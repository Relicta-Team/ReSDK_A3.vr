// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\struct.hpp>
#include <..\GameObjects\GameConstants.hpp>
#include <..\NOEngine\NOEngine.hpp>
#include <..\Gender\Gender.hpp>

//низкоуровневые функции для работы с NOEngine (нужны для ai_getNearObjects_Internal)
#include <..\NOEngine\NOEngine.h>

#include "ai.h"

#include "HPAstar\core.sqf"
#include "HPAstar\debug.sqf"
#include "HPAstar\region.sqf"
#include "HPAstar\update.sqf"
#include "HPAstar\entrance.sqf"

#include "Brain\brain_init.sqf"

#include "ai_interact.sqf"
#include "ai_util.sqf"

#include "HPAstar\native.sqf"

ai_nextUpdateReg = 0;
ai_updateRegInterval = 0.2; //200ms - интервал обновления регионов
ai_maxRegUpdateTime = 0.5; //сколько времени можно потратить на обновление регионов за один цикл

ai_regionsUpdateQueue = []; //очередь регионов на обновление
ai_regionsUpdateMap = createHashMap; //маппинг региона на его индекс в очереди

ai_handleUpdate = -1; //хэндл обновления AI

ai_allMobs = []; //список всех мобов

//активатор регионов для симуляции

ai_activeRegions = createHashMap; // регионы, в которых должен работать AI
ai_activeRegionsRadius = 4; // радиус в регионах
ai_playerLastRegions = createHashMap; // последний регион каждого игрока (clientOwner -> regionKey)

// Увеличивает/уменьшает счётчик активности региона
ai_modifyRegionRefCount = {
    params ["_regionKey", "_delta"]; // _delta: +1 или -1
    
    _regionKey splitString "_" params ["_rx", "_ry"];
    _rx = parseNumber _rx; 
    _ry = parseNumber _ry;
    
    for "_dx" from (-ai_activeRegionsRadius) to ai_activeRegionsRadius do {
        for "_dy" from (-ai_activeRegionsRadius) to ai_activeRegionsRadius do {
            private _key = format ["%1_%2", _rx + _dx, _ry + _dy];
            private _currentCount = ai_activeRegions getOrDefault [_key, 0];
            private _newCount = _currentCount + _delta;
            
            if (_newCount > 0) then {
                ai_activeRegions set [_key, _newCount];
            } else {
                ai_activeRegions deleteAt _key;
            };
        };
    };
};

ai_log = {
	#ifdef EDITOR
		log("[AI]: "+(_this call formatLazy));
	#endif
};

// Brain update budget system
ai_brain_maxTimePerFrame = 0.150; // бюджет на brain updates за кадр
ai_brain_minUpdateInterval = 0.15; // Минимум 150ms между обновлениями
ai_brain_nextUpdateId = 0; // Счетчик для распределения обновлений (staggering)

ai_stats_maxProcUpdate = 0;
ai_stats_maxProcUpdateAgent = 0;
ai_stats_brainUpdatesPerFrame = 0;
ai_stats_brainBudgetUsed = 0;
ai_stats_nextRefreshTime = 0;
#define AI_STATS_REFRESH_INTERVAL 5

//todo remove when ai will be stable
#ifndef EDITOR
ai_countCreatedAI = 0;
ai_maxAICount = 100;
#endif

