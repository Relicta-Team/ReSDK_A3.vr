// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include "VisualState_structBase.sqf"


vst_map_cfgs = createHashMap; //key:name, value:struct type
vst_dictInitialized = false;

vst_const_internalVarName = "__vst_cfgs";

vst_initializeDict = {
	private _vstList = ["VSTBase"] call struct_getAllTypesOf;
	if (count _vstList == 0) exitWith {
		setLastError("VST: Not found any VSTs");
	};
	private _cfgName = "";
	{
		_cfgName = [_x,"name"] call struct_reflect_getTypeValue;
		vst_map_cfgs set [_cfgName,_x];
	} foreach _vstList;
	vst_dictInitialized = true;
};

//check if config exists
vst_containsConfig = {
	params ["_src","_type"];

	private _oldCfgs = _src getVariable vst_const_internalVarName;
	if isNullVar(_oldCfgs) exitWith {};
	array_exists(_oldCfgs,_type);
};

//get vst handler
vst_getSourceHandler = {
	params ["_src","_type"];

	private _oldCfgs = _src getVariable vst_const_internalVarName;
	if isNullVar(_oldCfgs) exitWith {null};
	_oldCfgs get _type
};

//initialize vst config
vst_create = {
	params ["_type","_src","_ctx"];

	if (!vst_dictInitialized) then {
		vst_initializeDict;
	};

	if array_exists(vst_map_cfgs,_type) exitWith {
		errorformat("VST::create() - Undefined config type: %1",_type);
		false
	};
	
	private _obj = [vst_map_cfgs get _type,[_src]] call struct_alloc;

	private _oldCfgs = _src getVariable vst_const_internalVarName;

	if isNullVar(_oldCfgs) then {
		_oldCfgs = createHashMap;
		_src setVariable [vst_const_internalVarName,_oldCfgs];
	};
	
	//if already loaded - unload them
	if array_exists(_oldCfgs,_type) then {
		(_oldCfgs get _type) callp(onDestroy,_ctx);
	};
	
	_oldCfgs set [_type,_obj];
	
	_obj callp(onCreated,_ctx);

	true
};

//remove vst
vst_remove = {
	params ["_type","_src","_ctx"];

	private _oldCfgs = _src getVariable vst_const_internalVarName;
	private _finalized = false;
	if !isNullVar(_oldCfgs) then {
		if array_exists(_oldCfgs,_type) then {
			private _obj = _oldCfgs get _type;
			_oldCfgs deleteAt _type;
			_obj callp(onDestroy,_ctx);
			_finalized = true;			
		};
	};
	_finalized
};

vst_createDummyMesh = {
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

//! TODO replace all this shit with vst_getSourceHandler
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
