// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(golib_hashData_init)
{
	golib_internal_lastBatchUpdateMode = [];

	golib_internal_randomConvTable = null;
}

function(golib_hasHashData)
{
	params ["_wobj"];
	if (_wobj call golib_isVirtualObject) exitwith {
		not_equals(_wobj getVariable ["observedData" arg ""],"")
	};
	private _attr = _wobj get3DENAttribute 'init';
	(not_equals(_attr,[""]) && not_equals(_attr,[]))
}

function(golib_serializeHashData)
{
	params ["_hashData"];
	private _serializedData = "{createHashMapFromArray"+(str _hashData)+"}";
	private _idx = _serializedData find "[""customProps"",[";
	//TODO возможно containerContent тоже надо сериализовывать через карту
	if (_idx!=-1) then {
		_serializedData = _serializedData insert [_idx+15,"createHashMapFromArray"]
	};

	_serializedData
}


function(golib_setHashData)
{
	params ["_worldObj","_hashData",["_addToHistory",false],["_postMes",""]];
	
	if (_worldObj call golib_isVirtualObject) exitwith {
		private _serializedData = [_hashData] call golib_serializeHashData;
		_worldObj setvariable ["observedData",_serializedData];
		_observedContent = _worldObj getvariable ["observedContent",[]];
		_observedIndex = _worldObj getvariable ["observedIndex",-1];
		if (count _observedContent == 0 || _observedIndex == -1) exitwith {
			["%1 - cannot save hash data for object %2",__FUNC__,_worldObj] call printError;
		};
		(_observedContent select _observedIndex) set [0,_serializedData];
	};

	//only first object must passed from params
	private _otherObjects = inspector_otherObjects;
	if not_equals(_worldObj,inspector_allSelectedObjects select 0) then {
		["first object: %1; list: %2",_worldObj,inspector_otherObjects] call printTrace;
		_otherObjects = inspector_allSelectedObjects - [_worldObj];
	};

	//prevaidate data
	private _canApplyForCurrent = true;
	
	if (count golib_internal_lastBatchUpdateMode > 1) then {
		golib_internal_lastBatchUpdateMode params ["_name",["_btype",""]];
		if (_btype == "cprov") then {
			_canApplyForCurrent = [_hashData get "class",_name,_hashData] call golib_batch_validatePropAccess;
		};
	};

	private _serializedData = [_hashData] call golib_serializeHashData;
	if (_addToHistory) then {
		if (_postMes!="") then {
			_postMes = ": " + _postMes;
		};
		["Инспектор"+_postMes, "Изменение свойств объекта "+(_hashData get "class"), "a3\3den\data\cfg3den\history\changeAttributes_ca.paa"] collect3DENHistory {
			[_otherObjects,_hashData,golib_internal_lastBatchUpdateMode] call golib_setHashData_batch;
			if (_canApplyForCurrent) then {
				_worldObj set3DENAttribute ["init",_serializedData];
			};
		};
	} else {
		[_otherObjects,_hashData,golib_internal_lastBatchUpdateMode] call golib_setHashData_batch;
		if (_canApplyForCurrent) then {
			_worldObj set3DENAttribute ["init",_serializedData];
		};
	};
}

/*
	set next sethashdata batch mode
	Если свойство найдено в новой дате - это установка
	Если свойство не найден в новой дате - это удаление
*/
function(goilb_setBatchMode)
{
	params ["_name",["_mode",""]];
	golib_internal_lastBatchUpdateMode = [_name,_mode];
}

function(golib_batch_validatePropAccess)
{
	params ["_type","_prop","_hashData"];
	
	//no field founded
	if !((tolower _prop) in ([_type] call golib_getClassAllFields)) exitWith {false};

	//internal field check
	if ([_type,_prop,"InternalImpl"] call goasm_attributes_hasAttributeField) exitWith {false};
	//readony field check
	if ([_type,_prop,"ReadOnly"] call goasm_attributes_hasAttributeField) exitWith {false};

	true
}

