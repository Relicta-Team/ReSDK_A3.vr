// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

function(golib_internal_cleanupTreeSavedData)
{
	uinamespace setvariable [golib_internal_const_nameofTreeSaver,createHashMap];
}

function(golib_internal_expandAllTreeSavedData)
{
	call golib_internal_cleanupTreeSavedData;

	private _map = call golib_internal_getTreeSaverStorage;
	private _tree = call golib_vis_getTree;
	private _path = [];
	for "_i" from 0 to (_tree tvCount _path) do {
		[_tree,_path+[_i],_map] call golib_internal_expandTreeBranchRecursively;
	};
}

function(golib_internal_expandTreeBranchRecursively)
{
	params ["_tree","_path","_map"];
	private _curtext = _tree tvText _path;
	_map set [_curtext,_path];
	for "_i" from 0 to (_tree tvCount _path) do {
		[_tree,_path+[_i],_map] call golib_internal_expandTreeBranchRecursively;
	};
};

function(golib_internal_getTreeSaverStorage) { uinamespace getvariable golib_internal_const_nameofTreeSaver }

function(golib_internal_initTreeStateSaver)
{
	params ["_tree"];

	golib_internal_const_nameofTreeSaver = "resdk_internal_treeSaver";
	golib_internal_list_treeAllPathes = [];

	if isNull(uinamespace getvariable golib_internal_const_nameofTreeSaver) then {
		call golib_internal_cleanupTreeSavedData;
	};

	_tree ctrlAddEventHandler ["TreeExpanded",{
		params ["_tree","_path"];
		_map = call golib_internal_getTreeSaverStorage;
		_curname = _tree tvText _path;
		_map set [_curname,_path];
		//["Tree expanded %1 %3 (saved %2)",_path,_curname in _map,_curname] call printTrace;
	}];
	_tree ctrlAddEventHandler ["TreeCollapsed",{
		params ["_tree","_path"];
		_map = call golib_internal_getTreeSaverStorage;
		_curname = _tree tvText _path;
		_map deleteAt _curname;
		// TODO: при сворачивании ветки в _map могут храниться дочки.
		// Они не раскрываются при перезгрузке (иногда всё же бывает проблема)
		//! Нужно удалять из карты дочерние ветки для работы нативной логике дерева.
		//["Tree collapsed %1 %3 (saved %2)",_path,_curname in _map,_curname] call printTrace;
	}];
}

function(golib_vis_applyExpand)
{
	params ["_tree"];
	{
		_tree tvExpand _y;
	} foreach (call golib_internal_getTreeSaverStorage);
}

