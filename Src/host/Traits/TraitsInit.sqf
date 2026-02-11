// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\text.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <..\Networking\Network.hpp>

traits_viceGlobalList = [];
traits_viceMap = createHashMap;
private _lastViceIndex = -1;
#include "vices.sqf"


traits_getViceDescByClass = {
	params ["_viceClass"];
	if (_viceClass == "rand") exitWith {
		"Выпадает один из случайных пороков. С 60% вероятностью порока может не быть."
	};
	traits_viceMap get _viceClass select 1
};


netSetGlobal(lobby_viceList,traits_viceGlobalList);