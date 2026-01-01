// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	DCM - Display Context Menu

	Use this if need creating contextMenu in display, opened with funciton displayOpen
*/

init_function(dcm_initialize)
{
	dcm_widgets = [widgetNull];
	dcm_postEnableList = [];
	dcm_contextParams = [];

	dcm_contextMenu_tree = [];

	dcm_internal_setFocus = false;

	dcm_internal_contextmenu_entercolor = [0.3,0.3,0.3,0.7];
	dcm_internal_contextmenu_exitcolor = [0.6,0.6,0.6,0.7];

	dcm_internal_const_copyFromNameValue = "@COPY_FROM_NAME@";
}

function(dcm_copyDescFromName) {dcm_internal_const_copyFromNameValue};

function(dcm_isOpened) {
	!isNullReference(call dcm_getCtg)
};

function(dcm_getCtg)
{
	dcm_widgets select 0
}

function(dcm_getContextParams)
{
	if !(call dcm_isOpened) exitWith {
		["%1 - display context menu not opened...",__FUNC__] call printError;
		[]
	};
	dcm_contextParams
}

/*
	//vec2: name, [code | list] ,["_condToVisible",{true}],["_desc",""]
	[
		[
			["menu item 1",{}],
			["menu item 2",{}]
			["menu extended",
				[
					["menu internal 1",{}],
					["menu internal 2",{}],
				]
			]
		]
		call mouseGetPosition
	] call dcm_create;
*/
function(dcm_create) {
	params ["_elements",["_posBase",call mouseGetPosition],["_ctx",[]]];

	if (call dcm_isOpened) exitwith {setLastError(__FUNC__ + " - Context menu already opened.")};

	private _d = call getOpenedDisplay;
	dcm_postEnableList = [];
	dcm_contextParams = _ctx;
	{
		if (ctrlEnabled _x) then {
			_x ctrlEnable false;
			dcm_postEnableList pushBack _x;
		};
	} foreach (allControls _d);

	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	dcm_widgets set [0,_ctg];

	dcm_contextMenu_tree = [];
	
	dcm_internal_setFocus = true;

	[_elements,_posBase,0] call dcm_internal_loadContext;
};

function(dcm_onResetEnable)
{
	{
		if !isNullReference(_x) then {
			_x ctrlEnable true;
		};
	} foreach dcm_postEnableList;
	dcm_postEnableList = [];
}

