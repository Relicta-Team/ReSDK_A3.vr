// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(menu_getControlObject)
{
	getEdenMenu
}

function(menu_getSize)
{
	getEdenMenu menuSize _this
}

function(menu_create) {getEdenMenu menuAdd _this}
function(menu_delete) {getEdenMenu menuDelete _this}

function(menu_setEnable) {getEdenMenu menuEnable _this}
function(menu_isEnabled) {getEdenMenu menuEnabled _this}

function(menu_getData) {getEdenMenu menuData _this}
function(menu_setData) {getEdenMenu menuSetData _this}

function(menu_setText) {getEdenMenu menuSetText _this}
function(menu_getText) {getEdenMenu menuText _this}

function(menu_setShortcut) {getEdenMenu menuSetShortcut _this}
function(menu_getShortcut) {getEdenMenu menuShortcut _this}

/*function(menu_setShortcutText) {getEdenMenu menuSetShortcutText _this}
function(menu_getShortcutText) {getEdenMenu menuShortcutText _this}*/

function(menu_setPicture) {getEdenMenu menuSetPicture _this}
function(menu_getPicture) {getEdenMenu menuPicture _this}

function(menu_setChecked) {getEdenMenu menuSetCheck _this}
function(menu_isChecked) {getEdenMenu menuChecked _this}

function(menu_setUrl) {getEdenMenu menuSetURL _this}
function(menu_getUrl) {getEdenMenu menuURL _this}

function(menu_setAction) {
	params ["_path","_act"];
	if equalTypes(_act,{}) then {_act = toString _act};
	getEdenMenu menuSetAction [_path,_act];
}
function(menu_getAction) {getEdenMenu menuAction _this}

function(menu_dumpNativeMenuInfo)
{
	params ["_refArr","_tvar"];
	private _rec = ifcheck(isNullVar(_refArr),[],_refArr);
	
	#define menu_getval__(varname,path) (format["%1",call compile format['getEdenMenu varname %1',path]])
	
	
	private _size = (_rec call menu_getSize);
	
	private _tabs = ""; for "_i" from 1 to _size do {modvar(_tabs) + menu_debug_tab};
	
	for "_i" from 0 to (_size - 1) do {
		_recinc = _rec + [_i];
		["DUMP: %1",_recinc] call printWarning;
		[
			"Path %1
	text: %2
	data: %3
	act:  %4
	short:%5
	sctxt:%6
	pic:  %7
	",
			_recinc,
			call compile format['getEdenMenu menuText %2',_tvar,_recinc],
			call compile format['getEdenMenu menuData %2',_tvar,_recinc],
			call compile format['getEdenMenu menuAction %2',_tvar,_recinc],
			call compile format['getEdenMenu menuShortcut %2',_tvar,_recinc],
			call compile format['getEdenMenu menuShortcutText %2',_tvar,_recinc],
			call compile format['getEdenMenu menuPicture %2',_tvar,_recinc]
		] call printLog;
		
		modvar(menu_internal_dumpNativeMenuItemsLayout) + _tabs + "[" + menu_debug_endl +
		"text:"+menu_getval__(menuText,_recinc)+";"+
		"data:"+menu_getval__(menuData,_recinc)+";"+
		"act:"+menu_getval__(menuAction,_recinc)+";"+
		"short:"+menu_getval__(menuShortcut,_recinc)+";"+
		"shtxt:"+menu_getval__(menuShortcutText,_recinc)+";"+
		"pic:"+menu_getval__(menuPicture,_recinc)+";"+menu_debug_endl+
		_tabs + "],";
		
		[_recinc,_tvar] call menu_dumpNativeMenuInfo;
	};

}

function(menu_internal_clearAllElements)
{
	for "_i" from 0 to (call menu_getSize) do {
		[0] call menu_delete;
	};
}

function(menu_internal_debug_getNativeLayoutInfo)
{
	menu_debug_endl = toString[10,13];
	menu_debug_tab = toString[9];
	menu_internal_dumpNativeMenuItemsLayout = "["+ menu_debug_endl;
	call menu_dumpNativeMenuInfo;
	menu_internal_dumpNativeMenuItemsLayout = menu_internal_dumpNativeMenuItemsLayout + "]";
	forceUnicode 1;
	copyToClipboarD menu_internal_dumpNativeMenuItemsLayout;
}

function(menu_internal_initLayout)
{
	private _pathArr = [];
	{
		[_x,_forEachIndex,_pathArr] call menu_internal_parseLayoutNode;
	} foreach menu_structureLayout;
}

