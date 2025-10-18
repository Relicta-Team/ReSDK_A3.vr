// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

#include "..\ai.h"

/*
	BA - Brain Action - обязательный префикс для всех действий
	Базовое действие для ИИ-системы

	Этот файл загружается из загрузчика структур

	Для верного распределения приоритетов следуйте правило балансировки:
	Балансировка приоритетов:
		90-100: критические действия (выживание)
		60-90: важные тактические (бой, преследование)
		30-60: утилитарные (поиск ресурсов, лечение)
		10-30: комфорт (отдых, исследование)
		0-10: фоновые (бродить, ничего)
*/
struct(BABase)
	def(name) ""; //базовое имя действия

	def(baseScore) 0; //базовая стоимость действия. может быть не определена для полной динамики

	def(state) "idle"; //состояние: idle, running, completed, failed

	//модификатор, добавляемый к базовой стоимости действия
	def(getScore) {
		params ["_agent","_mob"];
		0
	}

	//вызывается при старте действия
	def(onStart) {
		params ["_agent","_mob"];
	}

	//вызывается каждый кадр обновления. Возвращает UPDATE_STATE_COMPLETED если завершено, UPDATE_STATE_FAILED если провалено, UPDATE_STATE_CONTINUE если продолжается
	def_ret(onUpdate) {
		params ["_agent","_mob"];
		UPDATE_STATE_COMPLETED //в базовом методе по умолчанию действие успешно завершено
	}

	//вызывается при успешном завершении действия
	def(onCompleted) {
		params ["_agent","_mob"];
	}

	//вызывается при провале действия
	def(onFailed) {
		params ["_agent","_mob"];
	}

	def(_lastScore) 0; //последняя оценка пишется сюда
	
	def(init)
	{
		if ((self getv(name)) == "") then {
			private _name = struct_typename(self);
			_name = _name select [2];
			self setv(name,_name);
		};
	}

	def(str) {
		format["%1 (score: %2, state: %3)",self getv(name),self getv(_lastScore),self getv(state)]
	}
endstruct


/*
	BHV - Behavior - обязательный префикс для всех поведений
	Поведение - это группа действий, которые выполняются в определенной последовательности
	Поведение может быть составлено из нескольких действий и других поведений
	

*/
struct(BHVBase) //Behavior Base - обязательный префикс для всех поведений
	def(name) ""; //базовое имя поведения

	def(sensorUpdateDelay) 0.1; //задержка обновления сенсоров
	def(sensorNextUpdate) 0; //время следующего обновления сенсоров

	def(updateDelay) 0.1; //частота обновления поведения
	def(nextUpdate) 0; //время следующего обновления поведения

	def(actions) []; //строковый массив типов действий, которые есть в данном поведении

	def(init)
	{
		if ((self getv(name)) == "") then {
			private _name = struct_typename(self);
			_name = _name select [3];
			self setv(name,_name);
		};
	}

	def(_possibleActions) []; //массив возможных действий (сгенерированный список)

	//обновление сенсоров (переопределяется в дочерних классах)
	def(updateSensors) {
		params ["_agent","_mob"];
	}

	//генерирует список объектов возможных действий
	def(generateActions)
	{
		params ["_agent"];
		private _actsList = [];
		{
			private _aName = _x;
			_actsList pushBack ([_aName] call struct_alloc);
		} foreach (self getv(actions));
		self setv(_possibleActions,_actsList);
	}
endstruct

// ============================================================================
// ПРИМЕРЫ ДЕЙСТВИЙ И ПОВЕДЕНИЙ
// ============================================================================

/*
	Действие: Бродить случайно
	Базовое действие с низким приоритетом, всегда доступно
*/
struct(BAWander) base(BABase)
	def(baseScore) 10;

	def_ret(getScore) {
		params ["_agent","_mob"];
		if isNullReference(_agent get "visibleTarget") exitWith {150};
		0 // просто базовый score
	}

	def(onStart) {
        params ["_agent","_mob"];
        private _actor = _agent get "actor";
        private _currentPos = getPosASL _actor;
        
        // 1. Получаем текущий регион
        private _currentRegionKey = [_currentPos select 0, _currentPos select 1] call ai_nav_getRegionKey;
        
        // 2. Собираем текущий регион + 8 соседей (3x3 сетка)
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
            // Fallback на старую систему если нет регионов
            private _pos = getPosATL _actor;
            private _randomPos = [
                (_pos select 0) + (random 20 - 10),
                (_pos select 1) + (random 20 - 10),
                0
            ];
            _agent set ["wanderTarget",_randomPos];
        };
        
        // 3. Выбираем случайный регион
        private _selectedRegionKey = pick _availableRegions;
        private _regionData = ai_nav_regions get _selectedRegionKey;
        private _nodeIds = _regionData get "nodes";
        
        // 4. Фильтруем только узлы с соседями (связанные)
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
            _agent set ["wanderTarget",_randomPos];
        };
        
        // 5. Выбираем случайный связанный узел
        private _selectedNodeId = pick _connectedNodes;
        private _nodeData = ai_nav_nodes get _selectedNodeId;
        private _targetPos = _nodeData get "pos";
        
        _agent set ["wanderTarget",_targetPos];
    }

	def_ret(onUpdate) {
		params ["_agent","_mob"];
		private _actor = _agent get "actor";
		private _targetPos = _agent getOrDefault ["wanderTarget",[]];
		if (_targetPos isEqualTo []) exitWith {UPDATE_STATE_FAILED};

		// планируем движение если еще не движемся
		if !(_agent get "ismoving") then {
			private _success = [_mob,_targetPos] call ai_planMove;
			if (!_success) exitWith {UPDATE_STATE_FAILED};
		};

		// проверяем достигли ли цели
		if (_actor distance2D _targetPos < 2) exitWith {UPDATE_STATE_COMPLETED};

		UPDATE_STATE_CONTINUE
	}

	def(onCompleted) {
		params ["_agent","_mob"];
		_agent set ["wanderTarget",null];
	}

	def(onFailed) {
		params ["_agent","_mob"];
		_agent set ["wanderTarget",null];
	}
