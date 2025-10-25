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
    def(requiredAgentFields) ["visibleTarget","attackDistance"];
    def(baseScore) 70;
    
    // Локальные данные действия
    def(lastAttackTime) 0;
    def(attackCooldown) 1.5; // Кулдаун между атаками в секундах
    def(attackCooldownRand) 1.5; //доп кулдаун в секундах
    
    // КОНТЕКСТ: можем атаковать?
    def_ret(isAvailable) {
        params ["_agent"];
        
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {false};
        
        private _mob = _agent getv(mob);
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        if (_dist > (_agent getv(attackDistance))) exitWith {false};

        //цель жива
        if getVar(_target,isDead) exitWith {false};
        
        // Есть стамина для атаки?
        private _staminaPercent = _agent callv(getStaminaPercent);
        (_staminaPercent >= 15)
    }
    
    // ПОЛЕЗНОСТЬ: насколько выгодно атаковать?
    def_ret(getScore) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _target = _agent getv(visibleTarget);
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        private _staminaPercent = _agent callv(getStaminaPercent);
        
        // Бонус за стамину: 15%→0, 100%→10
        private _staminaBonus = (_staminaPercent - 15) / 85 * 10;
        
        // Бонус за близость
        private _distBonus = ((_agent getv(attackDistance)) - _dist) * 3;
        
        // ИТОГО: 0-19 (добавится к baseScore 70)
        _staminaBonus + _distBonus
    }
    
    def(onStart) {
        params ["_agent"];
        
        // Устанавливаем время в прошлое чтобы первая атака была сразу
        self setv(lastAttackTime,0);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем стамину
        if (_agent callv(getStaminaPercent) < 10) exitWith {UPDATE_STATE_FAILED};
        
        private _mob = _agent getv(mob);
        if (callFuncParams(_mob,getDistanceTo,_target) > (_agent getv(attackDistance))) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем кулдаун
        private _lastAttack = self getv(lastAttackTime);
        private _cooldown = self getv(attackCooldown);
        private _timeSinceLastAttack = tickTime - _lastAttack;
        
        if (_timeSinceLastAttack >= _cooldown) then {
            // Можем атаковать!
            [_mob,_target] call ai_rotateTo;
            [_mob,_target] call ai_attackTarget;
            self setv(lastAttackTime,tickTime + rand(0,self getv(attackCooldownRand)));
        };
        
        // Продолжаем действие (не завершаем)
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        self setv(lastAttackTime,0);
    }
    
    def(onFailed) {
        params ["_agent"];
        self setv(lastAttackTime,0);
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 2: ПРЕСЛЕДОВАНИЕ ВРАГА
// ============================================================================
struct(BAEater_Chase) base(BABase)
    def(requiredAgentFields) ["visibleTarget","attackDistance"];
    def(baseScore) 40;
    
    // Локальные данные для отслеживания перепланировки
    def(lastReplanTime) 0;
    def(replanInterval) 1.0; // Перепланировка каждую секунду
    
    // КОНТЕКСТ: можем преследовать?
    def_ret(isAvailable) {
        params ["_agent"];
        
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {false};
        
        private _mob = _agent getv(mob);
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        
        // Только на средней дистанции
        (_dist >= (_agent getv(attackDistance))) && (_dist <= 30)
    }
    
    // ПОЛЕЗНОСТЬ: насколько выгодно преследовать?
    def_ret(getScore) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _target = _agent getv(visibleTarget);
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        private _staminaPercent = _agent callv(getStaminaPercent);
        
        // Бонус за близость: 30м→0, 3м→30
        private _distBonus = (30 - _dist) / 27 * 30;
        
        // Штраф за усталость
        private _staminaPenalty = if (_staminaPercent < 30) then {-10} else {0};
        
        // ИТОГО: 0-30 - 10 = -10 до 30
        _distBonus + _staminaPenalty
    }
    
    def(onStart) {
        params ["_agent"];
        self setv(lastReplanTime,0);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
        
        private _dist = callFuncParams(_mob,getDistanceTo,_target);
        if (_dist < (_agent getv(attackDistance))) exitWith {UPDATE_STATE_COMPLETED};
        
        private _isMoving = _agent getv(ismoving);
        private _needReplan = false;
        
        private _emergencyReplan = false; // Флаг экстренной перепланировки
        
        if (_isMoving) then {
            // Проверяем нужно ли перепланировать путь
            private _lastReplan = self getv(lastReplanTime);
            private _timeSinceReplan = tickTime - _lastReplan;
            
            // Проверяем отклонение цели от конца пути
            private _curPath = _agent getv(curpath);
            if (count _curPath > 0) then {
                private _pathEnd = _curPath select (count _curPath - 1);
                private _targetPos = atltoasl callFunc(_target,getPos);
                private _targetDeviation = _pathEnd distance _targetPos;
                
                // Экстренная перепланировка при большом отклонении
                if (_targetDeviation > 5) then {
                    _needReplan = true;
                    _emergencyReplan = true; // Останавливаемся только при экстренной
                } else {
                    // Обычная периодическая перепланировка
                    if (_timeSinceReplan >= self getv(replanInterval)) then {
                        _needReplan = true;
                    };
                };
            } else {
                // Пути нет - обычная перепланировка
                if (_timeSinceReplan >= self getv(replanInterval)) then {
                    _needReplan = true;
                };
            };
        } else {
            // Не движемся - нужно планировать
            _needReplan = true;
        };
        
        // Останавливаем ТОЛЬКО при экстренной перепланировке
        if (_emergencyReplan) then {
            [_mob] call ai_stopMove;
        };
        
        if (_needReplan) then {
            // ПРЕДСКАЗАНИЕ: куда цель побежит через 1 секунду
            private _predictedPos = [_target, 1.0] call ai_predictTargetPosition;
            
            private _success = [_mob, _predictedPos] call ai_planMove;
            if (!_success) exitWith {UPDATE_STATE_FAILED};
            
            self setv(lastReplanTime, tickTime);
        };
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        [_agent getv(mob)] call ai_stopMove;
        self setv(lastReplanTime,0);
    }
    
    def(onFailed) {
        params ["_agent"];
        self setv(lastReplanTime,0);
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 3: ПОИСК ПОТЕРЯННОЙ ЦЕЛИ
// ============================================================================
struct(BAEater_Search) base(BABase)
    def(requiredAgentFields) ["visibleTarget","lastSeenTargetTime","lastSeenTargetPos"];
    def(baseScore) 50;
    
    // Локальные данные действия
    def(searchTarget) [0,0,0];
    def(searchStartTime) 0;
    def(searchCenterReached) false;
    def(searchAttempts) 0;
    def(searchWaitStart) 0;
    def(isSearchWaiting) false;
    
    // КОНТЕКСТ: можем искать?
    def_ret(isAvailable) {
        params ["_agent"];
        
        // Цель потеряна недавно?
        private _lastSeenTime = _agent getv(lastSeenTargetTime);
        if (_lastSeenTime == 0) exitWith {false};
        
        private _timeSinceLost = tickTime - _lastSeenTime;
        if (_timeSinceLost > 30) exitWith {false};
        
        // Цель не видна сейчас?
        private _target = _agent getv(visibleTarget);
        isNullReference(_target)
    }
    
    // ПОЛЕЗНОСТЬ: насколько важен поиск?
    def_ret(getScore) {
        params ["_agent"];
        
        private _lastSeenTime = _agent getv(lastSeenTargetTime);
        private _timeSinceLost = tickTime - _lastSeenTime;
        
        // Свежесть следа: 0сек→10, 30сек→0
        (30 - _timeSinceLost) / 30 * 10
    }
    
    def(onStart) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        // Переключаемся на ходьбу для сканирования
        [_mob] call ai_stopMove;
        
        // Идем к последней известной позиции
        private _lastPos = _agent getv(lastSeenTargetPos);
        self setv(searchTarget,_lastPos);
        self setv(searchStartTime,tickTime);
        self setv(searchCenterReached,false);
        self setv(searchAttempts,0);
        self setv(isSearchWaiting,false);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        FHEADER;
        
        private _mob = _agent getv(mob);
        
        // Если нашли цель - успех
        private _target = _agent getv(visibleTarget);
        if (!isNullReference(_target)) exitWith {UPDATE_STATE_COMPLETED};
        
        // Проверяем таймаут поиска (20 секунд)
        private _searchTime = tickTime - (self getv(searchStartTime));
        if (_searchTime > 20) exitWith {UPDATE_STATE_FAILED};
        
        private _searchPos = self getv(searchTarget);
        private _actor = _agent getv(actor);
        private _lastSeenPos = _agent getv(lastSeenTargetPos);
        
        // Если еще не достигли центра поиска
        if !(self getv(searchCenterReached)) then {
            // Двигаемся к последней известной точке
            if !(_agent callv(hasPath)) then {
                private _success = [_mob,_searchPos] call ai_planMove;
                if (!_success) exitWith {RETURN(UPDATE_STATE_FAILED)};
            };
            
            // Достигли центра - начинаем патрулирование
            if (_agent callv(isPathReached)) then {
                self setv(searchCenterReached,true);
            };
        } else {
            // Патрулируем в области последнего обнаружения
            
            // Проверяем в режиме паузы ли мы
            if (self getv(isSearchWaiting)) then {
                private _elapsed = tickTime - (self getv(searchWaitStart));
                
                // Пауза 2-3 секунды для "осмотра"
                if (_elapsed >= rand(2,3)) then {
                    self setv(isSearchWaiting,false);
                };
            } else {
                // Режим движения к точке
                if !(_agent callv(hasPath)) then {
                    private _attempts = self getv(searchAttempts);
                    
                    // Ограничиваем количество попыток (3-4 точки)
                    if (_attempts >= 3) exitWith {RETURN(UPDATE_STATE_FAILED)};
                    
                    // Ищем случайную точку вокруг центра поиска (радиус 5-15м)
                    private _newSearchPos = [_mob, _lastSeenPos, 15, 5, true] call ai_findNearestValidPosition;
                    
                    if (_newSearchPos isEqualTo []) then {
                        // Нет валидных точек - fallback
                        _newSearchPos = [
                            (_lastSeenPos select 0) + (rand(-10,10)),
                            (_lastSeenPos select 1) + (rand(-10,10)),
                            (_lastSeenPos select 2)
                        ];
                    };
                    
                    self setv(searchTarget,_newSearchPos);
                    self setv(searchAttempts,_attempts + 1);
                    
                    private _success = [_mob,_newSearchPos] call ai_planMove;
                    if (!_success) exitWith {RETURN(UPDATE_STATE_FAILED)};
                    [_mob,SPEED_MODE_WALK] call ai_setSpeed;
                };
                
                // Проверяем достигли ли точки поиска
                if (_agent callv(isPathReached)) then {
                    self setv(searchWaitStart,tickTime);
                    self setv(isSearchWaiting,true);
                };
            };
        };
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        self setv(searchTarget,vec3(0,0,0));
        self setv(searchCenterReached,false);
        self setv(searchAttempts,0);
        self setv(isSearchWaiting,false);
        // Возвращаем бег если цель найдена
        [_mob,SPEED_MODE_RUN] call ai_setSpeed;
    }
    
    def(onFailed) {
        params ["_agent"];
        
        self setv(searchTarget,vec3(0,0,0));
        self setv(searchCenterReached,false);
        self setv(searchAttempts,0);
        self setv(isSearchWaiting,false);
        // Сбрасываем след в агенте
        _agent setv(lastSeenTargetTime,0);
        // Скорость вернётся к ходьбе через updateSensors когда след остынет
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 4: ОТСТУПЛЕНИЕ ДЛЯ ВОССТАНОВЛЕНИЯ СТАМИНЫ
// ============================================================================
struct(BAEater_Retreat) base(BABase)
    def(requiredAgentFields) ["visibleTarget"];
    def(baseScore) 90;
    
    // Локальные данные действия
    def(retreatTarget) [0,0,0];
    def(retreatStartTime) 0;
    def(isResting) false;
    
    // КОНТЕКСТ: нужно отступать?
    def_ret(isAvailable) {
        params ["_agent"];
        
        // Если уже отдыхаем - продолжаем
        if (self getv(isResting)) exitWith {true};
        
        // Критически низкая стамина?
        private _staminaPercent = _agent callv(getStaminaPercent);
        (_staminaPercent < 15)
    }
    
    // ПОЛЕЗНОСТЬ: насколько срочно отступать?
    def_ret(getScore) {
        params ["_agent"];
        
        // Если отдыхаем - держим высокий приоритет
        if (self getv(isResting)) then {
            private _staminaPercent = _agent callv(getStaminaPercent);
            if (_staminaPercent >= 80) exitWith {0}; // восстановились
            10 // высокий приоритет
        } else {
            // Чем ниже стамина, тем важнее: 15%→0, 0%→25
            private _staminaPercent = _agent callv(getStaminaPercent);
            (15 - _staminaPercent) / 15 * 25
        };
    }
    
    def(onStart) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        // Переключаемся на медленную ходьбу для экономии стамины
        [_mob,SPEED_MODE_WALK] call ai_setSpeed;
        
        // Ищем точку отступления
        private _target = _agent getv(visibleTarget);
        private _retreatPos = [];
        
        if (!isNullReference(_target)) then {
            // Отступаем от цели на 15 метров
            _retreatPos = [_mob, _target, 15] call ai_retreatFrom;
        } else {
            // Случайная валидная позиция рядом
            _retreatPos = [_mob, [], 20] call ai_findNearestValidPosition;
            if (_retreatPos isEqualTo []) then {
                // Fallback - случайное направление
                private _actor = _agent getv(actor);
                private _currentPos = getPosASL _actor;
                _retreatPos = [
                    (_currentPos select 0) + (random 20 - 10),
                    (_currentPos select 1) + (random 20 - 10),
                    (_currentPos select 2)
                ];
            };
        };
        
        self setv(retreatTarget,_retreatPos);
        self setv(retreatStartTime,tickTime);
        self setv(isResting,false);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        // Проверяем восстановилась ли стамина
        if (_agent callv(getStaminaPercent) >= 80) exitWith {UPDATE_STATE_COMPLETED};
        
        private _retreatPos = self getv(retreatTarget);
        private _actor = _agent getv(actor);
        
        // Проверяем в режиме отдыха ли мы
        if (self getv(isResting)) then {
            // Сидим и ждём восстановления стамины
            UPDATE_STATE_CONTINUE
        } else {
            // Режим движения к точке отступления
            
            // Двигаемся к точке отступления
            if !(_agent callv(hasPath)) then {
                private _success = [_mob,_retreatPos] call ai_planMove;
                if (!_success) exitWith {UPDATE_STATE_FAILED};
            };
            
            // Достигли точки - присаживаемся для отдыха
            if (_agent callv(isPathReached)) then {
                // Выключаем комбат чтобы можно было присесть
                if (getVar(_mob,isCombatModeEnable)) then {
                    callFuncParams(_mob,setCombatMode,false);
                };
                [_mob,STANCE_MIDDLE] call ai_setStance; // присаживаемся
                self setv(isResting,true);
            };
            
            UPDATE_STATE_CONTINUE
        };
    }
    
    def(onCompleted) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        self setv(retreatTarget,vec3(0,0,0));
        self setv(isResting,false);
        // Встаём
        [_mob,STANCE_UP] call ai_setStance;
        // Включаем комбат обратно
        if (!getVar(_mob,isCombatModeEnable)) then {
            callFuncParams(_mob,setCombatMode,true);
        };
        // Возвращаем бег если восстановились
        [_mob,SPEED_MODE_RUN] call ai_setSpeed;
    }
    
    def(onFailed) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        self setv(retreatTarget,vec3(0,0,0));
        self setv(isResting,false);
        // Встаём
        [_mob,STANCE_UP] call ai_setStance;
        // Скорость вернётся через updateSensors в зависимости от наличия цели
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 5: ПАТРУЛИРОВАНИЕ (HPA* граф)
// ============================================================================
struct(BAEater_Patrol) base(BABase)
    def(requiredAgentFields) [];
    def(baseScore) 10;
    
    // Локальные данные действия
    def(patrolTarget) [];
    def(waitStartTime) 0;
    def(waitDuration) 0;
    def(isWaiting) false;
    def(movePlanned) false;
    
    // Параметры патрулирования
	def(_minWaitTime) 4;
	def(_maxWaitTime) 8;
	def(_minPatrolDist) 5;
	def(_maxPatrolDist) 20;

    // КОНТЕКСТ: можем патрулировать?
    def_ret(isAvailable) {
        params ["_agent"];
        true // всегда доступно (фоновое действие)
    }
    
    // ПОЛЕЗНОСТЬ: низкий приоритет
    def_ret(getScore) {
        params ["_agent"];
        0 // просто baseScore
    }
    
    def(onStart) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        // Ищем СЛУЧАЙНУЮ валидную точку для патрулирования  
        private _patrolPos = [_mob, [], self getv(_maxPatrolDist), self getv(_minPatrolDist), true] call ai_findNearestValidPosition;
        
        if equals(_patrolPos,[]) then {
            // Fallback - случайная точка рядом
            private _actor = _agent getv(actor);
            private _pos = getPosASL _actor;
            _patrolPos = [
                (_pos select 0) + (rand(-10,10)),
                (_pos select 1) + (rand(-10,10)),
                (_pos select 2)
            ];
        };
        
        self setv(patrolTarget, _patrolPos);
        self setv(isWaiting, false);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _actor = _agent getv(actor);
        private _targetPos = self getv(patrolTarget);
        if equals(_targetPos,[]) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем в режиме ожидания ли мы
        if (self getv(isWaiting)) exitWith {
            // Ждем на месте
			private _return = UPDATE_STATE_CONTINUE;
            private _elapsed = tickTime - (self getv(waitStartTime));
            if (_elapsed >= (self getv(waitDuration))) then {
                // Закончили ждать - ищем новую точку
                private _newPos = [_mob, [], self getv(_maxPatrolDist), self getv(_minPatrolDist),true] call ai_findNearestValidPosition;
                if equals(_newPos,[]) exitWith {_return = UPDATE_STATE_FAILED};
                
                self setv(patrolTarget, _newPos);
                self setv(isWaiting, false);
            };
            
            _return
        };

        // Режим движения
		private _return = UPDATE_STATE_CONTINUE;
		// планируем движение если еще не движемся
		if !(self getv(movePlanned)) then {
			private _success = [_mob,_targetPos,_agent getv(lastvalidpos)] call ai_planMove;
			if (!_success) exitWith {_return = UPDATE_STATE_FAILED};
			self setv(movePlanned,true);
		};
		if (_return == UPDATE_STATE_FAILED) exitWith {_return};
		
		// проверяем достигли ли цели
		if (_agent callv(isPathReached)) then {
			// Достигли точки - останавливаемся и начинаем ждать			
			// Случайная пауза от 3 до 8 секунд
			private _waitTime = rand(self getv(_minWaitTime),self getv(_maxWaitTime));
			self setv(waitStartTime, tickTime);
			self setv(waitDuration, _waitTime);
			self setv(isWaiting, true);
			self setv(movePlanned,false);
			
		};
		
		UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        self setv(patrolTarget,[]);
        self setv(isWaiting, false);
        self setv(movePlanned, false);
    }
    
    def(onFailed) {
        params ["_agent"];
        self setv(patrolTarget,[]);
        self setv(isWaiting, false);
        self setv(movePlanned, false);
    }
endstruct

// BHVEater удалено - поведение перенесено в AgentEater (Brain_struct.sqf)