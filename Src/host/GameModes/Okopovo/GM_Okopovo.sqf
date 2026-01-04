// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

editor_attribute("CodeOnyGamemode")
class(GMOkopovo) extends(GMBase)
	var(name,"Последний фронт");
	var(desc,"Противостояние Новой Армии и Истязателей");
	var(descExtended,"Позиционная война между Новой Армии и Истязателями.");
	
	var(duration,60 * 60 * 2);
	getter_func(isVoteSystemEnabled,false);
	getterconst_func(getProbability,90);
	getterconst_func(getReqPlayersMin,6);
	getterconst_func(getReqPlayersMax,30);

	getterconst_func(canPlayEvents,false);
	var(canAddAspect,false);

	var(unblockAllRoles,60*2); //через сколько откроются роли

		//данные режима
	//имя загружаемой карты
	getterconst_func(getMapName,"Okopovo");
	//имя лобби звука и картинка
	getterconst_func(getLobbySoundName,"lobby\Conflict.ogg");
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\tvtlobby.paa"));

	//Список ролей для этого режима. Массив строк. Инициализируется во время пикинга режима
	func(getLobbyRoles)
	{
		[
			"ROkopvoComIZ",
			"ROkopvoComNA"
		]
	};
	//Список лейт ролей. Массив строк. Инициализируется во время пикинга режима
	func(getLateRoles)
	{
		[
			"ROkopovoCombatSergantNA",
			"ROkopovoCombatSergantIZ"

			,"ROkopovoCombatRiflemanRoleNA"
			,"ROkopovoCombatRiflemanRoleIZ"
			,"ROkopovoCombatScoutRoleNA"
			,"ROkopovoCombatScoutRoleIZ"
			,"ROkopovoCombatTroopRoleNA"
			,"ROkopovoCombatTroopRoleIZ"
			,"ROkopovoCombatCookRoleNA"
			,"ROkopovoCombatCookRoleIZ"
			,"ROkopovoCombatHealerRoleNA"
			,"ROkopovoCombatHealerRoleIZ"
		]
	};

	//какие клиенты за какую сторону
	var(clientsInSide,createHashMap);

	//события режима

	//Условие старта раунда
	func(conditionToStart)
	{
		objParams();
		count getVar(("ROkopvoComIZ") call gm_getRoleObject,contenders_1) > 0
		&& count getVar(("ROkopvoComNA") call gm_getRoleObject,contenders_1) > 0
		
	};

	//Возвращает строку почему не вышло
	func(onFailReasonToStart)
	{
		objParams();
		"Нужен командир Новой Армии и Истязателей."
	};

	func(getUnsleepGameInfo)
	{
		objParams();
		[] //without unsleep info
	};

	func(preSetup)
	{
		objParams();

		#ifdef DEBUG
		setSelf(unblockAllRoles,5);
		#endif
	};
	

	func(onLightZoneOff)
	{
		objParams();
		callFuncParams("arealight" call getObjectByRef,setEnable,false);
		
		private _text = format["<t align='center' size='2'>Подача энергии нарушена. На поле боя становится всё темнее...</t>"];
		private _sound = "events\event_" + str randInt(1,5);
		private _pitch = rand(0.9,1.1);
		
		{
			callFuncParams(_x,playSound,_sound arg _pitch arg 1.15);
			callFuncParams(_x,localSay,_text arg "event");
		} foreach (cm_allClients);
		
	};
	func(onAcceptAllRoles)
	{
		objParams();
		[format["<t align='center'>Бойцы начинают распределяться по позициям...</t>"],"event"] call cm_sendOOSMessage;
		[format["<t size='3'>Роли командиров отрядов доступны!</t>"],"system"] call cm_sendLobbyMessage;
	};
	func(postSetup)
	{
		objParams();

		callSelfAfter(onAcceptAllRoles,getSelf(unblockAllRoles));

		//после исправления контейнеров действие не требуется
		// setVar("pipeiz" call getObjectByRef,countSlots,BASE_STORAGE_CAPACITY(15));
		// setVar("pipeiz" call getObjectByRef,maxSize,ITEM_SIZE_HUGE);
		// setVar("pipena" call getObjectByRef,countSlots,BASE_STORAGE_CAPACITY(15));
		// setVar("pipena" call getObjectByRef,maxSize,ITEM_SIZE_HUGE);

		//callFuncParams("arealight" call getObjectByRef,setEnable,true);

		for "_i" from 0 to (getSelf(duration) / (60*5)) - 1 do {
			callFuncParams("coniz" call getObjectByRef,addTask,"c_addmon" arg 150 arg (60*5)*_i+0.1);
			callFuncParams("conna" call getObjectByRef,addTask,"c_addmon" arg 150 arg (60*5)*_i+0.1);
		};
		
		_d = ["ROkopovoPaperDocs","izdocs" call getSpawnPosByName,null,false] call createItemInWorld;
		setVar(_d,name,"Карты лагерей");
		setVar(_d,type,"iz");
		getSelf(docsInSide) set ["iz",_d];
		_d = ["ROkopovoPaperDocs","nadocs" call getSpawnPosByName,null,false] call createItemInWorld;
		setVar(_d,name,"Секретные донесения");
		setVar(_d,type,"na");
		getSelf(docsInSide) set ["na",_d];

		_alg = {

			_leftUp = [4023.26,4049.75,8.93869];
			_rightDown = [4070.49,4079.42,8.77438];
			_z = 12.1789;

			for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
				for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
					if prob(40) then {
						["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
					};
				};
			};

			_leftUp = [4023.19,4007.66,8.63239];
			_rightDown = [4069.87,4023.5,8.8313];
			_z = 11.1789;

			for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
				for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
					if prob(40) then {
						["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
					};
				};
			};
		};
		#ifdef EDITOR
		debug_spawntraps = _alg;
		#else
		call _alg;
		#endif

		//generate bases
		callSelfParams(generateBasePos,"na");
		callSelfParams(generateBasePos,"iz");

		//generate task
		callSelf(generateTasks);

		_ca = [[4040.35,4040.52,8.988],40,33,9.629/*8.988*/,true];
		setSelf(creppyArea,_ca);
	};

	//По истечению опасной зоны выключается свет и становятся видны задачи
	#ifdef EDITOR
	var(creppyActive,30);
	#else
	var(creppyActive,60 * randInt(20,25) + randInt(1,60));
	#endif

	func(creppyAreaCheck)
	{
		objParams();
		if (gm_roundDuration >= getSelf(creppyActive)) exitWith {};
		//isMobInCreepy
		{
			if callSelfParams(isMobInCreepy,_x) then {
				if isNull(getVar(_x,__gmokopovo_creppyFlag)) then {
					private _m = pick[
						"Я НЕ ХОЧУ УМИРАТЬ!",
						"НАЗАД!",
						"Я НЕ ГОТОВ К ЭТОМУ...",
						"МНЕ ОЧЕНЬ СТРАШНО!",
						"ОНИ... УБЬЮТ МЕНЯ."
					];
					callFuncParams(_x,mindSay,setstyle(_m,style_redbig));
					callFuncParams(_x,playSoundLocal,"effects\tension5" arg getRandomPitchInRange(0.7,1.3));
				};
				setVar(_x,__gmokopovo_creppyFlag,true);
				modVar(_x,hunger, - 0.5);
				callFuncParams(_x,addStaminaLoss,2.5);
			} else {
				setVar(_x,__gmokopovo_creppyFlag,null);
			};
			true
		} count (
			(getSelf(mobsInSide) get "na")
			+ (getSelf(mobsInSide) get "iz")
		);
	};

	var(__tasksGetted,false);
	func(lightDisableCheck)
	{
		objParams();
		if getSelf(__tasksGetted) exitWith{};
		if (gm_roundDuration >= getSelf(creppyActive)) exitWith {
			setSelf(__tasksGetted,true);
			{
				_m = getSelfReflect("leader"+_x);
				_t = getSelf(tasks) get _x;
				_mes = format["<t size='1.8' color='#528736'>Поступила задача %3. %1: %2</t>",
					getVar(_t,name),
					getVar(_t,desc),
					ifcheck(_x=="na","из штаба","от Верхних")
				];
				callFuncParams(_m,mindSay,_mes);
				callFuncParams(_m,addMemory,_mes);

				callFuncParams(_m,playSoundLocal,"effects\tension8" arg getRandomPitchInRange(0.7,1.3));
			} foreach ["na","iz"];


			callSelfAfter(onLightZoneOff,60 * randInt(1,5));
		};
	};

	func(checkFinish)
	{
		objParams();
		callSelf(creppyAreaCheck);
		callSelf(lightDisableCheck);
		
		if (gm_roundDuration >= getSelf(duration)) exitWith {8080};
		if getVar(getSelf(leaderNA),isDead) exitWith {-6600};
		if getVar(getSelf(leaderIZ),isDead) exitWith {6600};
		_r = 0;
		if (getSelf(__tasksGetted)) then {
			{
				_r = callFunc(_x,canDone);
				if (_r != 0) exitWith {
					setVar(_x,result,_r);
				};
			}foreach(values getSelf(tasks));
		};

		_r
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		if(getSelf(finishResult) == 8080)exitWith{
			"<t size='1.5'>Стороны не успели выполнить свои задачи.</t>"
		}; 
		if(getSelf(finishResult) == 6600)exitWith{
			"<t size='1.5'>Победа Новой Армии! - Атаман Истязателей повержен.</t>"
		};
		if(getSelf(finishResult) == -6600)exitWith{
			"<t size='1.5'>Победа Истязателей! - Капитан Новой Армии погиб.</t>"
		};
		private _res = "Исход:";
		{
			private _r = callFunc(_x,getTextResult);
			if (_r != "---") then {
				modvar(_res) +sbr+ _r;
			};
		} foreach (values getSelf(tasks));

		"<t size='1.5'>"+_res+"</t>"
	};
	
	func(onFinish)
	{
		objParams();
		super();
	};

	var(creppyArea,null);

	var(mapArea,createHashMapFromArray [vec2("na",0) arg vec2("iz",0)]);
	var(mobsInSide,createHashMapFromArray [vec2("na",[]) arg vec2("iz",[])]);

	func(addMobInSide)
	{
		objParams_2(_mob,_side);
		(getSelf(mobsInSide) get _side)pushBackUnique _mob;
		//update lobby
	};

	func(removeMobInSide)
	{
		objParams_2(_mob,_side);
		array_remove(getSelf(mobsInSide) get _side,_mob);
		//update lobby
	};

	//squad options
	var(leaderNA,nullPtr);
	var(leaderIZ,nullPtr);
	var(sergantesInSide,createHashMapFromArray [vec2("na",[]) arg vec2("iz",[])]);
	var(maxSergantsPerTime,2); //сколько может быть одновременно живых сержантов-отрядов
	var(basenumNA,0);
	var(basenumIZ,0);

	var(deadSquads,createHashMapFromArray [vec2("na",[]) arg vec2("iz",[])]); //убитые сквады

	var(docsInSide,createHashMap);

	func(generateBasePos)
	{
		objParams_1(_side);
		private _pos = if (_side == "na") then {
			[4043.98,3968.92,0]
		} else {
			[4058.73,4122.17,8.766]
		};
		private _rect = if (_side == "na") then {
			[40,25]
		} else {
			[40,40]
		};
		private _dir = if(_side == "na") then {0} else {0};

		private _list = [];
		_list pushBack _pos;
		_list append _rect;
		_list pushBack _dir;
		_list pushBack true;

		getSelf(mapArea) set [_side,_list];
	};

	func(isMobInCreepy)
	{
		objParams_1(_mob);
		private _b = getSelf(creppyArea);
		if isNullVar(_b) exitwith {false};
		private _pos = callFunc(_mob,getPos);
		_pos inArea _b;
	};

	func(isMobInBase)
	{
		objParams_2(_mob,_baseName);
		private _b = getSelf(mapArea) get _baseName;
		if isNullVar(_b) exitwith {false};
		private _pos = callFunc(_mob,getPos);
		_pos inArea _b;
	};

	func(isItemInBase)
	{
		objParams_2(_item,_baseName);
		private _b = getSelf(mapArea) get _baseName;
		if isNullVar(_b) exitwith {false};
		private _pos = getPosATL callFunc(_item,getBasicLoc);
		_pos inArea _b;
	};

	func(getActiveMobsInSide)
	{
		objParams_1(_side);
		private _mlist = [];
		{
			if callFunc(_x,isActive) then {
				_mlist pushback _x;
			};
			true;
		} count (getSelf(mobsInSide) get _side);
		_mlist
	};

	var(tasks,createHashMap);

	func(generateTasks)
	{
		objParams();
		private _genericList = [
			"ROkopovoTaskGetDocs",
			"ROkopovoTaskGetCommander"
		];
		private _combatList = [
			"ROkopovoTaskCaptive",
			"ROkopovoTaskDefend"
		];

		{
			private _curcmb = pick _combatList;
			_combatList = _combatList - [_curcmb];
			private _curtasks = _genericList + _combatList;

			#ifdef DEBUG_TASK
			_curtasks = [DEBUG_TASKNAME];
			#endif

			private _obj = instantiate(pick _curtasks);
			getSelf(tasks) set [_x,_obj];
			callFuncParams(_obj,handleTask,_x);
		} foreach array_shuffle(["na" arg "iz"]);
	};

	//Получаем отряд для входа в него
	func(getOptimalSquad)
	{
		objParams_1(_side);
		private _list = getSelf(sergantesInSide) get _side;
		private _optimal = [];
		{
			if callFunc(_x,canAddNewMob) then {
				_optimal pushBack _x;
			};
		} foreach _list;
		if (count _optimal == 0) exitWith {nullPtr};
		pick _optimal
	};
	
endclass