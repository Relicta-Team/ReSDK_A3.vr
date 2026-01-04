// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

function(goasm_attributes_providerNativeGet)
{
	params ["_mode","_ctx"];
	_nativetypes = ["bool","int","float","string"];
	if (_mode=="check") exitWith {
		if !(_ctx in _nativetypes) exitWith {
			["%1 - unknown type %2 in %3",__FUNC__,_ctx,_type+"::"+_memberName] call printError;
			continue
		};
		_ctx
	};
};

//special macro redefine (for providers)
#define ITEM_SIZE_LIST_ALL [ITEM_SIZE_TINY,ITEM_SIZE_SMALL,ITEM_SIZE_MEDIUM,ITEM_SIZE_LARGE,ITEM_SIZE_BIG,ITEM_SIZE_HUGE]
#define ITEM_SIZE_LIST_NAME_ALL ["Крошечный","Маленький","Средний","Крупный","Большой","Огромный"]

//TODO not used now... Replace to game constants 
#define ITEM_SIZE_MINIMUM ITEM_SIZE_TINY
#define ITEM_SIZE_MAXIMUM ITEM_SIZE_HUGE

;
function(goasm_attributes_handleProvider_bool)
{
	["RscCheckBox",[10,_optimalSizeH],_offsetMemX,false] call _createElement;
	_wid setVariable ["_memberName",_memberName];
	_wid setVariable ["_editorContext",_editorContext];
	_check = _wid;
	{
		//["ctx: %1",_wid getVariable "_editorContext"] call printTrace;
		_defState = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		//conditions: have val OR set from reflect
		_props = _data get "customProps";
		if (_memberName in _props) then {
			_wid cbSetChecked (_props get _memberName)
		} else {
			_wid cbSetChecked _defState
		};
	} call _setSyncValCode;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		_pval = _props getOrDefault [_memberName,_defval];
		if equals(_defval,_pval) then {
			_props set [_memberName,!_defval];
		} else {
			_props deleteAt _memberName;
		};
		[_memberName,"cprov"] call goilb_setBatchMode;
		[_objWorld,_data,true] call golib_setHashData;
	} call _setOnCBChanged;
	[BUTTON,[20,_optimalSizeH],_offsetMemX + 10,true] call _createElement;
	_wid setVariable ["_memberName",_memberName];
	_wid setVariable ["checkProvBool",_check];
	_wid ctrlSetText "СБРОС";
	{
		(_data get "customProps") deleteAt _memberName;
		[_memberName,"cprov"] call goilb_setBatchMode;
		[_objWorld,_data,true] call golib_setHashData;
		_wid = _wid getVariable "checkProvBool";
		call (_wid getVariable "checkProvBool" getVariable "_onSync");
	} call _setOnPressCode;
}

function(goasm_attributes_handleProvider_int)
{
	private _inputType = "int";
	private _conditionType = { //стандартная валидация типа
		params ["_newVal"];
		(floor parseNumber _newVal) == (parseNumber _newVal)
	};
	private _setNewValue_prov = { //установка новое значение типа 
		_props set [_memberName,floor parseNumber _this]
	};
	call goasm_attributes_handleProvider_inputGeneric;
}

function(goasm_attributes_handleProvider_float)
{
	private _inputType = "float";
	private _conditionType = { 
		params ["_newVal"];
		true//(floor parseNumber _newVal) == (parseNumber _newVal)
	};
	private _setNewValue_prov = { 
		_props set [_memberName,parseNumber _this]
	};
	call goasm_attributes_handleProvider_inputGeneric;
}

function(goasm_attributes_handleProvider_string)
{
	private _inputType = "string";
	private _conditionType = { 
		params ["_newVal"];
		true
	};
	private _setNewValue_prov = { 
		_props set [_memberName,_this]
	};
	call goasm_attributes_handleProvider_inputGeneric;
}

function(goasm_attributes_handleProvider_inputGeneric)
{
	
	private _checkRange = {true}; private _rangeValues = [0,0];
	private _idxRange = _editorContext findif {"range:" in _x};
	private _allowedRangeText = "";
	if (_idxRange != -1 && _inputType in ["int","float"]) then {
		((_editorContext select _idxRange) splitString ":")params["",["_min",0],["_max",1]];
		_allowedRangeText = format["Допустимый диапазон:\nот %1 до %2",_min,_max];
		_rangeValues = [parseNumber _min,parseNumber _max];
		_checkRange = {
			(_wid getVariable "_rangeValues_InputGeneric") params ["_min","_max"];
			_num = parseNumber _this;
			inRange(_num,_min,_max)
		}
	};
	_idxRange = _editorContext findif {"stringmaxsize:" in _x};
	if (_idxRange!=-1 && _inputType == "string") then {
		_rangeValues = parseNumber(((_editorContext select _idxRange) splitString ":") select 1);
		_allowedRangeText = format["Макс. размер строки:\n%1 символов",_rangeValues];
		_checkRange = {
			forceUnicode 0;
			(count _this) <= ((_wid getVariable "_rangeValues_InputGeneric") )
		}
	};
	
	
	
	[BUTTON,[10,_optimalSizeH],_offsetMemX,false] call _createElement;
	_wid setVariable ["_memberName",_memberName];
	_wid setVariable ["_editorContext",_editorContext];
	_button = _wid;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - Применить значение\nПКМ - Сброс на стандарт";
	{
		_wid = _wid getVariable "input";
		if (_key == MOUSE_LEFT) then {
			call (_wid getVariable "_onKillFocus");
		} else {
			(_data get "customProps") deleteAt _memberName;
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
		};
	} call _setOnPressCode;
	
	[INPUT,[40,_optimalSizeH],_offsetMemX+10,true] call _createElement;
	_button setVariable ["input",_wid];
	if (_allowedRangeText!="") then {
		_allowedRangeText = "Вводимый тип данных: "+_inputType+"\n\n"+_allowedRangeText;
	} else {
		_allowedRangeText = "Вводимый тип данных: "+_inputType
	};

	if (_inputType=="string") then {
		modvar(_allowedRangeText) + "\n\n" + "Нажмите ПКМ для детального редактирования";
		{
			if (_key == MOUSE_RIGHT) then {
				//Жидко... но работает
				private _ref = refcreate("");
				_props = _data get "customProps";
				private _base = ctrlText _wid;//[_objWorld,_memberName] call golib_getActualDataValue;
				//["base %1",_base] call printTrace;
				_maxlen = (_wid getVariable "_rangeValues_InputGeneric");
				if not_equalTypes(_maxlen,0) then {_maxlen = 0};
				forceUnicode 1;
				if ([_ref,"Изменение поля " + format["%1::%2 (max %3, cur: %4)",_data get "class",_memberName,_maxlen,count toarray _base],"Введите текст",_base,true,_maxlen] call widget_winapi_openTextBox) then {
					private _newvalue = refget(_ref);
					["New count %1",count toarray _newvalue] call printTrace;
					_props set [_memberName,_newvalue];
					private _changedData = true;
					_defval = [_data get "class",_memberName] call oop_getFieldBaseValue;
					//["pre (%1); post (%2)",_defval,str _newvalue] call printTrace;
					if (equals(str _newvalue,_defval) || _newvalue == "") then {
						if (_memberName in _props) then {_changedData = true} else {_changedData = false};
						_props deleteAt _memberName;
					};
					if (_changedData) then {
						[_memberName,"cprov"] call goilb_setBatchMode;
						[_objWorld,_data,true] call golib_setHashData;
					};
				};
			};
		} call _setOnPressCode;
	};

	_wid ctrlSetTooltip _allowedRangeText;
	_wid setVariable ["_memberName",_memberName];
	_wid setvariable ["_button",_button];
	_wid setVariable ["_editorContext",_editorContext];
	_wid setVariable ["_inputType",_inputType];
	_wid setVariable ["_conditionType",_conditionType];
	_wid setVariable ["_checkRange",_checkRange];
	_wid setVariable ["_setNewValue_prov",_setNewValue_prov];
	_wid setVariable ["_rangeValues_InputGeneric",_rangeValues];
	
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName] call oop_getFieldBaseValue;
		
		if (_memberName in _props && not_equals(_defval,ctrlText _wid)) then {
			_wid ctrlSetText format["%1",_props get _memberName];
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
			//["SETTED %1",_val] call printError;
		} else {
			_pastedVal = if ((_wid getVariable "_inputType")=="string") then {
				if ([_defval,"\b(nil|call)\b"] call regex_ismatch) then {
					_defval
				} else {
					call compile _defval
				}
			} else {format vec2("%1",_defval)};
			_wid ctrlSetText _pastedVal;
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
			//["RETDEF %1",_val] call printError;
		};
	} call _setSyncValCode;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName] call oop_getFieldBaseValue;
		_val = ctrlText _wid;
		if (_val == "" || {equals(str _val,_defval)}) then { //тут фикс при применении строки с деф знач.
			_val = _defval;
			//["EMPTY %1",_val] call printTrace;
		};
		forceUnicode 1; //global enable unicode

		if ([_val] call (_wid getVariable "_conditionType")) then {
			//["stage %1",_wid getVariable "_conditionType"] call printTrace;
			
			if !(_val call (_wid getVariable "_checkRange") || equals(_val,_defval)) exitWith {
				private _itinf = "";
				if ((_wid getVariable "_inputType")=="string") then {
					_itinf = format[". Количество %1, Допустимо %2",count _val,_wid getvariable "_rangeValues_InputGeneric"]
				};
				[format["Значение %1::%2 вне диапазона%3",_data get "class",_memberName,_itinf],4] call showWarning;
			};
			//["stage %1",_wid getVariable "_checkRange"] call printTrace;
			_val call (_wid getVariable "_setNewValue_prov");
			//["%1 %2 %3 %4",equals(_val,_defval),typename _val,typename _defval,[_val,_defval]] call printTrace;
			//! второе условие для фикса когда идет установка значения, равного числовому дефолтному
			if (equals(_val,_defval) || equals(_val,str _defval)) then {
				_props deleteAt _memberName;
			};
			//["stage %1",_wid getVariable "_setNewValue_prov"] call printTrace;
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
		};

		
		
	} call _setOnKillFocusCode;
}

