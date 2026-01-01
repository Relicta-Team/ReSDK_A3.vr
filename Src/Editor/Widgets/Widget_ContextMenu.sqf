// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(contextMenu_isOpened) {
	private _d = call contextMenu_getDisplay;
	!isNullReference(_d) && {!isNull(_d getvariable "contextCTG")}
};

function(contextMenu_getDisplay)
{
	displayChild getEdenDisplay
}

function(contextMenu_getContextParams)
{
	if !(call contextMenu_isOpened) exitWith {
		["%1 - context menu not opened...",__FUNC__] call printError;
		[]
	};
	(call contextMenu_getDisplay) getVariable ["_ctx",[]];
}

/*
	//vec2: name, [code | list] ,["_condToVisible",{true}],["_desc",""]
	[
		[
			["menu item 1",{}],
			["menu item 2",{}]
			["menu extended",
				[
					["menu internal 1",{}],
					["menu internal 2",{}],
				]
			]
		]
		call mouseGetPosition
	] call contextMenu_create;
*/
function(contextMenu_create) {
	params ["_elements",["_posBase",call mouseGetPosition],["_ctx",[]]];

	if (call contextMenu_isOpened) exitwith {setLastError(__FUNC__ + " - Context menu already opened.")};

	ContextMenu_internal_openedMousePos = call mouseGetPosition;
	ContextMenu_internal_openedMousePosNative = getMousePosition;

	private _d = getEdenDisplay createDisplay "RscDisplayEmpty";
	{_x ctrlShow false} foreach (allControls _d);
	
	//Старая-добрая копипаста из displayOpen
	_d displayAddEventHandler [
		"keyDown",
		{
			params ["_obj","_key","_shift","_ctrl","_alt"];
			
			if (_key == KEY_HOME && _shift && cfg_debug_devMode) then {nextFrameParams({(_this select 0) closeDisplay 1},[_obj])};
			if (_key == KEY_ESCAPE) then {true;} else {false;}
		}
	];

	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;

	_d setVariable ["contextCTG",_ctg];
	_d setVariable ["_ctx",_ctx];
	
	widget_internal_contextmenu_tree = [];
	
	[_elements,_posBase,0] call contextMenu_internal_loadContext;
};

