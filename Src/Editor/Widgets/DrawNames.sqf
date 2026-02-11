// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(drawNames_init)
{
	#include "..\..\host\GURPS\Gurps.sqf"

	;drawNames_enabled = false;
	drawNames_distance = 50; //default value
	drawNames_const_updateDelay = 1;
	
	drawNames_internal_listNoShown = [];

	drawNames_internal_lastUpdate = 0;

	drawNames_internal_list_collectedOjbects = [];

	["onFrame",drawNames_internal_onFrame] call Core_addEventHandler;
}

function(drawNames_setEnable) { drawNames_enabled = _this; }

function(drawNames_internal_onFrame)
{
	if (!isGameFocused) exitwith {};

	if (!drawNames_enabled) exitwith {};
	private _extendedInfo = cfg_system_extendedInfoInClassname;

	if (tickTime >= drawNames_internal_lastUpdate) then {
		drawNames_internal_lastUpdate = tickTime + drawNames_const_updateDelay;
		_basepos = positionCameraToWorld[0,0,0];
		_collected = (_basepos nearObjects drawNames_distance)apply {[_x,_basepos distance _x]};
		drawNames_internal_list_collectedOjbects = [];
		// sort objects by distance
		_collected sort true;
		_refwt = refcreate(0);
		{
			_x = _x select 0;
			if ([_x,false] call golib_hasHashData) then {
				if (isObjectHidden _x) exitwith {};
				_class = ([_x,false] call golib_getHashData) getOrDefault ["class","<no class>"];
				if ((tolower _class) in drawNames_internal_listNoShown) exitwith {};
				_element = [_x,_class];
				if (_extendedInfo) then {
					_mat = [_x,"material"] call golib_getActualDataValue;
					_clr = "ffffff";
					_hp = 0;
					_dr = 0;
					_ht = 0;
					_wt = 0;
					if !isNullVar(_mat) then {
						if equalTypes(_mat,"") then {
							_matClass = _mat;
							_clr = [_mat,"color",true] call oop_getFieldBaseValue;
							_mat = [_mat,"name",true] call oop_getFieldBaseValue;
							if ([_class,"",true,"isItem"] call oop_getFieldBaseValue) then {
								_wt = [_class,"weight",true] call oop_getFieldBaseValue;
								_hp = [null,
									_wt,
									[_class,"",true,"objectHealthType"] call oop_getFieldBaseValue
								] call gurps_calculateItemHP;

							} else {
								_hp = [
									_class,
									[_class,"model",true] call oop_getFieldBaseValue,
									_matClass,
									_refwt
								] call gurps_internal_calculateHP;
								_wt = refget(_refwt) * 1000;
							};
							_ht = [_class,"ht",true] call oop_getFieldBaseValue;
							_dr = [_class,"dr",true] call oop_getFieldBaseValue;
							
						};
					};
					_ext = format["mat:%1 (hp:%2;dr:%3;ht:%4;w_kg:%5)",_mat,_hp,_dr,_ht,_wt];
					_element pushBack [_ext,_clr];
				};
				drawNames_internal_list_collectedOjbects pushBack _element;
			};
			if (count drawNames_internal_list_collectedOjbects > 400) exitwith {};
		} foreach _collected;
	};

	_basepos = positionCameraToWorld[0,0,0];
	{
		_x params ["_obj","_class","_extInfo"];		
		_t = format["%1",_class];
		_distObj = _basepos distance _obj;
		_distSize = linearConversion [1,drawNames_distance,_distObj,0.07,0.0051];
		_distOpacity = linearConversion [1,drawNames_distance,_distObj,1,0];
		_clr = [1,1,1,_distOpacity];
		if (_class == "IStruct" || _class == "Decor") then {
			_clr = [1,0.3,0,_distOpacity];
		};
		private _isDepr = _obj getvariable "___cache_depr";
		if isNullVar(_isDepr) then {
			_obj setvariable ["___cache_depr",[_class,"Deprecated"] call goasm_attributes_hasAttributeClass];
		} else {
			if (_isDepr) then {
				_clr = [1,0,0,_distOpacity];
				_t = "(DEPRECATED) " + _t;
			};
		};
		drawIcon3D ["", _clr, (getposatl _obj)vectorAdd (boundingCenter _obj), 0, 0, 0, _t, 1, _distSize, "EtelkaMonospaceProBold"];
		if (_extendedInfo) then {
			_extInfo params ["_txt","_color"];
			_color = [_color] call color_HTMLtoRGBA;
			drawIcon3D ["",_color vectormultiply 1.2, (getposatl _obj)vectorAdd (boundingCenter _obj vectoradd[0,0,-0.5]), 0, 0, 0, _txt, 1, _distSize, "EtelkaMonospaceProBold"];
		};
	} foreach drawNames_internal_list_collectedOjbects;
}