function(menu_internal_parseLayoutNode)
{
	params ["_node","_index","_pathArr"];
	
	if equalTypes(_node,[]) then {
		
		{
			if (_forEachIndex == 0) then {
				[_x,_forEachIndex,_pathArr] call menu_internal_parseLayoutNode;
			} else {
				_feInfo = ifcheck(equalTypes(_x,[]),_forEachIndex - 1,_forEachIndex);
				[_x,_feInfo,_pathArr + [_index]] call menu_internal_parseLayoutNode;
			};
		} foreach _node;
	} else {
		[_node,_pathArr] call menu_internal_parseLayoutElement;
	};
}

function(menu_internal_parseLayoutElement)
{
	params ["_node","_path"];
	//["%1 at %2 (is empty %3) [idx:%4; fidx:%5]",_node,_path,count _node == 0,_index,_forEachIndex] call printWarning;
	if (count _node == 0) exitWith {
		private _item = [_path,""] call menu_create;
		[_path+[_item],false] call menu_setEnable;
	};
	
	private _attributes = _node splitString ";";

	private _unicalAttrs = [];
	
	private _item = [_path,""] call menu_create;
	
	if equals(_item,-1) exitWith {
		["%1 - Error on create menu item: %2",__FUNC__,_path] call printError;
	};
	_item = _path + [_item];
	{
		(_x splitString ":") params ["_name","_val"];
		if !(_name in menu_layout_allowedAttributes) exitWith {
			["%1 - Unknown attribute %2",__FUNC__,_name] call printError;
		};
		if (_name in _unicalAttrs) exitWith {
			["%1 - Double define attribute %2",__FUNC__,_name] call printError;
		};
		_unicalAttrs pushBack _name;
		
		call {
			if (_name == "text") exitWith {
				[_item,_val] call menu_setText;
			};
			if (_name == "data") exitWith {
				[_item,_val] call menu_setData;
			};
			if (_name == "act") exitWith {
				[_item,_val] call menu_setAction;
			};
			if (_name == "pic") exitWith {
				[_item,_val] call menu_setPicture;
			};
			if (_name == "short") exitWith {
				[_item,call compile _val] call menu_setShortcut;
			};
			/*if (_name == "shtxt") exitWith {
				[_item,_val] call menu_setShortcutText;
			};*/
			if (_name == "check") exitWith {
				private _isChecked = call compile _val;
				[_item,_isChecked] call menu_setChecked;
			};
			if (_name == "url") exitWith {
				[_item,"https://"+_val] call menu_setUrl;
			};
			if (_name == "ena") exitWith {
				[_item,call compile _val] call menu_setEnable
			};
			if (_name == "path") exitWith {
				missionNamespace setVariable [_val,_item];
			};
		};
		
	} foreach _attributes;
}