ai_createMob = {
	params ["_pos",["_builderType","AgentBuilderEater"]];

	#ifndef EDITOR
	if (ai_countCreatedAI >= ai_maxAICount) exitWith {nullPtr};
	ai_countCreatedAI = ai_countCreatedAI + 1;
	#endif

	if !struct_existType_str(_builderType) exitWith {nullPtr};

	private _builder = [_builderType] call struct_alloc;
	private _instanceType = _builder getv(instanceType);
	private _agentType = _builder getv(agentType);

	if !isImplementClass(_instanceType) exitWith {nullPtr};
	if !struct_existType_str(_agentType) exitWith {nullPtr};

	private _gMob = _pos call gm_createMob;
	private _mob = instantiate(_instanceType);
	callFuncParams(_mob,initAsActor,_gMob);

	(_builder callv(getSkills)) params [["_st",10],["_iq",10],["_dx",10],["_ht",10]];
	[_mob,_st,_iq,_dx,_ht] call gurps_initSkills;
	
	private _firstName = _builder callp(getFirstName,_mob);
	if (_firstName == "") then {
		setVar(_mob,name,"Существо");
		([GENDER_MALE] call naming_getRandomName) params ["_f_","_s_"];
		callFuncParams(_mob,generateNaming,_f_ arg _s_);
	} else {
		private _secondName = _builder callp(getSecondName,_mob);
		callFuncParams(_mob,generateNaming,_firstName arg _secondName);
	};

	[_gMob,null,_mob] call cm_registerMobInGame;
	
	private _face = _builder callp(getFace,_mob);
	callFuncParams(_mob,setMobFace,_face);

	_builder callp(onApply,_mob);

	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);

	//forced unsleep
	setVar(_mob,sleepStrength,0);
	
	_gMob enableAI "MOVE";
	_gMob enableAI "ANIM";

	_gMob switchmove "amovpercmstpsnonwnondnon"; //for standup anim

	[_mob,SPEED_MODE_WALK] call ai_setSpeed;

	//создаем регион для существа
	[_pos] call ai_nav_createRegionIfNeed;
	
	ai_allMobs pushBack _mob;

	private _agent = [_pos,_mob,_agentType] call ai_createAgent;

	_mob
};

// Получить мобов в радиусе от позиции используя региональную систему
// Намного быстрее чем перебор всех мобов на карте
ai_getNearMobs_Internal = {
	params ["_centerPos","_distance",["_excludeMob",nullPtr],"_predicate"];
	
	private _regionKey = _centerPos call ai_nav_getRegionKey;
	private _result = [];
	
	// Вычисляем радиус в регионах (округляем вверх)
	private _regionRadius = ceil(_distance / ai_nav_regionSize);
	
	_regionKey splitString "_" params ["_rx","_ry"];
	_rx = parseNumber _rx;
	_ry = parseNumber _ry;
	
	// Проходим только по регионам в радиусе
	for "_dx" from (-_regionRadius) to _regionRadius do {
		for "_dy" from (-_regionRadius) to _regionRadius do {
			private _key = format ["%1_%2",_rx + _dx,_ry + _dy];
			private _regionData = ai_nav_regions get _key;
			
			if (!isNil "_regionData") then {
				private _mobsInRegion = _regionData get "mobs";
				
				{					
					// Проверяем реальное расстояние
					private _mobPos = callFunc(_x,getPos);
					private _dist = _centerPos distance _mobPos;
					
					if (_dist <= _distance) then {
						if (_x call _predicate) then {
							_result pushBack _x;
						};
					};
				} forEach _mobsInRegion;
			};
		};
	};
	
	_result - [_excludeMob]
};

// Версия для моба (удобная обертка, быстрее в 29 раз чем BasicMob::getNearMobs)
ai_getNearMobs = {
	params ["_mob","_distance",["_predicate",{true}]];
	
	private _pos = callFunc(_mob,getPos);
	[_pos,_distance,_mob,_predicate] call ai_getNearMobs_Internal
};

/*
	Упрощенный поиск объектов в радиусе
	Оптимизация достигается засчет получения кешированных объектов из NOEngine,
	а так же простой проверки дистанции с помощью rvengine
	
	old: items 3.88955ms (10k iter)
	cur: items 0.946484ms (10k iter)
	x~4.2 раза быстрее

	with func: items ~1.1ms (10k iter)
*/
ai_getNearObjects_Internal = {
	params ["_centerPos","_distance","_type",["_funcCanAdd",{true}]];
	
	private _result = [];
	private _chunkSize = getChunkSizeByType(_type);
	
	// Вычисляем радиус в чанках
	private _chunkRadius = ceil(_distance / _chunkSize);
	
	// Получаем центральный чанк
	private _centerChunk = [_centerPos,_type] call noe_posToChunk;
	_centerChunk params ["_cx","_cy"];
	
	// Проходим по чанкам в радиусе
	for "_dx" from (-_chunkRadius) to _chunkRadius do {
		for "_dy" from (-_chunkRadius) to _chunkRadius do {
			private _chunkPos = [_cx + _dx,_cy + _dy];
			private _chunkObj = [_chunkPos,_type] call noe_getChunkObject;
			
			if (!isNullVar(_chunkObj)) then {
				private _objectsData = chunk_getObjectsData(_chunkObj);
				
				// Проходим по всем объектам в чанке
				{
					// Проверяем реальное расстояние
					private _dist = _centerPos distance _y;//simple check by mesh
					
					if (_dist <= _distance) then {
						private _gobj = pointerList get _x;
						if (_gobj call _funcCanAdd) then {
							_result pushBack _gobj;
						};
					};
				} forEach _objectsData;
			};
		};
	};
	
	_result
};

