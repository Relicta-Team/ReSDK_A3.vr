// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

#include <..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

//todo
//barreled armor
//"a3\props_f_enoch\military\garbage\garbagebarrel_02_f.p3d"

//FlexibleArmor
//"a3\structures_f\civ\camping\sleeping_bag_folded_f.p3d"
//"Land_Sleeping_bag_folded_F"
//TODO implement steel armor


struct(VSTBase)
    decl(string) def(name) "" //must be defined

    decl(string()) def(str)
    {
        format["VSTConfig<%1>",self getv(name)]
    }

    decl(actor) def(_src) objNull

    decl(actor()) def(getLocalPlayer)
    {
        __LOCAL_PLAYER__ //external reference
    }

    decl(void(actor)) def(init)
    {
        params ["_src"];
        self setv(_src,_src);
    }

    decl(void(any[])) def(onCreated)
    {
        params ["_ctx"];
    }

    decl(void(any[])) def(onDestroy)
    {
        params ["_ctx"];
    }
endstruct