init_function(menu_internal_initialize)
{
	
	["onFrame",MouseArea_handleDisableTooltip] call  Core_addEventHandler;
	menu_internal_markListControls = allControls getEdenDisplay;
	
	call MouseArea_init;
	
	
	call menu_internal_clearAllElements;
	
	call widget_createDragger;
	
	nextFrame(menu_internal_initLayout);
	
	//hide mission cat
	_mcat = (getEdenDisplay displayCtrl 10306);
	_mcat ctrlEnable false;
	//night vision
	_mcat = (getEdenDisplay displayCtrl 10304);
	_mcat ctrlEnable false;
	
	//steam
	_mcat = (getEdenDisplay displayCtrl 10091);
	_mcat ctrlEnable false;
	
	//disable layer delete button
	// _e = (getEdenDisplay) displayCtrl 85;
	// _e ctrlEnable false;
	// _e ctrlshow false;
	
	//disable changetime button
	_e = getEdenDisplay displayCtrl 10302;
	_e ctrlEnable false;
	_e ctrlshow false;


	//disable create entitymenu (in right panel)
	// Это убирае сами кнопки переключения
	_e = (getEdenDisplay displayCtrl 1039);
	[_e,[150,150]] call widgetSetPositionOnly;

	//disable selector entitymenu (tab)
	//Это удаляет пункт создания объектов через платформу
	_e = (getEdenDisplay displayCtrl 1036);
	_idc = _e lbvalue 0; //1040 for history,1039 templates
	if (_idc != 1040) then {
		//hide panel
		private _ctrlTabs = _e;
		private _id = 1; //id for history
		for "_i" from 0 to 10 do { 
			private _idc = _ctrlTabs lbvalue _i; 
			if (_idc <= 0) exitwith {}; 
			private _ctrl = (findDisplay 313) displayctrl _idc; 
			_ctrl ctrlshow (_id == _i); 
		};
		//delete item
		_e lbDelete 0;
	};

	//disable locations (in left panel)
	//Тут всё проще
	_o = (getEdenDisplay displayCtrl 1033);
	_o lbdelete 1;
	_o lbSetText [0,"Слои"];
	/*
		> "AllWest"
		> "AllEast"
		> "AllIndependent"
		> "AllCivilian"
		> "AllEmpty"
		> "AllAmbient"
		> "AllTriggers"
		> "AllLogics"
		> "AllMarkers"
		> "AllComments"
	*/
	_nonaccessData = ["AllWest"
		,"AllEast"
		,"AllIndependent"
		,"AllCivilian"
		,"AllLogics"
	];
	_o = (findDisplay 313 displayCtrl 55);
	for "_i" from 0 to (_o tvCount []) do {
		_cur = _o tvData [_i];
		if (_nonaccessData findIf {_x == _cur} != -1) then {
			_o tvSetText [[_i],"(НЕ ИСПОЛЬЗОВАТЬ)"];
			//? Можно и удалять но основные системные ветки пересоздаются сразу же. Можно делать в цикле но производительность...
		};
	};
	//TODO custom objectlist tree view
	// Исходное дерево не имеет данных и не дает заменять названия

	//Создание плашки девбилд
	_w = getEdenDisplay getVariable ["menu_internal_devbuildwidget",widgetNull];
	if !isNullReference(_w) then {
		[_w,true] call deleteWidget;
	};
	_w = [getEdenDisplay,BACKGROUND,[0,95,100,5]] call createWidget;
	[_w,"<t align='center'>DEVELOPMENT BUILD</t>"] call widgetSetText;
	_w ctrlSetBackgroundColor [0.9,0.1,0.1,.4];
	getEdenDisplay setVariable ["menu_internal_devbuildwidget",_w];
	if (!ISDEVBUILD) then {
		_w ctrlShow false;
	};

	//отладка памяти
	_w = getEdenDisplay getvariable ["menu_internal_memwidget",widgetNull];
	if !isNullReference(_w) then {
		[_w,false] call deleteWidget;
	};
	_wloff = getEdenDisplay displayctrl 1055;
	(_wloff call widgetGetPosition) params ["_wlx","_wly","_wlw","_wlh"];
	_ctgDown = ctrlParentControlsGroup(_wloff);
	_mwid = [getEdenDisplay,TEXT,[_wlx+_wlw,_wly,80,_wlh],_ctgDown] call createWidget;
	[_mwid,"<t align='left'>MEMORY</t>"] call widgetSetText;
	getEdenDisplay setVariable ["menu_internal_memwidget",_mwid];
	["onFrame",{
		_mwid = getEdenDisplay getvariable ["menu_internal_memwidget",widgetNull];
		if !isNullReference(_mwid) then {
			_meminfList = (["ScriptContext","mem",null,true] call rescript_callCommand splitString ",") apply {_x splitString ":" select 1};
			_meminf = format["<t size='0.9'>memory: workset= %1mb, privmem= %3mb, paged= %2mb</t>",_meminfList select 1,_meminfList select 2,_meminfList select 3];
			[_mwid,_meminf] call widgetSetText;
		};
	}] call Core_addEventHandler;
	//play button
	
	_w = getEdenDisplay getVariable ["menu_internal_objlibWidget",widgetNull];
	if !isNullReference(_w) then {
		[_w,true] call deleteWidget;
	};
	
	_mcat = (getEdenDisplay displayCtrl 1023);
	_mcat ctrlEnable false;
	_mcat ctrlShow false;
	private _pos = (_mcat call widgetGetPosition);
	
	//Можно меньше при желании
	//_pos params ["_x","_y","_w","_h"];
	//_pos = [_x,_y+_h/2,_w,_h/2]; 
	
	_w = [getEdenDisplay,BUTTON,_pos] call createWidget;
	_w ctrlSetText "Библиотека";
	_w ctrlSetBackgroundColor [0.2,0.2,0.2,.5];
	getEdenDisplay setVariable ["menu_internal_objlibWidget",_w];
	menu_internal_widget_refButtonObjLib set [0,_w];
	//какое-никакое добро для просмотра инфы на дисплее.
	//дополнительные айди тут:
	//https://community.bistudio.com/wiki/Arma_3:_Display3DEN_IDCs
	//call menu_internal_debug_setTooltipInfoToAllElements;

}

function(menu_getButtonObjLib) {menu_internal_widget_refButtonObjLib select 0};

function(menu_getMissionNameControl)
{
	getEdenDisplay displayCtrl 76
}

function(menu_setMissionName)
{
	menu_internal_missionName = _this;
}


function(menu_internal_debug_setTooltipInfoToAllElements)
{
	{
		_text = format["type: (%3) %1\nidc %2",
			ctrlType _x,
			ctrlIDC _x,
			ctrlClassName _x
		];
		_x ctrlSetTooltip _text;
	} foreach (allControls getEdenDisplay);
}