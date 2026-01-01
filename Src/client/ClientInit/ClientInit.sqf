// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>

//first step - check dlls
#include "DllSignCheck.sqf"

//disable world map effects
setDetailMapBlendPars [1000, 1000];
setHorizonParallaxCoef 500;

//fix render distance #276
private _hasErrorRenderDistance = false;
if ((ceil(getVideoOptions get "objectVisibility") < 60) || (ceil(getVideoOptions get "overallVisibility") < 60)) then {
    _hasErrorRenderDistance = true;
};
if (_hasErrorRenderDistance) exitWith {
    rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","Увеличьте дистанцию прорисовки игровых объектов до 60 и выше."));
    endMission "LOSER";
};

if (!isMultiplayer && !cam_isEnabled) then {
    player switchcamera "Internal";
};


if (not_equals(relicta_version,client_version) && isMultiplayer) exitWith {
	errorformat("Version mismatch - %1 (required %2)",client_version arg relicta_version);
    endMission "LOSER";
};

_canload_ = true;
//validate gamma and squad
if (isMultiplayer) then {
    if (!(call widget_antiGammaCheck)) exitWith {
        _canload_ = false;
        error("Brightness or gamma is out of the acceptable range. Set the brightness and gamma value to 1");
        //endMission "LOSER";
        rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","На сервере запрещается изменение яркости и гаммы. " + widget_antiGamma_lastError));
    };
    
    {
        if not_equals(_x,"") exitWith {
            _canload_ = false;
            error("Squad protection activated");
            rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","Никаких нашивок! На сервере запрещена установка отряда через лаунчер. Снимите флажок со своего отяда в лаунчере Arma3 и повторите вход."));
        };
    } foreach ((squadParams player) select 0);
};
if (!_canload_) exitWith {error("Unknown reason of cannot load client")};

player allowDamage false;

call vs_audio_init;

client_sys_loaded = true; //flag for skip static asserts on client

// initialization discord rpc
_drpc = {call discrpc_init;};
if (!isMultiplayer) then {
    invokeAfterDelay(_drpc,0);
} else {
    call _drpc;
};

//adding remove client code
__uiCode_onDisconnect = {
    "DiscordRichPresence" callExtension ["CloseRichPresence",[]];
    uiNamespace setvariable ["isNonFirstLoad",true];
    setAperture 100000;
};

uiNamespace setvariable ["relicta_onRemoveClientCode",__uiCode_onDisconnect];


//Fix - 0.7.579: решает проблему зависших динамических дисплеев при кике локального клиента
if (isMultiplayer) then {
    [] SPAWN {
        uisleep 2;

        client_internal_lastchecknet = netTickTime - 1;
        
        while {true} do {
            
            if (cba_missiontime == client_internal_lastchecknet) exitwith {
                _d = (findDisplay 10000);    
                if !(iSNULL _d) then {
                    if (_d getVariable ["$dynflag$",false]) then {
                        _d closeDisplay 0;
                    };
                };
                if (userInputDisabled) then {
                    disableUserInput false;
                };
            };   
            client_internal_lastchecknet = netTickTime;
            uisleep 1;
        };
    };
};

_owner = if (isServer) then {0} else {clientOwner};
[true] call setBlackScreenGUI;
["Station"] call ct_load;
_data = [_owner];

//init clientside structures only in mp-mode
if (isMultiplayer) then {
    call struct_initialize;
};

if (!isMultiplayer) then {
    #ifndef SP_MODE
        //против задержки пакетов
        invokeAfterDelayParams({rpcSendToServer("onClientReady",_this)},0.3,_data)
    #endif
} else {
    rpcSendToServer("onClientReady",_data);
};
