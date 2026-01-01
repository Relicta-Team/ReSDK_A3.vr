// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

#include "..\ai.h"

#include "Builders\builders.sqf"

#include "Behaviors\test.sqf"
#include "Behaviors\Eater.sqf"
#include "Behaviors\SmallRat.sqf"

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
		params ["_agent"];
		0
	}

	//проверяет будет ли действие доступно в текущий момент
	def(isAvailable) {
		params ["_agent"];
		true
	}

	//вызывается при старте действия
	def(onStart) {
		params ["_agent"];
	}

	//вызывается каждый кадр обновления. Возвращает UPDATE_STATE_COMPLETED если завершено, UPDATE_STATE_FAILED если провалено, UPDATE_STATE_CONTINUE если продолжается
	def_ret(onUpdate) {
		params ["_agent"];
		UPDATE_STATE_COMPLETED //в базовом методе по умолчанию действие успешно завершено
	}

	//вызывается при успешном завершении действия
	def(onCompleted) {
		params ["_agent"];
	}

	//вызывается при провале действия
	def(onFailed) {
		params ["_agent"];
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
	def(mob) nullPtr; // ссылка на моба
	def(lastvalidpos) [0,0,0]; // последняя валидная позиция
	def(lastPointSetup) 0; // время установки последней точки пути
	def(curpath) []; // текущий путь (массив позиций)
	def(targetidx) 0; // индекс текущей точки на пути
	def(ismoving) false; // флаг движения
	def(pathTask) null //задача движения
	def(_lastPathTask) refcreate(false);
	
	//путь назначен
	def(hasPath) {
		!isNull(self getv(pathTask))
	}

	//последний путь был достигнут
	def(isPathReached) {
		refget(self getv(_lastPathTask))
	}

	def(getPathTask) {
		self getv(pathTask)
	}

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

	def(nextBrainUpdate) 0; // время следующего обновления brain

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

	// обновляет контекстные данные
	def(updateContext) {
		params ["_mob"];
		// базовая реализация пустая
	}

	// ============================================================================
	// HELPER-МЕТОДЫ ДЛЯ УДОБНОГО ДОСТУПА К ДАННЫМ
	// ============================================================================
	
	// Получить моба агента
	def(getMob) {
		self getv(mob)
	}
	
	// Получить процент стамины (0-100)
	def(getStaminaPercent) {
		private _mob = self getv(mob);
		private _stamina = getVar(_mob,stamina);
		private _staminaMax = getVar(_mob,staminaMax);
		(_stamina / _staminaMax) * 100
	}
	
	// Получить процент здоровья (0-100)
	def(getHealthPercent) {
		100 //TODO: реализовать
	}
	
	// В бою ли агент
	def(isInCombat) {
		private _mob = self getv(mob);
		getVar(_mob,isCombatModeEnable) || !isNullReference(self getv(visibleTarget))
	}

	// ============================================================================
	// ОБНОВЛЕНИЕ СЕНСОРОВ
	// ============================================================================
	// Переопределяется в дочерних классах для реализации конкретного поведения
	def(updateSensors) {
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
		private _mob = self getv(mob);
		
		// Ищем ближайших мобов (включая игроков)
		private _nearMobs = callFuncParams(_mob,getNearMobs,20);
		private _refview = refcreate(VISIBILITY_MODE_NONE);
		_nearMobs = _nearMobs select {
			callFunc(_x,isPlayer)
			&& {!getVar(_x,isDead)}
			&& {callFuncParams(_mob,canSeeObject,_x arg _refview)}
			&& {refget(_refview) >= VISIBILITY_MODE_LOW}
			&& isTypeOf(_x,Mob)
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
	def(actions) ["BAEater_Patrol","BAEater_Search","BAEater_Chase","BAEater_Attack","BAEater_Retreat","BAEater_EatBodyParts"];
	
	// Сенсорные данные
	def(visibleTarget) nullPtr; // видимая цель
	def(lastSeenTargetTime) 0; // время последнего обнаружения
	def(lastSeenTargetPos) [0,0,0]; // последняя известная позиция цели
	def(nearestBodyPart) nullPtr; // ближайшая часть тела для поедания
	def(nearPlayers) []; // ближайшие игроки (для отступления)
	
	def(interactDistance) 1.3;
	def(attackDistance) 1.9;
	def(bodyPartScanDistance) 20; // расстояние сканирования частей тела
	def(retreatScanDistance) 15; // расстояние сканирования игроков для отступления

	def(sensorUpdateDelay) 0.5;
	def(updateDelay) 0.3;
	
	//сенсорные контекстные данные
	def(distanceToTarget) 0; // расстояние до цели
	def(hasTarget) false;
	def(staminaPrecent) 100;
	def(inCombat) false;
	def(isHunger) false;
	def(angryLevel) 0;

	def(updateContext) {
		private _mob = self getv(mob);
		
		private _target = self getv(visibleTarget);
		self setv(hasTarget,!isNullReference(_target));
		self setv(staminaPrecent,getVar(_mob,stamina) / getVar(_mob,staminaMax) * 100);
		self setv(inCombat,getVar(_mob,isCombatModeEnable) || self getv(hasTarget));
		self setv(isHunger,getVar(_mob,hunger) < 40);
		self setv(angryLevel,ifcheck(self getv(inCombat),10,0));

		if (self getv(hasTarget)) then {
			self setv(distanceToTarget,callFuncParams(_mob,getDistanceTo,_target));
		};

	}

	def(updateSensors) {
		
		private _mob = self getv(mob);
		
		private _hadTarget = !isNullReference(self getv(visibleTarget));

		// Ищем ближайших врагов
		private _refview = refcreate(VISIBILITY_MODE_NONE);
		private _nearMobs = [_mob,40,{
			callFunc(_this,isPlayer)
			&& isTypeOf(_this,Mob)
			&& {!getVar(_this,isDead)}
			&& {callFuncParams(_mob,canSeeObject,_this arg _refview)}
			&& {refget(_refview) >= VISIBILITY_MODE_LOW}
		}] call ai_getNearMobs;
		
		if (count _nearMobs > 0) then {
			// Нашли врага
			private _closestMob = _nearMobs select 0;
			//todo onEaterRoar
			self setv(visibleTarget,_closestMob);
			self setv(lastSeenTargetTime,tickTime);
			self setv(lastSeenTargetPos,atltoasl callFunc(_closestMob,getPos));
			
			// Переключаемся в боевой режим если только обнаружили цель
			if (!_hadTarget) then {
				// Включаем комбат-режим
				if (!getVar(_mob,isCombatModeEnable)) then {
					callFuncParams(_mob,setCombatMode,true);
				};
				// Переключаемся на бег
				[_mob,SPEED_MODE_RUN] call ai_setSpeed;
			};
		} else {
			// Враг не виден
			self setv(distanceToTarget,0);
			self setv(visibleTarget,nullPtr);
			// lastSeenTargetTime НЕ сбрасываем - используется для поиска
			
			// Проверяем давность следа
			private _lastSeenTime = self getv(lastSeenTargetTime);
			private _timeSinceLost = if (_lastSeenTime > 0) then {
				tickTime - _lastSeenTime
			} else {
				999 // никогда не видели
			};
			
			// Выходим из боевого режима только если след давно потерян (30+ секунд)
			if (_hadTarget && _timeSinceLost > 30) then {
				// Выключаем комбат-режим
				if (getVar(_mob,isCombatModeEnable)) then {
					callFuncParams(_mob,setCombatMode,false);
				};
				// Переключаемся на ходьбу
				[_mob,SPEED_MODE_WALK] call ai_setSpeed;
			};
		};
		
		// Сканирование частей тела для поедания
		private _bodyPartScanDist = self getv(bodyPartScanDistance);
		private _nearItems = [_mob,_bodyPartScanDist,{isTypeOf(_this,BodyPart)}] call ai_getNearItems;
		
		if (count _nearItems > 0) then {
			// Сортируем по близости
			private _mobPos = callFunc(_mob,getPos);
			_nearItems = [_nearItems,{_mobPos distance callFunc(_x,getPos)},true] call sortBy;
			self setv(nearestBodyPart,_nearItems select 0);
		} else {
			self setv(nearestBodyPart,nullPtr);
		};
		
		// Сканирование игроков для отступления (даже если не видим напрямую)
		private _retreatScanDist = self getv(retreatScanDistance);
		private _nearPlayersForRetreat = [_mob,_retreatScanDist] call ai_getNearMobs;
		_nearPlayersForRetreat = _nearPlayersForRetreat select {
			callFunc(_x,isPlayer) && !getVar(_x,isDead) && isTypeOf(_x,Mob)
		};
		self setv(nearPlayers,_nearPlayersForRetreat);
	}
endstruct

