// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include "LightEngine.h"
//place this file before all configs

le_se_map = createHashMap;
le_se_noattr = null;
le_se_cfgRange = [2100,4900];

/*
	regScriptEmit(name) //ineditor: start of cfg location
		[ //this is array
			["pt",
				[custom events], //function reference on special conditions
				_emitAlias("Частица 1")
				["setParticleParams",[...]],
				["setParticleRandom",[...]],
				...
			],
			["lt",
				null // if null - no custom events
				["setLightColor",[...]],
				["setLightAttenuation",[...]]
			],
			[..etc type]
		]
	endScriptEmit //ineditor: eocfg location
*/

//Функция-обработчик скриптового освещения (для клиента)
le_se_handleConfig = {
	params ["_cfgDataList",["_isDrop",false],"_dropPos"];
	private ["_t","_events","_o"];
	
	private _funcInit = le_se_intenral_handleVarInit;
	if (_isDrop) then {
		_funcInit = le_se_intenral_handleDropVarInit;
	};

	private _handleFirstEmit = false;
	private _offset = [0,0,0];
	if (_isDrop) then {
		{
			_o = objnull;
			call {
				_t = _x select 0;
				_events = _x param [1,[]]; //list events
				//this dosent used
				// if (_t == "rend") exitwith {
				// 	sourceObject call le_initRenderer;
				// };
				//particle handler
				if (_t == "pt") exitwith {
					_o = "#particlesource" createVehicleLocal [0,0,0];
					call _funcInit;
				};
				//light handler
				if (_t == "lt") exitwith {
					_o = "#lightpoint" createVehicleLocal [0,0,0];
					call _funcInit;
				};
				// //light directional handler
				// if (_t == "ltd") exitwith {
				// 	_o = "#lightreflector" createVehicleLocal [0,0,0];
				// 	call _funcInit;
				// };
			};
			if !isNullReference(_o) then {
				allEmitters pushBack _o;
			};
		} foreach _cfgDataList;
	} else {
		{
			_o = objnull;
			call {
				_t = _x select 0;
				_events = _x param [1,[]]; //list events
				//this dosent used
				if (_t == "rend") exitwith {
					sourceObject call le_initRenderer;
				};
				//particle handler
				if (_t == "pt") exitwith {
					_o = "#particlesource" createVehicleLocal [0,0,0];
					call _funcInit;
					call _funcInit; //?this really needed?
				};
				//light handler
				if (_t == "lt") exitwith {
					_o = "#lightpoint" createVehicleLocal [0,0,0];
					call _funcInit;
				};
				//light directional handler
				if (_t == "ltd") exitwith {
					_o = "#lightreflector" createVehicleLocal [0,0,0];
					call _funcInit;
				};
			};
			if !isNullReference(_o) then {
				allEmitters pushBack _o;
			};
		} foreach _cfgDataList;
	};
	

	if (_isDrop) exitWith {true};
	//addEventOnDestroySource not used in scripted emitters
	//! native evh Destroyed not working with simple objects (sourceObject it is)

	//Возвращаем свет 
	sourceObject getvariable ["__light",objnull]
};

le_se_mapHandlersShots = null;
le_se_mapHandlers = createHashMapFromArray [
	#ifdef EDITOR
	["alias",{}],
	#endif

	//generic events
	["linkToSrc",{
		(_this select 0) attachTo [player,[0,0,0]];
		_offset = _this select 1;
		(_this select 0) attachTo [sourceObject,_offset];
	}],
	["linkToLight",{
		(_this select 0) attachTo [sourceObject getvariable "__light",(_this select 1) vectorDiff _offset];
	}],
	["setOrient",{[_this select 0,_this select 1] call BIS_fnc_setObjectRotation}],
	
	//for light
	["setLightColor",{(_this select 0) setLightColor (_this select 1)}],
	//!DEPRECATED: valueconv: (brightness * 3000 = intensity) ["setLightBrightness",{(_this select 0) setLightBrightness (_this select 1)}],
	["setLightAmbient",{(_this select 0) setLightAmbient (_this select 1)}],
	["setLightAttenuation",{(_this select 0) setLightAttenuation (_this select 1)}],
	["setLightIntensity",{(_this select 0) setLightIntensity (_this select 1)}],
	["setLightUseFlare",{(_this select 0) setLightUseFlare (_this select 1)}],
	["setLightFlareSize",{(_this select 0) setLightFlareSize (_this select 1)}],
	["setLightFlareMaxDistance",{(_this select 0) setLightFlareMaxDistance (_this select 1)}],
	
	//for spotlight
	["setLightConePars",{(_this select 0) setLightConePars (_this select 1)}],
	["setLightVolumeShape",{(_this select 0) setLightVolumeShape (_this select 1)}],
	
	//for particle	
	["setParticleParams",{(_this select 0) setParticleParams (_this select 1)}],
	["setParticleRandom",{(_this select 0) setParticleRandom (_this select 1)}],
	["setParticleCircle",{(_this select 0) setParticleCircle (_this select 1)}],
	["setDropInterval",{(_this select 0) setDropInterval (_this select 1)}]
];

le_se_errorHandler = {
	errorformat("le::se::errorHandler() - error on parse value %1 (in type: %2)",_prop arg _t);
};

