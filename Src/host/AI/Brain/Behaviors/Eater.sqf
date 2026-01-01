// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
        private _dist = _agent getv(distanceToTarget);
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
        private _dist = _agent getv(distanceToTarget);
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
        if ((_agent getv(distanceToTarget)) > (_agent getv(attackDistance))) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем кулдаун
        private _lastAttack = self getv(lastAttackTime);
        private _cooldown = self getv(attackCooldown);
        private _timeSinceLastAttack = tickTime - _lastAttack;
        
        if (_timeSinceLastAttack >= _cooldown) then {
            // Можем атаковать!
            [_mob,_target] call ai_rotateTo;
            #ifndef EDITOR
            [_mob,_target] call ai_attackTarget;
            #else
            [format['lastattack: %1',_timeSinceLastAttack]] call ai_log;
            #endif
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
    def(replanInterval) 2.0; // Перепланировка каждую секунду
    
    // КОНТЕКСТ: можем преследовать?
    def_ret(isAvailable) {
        params ["_agent"];
        
        private _target = _agent getv(visibleTarget);
        if (isNullReference(_target)) exitWith {false};
        
        private _mob = _agent getv(mob);
        private _dist = _agent getv(distanceToTarget);
        
        // Только на средней дистанции
        (_dist >= (_agent getv(attackDistance))) && (_dist <= 30)
    }
    
    // ПОЛЕЗНОСТЬ: насколько выгодно преследовать?
    def_ret(getScore) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _target = _agent getv(visibleTarget);
        private _dist = _agent getv(distanceToTarget);
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
        
        private _dist = _agent getv(distanceToTarget);
        if (_dist < (_agent getv(attackDistance))) exitWith {UPDATE_STATE_COMPLETED};
        
        private _needReplan = false;
        
        private _emergencyReplan = false; // Флаг экстренной перепланировки
        
        if (_agent callv(hasPath)) then {
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
                if (_targetDeviation > 3) then {
                    _needReplan = true;
                    _emergencyReplan = true; // Останавливаемся только при экстренной
                } else {
                    // Обычная периодическая перепланировка
                    if (_timeSinceReplan >= self getv(replanInterval)) then {
                        //_needReplan = true;
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
        
        private _ret = UPDATE_STATE_CONTINUE;
        if (_needReplan) then {
            // ПРЕДСКАЗАНИЕ: куда цель побежит через 1 секунду
            private _predictedPos = [_target, 1.0] call ai_predictTargetPosition;
            
            private _success = [_mob, _predictedPos] call ai_planMove;
            if (!_success) exitWith {_ret = UPDATE_STATE_FAILED};
            
            self setv(lastReplanTime, tickTime);
        };
        
        _ret;
    }
    
    def(onCompleted) {
        params ["_agent"];
        [_agent getv(mob)] call ai_stopMove;
        self setv(lastReplanTime,0);
    }
    
    def(onFailed) {
        params ["_agent"];
        [_agent getv(mob)] call ai_stopMove;
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

        [_mob] call ai_rotateReset;
        
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
        private _currentPos = getPosASL _actor;
        
        // ФАЗА 1: Движение к центру поиска (последняя известная позиция цели)
        if !(self getv(searchCenterReached)) then {
            // Проверяем достигли ли центра
            if (_agent callv(isPathReached)) exitWith {
                self setv(searchCenterReached,true);
                self setv(searchWaitStart,tickTime);
                self setv(isSearchWaiting,true);
            };

            if !(_agent callv(hasPath)) then {
                // Планируем путь если его нет или если достигли но далеко
                private _success = [_mob,_searchPos] call ai_planMove;
                if (!_success) exitWith {RETURN(UPDATE_STATE_FAILED)};
                [_mob,SPEED_MODE_WALK] call ai_setSpeed;                
            };
            
        } else {
            // ФАЗА 2: Патрулирование в области последнего обнаружения
            
            // Состояние: Пауза (осмотр местности)
            if (self getv(isSearchWaiting)) then {
                private _elapsed = tickTime - (self getv(searchWaitStart));
                
                // Пауза 2-3 секунды для "осмотра"
                if (_elapsed >= rand(2,3)) then {
                    // Выходим из паузы - планируем новую точку
                    self setv(isSearchWaiting,false);
                    
                    private _attempts = self getv(searchAttempts);
                    
                    // Ограничиваем количество попыток (3-4 точки)
                    if (_attempts >= 3) exitWith {
                        //["Search: Max attempts reached, giving up"] call ai_log;
                        RETURN(UPDATE_STATE_FAILED)
                    };
                    
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
                    //["Search: Moving to patrol point %1",_attempts + 1] call ai_log;
                };
            } else {
                // Состояние: Движение к очередной точке патруля
                
                // Проверяем достигли ли точки поиска
                if (_agent callv(isPathReached)) then {
                    self setv(searchWaitStart,tickTime);
                    self setv(isSearchWaiting,true);
                } else {
                    // Если нет пути - планируем
                    if !(_agent callv(hasPath)) then {
                        private _success = [_mob,_searchPos] call ai_planMove;
                        if (!_success) exitWith {RETURN(UPDATE_STATE_FAILED)};
                        [_mob,SPEED_MODE_WALK] call ai_setSpeed;
                    };
                };
            };
        };
        
        RETURN(UPDATE_STATE_CONTINUE)
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
    def(requiredAgentFields) ["visibleTarget","nearPlayers"];
    def(baseScore) 90;
    
    // Локальные данные действия
    def(retreatTarget) [0,0,0];
    def(retreatStartTime) 0;
    def(isResting) false;
    def(lastRetreatCheckTime) 0;
    def(retreatCheckInterval) 2.0; // Проверяем приближение игроков каждые 2 секунды
    def(retreatPathTask) pathTask_null;
    
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
            
            // Проверяем приближение игроков
            private _nearPlayers = _agent getv(nearPlayers);
            if (count _nearPlayers > 0) then {
                25 // Высокий приоритет - нужно снова отходить
            } else {
                10 // Продолжаем отдыхать
            }
        } else {
            // Чем ниже стамина, тем важнее: 15%→0, 0%→25
            private _staminaPercent = _agent callv(getStaminaPercent);
            (15 - _staminaPercent) / 15 * 25
        };
    }
    
    def(onStart) {
        params ["_agent"];

        _agent setv(retreatPathTask,pathTask_null);
        
        private _mob = _agent getv(mob);
        
        // Переключаемся на медленную ходьбу для экономии стамины
        [_mob,SPEED_MODE_WALK] call ai_setSpeed;
        [_mob] call ai_stopMove; //выключаем движение для логики отступления
        
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
        FHEADER;
        
        private _mob = _agent getv(mob);
        
        // Проверяем восстановилась ли стамина
        if (_agent callv(getStaminaPercent) >= 80) exitWith {UPDATE_STATE_COMPLETED};
        
        private _retreatPos = self getv(retreatTarget);
        private _actor = _agent getv(actor);
        
        // Проверяем в режиме отдыха ли мы
        if (self getv(isResting)) then {
            // Проверяем приближение игроков периодически
            private _lastCheck = self getv(lastRetreatCheckTime);
            private _checkInterval = self getv(retreatCheckInterval);
            
            if (tickTime - _lastCheck >= _checkInterval) then {
                self setv(lastRetreatCheckTime,tickTime);
                
                private _nearPlayers = [_mob,10,{callFunc(_x,isPlayer) && isTypeOf(_x,Mob)}] call ai_getNearMobs;
                if (count _nearPlayers > 0 && _agent getv(hasTarget)) then {
                    // Игроки наступают! Нужно отходить снова
                    ["Eater: Players approaching during rest, retreating again..."] call ai_log;
                    
                    // Встаём и ищем новую точку отступления
                    [_mob,STANCE_UP] call ai_setStance;
                    self setv(isResting,false);
                    [_mob] call ai_stopMove;
                    
					// Находим ближайшего игрока
					private _mobPos = callFunc(_mob,getPos);
					_nearPlayers = [_nearPlayers,{_mobPos distance callFunc(_x,getPos)},true] call sortBy;
					private _closestPlayer = _nearPlayers select 0;
                    
                    // Отступаем от него на 20 метров
                    private _newRetreatPos = [_mob, _closestPlayer, 20] call ai_retreatFrom;
                    if (_newRetreatPos isEqualTo []) then {
                        // Fallback - случайная валидная позиция
                        _newRetreatPos = [_mob, [], 25] call ai_findNearestValidPosition;
                        if (_newRetreatPos isEqualTo []) then {
                            // Критический fallback
                            private _currentPos = getPosASL _actor;
                            _newRetreatPos = [
                                (_currentPos select 0) + (random 30 - 15),
                                (_currentPos select 1) + (random 30 - 15),
                                (_currentPos select 2)
                            ];
                        };
                    };
                    
                    self setv(retreatTarget,_newRetreatPos);
                    self setv(retreatPathTask,pathTask_null);
                };
            };
            
        } else {
            // Режим движения к точке отступления
            
            // Достигли точки - присаживаемся для отдыха
            if pathTask_reached(self getv(retreatPathTask)) exitWith {
                // Выключаем комбат чтобы можно было присесть
                [_mob,false] call ai_setCombatMode;
                [_mob,STANCE_MIDDLE] call ai_setStance; // присаживаемся
                self setv(isResting,true);
                self setv(lastRetreatCheckTime,tickTime);
            };

            // Двигаемся к точке отступления
            if !(_agent callv(hasPath)) then {
                private _success = [_mob,_retreatPos] call ai_planMove;
                if (!_success) exitWith {RETURN(UPDATE_STATE_FAILED)};
                self setv(retreatPathTask,_agent callv(getPathTask));
            };
            
        };

        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        self setv(retreatTarget,vec3(0,0,0));
        self setv(isResting,false);
        // Встаём
        [_mob,STANCE_UP] call ai_setStance;
        // Включаем комбат обратно
        [_mob,true] call ai_setCombatMode;
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
    def(pathPatrolTask) pathTask_null;

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
        self setv(pathPatrolTask,pathTask_null);
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

        // проверяем достигли ли цели
		if pathTask_reached(self getv(pathPatrolTask)) exitWith {
			// Достигли точки - останавливаемся и начинаем ждать			
			// Случайная пауза от 3 до 8 секунд
			private _waitTime = rand(self getv(_minWaitTime),self getv(_maxWaitTime));
			self setv(waitStartTime, tickTime);
			self setv(waitDuration, _waitTime);
			self setv(isWaiting, true);
			self setv(pathPatrolTask,pathTask_null);
            _return
		};

		// планируем движение если еще не движемся
		if !(_agent callv(hasPath)) then {
			private _success = [_mob,_targetPos] call ai_planMove;
			if (!_success) exitWith {_return = UPDATE_STATE_FAILED};
            self setv(pathPatrolTask,_agent callv(getPathTask));
		};
		
		_return
    }
    
    def(onCompleted) {
        params ["_agent"];
        self setv(patrolTarget,[]);
        self setv(isWaiting, false);
    }
    
    def(onFailed) {
        params ["_agent"];
        self setv(patrolTarget,[]);
        self setv(isWaiting, false);
    }
endstruct

// ============================================================================
// ДЕЙСТВИЕ 6: ПОЕДАНИЕ ЧАСТЕЙ ТЕЛА
// ============================================================================
struct(BAEater_EatBodyParts) base(BABase)
    def(requiredAgentFields) ["visibleTarget"];
    def(baseScore) 30;
    
    // Локальные данные действия
    def(targetBodyPart) nullPtr;
    def(isEating) false; // Флаг процесса поедания
    def(lastBiteTime) 0; // Время последнего укуса
    def(biteCooldown) 1.5; // Кулдаун между укусами
    def(biteCooldownRand) 1.0; // Случайная добавка к кулдауну
    def(biteHungerRestore) 8; // Сколько голода восстанавливает один укус
    def(targetHungerLevel) 80; // До какого уровня голода есть
    
    // КОНТЕКСТ: можем есть?
    def_ret(isAvailable) {
        params ["_agent"];
        
        // Есть ли части тела рядом?
        private _nearBodyPart = _agent getv(nearestBodyPart);
        if (isNullReference(_nearBodyPart)) exitWith {false};
        
        // Нет опасности рядом (нет видимых врагов)
        private _target = _agent getv(visibleTarget);
        if (!isNullReference(_target)) exitWith {false};
        
        // Есть ли голод?
        private _mob = _agent getv(mob);
        private _hunger = getVar(_mob,hunger);
        (_hunger < self getv(targetHungerLevel))
    }
    
    // ПОЛЕЗНОСТЬ: насколько выгодно есть?
    def_ret(getScore) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _hunger = getVar(_mob,hunger);
        private _targetHunger = self getv(targetHungerLevel);
        
        // Чем больше голод, тем важнее еда: 80%→0, 0%→30
        private _hungerBonus = (_targetHunger - _hunger) / _targetHunger * 30;
        
        // Близость части тела
        private _bodyPart = _agent getv(nearestBodyPart);
        if (!isNullReference(_bodyPart)) then {
            private _dist = callFuncParams(_mob,getDistanceTo,_bodyPart);
            // Чем ближе часть, тем выше бонус: 20м→0, 0м→10
            private _distBonus = (20 - _dist) / 20 * 10;
            _hungerBonus + _distBonus
        } else {
            0
        }
    }
    
    def(onStart) {
        params ["_agent"];
        
        private _bodyPart = _agent getv(nearestBodyPart);
        self setv(targetBodyPart,_bodyPart);
        self setv(isEating,false);
        self setv(lastBiteTime,0);
    }
    
    def_ret(onUpdate) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        private _bodyPart = self getv(targetBodyPart);
        
        // Проверяем существует ли ещё часть тела
        if (isNullReference(_bodyPart)) exitWith {UPDATE_STATE_FAILED};
        if (!callFunc(_bodyPart,isInWorld)) exitWith {UPDATE_STATE_FAILED};
        
        // Если появилась опасность - прерываем
        private _target = _agent getv(visibleTarget);
        if (!isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
        
        // Проверяем наелись ли
        private _currentHunger = getVar(_mob,hunger);
        if (_currentHunger >= self getv(targetHungerLevel)) exitWith {
            // Наелись! Удаляем часть тела и завершаем
            callFunc(_bodyPart,deleteObject);
            UPDATE_STATE_COMPLETED
        };
        
        private _dist = callFuncParams(_mob,getDistanceTo,_bodyPart);
        private _eatDistance = _agent getv(interactDistance);
        
        // Фаза 1: Движение к части тела
        if (_dist > _eatDistance) exitWith {
            // Если уже ели - встаём
            if (self getv(isEating)) then {
                [_mob,STANCE_UP] call ai_setStance;
                self setv(isEating,false);
            };
            
            if !(_agent callv(hasPath)) then {
                private _targetPos = atltoasl callFunc(_bodyPart,getPos);
                private _success = [_mob,_targetPos] call ai_planMove;
                if (!_success) exitWith {UPDATE_STATE_FAILED};
                [_mob,SPEED_MODE_WALK] call ai_setSpeed;
            };
            UPDATE_STATE_CONTINUE
        };
        
        // Фаза 2: Поедание (атака еды)
        if !(self getv(isEating)) then {
            // Начинаем есть - присаживаемся
            [_mob] call ai_stopMove;
            [_mob,_bodyPart] call ai_rotateTo;
            [_mob,STANCE_MIDDLE] call ai_setStance;
            
            self setv(isEating,true);
            self setv(lastBiteTime,tickTime - (self getv(biteCooldown))); // Первый укус сразу
        };
        
        // Проверяем кулдаун укуса
        private _lastBite = self getv(lastBiteTime);
        private _cooldown = self getv(biteCooldown);
        private _timeSinceLastBite = tickTime - _lastBite;
        
        if (_timeSinceLastBite >= _cooldown) then {
            // Делаем укус!
            [_mob,_bodyPart] call ai_rotateTo;
            
            // Атакуем часть тела (визуально)
            [_mob,_bodyPart] call ai_attackTarget; // если есть такая функция
            
            // Восстанавливаем голод
            private _newHunger = (_currentHunger + (self getv(biteHungerRestore))) min 100;
            setVar(_mob,hunger,_newHunger);
            
            // Устанавливаем время следующего укуса
            self setv(lastBiteTime,tickTime + rand(0,self getv(biteCooldownRand)));
            
            ["Eating: Bite! Hunger: %1 -> %2",_currentHunger toFixed 1,_newHunger toFixed 1] call ai_log;
        };
        
        UPDATE_STATE_CONTINUE
    }
    
    def(onCompleted) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        self setv(targetBodyPart,nullPtr);
        self setv(isEating,false);
        self setv(lastBiteTime,0);
        [_mob,STANCE_UP] call ai_setStance;
        [_mob,false] call ai_setCombatMode;
    }
    
    def(onFailed) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        self setv(targetBodyPart,nullPtr);
        self setv(isEating,false);
        self setv(lastBiteTime,0);
        [_mob,STANCE_UP] call ai_setStance;
        [_mob,false] call ai_setCombatMode;
    }
endstruct