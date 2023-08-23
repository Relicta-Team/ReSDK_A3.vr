// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
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
		
		if !(call _condToVisible) then {
			_w ctrlEnable false;
			_w setBackgroundColor (widget_internal_contextmenu_exitcolor apply {(_x - 0.5)max 0});
		};

		_w ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor widget_internal_contextmenu_entercolor}];
		_w ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor widget_internal_contextmenu_exitcolor}];

		if (_level > 0) then {
			_w setFade 1;
			_w commit 0;
			_w ctrlEnable false;
		};
		
		if equalTypes(_includedListOrAction,[]) then {
			modvar(_name) + "<t align='right' size='1.3'>+"+sgt+"</t>";
			
			_w ctrlAddEventHandler ["MouseButtonUp",{
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
			_w ctrlAddEventHandler ["MouseButtonUp",{
				_c = {
					_buttonContext = _this select 0;
					_nameContext = sanitizeHTML(ctrlText _buttonContext);
					_indexContext = _buttonContext getVariable "index";
					_levelContext = _buttonContext getVariable "level";
					call (_buttonContext getVariable "_action");
				};
				
				nextFrameParams(_c,_this);
				nextFrame({(call contextMenu_getDisplay) closeDisplay 0});
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

function(ContextMenu_loadMouseObject)
{
	private _obj = get3DENMouseOver;
	private _hasObject = false;
	if (count _obj > 0 && (_obj select 0)== "Object") then {
		_hasObject = true;
		_obj = _obj select 1;
	};
	//second check 
	if (!_hasObject) then {
		_screenToWorldPos = screenToWorld getMousePosition;
		([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR"];
		if !isNullReference(_objR) then {
			_obj = _objR;
			_hasObject = true;
		};
	};
	_stackMenu = [["Отмена",{}]];
	private _ctxParams = [_obj];

	private _commonSimStart = {
		_stackMenu pushBack ["Запустить симуляцию отсюда",{
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
		}];
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

						_objWorld call golib_setSelectedObjects;
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

	call _commonCheckDistance;

	_stackMenu pushBack ["<t size='0.9'>Открыть редактор позиций модели</t>",{nextFrameParams(vcom_relposEditorOpen,(call contextMenu_getContextParams) select 0)}];
	_stackMenu pushBack ["Открыть редактор эмиттеров",{
		private _obj = (call contextMenu_getContextParams) select 0;
		nextFrameParams(vcom_emit_createVisualWindow,_obj);
	}];

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


	[
		_stackMenu,
		call mouseGetPosition,
		_ctxParams
	] call contextMenu_create;
}

init_function(ContextMenu_mouseArea_init)
{
	ContextMenu_internal_openedMousePos = [0,0];
	ContextMenu_internal_openedMousePosNative = [0,0];

	["onMouseAreaPressed",ContextMenu_mouseArea_handleEvent] call Core_addEventHandler;
	["onFrame",{
		if !isNullReference(contextMenu_internal_energy_connector) then {
			_errDraw = {
				_screenToWorldPos = screenToWorld getMousePosition;
				([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
				if equals(_atlPos,vec3(0,0,0)) then {
					_atlPos = _screenToWorldPos;
				};
				drawLine3D [
					getPosAtl contextMenu_internal_energy_connector, 
					_atlPos, 
					[1,0,0,1]
				];
			};
			contextMenu_internal_energy_toObject = objnull;
			private _obj = get3DENMouseOver;
			if (count _obj == 0) exitWith _errDraw;
			if ((_obj select 0)!= "Object") exitWith _errDraw;
			contextMenu_internal_energy_toObject = _obj select 1;

			_screenToWorldPos = screenToWorld getMousePosition;
			([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
			if equals(_atlPos,vec3(0,0,0)) then {
				_atlPos = getPosAtl contextMenu_internal_energy_toObject;
			};

			drawLine3D [
				getPosAtl contextMenu_internal_energy_connector, 
				_atlPos, 
				[0,1,0,1]
			];
			drawIcon3D ["", [0,0.7,0,1], (getPosAtl contextMenu_internal_energy_connector) vectoradd [0,0,1], 0, 0, 0, "Точка привязки", 1, 0.05, "PuristaMedium"];
			if (contextMenu_internal_energy_toObject call golib_hasHashData) then {
				_hd = contextMenu_internal_energy_toObject call golib_getHashData;
				_t = format["Привязать к %1",_hd getOrDefault ["class","ERROR_TYPE"]];
				drawIcon3D ["", [0,1,0,2,1], _atlPos, 0, 0, 0, _t, 1, 0.07, "PuristaMedium","right"];
			};

		};
	}] call Core_addEventHandler;

	contextMenu_internal_energy_connector = objnull;
	contextMenu_internal_energy_toObject = objnull;
}

function(ContextMenu_mouseArea_handleEvent)
{
	params ["_mouse","_shift","_ctrl","_alt"];

	if isNullReference(contextMenu_internal_energy_connector) exitwith {};

	//["Связывание через контекст не реализовано в данной версии"] call showWarning;
	
	if (_mouse == MOUSE_RIGHT) exitwith {
		if (!_ctrl) exitwith {};
		contextMenu_internal_energy_connector = objnull;
		contextMenu_internal_energy_toObject = objnull;
	};
	
	[contextMenu_internal_energy_connector,contextMenu_internal_energy_toObject] call golib_en_connectObjects;

	contextMenu_internal_energy_connector = objnull;
	contextMenu_internal_energy_toObject = objnull;
}