function(golib_vis_onCreateExpand)
{
	_d = getEdenDisplay;
	_gobutton = _d getVariable ["menu_internal_objlibWidget",widgetNull];
	if isNullReference(_gobutton) exitWith {
		["%1 - menu_internal_objlibWidget is null",__FUNC__] call printError;
	};
	(_gobutton call widgetGetPosition) params ["_x","_y","_w","_h"];
	_toggleRight = _d displayctrl 1034;
 	_toggleRight ctrlshow false;

	(_toggleRight call widgetGetPosition) params ["_xtog","_ytog"];

	if (cfg_gen_rightTabSize > 0) then {
		_w = cfg_gen_rightTabSize;
	};

	_ctg = [_d,WIDGETGROUP,
	[100-_w,_ytog,_w,100 -_ytog-_h]
	] call createWidget;
	_ctg setVariable ["defaultPoses",[100-_w,_ytog]];

	["golib_vis_ctg_bind",_ctg] call widget_bind;

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.1,0.1,0.1,.8];

	// Fix #347
	golib_vis_isEnteredInWidget = false;
	golib_vis_lastBeforeEnterMousePos = [0,0,0];

	_searchSizeH = 3;



	//search pic "a3\3den\data\displays\display3den\search_start_ca.paa"
		//for cleanup pic "a3\3den\data\displays\display3den\search_end_ca.paa"
	//collapse and expand pic
	//"a3\3den\data\displays\display3den\tree_collapse_ca.paa"
	//"a3\3den\data\displays\display3den\tree_expand_ca.paa"

	_sizeY = 0;

	//categoryes
	_catData = golib_vis_catData;
	_catSizeW = (100/(count _catData));
	_catSizeH = 3;
	for "_i" from 0 to (count _catData) - 1 do {
		_b = [_d,TEXT,[_catSizeW * _i,_sizeY,_catSizeW,_catSizeH],_ctg] call createWidget;
		[_b,format["<t align='center'>%1</t>",_catData select _i select 0]] call widgetSetText;
		_b ctrlAddEventHandler ["MouseButtonUp",_catData select _i select 1];
	};
	modvar(_sizeY) + _catSizeH;

	_search = [_d,"RscEdit",[2,_sizeY,70-2,_searchSizeH],_ctg] call createWidget;
	_search ctrlSetTooltip (
		"Доступные фильтры поиска\n\n"+
		"[name] - поиск по имени типа\n"+
		"typeof:[name] - поиск всех дочерних типов от [name] (без учёта регистра)\n"+
		"hasfield:[name] - поиск всех типов, имеющих поле [name] (без учёта регистра)\n"+
		"hasmethod:[name] - поиск всех типов, имеющих метод [name] (без учёта регистра)\n"+
		"\n\nРежимы могут быть скомбинированы через точку с запятой: Пример: typeof:GameObject;hasfield:name"
	);
	// _search ctrlAddEventHandler ["KillFocus",{
	// 	params ["_b"];
	// 	(ctrlText _b) call golib_vis_doSearchInLib;
	// }];
	_search ctrlAddEventHandler ["EditChanged",{
		params ["_b","_ntext"];
		if (_ntext== "") exitwith {
			call golib_vis_loadObjList;
		};
		(ctrlText _b) call golib_vis_doSearchInLib;
	}];
	

	_btH = _searchSizeH;
	_btW = 10;
	_searchButton = [_d,"RscActivePicture",[70,_sizeY,_btW,_btH],_ctg] call createWidget;
	_searchButton ctrlSetText "a3\3den\data\displays\display3den\search_start_ca.paa";
	_searchButton ctrlSetActiveColor  [0,1,0,1];
	_searchButton setVariable ["input",_search];
	_searchButton ctrlSetTooltip "ЛКМ - для поиска\nПКМ - очистить строку поиска";
	_searchButton ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b","_key"];
		_b = (_b getVariable "input");
		if (_key == MOUSE_LEFT) then {
			(ctrlText _b) call golib_vis_doSearchInLib;
		} else {
			_b ctrlSetText "";
			//выгрузка всей базы
			call golib_vis_loadObjList;
		};
	}];

	_searchButton = [_d,"RscActivePicture",[70+_btW,_sizeY,_btW,_btH],_ctg] call createWidget;
	_searchButton ctrlSetText "a3\3den\data\displays\display3den\tree_collapse_ca.paa";
	_searchButton ctrlSetActiveColor  [0,1,0,1];
	_searchButton ctrlSetTooltip "Свернуть все";
	_searchButton ctrlAddEventHandler ["MouseButtonUp",{tvCollapseAll (call golib_vis_getTree); call golib_internal_cleanupTreeSavedData}];

	_searchButton = [_d,"RscActivePicture",[70+_btW+_btW,_sizeY,_btW,_btH],_ctg] call createWidget;
	_searchButton ctrlSetText "a3\3den\data\displays\display3den\tree_expand_ca.paa";
	_searchButton ctrlSetActiveColor  [0,1,0,1];
	_searchButton ctrlSetTooltip "Развернуть все";
	_searchButton ctrlAddEventHandler ["MouseButtonUp",{tvExpandAll (call golib_vis_getTree); call golib_internal_expandAllTreeSavedData}];

	modvar(_sizeY) + _searchSizeH;

	_tree = [_d,"RscTree",[0,_sizeY+1,100,100-(_sizeY+1)],_ctg] call createWidget;
	/*for "_i" from 1 to 50 do {
		_tree tvAdd [[],"element " + str _i];
		_tree tvAdd [[0],"internal"];
	};*/
	golib_vis_widget_tree set [0,_tree];

	_tree ctrlAddEventHandler ["MouseButtonDown",golib_vis_ontreeMouseDown];
	_tree ctrlAddEventHandler ["MouseButtonUp",golib_vis_ontreeMouseUp];
	_tree ctrlAddEventHandler ["TreeMouseHold",golib_vis_ontreeMouseHold];
	_tree ctrlAddEventHandler ["TreeSelChanged",golib_vis_ontreeMouseHold];

	_tree ctrlAddEventHandler ["TreeMouseMove",golib_vis_ontreeMouseMoved];
	_tree ctrlAddEventHandler ["MouseEnter",golib_vis_ontreeMouseEnter];
	_tree ctrlAddEventHandler ["MouseExit",golib_vis_ontreeMouseExit];
	_tree ctrlAddEventHandler ["KeyUp",{
		params ["","_key","_shift","_ctrl","_alt"];
		if (_key == KEY_C && _ctrl) then {
			_cs = tvCurSel (call golib_vis_getTree);
			if (!call golib_vis_isMouseInsideTree) exitWith {};
			if not_equals(_cs,[]) then {
				private _classname = ([_cs,"class"] call golib_vis_getTreeItemProperty);
				[format["Имя '%1' скопировано в буфер обмена",_classname]] call showInfo;
				copytoclipboard _classname;
			};
		};
	}];

	[_tree] call golib_internal_initTreeStateSaver;

	[_d] call golib_vis_createLibPreviewer;
	["onFrame",golib_vis_onFrame_LibPreview] call  Core_addEventHandler;

	call golib_vis_libPreviewOnLeaveZone;

	_w = call menu_getButtonObjLib;
	_w ctrlAddEventHandler ["MouseButtonUp",golib_vis_onPressButtonObjLib];

	["onToggleRightPanelState",{
		params ["_hidden"];
		//["hidden %1",_hidden] call printTrace;
		if (!_hidden) then {
			[false] call golib_vis_onChangeRightPanelState;
		};
	}] call Core_addEventHandler;

	[(call nativePanels_isHiddenRight),true] call golib_vis_onChangeRightPanelState;

	golib_vis_handleUpdate = ["onFrame",golib_vis_onFrame] call Core_addEventHandler;
	
	call golib_vis_loadObjList;
}