function(contextMenu_internal_loadContext)
{
	params ["_elements","_pointStart","_level","_pressedWidget"];

	private _sizeX = 15;
	private _sizeY = 4;

	_pointStart params ["_posX","_posY"];

	_posX = clamp(_posX,0,100-_sizeX);
	_posY = clamp(_posY,0,100-((count _elements))*_sizeY);

	private _back = [_d,BACKGROUND,[_posX,_posY,_sizeX,((count _elements))*_sizeY],_ctg] call createWidget;
	_back setBackgroundColor [.2,.2,.2,0.9];
	_back ctrlEnable false;
	_back setVariable ["level",_level];
	private _backItems = [];
	_back setVariable ["items",_backItems];
	if (_level > 0) then {
		_back setFade 1;
		_back commit 0;
		_back setVariable ["pressedRoot",_pressedWidget];
		_pressedWidget setVariable ["childBack",_back];
	};
	

	
	for "_i" from 0 to (count _elements) - 1 do {
		(_elements select _i) params ["_name",["_includedListOrAction",{}],["_condToVisible",{true}],["_desc",""]];
		private _w = [_d,TEXT,[_posX,_posY + (_i*_sizeY)+0.5,_sizeX,_sizeY-1],_ctg] call createWidget;
		_w ctrlSetTooltip _desc;
		_w setVariable ["level",_level];
		_w setVariable ["back",_back];
		_w setVariable ["index",_i];
		_backItems pushBack _w;
		_w setBackgroundColor widget_internal_contextmenu_exitcolor;
		
		private _canVisible = call _condToVisible;
		if !(_canVisible) then {
			_w ctrlEnable false;
			_w setBackgroundColor (widget_internal_contextmenu_exitcolor apply {(_x - 0.5)max 0});
		};

		if (_canVisible) then {
			_w ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor widget_internal_contextmenu_entercolor}];
			_w ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor widget_internal_contextmenu_exitcolor}];
		};

		if (_level > 0) then {
			_w setFade 1;
			_w commit 0;
			_w ctrlEnable false;
		};
		
		if equalTypes(_includedListOrAction,[]) then {
			modvar(_name) + "<t align='right' size='1.3'>+"+sgt+"</t>";
			_w setvariable ["enabled__",_canVisible];
			_w ctrlAddEventHandler ["MouseButtonUp",{
				if !((_this select 0) getvariable "enabled__") exitwith {};

				_nextBack = ((_this select 0) getVariable "childBack");
				_curBack = (_this select 0) getVariable "back";
				//Если в древе нет текущего бэка то скрываем всю ветку и чистим её
				//В противном же случае чистим до определенного индекса
				private _idx = widget_internal_contextmenu_tree find _curBack;
				if (_idx != -1) then {
					if (_idx == (count widget_internal_contextmenu_tree - 1)) then {
						//["noresized %1",widget_internal_contextmenu_tree apply {_x getVariable "level"}] call printTrace;
					} else {
						//["cursize %1. rem at %2",widget_internal_contextmenu_tree apply {_x getVariable "level"},_idx] call printTrace;
						//берем последние элементы (_idx+1) и скрываем.
						_selection = widget_internal_contextmenu_tree select [_idx+1,count widget_internal_contextmenu_tree - 1];
						{
							[_x] call contextMenu_internal_hideCat;
							widget_internal_contextmenu_tree deleteAt (widget_internal_contextmenu_tree find _x);
						} foreach _selection;
						//widget_internal_contextmenu_tree resize ((count widget_internal_contextmenu_tree)-_idx);
						//["new size %1",widget_internal_contextmenu_tree apply {_x getVariable "level"}] call printTrace;
					};
					
					
				} else {
					//["no find %1",widget_internal_contextmenu_tree apply {_x getVariable "level"}] call printTrace;
					{
						[_x] call contextMenu_internal_hideCat;
					} foreach widget_internal_contextmenu_tree;
					widget_internal_contextmenu_tree = [];
					//[_curBack] call contextMenu_internal_hideCat;
				};
				
				[_nextBack] call contextMenu_internal_showCat;
				widget_internal_contextmenu_tree pushBack _nextBack; 
			}];
			
		};
		if (!_canVisible) then {
			_name = "<t color='#5E5E5E'>"+_name+"</t>";
		};
		[_w,format["<t align='center'>%1</t>",_name]] call widgetSetText;
		if (_name == "") then {
			_w ctrlEnable false;
		};
		
		if equalTypes(_includedListOrAction,[]) then {
			if (count _includedListOrAction > 0) then {
				private _miniOfs = 0.5;
				private _addOffset = if (_posX+_sizeX+_miniOfs>=(100-_sizeX)) then {-_sizeX-_miniOfs} else {_sizeX+_miniOfs};
				[_includedListOrAction,[_posX + _addOffset,_posY+(_i*_sizeY)],_level + 1,_w] call contextMenu_internal_loadContext;
			};
		} else {
			
			_w setVariable ["_action",_includedListOrAction];
			_w setvariable ["enabled__",_canVisible];
			_w ctrlAddEventHandler ["MouseButtonUp",{
				["enabled action %1",(_this select 0) getvariable "enabled__"] call printTrace;
				if !((_this select 0) getvariable "enabled__") exitwith {};
				_c = {
					_buttonContext = _this select 0;
					_nameContext = sanitizeHTML(ctrlText _buttonContext);
					_indexContext = _buttonContext getVariable "index";
					_levelContext = _buttonContext getVariable "level";
					call (_buttonContext getVariable "_action");
				};

				nextFrameParams(_c,_this);
				nextFrame({(call contextMenu_getDisplay) closeDisplay 0;});
				
			}];
		};
		

	};
}

function(contextMenu_internal_hideCat)
{
	params ["_back"];
	_back setFade 1;
	_back commit 0.2;
	{
		_x setFade 1;
		_x commit 0.1;
		_x ctrlEnable false;
	} foreach (_back getVariable "items");
}

