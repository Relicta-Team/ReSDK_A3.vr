// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(createWidget_button)
{
	params [["_listAttr",[]],"_pos","_parent"];

	private _display = call getOpenedDisplay;
	if isNullReference(_display) exitWith {
		["%1 - display is null",__FUNC__] call printError;
	};

	_button = [_display,TEXT,_pos,_parent] call createWidget;

	_button setBackgroundColor [0.3,0.3,0.3,0.6];

	{
		_x params ["_attr","_ctx"];
		if (_attr == "onClick") then {
			_button setVariable ["___autoEvent",_ctx];
			_button ctrlAddEventHandler ["MouseButtonUp",{
				nextFrameParams({(_this select 0) getVariable vec2("___autoEvent",{})},_this select 0);
			}];
			continue;
		};
		if (_attr == "text") then {
			[_button,format ["<t align='center'>%1</t>",_ctx]] call widgetSetText;
			continue;
		};
		["%1 - Unknown attribute %2",__FUNC__,_attr] call printWarning;
	} foreach _listAttr;

	_button ctrlAddEventHandler ["MouseEnter", {(_this select 0) setBackgroundColor [0.3,0.3,0.3,0.8]}];
	_button ctrlAddEventHandler ["MouseExit", {(_this select 0) setBackgroundColor [0.3,0.3,0.3,0.6]}];

	_button
}

function(createWidget_closeButton)
{
	params [["_listAttr",[]],"_pos","_parent"];

	private _display = call getOpenedDisplay;
	if isNullReference(_display) exitWith {
		["%1 - display is null",__FUNC__] call printError;
	};

	_closeButton = [_display,TEXT,_pos,_parent] call createWidget;

	_closeButton setBackgroundColor [0.651,0.161,0.161,0.6];

	{
		_x params ["_attr","_ctx"];
		if (_attr == "onClick") then {
			_closeButton setVariable ["___autoEvent",_ctx];
			_closeButton ctrlAddEventHandler ["MouseButtonUp",{
				nextFrameParams({(_this select 0) getVariable vec2("___autoEvent",{})},_this select 0);
			}];
			continue;
		};
		if (_attr == "text") then {
			[_closeButton,format ["<t align='center'>%1</t>",_ctx]] call widgetSetText;
			continue;
		};
		["%1 - Unknown attribute %2",__FUNC__,_attr] call printWarning;
	} foreach _listAttr;

	_closeButton ctrlAddEventHandler ["MouseButtonUp",{
		[true] call displayClose;
	}];

	_closeButton ctrlAddEventHandler ["MouseEnter", {(_this select 0) setBackgroundColor [0.651,0.161,0.161,0.8]}];
	_closeButton ctrlAddEventHandler ["MouseExit", {(_this select 0) setBackgroundColor [0.651,0.161,0.161,0.6]}];

	_closeButton
}


#define define HEIGHT_WINDOW_DRAGGER 3

function(createWidget_window)
{
	params [["_listAttr",[]],"_type","_pos","_parent"];

	private _display = call getOpenedDisplay;
	if isNullReference(_display) exitWith {
		["%1 - display is null",__FUNC__] call printError;
	};

	private _ctg = [_display,_type,_pos,_parent] call createWidget;
	private _background = [_display,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
	_ctg setvariable ["background",_background];

	//create header
	_pos params ["_tx","_ty","_tw","_th"];

	private _titleGroup = [_display,WIDGETGROUP,[_tx,_ty - HEIGHT_WINDOW_DRAGGER,_tw,HEIGHT_WINDOW_DRAGGER]] call createWidget;
	_ctg setvariable ["tg",_titleGroup];
	private _title = [_display,TEXT,[0,0,100 - 10,100],_titleGroup] call createWidget;
	_title setvariable ["connected",_ctg];

	{
		_x params ["_attr","_ctx"];
		if (_attr == "text") then {
			[_title,format ["<t align='center'>%1</t>",_ctx]] call widgetSetText;
			continue;
		};
		if (_attr == "list") then {
			_ctx params ["_elements","_sizeH","_handler"];
			private _w = widgetNull;

			for "_i" from 0 to (count _elements)-1 do {
				_text = _elements select _i;
				_w = [
					[vec2("text",_text),["onClick",{
						[_this getVariable "listIndex",_this getVariable "elementName"] call (_this getVariable "handler")
						}]],
					[0,_sizeH * _i,100,_sizeH],
					_ctg
				] call createWidget_button;
				_w setVariable ["listIndex",_i];
				_w setVariable ["elementName",_text];
				_w setVariable ["handler",_handler];
			};
			continue;
		};
		["%1 - Unknown attribute %2",__FUNC__,_attr] call printWarning;
	} foreach _listAttr;

}

//NON-USABLE FUNCTION
/*function(createWidget_square)
{
	params ["_display","_type","_pos","_parent"];

	private _nsize = transformSizeByAR(_pos select 3);
	_pos set [2,_nsize];

	private _wid = [_display,_type,_pos,_parent] call createWidget;

	_wid setvariable ["isSquare",true];

	_wid
}
*/
