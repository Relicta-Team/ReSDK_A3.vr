// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//функция для создания шаблонов из типов
//отличается от goasm_prefab_createNewFromType_openWindow тем, что после создания типа она обновляет все эквивалентые модели под новый класс
//функция только для внутреннего назначения.
function(goasm_prefab_createTemplateFrom_openWindow)
{
	params ["_basicType","_worldObj"];
	
	["%1 - parameters %3: %2",__FUNC__,_this,count _this] call printTrace;

	//std validate file access
	([_basicType,"__decl_info_end__"] call oop_getTypeValue)params ["_file","_line"];

	
	//handle from virtual editor
	//create virtual object -> use "observedData"
	_virtObj = [_basicType,(getModelInfo _worldObj) select 1,[_worldObj,false] call golib_getHashData] call golib_createVirtualObject;
	[[_virtObj]] call inspector_menuLoad;
	
	//in arraylist items: add attribute:
	call Core_pushContext;

	private _args=[ [
		"Создать наследника от|text",
		"Имя класса|typename|Введите имя класса\nИмя может содержать только символы английского алфавита, цифры и нижнее подчеркивание.\nИмя должно начинаться только с нижнего подчеркивания либо буквы"
	  ],
		{
			(_this splitString "|") params [["_name","ERROR_NAME"],["_t","ERROR_TYPE"],["_desc",""]];
			if (_t == "text") then {
				_text = [_d,TEXT,[0,10*_i,100,9.5],_ctg] call createWidget;
				[_text,_name + " " +("_basicType" call Core_getContextVar) + " (перетащите класс из библиотеки для замены)"] call widgetSetText;
			};
			if (_t == "typename") then {
				_text = [_d,TEXT,[0,10*_i,30,9.5],_ctg] call createWidget;
				[_text,_name] call widgetSetText;
				_text ctrlSetTooltip _desc;

				_widTypename = [_d,INPUT,[30,10*_i,100-30,9.5],_ctg] call createWidget;
				["_widTypename",_widTypename] call Core_addContext;
				_widTypename ctrladdeventhandler ["KillFocus",{
					private _widTypename = "_widTypename" call Core_getContextVar;
					private _newClass = ctrlText (_widTypename);
					private _basicType = "_basicType" call Core_getContextVar;

					if !([_newClass,_basicType] call goasm_prefab_validateName) then {
						_widTypename ctrlsettext "";
					};
				}];
			};
		},
		//onsave
		{
			private _newClass = ctrlText ("_widTypename" call Core_getContextVar);
			["_newClass",_newClass] call Core_addContext;
			private _basicType = "_basicType" call Core_getContextVar;
			private _worldObj = "_worldObj" call Core_getContextVar;

			private _virtObj = "_virtObj" call Core_getContextVar;
			_mapData = [_virtObj] call golib_getCustomProps;
			
			private _listProps = _mapData toArray false;

			
			private _postSuccess = {
				call loadingScreen_stop;
				
				private _worldObj = "_worldObj" call Core_getContextVar;
				private _newClass = "_newClass" call Core_getContextVar;
				private _virtObj = "_virtObj" call Core_getContextVar;
				_mapData = [_virtObj] call golib_getCustomProps;

				//update hashdata
				private _hd = [_worldObj,false] call golib_getHashData;
				_oldClass = _hd get "class";
				_hd set ["class",_newClass];
				_cust = _hd getOrDefault ["customProps",createHashMap];
				if (("model" in _mapData) && {(_mapData get "model")!=(_cust getOrDefault ["model","--nomodel--"])}) then {
					_mapData deleteat "model";
					["Модель не будет обновлена в данном случае, так как создается префаб из уже изменённой модели"] call showWarning;
					["goasm_prefab_createTemplateFrom_openWindow - handled potential error with model logic"] call printWarning;
				};
				
				["mapdata: %1; hashdata: %2",_mapData,_hd] call printTrace;

				_hd set ["customProps",_mapData];
				// Это действие не будет выполнено, поскольку после ребилда вызывается golib_massoc_updateAllObjectsAtClassAndModel
				// который в свою очередь размапит структуры и декорации
				// TODO: разкомментировать когда будет реализован префаб генератор
				// if ((tolower _oldClass) in ["istruct","decor"]) then {
				// 	[_worldObj,_hd,true,"Создание префаба типа "+_newClass] call golib_setHashData;
				// };
				
				[[]] call inspector_menuLoad;
				
				//runtime postbuild code
				private _code = format["call golib_vis_loadObjList; %1 call golib_massoc_updateAllObjectsAtClassAndModel;",[_newClass]];
				(compile _code) call goasm_builder_setPostBuildCode;
				
				call Core_popContext;
			};
			private _postError = {
				call loadingScreen_stop;
				
				private _virtObj = "_virtObj" call Core_getContextVar;
				deleteVehicle _virtObj;

				[[]] call inspector_menuLoad;

				call Core_popContext;
			};
			
			[displayNull] call loadingScreen_start;
			
			[50,"Генерация"] call loadingScreen_setProgress;			

			[
				_newClass,
				_basicType,
				_listProps,
				"prefab_openFileAfterCreated" call core_settings_getValue,
				[_postSuccess,_postError]
			] call goasm_prefab_createPrefab;

		},
		"Создание префаба",
		"Создать",
		getEdenDisplay, //!для работы с полями инспектора
		{
			private _virtObj = "_virtObj" call Core_getContextVar;
			deleteVehicle _virtObj;

			call Core_popContext;

			[[]] call inspector_menuLoad;
		},
		{
			params ["_draggedClass"];
			["_basicType",_draggedClass] call Core_updateContextVar;
			call golib_eventReloadArraySelector;
		},
		true
	]; //call golib_openArraySelector;
	//В следующем кадре вызов. в текущем ещё удаляется дисплей
	nextFrameParams(golib_openArraySelector,_args);
}