function(golib_vis_onPressButtonObjLib)
{
	if (!golib_vis_isexpanded) then {
		if !(call nativePanels_isHiddenRight) then {
			call nativePanels_onToggleRight;
		};
	};

	[!golib_vis_isexpanded] call golib_vis_onChangeRightPanelState;
}

function(golib_vis_getTree) {golib_vis_widget_tree select 0}

//Если показывает правое меню то наша штука прячется
function(golib_vis_onChangeRightPanelState)
{
	params ["_showPanel",["_isInit",false]];

	_timeApplyPanel = ifcheck(_isInit,0,0.2);

	//Визуальная логика всегда должна быть установлена
	_wid = "golib_vis_ctg_bind" call widget_getBind;
	(_wid getVariable "defaultPoses") params ["_x","_y"];
	if (_showPanel) then {
		[_wid,[_x,_y],_timeApplyPanel] call widgetSetPositionOnly;
	} else {
		[_wid,[100,_y],_timeApplyPanel] call widgetSetPositionOnly;
	};

	if (_showPanel == golib_vis_isexpanded) exitWith {};
	golib_vis_isexpanded = _showPanel;

	//Полная перезапись - нахуй
	if (_showPanel) then {
		//call golib_vis_loadObjList;
	};
	//Опциональная проверка можно подгрузить что-то или сгенерировать карту объектов
}

function(golib_vis_isMouseInsideTree)
{
	("golib_vis_ctg_bind" call widget_getBind) call isMouseInsideWidget
}

function(golib_vis_isMouseInsideInspector)
{
	("inspector_ctg_main_bind" call widget_getBind) call isMouseInsideWidget
}

function(golib_vis_onFrame)
{
	if (golib_vis_isholdedLMB) then {
		if (!call golib_vis_isMouseInsideTree) then {
			_drag = "dragger_bind" call widget_getBind;
			[_drag,(call mouseGetPosition)vectorAdd[-10/2,-5]] call widgetSetPositionOnly;

			_backInspector = call golib_getArraySelectorBackground;
			if isNullReference(_backInspector) exitWith {};
			if (call golib_isInsideArraySelector) then {
				_backInspector setBackgroundColor [0.2,.7,.2,.9];
			} else {
				_backInspector setBackgroundColor [0.2,.2,.2,.9];
			};
		} else {
			[_drag,[100,100]] call widgetSetPositionOnly;
		};
		//["%1 - is inside %2",__FUNC__,call golib_vis_isMouseInsideTree] call printTrace;
	};
	golib_vis_isEnteredInWidget = call golib_vis_isMouseInsideTree || call golib_vis_isMouseInsideInspector;
	if (golib_vis_isEnteredInWidget) then {
		if equals(golib_vis_lastBeforeEnterMousePos,vec3(0,0,0)) then {
			golib_vis_lastBeforeEnterMousePos = getposasl get3dencamera;
		};
		move3DENCamera [golib_vis_lastBeforeEnterMousePos,!true];
	} else {
		if not_equals(golib_vis_lastBeforeEnterMousePos,vec3(0,0,0)) then {
			golib_vis_lastBeforeEnterMousePos = [0,0,0];
			//ctrlSetFocus (call MouseAreaGetWidget);
		};
	};
}

