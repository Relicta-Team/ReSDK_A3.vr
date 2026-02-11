// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(lightValidator_process)
{
	if !(call vcom_emit_io_isEnumConfigsLoaded) then {
		[true] call vcom_emit_io_loadEnumAssoc;	
	};
	private _erroredConfigs = [];
	private _erroredObjects = [];
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				private _hash = [_x,true] call golib_getHashData;
				//this checked only light values
				private _pps = _hash get "customProps";
				if ("light" in _pps) then {
					private _lt = _pps get "light";
					private _cfgList = keys vcom_emit_io_enumAssocKeyStr;
					if ((_cfgList findif {_x==_lt})==-1) then {
						_erroredObjects pushBack _x;
						_erroredConfigs pushBackUnique _lt;
					};
				};
			};
		};
	} foreach (all3DENEntities select 0);

	if (count _erroredConfigs > 0) then {
		[format["Найдено %1 объектов с несуществующими конфигами, указанными через инспектор. Все они были выделены.",count _erroredObjects],20] call showWarning;
		_erroredObjects call golib_vis_jumpToObjects;
	} else {
		["Ошибок конфигов света не обнаружено"] call showInfo;
	};
}

function(lightConfig_checkOptimizer)
{
	if !(call vcom_emit_io_isConfigsLoaded) then { 
		call vcom_emit_io_readConfigs; 
	};

	private _errCount = [];
	{
		private _cfgName = _x;
		private _ldat = _y;
		{
			private _cfgStorage = _x;
			if (_cfgStorage get "typeshort" == "lt") then {
				
				private _alias = format["%1[%2]",_cfgName,_cfgStorage getOrDefault ["alias",str _foreachIndex]];
				private _settings = _cfgStorage get "settings";
				private _hasAtten = false;
				private _attenSets = null;
				{
					if (_x select 0 == "setLightAttenuation") exitWith {
						_hasAtten = true;
						_attenSets = parsesimplearray(_x select 1);
					};
				} foreach _settings;
				if (!_hasAtten) exitWith {
					_errCount pushBack [_alias,"Конфиг не имеет параметров затухания"];
				};
				
				private _endHardLimit = _attenSets select 5;
				if (_endHardLimit <= 0) then {
					_errCount pushBack [_cfgName,"Конфиг не имеет параметра затухания (равен 0)"];
				};
				["Light check %1 - ok",_alias] call printLog;
			};
		} foreach _ldat;
	} foreach vcom_emit_io_map_configs;

	{
		_x params ["_cf","_msg"];
		["Config error %1 - %2",_cf,_msg] call printError;
	} foreach _errCount;

	if (count _errCount == 0) then {
		["Ошибок не обнаружено"] call showInfo;
	} else {
		["Обнаружены ошибки. Проверьте консоль для получения детальной информации"] call showError;
	};
}