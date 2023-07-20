// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(sim_initialize)
{
	sim_internal_const_pathAbsSDKConfig = getMissionPath "src\Editor\EditorSDKConfig.txt";
}

function(sim_openMapSelector)
{
	private _allowedModes = [];
	{
		if ([_x,"InterfaceClass"] call goasm_attributes_hasAttributeClass
			|| [_x,"HiddenClass"] call goasm_attributes_hasAttributeClass
		) then {continue};
		_allowedModes pushBack ([_x,"classname"] call oop_getTypeValue);
	} foreach (call gm_getAllGamemodeObjects);

	_allowedModes sort true;
	
	[
		_allowedModes,
		//event on select
		{
			_curMode = _text;
			[[],[vec2("startupMode",_curMode)]] call sim_internal_processLaunchSim;
		},
		{
			
		},
		null,
		"Выберите режим с которым будет запускаться симуляция"
	] call control_createList;
}

function(sim_startSimFromCache)
{
	private _cache = call editorDebug_getPlayerSettings;
	if (count _cache == 0) exitwith {
		["Настройки в кеше отсутствуют. Зайдите за роль в режиме"] call showWarning;
	};
	private _ret = [_cache] call editorDebug_internal_validateValuesCanStart;
	if (_ret != "") exitwith {
		[format["Невозможно запустить симуляцию. Секция '%1' не принимает значения",_ret]] call showWarning;
	};

	[["autoGamemode","startGame","spawnposFromCache"],[
		["startGamemodeName",_cache get "gamemode"],
		["startRoleName",_cache get "role"]
	]] call sim_internal_processLaunchSim;
}

function(sim_startupDefault)
{
	[null,null] call sim_internal_processLaunchSim;
}

function(sim_applySDKConfig)
{
	params [["__systemFlags",[]],["__sdkProps",[]]];

	private _data = format["[%1,createHashMapFromArray %2]",str __systemFlags,str __sdkProps];
	["data was %1",_data] call printTrace;
	private _delimeter = "";
	_data = _data regexReplace["""/g",""];
	["FileManager","Write",[sim_internal_const_pathAbsSDKConfig,_data,_delimeter]] call rescript_callCommandVoid;
}

function(sim_internal_processLaunchSim)
{
	params [["__systemFlags",[]],["__sdkProps",[]]];

	if (cfg_map_canBuildBeforeSimulate && {!(["no-success-info","no-bake-object-info","no-ecode-logs"] call mm_build)}) exitWith {
		["Не удалось запустить симуляцию. При сборке карты найдены проблемы. Смотрите логи"] call showError;
	};

	if (cfg_sim_startAtNight) then {
		__systemFlags pushBack "startAtNight";
	};
	if (cfg_system_startWithLogVars) then {
		__systemFlags pushBack "enableLogVars";
	};

	[__systemFlags,__sdkProps] call sim_applySDKConfig;

	do3DENAction "MissionPreview";
} 

function(sim_openDetaliSetup)
{
	private _params = [
		//setting,name(|desc),valuetype,defaultvalue
		["autoGamemode","Авторежим|Установить режим и роль","check"],
		["startGame","Автостарт|Запускает установленный режим сразу","check"],
		["startGamemodeName","Старт.режим|Имя режима, которое будет установлено","input"],
		["startRoleName","Старт.роль|Имя роли, которая будет выдана при установке режима","input"],
		["forceAspect","Автоаспект|Принудительно установит указанный аспект раунда","check"],
		["forcedAspectName","Имя аспекта|Класснейм аспекта, который будет установлен","input"]
	];
	
	sim_internal_map_settings = createHashMap;
	sim_intenral_list_widgets = [];
	[_params,
		{
			_resdk_cache_simsetup = profileNamespace getvariable ["resdk_cache_simsetup",[]];

			if (_i == 0) then {sim_intenral_list_widgets=[]};
			_this params ["_setname","_name","_valuetype"];
			_color = (([0,0,0] apply{_i%3 /10 + 0.2}) + [1]);
			private _sizeH = 7;
			_ofs = _i%2;
			_ofsY = _i%2;
			_tex = [_d,TEXT,[50*_ofs,_sizeH * (_i-_ofsY)/2,25,_sizeH],_ctg] call createWidget;
			(_name splitString "|")params["_tname","_tdes"];
			[_tex,_tname] call widgetSetText;
			_tex ctrlSetTooltip _tdes;
			_tex setBackgroundColor _color;

			_valueSetup = null;
			_valueSetup = call {
				
				if (_valuetype=="input") exitwith {
					//wtype,size,codecheck,setupfromcache
					[INPUT,[25+50*_ofs,_sizeH * (_i-_ofsY)/2,25,_sizeH],{
						ctrlText _this
					},{(_this select 0) ctrlsettext (_this select 1)}]
				};
				if (_valuetype=="check") exitwith {
					["RscCheckBox",[25+50*_ofs,_sizeH * (_i-_ofsY)/2,15,_sizeH],{
						cbChecked _this
					},{(_this select 0) cbSetChecked (_this select 1)}]
				};
			};

			if !isNullVar(_valueSetup) then {
				_valueSetup params ["_t","_s","_ev","_pset"];
				_w = [_d,_t,_s,_ctg] call createWidget;
				_w setvariable ["eventGetValue",_ev];
				_w setvariable ["settingName",_setname];
				_w setvariable ["valuetype",_valuetype];
				_w setBackgroundColor _color;
				sim_intenral_list_widgets pushBack _w;

				_idxFind = (_resdk_cache_simsetup findif {_x select 0 == _setname});
				if (_idxFind != -1) then {
					[_w,_resdk_cache_simsetup select _idxFind select 1] call _pset;
				};
			};
			
		},
		{
			["%1",sim_intenral_list_widgets] call printTrace;
			_flags = []; _values = [];
			private _vauleList = [];
			{
				private _val = _x call (_x getvariable "eventGetValue");
				private _set = _x getvariable "settingName";
				_vauleList pushBack [_set,_val];
				private _vt = _x getvariable "valuetype";
				if (_vt == "check") then { if (_val) then {_flags pushBack _set}};
				if (_vt == "input") then { _values pushBack [_set,_val]};
			} foreach sim_intenral_list_widgets;
			
			profileNamespace setvariable ["resdk_cache_simsetup",_vauleList];
			saveprofilenamespace;

			//onsave
			nextFrame(displayClose);

			nextFrameParams(sim_internal_processLaunchSim,vec2(_flags,_values));

		},
		"Настройка запуска симуляции",
		"Запуск",
		null,
		{
			nextFrame(displayClose);
		}
	] call golib_openArraySelector
}