function(golib_vis_ontreeMouseDown)
{
	params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	if (_button == MOUSE_LEFT) then {
		_cs = golib_vis_treelastholdedPath;
		if not_equals(_cs,[]) then {
			_name = (call golib_vis_getTree) tvText _cs;
			
			//["tree lb down " + str(_name)] call showInfo;
			golib_vis_isholdedLMB = true;
			_drag = "dragger_bind" call widget_getBind;
			_drag setVariable ["lastClassName",[_cs,"class"] call golib_vis_getTreeItemProperty];
			[_drag,format["<t align='center'>%1</t>",_name]] call widgetSetText;
			_drag setBackgroundColor [0,0.8,0,0.5];
		};
		
	} else {
		//["tree rb down"] call showInfo;
		(call golib_vis_getTree) tvSetCurSel golib_vis_treelastholdedPath;
	}
}

function(golib_vis_ontreeMouseUp)
{
	params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	if (_button == MOUSE_LEFT) then {
		if (golib_vis_isholdedLMB) then {
			_drag = "dragger_bind" call widget_getBind;
			//["tree lb up"] call showInfo;
			golib_vis_isholdedLMB = false;
			[_drag,[100,100]] call widgetSetPositionOnly;

			_backInspector = call golib_getArraySelectorBackground;
			if !isNullReference(_backInspector) then {
				_backInspector setBackgroundColor [0.2,.2,.2,.9];
			};				

			private _isInsideContainerContent = call golib_isInsideArraySelector;
			if (_isInsideContainerContent) exitWith {
				[_drag getvariable "lastClassName"] call golib_onArraySelectorDragFromTree;
			};
			if (!call golib_vis_isMouseInsideTree) then {
				[_drag getVariable "lastClassName"] call golib_om_placeObjectAtMouse;
			};
		};

	} else {
		//["tree rb up"] call showInfo;
		_cs = tvCurSel (call golib_vis_getTree);
		if (!call golib_vis_isMouseInsideTree) exitWith {};
		if not_equals(_cs,[]) then {
			[[_cs,"class"] call golib_vis_getTreeItemProperty] call golib_vis_onPressSettingsObject;
		};
	}
}

function(golib_vis_ontreeMouseHold)
{
	params ["_tree","_path"];
	golib_vis_treelastholdedPath = _path;
}

function(golib_vis_ontreeMouseMoved)
{
	params ["_tree","_path"];
	[_path] call golib_vis_libPreviewUpdatePosition;
}

function(golib_vis_allocTreeItemProperty)
{
	params ["_type","_obj"];
	format["class:%1;",_obj getVariable "classname"]
}

function(golib_vis_getTreeItemProperty)
{
	params ["_path","_name"];
	private _data = (call golib_vis_getTree)tvData _path;
	private _dataList = _data splitString ";";
	private _namefact = _name + ":";
	private _idx = _dataList findIf {_namefact in _x};
	if (_idx==-1) exitWith {
		["%1 - Cant find property %2. Data was %3",__FUNC__,_name_,_data] call printError;
		""
	};
	((_dataList select _idx)splitString ":" ) select 1;
}

