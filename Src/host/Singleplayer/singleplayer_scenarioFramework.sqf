// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_list_scenario = [];
//todo load logic
sp_loadScenario = {
	params ["_path"];
	//loadFile(_path)
};

sp_clientInstance = nullPtr;

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
	invokeAfterDelayParams({["processClientCommand" arg vec2("setmode "+ _this ,player)] call client_sendToServer},0.2,_startupMode);
	

	private _startupRole = "GMSp_game_BasicRole";
	invokeAfterDelayParams({ ["onClientChangeCharSetting" arg ["role1" arg _this arg 0]] call client_sendToServer },0.3,_startupRole);
	invokeAfterDelay({ ["onClientPrepareToPlay" arg [true arg 0]] call client_sendToServer},0.3);
	
	//auto start game
	invokeAfterDelay({["processClientCommand" arg vec2("startgame",player)] call client_sendToServer},0.4);
	invokeAfterDelay({["Загрузка..."] call chat_clearBuffer;},0.41);
	
};