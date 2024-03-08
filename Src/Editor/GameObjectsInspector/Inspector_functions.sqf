// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(inspector_init)
{
	private _handleSelectionChange = {
		params ["_list"];
		
		//нельзя выбирать персонажа (впрочем как и ставить...)
		//Нельзя также выбирать системный объект golib_com_object
		if (!cfg_debug_devMode && {
			_list findif {
				(_x isKindOf "Man" && (!cfg_debug_allowSelectUnits)) || 
				(equals(golib_com_object,_x) && !cfg_debug_allowSelectSystemObject)
			} != -1}
		) exitwith {
			[] call golib_setSelectedObjects;
		};

		if (count _list == 1) then {
			inspector_lastObject = _list select 0;
		} else {
			inspector_lastObject = objNUll;
		};
		
		{
			[_x] call golib_om_internal_handleTransformEvent;
		} foreach _list;
		
		call inspector_menuLoad;
	};
	["onSelectionChange",_handleSelectionChange] call Core_addEventHandler;
	[get3DENSelected "" select 0] call _handleSelectionChange;
	
	//! inspector_menuLoad need optimize
	//["onUndo",{call inspector_menuLoad}] call Core_addEventHandler;
	//["onRedo",{call inspector_menuLoad}] call Core_addEventHandler;

	["onFrame",inspector_internal_onFrame] call Core_addEventHandler;
	
	inspector_catData = [
		["Инспектор",{}]
		//,["<t size='0.9' color='#ff0000'>Слои</t>",{}]
	];
	
	call inspector_loadWidgets;
}


function(inspector_loadWidgets)
{
	_d = getEdenDisplay;
	_toggleLeft = _d displayctrl 1031;
 	_toggleLeft ctrlshow false;

	(_toggleLeft call widgetGetPosition) params ["_xtog","_ytog"];
	
	//left panel widget
	((_d displayCtrl 1019) call widgetGetPosition) params ["","","_panW","_panH"];
	
	if (cfg_gen_leftTabSize > 0) then {
		_panW = cfg_gen_leftTabSize;
	};

	_ctg = [_d,WIDGETGROUP,
	[_xtog,_ytog,_panW,_panH]
	] call createWidget;
	_ctg setVariable ["defaultPoses",[_xtog,_ytog,_panW]];
	_ctg setvariable ["__basicSizeX",_panW];
	["inspector_ctg_main_bind",_ctg] call widget_bind;

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.1,0.1,0.1,.8];
	
	_inspectorSize = 3;
	
	//create internal ctg
	_ctgExternal = _ctg;
	_ctg = [_d,WIDGETGROUPSCROLLS,[0,_inspectorSize,100,100-_inspectorSize],_ctg] call createWidget;
	["inspector_ctg_bind",_ctg] call widget_bind;	
	
	_sizeY = 0;
	//categoryes
	_catData = inspector_catData;
	_catSizeW = (100/(count _catData));
	_catSizeH = _inspectorSize;
	for "_i" from 0 to (count _catData) - 1 do {
		_b = [_d,TEXT,[_catSizeW * _i,_sizeY,_catSizeW,_catSizeH],_ctgExternal] call createWidget;
		_b setBackgroundColor [0.7,0.7,0.7,0.7];
		[_b,format["<t align='center'>%1</t>",_catData select _i select 0]] call widgetSetText;
		_b ctrlAddEventHandler ["MouseButtonUp",_catData select _i select 1];
	};
	modvar(_sizeY) + _catSizeH;
	
	// Тут уже непосредственно код инспектора
	// А точнее он рантаймится в inspector_menuLoad
	
	
	//post adding events
	["onToggleLeftPanelState",{
		params ["_hidden"];
		//Хардкод. выключение левого меню
		/*if (!_hidden) then {
			call nativePanels_onToggleLeft;
		};*/
		
		//["hidden %1",_hidden] call printTrace;
		if (!_hidden) then {
			[false] call inspector_onChangeLeftPanelState;
		};
	}] call Core_addEventHandler;
	
	//выключаем левое меню
	if !(call nativePanels_isHiddenLeft) then {
		call nativePanels_onToggleLeft;
	};
	
	[(call nativePanels_isHiddenLeft),true] call inspector_onChangeLeftPanelState;
	
	
}


