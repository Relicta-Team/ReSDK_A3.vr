// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\WidgetSystem\widgets.hpp>

#define SC_SIZE_W 40
#define SC_SIZE_H 30
#define CD_MAX_COMMANDS_HISTORY_COUNT 100

cd_commandHistoryBuffer = [];

// #ifdef DEBUG
// for "_i" from 1 to 20 do {
// 	cd_commandHistoryBuffer pushBack ("command " + (str _i));
// };
// #endif

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
				cd_commandHistoryBuffer pushBack _data;

				rpcSendToServer("processClientCommand",_args);

				if (count cd_commandHistoryBuffer > CD_MAX_COMMANDS_HISTORY_COUNT) then {
					cd_commandHistoryBuffer deleteAt 0;	
				};
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

	//commands history
	_d setVariable ["_input",_input];
	_d displayAddEventHandler ["KeyDown",{
		_wid = _this select 0;
		_key = _this select 1;
		_locked = false;
		_input = _wid getvariable "_input";
		
		//fix lobby bypass logic
		if not_equals(focusedCtrl _wid,_input) exitwith {false};

		_bufidx = _input getvariable ["cmdhistidx",count cd_commandHistoryBuffer -1];
		if (_key == KEY_UP) then {
			DEC(_bufidx);
			_locked = true;
		};
		if (_key == KEY_DOWN) then {
			INC(_bufidx);
			_locked = true;
		};
		if (!_locked) exitwith {false};

		if (_bufidx >= 0 && _bufidx <= (count cd_commandHistoryBuffer-1)) then {
			_input ctrlsettext (cd_commandHistoryBuffer select _bufidx);
			_input setvariable ["cmdhistidx",_bufidx];
		};
		if (_locked) then {
			true
		} else {false};
	}];

	//list commands
	#ifdef EDITOR
	//TODO: fixme - in lobby ctg2 created on maingroup
	(_ctg call widgetGetPosition)params["_baseX","_baseY","_baseW","_baseH"];
	_ctg2 = [_d,WIDGETGROUP,[_baseX,_baseY+_baseH,_baseW,_baseY]] call createWidget;
	_input setvariable ["_searchCtg",_ctg2];
	_back = [_d,TEXT,WIDGET_FULLSIZE,_ctg2] call createWidget;
	_back setBackgroundColor [0.1,0.1,0.1,0.4];
	_ctg2 setvariable ["_back",_back];
	_input ctrlAddEventHandler ["KeyUp",{
		_b = _this select 0;
		_key = _this select 1;
		_moder = 0;
		if (_key == KEY_UP) then {
			_moder = -1;
		};
		if (_key == KEY_DOWN) then {
			_moder = 1;
		};
		_cur = _b getvariable ["curidx",0];

		_ctg2 = _b getvariable "_searchCtg";
		_back = _ctg2 getvariable "_back";
		_inputed = tolower (ctrlText _b) splitString " " joinString "";
		_text = [];
		{
			if (_inputed in _x) then {
				// _maxLen = selectMax ((keys cm_commands_map) apply {count _x});
				// _need = (_maxLen - count _x);
				// _spaces = ""; for "_i" from 1 to _need do {_spaces = _spaces + " "};
				_spaces = "        ";
				_text pushBack (format["<t color='#00AF64'>%1</t>%3%2",_x,sanitize(_y select 1),_spaces]);
			};
		} foreach cm_commands_map;

		_cur = _cur max 0 min (count _text - 1);
		_cur = _cur + _moder;
		_b setvariable ["curidx",_cur];
		if (count _text > 0) then {
			_text set [_cur,format["<t color='#00B00C'>%1</t>",sanitizeHTML(_text select _cur)]];
		};
		

		[_back,_text joinString sbr] call widgetSetText;
	}];
	#endif
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
