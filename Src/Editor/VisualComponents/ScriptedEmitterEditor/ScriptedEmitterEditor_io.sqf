// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Логика работы:
		Открытие редактора:
			1. При открытии читаем файлы конфигов света
			2. Парсим их в структуры
		Закрытие редактора:
			1. Сериализуем все данные обратно в файлы
		
		...
	
	regScriptEmit(name) //ineditor: start of cfg location
		["pt",
			[custom events], //function reference on special conditions
			_emitAlias("Частица 1")
			["setParticleParams",[...]],
			["setParticleRandom",[...]],
			...
		],
		["lt",
			null // if null - no custom events
			["setLightColor",[...]],
			["setLightAttenuation",[...]]
		],
		[..etc type]
		
	endScriptEmit //ineditor: eocfg location
*/

//активирует трассировочные сообщения чтения/записи конфигов
//#define ENABLE_TRACE_MESSAGES_IOCFG
//Активирует трассировочные сообщения чтения файла конфигурации
#define ENABLE_TRACE_MESSAGES_CFGLOADER

init_function(vcom_emit_io_initialize)
{
	vcom_emit_io_configFilesFormatter = "src\client\LightEngine\ScriptedConfigs\%1";
	vcom_emit_io_configFileNamePathFormatter = "src\client\LightEngine\ScriptedConfigs\%1.sqf";

	vcom_emit_io_configsDirectory = "src\client\LightEngine\ScriptedConfigs";

	vcom_emit_io_map_configs = createHashMap;
		//ключ в верхнем регистре, знач. массив элементов: type, typeshort, customEvents, alias, settings
	vcom_emit_io_list_allConfigsNames = []; //имена в нижнем регистре (для поиска)

	vcom_emit_const_lightInfo = [
		"setLightColor",
		"setLightAmbient",
		"setLightIntensity",
		"setLightUseFlare",
		"setLightFlareSize",
		"setLightFlareMaxDistance",
		"",//daylight<notused>
		"setLightAttenuation",
		"setLightConePars"
	];
	vcom_emit_const_particleInfo = [
		"setParticleParams",
		"setParticleRandom",
		"setParticleCircle",
		"",//particleFile<notused>
		"setDropInterval"
	];
	vcom_emit_const_directLightInfo = array_copy(vcom_emit_const_lightInfo);
	array_remlast(vcom_emit_const_lightInfo);

	vcom_emit_io_currentConfig = ""; //uppercase

	vcom_emit_io_internal_isCfgListLoaded = false;

	//enum info
	vcom_emit_io_enumAssocKeyStr = createHashMap;
	vcom_emit_io_enumAssocKeyInt = createHashMap;//int is string...

	vcom_emit_io_internal_isEnumAssocLoaded = false;
}

function(vcom_emit_io_hasConfig) {(tolower _this) in vcom_emit_io_list_allConfigsNames}

function(vcom_emit_io_isEditConfig) {vcom_emit_io_currentConfig!=""}

function(vcom_emit_io_isConfigsLoaded) {vcom_emit_io_internal_isCfgListLoaded}

function(vcom_emit_io_isEnumConfigsLoaded) {vcom_emit_io_internal_isEnumAssocLoaded}

function(vcom_emit_io_loadEnumAssoc)
{
	params [["_fromFile",true]];
	
	vcom_emit_io_enumAssocKeyStr = createHashMap;
	vcom_emit_io_enumAssocKeyInt = createHashMap;

	private _flist = [vcom_emit_io_configsDirectory,true,"*.sqf",true] call file_getFileList;
	if (count _flist == 0) exitWith {
		["Light configs not found"] call showError;
	};
	private _patHeader = "regScriptEmit\(SLIGHT_(\w+)\)";

	private _cfgIndex = 2100;
	{
		_fp = format[vcom_emit_io_configFilesFormatter,_x];
		private _content = [_fp] call file_read;
		if (_content=="") exitWith {
			setLastError("Cannot load file " + _fp);
		};
		if !([_content,_patHeader] call regex_isMatch) exitWith {
			setLastError("Cannot load config name from " + _fp);
		};
		private _name = [_content,_patHeader,1] call regex_getFirstMatch;
		private _valStr = str _cfgIndex;

		vcom_emit_io_enumAssocKeyStr set [_name,_valStr];
		vcom_emit_io_enumAssocKeyInt set [_valStr,_name];

		INC(_cfgIndex);
	} foreach _flist;

	vcom_emit_io_internal_isEnumAssocLoaded = true;
}