ai_getNearItems = {
	params ["_mob","_distance",["_predicate",{true}]];
	private _pos = callFunc(_mob,getPos);
	[_pos,_distance,CHUNK_TYPE_ITEM,_predicate] call ai_getNearObjects_Internal
};

ai_getNearStructs = {
	params ["_mob","_distance",["_predicate",{true}]];
	private _pos = callFunc(_mob,getPos);
	[_pos,_distance,CHUNK_TYPE_STRUCTURE,_predicate] call ai_getNearObjects_Internal
};

ai_getNearDecors = {
	params ["_mob","_distance",["_predicate",{true}]];
	private _pos = callFunc(_mob,getPos);
	[_pos,_distance,CHUNK_TYPE_DECOR,_predicate] call ai_getNearObjects_Internal
};

ai_createAgent = {
	params ["_pos","_mob",["_agentType","AgentEater"]];
	
	// Создаем агента как структуру
	private _agent = [_agentType] call struct_alloc;
	
	setVar(_mob,__aiagent,_agent);

	// Инициализация системных данных
	_agent setv(actor,toActor(_mob));
	_agent setv(mob,_mob);
	_agent setv(speedMode,SPEED_MODE_WALK);
	_agent setv(lastvalidpos,_pos);
	_agent setv(curpath,[]);
	_agent setv(targetidx,0);
	_agent setv(ismoving,false);
	
	// Инициализация Utility AI
	_agent setv(currentAction,null);
	_agent setv(nextSensorUpdate,0);
	_agent setv(nextActionUpdate,0);
	
	// Распределенное обновление brain (staggering)
	ai_brain_nextUpdateId = ai_brain_nextUpdateId + 1;
	private _staggerOffset = (ai_brain_nextUpdateId mod 13) * 0.015; // Распределяем на ~200ms (13 × 15ms)
	_agent set ["nextBrainUpdate", tickTime + _staggerOffset];
	
	// Генерируем действия
	_agent callv(generateActions);
	
	_agent
};

ai_init = {
	if (is3den) exitWith {};
	
	ai_handleUpdate = startUpdate(ai_onUpdate,0);

	#ifdef AI_DEBUG_TRACEPATH
		if !isNull(ai_internal_debug_drawPathHandle) then {
			stopUpdate(ai_internal_debug_drawPathHandle);
		};
		private _upd = {
			call ai_debug_internal_drawPath;
		}; 
		ai_internal_debug_drawPathHandle = startUpdate(_upd,0);
	#endif
	#ifdef AI_DEBUG_BRAINIINFO
		if !isNull(ai_internal_debug_brainiInfoHandle) then {
			stopUpdate(ai_internal_debug_brainiInfoHandle);
		};
		private _upd = {
			call ai_debug_internal_brainiInfo;
		}; 
		ai_internal_debug_brainiInfoHandle = startUpdate(_upd,0);
	#endif
};