function(inspector_onChangeLeftPanelState)
{
	params ["_showPanel",["_isInit",false]];

	_timeApplyPanel = ifcheck(_isInit,0,0.2);

	//Визуальная логика всегда должна быть установлена
	_wid = "inspector_ctg_main_bind" call widget_getBind;
	(_wid getVariable "defaultPoses") params ["_x","_y","_sizeX"];
	if (_showPanel) then {
		[_wid,[_x,_y],_timeApplyPanel] call widgetSetPositionOnly;
	} else {
		[_wid,[-_sizeX,_y],_timeApplyPanel] call widgetSetPositionOnly;
	};

	if (_showPanel == inspector_isexpanded) exitWith {};
	inspector_isexpanded = _showPanel;

	if (_showPanel) then {
		
	};
}

function(inspector_onPressButton)
{
	if (!inspector_isexpanded) then {
		if !(call nativePanels_isHiddenLeft) then {
			call nativePanels_onToggleLeft;
		};
	};

	[!inspector_isexpanded] call inspector_onChangeLeftPanelState;
}



function(inspector_menuLoad)
{
	params [["_objList",get3DENSelected "" select 0]];
	_isWorldContext = count _objList > 0 && {!((_objList select 0) call golib_isVirtualObject)};
	
	["Inspector load %1 (world context - %2)",tickTime,_isWorldContext] call printTrace;

	private _ctgInspectorMain = "inspector_ctg_bind" call widget_getBind;
	if isNullReference(_ctgInspectorMain) exitWith {};
	{ctrlDelete _x} foreach (allControls _ctgInspectorMain);
	
	//_objlist = get3DENSelected "" select 0;
	private _isOneNonDatedObject = count _objList == 1 && {!([_objList select 0] call golib_hasHashData)};
	if (count(_objlist)!=1 || _isOneNonDatedObject) exitWith {
		_txt = [getEdenDisplay,TEXT,WIDGET_FULLSIZE,_ctgInspectorMain] call createWidget;
		_txtDat = if (count _objList == 0) then {
			"Выберите объекты для просмотра в окне инспектора"
		} else {
			private _tInternal = format["<t align='center' size='2' color='#874141'>Выбрано %1 объектов:</t>",count _objList];
			private _max = count _objList;
			if (_max <= 15) then {
				{
					if ([_x] call golib_hasHashData) then {
						modvar(_tInternal) + sbr + format["%1 в %2;",[_x] call golib_getHashData get "class",(getPosATL _x) call core_vec3_toString];
					} else {
						modvar(_tInternal) + sbr + format["(без привязки) %1<t size='0.8'>"+slt+"%2"+sgt +"</t> в %3;" ,typeof _x,_x,(getPosATL _x) call core_vec3_toString];
					};
				} foreach _objList;
			} else {
				modvar(_tInternal) + sbr + format["%1 объектов выбрано" ,_max];
			};
			
			_tInternal
		};
		[_txt,_txtDat] call widgetSetText;
		private _sizeH = _txt call widgetGetTextHeight;
		[_txt,[0,0,100,_sizeH]] call widgetSetPosition;
		(0) breakout "inspector_menuLoad";
	};
	
	
	_d = getEdenDisplay;
	_sizeY_ctg_bias = 0.5;
	_sizeY = _sizeY_ctg_bias;  //начальный поз
		_internalY = 0;
		_optimalSizeH = 0;
		_wid = widgetNull; //внешняя ссылка для назначения свойств
		_controlGroup = widgetNull;
	_backgroundPrev = widgetNull;
	_ctgGroupType = WIDGETGROUP_H;
	//==========================================================================
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
			_createElement = {
				params ["_type","_sizes",["_directionX",0],["_addOfsY",true],["_yOfs",0]];
				private _wSize = (_sizes select 0); //TODO можно ограничить по-умоному если скролл появился
				private _pos = [_directionX,_internalY + _yOfs,_wSize,_sizes select 1];		
				
				_wid = [_d,_type,_pos,_controlGroup] call createWidget;
				_wid setVariable ["_refObj",_obj];
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
		_setSyncValCode = {
			private _code = _this;
			_wid setVariable ["_onSync",_code];
			call _code;
		};
		
		_setOnMouseDownCode = {
			_wid setVariable ["_onMouseDown",_this];
			_wid ctrlAddEventHandler ["MouseButtonDown",{
				call {
				params ["_wid","_key", "_xPressPos", "_yPressPos","_shift","_ctrl","_alt"];
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onMouseDown");
				call (_wid getVariable "_onSync");
				}
			}];
		};
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
		_setOnMovingCode = {
			_wid setVariable ["_onMoving",_this];
			_wid ctrlAddEventHandler ["MouseMoving",{
				call {
				params ["_wid","_x", "_y", "_mouseOver"];
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onMoving");
				call (_wid getVariable "_onSync");
				}
			}];
		};
		_setOnCBChanged = {
			_wid setVariable ["_onCheckChanged",_this];
			_wid ctrlAddEventHandler ["CheckedChanged",{
				call {
				params ["_wid","_checked"];
				_checked = _checked > 0;
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onCheckChanged");
				call (_wid getVariable "_onSync");
				}
			}];
		};
		_setOnKeyUpCode = {
			_wid setVariable ["_onKeyUp",_this];
			_wid ctrlAddEventHandler ["KeyUp",{
				call {
				params ["_wid","_key","_shift","_ctrl","_alt"];
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onKeyUp");
				call (_wid getVariable "_onSync");
				}
			}];
		};
		_setOnKillFocusCode = {
			_wid setVariable ["_onKillFocus",_this];
			_wid ctrlAddEventHandler ["KillFocus",{
				call {
				params ["_wid"];
				private _objWorld = _wid getVariable "_refWorldObj";
				private _data = [_objWorld] call golib_getHashData;
				private _memberName = _wid getVariable "_memberName";
				call (_wid getVariable "_onKillFocus");
				call (_wid getVariable "_onSync");
				}
			}];
		};
		_setSliderPosChangedCode = {
			_wid setVariable ["_onSliderPosChanged",_this];
			_wid ctrlAddEventHandler ["SliderPosChanged",{
				call {
					params ["_wid","_value"];
					private _objWorld = _wid getVariable "_refWorldObj";
					private _data = [_objWorld] call golib_getHashData;
					private _memberName = _wid getVariable "_memberName";
					call (_wid getVariable "_onSliderPosChanged");
					call (_wid getVariable "_onSync");
				}
			}];
		};
	//==========================================================================
	//==========================================================================
	//===================== ВОТ ТУТ У НАС ВИЗУАЛКА =============================
	//==========================================================================
	//==========================================================================
	
	//Читаем объект
	private _objWorld = _objlist select 0;
	private _data = [_objWorld] call golib_getHashData;
	private _type = _data get "class";
	private _obj = missionNamespace getVariable ["pt_"+_type,nullPtr];
	if isNullReference(_obj) exitWith {
		["%1 - null type %2",__FUNC__,_type] call printError;
	};
	private _isVirtualObject = _objWorld call golib_isVirtualObject;
	
	/*
		ссылка игрового объекта
			Глобальная переменая ТЭГ (строка)
			Слой | скрыть(кнопка)
	*/
	9 call _createCTGExt;
		
	//text
	[TEXT,[100,_optimalSizeH]] call _createElement;
	_classnameShow = _type;
	if ([_type,"Deprecated"] call goasm_attributes_hasAttributeClass) then {
		_classnameShow = format["<t color='#ff0000'>(УСТАРЕВШИЙ) %1</t>",_classnameShow];
	};
	_text = format["<t align='left'>Свойства объекта: %1</t>",_classnameShow];
	[_wid,_text] call widgetSetText;
	
	//mark
	[TEXT,[50,_optimalSizeH],0,false] call _createElement;
	[_wid,format["<t align='left'>Глобальая ссылка:</t>"]] call widgetSetText;
	[BUTTON,[10,_optimalSizeH],50,false] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - сохранить\nПКМ - очистить";
	_button = _wid;
	{
		
		private _deleteCode = {
			(_wid getVariable "input") ctrlSetText "";
			if ("mark" in _data) then {
				_data deleteAt "mark";
				[_objWorld,_data,true,"Удаление глобальной ссылки"] call golib_setHashData;
				call golib_cs_syncMarks;
			};
		};
		
		if (_key == MOUSE_LEFT) then {
			private _txt = ctrlText (_wid getVariable "input");
			//простая валидация
			if (_txt == "" || count (_txt splitString " ") == 0) exitWith _deleteCode;
			
			private _editReason = if ("mark" in _data) then {
				"Изменение глобальный ссылки"
			} else {
				"Добавление глобальный ссылки"
			};
			_data set ["mark",_txt];
			[_objWorld,_data,true,_editReason] call golib_setHashData;
			call golib_cs_syncMarks;
		} else _deleteCode;
		
		_wid = _wid getVariable "input";
		call (_wid getVariable "_onSync");
		
	} call _setOnPressCode;
	[INPUT,[40,_optimalSizeH],50 + 11,true] call _createElement;
	_wid ctrlSetTooltip "Введите любой текст по которому будет доступен данный объект";
	_button setVariable ["input",_wid];
	{
		_wid ctrlSetText (_data getOrDefault ["mark",""]);
		if (ctrlText _wid == "") then {
			_wid ctrlSetBackgroundColor [.3,.3,.3,.3];
		} else {
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
		};
	} call _setSyncValCode;
	
	//invisible
	[TEXT,[50,_optimalSizeH],0,false] call _createElement;
	{
		_layer = [_objWorld,true] call layer_getObjectLayer;
		if (_layer == "") then {_layer = slt+"нет"+sgt};
		[_wid,format["<t align='left'>Слой: %1</t>",_layer]] call widgetSetText;
	} call _setSyncValCode;
	
	[TEXT,[40,_optimalSizeH],50,false] call _createElement;
	[_wid,format["<t align='right'>Видимость:</t>"]] call widgetSetText;
	["RscCheckBox",[10,_optimalSizeH],90,true] call _createElement;
	_wid ctrlSetTooltip "Не реализовано в текущей версии...";
	{
		_wid cbSetChecked (!("invisible" in _data));
	} call _setSyncValCode;
	/*{
		private _m = "";
		if (_checked) then {
			_data deleteAt "invisible";
			_m = "Выключение видимости";
		} else {
			_data set ["invisible",true];
			_m = "Включение видимости";
		};
		
		[_objWorld,_data,true,_m] call golib_setHashData;
	} call _setOnCBChanged;*/
		
	/*
		трансформация
			позХ,позY,позZ
			ротX,ротY,ротZ
		создание
			вероятность появления (проценты)
			случайная позиция (число)
			случайный поворот (кнопка)
	*/
	ifcheck(_isVirtualObject,8,24) call _createCTGExt;

	if (!_isVirtualObject) then {

		_panList = [["X",[1,0,0,1]],["Y",[0,1,0,1]],["Z",[0,0,1,1]]];
		
		//==========================================================================
		// ПОЗИЦИЯ
		//==========================================================================
		region(pos)
			[TEXT,[100,_optimalSizeH]] call _createElement;
			[_wid,format["<t align='left' size='0.8'>Трансформация: позиция</t>"]] call widgetSetText;
			for "_i" from 0 to 2 do {
				[TEXT,[100/3/4,_optimalSizeH],100/3*_i,false] call _createElement;
				(_panList select _i)params ["_t","_col"];
				[_wid,format["<t align='center'>%1</t>",_t]] call widgetSetText;
				_wid setBackgroundColor _col;
				_wid setVariable ["transform_index",_i];
				_wid setVariable ["transform_name",_t];
				_drag = _wid;
				_wid ctrlSetTooltip format["Потяните вверх или вниз для изменения оси %1",_t];
				{
					if (_key != MOUSE_LEFT) exitWith {};
					_mPos = call mouseGetPosition select 1;
					_wid setVariable ["transform_lastPoint",_mPos];
					inspector_internal_lastWidgetTransformPos = [_wid];
					
				} call _setOnMouseDownCode;
				_exitedConditions = 
				{
					if isNullReference(inspector_internal_lastWidgetTransformPos select 0) exitWith {};
					inspector_internal_lastWidgetTransformPos = [widgetNull];
					_transName = _wid getVariable "transform_name";
					_transIndex = _wid getVariable "transform_index";
					_newPos = getPosATL _objWorld;
					_oldPos = _objWorld call golib_om_getPosition;
					
					[_objWorld,_newPos,true,format["Позиция %1 (%2 -> %3)",_transName,_oldPos select _transIndex,_newPos select _transIndex]] call golib_om_setPosition;
				};
				_exitedConditions call _setOnPressCode;
				_exitedConditions call _setOnKillFocusCode;
				{
					(_wid getVariable "input") ctrlSetText str ((_objWorld call golib_om_getPosition) select (_wid getVariable "transform_index"))
				} call _setSyncValCode;
				
				
				
				[INPUT,[100/3-(100/3/4),_optimalSizeH],100/3*_i + (100/3/4),_i==2] call _createElement;
				_wid ctrlSetFontHeight 0.035;
				_drag setVariable ["input",_wid];
				_wid setVariable ["transform_index",_i];
				_wid setVariable ["transform_name",_t];
				{
					_wid ctrlSetText str ((_objWorld call golib_om_getPosition) select (_wid getVariable "transform_index"))
				} call _setSyncValCode;
				{
					_text = ctrlText _wid;
					_transName = _wid getVariable "transform_name";
					_numval = parseNumber _text;
					if not_equals(str _numval,_text) exitWith {
						[format["Неверное значение для трансформации оси %1",_transName]] call showWarning;
					};
					_transIndex = _wid getVariable "transform_index";
					_oldPos = (_objWorld call golib_om_getPosition);
					_oldval = _oldPos select _transIndex;
					_oldPos set [_transIndex,_numval];
					
					[_objWorld,_oldPos,true,format["Позиция %1 (%2 -> %3)",_transName,_oldval,_numval]] call golib_om_setPosition;
				} call _setOnKillFocusCode;
			};
		//==========================================================================
		// Поворот
		//==========================================================================
		region(rot)
			[TEXT,[100,_optimalSizeH]] call _createElement;
			[_wid,format["<t align='left' size='0.8'>Трансформация: поворот</t>"]] call widgetSetText;
			for "_i" from 0 to 2 do {
				[TEXT,[100/3/4,_optimalSizeH],100/3*_i,false] call _createElement;
				(_panList select _i)params ["_t","_col"];
				[_wid,format["<t align='center'>%1</t>",_t]] call widgetSetText;
				_wid setBackgroundColor _col;
				_wid setVariable ["transform_index",_i];
				_wid setVariable ["transform_name",_t];
				_drag = _wid;
				_wid ctrlSetTooltip format["Чехи забыли написать функцию менеджмента локальной оси %1\n...поэтому тут ничего нет...",_t];
				/*{
					if (_key != MOUSE_LEFT) exitWith {};
					_mPos = call mouseGetPosition select 1;
					_wid setVariable ["transform_lastPoint",_mPos];
					inspector_internal_lastWidgetTransformPos = [_wid];
					
				} call _setOnMouseDownCode;
				_exitedConditions = 
				{
					if isNullReference(inspector_internal_lastWidgetTransformPos select 0) exitWith {};
					inspector_internal_lastWidgetTransformPos = [widgetNull];
					_transName = _wid getVariable "transform_name";
					_transIndex = _wid getVariable "transform_index";
					_newPos = getPosATL _objWorld;
					_oldPos = _objWorld call golib_om_getPosition;
					
					[_objWorld,_newPos,true,format["Позиция %1 (%2 -> %3)",_transName,_oldPos select _transIndex,_newPos select _transIndex]] call golib_om_setPosition;
				};
				_exitedConditions call _setOnPressCode;
				_exitedConditions call _setOnKillFocusCode;
				{
					(_wid getVariable "input") ctrlSetText str ((_objWorld call golib_om_getPosition) select (_wid getVariable "transform_index"))
				} call _setSyncValCode;*/
				
				
				
				[INPUT,[100/3-(100/3/4),_optimalSizeH],100/3*_i + (100/3/4),_i==2] call _createElement;
				_wid ctrlSetFontHeight 0.035;
				_drag setVariable ["input",_wid];
				_wid setVariable ["transform_index",_i];
				_wid setVariable ["transform_name",_t];
				{
					_wid ctrlSetText str ((_objWorld call golib_om_getRotation) select (_wid getVariable "transform_index"))
				} call _setSyncValCode;
				{
					_text = ctrlText _wid;
					_transName = _wid getVariable "transform_name";
					_numval = parseNumber _text;
					if not_equals(str _numval,_text) exitWith {
						[format["Неверное значение для трансформации оси %1",_transName]] call showWarning;
					};
					_transIndex = _wid getVariable "transform_index";
					_oldPos = (_objWorld call golib_om_getRotation);
					_oldval = _oldPos select _transIndex;
					_oldPos set [_transIndex,_numval];
					
					[_objWorld,_oldPos,true,format["Поворот %1 (%2 -> %3)",_transName,_oldval,_numval]] call golib_om_setRotation;
				} call _setOnKillFocusCode;
			};
	};

	region(probspawn)
		[TEXT,[100,_optimalSizeH]] call _createElement;
		//Тут осталось настроить синхру кнопки применения настроек
		[_wid,format["<t align='left'>Вероятность появления:</t>"]] call widgetSetText;
			[SLIDERWNEW,[70,_optimalSizeH/1.5],0,false] call _createElement;
			_slider = _wid;
			_wid sliderSetRange [0,100];
			_wid sliderSetPosition 100;
			//default color
			_wid ctrlSetForegroundColor [0.7,0.7,0.7,0.5];
			_wid ctrlSetActiveColor [0.7,0.7,0.7,0.5];
			{
				if ("prob" in _data) then {
					_wid ctrlSetTooltip ("Значение: " + str (sliderPosition _wid) +"%");
				};
			} call _setSyncValCode;
			{
				_wid ctrlSetForegroundColor [0.7,0,0,0.5];
				_wid ctrlSetActiveColor [0.7,0,0,0.5];
			} call _setSliderPosChangedCode;
			/*{
				if ("prob" in _data) then {
					_old = _data get "prob";
					_data set ["prob",_value];
					[_objWorld,_data,true,format["Изменение вероятности появления (%1 -> %2)",_old,_value]] call golib_setHashData;
				};
			} call _setOnKillFocusCode;*/
			[BUTTON,[8,_optimalSizeH/1.5],72,false] call _createElement;
			_button = _wid;
			_wid ctrlSetText "+";
			_wid ctrlSetTooltip "Нажмите, чтобы записать значение вероятности появления.";
			_wid setVariable ["slider",_slider];
			{
				if ("prob" in _data) then {
					_value = sliderPosition (_wid getVariable "slider");
					_old = _data get "prob";
					_data set ["prob",_value];
					[_objWorld,_data,true,format["Изменение вероятности появления (%1 -> %2)",_old,_value]] call golib_setHashData;
					
					_sli = (_wid getVariable "slider");
					_sli ctrlSetForegroundColor [0.7,0.7,0.7,0.5];
					_sli ctrlSetActiveColor [0.7,0.7,0.7,0.5];
				};
			} call _setOnPressCode;
			["RscCheckBox",[10,_optimalSizeH/1.2],80,true] call _createElement;
			_wid setVariable ["slider",_slider];
			_wid setVariable ["button",_button];
			{
				_wid cbSetChecked ("prob" in _data);
				_canuseslider = (cbChecked _wid);
				_slider = _wid getVariable "slider";
				_button = _wid getVariable "button";
				_slider ctrlEnable _canuseslider;
				_button ctrlEnable _canuseslider;
				widgetFadeNow(_slider,ifcheck(_canuseslider,0,0.5));
				widgetFadeNow(_button,ifcheck(_canuseslider,0,0.5));
				if (_canuseslider) then {
					_slider sliderSetPosition (_data get "prob");
					private _wid = _slider; //только здесь приват спасет (контекст не сломается)
					call (_slider getVariable "_onSync");
				};
			} call _setSyncValCode;
			{
				private _m = "";
				if (_checked) then {
					_data set ["prob",_data getOrDefault ["prob",100]];
					_m = "Включение случайного появления";
				} else {
					_data deleteAt "prob";
					_m = "Выключение случайного появления";	
				};
				
				[_objWorld,_data,true,_m] call golib_setHashData;
			} call _setOnCBChanged;
	
	if (!_isVirtualObject) then {

		region(randdir)
			[TEXT,[80,_optimalSizeH],0,false] call _createElement;
			[_wid,format["<t align='left'>Случайное направление:</t>"]] call widgetSetText;
				["RscCheckBox",[10,_optimalSizeH],80,true] call _createElement;
				{
					_wid cbSetChecked ("rdir" in _data);
				} call _setSyncValCode;
				{
					private _m = "";
					if (!_checked) then {
						_data deleteAt "rdir";
						_m = "Выключение рандомного направления";
					} else {
						_data set ["rdir",true];
						_m = "Включение рандомного направления";
					};
					
					[_objWorld,_data,true,_m] call golib_setHashData;
				} call _setOnCBChanged;
			
		region(randpos)
			[TEXT,[50,_optimalSizeH],0,false] call _createElement;
			[_wid,format["<t align='left'>Случайная позиция</t>"]] call widgetSetText;
			
			[INPUT,[30,_optimalSizeH],50,false] call _createElement;
			_input = _wid;
			{
				if ("rpos" in _data) then {
					_wid ctrlEnable true;
					_wid ctrlSetText str(_data get "rpos");
				} else {
					_wid ctrlSetText "";
					_wid ctrlEnable false;
				};
			} call _setSyncValCode;
			{
				_val = parseNumber(ctrlText _wid);
				if !inRange(_val,0,1000) then {
					["Для случайной позиции радиус может быть в диапазоне от 0 до 1000"] call showWarning;
					_val = clamp(_val,0,1000);
				};
				_data set ["rpos",_val];
				[_objWorld,_data,true,"Изменение радиуса случайной позиции"] call golib_setHashData;
			} call _setOnKillFocusCode;
			["RscCheckBox",[10,_optimalSizeH],80,true] call _createElement;
			_wid setVariable ["_input",_input];
			{
				_wid cbSetChecked ("rpos" in _data);
			} call _setSyncValCode;
			{
				if (_checked) then {
					_data set ["rpos",0];
				} else {
					_data deleteAt "rpos";
				};
				[_objWorld,_data,true,"Переключение случайной позиции"] call golib_setHashData;
				
				_wid = _wid getVariable "_input";
				call (_wid getVariable "_onSync");
			} call _setOnCBChanged;
	};

	//attributes
	_getAtrAtIdx = {
		params ["_x","_idx",["_onerror","ERROR_NOVAL"]];
		modvar(_idx) + 1;
		if (count _x <= 1 || {(count _x -1) > _idx}) exitWith {_onerror};
		_x select _idx;
	};
	_type = _obj getVariable "className";
	50 call _createCTGExt;
	
	{
		_memberName = _x;
		_memberVisibleName = _x;
		_atrList = _y;
		
		//Только внутренняя реализация
		if ([_type,_memberName,"InternalImpl"] call goasm_attributes_hasAttributeField) then {continue};
		
		_sizeMemX = 100;
		_offsetMemX = 0;
		_toNextLine = true;
		_tooltip = format["%1::%2",_type,_memberName];
		_editorType = "";
		_editorContext = null;
		//Обрабатываем атрибуты члена в этом цикле
		{
			_atrName = _x select 0;
			call {
				if (_atrName == "Tooltip") exitWith {
					_tooltip = _tooltip+"\n\n"+([_x,0,"empty descr"] call _getAtrAtIdx);
				};
				if (_atrName == "alias") exitWith {
					if (count _x <= 1) exitWith {_memberVisibleName = "ERROR_ALIAS::"+_memberName};
					_memberVisibleName = _x select 1;
				};
				if (_atrName == "EditorVisible") exitWith {
					if (_editorType!="") exitWith {
						["%1 - Editor provider already defined <%2> -> %3::%4",__FUNC__,_editorType,_data get "class",_memberName] call printError;
						continue;
					};
					
					_idx = _x findif {"type:"in _x};
					if (_idx!=-1) exitWith {
						_editorType = ["check",((_x select _idx) splitString ":") select 1] call goasm_attributes_providerNativeGet;
						if (_editorType!="") then {
							//если есть способ изменения то он будет правее названия
							_sizeMemX = 45;
							_offsetMemX = _sizeMemX;
							_editorContext = _x select [1,count _x];
						};
					};
					_idx = _x findif {"custom_provider:"in _x};
					if (_idx!=-1) then {
						_editorType = ((_x select _idx) splitString ":") select 1;
						if (_editorType!="") then {
							//если есть способ изменения то он будет правее названия
							_sizeMemX = 45;
							_offsetMemX = _sizeMemX;
							_editorContext = _x select [1,count _x];
						};
					};
				};
			}
		} foreach _atrList;
		[TEXT,[_sizeMemX,_optimalSizeH],0,_editorType==""] call _createElement;
		[_wid,format["<t align='left'>p: %1</t>",_memberVisibleName]] call widgetSetText;
		_wid setVariable ["_memberName",_memberName];
		_wid setVariable ["_editorContext",_editorContext];
		
		_wid ctrlSetTooltip _tooltip;
		
		if (_editorType!="") then {
			
			//Вот тут сам код поставщика
			call (missionNamespace getVariable ["goasm_attributes_handleProvider_"+_editorType,{
				[BUTTON,[50,_optimalSizeH],_offsetMemX,true] call _createElement;
				_wid ctrlSetText ("ERROR PROVIDER: " + _editorType);
				_wid ctrlSetTooltip("ERROR PROVIDER: " + _editorType);
			}]);
		};
		
		
		
	} foreach (_obj getVariable "_redit_attribFields");
	
	
	30 call _createCTGExt;
	[TEXT,[100,_optimalSizeH]] call _createElement;
	[_wid,"<t align='left'>Код инициализации</t>"] call widgetSetText;
	_wid ctrlSetTooltip "Данный код будет вызван сразу после создания объекта и расположения на карте";

	["RscEditReadOnly",[65,_optimalSizeH],5,false] call _createElement;
	_input = _wid;
	{
		if ("code_onInit" in _data) then {
			_wid ctrlSetText (_data get "code_onInit");
			_wid ctrlSetBackgroundColor [.7,.7,.7,.7];
			_wid ctrlSetTooltip ([_data get "code_onInit","\n","\\n"] call regex_replace);
		} else {
			_wid ctrlSetText "";
			_wid ctrlSetBackgroundColor [0.3,0.3,0.3,0.3];
			_wid ctrlSetTooltip "";
		};
	} call _setSyncValCode;

	[BUTTON,[24,_optimalSizeH],72,true] call _createElement;
	_wid ctrlSetText "Изменить";
	_wid ctrlSetTooltip "ЛКМ - для открытия окна инициализации\nПКМ - очистка инструкций";
	{
		if (_key == MOUSE_RIGHT) exitwith {
			_wid = _input;
			if ("code_onInit" in _data) then {
				_data deleteAt "code_onInit";
				[_objWorld,_data,true] call golib_setHashData;
				call (_wid getVariable "_onSync");
			};
		};

		[_data getOrDefault ["code_onInit",""],_objWorld] call golib_code_open;		
	} call _setOnPressCode;
}