// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


led_widgets_system = [];
led_widgets = [];
led_ambientWidgets = [];
led_emitterObject = objnull;

led_hasPressedModRightMouse = false;

#define LED_TIME_ONUPDATE 0.05
led_perFramehandler = -1;
led_hasNeedUpdate = false;

//точность расчётов с цветом
#define pointSizeColor 1000


#define getSetting(enum) (led_config select (enum))
#define setSetting(enum,newval) led_config set [enum,newval]

#define enum_useflare 0
#define enum_flaresize 1
#define enum_flaredist 2
#define enum_brightness 3
#define enum_lc 4
#define enum_intensity 5
#define enum_ambient 6
#define enum_atten 7

led_config = [
	false,
	0,
	10,
	1,
	[0,0,0],
	0,
	[0,0,0],
	[0,0,0,0,0,0]
];

#define loadLedWidget(type,pos,text) [type,pos,text] call led_createWidget


/*
====================================================================================================
		GROUP: COMMON EMITTER MAINPULATION FUNCTIONS
====================================================================================================
*/




#define emitter led_emitterObject

//Установите яркость света.
#define setLightBrightness(val) emitter setLightBrightness (val)

//Установите окружающий цвет света. Сюда входят поверхности, которые обращены в сторону от света, в отличие от setLightColor .
#define setLightAmbient(val) emitter setLightAmbient (val)

/*
	[start, constant, linear, quadratic, hardlimitstart, hardlimitend]: массив
		start: Number - дистанция со 100% интенсивностью, здесь начинается спад
		constant: Number - постоянный коэффициент затухания
		linear: Number - коэффициент линейного затухания
		quadratic: Number - квадратичный коэффициент затухания
		hardlimitstart (Необязательно): Number - максимальное расстояние начала жесткого ограничения (начало постепенного уменьшения интенсивности до 0) в м
		hardlimitend (Необязательно): Number - максимальное расстояние до конца жесткого ограничения (конец затухания интенсивности до 0) в м

	Устанавливает ослабление света.
	Параметр start представляет собой расстояние, на котором начинает действовать затухание (dist = distance - start).

	Стандартный метод затухания: (1 / (constant + linear*dist + quadratic*dist*dist))

*/
#define setLightAttenuation(val) emitter setLightAttenuation (val); logformat("NEW ATTEN - %1",val)

//Установите рассеянный цвет света. Освещает поверхности, обращенные к свету.
#define setLightColor(val) emitter setLightColor (val)

//Устанавливает интенсивность света.
#define setLightIntensity(val) /*emitter setLightIntensity (val)*/

//Устанавливается, если на свете есть блики.
#define setLightUseFlare(val) emitter setLightUseFlare (val)

//Устанавливает относительный размер блика для света.
#define setLightFlareSize(val) emitter setLightFlareSize (val)

//Устанавливает максимальное расстояние, на котором виден блик.
#define setLightFlareMaxDistance(val) emitter setLightFlareMaxDistance (val)