function(golib_vis_onPressSettingsObject)
{
	params ["_class"];
	/*
		Свернуть все дочерние уровни
		показать члены объекта
		создать
		создать копию

	*/
	/*[
		[
			["test 1" + _data,
				[
					["internal 1"],
					["internal 2"],
					["internal 3"],
					["internal 4",[
						["object"],
						["object"],
						["object"],
						["object"],
						["object"],
						["object"]
					]],
					["internal 5"],
					["internal 6"]
				]
			],
			["test some..."],
			["test 2",[["internal 3313"],
				["internal 31414",
				[
					["object"],
					["object"],
					["object",[["test"],["test"],["test"],["test"],["test"]]],
					["object"],
					["object"],
					["object"]
				]
				]
			]],
			["test 3",[["internal last"],["internal last"]]]
		],
		call mouseGetPosition
	] call contextMenu_create;*/
	
	[
		[
			["Отмена",{}],
			["Создать новый тип из "+_class,{["TODO implement (use virtual object)"] call showInfo}],
			["Выделить в сцене",
				[
					["Все объекты "+_class,{
						(call contextMenu_getContextParams) params ["_class"];
						[_class,{_x == _class}] call golib_selectObjectsBy;
					},null,"Выделяет все объекты типа "+_class],
					["Дочерние от "+_class,{
						(call contextMenu_getContextParams) params ["_class"];
						[_class,{
							_curItem = _x;
							(([_class,false] call oop_getinhlist) findif {_curItem == _x}) !=-1
						}] call golib_selectObjectsBy;
					},null,"Выделяет типы, унаследованные от "+_class],
					//! 2 тултипа не показываются изза прекрытия другой категорией
					//TODO исправить
					["Всех от "+_class,{
						(call contextMenu_getContextParams) params ["_class"];
						[_class,{
							_curItem = _x;
							(([_class,true] call oop_getinhlist) findif {_curItem == _x})!=-1
						}] call golib_selectObjectsBy;
					},null,"Выделяет все типы, унаследованные от "+_class+" (глубокое наследование)"],
					["Объекты "+_class + " и дочерние",{
						(call contextMenu_getContextParams) params ["_class"];
						[_class,{
							_curItem = _x;
							_x == _class || 
							(([_class,false] call oop_getinhlist) findif {_curItem == _x})!=-1
						}] call golib_selectObjectsBy;
					},null,"Выделяет типы "+_class+", и унаследованные от "+_class],
					["Объекты "+_class + " и всех наследн.",{
						(call contextMenu_getContextParams) params ["_class"];
						[_class,{[_x,_class] call oop_isTypeOf}] call golib_selectObjectsBy;
					},null,"Выделяет все типы, которые являются типами "+_class+" или наследниками от "+_class]
				]
			],
			["Подробная информация о типе",{}],
			["Файлы",
				[
					["Перейти к определению",{
						(call contextMenu_getContextParams) params ["_class"];
						_type = missionNamespace getVariable ["pt_"+_class,nullPtr];
						if !isNullReference(_type) then {
							(_type getVariable ["__decl_info__",["NULL","NULL"]])params ["_file","_line"];
							//[format["%1 определен в '%2' на линии %3",_class,_file,_line],10] call showInfo;

							["WorkspaceHelper","gotoclass",[_file,_line],true] call rescript_callCommand;
						};
					}],
					["Открыть папку хранения файла",{
						(call contextMenu_getContextParams) params ["_class"];
						_type = missionNamespace getVariable ["pt_"+_class,nullPtr];
						if !isNullReference(_type) then {
							(_type getVariable ["__decl_info__",["NULL","NULL"]])params ["_file","_line"];

							["WorkspaceHelper","openfolder",[_file,_line,"with_select"],true] call rescript_callCommand;
						};
						
					}]
				]
			]
		],
		call mouseGetPosition,
		[_class]
	] call contextMenu_create;
}


function(golib_vis_loadObjectList_Recursive)
{
	params ["_type","_listRef","_condAdd"];
	
	if (!goasm_isbuilded) exitWith {
		["%1 - game objects assembly not builded; Type: %2",__FUNC__,_type] call printError;
	};
	
	//Добавляем этот объект в трею
	//GameObject __childList
	private _tobj = missionNamespace getVariable ["pt_"+_type,nullPtr];
	if isNullReference(_tObj) exitWith {
		["%1 - null reference for type %2",__FUNC__,_type] call printError;
	};
	
	if ([_type,"HiddenClass"] call goasm_attributes_hasAttributeClass && !("objlib_showHiddenClasses" call core_settings_getValue)) then {
		_hiddenValues = ([_type,"Class","HiddenClass"] call goasm_attributes_getValues);
		if ("allChild" in _hiddenValues) exitWith {};

		{
			[_x,_listRef,_condAdd] call golib_vis_loadObjectList_Recursive;
		} foreach (_tobj getVariable "__childList");
		
	} else {
		
		if (call _condAdd) then {
			private _tree = call golib_vis_getTree;
			private _idx = _tree tvAdd [_listRef,_tobj getVariable "classname"];
			_listRef = _listRef + [_idx];
			
			if ([_type,"ColorClass"] call goasm_attributes_hasAttributeClass) then {
				_color = ([_type,"Class","ColorClass"] call goasm_attributes_getValues) select 0;
				_tree tvSetColor [_listRef,[_color] call color_HTMLtoRGBA];
			};
			if ([_type,"InterfaceClass"] call goasm_attributes_hasAttributeClass) then {
				_tree tvSetColor [_listRef,[.7,0.7,0.5,.8]];
			};
			_tree tvSetData [_listRef,[_type,_tobj] call golib_vis_allocTreeItemProperty];
			//_tobj getVariable "__decl_info__"
			private _ttp = if (gm_isInsideModemanager) then {
				format["%1",([_type,"__decl_info__"] call oop_getTypeValue) joinString " at "]
			} else {
				format["Имя:%1\nОписание: %2",
					[_type,"name",false,"getName"] call oop_getFieldBaseValue,
					[_type,"desc",false,"getDesc"] call oop_getFieldBaseValue
				]
			};
			_tree tvSetTooltip [_listRef,_ttp];
		};
			
		{
			[_x,_listRef,_condAdd] call golib_vis_loadObjectList_Recursive;
		} foreach (_tobj getVariable "__childList");
	};
	

}

