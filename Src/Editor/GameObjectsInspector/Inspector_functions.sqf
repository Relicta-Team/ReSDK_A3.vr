// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(inspector_init)
{
	inspector_const_providedBatchedPropColor = "#448709" call color_HTMLtoRGBA;
	inspector_const_providedBatchedPropColor set [3,0.4];

	inspector_const_providedBatchedTransformColor = "#448709" call color_HTMLtoRGBA;
	inspector_const_providedBatchedTransformColor set [3,0.4];

	private _handleSelectionChange = {
		params ["_list"];
		
		//нельзя выбирать персонажа (впрочем как и ставить...)
		//Нельзя также выбирать системный объект golib_com_object
		if (!cfg_debug_devMode && {
			_list findif {
				_ismob = [_x get3DENAttribute "name" select 0, "debug_mob"] call stringStartWith;
				//{(_x get3DENAttribute "ControlMP" select 0)}
				((_x isKindOf "Man") && {(!cfg_debug_allowSelectUnits)} && {!_ismob}) || 
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

		traceformat("[preupdate inspect]: FRAME %1; cnt: %2",diag_frameNo arg count(get3DENSelected "" select 0));
		
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

	inspector_otherObjects = [];
	inspector_allSelectedObjects = [];
	
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
	
	inspector_otherObjects = [];
	inspector_allSelectedObjects = [];
	_isWorldContext = count _objList > 0 && {!((_objList select 0) call golib_isVirtualObject)};
	
	//["Inspector load %1, frame: %2 (world context - %3)%4CTX:%5",tickTime,diag_frameNo,_isWorldContext,endl,diag_stacktrace apply {_x select [0,3] joinString " + "} joinString (endl+"    ")] call printTrace;

	private _ctgInspectorMain = "inspector_ctg_bind" call widget_getBind;
	if isNullReference(_ctgInspectorMain) exitWith {};
	{ctrlDelete _x} foreach (allControls _ctgInspectorMain);
	
	//_objlist = get3DENSelected "" select 0;
	private _isOneNonDatedObject = count _objList == 0 || { _objList findif {!([_x] call golib_hasHashData)} != -1};
	if (_isOneNonDatedObject) exitWith {
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

	private _isSingleObject = count _objList == 1;
	private _multiObjectText = {
		ifcheck(_isSingleObject,"",_this)
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
					modvar(_internalY) + (_sizes select ifcheck(count _sizes >= 3,2,1)); //тут можно добавить оффест для паддинга
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
		//["%1 - null type %2",__FUNC__,_type] call printError;
	};
	private _isVirtualObject = _objWorld call golib_isVirtualObject;
	inspector_allSelectedObjects = _objList;
	if (!_isSingleObject) then {inspector_otherObjects = _objList select [1,count _objList]};

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
	_text = if (_isSingleObject) then {
		format["<t align='left'>Объект: %1</t>",_classnameShow];
	} else {
		format["<t align='left'>Несколько объектов: %1</t>",count _objList];
	};
	[_wid,_text] call widgetSetText;
	if (!_isSingleObject) then {
		_wid ctrlSetTooltip (
			(format["Нажмите ЛКМ для контекстного меню\nПервый объект: %1\n",_classnameShow]) + 
			("Типы:\n"+(hashSet_toArray(hashSet_create(_objList apply {[_x] call golib_getClassName})) joinString "\n"))
		);
	} else {
		_wid ctrlSetTooltip "Нажмите ЛКМ для контекстного меню";
	};
	_wid ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0.4,0.4,0.4,1];}];
	_wid ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor [0,0,0,0];}];
	{
		[
			[
				["Сбросить свойства",
					[
						["Все",{
							private _olist = inspector_allSelectedObjects;
							[_olist,true,true,true] call golib_resetObjectsData;
						}],
						["Вероятности",{
							private _olist = inspector_allSelectedObjects;
							[_olist,true,true,false] call golib_resetObjectsData;
						}],
						["Только свойства",{
							private _olist = inspector_allSelectedObjects;
							[_olist,true,false,true] call golib_resetObjectsData;
						}]
					]
				],
				["Замена класс"+ifcheck(count inspector_otherObjects == 0,"а","ов"),{
					//(call contextMenu_getContextParams) params ["_wid","__codeValidateContainer"];
					
					private _newval = refcreate(0);
					if ([
						_newval,
						"Выберите новый тип",
						"Выберите тип для выделенных объектов",
						["IDestructible",{
							_this != "IDestructible"
						}] call widget_winapi_getTreeObject
					] call widget_winapi_openTreeView) then {
						if (refget(_newval) == "") exitWith {};
						private _class = refget(_newval);

						if (
							([_class,"InterfaceClass"] call goasm_attributes_hasAttributeClass)
							|| {([_class,"HiddenClass"] call goasm_attributes_hasAttributeClass)}
						) exitWith {
							["Класс недоступен (интрейфес или скрытый)"] call showError;
						};

						if (["Внимание!"+endl+endl
							+"Замена класса объекта влечет за собой очистку свойств изменяемых объектов."+endl+endl
							+(format[" Вы действительно хотите выполнить замену на %1?",_class])] call messageBoxRet
						) then {
							private _olist = inspector_allSelectedObjects;
							[_olist,true,false,true,_class] call golib_resetObjectsData;
							nextFrame(inspector_menuLoad);
						};
						
					};
				}],
				["Отмена",{}]
			],
			call mouseGetPosition,
			[]
		] call contextMenu_create;
	} call _setOnPressCode;

	
	//mark
	[TEXT,[50,_optimalSizeH],0,false] call _createElement;
	[_wid,format["<t align='left' size='0.9'>Глобальн%1 ссылк%2:</t>",ifcheck(_isSingleObject,"ая","ые"),ifcheck(_isSingleObject,"а","и")]] call widgetSetText;
	[BUTTON,[10,_optimalSizeH],50,false] call _createElement;
	_wid ctrlSetText "+";
	_wid ctrlSetTooltip "ЛКМ - сохранить\nПКМ - очистить";
	_button = _wid;
	{
		
		private _deleteCode = {
			(_wid getVariable "input") ctrlSetText "";
			if ("mark" in _data) then {
				_data deleteAt "mark";
				["mark"] call goilb_setBatchMode;
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
			["mark","set_mark"] call goilb_setBatchMode;
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
	if (!_isVirtualObject) then {
		[TEXT,[100,_optimalSizeH],0,true] call _createElement;
		{
			private _setKeys = createHashMap;
			{
				private _l = [_x,true] call layer_getObjectLayer;
				if (_l!="") then {
					hashSet_add(_setKeys,_l);
				};
			} foreach inspector_allSelectedObjects;

			_pressHelper = "Нажмите ЛКМ чтобы открыть меню выбора слоя";
			private _ltxt = "НЕ ЗАГРУЖЕНО";
			if (count _setKeys <= 1) then {
				_fkey = hashSet_toArray(_setKeys );
				_ltxt = ifcheck(count _fkey == 0,"",_fkey select 0);
				if (_ltxt == "") then {_ltxt = slt+"нет"+sgt};
			} else {
				_ltxt = slt+"несколько значений"+sgt;
				modvar(_pressHelper) + "\n\nОбнаружены слои:\n" + (
					(hashSet_toArray(_setKeys) apply {format["- %1",_x]}) joinString "\n"
				);
			};

			_wid ctrlSetTooltip _pressHelper;
			[_wid,format["<t align='left'>Слой: %1</t>",_ltxt]] call widgetSetText;
		} call _setSyncValCode;
		
		_wid ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0.4,0.4,0.4,1];}];
		_wid ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor [0,0,0,0];}];
		{
			private _newLayerId = [
				"Выберите слой",
				format["Выберите слой, в который будут помещены объекты (%1 шт)",count inspector_allSelectedObjects],
				[_objWorld,false] call layer_getObjectLayer
			] call layer_openSelectLayer;
			if (_newLayerId != -1) then {
				
				["Изменение слоя", format["Замена слоя для %1 объектов",count inspector_allSelectedObjects], "a3\3den\data\Cfg3DEN\History\addToLayer_ca.paa"] collect3DENHistory
				{
					{
						[_x,_newLayerId] call layer_addObject;
					} foreach inspector_allSelectedObjects;
				};
			};

		} call _setOnPressCode;
	};
	
	//!VISIBILITY DISABLED
	// [TEXT,[40,_optimalSizeH],50,false] call _createElement;
	// [_wid,format["<t align='right'>Видимость:</t>"]] call widgetSetText;
	// ["RscCheckBox",[10,_optimalSizeH],90,true] call _createElement;
	// _wid ctrlSetTooltip "Не реализовано в текущей версии...";
	// {
	// 	_wid cbSetChecked (!("invisible" in _data));
	// } call _setSyncValCode;
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
			[_wid,format["<t align='left' size='0.8'>Трансформация: позиция%1</t>"," (несколько)" call _multiObjectText]] call widgetSetText;
			for "_i" from 0 to 2 do {
				[TEXT,[100/3/4,_optimalSizeH],100/3*_i,false] call _createElement;
				(_panList select _i)params ["_t","_col"];
				[_wid,format["<t align='center'>%1</t>",_t]] call widgetSetText;
				_wid setBackgroundColor _col;
				_wid setVariable ["transform_index",_i];
				_wid setVariable ["transform_name",_t];
				_drag = _wid;
				if (!_isSingleObject) then {
					_wid ctrlSetTooltip format["Трансформация перетягиванием для нескольких объектов не поддерживается"];
				} else {
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
				};
				
				{
					(_wid getVariable "input") ctrlSetText str ((_objWorld call golib_om_getPosition) select (_wid getVariable "transform_index"))
				} call _setSyncValCode;
				
				
				
				[INPUT,[100/3-(100/3/4),_optimalSizeH],100/3*_i + (100/3/4),_i==2] call _createElement;
				_wid ctrlSetFontHeight 0.035;
				if (!_isSingleObject) then {
					_wid setBackgroundColor inspector_const_providedBatchedTransformColor;	
				};
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

					["position",[_transIndex,getdiff(_oldval,_numval)]] call goilb_setBatchMode;
					[_objWorld,_oldPos,true,format["Позиция %1 (%2 -> %3)",_transName,_oldval,_numval]] call golib_om_setPosition;
				} call _setOnKillFocusCode;
			};
		//==========================================================================
		// Поворот
		//==========================================================================
		region(rot)
			[TEXT,[100,_optimalSizeH]] call _createElement;
			[_wid,format["<t align='left' size='0.8'>Трансформация: поворот%1</t>"," (несколько)" call _multiObjectText]] call widgetSetText;
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
				if (!_isSingleObject) then {
					_wid setBackgroundColor inspector_const_providedBatchedTransformColor;	
				};
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
					
					["rotation",[_transIndex,getdiff(_oldval,_numval)]] call goilb_setBatchMode;
					[_objWorld,_oldPos,true,format["Поворот %1 (%2 -> %3)",_transName,_oldval,_numval]] call golib_om_setRotation;
				} call _setOnKillFocusCode;
			};
	};

	region(probspawn)
		[TEXT,[100,_optimalSizeH]] call _createElement;
		//Тут осталось настроить синхру кнопки применения настроек
		[_wid,format["<t align='left'>Вероятность появления%1:</t>"," (несколько)" call _multiObjectText]] call widgetSetText;
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
					["prob","set"] call goilb_setBatchMode;
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
				_slider ctrlShow _canuseslider;
				if (_canuseslider) then {
					_slider sliderSetPosition (_data get "prob");
					private _wid = _slider; //только здесь приват спасет (контекст не сломается)
					call (_slider getVariable "_onSync");
				} else {
					_slider sliderSetPosition 100;
				};
			} call _setSyncValCode;
			{
				private _m = "";
				private _modeBatch = "";
				if (_checked) then {
					_data set ["prob",_data getOrDefault ["prob",100]];
					_m = "Включение случайного появления";
					_modeBatch = "set";
				} else {
					_data deleteAt "prob";
					_m = "Выключение случайного появления";	
					_modeBatch = "del";
				};
				["prob",_modeBatch] call goilb_setBatchMode;
				[_objWorld,_data,true,_m] call golib_setHashData;
			} call _setOnCBChanged;
	
	if (!_isVirtualObject) then {

		region(randdir)
			[TEXT,[80,_optimalSizeH],0,false] call _createElement;
			[_wid,format["<t align='left'>Ранд. направление%1:</t>"," <t size='0.7'>(несколько)</t>" call _multiObjectText]] call widgetSetText;
				_wid ctrlSetTooltip "Случайное направление (рандомное) отвечает за рандомный поворт объекта при появлении.";
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
					["rdir"] call goilb_setBatchMode;
					[_objWorld,_data,true,_m] call golib_setHashData;
				} call _setOnCBChanged;
			
		region(randpos)
			[TEXT,[50,_optimalSizeH],0,false] call _createElement;
			[_wid,format["<t align='left'>Ранд. позиция%1</t>"," <t size='0.7'>(неск.)</t>" call _multiObjectText]] call widgetSetText;
			_wid ctrlSetTooltip "Случайная позиция (рандомная) отвечает за зону случайной позиции объекта. Если она установлена, то объект появится в радиусе указанной позиции по оси Z.";

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
				["rpos"] call goilb_setBatchMode;
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
				["rpos"] call goilb_setBatchMode;
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
	
	_propsSizeMid = 50;
	_propsSizeMid call _createCTGExt;
	
	_registeredFields = createHashMap;
	{
		//_type = _x getVariable "className";
		_wobjIter = _x;
		_clsObj = [_x] call golib_getClassName;
		_type = [_clsObj,"className"] call oop_getTypeValue;
		_isFirstType = _foreachIndex == 0;
		{
			_memberName = _x;
			//already registered in inspector
			if ((tolower _memberName) in _registeredFields) then {
				private _rf = (_registeredFields get (tolower _memberName));
				_rf params ["_wid__","_ctr__"];
				_rf set [1,_ctr__ + 1];
				continue;
			}; 
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
			[_wid,format["<t align='left'>%1</t>",_memberVisibleName]] call widgetSetText;
			_wid setVariable ["_memberName",_memberName];
			_wid setVariable ["_editorContext",_editorContext];
			_wid setVariable ["___isMultiselectProp",false];
			_wid setvariable ["___visibleName",_memberVisibleName];
			_wid setvariable ["___providedClass",_type];
			if (!_isVirtualObject) then {
				_wid ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];
					if (_b==MOUSE_RIGHT) then {
						[
							_w getvariable "_memberName",
							_w getvariable "___isMultiselectProp",
							inspector_allSelectedObjects,
							_w getvariable "___visibleName",
							_w getvariable "___providedClass"
						] call inspector_onPressPropertyCtxMenu;
					};
					if (_b==MOUSE_LEFT) then {
						[format["Нажмите ПКМ по свойству ""%1"" для работы со значением",_w getvariable "___visibleName"]] call showInfo;
					};
				}];
			} else {
				_wid ctrlAddEventHandler ["MouseButtonUp",{
					["Виртуальные объекты в инспекторе не поддерживают контекстное меню выбора"] call showWarning;
				}];
			};
			
			_wid ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0.4,0.4,0.4,1];}];
			_wid ctrlAddEventHandler ["MouseExit",{
				(_this select 0) setBackgroundColor 
					((_this select 0) getvariable ["___bufferedbackcolor",[0,0,0,0]]);
			}];
			
			_wid ctrlSetTooltip _tooltip;

			if (!_isFirstType) then {
				_tooltip = "Предоставлено классом " + _type + "\n\n" + _tooltip;
				_wid ctrlSetTooltip _tooltip;
				_wid setBackgroundColor inspector_const_providedBatchedPropColor;
				_wid setVariable ["___bufferedbackcolor",inspector_const_providedBatchedPropColor];
			};

			_registeredFields set [tolower _memberName,[_wid,1,_memberVisibleName]];
			
			if (_editorType!="") then {
				private _cacheODT = [_objWorld,_data];
				if (!_isFirstType) then {
					//правка чтобы с внешних объектов подгружались дефолт свойства в визуал
					_objWorld = _wobjIter;
					_data = [_objWorld] call golib_getHashData;
				};

				//Вот тут сам код поставщика
				call (missionNamespace getVariable ["goasm_attributes_handleProvider_"+_editorType,{
					[BUTTON,[50,_optimalSizeH],_offsetMemX,true] call _createElement;
					_wid ctrlSetText ("ERROR PROVIDER: " + _editorType);
					_wid ctrlSetTooltip("ERROR PROVIDER: " + _editorType);
				}]);

				_objWorld = _cacheODT select 0;
				_data = _cacheODT select 1;
			};
			
		} foreach ([_clsObj,"_redit_attribFields"] call oop_getTypeValue);//(_x getVariable "_redit_attribFields");

	} foreach ifcheck(_isSingleObject,[_objWorld],_objList);
	
	{
		_y params ["_wid__","_ctr__","_memvisname__"];
		if (_ctr__ > 1) then {
			[_wid__,format["<t align='left'>%1 (x%2)</t>",_memvisname__,_ctr__]] call widgetSetText;
			_wid__ ctrlSetTooltip (format["Объектов с этим свойством: %1\n%2",_ctr__,ctrltooltip _wid__]);
			_wid__ setvariable ["___isMultiselectProp",true];
		};
	} foreach _registeredFields;

	//adjust max size
	//TODO auto adjust size for object propertys
	//(_controlGroup call widgetGetPosition) params ["_pX","_pY","_pW","_pH"];
	// private _newHLastGroup = _internalY;//_propsSizeMid min (_internalY);
	// //_internalY = _newHLastGroup;
	// [_controlGroup,[_pX,_pY,_pW,_newHLastGroup],5] call widgetSetPosition;
	// [_backgroundPrev,WIDGET_FULLSIZE] call widgetSetPosition;
	
	30 call _createCTGExt;

	//===============================new scripting tab===============================
	[TEXT,[100,_optimalSizeH]] call _createElement; //name
	[_wid,format["<t align='left'>Скрипт объекта%1</t>"," (несколько)" call _multiObjectText]] call widgetSetText;

	//edit scriptname
	["RscEditReadOnly",[65,_optimalSizeH],5,false] call _createElement;
	_input = _wid;
	{
		_scr = _data getOrDefault ["__scriptName",""];
		private _dirtyScriptName = false;
		private _dirtyScriptList = [];
		if (count inspector_otherObjects > 0) then {
			{
				private _scrCheck = [_x,"__scriptName"] call golib_getActualBasicValue;
				
				if (!isNullVar(_scrCheck) && {_scrCheck != _scr}) then {
					_dirtyScriptName = true;
					if !isNullVar(_scrCheck) then {
						_dirtyScriptList pushBackUnique _scrCheck;
					};
				};
				
			} foreach inspector_otherObjects;
		};
		_wid ctrlsettext ifcheck(_dirtyScriptName,"Несколько значений",_scr);
		if (_dirtyScriptName && count _dirtyScriptList > 0) then {
			_dirtyScriptList pushBackUnique _scr;
			_wid ctrlSetTooltip (format["Несколько скриптов:\n%1",_dirtyScriptList joinString "\n"]);
		};
	} call _setSyncValCode;

	[BUTTON,[24,_optimalSizeH],72,true] call _createElement;
	_wid setvariable ["_input",_input];
	_wid ctrlSetText "Изменить";
	_wid ctrlSetTooltip "ЛКМ - для открытия окна выбора класса\nПКМ - сброс";
	{
		_inputSync = {
			_wid = _wid getVariable "_input";
			call (_wid getVariable "_onSync");
		};	
		if (_key == MOUSE_RIGHT) exitwith {
			if ("__scriptName" in _data) then {
				_data deleteAt "__scriptName";
				_data deleteAt "__scriptParams";
				[["__scriptName","__scriptParams"],"del"] call goilb_setBatchMode;
				[_objWorld,_data,true] call golib_setHashData;
				call _inputSync;
				nextFrame(inspector_menuLoad);
			};
		};
		
		private _newval = refcreate(0);
		if ([
			_newval,
			"Выберите скрипт",
			"Выберите скрипт, который будет назначен этому объекту",
			["ScriptedGameObject",{_this != "ScriptedGameObject"}] call widget_winapi_getTreeObject
		] call widget_winapi_openTreeView) then {
			if (refget(_newval) == "") exitWith {};

			_data set ["__scriptName",refget(_newval)];
			["__scriptName"] call goilb_setBatchMode;
			[_objWorld,_data,true] call golib_setHashData;
			
			call _inputSync;
		};

	} call _setOnPressCode;

	//script params
	[TEXT,[100,_optimalSizeH],0,true] call _createElement;
	[_wid,format["<t align='left'>Параметры:</t>"]] call widgetSetText;
	
	_iTxt = 8;
	_pnameTxt = 25;
	_pvalTxt = 55;
	_pdelTxt = 12;

	_hd = _data get "__scriptParams";
	{
		[TEXT,[_iTxt,_optimalSizeH],0,false] call _createElement;
		[_wid,format["<t align='left' size='0.9'>%1</t>",_foreachIndex+1]] call widgetSetText;
		_indexKeyWid = _wid;
		
		// ? Param key
		[INPUT,[_pnameTxt,_optimalSizeH],_iTxt,false] call _createElement;
		_wid setvariable ["_index",_foreachIndex];
		_wid setvariable ["_indexKeyWid",_indexKeyWid];
		{
			_spars = _data getOrDefault ["__scriptParams",[]];
			_index = _wid getvariable "_index";
			_indexKeyWid = _wid getvariable "_indexKeyWid";
			_txtData = "";
			_txtData = _spars select _index select 0;
			_wid ctrlSetText _txtData;
			_wid ctrlSetTooltip (format["Значение: '%1'",_txtData]);
			_wid ctrlSetFontHeight 0.035;
			_indexKeyWid ctrlSetTooltip (format["Параметр %1: '%2'",_index,_txtData]);
		} call _setSyncValCode;
		{
			_spars = _data getOrDefault ["__scriptParams",[]];
			_index = _wid getvariable "_index";
			_kvpair = _spars select _index;
			private _key = _kvpair select 0;
			if not_equals(_key,ctrlText _wid) then {
				_kvpair set [0,ctrlText _wid];
				["__scriptParams","script_params_setvalidate"] call goilb_setBatchMode;
				[_objWorld,_data,true,format["Изменение параметра '%1'",_key]] call golib_setHashData;
			};
		} call _setOnKillFocusCode;

		// ? Param value
		[INPUT,[_pvalTxt-2,_optimalSizeH],_iTxt+_pnameTxt+2,false] call _createElement;
		_wid setvariable ["_index",_foreachIndex];
		{
			_spars = _data getOrDefault ["__scriptParams",[]];
			_index = _wid getvariable "_index";
			_txtData = "";
			_txtData = _spars select _index select 1;
			_wid ctrlSetText _txtData;
		} call _setSyncValCode;
		{
			_spars = _data getOrDefault ["__scriptParams",[]];
			_index = _wid getvariable "_index";
			_kvpair = _spars select _index;
			private _key = _kvpair select 0;
			_val = _kvpair select 1;
			if not_equals(_val,ctrlText _wid) then {
				_kvpair set [1,ctrlText _wid];
				["__scriptParams","script_params_setvalidate"] call goilb_setBatchMode;
				[_objWorld,_data,true,format["Изменение значения параметра '%1'",_key]] call golib_setHashData;
			};
		} call _setOnKillFocusCode;

		// ? delete param
		[BUTTON,[_pdelTxt,_optimalSizeH],(_iTxt+_pnameTxt+_pvalTxt),true] call _createElement;
		_wid ctrlSetText "X";
		_wid ctrlSetTooltip (format["Удаляет параметр %1",_foreachIndex+1]);
		_wid ctrlSetBackgroundColor [1,0,0,1];
		_wid setVariable ["_index",_foreachIndex];
		{
			_spars = _data getOrDefault ["__scriptParams",[]];
			_index = _wid getvariable "_index";
			_spars deleteAt _index;
			_validator = null;
			if (count _spars == 0) then {
				_data deleteAt "__scriptParams";
				_validator = "script_params_delvalidate";
			} else {
				_data set ["__scriptParams",_spars];
				_validator = "script_params_setvalidate";
			};
			["__scriptParams",_validator] call goilb_setBatchMode;
			[_objWorld,_data,true,format["Удаление параметра %1",_foreachIndex+1]] call golib_setHashData;
			nextFrame(inspector_menuLoad);
		} call _setOnPressCode;
	} foreach _hd;
	

	[BUTTON,[48*2,_optimalSizeH],2,true] call _createElement;
	_wid ctrlSetText "Добавить параметр";
	{
		if !("__scriptName" in _data) exitWith {
			["Для добавления параметров назначьте скрипт выбранным объектам"] call showError;
		};
		_spars = _data getOrDefault ["__scriptParams",[]];
		_spars pushBack [format["Параметр %1",count _spars+1],""];
		_data set ["__scriptParams",_spars];
		["__scriptParams","script_params_setvalidate"] call goilb_setBatchMode;
		[_objWorld,_data,true,format["Добавление параметра скрипта"]] call golib_setHashData;
		nextFrame(inspector_menuLoad);
	} call _setOnPressCode;

	//----------- LEGACY SCRIPTING ------------
	//! this will be removed in next versions
	[TEXT,[100,_optimalSizeH/2],null,null] call _createElement;
	_wid setBackgroundColor [0.7,0.7,0.7,0.6];
	
	[TEXT,[100,_optimalSizeH]] call _createElement;
	[_wid,"<t align='left' color='#BD2211'>Код инициализации (УСТАРЕВШЕЕ)</t>"] call widgetSetText;
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
		if (!golib_code_deprecatedWarnVisible) then {
			golib_code_deprecatedWarnVisible = true;
			["Компонент ECode является устаревшим и не должен быть использован на новых проектах карт"] call messageBox;
		};
		[_data getOrDefault ["code_onInit",""],_objWorld] call golib_code_open;		
	} call _setOnPressCode;
}