//цикл обновления AI
ai_onUpdate = {
	if (tickTime > ai_stats_nextRefreshTime) then {
		ai_stats_nextRefreshTime = tickTime + AI_STATS_REFRESH_INTERVAL;
		ai_stats_maxProcUpdate = 0;
		ai_stats_maxProcUpdateAgent = 0;
		ai_stats_brainUpdatesPerFrame = 0;
		ai_stats_brainBudgetUsed = 0;
	};
	//синхронизируем регионы
	private _pos = [];
	private _tUpd = tickTime;
	private _tAgent = tickTime;
	
	// Brain update budget tracking
	private _brainBudgetUsed = 0;
	private _brainUpdatesThisFrame = 0;

	if (tickTime > ai_nextUpdateReg) then {
		ai_nextUpdateReg = tickTime + ai_updateRegInterval;
		private _updated = [];
		private _tStart = tickTime;
		private _tDelta = 0;
		{
			_pos = [_x] call ai_nav_regionToPos;
			[_pos] call ai_nav_updateRegion;
			ai_regionsUpdateMap deleteAt _x;
			_updated pushBack _forEachIndex;
			_tDelta = tickTime - _tStart;
			if (_tDelta > ai_maxRegUpdateTime) exitWith {
				["region update took too long: %1 ms, count updated: %2",(_tDelta*1000)toFixed 2,count _updated] call ai_log;
			};
		} foreach ai_regionsUpdateQueue;
		if (count _updated > 0) then {
			ai_regionsUpdateQueue deleteAt _updated;
		};
	};
	
	//процессим мобов
	private _agent = null;
	private _mob = null;
	private _curRegion = "";
	private _curRegionObj = null;
	private _deadMobs = [];
	{
		_body = _x;
		_mob = _x getvariable "link";
		_agent = getVar(_mob,__aiagent);

		_curRegion = getVar(_mob,__curRegion);
		_curRegionObj = ai_nav_regions get _curRegion;
		_pos = getposasl _body;
		_changedPos = false;
		_curRegionBackup = _curRegion;

		//обновляем информацию о мобах в регионе
		if isNullVar(_curRegionObj) then {
			//региона не существует - создаем его
			[_pos] call ai_nav_updateRegion;
			_curRegion = _pos call ai_nav_getRegionKey;
			_curRegionBackup = _curRegion;
			
			_curRegionObj = ai_nav_regions get _curRegion;
			(_curRegionObj get "mobs") pushBack _mob;
			setVar(_mob,__curRegion,_curRegion);

			_changedPos = true;
		} else {
			//региона существует - проверяем находится ли моб в нем
			_actualRegion = _pos call ai_nav_getRegionKey;
			_actualRegionObj = ai_nav_regions get _actualRegion;
			
			//если регион не существует - создаем его
			if isNullVar(_actualRegionObj) then {
				[_pos] call ai_nav_updateRegion;
				_actualRegionObj = ai_nav_regions get _actualRegion;
			};

			if not_equals(_curRegionObj,_actualRegionObj) then {
				private _oldRegionMobs = (_curRegionObj get "mobs");
				_oldRegionMobs deleteAt (_oldRegionMobs find _mob);
				(_actualRegionObj get "mobs") pushBack _mob;
				setVar(_mob,__curRegion,_actualRegion);
				
				_changedPos = true;
				_curRegion = _pos call ai_nav_getRegionKey;
			};
		};

		//обновляем счетчик активности региона
		if 
			//callFunc(_mob,isPlayer) //! по непонятной причине флаг игрока может иметь неактуальные значения
			!isNullReference(getVar(_mob,client))
		then {
			if not_equals(_curRegionBackup,_curRegion) then {
				[_curRegionBackup,-1] call ai_modifyRegionRefCount;
			};
			if (_changedPos) then {
				[_curRegion,+1] call ai_modifyRegionRefCount;
			};
		};

		//обновляем агента
		if !isNullVar(_agent) then {
			
			_tAgent = tickTime;

			//todo упрощенная симуляция AI в инактивных регионах
			if !(_curRegion in ai_activeRegions) exitWith {
				// Сбрасываем время обновления brain для последующей активации с staggering
				_agent setv(nextBrainUpdate, -1);
				_curAction = _agent getv(currentAction);
				if !isNullVar(_curAction) then {
					//сброс активного действия
					_curAction setv(state,"idle");
					_curAction callp(onFailed,_agent);
					_agent setv(currentAction,null);
				};
				//временно стопаем сущность
				private _valpos = _agent getv(lastvalidpos);
				[_mob] call ai_stopMove;
				_agent setv(lastvalidpos,_valpos); //на всякий случай откатываем валидную позицию
			};

			#ifdef AI_DEBUG_MOVETOPLAYER
				private _body = toActor(_mob);
				private _pos = getposasl _body;
				if !(_agent getv(ismoving)) then {
					if (tickTime < (_agent getOrDefault ["nextPlanTime",tickTime])) exitWith {};
					_target = getposasl player;
					

					if (_pos distance _target < 1.2) exitWith {};
					if ([_mob,_target] call ai_planMove) then {
						
						
					};
				};
			#endif
			
			if (_agent getv(ismoving)) then {
				[_mob] call ai_handleMove;
			};

			//если моб инактивен - так же стопаем его
			//TODO возможно есть какой-то более лучший способ сделать это
			if !callFunc(_mob,isActive) then {
				[_mob] call ai_stopMove;
				[_mob] call ai_rotateReset;
				if (getVar(_mob,isDead)) then {
					_deadMobs pushBack _mob;
				};
				continue;
			};
			
			// Обновление Utility AI с бюджетом
			private _nextBrainUpdate = _agent getv(nextBrainUpdate);
			
			// Если агент был неактивным (nextBrainUpdate = -1), применяем staggering
			if (_nextBrainUpdate < 0) then {
				ai_brain_nextUpdateId = ai_brain_nextUpdateId + 1;
				private _staggerOffset = (ai_brain_nextUpdateId mod 13) * 0.015;
				_nextBrainUpdate = tickTime + _staggerOffset;
				_agent setv(nextBrainUpdate, _nextBrainUpdate);
			};
			
			// Проверяем: время пришло И есть бюджет
			if (tickTime >= _nextBrainUpdate && _brainBudgetUsed < ai_brain_maxTimePerFrame) then {
				private _brainStart = tickTime;
				
				[_mob, _agent] call ai_brain_update;
				
				private _brainTime = tickTime - _brainStart;
				_brainBudgetUsed = _brainBudgetUsed + _brainTime;
				_brainUpdatesThisFrame = _brainUpdatesThisFrame + 1;
				
				// Планируем следующее обновление
				_agent setv(nextBrainUpdate, tickTime + ai_brain_minUpdateInterval);
			};

			ai_stats_maxProcUpdateAgent = (tickTime - _tAgent) max ai_stats_maxProcUpdateAgent;
		};
	} foreach cm_allInGameMobs;

	{
		setVar(_x,__aiagent,null);
		array_remove(ai_allMobs,_x);
	} foreach _deadMobs;

	// Обновляем статистику brain updates
	ai_stats_brainUpdatesPerFrame = _brainUpdatesThisFrame max ai_stats_brainUpdatesPerFrame;
	ai_stats_brainBudgetUsed = (_brainBudgetUsed * 1000) max ai_stats_brainBudgetUsed; // В миллисекундах

	ai_stats_maxProcUpdate = (tickTime - _tUpd) max ai_stats_maxProcUpdate;
};

