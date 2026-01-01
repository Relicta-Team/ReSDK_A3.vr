// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(lsim_init)
{
	//first - unload all lights (if catched error on runtime)
	if (!isNull(lsim_objMap)) then {
		{
			_x switchLight "off";
			_x enableSimulation false;
		} foreach (values lsim_objMap);
	};
	if (!isNull(lsim_internal_registeredLights)) then {
		{
			{
				detach _x;
				deleteVehicle _x;
			} foreach _y;
		} foreach lsim_internal_registeredLights;
	};


	lsim_mode = false; //false - off, true - on
	lsim_objMap = createHashMap;
	lsim_internal_registeredLights = createHashMap;

	lsim_proxyObject = objNull;

	le_allLights = [];

	lsim_internal_handleUndo = -1;
	lsim_internal_handleRedo = -1;


	["onObjectAdded",lsim_internal_event_onAdded] call Core_addEventHandler;
	["onObjectRemoved",lsim_internal_event_onRemoved] call Core_addEventHandler;

}

function(lsim_internal_event_onAdded)
{
	params ["_obj"];
	if (lsim_mode) then {
		if (_obj call lsim_canSimulateLight) then {
			[_obj] call lsim_internal_loadLight;
		};
	};
}

function(lsim_internal_event_onRemoved)
{
	params ["_obj"];
	if (lsim_mode) then {
		if (_obj call lsim_isLightSimulated) then {
			[_obj] call lsim_internal_unloadLight;
		};
	}
}

function(lsim_isLightSimulated) { params ["_obj"];(hashValue _obj) in lsim_objMap }
function(lsim_canSimulateLight) { 
	params ["_obj"];
	private _v = [_obj,"light",false] call golib_getActualDataValue;
	if equalTypes(_v,0) exitWith {
		inRange(_v,le_se_cfgRange select 0,le_se_cfgRange select 1)	
	};
	not_equals(_v,"")
}
function(lsim_allLightObjects) { values lsim_objMap }

function(lsim_resolveObjectConfig)
{
	params ["_obj"];

	if !(call vcom_emit_io_isConfigsLoaded) then {
		call vcom_emit_io_readConfigs;
	};

	//use: vcom_emit_io_enumAssocKeyStr, vcom_emit_io_enumAssocKeyInt
	if !(call vcom_emit_io_isEnumConfigsLoaded) then {
		[true] call vcom_emit_io_loadEnumAssoc;
	};

	private _lt = [_obj,"light",false] call golib_getActualDataValue;
	if equalTypes(_lt,0) then {
		_lt = str _lt;
	};
	
	//is numeric
	private _cfg = vcom_emit_io_enumAssocKeyInt get _lt;
	if isNullVar(_cfg) then {
		_cfg = vcom_emit_io_enumAssocKeyStr get _lt;
		if isNullVar(_cfg) exitWith {""};
		if !inRange(parseNumber _cfg,le_se_cfgRange select 0,le_se_cfgRange select 1) then {
			""
		} else {
			[_lt,""] call vcom_emit_io_parseScriptedConfigName;
		}
	} else {
		if !inRange(parseNumber _lt,le_se_cfgRange select 0,le_se_cfgRange select 1) then {
			""
		} else {
			[_lt,""] call vcom_emit_io_parseScriptedConfigName;
		};
	};
	
}

function(lsim_internal_buildScriptedConfigs)
{
	call compile preprocessFileLineNumbers "Src\Editor\SystemTools\LigthSimulation_cfgLoader.sqf"
}

function(lsim_setMode)
{
	params ["_mode"];
	if (_mode == lsim_mode) exitWith {};

	//set night
	if ((call rendering_isNightEnabled) != _mode) then {
		_mode call rendering_setNight;
	};

	if (_mode) then {
		//ранее был подключен созданный локальный костер но он всё равно дает задержки симуляции
		lsim_proxyObject = golib_com_object;
		//lsim_proxyObject setposatl [100,100,100];
		//lsim_proxyObject hideObject true;
		lsim_proxyObject enableSimulation true;
		//lsim_proxyObject attachto [player,[0,0,0]];

		//preinit internal data
		call lsim_internal_buildScriptedConfigs;
		
		//collect objects
		{
			[_x] call lsim_internal_loadLight;
		} foreach (call lsim_internal_collectLightObjects);

		lsim_internal_handleUndo = ["onUndo",{call lsim_internal_rebuildAllLights}] call Core_addEventHandler;
		lsim_internal_handleRedo = ["onRedo",{call lsim_internal_rebuildAllLights}] call Core_addEventHandler;
		
	} else {
		//! Внимание ! удаление прокси объекта ссылающегося на golib_com_object приведёт к поломке карты
		//deleteVehicle lsim_proxyObject;

		["onUndo",lsim_internal_handleUndo] call Core_removeEventHandler;
		["onRedo",lsim_internal_handleRedo] call Core_removeEventHandler;
		lsim_internal_handleUndo = -1;
		lsim_internal_handleRedo = -1;

		{
			[_x] call lsim_internal_unloadLight;
		} foreach (call lsim_allLightObjects);

		if (count (call lsim_allLightObjects) > 0) then {
			setLastError("Light objects still exists on unloading...");
		};
	};

	lsim_mode = _mode;
	_mode call rendering_setInGameHDR;
}