function(goasm_attributes_handleProvider_size)
{
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_wid setVariable ["_memberName",_memberName];
	_input = _wid;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		if (_memberName in _props && {not_equals(_defval,_props get _memberName)}) then {
			_wid ctrlSetText (ITEM_SIZE_LIST_NAME_ALL select ((_props get _memberName)-1));
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_wid ctrlSetText (ITEM_SIZE_LIST_NAME_ALL select (_defval-1));
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
	} call _setSyncValCode;
	[BUTTON,[10,_optimalSizeH],_offsetMemX + 40,true] call _createElement;
	_wid setVariable ["input",_input];
	_wid ctrlSetText "+";
	{
		_wid = _wid getVariable "input";
		
		_codeOnPressContext = {
			(call contextMenu_getContextParams) params ["_wid","__codeValidateContainer"];
			
			{
				_props = _data get "customProps";
				_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
				_val = ITEM_SIZE_LIST_ALL select _indexContext;
				_props set [_memberName,_val];
				if equals(_val,_defval) then {
					_props deleteAt _memberName;
				};
				
				//call __codeValidateContainer;
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				
				call (_wid getVariable "_onSync");	
			} call (_wid getVariable "_setContext");
		};
		_build = ITEM_SIZE_LIST_NAME_ALL apply {[_x,_codeOnPressContext]};
		
		//Логика контейнера будет проверяться в провайдере контейнерного добавления
		// __codeValidateContainer = {
		// 	if ("containerContent" in _data) then {
		// 		private _errorContainer = false;
		// 		private _refContent = _data get "containerContent";
		// 		{
		// 			_x params ["_serializedHash","_countItems"];
		// 			//validate
		// 			if !([_data,_serializedHash,_refContent,_countItems,false] call golib_attributes_container_content_validateAdd) exitwith {
		// 				// validate failed
		// 				_errorContainer = true;
		// 			};
		// 		} foreach _refContent;
				
		// 		if (_errorContainer) then {
		// 			["Контейнер очищен из-за ошибки логики"] call showWarning;
		// 			_data deleteAt "containerContent";
		// 		};
		// 	};
			
		// };

		[
			[
				["Выбрать",_build],
				["Сброс на дефолт.",{
					(call contextMenu_getContextParams) params ["_wid","__codeValidateContainer"];
					{
						_props = _data get "customProps";
						_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
						_val = _props getOrDefault [_memberName,_defval];
						if not_equals(_val,_defval) then {
							_props deleteAt _memberName;
							
							//call __codeValidateContainer;
							[_memberName,"cprov"] call goilb_setBatchMode;
							[_objWorld,_data,true] call golib_setHashData;
							call (_wid getVariable "_onSync");	
						};
					} call (_wid getVariable "_setContext");
				}],
				["Отмена",{}]
			],
			call mouseGetPosition,
			[_wid,__codeValidateContainer]
		] call contextMenu_create;
	} call _setOnPressCode;
	
}


function(goasm_attributes_handleProvider_icon)
{
	[BACKGROUND,[30,_optimalSizeH * 4],_offsetMemX,false] call _createElement;
	_wid setBackgroundColor [0.1,0.1,0.1,0.2];

	[PICTURE,[30,_optimalSizeH * 4],_offsetMemX,false] call _createElement;
	_picture = _wid;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		if (_memberName in _props && {not_equals(_defval,_props get _memberName)}) then {
			_wid ctrlSetText PATH_PICTURE_INV(_props get _memberName);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_wid ctrlSetText PATH_PICTURE_INV(_defval);
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
		_wid ctrlSetTooltip format["Путь до файла: %1",ctrlText _wid];
		
	} call _setSyncValCode;
	
	[BUTTON,[20,_optimalSizeH * 2],_offsetMemX + 30,false,_optimalSizeH * 2] call _createElement;
	_wid ctrlSetText "Синхр.";
	_wid ctrlSetTooltip "Производит синхронизацию иконки с текущей моделью";
	_wid setVariable ["_picture",_picture];
	{
		_props = _data get "customProps";
		_picture = _wid getVariable "_picture";
		if ("model" in _props) then {
			_mod = _props get "model";
			_wid = _picture;
			if ("\" in _mod) then {
				_mod = "gen\"+(_mod splitString "\/." joinString "+");
			} else {
				_errCode = "ERROR:<cfg2model> __FILE_NOT_FOUND__";
				_mod = core_cfg2model getVariable [_mod,_errCode];
				if (_mod == _errCode) exitWith {};
				_mod = "gen\"+(_mod splitString "\/." joinString "+");
			};
			if !(FILEEXISTS PATH_PICTURE_INV(_mod)) exitWith {
				["Inventory icon not found or not generated - "+PATH_PICTURE_INV(_mod),10] call showWarning;
			};
			_props set [_memberName,_mod];
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
		} else {
			_wid = _picture;
			
			_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
			_curpic = "gen\"+((core_cfg2model getVariable [[_objWorld,false] call golib_om_getConfigByObject,"ERR_ICON_PROVIDER_NO_CFG2MODEL"]) splitString "\/." joinString "+");
			_hasNewPicExists = FILEEXISTS PATH_PICTURE_INV(_curpic);
			["%1 %2",_curpic,_hasNewPicExists] call printTrace;
			if (_defval!=_curpic && _hasNewPicExists) then {
				_props set [_memberName,_curpic];
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
			} else {
				_data get "customProps" deleteAt _memberName;
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				if (!_hasNewPicExists) then {
					["Иконка для модели ("+(_curpic)+") не найдена в библиотеке иконок - сброс на иконку по умолчанию",5] call showInfo;
				} else {
					["Модель экземпляра "+(_data get "class")+" не заменена - сброс на иконку по умолчанию"] call showInfo;
				};
			};
			
			call (_wid getVariable "_onSync");
		};
	} call _setOnPressCode;
	
	[BUTTON,[20,_optimalSizeH * 2,_optimalSizeH * 4],_offsetMemX + 30,true] call _createElement;
	_wid ctrlSetText "Замена";
	_wid ctrlSetTooltip "ЛКМ - открыть список\nПКМ - вернуть на дефолтное значение";
	_wid setVariable ["picture",_picture];
	{
		_picture = _wid getVariable "picture";
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		if (_key == MOUSE_RIGHT) exitWith {
			_wid = _picture;
			_data get "customProps" deleteAt _memberName;
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
		};
		
		call Core_pushContext;
		
		_d = [] call displayOpen;
		_ctg = [_d,WIDGETGROUP,[30,30,50,50]] call createWidget;
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
		_back setBackgroundColor [.3,.3,.3,.5];
		
		_n = [_d,TEXT,[0,0,50,10],_ctg] call createWidget;
		[_n,"Выберите иконку из списка или введите запрос >"] call widgetSetText;
		_but = [[["text","Отмена"]],[0,90,100,10],_ctg] call createWidget_closeButton;
		_but ctrlAddEventHandler ["MouseButtonUp",{
			call Core_popContext;
		}];
		
		_inp = [_d,INPUT,[50,0,50,10],_ctg] call createWidget;
		_inp ctrlAddEventHandler ["KillFocus",{
			_ctg = (_this select 0) getVariable "_ctg";
			_val = ctrlText (_this select 0);
			call ((_this select 0) getVariable "__calledOnSearch");
		}];
		
		__calledOnSearch = {
			_d = call getOpenedDisplay;
			{ctrlDelete _x} foreach (allControls _ctg);
			_sorted = array_copy(golib_internal_buffer_icons);
			_sorted sort true;
			_factvalList = [];
			if (_val != "") then {
				{
					if ((tolower _val) in (tolower _x)) then {
						_factvalList pushBack _x;
					};
				} foreach _sorted;
			} else {_factvalList = _sorted;};
			
			{
				_b = [_d,TEXT,[0,15 * _forEachIndex,100,15],_ctg] call createWidget;
				_b setVariable ["_pictStr",_x];
				[_b,format[
					"<img size='2.5' image='%1'/><t size='0.9'>                  %2</t>",
					PATH_PICTURE_INV(_x),_x]
				] call widgetSetText;
				_b ctrlAddEventHandler ["MouseEnter", {(_this select 0) setBackgroundColor [0.1,0.1,0.1,0.8]}];
				_b ctrlAddEventHandler ["MouseExit", {(_this select 0) setBackgroundColor [0.1,0.1,0.1,0.6]}];
				_b setBackgroundColor [0.1,0.1,0.1,0.6];
				_b ctrlAddEventHandler ["MouseButtonUp",{
					_b = _this select 0;
					{
						_wid = _picture;
						//Вот тут надо общий алг.
						_val = _b getVariable "_pictStr";
						_props set [_memberName,_val];
						if equals(_val,_defval) then {
							_props deleteAt _memberName;
						};
						[_memberName,"cprov"] call goilb_setBatchMode;
						[_objWorld,_data,true] call golib_setHashData;
						call (_wid getVariable "_onSync");	
					} call Core_callContext;
					[true] call displayClose;
					call Core_popContext;
				}];
				
			} foreach _factvalList;
		};
		
		
		_ctg = [_d,WIDGETGROUP_H,[5,10,90,80],_ctg] call createWidget;
		_inp setVariable ["_ctg",_ctg];
		_inp setVariable ["__calledOnSearch",__calledOnSearch];
		_val = "";
		
		call __calledOnSearch;
	} call _setOnPressCode;
}