function(contextMenu_internal_showCat)
{
	params ["_back"];
	_back setFade 0;
	_back commit 0.1;
	{
		_x setFade 0;
		_x commit 0.2;
		_x ctrlEnable true;
	} foreach (_back getVariable "items");
}

function(ContextMenu_loadMouseObjectList)
{
	params ["_objList"];

	_stackMenu = [["Отмена",{}]];
	["Context selected object count %1",count _objList] call printTrace;
	private _ctxParams = [_objList];

	private _energyListIs = _objList apply {_x call golib_en_obj_isEnergyObject};
	if (any_of(_energyListIs)) then {
		_stackMenu pushBack [
			format["Подключить %1 к источнику",{_x} count _energyListIs],
			{
				["Нажмите ЛКМ чтобы связать объект, ПКМ + Ctrl для отмены"] call showInfo;
				private _possibleObjects = (call contextMenu_getContextParams) select 0;
				{
					if (!(_x call golib_en_obj_isEnergyObject)) then {_possibleObjects set [_foreachIndex,objNull]};
				} foreach _possibleObjects;
				_possibleObjects = _possibleObjects - [objNull];
				contextMenu_internal_energy_connectorList = _possibleObjects;
			}
		]
	};



	[
		_stackMenu,
		call mouseGetPosition,
		_ctxParams
	] call contextMenu_create;

}