function(lsim_internal_collectLightObjects)
{
	private _olist = [];
	{
		if (_x call golib_hasHashData && {not_equals(golib_com_object,_x)}) then {
			private _hash = [_x,true] call golib_getHashData;
			private _class = _hash get "class";
			_lt = [_class,"light"] call oop_getFieldBaseValue;
			if (_lt != "") then {
				_olist pushBack _x;
			};
		};
	} foreach (all3DENEntities select 0);

	_olist
}

function(lsim_internal_rebuildAllLights)
{
	{
		[_x] call lsim_internal_unloadLight;
	} foreach (call lsim_allLightObjects);
	{
		[_x] call lsim_internal_loadLight;
	} foreach (call lsim_internal_collectLightObjects);
}

function(lsim_internal_unloadLight)
{
	params ["_obj"];
	
	["Unloading light from %1",_obj] call printTrace;

	if (simulationEnabled _obj) then {
		_obj enableSimulation true;
	};

	lsim_objMap deleteAt (hashValue _obj);

	private _light = _obj getvariable ["__light",objNUll];
	private _allEmitters = _obj getVariable ["__allEmitters",[]];
	{
		deleteVehicle _x;
	} foreach _allEmitters;
	_obj setVariable ["__allEmitters",null];
	_obj setvariable ["__config",null];

	_obj setvariable ["__defBright",null];

	le_allLights deleteat (le_allLights find _light);
	le_allLights deleteat (le_allLights find _obj);

	lsim_internal_registeredLights deleteAt (hashValue _light);

	deleteVehicle _light;
}

function(lsim_reloadLightOnObject)
{
	params ["_obj"];
	if (!lsim_mode) exitWith {};

	if (_obj call lsim_canSimulateLight) then { //load with reloading
		[_obj] call lsim_internal_loadLight;
	} else {
		if (_obj call lsim_isLightSimulated) then {
			[_obj] call lsim_internal_unloadLight;
		};
	};
}

function(lsim_internal_loadLight)
{
	params ["_obj"];
	private _src = _obj;
	private _canLoad = true;

	private _oldCfg = _src getvariable "__config";
	if (!isNullVar(_oldCfg)) then {
		
		//Вот этот код может вызывать определённые проблемы в некоторых случаях
		[_src] call lsim_internal_unloadLight;
		
	};

	private _ltCfg = [_obj,"light",false] call golib_getActualDataValue;
	private _dataValue = _ltCfg;
	//do not load deprecated light config
	if equalTypes(_ltCfg,0) then {
		if !inRange(_ltCfg,le_se_cfgRange select 0,le_se_cfgRange select 1) exitWith {
			_canLoad = false;
			_ltCfg = "errlt";
		};
		//convert config if is set to default value
		_ltCfg = vcom_emit_io_enumAssocKeyInt getOrDefault [str _ltCfg,"errorlight____"];
	};
	
	if (str parseNumber _ltCfg == _ltCfg || !_canLoad) exitWith {}; //this deprecated light

	private _nullName = "<NULL>";
	private _parsedName = [_ltCfg,_nullName] call vcom_emit_io_parseScriptedConfigName;
	
	if (_nullName == _parsedName) exitWith {
		["Cant load light %1",_ltCfg] call printError;
	};

	private _cfgLightStr = vcom_emit_io_enumAssocKeyStr get _parsedName;
	if isNullVar(_cfgLightStr) exitWith {
		["Cant load non-existen light %1 (data: %2)",_parsedName,_dataValue] call printError;
	};

	private _code = missionNamespace getVariable ["le_conf_" + _cfgLightStr,objNull];
	if equalTypes(_code,objNull) exitWith {
		["Cant load non-existen light %1 - loader not found",_cfgLightStr] call printError;
	};
	
	["Loading light %1 at %2",_cfgLightStr,_src] call printTrace;

	//enable sim if need
	if !(simulationEnabled _obj) then {
		if (getmass _obj == 0) then {
			_obj enableSimulation true;
			_obj switchLight "off";
		};
	};

	lsim_objMap set [hashValue _obj,_obj];

	private _lt = [_src] call _code;
	lsim_internal_registeredLights set [hashValue _lt,(_src getvariable "__allEmitters")];
}