function(goasm_attributes_handleProvider_scriptedlight)
{
	["RscEditReadOnly",[40+20,_optimalSizeH],_offsetMemX-20,false] call _createElement;
	_input = _wid;
	{
		if !(call vcom_emit_io_isEnumConfigsLoaded) then {
			[true] call vcom_emit_io_loadEnumAssoc;
		};

		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,false] call oop_getFieldBaseValue;
		
		if (_memberName in _props) then {
			_keyName = (_props get _memberName);
			_wid ctrlSetText ([_keyName,"UNKERR->%1"] call vcom_emit_io_parseScriptedConfigName);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_wid ctrlSetText ([_defval,"[error] %1"] call vcom_emit_io_parseScriptedConfigName);
			if ("[error]" in (ctrlText _wid)) then {
				_wid ctrlSetBackgroundColor [.5,.15,.15,.3];
			} else {
				_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
			};
		};
	} call _setSyncValCode;
	_input ctrlSetTooltip "ПКМ - для открытия редактирования этого конфига";
	{
		if (_key == MOUSE_RIGHT) then {
			_postcode = {
				params ["_obj","_text"];
				if isNullVar(_text) exitWith {};
				if equals(_text,"") exitWith {};
				if ("deprecated" in _text) exitWith {};

				_obj call vcom_emit_createVisualWindow;
				
				[_text] call vcom_emit_io_loadConfigCheck;
			};
			nextFrameParams(_postcode,[_objWorld arg ctrlText _wid]);
		};
	} call _setOnPressCode;

	[BUTTON,[10,_optimalSizeH],_offsetMemX + 40,true] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - меню выбора света\nПКМ - сброс на стандартное значение";
	_wid setVariable ["_input",_input];
	{
		if (_key == MOUSE_LEFT) then {
			if !(call vcom_emit_io_isConfigsLoaded) then {
				call vcom_emit_io_readConfigs;
			};

			_defval = [_data get "class",_memberName,false] call oop_getFieldBaseValue;
			_keyName = vcom_emit_io_enumAssocKeyInt getorDefault [_defval,"ERROR_NULL_CONFIG"];

			call Core_pushContext;
			_nf = {
				/*
				"_listElements",
				["_eventOnSelect",{}],
				["_eventOnClose",{}],
				["_eventOnSelChanged",{}],
				["_name","Выберите элемент списка"],
				["_postCreateCode",{}],
				*/
				[
					vcom_emit_io_list_allConfigsNames apply {toUpper _x},
					{
						//onselect
						{
							//_wid = "_wid" call Core_getContextVar;
							
							_wid = _wid getvariable "_input";
							_props = _data get "customProps";
							_val = format["SLIGHT_%1",_text];

							//["%1 ----- %2",_val,_keyName] call messageBox;
							_props set [_memberName,_val];
							if equals(_val,_keyName) then {
								_props deleteAt _memberName;
							};
							[_memberName,"cprov"] call goilb_setBatchMode;
							[_objWorld,_data,true] call golib_setHashData;
							call (_wid getVariable "_onSync");	

							{[_x] call lsim_reloadLightOnObject} foreach inspector_allSelectedObjects;

						} call Core_callContext;
						call Core_popContext;
					},
					{
						//onclose
						call Core_popContext;
					},
					null,
					"Выберите тип освещения/частиц для данного объекта"

				] call control_createList;
			}; nextFrame(_nf);
		} else {
			_input = _wid getVariable "_input";
			_props = _data get "customProps";
			_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
			
			_wid = _input;
			_data get "customProps" deleteAt _memberName;
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
			
			{[_x] call lsim_reloadLightOnObject} foreach inspector_allSelectedObjects;
		};
	} call _setOnPressCode;
}

function(goasm_attributes_handleProvider_weight_eval)
{
	params ["_val",["_evalToProperty",false]];
	forceUnicode 0;
	
	if (_evalToProperty) exitwith {
		_val = tolower _val;
		_isKg = [_val,"\d+(\.\d+)?\s*кг"] call regex_ismatch;
		_isGramm = [_val,"\d+(\.\d+)?\s*г"] call regex_ismatch;
		if (_isGramm) exitwith {
			format['gramm(%1)',clamp(parseNumber _val,0,1000)]
		};
		if (_isKg) exitwith {
			format["%1",clamp(parseNumber _val,1,1000)]
		};
		""
	};

	(_val splitString " / ")params ["_leftOp","_rightOp"];
	private _leftOp = parseNumber _leftOp;
	if isNullVar(_rightOp) exitwith {
		format["%1 кг.",_leftOp];
	};
	if (_leftOp >= 1000) then {
		format["%1 кг.",_leftOp/1000];
	} else {
		format["%1 г.",_leftOp];
	};
}