function(golib_vis_loadObjList)
{
	
	private _conditionAdd = if isNullVar(_golib_global_flag_search) then { {true} } else {_golib_global_flag_search};
	
	tvClear (call golib_vis_getTree);
	golib_internal_list_treeAllPathes = [];

	private _startPath = "GameObject";
	if (gm_isInsideModemanager) then {
		_startPath = "object";
		_conditionAdd = compile ((toString _conditionAdd) + " && " + ("!('managedobject' in (_tobj getVariable '__inhlist_map'))"));
	};

	[_startPath,[],_conditionAdd] call golib_vis_loadObjectList_Recursive;

	(call golib_vis_getTree) tvSortAll [[], false];
	
	(call golib_vis_getTree) call golib_vis_applyExpand;
	//["pressed load objs"] call showInfo;
}

function(golib_vis_loadTemplatesList)
{
	//["pressed load templates"] call showInfo;
}


function(golib_vis_doSearchInLib)
{
	private _serachText = _this;
	_nocall = {
		"Доступные режимы поиска\n\n"+
		"[name] - поиск по имени типа\n"+
		"typeof:[name] - поиск всех дочерних типов от [name] (без учёта регистра)\n"+
		"hasfield:[name] - поиск всех типов, имеющих поле [name] (без учёта регистра)\n"+
		"hasmethod:[name] - поиск всех типов, имеющих метод [name] (без учёта регистра)\n"+
		"\n\nРежимы могут быть скомбинированы через точку с запятой: Пример: typeof:GameObject;hasfield:name"
	};

	private _tokens = (_serachText splitString ";");
	//Можно использовать _tobj - ссылка типа, _type - строка типа
	private _conditions = [];
	
	{
		call {
			if ("typeof:" in _x) exitWith {
				_conditions pushBack (format["'%1' in (_tobj getVariable '__inhlist_map')",tolower(_x splitString ";: " select 1)]);
			};
			if ("hasfield:" in _x) exitWith {
				_conditions pushBack (format["'%1' in (_tobj getVariable '__allfields_map')",tolower(_x splitString ";: " select 1)]);
			};
			if ("hasmethod:" in _x) exitWith {
				_conditions pushBack (format["'%1' in (_tobj getVariable '__allmethods')",tolower(_x splitString ";: " select 1)]);
			};
			
			_conditions pushBack (format["'%1' in (tolower _type)",tolower _x]);
		};
	} foreach _tokens;
	
	private _condCode = null;
	if (count _conditions > 0) then {
		_condCode = compile (_conditions joinString " && ");
	};
	
	["search pattern %1",_condCode] call printTrace;
	
	private _golib_global_flag_search = _condCode;
	call golib_vis_loadObjList;
	//_condCode
}


function(golib_vis_resetLockNativeCamera)
{
	get3DENCamera campreparetarget objnull;
	get3DENCamera camcommitprepared 0;
}

function(golib_vis_lockNativeCamera)
{
	get3DENCamera campreparetarget _this;
	get3DENCamera camcommitprepared 0;
}

function(golib_vis_isNativeCameraLockedOnObject)
{
	!isNullReference(camTarget get3DENCamera)
}

function(golib_vis_switchLockCameraOnSelected)
{
	private _isLocked = call golib_vis_isNativeCameraLockedOnObject;
	if (_isLocked) then {
		call golib_vis_resetLockNativeCamera;
	} else {
		private _obList = call golib_getSelectedObjects;
		if (count _obList == 0) exitWith {
			["Не выбран ни один объект"] call showWarning;
		};
		(_obList select 0) call golib_vis_lockNativeCamera;
	};
}

function(golib_vis_jumpToObjects)
{
	[_this] call golib_setSelectedObjects;
	call golib_vis_jumpToSelected;
}

