// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(OneSync;NULL)

/*
	Компонент клиентского освещения
*/

macro_const(os_light_updateDelay)
#define OS_LIGHT_UPDATE_DELAY 0.2
// влияет на частоту отправки сообщений. менять с осторожностью
macro_const(os_light_dataSendDelay)
#define OS_LIGHT_DATASEND_DELAY 1

decl(int)
os_light_handle_onupdate = -1;
decl(float)
os_light_lastTimeSendInfo = 0;
decl(vector2[])
os_light_list_noProcessedLights = []; //vec2 (light,intensity)

decl(void(bool))
os_light_setEnable = {
	params ["_mode"];
	if (_mode) then {
		os_light_lastTimeSendInfo = 0;
		private _ltUpd = OS_LIGHT_UPDATE_DELAY;
		#ifdef SP_MODE
		_ltUpd = 0.05;
		#endif
		os_light_handle_onupdate = startUpdate(os_light_onUpdate,_ltUpd);
	} else {
		stopUpdate(os_light_handle_onupdate);
		os_light_handle_onupdate = -1;
	};
};

decl(float())
os_light_getLighting = {
	{
		(_x select 0) setLightIntensity 0;
	} count os_light_list_noProcessedLights;
	
	//значения взяты с сервера. всё должно совпадать
	private _light = round linearConversion [10,60,(getLightingAt player) select 3,0,4,true];

	{
		(_x select 0) setLightIntensity (_x select 1);
	} count os_light_list_noProcessedLights;
	_light
};

decl(void())
os_light_onUpdate = {
	if (hud_stealth > 0) then {
		if (tickTime >= os_light_lastTimeSendInfo) then {
			os_light_lastTimeSendInfo = tickTime + OS_LIGHT_DATASEND_DELAY;
			
			hud_light = call os_light_getLighting;
			
			rpcSendToServer("os_lt",vec2(player,hud_light));
		};
	} else {
		if (hud_light != 0) then {hud_light = 0};
	};
};

decl(mesh(mesh;float))
os_light_registerAsNoProcessedLight = {
	params ["_lt","_intensity"];
	os_light_list_noProcessedLights pushBackUnique [_lt,_intensity];
	_lt
};
