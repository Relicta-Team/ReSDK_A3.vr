// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define sizeof_float 5

/*
	Функция сборки карты в пригодный для выполнения в платформе формат

	Опции сборки
	no-success-info - без успешного вывода уведомления на экране
	no-bake-object-info - без лога запеченых объектов 
	no-ecode-logs - без логов сборки ecode-инструкций

	TODO
	build-all-maps - собрать все карты
*/
function(mm_build)
{
	private _buildOptions = _this;

	if (isNull(goasm_isbuilded) || {!goasm_isbuilded}) exitWith {
		["Сборка игровых объектов не выполнена. Запустите сборку игровых объектов"] call showWarning;
		false
	};

	["%1: Started map builder",__FUNC__] call printLog;

	mm_internal_errorCount = 0;
	mm_internal_threadErrorText = "";

	eden_enum_instancerNames = ["InitItem","InitStruct","InitDecor"];
	eden_debug_vuplist = [];

	mm_internal_allSpawnPoints = [];

	mm_internal_map_marks = hashSet_createEmpty();

	private _objList = [];
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				_objList pushBack _x;
			};
		};
	} foreach (all3DENEntities select 0);

	["%1: Collected %2 objects",__FUNC__,count _objList] call printLog;

	private _output = "";
	private _postoutput = ""+endl+endl+endl;
	_output = _output + format["__metaInfo__ = 'Builded on editor version: %1';",Core_version_name];
	_output = _output + format["__metaInfoVersion__ = %1;","version" call golib_getCommonStorageParam];
	_output = _output + "go_editor_globalRefs = createHashMap;";

	//generating headers opcodes
	_output = _output + endl+endl+ (call golib_getCodeCallers) + endl + endl;

	{
		_x call mm_handleObjectSave;
	} foreach _objList;

	_output = _output + _postoutput;

	if ((["FileManager","ExistsDir",[mm_folderSaveMaps],true] call rescript_callCommand)=="false") then {
		INC(mm_internal_errorCount);
		mm_internal_threadErrorText = mm_internal_threadErrorText + endl + "Path not exists: " + mm_folderSaveMaps;
	};

	//check filelock
	private _pathFull = mm_folderSaveMaps + "/" + ("missionName" call golib_getCommonStorageParam) + mm_internal_defaultMapExt;
	if ([_pathFull,false] call file_isLocked) then {
		INC(mm_internal_errorCount);
		mm_internal_threadErrorText = mm_internal_threadErrorText + endl + "Файл заблокирован на запись (требуется переключение активного окна): " + _pathFull;
	};

	if (mm_internal_errorCount > 0) exitWith {
		["Error count %1",mm_internal_errorCount] call printWarning;
		[mm_internal_threadErrorText] call printError;
		["Ошибка сборки карты. Смотрите логи"] call showWarning;
		false
	};

	// DEPRECATED solution for map saving
	//forceUnicode 1;
	//["FileManager","Write",[_pathFull,_output]] call rescript_callCommandVoid;
	//copyToClipboard _output;
	//["OOPBuilder","runsavemap",[getMissionPath "ScriptsEditor\SaveMapFromClip.exe",_pathFull]] call rescript_callCommandVoid; 

	//now we don't need using clipboard
	if !([_pathFull,_output,false] call file_write) exitwith {
		["Неизвестная ошибка при запаковке карты. Не удалось сохранить файл карты."] call showError;
		false
	};

	["Map builded"] call printLog;

	if !("no-success-info" in _buildOptions) then {
		["Карта запакована"] call showInfo;
	};

	true
}

