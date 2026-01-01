// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include "..\GameObjects\GameConstants.hpp"
#include "..\NOEngine\NOEngine.hpp"

//all events inherited from BaseProgressInfluenceEvent
#define interface_class(name) gameEvents_internal_list_interfaces pushBack (tolower #name); class(name)

gameEvents_internal_list_interfaces = [];
gameEvents_internal_map_createdEvents = createHashMap; //key(string) classname, value(int) count 
gameEvents_sys_getAllEventTypes = {
	//Тут проверка в нижнем регистре обязательно!
	getAllObjectsTypeOf(BaseProgressInfluenceEvent) - gameEvents_internal_list_interfaces
};

//all gameevents

#include "BaseEvent.sqf"
#include "Common.sqf"
#include "DirtpitEvents.sqf"