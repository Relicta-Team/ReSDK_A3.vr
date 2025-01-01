// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


lobby_sendToServerSetting = {
	params ["_settingName","_val"];
	rpcSendToServer("onClientChangeCharSetting",[_settingName arg _val arg clientOwner]);
};



/*
--------------------------------------------------------------------------------
				События при получении ответа от сервера
--------------------------------------------------------------------------------
*/

//Событие вызывается когда сервер подтвердил изменение настройки
_onCharSettingCallback = {
	params ["_setting","_value"];

	_wid = getMainCtg getVariable ["set" + _setting,widgetNull];
	if equals(_wid,widgetNull) exitWith {
		errorformat("Lobby::Events::onCharSettingCallback() - Cant find setting <%1>",_setting);
	};
	
	if (_setting find "role" != -1) then {
		
		_value = [_value,_wid getVariable 'roleIndex'];
	};
	
	lobby_charData setVariable [_setting,_value];
	
	[_wid,_value] call (_wid getVariable "onSetCode");
	
}; rpcAdd("onCharSettingCallback",_onCharSettingCallback);

//событие для открытия лобби
_openLobby = {
	private _settings = _this;
	_settings call lobbyOpen;
}; rpcAdd("openLobby",_openLobby);

//событие для закрытия лобби
_closeLobby = {
	call lobbyClose;
}; rpcAdd("closeLobby",_closeLobby);

_onMusicSetupLobby = {
	[lobby_isMusicEnabled] call lobby_handleMusic;
}; rpcAdd("onMusicSetupLobby",_onMusicSetupLobby);

//загружает клиенту все ролли.
_loadRoles = {
	private _roles = _this;
	
	//TODO если окно с ролями было открыто - перезагружаем их
	
	//smart sorting default roles
	_indCurrent = 0;
	_newRoles = [];
	for "_i" from 1 to count _roles do {
		{
			_x params ["_cls","_name","_desc","_ind"];
			if (_indCurrent == _ind) then {
				_newRoles pushBack _x;
				INC(_indCurrent);
			};
		} foreach _roles;
	};
	
	
	trace("Roles updated");
	
	lobby_roleList = _newRoles;
}; rpcAdd("loadRoles",_loadRoles);

/*
--------------------------------------------------------------------------------
				Менеджер системных категорий
--------------------------------------------------------------------------------
*/
_removeLobbySystemAction = {
	params ["_cat","_act"];
	//checking cat
	if !(_cat in lobby_sys_buttonActions_sortedList) exitWith {};
	
	_list = lobby_sys_buttonActions get _cat;
	_idx = _list findif {equals(_x select 1,_act)};
	if (_idx != -1) then {
		_list deleteAt _idx;
		
		if (!isLobbyOpen) exitWith {};
		
		if (lobby_sys_curActionCategory == _cat) then {
			[lobby_sys_curActionCategory] call lobby_sysLoadSettings;
		};
	};
	
};rpcAdd("removeLobbySystemAction",_removeLobbySystemAction);

_addLobbySystemAction = {
	params ["_cat","_act","_name"];
	//checking cat
	if !(_cat in lobby_sys_buttonActions_sortedList) exitWith {};
	if isNullVar(_name) exitWith {};
		
	_list = lobby_sys_buttonActions get _cat;
	_list pushBack [_name,_act];
	
	if (!isLobbyOpen) exitWith {};
	
	if (lobby_sys_curActionCategory == _cat) then {
		[lobby_sys_curActionCategory] call lobby_sysLoadSettings;
	};
	
};rpcAdd("addLobbySystemAction",_addLobbySystemAction);