function(golib_setHashData_batch)
{
	params ["_worldObj","_newData","_bupd"];
	golib_internal_lastBatchUpdateMode = [];
	if (count _bupd == 0) exitWith {};
	if not_equalTypes(_worldObj,[]) then {_worldObj = [_worldObj]};
	if (count _worldObj == 0) exitWith {};

	_bupd params ["_propname",["_mode",""]];

	if (_mode == "") then {
		assert(equalTypes(_propname,""));
		if (_propname in _newData) then {
			_mode = "set";
		} else {
			_mode = "del";
		};
	};

	["Update batch: %1 for %2 (newclass: %3)",_mode,_propname ,_newData get "class"] call printTrace;
	
	private _statementMap = (createHashMapFromArray [
		//custom provider for fields
		["cprov",{
			//validate. class not contain this field
			if !([_curData get "class",_propname,_curData] call golib_batch_validatePropAccess) exitWith {
				["Invalidate check %1::%2",_curData get "class",_propname] call printError;
			};


			private _curDataTemp = _curData;
			private _newDataTemp = _newData;
			_curData = _curData get "customProps";
			_newData = _newData get "customProps";
			private _intMode = if (_propname in _newData) then {"set"} else {"del"};
			
			["internal cprov batch: %1 for %2",_intMode,_propname] call printTrace;

			call (_statementMap get _intMode);
			
			//restore
			_curData = _curDataTemp;
			_newData = _newDataTemp;
		}],
		["set",{
			if equalTypes(_propname,[]) then {
				{_curData set [_x,_newData get _x]} foreach _propname
			} else {
				private _newvalue = _newData get _propname;
				_curData set [_propname,_newvalue]
			};
			
		}],
		["del",{
			if equalTypes(_propname,[]) then {
				{_curData deleteAt _x} foreach _propname
			} else {
				_curData deleteAt _propname
			};
		}],
		["set_mark",{
			assert(equalTypes(_propname,""));
			private _newvalue = _newData get _propname;
			_curData set [_propname,format["%1 (copy %2)",[_newvalue," \(copy \d+\)",""] call regex_replace, _foreachIndex + 1]]
		}],
		["script_params_setvalidate",{
			if !("__scriptName" in _curData) exitWith {};
			call (_statementMap get "set");
		}],
		["script_params_delvalidate",{
			if !("__scriptName" in _curData) exitWith {};
			call (_statementMap get "del");
		}]
	]);

	private _execCode = _statementMap get (_mode);
	if isNullVar(_execCode) exitWith {
		["Unknown batch type %1",_mode] call printError;
	};

	{
		private _curData = [_x,false] call golib_getHashData;
		["batch update class: %1",_curData get "class"] call printTrace;
		call _execCode;
		private _serHash = [_curData] call golib_serializeHashData;
		_x set3DENAttribute ["init",_serHash];
	} foreach _worldObj;
}

function(golib_isVirtualObject)
{
	params ["_wobj"];
	!isNull(_wobj getVariable "observedData");
}

function(golib_createVirtualObject)
{
	params ["_cls","_model","_refHashData"];
	private _dummyObj = createSimpleObject [_model,[0,0,0]];
	_dummyObj setVariable ["observedIndex",0];
	
	private _basicHD = if isNullVar(_refHashData) then {
		[null,_cls,false] call golib_initHashData
	} else {
		_refHashData
	};

	private _hashData = [_basicHD] call golib_serializeHashData;
	private _refContent = [
		[
			_hashData,
			0
		]
	];

	//массив vec2, сериализованный код hashData и количество
	_dummyObj setVariable ["observedContent",_refContent];
	//сериализованный код с hashData текущего элемента (только для виртуальных объектов)
	_dummyObj setVariable ["observedData",_hashData];
	
	_dummyObj
}

