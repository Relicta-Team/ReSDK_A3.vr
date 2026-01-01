// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//struct of vec3: ref ctg, name, code target, positions(size),handler
editorDebug_handlerWidgets = [
	[widgetNull,"Hand",{
		_ref = player getVariable "link";
		callFunc(_ref,getItemInActiveHand)
		},vec4(40,0,20,100),editorDebug_handler_gameObject],
	[widgetNull,"Targ",{
		// _o=call interact_cursorObject;
		// if isNullReference(_o) exitWith {nullPtr};
		// _o = pointerList getOrDefault [(_o getVariable ["ref","nan"]),nullPtr];
		/*if isNullReference(_o) exitWith {
			_o = call interact_cursorObject;
			if isNullReference(_o) exitWith {nullPtr};
			pointerList getOrDefault [(_o getVariable ["link","nan"]),nullPtr];
		};*/
		private _o = (["target",""] call oop_getData) select 0;
		if equalTypes(_o,"") exitwith {nullPtr};
		_o
	},vec4(40+20,0,20,100),editorDebug_handler_gameObject],
	[widgetNull,"Usr",{
		player getVariable ["link",nullPtr]
	},vec4(40+20+20,0,20,100),editorDebug_handler_gameObject],
	[widgetNull,"Common",{player},vec4(0,0,30,30),editorDebug_handler_common]
];

editorDebug_setVisibleWidgets = {
	params ["_mode"];
	{
		(_x select 0) ctrlShow _mode;
	} foreach editorDebug_handlerWidgets;
	
	editorDebug_internal_debuggerStatus = _mode;
};
editorDebug_isVisibleWidgets = {
	ctrlShown (editorDebug_handlerWidgets select 0 select 0)
};

editorDebug_internal_activeTab = -1;

editorDebug_createVisual = {
	params ["_catName"];
	private _idx = editorDebug_handlerWidgets findIf {(_x select 1)==_catName};
	if (_idx == -1) exitWith {
		errorformat("editorDebug::createVisual() - Category %1 not exists",_catName);
	};

	editorDebug_internal_activeTab = _idx;

	private _pos = editorDebug_handlerWidgets select _idx select 3;

	private _d = getGUI;
	//create visual ctg
	private _ctg = [_d,WIDGETGROUP,_pos] call createWidget;
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,0.3];
	private _text = [_d,TEXT,vec4(0,0,100,3),_ctg] call createWidget;
	[_text,format["<t align='center'>%1</t>",editorDebug_handlerWidgets select _idx select 1]] call widgetSetText;
	private _ctgIn = [_d,WIDGETGROUP,vec4(0,3,100,100-3),_ctg] call createWidget;
	private _textIn = [_d,TEXT,WIDGET_FULLSIZE,_ctgIn] call createWidget;

	//setting references
	_ctg setVariable ["textField",_textIn];
	_ctg setVariable ["refdata",editorDebug_handlerWidgets select _idx];
	_ctg setVariable ["index",_idx];
	_ctg setVariable ["background",_back];
	_ctg setVariable ["defaultPos",_pos];
	(editorDebug_handlerWidgets select _idx) set [0,_ctg];
};


editorDebug_scrollActiveTab = {
	params ["_val"];
	_ctg = editorDebug_handlerWidgets select editorDebug_internal_activeTab select 0;
	_tf = _ctg getVariable "textField";
	_maxSizeY = _tf getVariable ["textSizeY",100];
	//traceformat("maxy: %1; newy: %2",_maxSizeY arg ((_tf getVariable ["biasY" arg 0]) + _val))
	_tf setVariable ["biasY",
		clamp((_tf getVariable ["biasY" arg 0]) + _val,-_maxSizeY+100,0)
		
	];
};


editorDebug_handleKeyPress = {
	params ["_str","_isShift"];

	if (_str == "up") exitWith {
		_v = 1.5;
		if (_isShift) then {modvar(_v) * 5};
		[_v] call editorDebug_scrollActiveTab;
	};
	if (_str == "down") exitWith {
		_v = -1.5;
		if (_isShift) then {modvar(_v) * 5};
		[_v] call editorDebug_scrollActiveTab;
	};
	_ch = if (_str == "left") then {-1} else {1};

	_nv = editorDebug_internal_activeTab + _ch;
	if (_nv <0)then {
		_nv = (count editorDebug_handlerWidgets)-1;
	} else {
		if (_nv >= (count editorDebug_handlerWidgets))then {
			_nv = 0;
		};
	};
	editorDebug_internal_activeTab = _nv;
};