function(mm_handleObjectSave)
{
	private _obj = _this;
	private _hash = [_obj,false] call golib_getHashData;
	if (count _hash == 0) exitWith {
		INC(mm_internal_errorCount);
		mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
		format["Cant find hash data for object %1 at position %2",_obj,getposatl _obj];
	};

	if !((_hash get "class") call oop_reflect_hasClass) exitwith {
		INC(mm_internal_errorCount);
		mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
		format["Cant find class '%3' for object %1 at position %2. Require start validator for dead classes",_obj,getposatl _obj,_hash get "class"];
	};

	private _class = _hash get "class";

	_instancer = eden_enum_instancerNames select (
		[_class,"",true,"getChunkType"] call oop_getFieldBaseValue
	);

	_tab = toString [9];
	_counterNotNeedLvar = 0;

	_realocModel = "";
	_isEffectModel = false;

	//reassign model
	private _mpath = [_class,"model",true,"getModel"] call oop_getFieldBaseValue;
	//_mpath = [_obj,"model"] call golib_getActualDataValue;
	
	if ((_mpath select [0,1]) == "\") then {
		_mpath = _mpath select [1,count _mpath];
	};
	private _model = if (".p3d" in _mpath) then {(getModelInfo _obj) select 1} else {typeOf _obj}; //не для пути модели используем сравнение по классу
	if ((_model select [0,1]) == "\") then {
		_model = _model select [1,count _model];
	};
	_isEffectModel = "land_vr_block_" in (tolower typeof _obj);
	if (_mpath != _model && !_isEffectModel) then {
		INC(_counterNotNeedLvar);
		_realocModel = _model;
	};
	

	_pos = getPosATL _obj;
	_vdir = getDir _obj;
	_vup = vectorUp _obj;

	_randSpawn= false;
	_randSpawnString = "";
	_randPos = false;
	_randPosString = "";
	_objcustomdata = [];
	_initCodeArgs = [];
		_addPreInitHandler = false;

	if (_realocModel != "") then {
		_initCodeArgs pushBackUnique (format["%1 setvariable ['%2','%3'];",'_thisObj','model',_realocModel])
	};
	
	private _customProps = _hash getOrDefault ["customProps",[]];

	//get native preinit vars
	private _sysvars = [];
	{
		_arrAdd = ([_x,"__handleNativePreInitVars__"] call oop_getTypeValue);
		if !isNullVar(_arrAdd) then {
			if equalTypes(_arrAdd,{}) then {
				_sysvars append (call _arrAdd);
			};
		};
		if (_x == "gameobject") then {break};
	} foreach ([_class,"__inhlist"] call oop_getTypeValue);
	_sysvars = _sysvars apply {tolower _x};
	_sysvars = _sysvars arrayintersect _sysvars;
	
	{
		[_x,_y] params ["_name","_val"];

		if (_x == "spawnPointName" && _class == "SpawnPoint") then {
			private _ind = mm_internal_allSpawnPoints findif {_x == _val};
			
			if (_ind != -1) exitWith {
				INC(mm_internal_errorCount);
				mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
				format["SpawnPoint '%1' double define at position %2",_val,getposatl _obj];
			};
			if (":" in _val) exitWith {
				INC(mm_internal_errorCount);
				mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
				format["SpawnPoint '%1' unexpected name at %2: Forbidden character in the point name ':'",_val,getposatl _obj];
			};
			mm_internal_allSpawnPoints pushBack _val;
		};
		if (_class == "CollectionSpawnPoint" && {_x == "spawnPointName"}) then {
			if (":" in _val) exitWith {
				INC(mm_internal_errorCount);
				mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
				format["CollectionSpawnPoint '%1' unexpected name at %2: Forbidden character in the point name ':'",_val,getposatl _obj];
			};
		};

		if equalTypes(_val,"") then {
			_val = str _val;
		};

		//model decl inside marks sys
		if (_x == "model") then {continue};
		if (_x == "light") then {
			private _realVal = _val select [1,count _val-2];
			private _cfgName = [_realVal,"#ERR#"] call vcom_emit_io_parseScriptedConfigName;
			if (_cfgName != "#ERR#") then {
				_val = format["%1 call lightSys_getConfigIdByName",_val];
				if !(call vcom_emit_io_isEnumConfigsLoaded) then {
					[true] call vcom_emit_io_loadEnumAssoc;
				};
				private _idxlight = (keys vcom_emit_io_enumAssocKeyStr) findif {_cfgName==_x};
				if (_idxlight == -1) exitWith {
					INC(mm_internal_errorCount);
					mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
					format["Non-existing light type '%1' for object at position '%2'",_realVal,getposatl _obj];
					continue;
				};
			} else {
				INC(mm_internal_errorCount);
				mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
				format["Wrong light type '%1' for object at position '%2'",_val,getposatl _obj];
				continue;
			};
		};
		if ("preinit@" in _x) then {
			_addPreInitHandler = true;
			_initCodeArgs pushBackUnique (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (tolower _x in _sysvars) then {
			_addPreInitHandler = true;
			_initCodeArgs pushBackUnique (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (_x == "lightIsEnabled" || _x == "light") then {
			_initCodeArgs pushBackUnique (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (_x == "__effinit") then {
			INC(_counterNotNeedLvar);
			_objcustomdata pushBack (format["[%1,%2] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'setEffectType');","%1",_val]);
			continue;
		};

		_objcustomdata pushBackUnique (format["%1 setvariable ['%2',%3];","%1",_name,_val]);

		INC(_counterNotNeedLvar);
	} foreach _customProps;

	if ((_class == "SpawnPoint" || _class == "CollectionSpawnPoint") && !("spawnpointname" in (_customProps))) exitWith {
		INC(mm_internal_errorCount);
		mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
		format["%2 empty name at position %1",getposatl _obj,_class];
	};

	_code_init = _hash get "code_onInit";
	_tryErrorOnInit = false;
	_customCodeOnInit = "";
	if !isNullVar(_code_init) then {
		_retStrCode = [_code_init,
			!("no-ecode-logs" in _buildOptions)
		] call golib_code_prepareInstructions;
		if (_retStrCode == "!ERROR!") exitWith {
			_tryErrorOnInit = true;
			INC(mm_internal_errorCount);
			mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
		format["Class '%1' init code parsing error at position %2",_class,getposatl _obj];
		};

		INC(_counterNotNeedLvar);

		_objcustomdata pushBackUnique "";
		_customCodeOnInit = _retStrCode;
	};

	private _script = _hash get "__scriptName";
	private _scriptParams = _hash get "__scriptParams";
	private _scriptCode = "";
	if !isNullVar(_script) then {
		INC(_counterNotNeedLvar);
		_objcustomdata pushBackUnique "";
		private _sparams = ifcheck(isNullVar(_scriptParams),"nil",str _scriptParams);
		_scriptCode = format["['%1',%2,%3] call createGameObjectScript;",_script,"%1",_sparams];
	};

	//?? -----------------check edConnected
	_edConnected = _hash get "edConnected";
	if !isNullVar(_edConnected) then {
		{
			INC(_counterNotNeedLvar);
			_objcustomdata pushBackUnique (format["[%1,go_editor_globalRefs get ""%2""] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'addConnection');","%1",_x]);
		} foreach _edConnected;
	};

	//?? ---- container content
	_containerContent = _hash get "containerContent";
	if !isNullVar(_containerContent) then {
		private _pre = "";
		private _post = "";
		{
			_pre = "";
			_post = "";
			INC(_counterNotNeedLvar);
			_x params ["_hashitem","_count"];
			_hashitem = _hashitem call golib_deserializeHashData;
			//'createItemInContainer',["Key",5,100,[["var","name","Ключ от клеток"],["var","keyOwner",["sbskletka"]]]]
			_stringStruct = format["'%1',%2,%3",_hashItem get "class",_count,_hashItem getOrDefault ["prob",100]];
			_arrAtrs = [];
			{
				[_x,_y] params ["_key","_val"];
				//if equalTypes(_val,"") then {
					//_val = str _val;
				//};
				_arrAtrs pushback ["var",_key,_val];
				
			} foreach (_hashItem get "customProps");

			if (count _arrAtrs > 0) then {
				_stringStruct = _stringStruct + "," + str _arrAtrs;
			};

			if ("mark" in _hashItem) then {
				_pre = "private _ccit = ";
				_post = format[" go_editor_globalRefs set [""%1"",%2];",_hashItem get "mark","_ccit"];
				if ((_hashItem get "mark") in mm_internal_map_marks) exitWith {
					INC(mm_internal_errorCount);
					mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
					format["Container item mark '%1' duplicate name",_hashItem get "mark"];
				};
				hashSet_add(mm_internal_map_marks,_hashItem get "mark");
			};

			_objcustomdata pushBackUnique (format["%3[%1,%2] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'createItemInContainer');%4","%1",_stringStruct,_pre,_post]);
		} foreach _containerContent;
	};


	if (_tryErrorOnInit) exitWith {};

	_atlPos = (getPosATL _obj);
	_poses = ((_atlPos select 0) toFixed sizeof_float) + ((_atlPos select 1) toFixed sizeof_float) + ((_atlPos select 2) toFixed sizeof_float);
	
	_varname = "_" + (_poses splitString "-." joinString "_");

	//!THIS IS GLOBAL REFERENCE
	_registeredMark = "";

	if ("rdir" in _hash) then {
		_vdir = "random 360";
	};
	if ("prob" in _hash) then {
		_randSpawn = true;
		_val = (_hash get "prob") / 100; //проценты в нормализованные знач.
		_randSpawnString = format["if ((random 1) < %1) then {" + endl + _tab + "%2};" + endl,_val,"%1"];
	};
	if ("rpos" in _hash) then {
		_val = (_hash get "rpos");
		_randPos = true;
		_randPosString = format["%1 call{__v = _this select [0,3];__r = random 360;__v = __v vectorAdd [sin __r * %2,cos __r * %2,0];if (count _this > 3) then {__v = __v + [true]};__v}","%1",_val];
	};
	if ("mark" in _hash) then {
		_registeredMark = _hash get "mark";
		_initCodeArgs pushBackUnique format["go_editor_globalRefs set [""%1"",%2];",_registeredMark,"_thisObj"] + endl;
		if ((_hash get "mark") in mm_internal_map_marks) exitWith {
			INC(mm_internal_errorCount);
			mm_internal_threadErrorText = mm_internal_threadErrorText + endl +
			format["Object mark '%1' duplicate name",_hash get "mark"];
		};
		hashSet_add(mm_internal_map_marks,_hash get "mark");
	};

	if not_equals(_vup,[0 arg 0 arg 1]) then {
			_pos = (getPosWorld _obj) + [true]; //convert poscoords
		};
		__probNewDir = vectorDir _obj;
		//if equals((__probNewDir select 2)toFixed 1,"-1") then {
		// THIS IS ACTUAL ALGORITHM OF VECDIR COLLECT DATA ON OBJECTS
		_zPosVDir = parseNumber((__probNewDir select 2) toFixed 1);
		
		private _editedVdir = false;
		if equalTypes(_vdir,"") then {_editedVdir = true}; //if rdir enabled then do not override vdir 

		if (_zPosVDir <= -0.85 || _zPosVDir >= 0.85 && !_editedVdir) then {
			_vdir = __probNewDir;
			_editedVdir = true;
			eden_debug_vuplist pushBack _obj;
		};

		//---------- rule2 transform serialization check 
		if (mm_use_alg2_vdir_check) then {
			private _transformVec = _obj call core_getPitchBankYaw;//do not use relative transform: _obj call golib_om_getRotation;
			//if (!_editedVdir && {(_transformVec select [0,2] apply {(abs _x) toFixed 0}) isNOTEQUALTO ["0","0"]}) then {
			if (!_editedVdir && {{_x=="0"}count(_transformVec apply {(abs _x) toFixed 0})<2 }) then {
				//post comparator rule: 2 fixed elements equals
				private _tempRes = 0;
				private _cmparr = _transformVec apply {_tempRes=parseNumber(abs _x toFixed 0);ifcheck(_tempRes<=2,"0",_tempRes toFixed 0)};
				private _condit = false;
				{
					private _thisX = _x;
					if ({_x == _thisX}count _cmparr >= 2) exitwith {_condit = true};
				} foreach _cmparr;
				if (_condit) exitwith {}; //exit from vdir check scope

				_vdir = __probNewDir;//(str __probNewDir) +"/* "+str _cmparr+" */" ;
				_editedVdir = true;
				eden_debug_vuplist pushBack _obj;
			};
		};

	_addictPost = "";
	if (_realocModel != "") then {
		_addictPost = "// !!! realocated model !!!";
	};
	if (_isEffectModel) then {
		_addictPost = "// Effect";
	};

	if (_addPreInitHandler) then {
		_initCodeArgs pushBack (
			format["%1 call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable '__handlePreInitVars__');","_thisObj"]
		);
	};

	//pre init code initializer
	_initCode = if (count _initCodeArgs > 0) then {", {" + (_initCodeArgs joinString " ")+"}"} else {""};

	//BINARIZE
	if (_counterNotNeedLvar > 0) then {
		//do need create lvar
		
		if (_randPos) then {
			_pos = format[_randPosString,_pos];
		};	
		
		_inst = format["['%1',%2,%3,%4%7] call %5; %6" + endl,_class,_pos,_vdir,_vup,_instancer,_addictPost,_initCode];

		if (_randSpawn) then {
			_inst = format[_randSpawnString,_inst];
		};

		_output = _output + format["%1 = %2",_varname,_inst];

		if (count _objcustomdata > 0) then {
			_postoutput = _postoutput + format["if (!isNil'%1') then {" + endl,_varname];

			{
				_postoutput = _postoutput + _tab + format[_x,_varName] + endl;
			} foreach _objcustomdata;

			

			if (_customCodeOnInit != "") then {
				_postoutput = _postoutput + "_o="+_varName+";"+endl;
				_postoutput = _postoutput + _customCodeOnInit + endl;
			};

			if (_scriptCode != "") then {
				_postoutput = _postoutput + (format[_scriptCode,_varName]) + endl;
			};
			
			_postoutput = _postoutput + "};" + endl;
		};

	} else {

		if (_randPos) then {
			_pos = format[_randPosString,_pos];
		};

		_inst = format["['%1',%2,%3,%4%7] call %5; %6" + endl,_class,_pos,_vdir,_vup,_instancer,_addictPost,_initCode];

		if (_randSpawn) then {
			_inst = format[_randSpawnString,_inst];
		};

		//not need create lvar
		_output = _output + _inst;
	};


	if !("no-bake-object-info" in _buildOptions) then {
		["Baked %1 (%2/%3)",_obj,_foreachIndex+1,count _objList] call printLog;
	};

	
}

function(mm_openMapSelector)
{

	if (golib_hasUnsavedChanges) then {
		[ 
			"У вас есть несохраненные изменения в вашей карте. Нажмите ""Загрузить"" для принудительной загрузки выбранной карты (все несохраненные данные будут утеряны), либо ""Отмена"" для отмены загрузки.", 
			"ReEditor - Загрузка карты", 
			[ 
				"Загрузить", 
				{ 
					do3DENAction "MissionSave";
					(call mm_openMapSelector_Internal);
				} 
			], 
			[ 
				"Отмена", 
				{ } 
			], 
				"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
				findDisplay 313 
		] call createMessageBox;
	} else {
		call mm_openMapSelector_Internal;
	};
	
}

function(mm_openMapSelector_Internal)
{
	//enumerate map files
	[
		([core_path_maps] call file_getFileList)
			apply {[[_x,"\.\w+$/",''] call regex_replace,_x]},
		{
			//_data - is filename
			_loadPath = core_path_maps +"\"+ _data;

			_loader = {
				params ["_loadPath"];
				[displayNull] call loadingScreen_start;
				[10,"Загрузка карты: " + _loadPath] call loadingScreen_setProgress;

				[_loadPath,"mission.sqm",true,{
					
					[100,"Карта загружена. Перезапускаем редактор..."] call loadingScreen_setProgress;
					_postSuccess = {
						call loadingScreen_stop;
						[false] spawn Core_reloadEditorFull;
					};
					invokeAfterDelay(_postSuccess,2);
				},{
					[90,"Ошибка загрузки карты. Повторите попытку"] call loadingScreen_setProgress;
					invokeAfterDelay(loadingScreen_stop,2);
				}] call file_copyAsync;
			}; 
			nextFrameParams(_loader,_loadPath);
		},
		{},//close
		{},//selchanged
		"Выберите загружаемую карту"
	] call control_createList;
}

function(mm_createNewMapSelector)
{

	// обязательный запрос на подтверждение
	if (golib_hasUnsavedChanges || true) then {
		[ 
			"Все несохранённые данные будут удалены при создании новой карты. Нажмите ""Создать"" для создания карты, либо ""Отмена"" для отмены операции.", 
			"ReEditor - Создание новой карты", 
			[ 
				"Создать", 
				{ 
					do3DENAction "MissionSave";
					nextFrame(mm_createNewMapSelector_Internal);
				} 
			], 
			[ 
				"Отмена", 
				{ } 
			], 
				"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
				findDisplay 313 
		] call createMessageBox;
	} else {
		call mm_createNewMapSelector_Internal;
	};
}

function(mm_createNewMapSelector_Internal)
{
	[displayNull] call loadingScreen_start;
	
	private _loadPath = core_path_mapTemplateFile;
	
	[10,"Запуск процедуры создания карты"] call loadingScreen_setProgress;

	private _handled = [_loadPath,"mission.sqm",true,{
		
		[100,"Карта создана. Перезапускаем редактор..."] call loadingScreen_setProgress;
		_postSuccess = {
			call loadingScreen_stop;
			[false] spawn Core_reloadEditorFull;
		};
		invokeAfterDelay(_postSuccess,2);
	},{
		[90,"Ошибка создания карты. Повторите попытку"] call loadingScreen_setProgress;
		invokeAfterDelay(loadingScreen_stop,2);
	}] call file_copyAsync;

	if !(_handled) then {
		[50,"Ошибка создания. Процедура не выполнена"] call loadingScreen_setProgress;
		invokeAfterDelay(loadingScreen_stop,2);
	};
}

function(mm_saveCurrentMapToFile)
{
	params [["_showMessage",true]];
	private _mapName = "missionName" call golib_getCommonStorageParam;
	private _savePath = core_path_maps + "/" + _mapName + core_path_binarizedMapFileExt;
	if ([_savePath] call file_isLocked) exitwith {
		if (_showMessage) then {
			[format["Не удалось сохранить карту '%1'. Файл карты недоступен для записи. Повторите попытку.",_mapName]] call showError;
		};
	};
	
	private _result = ["mission.sqm",_savePath] call file_copy;

	if (_showMessage) then {
		if (_result) then {
			[format["Файл карты '%1' сохранен",_mapName]] call showInfo;
		} else {
			[format["Не удалось сохранить файл карты '%1'",_savePath]] call showError;
		};
		
	};

	["%1 - saving result %2",__FUNC__,_result] call printTrace;
}

function(mm_debug_createCopy)
{
	private _todel = _this;
	if not_equalTypes(_todel,0) then {_todel = 5};
	if isNullVar(_todel) then {_todel = 5};
	
	{
		_o = _x; 

		_pos = getPosWorld _o;
		_vecs = [vectordir _o,vectorup _o];

		_no = createSimpleObject[getModelInfo _o select 1,[0,0,0]];
		mm_debug_internal_testobj = _no;
		_no setPosWorld _pos;
		_no setVectorDirAndUp _vecs;
		_h = [_no,_todel] SPAWN {
			params ["_no","_todel"];
			uiSleep _todel;
			deleteVehicle _no;
		};
	} foreach (get3denselected "" select 0);
}


#undef sizeof_float
