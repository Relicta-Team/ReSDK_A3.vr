// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(drawNames_init)
{
	drawNames_enabled = false;
	drawNames_distance = 50; //default value
	drawNames_const_updateDelay = 0.7;


	drawNames_internal_lastUpdate = 0;

	drawNames_internal_list_collectedOjbects = [];

	["onFrame",drawNames_internal_onFrame] call Core_addEventHandler;
}

function(drawNames_setEnable) { drawNames_enabled = _this; }

function(drawNames_internal_onFrame)
{
	if (!isGameFocused) exitwith {};

	if (!drawNames_enabled) exitwith {};
	if (tickTime >= drawNames_internal_lastUpdate) then {
		drawNames_internal_lastUpdate = tickTime + drawNames_const_updateDelay;
		drawNames_internal_list_collectedOjbects = cameraOn nearObjects drawNames_distance;
	};

	{
		if !(_x call golib_hasHashData) then {continue};
		
		_class = ([_x,false] call golib_getHashData) getOrDefault ["class","<no class>"];
		_t = format["%1",_class];
		_distObj = cameraOn distance _x;
		_distSize = linearConversion [1,drawNames_distance,_distObj,0.07,0.0051];
		_distOpacity = linearConversion [1,drawNames_distance,_distObj,1,0];
		_clr = [1,1,1,_distOpacity];
		if (_class == "IStruct" || _class == "Decor") then {
			_clr = [1,0.3,0,_distOpacity];
		};
		drawIcon3D ["", _clr, (getposatl _x)vectorAdd (boundingCenter _x), 0, 0, 0, _t, 1, _distSize, "EtelkaMonospaceProBold"];
	} foreach drawNames_internal_list_collectedOjbects;
}