//прочитать данные из объекта
function(golib_getHashData)
{
	params ["_wobj",["_throwError",true]];
	private _isWorldContext = !(_wobj call golib_isVirtualObject);
	if (_isWorldContext) then {
		private _attr = _wobj get3DENAttribute 'init'; //копипаста из golib_hasHashData (производительность+1)
		if (not_equals(_attr,[""]) && not_equals(_attr,[])) then {
			call call compile(_attr select 0)
		} else {
			if (_throwError) then {
				["%1 - Error at getting hash data -> %2 (object %3). Returned empty data",__FUNC__,_attr,_wobj] call printError;
			};
			createHashMap
		};
	} else {
		private _dat = _wobj getVariable ["observedData",""];
		if equals(_dat,"") exitWith {
			if (_throwError) then {
				["%1 - Error at getting hash data from virtual object -> %2 (object %3). Returned empty data",__FUNC__,_dat,_wobj] call printError;
			};
			createHashMap
		};
		(_dat) call golib_deserializeHashData;
	};
	
}

function(golib_deserializeHashData)
{
	params ["_serializedData"];
	call (call compile _serializedData);
}

//Регистрация нового объекта созданного перетаскиванием мыши
function(golib_initHashData)
{
	params ["_worldObj","_go",["_applyToWorldObject",true]];
	private _mapData = createHashMap;
	_mapData set ["class",_go];
	_mapData set ["customProps",createHashMap];
	if (_applyToWorldObject) then {
		[_worldObj,_mapData] call golib_setHashData;
	};
	_mapData
}

function(golib_getClassAllFields)
{
	params ["_obj"];
	private _cls = ifcheck(equalTypes(_obj,""),_obj,[_obj] call golib_getClassName);
	if isNullVar(_cls) exitWith {[]};
	[_cls,"__allfields_map"] call oop_getTypeValue;
}

function(golib_getClassName)
{
	params ["_obj"];
	if !([_obj] call golib_hasHashData) exitwith {};

	private _hd = [_obj,false] call golib_getHashData;
	_hd get "class"
}

function(golib_getChangedCustomPropsCount)
{
	params ["_obj"];
	private _hd = [_obj,false] call golib_getHashData;
	count (_hd get "customProps")
}

function(golib_getCustomProps)
{
	params ["_obj"];
	private _hd = [_obj,false] call golib_getHashData;
	_hd get "customProps"
}

function(golib_getActualDataValue)
{
	params ["_obj","_field",["_compileResult",true]];
	_field = tolower _field;
	private _hd = [_obj,false] call golib_getHashData;
	if (_field in (_hd get "customProps")) then {
		(_hd get "customProps") get _field;
	} else {
		[_hd get "class",_field,_compileResult] call oop_getFieldBaseValue;
	};
}

function(golib_getHashDataActualValue)
{
	params ["_hd","_field"];
	_field = tolower _field;
	if (_field in (_hd get "customProps")) then {
		(_hd get "customProps") get _field;
	} else {
		[_hd get "class",_field,true] call oop_getFieldBaseValue;
	};
}

function(golib_getActualBasicValue)
{
	params ["_obj","_field"];
	private _hd = [_obj,false] call golib_getHashData;
	if (_field in (_hd)) then {
		(_hd) get _field;
	} else {
		//[_hd get "class",_field,true] call oop_getFieldBaseValue;
		null
	};
}

function(golib_setActualBasicValue)
{
	params ["_obj","_var","_val"];
	private _hd = [_obj,false] call golib_getHashData;
	if (_var in golib_hashData_keys) then {
		_hd set [_var,_val];
		[_obj,_hd] call golib_setHashData;
	} else {
		["Error on setting actual data %1 -> %2. Key not found",_obj,_var] call printError;
		false
	};
}

// COMMON STORAGE

function(golib_getCommonStorage)
{
	golib_com_object
}

