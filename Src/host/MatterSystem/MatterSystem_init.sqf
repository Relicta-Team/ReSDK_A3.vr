// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>

#include <MatterSystem.hpp>

#include <MatterSystem.h>
#include "MatterSystem_functions.sqf"

ms_map_allMatters = createHashMap;
ms_map_allReactions = createHashMap;

#include "Matters\Matters.sqf"

#include "Reactions\Reactions.sqf"



call ms_internal_initInheritance;


/*a = [player,100,[["Water",3],["Matter",7]]] call ms_create;
b = [vasya,100,[["Water",3]]] call ms_create;
[a,b,8] call ms_transferMatter;*/
