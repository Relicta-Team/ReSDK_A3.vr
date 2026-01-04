// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//#ifdef EDITOR_GOLIB_LAYER_SYSTEM_UPDATE

init_function(layer_internal_initLayerDict)
{
	call layer_internal_reloadLayerTree;

	private _onchange = {
		params ["_entity"];
		
		//skip models (only id's)
		if not_equalTypes(_entity,-1) exitWith {};

		if equals(get3DENEntity _entity,_entity) then {
			if array_exists(all3DENEntities select 6,_entity) then {
				//do reload layers library
				call layer_internal_reloadLayerTree;
			};
		};
	};

	["onEntityAdded",_onchange] call Core_addEventHandler;
	["onEntityRemoved",_onchange] call Core_addEventHandler;
}

function(layer_internal_reloadLayerTree)
{
	private _allLayers = all3DENEntities select 6;
	#define __getname(_v) ((_v) get3DENAttribute "name" select 0)
	#define __getparentlayer(_v) (get3DENLayer (_v))
	
	layer_internal_map_layerTree = createHashMap;//k id(int), childs[]
	private _ldict = layer_internal_map_layerTree;

	private _flatChilds = createHashMap;
	layer_internal_map_childs = _flatChilds; //base mother, child

	{
		private _p = __getparentlayer(_x);
		if (_p != -1) then {
			if !(_p in _flatChilds) then {
				_flatChilds set [_p,[]];
			};
			(_flatChilds get _p) pushBack _x;
		} else {
			//no parents found - is root
			_ldict set [_x,[]];
		};
	} foreach _allLayers;

	_search = {
		params ["_cur","_plist","_mapping"];
		//add current to tree
		private _imap = createHashMap;
		_mapping set [_cur,_imap];
		{
			[_x,_flatChilds get _x,_imap] call _search;
		} foreach _plist;
	};

	{
		[_x,_y,_ldict] call _search;
	} foreach _flatChilds;
}

function(layer_openSelectLayer)
{
	params [["_tex","Выберите слой"],["_des","Выберите слой по названию"],["_firstId",-1]];
	private _dictinf_data = [];
	private _getname_ = { format["%1 #%2",__getname(_this),_this] };
	private _selItm = "";
	private _fmtType = "<<< %1 >>>";
	{
		private _p = __getparentlayer(_x);
		private _lname = _x call _getname_;
		
		if (_x == _firstId) then {
			_lname = format[_fmtType,_lname];
		};

		if (_p == -1) then {
			_dictinf_data pushBack (_lname + ":ROOT");
		} else {
			private _ppb = (_p call _getname_);
			if (_p == _firstId) then {
				_ppb = format[_fmtType,_ppb];	
			};
			_dictinf_data pushBack (_lname + ":" + _ppb);
		};
		
	} foreach (all3DENEntities select 6);

	_dictinf_data = _dictinf_data joinString ";";

	private _newval = refcreate(0);
	if ([
		_newval,
		_tex,
		_des,
		_dictinf_data
	] call widget_winapi_openTreeView) then {
		if (refget(_newval) == "") exitWith {-1};
		private _v = refget(_newval);
		parseNumber(_v select [(_v find "#") + 1])
	} else {
		-1
	};
}

//#else

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

//#endif
//EDITOR_GOLIB_LAYER_SYSTEM_UPDATE