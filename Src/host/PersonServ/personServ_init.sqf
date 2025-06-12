// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\engine.hpp>
#include <..\Networking\Network.hpp>
#include <..\ServerRpc\serverRpc.hpp>

#include "personServ.hpp"

personServ_map_mobs = createHashMap;

//регистрация сущности
personServ_registerMob = {
    params ["_mobIdAsOwner"];
    private _mob = [PERSONSERV_MOB_POS] call gm_createSimpleMob;
    personServ_map_mobs set [_mobIdAsOwner,_mob];

    //send var to local client
    netSendVar("personCli_localMobRef",_mob,_mobIdAsOwner);
    netSetGlobal(personCli_updateNeed,true);
};

//удаление сущности
personServ_unregisterMob = {
    params ["_mobIdAsOwner"];
    if !array_exists(personServ_map_mobs,_mobIdAsOwner) exitWith {false};

    private _mob = personServ_map_mobs get _mobIdAsOwner;
    personServ_map_mobs deleteAt _mob;
    deleteVehicle _mob;
    true
};

personServ_getMobIdList = {
    keys personServ_map_mobs
};