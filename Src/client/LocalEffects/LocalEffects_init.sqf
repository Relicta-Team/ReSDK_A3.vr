// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include <..\ClientRpc\clientRpc.hpp>

#include "LocalEffects_structs.sqf"

namespace(LocalEffects,locef_)

/*
	Local effects system
	night vision
	footsteps
	etc...

	Events:
		oncreate  - called on event created
		ondestroy - called on event removed
		onupdate - called on event updated


*/

decl(map<string;string)
locef_allEffectsCfg = createHashMap; //списки конфигураций эффектов
decl(map<string;struct_t.LocEffBase>)
locef_allActiveEffects = createHashMap; //key:name, value:struct_t.LocEffBase

macro_func(locef_sanitizeCfgName,string(string))
#define sanitizeCfgName(var) tolower var
macro_func(locef_effectExists,bool(string))
#define effectExists(checked) (checked in locef_allActiveEffects)

decl(bool)
locef_isInitialized = false;

decl(void())
locef_initConfigs = {
	private _types = ["LocEffBase"] call struct_getAllTypesOf;
	if (count _types == 0) exitWith {
		setLastError("LocEff: Not found any LocEffs");
	};
	{
		private _cfgName = [_x,"name"] call struct_reflect_getTypeValue;
		if (_cfgName != "") then {
			locef_allEffectsCfg set [sanitizeCfgName(_cfgName),_x];
		};
	} foreach _types;

	locef_isInitialized = true;
};

decl(void(string))
locef_remove = {
	private _eventName = _this;
	_eventName = sanitizeCfgName(_eventName);
	
	if !effectExists(_eventName) exitwith {};
	private _evObj = locef_allActiveEffects get _eventName;
	if !isNullVar(_evObj) then {
		_evObj callv(destroy);
		locef_allActiveEffects deleteAt _eventName;
	};
}; rpcAdd("lcfrem",locef_remove);

decl(void(string;any))
locef_update = {
	params ["_eventName",["_context",[]]];

	if (!locef_isInitialized) then {
		call locef_initConfigs;
	};

	_eventName = sanitizeCfgName(_eventName);
	private _isExists = effectExists(_eventName);
	//! здесь очевидно не должен записываться контекст. может возникнуть повреждение контекста при обновлении эффекта
	if (_isExists) then {
		private _obj = locef_allActiveEffects get _eventName;
		_obj callp(updateContext,_context);
		_obj callv(update);
	} else {
		private _cfg = locef_allEffectsCfg get _eventName;
		if isNullVar(_cfg) exitWith {
			errorformat("locef_update() - Undefined key: %1",_eventName);
		};
		private _obj = [_cfg] call struct_alloc;
		locef_allActiveEffects set [_eventName,_obj];
		_obj callp(updateContext,_context);
		_obj callv(create);
	};
	
}; rpcAdd("lcfupd",locef_update);

decl(void())
locef_removeAll = {
	{
		_x call locef_remove;
	} foreach (keys locef_allActiveEffects);
}; rpcAdd("lcfclr",locef_removeAll);

decl(mesh())
locef_createTempObject = {
	private _o = [null,null,true] call vst_createDummyMesh;
	_o
};
