// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\client\WidgetSystem\widgets.hpp>
#include <..\..\engine.hpp>
#include <..\..\text.hpp>
#include <..\..\keyboard.hpp>


#include "LightEditor.hpp"

led_openMenu = {

	log("OPENED LightEditor");

	private _d = call dynamicDisplayOpen;

	logformat("Display is %1",_d);

	_d displayAddEventHandler ["KeyUp",{
		params ["_d","_key"];

		if (_key == KEY_K) exitWith {
			call led_closeMenu;
		};
	}];
	_d displayAddEventHandler ["MouseButtonUp",{
		params ["_d","_key"];

		if (_key == MOUSE_LEFT) then {
			call led_teleportEmitterToMouse;
		} else {
			led_hasPressedModRightMouse = false;
		}

	}];
	_d displayAddEventHandler ["MouseButtonDown",{
		if equals(_this select 1,MOUSE_RIGHT) then {led_hasPressedModRightMouse = true}
	}];
	_d displayAddEventHandler ["MouseZChanged",led_onChangeZEmitter];

	//remove old pointers
	led_widgets = [];
	led_ambientWidgets = [];

	_ctg = [_d,WIDGETGROUP,[60,30,40,40]] call createWidget;
	led_widgets_system = [_ctg];
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [1,0,0,0.4];
	logformat("ctg is %1, back is %2", _ctg arg _back);


	//reloading emitter object
	if (!isNULL emitter) then {
		call led_removeEmitterObject;
	};
	call led_loadEmitterObject;


	//======================================load widgets======================================

	#define setDesc(text) _ct ctrlSetTooltip (text)
	#define setAttr(name,val) _ct setvariable [name,val]

	#define iniCateg(text) _n_c = ([_d,TEXT,[_xPos,_yPos,30,10],_ctg] call createWidget); \
	[_n_c,"<t align='center'>" + text + "</t>"] call widgetSetText; \
	_n_c setBackgroundColor [0,0.1,0,0.4]

	#define iniButtonPresser _ct ctrlAddEventHandler ["MouseButtonUp",{params ["_b"];\
	_enum = _b getVariable "enum";

	#define end_iniButtonPresser call led_applySettings}];

	#define iniInputPresser _ct ctrlAddEventHandler ["KeyUp",{params ["_b"]; \
	_enum = _b getVariable "enum";

	#define end_iniInputPresser call led_applySettings}];

	#define iniSliderPresser _ct ctrlAddEventHandler ["SliderPosChanged",{params ["_b","_value"]; \
	_enum = _b getVariable "enum";

	#define end_iniSliderPresser call led_applySettings}];

	_xPos = 0;
	_yPos = 0;

	iniCateg("Flare settings");
	MOD(_yPos,+10);
	//button - useflare
	_ct = [BUTTON,[_xPos,_yPos,30,10],enum_useflare] call led_createWidget;
	_ct ctrlSetText "use flare";
	iniButtonPresser

		_old = !getSetting(_enum);

		setSetting(_enum,_old);
		setLightUseFlare(_old);
		logformat("Now use flare is %1",_old);
	end_iniButtonPresser


	//input - flaresize
	MOD(_yPos,+10);
	_ct = [INPUT,[_xPos,_yPos,30,10],enum_flaresize] call led_createWidget;
	setDesc("Flare size");
	iniInputPresser
		_text = ctrlText _b;
		_num = parseNumber _text;
		setSetting(_enum,_num);
		setLightFlareSize(_num);
	end_iniInputPresser

	//input - flaremaxdist
	MOD(_yPos,+10);
	_ct = [INPUT,[_xPos,_yPos,30,10],enum_flaredist] call led_createWidget;
	setDesc("Flare max distance");
	iniInputPresser
		_text = ctrlText _b;
		_num = parseNumber _text;
		setSetting(_enum,_num);
		setLightFlareMaxDistance(_num);
	end_iniInputPresser



	MOD(_yPos,+10);
	iniCateg("Common light config");



	//input - brightness
	MOD(_yPos,+10);
	_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_brightness] call led_createWidget;
	setDesc("Light brightness");
	/*iniInputPresser
		_text = ctrlText _b;
		_num = parseNumber _text;
		setSetting(_enum,_num);
		setLightBrightness(_num);
	end_iniInputPresser*/
	_ct sliderSetRange [0,10000];
	iniSliderPresser
		//_arr = getSetting(_enum);
		_newVal = _value / 100;
		log("New brightness " + str _newVal);
		setSetting(_enum,_newVal);
		setLightBrightness(_newVal);
	end_iniSliderPresser

	//light color
		//r - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_lc] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light color RED");
		setAttr("isColor",0);
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,0,_newVal);
			setSetting(_enum,_arr);
			setLightColor(_arr);
		end_iniSliderPresser
		//g - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_lc] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light color GREEN");
		setAttr("isColor",1);
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,1,_newVal);
			setSetting(_enum,_arr);
			setLightColor(_arr);
		end_iniSliderPresser
		//b - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_lc] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light color BLUE");
		setAttr("isColor",2);
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,2,_newVal);
			setSetting(_enum,_arr);
			setLightColor(_arr);
		end_iniSliderPresser

	//input - light intensity
	MOD(_yPos,+10);
	_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_intensity] call led_createWidget;
	setDesc("Light intensity");
	/*iniInputPresser
		_text = ctrlText _b;
		_num = parseNumber _text;
		setSetting(_enum,_num);
		setLightIntensity(_num);
	end_iniInputPresser*/
	_ct sliderSetRange [0,10000];
	iniSliderPresser
		//_arr = getSetting(_enum);
		_newVal = _value;
		setSetting(_enum,_newVal);
		setLightIntensity(_newVal);
	end_iniSliderPresser


	_ypos =0 ;
	MOD(_xPos,+30);
	iniCateg("Ambient settings");

	//light ambient
		//r - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_ambient] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light ambient RED");
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,0,_newVal);
			setSetting(_enum,_arr);
			setLightAmbient(_arr);
		end_iniSliderPresser
		//g - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_ambient] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light ambient GREEN");
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,1,_newVal);
			setSetting(_enum,_arr);
			setLightAmbient(_arr);
		end_iniSliderPresser
		//b - slider
		MOD(_yPos,+10);
		_ct = [SLIDERWNEW,[_xPos,_yPos,30,10],enum_ambient] call led_createWidget;
		_ct sliderSetRange [0,pointSizeColor];
		setDesc("light ambient BLUE");
		iniSliderPresser
			_arr = getSetting(_enum);
			_newVal = _value / pointSizeColor;
			SETARR(_arr,2,_newVal);
			setSetting(_enum,_arr);
			setLightAmbient(_arr);
		end_iniSliderPresser

	// Места не хватает
	//MOD(_yPos,+10);
	//iniCateg("окружающий цвет");



	//light attenuation
		//------------(all are inputs)------------
		// start
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("START");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,0,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser
		//constant
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("constant");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,1,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser
		// linear
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("linear");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,2,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser
		//quadratic
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("quadratic");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,3,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser
		//hardlimitstart
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("hardlimitstart");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,4,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser
		//hardlimitend
		MOD(_yPos,+10);
		_ct = [INPUT,[_xPos,_yPos,30,10],enum_atten] call led_createWidget;
		setDesc("hardlimitend");
		iniInputPresser
			_text = ctrlText _b;
			_num = parseNumber _text;

			_arr = getSetting(_enum);
			SETARR(_arr,5,_num);

			setSetting(_enum,_arr);
			setLightAttenuation(_arr);
		end_iniInputPresser

	_ypos =0 ;
	MOD(_xPos,+30);
	iniCateg("Modifier");

	MOD(_yPos,+10);
	_ct = [BUTTON,[_xPos,_yPos,30,10],enum_useflare] call led_createWidget;
	_ct ctrlSetText "Sync color=>ambient";
	iniButtonPresser

		call led_syncColorToAmbient;

	end_iniButtonPresser

	led_hasNeedUpdate = true;
	led_perFramehandler = startUpdate(led_onUpdateEmitterPref,LED_TIME_ONUPDATE);
};

