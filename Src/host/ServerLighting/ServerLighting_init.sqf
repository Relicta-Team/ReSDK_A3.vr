// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\GameObjects\GameConstants.hpp>

private __slt_configs = [];

#define sltInit(cfg) _new_seg_slt = [cfg]; __slt_configs pushBack _new_seg_slt; _new_seg_slt pushBack

#define slt_createLight() ("#lightpoint" createVehicleLocal [0,0,0])
#define slt_createObj(type) (call {private __o = (type) createVehicleLocal [0,0,0]; __o allowDamage false; __o})
#define sourceObject _obj
#define lightObject _lt
#define linkToSource(obj,vecoffset) obj setPosAtl (getPosATL sourceObject); obj setVectorDirAndUp [vectorDirVisual sourceObject,vectorUpVisual sourceObject]
#define linkLightToSource(obj,vecoffset) obj lightAttachObject [sourceObject,vecoffset]

#include "ServerLighting_configs.sqf"

{
	_x params ["_id","_code"];
	missionNamespace setVariable [format["slt_cfg_id_%1",_id],_code];
} foreach __slt_configs;

#define sourceObject _wObj
#define lightObject _firstLight

slt_map_scriptCfgs = createHashMap;

#define regScriptEmit(type) _semDat = []; slt_map_scriptCfgs set ['type',_semDat]; slt_cfg_id_##type = { \
	params ['sourceObject']; \
	(slt_map_scriptCfgs get 'type') call slt_handleScriptedCfg; \
}; _semDat append [
#define endScriptEmit  ];
#define _emitAlias(v) 


#include "..\..\client\LightEngine\ScriptedEffectConfigs.sqf"

//Опеределяем предкомпилированные константы
#define SCRIPT_EMIT_EVAL_SERVER

#include "..\..\client\LightEngine\ScriptedEffects.hpp"

slt_handleScriptedCfg = {
	private ["_t","_events"];
	private _o = objNull;
	private _firstLight = null;
	private _offset = [0,0,0];
	private _allEmitters = [];

	{
		_t  = _x select 0;
		_o = objnull;
		call {
			if (_t == "lt") exitwith {
				_o = "#lightpoint" createVehicleLocal [0,0,0];
				_o attachTo [slt_const_dummyMob,[0,0,0]];
				call slt_handleScriptedCfgVars;
			};
			if (_t == "ltd") exitwith {
				_o = "#lightreflector" createVehicleLocal [0,0,0];
				_o attachTo [slt_const_dummyMob,[0,0,0]];
				call slt_handleScriptedCfgVars;
			};
		};
		
		if !isNullReference(_o) then {
			_allEmitters pushBack _o;
		};
	} foreach _this;

	_allEmitters
};

	slt_handleScriptedCfgVars = {
		if isNullVar(_firstLight) then {
			_firstLight = _o;
		};
		
		{
			_x params ["_prop","_val"];
			[_o,_val] call (slt_scriptedCfgMapHandlers getorDefault [_prop,{}]);
			true;
		} count (_x select [2,(count _x) - 2]);
	};
	slt_scriptedCfgMapHandlers = createHashMapFromArray [
		["linkToSrc",{
			_offset = _this select 1;
			if (_autolink) then {
				(_this select 0) attachTo [sourceObject,_offset];
			} else {
				(_this select 0) attachTo [_obj,_offset,_select];
			};
		}],
		["linkToLight",{
			if (_autolink) then {
				(_this select 0) attachTo [sourceObject,(_this select 1)];
			} else {
				(_this select 0) attachTo [_firstLight,(_this select 1),_select];
			};
		}],
		["setOrient",{
			if (_autolink) then {
				[_this select 0,_this select 1] call BIS_fnc_setObjectRotation;
			} else {
				[_this select 0,//(_this select 1)
					(_this select 1)
				] call BIS_fnc_setObjectRotation;
			};
		}],

		["setLightColor",{(_this select 0) setLightColor (_this select 1)}],
		["setLightAmbient",{(_this select 0) setLightAmbient (_this select 1)}],
		["setLightAttenuation",{(_this select 0) setLightAttenuation (_this select 1)}],
		["setLightIntensity",{(_this select 0) setLightIntensity (_this select 1)}],
		
		//TODO remove flare section (non-usage on server)
		["setLightUseFlare",{(_this select 0) setLightUseFlare (_this select 1)}],
		["setLightFlareSize",{(_this select 0) setLightFlareSize (_this select 1)}],
		["setLightFlareMaxDistance",{(_this select 0) setLightFlareMaxDistance (_this select 1)}],

		["setLightConePars",{(_this select 0) setLightConePars (_this select 1)}],
		["setLightVolumeShape",{(_this select 0) setLightVolumeShape (_this select 1)}]
	];

#ifndef __VM_VALIDATE
slt_const_dummyMob = [10,10,0] call gm_createMob;
#endif

slt_create = {
	params ["_obj","_cfg",["_autolink",true],["_select",""]];
	if (_cfg >= 99999) exitWith {objnull};
	
	#ifdef NOE_DEBUG_HIDE_SERVER_LIGHT
	if (true) exitWith {objNUll};
	#endif

	private _code = missionNamespace getVariable [format["slt_cfg_id_%1",_cfg],{}];
	if equals(_code,{}) exitWith {
		errorformat("slt::create() - null config %1",_cfg);
		objNUll
	};
	//in case with scripted emitters its (list of objects)
	private _o = [_obj] call _code;
	if (_autolink) then {
		_obj setVariable ["srv_slt_obj",_o];
	} else {
		if not_equalTypes(_o,objNull) exitwith {};
		//when attached to unit legacy light
		_o attachTo [_obj,[0,0,0],_select];
	};
	_o
};

slt_destr = {
	params ["_obj"];
	private _o = _obj getVariable ["srv_slt_obj",objNUll];
	[_o] call slt_destr_impl;
	_obj setVariable ["srv_slt_obj",null];
};

//real impl of destroy server light
slt_destr_impl = {
	params ["_o"];
	if equalTypes(_o,objNull) then {
		deleteVehicle _o;
	} else {
		{deleteVehicle _x} foreach _o;
	};
};

//фикс из le_se_doSorting с доп.оптимизацией
slt_scriptCfg_doSorting = {
	private ["_cfgSegments","_curItm","_idx","_curPg"];
	private _cfgId = 0;
	{
		_cfgId = _x;

		_cfgSegments = _y;
		private _countEmts = count _cfgSegments;
		private _allIsPts = ({ _x select 0 == "pt"} count _cfgSegments) == _countEmts;
		
		if (_allIsPts) then {
			//Все - частицы
			//adding dummy light
			// [_cfgSegments,
			// 	[ "lt",null,["linkToSrc",[0,0,0]] ]
			// ] call pushFront;
			
			//Частицы нам не нужны
			_cfgSegments resize 0;
			_cfgSegments pushBack [ "lt",null,["linkToSrc",[0,0,0]] ];

		} else {
			//не все - частицы
			//Цикл сортировки. Все частицы - в конец
			for "_i" from 0 to (count _cfgSegments)-1 do {
				_curItm = _cfgSegments select 0;
				if (_curItm select 0 != "pt") exitWith {};
				_cfgSegments deleteAt 0;
				//_cfgSegments pushBack _curItm; //удаляем эмиттер частиц
			};
			//Если эмиттеров не осталось - добавим dummy эмиттер
			if (count _cfgSegments == 0) then {
				_cfgSegments pushBack [ "lt",null,["linkToSrc",[0,0,0]] ];
			};
		};

		{
			_curPg = _x;
			_idx = _curPg findif {!isNullVar(_x) && {equalTypes(_x,[])} && {(_x select 0) in ["linkToSrc","linkToLight"]}};
			
			//! Никогда не должно выбрасываться...
			if (_idx == -1) exitwith {
				#ifdef EDITOR
				["(SERVER_CHECK): Link property not found for scripted light <%1>: %2",_cfgId,_x] call MessageBox;
				halt;
				#endif
			};
			_curPg set [
				_idx,
				[ifcheck(_foreachIndex==0,"linkToSrc","linkToLight"),_curPg select _idx select 1]
			]
		} foreach _cfgSegments;

	} foreach slt_map_scriptCfgs;
};
//autosorting
call slt_scriptCfg_doSorting;