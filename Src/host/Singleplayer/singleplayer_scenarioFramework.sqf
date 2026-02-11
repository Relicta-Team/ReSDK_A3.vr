// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_map_scenario = createHashMap;

sp_loadedScenarios = [];
sp_lastStartedScene = "";

//client object
sp_clientInstance = nullPtr;


sp_loadScenario = {
	params ["_name"];
	if !([_name,".sqf"] call stringEndWith) then {
		modvar(_name) + ".sqf";
	};

	loadFile("src\host\Singleplayer\Scenarios\"+_name);
	sp_loadedScenarios pushBack _name;
};

sp_startScene = {
	params ["_name",["_doTeleport",false]];
	if (canSuspend) exitWith {
		ISNIL {_this call sp_startScene}	
	};

	call (sp_internal_map_scenes getOrDefault [_name,{
		errorformat("Scene not found - %1",_name);
	}]);
	traceformat("Scene started: %1",_name)
	sp_lastStartedScene = _name;
	if (_doTeleport) then {
		{
			if equals(getVar(_x,triggerName),_name) exitWith {
				[callFunc(_x,getPos),callFunc(_x,getDir)] call sp_setPlayerPos;
			};
		} foreach sp_gc_internal_listTriggers;
	};
};

sp_internal_map_scenes = createHashMap;
//Добавление сцены. Если в мире есть триггер с таким же названием, либо объект - то при системном запуске персонажа телепортирует в сцену
sp_addScene = {
	params ["_name","_code"];
	sp_internal_map_scenes set [_name,_code];
};

//triggerzone works
sp_addTriggerEnter = {
	params ["_name","_code"];
	sp_internal_map_scenes set [_name + "__onEnter",_code];
};

sp_addTriggerExit = {
	params ["_name","_code"];
	sp_internal_map_scenes set [_name + "__onExit",_code];
};

sp_callTriggerEvent = {
	params ["_name",["_isEnter",true]];
	private _postfix = ifcheck(_isEnter,"__onEnter","__onExit");
	call (sp_internal_map_scenes getOrDefault [_name + _postfix, {}])
};



sp_preloadScenarioEnvironment = {
	//disable saving in spmode
	enableSaving false;

	private _persetupCode = {
		setNight = { _dateToSync = [1985,5,20,0,00];setDate _dateToSync; };
		call setNight;call setNight;[] spawn setNight;
		si_internal_rayObject hideObject true;

		//setup client
		private _cli = newParams(ServerClient,[0 arg "12345"]);
		sp_clientInstance = _cli;
		setVar(_cli,name,"UserSP");
		setVar(_cli,access,["ACCESS_OWNERS"] call cm_accessTypeToNum);
		
		//[callFunc(_cli,getOwner),"openLobby",callFunc(_cli,collectClientSettings)] call server_sendtoclient;
	};
	invokeAfterDelay(_persetupCode,0.01);


	private _startupMode = "GMSp_game";
	private _codeOnMode = {
		["processClientCommand" arg vec2("setmode "+ _this ,player)] call client_sendToServer;
		sp_gc_internal_listTriggers = ["Struct_SPTrigger",false] call getAllObjectsInWorldTypeOf;
	};
	invokeAfterDelayParams(_codeOnMode,0.2,_startupMode);
	

	private _startupRole = "GMSp_game_BasicRole";
	invokeAfterDelayParams({ ["onClientChangeCharSetting" arg ["role1" arg _this arg 0]] call client_sendToServer },0.3,_startupRole);
	invokeAfterDelay({ ["onClientPrepareToPlay" arg [true arg 0]] call client_sendToServer},0.3);
	
	//auto start game
	_starting = {
		sp_gc_internal_listTriggers = ["Struct_SPTrigger",false] call getAllObjectsInWorldTypeOf;
		sp_gc_internal_listTriggersZones = ["Struct_SPZoneTrigger",false] call getAllObjectsInWorldTypeOf;
		["processClientCommand" arg vec2("startgame",player)] call client_sendToServer;
	};
	invokeAfterDelay(_starting,0.4);
	invokeAfterDelay({["Загрузка..."] call chat_clearBuffer;},0.41);
	
};

//cleanup all scene data
sp_cleanupSceneData = {
	//first - stop all threads
	call sp_threadStopAll;

	call sp_clearPlayerHandlers;

	call sp_gui_resetInventoryVisibleHandlers;

	call sp_cleanupWidgetHighlightTokens;
	
	//now delete all mobs
	call sp_ai_deleteAllPersons;
};

sp_onChapterDone = {
	params ["_chapId"];
	{
		private _chapList = profilenamespace getvariable ["rel_spdone",[]];
		//check base type
		if not_equalTypes(_chapList,[]) then {
			_chapList = [];
		};
		//check count
		if (count _chapList > 6) then {
			_chapList = [];
		};
		//check values
		{
			if not_equalTypes(_x,0) then {
				_chapList = [];
			}
		} foreach _chapList;

		for "_i" from 0 to _chapId do {
			_chapList pushBackUnique _i;
		};

		profilenamespace setvariable ["rel_spdone",_chapList];
		saveProfileNamespace;

	} call sp_threadCriticalSection;
};

sp_saveCharacterData = {
	params [["_t",call sp_getActor],["_data",null]];

	if (isNullVar(_data)) then {
		_data = [
			callFunc(_t,getFirstName),
			callFunc(_t,getLastName),
			callFunc(_t,getFace)
		];
	};

	profilenamespace setvariable ["rel_spchardata",_data];
	saveProfileNamespace;
};

sp_loadCharacterData = {
	params [["_t",call sp_getActor]];
	private _data = profilenamespace getvariable ["rel_spchardata",[]];
	
	if not_equalTypes(_data,[]) exitWith {};
	if (count _data != 3) exitWith {};

	_data params ["_fn","_ln","_face"];
	if (isNullVar(_fn) || isNullVar(_ln) || isNullVar(_face)) exitWith {};
	if (not_equalTypes(_fn,"") || not_equalTypes(_ln,"") || not_equalTypes(_face,"")) exitWith {};

	callFuncParams(_t,generateNaming,capitalize(_fn) arg capitalize(_ln));
	if (_face call facesys_hasFace) then {
		callFuncParams(_t,setMobFace,_face);
	};
};