//открытие контекстного меню работы со свойствами
function(inspector_onPressPropertyCtxMenu)
{
	params ["_propName","_isMultiprop","_objList","_visName","_visClass"];

	private _ctxParams = [_visClass,_propName,_isMultiprop,_visName];
	
	#define selprc(flags) nextFrameParams(inspector_internal_onPressCtx,[call contextMenu_getContextParams arg flags]);
	
	private _stackMenu = [
		["Выделение",[
			/*
				Выделение на основе наличия свойства
			*/
			["Свойство",[
				[format["Выдел. с %1",_visName],{selprc("sel")},null,format["Выбирает выделенные объекты имеющие свойство %1",_visName]],
				[format["Выдел. типы с %1",_visName],{selprc("sel|classof")},null,format["Выбирает выделенные объекты определенного типа со свойством %1",_visName]],
				[format["Выдел. типы и их дочерние с %1",_visName],{selprc("sel|typeof")},null,format["Выбирает выделенные объекты определенного типа и все дочерние со свойством %1",_visName]],
				//здесь нужна логика выбора мировых объектов чтобы потом делать выбор по значению из выделенных
				[format["Все с %1",_visName],{selprc("all")},null,format["Выбирает все объекты в сцене имеющие свойство %1",_visName]],
				[format["Все типы с %1",_visName],{selprc("all|classof")},null,format["Выбирает все объекты в сцене определенного типа со свойством %1",_visName]],
				[format["Все типы и их дочерние с %1",_visName],{selprc("all|typeof")},null,format["Выбирает все объекты в сцене определенного типа и все дочерние со свойством %1",_visName]]
			],null,"Выделение объектов имеющих данное свойство"],
			/*
				Выделение на основе значения свойства
			*/
			["Значения",[
				[format["Со значением"],{selprc("sel|withval")},ifcheck(_isMultiprop,{true},{false}),format["Выбирает все объекты из выделенных принимающих указанное значение для свойства ""%1""",_visName]],
				[format["С любым значением"],{selprc("sel|withanyval|typeof")},ifcheck(_isMultiprop,{true},{false}),format["Выбирает все объекты из выделенных принимающих любое значение для свойства ""%1""",_visName]],
				[format["Без значения"],{selprc("sel|withdefault")},ifcheck(_isMultiprop,{true},{false}),"Выбирает все объекты из выделенных, свойство которых принимает значение по умолчанию"]
			],null,"Выделение объектов на основе значений"]
		],null,format["Специализированный выбор объектов, владеющих свойством ""%1""",_visName]],
		["Сброс",[
			["Выдел. с этим значением",{selprc("sel|withval|deleteprop")},null,"Сбрасывает свойства для объектов, принимающих указанное значение"],
			["Только типы",{selprc("sel|classof|deleteprop")},null,"Сбрасывает свойства для объектов, определенного типа"],
			["Только типы и их дочерние",{selprc("sel|typeof|deleteprop")},null,"Сбрасывает свойства для объектов, определенного типа и его дочерних"]
		],null,format["Сброс значения свойства ""%1"" объектов",_visName]]
	];
	#undef selprc

	_stackMenu pushBack ["Отмена",{}];
	private _par = [
		_stackMenu,
		call mouseGetPosition,
		_ctxParams
	];
	nextFrameParams(contextMenu_create,_par);
}

