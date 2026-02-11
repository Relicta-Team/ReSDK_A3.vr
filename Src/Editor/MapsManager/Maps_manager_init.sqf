// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

mm_use_alg2_vdir_check = true; // дополнительная валидация сериализации поворота/трансформации объекта

mm_folderSaveMaps = getMissionPath "src\host\MapManager\Maps\";
mm_internal_defaultMapExt = ".sqf";

#include "Maps_manager_importOld.sqf"
#include "Maps_manager_common.sqf"
#include "Maps_manager_virtualMap.sqf"