endstruct

/*
	Действие: Преследовать игрока
	Активируется когда игрок в радиусе видимости
*/
struct(BAChasePlayer) base(BABase)
	def(baseScore) 50;

	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
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
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};

		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist < 3) exitWith {UPDATE_STATE_COMPLETED};

		private _success = true;
		if !(_agent get "ismoving") then {
			_success = [_mob,_target] call ai_planMove;
		};
		if (!_success) exitWith {UPDATE_STATE_FAILED};
		//если цель далеко от точки конца пути
		if ((atltoasl callFunc(_target,getPos)) distance (array_selectlast(_agent get "curpath")) > 1.8) exitWith {UPDATE_STATE_FAILED};

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
struct(BARetreat) base(BABase)
	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {0};
		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3 || getVar(_mob,stamina) > 30) exitWith {0}; // слишком близко - атаковать

		(30 - getVar(_mob,stamina)) * 4
	}

	def(onStart) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {};

		//обтаное движение от цели
		private _targetPos = atltoasl callFunc(_target,getPos);
		private _myPos = atltoasl callFunc(_mob,getPos);
		private _direction = _targetPos vectorDiff _myPos;
		private _newPos = _myPos vectorAdd (_direction vectorMultiply 10);
		_m = [_mob,_newPos] call ai_planMove;
	}

	def_ret(onUpdate) {
		params ["_agent","_mob"];
		if (!(_agent get "ismoving")) exitWith {UPDATE_STATE_COMPLETED};
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
struct(BAAttackPlayer) base(BABase)

	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {0};

		private _dist = callFuncParams(_mob,getDistanceTo,_target);
		if (_dist > 3) exitWith {0}; // слишком далеко
		if (getVar(_mob,stamina) < 10) exitWith {2}; //нет стамины - приоритет низок

		60 // близко - можем атаковать
	}

	def(onStart) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		_agent set ["attackStartTime",tickTime];
		[_mob,_target] call ai_rotateTo;
	}

	def_ret(onUpdate) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {UPDATE_STATE_FAILED};

		private _startTime = _agent getOrDefault ["attackStartTime",0];
		if (tickTime - _startTime < 2) exitWith {UPDATE_STATE_CONTINUE};

		// атакуем через ai_attackTarget
		[_mob,_target] call ai_attackTarget;

		UPDATE_STATE_COMPLETED
	}

	def(onCompleted) {
		params ["_agent","_mob"];
		_agent set ["attackStartTime",null];
	}

	def(onFailed) {
		params ["_agent","_mob"];
		_agent set ["attackStartTime",null];
	}
endstruct

/*
	Поведение: Зомби
	Простое поведение с тремя действиями
*/
struct(BHVZombie) base(BHVBase)
	def(actions) ["BAWander","BAChasePlayer","BAAttackPlayer","BARetreat"];

	def(sensorUpdateDelay) 1.0; // обновляем сенсоры раз в секунду
	def(updateDelay) 0.3; // обновляем действия чаще

	// Обновление сенсоров - ищем цели
	def(updateSensors) {
		params ["_agent","_mob"];

		// ищем ближайших мобов (включая игроков)
		private _nearMobs = callFuncParams(_mob,getNearMobs,20);
		private _refview = refcreate(VISIBILITY_MODE_NONE);
		_nearMobs = _nearMobs select {
			callFunc(_x,isPlayer)
			&& {callFuncParams(_mob,canSeeObject,_x arg _refview)}
			&& {refget(_refview) >= VISIBILITY_MODE_LOW}
		};

		if (count _nearMobs > 0) then {
			private _closestMob = _nearMobs select 0;
			_agent set ["visibleTarget",_closestMob];
		} else {
			_agent set ["visibleTarget",nullPtr];
		};
	}
endstruct