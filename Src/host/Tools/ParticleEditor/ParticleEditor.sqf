// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\client\WidgetSystem\widgets.hpp>
#include <..\..\engine.hpp>
#include <..\..\text.hpp>
#include <..\..\keyboard.hpp>
#include <ParticleEditor.hpp>

#include "ParticleEditor_defines.sqf"


ped_emitterObject = objnull;

ped_openMenu = {
	_d = call dynamicDisplayOpen;
	_d displayAddEventHandler ["KeyUp",{
		params ["_d","_key"];
		if (_key == KEY_J) exitWith {
			call ped_closeMenu;
		};
	}];

	_ctg = [_d,WIDGETGROUP,[30,30,40,40]] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,0.7];


};


ped_loadEmitterObject = {
	ped_emitterObject = "#particlesource" createVehicleLocal [0,0,0];
};

ped_unloadEmitterObject = {
	deleteVehicle ped_emitterObject;
};

ped_closeMenu = {
	call ped_unloadEmitterObject;
	call displayClose;
};
