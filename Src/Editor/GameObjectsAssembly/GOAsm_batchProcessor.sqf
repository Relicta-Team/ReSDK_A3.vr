// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



init_function(goasm_batch_init)
{
	goasm_batch_const_tokenList = [
		"BatchTokenSetVar",
		"BatchTokenWhere",
		"BatchTokenWhereAndExpression",
		"BatchTokenWhereOrExpression",
		"BatchTokenWhereCheckVar",
		"BatchTokenWhereCheckType"
	];
	//worker object list
	goasm_batch_objectsWorklist = [];

	goasm_batch_widgetMap = createHashMap;
}

function(goasm_batch_open)
{
	params ["_objList"];
	if (count _objList == 0) exitWith {
		["Для пакетной обработки объектов выберите один или несколько объектов в сцене."] call showWarning;
	};

	hashSet_clear(goasm_batch_widgetMap);


	goasm_batch_objectsWorklist = (_objList apply {
		if (_x call golib_hasHashData && {!(_x call golib_isVirtualObject) && {not_equals(_x,golib_com_object)}}) then {
			_x
		} else {
			objNull;
		};
	}) - [objNull];

	goasm_batch_executeTokenList = [];
	private _curY = 0;
	private _closeButtonSizeW = 5;
	private _increm = { private _cur = _this; modvar(_curY) + _cur;_cur; };
	private _d = [[],[]] call displayOpen;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,1];

	private _t = [_d,TEXT,[0,_curY,100 - _closeButtonSizeW,5 call _increm]] call createWidget;
	[_t,null,
		[""]+(notificationSounds select 1 select [1,2])
	] call setNotificationContext;
	["onDisplayClose",{
		[null] call setNotificationContext;
	}] call Core_addEventHandler;

	_t = [_d,BUTTON,[100-_closeButtonSizeW,0,_closeButtonSizeW,5]] call createWidget;
	_t ctrlSetBackgroundColor [1,0,0,1];
	_t ctrlSetText "X";
	_t ctrlSetTooltip "Закрыть окно";
	_t ctrlAddEventHandler ["MouseButtonUp",{
		_w = (_this select 0);
		nextFrame(displayClose);
	}];

	_t = [_d,TEXT,[0,_curY,100,6 call _increm]] call createWidget;
	_t setBackgroundColor [0.4,0.4,0.4,1];
	[_t,format["Объектов выбрано: %1",count goasm_batch_objectsWorklist]] call widgetSetText;
	private _batchZoneSizeW = 80;
	private _batchZoneSize = [2,_curY,_batchZoneSizeW,80];
	_back = [_d,BACKGROUND,_batchZoneSize] call createWidget;
	_back setBackgroundColor [0.5,0.5,0.5,1];
	_ctg = [_d,WIDGETGROUP_H,_batchZoneSize] call createWidget;

	private _afterBatchZoneW = _batchZoneSizeW + 2;
	_t = [_d,TEXT,[_afterBatchZoneW,_curY,100-_afterBatchZoneW,5]] call createWidget;
	[_t,"<t align='center'>Список команд</t>"] call widgetSetText;
	_tokList = [_d,LISTBOX,[_afterBatchZoneW,_curY+5,100-_afterBatchZoneW,65]] call createWidget;
	_buttonAdd = [_d,BUTTON,[_afterBatchZoneW,_curY+5+65,100-_afterBatchZoneW,5]] call createWidget;
	_buttonAdd ctrlSetText "Добавить";
	_buttonAdd ctrlAddEventHandler ["MouseButtonUp",{
		nextFrame(goasm_batch_addCurrentToken);
	}];

	goasm_batch_widgetMap set ["ctg",_ctg];
	goasm_batch_widgetMap set ["tokenList",_tokList];
	
	_t = [_d,BUTTON,[4,92,40,6]] call createWidget;
	_t ctrlSetText "Запрос на изменение";
	_t ctrlSetTooltip "Выполняет запрос на изменение объектов";
	_t ctrlAddEventHandler ["MouseButtonUp",{
		nextFrame(goasm_batch_query);
	}];

	call goasm_batch_updateTokenList;

	["Инструмент загружен"] call showInfo;

}

//update listbox of allowed tokens
function(goasm_batch_updateTokenList)
{
	private _lb = goasm_batch_widgetMap get "tokenList";
	lbClear _lb;
	{
		private _name = [_x,"name"] call struct_reflect_getTypeValue;
		private _desc = [_x,"desc"] call struct_reflect_getTypeValue;
		private _index = _lb lbAdd _name;
		_lb lbSetTooltip [_index,_desc];
		_lb lbSetData [_index,_x];

	} foreach goasm_batch_const_tokenList;
}

//add current token
function(goasm_batch_addCurrentToken)
{
	private _lb = goasm_batch_widgetMap get "tokenList";
	private _curIndex = lbCurSel _lb;
	if (_curIndex == -1) exitWith {
		["Не выбран токен"] call showError;
	};
	private _tokenName = _lb lbData _curIndex;
	goasm_batch_executeTokenList pushBack ([_tokenName] call struct_alloc);
	call goasm_batch_updateRender;
}

function(goasm_batch_updateRender)
{
	private _offsY = 1;
	private _curSizeY = 0;
	{
		private _ctg = _x getv(_internalCtg);
		private _sizeH = _x getv(sizeHeight);
		[_ctg,[0,_curSizeY]] call widgetSetPositionOnly;
		_x callp(updateName,_foreachindex + 1);
		modvar(_curSizeY) + _sizeH + _offsY;
	} foreach goasm_batch_executeTokenList;
}

function(goasm_batch_query)
{
	private _hasError = { _errorText != ""};
	private _errorText = "";
	private _setError = {
		_errorText = format["syntax error at %1: %2",_foreachindex+1,_this];
	};

	private _getNext = {
		private _ind = _this + 1;
		if (_ind >= count goasm_batch_executeTokenList) exitWith {null};
		goasm_batch_executeTokenList select _ind;
	};
	private _hasNext = {
		_this < count goasm_batch_executeTokenList
	};


	{
		if (call _hasError) exitWith {};

		private _curTok = _x;
		private _nextTok = _forEachIndex call _getNext;
		["		%1: %2 -> %3",__FUNC__,_curTok,_nextTok] call printTrace;
		//check require
		private _allowNextTokens = _curTok getv(nextTokens);
		private _canBeEnd = _curTok getv(canBeEnd);

		if isNullVar(_nextTok) then {
			if (!_canBeEnd) exitWith {
				(format["Требуется следующий токен(ы): %1",_allowNextTokens apply {
					[_x,"name"] call struct_reflect_getTypeValue
				} joinString ", "]) call _setError;
			};
		} else {
			
			["allow check next: %1 -> %2",_allowNextTokens,_allowNextTokens apply {isinstance_str(_nextTok,_x)}] call printTrace;

			if any_of(_allowNextTokens apply {isinstance_str(_nextTok,_x)}) then {
				["allowed token next: %1",_nextTok] call printTrace;
			} else {
				["non allowed catch"] call printTrace;

				(format[
					"Недопустимый следующий токен: %1; Ожидались: %2",
					[_nextTok,"name"] call struct_reflect_getTypeValue,
					_allowNextTokens apply {
						[_x,"name"] call struct_reflect_getTypeValue
					} joinString ", "
				]) call _setError;
			};
		};

	} foreach goasm_batch_executeTokenList;

	if (call _hasError) exitWith {
		[_errorText,10] call showError;
	};
}
