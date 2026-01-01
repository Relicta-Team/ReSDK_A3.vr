// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include "LightEngine.h"
//place this file before all configs

//карта эффектов. ключи - айди эффектов, значения - настройки эмиттеров
decl(map<string;any>)
le_se_map = createHashMap;
decl(any)
le_se_noattr = null; //!not used
decl(tuple<int;int>)
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
decl(bool|NULL(any[];int;vector3))
le_se_handleConfig = {
	params ["_cfgDataList",["_hMode",SCRIPT_EMIT_HANDLER_MODE_DEFAULT],"_dropPos"];
	private ["_t","_events","_alias","_o","_cfgDataCur","_cfgDataCurIdx"];
	private _isDrop = _hMode == SCRIPT_EMIT_HANDLER_MODE_DROP;
	private _isUnmanaged = _hMode == SCRIPT_EMIT_HANDLER_MODE_UNMANAGED;
	private _funcInit = le_se_list_fassoc select _hMode;

	private _handleFirstEmit = false;
	private _offset = [0,0,0];
	if (_isDrop) then {
		{
			_o = objnull;
			call {
				_cfgDataCur = _x;
				_t = _x select 0;
				_events = _x param [1,[]]; //list events
				_alias = _x select 2 select 1;
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
			_events call le_se_handleCfgEvents;
			if !isNullReference(_o) then {
				allEmitters pushBack _o;
			};
		} foreach _cfgDataList;
	} else {
		{
			_o = objnull;
			call {
				_cfgDataCur = _x;
				_cfgDataCurIdx = _foreachIndex;
				_t = _x select 0;
				_events = _x param [1,[]]; //list events
				_alias = _x select 2 select 1;
				//this dosent used
				if (_t == "rend") exitwith {
					//sourceObject call le_initRenderer;
				};
				//particle handler
				if (_t == "pt") exitwith {
					_o = "#particlesource" createVehicleLocal [0,0,0];
					call _funcInit;
					if (!_isUnmanaged) then {
						call _funcInit; //?this really needed?
					};
				};
				//light handler
				if (_t == "lt") exitwith {
					_o = "#lightpoint" createVehicleLocal [0,0,0];
					call _funcInit;
					[_o] call lesc_handleLight;
				};
				//light directional handler
				if (_t == "ltd") exitwith {
					_o = "#lightreflector" createVehicleLocal [0,0,0];
					call _funcInit;
					[_o,true] call lesc_handleLight;
				};
			};
			_events call le_se_handleCfgEvents;
			if !isNullReference(_o) then {
				allEmitters pushBack _o;
			};
		} foreach _cfgDataList;
	};
	

	if (_isDrop || _isUnmanaged) exitWith {true};
	//auto delete not used in scripted emitters
	//! native evh Destroyed not working with simple objects (sourceObject it is)

	//Возвращаем свет 
	sourceObject getvariable ["__light",objnull]
};

/* 
	создание неуправляемых эмиттеров. 
	параметр _dataHandler служит обработчиком внутри частиц
	Он принимает набор специальных параметров:
		- object - обрабатываемый эмиттер
		- param_name - имя обрабатываемой опции
		- param_value - значение обрабатываемой опции (является копией оригинала. при изменении опции значение будет установлено в эффекторе)
		- emitter_index - индекс эмиттера в списке конфигурации

*/
decl(mesh[](string|int;vector3;any))
le_se_createUnmanagedEmitter = {
	params ["_cfg","_pos",["_dataHandler",{}]];
	
	if not_equalTypes(_cfg,"") then {
		_cfg = str _cfg;
	};

	private __seMDat = le_se_map get _cfg;
	if isNullVar(__seMDat) exitWith {
		errorformat("Cant load light from config => %1",_cfg);
		[]
	};

	private _u_spawnpos = _pos;//!do not change _u_spawnpos varname
	private _allEmitters = []; //external variable
	private sourceObject = objNull; //dummy var. just in case...
	[__seMDat,SCRIPT_EMIT_HANDLER_MODE_UNMANAGED] call le_se_handleConfig;

	_allEmitters
};

decl(void())
le_se_handleCfgEvents = {
	//all configs are handler
	//params is: ["configHandlerName",cfgparams_any]
	//confighandler was
	//inside configHandlerName params is: cfgOwner:obj (cannot set objvars), src - source object, cfgparams, outparams
	private _hfunc = null;
	{
		_x params ["_cfgName","_cfgInParams"];//inparams can be null
		private _hfunc = le_se_map_cfgHandlers getorDefault [_cfgName,le_se_internal_errorFuncCfgEvents];
		[_o,sourceObject,_cfgInParams,
			null //todo implement outparams
		] call _hfunc
	} foreach _this;
};

decl(void(any))
le_se_internal_errorFuncCfgEvents = {
	private _errpar = _this;
	setLastError("Cannot initialize config handler: " + str _errpar);
};

decl(void(string;any))
le_se_registerConfigHandler = {
	params ["_cfgName","_cfgCode"];
	le_se_map_cfgHandlers set [_cfgName,_cfgCode];
}; //регистрация нового конфига. только на клиенте

//работает внутри обработчика скрипта для эмиттера. проверяет является ли контекст подключением к мобу
decl(bool(mesh|actor))
le_se_isAttachedToMob = {
	_this call smd_isSMDObjectInSlot
};

//получает айди слота подключения к мобу (например INV_FACE)
decl(int(actor))
le_se_getAttachedProxySlot = {
	_this call smd_getSMDObjectSlotId;
};

//получает значение опции из конфига. используется в хандлерах событий скриптовых эмиттеров
decl(any(string))
le_se_getCurrentConfigPropVal = {
	params ["_srch"];
	
	private _ls = _cfgDataCur select [2,(count _cfgDataCur) - 2];
	private _id = _ls findif {(_x select 0) == _srch};
	if (_id == -1) exitWith {null};
	_ls select _id select 1
};
//получает айди текущего конфига. только внутри хандлееров событий скриптовых эмиттеров
decl(any())
le_se_getCurrentConfigId = {
	assert_str(sourceObject getVariable "__config","Unexpected context or null config returns");
};

decl(map<string;any>)
le_se_map_cfgHandlers = createHashMap; //карта зарегистрированных конфигов

//always need included on client
#include "SEConfigHandlers.sqf"

decl(map<string;any>)
le_se_mapHandlersUnmanaged = null; //карта нативных эффектов
decl(map<string;any>)
le_se_mapHandlersShots = null;

//специальная функция разрешения симуляции для игры и для редактора
decl(mesh|actor())
le_se_getSimProxObj = {
	if (is3den) then {lsim_proxyObject} else {player}
};

decl(map<string;any>)
le_se_mapHandlers = createHashMapFromArray [
	
	["alias",{}],

	//generic events
	["linkToSrc",{
		(_this select 0) attachTo [call le_se_getSimProxObj,[0,0,0]];
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

decl(void())
le_se_errorHandler = {
	errorformat("le::se::errorHandler() - error on parse value %1 (in type: %2)",_prop arg _t);
};

decl(void())
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
	} count (_x select [3,(count _x) - 3]);
};

decl(void())
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

decl(void())
le_se_internal_createUnmanagedEmitterMap = {
	private _listNew = le_se_mapHandlers toArray false;
	private _funcSetPos = {
		(_this select 0) setPosAtl _u_spawnpos;
	};
	{
		_x params ["_prop","_val"];
		if (_prop == "linkToSrc") then {_listNew select _forEachIndex set [1,{
			(_this select 0) setposatl _u_spawnpos;
		}]};
		if (_prop == "linkToLight") then {_listNew select _forEachIndex set [1,{
			(_this select 0) setposatl (_u_spawnpos vectoradd (_this select 1));
		}]};
		if (_prop == "setOrient") then {_listNew select _forEachIndex set [1,{}]};
	} foreach _listNew;

	le_se_mapHandlersUnmanaged = createHashMapFromArray _listNew;
};

decl(void())
le_se_intenral_handleUnmanagedVarInit = {
	private _valCopy = null;
	{
		_x params ["_prop","_val"];
		_valCopy = _val;
		
		if equalTypes(_valCopy,[]) then {_valCopy = array_copy(_valCopy)};

		[_o,_prop,_valCopy,
			_alias //new version latest param is alias because cfgdatacuridx is unordered value...
			//_cfgDataCurIdx
		] call _dataHandler;
		[_o,_valCopy] call (le_se_mapHandlersUnmanaged getorDefault [_prop,le_se_errorHandler]);
		true;
	} count (_x select [3,(count _x) - 3]);
};

decl(void())
le_se_intenral_handleDropVarInit = {
	{
		_x params ["_prop","_val"];
		[_o,_val] call (le_se_mapHandlersShots getorDefault [_prop,le_se_errorHandler]);
		true;
	} count (_x select [3,(count _x) - 3]);
};

decl(bool(string|int;vector3;vector3;float;ref;any))
le_se_fireEmit = {
	params ["_cfg","_pos",["_norm",[0,0,1]],"_deleteAfter","_refemitters","_reservedParam"];
	
	if not_equalTypes(_cfg,"") then {_cfg = str _cfg};

	private _cfgData = (le_se_map get _cfg);

	if isNullVar(_cfgData) exitWith {
		errorformat("le::se::fireEmit() - Cant load config => %1",_cfg);
		false
	};
	private allEmitters = [];
	[_cfgData,SCRIPT_EMIT_HANDLER_MODE_DROP,_pos] call le_se_handleConfig;
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
	if !isNullVar(_deleteAfter) then {
		_rp = _deleteAfter;
	};
	if !isNullVar(_refemitters) then {
		refset(_refemitters,allEmitters);
	};
	invokeAfterDelayParams({{deleteVehicle _x}foreach _this},_rp,allEmitters);

	true
};

decl(void())
le_se_initScriptedLights = {
	
	if (isMultiplayer) then {
		assert_str(count lt_preload_cfgList > 0,"Client scripted configs not found");
		{
			if !([_x,false] call lightSys_registerConfig) exitWith {
				setLastError("Build scripted config error at index " + (str _foreachIndex));
			};
		} foreach lt_preload_cfgList;
	} else {
		assert_str(count slt_internal_fileListBuffer > 0,"Server scripted configs not found");
		{
			private _content = preprocessFile _x;
			if !([_content,false] call lightSys_registerConfig) exitWith {
				setLastError("Build scripted config error on client; File: " + _x);
			};
		} foreach slt_internal_fileListBuffer;
	};
};

//Опытным путем было выяснено что тип частиц не может быть прикреплен напрямую к источнику
//А если использовать хаки, то к частицам нельзя присоеденить другие объекты
//Спасибо Богемия...
decl(void())
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
				[ "lt",null,["alias","autogen_light"],["linkToSrc",[0,0,0]] ]
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

decl(map<string;any>)
le_se_map_partAddress = createHashMap; //key setParticleN , value [functions]

decl(any(string;string;any))
le_se_getParticleOption = {
	params ["_optName","_varname","_storage"];
	private _oDat = le_se_map_partAddress get _optName;
	if isNullVar(_oDat) exitWith {null};
	private _storCode = _oDat get _varname;
	if isNullVar(_storCode) exitWith {null};
	(_storage)call(_storCode select 0)
};

decl(void(string;string;any;any))
le_se_setParticleOption = {
	params ["_optName","_varname","_storage","_value"];
	private _oDat = le_se_map_partAddress get _optName;
	if isNullVar(_oDat) exitWith {};
	private _storCode = _oDat get _varname;
	if isNullVar(_storCode) exitWith {};
	[_storage,_value] call(_storCode select 1)
};

decl(int())
le_se_getCurrentEmitterIndex = { _cfgDataCurIdx };

decl(void())
le_se_internal_generateOptionAddress = {
	private _aListNames = ["setParticleParams","setParticleRandom","setParticleCircle","setDropInterval"];
	private _aList = [
		"particleShape", [0, 0, 0], 
		"particleFSNtieth", [0, 0, 1], 
		"particleFSIndex", [0, 0, 2], 
		"particleFSFrameCount", [0, 0, 3], 
		"particleFSLoop", [0, 0, 4], 
		"particleType", [0, 2], 
		"timerPeriod", [0, 3], 
		"lifeTime", [0, 4], 
		"position", [0, 5], 
		"moveVelocity", [0, 6], 
		"rotationVelocity", [0, 7], 
		"weight", [0, 8], 
		"volume", [0, 9], 
		"rubbing", [0, 10], 
		"size", [0, 11], 
		"color", [0, 12], 
		"animationSpeed", [0, 13], 
		"randomDirectionPeriod", [0, 14], 
		"randomDirectionIntensity", [0, 15], 
		"onTimerScript", [0, 16], 
		"beforeDestroyScript", [0, 17], 
		"attachTo", [0, 18], 
		"angle", [0, 19], 
		"onSurface", [0, 20], 
		"bounceOnSurface", [0, 21], 
		"emissiveColor",  [0, 22], 
		"lifeTimeVar", [1, 0], 
		"positionVar",  [1, 1], 
		"moveVelocityVar", [1, 2], 
		"rotationVelocityVar", [1, 3], 
		"sizeVar",  [1, 4], 
		"colorVar", [1, 5], 
		"randomDirectionPeriodVar", [1, 6], 
		"randomDirectionIntensityVar",  [1, 7], 
		"angleVar",  [1, 8], 
		"bounceOnSurfaceVar",  [1, 9], 
		"circleRadius", [2, 0], 
		"circleVelocity", [2, 1],
		"interval",  [3]
	];
	private _oName = null;
	private _oValAddr = null;
	for "_i" from 0 to (count _aList)-1 step 2 do {
		_oName = _aList select _i;
		_oValAddr = _aList select (_i+1);
		private _pOffset = _oValAddr select 0;
		private _propName = _aListNames select _pOffset;
		private _addrMap = _oValAddr select [1,count _oValAddr];
		private _funcBuffGet = ["_this"];
		private _funcBuffSet = ["(_this select 0)"];
		if (count _addrMap==0) then {
			//no addresses - is value
			//_funcBuffGet pushBack (format[""]);
			//_funcBuffSet pushBack (format[""]);
			_funcBuffSet = ["_valCopy = _this select 1"]; // _valCopy exref inside le_se_intenral_handleUnmanagedVarInit
		} else {
			_funcBuffGet pushBack (format["%1",_addrMap apply {"select " + (str _x)} joinString " "]);
			private _lastArr = _addrMap select -1;
			private _midArrL = _addrMap select [0,count _addrMap-1];
			if (count _addrMap == 1) then {
				_midArrL = [];//reset
			};
			_funcBuffSet pushBack (format[
				"%2 set [%1,(_this select 1)]",
				_lastArr,
				_midArrL apply {"select " + (str _x)} joinString " "
			]);
		};

		if !(_propName in le_se_map_partAddress) then {
			le_se_map_partAddress set [_propName,createHashMap];
		};
		private _mapStore = le_se_map_partAddress get _propName;
		_mapStore set [_oName,[compile(_funcBuffGet joinString " "),compile(_funcBuffSet joinString " ")]];
	};
};


//see macro SCRIPT_EMIT_HANDLER_MODE_
decl(any[])
le_se_list_fassoc = [];
le_se_list_fassoc set [SCRIPT_EMIT_HANDLER_MODE_DEFAULT,le_se_intenral_handleVarInit];
le_se_list_fassoc set [SCRIPT_EMIT_HANDLER_MODE_DROP,le_se_intenral_handleDropVarInit];
le_se_list_fassoc set [SCRIPT_EMIT_HANDLER_MODE_UNMANAGED,le_se_intenral_handleUnmanagedVarInit];
assert(({isNullVar(_x)}count le_se_list_fassoc)==0);