// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	Легаси система постпроцесса
	TODO: перенести на структуры

*/
#include <..\..\..\host\lang.hpp>

namespace(Rendering.PostProcess,pp_)

#include <postprocessing.h>

if (!isNullVar(pp_allEffects)) then {
	{
		ppEffectDestroy _x;
	} forEach pp_allEffects;
} else {
	if (isMultiplayer) exitWith {};
	//just init pp editor once
	//vm fix
	if (fileExists("GFPPE\GFPPE_init.sqf")) then {
		handl_ppdebug = [] execvm "GFPPE\GFPPE_init.sqf";
	};
};

decl(any[])
pp_buffer_efx = [];
decl(any[])
pp_allEffects = [];
decl(int)
pp_uniIndex = 5000;

decl(void(bool))
pp_reload = {
	params ["_enableUpdated"];

	pp_allEffects = [];
	pp_uniIndex = 5000;
	private _copyBuffer = array_copy(pp_buffer_efx);
	pp_buffer_efx = [];
	{
		_name = _x select 0;
		_h = getPPVar(_name + "_handle");
		stopUpdate(_h);
		ppEffectDestroy getPPVar(_name);

		//! i think is double initialization. maybee need remove?!
		call (_x select 6); //reload init statements

		_x call pp_init;
		//apply enabled
		if (_x select 7) then {
			[_name,true] call pp_setEnable;			
		};
		if (_enableUpdated && _h != -1) then {
			[_name,true,false] call pp_setEnable;
		};
	} foreach _copyBuffer;
};

decl(void(string;string;any[];any[];any;float;any;bool))
pp_init = {
	params ["_name","_config","_settings",["_args",[]],["_code",{}],["_delay",0],["_initStatement",{}],["_isActive",false]];
	
	call _initStatement;
	
	private _varName = PP_MACRO_PREF + _name;

	private _obj = ppEffectCreate [_config,pp_uniIndex];
	INC(pp_uniIndex);

	_obj ppEffectAdjust _settings;
	_obj ppEffectCommit 0;

	pp_allEffects pushBackUnique _obj;

	missionNamespace setVariable [_varName,_obj];

	setPPVar(_name + "_handle",-1);
	setPPVar(_name + "_onUpdate",_code);
	setPPVar(_name + "_args",_args);
	setPPVar(_name + "_updateDelay",_delay);
	
	private _curState = true;

	pp_buffer_efx pushBack [_name,_config,_settings,_args,_code,_delay,_initStatement,_isActive,_curState];
};

decl(void(...any[]))
pp_init_active = {
	_this set [7,true];
	_this call pp_init;
	[_this select 0,true] call pp_setEnable
};

decl(void(string;bool;bool))
pp_setEnable = {
	params ["_varName","_mode",["_showError",true]];

	private _effect = getPPVar(_varName);

	if isNullVar(_effect) exitWith {
		errorformat("PostProcessing::setEnable() - Cant find effect %1",_varName);
	};

	if (_mode == (ppEffectEnabled _effect)) exitWith {
		if (_showError) then {
			errorformat("PostProcessing::setEnable() - Effect %1 already %2",_varName arg _mode);
		};
	};

	_effect ppEffectEnable _mode;

	if (_mode) then {
		private _code = getPPVar(_varName + "_onUpdate");
		if not_equals(_code,{}) then {

			private _args = [_varName,getPPVar(_varName + "_args")];

			private __updateCode = {
				(_this select 0) params ["__EFFECT_NAME","__args"];
				
				__args call getPPVar(__EFFECT_NAME+"_onUpdate");
			};

			setPPVar(_varName + "_handle",startUpdateParams(__updateCode,getPPVar(_varName + "_updateDelay"),_args))
		};
	} else {
		private _handle = getPPVar(_varName + "_handle");
		if (_handle != -1) then {
			stopUpdate(_handle);
			setPPVar(_varName + "_handle",-1);
		};
	};

};



#include "PPDefines.sqf"
