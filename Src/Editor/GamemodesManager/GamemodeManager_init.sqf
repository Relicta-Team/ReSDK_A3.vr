
variable_define
	gm_isInsideModemanager = false;


function(gm_createGamemode)
{
	/*
	function(golib_openArraySelector)
	params [
		"_rawData",
		["_handlerElementCreate",{}],
		["_handlerSave",{}],
		["_text","Настройка элементов массива"],
		["_save","Сохранить"],
		["_childDisplay",displayNull],
		["_customEventClose",{}],
		["_customEventOnDragFromTree",{}],
		["_lockmodeOnEdenDisplay",false] //блокирует ввод выбора объекта и перемещения
	];
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

		_this params ["_settingName","_settingType"];
		
		call {
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
				_ch setvariable ["validator",_canSetCode];
				_ch setvariable ["current",_currentValue];
				_ch setvariable ["default",_defaultValue];
				_ch setvariable ["name",_name];
				_ch setvariable ["type",_valueType];
				_ch cbSetChecked _currentValue;
				_ch ctrladdeventhandler ["CheckedChanged",{
					params ["_wid","_value"];
					_value = _value > 0;
					_validator = _wid getvariable "validator";
					if (call _validator) then {
						_wid cbSetChecked (_value);
						core_settings_internal_map_cachedPresetup set [_wid getvariable "name",_value];
					} else {
						_wid cbSetChecked (_wid getvariable "current");
					};
				}];
				
			};
			if (_settingType == "input") exitwith {

			};
		};

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