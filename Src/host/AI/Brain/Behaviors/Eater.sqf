// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
    ПОВЕДЕНИЕ: ЕДОК (Охотник)
    
    Монстр-охотник с тактическим поведением:
    - Атакует врагов в ближнем бою
    - Преследует видимых врагов
    - Ищет потерянных врагов
    - Отступает для восстановления стамины
    - Патрулирует территорию
    
    Приоритеты:
    1. Отступить (90-115) - если стамина < 25%
    2. Атаковать (70-89) - если враг близко и есть стамина
    3. Искать (50-60) - если враг потерян недавно
    4. Преследовать (40-70) - если враг виден на расстоянии
    5. Патрулировать (10) - фоновое действие
*/

// ============================================================================
// ДЕЙСТВИЕ 1: АТАКА ВРАГА
// ============================================================================
struct(BAEater_Attack) base(BABase)
    def(requiredAgentFields) ["visibleTarget"]; // требуется для атаки цели
    
    // Локальные данные действия
    def(attackStartTime) 0;
    
    def_ret(getScore) {
        params ["_agent","_mob"];
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {0};
        
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        if (_dist > 3) exitWith {0}; // слишком далеко
        
        // БАЗА: важное действие (70)
        private _baseValue = 70;
        
        // МОДИФИКАТОР 1: Стамина (критично!)
        private _stamina = getVar(_mob,stamina);
        if (_stamina < 15) exitWith {0}; // нет стамины - не атакуем
        
        // Бонус за высокую стамину: 15%→0, 100%→10
        private _staminaBonus = (_stamina - 15) / 85 * 10; // 0-10
        
        // МОДИФИКАТОР 2: Близость к цели
        private _distBonus = (3 - _dist) * 3; // 0-9
        
        // ИТОГО: 70 + 0-10 + 0-9 = 70-89
        _baseValue + _staminaBonus + _distBonus
    }
    
    def(onStart) {
        params ["_agent","_mob"];
        private _target = _agent getv(visibleTarget);
        self setv(attackStartTime,tickTime);
        [_mob,_target] call ai_rotateTo;
    }
    
    def_ret(onUpdate) {
        params ["_agent","_mob"];
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем стамину
        if (getVar(_mob,stamina) < 10) exitWith {UPDATE_STATE_FAILED};
        
        private _startTime = self getv(attackStartTime);
        if (tickTime - _startTime < 2) exitWith {UPDATE_STATE_CONTINUE};
        
        [_mob,_target] call ai_attackTarget;
        UPDATE_STATE_COMPLETED
    }
    
    def(onCompleted) {
        params ["_agent","_mob"];
        self setv(attackStartTime,0);
    }
    
    def(onFailed) {
        params ["_agent","_mob"];
        self setv(attackStartTime,0);
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 2: ПРЕСЛЕДОВАНИЕ ВРАГА
// ============================================================================
struct(BAEater_Chase) base(BABase)
    def(requiredAgentFields) ["visibleTarget"]; // требуется для преследования цели
    
    def_ret(getScore) {
        params ["_agent","_mob"];
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {0};
        
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        if (_dist < 3) exitWith {0};   // слишком близко - атаковать
        if (_dist > 30) exitWith {0};  // слишком далеко
        
        // БАЗА: среднее действие (40)
        private _baseValue = 40;
        
        // МОДИФИКАТОР 1: Расстояние (ближе = выше приоритет)
        // 30м→40, 3м→70
        private _distBonus = (30 - _dist) / 27 * 30; // 0-30
        
        // МОДИФИКАТОР 2: Стамина (усталость снижает желание преследовать)
        private _stamina = getVar(_mob,stamina);
        private _staminaPenalty = if (_stamina < 30) then {-10} else {0};
        
        // ИТОГО: 40 + 0-30 - 10 = 30-70
        _baseValue + _distBonus + _staminaPenalty
    }
    
    def(onStart) {
        params ["_agent","_mob"];
    }
    
    def_ret(onUpdate) {
        params ["_agent","_mob"];
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
        
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        if (_dist < 3) exitWith {UPDATE_STATE_COMPLETED}; // достигли
        
        if !(_agent getv(ismoving)) then {
            private _success = [_mob,_target] call ai_planMove;
            if (!_success) exitWith {UPDATE_STATE_FAILED};
        };
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent","_mob"];
    }
    
    def(onFailed) {
        params ["_agent","_mob"];
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 3: ПОИСК ПОТЕРЯННОЙ ЦЕЛИ
// ============================================================================
struct(BAEater_Search) base(BABase)
    def(requiredAgentFields) ["visibleTarget","lastSeenTargetTime","lastSeenTargetPos"]; // требуется память о цели
    
    // Локальные данные действия
    def(searchTarget) [0,0,0];
    def(searchStartTime) 0;
    
    def_ret(getScore) {
        params ["_agent","_mob"];
        
        // Проверяем что цель потеряна НЕДАВНО
        private _lastSeenTime = _agent getv(lastSeenTargetTime);
        if (_lastSeenTime == 0) exitWith {0}; // никогда не видели
        
        private _timeSinceLost = tickTime - _lastSeenTime;
        if (_timeSinceLost > 30) exitWith {0}; // слишком давно (30 сек)
        
        // Текущая цель не видна
        private _target = _agent getv(visibleTarget);
        if (!isNullReference(_target)) exitWith {0}; // цель видна - не ищем
        
        // БАЗА: среднее действие (50)
        private _baseValue = 50;
        
        // МОДИФИКАТОР: Свежесть следа (чем недавнее, тем важнее)
        // 0сек→+10, 30сек→0
        private _freshnessBonus = (30 - _timeSinceLost) / 30 * 10; // 0-10
        
        // ИТОГО: 50 + 0-10 = 50-60
        _baseValue + _freshnessBonus
    }
    
    def(onStart) {
        params ["_agent","_mob"];
        // Идем к последней известной позиции
        private _lastPos = _agent getv(lastSeenTargetPos);
        self setv(searchTarget,_lastPos);
        self setv(searchStartTime,tickTime);
    }
    
    def_ret(onUpdate) {
        params ["_agent","_mob"];
        
        // Если нашли цель - успех
        private _target = _agent getv(visibleTarget);
        if (!isNullReference(_target)) exitWith {UPDATE_STATE_COMPLETED};
        
        // Проверяем таймаут поиска (10 секунд)
        private _searchTime = tickTime - (self getv(searchStartTime));
        if (_searchTime > 10) exitWith {UPDATE_STATE_FAILED};
        
        private _searchPos = self getv(searchTarget);
        private _actor = _agent getv(actor);
        
        // Двигаемся к точке
        if !(_agent getv(ismoving)) then {
            private _success = [_mob,_searchPos] call ai_planMove;
            if (!_success) exitWith {UPDATE_STATE_FAILED};
        };
        
        // Достигли точки - провал (не нашли)
        if (_actor distance _searchPos < 2) exitWith {UPDATE_STATE_FAILED};
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent","_mob"];
        self setv(searchTarget,vec3(0,0,0));
    }
    
    def(onFailed) {
        params ["_agent","_mob"];
        self setv(searchTarget,vec3(0,0,0));
        // Сбрасываем след в агенте
        _agent setv(lastSeenTargetTime,0);
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 4: ОТСТУПЛЕНИЕ ДЛЯ ВОССТАНОВЛЕНИЯ СТАМИНЫ
// ============================================================================
struct(BAEater_Retreat) base(BABase)
    def(requiredAgentFields) ["visibleTarget"]; // требуется для определения направления отступления
    
    // Локальные данные действия
    def(retreatTarget) [0,0,0];
    def(retreatStartTime) 0;
    
    def_ret(getScore) {
        params ["_agent","_mob"];
        
        private _stamina = getVar(_mob,stamina);
        
        // Активируется только при низкой стамине
        if (_stamina > 25) exitWith {0};
        
        // БАЗА: критическое действие (90)
        private _baseValue = 90;
        
        // МОДИФИКАТОР: Чем ниже стамина, тем важнее
        // 25%→90, 0%→115
        private _urgencyBonus = (25 - _stamina) / 25 * 25; // 0-25
        
        // ИТОГО: 90 + 0-25 = 90-115
        _baseValue + _urgencyBonus
    }
    
    def(onStart) {
        params ["_agent","_mob"];
        
        // Ищем точку отступления (от цели или случайная)
        private _actor = _agent getv(actor);
        private _currentPos = getPosASL _actor;
        
        private _target = _agent getv(visibleTarget);
        private _retreatPos = [];
        
        if (!isNullReference(_target)) then {
            // Отступаем от цели
            private _targetPos = getPosASL _target;
            private _dirAway = _currentPos vectorDiff _targetPos;
            private _dirNorm = vectorNormalized _dirAway;
            _retreatPos = _currentPos vectorAdd (_dirNorm vectorMultiply 15);
        } else {
            // Случайное направление
            _retreatPos = [
                (_currentPos select 0) + (random 20 - 10),
                (_currentPos select 1) + (random 20 - 10),
                (_currentPos select 2)
            ];
        };
        
        self setv(retreatTarget,_retreatPos);
        self setv(retreatStartTime,tickTime);
    }
    
    def_ret(onUpdate) {
        params ["_agent","_mob"];
        
        // Проверяем восстановилась ли стамина
        private _stamina = getVar(_mob,stamina);
        if (_stamina > 50) exitWith {UPDATE_STATE_COMPLETED}; // восстановились
        
        // Таймаут (15 секунд)
        private _retreatTime = tickTime - (self getv(retreatStartTime));
        if (_retreatTime > 15) exitWith {UPDATE_STATE_COMPLETED};
        
        private _retreatPos = self getv(retreatTarget);
        private _actor = _agent getv(actor);
        
        // Двигаемся к точке отступления
        if !(_agent getv(ismoving)) then {
            private _success = [_mob,_retreatPos] call ai_planMove;
            if (!_success) exitWith {UPDATE_STATE_FAILED};
        };
        
        // Достигли точки - просто ждем восстановления
        if (_actor distance _retreatPos < 3) then {
            [_mob,true] call ai_setStop;
        };
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent","_mob"];
        self setv(retreatTarget,vec3(0,0,0));
    }
    
    def(onFailed) {
        params ["_agent","_mob"];
        self setv(retreatTarget,vec3(0,0,0));
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 5: ПАТРУЛИРОВАНИЕ (HPA* граф)
// ============================================================================
struct(BAEater_Patrol) base(BABase)
    def(requiredAgentFields) []; // не требует дополнительных полей
    
    // Локальные данные действия
    def(patrolTarget) [];
    
    def_ret(getScore) {
        params ["_agent","_mob"];
        10 // фоновое действие
    }
    
    def(onStart) {
        params ["_agent","_mob"];
        private _actor = _agent getv(actor);
        private _currentPos = getPosASL _actor;
        
        // Получаем текущий регион
        private _currentRegionKey = [_currentPos select 0, _currentPos select 1] call ai_nav_getRegionKey;
        
        // Собираем текущий регион + 8 соседей (3x3 сетка)
        private _availableRegions = [];
        _currentRegionKey splitString "_" params ["_rx", "_ry"];
        _rx = parseNumber _rx; 
        _ry = parseNumber _ry;
        
        // Проверяем 9 регионов (3x3)
        for "_dx" from -1 to 1 do {
            for "_dy" from -1 to 1 do {
                private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
                if (_neighborKey in ai_nav_regions) then {
                    _availableRegions pushBack _neighborKey;
                };
            };
        };
        
        if (count _availableRegions == 0) exitWith {
            // Fallback - случайная точка
            private _pos = getPosATL _actor;
            private _randomPos = [
                (_pos select 0) + (random 20 - 10),
                (_pos select 1) + (random 20 - 10),
                0
            ];
            self setv(patrolTarget,_randomPos);
        };
        
        // Выбираем случайный регион
        private _selectedRegionKey = selectRandom _availableRegions;
        private _regionData = ai_nav_regions get _selectedRegionKey;
        private _nodeIds = _regionData get "nodes";
        
        // Фильтруем только узлы с соседями (связанные)
        private _connectedNodes = [];
        {
            private _nodeId = _x;
            private _neighbors = ai_nav_adjacency getOrDefault [_nodeId, []];
            if (count _neighbors > 0) then {
                _connectedNodes pushBack _nodeId;
            };
        } forEach _nodeIds;
        
        if (count _connectedNodes == 0) exitWith {
            // Нет связанных узлов - fallback
            private _pos = getPosATL _actor;
            private _randomPos = [
                (_pos select 0) + (random 20 - 10),
                (_pos select 1) + (random 20 - 10),
                0
            ];
            self setv(patrolTarget,_randomPos);
        };
        
        // Выбираем случайный связанный узел
        private _selectedNodeId = selectRandom _connectedNodes;
        private _nodeData = ai_nav_nodes get _selectedNodeId;
        private _targetPos = _nodeData get "pos";
        
        self setv(patrolTarget,_targetPos);
    }
    
    def_ret(onUpdate) {
        params ["_agent","_mob"];
        private _actor = _agent getv(actor);
        private _targetPos = self getv(patrolTarget);
        if (_targetPos isEqualTo []) exitWith {UPDATE_STATE_FAILED};
        
        // планируем движение если еще не движемся
        if !(_agent getv(ismoving)) then {
            private _success = [_mob,_targetPos] call ai_planMove;
            if (!_success) exitWith {UPDATE_STATE_FAILED};
        };
        
        // проверяем достигли ли цели
        if (_actor distance2D _targetPos < 2) exitWith {UPDATE_STATE_COMPLETED};
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent","_mob"];
        self setv(patrolTarget,[]);
    }
    
    def(onFailed) {
        params ["_agent","_mob"];
        self setv(patrolTarget,[]);
    }
endstruct

// BHVEater удалено - поведение перенесено в AgentEater (Brain_struct.sqf)