function(golib_vis_jumpToSelected)
{
	//_pos = [];

	private _obList = call golib_getSelectedObjects;
	if (count _obList == 0) exitWith {};

	private _oSel = _obList select 0;
	private _newPos = getposatl _oSel;
	private _bbx = boundingBoxReal _oSel;
	private _actPos = atltoasl  (_newPos vectorAdd [0,(abs(_bbx select 1 select 1)) * 2,(abs(_bbx select 1 select 2)) * 3]);
	["%3 :: %1 %2",_newPos,_bbx,_actPos] call printTrace;
	move3DENCamera [_actPos,!true];

	// _cam = get3dencamera;
	// _cam campreparetarget _oSel;
	// _cam campreparefocus [-1,-1];
	// _cam campreparefov 0.7;
	// _cam camcommitprepared 0;

	//rotate cam
	// private _a = positionCameraToWorld [0,0,0] vectorFromTo (_actPos);
	// private _y = asin(_a select 0);
	// private _b = [_a,_y] call BIS_fnc_rotateVector2D;
	// private _z = _b select 2;
	// private _p = asin(_z / sqrt((_b select 1)^2 + _z^2));
	// get3DENCamera setVectorDirAndUp [
	// 	_a,
	//  [ [0,-sin _p,cos _p],-_y] call BIS_fnc_rotateVector2D
	// ];

	// if (
	// count menuhover (finddisplay 					313 displayctrl 			120 ) == 0
	// &&
	// {{count _x > 0} count (get3DENSelected "" + [get3DENSelected "Comment",get3DENSelected "Layer"]) == 0}
	// ) then {
	// _pos = if (get3denactionstate "togglemap" > 0) then {
	// (finddisplay 					313 displayctrl 				51) ctrlmapscreentoworld getmouseposition;
	// } else {
	// screentoworld getmouseposition;
	// };
	// //_pos set [2,(_pos param [2,0]) + getterrainheightasl _pos];
	// };


	// {
	// _pos = (_x get3DENAttribute "position") select 0;
	// } foreach (get3DENSelected "Comment");


	// //scopename "selected";
	// _fnc_getLayerEntities = {
	// {
	// if (_x isequaltype 0) then {
	// _x call _fnc_getLayerEntities;
	// } else {
	// _pos = (_x get3DENAttribute "position") select 0;
	// if (count _pos > 0) then {_pos set [2,(_pos param [2,0]) + getterrainheightasl _pos];};
	// breakto "golib_vis_jumpToSelected";
	// };
	// } foreach get3DENLayerEntities _this;
	// };
	// {
	// _x call _fnc_getLayerEntities;
	// } foreach (get3DENSelected "Layer");


	// {
	// if (count _x > 0) then {
	// _pos = ((_x select 0) get3DENAttribute "position") select 0;
	// if (count _pos > 0) then {_pos set [2,(_pos param [2,0]) + (boundingBoxReal (_x select 0) select 1 select 2)];};
	// };
	// } foreach (get3DENSelected "");


	// if (count _pos > 0) then {
	// move3DENCamera [_pos,!true];
	//};
}

//создает объект предпросмотра (модель и описание)
function(golib_vis_createLibPreviewer)
{
	params ["_d"];

	private _sizeH = 20;
	private _sizeW = transformSizeByAR(_sizeH);
	private _ctg = [_d,WIDGETGROUP,[50,50,_sizeW,_sizeH]] call createWidget;
	["golib_vis_libPreviewCtg_bind",_ctg] call widget_bind;

	private _b = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_b setBackgroundColor [0,0,0,0];
	_ctg setvariable ["back",_b];

	_b = [_d,BACKGROUND,[0,0,100,3],_ctg] call createWidget;
	_b setBackgroundColor [0.2,.2,.2,.9];
	_b = [_d,BACKGROUND,[0,0,3,100],_ctg] call createWidget;
	_b setBackgroundColor [0.2,.2,.2,.9];

	_b = [_d,BACKGROUND,[0,100-3,100,3],_ctg] call createWidget;
	_b setBackgroundColor [0.2,.2,.2,.9];

	

	_b = [_d,TEXT,[0,80,100,20],_ctg] call createWidget;
	_ctg setvariable ["text",_b];
	[_b,"Object name"] call widgetSetText;
	
	//before cleanup all objects
	private _obj = if isNull(_d getvariable "__golib_vis_internal_3dobject_preview") then {
		private _o = _d ctrlCreate ["RscObject",-1,_ctg];
		_d setvariable ["__golib_vis_internal_3dobject_preview",_o];
		_o;
	} else {
		_d getvariable "__golib_vis_internal_3dobject_preview";
	};

	_ctg setvariable ["model",_obj];
	
}