//!deprecated function
function(vcom_emit_io_parseConfigName)
{
	params ["_cfg",["_customFormatOnErr","%1"]];
	if ([_cfg,"^SLIGHT_(\w+)$"] call regex_isMatch) then {
		[_cfg,"^SLIGHT_(\w+)$",1] call regex_getFirstMatch
	} else {
		format[_customFormatOnErr,_cfg]
	};
}

//возвращает имя конфига без префикса slight_
function(vcom_emit_io_parseScriptedConfigName)
{
	params ["_cfg",["_customFormatOnErr","%1"]];
	if ([_cfg,"SLIGHT_(\w+)\b"] call regex_isMatch) then {
		[_cfg,"SLIGHT_(\w+)\b",1] call regex_getFirstMatch
	} else {
		format[_customFormatOnErr,_cfg]
	};
}

//Возвращает массив с файлами загрузчика
function(vcom_emit_io_readConfigLoader)
{
	params ["_cfgDir"];
	#ifdef ENABLE_TRACE_MESSAGES_CFGLOADER
	["Start %1",__FUNC__] call printTrace;
	#endif

	private _output = [];

	private _flist = [_cfgDir,true,"*.sqf",true] call file_getFileList;
	if (count _flist == 0) exitWith {
		["Light configs not found"] call showError;
		_output
	};

	{
		_fp = format[vcom_emit_io_configFilesFormatter,_x];
		private _content = [_fp] call file_read;
		if (_content=="") exitWith {
			setLastError("Cannot load file " + _fp);
		};
		_output append (_content splitString endl);
	} foreach _flist;

	#ifdef ENABLE_TRACE_MESSAGES_CFGLOADER
	["End %1; Count: %2",__FUNC__,count _output] call printTrace;
	#endif

	_output;
}