led_createWidget = {
	params ["_type","_pos","_enum"];

	private _newWid = [_d,_type,_pos,_ctg] call createWidget;

/*	call {
		if (_type == BUTTON) exitWith {

		};
		if (_type == INPUT) exitWith {};
	};*/

	_newWid setvariable ['enum',_enum];

	if (_enum == enum_ambient) then {
		led_ambientWidgets pushBack _newWid;
	};

	//TODO setting variables
	led_widgets pushback _newWid;

	_newWid
};

// if one or more light settings changed - reload all settings (global update)
led_onUpdateEmitterPref = {
	if (!led_hasNeedUpdate) exitWith {};
	/*

	ambientLightColor: Color (RGB)
	ambientLightBrightness: Number
	lightDirection: Vector3D

	*/
	/*(getLightingAt player) params ["_colorAx","_brightAx","_colorA","_brightA"];

	logformat("[ReLED] Color: %1",_colorA);
	logformat("[ReLED] Bright: %1",_brightA);*/

	//logformat("%1",(getLightingAt player));
};

led_closeMenu = {
	call led_led_removeEmitterObject;

	stopUpdate(led_perFramehandler);
	led_perFramehandler = -1;
	call displayClose;
};

led_loadEmitterObject = {
	emitter = "#lightpoint" createVehicleLocal [0,0,0];
	emitter setPosAtl ((getposatl player) vectorAdd [0,0,1])
};

