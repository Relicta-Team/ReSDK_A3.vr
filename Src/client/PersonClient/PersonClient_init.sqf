// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
    PersonClient subsystem

    Используется для предпросмотра одежды\шапок
    Так же может использоваться для фотографий персонажей или осмотра в зеркале

*/

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include "..\..\host\PersonServ\personServ.hpp"

//extern (rpc) personCli_localMobRef

personCli_rttCamera = "camera" camCreate [0,0,0]; //камера для рендеринга

/*
    Переменная рассылается сервером
    Вариант использования обработчика entityCreated рассматривался но возможно это вызовет куда большие проблемы нагрузки на клиент
*/
personCli_updateNeed = false;

personCli_getAllMobs = {
    PERSONSERV_MOB_POS nearEntities 20;
};

//тред регулярного обновления и синхронизации видимости
personCli_onUpdate = {
    if (personCli_updateNeed) then {
        personCli_updateNeed = false;
        call personCli_syncLocalVisibility;
    };
};


personCli_localMobObjCached = objNull; //кешированный объект локальной персоны

//получает локальную персону для клиента
personCli_getLocalMob = {
    if !isNullReference(personCli_localMobObjCached) exitWith {
        personCli_localMobObjCached
    };

    private _m = objNull;
    {
        if equals(_locId,_x) exitWith {
            _m = _x;
        };
    } foreach (call personCli_getAllMobs);
    
    personCli_localMobObjCached = _m;
    
    _m
};

//синхронизация видимости. мы видим только свою локальную персону.
personCli_syncLocalVisibility = {
    private _locId = ifcheck(isNull(personCli_localMobRef),-1,personCli_localMobRef);

    {
        _x hideObject (!equals(_locId,_x));
        false
    } count (call personCli_getAllMobs);
};

//установка опции локального клиента
personCli_setStat = {
    params ["_stateName","_val"];
    //TODO  if val empty string reset stat to default (removeUniform/removeVest etc...)
    private _per = call personCli_getLocalMob;
    if equals(_stateName,"face") exitWith {
        _per setFace _val;
    };
    if equals(_stateName,"cloth") exitWith {
        _per forceAddUniform _val;
    };
    if equals(_stateName,"armor") exitWith {
        _per addVest _val;
    };
    if equals(_stateName,"backpack") exitWith {
        _per addBackpack _val;
    };
    if equals(_stateName,"mask") exitWith {
        _per addGoggles _val;
    };
    if equals(_stateName,"helmet") exitWith {
        _per addHeadgear _val;
    };
};

personCli_cloneCharVisualFromPlayer = {
    //todo implement (для осмотра себя в зеркале)
};

personCli_prepCamera = {
    params [["_fov",0.16]];
    private _per = call personCli_getLocalMob;
    personCli_rttCamera cameraEffect ["terminate", "back"];
    personCli_rttCamera cameraEffect ["INTERNAL", "BACK", "person_cli_rendertarget"];
	private _campos = (_per modeltoworldvisual (_per selectionPosition "head"));
	personCli_rttCamera setposatl (_campos vectoradd [0,1,0.15]);
	personCli_rttCamera campreparetarget (_camPos vectoradd [-0.05,0,0.11]);
	personCli_rttCamera camSetFov _fov;
	personCli_rttCamera camcommitprepared 0;
};

personCli_setPictureRenderTarget = {
    params ["_pic"];
    _pic ctrlSetText "#(argb,512,512,1)r2t(person_cli_rendertarget,1)";
};

personCli_internal_threadHandle = startUpdate(personCli_onUpdate,0);