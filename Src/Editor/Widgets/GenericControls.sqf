// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



//on select ctx data: _index,_text,_data
//_ctxData - специальные контекстные внутренние данные доступные при выборе элемента
//Установив дату в control_const_listElementNoExitAtSelect закрытия листа не произойдёт
function(control_createList)
{
	params [
		"_listElements",
		["_eventOnSelect",{}],
		["_eventOnClose",{}],
		["_eventOnSelChanged",{}],
		["_name","Выберите элемент списка"],
		["_postCreateCode",{}],
		["_ctxData",[]],
		["_childDisplay",displayNull]
	];
	
	private _closeDisplay = isNullReference(_childDisplay);

	if (call isDisplayOpened && _closeDisplay) exitWith {
		startAsyncInvoke
			{
				!call isDisplayOpened
			},
			{
				_this call control_createList
			},
			_this
		endAsyncInvoke
	};
	
	_d = if !_closeDisplay then {
		_childDisplay;
	} else {
		[[],[]] call displayOpen;
	};
	
	_mH = 80;
	_mW = 50;
	_ctg = [_d,WIDGETGROUP,[50-_mW/2,50-_mH/2,_mW,_mH]] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.2,.2,.2,.9];
	_text = [_d,TEXT,[3,0,100-3,5],_ctg] call createWidget;
	[_text,format["<t align='center'>%1</t>",_name]] call widgetSetText;
	_list = [_d,LISTBOX,[3,5,100-3*2,100-5-5],_ctg] call createWidget;
	{
		if equalTypes(_x,[]) then {
			_item = _list lbAdd (_x select 0);
			_list lbSetData [_item,_x select 1];
			_list lbSetTooltip [_item,ifcheck(count _x > 2,_x select 2,"")];
		} else {
			_list lbAdd _x;
		};
	} forEach _listElements;
	_list setVariable ["_eventOnSelChanged",_eventOnSelChanged];
	_list ctrlAddEventHandler ["LBSelChanged",{
		params ["_list","_index"];
		_eventOnSelChanged = _list getVariable "_eventOnSelChanged";
		[_index] call _eventOnSelChanged;
	}];
	
	_butSel = [_d,BUTTON,[3,100-5+0.5,50-3,5-0.5],_ctg] call createWidget;
	_butSel ctrlSetText "Выбрать";
	_butSel setVariable ["_eventOnSelect",_eventOnSelect];
	_butSel setVariable ["_list",_list];
	_butSel setVariable ["_ctxData",_ctxData];
	_butSel setvariable ["_closeDisplay",_closeDisplay];
	_butSel ctrlAddEventHandler ["MouseButtonUp",{
		params ["_butSel","_key"];
		_list = _butSel getVariable "_list";
		_idx = lbCurSel _list;
		if (_idx == -1) exitWith {
			["Не выбран элемент списка",10] call showWarning;
		};
		_ctxData = _butSel getvariable "_ctxData";
		_data = _list lbData _idx;
		_text = _list lbText _idx;
		_index = _idx;
		_eventOnSelect = _butSel getVariable "_eventOnSelect";
		
		if (
			not_equals(_data,control_const_listElementNoExitAtSelect)
			&& (_butSel getvariable "_closeDisplay")
		) then {
			nextFrame(displayClose);
		};
		_delegate = {
			(_this select 0) params ["_index","_text","_data","_ctxData"];
			call (_this select 1);
		};
		_args = [[_index,_text,_data,_ctxData],_eventOnSelect];
		nextFrameParams(_delegate,_args);
	}];
	
	_butCan = [_d,BUTTON,[3+50,100-5+0.5,50-3-3,5-0.5],_ctg] call createWidget;
	_butCan ctrlSetText "Отмена";
	_butCan setVariable ["_eventOnClose",_eventOnClose];
	_butCan setvariable ["_closeDisplay",_closeDisplay];
	_butCan ctrlAddEventHandler ["MouseButtonUp",{
		params ["_butCan","_key"];
		_eventOnClose = _butCan getVariable "_eventOnClose";
		nextFrame(_eventOnClose);
		if (_butCan getvariable "_closeDisplay") then {
			nextFrame(displayClose);
		};
	}];

	//params: _ctg
	call _postCreateCode;

	_ctg
}

//быстрая функция открытия дисплея
function(control_openDisplay)
{
	private _code = _this;
	if (call isDisplayOpened) exitWith {
		startAsyncInvoke
			{
				!call isDisplayOpened
			},
			{
				_this call control_openDisplay
			},
			_this
		endAsyncInvoke
	};
	
	private _d = [[],[]] call displayOpen;
	
	private _mH = 80;
	private _mW = 50;
	private _ctg = [_d,WIDGETGROUP,[50-_mW/2,50-_mH/2,_mW,_mH]] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.2,.2,.2,.9];
	
	call _code;
}