// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(widget_winapi_init)
{
	widget_winapi_lastpressTree = 0;
}

function(widget_winapi_resetLockTreeView)
{
	widget_winapi_lastpressTree = 0;
}

function(widget_winapi_openTextBox)
{
	params ["_refOut",["_header","Ввод текста"],["_desc","Введите текст"],["_baseText",""],["_canMultiLine",true],["_maxlen",1024*2]];
	if isNullVar(_refOut) exitWith {false};
	//private _cachedMousePos = getMousePosition; //replaced inside c#-side
	private _result = ["OOPBuilder","textbox",[_header,_desc,_canMultiLine,_baseText,_maxlen],true] call rescript_callCommand;
	//setMousePosition _cachedMousePos;
	if (_result != "$CLOSED$") exitWith {
		
		private _etok = [_result] call widget_winapi_internal_validateByteCount;
		if (_etok != "") exitWith {
			["Символ '%1' не входит в допустимый диапазон. Уберите его из текста",_etok] call messageBox;
			false
		};
		
		refset(_refOut,_result);
		true
	};
	false
}

function(widget_winapi_internal_validateByteCount)
{
	params ["_data"];
	forceUnicode 0;
	private _bytes = toArray _data;
	private _errorToken = "";
	{
		if (_x > 8000) exitWith {
			_errorToken = toString [_x];
		};
	} foreach _bytes;
	_errorToken
}

function(widget_winapi_openTreeView)
{
	params ["_refOut",["_header","Выбор"],["_desc","Выберите элемент"],["_itemTree",""],["_curItem",""]];
	if isNullVar(_refOut) exitWith {false};
	if (tickTime < widget_winapi_lastpressTree) exitWith {false};

	//private _cachedMousePos = getMousePosition; //replaced inside c#-side
	private _result = ["OOPBuilder","tree",[_header,_desc,_itemTree,_curItem],true] call rescript_callCommand;
	
	widget_winapi_lastpressTree = tickTime + 0.3;
	
	//setMousePosition _cachedMousePos;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,_result);
		true
	};
	false
}

function(widget_winapi_getTreeObject)
{
	params [["_objectName",""],["_handler",{true}]];
	private _data = [];
	private _collectTree = {
		params ["_type","_listref"];
		_type = [_type,"classname"] call oop_getTypeValue;
		_mother = [_type,"__motherclass"] call oop_getTypeValue;
		
		if (_type call _handler) then {
			private _lAdd = _type + ":" + _mother;
			_listref pushBack _lAdd;
			{
				[_x,_listref] call _collectTree;
			} foreach ([_type,false] call oop_getinhlist);
		} else {
			{
				[_x,_listref] call _collectTree;
			} foreach ([_type,false] call oop_getinhlist);
		};

		
	};
	
	private _data = [];
	[_objectName,_data] call _collectTree;
	_data joinString ";"
}

function(widget_winapi_openColor)
{
	params ["_refOut",["_defColor",[0,0,0]],["_precision",6]];
	if isNullVar(_refOut) exitWith {false};
	private _result = ["OOPBuilder","colorbox",[
		clamp(_defColor select 0,0,1),
		clamp(_defColor select 1,0,1),
		clamp(_defColor select 2,0,1)
	],true] call rescript_callCommand;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,(parseSimpleArray _result) apply {parseNumber (_x toFixed _precision)});
		true;
	};
	false
}