function(golib_getCommonStorageParam)
{
	params ["_pname"];
	([golib_com_object,false] call golib_getHashData) get _pname
}


function(golib_hasCommonStorageParam)
{
	_this in ([golib_com_object,false] call golib_getHashData)
}

function(golib_saveCommonStorage)
{
	params [["_logMessage",""]];
	private _showLog = false;
	if (_logMessage != "") then {
		_showLog = true;
	};
	[golib_com_object,golib_com_objectHash,_showLog,_logMessage] call golib_setHashData
}

//процессор общих данных для режима симуляции. _mode true вызывается при входе, false при выходе или загрузке редактора
// function(golib_onCommonStorageProcess)
// {
// 	params ["_mode",["__systemFlags",[]],["__sdkProps",[]]];
// 	if (_mode) then {
// 		golib_com_objectHash set ["__systemFlags",__systemFlags];
// 		golib_com_objectHash set ["__sdkProps",__sdkProps];
// 		[] call golib_saveCommonStorage;
// 	} else {
// 		golib_com_objectHash deleteAt "__systemFlags";
// 		golib_com_objectHash deleteAt "__sdkProps";
// 		[] call golib_saveCommonStorage;
// 	};
// }


function(golib_initCommonStorage_nonAuto)
{
	["onFrame",{
		_hasUnsaved = "*" in (ctrlText (call menu_getMissionNameControl)); //ctrlSetText menu_internal_missionName
		golib_hasUnsavedChanges = _hasUnsaved;
		_prefix = "";
		_baseText = (ctrlText (call menu_getMissionNameControl));
		if (_hasUnsaved) then {
			_prefix = "<UNSAVED CHANGES>           *";
		};

		(call menu_getMissionNameControl)
		 ctrlSetText 
		 (
			format["%1Map name: %2    (v%3); REDITOR version %4",_prefix,"missionName" call golib_getCommonStorageParam,"version" call golib_getCommonStorageParam,Core_version_name]
		 )
		;

	}] call Core_addEventHandler;

	["Initialize map storage"] call printLog;
	golib_com_object = objnull;
	golib_com_objectHash = createHashMap;
	private _exit = false;
	{
		if (_x call golib_hasHashData) then {
			_hd = [_x,false] call golib_getHashData;
			if ("missionName" in _hd) exitWith {
				golib_com_object = _x;
				golib_com_objectHash = _hd;
				_exit = true;
			};
		};
		if (_exit) exitWith {};
	} foreach (all3DENEntities select 0);

	if isNullReference(golib_com_object) exitwith {
		Core_catchedInitError = true;
		["Error on initialize map storage"] call printError;
		setLastError("Cannot find common storage. Try reload map from backup file");
	};

	["Initialize map storage done"] call printLog;

	if !("version" call golib_hasCommonStorageParam) then {
		golib_com_objectHash set ["version",Core_version_number];
		["!!! Инициализация версии"] call golib_saveCommonStorage;
	};

	if equals("missionName" call golib_getCommonStorageParam,"TEMP") then {
		["Initialize map name"] call printLog;
		call golib_setMapNameFromDisplay;
	};

	if (goasm_isbuilded) then {
		call golib_validateVersion;
	};

	(format["%3; Map ""%1"" (v%2)",
		"missionName" call golib_getCommonStorageParam,
		"version" call golib_getCommonStorageParam,
		Core_version_name
	]) call discrpc_editor_updateState;
}

