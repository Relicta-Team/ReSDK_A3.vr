// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


sltInit(LIGHT_FIRE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.2,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0.28,0.05));
	lightObject setLightBrightness 0.27;
	lightObject
};

sltInit(LIGHT_CAMPFIRE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.17,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,0.05));
	lightObject setLightBrightness 0.5;
	lightObject
};

sltInit(LIGHT_SIGARETTE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(-0.1,0,-.05));
	lightObject setLightBrightness 4.34;
	lightObject
};
sltInit(LIGHT_CAMPFIRE_BIG)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.3];
	lightObject setLightAmbient [0.17,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(-0.1,0,-.05));
	lightObject setLightBrightness 0.5;
	lightObject
};

sltInit(LIGHT_LAMP_KEROSENE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.4];
	lightObject setLightAmbient [0.15,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,0.05));
	lightObject setLightBrightness 1.0;
	lightObject
};

sltInit(LIGHT_CANDLE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.2,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,0.07));
	lightObject setLightBrightness 0.09;
	lightObject
};

sltInit(LIGHT_BAKE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.17,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(-0.75,1,-3.75));
	lightObject setLightBrightness 0.5;
	lightObject
};

sltInit(LIGHT_BAKESTOVE)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.17,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,0.07));
	lightObject setLightBrightness 0.5;
	lightObject
};

sltInit(LIGHT_MATCH)
{
	lightObject = slt_createLight();

	lightObject setLightColor [1,0.65,0.5];
	lightObject setLightAmbient [0.2,0.05,0];
	lightObject setLightIntensity (25 + 10 * ((1 + 1) / 2));
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(-0.06,0,-0.02));
	lightObject setLightBrightness 0.043;
	lightObject
};

// ================= electronics =================
sltInit(LIGHT_LAMP_WALL)
{
	lightObject = slt_createLight();

	lightObject setLightColor [0.016,0.012,0.012];
	lightObject setLightAmbient [0.022,0.023,0.013];
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,-1));
	lightObject setLightBrightness 1.43;
	lightObject
};

sltInit(LIGHT_LAMP_CEILING)
{
	lightObject = slt_createLight();

	lightObject setLightColor [0.016,0.012,0.012];
	lightObject setLightAmbient [0.022,0.023,0.013];
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,-1));
	lightObject setLightBrightness 0.843;
	lightObject
};

sltInit(LIGHT_STREETLAMP)
{
	lightObject = slt_createObj("Land_LampShabby_F");
	linkToSource(lightObject,vec3(0,0,0));
	lightObject
};
sltInit(LIGHT_FLASHLIGHT)
{
	lightObject = slt_createObj("SAN_HeadLight_white_hi");
	linkToSource(lightObject,vec3(0,0,0));
	lightObject
};

sltInit(LIGHT_SIGN_BAR)
{
	lightObject = slt_createLight();

	lightObject setLightColor [0.013,0.001,0];
	lightObject setLightAmbient [0.013,0.001,0];
	lightObject setLightAttenuation [0,50,3,700,4,1];
	linkLightToSource(lightObject,vec3(0,0,0));
	lightObject setLightBrightness 15;
	lightObject
};
sltInit(LIGHT_SIGN_MEDICAL)
{
	lightObject = slt_createLight();

	lightObject setLightColor [0,0.13,0.15];
	lightObject setLightAmbient [0,0.18,0];
	lightObject setLightAttenuation [0.3,38,70,1.5,1.1,3.5];
	linkLightToSource(lightObject,vec3(-0.1,0,0));
	lightObject setLightBrightness 2.15;
	lightObject
};


sltInit(LIGHT_LAMP_CEILING_REDLIGHT)
{
	lightObject = slt_createLight();

	lightObject setLightColor [0.08,0.035,0.012];
	lightObject setLightAmbient [0.169,0.009,0.009];
	lightObject setLightAttenuation [0,0,0,1];
	linkLightToSource(lightObject,vec3(0,0,-1));
	lightObject setLightBrightness 0.843;
	lightObject
};
