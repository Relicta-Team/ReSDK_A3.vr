// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	_inPar params ["_pname","_rangeNVals","_rangeDelay"];
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
		params ["_t","_o","_fnc","_val","_rng","_del"];
		if isNullReference(_o) exitWith {true};
		if (tickTime < _t) exitWith {false};
		_this set [0,tickTime + rand(_del select 0,_del select 1)];
		
		(_rng select 0) params ["_xb","_yb","_zb"];
		(_rng select 1) params ["_xe","_ye","_ze"];
		_val = _val vectorAdd [rand(_xb,_xe),rand(_yb,_ye),rand(_zb,_ze)];
		[_o,_val] call _fnc;

		false
	},
	{},//exiter 
	[tickTime,_emit,_pvFunc,_curval_const,_rangeNVals,_rangeDelay]
	endAsyncInvoke

}] call le_se_registerConfigHandler;

["randomize_value_float",{
	params ["_emit","_src","_inPar"];
	_inPar params ["_pname","_rangeVals","_rangeDelay"];
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
		params ["_t","_o","_fnc","_val","_rng","_del"];
		if isNullReference(_o) exitWith {true};
		if (tickTime < _t) exitWith {false};
		_this set [0,tickTime + rand(_del select 0,_del select 1)];
		
		_val = _val + rand(_rng select 0,_rng select 1);
		[_o,_val] call _fnc;

		false
	},
	{},//exiter 
	[tickTime,_emit,_pvFunc,_curval_const,_rangeVals,_rangeDelay]
	endAsyncInvoke
}] call le_se_registerConfigHandler;


//do not use this before fix le_se_getCurrentConfigId for unmanaged emitters
["atmos_optimize_chunk",{
	params ["_emit","_src"];
	// if (!acli_bool_enableSystem) exitWith {};
	// [_emit,call le_se_getCurrentConfigId] call acli_handleAddObj;
}] call le_se_registerConfigHandler;