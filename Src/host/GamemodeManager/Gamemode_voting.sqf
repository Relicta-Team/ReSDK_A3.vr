// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//votable component
gm_canVote = true;
	gm_votedMode = "";
	gm_votedClients = [];
	gm_votableModes = [];
	gm_voteMap = createHashMap;
	{
		private _modObj = _x call gm_getGameModeObject;
		if isNullReference(_modObj) then {continue};
		if !callFunc(_modObj,isVotable) then {continue};
		if !callFunc(_modObj,isPlayableGamemode) then {continue};

		gm_voteMap set [_x,0];
		gm_votableModes pushBack _x;
	} foreach gm_allowedModes;

gm_showVoteMessage = {
	params ["_client"];
	
	private _txt = "<t size='1.5'>Для голосования за следующий режим нажмите кнопку ""ГОЛОСОВАНИЕ!"" в меню ""Система""</t>";
	callFuncParams(_client,localSay,_txt arg "system");
	callFuncParams(_client,addSystemAction,"system" arg "system_votemode" arg "ГОЛОСОВАНИЕ!");
};

gm_getCanVoteCondition = {
	private _countLobbyClients = count (call cm_getAllClientsInLobby);
	if (_countLobbyClients <= 3) exitWith {false}; 
	private _output = (count gm_votedClients) >= (_countLobbyClients * 0.6) && _countLobbyClients >= 4;
	#ifdef EDITOR
	_output = count gm_votedClients > 0;
	#endif
	_output
};

//удаляет голос клиента из голосования
gm_voteOnClientDisconnected = {
	params ["_client"];
	if !array_exists(gm_votedClients,_client) exitWith {};
	gm_votedClients deleteAt (gm_votedClients find _client);
	private _mode = getVar(_client,prestartVotedTo);
	if array_exists(gm_votableModes,_mode) then {
		gm_voteMap set [_mode,((gm_voteMap get _mode) - 1) max 0];
	};
	setVar(_client,prestartVotedTo,"");
};

//обработка голосования
gm_voteProcess = {
	//голосование начнет проверяться только за 3 минуты до конца таймера
	if (gm_lobbyTimeLeft > (60*3)) exitWith {false};
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
			private _listWeights = [];
			{
				_listWeights pushback _x;
				_listWeights pushback (callFunc(_x call gm_getGameModeObject,getVotePriority));
			} foreach _listMaxModes;
			gm_votedMode = selectRandomWeighted _listWeights;
		} else {
			private _listWeights = [];
			{
				_listWeights pushback _x;
				_listWeights pushback (callFunc(_x call gm_getGameModeObject,getVotePriority));
			} foreach gm_votableModes;
			gm_votedMode = selectRandomWeighted _listWeights;
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
		if (_num < 0 || _num >= count gm_votableModes) exitWith {
			callFuncParams(this,localSay,"Неверное число.");
			callSelf(CloseMessageBox);
		};
		if array_exists(gm_votedClients,this) exitWith {
			private _curMode = getVar(this,prestartVotedTo);
			if array_exists(gm_votableModes,_curMode) then {
				//remove vote from old
				gm_voteMap set [_curMode,((gm_voteMap get _curMode) - 1) max 0];
				
				private _newMode = gm_votableModes select _num;
				setVar(this,prestartVotedTo,_newMode);
				gm_voteMap set [_newMode,(gm_voteMap get _newMode) + 1];
			};
			callSelf(CloseMessageBox);
		};

		private _strMode = gm_votableModes select _num;
		gm_votedClients pushBackUnique this;

		gm_voteMap set [_strMode,(gm_voteMap get _strMode) + 1];
		setVar(this,prestartVotedTo,_strMode);

		[format["<t size='1.2'>%1 голосует %2</t>",getVar(this,name),pick["фуфлыжно","кучеряво","куралесно","бибово","сюсяво"]],"system"] call cm_sendLobbyMessage;

		callSelf(CloseMessageBox);
	};
	_dat = ["Проголосуйте за режим:"];
	private _id = 1;
	{
		_gobj = _x call gm_getGameModeObject;
		_dat pushBack (format["%2. %1|%3",getVar(_gobj,name),_id,_foreachIndex]);
		INC(_id);
	} foreach gm_votableModes;
	
	callFuncParams(_client,ShowMessageBox,"Listbox" arg _dat arg _handler);
};