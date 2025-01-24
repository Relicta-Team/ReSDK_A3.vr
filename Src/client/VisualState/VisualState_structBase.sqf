// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Structs\AttachedObjects.sqf"
#include "Structs\BreastPlate.sqf"
#include "Structs\CeramicArmor.sqf"
#include "Structs\Ghost.sqf"
#include "Structs\MetalArmor.sqf"
#include "Structs\NightVision.sqf"
#include "Structs\Stealth.sqf"
#include "Structs\StrongArmor.sqf"

//todo
//barreled armor
//"a3\props_f_enoch\military\garbage\garbagebarrel_02_f.p3d"

//FlexibleArmor
//"a3\structures_f\civ\camping\sleeping_bag_folded_f.p3d"
//"Land_Sleeping_bag_folded_F"
//TODO implement steel armor


struct(VSTBase)
    def(name) "" //must be defined

    def(str)
    {
        format["VSTConfig<%1>",self getv(name)]
    }

    def(_src) objNull

    def(getLocalPlayer)
    {
        __LOCAL_PLAYER__ //external reference
    }

    def(init)
    {
        params ["_src"];
        self setv(_src,_src);
    }

    def(onCreated)
    {
        params ["_ctx"];
    }

    def(onDestroy)
    {
        params ["_ctx"];
    }
endstruct