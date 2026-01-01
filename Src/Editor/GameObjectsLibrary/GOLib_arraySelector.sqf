// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(golib_init_arraySelector)
{
	if equalTypes(getEdenDisplay getvariable vec2("__arraySelectorCtg",[]),[]) then {
		{
			ctrlDelete _x;
		} foreach (getEdenDisplay getvariable ["__arraySelectorCtg",[]]);
	};

	getEdenDisplay setVariable ["__arraySelectorCtg",null];
}

//функция менеджмента элементов массива
//можно использовать как простые значения, так и усложненные схемы
//Это стековая функция
function(golib_openArraySelector)
{
	params [
		"_rawData",
		["_handlerElementCreate",{}],
		["_handlerSave",{}],
		["_text","Настройка элементов массива"],
		["_save","Сохранить"],
		["_childDisplay",displayNull],
		["_customEventClose",{}],
		["_customEventOnDragFromTree",{}],
		["_lockmodeOnEdenDisplay",false] //блокирует ввод выбора объекта и перемещения
	];

	private _isChildCreate = !isNullReference(_childDisplay);
	private _d = if (_isChildCreate) then {
		getEdenDisplay
	} else {
		[[],[]] call displayOpen
	};

	//прячем предыдущий 
	if equals(_d,getEdenDisplay) then {
		private _oldDisplays = (getEdenDisplay getVariable vec2("__arraySelectorCtg",[]));
		if (count _oldDisplays > 0) then {
			array_selectlast(_oldDisplays) ctrlShow false;
		};
	} else {

	};
	
	private _mH = 80;
	private _mW = 50;
	private _ctg = [_d,WIDGETGROUP,[50-_mW/2,50-_mH/2,_mW,_mH]] call createWidget;
	_ctg setVariable ["_customEventOnDragFromTree",_customEventOnDragFromTree];
	_ctg setVariable ["_customEventClose",_customEventClose]; //copy from closing button
	_ctg setvariable ["__isChildArraySelector",_isChildCreate];
	_ctg setvariable ["_lockmodeOnEdenDisplay",_lockmodeOnEdenDisplay];

	//стековая запись 
	private _ctgStack = _d getVariable ["__arraySelectorCtg",[]];
	_ctgStack pushBack _ctg;
	_d setvariable ["__arraySelectorCtg",_ctgStack];

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.2,.2,.2,.9];
	_ctg setvariable ["_back",_back];
	
	_head = [_d,TEXT,[0,0,100,5],_ctg] call createWidget;
	private _baseText__ = format["<t align='center'>%1</t>",_text];
	[_head,_baseText__] call widgetSetText;
	_ctg setvariable ["_textHeaderAS",_head];
	_head setvariable ["basicText",_baseText__];
	
	_ctgIn = [_d,WIDGETGROUP_H,[2,5,96,100-5-5-2],_ctg] call createWidget;
	
	_buttonSave = [_d,BUTTON,[2,95-1,48,5],_ctg] call createWidget;
	_buttonSave ctrlSetText _save;
	_buttonSave setVariable ["handler",_handlerSave];
	_buttonSave setVariable ["motherDisplay",_d];
	_buttonSave ctrlAddEventHandler ["MouseButtonUp",{
		params ["_but"];
		nextFrame(_but getVariable vec2("handler",{}));

		_listCtx = (_but getvariable "motherDisplay") getvariable vec2("__arraySelectorCtg",[]);
		if (count _listCtx == 0) exitwith {
			["ArraySelector stack ctg empty"] call printError;
		};
		_dispCtx = array_remlast(_listCtx); //пересохранять массив в дисплей не нужно - при создании уже создался бинд

		if (_dispCtx getvariable vec2("__isChildArraySelector",false)) then {
			nextFrameParams({ctrlDelete _this},_dispCtx);
		};
		//restore prev ctx if exists
		if (count _listCtx > 0) then {
			array_selectlast(_listCtx) ctrlShow true;

			if (
				!(array_selectlast(_listCtx) getvariable ["___enableMouseAreaAfterClose",false])
			) then {
				true call MouseAreaSetEnable;
			};
		} else {
			//restore mouse area
			if ((_dispCtx getvariable ["___enableMouseAreaAfterClose",false])) then {
				true call MouseAreaSetEnable;
			};
		};
	}];
	
	_buttonClose = [_d,BUTTON,[50+2,95-1,46,5],_ctg] call createWidget;
	_buttonClose ctrlSetText "Закрыть";
	_buttonClose setVariable ["motherDisplay",_d];
	_ctg setVariable ["_buttonClose",_buttonClose];
	_buttonClose setVariable ["_customEventClose",_customEventClose];
	_buttonClose ctrlAddEventHandler ["MouseButtonUp",{
		params ["_but"];
		_listCtx = (_but getvariable "motherDisplay") getvariable vec2("__arraySelectorCtg",[]);
		if (count _listCtx == 0) exitwith {
			["ArraySelector stack ctg empty"] call printError;
		};
		_dispCtx = array_remlast(_listCtx); //пересохранять массив в дисплей не нужно - при создании уже создался бинд

		if !isNullReference(_dispCtx) then {
			nextFrameParams({ctrlDelete _this},_dispCtx);
			nextFrame(_but getvariable vec2("_customEventClose",{}));
		} else {
			nextFrame(displayClose);
			nextFrame(_but getvariable vec2("_customEventClose",{}));
		};
		//restore prev ctx if exists
		if (count _listCtx > 0) then {
			array_selectlast(_listCtx) ctrlShow true;

			if (
				!(array_selectlast(_listCtx) getvariable ["___enableMouseAreaAfterClose",false])
			) then {
				true call MouseAreaSetEnable;
			};
		} else {
			//restore mouse area
			if ((_dispCtx getvariable ["___enableMouseAreaAfterClose",false])) then {
				true call MouseAreaSetEnable;
			};
		};
	}];
	
	_ctg setVariable ["_ctgAS",_ctgIn];
	_ctg setVariable ["_dataAS",_rawData];
	_ctg setVariable ["_handlerElementCreateAS",_handlerElementCreate];
	_ctg setVariable ["_handlerSaveAS",_handlerSave];
	
	_eventLoad = {
		_d = call golib_getArraySelectorDisplay;
		_ctgStorage = call golib_getArraySelectorCtg;
		_ctg = _ctgStorage getVariable "_ctgAS";
		_data = _ctgStorage getVariable "_dataAS";
		_handlerElementCreate = _ctgStorage getVariable "_handlerElementCreateAS";
		_handlerSave = _ctgStorage getVariable "_handlerSaveAS";
		_eventLoad = _ctgStorage getVariable "_eventLoadAS";
		_textHeaderAS = _ctgStorage getVariable "_textHeaderAS";
		
		//Тут функциональный код например для создания виджетов
		
		{ctrlDelete _x} foreach (allControls _ctg);
		_wid = widgetNull;
		private _countElements = count _data;
		["arraySelector - count loaded elements %1, Storage %2, Display %3",_countElements,_ctgStorage,_d] call printTrace;
		private _globIncrement = 0;
		for "_i" from 0 to _countElements - 1 do {
			_isFirstItem = _i == 0;
			_isLastItem = _i == (_countElements - 1);
			(_data select _i) call _handlerElementCreate;
		};
		
	};
	
	_ctg setVariable ["_eventLoadAS",_eventLoad];
	
	//disable mouse area
	if (_lockmodeOnEdenDisplay) then {
		if (call MouseAreaIsEnabled) then {
			_ctg setvariable ["___enableMouseAreaAfterClose",true];
			false call MouseAreaSetEnable;
		};
	};

	call _eventLoad;
}

