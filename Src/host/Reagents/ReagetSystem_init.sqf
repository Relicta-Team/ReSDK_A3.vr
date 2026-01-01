// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>

#include "ReagentSystem_functions.sqf"

reagentSystem_count_created = 0; //сколько создано реагентов
reagentSystem_count_destroyed = 0; //сколько удалено реагетов



reagentSystem_internal_lastEx = "";
reagentSystem_internal_lastObj = nullPtr;

reagentSystem_map_allReactions = createHashMap;

call reagentSystem_initReactions;