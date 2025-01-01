// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//initialize vst
le_vst_create = {
	params ["_type","_src","_ctx"];
	if (_type <= 20000) exitWith {
		error("LightEngine::VST::create() - Undefined config type");
		if (!isMultiplayer) then {
			traceformat("LightEngine::VST::create() - args %1",_this);
		};
	};
	
	private _code = missionNamespace getVariable ["le_conf_" + str _type,{}];

	if equals(_code,{}) exitWith {
		errorformat("LightEngine::VST::create():: Cant load config => %1",_type);
	};

	private _oldCfgs = _src getVariable "__le_vst_cfgs";

	if isNullVar(_oldCfgs) then {
		_oldCfgs = [];
		_src setVariable ["__le_vst_cfgs",_oldCfgs];
	} else {
		//if already loaded - unload them
		if array_exists(_oldCfgs,_type) then {
			[VST_COND_DESTR,_src,_ctx] call _code;
		};
	};

	[VST_COND_CREATE,_src,_ctx] call _code;
};

le_isVSTConfig = {_this > 20000};

//remove vst
le_vst_remove = {
	params ["_type","_src","_ctx"];
	if (_type <= 20000) exitWith {
		error("LightEngine::VST::create() - Undefined config type");
		if (!isMultiplayer) then {
			traceformat("LightEngine::VST::create() - args %1",_this);
		};
	};

	private _code = missionNamespace getVariable ["le_conf_" + str _type,{}];

	if equals(_code,{}) exitWith {
		errorformat("LightEngine::VST::create():: Cant load config => %1",_type);
	};

	private _oldCfgs = _src getVariable "__le_vst_cfgs";
	if !isNullVar(_oldCfgs) then {
		_oldCfgs deleteAt (_oldCfgs find _src)
	};

	[VST_COND_DESTR,_src,_ctx] call _code;
};

le_vst_createDummyObj = {
	params [["_model","Sign_Sphere10cm_F"],["_doHide",true],["_createAsVehicle",false]];
	private _so = if (_createAsVehicle) then {
		_model createVehicleLocal [0,0,0]
	} else {
		createSimpleObject [_model,[0,0,0],true]
	};
	if (_doHide) then {
		_so hideObject true;
	};
	_so
};

//vst varmap manager
#define VAR_FULL_PREFIX__VST_PRIVATE ("__levst_cfg"+str __GLOB_CFG_IDX__+"_var_"+_var)
le_vst_regVar = {
	params ["_obj","_var","_val"];
	_obj setVariable [VAR_FULL_PREFIX__VST_PRIVATE,_val];
};
le_vst_hasVar = {
	params ["_obj","_var"]; !isNull(vec2(_obj,_var) call le_vst_getVar)
};
	le_vst_hasVarExt = {
		params ["_obj","_var","_cfg"];
		private __GLOB_CFG_IDX__ = _cfg;
		[_obj,_var] call le_vst_hasVar
	};
le_vst_getVar = {
	params ["_obj","_var"]; _obj getVariable VAR_FULL_PREFIX__VST_PRIVATE
};
	le_vst_getVarExt = {
		params ["_obj","_var","_cfg"];
		private __GLOB_CFG_IDX__ = _cfg;
		[_obj,_var] call le_vst_getVar
	};
le_vst_remVar = {
	params ["_obj","_var"]; _obj setVariable [VAR_FULL_PREFIX__VST_PRIVATE,null];
};


#include "VisualStates\NightVision.sqf"
#include "VisualStates\Stealth.sqf"
#include "VisualStates\BreastPlate.sqf"
#include "VisualStates\CeramicArmor.sqf"
#include "VisualStates\BarreledArmor.sqf"
#include "VisualStates\StrongArmor.sqf"
#include "VisualStates\MetalArmor.sqf"
#include "VisualStates\Ghost.sqf"
#include "VisualStates\AttachedObjects.sqf"

