// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



regFireLight(FLIGHT_TEST)
	initLightObject();

	lightObject setposatl getposatl sourceObject;

	lightObject setLightBrightness 1.0;
	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));//(50 + 400 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];

	invokeAfterDelayParams(deleteVehicle _this,0.3,lightObject);

endRegFireLight


