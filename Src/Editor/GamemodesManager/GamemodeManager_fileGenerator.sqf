// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

variable_define
	//all pathes are relative
	gm_filegen_internal_path_gamemodes = "src\host\GameModes";
	gm_filegen_internal_path_protomode = "src\editor\bin\protogamemode\proto_mode.sqf";
	gm_filegen_internal_path_protorole = "src\editor\bin\protogamemode\proto_roles.sqf";
	gm_filegen_internal_path_gamemodes_loader_file = gm_filegen_internal_path_gamemodes + "\scripted_loader.hpp";

function(gm_filegen_openWindow)
{
	private _modeName = ["OOPBuilder","inputbox",["Создание режима","Введите название режима"],true] call rescript_callCommand;
	
	if (_modeName == "$CLOSED$") exitwith {

	};
	
	[displayNull] call loadingScreen_start;
	[5,"Генерация режима"] call loadingScreen_setProgress;

	invokeAfterDelayParams(gm_filegen_internal_processCreate,1.5,[_modeName]);

	

	// [ 
	// 	[
	// 		"Создать новый режим|text",
	// 		"Имя режима|typename|Введите имя класса\nИмя может содержать только символы английского алфавита, цифры и нижнее подчеркивание.\nИмя должно начинаться только с нижнего подчеркивания либо буквы"
	// 	],
	// 	{
	// 		(_this splitString "|") params [["_name","ERROR_NAME"],["_t","ERROR_TYPE"],["_desc",""]];
	// 		if (_t == "text") then {
	// 			_text = [_d,TEXT,[0,10*_i,100,9.5],_ctg] call createWidget;
	// 			[_text,_name] call widgetSetText;
	// 		};
	// 		if (_t == "typename") then {
	// 			_text = [_d,TEXT,[0,10*_i,30,9.5],_ctg] call createWidget;
	// 			[_text,_name] call widgetSetText;
	// 			_text ctrlSetTooltip _desc;

	// 			_widTypename = [_d,INPUT,[30,10*_i,100-30,9.5],_ctg] call createWidget;
	// 			["_widTypename",_widTypename] call Core_addContext;
	// 			_widTypename ctrladdeventhandler ["KillFocus",{
	// 				private _widTypename = "_widTypename" call Core_getContextVar;
	// 				private _newClass = ctrlText (_widTypename);
	// 				private _basicType = "_basicType" call Core_getContextVar;

	// 				if !([_newClass,_basicType] call goasm_prefab_validateName) then {
	// 					_widTypename ctrlsettext "";
	// 				};
	// 			}];
	// 		};
	// 	},
	// 	//onsave
	// 	{
	// 		private _newClass = ctrlText ("_widTypename" call Core_getContextVar);
	// 		["_newClass",_newClass] call Core_addContext;
	// 		private _basicType = "_basicType" call Core_getContextVar;
	// 		private _worldObj = "_worldObj" call Core_getContextVar;

	// 		private _virtObj = "_virtObj" call Core_getContextVar;
	// 		_mapData = [_virtObj] call golib_getCustomProps;
			
	// 		private _listProps = _mapData toArray false;

			
	// 		private _postSuccess = {
	// 			call loadingScreen_stop;
				
	// 			private _worldObj = "_worldObj" call Core_getContextVar;
	// 			private _newClass = "_newClass" call Core_getContextVar;
	// 			private _virtObj = "_virtObj" call Core_getContextVar;
	// 			_mapData = [_virtObj] call golib_getCustomProps;

	// 			//update hashdata
	// 			private _hd = [_worldObj,false] call golib_getHashData;
	// 			_hd set ["class",_newClass];
	// 			if (("model" in _mapData) && {(_mapData get "model")!=(_hd get "model")}) then {
	// 				_mapData deleteat "model";
	// 				["Модель не будет обновлена в данном случае, так как создается префаб из уже изменённой модели"] call showWarning;
	// 				["goasm_prefab_createTemplateFrom_openWindow - handled potential error with model logic"] call printWarning;
	// 			};
	// 			_hd set ["customProps",_mapData];
	// 			[_worldObj,_hd,true,"Создание префаба типа "+_newClass] call golib_setHashData;
				
	// 			[[]] call inspector_menuLoad;
				
	// 			//runtime postbuild code
	// 			private _code = format["call golib_vis_loadObjList; %1 call golib_massoc_updateAllObjectsAtClassAndModel;",[_newClass]];
	// 			(compile _code) call goasm_builder_setPostBuildCode;
				
	// 			call Core_popContext;
	// 		};
	// 		private _postError = {
	// 			call loadingScreen_stop;
				
	// 			private _virtObj = "_virtObj" call Core_getContextVar;
	// 			deleteVehicle _virtObj;

	// 			[[]] call inspector_menuLoad;

	// 			call Core_popContext;
	// 		};
			
	// 		[displayNull] call loadingScreen_start;
			
	// 		[50,"Генерация"] call loadingScreen_setProgress;			

	// 		[
	// 			_newClass,
	// 			_basicType,
	// 			_listProps,
	// 			"prefab_openFileAfterCreated" call core_settings_getValue,
	// 			[_postSuccess,_postError]
	// 		] call goasm_prefab_createPrefab;

	// 	},
	// 	"Создание префаба",
	// 	"Создать",
	// 	null, //!для работы с полями инспектора
	// 	{
	// 		private _virtObj = "_virtObj" call Core_getContextVar;
	// 		deleteVehicle _virtObj;

	// 		call Core_popContext;

	// 		[[]] call inspector_menuLoad;
	// 	},
	// 	null,
	// 	true
	// ] call golib_openArraySelector;
}

