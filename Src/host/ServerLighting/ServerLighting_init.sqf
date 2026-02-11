// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\GameObjects\GameConstants.hpp>

slt_map_scriptCfgs = createHashMap;

//кэш загрузчика серверный конфигов эмиттеров
slt_internal_fileListBuffer = [];

slt_initScriptedLights = {
	private _flist = ["src\client\LightEngine\ScriptedConfigs",".sqf",true] call fso_getFiles;
	
	//load sp-lights
	#ifdef SP_MODE
	_flist = (LOADFILE "src\SP_lightPathes.i") splitString endl;
	#endif

	assert_str(count _flist > 0,"Scripted configs not found");
	slt_internal_fileListBuffer = _flist;
	call lightSys_preInitialize;
	private _content = "";
	{
		_content = preprocessFile _x;
		if !([_content,true] call lightSys_registerConfig) exitWith {
			setLastError("Build scripted config error on server; File: " + _x);
		};
	} foreach _flist;

	private _loadClientLights = false;
	
	#ifdef EDITOR
	_loadClientLights = true;
	#endif
	
	#ifdef SP_MODE
	_loadClientLights = true;
	#endif

	if (_loadClientLights) then {
		assert_str(!isNull(le_initializeScriptedConfigs),"Initialize scripted configs error - function not found");
		call le_initializeScriptedConfigs;
	};
};

call slt_initScriptedLights;

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
		//_source is outref
		["linkToSrc",{
			_offset = _this select 1;
			if (_autolink) then {
				(_this select 0) attachTo [_source,_offset];
			} else {
				(_this select 0) attachTo [_obj,_offset,_select];
			};
		}],
		//_source is outref
		["linkToLight",{
			if (_autolink) then {
				(_this select 0) attachTo [_source,(_this select 1)];
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

slt_const_dummyMob = objNull;

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

	//initialize dummy mob first time
	if isNullReference(slt_const_dummyMob) then {
		slt_const_dummyMob = [10,10,0] call gm_createMob;
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
	if isNullVar(_o) exitWith {
		error("slt::destr::impl() - destruct object already undefined");
	};
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
			_cfgSegments pushBack [ "lt",null,["alias","autogen_light"],["linkToSrc",[0,0,0]] ];

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
				_cfgSegments pushBack [ "lt",null,["alias","autogen_light"],["linkToSrc",[0,0,0]] ];
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