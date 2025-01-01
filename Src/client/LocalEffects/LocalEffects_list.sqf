// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



effect(GhostNightVision)
	create
		_obj = call locef_createTempObject;
		_obj attachTo [player,[0,0,0],"head",true];
		updateContext(_obj);
		[
			[LIGHT_AREA_GHOST_NIGHTVISION,_obj] call le_loadLight
		] call os_light_registerAsNoProcessedLight;

		//jumpto(EFFECT_EVENT_INDEX_UPDATE);
	destroy
		[thisContext] call le_unloadLight;
		deleteVehicle thisContext;
	//update
		
end

effect(GhostPostprocess)
	create
		["ghost_color",true] call pp_setEnable;
		["ghost_color_overlay",true] call pp_setEnable;
		["ghost_grain",true] call pp_setEnable;
	destroy
		["ghost_color",false] call pp_setEnable;
		["ghost_color_overlay",false] call pp_setEnable;
		["ghost_grain",false] call pp_setEnable;
end

effect(EaterNightVision)
	create
		_obj = call locef_createTempObject;
		_obj attachTo [player,[0,0,0],"head",true];
		updateContext(_obj);
		[
			[LIGHT_AREA_EATER_NIGHTVISION,_obj] call le_loadLight
		] call os_light_registerAsNoProcessedLight;
		
		["eater_nightvision_color",true] call pp_setEnable;
	destroy
		[thisContext] call le_unloadLight;
		deleteVehicle thisContext;
		["eater_nightvision_color",false] call pp_setEnable;
end

effect(Footsteps)
	create
		vst_human_stealth_allowStepsounds = true;
	destroy
		vst_human_stealth_allowStepsounds = false;
end

effect(NightVision)
	create
	destroy
end

effect(HumanPostprocess)
	create
		["color_default",true] call pp_setEnable;
		["grain_default",true] call pp_setEnable;

	destroy
		["color_default",false] call pp_setEnable;
		["grain_default",false] call pp_setEnable;
end

effect(GenericAmbSound)
	create
		_obj = call locef_createTempObject;
		_obj attachTo [player,[0,0,0],"head",true];
		updateContext(_obj);
		//params ["_source","_class","_dist",["_pitch",1]
		[_obj,[_obj,"lp_gen_amb",20,[0.9,1.1]],40] call sound3d_playOnObjectLooped;
	destroy
		deleteVehicle thisContext;
end