function(gm_filegen_internal_processCreate)
{
	params ["_modeName"];

	if ([_modeName,"[а-яА-Я]"] call regex_isMatch) exitwith {
		call loadingScreen_stop;
		["Русские символы в названии режима не допускаются"] call showWarning;
	};
	if !([_modeName,"^[\w+_0-9]{3,64}$"] call regex_isMatch) exitwith {
		call loadingScreen_stop;
		["Название режима содержит недопустимые символы. Название должно быть не менее 3х символов, может содержать англ.буквы, цифры и нижнее подчеркивание",10] call showWarning;
	};

	private _fullModeName = gm_filegen_internal_path_gamemodes + "\" + _modeName;
	if ([_fullModeName] call folder_exists) exitwith {
		call loadingScreen_stop;
		[format["Указанная директория уже существует: %1",_modeName],10] call showWarning;
	};

	if !([_modeName,"^GM\w+"] call regex_isMatch) then {
		_modeName = "GM" + capitalize(_modeName);
	};

	//unlock params:params ["_path","_ctx",["_isRelative",true],["_onUnlocked",{}],["_onTimeout",{}]];
	private _ctxParams = [_modeName];

	[gm_filegen_internal_path_gamemodes_loader_file,_ctxParams,true,
		{
			_this params ["_modeName"];

			private _replaceString = "@GAMEMODE_NAME@";
			private _thisMapName = "missionName" call golib_getCommonStorageParam;

			[30,"Генерация файла режима"] call loadingScreen_setProgress;
			private _modeFrom = getMissionPath gm_filegen_internal_path_protomode;
			private _modeTo = getMissionPath gm_filegen_internal_path_gamemodes + format["\%1\%1.sqf",_modeName];
			private _rez = ["OOPBuilder","gm_generator",[_modeFrom,_modeTo,_replaceString,_modeName,_thisMapName],true] call rescript_callCommand;
			if (_rez == "false") exitwith {
				call loadingScreen_stop;
				[format["Невозможно создать файл режима: %1",_modeName]] call showWarning;
			};

			[60,"Генерация файла ролей"] call loadingScreen_setProgress;
			private _roleFrom = getMissionPath gm_filegen_internal_path_protorole;
			private _roleTo = getMissionPath gm_filegen_internal_path_gamemodes + format["\%1\%1_roles.sqf",_modeName];
			_rez = ["OOPBuilder","gm_generator",[_roleFrom,_roleTo,_replaceString,_modeName,_thisMapName],true] call rescript_callCommand;
			if (_rez == "false") exitwith {
				call loadingScreen_stop;
				[format["Невозможно создать файл роли: %1",_modeName]] call showWarning;
			};

			[90,"Регистрация режима в загрузчик"] call loadingScreen_setProgress;
			_rez = ["OOPBuilder","gm_generator_finalize",[
				getMissionPath gm_filegen_internal_path_gamemodes_loader_file,
				getMissionPath (gm_filegen_internal_path_gamemodes + "\" + _modeName),
				_modeName
			],true] call rescript_callCommand;
			if (_rez == "false") exitwith {
				call loadingScreen_stop;
				[format["Невозможно завершить создание режима: %1",_modeName]] call showWarning;
			};
			
			call loadingScreen_stop;
			[format["Режим %1 создан",_modeName]] call showInfo;
			nextFrame(goasm_builder_rebuildClasses);
		},
		{
			["Не удалось разблокировать файл для записи: " + gm_filegen_internal_path_gamemodes_loader_file] call showWarning;
			[5,"Не удалось разблокировать файл для записи: " + gm_filegen_internal_path_gamemodes_loader_file] call loadingScreen_setProgress;
			invokeAfterDelay({call loadingScreen_stop;},3);
		}
	] call file_unlockAsync;
}