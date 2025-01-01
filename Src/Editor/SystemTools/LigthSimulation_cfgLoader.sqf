// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\EditorEngine.h"
#include "..\..\host\engine.hpp"

if !(call vcom_emit_io_isConfigsLoaded) then {
	call vcom_emit_io_readConfigs;
};

//use: vcom_emit_io_enumAssocKeyStr, vcom_emit_io_enumAssocKeyInt
if !(call vcom_emit_io_isEnumConfigsLoaded) then {
	[true] call vcom_emit_io_loadEnumAssoc;
};

//fix 1
missionNamespace setVariable ["pushFront",
{
	params ["_list","_element",["_unique",false]];
	reverse _list;
	if (_unique) then {
		_list pushBackUnique _element;
	} else {
		_list pushBack _element;
	};
	reverse _list;
}
];

//for init varobjects

#include "..\..\client\LightEngine\ScriptedEffects.hpp"

//light functions init
#include "..\..\client\LightEngine\ScriptedEffects.sqf"
//configs init
#include "..\..\client\LightEngine\ScriptedEffectConfigs.sqf"

call le_se_doSorting;