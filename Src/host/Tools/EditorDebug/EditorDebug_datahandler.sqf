// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
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
};

editorDebug_onUpdate = {
	{
		_x params ["_w","_nameT","_deleg_retObj","_defpos","_deleg_setText"];

		_o = call _deleg_retObj;
		_txt = "ERR - NO DATA";
		if isNullVar(_o) then {
			_txt = "ERR - NULL RETOBJ";
		} else {
			if isNullReference(_o) then {
				_txt = "ERR - NULL REFERENCE";
			} else {
				_txt = _o call _deleg_setText;
			};
		};

		_tf = _w getVariable "textField";
		[_tf,_txt] call widgetSetText;
		_textSizeH = (_w call widgetGetTextHeight);
		_tf setVariable ["textSizeY",_textSizeH];
		_b = _tf getVariable ["biasY",0]; //TODO scroll text saving
		[_tf,[0,_b/* max 0 min _textSizeH*/,500,_textSizeH]] call widgetSetPosition; //500 for long values


		//[0,0,0,0.3] std back
		if equals(_w getVariable "index",editorDebug_internal_activeTab) then {
			(_w getVariable "background") setBackgroundColor [0,0,0,0.3];
		} else {
			(_w getVariable "background") setBackgroundColor [0,0,0,0.15];
		};


	} foreach editorDebug_handlerWidgets;
};

editorDebug_handler_gameObject_valueToText = {
	params ['_varname',"_varval"];

	_type = ""; _realval = _varval;
	call {
		if isNullVar(_varval) exitWith {
			_realval = "NULL";
			_type = "null"
		};
		if (typename _varval == "location") exitWith {
			if isNullReference(_varval) then {
				_realval = "nullPtr";
				_type = "object";
			} else {
				_type = _varval getVariable PROTOTYPE_VAR_NAME getVariable "classname";
			};
		};
		if (typename _varval == "scalar") exitWith {
			if (floor _varval == _varval) then {
				_type = "int";
			} else {
				_type = "float";
			};
		};
		if (typename _varval == "string") exitWith {
			_type = "string";
		};
		if (typename _varval == "bool") exitWith {_type = "bool"};
		if (typename _varval == "array") exitWith {
			_type = "array["+str count _varval+"]";
		};
		if (typename _varval == "hashmap") exitWith {
			if(({isNullVar(_x)}count (values _varval)) == (count _varval))then{
				_type = "hashset";
			}else{
				_type = "dict";
			};
		};
		if (typename _varval == "object") exitWith {
			if isNullReference(_varval) then {
				_type = "model";
				_realval = "mdl_null";
			} else {
				_type = "model";
			};
		};
		_type = "ERROR TYPE - "+typeName _varval;
	};

	_txtRet = format["(%1) %2 = %3",_type,_varname,_realval];
	sanitizeHTML(_txtRet)

};

//обработчик игрового объекта
editorDebug_handler_gameObject = {
	_ret = "";

	{
		_v = getVarReflect(_this,_x);
		modvar(_ret) + ([_x,_v] call editorDebug_handler_gameObject_valueToText) + sbr;
	} foreach (allVariables _this);

	_ret
};

//общий обработчик данных
editorDebug_handler_common = {
	format["FPS (cur/min): %1; %2",round diag_fps,round diag_fpsmin] + sbr +
	format["Delta: %1; tickTime: %2; frame: %3",diag_deltaTime,diag_ticktime,diag_frameno] + sbr +
	format["OOP Info: Created: %1; Active: %2; Threads: %3",oop_cco,oop_cao,oop_upd]
};