function(golib_setMapNameFromDisplay)
{
	private _d = [[],[]] call displayOpen; 
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
		_back setBackgroundColor [0,0,0,1];

		_head = [_d,TEXT,[50-60/2,10,60,20]] call createWidget;
		[_head,"<t align='center' size='1.6'>Введите название проекта карты</t>"] call widgetSetText;
		_input = [_d,INPUT,[50-60/2,30,60,60]] call createWidget;
		_input ctrlSetFontHeight 0.5;

		_ok = [_d,BUTTON,[50-60/2,91,60,5]] call createWidget;
		_ok ctrlSetText "Создать";
		_ok setBackgroundColor [0,1,0,1];
		_ok setvariable ["_input",_input];
		_ok ctrladdeventhandler ["MouseButtonUp",{
			_input = (_this select 0) getvariable "_input";
			_text = ctrlText _input;
			if !([_text,"^[\w_]{3,32}$"] call regex_isMatch) exitWith {
				["One or more conditions are not met: The project name is from 4 to 32 characters; Only numbers, symbols of the English alphabet and underscores"] call printError;
			};

			golib_com_objectHash set ["missionName",_text];
			["Установка названия карты"] call golib_saveCommonStorage;
			nextFrame(displayClose);
		}];
}


function(golib_validateVersion)
{
	_curVers = "version" call golib_getCommonStorageParam;
	if (_curVers != Core_version_number) then {
		[format["Project version mismatch; Current %1; Need %2. Process update...",_curVers,Core_version_number],30] call showWarning;
	};

	if (_curVers > Core_version_number) exitWith {
		["System error - project version > core version ..."] call printError;
	};

	//version is actual
	if (_curVers == Core_version_number) exitwith {
		["Map file version actual: %1",_curVers] call printLog;
	};

	["Start update version from %1 to %2",_curVers,Core_version_number] call printLog;
	private _calledOnceFlag = false;
	while {_curVers < Core_version_number} do {
		_newVers = _curVers + 1;
		_calledOnceFlag = false;
		{
			[_x,_newVers] call golib_internal_handleVersionUpdate;
		} foreach (all3DENEntities select 0);
		
		
		_curVers = _newVers;
		golib_com_objectHash set ["version",_curVers];
		[format["Миграция версии с %1 до %2",_curVers-1,_curVers]] call golib_saveCommonStorage;
		["Version updated to %1",_curVers] call printLog;
	};

	["Версия карты обновлена. Сохраните, соберите карту и перезапустите редактор.",30] call showInfo;
}

//функция преобразования старого рандома в новый
function(golib_internal_gaussToLinear)
{
	params ["_val"];
	if isNull(golib_internal_randomConvTable) then {
		golib_internal_randomConvTable = createHashMapFromArray (call compile LOADFILE("src\Editor\Bin\RndConvTable.txt"));
	};
	_val = round _val;
	private _tvals = golib_internal_randomConvTable get _val;
	//For linear distribution between more than one values in table
	private _accVal = 0;
	{_accVal = _accVal + _x}foreach _tvals;
	_accVal / (count _tvals)
}

