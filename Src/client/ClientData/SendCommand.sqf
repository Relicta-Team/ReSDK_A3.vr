// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\WidgetSystem\widgets.hpp>

#define SC_SIZE_W 40
#define SC_SIZE_H 30

//Открывает окно отправки сообщения на сервер
cd_openSendCommandWindow = {
	
	params [["_isLobbyContext",false]];
	
	private _d = if (_isLobbyContext) then {getDisplay} else {call displayOpen};
	private _ctg = [_d,WIDGETGROUP,[50 - (SC_SIZE_W / 2),50 - (SC_SIZE_H / 2),SC_SIZE_W,SC_SIZE_H]] call createWidget;
	
	if (_isLobbyContext) then {
		_d setVariable ["cd_sendCommand_isLobbyContext",true];
		_d setVariable ["cd_sendCommand_lobbyModeCtg",_ctg];
		[true] call lobby_sysSetEnable;
	} else {
		_d setVariable ["cd_sendCommand_isEnabled",true];
	};
	
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.01,0.7,0.15,0.6];

	//header
	private _text = [_d,TEXT,[0,0,100,20],_ctg] call createWidget;
	_text ctrlSetText "Введите своё сообщение";
	//input
	private _input = [_d,INPUT,[0,20,100,50],_ctg] call createWidget;
	//buttons
	private _send = [_d,BUTTON,[0,70,50,30],_ctg] call createWidget;
	_send ctrlSetText "Отправить";

	private _cancel = [_d,BUTTON,[50,70,50,30],_ctg] call createWidget;
	_cancel ctrlSetText "Отмена";

	//adding references
	_send setvariable ["input",_input];

	_send ctrlAddEventHandler ["MouseButtonUp",{
		params ["_send","_bt"];
		_input = _send getvariable ["input",widgetNull];

		if not_equals(_input,widgetNull) then {

			_data = ctrlText _input;
			if (count _data > 128) exitWith {
				warningformat("clientData::sendCommand::send() - Too much data length - %1",count _data);
			};	
			if (_data != "") then {
				_args = [_data,player];
				rpcSendToServer("processClientCommand",_args);
			};

		} else {
			error("Cant get data from input. Input is null reference");
		};

		nextFrame(cd_closeSendCommandWindow);
	}];

	_cancel ctrlAddEventHandler ["MouseButtonUp",{
		nextFrame(cd_closeSendCommandWindow);
	}];

	ctrlSetFocus _input;


};

cd_closeSendCommandWindow = {
	if (getDisplay getVariable ["cd_sendCommand_isLobbyContext",false]) exitWith {
		getDisplay setVariable ["cd_sendCommand_isLobbyContext",false];
		[getDisplay getVariable ["cd_sendCommand_lobbyModeCtg",widgetNull]] call deleteWidget;
		[false] call lobby_sysSetEnable;
	};	
	call displayClose;
};

cd_openAhelp = {
	if (["cd_openAhelp",5] call input_spamProtect) exitWith {
		["Подождите немного прежде чем заново попытаться открыть это окно","system"] call chatPrint; 
	};

	private _args = ["ahelp",player];
	rpcSendToServer("processClientCommand",_args);
};

_onLocalCmdCall = {
	params ["_cmd",["_args",0]];

	_cmdcode = (cd_commands_localCommandsList get _cmd);
	if isNullVar(_cmdcode) exitWith {
		errorformat("onCallbackClientCommand() - command %1 not found",_cmd);
	};

	_args call (_cmdcode select 0);

}; rpcAdd("onLocalCommandCalled",_onLocalCmdCall);

cd_commands_localCommandsList = createHashMap;

#define localCommand(name) _cd_map_dataCode = []; cd_commands_localCommandsList set [name,_cd_map_dataCode]; _cd_map_dataCode pushBack

#define arguments _args

/***************************************************************************************************
----------------------------------------------------------------------------------------------------
	Local client commands list:
----------------------------------------------------------------------------------------------------
***************************************************************************************************/
localCommand("exit")
{
	if (!isMultiplayer) exitWith {
		
	};
	rpcCall("clientDisconnect",null);
};

localCommand("escnative")
{
	input_internal_handleNativeEsc = (parseNumber arguments) > 0;
};

localCommand("debugvars")
{
	[(parseNumber arguments) > 0] call clistat_setLogVars;
};

localCommand("smd_reload")
{
	//todo
};

localCommand("flycam")
{
	["Init"] call BIS_fnc_camera;
};

localCommand("camswitch")
{
	_new = if (cd_cameraSetting == 0) then {1} else {0};
	[_new] call cam_setCameraSetting;
};


localCommand("grafon")
{
	_new = if (cd_videoSettings == 0) then {1} else {0};
	_new call cd_setVideoSettings;
};

localCommand("reloadvoice")
{
	
	if !isNull(vs_internal_reloadTimer) then {
		if (vs_internal_reloadTimer) exitWith {
			warning("localCommand::mapCmd<GameFunction>['reloadvoice'] - too fast calling command. Wait some time...");
		};	
		vs_canProcess = false;
		vs_internal_reloadTimer = true;
		invokeAfterDelay({vs_internal_reloadTimer = false; vs_canProcess = true},5);
	} else {
		vs_canProcess = false;
		vs_internal_reloadTimer = true;
		invokeAfterDelay({vs_internal_reloadTimer = false; vs_canProcess = true},5);
	};
};
