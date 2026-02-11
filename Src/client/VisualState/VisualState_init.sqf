// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include "VisualState_structBase.sqf"

namespace(VisualState,vst_)

decl(map<string;string>)
vst_map_cfgs = createHashMap; //key:name, value:struct type
decl(bool)
vst_dictInitialized = false;

decl(string)
vst_const_internalVarName = "__vst_cfgs";

decl(void())
vst_initializeDict = {
	private _vstList = ["VSTBase"] call struct_getAllTypesOf;
	if (count _vstList == 0) exitWith {
		setLastError("VST: Not found any VSTs");
	};
	private _cfgName = "";
	{
		_cfgName = [_x,"name"] call struct_reflect_getTypeValue;
		if (_cfgName != "") then {
			vst_map_cfgs set [_cfgName,_x];
		};
	} foreach _vstList;
	vst_dictInitialized = true;
};

//check if config exists
decl(bool(actor;string))
vst_containsConfig = {
	params ["_src","_type"];
	if (!vst_dictInitialized) then {
		call vst_initializeDict;
	};
	private _oldCfgs = _src getVariable vst_const_internalVarName;
	if isNullVar(_oldCfgs) exitWith {false};
	array_exists(_oldCfgs,_type);
};

//get vst handler
decl(struct_t.VSTBase|NULL(actor;string))
vst_getSourceHandler = {
	params ["_src","_type"];

	private _oldCfgs = _src getVariable vst_const_internalVarName;
	if isNullVar(_oldCfgs) exitWith {null};
	_oldCfgs get _type
};

//initialize vst config
decl(bool(string;actor;any[]))
vst_create = {
	params ["_type","_src",["_ctx",[]]];
	//traceformat("VST::create(%1) on %2 with %3",_type arg _src arg _ctx);
	if (!vst_dictInitialized) then {
		call vst_initializeDict;
	};

	if !array_exists(vst_map_cfgs,_type) exitWith {
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
decl(bool(actor;string;any[]))
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

decl(mesh(string;bool;bool))
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