ai_debug_internal_drawPath = {
	if (!isNull(ai_debug_internal_drawLines)) then {
		{
			drawLine3d [
				_x select 0,
				_x select 1,
				[0,1,0,1],
				30
			]
		} foreach ai_debug_internal_drawLines;
	};
};

#ifdef EDITOR

#include <..\..\client\WidgetSystem\widgets.hpp>

ai_debug_internal_needLoadBrainWidget = true;


ai_debug_internal_brainiInfo = {
	if (ai_debug_internal_needLoadBrainWidget) then {
		if !isNull(ai_debug_internal_brainInfoWidget) then {
			[ai_debug_internal_brainInfoWidget select 0] call deleteWidget;
			ai_debug_internal_brainInfoWidget = null;
		};

		ai_debug_internal_needLoadBrainWidget = false;
		private _gui = getGUI;
		_w = [_gui,TEXT,[60,0,100-60,70]] call createWidget;
		ai_debug_internal_brainInfoWidget = [_w];
		_w setBackgroundColor [0,0,0,0.5];
	};
	private _t = [];

	_t pushBack "=== BRAIN INFO ===";
	_t pushback format["Agents: %1 | Mobs: %2",count ai_allMobs,count smd_allInGameMobs];
	_t pushback format["AR: %1; updQ: %2",count ai_activeRegions,count ai_regionsUpdateQueue,(getposasl player) call ai_nav_getRegionKey];
	_t pushback format["stat: upd: %1 ms, agent: %2 ms",ai_stats_maxProcUpdate*1000,ai_stats_maxProcUpdateAgent*1000];
	_t pushback format["Brain: %1 updates, %2/%3ms budget",
		ai_stats_brainUpdatesPerFrame,
		ai_stats_brainBudgetUsed toFixed 1,
		(ai_brain_maxTimePerFrame * 1000) toFixed 0
	];
	_t pushBack "";

	// Находим ближайшего моба к игроку для детальной информации
	if (count ai_allMobs > 0) then {
		private _nearestMob = nullPtr;
		private _nearestDist = 999999;
		{
			private _mob = _x;
			private _actor = toActor(_mob);
			private _dist = player distance _actor;
			if (_dist < _nearestDist) then {
				_nearestDist = _dist;
				_nearestMob = _mob;
			};
		} foreach ai_allMobs;

		if (!isNullReference(_nearestMob)) then {
			private _agent = getVar(_nearestMob,__aiagent);
			
			_t pushBack format["Nearest: %1 (%2m)",getVar(_nearestMob,name),(_nearestDist toFixed 1)];
			_t pushBack format["Agent: %1",_agent getv(name)];
			_t pushback format["moving: %1; stopped: %2; speed: %3",(_agent getv(ismoving)),expectedDestination(_agent getv(actor)) select 1 == "DoNotPlan",ai_internal_speedModes_names get ((_agent getv(speedMode))) ];
			_t pushback format["pathreach: %1; lastPT: %2; curPT: %3",_agent callv(isPathReached),_agent getv(_lastPathTask),_agent getv(pathTask)];
			
			// Текущее действие
			private _currentAction = _agent getv(currentAction);
			if (!isNullVar(_currentAction)) then {
				_t pushBack format["Current: %1",str _currentAction];
				{
					[_x,_y] params ["_name","_value"];
					if not_equalTypes(_value,{}) then {
						if (_name select [0,1] == "#") exitWith {};
						if (_name in [
							"__dflg__",
							"name",
							"state",
							"requiredAgentFields",
							"_lastScore",
							"baseScore"
						]) exitWith {};
						_t pushback format["%1: %2",_name,_value];
					};
				} foreach (_currentAction);
			} else {
				_t pushBack "Current: none";
			};

			_t pushback "";
			_t pushBack "--- Actions ---";
			
			// Все возможные действия и их стоимости
			private _possibleActions = _agent getv(possibleActions);
			{
				private _action = _x;
				private _name = _action getv(name);
				private _score = _action getv(_lastScore);
				private _state = _action getv(state);
				private _marker = "";
				
				if (!isNullVar(_currentAction) && {equals(_action,_currentAction)}) then {
					_marker = " [*]";
				};
				
				_t pushBack format["%1: %2 (%3)%4",_name,_score,_state,_marker];
			} foreach _possibleActions;
			
			// Информация о сенсорах
			_t pushBack "";
			private _target = _agent getv(visibleTarget);
			if (!isNullReference(_target)) then {
				_t pushBack format["Target: detected (%1m)",((toActor(_nearestMob)) distance callFunc(_target,getBasicLoc)) toFixed 1];
			} else {
				_t pushBack "Target: none";
			};
		};
	} else {
		_t pushBack "No mobs active";
	};

	[ai_debug_internal_brainInfoWidget select 0,_t joinString sbr] call widgetSetText;
};

ai_debug_showBrainInfo = {
	params ["_mode"];
	(ai_debug_internal_brainInfoWidget select 0) ctrlShow _mode;
};


//! fix score on recompile behaviors
ai_reloadBehaviors = {
	["src\host\AI\Brain\brain_struct.sqf"] call struct_reinitialize;
	{
		private _mob = _x;
		[_mob,SPEED_MODE_WALK] call ai_setSpeed;
		private _mapdata = [callFunc(_mob,getPos),_mob] call ai_createAgent;
		setVar(_mob,__aiagent,_mapdata);
	} foreach ai_allMobs;
	
};

#endif
