// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//votable component
gm_canVote = true;
	gm_votedMode = "";
	gm_votedClients = [];
	gm_voteMap = createHashMap;
	{
		gm_voteMap set [_x,0];
	} foreach gm_allowedModes;

gm_showVoteMessage = {
	params ["_client"];
	
	private _txt = "<t size='1.5'>Для голосования за следующий режим нажмите кнопку ""ГОЛОСОВАНИЕ!"" в меню ""Система""</t>";
	callFuncParams(_client,localSay,_txt arg "system");
	callFuncParams(_client,addSystemAction,"system" arg "system_votemode" arg "ГОЛОСОВАНИЕ!");
};

gm_getCanVoteCondition = {
	private _countLobbyClients = count (call cm_getAllClientsInLobby);
	private _output = _countLobbyClients <= ((count gm_votedClients)*70/100) && _countLobbyClients > 5;
	#ifdef EDITOR
	_output = count gm_votedClients > 0;
	#endif
	_output
};

gm_voteProcess = {
	private _canVote = call gm_getCanVoteCondition;
	
	if (_canVote) then {
		private _maxNum = 0;
		private _maxMode = "";
		private _listMaxModes = [];
		{
			if (_y > _maxNum) then {
				_maxNum = _y;
				//_maxMode = _x;
				_listMaxModes = [_x];
			} else {
				if (_y == _maxNum) then {_listMaxModes pushBack _x};
			};
		} foreach gm_voteMap;
		if (count _listMaxModes > 0) then {
			gm_votedMode = pick _listMaxModes;
		} else {
			gm_votedMode = gm_defaultMode;
		};
		// if (_maxNum == 0) exitWith {
		// 	_canVote = false;
		// 	false;
		// };
		_canVote = true;
	};
	_canVote
};

gm_tryVote = {
	params ["_client"];

	_handler = {
	#ifdef EDITOR
			["val is "+str _value] call chatPrint;
	#endif
		if (!gm_canVote) exitWith {
			callSelf(CloseMessageBox);
		};

		private _num = parseNumber _value;
		if (_num < 0 || _num >= count gm_allowedModes) exitWith {
			callFuncParams(this,localSay,"Неверное число.");
			callSelf(CloseMessageBox);
		};
		if array_exists(gm_votedClients,this) exitWith {
			callFuncParams(this,localSay,"Вы уже проголосовали.");
			callSelf(CloseMessageBox);
		};

		private _strMode = gm_allowedModes select _num;
		gm_votedClients pushBackUnique this;

		gm_voteMap set [_strMode,(gm_voteMap get _strMode) + 1];

		[format["<t size='1.2'>%1 голосует %2</t>",getVar(this,name),pick["фуфлыжно","кучеряво","куралесно","бибово","сюсяво"]],"system"] call cm_sendLobbyMessage;

		callSelf(CloseMessageBox);
	};
	_dat = ["Проголосуйте за режим:"];
	{
		_gobj = missionNamespace getVariable ["story_" + _x,nullPtr];
		if isNullReference(_gobj) then {continue};
		_dat pushBack (format["%2. %1|%3",getVar(_gobj,name),_forEachIndex + 1,_foreachIndex]);
	} foreach gm_allowedModes;
	
	callFuncParams(_client,ShowMessageBox,"Listbox" arg _dat arg _handler);
};