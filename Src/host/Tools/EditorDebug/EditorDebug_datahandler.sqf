// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



editorDebug_init = {

	if (!editorDebug_isEnabled) exitWith {
		log("editorDebug::init() - debugger not enabled.");
	};

	//create visuals
	{
		[_x select 1] call editorDebug_createVisual;
	} foreach editorDebug_handlerWidgets;

	editorDebug_handlerUpdate = startUpdate(editorDebug_onUpdate,0.01);

	log("editorDebug::init() - debugger loaded");

	//first init visual
	if isNull(editorDebug_internal_debuggerStatus) then {
		editorDebug_internal_debuggerStatus = false;
	};
	[editorDebug_internal_debuggerStatus] call editorDebug_setVisibleWidgets;
};

editorDebug_onUpdate = {
	_systemEnabled = call editorDebug_isVisibleWidgets;
	if (!_systemEnabled) exitwith {};

	{
		_x params ["_w","_nameT","_deleg_retObj","_defpos","_deleg_setText"];
		_metrics = _nameT == "usr";
		#define metstart(seg) _segtime = tickTime; _lastseg = #seg;
		#define metprint if (_metrics) then {traceformat("Metrics[%1]: %2",_lastseg arg (tickTime - _segtime) * 1000)};
		#define metstart(val) 
		#define metprint 

		metstart(getObject)
		_o = call _deleg_retObj;
		metprint
		_txt = "ERR - NO DATA";
		if isNullVar(_o) then {
			_txt = "ERR - NULL RETOBJ";
		} else {
			if isNullReference(_o) then {
				_txt = "ERR - NULL REFERENCE";
			} else {
				metstart(createText)
				_txt = _o call _deleg_setText;
				metprint
			};
		};
		
		metstart(changePos)
		//_txt = _txt + sbr + "!EOF!";
		_tf = _w getVariable "textField";
		[_tf,_txt] call widgetSetText;
		_textSizeH = (_tf call widgetGetTextHeight);
		_tf setVariable ["textSizeY",_textSizeH];
		_b = _tf getVariable ["biasY",0]; //TODO scroll text saving
		[_tf,[0,_b /* max 0 min _textSizeH*/,100,_textSizeH]] call widgetSetPosition; //500 for long values

		metprint

		//[0,0,0,0.3] std back
		if equals(_w getVariable "index",editorDebug_internal_activeTab) then {
			(_w getVariable "background") setBackgroundColor [0.2,0.2,0.2,0.3];
		} else {
			(_w getVariable "background") setBackgroundColor [0,0,0,0.15];
		};


	} foreach editorDebug_handlerWidgets;
};

editorDebug_handler_gameObject_valueToText = {
	params ['_varname',"_varval",["_dirty",0]];
	
	_type = ""; _realval = _varval; _postTypeMod = "";
	call {
		if isNullVar(_varval) exitWith {
			_realval = "NULL";
			_type = "null"
		};
		_typevar = typename _varval;

		if (_typevar == "scalar") exitWith {
			if (floor _varval == _varval) then {
				_type = "int";
			} else {
				_type = "float";
			};
			//_realval = str _realval;
		};
		if (_typevar == "string") exitWith {
			_type = "string";
			//_realval = sanitizeHTML(_realval);
		};
		if (_typevar == "bool") exitWith {_type = "bool"};
		if (_typevar == "array") exitWith {
			_type = "array";
			_postTypeMod = "%1["+str count _varval+"]";
			_realval = sanitizeHTML(str _realval);
		};
		if (_typevar == "location") exitWith {
			if isNullReference(_varval) then {
				_realval = "nullPtr";
				_type = "object";
			} else {
				//_type = _varval getVariable PROTOTYPE_VAR_NAME getVariable "classname";
				_type = "object";
				_realval = sanitize(str _realval);
			};
		};
		if (_typevar == "object") exitWith {
			if isNullReference(_varval) then {
				_type = "model";
				_realval = "mdl_null";
			} else {
				_type = "model";
				_realval = sanitizeHTML(str _realval);
			};
		};
		if (_typevar == "hashmap") exitWith {
			if(({isNullVar(_x)}count (values _varval)) == (count _varval))then{
				_type = "hashset";
				_realval = keys _varval;
			}else{
				_type = "dict";
			};
			_realval = sanitize(str _realval);
		};
		_type = "ERROR TYPE - "+typeName _varval;
	};

	_colorType = editorDebug_internal_const_typemapColors get _type;
	if !isNullVar(_colorType) then {
		if (_postTypeMod!="") then {
			_type = format[_postTypeMod,_type];
		};
		_type = format["<t color='%2'>%1</t>",
			_type,
			_colorType
		];
	};
	if (_dirty > 0) then {
		_clamped = clamp(_dirty,0,1);
		_realval = format["<t color='%2'>%1</t>",_realval,[1,_clamped,_clamped] call color_RGBtoHTML];
	};
	_txtRet = format["(%1) %2 = %3",_type,_varname,_realval];
	_txtRet
};