function(goasm_attributes_handleProvider_weight)
{
	private _event = {
		_input = _wid getVariable "_input";
		_text = ctrlText _input;
		_wid = _input;
		_props = _data get "customProps";
		_key = if isNullVar(_key) then {MOUSE_LEFT} else {_key};//killfoucs fix
		["trace %1 %2",_text,_key] call printTrace;
		if (_key == MOUSE_LEFT) then {
			_eval = [_text,true] call goasm_attributes_handleProvider_weight_eval;
			_defval = [_data get "class",_memberName,false] call oop_getFieldBaseValue;
			["Evaluated weight %1 [%2]",_eval,_text] call printTrace;
			if (_eval == _defval || _eval == "") exitwith {
				if (_memberName in _props) then {
					_props deleteAt _memberName;
					[_memberName,"cprov"] call goilb_setBatchMode;
					[_objWorld,_data,true] call golib_setHashData;
					call (_wid getVariable "_onSync");	
				};
			};

			_props set [_memberName,_eval];
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
		} else {
			if (_memberName in _props) then {
				_props deleteAt _memberName;
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				call (_wid getVariable "_onSync");
			};
		};
	};

	["RscEdit",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_wid ctrlSetTooltip "Введите число с обязательным постфиксом:\n\n г - для граммов\n кг - для килограммов\n\nДопустимый диапазон от 0 грамм до 1000 килограмм";
	_wid setVariable ["_input",_wid]; //for work event on killfocus
	_event call _setOnKillFocusCode;//!DOSEN'T WORK NOW
	_input = _wid;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,false] call oop_getFieldBaseValue;
		
		if (_memberName in _props) then {
			_keyName = (_props get _memberName);
			_wid ctrlSetText ([_keyName] call goasm_attributes_handleProvider_weight_eval);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_keyName = _defval;
			_wid ctrlSetText ([_keyName] call goasm_attributes_handleProvider_weight_eval);
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
	} call _setSyncValCode;
	[BUTTON,[10,_optimalSizeH],_offsetMemX + 40,true] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - Применить значение\nПКМ - Сброс на стандарт";
	_wid setVariable ["_input",_input];
	
	_event call _setOnPressCode;
}

function(goasm_attributes_handleProvider_model)
{
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_input = _wid;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		if (_memberName in _props) then {
			_wid ctrlSetText (_props get _memberName);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_wid ctrlSetText _defval;
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
	} call _setSyncValCode;
	[BUTTON,[10,_optimalSizeH],_offsetMemX + 40,true] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - контекст меню\nПКМ - сброс на стандартное значение";
	_wid setVariable ["_input",_input];
	{
		//Нельзя менять модель в открытом селекторе
		//Пока можно. Например в контейнерах
		//if (call golib_isOpenedArraySelector && _objWorld call golib_isVirtualObject) exitWith {
		//	["Невозможно изменить модель у виртуального объекта"] call showWarning;
		//};

		_props = _data get "customProps";
		
		if (_key == MOUSE_LEFT) then {
			__openModelViewer = {
				[{
					{
						if (_modelType == "dynamic") then {
							_cfg = core_model2cfg getVariable _value;
							if equalTypes(_cfg,[]) then {
								[_cfg,{
									{
										if !(_text call config_isEditorVisible) exitWith {
											["Конфиг '"+_text+"' не может быть создан в редакторе из-за ограничений доступа конфигурации",10] call showWarning;
										};
										
										_props set [_memberName,_text];
										[_memberName,"cprov"] call goilb_setBatchMode;
										[_objWorld,_data,true,golib_history_skippedHistoryStageFlag+"!!! СВОЙСТВА ПЕРЕД ЗАМЕНОЙ"] call golib_setHashData;
										[inspector_allSelectedObjects,_text] call golib_om_replaceObject;
									} call Core_callContext;
								},null,null,null,
								"Выберите подходящий конфиг"] call control_createList;
							} else {
								// проверка доступа
								if !(_cfg call config_isEditorVisible) exitWith {
									["Конфиг '"+_cfg+"' не может быть создан в редакторе из-за ограничений доступа конфигурации",10] call showWarning;
								};
								
								_props set [_memberName,_cfg];
								[_memberName,"cprov"] call goilb_setBatchMode;
								[_objWorld,_data,true,golib_history_skippedHistoryStageFlag+"!!! СВОЙСТВА ПЕРЕД ЗАМЕНОЙ"] call golib_setHashData;
								if !isNullReference(_wid) then {
									_wid = _wid getVariable "_input";
									call (_wid getVariable "_onSync");
								};
								[inspector_allSelectedObjects,_cfg] call golib_om_replaceObject;
							};
						} else {
							
							_props set [_memberName,_value];
							[_memberName,"cprov"] call goilb_setBatchMode;
							[_objWorld,_data,true,golib_history_skippedHistoryStageFlag+"!!! СВОЙСТВА ПЕРЕД ЗАМЕНОЙ"] call golib_setHashData;
							if !isNullReference(_wid) then {
								_wid = _wid getVariable "_input";
								call (_wid getVariable "_onSync");
							};
							[inspector_allSelectedObjects,_value] call golib_om_replaceObject;
						};
						
					} call Core_callContext;
					
					call Core_popContext;
				},{
					call Core_popContext;
				}] call golib_openModelViewer;
			};
			
			call Core_pushContext; //сохраняем контекст
			[
				[
					["Выбор динамической модели",{
						["_modelType","dynamic"] call Core_addContext;
						nextFrame("__openModelViewer" call Core_getContextVar);
						},null,"Динамические модели имеют расширенные свойства:\n- Могут менять свои текстуры\n- Могут быть анимированы\n\nПример динамических объектов: двери, лужи крови и т.д."],
					["Выбор простой модели",{
						["_modelType","static"] call Core_addContext;
						nextFrame("__openModelViewer" call Core_getContextVar);
					},null,"Простые модели это тип моделей без специальных свойств.\nБольшинство моделей в реликте являются простыми."],
					"Отмена"
				]
			] call contextMenu_create;
		} else {
			if (_memberName in _props) then {
				_props deleteAt _memberName;
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true,golib_history_skippedHistoryStageFlag+"!!! СВОЙСТВА ПЕРЕД ЗАМЕНОЙ"] call golib_setHashData;
				
				_wid = _wid getVariable "_input";
				call (_wid getVariable "_onSync");
				
				//_defmodel = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
				_allObj = inspector_allSelectedObjects;
				_defmodel = _allObj apply {
					([[_x] call golib_getClassName,_memberName,true] call oop_getFieldBaseValue)
				};
				[_allObj,_defmodel] call golib_om_replaceObject;
			};
		};
		
	} call _setOnPressCode;
}


