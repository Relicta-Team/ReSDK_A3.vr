// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//[true,30,0,6.57,[0.032,0.369,0.088],0,[0.097,0.085,0.029],[0,0,0,0,0,0]]
//[false,0,10,7.69,[0.043,0.036,0],0,[0.005,0.006,0],[15,30,80,5,10,40]]
regLight(LIGHT_AREA_EATER_NIGHTVISION)
	
	lightObject setLightIntensity 200;
	initBrightness(7.69);
	lightObject setLightColor [0.043,0.036,0];
	lightObject setLightAmbient [0.005,0.006,0];
	lightObject setLightAttenuation [15,30,80,5,10,40];
	
	
	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0));

	addEventOnDestroySource(lightObject);
endRegLight

regLight(LIGHT_AREA_GHOST_NIGHTVISION)
	
	lightObject setLightIntensity 200;
	initBrightness(7.69);
	lightObject setLightColor [0.043,0.036,0];
	lightObject setLightAmbient [0.005,0.006,0];
	lightObject setLightAttenuation [15,30,80,5,10,40];
	//obj = lightObject;
	
	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0));

	addEventOnDestroySource(lightObject);
endRegLight

regLight(LIGHT_TRAP_HIDDEN_EFFECT)	
	
	linkLight(lightObject,player,vector(0,0,0));
	linkLight(lightObject,sourceObject,vector(0,0,0));

	addEventOnDestroySource(lightObject);
	
	[sourceObject] call traps_checkKnownObject;
	//auto logic of cleanup trap
	private _event = {
		(_this select 0) params ["_light","_ref"];
		if isNullReference(_light) then {
			stopThisUpdate();
			[_ref] call traps_AutoDispose;
		};
	};
	startUpdateParams(_event,0.1,[lightObject,sourceObject getVariable "ref"]);
endRegLight