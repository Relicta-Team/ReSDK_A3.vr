// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\engine.hpp>
#include <..\Networking\Network.hpp>
#include <..\ServerRpc\serverRpc.hpp>

#include "personServ.hpp"

personServ_map_mobs = createHashMap;

personServ_dummyObjFloor = objNull;

//регистрация сущности
personServ_registerMob = {
    params ["_mobIdAsOwner"];
    if isNullReference(personServ_dummyObjFloor) then {
        personServ_dummyObjFloor = "block_dirt" createVehicleLocal [0,0,0];
        personServ_dummyObjFloor setPosATL PERSONSERV_MOB_POS;
        personServ_dummyObjFloor setObjectTexture [0,""];
        personServ_dummyObjFloor setObjectMaterial [0,""];
    };

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
    personServ_map_mobs deleteAt _mobIdAsOwner;
    deleteVehicle _mob;
    true
};

personServ_getMobIdList = {
    keys personServ_map_mobs
};