function(golib_isInsideArraySelector)
{
	private _dispCtx = getEdenDisplay getVariable vec2("__arraySelectorCtg",[]);
	if (count _dispCtx == 0) exitwith {false};
	_dispCtx = array_selectlast(_dispCtx);

	if !isNullReference(_dispCtx) then {
		_dispCtx call isMouseInsideWidget
	} else {
		_dispCtx = (call getOpenedDisplay) getvariable vec2("__arraySelectorCtg",[]);
		if (count _dispCtx == 0) exitwith {false};
		_dispCtx = array_selectlast(_dispCtx);
		if isNullReference(_dispCtx) exitWith {false};
		_dispCtx call isMouseInsideWidget
	};
}

function(golib_getArraySelectorCtg)
{
	private _disp = call golib_getArraySelectorDisplay;
	if isNullReference(_disp) exitWith {widgetNull};
	private _dispCtx = _disp getVariable vec2("__arraySelectorCtg",[]);
	if (count _dispCtx == 0) exitwith {widgetNull};
	array_selectlast(_dispCtx);
}

//открыт ли селектор
function(golib_isOpenedArraySelector)
{
	!isNullReference(call golib_getArraySelectorCtg)
}

function(golib_getArraySelectorBackground)
{
	private _ctg = call golib_getArraySelectorCtg;
	if isNullReference(_ctg) exitwith {widgetNull};
	_ctg getvariable ["_back",widgetNull];
}

function(golib_getArraySelectorDisplay)
{
	if (call isDisplayOpened) then {
		_d = call getOpenedDisplay;
		// some post check to make sure we have a valid display
		if isNullReference(_d) exitWith {displayNull};
		_dispCtx = _d getVariable vec2("__arraySelectorCtg",[]);
		if (count _dispCtx == 0) exitWith {displayNull};
		_dispCtx = array_selectlast(_dispCtx);
		if isNullReference(_dispCtx) exitwith {
			displayNull
		};
		_d
	} else {
		private _dispCtx = getEdenDisplay getVariable vec2("__arraySelectorCtg",[]);
		if (count _dispCtx == 0) exitwith {widgetNull};
		_dispCtx = array_selectlast(_dispCtx);
		ifcheck(!isNullReference(_dispCtx),getEdenDisplay,displayNull);
	};
}

function(golib_eventReloadArraySelector)
{
	private _d = call golib_getArraySelectorDisplay;
	if isNullReference(_d) exitWith {
		["Cant reload arraySelector - display null reference"] call printError;
	};
	private _ctg = call golib_getArraySelectorCtg;
	if isNullReference(_ctg) exitWith {
		["Cant reload arraySelector - ctg null reference"] call printError;
    };
	private _eventLoadAS = _ctg getVariable ["_eventLoadAS",{}];
	if equals(_eventLoadAS,{}) exitwith {
		["Cant reload arraySelector - event load empty"] call printError;
	};
	call _eventLoadAS;
}

function(golib_onArraySelectorDragFromTree)
{
	params ["_class"];
	private _ctg = call golib_getArraySelectorCtg;
	if isNullReference(_ctg) exitwith {
		["Cant perform drag event - ctg object is null reference"] call printError;
	};
	
	[_class] call (_ctg getvariable ["_customEventOnDragFromTree",{}]);
}
