// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

variable_define
	gm_isInsideModemanager = false;

	//gamemodes folder
	gm_path_gamemodes_folder = "\host\GameModes";
	// custom loader path
	gm_path_gamemodes_loader_file = "\host\GameModes\scripted_loader.hpp";
	
	//hashmap of gamemode settings
	gm_internal_map_settings = createHashMap;

#include "GamemodeManager_fileGenerator.sqf"

/*
		!WARNING
	На данный момент принято решение приостановить разработку данного компонента.
	Создание режимов производится через код.

*/


function(gm_createGamemode)
{
	/*
		Нам нужно хранить:
		название
		тип
		функцию инициализатор
		ассоциативное значение
	*/
	private _rawList = [
		["create"], //selector mode: open
		["Название режима","input"],
		["тест чекбокс","check"]
		
	];

	[_rawList,{
		//handle element
		if (_isFirstItem) exitwith {
			_this params ["_mgrMode"];
		};

		_sizeH = 7;
		
		_elementHandler = {

			_this params ["_settingName","_settingType"];

			private _settingDesc = "";
			if equalTypes(_settingName,[]) then {
				_settingDesc = _settingName select 1;
				_settingName = _settingName select 0;
			};

			if (_settingType == "check") exitwith {

				_t = [_d,TEXT,[0,_sizeH * _i,85,_sizeH],_ctg] call createWidget;
				[_t,format["<t align='left'>%1</t>",_settingName]] call widgetSetText;
				_t ctrlSetTooltip _settingDesc;

				_ch = [_d,"RscCheckBox",[85,_sizeH * _i,10,_sizeH],_ctg] call createWidget;
				_ch cbSetChecked _currentValue;
				_ch ctrladdeventhandler ["CheckedChanged",{
					params ["_wid","_value"];
					_value = _value > 0;
					_wid cbSetChecked (_value);
				}];
				
			};
			if (_settingType == "input") exitwith {
				_t = [_d,TEXT,[0,_sizeH * _i,50,_sizeH],_ctg] call createWidget;
				[_t,format["<t align='left'>%1</t>",_settingName]] call widgetSetText;
				_t ctrlSetTooltip _settingDesc;

				_inp = [_d,INPUT,[50,_sizeH * _i,50,_sizeH],_ctg] call createWidget;
				
				_inp setvariable ["validator",_canSetCode];
				_inp setvariable ["current",_currentValue];
				_inp setvariable ["default",_defaultValue];
				_inp setvariable ["name",_name];
				_inp setvariable ["type",_settingType];

				if (_settingType == "input") then {
					_inp ctrlsettext _currentValue;
				} else {
					_inp ctrlsettext str _currentValue;
				};
				
				_inp ctrladdeventhandler ["KillFocus",{
					params ["_wid"];
					_type = _wid getvariable "type";
					_validator = _wid getvariable "validator";
					_value = ctrlText _wid;
					if (_type == "num_input") then {
						_value = parseNumber _value;
						if !(finite _value) then {_value = 0};
					};
					if (call _validator) then {
						_wid ctrlsettext ifcheck(equalTypes(_value,""),_value,str _value);
						core_settings_internal_map_cachedPresetup set [_wid getvariable "name",_value];
					} else {
						_dv = _wid getvariable "current";
						_wid ctrlsettext ifcheck(equalTypes(_dv,""),_dv,str _dv);
					};
				}];
			};
		};

		call _elementHandler;

		if (_isLastItem) exitwith {

		};
	},{
		//onsave

		[false] call gm_internal_setGolibMode;
	},
	"Менеджер режима",
	"Ок",
	getEdenDisplay,
	{
		nextFrame(displayClose);
		[false] call gm_internal_setGolibMode;
	},
	{
		//ondrag
	},
	true
	] call golib_openArraySelector;


	[true] call gm_internal_setGolibMode;
	
}

function(gm_internal_setGolibMode)
{
	params ["_mode"];
	gm_isInsideModemanager = _mode;
	call golib_vis_loadObjList;
}

//get all gamemodes objects
function(gm_getAllGamemodeObjects)
{
	(["GMBase",false,true] call oop_getAllObjectsOfType)
}