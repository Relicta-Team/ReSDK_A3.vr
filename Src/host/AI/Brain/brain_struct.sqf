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

#include "Behaviors\test.sqf"
#include "Behaviors\Eater.sqf"

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

	// ============================================================================
	// КОНТРАКТ ДЕЙСТВИЯ
	// ============================================================================
	/*
		Список обязательных полей агента для работы действия
		Переопределяется в дочерних классах
		Пример: ["visibleTarget", "lastSeenTargetTime"]
	*/
	def(requiredAgentFields) [];

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
	Agent - обязательный префикс для всех агентов
	Агент - это система управления поведением моба, объединяющая:
	- Системные данные (actor, движение, путь)
	- Сенсоры (обнаружение целей, окружения)
	- Действия (actions) и логику их выбора
	
	Архитектура: mob -> agent -> action
	- mob: игровой объект
	- agent: управляющая структура (AgentBase и наследники)
	- action: конкретное действие (BABase и наследники)
*/
struct(AgentBase)
	def(name) ""; //базовое имя агента

	// ============================================================================
	// СИСТЕМНЫЕ ДАННЫЕ
	// ============================================================================
	def(actor) objNull; // игровой объект (Arma actor)
	def(lastvalidpos) [0,0,0]; // последняя валидная позиция
	def(curpath) []; // текущий путь (массив позиций)
	def(targetidx) 0; // индекс текущей точки на пути
	def(ismoving) false; // флаг движения

	// ============================================================================
	// UTILITY AI - УПРАВЛЕНИЕ ДЕЙСТВИЯМИ
	// ============================================================================
	def(actions) []; // строковый массив типов действий, доступных агенту
	def(possibleActions) []; // массив инстансов действий (сгенерированный список)
	def(currentAction) null; // текущее выполняемое действие
	
	// Обновления
	def(nextSensorUpdate) 0; // время следующего обновления сенсоров
	def(nextActionUpdate) 0; // время следующего обновления действий
	def(sensorUpdateDelay) 1.0; // задержка обновления сенсоров
	def(updateDelay) 0.3; // задержка обновления действий

	// ============================================================================
	// ИНИЦИАЛИЗАЦИЯ
	// ============================================================================
	def(init)
	{
		if ((self getv(name)) == "") then {
			private _name = struct_typename(self);
			_name = _name select [5]; // убираем префикс "Agent"
			self setv(name,_name);
		};
	}

	// ============================================================================
	// ГЕНЕРАЦИЯ ДЕЙСТВИЙ
	// ============================================================================
	// Создает инстансы всех действий из списка actions
	// Проверяет совместимость действий с агентом (наличие требуемых полей)
	def(generateActions)
	{
		private _actsList = [];
		private _agentType = struct_typename(self);
		
		{
			private _aName = _x;
			private _action = [_aName] call struct_alloc;
			private _required = _action getv(requiredAgentFields);
			
			// Проверяем наличие всех требуемых полей
			private _missingFields = [];
			{
				private _fieldName = _x;
				// Проверяем что поле существует в структуре агента
				if (isNull(self get _fieldName)) then {
					_missingFields pushBack _fieldName;
				};
			} forEach _required;
			
			// Если есть недостающие поля
			if (count _missingFields > 0) then {
				private _errorMsg = format[
					"Agent '%1' is incompatible with action '%2'. Missing required fields: %3",
					_agentType,
					_aName,
					_missingFields
				];
				
				#ifdef EDITOR
					// В редакторе - выбрасываем ошибку
					setLastError(_errorMsg);
				#else
					// В проде - логируем и пропускаем действие
					errorformat(_errorMsg);
				#endif
			} else {
				// Совместимо - добавляем действие
				_actsList pushBack _action;
			};
		} foreach (self getv(actions));
		
		self setv(possibleActions,_actsList);
	}

	// ============================================================================
	// ОБНОВЛЕНИЕ СЕНСОРОВ
	// ============================================================================
	// Переопределяется в дочерних классах для реализации конкретного поведения
	def(updateSensors) {
		params ["_mob"];
		// базовая реализация пустая
	}
endstruct

// ============================================================================
// КОНКРЕТНЫЕ АГЕНТЫ
// ============================================================================

/*
	ZombieAgent - простое агрессивное поведение
	Действия: бродить, преследовать, атаковать, отступать
*/
struct(AgentZombie) base(AgentBase)
	def(actions) ["BAWander_test","BAChasePlayer_test","BAAttackPlayer_test","BARetreat_test"];
	
	// Сенсорные данные
	def(visibleTarget) nullPtr; // видимая цель
	
	def(sensorUpdateDelay) 1.0;
	def(updateDelay) 0.3;
	
	def(updateSensors) {
		params ["_mob"];
		
		// Ищем ближайших мобов (включая игроков)
		private _nearMobs = callFuncParams(_mob,getNearMobs,20);
		private _refview = refcreate(VISIBILITY_MODE_NONE);
		_nearMobs = _nearMobs select {
			callFunc(_x,isPlayer)
			&& {callFuncParams(_mob,canSeeObject,_x arg _refview)}
			&& {refget(_refview) >= VISIBILITY_MODE_LOW}
		};
		
		if (count _nearMobs > 0) then {
			private _closestMob = _nearMobs select 0;
			self setv(visibleTarget,_closestMob);
		} else {
			self setv(visibleTarget,nullPtr);
		};
	}
endstruct

/*
	EaterAgent - тактический охотник
	Действия: патрулировать, искать, преследовать, атаковать, отступать
*/
struct(AgentEater) base(AgentBase)
	def(actions) ["BAEater_Patrol","BAEater_Search","BAEater_Chase","BAEater_Attack","BAEater_Retreat"];
	
	// Сенсорные данные
	def(visibleTarget) nullPtr; // видимая цель
	def(lastSeenTargetTime) 0; // время последнего обнаружения
	def(lastSeenTargetPos) [0,0,0]; // последняя известная позиция цели
	
	def(sensorUpdateDelay) 0.5;
	def(updateDelay) 0.3;
	
	def(updateSensors) {
		params ["_mob"];
		
		// Ищем ближайших врагов
		private _nearMobs = callFuncParams(_mob,getNearMobs,50);
		
		// Фильтруем: игроки или враждебная команда
		_nearMobs = /*_nearMobs select {
			private _isPlayer = callFunc(_x,isPlayer);
			private _isHostile = false;
			
			if (!_isPlayer) then {
				private _myTeam = getVar(_mob,team);
				private _theirTeam = getVar(_x,team);
				_isHostile = !isNullVar(_myTeam) && !isNullVar(_theirTeam) && {_myTeam != _theirTeam};
			};
			
			_isPlayer || _isHostile
		};*/
		_nearMobs select {
			callFunc(_x,isPlayer)
			&& {callFuncParams(_mob,canSeeObject,_x arg _refview)}
			&& {refget(_refview) >= VISIBILITY_MODE_LOW}
		};
		
		if (count _nearMobs > 0) then {
			// Нашли врага
			private _closestMob = _nearMobs select 0;
			private _closestActor = callFunc(_closestMob,getBasicLoc);
			
			self setv(visibleTarget,_closestActor);
			self setv(lastSeenTargetTime,tickTime);
			self setv(lastSeenTargetPos,getPosASL _closestActor);
		} else {
			// Враг не виден
			self setv(visibleTarget,nullPtr);
			// lastSeenTargetTime НЕ сбрасываем - используется для поиска
		};
	}
endstruct

