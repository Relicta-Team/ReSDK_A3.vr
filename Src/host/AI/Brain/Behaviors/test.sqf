// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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
	def(requiredAgentFields) ["visibleTarget"]; // требуется для проверки наличия цели
	
	// Локальные данные действия
	def(wanderTarget) []; // целевая точка для блуждания

	def_ret(getScore) {
		params ["_agent","_mob"];
		if isNullReference(_agent getv(visibleTarget)) exitWith {150};
		0 // просто базовый score
	}

	def(onStart) {
        params ["_agent","_mob"];
        
        // Ищем ближайшую валидную точку в радиусе 30 метров
        private _wanderPos = [_mob, [], 30] call ai_findNearestValidPosition;
        
        if (_wanderPos isEqualTo []) then {
            // Fallback - случайная точка рядом
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
		params ["_agent","_mob"];
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
		params ["_agent","_mob"];
		self setv(wanderTarget,[]);
	}

	def(onFailed) {
		params ["_agent","_mob"];
		self setv(wanderTarget,[]);
	}
endstruct

/*
	Действие: Преследовать игрока
	Активируется когда игрок в радиусе видимости
*/
struct(BAChasePlayer_test) base(BABase)
	def(baseScore) 50;
	def(requiredAgentFields) ["visibleTarget"]; // требуется для преследования цели

	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {0};

		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 20) exitWith {0}; // слишком далеко
		if (_dist < 3) exitWith {0}; // слишком близко - атаковать

		// чем ближе цель, тем выше score
		(20 - _dist)
	}

	def(onStart) {
		params ["_agent","_mob"];
		// цель уже в agent через sensors
	}

	def_ret(onUpdate) {
		params ["_agent","_mob"];
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
		params ["_agent","_mob"];
		[_mob] call ai_stopMove; //игрок сам на нас мог добежать
	}

	def(onFailed) {
		params ["_agent","_mob"];
		[_mob] call ai_stopMove;
	}
endstruct

// Отступать от цели
struct(BARetreat_test) base(BABase)
	def(requiredAgentFields) ["visibleTarget"]; // требуется для проверки наличия цели
	
	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {0};
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3 || getVar(_mob,stamina) > 30) exitWith {0}; // слишком далеко или стамина восстановлена

		(30 - getVar(_mob,stamina)) * 4
	}

	def(onStart) {
		params ["_agent","_mob"];
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
		params ["_agent","_mob"];
		if (!(_agent getv(ismoving))) exitWith {UPDATE_STATE_COMPLETED};
		UPDATE_STATE_CONTINUE
	}

	def(onCompleted) {
		params ["_agent","_mob"];
		[_mob] call ai_stopMove;
	};

endstruct

/*
	Действие: Атаковать игрока
	Активируется когда игрок очень близко
*/
struct(BAAttackPlayer_test) base(BABase)
	def(requiredAgentFields) ["visibleTarget"]; // требуется для атаки цели
	
	// Локальные данные действия
	def(attackStartTime) 0;

	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getv(visibleTarget);
		if (isNullReference(_target)) exitWith {0};

		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3) exitWith {0}; // слишком далеко
		if (getVar(_mob,stamina) < 10) exitWith {2}; //нет стамины - приоритет низок

		60 // близко - можем атаковать
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

		private _startTime = self getv(attackStartTime);
		if (tickTime - _startTime < 2) exitWith {UPDATE_STATE_CONTINUE};

		// атакуем через ai_attackTarget
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