function(inspector_internal_onPressCtx)
{
	//пришлось немного накостылить чтобы исправить зажатую мышь при выборе класса из winapi tree
	params ["_ctxMenu","_flags"];
	_ctxMenu params ["_cls","_memb","_isMulProp","_visName"];
	_p = ["property",hashMapNewArgs [["class",_cls],["property",_memb],["visibleName",_visName]],_flags,_isMulProp];
	[displayNull] call loadingScreen_start;
	[50,"Запрос объектов"] call loadingScreen_setProgress;
	_mtxval = [_p,false];
	invokeAfterDelayParams({(_this select 0) call inspector_processReselectQuery; _this set [1 arg true]},0.1,_mtxval);
	startAsyncInvoke
		{(_this select 1) && ((inputMouse 0) == 0 && (inputMouse 1) == 0)},
		//!это не ошибка. необходимо сделать фиктивную задержку чтобы "зарелизить" инпут
		{invokeAfterDelay({call loadingScreen_stop},0);["mps release %1 %2",inputMouse 0,inputMouse 1] call printTrace},_mtxval,10,
		{["Fatal error on restore mouse state (inspector::onPressPropertyCtxMenu)"] call showError}
	endAsyncInvoke
}

function(inspector_processReselectQuery)
{
	params ["_selectType","_paramMap","_flags","_isMulProp"];
	
	private _doExit = false;
	
	//_selectType == "property"
	
	/*
		paramMap:
		class - class name
		property - property name
		visibleName - property visible name

		---
		rtvals:
		existValue - string data of exist value

		flags:
		all - select from all scene objects
		sel - select from selected objects
		classof - select if class equal to _paramMap["class"]
		typeof - select if class istypeof _paramMap["class"]
	*/
	private _flagSet = hashSet_create((tolower _flags) splitString "| ");
	private _objList = [];
	["%1: type: %4;flags: %2; params: %3",__FUNC__,_flags,_paramMap,_selectType] call printTrace;
	
	if ("all" in _flagSet) then {
		hashSet_rem(_flagSet,"all");
		_objList = all3DENEntities select 0;
	};
	if ("sel" in _flagSet) then {
		hashSet_rem(_flagSet,"sel");
		_objList = inspector_allSelectedObjects;	
	};
	if (count _objList == 0) exitWith {
		["Выбор невозможен - Список объектов пуст"] call showWarning;
	};
	
	private _isPropCheck = _selectType == "property";
	
	private _possibleObjectsWithVal = []; //for withval flag

	if (_isMulProp) then {
		private _classes = hashSet_createEmpty();
		{
			if ([_x] call golib_hasHashData) then {
				if (_isPropCheck) then {
					//у типа нет такого свойства
					if !((_paramMap get "property") in ([_x] call golib_getClassAllFields)) then {continue};
				};

				if ("withval" in _flagSet || "withanyval" in _flagSet) then {
					private _cprops = [_x] call golib_getCustomProps;
					private _prop = _paramMap get "property";
					if !(_prop in _cprops) then {continue};
					_possibleObjectsWithVal pushBack _x;
				};
				if ("withdefault" in _flagSet) then {
					private _cprops = [_x] call golib_getCustomProps;
					private _prop = _paramMap get "property";
					if (_prop in _cprops) then {continue};
					_possibleObjectsWithVal pushBack _x;
				};
				
				hashSet_add(_classes,(([_x] call golib_getClassName)));
			};
		} foreach _objList;
		if (count _classes <= 1) exitWith {};
		
		private _r = refcreate(0);
		private _descText = "Выберите основной тип для запроса объектов";
		if (_isPropCheck) then {
			_descText = format["Выберите основной тип для запроса объектов со свойством %1",_paramMap get "visibleName"];
		};
		if ([_r,"Выбор типа",_descText,
			["GameObject",{_this in _classes}] call widget_winapi_getTreeObject
		] call widget_winapi_openTreeView) then {
			_paramMap set ["class",refget(_r)];
		} else {
			_doExit = true;
		};
		
	};

	if (_doExit) exitWith {};

	if ("withval" in _flagSet) then {
		private _valSet = hashSet_createEmpty();
		private _prop = _paramMap get "property";
		{
			if ([_x] call golib_hasHashData) then {
				if !([
					[_x] call golib_getClassName, //дочерний тип
					_paramMap get "class" //родительский тип
				] call oop_isTypeOf) then {continue};

				private _cprops = [_x] call golib_getCustomProps;
				if (_prop in _cprops) then {
					hashSet_add(_valSet,_cprops get _prop);
				};
			};
		} foreach _possibleObjectsWithVal;
		["%1: possible values: %2",__FUNC__,count _valSet] call printTrace;
		if (count _valSet <= 0) exitWith {_doExit = true; ["Не найдено ни одного установленного значения"] call showError;};
		if (count _valSet == 1) exitWith {
			_paramMap set ["existValue",str (hashSet_toArray(_valSet) select 0)];
		};
		private _tdata = [];
		{
			_tdata pushback (format["%1:_noopt_",_x]);
		} foreach hashSet_toArray(_valSet);
		_tdata = _tdata joinString ";";

		call widget_winapi_resetLockTreeView;
		private _r = refcreate(0);
		private _descText = "Выберите подходящее значение свойства";
		if ([_r,"Выбор значения",_descText,
			_tdata
		] call widget_winapi_openTreeView) then {
			_paramMap set ["existValue",str refget(_r)];
			hashSet_add(_flagSet,"typeof");
		} else {
			_doExit = true;
		};
		
	};
	
	if (_doExit) exitWith {};


	private _newSelected = [];
	private _thisClass = _paramMap get "class";
	["%1: fact class checked %2",__FUNC__,_thisClass] call printTrace;

	private _canAdd = true;
	{
		if !([_x] call golib_hasHashData) then {continue};
		_canAdd = true;

		if ("classof" in _flagSet) then {
			//другой класс
			if (([_x] call golib_getClassName)!=_thisClass) then {continue};
		};
		if ("typeof" in _flagSet) then {
			//не наследник _thisClass
			if !([
				[_x] call golib_getClassName, //дочерний тип
				_thisClass //родительский тип
			] call oop_isTypeOf) then {continue};
		};
		if (_isPropCheck) then {
			//у типа нет такого свойства
			if !((_paramMap get "property") in ([_x] call golib_getClassAllFields)) then {continue};

			//сравнение значения
			if ("withval" in _flagSet) then {
				private _parammapval = _paramMap get "existValue";
				private _parname = _paramMap get "property";
				//системная ошибка
				if isNullVar(_parammapval) exitWith {
					["%1: existValue is null",__FUNC__] call printError;
					continue;
				};

				private _cprops = [_x] call golib_getCustomProps;
				//свойства нет в данных объекта
				if !(_parname in _cprops) exitWith {continue};
				private _strVal = str (_cprops get _parname);
				//значения не соответствуют
				["compare: <%1> <%2>",_strVal,_parammapval] call printTrace;
				if not_equals(_strVal,_parammapval) exitWith {continue};
			};

			//сравнение отсутствия значения
			if ("withdefault" in _flagSet) then {
				private _cprops = [_x] call golib_getCustomProps;
				private _parname = _paramMap get "property";
				//свойство зарегистрировано
				if (_parname in _cprops) exitWith {continue};	
			};

			//проверка наличия любого значения кроме дефолта
			if ("withanyval" in _flagSet) then {
				private _cprops = [_x] call golib_getCustomProps;
				private _parname = _paramMap get "property";
				//свойство отсутствует
				if !(_parname in _cprops) exitWith {continue};	
			};
		};

		if (_canAdd) then {
			_newSelected pushBack _x;
		};
	} foreach _objList;

	["%1: %2 objects selected",__FUNC__,count _newSelected] call printTrace;
	
	if (count _newSelected == 0) exitWith {};
	if ("deleteprop" in _flagSet) exitWith {
		["Удаление свойств", "Множественное удаление свойств объектов", "a3\3den\data\cfg3den\history\changeAttributes_ca.paa"] collect3DENHistory
		{
			private _parname = _paramMap get "property";
			{
				if !([_x] call golib_hasHashData) then {continue};
				private _hd = [_x,false] call golib_getHashData;
				(_hd get "customProps") deleteAt _parname;
				[_x,_hd] call golib_setHashData;

				if (_parname == "light") then {
					[_x] call lsim_reloadLightOnObject;
				};
				if (_parname == "model") then {
					_defmodel = ([[_x] call golib_getClassName,_parname,true] call oop_getFieldBaseValue);
					[_x,_defmodel] call golib_om_replaceObject;
				};
			} foreach _newSelected;
		};
	};
	[_newSelected,true] call golib_setSelectedObjects;
}