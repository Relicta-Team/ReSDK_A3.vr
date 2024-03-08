// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *
|						LOW LEVEL API								|
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***/

//check if layer exists by name or pointer
function(layer_internal_exists)
{
	private _layer = _this;
	if equalTypes(_layer,0) then {
		array_exists(call layer_internal_getLayerPtrList,_layer);
	} else {
		private _finded = false;
		private _layername = null;
		{
			_layername = _x call layer_internal_getLayerNameByPtr;

			if equals(_layername,_layer) exitwith {
				_finded = true;
			};
		} foreach (call layer_internal_getLayerPtrList);

		_finded
	};
}

//_layerptr - обязательно должен быть проверен на существование извне чтобы случайно не получить имя объекта
function(layer_internal_getLayerNameByPtr)
{
	private _layerptr = _this;
	private _name = (_layerptr get3DENAttribute "name") select 0;
	if isNullVar(_name) exitwith {""};
	_name
}

function(layer_internal_getLayerPtrByName)
{
	private _layername = _this;
	private _ptr = -1;
	private _curname = null;
	{
		_curname = _x call layer_internal_getLayerNameByPtr;
		if equals(_curname,_layername) exitwith {
			_ptr = _x;	
		};
	} foreach (call layer_internal_getLayerPtrList);
	_ptr
}

function(layer_internal_getLayerPtrList)
{
	(all3DENEntities select 6)
}

function(layer_internal_allObjects)
{
	get3DENLayerEntities _this
}

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *
|						HIGH LEVEL API								|
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***/

function(layer_create)
{
	params ["_name",["_parent",-1]];
	private _ptr = _parent add3DENLayer _name;
	_ptr
}

function(layer_isExists)
{
	private _name = _this;
	(_name call layer_internal_exists)
}

function(layer_delete)
{
	private _ptr = _this;
	if equalTypes(_ptr,"") then {
		_ptr = _ptr call layer_internal_getLayerPtrByName;
	};
	
	if (_ptr == -1) exitwith {false};

	remove3DENLayer _ptr;
}

function(layer_setName)
{
	params ["_layer","_name"];
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	if (_layer == -1) exitwith {false};
	_layer set3DENAttribute ["name",_name]
}

function(layer_setLocked)
{
	params ["_layer","_name",["_postMes",""]];
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	if (_layer == -1) exitwith {false};
	["Слои" + _postMes, "Переключение видимости слоя", "a3\3den\data\cfg3den\history\changeAttributes_ca.paa"] collect3DENHistory {
		_layer set3DENAttribute ["Transformation",!_name];
	};
}

function(layer_lockGuard)
{
	params ["_mode"];
	if (_mode) then {
		if !isNull(layer_internal_lockGuardCache) exitwith {
			setLastError("Lock guard cache not empty. Restart editor required");
		};

		private _allLayersPtr = call layer_internal_getLayerPtrList;
		layer_internal_lockGuardCache = _allLayersPtr apply {[_x,_x call layer_isLocked]};
		{
			[_x,false,golib_history_skippedHistoryStageFlag+" Системное переключение"] call layer_setLocked;
		} foreach _allLayersPtr;
	} else {
		{
			//[_x select 0,_x select 1,golib_history_skippedHistoryStageFlag + " Системное переключение (возврат)"] call layer_setLocked;
			do3DENAction "Undo";
		} foreach layer_internal_lockGuardCache;
		layer_internal_lockGuardCache = null;
	};
}

function(layer_isLocked)
{
	params ["_layer"];
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	if (_layer == -1) exitwith {false};
	!((_layer get3DENAttribute "Transformation") select 0)
}

function(layer_setVisible)
{
	params ["_layer","_name"];
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	if (_layer == -1) exitwith {false};
	_layer set3DENAttribute ["Visibility",_name];
}

function(layer_isVisible)
{
	params ["_layer"];
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	if (_layer == -1) exitwith {false};
	(_layer get3DENAttribute "Visibility") select 0
}


function(layer_addObject)
{
	params ["_object","_layer"];
	if !(_layer call layer_isExists) exitWith {false};
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_internal_getLayerPtrByName;
	};
	
	if (_layer == -1) exitwith {false};

	_object set3DENLayer _layer;
}

function(layer_getObjects)
{
	private _ptr = _this;
	if equalTypes(_ptr,"") then {
		_ptr = _ptr call layer_internal_getLayerPtrByName;
	};

	if (_ptr == -1) exitwith {[]};

	_ptr call layer_internal_allObjects;
}


function(layer_getObjectLayer)
{
	params ["_o",["_retAsString",true]];
	private _list = null;
	private _retval = ifcheck(_retAsString,"",-1);
	{
		_list = _x call layer_internal_allObjects;
		if array_exists(_list,_o) exitWith {
			_retval = ifcheck(_retAsString,_x call layer_internal_getLayerNameByPtr,_x);
		};
	} foreach (call layer_internal_getLayerPtrList);

	_retval
}