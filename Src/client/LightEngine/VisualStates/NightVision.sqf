// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



regVST(VST_EATER_NIGHTVISION)
	_dummyObjRef = "eater_nightvision_dummyobj";
	_headObjRef = "eater_headobject";
	
	VSTCreate {
		if equals(localPlayer,src) then {
			private _dummy = [] call le_vst_createDummyObj;
			[src,_dummyObjRef,_dummy] call le_vst_regVar;
			_dummy attachTo [src,[0,0,0],"head",true];
			
			//create NightVision
			//[
			//	[LIGHT_AREA_EATER_NIGHTVISION,_dummy] call le_loadLight
			//] call os_light_registerAsNoProcessedLight;
			
			//["eater_nightvision_color",true] call pp_setEnable;
			
			
		} else {
			/* /"relicta_models\models\mutants\bloatfly.p3d" */
			private _object = ["relicta_models\models\mutants\bloatfly.p3d",false] call le_vst_createDummyObj;
			
			private _posData = [[-0.053,0.017,-0.024],[180,-55,0]];
			_object disableCollisionWith player;
			_object attachTo [src,_posData select 0,"head",true];
			[_object,_posData select 1] call BIS_fnc_setObjectRotation;
		
			//fix lagvector after 0.8.147
			_object attachTo [src,_posData select 0,"head",true];
			_object setobjectScale 0.7;
			[src,_headObjRef,_object] call le_vst_regVar;
		};
		
	};
	VSTDestroy {
		_dummy = [src,_dummyObjRef] call le_vst_getVar;
		if !isNullVar(_dummy) then {
			//[_dummy] call le_unloadLight;
			[src,_dummyObjRef] call le_vst_remVar;
			deleteVehicle _dummy;
			//["eater_nightvision_color",false] call pp_setEnable;
		};
		_head = [src,_headObjRef] call le_vst_getVar;
		if !isNullVar(_head) then {deleteVehicle _head};
	};
endRegVST