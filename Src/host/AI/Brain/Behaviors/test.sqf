// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ============================================================================
// ПРИМЕРЫ ДЕЙСТВИЙ И ПОВЕДЕНИЙ
// ============================================================================

/*
	Действие: Бродить случайно
	Базовое действие с низким приоритетом, всегда доступно
*/
struct(BAWander_test) base(BABase)
	def(baseScore) 10;
	def(requiredAgentFields) ["visibleTarget"];
	
	// Локальные данные действия
	def(wanderTarget) [];

	// КОНТЕКСТ: можем бродить?
	def_ret(isAvailable) {
		params ["_agent"];
		isNullReference(_agent getv(visibleTarget)) // нет цели
	}

	// ПОЛЕЗНОСТЬ: высокий приоритет если нет цели
	def_ret(getScore) {
		params ["_agent"];
		140 // высокий бонус к baseScore (итого 150)
	}

	def(onStart) {
        params ["_agent"];
        
        private _mob = _agent getv(mob);
        
        // Ищем ближайшую валидную точку
        private _wanderPos = [_mob, [], 30] call ai_findNearestValidPosition;
        
        if (_wanderPos isEqualTo []) then {
            // Fallback - случайная точка
            private _actor = _agent getv(actor);
            private _pos = getPosATL _actor;
            _wanderPos = [
                (_pos select 0) + (random 20 - 10),
                (_pos select 1) + (random 20 - 10),
                0
            ];
        };
        
        self setv(wanderTarget, _wanderPos);
    }

	def_ret(onUpdate) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _actor = _agent getv(actor);
		private _targetPos = self getv(wanderTarget);
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
		params ["_agent"];
		self setv(wanderTarget,[]);
	}

	def(onFailed) {
		params ["_agent"];
		self setv(wanderTarget,[]);
	}
endstruct

/*
	Действие: Преследовать игрока
	Активируется когда игрок в радиусе видимости
*/
struct(BAChasePlayer_test) base(BABase)
	def(baseScore) 50;
	def(requiredAgentFields) ["visibleTarget"];

	// КОНТЕКСТ: можем преследовать?
	def_ret(isAvailable) {
		params ["_agent"];
		
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {false};
		
		private _mob = _agent getv(mob);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		
		// Только на средней дистанции
		(_dist >= 3) && (_dist <= 20)
	}

	// ПОЛЕЗНОСТЬ: чем ближе цель, тем выше приоритет
	def_ret(getScore) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		
		// 20м→0, 3м→17
		(20 - _dist)
	}

	def(onStart) {
		params ["_agent"];
	}

	def_ret(onUpdate) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};

		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist < 3) exitWith {UPDATE_STATE_COMPLETED};

		private _success = true;
		if !(_agent getv(ismoving)) then {
			_success = [_mob,_target] call ai_planMove;
		};
		if (!_success) exitWith {UPDATE_STATE_FAILED};
		//если цель далеко от точки конца пути
		if ((atltoasl callFunc(_target,getPos)) distance (array_selectlast(_agent getv(curpath))) > 1.8) exitWith {UPDATE_STATE_FAILED};

		UPDATE_STATE_CONTINUE
	}

	def(onCompleted) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		[_mob] call ai_stopMove;
	}

	def(onFailed) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		[_mob] call ai_stopMove;
	}
endstruct

// Отступать от цели
struct(BARetreat_test) base(BABase)
	def(requiredAgentFields) ["visibleTarget"];
	def(baseScore) 80;
	
	// КОНТЕКСТ: нужно отступать?
	def_ret(isAvailable) {
		params ["_agent"];
		
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {false};
		
		private _mob = _agent getv(mob);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3) exitWith {false};
		
		// Низкая стамина?
		private _staminaPercent = _agent callv(getStaminaPercent);
		(_staminaPercent <= 30)
	}
	
	// ПОЛЕЗНОСТЬ: чем ниже стамина, тем важнее
	def_ret(getScore) {
		params ["_agent"];
		
		private _staminaPercent = _agent callv(getStaminaPercent);
		(30 - _staminaPercent) * 4
	}

	def(onStart) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {};

		// Отступаем на 10 метров от цели
		private _retreatPos = [_mob, _target, 10] call ai_retreatFrom;
		private _success = [_mob, _retreatPos] call ai_planMove;
		
		if (!_success) then {
			["Failed to plan retreat path"] call ai_log;
		};
	}

	def_ret(onUpdate) {
		params ["_agent"];
		if (!(_agent getv(ismoving))) exitWith {UPDATE_STATE_COMPLETED};
		UPDATE_STATE_CONTINUE
	}

	def(onCompleted) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		[_mob] call ai_stopMove;
	};