led_led_removeEmitterObject = {
	deleteVehicle emitter;
};

led_applySettings = {

	setLightUseFlare(getSetting(enum_useflare));
	setLightFlareSize(getSetting(enum_flaresize));
	setLightFlareMaxDistance(getSetting(enum_flaredist));
	setLightBrightness(getSetting(enum_brightness));
	setLightColor(getSetting(enum_lc));
	setLightIntensity(getSetting(enum_intensity));
	setLightAmbient(getSetting(enum_ambient));
	setLightAttenuation(getSetting(enum_atten));

};

led_teleportEmitterToMouse = {
	_ctg = led_widgets_system select 0;
	if (_ctg call isMouseInsideWidget) exitWith {};

	private _angle = (getCameraViewDirection player) select 2;

	private _maxDist = if (_angle < -0.2) then {
		AGLToASL (screenToWorld getMousePosition);
	} else {
		AGLToASL (positionCameraToWorld [0,0,100000])
	};

	private _itsc = lineIntersectsSurfaces [AGLToASL(positionCameraToWorld[0,0,0]),_maxDist,player,emitter,true,1,"VIEW","FIRE"];

	if ((count _itsc) == 0) exitWith {};

	(_itsc select 0) params ["_pos","_vecup","_targ"];

	emitter setposatl (ASLToATL _pos);
};

led_onChangeZEmitter = {
	params ["_displayorcontrol", "_value"];
	_ctg = led_widgets_system select 0;
	if (_ctg call isMouseInsideWidget || !led_hasPressedModRightMouse) exitWith {};

	_pos = getPosATL emitter;

	if (_value < 0) then {
		MODARR(_pos,2,-1);
		logformat("pos %1 ",_pos);
		emitter setposatl _pos;
	} else {
		MODARR(_pos,2,+1);
		emitter setposatl _pos;
	};

	logformat("(%2:%3) Now pos is %1", _pos arg _value arg _value < 0);
};

led_syncColorToAmbient = {
	_color = +getSetting(enum_lc);

	setSetting(enum_ambient,_color);
	setLightAmbient(_color);

	{
		if ((_x getVariable ["isColor",-1]) >= 0) then {
			_index = (_x getVariable "isColor");
			_val = (_color select _index) * pointSizeColor;
			(led_ambientWidgets select _index) sliderSetPosition _val;
		};
	} foreach led_widgets;
};


led_saveCurrentConfig = {

};

led_loadConfigFromClipboard = {

};
