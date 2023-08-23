// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\WidgetSystem\widgets.hpp>

#define SC_SIZE_W 40
#define SC_SIZE_H 30
#define CD_MAX_COMMANDS_HISTORY_COUNT 100

cd_commandHistoryBuffer = [];

#ifdef DEBUG
for "_i" from 1 to 20 do {
	cd_commandHistoryBuffer pushBack ("command " + (str _i));
};
#endif

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
	_text ctrlSetText "Введите своё сообщение. Enter - отправить. Стрелки - листать историю"
	#ifdef EDITOR
	+ "; Стрелки с Shift - выбор подсказки команды, Tab - ввод команды из подсказки."
	#endif
	;
	//input
	private _input = [_d,INPUT,[0,20,100,50],_ctg] call createWidget;
	//buttons
	private _send = [_d,BUTTON,[0,70,50,30],_ctg] call createWidget;
	_send ctrlSetText "Отправить";

	private _cancel = [_d,BUTTON,[50,70,50,30],_ctg] call createWidget;
	_cancel ctrlSetText "Отмена";

	//adding references
	_send setvariable ["input",_input];
	_input setvariable ["send",_send];
	_send ctrlAddEventHandler ["MouseButtonUp",{
		_this call ((_this select 0) getvariable "eventPress");
	}];
	_send setvariable ["eventPress",{
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
		_shift = _this select 2;
		_locked = false;
		_backjump = false; _changed = false;
		_input = _wid getvariable "_input";
		_send = _input getvariable "send";
		_selectedCmd = _input getvariable ["selectedCmd",""];
		
		//fix lobby bypass logic
		if not_equals(focusedCtrl _wid,_input) exitwith {false};

		_bufidx = _input getvariable ["cmdhistidx",count cd_commandHistoryBuffer];
		if (_key == KEY_UP) then {
			if (!_shift) then {
				DEC(_bufidx);
				_backjump = true;
				_changed = true;
			};
			_locked = true;
			
		};
		if (_key == KEY_DOWN) then {
			if (!_shift) then {
				INC(_bufidx);
				_changed = true;
			};
			_locked = true;
		};
		if (_key == KEY_TAB && _selectedCmd != "") then {
			_locked = true;
			_input ctrlsettext _selectedCmd;
			//override last cmd in buffer
			_input setvariable ["cmdhistidx",count cd_commandHistoryBuffer];
			_input setvariable ["cachedlastcmd",ctrltext _input];
			forceunicode 0;
			_input ctrlsetTextSelection [count (ctrltext _input),0];
		};
		if (_key == KEY_RETURN) exitwith {
			[_send,0] call (_send getvariable "eventPress");
		};

		
		traceformat("bufindex %1; lastidxcmd: %2",_bufidx arg count cd_commandHistoryBuffer-1);
		if (_bufidx >= 0 && _bufidx <= (count cd_commandHistoryBuffer) && _changed) then {
			//if out of range
			if (_bufidx == count cd_commandHistoryBuffer) then {
				_input ctrlsettext (_input getvariable ["cachedlastcmd",ctrltext _input]);	
			} else {
				//if last command
				if (_bufidx == count cd_commandHistoryBuffer-1 && _backjump) then {
					_input setvariable ["cachedlastcmd",ctrltext _input];
				}
			};
			_input ctrlsettext (cd_commandHistoryBuffer select _bufidx);
			_input setvariable ["cmdhistidx",_bufidx];

			forceunicode 0;
			_input ctrlsetTextSelection [count (ctrltext _input),0];
		};
		

		_codeIn = (_input getvariable ["KeyUp_handlecmdload",{}]);
		_args = [_codeIn,[_input,_key,_shift]];
		_code = {
			_this params ["_code","_args"];
			if isNullReference(_args select 0) exitwith {};
			_args call _code;
		};
		nextFrameParams(_code,_args);

		if (_locked) then {
			trace("locked finalized");
			true
		} else {trace("nonlocked finalized"); false};
	}];

	//list commands
	#ifdef EDITOR

	(_ctg call widgetGetPosition)params["_baseX","_baseY","_baseW","_baseH"];
	private _ctg2 = [_d,WIDGETGROUP_H,[_baseX,_baseY+_baseH,_baseW,_baseY]] call createWidget;
	if (isLobbyOpen) then {
		startAsyncInvoke
			{params ["_ctg"]; isNullReference(_ctg)},
			{params ["","_ctg2"]; [_ctg2,true] call deleteWidget},
			[_ctg,_ctg2]
		endAsyncInvoke
	};


	_input setvariable ["_searchCtg",_ctg2];
	_back = [_d,TEXT,[0,0,100,0],_ctg2] call createWidget;
	_back setBackgroundColor [0.1,0.1,0.1,0.4];
	_ctg2 setvariable ["_back",_back];
	_input setvariable ["KeyUp_handlecmdload",{
		_b = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_moder = 0;
		if (_key == KEY_UP && _shift) then {
			_moder = -1;
		};
		if (_key == KEY_DOWN && _shift) then {
			_moder = 1;
		};
		_cur = _b getvariable ["curidx",0];

		_ctg2 = _b getvariable "_searchCtg";
		_back = _ctg2 getvariable "_back";
		_inputed = tolower (ctrlText _b) splitString " " joinString "";
		_text = []; _cmdlist = [];
		{
			if (_inputed in _x) then {
				// _maxLen = selectMax ((keys cm_commands_map) apply {count _x});
				// _need = (_maxLen - count _x);
				// _spaces = ""; for "_i" from 1 to _need do {_spaces = _spaces + " "};
				_spaces = "        ";
				_text pushBack (format["<t color='#00AF64'>%1</t>%3%2",_x,sanitize(_y select 1),_spaces]);
				_cmdlist pushBack _x;
			};
		} foreach cm_commands_map;

		_cur = _cur + _moder;
		_cur = _cur max 0 min (count _text - 1);
		_needUpdateScroll = false;
		_b setvariable ["curidx",_cur];
		if (count _text > 0) then {
			_text set [_cur,format["<t color='#00B00C'>%1</t>",sanitizeHTML(_text select _cur)]];
			_b setvariable ["selectedCmd",_cmdlist select _cur];
			_needUpdateScroll = true;
		} else {
			_b setvariable ["selectedCmd",""];
		};
		

		[_back,_text joinString sbr] call widgetSetText;
		_h = _back call widgetGetTextHeight;
		[_back,[0,0,100,_h]] call widgetSetPosition;

		//! this dosent work... fuck BIS
		// if (_needUpdateScroll) then {
		// 	//update scroll
		// 	_val = linearConversion [0,count _cmdlist-1,_cur,0,1];
		// 	_ctg ctrlSetScrollValues [_val, _val];
		// 	traceformat("Scollupdate:%1 %2 %3 %4",_ctg2 arg _val arg ctrlScrollValues _ctg2 arg (allcontrols _ctg2) apply {ctrlclassname _x});
		// 	_ctg2 ctrlCommit 0;
		// };
	}];

	#endif
	//endif EDITOR
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
