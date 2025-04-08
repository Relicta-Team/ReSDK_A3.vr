// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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
	invokeAfterDelay({["processClientCommand" arg vec2("startgame",player)] call client_sendToServer},0.4);
	invokeAfterDelay({["Загрузка..."] call chat_clearBuffer;},0.41);
	
};