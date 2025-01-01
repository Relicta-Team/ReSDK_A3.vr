// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


vst_human_stealth_allowStepsounds = true;

regVST(VST_HUMAN_STEALTH)
	private _eaterHead = "eater_headobject";
	private _attachedObjects = "attached_objects";
	//localPlayer = objnull;
	VSTCreate {
		if equals(localPlayer,src) then {
			//no action for local player
			hud_stealth = 1;
			vst_human_stealth_allowStepsounds = false;
		} else {
			src hideObject true;
			[src,false] call smd_setSlotDataProcessor;
			if ([src,_eaterHead,VST_EATER_NIGHTVISION] call le_vst_hasVarExt) then {
				([src,_eaterHead,VST_EATER_NIGHTVISION] call le_vst_getVarExt) hideObject true;
			};
			if ([src,_attachedObjects,VST_EATER_NIGHTVISION] call le_vst_hasVarExt) then {
				([src,_attachedObjects,VST_EATER_NIGHTVISION] call le_vst_getVarExt) hideObject true;
			};
		};
	};
	VSTDestroy {
		
		if equals(localPlayer,src) then {
			//no action for local player
			hud_stealth = 0;
			vst_human_stealth_allowStepsounds = true;
		} else {
			src hideObject false;
			[src,true] call smd_setSlotDataProcessor;
			if ([src,_eaterHead,VST_EATER_NIGHTVISION] call le_vst_hasVarExt) then {
				([src,_eaterHead,VST_EATER_NIGHTVISION] call le_vst_getVarExt) hideObject false;
			};
			if ([src,_attachedObjects,VST_EATER_NIGHTVISION] call le_vst_hasVarExt) then {
				([src,_attachedObjects,VST_EATER_NIGHTVISION] call le_vst_getVarExt) hideObject false;
			};
		};
	};
endRegVST