function(goasm_attributes_handleProvider_allowedSlots)
{
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_input = _wid;
	{
		_defState = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		_props = _data get "customProps";
		_applyArr = {
			_str = [];
			{
				_str pushBack (INV_LIST_SLOTNAMES select (INV_LIST_ALL find _x));
			} foreach _this;
			if (count _str == 0) exitWith {"-нет-"};
			_str joinString ";"
		};
		_applyToolTip = {
			_str = [];
			{
				_str pushBack (toString[13,13]+" - " + (INV_LIST_VARNAME select (INV_LIST_ALL find _x)) + format[" (%1)",INV_LIST_SLOTNAMES select (INV_LIST_ALL find _x)]);
			} foreach _this;
			if (count _str == 0) exitWith {"Отсутствуют слоты для назначения"};
			"Может быть назначен в следующие типы слотов:\n"+(_str joinString "\n")
		};
		if (_memberName in _props) then {
			_wid ctrlSetText ((_props get _memberName)call _applyArr);
			_wid ctrlSetTooltip ((_props get _memberName)call _applyToolTip);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];			
		} else {
			_wid ctrlSetText (_defState call _applyArr);
			_wid ctrlSetTooltip (_defState call _applyToolTip);
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
	} call _setSyncValCode;
	
	[BUTTON,[10,_optimalSizeH],_offsetMemX+40,true] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - открывает окно выбора слотов\nПКМ - сбрасывает на стандартные";
	_wid setVariable ["_input",_input];
	{
		_input = _wid getVariable "_input";
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		if (_key == MOUSE_RIGHT) exitWith {
			_wid = _input;
			_data get "customProps" deleteAt _memberName;
			[_memberName,"cprov"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
		};
		
		call Core_pushContext;
		_m = [];
		{
			if (_x in INV_LIST_HANDS) then {continue};
			_m pushBack [(INV_LIST_VARNAME select _forEachIndex),INV_LIST_SLOTNAMES select _forEachIndex,_x];
		} foreach INV_LIST_ALL;
		
		[_m,
			{
				params ["_varname","_slotname","_enumType"];
				
				["_d",_d] call Core_addContext;
				
				_props = "_props" call Core_getContextVar;
				
				_txt = [_d,TEXT,[0,10*_i,100,9.5],_ctg] call createWidget;
				_txt setBackgroundColor [0.5,.5,.5,0.2];
				_txt ctrlEnable false;
				[_txt,format["<t align='center'>%1 (%2)</t>",_slotname,_varname]] call widgetSetText;
				
				_cb = [_d,"RscCheckBox",[0,10 * _i,10,10],_ctg] call createWidget;
				_cb setVariable ["_enumType",_enumType];
				_d setVariable ["enum_checkbox_"+str _enumType,_cb];
				if (_memberName in _props) then {
					_cb cbSetChecked (_enumType in (_props getOrDefault [_memberName,[]]));
				} else {
					_cb cbSetChecked (_enumType in ("_defval" call Core_getContextVar));
				};
				
			}//element create end
			,
			{//handler save
				{
					//prepare list allowed slots
					_listSlots = [];
					{
						if (_x in INV_LIST_HANDS) then {continue};
						_cb = _d getVariable ["enum_checkbox_"+str _x,widgetNull];
						if !isNullReference(_cb) then {
							if (cbChecked _cb) then {
								_listSlots pushBack _x;
							};
						};
					} foreach INV_LIST_ALL;
					
					_isSet = not_equals(_defval,_listSlots);
					
					_wid = _input;
					if (_isSet) then {
						_data get "customProps" set [_memberName,_listSlots];
					} else {
						(_data get "customProps") deleteAt _memberName;
					};
					[_memberName,"cprov"] call goilb_setBatchMode;
					[_objWorld,_data,true] call golib_setHashData;
					call (_wid getVariable "_onSync");
					
					nextFrame(displayClose);
				} call Core_callContext;

				_objWorld = "_objWorld" call Core_getContextVar;

				call Core_popContext;

				if !(_objWorld call golib_isVirtualObject) then {
					"allowedSlots" call Core_context_validate;
				};
			}//handler save end
			,
			"Выберите слоты, в которые можно будет поместить предмет",
			null,
			null,
			// event on close
			{
				_objWorld = "_objWorld" call Core_getContextVar;
				nextFrame(displayClose);
				call Core_popContext;

				if !(_objWorld call golib_isVirtualObject) then {
					"allowedSlots" call Core_context_validate;
				};
			}
		] call golib_openArraySelector;
	} call _setOnPressCode;
}

/*
	Элемент контейнера containerContent:
	[
		classname - тип
		prob - вероятность спавна. она выбрасывается для каждого 
		count - amount of items. if stack then called initStackCount
		varlist - initial variables list
		funclist - initial functions calling
	]
 */
function(goasm_attributes_handleProvider_container_content)
{
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_input = _wid;
	{
		if ("containerContent" in _data) then {
			private _content = ([_data get "containerContent",false] call goasm_attributes_container_content_ToString);
			if (count inspector_otherObjects > 0) then {
				_content = "Несколько значений...";
			};

			_wid ctrlSetText _content;
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
			_wid ctrlSetTooltip _content;
		} else {
			_content = ["Пусто","Там ничего нет"];
			if (count inspector_otherObjects > 0) then {
				_content = _content apply {"Несколько значений..."};
			};
			_wid ctrlSetText (_content select 0);
			_wid ctrlSetBackgroundColor [0.3,0.3,0.3,0.3];
			_wid ctrlSetTooltip (_content select 1);
		};
	} call _setSyncValCode;
	[BUTTON,[10,_optimalSizeH],_offsetMemX+40,true] call _createElement;
	_wid setvariable ["_input",_input];
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - открывает окно настройки контейнера\nПКМ - сбрасывает на стандартные";
	{
		if (_objWorld call golib_isVirtualObject) exitwith {
			["К сожалению вы не можете поместить предметы в виртуальный контейнер из-за ограничений игровой логики. Рекомендуется создать данный тип в мире и расположить предметы внутри него",20] call showWarning;
		};
		_input = _wid getvariable "_input";

		//сброс
		if (_key == MOUSE_RIGHT) exitwith {
			_wid = _input;
			//if ("containerContent" in _data) then {
				_data deleteAt "containerContent";
				["containerContent","del"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				call (_wid getVariable "_onSync");
			//};
		};

		if (count inspector_otherObjects > 0) exitWith {
			["В текущей версии нельзя изменять содержимое контейнеров для нескольких объектов."] call showError;
		};

		_srcObject = _objWorld;
		_dummyObj = createSimpleObject ["block_dirt",[0,0,0]];
		_dummyObj setVariable ["observedIndex",-1];
		_dummyObj setVariable ["observedData",""];
		_refContent = _data getOrDefault ["containerContent",[]];
		_dummyObj setVariable ["observedContent",_refContent];
		___syncHeaderText = {
			private _textHeaderAS = (call golib_getArraySelectorCtg) getvariable "_textHeaderAS";
			private _size = ["_refContent" call Core_getContextVar] call golib_attributes_container_content_getCurrentSize;
			private _objWorld = "_objWorld" call Core_getContextVar;
			private _data = [_objWorld,false] call golib_getHashData; //"_data" call Core_getContextVar;
			private _props = _data get "customProps";

			//permaupdate data and _props
			["_data",_data] call Core_addContext;
			["_props",_props] call Core_addContext;

			private _countSlots = if ("countslots" in _props) then {
				_props get "countslots"
			} else {
				[_data get "class","countslots"] call oop_getFieldBaseValue
			};

			_bt = _textHeaderAS getvariable "basicText";
			[_textHeaderAS,format["%1 === Заполнен на %2 из %3 ===",sanitizeHTML(_bt),_size,_countSlots]] call widgetSetText;
		};
		call Core_pushContext;

		[
			_refContent,
			{ //element create
				_this params ["_curItem","_curCount"];

				if (_isLastItem) then {
					call ("___syncHeaderText" call Core_getContextVar);
				};

				_curItem = (_curItem call golib_deserializeHashData);
				
				//изменить свойства, количество, вероятность, удалить,
				_backName = [_d,BACKGROUND,[0,10*_i,50,9.5],_ctg] call createWidget;
				_backName setBackgroundColor [0.7,0.7,0.7,0.5];
				_txt = [_d,TEXT,[0,10*_i,50,9.5],_ctg] call createWidget;
				[_txt,format["%1",_curItem get "class"]] call widgetSetText;
				_txt ctrlSetTooltip "Нажмите на элемент, чтобы отредактировать его свойства в инспекторе";
				_txt setVariable ["_index",_i];
				_txt ctrlAddEventHandler ["MouseButtonUp",{
					params ["_but"];
					_idx = _but getVariable "_index";
					_refContent = "_refContent" call Core_getContextVar;
					_curItem = (_refContent select _idx) select 0;

					//подгрузчик модели с обновлением контекста
					//TODO если свойство изменено то подргужаем другую модель (измененную)
					_hashData = (_curItem call golib_deserializeHashData);
					_m = [_hashData get "class","model",true] call oop_getFieldBaseValue;
					if (isNullVar(_m) || {equals(_m,"")}) exitwith {
						["Model for class %1 not found (provider container_content)",_hashData get "class"] call printError;
					};
					//rem old object
					_dummyObj = "_dummyObj" call Core_getContextVar;
					deleteVehicle _dummyObj;
					//create new object
					_dummyObj = createSimpleObject [_m,[0,0,0]];
					["_dummyObj",_dummyObj] call Core_addContext;
					_dummyObj setVariable ["observedIndex",_idx];
					_dummyObj setVariable ["observedContent",_refContent];
					_dummyObj setVariable ["observedData",_curItem];
					
					[[_dummyObj]] call inspector_menuLoad;
				}];

				//количество
				_input = [_d,INPUT,[50,10*_i,15,9.5],_ctg] call createWidget;
				_input ctrlSetTooltip "Количество предметов в контейнере";
				_input setVariable ["_index",_i];
				_input ctrlSetText str _curCount;
				_input ctrlAddEventHandler ["KeyUp",{
					params ["_but"];
					_number = floor parseNumber ctrlText _but;
					_idx = _but getVariable "_index";
					_refContent = "_refContent" call Core_getContextVar;
					_number = clamp(_number,1,1000);
					
					//хэш этого предмета, хэш для проверки, содержимое контейнера, количество предметов
					_copyRefContentWithoutItem = array_copy(_refContent);
					_copyRefContentWithoutItem deleteAt _idx;
					
					if !([
						"_data" call Core_getContextVar,
						_refContent select _idx select 0,
						_copyRefContentWithoutItem,
						_number
					] call golib_attributes_container_content_validateAdd) then {
						_number = 1;
						//["Ошибка добавления предметов в контейнер: не хватило слотов для указанного количества. Сброс на 1",10] call showWarning;
					};

					(_refContent select _idx) set [1,_number];
					_but ctrlSetText str _number;

					call ("___syncHeaderText" call Core_getContextVar);

					//nextFrame(golib_eventReloadArraySelector);
				}];

				_delete = [_d,BUTTON,[90,10*_i,10,9.5],_ctg] call createWidget;
				_delete ctrlSetText "X";
				_delete setBackgroundColor [1,0,0,0.5];
				_delete ctrlSetTooltip "Удалить элемент из контейнера";
				_delete setvariable ["_index",_i];
				_delete ctrlAddEventHandler ["MouseButtonUp",{
					params ["_but"];
					_idx = _but getvariable ["_index",-1];
					if (_idx == -1) exitWith {
						["Cannot find index to delete item"] call printError;
					};	
					_refContent = "_refContent" call Core_getContextVar;
					_refContent deleteAt _idx;

					//если предпросмотрщик стоит на dummy obj тогда переназначаем
					_dummyObj = "_dummyObj" call Core_getContextVar;
					_dummyObj setvariable ["observedIndex",-1];
					_srcObject = "_srcObject" call Core_getContextVar;
					[_srcObject,true] call golib_setSelectedObjects;

					if (count _refContent == 0) then {
						call ("___syncHeaderText" call Core_getContextVar);
					};

					//в следующем кадре из-за того что вызов в контексте события UI
					nextFrame(golib_eventReloadArraySelector);
				}];

			}, //element create end
			{ //handler save
				_refContent = "_refContent" call Core_getContextVar;
				_srcObject = "_srcObject" call Core_getContextVar;
				_dummyObj = "_dummyObj" call Core_getContextVar;
				
				deleteVehicle _dummyObj;

				{
					if ("containerContent" in _data) then {
						private _errorContainer = false;
						
						{
							_x params ["_serializedHash","_countItems"];
							//validate
							if !([_data,_serializedHash,_refContent,_countItems,false] call golib_attributes_container_content_validateAdd) exitwith {
								// validate failed
								_errorContainer = true;
								_refContent set [_foreachIndex,objnull];
							};
						} foreach (+_refContent);
						
						if (_errorContainer) then {
							_refContent = _refContent - [objnull];
							["Найдены ошибки логики в контейнере. Место было высвобождено"] call showWarning;
							_data deleteAt "containerContent";
						};
					};

					//! тут не всегда вызывается событие: из-за переключения инспектора старые виджеты удаляются и не хранятся в памяти
					//! ["%1 %2 %3",_wid,_input,_wid getvariable "_onSync",_input getvariable "_onSync"] call printWarning;
					_wid = _input;
					if (count _refContent > 0) then {
						_data set ["containerContent",_refContent];
					} else {
						_data deleteAt "containerContent";
					};
					[_memberName] call goilb_setBatchMode;
					[_srcObject,_data,true] call golib_setHashData;
					call (_wid getVariable "_onSync");

					call golib_cs_syncMarks; //sync marks because globalrefs can be inside container
				} call Core_callContext;

				[_srcObject,true] call golib_setSelectedObjects;
				
				call Core_popContext;

				//! Зачем это делается? Смотри событие EVENT ON CLOSE ниже...
				if !(_srcObject call golib_isVirtualObject) then {
					"container_content" call Core_context_validate;
				};
			}, //handler save end
			"Содержимое контейнера (перетащите из библиотеки для добавления)",
			"Сохранить",
			getEdenDisplay,
			// --------------- EVENT ON CLOSE ----------------------
			{
				_srcObject = "_srcObject" call Core_getContextVar;
				_dummyObj = "_dummyObj" call Core_getContextVar;
				if isNullVar(_dummyObj) exitWith {
					["Dummy object not found"] call printError;
				};
				if isNullVar(_srcObject) exitwith {
					["Cant get null var for object"] call printError;
				};
				if isNullReference(_dummyObj) then {
					["%1 - Undefined behaviour: dummy object is nullref",__FUNC__] call printError;
				};
				if isNullReference(_srcObject) exitwith {
					["Cannot get reference to null object"] call printError;
				};
				[_srcObject,true] call golib_setSelectedObjects;
				
				deleteVehicle _dummyObj;

				call Core_popContext;

				//мы можем открыть контейнер в контейнере и для проверки контекстов начальный объект не должен быть виртуальным
				if !(_srcObject call golib_isVirtualObject) then {
					"container_content" call Core_context_validate;
				};
			},
			// --------------- EVENT ON DRAG ----------------------
			{
				params ["_class"];
				//Обновление нужно для синхронизации _data
				call ("___syncHeaderText" call Core_getContextVar);

				["try drop class:" + _class + " is item:" + str isTypeNameOf(_class,Item)] call printTrace;
				if !isTypeNameOf(_class,Item) exitWith {
					["Type '"+_class+"' cannot be added to container (not a item)"] call showWarning;
				};
				//todo check - can emplace item in container
				_data = "_data" call Core_getContextVar;
				_refContent = "_refContent" call Core_getContextVar; //получаем по ссылке данные
				_serializedHash = [[objNull,_class,false] call golib_initHashData] call golib_serializeHashData;
				//validate
				if !([_data,_serializedHash,_refContent] call golib_attributes_container_content_validateAdd) exitwith {
					// validate failed
				};

				

				_refContent pushBack [
					_serializedHash,
					1
				]; //добавляем в массив элемент
				
				call golib_eventReloadArraySelector;
			},
			true
		] call golib_openArraySelector;

		//after loaded array selector call ___syncHeaderText
		call ___syncHeaderText;


	} call _setOnPressCode;
}

function(goasm_attributes_container_content_ToString)
{
	params ["_data",["_isTooltip",false]];
	private _delimeter = ifcheck(_isTooltip,"\n",";");
	private _list = ["Содержимое:"];
	{
		_x params ["_hash","_count"];
		_map = (_hash) call golib_deserializeHashData;
		_list pushback format["	- %1 - %2,",_map get "class",_count];

	} foreach _data;

	_list joinString _delimeter;
}

//Количественные и размерные валидаторы
function(golib_attributes_container_content_validateAdd)
{
	//хэш этого предмета, хэш для проверки(serialized), содержимое контейнера, количество предметов
	params ["_curHash","_hashEmplace","_curContainerContent",["_probItemCount",1],["_throwError",true]];
	//["cur hash %2%1emplace hash %3%1content %4%1",endl,_curhash,_hashEmplace,_curContainerContent] call printTrace;
	/*
		if (_size > getSelf(maxSize)) exitWith {false};
		if (getSelf(currentsize) + BASE_STORAGE_COST(_size) > getSelf(countSlots)) exitWith {false};
	*/
	private _curClass = _curhash get "class";
	private _curData = _curhash get "customProps";

	private _itmHash = _hashEmplace call golib_deserializeHashData;
	private _itmClass = _itmHash get "class";
	private _itmData = _itmHash get "customProps";

	// private _maxSize = if ("maxsize" in _curData) then {
	// 	_curData get "maxsize"
	// } else {
	// 	[_curClass,"maxSize",true] call oop_getFieldBaseValue
	// };
	// private _itmSize = if ("size" in _itmData) then {
	// 	_itmData get "size"
	// } else {
	// 	[_itmClass,"size",true] call oop_getFieldBaseValue
	// };

	private _maxSize = [_curhash,"maxSize"] call golib_getHashDataActualValue;
	private _itmSize = [_itmHash,"size"] call golib_getHashDataActualValue;

	if (_itmSize > _maxSize) exitwith {
		if (_throwError) then {
			[
				format[
					"Ошибка добавления в контейнер: превышен максимальный размер объекта на %3 уровня; Предмет '%1', макс. '%2'",
					ITEM_SIZE_LIST_NAME_ALL select ((_itmSize-1) max 0),
					ITEM_SIZE_LIST_NAME_ALL select ((_maxSize-1) max 0),
					_itmSize - _maxSize
				],
				10
			] call showWarning;
		};
		false
	};

	// cur size + BASE_STORAGE_COST(_itmSize) > count slots
	// 1. Get Cur size
	private _curSize = [_curContainerContent] call golib_attributes_container_content_getCurrentSize;
	// 2. get count slots
	private _countSlots = if ("countslots" in _curData) then {
		_curData get "countslots"
	} else {
		//! ТУТ нельзя ставить true для компиляции результата. Я не помню почему числовые поля сразу возвращаются...
		[_curClass,"countslots",true] call oop_getFieldBaseValue
	};

	//now start check
	if (_curSize + (BASE_STORAGE_COST(_itmSize) * _probItemCount) > _countSlots) exitwith {
		if (_throwError) then {
			[
				format[
					"Ошибка доавления в контейнер: не хватает места для указанного предмета; Превышение лимита на %1 ед.",
					(_curSize + (BASE_STORAGE_COST(_itmSize) * _probItemCount)) - _countSlots
				],
				10
			] call showWarning;
		};
		false
	};

	true
}

function(golib_attributes_container_content_getCurrentSize)
{
	params ["_containerContent"];
	private _curSize = 0;
	private _itSize = 0;
	private _cusprop = "";
	{
		_x params ["_hash","_amount"];
		_hash = _hash call golib_deserializeHashData;
		_cusprop = _hash get "customProps";
		_itSize = if ("size" in _cusprop) then {
			_cusprop get "size"
		} else {
			[_hash get "class","size",true] call oop_getFieldBaseValue
		};
		modvar(_curSize) + (BASE_STORAGE_COST(_itSize) * _amount);
	} foreach _containerContent;
	_curSize
}

function(goasm_attributes_handleProvider_edConnected)
{
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_input = _wid;
	{
		if ("edConnected" in _data) then {
			_wid ctrlSetText ([_data get "edConnected",false] call goasm_attributes_handlerProv_internal_getText);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
			//_wid ctrlSetTooltip ([_data get "edConnected",true] call goasm_attributes_handlerProv_internal_getText);
		} else {
			_wid ctrlSetText "Пусто";
			_wid ctrlSetBackgroundColor [0.3,0.3,0.3,0.3];
			//_wid ctrlSetTooltip "Нет подключений";
		};
	} call _setSyncValCode;
	_wid ctrlSetTooltip "ПКМ - открыть меню перемещения к подключенному объекту";
	{
		if (_key == MOUSE_RIGHT) exitwith {
			if (call golib_isOpenedArraySelector) exitWith {
				["Данное действие невозможно при открытом селекторе"] call showWarning;
			};

			_build = [["Отмена",{}]];
			//_edc = _data get "edConnected";
			_edc = [];
			{
				private _hd = [_x,false] call golib_getHashData;
				if ("edConnected" in _hd) then {
					{
						_edc pushBackUnique _x;
					} foreach (_hd get "edConnected");
				};
			} forEach inspector_allSelectedObjects;

			{
				_build pushBack [
					"Перейти к " + str _x,
					{
						_idx = _indexContext - 1;
						_edc = (call contextMenu_getContextParams) select 0;
						_markSearch = _edc select _idx;
						["Searching object %1",_markSearch] call printTrace;
						_o = _markSearch call golib_cs_getObjectByMark;
						nextFrameParams({[_this] call golib_vis_jumpToObjects},_o);
					}
				]
			} foreach (_edc);

			[
				
				_build
				,
				call mouseGetPosition,
				[_edc]
			] call contextMenu_create;
		};
	} call _setOnPressCode;

	[BUTTON,[10,_optimalSizeH],_offsetMemX+40,true] call _createElement;
	_wid setvariable ["_input",_input];
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - открывает окно настройки подключений\nПКМ - сбрасывает на стандартные";
	{
		if (call golib_isOpenedArraySelector) exitWith {
			["Данное действие невозможно при открытом селекторе"] call showWarning;
		};

		_input = _wid getVariable "_input";
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;

		
		if (_key == MOUSE_RIGHT) exitwith {
			_wid = _input;
			_data deleteAt "edConnected";
			["edConnected","del"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			call (_wid getVariable "_onSync");
			nextFrame(golib_cs_syncMarks);
		};

		if (count inspector_allSelectedObjects > 1) exitWith {
			["Изменение подключения для множества объектов не поддерживается"] call showError;
		};

		call Core_pushContext;
		
		[[false] + (golib_internal_map_marks toArray false),
			{
				params ["_ref","_objPtr"];
				
				["_d",_d] call Core_addContext;
				private _data = "_data" call Core_getContextVar;
				private _objWorld = "_objWorld" call Core_getContextVar;
				
				if equals(false,_ref) exitwith {
					_sizeHeader = 10;
					_input = [_d,INPUT,[20,2,80,_sizeHeader-4],_ctg] call createWidget;
					_input ctrlSetText (_d getvariable ["prov_binding_input_edConnection",""]);
					_bFilter = [_d,BUTTON,[0,2,20,_sizeHeader-4],_ctg] call createWidget;
					_bFilter ctrlSetText "Применить фильтр";
					_bFilter ctrlSetTooltip "ЛКМ - применить фильтр\nПКМ - очистить фильтр";
					_bFilter setvariable ["_input",_input];
					_bFilter setvariable ["_disp",_d];
					_bFilter ctrlAddEventHandler ["MouseButtonUp",{
						params ["_w","_key"];
						_d = _w getvariable "_disp";
						if (_key == MOUSE_RIGHT) exitWith {
							_d setvariable ["prov_binding_input_edConnection",""];
							nextFrame(golib_eventReloadArraySelector);
						};
						_input = _w getvariable "_input";
						_text = ctrltext _input;
						_d setvariable ["prov_binding_input_edConnection",_text];
						nextFrame(golib_eventReloadArraySelector);
					}];

					_ctg = [_d,WIDGETGROUP_H,[0,_sizeHeader,100,100-_sizeHeader],_ctg] call createWidget;
					if isNull(_data get "edConnected") then {
						_data set ["edConnected",[]];
					};

					//находим все материнские указатели
					private _allMotherMarks = [];
					_mot = _objWorld;
					while {
						_mot = _mot call golib_en_obj_getMotherEnergyObject;
						
						if isNullReference(_mot) exitWith {false};

						if (_mot call golib_en_obj_isEnergyObject) then {
							_allMotherMarks pushback (_mot call golib_en_obj_getMark);
						};
						true
					} do {};

					_d setvariable ["prov_binding_allmarks_static",_allMotherMarks];
				};
				_searcher = _d getvariable ["prov_binding_input_edConnection",""];
			
				private _hd = [_objPtr,false] call golib_getHashData;
				if (count _hd == 0) exitwith {
					["Требуется перегрузка данного окна. Закройте и повторите снова"]call showWarning;
				};


				if equals(_data getOrDefault vec2("mark","______$$$$NODATA$$$$_____"),_ref) exitwith {};
				_thisMark = _data get "mark";
				if isNullVar(_thisMark) exitwith {
					["На целевом объекте не указана глобальная ссылка"] call showWarning;
				};

				//если по циклической системе существуют ссылки равные _ref то выходим
				_allMotherMarks = _d getvariable "prov_binding_allmarks_static";
				if (_ref in _allMotherMarks) exitWith {};

				_findErr = false;
				{
					if (
						/*equals(_x,_ref) || */
						//_ref in _y 
						//|| (_thisMark in _y && _ref == _x)

						//мы не показываем ссылку если:
							//если ссылка зайдействована где-то и это не целевой объект
							(_ref in _y && _thisMark != _x) //||
							//...
							//(_thisMark in _y && _thisMark != _ref || false)
					) exitWith {_findErr = true};
				} foreach golib_internal_map_connected;
				if (_findErr) exitWith {};

				if ([_hd get "class","edOwner","EditorVisible"] call goasm_attributes_hasAttributeField) then {
					if (_searcher == "" || (tolower _searcher) in (tolower _ref)) then {
						_txt = [_d,TEXT,[0,10*_globIncrement,100,9.5],_ctg] call createWidget;
						_txt setBackgroundColor [0.5,.5,.5,0.2];
						_txt ctrlEnable false;
						[_txt,format["<t align='center'>%1 (%2)</t>",_ref,_objPtr]] call widgetSetText;

						_connected = _data getOrDefault ["edConnected",[]];

						_cb = [_d,"RscCheckBox",[0,10 * _globIncrement,10,10],_ctg] call createWidget;
						// _cb setVariable ["_enumType",_enumType];
						// _d setVariable ["enum_checkbox_"+str _enumType,_cb];
						if ("edConnected" in _data) then {
							_cb cbSetChecked (_ref in (_connected));
						} else {
							// это условие никогда не выпадет
							_cb cbSetChecked false;
						};

						_cb setvariable ["_data",_data get "edConnected"];
						_cb setvariable ["_ref",_ref];
						_cb ctrlAddEventHandler ["CheckedChanged",{
							params ["_wid","_checked"];
							_checked = _checked > 0;
							private _data = _wid getvariable "_data";
							private _ref = _wid getvariable "_ref";
							if (_checked) then {
								_data pushBackUnique _ref;
							} else {
								_data deleteAt (_data find _ref);
							};
						}];

						_bToObj = [_d,"RscButton",[80,10 * _globIncrement,20,10],_ctg] call createWidget;
						_bToObj ctrlSetText "К объекту";
						_bToObj ctrlSetTooltip "Нажмите, чтобы закрыть окно и переместиться к этому объекту";
						_bToObj setBackgroundColor [0,.3,0,1];
						_bToObj setvariable ["_mark",_ref];
						_bToObj ctrlAddEventHandler ["MouseButtonUp",{
							params ["_w","_key"];
							_mark = _w getvariable "_mark";
							_o = _mark call golib_cs_getObjectByMark;
							_ctgStorage = call golib_getArraySelectorCtg;
							_buttonClose = _ctgStorage getvariable "_buttonClose";
							nextFrame(displayClose);
							nextFrame(_buttonClose getvariable vec2("_customEventClose",{}));
							nextFrameParams({[_this] call golib_vis_jumpToObjects},_o);
						}];

						INC(_globIncrement);
					};
				};

				//_props = "_props" call Core_getContextVar;
				//["%1 is props",_props] call printError;
			}//element create end
			,
			{//handler save
				{					
					_isSet = not_equals(_data get "edConnected",[]);
					
					_wid = _input;
					if (_isSet) then {
						//_data get "customProps" set [_memberName,_listSlots];
						//TODO validate marks (not need now)
					} else {
						(_data deleteAt "edConnected")
					};
					["edConnected"] call goilb_setBatchMode;
					[_objWorld,_data,true] call golib_setHashData;
					call (_wid getVariable "_onSync");
					
					nextFrame(displayClose);

					_objWorld = "_objWorld" call Core_getContextVar;

					call Core_popContext;

					if !(_objWorld call golib_isVirtualObject) then {
						"edConnected" call Core_context_validate;
					};

				} call Core_callContext;

				_objWorld = "_objWorld" call Core_getContextVar;

				call Core_popContext;

				if !(_objWorld call golib_isVirtualObject) then {
					"edConnected" call Core_context_validate;
				};

				nextFrame(golib_cs_syncMarks);
			}//handler save end
			,
			"Выберите какие узлы будут подключены к этому объекту",
			null,
			null,
			// event on close
			{
				_objWorld = "_objWorld" call Core_getContextVar;
				nextFrame(displayClose);
				call Core_popContext;

				if !(_objWorld call golib_isVirtualObject) then {
					"edConnected" call Core_context_validate;
				};
			}
		] call golib_openArraySelector;
	} call _setOnPressCode;
}

function(goasm_attributes_handlerProv_internal_getText)
{
	params ["_markList",["_isTooltip",false]];
	private _delim = ifcheck(_isTooltip,"\n",";");
	private _out = if (_isTooltip) then {"Подключено:"} else {""};
	{
		_o = _x call golib_cs_getObjectByMark;
		_hd = [_o,false] call golib_getHashData;
		if (count _hd == 0) exitwith {
			["Null mark founded. Reload marks"] call printWarning;
			nextFrame(golib_cs_syncMarks);
		};
		if (!_isTooltip) then {
			_out = _out + _delim + _x;
		} else {
			_numen = 0;
			_out = _out + _delim + format["""%1"" (%2) > %3",_x,_hd get "class",
				[_o,"edReqPower"] call golib_getActualDataValue
			];
		};
	} foreach _markList;

	_out
}

function(goasm_attributes_handleProvider_edOwner)
{
	if (count inspector_allSelectedObjects > 1) exitWith {
		[TEXT,[50,_optimalSizeH],_offsetMemX,true] call _createElement;
		[_wid,"<t align='center' size='0.7'>Несколько значений</t>"] call widgetSetText;
	};

	["RscButton",[50,_optimalSizeH],_offsetMemX,true] call _createElement;
	_wid ctrlSetText "К источнику";
	_wid ctrlSetTooltip "ЛКМ - перейти к источнику";
	{
		_m = _data get "mark";
		if isNullVar(_m) exitWith {
			["Целевой объект не имеет глобальной ссылки"] call showWarning;
		};
		_finded = false;
		if (call golib_isOpenedArraySelector) exitWith {
			["Данное действие невозможно при открытом селекторе"] call showWarning;
		};
		{
			if (_m in _y) exitWith {
				_o = _x call golib_cs_getObjectByMark;
				if isNullReference(_o) exitWith {
					["Generic error on get object by mark: object %1 not found",_x] call printError;
				};
				nextFrameParams({[_this] call golib_setSelectedObjects; call golib_vis_jumpToSelected},_o);
				_finded = true;
			};
		} foreach golib_internal_map_connected;
		if (!_finded) then {
			["Источник отсутствует"] call showWarning;
		};
	} call _setOnPressCode;
}



function(goasm_attributes_handleProvider_effect_configs)
{
	//editor_attribute("EditorVisible" arg "custom_provider:effect_configs" arg "possible_values:dust_pieces_10m|dust_clouds_10m|govnelin")
	["RscEditReadOnly",[40,_optimalSizeH],_offsetMemX,false] call _createElement;
	_wid setVariable ["_memberName",_memberName];
	_input = _wid;
	{
		_props = _data get "customProps";
		_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
		
		if (_memberName in _props && {not_equals(_defval,_props get _memberName)}) then {
			_wid ctrlSetText (_props get _memberName);
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		} else {
			_wid ctrlSetText "Без эффекта";
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		};
	} call _setSyncValCode;
	[BUTTON,[10,_optimalSizeH],_offsetMemX + 40,true] call _createElement;
	_wid setVariable ["input",_input];
	_wid ctrlSetText "+";
	{
		_wid = _wid getVariable "input";

		private _listData = [];

		_aobj = ([_data get "class","field","EditorVisible",_memberName] call goasm_attributes_getValues);

		_listData = (([_aobj,"possible_values"] call goasm_attributes_getPropertyValue) select 0) splitString "|";


		_codeOnPressContext = {
			(call contextMenu_getContextParams) params ["_wid","_listData"];
			
			{
				_props = _data get "customProps";
				_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
				_val = _listData select _indexContext;
				_props set [_memberName,_val];
				if equals(_val,_defval) then {
					_props deleteAt _memberName;
				};
				[_memberName,"cprov"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				
				call (_wid getVariable "_onSync");	
			} call (_wid getVariable "_setContext");
		};
		_build = _listData apply {[_x,_codeOnPressContext]};
		
		[
			[
				["Выбрать",_build],
				["Сброс на дефолт.",{
					(call contextMenu_getContextParams) params ["_wid"];
					{
						_props = _data get "customProps";
						_defval = [_data get "class",_memberName,true] call oop_getFieldBaseValue;
						_val = _props getOrDefault [_memberName,_defval];
						if not_equals(_val,_defval) then {
							_props deleteAt _memberName;
							[_memberName,"cprov"] call goilb_setBatchMode;
							[_objWorld,_data,true] call golib_setHashData;
							call (_wid getVariable "_onSync");	
						};
					} call (_wid getVariable "_setContext");
				}],
				["Отмена",{}]
			],
			call mouseGetPosition,
			[_wid,_listData]
		] call contextMenu_create;
	} call _setOnPressCode;
}