function(goasm_prefab_createPrefab)
{
	params ["_newType","_basicType","_listKeymapValues",["_openAfterAdd",false],["_postEvents",[{},{}]]];
	_postEvents params [["_onSuccessCreate",{}],["_onErrorCreate",{}]];

	/*
		1. Check duplicate name new type
		2. Alloc eoc (end-of-class) in basic type
		3. build class info
		4. emplace info in mother class file
		5. rebuild classes with goasm_builder_rebuildClasses
	*/
	if !([_newType,_basicType] call goasm_prefab_validateName) exitwith {
		call _onErrorCreate;
		false
	};

	_basicType = [_basicType,"classname"] call oop_getTypeValue;

	private _charTab = toString [9];
	private _parseValue = {
		if equalTypes(_this,"") then {
			str(
				[_this,"\,",""" + pcomma + """] call regex_replace
			)
		} else {
			[_this,"\,"," arg "] call regex_replace
		};
	};

	([_basicType,"__decl_info_end__"] call oop_getTypeValue)params ["_file","_line"];
	private _typeInfo = format[endl+"editor_attribute(""EditorGenerated"")" + endl +"class(%1) extends(%2)",_newType,_basicType];

	//члены класса
	{
		_x params ["_key","_val"];
		modvar(_typeInfo) + (format[endl + _charTab + "var(%1,%2);",
			_key,
			_val call _parseValue
		]);
	} foreach _listKeymapValues;
	//закрывающий тэг
	modvar(_typeInfo) + endl + "endclass";
	
	if ("" in _typeInfo) exitwith {
		["%1 - unrecognized symbol in type info",__FUNC__] call showError;
		call _onErrorCreate;
		false
	};

	private _ctxParams = [
		// _buildContext
		[_file,_line+1,_typeInfo regexReplace["""/g",""]],
		// _postEvents
		[_onSuccessCreate,_onErrorCreate],
		// _openAfterAdd
		_openAfterAdd
	];

	[_file,_ctxParams,false,{
		_this params ["_buildContext","_postEvents","_openAfterAdd"];

		private _out = ["OOPBuilder","buildclass",_buildContext,true] call rescript_callCommand;
	
		if (_out != "") exitWith {
			setScopeName("goasm_prefab_createPrefab<postevent_unlock>");
			["%1 - Output error: %2",__FUNC__,_out] call printError;
			call (_postEvents select 1);
		};

		call (_postEvents select 0);

		call goasm_builder_rebuildClasses;	

		if (_openAfterAdd) then {
			_buildContext params ["_file","_line"];
			["WorkspaceHelper","gotoclass",[_file,_line],true] call rescript_callCommand;
		};
	},{
		_this params ["","_postEvents",""];
		call (_postEvents select 1);
	}] call file_unlockAsync;

	true
}

function(goasm_prefab_validateName)
{
	params ["_newType","_basicType"];

	if !([_newType,"^([_a-zA-Z][_a-zA-Z0-9]*)$"] call regex_isMatch) exitWith {
		["Имя класса должно содержать только англ. символы. Допускаются цифры и нижнее подчеркивание: ^([_a-zA-Z][_a-zA-Z0-9]*)$"] call showError;
		false
	};
	if (_newType call oop_reflect_hasClass) exitWith {
		["Класс "+_newType+" уже существуе"] call showError;
		false
	};
	if !(_basicType call oop_reflect_hasClass) exitWith {
		["Базовый класс "+_basicType+" не существует"] call showError;
		false
	};

	if (count _newType >= 255) exitwith {
		["Слишком длинное имя класса. Не более 255 символов"] call showError;
		false
	};

	true
}

function(goasm_prefab_createNewFromType_openWindow)
{
	//create dummy virtual object
}