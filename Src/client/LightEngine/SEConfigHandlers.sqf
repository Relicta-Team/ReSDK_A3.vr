// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


["loop_sound",{
	params ["_emit","_src","_inPar"];
	_inPar params ["_sndPath","_pitORpitv2","_dist","_preend","_vol"];
	// _dist = 8;
	// _preend = 1.5;
	[_sndPath,_emit,_pitORpitv2,_dist,null,_preend,_vol] call sound3d_playLocalOnObjectLooped;
}] call le_se_registerConfigHandler;

["randomize_value_vec3",{
	params ["_emit","_src","_inPar"];
	_inPar params ["_pname","_rangeNVals","_rangeDelay",["_isSet",false]];
	private _pvFunc = le_se_mapHandlers get _pname;
	if isNullVar(_pvFunc) exitWith {};
	if !([_pname,"setLight"] call stringStartWith) exitWith {};
	private _endPostfix = [_pname,"setLight"] call stringReplace;
	if !(_endPostfix in ["Color","Ambient"]) exitWith {
		errorformat("randomize_value_vec3() - Wrong type _pname - name (%1). Possible only Color or Ambient",_pname);
	};
	private _curval_const = [_pname] call le_se_getCurrentConfigPropVal;
	if isNullVar(_curval_const) exitWith {};

	startAsyncInvoke
	{
		params ["_t","_o","_fnc","_val","_rng","_del","_isset"];
		if isNullReference(_o) exitWith {true};
		if (tickTime < _t) exitWith {false};
		_this set [0,tickTime + rand(_del select 0,_del select 1)];
		
		(_rng select 0) params ["_xb","_yb","_zb"];
		(_rng select 1) params ["_xe","_ye","_ze"];
		if (_isset) then {
			_val = [rand(_xb,_xe),rand(_yb,_ye),rand(_zb,_ze)];
		} else {
			_val = _val vectorAdd [rand(_xb,_xe),rand(_yb,_ye),rand(_zb,_ze)];
		};
		[_o,_val] call _fnc;

		false
	},
	{},//exiter 
	[tickTime,_emit,_pvFunc,_curval_const,_rangeNVals,_rangeDelay,_isSet]
	endAsyncInvoke

}] call le_se_registerConfigHandler;

["randomize_value_float",{
	params ["_emit","_src","_inPar"];
	_inPar params ["_pname","_rangeVals","_rangeDelay",["_isSet",false]];
	private _pvFunc = le_se_mapHandlers get _pname;
	if isNullVar(_pvFunc) exitWith {};
	if !([_pname,"setLight"] call stringStartWith) exitWith {};
	private _endPostfix = [_pname,"setLight"] call stringReplace;
	if !(_endPostfix in ["Intensity"]) exitWith {
		errorformat("randomize_value_float() - Wrong type _pname - name (%1). Possible only Intensity",_pname);
	};
	private _curval_const = [_pname] call le_se_getCurrentConfigPropVal;
	if isNullVar(_curval_const) exitWith {};

	startAsyncInvoke
	{
		params ["_t","_o","_fnc","_val","_rng","_del","_isset"];
		if isNullReference(_o) exitWith {true};
		if (tickTime < _t) exitWith {false};
		_this set [0,tickTime + rand(_del select 0,_del select 1)];
		if (_isset) then {
			_val = rand(_rng select 0,_rng select 1);
		} else {
			_val = _val + rand(_rng select 0,_rng select 1);
		};
		[_o,_val] call _fnc;

		false
	},
	{},//exiter 
	[tickTime,_emit,_pvFunc,_curval_const,_rangeVals,_rangeDelay,_isSet]
	endAsyncInvoke
}] call le_se_registerConfigHandler;


//do not use this before fix le_se_getCurrentConfigId for unmanaged emitters
["atmos_optimize_chunk",{
	params ["_emit","_src"];
	// if (!acli_bool_enableSystem) exitWith {};
	// [_emit,call le_se_getCurrentConfigId] call acli_handleAddObj;
}] call le_se_registerConfigHandler;

//abstract light cant be get from getLightingAt
["virtual_light",{
	params ["_emit","_src","_inPar"];
	private _curval_const = ["setLightIntensity"] call le_se_getCurrentConfigPropVal;
	if isNullVar(_curval_const) exitWith {
		errorformat("virtual_light() - Unknown intensity value for source object %1",_src);
	};
	[_emit,_curval_const] call os_light_registerAsNoProcessedLight;
}] call le_se_registerConfigHandler;

["sign_bar_blink",{
	params ["_emit","_src","_inPar"];
	private _delay = 0.7;
	private _posvec = [
		[0.1,-0,0.2], //center
		[0.5,-0,0.4],//up
		[0.5,-0,0.0], //middle
		[0.25,-0,-0.15],//semiarrow
		[-0.2,-0,-0.6], //arrow
		[0,0,-100] //nopos
	];
	private _code = {
		params ["_light","_src","_stateIndex","_delay","_method","_posvec"];
		if isNullReference(_light) exitWith {};

		_light attachTo [_src,_posvec select _stateIndex];

		if (_stateIndex >= (count _posvec -1)) then {
			_stateIndex = -1
		} else {
			if (_stateIndex % 2 == 0) then {
				_light setLightColor [0.013,0.001,0];
				_light setLightAmbient [0.013,0.001,0];
			} else {
				_light setLightColor [0.001,0.013,0];
				_light setLightAmbient [0.001,0.013,0];
			};
		};
		_this set [2,_stateIndex + 1];

		invokeAfterDelayParams(_method,_delay,_this);
	};
	_params = [_emit,_src,0,_delay,_code,_posvec];
	invokeAfterDelayParams(_code,_delay,_params);
}] call le_se_registerConfigHandler;