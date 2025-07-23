// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>

ppmgr_effects = [];

ppmgr_init = {

};

ppmgr_applyInternalEffect = {

};

ppmgr_createEffect = {
	params ["_typeName","_args"];
	
};

//todo...
ppmgr_openEditor = {
	_d = call displayOpen;
	private _pplist = [];
	{
		
		_pplist pushback _x;
	} foreach (["PostProcessEffectBase"] call struct_getAllTypesOf);

	_pplist
};