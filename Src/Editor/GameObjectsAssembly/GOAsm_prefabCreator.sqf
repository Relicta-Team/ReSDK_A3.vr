// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
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
		"Создать наследника "+_basicType+"|text",
		"Имя класса|typename|Введите имя класса\nИмя может содержать только символы английского алфавита, цифры и нижнее подчеркивание.\nИмя должно начинаться только с нижнего подчеркивания либо буквы"
	  ],
		{
			(_this splitString "|") params [["_name","ERROR_NAME"],["_t","ERROR_TYPE"],["_desc",""]];
			if (_t == "text") then {
				_text = [_d,TEXT,[0,10*_i,100,9.5],_ctg] call createWidget;
				[_text,_name] call widgetSetText;
			};
			if (_t == "typename") then {
				_text = [_d,TEXT,[0,10*_i,30,9.5],_ctg] call createWidget;
				[_text,_name] call widgetSetText;
				_text ctrlSetTooltip _desc;

				_widTypename = [_d,INPUT,[30,10*_i,100-30,9.5],_ctg] call createWidget;
				["_widTypename",_widTypename] call Core_addContext;
			};
		},
		//onsave
		{
			private _newClass = ctrlText ("_widTypename" call Core_getContextVar);
			private _basicType = "_basicType" call Core_getContextVar;
			private _worldObj = "_worldObj" call Core_getContextVar;

			private _virtObj = "_virtObj" call Core_getContextVar;
			_mapData = [_virtObj] call golib_getCustomProps;
			
			private _listProps = _mapData toArray false;

			call Core_popContext;
			private _outvalueError = refcreate("");
			if ([_newClass,_basicType,_listProps,"prefab_openFileAfterCreated" call core_settings_getValue,_outvalueError] call goasm_prefab_createPrefab) then {

				//update hashdata
				private _hd = [_worldObj,false] call golib_getHashData;
				_hd set ["class",_newClass];
				if (("model" in _mapData) && {(_mapData get "model")!=(_hd get "model")}) then {
					_mapData deleteat "model";
					["Модель не будет обновлена в данном случае, так как создается префаб из уже изменённой модели"] call showWarning;
					["goasm_prefab_createTemplateFrom_openWindow - handled potential error with model logic"] call printWarning;
				};
				_hd set ["customProps",_mapData];
				[_worldObj,_hd,true,"Создание префаба типа "+_newClass] call golib_setHashData;
				
				[[]] call inspector_menuLoad;

				//update all in next frame only (because rebuild called at next frame)
				//private _params = [_newClass];
				//nextFrameParams(golib_massoc_updateAllObjectsAtClassAndModel,_params);
				
				//runtime postbuild code
				private _code = format["%1 call golib_massoc_updateAllObjectsAtClassAndModel; call golib_vis_loadObjList;",[_newClass]];
				(compile _code) call goasm_builder_setPostBuildCode;
			} else {
				[[]] call inspector_menuLoad;

				private _errCode = refget(_outvalueError);
				if (!isNullVar(_errCode) && {_errCode == "ioex"}) then {
					["Ошибка ввода. Передключитесь на редактор, затем обратно и повторите попытку создания"] call showWarning;
				} else {
					[format["Ошибка при создании класса %1. Подробнее смотрите в логах",_errCode]] call showWarning;
				};
			};

			deleteVehicle _virtObj;
		},
		"Создание префаба",
		"Создать",
		getEdenDisplay, //!для работы с полями инспектора
		{
			private _virtObj = "_virtObj" call Core_getContextVar;
			deleteVehicle _virtObj;

			call Core_popContext;
		},
		null,
		true
	]; //call golib_openArraySelector;
	//В следующем кадре вызов. в текущем ещё удаляется дисплей
	nextFrameParams(golib_openArraySelector,_args);
}

function(goasm_prefab_createPrefab)
{
	params ["_newType","_basicType","_listKeymapValues",["_openAfterAdd",false],"_referror"];
	/*
		1. Check duplicate name new type
		2. Alloc eoc (end-of-class) in basic type
		3. build class info
		4. emplace info in mother class file
		5. rebuild classes with goasm_builder_rebuildClasses
	*/
	if !([_newType,"^([_a-zA-Z][_a-zA-Z1-9]*)$"] call regex_isMatch) exitWith {
		refset(_referror,"clserror");
		["Classname error only in format: ^([_a-zA-Z][_a-zA-Z1-9]*)$"] call printError;
		false
	};
	if (_newType call oop_reflect_hasClass) exitWith {
		refset(_referror,"duplicateerror");
		["Class "+_newType+" already exists"] call printError;
		false
	};
	if !(_basicType call oop_reflect_hasClass) exitWith {
		refset(_referror,"baseclassnotfounderror");
		["Base class "+_basicType+" not exists"] call printError;
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
		["%1 - unrecognized symbol in type info",__FUNC__] call printError;
		false
	};

	private _out = ["OOPBuilder","buildclass",[_file,_line+1,(_typeInfo) regexReplace["""/g",""] ],true] call rescript_callCommand;
	
	if (_out != "") exitWith {
		refset(_referror,ifcheck("IOException" in _out,"ioex",_out));
		["%1 - Output error: %2",__FUNC__,_out] call printError;
		false
	};

	call goasm_builder_rebuildClasses;	

	if (_openAfterAdd) then {
		["WorkspaceHelper","gotoclass",[_file,_line+1],true] call rescript_callCommand;
	};

	true
}

function(goasm_prefab_createNewFromType_openWindow)
{
	//create dummy virtual object
}