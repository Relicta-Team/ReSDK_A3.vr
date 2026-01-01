// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	GOAsm
	Низкоуровневая библиотека.
	содержит методы для работы с кодом, сборкой
*/

if (isnil{goasm_isbuilded} && !core_debug_skipBuilding) then {
	goasm_isbuilded = false;
};
goasm_attributes_map_hashData = createHashMap;
goasm_builder_postInit_delegate = {}; //то что выполнится после запуска билдера
goasm_builder_onError_delegate = {}; //пользовательский код, выполняющийся при ошибке компиляции
	goasm_builder_postInit_customSetup = false; //это значение отвечает за пользователькое выполнение постбилд кода (смотрите goasm_builder_setPostBuildCode)

#include "..\..\host\OOP_engine\oop_main_loader.sqf"

#include "GOAsm_oop_preinit.sqf"
#include "GOAsm_oop_builder.sqf"
#include "GOAsm_oop_attributes.sqf"
#include "GOAsm_providers.sqf"
#include "GOAsm_internalAPI_attributes.sqf"
#include "GOAsm_prefabCreator.sqf"