editorDebug_internal_const_typemapColors = createHashMapFromArray[
	["object","#7E07A9"]
	,["bool","#00CD00"]
	,["int","#FFC901"]
	,["float","#EEFF00"]
	,["string","#994D1A"]
	,["array","#173F63"]
	,["hashset","#301C69"]
	,["dict","#8405AB"]
	,["model","#FF6400"]
];

//обработчик игрового объекта
editorDebug_handler_gameObject = {
	_ret = [];
	//_varlist = allVariables _this;
	//_varlist sort true;

	_wid = _w;

	_lastptr = _wid getvariable ["lastpointer",nullPtr];
	_storedvalues = _wid getvariable "storedvalues";
	//_storedstrings = _wid getvariable ["storedstrings",[]];

	if not_equals(_lastptr,_this) then {
		_storedvalues = createHashMap;
		
		_varlist = allVariables _this;
		_varlist sort true;
		_wid setvariable ["varlist",_varlist];
	};
	_varlist = _wid getvariable "varlist";
	
	_curstored = null;
	{

		_v = getVarReflect(_this,_x);
		_curstored = _storedvalues getOrDefault [_x,[_v,0]];
		_rv = ifcheck(isNullVar(_v),"#NOT_DEF#",_v);
		if not_equals(_curstored select 0,_rv) then {
			_curstored set [1,tickTime + 4];
			_curstored set [0,_rv];
		};

		_storedvalues set [_x,_curstored];
		_curtime = (_curstored select 1);
		_newvalue = linearConversion [4,0,_curtime - tickTime,0,1,true];
		// if (_newvalue >= -1) then {
		// 	_storedstrings set [_foreachindex,
		// 		([_x,_v,_newvalue] call editorDebug_handler_gameObject_valueToText)
		// 	]
		// };
		
		_ret pushBack ([_x,_v,_newvalue] call editorDebug_handler_gameObject_valueToText);
		_ret pushBack sbr;
	} foreach _varlist;

	_wid setvariable ["lastpointer",_this];
	_wid setvariable ["storedvalues",_storedvalues];
	//_wid setvariable ["storedstrings",_storedstrings];

	//_storedstrings joinString sbr;
	(_ret joinString "")
};

//общий обработчик данных
editorDebug_handler_common = {
	#define symb__(dat) ###dat
	#define bcol(button) <t color=''symb__(ff0000)''>button</t> 

	"<t size='1.4'>Use <t color='#ff0000'>J,I,K,L</t> for switch and scroll active debug panel. shift - for fast scroll</t>" + sbr + sbr +
	format["FPS (cur/min): %1; %2",round diag_fps,round diag_fpsmin] + sbr +
	format["Delta: %1; tickTime: %2; frame: %3",diag_deltaTime,diag_ticktime,diag_frameno] + sbr +
	format["OOP Info: Created: %1; Active: %2; Threads: %3",oop_cco,oop_cao,oop_upd] + sbr + 
	format["Player pos: {%1}",(getposatl player apply {_x toFIXED 2}) joinString ","] + sbr +
	format["Player dir: %1",getDir player] + sbr +
	format["Player velocity: {%1}",(velocity player apply {_x toFIXED 4}) joinString ","]
};
