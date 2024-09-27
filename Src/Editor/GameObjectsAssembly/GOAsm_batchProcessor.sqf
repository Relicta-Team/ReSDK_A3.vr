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
	goasm_batch_unicalTypes = [];
	goasm_batch_allFields = [];

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

	call goasm_batch_prepareClassMetadata;

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

function(goasm_batch_prepareClassMetadata)
{
	private _htypes = hashSet_createEmpty();
	{
		hashSet_add(_htypes,[_x] call golib_getClassName);
	} foreach goasm_batch_objectsWorklist;
	goasm_batch_unicalTypes = hashSet_toArray(_htypes);

	private _fields = [];
	{
		private _type = _x;
		private _attrFList = [_type,"_redit_attribFields"] call oop_getTypeValue;
		{
			_memberName = _x;
			_memberVisibleName = _x;
			_atrList = _y;
			_editorContext = null;
			{
				private _atrName = _x select 0;
				if (_atrName == "alias") then {
					if (count _x > 1) then {
						_memberVisibleName = _x select 1;
					};
					continue;
				};
				if (_atrName == "EditorVisible") then {
					
					_idx = _x findif {"type:"in _x};
					if (_idx!=-1) exitWith {
						_editorType = ["check",((_x select _idx) splitString ":") select 1] call goasm_attributes_providerNativeGet;
						if (_editorType!="") then {
							_editorContext = _x select [1,count _x];
						};
					};
					_idx = _x findif {"custom_provider:"in _x};
					if (_idx!=-1) then {
						_editorType = ((_x select _idx) splitString ":") select 1;
						if (_editorType!="") then {
							_editorContext = _x select [1,count _x];
						};
					};

					continue;
				};
			} foreach _atrList;
			if !isNullVar(_editorContext) then {
				_edCtxFull = _editorContext;
				if !([_editorContext select 0,"type:"] call stringStartWith) exitWith {
					["unknown context: %1",_editorContext] call printWarning;
				};
				_editorContext = [_editorContext select 0,"type:",""] call stringReplace;
				_fields pushBack (
					struct_newp(BatchVariableInfo,_memberVisibleName arg _type arg _memberName arg _editorContext arg _edCtxFull)
				)
			};
		} foreach _attrFList;

	} forEach goasm_batch_unicalTypes;

	goasm_batch_allFields = _fields;
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


function(goasm_batch_provideProps)
{
	params ['self',"_ctxField","_widgetList","_startPosX"];
	["Loading provider: %1 %2",self,_ctxField] call printTrace;
	//predefines
	private _controlGroup = self getv(_internalCtg);
	private _eventOnLoad__ = _ctxField getv(onLoadWidget);
	private _memberName = _ctxField getv(visibleName);
	private _editorContext = _ctxField getv(editorContext);

	private _d = self callv(getDisplay);
	private _sizeY_ctg_bias = 0.5;
	private _sizeY = _sizeY_ctg_bias;  //начальный поз
		private _internalY = 25;
		private _optimalSizeH = 50;
		private _offsetMemX = _startPosX;//_sizeMemX;
		private _wid = widgetNull; //внешняя ссылка для назначения свойств
		
	private _backgroundPrev = widgetNull;
	private _ctgGroupType = WIDGETGROUP_H;
	private _wid = widgetNull;
	private _ctgInspectorMain = _controlGroup;

	//as list
	private _objWorld = goasm_batch_objectsWorklist;
	private _data = createHashMapFromArray [["class","DISABLED_DATA"],["customProps",null]];
	

	//! not used
	_createCTGExt = {
		if !isNullReference(_backgroundPrev) then {
			[_backgroundPrev,[0,0,100,_internalY max 100]]call widgetSetPosition;
		};
		_internalY = 0;
		private _siz_h = _this;
		_optimalSizeH = 3*100/_siz_h; // <--- ТУТ ВСЁ РЕШАЕТСЯ. Меньше число = больше элементов вместится(мельче)
		_controlGroup = [_d,_ctgGroupType,[0,_sizeY,96,_siz_h],_ctgInspectorMain] call createWidget;
		_backgroundPrev = [_d,BACKGROUND,WIDGET_FULLSIZE,_controlGroup] call createWidget;
		_backgroundPrev setBackgroundColor [.3,.3,.3,.3];
		modvar(_sizeY) + _siz_h + _sizeY_ctg_bias;
	};
	
	//used
	_createElement = {
		params ["_type","_sizes",["_directionX",0],["_addOfsY",true],["_yOfs",0]];
		private _wSize = (_sizes select 0); //TODO можно ограничить по-умоному если скролл появился
		private _pos = [_directionX,_internalY + _yOfs,_wSize,_sizes select 1];		
		
		_wid = [_d,_type,_pos,_controlGroup] call createWidget;
		_widgetList pushBack _wid;

		//_wid setVariable ["_refObj",_obj];//! not used
		_wid setVariable ["_refWorldObj",_objWorld];
		_wid setVariable ["_defPos",_pos];
		_wid setVariable ["_ctg",_controlGroup];
		_wid setVariable ["_ctgInspector",_ctgInspectorMain];
		if !isNullVar(_memberName) then {
			_wid setVariable ["_memberName",_memberName];
		};
		_wid setVariable ["_setContext",{
			private __contextFunc = _this;
			_objWorld = _wid getVariable "_refWorldObj";
			_data = [_objWorld] call golib_getHashData;
			_memberName = _wid getVariable "_memberName";
			call __contextFunc;
		}];
		if (_addOfsY) then {
			modvar(_internalY) + (_sizes select ifcheck(count _sizes >= 3,2,1));
		};
	};
	// _setSyncValCode = {
	// 	private _code = _this;
	// 	_wid setVariable ["_onSync",_code];
	// 	call _code;
	// };

	// _setOnMouseDownCode = {
	// 	_wid setVariable ["_onMouseDown",_this];
	// 	_wid ctrlAddEventHandler ["MouseButtonDown",{
	// 		call {
	// 		params ["_wid","_key", "_xPressPos", "_yPressPos","_shift","_ctrl","_alt"];
	// 		private _objWorld = _wid getVariable "_refWorldObj";
	// 		private _data = [_objWorld] call golib_getHashData;
	// 		private _memberName = _wid getVariable "_memberName";
	// 		call (_wid getVariable "_onMouseDown");
	// 		call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };
	_setOnPressCode = {
		_wid setVariable ["_onPress",_this];
		_wid ctrlAddEventHandler ["MouseButtonUp",{
			call {
				params ["_wid","_key", "_xPressPos", "_yPressPos","_shift","_ctrl","_alt"];
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onPress");
				call (_wid getVariable "_onSync");
			}
		}];
	};
	// _setOnMovingCode = {
	// 	_wid setVariable ["_onMoving",_this];
	// 	_wid ctrlAddEventHandler ["MouseMoving",{
	// 		call {
	// 		params ["_wid","_x", "_y", "_mouseOver"];
	// 		private _objWorld = _wid getVariable "_refWorldObj";
	// 		private _data = [_objWorld] call golib_getHashData;
	// 		private _memberName = _wid getVariable "_memberName";
	// 		call (_wid getVariable "_onMoving");
	// 		call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };
	// _setOnCBChanged = {
	// 	_wid setVariable ["_onCheckChanged",_this];
	// 	_wid ctrlAddEventHandler ["CheckedChanged",{
	// 		call {
	// 		params ["_wid","_checked"];
	// 		_checked = _checked > 0;
	// 		private _objWorld = _wid getVariable "_refWorldObj";
	// 		private _data = [_objWorld] call golib_getHashData;
	// 		private _memberName = _wid getVariable "_memberName";
	// 		call (_wid getVariable "_onCheckChanged");
	// 		call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };
	// _setOnKeyUpCode = {
	// 	_wid setVariable ["_onKeyUp",_this];
	// 	_wid ctrlAddEventHandler ["KeyUp",{
	// 		call {
	// 		params ["_wid","_key","_shift","_ctrl","_alt"];
	// 		private _objWorld = _wid getVariable "_refWorldObj";
	// 		private _data = [_objWorld] call golib_getHashData;
	// 		private _memberName = _wid getVariable "_memberName";
	// 		call (_wid getVariable "_onKeyUp");
	// 		call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };
	// _setOnKillFocusCode = {
	// 	_wid setVariable ["_onKillFocus",_this];
	// 	_wid ctrlAddEventHandler ["KillFocus",{
	// 		call {
	// 		params ["_wid"];
	// 		private _objWorld = _wid getVariable "_refWorldObj";
	// 		private _data = [_objWorld] call golib_getHashData;
	// 		private _memberName = _wid getVariable "_memberName";
	// 		call (_wid getVariable "_onKillFocus");
	// 		call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };
	// _setSliderPosChangedCode = {
	// 	_wid setVariable ["_onSliderPosChanged",_this];
	// 	_wid ctrlAddEventHandler ["SliderPosChanged",{
	// 		call {
	// 			params ["_wid","_value"];
	// 			private _objWorld = _wid getVariable "_refWorldObj";
	// 			private _data = [_objWorld] call golib_getHashData;
	// 			private _memberName = _wid getVariable "_memberName";
	// 			call (_wid getVariable "_onSliderPosChanged");
	// 			call (_wid getVariable "_onSync");
	// 		}
	// 	}];
	// };

	call _eventOnLoad__;
	["created: %1",_widgetList apply {format["%1 at %2",_x,_x call widgetGetPosition]}] call printTrace;
}