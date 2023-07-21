variable_define
	//all pathes are relative
	gm_filegen_internal_path_gamemodes = "src\host\GameModes";
	gm_filegen_internal_path_protomode = "src\editor\bin\proto_mode.sqf";
	gm_filegen_internal_path_protorole = "src\editor\bin\proto_role.sqf";
	gm_filegen_internal_path_gamemodes_loader_file = gm_filegen_internal_path_gamemodes + "\scripted_loader.hpp";

function(gm_filegen_openWindow)
{
	private _modeName = ["OOPBuilder","inputbox",["Создание режима","Введите название режима"],true] call rescript_callCommand;

	private _fullModeName = gm_filegen_internal_path_gamemodes + "\" + _modeName;
	if ([_fullModeName] call folder_exists) exitwith {
		[format["Указанная директория уже существует: %1",_modeName]] call showWarning;
	};

	if ([_modeName,"[^\w+_0-9]"] call regex_isMatch) exitwith {
		["Название режима содержит недопустимые символы"] call showWarning;
	};

	if !([_modeName,"^GM\w+"] call regex_isMatch) then {
		_modeName = "GM" + _modeName;
	};

	private _modeFrom = getMissionPath gm_filegen_internal_path_protomode;
	private _modeTo = getMissionPath gm_filegen_internal_path_gamemodes + format["\%1\%1.sqf",_modeName];

	private _roleFrom = getMissionPath gm_filegen_internal_path_protomode;
	private _roleTo = getMissionPath gm_filegen_internal_path_protorole + format["\%1\%1_roles.sqf",_modeName];

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