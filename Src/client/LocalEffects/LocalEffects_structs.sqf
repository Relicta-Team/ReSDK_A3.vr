// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

struct(LocEffBase)
    decl(string) def(name) ""

    decl(any) def(_context) null;

    decl(string) def(str)
    {
        format["LocalEffect<%1>",self getv(name)]
    }

    decl(void()) def(create) 
    {

    }

    decl(void()) def(destroy) 
    {

    }

    decl(void()) def(update) 
    {

    }

    decl(void(any)) def(updateContext)
    {
        params ["_ctx"];
        self setv(_context,_ctx);
    }

    decl(any())
    def(getContext)
    {
        self getv(_context);
    }
endstruct

struct(LocEffGhostNightVision) base(LocEffBase)
    decl(override) def(name) "GhostNightVision"

    decl(override) def(create)
    {
        private _obj = call locef_createTempObject;
		_obj attachTo [player,[0,0,0],"head",true];
        self callp(updateContext,_obj);
        ["SLIGHT_AREA_GHOST_NIGHTVISION" call lightSys_getConfigIdByName,_obj] call le_loadLight;
    }

    decl(override) def(destroy)
    {
        [self callv(getContext)] call le_unloadLight;
        deleteVehicle (self callv(getContext));
    }
endstruct

struct(LocEffGhostPostprocess) base(LocEffBase)
    decl(override) def(name) "GhostPostprocess"

    decl(override) def(create)
    {
        ["ghost_color",true] call pp_setEnable;
        ["ghost_color_overlay",true] call pp_setEnable;
        ["ghost_grain",true] call pp_setEnable;
    }

    decl(override) def(destroy)
    {
        ["ghost_color",false] call pp_setEnable;
        ["ghost_color_overlay",false] call pp_setEnable;
        ["ghost_grain",false] call pp_setEnable;
    }
endstruct

struct(LocEffEaterNightVision) base(LocEffBase)
    decl(override) def(name) "EaterNightVision"

    decl(override) def(create)
    {
        private _obj = call locef_createTempObject;
        _obj attachTo [player,[0,0,0],"head",true];
        self callp(updateContext,_obj);
        ["SLIGHT_AREA_EATER_NIGHTVISION" call lightSys_getConfigIdByName,_obj] call le_loadLight;

        ["eater_nightvision_color",true] call pp_setEnable;
    }

    decl(override) def(destroy)
    {
        [self callv(getContext)] call le_unloadLight;
        deleteVehicle (self callv(getContext));
        ["eater_nightvision_color",false] call pp_setEnable;
    }
endstruct

struct(LocEffFootstep) base(LocEffBase)
    decl(override) def(name) "Footstep"

    decl(override) def(create)
    {
        vst_human_stealth_allowStepsounds = true;
    }

    decl(override) def(destroy)
    {
        vst_human_stealth_allowStepsounds = false;
    }
endstruct

struct(LocEffNightVision) base(LocEffBase)
    decl(override) def(name) "NightVision"

    decl(override) def(create) {}
    decl(override) def(destroy) {}
endstruct

struct(LocEffHumanPostprocess) base(LocEffBase)
    decl(override) def(name) "HumanPostprocess"

    decl(override) def(create)
    {
        ["color_default",true] call pp_setEnable;
        ["grain_default",true] call pp_setEnable;
    }

    decl(override) def(destroy)
    {
        ["color_default",false] call pp_setEnable;
        ["grain_default",false] call pp_setEnable;
    }
endstruct

struct(LocEffGenericAmbSound) base(LocEffBase)
    decl(override) def(name) "GenericAmbSound"

    decl(override) def(create)
    {
        private _obj = call locef_createTempObject;
        _obj attachTo [player,[0,0,0],"head",true];
        self callp(updateContext,_obj);
        //params ["_source","_class","_dist",["_pitch",1]
        [_obj,[_obj,"lp_gen_amb",20,[0.9,1.1]],40] call sound3d_playOnObjectLooped;
    }

    decl(override) def(destroy)
    {
        deleteVehicle (self callv(getContext));
    }
endstruct