//безблокировочное чтение конфигов
function(vcom_emit_io_readConfigs)
{
	vcom_emit_io_map_configs = createHashMap;
	vcom_emit_io_list_allConfigsNames = [];

	//get configs
	private _cfgData = [vcom_emit_io_configsDirectory] call vcom_emit_io_readConfigLoader;


	private _isInMLComment = false;
	private _isInConfig = false;
	private _isReadConfig = false;
		private _const_patHeadCfg = "\s*regScriptEmit\(SLIGHT_(\w+)\)/";
		private _const_patFootCfg = "\s*endScriptEmit";
		private _const_patEmitAlias = "\s*_emitAlias\(\""(.*)\""\)/";
		private _const_patAnySetting = "(\s*\[\""(\w+)\""\s*\,(.*))\]\,?";
		private _curConfigName = "<NOT_IN_CONFIG>";

		private _configSegments = [];
		private _readConfigSegment = false;
		private _segZoneIdx = 0;
		private _segZoneData = [];
		private _segZoneDataSettings = [];
	{
		if ([_x,"^[\t ]*\/\//"] call regex_isMatch) then {
			#ifdef ENABLE_TRACE_MESSAGES_IOCFG
			["skip line>>> %1",_x] call printTrace;
			#endif
			continue;
		};
		if ([_x,"\/\*/"] call regex_isMatch) then {
			if (_isInMLComment) exitwith {
				setLastError("Pasring error. Check multiline comments at: " + _x);
			};
			#ifdef ENABLE_TRACE_MESSAGES_IOCFG
			["skip mlcom>>> %1",_x] call printTrace;
			#endif
			_isInMLComment = true;
			// continue;// for ml com in one line
		};
		if ([_x,"\*\//"] call regex_isMatch && _isInMLComment) then {
			#ifdef ENABLE_TRACE_MESSAGES_IOCFG
			["skip mlcom_close>>> %1",_x] call printTrace;
			#endif
			_isInMLComment = false;
			continue;
		};
		if (_isInMLComment) then {
			#ifdef ENABLE_TRACE_MESSAGES_IOCFG
			["skip inml>>> %1",_x] call printTrace;
			#endif
			continue;
		};
		if ([_x,_const_patHeadCfg] call regex_isMatch && !_isReadConfig) then {
			_isReadConfig = true;
			_isInConfig = true;
			_segZoneIdx = 0;
			_curConfigName = [_x,_const_patHeadCfg,1] call regex_getFirstMatch;
			if ((tolower _curConfigName) in vcom_emit_io_list_allConfigsNames) exitwith {
				setLastError("Config already exists: "+_curConfigName);
			};
			#ifdef ENABLE_TRACE_MESSAGES_IOCFG
			["!!! start reading config: %1",_curConfigName] call printTrace;
			#endif
			continue;
		};
		if (_isReadConfig) then {
			if ([_x,"\s*\,?\["] call regex_isMatch && !_readConfigSegment) then {
				#ifdef ENABLE_TRACE_MESSAGES_IOCFG
				["open segment >>> %1",_x] call printTrace;
				#endif
				_readConfigSegment = true;
				continue;
			};
			if (_readConfigSegment) then {
				//particle type
				if (_segZoneIdx == 0) exitwith {
					_type = [_x,"\s*""(\w+)""/",1] call regex_getFirstMatch;
					if !(_type in vcom_emit_assocCfgNameShortToFull) exitwith {
						setLastError("Unknown emitter type - "+_type);
					};
					_segZoneData pushBack ["type",vcom_emit_assocCfgNameShortToFull get _type];
					_segZoneData pushBack ["typeshort",_type];
					#ifdef ENABLE_TRACE_MESSAGES_IOCFG
					["read ptype >>> %1",_type] call printTrace;
					#endif
					INC(_segZoneIdx);
					continue;
				};
				//reading custom scripted events
				if (_segZoneIdx == 1) exitwith {
					_cevents = [_x,"(?:\s*)(.*)(?!\,)/",1] call regex_getFirstMatch;
					if !([_cevents,","] call stringEndWith) exitwith {
						setLastError("Config custom events reading error from " + _curConfigName);
					};
					
					//endline removing last ','
					_cevents = _cevents select [0,count _cevents-1];

					_segZoneData pushBack ["customEvents",_cevents];
					#ifdef ENABLE_TRACE_MESSAGES_IOCFG
					["read events >>> %1",_cevents] call printTrace;
					#endif
					INC(_segZoneIdx);
					continue;
				};
				if ([_x,_const_patEmitAlias] call regex_isMatch) exitwith {
					if (_segZoneData findif {(_x select 0)== "alias"}!=-1) exitwith {
						setLastError("Alias double defile:" + _curConfigName);
					};
					_alias = [_x,_const_patEmitAlias,1] call regex_getFirstMatch;
					_segZoneData pushBack ["alias",_alias];
					#ifdef ENABLE_TRACE_MESSAGES_IOCFG
					["read alias >>> %1",_alias] call printTrace;
					#endif
					INC(_segZoneIdx);
					continue;
				};
				if ([_x,_const_patAnySetting] call regex_isMatch) exitwith {
					//_data = [_x,_const_patAnySetting,1] call regex_getFirstMatch;
					_nameSet = [_x,_const_patAnySetting,2] call regex_getFirstMatch;
					_valSet = [_x,_const_patAnySetting,3] call regex_getFirstMatch;

					_segZoneDataSettings pushBack [_nameSet,_valSet];
					#ifdef ENABLE_TRACE_MESSAGES_IOCFG
					["read setting >>> name: %1 with value %2",_nameSet,_valSet] call printTrace;
					#endif
					INC(_segZoneIdx);
					continue;
				};
				if ([_x,"\s*\]"] call regex_isMatch) then {
					#ifdef ENABLE_TRACE_MESSAGES_IOCFG
					["close segment >>> %1",_x] call printTrace;
					#endif
					_segZoneData pushBack ["settings",_segZoneDataSettings];
					_configSegments pushBack _segZoneData;
					_readConfigSegment = false;

					_segZoneDataSettings = [];
					_segZoneData = [];
					_segZoneIdx = 0;

					continue;
				};
			};//zone segment read

			if ([_x,_const_patFootCfg] call regex_isMatch) then {
				#ifdef ENABLE_TRACE_MESSAGES_IOCFG
				["done read config %1; Data: %2",_curConfigName,_configSegments] call printTrace;
				#endif
				vcom_emit_io_map_configs set [_curConfigName,_configSegments apply {createHashMapFromArray _x}];
				vcom_emit_io_list_allConfigsNames pushBack (tolower _curConfigName);
				
				_curConfigName = "<NOT_IN_CONFIG>";
				_configSegments = [];
				_isReadConfig = false;
				_isInConfig = false;
				continue;
			};

		};//config zone read
		#ifdef ENABLE_TRACE_MESSAGES_IOCFG
		["read>>> %1",_x] call printTrace;
		#endif

		if (!_isInConfig) then {
			[("Parsing error. Wrong line: " + _x)] call printError;
			continue;
		};

	} foreach _cfgData;

	#ifdef ENABLE_TRACE_MESSAGES_IOCFG
	["======================== Done; Read %1 cfgs",count vcom_emit_io_list_allConfigsNames] call printTrace;
	#endif

	vcom_emit_io_internal_isCfgListLoaded = true;
}

