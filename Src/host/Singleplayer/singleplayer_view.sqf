// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"

sp_gui_taskWidgets = [];
sp_gui_notificationWidgets = [];
sp_gui_borders = [];

sp_gui_borderSize = 10;
sp_gui_notificationSizeW = 40;
sp_gui_notificationSizeH = 70;

sp_gui_taskMessageWidth = 25;

sp_internal_lastNotification = "";

if !isNull(sp_gui_pphndl_chromabb) then {
	ppEffectDestroy sp_gui_pphndl_chromabb;
};
sp_gui_pphndl_chromabb = ppEffectCreate ["ChromAberration", 10000];
if !isNull(sp_gui_pphndl_clrinvers) then {
	ppEffectDestroy sp_gui_pphndl_clrinvers;
};
sp_gui_pphndl_clrinvers = ppEffectCreate ["ColorInversion", 10001];

sp_gui_pphndl_chromabb ppEffectEnable true;
sp_gui_pphndl_clrinvers ppEffectEnable true;

sp_gui_internal_handlePPUpdate = -1;

sp_isGUIInit = false;
sp_initGUI = {
	if not_equals(sp_gui_internal_handlePPUpdate,-1) then {
		stopUpdate(sp_gui_internal_handlePPUpdate);
	};

	sp_gui_internal_handlePPUpdate = startUpdate(sp_gui_internal_onUpdatePPGUI,0.1);

	if (count sp_gui_taskWidgets > 0) exitWith {};
	private _d = getGUI;
	private _ctg = [_d,WIDGETGROUP,[100-sp_gui_taskMessageWidth,2,sp_gui_taskMessageWidth,15]] call createWidget;
	private _b = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_b setBackgroundColor [0.2,0.2,0.2,0.3];
	private _t = [_d,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	sp_gui_taskWidgets = [_ctg,_b,_t];

	sp_int_taskTextOrigPos = _ctg call widgetGetPosition;
	_ctg setFade 1;
	_ctg commit 0;

	_ctg ctrlAddEventHandler ["Committed",{
		params ["_control", "_animType", "_animTime"];
		if (_animType == "alpha") then {
			if !isNull(sp_int_nextTaskTextParams) then {
				sp_int_nextTaskTextParams call sp_setTaskMessage;
				sp_int_nextTaskTextParams = null;
				[false] call sp_setHideTaskMessageCtg;
			};
		};
	}];

	//notif
	_ctg = [_d,WIDGETGROUP,
		[
			50-(sp_gui_notificationSizeW/2),
			2,
			sp_gui_notificationSizeW,sp_gui_notificationSizeH
		]
	] call createWidget;

	_backpulse = [_d,BACKGROUND,[0,0,0,0]] call createWidget;
	_t = [_d,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	_t setBackgroundColor [0.2,0.2,0.2,0.3];
	_t setvariable ["orig_color",[0.2,0.2,0.2,0.3]];
	sp_gui_notificationWidgets = [_ctg,_t,_backpulse];
	_ctg setFade 1;
	_ctg commit 0;

	//---- borders ----
	_b = [_d,BACKGROUND,[0,0,100,sp_gui_borderSize]] call createWidget;
	_b setBackgroundColor [0,0,0,1];
	sp_gui_borders pushBack _b;

	_b = [_d,BACKGROUND,[0,100-sp_gui_borderSize,100,sp_gui_borderSize]] call createWidget;
	_b setBackgroundColor [0,0,0,1];
	sp_gui_borders pushBack _b;

	[false,0] call sp_view_setBordersVisible;

	//disable native panels
	(cd_vv_widgets select 0) ctrlShow false;
	if !isNull(cli_mem_widgets) then {
		(cli_mem_widgets select 0) ctrlShow false;
	};

	sp_isGUIInit = true;
};

sp_view_setBordersVisible = {
	params ["_mode",["_time",0]];
	{
		if (_mode) then {
			_x setFade 0;
			_x commit _time;
		} else {
			_x setFade 1;
			_x commit _time;
		}
	} foreach sp_gui_borders;
};

sp_int_taskTextOrigPos = vec4(0,0,0,0);

sp_int_getTaskCtgWidget = { sp_gui_taskWidgets select 0 };
sp_int_getTaskBackgroundWidget = { sp_gui_taskWidgets select 1 };
sp_int_getTaskTextWidget = { sp_gui_taskWidgets select 2 };

sp_int_getNotificationWidgetCtg = { sp_gui_notificationWidgets select 0 };
sp_int_getNotificationWidget = { sp_gui_notificationWidgets select 1 };
sp_int_getNotificationBackPulseWidget = { sp_gui_notificationWidgets select 2 };

sp_setTaskMessage = {
	params ["_header",["_desc",""]];
	if (!sp_isGUIInit) exitWith {};
	private _txt = format["%2<t size='1.5'>%1</t>%2<t>%3</t>%2 ",_header,sbr,_desc];

	private _tWid = call sp_int_getTaskTextWidget;
	private _back = call sp_int_getTaskBackgroundWidget;
	[_tWid,_txt] call widgetSetText;
	private _tH = ctrlTextHeight _tWid;
	{
		_x ctrlSetPositionH _tH;
		_x commit 0;
	} foreach [_back,_tWid];
};

sp_int_nextTaskTextParams = null;

sp_setTaskMessageEff = {
	params ["_header",["_desc",""]];
	sp_int_nextTaskTextParams = [_header,_desc];
	[true] call sp_setHideTaskMessageCtg;	
};

sp_setHideTaskMessageCtg = {
	params ["_mode"];
	private _ctg = call sp_int_getTaskCtgWidget;
	if (_mode) then {
		_ctg setFade 1;
		_ctg commit 0.2;
	} else {
		_ctg setFade 0;
		_ctg commit 0.7;
	};
};
sp_isVisibleTaskMesssageCtg = {
	(getFade (call sp_int_getTaskCtgWidget)) == 0;
};

//notification system
sp_setNotification = {
	params ["_text"];
	if (!sp_isGUIInit) exitWith {""};
	sp_internal_lastNotification = _text;
	private _tcopy = _text;
	private _tWid = call sp_int_getNotificationWidget;
	forceUnicode 1;

	//green inputs (gameside) $text
	while {[_text,"\$\w+"] call regex_isMatch} do {
		private _vname = [_text,"\$\w+"] call regex_getFirstMatch;
		private _keyName = _vname select [1,count _vname];
		private _inpName = [_keyName] call input_getKeyNameByInputName;
		_text = [_text,"\$"+_keyName,format["<t size='1.3' color='#3bad18'>%1</t>",_inpName]] call regex_replace;
	};

	//red inputs (engine side) @text
	while {[_text,"\@\w+"] call regex_isMatch} do {
		private _vname = [_text,"\@\w+"] call regex_getFirstMatch;
		private _keyName = _vname select [1,count _vname];
		private _inpName = actionKeysNames _keyName;
		_text = [_text,"\@"+_keyName,format["<t size='1.3' color='#e20048'>%1</t>",_inpName]] call regex_replace;
	};

	//keywords #(text and text)
	while {[_text,"\#\([^\)]+\)"] call regex_isMatch} do {
		private _vname = [_text,"\#\([^\)]+\)"] call regex_getFirstMatch;
		private _txt = _vname select [2,count _vname - 3];
		
		_text = [_text,"\#\("+_txt+"\)",format["<t size='1.3' shadow='1' shadowColor='#063014' shadowOffset='0.01' color='#0fab43'>%1</t>",_txt]] call regex_replace;
	};

	[_tWid,format["%2<t align='center' size='1.2'>%1</t>%2 ",_text,sbr]] call widgetSetText;
	_tWid ctrlSetPositionH (ctrlTextHeight _tWid);
	_tWid commit 0;
	if (!(call sp_isVisibleNotification)) then {
		[true] call sp_setNotificationVisible;
	};

	call sp_int_pulseNotification;

	_tcopy
};

sp_int_pulseNotificationHandle = sp_threadNull;
sp_int_pulseNotification = {
	if isNull(sp_int_pulseNotificationHandle) then {
		sp_int_pulseNotificationHandle = sp_threadNull; //fix error for undefined variable
	};

	sp_int_pulseNotificationHandle call sp_threadStop;
	private _w = (call sp_int_getNotificationWidget);
	_w setBackgroundColor (_w getvariable "orig_color");
	sp_int_pulseNotificationHandle = {
		private _w = (call sp_int_getNotificationWidget);
		_orig = _w getvariable "orig_color";
		_upd = [0.6,0.6,0.6,0.3]; //"c1d41c" call color_htmlToRGBA;
		_t = tickTime;
		_tEnd = _t + 0.8;

		while {tickTime < _tEnd} do {
			_nv = vectorLinearConversion [0,0.2,tickTime % 0.2,_orig select [0,3],_upd select [0,3],true];
			_nv set [3,0.3];
			_w setBackgroundColor _nv;
		};

		_w setBackgroundColor _orig;
		
	} call sp_threadStart;
	
};

sp_setNotificationVisible = {
	params ["_mode",["_notifHandler",""]];
	if (not_equals(_notifHandler,"") && not_equals(_notifHandler,sp_internal_lastNotification)) exitWith {};
	private _ctg = call sp_int_getNotificationWidgetCtg;
	if (_mode) then {
		_ctg setFade 0;
		_ctg commit 0.2;
	} else {
		_ctg setFade 1;
		_ctg commit 0.7;
	};
};

sp_isVisibleNotification = {
	(getFade (call sp_int_getNotificationWidgetCtg)) == 0;	
};

sp_allInitializedWidgetHighlightTokens = [];

sp_cleanupWidgetHighlightTokens = {
	sp_allInitializedWidgetHighlightTokens apply {
		refset(_x,true);
	};
	sp_allInitializedWidgetHighlightTokens resize 0;
};

sp_createWidgetHighlight = {
	params ["_w",["_sizePx",0.01],["_codeRecreate",{}],["_codeParams",[]]];
	if equalTypes(_w,{}) exitWith {
		private _cancelToken = refcreate(false);
		
		sp_allInitializedWidgetHighlightTokens pushBack _cancelToken;

		startAsyncInvoke
		{
			_this params ["_code","_cancelToken","_widRef","_sizePx","_refWidHandle","_cancelCode"];
			if (refget(_cancelToken)) exitWith {
				refset(_refWidHandle,true);
				true
			};
			if ((_cancelCode select 1) call (_cancelCode select 0) && !refget(_refWidHandle)) then {
				refset(_refWidHandle,true);
				_widRef = widgetNull;
				_this set [2,_widRef];
				_this set [4,refcreate(false)];
			};
			if !isNullReference(_widRef) exitWith {false};
			_probWid = call _code;
			if !isNullReference(_probWid) then {
				_this set [2,_probWid];
				_wh = [_probWid,_sizePx] call sp_createWidgetHighlight;
				_this set [4,_wh];
			};
			false
		},
		{
			_this params ["_code","_cancelToken","_widRef","_sizePx","_refWidHandle"];
			refset(_refWidHandle,true);
		},
		[_w,_cancelToken,widgetNull,_sizePx,refcreate(false),[_codeRecreate,_codeParams]]
		endAsyncInvoke

		_cancelToken
	};
	if equalTypes(_w,widgetNull) exitWith {
		if isNullReference(_w) exitWith {refcreate(true)};

		private _wlist = [];
		private _dpar = ctrlParent _w;
		for "_i" from 1 to 4 do {
			_wlist pushBack ([_dpar,BACKGROUND,[0,0,0,0]] call createWidget);
		};
		private _cancelToken = refcreate(false);

		sp_allInitializedWidgetHighlightTokens pushBack _cancelToken;

		startAsyncInvoke
		{
			_this params ["_w","_wlist","_sizePx","_cancelToken","_laststart"];
			if (tickTime > ((_this select 4)+1)) then {
				_this set [4,tickTime];
			};
			if isNullReference(_w) exitWith {true};
			if (any_of(_wlist apply {isNullReference(_x)})) exitWith {true};
			if (refget(_cancelToken)) exitWith {true};
			(ctrlPosition _w) params ["_oX","_oY","_oW","_oH"];
			
			//get parent pos because position of control is relative to controls group
			_orig = ctrlParentControlsGroup _w;
			while {!isNullReference(_orig)} do {
				(ctrlPosition _orig) params ["_oXExt","_oYExt"];
				modvar(_oX) + _oXExt;
				modvar(_oY) + _oYExt;
				_orig = ctrlParentControlsGroup _orig;
			};

			_wlist params ["_top", "_bottom", "_left", "_right"];
			
			_backOp = linearConversion [_laststart,_laststart + 1,tickTime,0.3,0.7,true];
			_sizePx = linearConversion [_laststart,_laststart + 1,tickTime,_sizePx,_sizePx*1.3,true];

			_top ctrlSetPosition [_oX - _sizePx, _oY - _sizePx, _oW + _sizePx * 2, _sizePx];
			_bottom ctrlSetPosition [_oX - _sizePx, _oY + _oH, _oW + _sizePx * 2, _sizePx];
			_left ctrlSetPosition [_oX - _sizePx, _oY, _sizePx, _oH];
			_right ctrlSetPosition [_oX + _oW, _oY, _sizePx, _oH];

			{
				_x ctrlEnable true;
				_x ctrlSetBackgroundColor [1,0.7,0,_backOp]; // Жёлтый цвет рамки
				_x ctrlCommit 0;
				ctrlsetfocus _x;
				_x ctrlEnable false;
			} foreach _wlist;

			false
		},
		{
			_this params ["_w","_wlist","_sizePx","_cancelToken"];
			{
				if !isNullReference(_x) then {
					[_x,false] call deleteWidget;
				};
			} foreach _wlist;
		},
		[_w,_wlist,_sizePx,_cancelToken,tickTime]
		endAsyncInvoke

		_cancelToken
	};
	
};

//включение или отключение отображения худа. для черного экрана используем setBlackScreenGUI
sp_view_setPlayerHudVisible = {
	params [["_mode","inv+right+up+left+stats+cursor+stam+chat"]];
	private _modesList = _mode splitString " +";
	["inv" in _modesList] call inventory_setGlobalVisible; //enable inventory slots
	interactMenu_disableGlobal = !("right" in _modesList); //right menu
	interactCombat_disableGlobal = !("up" in _modesList); //up menu
	interactEmote_disableGlobal = !("left" in _modesList); //left/emote menu

	interact_aim_disableGlobal = !("cursor" in _modesList);

	[("stam" in _modesList)] call stamina_setVisible;
	
	{
		if isNullVar(_x) then {continue};
		if isNullReference(_x) then {continue};
		_x ctrlShow ("stats" in _modesList);
	} foreach hud_widgets; //statuses

	(chat_widgets select 0) ctrlShow ("chat" in _modesList);
};

//установить видимость головы игрока
sp_view_setPlayerHeadVisible = {
	params ["_mode"];
	if (_mode) then {
		private __onChangeHud = true;
		[player,"onChangeFace",true] call smd_syncVar;
	} else {
		[player,"onChangeFace",true] call smd_syncVar;
	};
};

sp_gui_setPlayerColorInversion = {
	params ["_r","_g","_b"];
	private _handle = sp_gui_pphndl_clrinvers;
	_handle ppEffectAdjust [_r,_g,_b];
	_handle ppEffectCommit 0.01;	
};

sp_gui_setPlayerAbberation = {
	params ["_abberval"];
	private _handle = sp_gui_pphndl_chromabb;
	_handle ppEffectAdjust [_abberval,_abberval,true];
	_handle ppEffectCommit 0.01;
};

sp_gui_internal_onUpdatePPGUI = {
	
	_hp = sp_playerHp;

	if (_hp < 100) then {
		if (tickTime >= (sp_playerLastDamagedTime + 5)) then {
			_hp = _hp + 3;
			sp_playerHp = _hp;
		};
	};

	_abber = linearConversion [100,0,_hp,0,0.5,true];
	[_abber] call sp_gui_setPlayerAbberation;
	_redclr = linearConversion [100,0,_hp,0,0.6,true];
	[_redclr,0,0] call sp_gui_setPlayerColorInversion;
};

sp_gui_internal_cinematicMode = false;
sp_gui_internal_cinematicModeWidgets = [];
sp_gui_setCinematicMode = {
	params ["_mode"];
	if equals(_mode,sp_gui_internal_cinematicMode) exitWith {};
	sp_gui_internal_cinematicMode = _mode;
	if (_mode) then {
		if (isDisplayOpen) then {
			call displayClose;
		};
		
		private _d = call displayOpen;
		{
			{[_x,false] call deleteWidget} foreach sp_gui_internal_cinematicModeWidgets;

			private _gui = getGUI;
			private _sizeH = 10;
			private _w1 = [_gui,BACKGROUND,[0,0,100,_sizeH]] call createWidget;
			_w1 setvariable ["_outpos",[0,0-_sizeH,100,_sizeH]];
			_w1 setvariable ["_inpos",[0,0,100,_sizeH]];
			private _w2 = [_gui,BACKGROUND,[0,100-_sizeH,100,_sizeH]] call createWidget;
			_w2 setvariable ["_outpos",[0,100,100,_sizeH]];
			_w2 setvariable ["_inpos",[0,100-_sizeH,100,_sizeH]];
			{
				_x setBackgroundColor [0,0,0,1];
				widgetSetFade(_x,1,0);
				widgetSetFade(_x,0,0.5);
				[_x,_x getvariable "_outpos"] call widgetSetPosition;
				[_x,_x getvariable "_inpos",0.5] call widgetSetPosition;
			} foreach [_w1,_w2];
			sp_gui_internal_cinematicModeWidgets = [_w1,_w2];
		} call sp_threadCriticalSection;

		setMousePosition [100,100];
		_d displayAddEventHandler ["MouseMoving",{
			setMousePosition [100,100];
		}];
	} else {
		call displayClose;
		{
			{
				widgetSetFade(_x,1,0.8);
				[_x,_x getvariable "_outpos",0.8] call widgetSetPosition;
			} foreach sp_gui_internal_cinematicModeWidgets;
			private _code = {
				{
					[_x,false] call deleteWidget;
				} foreach sp_gui_internal_cinematicModeWidgets;
			};
			invokeAfterDelay(_code,0.9);
		} call sp_threadCriticalSection;
	};
};

sp_gui_setBlackScreenGUI = {
	params ["_mode",["_time",1],["_threadWait",true]];
	[_mode,_time] call setBlackScreenGUI;
	if (canSuspend && _threadWait) then {
		_time call sp_threadPause;
	};
};

sp_gui_inventoryVisibleHandlers = [{true},{true},{true}];
sp_gui_resetInventoryVisibleHandlers = {
	sp_gui_inventoryVisibleHandlers = [{true},{true},{true}];
};
/* 
	for right
	{
        if equals(ctrltext _x,"Рот") exitWith {_wid = _x};
    } foreach interactMenu_selectionWidgets;
	{
		if (!isNullReference(_x) && {(_x getvariable "actionName") == "Сон"}) exitWith {
			_wid = _x;
		};
	} foreach interactMenu_specActWidgets;

	for up

*/
sp_gui_setInventoryVisibleHandler = {
	params [["_left",{true}],["_up",{true}],["_right",{true}]];
	sp_gui_inventoryVisibleHandlers = [_left,_up,_right];
};

sp_gui_internal_const_baseFadeInvVis = 0.6;

sp_gui_syncInventoryVisible = {
	private _d = getDisplay;
	if (isNullReference(_d)) exitWith {};
	sp_gui_inventoryVisibleHandlers params ["_left","_up","_right"];

	private _funcHandleWidget = {
		params ["_fnGetName","_widget","_fnCheck"];
		if isNullReference(_widget) exitWith {false};
		if ([call _fnGetName,_widget] call _fnCheck) then {
			if !isNull(_widget getvariable "__basefade_spgui") then {
				_widget setFade (_widget getvariable "__basefade_spgui");
				_widget commit 0;
				_widget setvariable ["__basefade_spgui",nil];
			};
			_widget ctrlEnable true;
		} else {
			if isNull(_widget getvariable "__basefade_spgui") then {
				_widget setvariable ["__basefade_spgui",ctrlFade _widget];
			};
			_widget setFade sp_gui_internal_const_baseFadeInvVis;
			_widget commit 0;
			_widget ctrlEnable false;
		};
	};

	//left handler
	{
		[{_x getvariable "act"},_x,_left] call _funcHandleWidget;
	} foreach interactEmote_act_widgets;
	private _w = _d getvariable ["ieMenuCtg",widgetNull] getvariable ["buttonSend",widgetNull];
	if !isNullReference(_w) then {
		[{"buttonSendEmote"},_w,_left] call _funcHandleWidget;
	};

	//up handler
	{
		[{_x},_y,_up] call _funcHandleWidget;
	} foreach interactCombat_map_widgetStyles;
	{
		[{_x},_y,_up] call _funcHandleWidget;
	} foreach interactCombat_map_attTypeWidgets;
	{
		[{_x},_y,_up] call _funcHandleWidget;
	} foreach interactCombat_map_defTypeWidgets;

	
	//right handler
	{
		[{ctrltext _x},_x,_right] call _funcHandleWidget;
	} foreach interactMenu_selectionWidgets;

	{
		[{_x getvariable "actionName"},_x,_right] call _funcHandleWidget;
	} foreach interactMenu_specActWidgets;
};