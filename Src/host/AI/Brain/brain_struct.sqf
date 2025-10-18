// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

/*
	BA - Brain Action - обязательный префикс для всех действий
	Базовое действие для ИИ-системы

	Этот файл загружается из загрузчика структур
*/
struct(BABase)
	def(name) ""; //базовое имя действия

	def(baseScore) 0; //базовая стоимость действия

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

	//вызывается каждый кадр обновления. Возвращает true если завершено, false если продолжается
	def_ret(onUpdate) {
		params ["_agent","_mob"];
		false
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
		private _pos = getPosATL _actor;
		private _randomPos = [
			(_pos select 0) + (random 20 - 10),
			(_pos select 1) + (random 20 - 10),
			0
		];
		_agent set ["wanderTarget",_randomPos];
	}

	def_ret(onUpdate) {
		params ["_agent","_mob"];
		private _actor = _agent get "actor";
		private _targetPos = _agent getOrDefault ["wanderTarget",[]];
		if (_targetPos isEqualTo []) exitWith {false}; // failed

		// планируем движение если еще не движемся
		if !(_agent get "ismoving") then {
			[_mob,_targetPos] call ai_planMove;
		};

		// проверяем достигли ли цели
		if (_actor distance2D _targetPos < 2) exitWith {true}; // completed

		false // продолжаем
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

		private _actor = _agent get "actor";
		private _dist = _actor distance _target;
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
		if (isNullReference(_target)) exitWith {false}; // цель пропала - failed

		private _actor = _agent get "actor";
		private _dist = _actor distance _target;
		if (_dist < 3) exitWith {true}; // достигли - completed

		// планируем движение к цели
		private _targetPos = getPosASL _target;
		if !(_agent get "ismoving") then {
			[_mob,_targetPos] call ai_planMove;
		};

		false // продолжаем
	}

	def(onCompleted) {
		params ["_agent","_mob"];
	}

	def(onFailed) {
		params ["_agent","_mob"];
	}
endstruct

/*
	Действие: Атаковать игрока
	Активируется когда игрок очень близко
*/
struct(BAAttackPlayer) base(BABase)
	def(baseScore) 100;

	def_ret(getScore) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {0};

		private _actor = _agent get "actor";
		private _dist = _actor distance _target;
		if (_dist > 3) exitWith {0}; // слишком далеко

		50 // близко - можем атаковать
	}

	def(onStart) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		_agent set ["attackStartTime",tickTime];
		private _actor = _agent get "actor";
		[_actor,_target] call ai_rotateTo;
	}

	def_ret(onUpdate) {
		params ["_agent","_mob"];
		private _target = _agent getOrDefault ["visibleTarget",nullPtr];
		if (isNullReference(_target)) exitWith {false}; // цель пропала

		private _startTime = _agent getOrDefault ["attackStartTime",0];
		if (tickTime - _startTime < 2) exitWith {false}; // анимация атаки

		// атакуем через ai_attackTarget
		private _targetMob = _target getVariable "link";
		if (!isNullVar(_targetMob)) then {
			[_mob,_targetMob] call ai_attackTarget;
		};

		true // completed, можем повторить
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
	def(actions) ["BAWander","BAChasePlayer","BAAttackPlayer"];

	def(sensorUpdateDelay) 1.0; // обновляем сенсоры раз в секунду
	def(updateDelay) 0.3; // обновляем действия чаще

	// Обновление сенсоров - ищем цели
	def(updateSensors) {
		params ["_agent","_mob"];

		// ищем ближайших мобов (включая игроков)
		private _nearMobs = callFuncParams(_mob,getNearMobs,20);
		_nearMobs = _nearMobs select {callFunc(_x,isPlayer)};

		if (count _nearMobs > 0) then {
			private _closestMob = _nearMobs select 0;
			private _closestActor = callFunc(_closestMob,getBasicLoc);
			_agent set ["visibleTarget",_closestActor];
		} else {
			_agent set ["visibleTarget",nullPtr];
		};
	}
endstruct