le_se_intenral_handleVarInit = {
	//Добавляем первый источник как свет
	if (!_handleFirstEmit) then {
		_handleFirstEmit = true;
		sourceObject setvariable ["__light",_o];
	};

	{
		_x params ["_prop","_val"];
		[_o,_val] call (le_se_mapHandlers getorDefault [_prop,le_se_errorHandler]);
		true;
	} count (_x select [2,(count _x) - 2]);
};

le_se_internal_createDropEmitterMap = {
	private _listNew = le_se_mapHandlers toArray false;
	private _funcSetPos = {
		(_this select 0) setPosAtl _dropPos;
	};
	{
		_x params ["_prop","_val"];
		if (_prop == "linkToSrc") then {_listNew select _forEachIndex set [1,_funcSetPos]};
		if (_prop == "linkToLight") then {_listNew select _forEachIndex set [1,_funcSetPos]};
		if (_prop == "setOrient") then {_listNew select _forEachIndex set [1,{}]};
		// if (_prop == "setParticleParams") then {
		// 	_listNew select _foreachIndex set [1,{
		// 		//_norm
		// 		private _p = array_copy(_this select 1);
		// 		// _p set [23,[[rand(-100,100),rand(-100,100),rand(-100,100)],_norm]];
		// 		// _p set [19,rand(0,360)];
		// 		// _p set [20,true];
		// 		// _p set [21,1];
		// 		_src = (_p select 6);
		// 		{
		// 			_src set [_foreachIndex,(_src select _foreachIndex) * -(_norm select _foreachIndex)];
		// 		} foreach _src;
		// 		_p set [6,_src];
				
		// 		(_this select 0) setParticleParams _p;

		// 	}];
		// };
		// if (_prop == "setParticleRandom") then {
		// 	_listNew select _foreachIndex set [1,{
		// 		//_norm
		// 		private _p = array_copy(_this select 1);
		// 		_src = (_p select 2);
		// 		{
		// 			_src set [_foreachIndex,(_src select _foreachIndex) * -(_norm select _foreachIndex)];
		// 		} foreach _src;
		// 		_p set [2,_src];
				
		// 		(_this select 0) setParticleRandom _p;

		// 	}];
		// };
		//if ([_prop,"setLight"] call stringStartWith) then {_listNew select _forEachIndex set [1,{}]};
	} foreach _listNew;

	le_se_mapHandlersShots = createHashMapFromArray _listNew;
};

le_se_intenral_handleDropVarInit = {
	{
		_x params ["_prop","_val"];
		[_o,_val] call (le_se_mapHandlersShots getorDefault [_prop,le_se_errorHandler]);
		true;
	} count (_x select [2,(count _x) - 2]);
};

le_se_fireEmit = {
	params ["_cfg","_pos",["_norm",[0,0,1]],"_reservedParam"];
	
	if not_equalTypes(_cfg,"") then {_cfg = str _cfg};

	private _cfgData = (le_se_map get _cfg);

	if isNullVar(_cfgData) exitWith {
		errorformat("le::se::fireEmit() - Cant load config => %1",_cfg);
		false
	};
	private allEmitters = [];
	[_cfgData,true,_pos] call le_se_handleConfig;
	// #ifdef EDITOR
	// private _et = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	// _et setposatl _pos;
	// _et setVectorUp _norm;
	// #endif
	
	// {
	// 	_x attachto [player,[0,0,0]];
	// 	_x attachto [_et,[0,0,0]];
	// 	_x attachto [_et,[0,0,0]];
	// 	_et setVectorUp _norm;
	// } foreach allEmitters;
	// _et setposatl _pos;
	// _et setVectorUp _norm;
	allEmitters pushBack _et;
	
	private _rp = rand(0.05,0.2);
	invokeAfterDelayParams({{deleteVehicle _x}foreach _this},_rp,allEmitters);

	true
};

//Опытным путем было выяснено что тип частиц не может быть прикреплен напрямую к источнику
//А если использовать хаки, то к частицам нельзя присоеденить другие объекты
//Спасибо Богемия...
le_se_doSorting = {
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
			[_cfgSegments,
				[ "lt",null,["linkToSrc",[0,0,0]] ]
			] call (missionnamespace getvariable "pushFront"); //for bypass vm error
		} else {
			//не все - частицы
			//Цикл сортировки. Все частицы - в конец
			for "_i" from 0 to (count _cfgSegments)-1 do {
				_curItm = _cfgSegments select 0;
				if (_curItm select 0 != "pt") exitWith {};
				_cfgSegments deleteAt 0;
				_cfgSegments pushBack _curItm;
			};
		};

		{
			_curPg = _x;
			_idx = _curPg findif {!isNullVar(_x) && {equalTypes(_x,[])} && {(_x select 0) in ["linkToSrc","linkToLight"]}};
			
			//! Никогда не должно выбрасываться...
			if (_idx == -1) exitwith {
				#ifdef EDITOR
				["Link property not found for scripted light <%1>: %2",_cfgId,_x] call MessageBox;
				halt;
				#endif
			};
			_curPg set [
				_idx,
				[ifcheck(_foreachIndex==0,"linkToSrc","linkToLight"),_curPg select _idx select 1]
			]
		} foreach _cfgSegments;

	} foreach le_se_map;
};