function(golib_internal_handleVersionUpdate)
{
	params ["_obj","_newVers"];
	private _hasHashData = [_obj,false] call golib_hasHashData;
	/*
		Во второй версии все частицы поменяли модели и добавились в слой Effects
		["ObjectTextureCustom0",""]
		["ObjectTextureCustom1","#(argb,8,8,3)color(1.0,0.0,0.4,1.0,co)"]
		["ObjectMaterialCustom0",""]
		["ObjectMaterialCustom1",""]
	 */
	if (_newVers == 2) exitWith {
		if !("Effects" call layer_isExists) then {
			["Effects"] call layer_create;
		};

		if (typeof _obj == "Land_ClutterCutter_small_F" && _hasHashData) exitWith {
			
			//replace model 
			private _pos = _obj call golib_om_getPosition;
			private _objNew = create3DENEntity ["Object","Land_VR_Block_02_F", _pos];
			
			if ((format["%1",_objNew]) == "<null>") exitWith {
			 	["Не удалось заменить модель при обновлении версии"] call showWarning;
			 	["Cant create eden entity by config %1. Update object failed",_val] call printError;
			};
			
			private _rot = _obj call golib_om_getRotation;
			private _data = [_obj,true] call golib_getHashData;
			delete3DENEntities [_obj];
			
			[_objNew,_data] call golib_setHashData;
			[_objNew,_pos] call golib_om_setPosition;
			[_objNew,_rot] call golib_om_setRotation;
			
			[_objNew] call golib_om_internal_handleTransformEvent;

			//update textures
			_objNew set3DENAttribute ["ObjectTextureCustom0",""];
			_objNew set3DENAttribute ["ObjectTextureCustom1","#(argb,8,8,3)color(1.0,0.0,0.4,1.0,co)"];
			_objNew set3DENAttribute ["ObjectMaterialCustom0",""];
			_objNew set3DENAttribute ["ObjectMaterialCustom1",""];

		   	//add object to layer
			[_objNew,"Effects"] call layer_addObject;

			[_objNew,true] call Core_initObjectEvents;

			["Updated object %1",_objNew] call printLog;
		};
		if (typeof _obj == "Land_VR_Block_02_F" && _hasHashData) exitWith {
			//update textures
			_obj set3DENAttribute ["ObjectTextureCustom0",""];
			_obj set3DENAttribute ["ObjectTextureCustom1","#(argb,8,8,3)color(1.0,0.0,0.4,1.0,co)"];
			_obj set3DENAttribute ["ObjectMaterialCustom0",""];
			_obj set3DENAttribute ["ObjectMaterialCustom1",""];

		   	//add object to layer
			[_obj,"Effects"] call layer_addObject;

			["(v2) Updated object %1",_obj] call printLog;
		};
	};
	/*
		В третьей версии исправляется проблема замены модели при обновлении объектов
		Если объект с классом имеет модель в хэшдате, равную базовой модели, определенной в классе - 
		сбрасываем избыточную установку модели из хэшдаты
		https://github.com/Relicta-Team/ReSDK_A3.vr/issues/20#issue-1814830351
	*/
	if (_newVers == 3) exitWith {
		
		if (!_hasHashData) exitwith {};

		private _data = [_obj,true] call golib_getHashData;

		private _class = _data get "class";
		private _props = _data get "customProps";

		if (!("class" in _data) || !("customProps" in _data)) exitwith {
			["Skip object %1 at %2",_obj,getposatl _obj] call printLog;
		};
		
		private _defModel = [_class,"model",true,"getModel"] call oop_getFieldBaseValue;
		if ("model" in _props && {_defModel == (_props get "model")}) then {
			_props deleteAt "model";
			[_obj,_data,true,"Обновление объекта до версии 3"] call golib_setHashData;
			["(v3) Updated object %1",_obj] call printLog;
		};
	};
	/*
		В четвертой версии заменяются модели соли, сахара и перца
		Так же удаляется устаревшая метадата о слоях
	*/
	if (_newVers == 4) exitwith {
		//cleanup map hash data
		if (!_calledOnceFlag) then {
			_calledOnceFlag = true;
			golib_com_objectHash deleteAt "layer_ptrToName";
			golib_com_objectHash deleteAt "layer_nameToPtr";
			[format["v%1 Удаление устаревших данных о слоях",_newVers]] call golib_saveCommonStorage;
		};
		//skip non-go objects
		if (!_hasHashData) exitwith {};

		private _class = [_obj] call golib_getClassName;
		if isNullVar(_class) exitwith {};
		if ([_class,"SaltShaker"] call oop_isTypeOf) then {
			private _newModel = [_class,"model",true] call oop_getFieldBaseValue;
			
			//cleanup model data
			private _data = [_obj,true] call golib_getHashData;
			_props = _data get "customProps";
			if ("model" in _props && {_newModel == (_props get "model")}) then {
				_props deleteAt "model";
				[_obj,_data,true,format["v%1 Очистка метаданных модели",_newVers]] call golib_setHashData;
			};
			
			//update world object
			[_obj,_newModel] call golib_om_replaceObject;

		};
	};
}