function(dcm_internal_loadContext)
{
	params ["_elements","_pointStart","_level","_pressedWidget"];

	private _sizeX = 15;
	private _sizeY = 4;

	_pointStart params ["_posX","_posY"];

	_posX = clamp(_posX,0,100-_sizeX);
	_posY = clamp(_posY,0,100-((count _elements))*_sizeY);

	private _back = [_d,BACKGROUND,[_posX,_posY,_sizeX,((count _elements))*_sizeY],_ctg] call createWidget;
	_back setBackgroundColor [.2,.2,.2,0.9];
	_back ctrlEnable false;
	_back setVariable ["level",_level];
	private _backItems = [];
	_back setVariable ["items",_backItems];
	if (_level > 0) then {
		_back setFade 1;
		_back commit 0;
		_back setVariable ["pressedRoot",_pressedWidget];
		_pressedWidget setVariable ["childBack",_back];
	};
	
	for "_i" from 0 to (count _elements) - 1 do {
		(_elements select _i) params ["_name",["_includedListOrAction",{}],["_condToVisible",{true}],["_desc",""]];
		private _w = [_d,TEXT,[_posX,_posY + (_i*_sizeY)+0.5,_sizeX,_sizeY-1],_ctg] call createWidget;
		if (dcm_internal_setFocus) then {
			ctrlSetFocus _w;
			dcm_internal_setFocus = false;
		};
		if equals(dcm_internal_const_copyFromNameValue,_desc) then {
			_desc = _name;
		};
		_w ctrlSetTooltip _desc;
		_w setVariable ["level",_level];
		_w setVariable ["back",_back];
		_w setVariable ["index",_i];
		_backItems pushBack _w;
		_w setBackgroundColor dcm_internal_contextmenu_exitcolor;
		
		private _canVisible = call _condToVisible;
		if !(_canVisible) then {
			_w ctrlEnable false;
			_w setBackgroundColor (dcm_internal_contextmenu_exitcolor apply {(_x - 0.5)max 0});
		};
		
		if (_canVisible) then {
			_w ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor dcm_internal_contextmenu_entercolor}];
			_w ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor dcm_internal_contextmenu_exitcolor}];
		};

		if (_level > 0) then {
			_w setFade 1;
			_w commit 0;
			_w ctrlEnable false;
		};
		
		if equalTypes(_includedListOrAction,[]) then {
			modvar(_name) + "<t align='right' size='1.3'>+"+sgt+"</t>";
			
			_w setvariable ["enabled__",_canVisible];
			_w ctrlAddEventHandler ["MouseButtonUp",{
				if !((_this select 0) getvariable "enabled__") exitwith {};

				_nextBack = ((_this select 0) getVariable "childBack");
				_curBack = (_this select 0) getVariable "back";
				//Если в древе нет текущего бэка то скрываем всю ветку и чистим её
				//В противном же случае чистим до определенного индекса
				private _idx = dcm_contextMenu_tree find _curBack;
				if (_idx != -1) then {
					if (_idx == (count dcm_contextMenu_tree - 1)) then {
						//["noresized %1",dcm_contextMenu_tree apply {_x getVariable "level"}] call printTrace;
					} else {
						//["cursize %1. rem at %2",dcm_contextMenu_tree apply {_x getVariable "level"},_idx] call printTrace;
						//берем последние элементы (_idx+1) и скрываем.
						_selection = dcm_contextMenu_tree select [_idx+1,count dcm_contextMenu_tree - 1];
						{
							[_x] call dcm_internal_hideCat;
							dcm_contextMenu_tree deleteAt (dcm_contextMenu_tree find _x);
						} foreach _selection;
						//dcm_contextMenu_tree resize ((count dcm_contextMenu_tree)-_idx);
						//["new size %1",dcm_contextMenu_tree apply {_x getVariable "level"}] call printTrace;
					};
					
					
				} else {
					//["no find %1",dcm_contextMenu_tree apply {_x getVariable "level"}] call printTrace;
					{
						[_x] call dcm_internal_hideCat;
					} foreach dcm_contextMenu_tree;
					dcm_contextMenu_tree = [];
					//[_curBack] call dcm_internal_hideCat;
				};
				
				[_nextBack] call dcm_internal_showCat;
				dcm_contextMenu_tree pushBack _nextBack; 
			}];
			
		};
		
		if (!_canVisible) then {
			_name = "<t color='#5E5E5E'>"+_name+"</t>";
		};
		[_w,format["<t align='center'>%1</t>",_name]] call widgetSetText;
		if (_name == "") then {
			_w ctrlEnable false;
		};
		
		if equalTypes(_includedListOrAction,[]) then {
			if (count _includedListOrAction > 0) then {
				private _miniOfs = 0.5;
				private _addOffset = if (_posX+_sizeX+_miniOfs>=(100-_sizeX)) then {-_sizeX-_miniOfs} else {_sizeX+_miniOfs};
				[_includedListOrAction,[_posX + _addOffset,_posY+(_i*_sizeY)],_level + 1,_w] call dcm_internal_loadContext;
			};
		} else {
			
			_w setVariable ["_action",_includedListOrAction];
			_w setvariable ["enabled__",_canVisible];
			_w ctrlAddEventHandler ["MouseButtonUp",{
				["enabled action %1",(_this select 0) getvariable "enabled__"] call printTrace;
				if !((_this select 0) getvariable "enabled__") exitwith {};
				
				_buttonContext = _this select 0;
				_nameContext = sanitizeHTML(ctrlText _buttonContext);
				_indexContext = _buttonContext getVariable "index";
				_levelContext = _buttonContext getVariable "level";
				call (_buttonContext getVariable "_action");
				
				call dcm_onResetEnable;
				[call dcm_getCtg,true] call deleteWidget;
				
			}];
		};
		

	};
}

function(dcm_internal_hideCat)
{
	params ["_back"];
	_back setFade 1;
	_back commit 0.2;
	{
		_x setFade 1;
		_x commit 0.1;
		_x ctrlEnable false;
	} foreach (_back getVariable "items");
}

function(dcm_internal_showCat)
{
	params ["_back"];
	_back setFade 0;
	_back commit 0.1;
	{
		_x setFade 0;
		_x commit 0.2;
		_x ctrlEnable true;
	} foreach (_back getVariable "items");
}