//сохранятор конфигов. vcom_emit_io_list_allConfigsNames для сохранения всех конфигов. имена конфигов без префиксов
function(vcom_emit_io_saveAllConfigs)
{
	params ["_cfgListLoader"];
	if (count vcom_emit_io_map_configs == 0) exitWith {
		["%1 - no configs found",__FUNC__] call printError;
	};
	
	private _tabSim = toString[9];
	private _output = "";
	private _copyright = ["src\Editor\Bin\copyright.sqf"] call file_read;

	private _checkNeedCommaSetting = {
		#define __strcomma ","
		ifcheck(_foreachindex == ((count _settings)-1),"",__strcomma)
	};
	private _checkNeedCommaData = {
		//ifcheck(_foreachindex == ((count _data) - 1),"",",")
		","
	};
	private _configId = vcom_emit_minConfigId;
	{
		if (_configId > vcom_emit_maxConfigId) exitwith {
			setLastError(__FUNC__ + " - Maximum emitters config reached");
		};

		private _name = toUpper _x;
		private _data = vcom_emit_io_map_configs get _name;
		
		private _fullName = "SLIGHT_"+_name;
		
		if (count _data > 0) then {
			_output = ""; //cleanup output

			private _cfgSaveName = format[vcom_emit_io_configFileNamePathFormatter,_fullName];

			modvar(_output) + endl + (format["regScriptEmit(%1)",_fullName]);

			INC(_configId);

			{
				modvar(_output) + endl + _tabSim + ifcheck(_foreachindex==0,"",__strcomma) + "[";
				
				private _tp = _x get "typeshort";
				modvar(_output) + endl + _tabSim+_tabSim + str _tp + (call _checkNeedCommaData);
				if ("customEvents" in _x) then {
					//без табов потому что данные сырые
					modvar(_output) + endl + _tabSim+_tabSim + (_x get "customEvents") + (call _checkNeedCommaData);
				};
				if ("alias" in _x) then {
					modvar(_output) + endl + _tabSim+_tabSim + (format["_emitAlias(%1)",str(_x get "alias")]);
				};
				private _settings = _x get "settings";
				{
					_x params ["_k","_v"];
					modvar(_output) + endl + _tabSim+_tabSim + 
						format["[%1,%2]%3",str _k,call compile _v,call _checkNeedCommaSetting];
				} foreach _settings;

				modvar(_output) + endl + _tabSim + "]";
			} foreach _data;

			modvar(_output) + endl + "endScriptEmit";

			[_cfgSaveName,_copyright+_output] call file_write;
		};
		

	} foreach _cfgListLoader;
		
	//reload enums
	call vcom_emit_io_loadEnumAssoc;

	if (lsim_mode) then {
		call lsim_internal_buildScriptedConfigs;
		call lsim_internal_rebuildAllLights;
	};	
}

