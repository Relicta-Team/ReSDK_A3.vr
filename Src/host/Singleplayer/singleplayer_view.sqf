// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_gui_taskWidgets = [];
sp_gui_notificationWidgets = [];
sp_gui_borders = [];

sp_gui_borderSize = 10;
sp_gui_notificationSizeW = 40;
sp_gui_notificationSizeH = 70;

sp_gui_taskMessageWidth = 25;

sp_internal_lastNotification = "";

sp_isGUIInit = false;
sp_initGUI = {
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
	_t = [_d,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	_t setBackgroundColor [0.2,0.2,0.2,0.3];
	sp_gui_notificationWidgets = [_ctg,_t];
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

	while {[_text,"\$\w+"] call regex_isMatch} do {
		private _vname = [_text,"\$\w+"] call regex_getFirstMatch;
		private _keyName = _vname select [1,count _vname];
		private _inpName = [_keyName] call input_getKeyNameByInputName;
		_text = [_text,"\$"+_keyName,format["<t size='1.3' color='#3bad18'>%1</t>",_inpName]] call regex_replace;
	};

	while {[_text,"\@\w+"] call regex_isMatch} do {
		private _vname = [_text,"\@\w+"] call regex_getFirstMatch;
		private _keyName = _vname select [1,count _vname];
		private _inpName = actionKeysNames _keyName;
		_text = [_text,"\@"+_keyName,format["<t size='1.3' color='#e20048'>%1</t>",_inpName]] call regex_replace;
	};

	[_tWid,format["%2<t align='center' size='1.2'>%1</t>%2 ",_text,sbr]] call widgetSetText;
	_tWid ctrlSetPositionH (ctrlTextHeight _tWid);
	_tWid commit 0;
	if (!(call sp_isVisibleNotification)) then {
		[true] call sp_setNotificationVisible;
	};

	_tcopy
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


sp_createWidgetHighlight = {
	params ["_w",["_sizePx",0.01]];
	if equalTypes(_w,{}) exitWith {
		private _cancelToken = refcreate(false);
		startAsyncInvoke
		{
			_this params ["_code","_cancelToken","_widRef","_sizePx","_refWidHandle"];
			if (refget(_cancelToken)) exitWith {
				refset(_refWidHandle,true);
				true
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
		[_w,_cancelToken,widgetNull,_sizePx,refcreate(false)]
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
	params [["_mode","inv+right+up+left+stats+cursor"]];
	private _modesList = _mode splitString " +";
	["inv" in _modesList] call inventory_setGlobalVisible; //enable inventory slots
	interactMenu_disableGlobal = !("right" in _modesList); //right menu
	interactCombat_disableGlobal = !("up" in _modesList); //up menu
	interactEmote_disableGlobal = !("left" in _modesList); //left/emote menu

	interact_aim_disableGlobal = !("cursor" in _modesList);
	
	{_x ctrlShow ("stats" in _modesList)} foreach hud_widgets; //statuses
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