endstruct

/*
	Действие: Атаковать игрока
	Активируется когда игрок очень близко
*/
struct(BAAttackPlayer_test) base(BABase)
	def(baseScore) 60;
	def(requiredAgentFields) ["visibleTarget"];
	
	// Локальные данные действия
	def(attackStartTime) 0;

	// КОНТЕКСТ: можем атаковать?
	def_ret(isAvailable) {
		params ["_agent"];
		
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {false};
		
		private _mob = _agent getv(mob);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3) exitWith {false};
		
		// Есть стамина?
		private _staminaPercent = _agent callv(getStaminaPercent);
		(_staminaPercent >= 10)
	}

	// ПОЛЕЗНОСТЬ: всегда высокая если доступно
	def_ret(getScore) {
		params ["_agent"];
		0 // просто baseScore
	}

	def(onStart) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		
		self setv(attackStartTime,tickTime);
		[_mob,_target] call ai_rotateTo;
	}

	def_ret(onUpdate) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};

		private _startTime = self getv(attackStartTime);
		if (tickTime - _startTime < 2) exitWith {UPDATE_STATE_CONTINUE};

		// атакуем через ai_attackTarget
		[_mob,_target] call ai_attackTarget;

		UPDATE_STATE_COMPLETED
	}

	def(onCompleted) {
		params ["_agent"];
		self setv(attackStartTime,0);
	}

	def(onFailed) {
		params ["_agent"];
		self setv(attackStartTime,0);
	}
endstruct

/*
	Действие: Фланговая атака
	Моб заходит с фланга для атаки цели (тактическое преимущество)
*/
struct(BAFlankAttack_test) base(BABase)
	def(baseScore) 55;
	def(requiredAgentFields) ["visibleTarget"];
	
	// Локальные данные действия
	def(flankPos) [];
	
	// КОНТЕКСТ: можем фланговать?
	def_ret(isAvailable) {
		params ["_agent"];
		
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {false};
		
		private _mob = _agent getv(mob);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist < 5 || _dist > 20) exitWith {false};
		
		// Высокая стамина для маневра
		private _staminaPercent = _agent callv(getStaminaPercent);
		(_staminaPercent >= 40)
	}
	
	// ПОЛЕЗНОСТЬ: чем дальше цель, тем выгоднее фланг
	def_ret(getScore) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		
		// 5м→0, 20м→20
		((_dist - 5) / 15) * 20
	}
	
	def(onStart) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		
		// Ищем оптимальный фланг
		private _flankPos = [_mob, _target, 6, 60, "optimal"] call ai_findFlankPosition;
		
		if (_flankPos isEqualTo []) exitWith {
			// Fallback - прямой подход
			_flankPos = atltoasl callFunc(_target,getPos);
		};
		
		self setv(flankPos, _flankPos);
		[_mob, _flankPos] call ai_planMove;
	}
	
	def_ret(onUpdate) {
		params ["_agent"];
		
		private _mob = _agent getv(mob);
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};
		
		private _flankPos = self getv(flankPos);
		if (_flankPos isEqualTo []) exitWith {UPDATE_STATE_FAILED};
		
		private _actor = _agent getv(actor);
		
		// Достигли фланговой позиции
		if (_actor distance _flankPos < 3) exitWith {UPDATE_STATE_COMPLETED};
		
		// Продолжаем движение
		if !(_agent getv(ismoving)) then {
			private _success = [_mob, _flankPos] call ai_planMove;
			if (!_success) exitWith {UPDATE_STATE_FAILED};
		};
		
		UPDATE_STATE_CONTINUE
	}
	
	def(onCompleted) {
		params ["_agent"];
		self setv(flankPos, []);
	}
	
	def(onFailed) {
		params ["_agent"];
		self setv(flankPos, []);
	}
endstruct