function(vcom_emit_io_openWindow_selectConfigLoad)
{
	call wch_enable;
	
	private _back = [call vcom_getDisplay,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_back setBackgroundColor [0.8,0.8,0.8,0.9];
	(call wch_getControlStorage) pushBack _back;

	private _listCtg = [
		vcom_emit_io_list_allConfigsNames apply {toUpper _x},
		{
			//on select
			call wch_disable;

			[_text] call vcom_emit_io_loadConfigCheck;
		},
		{
			//on close
			call wch_disable;
		},
		null,
		"Выберите подходящий конфиг",
		{
			ctrlsetfocus _butCan;
		},
		null,
		call vcom_getDisplay
	] call control_createList;

	(call wch_getControlStorage) pushBack _listCtg;
}

function(vcom_emit_io_loadConfigCheck)
{
	params ["_name"];
	
	call Core_pushContext;
	if (call vcom_emit_io_isEditConfig) then {
		[ 
			"Вы уверены? Несохраненные данные будут утеряны.", 
			"Загрузка конфига", 
			[ 
				"Загрузить", 
				{ 
					private _name = "_name" call Core_getContextVar;
					call Core_popContext;
					[_name] call vcom_emit_io_loadConfig;
				} 
			], 
			[ 
				"Отмена", 
				{
					call Core_popContext;
				} 
			], 
			"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
			call vcom_getDisplay
		] call createMessageBox;
	} else {
		[_name] call vcom_emit_io_loadConfig;
	};
	
}

//Очищает список эмиттеров и загружает по конфигу новые данные
function(vcom_emit_io_loadConfig)
{
	params ["_name"];
	if !(_name call vcom_emit_io_hasConfig) exitwith {
		["Cannot load config %1 - unknown name",_name] call printError;
	};

	call vcom_emit_deleteAllEmitters;

	private _cfgDataList = vcom_emit_io_map_configs get _name;

	if isNullVar(_cfgDataList) exitwith {
		setLastError("Data loading error. Name cfg: " + format[vec2("%1",_name)]);
	};

	vcom_emit_io_currentConfig = _name;
	[_name,true] call vcom_emit_io_setInputConfigName;

	{
		private _data = [];
		private _postRules = []; //vec2: str(name),any(context data)

		private _cfgSect = _x;
		private _settingList = _cfgSect get "settings";
		private _emitType = _cfgSect get "type";
		{
			_x params ["_k","_v"];
			[_k,_v,_emitType,_data,_postRules] call vcom_emit_internal_handleEmitterParseValues;
		} foreach _settingList;
		
		//["----- data(%1): %2",_cfgSect get "alias",_data] call printTrace;

		private _newObj = [_emitType,_cfgSect get "alias",_data,_cfgSect get "customEvents"] call vcom_emit_createEmitter;

		{
			_x params ["_rule","_ctx"];
			if (_rule == "setpos") then {
				for "_i" from 0 to 2 do {
					[_i,_ctx select _i,_newObj getvariable "index",false] call vcom_emit_relpos_updatePositionAtAxis;
				};
				continue;
			};
			if (_rule == "setorient") then {
				for "_i" from 0 to 2 do {
					[_i,_ctx select _i,_newObj getvariable "index",true] call vcom_emit_relpos_updatePositionAtAxis;
				};
				continue;
			};

			["%1 - Unknown post rule: %2",__FUNC__,_rule] call printWarning;
		} foreach _postRules;

	} foreach _cfgDataList;
}

function(vcom_emit_internal_handleEmitterParseValues)
{
	params ["_key","_cachedValue","_emitType","_outData","_outPostRules"];

	if (_key in ["linkToSrc","linkToLight"]) exitwith {
		_outPostRules pushBack ["setpos",call compile _cachedValue];
	};
	if (_key == "setOrient") exitwith {
		_outPostRules pushBack ["setorient",call compile _cachedValue];
	};

	private _lightInfo = vcom_emit_const_lightInfo;
	private _particleInfo = vcom_emit_const_particleInfo;
	private _curInfoList = ifcheck(_emitType=="particle",_particleInfo,_lightInfo);
	if (_emitType=="directlight") then {
		_curInfoList = vcom_emit_const_directLightInfo;
	};
	private _offsetIndex = _curInfoList find _key;
	if (_offsetIndex == -1) exitwith {
		["Searching data offset warning; Key %1 not found",_key] call printWarning;
	};

	//todo fix issue float values random shift
	_outData set [_offsetIndex,call compile _cachedValue];
}


//common props

//открытие окна нового конфига
function(vcom_emit_io_createNewConfig_openWindow)
{
	private _nf = {
		call wch_enable;
		private _d = call vcom_getDisplay;
		_sW = 30;
		_sH = 20;

		_b = [_d,BACKGROUND,[50-70/2,50-70/2,70,70]] call createWidget;
		(call wch_getControlStorage) pushBack _b;
		_b setBackgroundColor [0.3,0.3,0.3,1];
		
		_b = [_d,TEXT,[50-_sW/2,10+20-10,_sW,10]] call createWidget; (call wch_getControlStorage) pushBack _b;
		[_b,"Введите название конфига"] call widgetSetText;

		_b = [_d,INPUT,[50-_sW/2,10+20,_sW,10]] call createWidget; (call wch_getControlStorage) pushBack _b;
		_b ctrlsettext "";
		_inp = _b;

		_b = [_d,BUTTON,[50-_sW/2,10+20+20,_sW,10]] call createWidget; (call wch_getControlStorage) pushBack _b;
		_b ctrlsettext "Создать";
		_b setvariable ["_inp",_inp];
		_b ctrladdeventhandler ["MouseButtonUp",{
			_b = _this select 0;
			_inp = _b getvariable "_inp";
			_v = ctrlText _inp;
			//regex check with pattern \w+
			if !([_v,"^(\w+)$"] call regex_isMatch) exitwith {
				["Ошибка названия. Только английские символы, цифры и символ '_'"] call showError;
			};
			if (tolower(_v) in vcom_emit_io_list_allConfigsNames) exitwith {
				[format["Конфиг с именем '%1' уже существует",_v]] call showError;
			};
			[toUpper _v] call vcom_emit_io_createNewConfig;
			nextFrame(wch_disable);
		}];

		_b = [_d,BUTTON,[50-_sW/2,10+20+20+10,_sW,10]] call createWidget;
		_b ctrlsettext "Отмена";
		ctrlsetfocus _b;
		(call wch_getControlStorage) pushBack _b;
		_b ctrladdeventhandler ["MouseButtonUp",{
			call wch_disable;
		}];

		

	}; nextFrame(_nf);
}

function(vcom_emit_io_createNewConfig)
{
	params["_name"];
	
	call vcom_emit_deleteAllEmitters;

	vcom_emit_io_currentConfig = toUpper _name;
	[_name] call vcom_emit_io_setInputConfigName;
}

function(vcom_emit_io_saveCurrentConfig)
{
	if !(call vcom_emit_io_isEditConfig) exitwith {
		["Создайте конфиг",3] call showInfo;
	};
	if (vcom_emit_io_currentConfig call vcom_emit_io_hasConfig) exitwith {
		
		[ 
			format["Конфиг %1 уже существует. Вы хотите перезаписать его?",toUpper vcom_emit_io_currentConfig], 
			"Перезапись конфига", 
			[ 
				"Да", 
				{ 
					private _curData = call vcom_emit_io_internal_serializeEmittersToConfig;
					vcom_emit_io_map_configs set [toUpper vcom_emit_io_currentConfig,_curData];
					[[tolower vcom_emit_io_currentConfig]] call vcom_emit_io_saveAllConfigs;
					[format["Конфиг %1 перезаписан",toUpper vcom_emit_io_currentConfig],5] call showInfo;
				} 
			], 
			[ 
				"Нет", 
				{} 
			], 
			"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
			call vcom_getDisplay
		] call createMessageBox;
	};

	private _curData = call vcom_emit_io_internal_serializeEmittersToConfig;

	vcom_emit_io_list_allConfigsNames pushBack (tolower vcom_emit_io_currentConfig);
	vcom_emit_io_map_configs set [toUpper vcom_emit_io_currentConfig,_curData];
	[[tolower vcom_emit_io_currentConfig]] call vcom_emit_io_saveAllConfigs;
	[format["Конфиг %1 сохранён",toUpper vcom_emit_io_currentConfig],5] call showInfo;
}

function(vcom_emit_io_setInputConfigName)
{
	params ["_name",["_noChecks",false]];
	
	if (_noChecks) exitwith {
		private _inp = ["_ctgEmitProp","_inputCfgName"] call vcom_emit_getVarInSets;
		_inp ctrlsettext (toUpper _name);
		true
	};

	if !([_name,"^(\w+)$"] call regex_isMatch) exitwith {
		["Неверное название конфига. Только английские буквы, цифры и символ подчеркивания"] call showWarning;
		false
	};
	if (tolower(_name) in vcom_emit_io_list_allConfigsNames) exitwith {
		[format["Конфиг с именем %1 уже существует",toUpper _name]] call showWarning;
		false
	};
	private _inp = ["_ctgEmitProp","_inputCfgName"] call vcom_emit_getVarInSets;
	_inp ctrlsettext (toUpper _name);
	true
}

function(vcom_emit_io_internal_attemptUpdateConfigName)
{
	params ["_newName"];
	if !(call vcom_emit_io_isEditConfig) exitwith {
		(["_ctgEmitProp","_inputCfgName"] call vcom_emit_getVarInSets) ctrlsettext "";
		["Вы не редактируете никакой конфиг в данный момент"] call showWarning;
	};
	private _oldName = vcom_emit_io_currentConfig;

	if ([_newName] call vcom_emit_io_setInputConfigName) then {
		// [ 
		// 	format["Конфиг %1 будет переименован в %2. Настройки эмиттеров не будут сохранены (их нужно сохранять вручную)",
		// 		toUpper _oldName,
		// 		toUpper _newName], 
		// 	"Переименование конфига", 
		// 	[ 
		// 		"Да", 
		// 		{} 
		// 	], 
		// 	[ 
		// 		"Нет", 
		// 		{} 
		// 	], 
		// 	"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
		// 	call vcom_getDisplay
		// ] call createMessageBox;

		//! Логичнее всего переименовывать сам конфиг без изменения в исходнике
		//Таким образом мы сможем создавать новые конфиги на основе старых изменив имя
		vcom_emit_io_currentConfig = toUpper _newName;

		//берем настройки текущего конфига, и добавляем в новое поле
		// private _curData = vcom_emit_io_map_configs get (toUpper _oldName);
		// private _idx = vcom_emit_io_list_allConfigsNames find (tolower _oldName);
		// if (_idx == -1) exitwith {};
		// vcom_emit_io_list_allConfigsNames set [_idx,tolower _newName];
		// vcom_emit_io_map_configs deleteAt (toUpper _oldName);
		// vcom_emit_io_map_configs set [toUpper _newName,_curData];
	} else {
		(["_ctgEmitProp","_inputCfgName"] call vcom_emit_getVarInSets) ctrlsettext _oldName;
	};
}

//генератор структуры конфига
function(vcom_emit_io_internal_serializeEmittersToConfig)
{
	private _allEmitters = call vcom_emit_getEmitterObjectList;
	private _allEmittersData = [];
	{
		_el = createHashMap;
		//type, typeshort, customEvents, alias, settings
		_el set ["alias",_x getvariable "unicalIDStr"];
		
		_el set ["customEvents",_x getvariable ["serializedCustomEvents","null"]];
		
		_emType = _x getvariable "emitType";
		_el set ["type",_emType];
		_el set ["typeshort",(vcom_emit_emitterTypeAssoc get _emType) select 1];
		
		private _settingsData = [];
		_el set ["settings",_settingsData];

		private _data = _x getvariable "data";
		private _pos = _x getvariable "pos";
		private _orient = _x getvariable "orient";

		_settingsData pushBack [
			ifcheck(_foreachIndex==0,"linkToSrc","linkToLight"),
			str _pos
		];
		

		if (_emType == "directlight" && not_equals(_orient,vec3(0,0,0))) then {
			_settingsData pushBack ["setOrient",str _orient];
		};

		//common info

		//get setter func
		_provSearcher = ifcheck(_emType=="particle",vcom_emit_const_particleInfo,vcom_emit_const_lightInfo);
		if (_emType == "directlight") then {
			_provSearcher = vcom_emit_const_directLightInfo;
		};

		//serialize emitter data elements
		private _dataMaxIndex = count _data - 1;
		private _serializedSetting = null;
		{
			if (_x == "") then {continue}; //empty setting
			if (_foreachIndex > _dataMaxIndex) exitwith {
				["%1 - reader out of range; Emitter '%2'",__FUNC__,_el get "alias"] call printWarning;
			};
			_serializedSetting = str (_data select _foreachIndex);
			if ([_serializedSetting,"^(\[0?(\,0)*\]|false|0)$/"] call regex_isMatch) then {
				#ifdef ENABLE_TRACE_MESSAGES_IOCFG
				["    (%1) Empty data '%2' (val:%3), Skipping",_el get "alias",_x,_serializedSetting] call printTrace;
				#endif
				continue;
			};
			_settingsData pushBack [_x,_serializedSetting];
		} foreach _provSearcher;
		

		_allEmittersData pushBack _el;
	} foreach _allEmitters;
	_allEmittersData
}
