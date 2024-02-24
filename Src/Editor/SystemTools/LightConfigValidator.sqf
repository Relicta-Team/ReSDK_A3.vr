// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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