function(ContextMenu_loadMouseObject)
{
	
	private _obj = objNull;
	private _hasObject = false;
	
	//second check 
	
	_screenToWorldPos = screenToWorld getMousePosition;
	([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR"];
	if !isNullReference(_objR) then {
		_obj = _objR;
		_hasObject = true;
	};
	
	private _sel = get3DENMouseOver;
	if (count _sel == 2 && {(_sel select 0) == "Object"}) then {
		private _checkObj = _sel select 1;
		if isNullReference(_checkObj) exitwith {};
		
		private _isNoGeom = ((allLods _checkObj) findif {_x select 1 == "geometry"})==-1;
		
		if isNullReference(_obj) exitwith {_obj = _checkObj; _hasObject = true};
		
		//get3DENCamera distance to targets check
		if (_isNoGeom) then {
			_obj = _checkObj;
			_hasObject = true;
		};
	};

	_stackMenu = [["Отмена",{}]];
	["Context selected object %1",_obj] call printTrace;
	private _ctxParams = [_obj];


	private _commonSimStart = {
		_stackMenu pushBack ["Запустить симуляцию отсюда",[
			["Запуск",{
				_obj = (call contextMenu_getContextParams) select 0;
				_screenToWorldPos = screenToWorld ContextMenu_internal_openedMousePosNative;
				([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
				if equals(_atlPos,vec3(0,0,0)) then {_atlPos = getposatl get3DENCamera};
				// if not_equals(_obj,_objR) then {
				// 	["Несоответствие точки старта симуляции."] call printWarning;
				// 	["Object1: %1; Object2: %2",_obj,_objR] call printTrace;
				// };

				private _params = [false,true];
				sim_internal_lastCachedTransform = [_atlPos,getDir get3DENCamera];
				nextFrameParams(sim_openMapSelector,_params);
			}],
			["С выбранным снаряжением роли",{
				_obj = (call contextMenu_getContextParams) select 0;
				_screenToWorldPos = screenToWorld ContextMenu_internal_openedMousePosNative;
				([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
				if equals(_atlPos,vec3(0,0,0)) then {_atlPos = getposatl get3DENCamera};

				sim_internal_lastCachedTransform = [_atlPos,getDir get3DENCamera];
				_allRoles = [];
				_uniqueRoles = [];

				{
					if ([_x,"InterfaceClass"] call goasm_attributes_hasAttributeClass
						|| [_x,"HiddenClass"] call goasm_attributes_hasAttributeClass
					) then {continue};
					private _curGamemode = [_x,"classname"] call oop_getTypeValue;
					private _roles = ([_curGamemode,"",true,"getLobbyRoles"] call oop_getFieldBaseValue) 
						+ ([_curGamemode,"",true,"getLateRoles"] call oop_getFieldBaseValue);
						
						//fix #294
						if (count _roles == 1 && {(_roles select 0) == "___SCRITED_GAMEMODE___"}) then {
							_roles = [_curGamemode,"",true,"_getRolesWrapper"] call oop_getFieldBaseValue;
						};

						{
							if !array_exists(_uniqueRoles,_x) then {
								_uniqueRoles pushBack _x;
								_allRoles pushBack [
									format["%1 (%2) с режима %3",
										[_x,"name",true] call oop_getFieldBaseValue,
										_x,
										_curGamemode
									]
									,_x
								]
							};
							
						} foreach _roles;
					
					_allRoles pushBack ["---",control_const_listElementNoExitAtSelect];
				} foreach (call gm_getAllGamemodeObjects);

				[
					_allRoles,
					//event on select
					{
						if equals(control_const_listElementNoExitAtSelect,_data) exitWith {};
						_curRoleName = _data;

						["lastContextStartupRole",_curRoleName] call Core_setSessionPlatformCachedValue;
						["currentRoleEquip",_curRoleName] call sim_addSDKProp;
						private _params = [false,true];
						nextFrameParams(sim_openMapSelector,_params);
					},
					{
						
					},
					null,
					"Выберите снаряжение роли"
				] call control_createList;
				
			},null,"Открывает окно выбора роли, от которой будет выдано снаряжение"],
			["С последней выбранной ролью",{
				private _lastrole = ["lastContextStartupRole"] call Core_getSessionPlatformCachedValue;
				if isNullVar(_lastrole) exitwith {
					["Вы ещё не запускали симуляцию через пункт ""С выбранным снаряжением роли"". Выберите роль и пункт станет активным.",10] call showError;
				};
				["currentRoleEquip",["lastContextStartupRole"] call Core_getSessionPlatformCachedValue] call sim_addSDKProp;

				_obj = (call contextMenu_getContextParams) select 0;
				_screenToWorldPos = screenToWorld ContextMenu_internal_openedMousePosNative;
				([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
				if equals(_atlPos,vec3(0,0,0)) then {_atlPos = getposatl get3DENCamera};

				private _params = [false,true];
				sim_internal_lastCachedTransform = [_atlPos,getDir get3DENCamera];
				nextFrameParams(sim_openMapSelector,_params);
			},{!isNull(["lastContextStartupRole"] call Core_getSessionPlatformCachedValue)}]
		]
	];
	};
	private _commonCheckDistance = {
		_stackMenu pushBack ["Измерить расстояние",{
			_obj = (call contextMenu_getContextParams) select 0;
			_screenToWorldPos = screenToWorld ContextMenu_internal_openedMousePosNative;
			([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
			if equals(_atlPos,vec3(0,0,0)) then {_atlPos = _screenToWorldPos};
			[_atlPos] call meterTool_onActivate;
		}];
	};

	private _commonSelectQuery = {
		_stackMenu pushBack ["Выбрать в сцене",
			[
				["Все объекты "+_class,{
					_class = [(call contextMenu_getContextParams) select 0] call golib_getClassName;
					[_class,{_x == _class}] call golib_selectObjectsBy;
				},null,"Выделяет все объекты типа "+_class],
				["Дочерние от "+_class,{
					_class = [(call contextMenu_getContextParams) select 0] call golib_getClassName;
					[_class,{
						_curItem = _x;
						(([_class,false] call oop_getinhlist) findif {_curItem == _x}) !=-1
					}] call golib_selectObjectsBy;
				},null,"Выделяет типы, унаследованные от "+_class],
				["Всех от "+_class,{
					_class = [(call contextMenu_getContextParams) select 0] call golib_getClassName;
					[_class,{
						_curItem = _x;
						(([_class,true] call oop_getinhlist) findif {_curItem == _x})!=-1
					}] call golib_selectObjectsBy;
				},null,"Выделяет все типы, унаследованные от "+_class+" (глубокое наследование)"],
				["Объекты "+_class + " и дочерние",{
					_class = [(call contextMenu_getContextParams) select 0] call golib_getClassName;
					[_class,{
						_curItem = _x;
						_x == _class || 
						(([_class,false] call oop_getinhlist) findif {_curItem == _x})!=-1
					}] call golib_selectObjectsBy;
				},null,"Выделяет типы "+_class+", и унаследованные от "+_class],
				["Объекты "+_class + " и всех наследн.",{
					_class = [(call contextMenu_getContextParams) select 0] call golib_getClassName;
					[_class,{[_x,_class] call oop_isTypeOf}] call golib_selectObjectsBy;
				},null,"Выделяет все типы, которые являются типами "+_class+" или наследниками от "+_class]
			]
		]
	};
	
	//context menu for debug mob
	if ([_obj] call ContextMenu_isDebugMob) exitWith {
		call _commonCheckDistance;

		_stackMenu pushBack [
			"Манекен стоит",
			{
				_obj = (call contextMenu_getContextParams) select 0;
				_obj set3DENAttribute ["unitPos",0];
			}
		];
		_stackMenu pushBack [
			"Манекен сидит",
			{
				_obj = (call contextMenu_getContextParams) select 0;
				_obj set3DENAttribute ["unitPos",1];
			}
		];
		_stackMenu pushBack [
			"Манекен лежит",
			{
				_obj = (call contextMenu_getContextParams) select 0;
				_obj set3DENAttribute ["unitPos",2];
			}
		];

		[
			_stackMenu,
			call mouseGetPosition,
			_ctxParams
		] call contextMenu_create;
	};

	if (!_hasObject) exitwith {};
	
	if !(_obj call golib_hasHashData) exitWith {};

	_hashData = [_obj,false] call golib_getHashData;

	if (_obj call golib_en_obj_isEnergyObject) then {
		_stackMenu pushBack [
			"Подключить к источнику",
			{
				["Нажмите ЛКМ чтобы связать объект, ПКМ + Ctrl для отмены"] call showInfo;

				contextMenu_internal_energy_connector = (call contextMenu_getContextParams) select 0;
			}
		]
	};

	call _commonSimStart;

	_stackMenu pushBack [
		"Создать префаб (новый класс)",
		{
			_obj = (call contextMenu_getContextParams) select 0;
			if (([_obj] call golib_getChangedCustomPropsCount) == 0) exitWith {
				["Нельзя создать новый класс с такими же свойствами. Измените свойства и попробуйте снова."] call showWarning
			};
			//TODO open input new classname
		}
	];

	private _class = [_obj] call golib_getClassName;
	if (_class == "IStruct" || _class == "Decor") then {
		
		//here grouped all struct categories
		//https://github.com/Yobas/relicta.vr/blob/c842c876a86a328be617335a5745f65742d5279e/src/host/GameObjects/Structures/StructCategories.sqf

		private _listTypes = [];
		_listTypes pushBack ["--------------СТРУКТУРЫ--------------",control_const_listElementNoExitAtSelect,"Различные объекты окружения от малых до больших.\nБольшинство из этих объектов могут быть разрушены в процессе."];
		{
			if ([_x,"TemplatePrefab"] call goasm_attributes_hasAttributeClass) then {
				_listTypes pushBack _x;
			};
		} foreach (["IStruct",true] call oop_getinhlist);

		_listTypes pushBack ["--------------ДЕКОР--------------",control_const_listElementNoExitAtSelect,"Крупные декорации общего назначения.\nОбычно это неразрушаемые конструкции, которые служат основной для постройки любой карты"];
		private _decorsList = [];
		{
			if ([_x,"TemplatePrefab"] call goasm_attributes_hasAttributeClass) then {
				_listTypes pushBack _x;
			};
		} foreach (["Decor",true] call oop_getinhlist);

		//конвертируем массив типов в vec2 для ассоциаций
		_listTypes = _listTypes apply {
			if equalTypes(_x,"") then {
				[
					format["%1 (%2)",[_x,"name",true,"getName"] call oop_getFieldBaseValue,_x],
					_x,
					([_x,"desc",false,"getDesc"] call oop_getFieldBaseValue) call {
						if !([_this,"([\+]|nil)"] call regex_isMatch ) then {call compile _this}
						else {format["<runtime_expr>\n\n%1",_this]}
					}
				]
			} else {
				_x
			};
			
		};

		//_listTypes pushBack ["",control_const_listElementNoExitAtSelect];
		//_listTypes pushBack ["",control_const_listElementNoExitAtSelect];
		//TODO тут что-то хотел добавить, но забыл...

		_ctxParams pushBack _listTypes;

		_stackMenu pushBack [
			"Создать новый тип из "+ifcheck(_class=="IStruct","структуры","декорации"),
			{
				(call contextMenu_getContextParams) params ["_obj","_listTypes"];

				[
					_listTypes,
					//event on select
					{
						if equals(control_const_listElementNoExitAtSelect,_data) exitWith {

						};
						
						_objWorld = _ctxData select 0;

						[_objWorld] call golib_setSelectedObjects;
						private _args = [_data,_objWorld];// call goasm_prefab_createTemplateFrom_openWindow;
						nextFrameParams(goasm_prefab_createTemplateFrom_openWindow,_args);
					},
					{},
					{},
					"Выберите тип, от которого будет унаследован выбранный объект",
					null,
					[_obj]
				] call control_createList;
			}
		];
	};

	call _commonSelectQuery;
	call _commonCheckDistance;

	_stackMenu pushBack ["<t size='0.9'>Открыть редактор позиций модели</t>",{nextFrameParams(vcom_relposEditorOpen,(call contextMenu_getContextParams) select 0)}];
	_stackMenu pushBack ["Открыть редактор эмиттеров",{
		private _obj = (call contextMenu_getContextParams) select 0;
		private _params = [_obj];
		private _cfg = [_obj] call lsim_resolveObjectConfig;
		if (_cfg != "") then {
			_params pushBack _cfg;
		};
		private _code = {
			params ["_obj",["_cfg",""]];
			[_obj] call vcom_emit_createVisualWindow;
			
			if (_cfg != "") then {
				[_cfg] call vcom_emit_io_loadConfigCheck;
			};
		};
		nextFrameParams(_code,_params);
	}];

	// _stackMenu pushBack ["Добавить комментарий",{
	// 	do3DENAction "CreateComment";
	// }];

	_stackMenu pushBack ["Перейти к определению",{
		_obj = (call contextMenu_getContextParams) select 0;
		_class = [_obj] call golib_getClassName;
		if isNullVar(_class) exitwith {};
		
		_type = missionNamespace getVariable ["pt_"+_class,nullPtr];
		if !isNullReference(_type) then {
			(_type getVariable ["__decl_info__",["NULL","NULL"]])params ["_file","_line"];
			//[format["%1 определен в '%2' на линии %3",_class,_file,_line],10] call showInfo;

			["WorkspaceHelper","gotoclass",[_file,_line],true] call rescript_callCommand;
		};
	}];

	_stackMenu pushBack ["Создать манекен",{
		_screenToWorldPos = screenToWorld ContextMenu_internal_openedMousePosNative;
		([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
		if equals(_atlPos,vec3(0,0,0)) then {
			_atlPos = _screenToWorldPos;
		};

		_obj = create3DENEntity ["Object",BASIC_MOB_TYPE,_atlPos];
		_obj set3DENAttribute ["Name","debug_mob_gen_" + ((toArray hashValue _obj)joinString "_")];
		[_obj,_atlPos,false,golib_history_skippedHistoryStageFlag + " - fixpos"] call golib_om_setPosition;
	}];


	[
		_stackMenu,
		call mouseGetPosition,
		_ctxParams
	] call contextMenu_create;
}

function(ContextMenu_isDebugMob)
{
	params ["_mob"];
	[_mob get3DENAttribute "Name" select 0, "debug_mob"] call stringStartWith
}

init_function(ContextMenu_mouseArea_init)
{
	ContextMenu_internal_openedMousePos = [0,0];
	ContextMenu_internal_openedMousePosNative = [0,0];

	["onMouseAreaPressed",ContextMenu_mouseArea_handleEvent] call Core_addEventHandler;
	["onFrame",{
		if (call contextMenu_energy_isDragModeActive) then {
			_curObj = objNull;
			_objList = ifcheck(!isNullReference(contextMenu_internal_energy_connector),[contextMenu_internal_energy_connector],contextMenu_internal_energy_connectorList);
			
			_errDraw = {
				_screenToWorldPos = screenToWorld getMousePosition;
				([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
				if equals(_atlPos,vec3(0,0,0)) then {
					_atlPos = _screenToWorldPos;
				};
				{
					drawLine3D [
						getPosAtl _x, 
						_atlPos, 
						[1,0,0,1],
						50
					];
				} foreach _objList;
				
			};
			contextMenu_internal_energy_toObject = objnull;
			
			//! get3denMouseOver not collect locked object
			// private _obj = get3DENMouseOver;
			// if (count _obj == 0) exitWith _errDraw;
			// if ((_obj select 0)!= "Object") exitWith _errDraw;
			// contextMenu_internal_energy_toObject = _obj select 1;

			_screenToWorldPos = screenToWorld getMousePosition;
			([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
			private _mobj = get3DENMouseOver;
			if (count _mobj > 1) then {_mobj = _mobj select 1} else {_mobj = objNull};
			_allNulls = isNullReference(_obj) && isNullReference(_mobj);
			if _allNulls exitwith _errDraw;
			//get not null
			if (isNullReference(_obj) || isNullReference(_mobj)) then {
				if isNullReference(_obj) then {
					_obj = _mobj;
				};
			} else {
				//all not null
				_d1 = _obj distance get3DENCamera;
				_d2 = _mobj distance get3DENCamera;
				if (_d1 < _d2) then {
					_obj = _obj;
				} else {
					_obj = _mobj;
				};
			};

			contextMenu_internal_energy_toObject = _obj;

			if equals(_atlPos,vec3(0,0,0)) then {
				_atlPos = getPosAtl contextMenu_internal_energy_toObject;
			};
			
			{
				_curObj = _x;
				drawLine3D [
					getPosAtl _curObj, 
					_atlPos, 
					[0,1,0,1],
					30
				];
				drawIcon3D ["", [0,0.7,0,1], (getPosAtl _curObj) vectoradd [0,0,1], 0, 0, 0, "Точка привязки", 1, 0.05, "PuristaMedium"];
				if (contextMenu_internal_energy_toObject call golib_hasHashData) then {
					_hd = contextMenu_internal_energy_toObject call golib_getHashData;
					_t = format["Привязать к %1",_hd getOrDefault ["class","ERROR_TYPE"]];
					drawIcon3D ["", [0,1,0,2,1], _atlPos, 0, 0, 0, _t, 1, 0.07, "PuristaMedium","right"];
				};
			} foreach _objList;
		};

	}] call Core_addEventHandler;

	contextMenu_internal_energy_connector = objnull;
	contextMenu_internal_energy_connectorList = [];
	contextMenu_internal_energy_toObject = objnull;
}

function(contextMenu_energy_isDragModeActive)
{
	!isNullReference(contextMenu_internal_energy_connector)
	|| {count contextMenu_internal_energy_connectorList > 0}
}

function(ContextMenu_mouseArea_handleEvent)
{
	params ["_mouse","_shift","_ctrl","_alt"];

	if !(call contextMenu_energy_isDragModeActive) exitwith {};

	//["Связывание через контекст не реализовано в данной версии"] call showWarning;
	
	if (_mouse == MOUSE_RIGHT) exitwith {
		if (!_ctrl) exitwith {};
		contextMenu_internal_energy_connectorList = [];
		contextMenu_internal_energy_connector = objnull;
		contextMenu_internal_energy_toObject = objnull;
	};
	
	if !isNullReference(contextMenu_internal_energy_connector) then {
		[contextMenu_internal_energy_connector,contextMenu_internal_energy_toObject] call golib_en_connectObjects;
	} else {
		[contextMenu_internal_energy_connectorList,contextMenu_internal_energy_toObject] call golib_en_connectObjectsList;
	};

	contextMenu_internal_energy_connectorList = [];
	contextMenu_internal_energy_connector = objnull;
	contextMenu_internal_energy_toObject = objnull;
	
	//sync inspector visual
	nextFrame(inspector_menuLoad);
}