function(golib_vis_syncLibPreview)
{
	params ["_wid"];
	private _obj = _wid getvariable "model";
	private _scale = 1 / (getResolution select 5); // keep object the same size for any interface size
	private _distance = 15 * 4/3;
	if ((getResolution select 4) < (4/3)) then { _distance = _distance * (getResolution select 7); }; // eg 5x4
	private _base = ["3d", [
		(ctrlPosition _wid) select 0,
		(ctrlPosition _wid) select 1,
		_distance
	], _scale] call widgetModel_objectHelper;
	_base = [((ctrlPosition _wid) select 0) + (
		((ctrlPosition _wid) select 2)/2
	),
		((core_modelBBX getOrDefault [ctrlModel _obj,[0,0,1]]) select 2) * (_base select 1), 
		//_base select 1,
	((ctrlPosition _wid) select 1) + (
		((ctrlPosition _wid) select 3)/2
	)];
	
	_obj ctrlSetPosition _base;
	_obj ctrlSetModelScale _scale;
	_obj ctrlSetModelDirAndUp (([60,75,0] call model_convertPithBankYawToVec));

	_obj ctrlSetFadE rand(0.2,0.5);
	_obj ctrlCommit 0;
}

function(golib_vis_onFrame_LibPreview)
{
	golib_vis_isInsideLibPreview = ("golib_vis_ctg_bind" call widget_getBind) call isMouseInsideWidget;
	if (!golib_vis_isInsideLibPreview ) then {
		call golib_vis_libPreviewOnLeaveZone;
	};
}

function(golib_vis_libPreviewOnLeaveZone)
{
	_ctg = "golib_vis_libPreviewCtg_bind" call widget_getBind;
	_model = _ctg getvariable "model";

	//already setup
	if (ctrlPosition _model select 0 == -100) exitWith {};

	[_ctg,[-100,-100]] call widgetSetPositionOnly;
	_model ctrlSetPosition [-100,-100,0];
}

function(golib_vis_libPreviewUpdatePosition)
{
	params ["_path"];
	if (count _path == 0 || gm_isInsideModemanager) exitwith {};
	

	_ctg = "golib_vis_libPreviewCtg_bind" call widget_getBind;
	_model = _ctg getvariable "model";
	_text = _ctg getvariable "text";
	_back = _ctg getvariable "back";
	
	(_ctg call widgetGetPosition)params["_srcX","_srcY","_srcW","_srcH"];
	(("golib_vis_ctg_bind" call widget_getBind) call widgetGetPosition) params ["_lvX","_lvY","_lvW","_lvH"];
	(call mouseGetPosition)params["_posX","_posY"];


	[_ctg,[_lvX-_srcW,clamp(_posY-(_srcH/2),0,100-_srcH)]] call widgetSetPositionOnly;

	private _class = [_path,"class"] call golib_vis_getTreeItemProperty;
	private _modelPath = [_class,"model",true] call oop_getFieldBaseValue;
	
	private _nameOf = [_class,"name",true,getName] call oop_getFieldBaseValue;
	if isNullVar(_nameOf) then {_nameOf = _class};
	private _hasModelPath = !isNullVar(_modelPath);
	
	if (_hasModelPath && {!(".p3d" in _modelPath)}) then {
		_modelPath = gettext(configFile >> "CfgVehicles" >> _modelPath >> "model" );
	};
	
	if (!_hasModelPath) then {
		_modelPath = "";
		_nameOf = "NULL";
	};

	_texBack = [0,0,0,0];
	if (_modelPath == "") then {
		_modelPath = "\A3\Weapons_f\dummyweapon.p3d";
		_texBack = [1,0,0,0.4];
		_nameOf = "(err_model) " + _nameOf;
	};

	if (_modelPath select [0,1] != "\") then {
		_modelPath = "\"+_modelPath;
	};
	
	[_text,format["<t align='center'>%1</t>",_nameOf]] call widgetSetText;
	(_back) setBackgroundColor _texBack;
	_model ctrlSetModel _modelPath;
	[_ctg] call golib_vis_syncLibPreview;
};

function(golib_vis_ontreeMouseEnter)
{
	params ["_tree"];
}

function(golib_vis_ontreeMouseExit)
{
	params ["_tree"];
	
}