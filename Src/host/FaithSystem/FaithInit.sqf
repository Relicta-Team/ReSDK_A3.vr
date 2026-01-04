// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\Networking\Network.hpp>

faith_map = createHashMap;

#include "FaithList.sqf"

//after registered all faiths sync this to clients
netSetGlobal(lobby_faithList,parseSimpleArray str faith_map);