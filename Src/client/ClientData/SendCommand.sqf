// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(ClientData,cd_)

#include <..\WidgetSystem\widgets.hpp>

macro_const(cd_SC_SIZE_W)
#define SC_SIZE_W 40
macro_const(cd_SC_SIZE_H)
#define SC_SIZE_H 30

macro_const(cd_MAX_COMMANDS_HISTORY_COUNT)
#define CD_MAX_COMMANDS_HISTORY_COUNT 100

decl(string[])
cd_commandHistoryBuffer = [];

#ifdef EDITOR
	if isNull(cd_commandHistoryBuffer) then {
		cd_commandHistoryBuffer = [];

		for "_i" from 1 to 20 do {
			cd_commandHistoryBuffer pushBack ("command " + (str _i));
		};
	};
#else
	cd_commandHistoryBuffer = [];
#endif

//Открывает окно отправки сообщения на сервер
decl(void(bool))
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
	_d setVariable ["_input_cmdhandler",_input];
	private _handle_rem = _d displayAddEventHandler ["KeyDown",{
		_wid = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_locked = false;
		_backjump = false; _changed = false;
		_input = _wid getvariable "_input_cmdhandler";
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
	_d setvariable ["_handle_rem_onpress",_handle_rem];

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

decl(void())
cd_closeSendCommandWindow = {
	if (getDisplay getVariable ["cd_sendCommand_isLobbyContext",false]) exitWith {

		private _handle_rem = getDisplay getvariable ["_handle_rem_onpress",-1];
		if (_handle_rem != -1) then {
			getDisplay displayRemoveEventHandler ["KeyDown",_handle_rem];
		};

		getDisplay setVariable ["cd_sendCommand_isLobbyContext",false];
		[getDisplay getVariable ["cd_sendCommand_lobbyModeCtg",widgetNull]] call deleteWidget;
		[false] call lobby_sysSetEnable;
	};	
	call displayClose;
};

decl(void())
cd_openAhelp = {
	#ifdef SP_MODE
		sp_checkInput("open_ahelp",[]);
	#endif

	if (["cd_openAhelp",5] call input_spamProtect) exitWith {
		["Подождите немного прежде чем заново попытаться открыть это окно","system"] call chatPrint; 
	};

	private _args = ["ahelp",player];
	rpcSendToServer("processClientCommand",_args);
};

decl(void(string;any))
cd_onLocalCmdCall = {
	params ["_cmd",["_args",0]];

	_cmdcode = (cd_commands_localCommandsList get _cmd);
	if isNullVar(_cmdcode) exitWith {
		errorformat("onCallbackClientCommand() - command %1 not found",_cmd);
	};
	cd_internal_cmd_thisArguments = _args;
	0 call (_cmdcode select 0);

}; rpcAdd("onLocalCommandCalled",cd_onLocalCmdCall);

decl(map<string;any>)
cd_commands_localCommandsList = createHashMap;

inline_macro
#define localCommand(name) _cd_map_dataCode = []; cd_commands_localCommandsList set [name,_cd_map_dataCode]; _cd_map_dataCode pushBack

macro_func(cd_localCmdGetArgs,any())
#define arguments cd_internal_cmd_thisArguments

decl(any) cd_internal_cmd_thisArguments = 0;

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

#ifdef DEBUG
decl(widget) cd_modelPosWidget = widgetNull;
decl(int) cd_modelPosUpdate = -1;
decl(string) cd_modelPosSelection = "";

decl(void())
cd_modelPosStop = {
	if (cd_modelPosUpdate != -1) then {stopUpdate(cd_modelPosUpdate)};
	cd_modelPosUpdate = -1;
	if !isNullReference(cd_modelPosWidget) then {[cd_modelPosWidget] call deleteWidget};
	cd_modelPosWidget = widgetNull;
};

decl(void())
cd_modelPosOnUpdate = {
	if (isNullReference(cd_modelPosWidget) || {isNullReference(player)}) exitWith {call cd_modelPosStop};
	private _hit = [] call interact_getIntersectData;
	_hit params ["_object","_point"];
	private _text = "Наведи центр экрана на поверхность объекта";
	if !isNullReference(_object) then {
		private _face = _object getVariable ["ngo_src",_object];
		private _owner = _face getVariable ["doorLockOwner",objNull];
		if !isNullReference(_owner) then {
			private _formatVector = {"[" + ((_this apply {_x toFixed 4}) joinString ", ") + "]"};
			private _facePos = (getPosWorldVisual _face) call _formatVector;
			private _faceDir = (vectorDirVisual _face) call _formatVector;
			private _faceUp = (vectorUpVisual _face) call _formatVector;
			private _ownerPos = (getPosWorldVisual _owner) call _formatVector;
			private _ownerDir = (vectorDirVisual _owner) call _formatVector;
			private _ownerUp = (vectorUpVisual _owner) call _formatVector;
			_text = format["lock face snapshot<br/>faceWorldPos = %1<br/>faceWorldDir = %2<br/>faceWorldUp = %3<br/>ownerWorldPos = %4<br/>ownerWorldDir = %5<br/>ownerWorldUp = %6<br/>Repeat during closed/moving/open states" arg _facePos arg _faceDir arg _faceUp arg _ownerPos arg _ownerDir arg _ownerUp];
		} else {
			private _selection = cd_modelPosSelection;
			private _modelPoint = _object worldToModel _point;
			private _formatVector = {"[" + ((_this apply {_x toFixed 4}) joinString ", ") + "]"};
			_text = format["%1<br/>modelPosition = %2",(getModelInfo _object) select 0,_modelPoint call _formatVector];
			private _installed = _object getVariable ["doorLockVisualData",[]];
			if (count _installed > 0) then {
				_text = _text + format["<br/>installedPosition = %1<br/>installedSelection = '%2'",(_installed select 2) call _formatVector,_installed select 3];
			};
			if (_selection == "" || {_selection in selectionNames _object}) then {
				private _offset = _modelPoint;
				if (_selection != "") then {_offset = _offset vectorDiff (_object selectionPosition _selection)};
				_text = _text + format["<br/>candidateSelection = '%1'<br/>candidatePosition = %2",_selection,_offset call _formatVector];
			} else {
				_text = _text + "<br/>У этой модели нет указанного селекта";
			};
		};
	};
	[cd_modelPosWidget,"<t align='center'>" + _text + "<br/>modelpos off — выключить</t>"] call widgetSetText;
};

localCommand("modelpos")
{
	call cd_modelPosStop;
	if (arguments == "off") exitWith {};
	cd_modelPosSelection = arguments;
	cd_modelPosWidget = [getGUI,TEXT,[25,54,50,18]] call createWidget;
	cd_modelPosWidget setBackgroundColor (["back"] call ct_getValue);
	call cd_modelPosOnUpdate;
	if !isNullReference(cd_modelPosWidget) then {
		cd_modelPosUpdate = startUpdate(cd_modelPosOnUpdate,0.05);
	};
};

#endif

decl(mesh) cd_geomBoundsObject = objNull;
decl(string) cd_geomBoundsLod = "Geometry";
decl(vector4) cd_geomBoundsColor = [0,1,0,1];
decl(int) cd_geomBoundsUpdate = -1;

decl(void())
cd_geomBoundsStop = {
	if (cd_geomBoundsUpdate != -1) then {stopUpdate(cd_geomBoundsUpdate)};
	cd_geomBoundsUpdate = -1;
	cd_geomBoundsObject = objNull;
};

decl(void())
cd_geomBoundsOnUpdate = {
	updateParams();
	if isNullReference(cd_geomBoundsObject) exitWith {call cd_geomBoundsStop};
	private _bounds = ifcheck(cd_geomBoundsLod == "",boundingBoxReal cd_geomBoundsObject,boundingBoxReal [cd_geomBoundsObject,cd_geomBoundsLod]);
	[cd_geomBoundsObject,cd_geomBoundsColor,3,_bounds] call debug_drawBoundingBox;
};

localCommand("geombounds")
{
	private _modeName = tolower arguments;
	if (_modeName == "") then {_modeName = "geometry"};
	call cd_geomBoundsStop;
	if (_modeName == "off") exitWith {["geombounds: отображение выключено.","system"] call chatPrint};
	private _modes = createHashMapFromArray [
		["geometry",["Geometry",[0,1,0,1],"Geometry"]],
		["view",["ViewGeometry",[0,0.6,1,1],"ViewGeometry"]],
		["fire",["FireGeometry",[1,0.2,0.2,1],"FireGeometry"]],
		["visual",["",[1,0.8,0,1],"visual model"]]
	];
	private _config = _modes getOrDefault [_modeName,[]];
	if (count _config == 0) exitWith {["geombounds geometry|view|fire|visual|off. Рисуется только model-space bounding box выбранного LOD, не полигоны и не wireframe.","system"] call chatPrint};
	private _hit = [] call interact_getIntersectData;
	private _object = _hit param [0,objNull];
	if isNullReference(_object) exitWith {["geombounds: наведите центр экрана на объект.","system"] call chatPrint};
	_object = _object getVariable ["ngo_src",_object];
	_config params ["_lod","_color","_label"];
	cd_geomBoundsObject = _object;
	cd_geomBoundsLod = _lod;
	cd_geomBoundsColor = _color;
	cd_geomBoundsUpdate = startUpdate(cd_geomBoundsOnUpdate,0);
	private _modelName = (getModelInfo _object) select 0;
	private _bounds = ifcheck(_lod == "",boundingBoxReal _object,boundingBoxReal [_object,_lod]);
	[format["geombounds: %1, объект %2, bounds=%3. Это model-space bounding box LOD, не collision-полигоны и не wireframe; geombounds off — выключить." arg _label arg _modelName arg _bounds],"system"] call chatPrint;
};

localCommand("debugvars")
{
	[(parseNumber arguments) > 0] call clistat_setLogVars;
};

localCommand("debugvoice")
{
	[(parseNumber arguments) > 0] call vs_setDiagnosticMenuVisible;
};

localCommand("ping")
{
	[[diag_tickTime],{

		[[_this select 0],{
			private _rtime = diag_tickTime - (_this select 0);
			[format["Время ответа (in+out): %1 мс",_rtime *1000],"log"] call chatPrint;
		}]
		remoteExecCall ["call",remoteExecutedOwner]

	}] remoteExecCall ["call",2]
};

#ifdef EDITOR
localCommand("lightdebug")
{
	[parseNumber arguments != 0] call lesc_setDebugRender;
};
#endif

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
	if (vs_useReVoice) then {
		if (isLobbyOpen) exitWith {
			["Перезапуск войса в лобби невозможен","system"] call chatPrint;
		};
		
		if isNull(vs_internal_reloadVoiceNew) then {
			vs_internal_reloadVoiceNew = true;
			if (call vs_isConnectedVoice) then {
				["Остановка войса...","system"] call chatPrint;
				call vs_disconnectVoiceSystem;
			};
			private _code = {
				["Подключение войса...","system"] call chatPrint;
				if (call vs_connectToVoiceSystem) then {
					["Войс подключен!...","system"] call chatPrint;
				} else {
					["Ошибка подключения войса. Попробуйте снова или перезапустите игру","system"] call chatPrint;
				};
				vs_internal_reloadVoiceNew = null;
			}; invokeAfterDelay(_code,2);
		};
	} else {
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
	
};

localCommand("setvoipvol") 
{
	["В настройках Реликты (раздел Игра) вы можете более удобно настроить эту опцию","system"] call chatPrint;
	_new = parseNumber arguments;
	if ([_new] call vs_setMasterVoiceVolume) then {
		vs_voipVolCurrent = _new;
		profileNamespace setVariable ["rel_voipvol",_new];
		saveProfileNamespace;
	};
};

localCommand("disablecolorcorrection")
{
	if isNullVar(cd_colorCorrection_disabled) then {
		cd_colorCorrection_disabled = false;
	};
	
	cd_colorCorrection_disabled = !cd_colorCorrection_disabled;
	
	["color_default",!cd_colorCorrection_disabled] call pp_setEnable;
	
	private _msg = if (cd_colorCorrection_disabled) then {
		"Цветокоррекция отключена"
	} else {
		"Цветокоррекция включена"
	};
	[_msg,"system"] call chatPrint;
};
