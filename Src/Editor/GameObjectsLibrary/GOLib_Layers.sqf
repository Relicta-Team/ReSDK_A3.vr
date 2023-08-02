// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

function(layer_internal_addPtr)
{
	params ["_ptr","_name"];
	if !("layer_ptrToName" call golib_hasCommonStorageParam) then {
		golib_com_objectHash set ["layer_ptrToName", createHashMap ];
		[] call golib_saveCommonStorage;
	};
	if !("layer_nameToPtr" call golib_hasCommonStorageParam) then {
		golib_com_objectHash set ["layer_nameToPtr", createHashMap ];
		[] call golib_saveCommonStorage;
	};

	golib_com_objectHash get "layer_ptrToName" set [_ptr,_name];
	golib_com_objectHash get "layer_nameToPtr" set [_name,_ptr];
	[] call golib_saveCommonStorage;
}

function(layer_internal_removePtr)
{
	private _ptr = _this;
	if !("layer_ptrToName" call golib_hasCommonStorageParam) then {
		golib_com_objectHash set ["layer_ptrToName", createHashMap ];
		[] call golib_saveCommonStorage;
	};
	if !("layer_nameToPtr" call golib_hasCommonStorageParam) then {
		golib_com_objectHash set ["layer_nameToPtr", createHashMap ];
		[] call golib_saveCommonStorage;
	};

	//getting name by ptr
	private _name = golib_com_objectHash get "layer_ptrToName" getOrDefault [_ptr,"$ERROR_LAYER_NOT_FOUND$"];
	(golib_com_objectHash get "layer_ptrToName") deleteAt _ptr;
	(golib_com_objectHash get "layer_nameToPtr") deleteAt _name;
	[] call golib_saveCommonStorage;
}

function(layer_create)
{
	params ["_name",["_parent",-1]];
	private _ptr = _parent add3DENLayer _name;
	[_ptr,_name] call layer_internal_addPtr;
}

function(layer_isExists)
{
	private _name = _this;
	(_name call layer_nameToPtr) != -1;
}

function(layer_delete)
{
	private _ptr = _this;
	if equalTypes(_ptr,"") then {
		_ptr = _ptr call layer_nameToPtr;
	};
	[_ptr] call layer_internal_removePtr;
	remove3DENLayer _ptr;
}

function(layer_addObject)
{
	params ["_object","_layer"];
	if !(_layer call layer_isExists) exitWith {false};
	if equalTypes(_layer,"") then {
		_layer = _layer call layer_nameToPtr;
	};
	
	_object set3DENLayer _layer;
}

function(layer_getObjects)
{
	private _ptr = _this;
	if equalTypes(_ptr,"") then {
		_ptr = _ptr call layer_nameToPtr;
	};

	get3DENLayerEntities _ptr
}

function(layer_nameToPtr)
{
	private _name = _this;
	if !("layer_nameToPtr" in golib_com_objectHash) exitWith {-1};
	(golib_com_objectHash get "layer_nameToPtr") getOrDefault [_name,-1]
}

function(layer_getObjectLayer)
{
	private _o = _this;
	private _listMap = (golib_com_objectHash get "layer_nameToPtr");
	if isNullVar(_listMap) exitwith {""};
	private _lname = "";
	private _olist = null;
	{
		_olist = _x call layer_getObjects;
		if (_o in _olist) exitwith {_lname = _x};
	} foreach (keys _listMap);
	_lname
}