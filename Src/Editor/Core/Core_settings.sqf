// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\Widgets\Widgets.hpp>

core_settings_pathAbs = getMissionPath "src\Editor\EditorSettings.txt";




#define SETP_SECT_PROPNAME 0
#define SETP_SECT_DATASTRUCT 1

#define SETP_IDX_NAME 0
#define SETP_IDX_DESC 1
#define SETP_IDX_DEFDATA 2
	#define SETP_IDX_DEFDATA_DEFALUT 0
	#define SETP_IDX_DEFDATA_TYPE 1
	#define SETP_IDX_DEFDATA_CURRENTVAL 2
	#define SETP_IDX_DEFDATA_ALLVALUES 3
#define SETP_IDX_VALIDATE 3
#define SETP_IDX_POSTSETUP 4

#define issectregion(x) equals((x) select 0,"region")

core_settings_map_settings = createHashMap;

function(core_settings_init)
{
	{
		if issectregion(_x) then {continue};

		_d = _x select SETP_SECT_DATASTRUCT;
		if (count _d - 1 < SETP_IDX_POSTSETUP) then {
			_d set [SETP_IDX_POSTSETUP,{}];
		};
	} foreach core_settings_list_default;

	//magic variable for initialize
	private _INIT_SETTINGS_FLAG_ = true;

	if (
		[core_settings_pathAbs,false] call file_exists
	) then {
		//create settings buffer
		{
			if issectregion(_x) then {continue};

			core_settings_map_settings set [
				_x select SETP_SECT_PROPNAME,
				_x select SETP_SECT_DATASTRUCT
			];
		} foreach core_settings_list_default;
		
		[!false] call core_settings_load;
	} else {
		[__FUNC__+" - Created new settings"] call showInfo;
		
		//create settings map
		{
			if issectregion(_x) then {continue};

			core_settings_map_settings set [_x select SETP_SECT_PROPNAME,_x select SETP_SECT_DATASTRUCT];
			//set to default
			[
				_x select SETP_SECT_PROPNAME,
				(_x select SETP_SECT_DATASTRUCT) 
				select SETP_IDX_DEFDATA select SETP_IDX_DEFDATA_DEFALUT
			] call core_settings_setValue;
		} foreach core_settings_list_default;
		
		[false] call core_settings_save;
	};
	
}

//get setting value
//you can also use variables cfg_NAME, where NAME - variable name...
function(core_settings_getValue)
{
	private _d = core_settings_map_settings get _this;
	if isNullVar(_d) exitWith {null};
	_d select SETP_IDX_DEFDATA select SETP_IDX_DEFDATA_CURRENTVAL
}

function(core_settings_getDefaultValue)
{
	private _d = core_settings_map_settings get _this;
	if isNullVar(_d) exitWith {null};
	_d select SETP_IDX_DEFDATA select SETP_IDX_DEFDATA_DEFALUT
}

function(core_settings_setValue)
{
	params ["_setName","_value"];

	private _isInit = !isNullVar(_INIT_SETTINGS_FLAG_);

	private _d = core_settings_map_settings get _setName;
	if isNullVar(_d) exitWith {
		[format["%1 - Setting %2 not exists",__FUNC__,_setName]] call showWarning;
		["%1 - Setting %2 not exists",__FUNC__,_setName] call printWarning;
		false
	};
	private _defData = _d select SETP_IDX_DEFDATA;
	private _allValues = if (count _defData >= SETP_IDX_DEFDATA_ALLVALUES 
		&& (_defData select SETP_IDX_DEFDATA_TYPE) == "list") then {
			_defData select SETP_IDX_DEFDATA_ALLVALUES
		} else {null};

	//validate 
	if !(call (_d select SETP_IDX_VALIDATE)) exitWith {
		//sync if not initialized
		if (count _defData != SETP_IDX_DEFDATA_CURRENTVAL) then {
			_defData set [SETP_IDX_DEFDATA_CURRENTVAL,_defData select SETP_IDX_DEFDATA_DEFALUT];
			missionnamespace setvariable [format["cfg_%1",_setName],_defData select SETP_IDX_DEFDATA_DEFALUT];
		};

		false
	};
	//setup
	_defData set [SETP_IDX_DEFDATA_CURRENTVAL,_value];

	missionnamespace setvariable [format["cfg_%1",_setName],_value];

	//postsetup
	call (_d select SETP_IDX_POSTSETUP);

	true
}

function(core_settings_load)
{
	params [["_showMessage",true]];
	
	private _data = ([core_settings_pathAbs,false] call file_read) splitString endl;
	private _codeCount = {! issectregion(_x) }count core_settings_list_default;
	private _setsCount = {! ([_x,"^#"] call regex_isMatch)} count _data;
	/*
	if (_codeCount != _setsCount) exitWith {
		private _deleted = [core_settings_pathAbs,false] call file_delete;
		private _resText = if (_deleted) then {
			"Предыдущий файл настроек успешно удален. Перезапустите редактор."
		} else {
			"Предыдущий файл настроек не был удален. Удалите его вручную и перезапустите редактор. Файл:" + core_settings_pathAbs;
		};
		private _info = format["%3%3Настроек редактора: %1%3Настроек в конфиге: %2%3",_codeCount,_setsCount,endl];
		setLastError("Несоответствие количества параметров в настройках."+_info+endl+_resText);
	};*/

	if (_codeCount != _setsCount) then {
		["Settings count missmatch; in config: %1; expected %2",_setsCount,_codeCount] call printWarning;	
	};
	
	private _possibleSettingsList = keys core_settings_map_settings;

	//["prop=""hello""","^\w+=",""] call regex_replace //forvalue
	//"(?!\w+)=.*" forkey

	{
		//skip comments
		if ([_x,"^#"] call regex_isMatch) then {
			//["comment line %1",_x] call printTrace;
			continue;
		};

		_key = [_x,"(?!\w+)=.*",""] call regex_replace;
		if !(_key in _possibleSettingsList) then {
			["%1 - setting '%2' not exists",__FUNC__,_key] call printWarning;
			continue;
		};
		_val = [_x,"^\w+=",""] call regex_replace;
		if ("<null>" in (tolower _val)) then {
			setLastError("Setting error; recreate editor settings: null data for key " + _key);
		};
		[_key,
			//?unsafe parsing. maybee use another method?
			call compile _val
		] call core_settings_setValue;

		array_remove(_possibleSettingsList,_key);
	} foreach _data;
	
	if (count _possibleSettingsList > 0) then {
		{
			_def = _x call core_settings_getDefaultValue;
			if isNullVar(_def) exitwith {
				setLastError("Error on get defalut value for " + _x);
			};
			[_x,_def] call core_settings_setValue;
			["Applied default setting for key '%1'",_x] call printLog;
		} foreach _possibleSettingsList;
	};

	if (_showMessage) then {
		["Editor settings loaded"] call printLog;
	};
}

function(core_settings_save)
{
	params [["_showMessage",true]];
	private _data = ["# Не изменяйте эти настройки вручную"];
	private _val = null;
	private _nm = null;
	{
		if issectregion(_x) then {
			_x params ["",["_regionName",""]];
			_data pushBack (format["# %1",_regionName]);
			continue;
		};
		_nm = _x select SETP_SECT_PROPNAME;
		_val = _nm call core_settings_getValue;
		if equalTypes(_val,"") then {_val = str _val};
		_data pushBack (format["%1=%2",_nm,_val]);
	} foreach core_settings_list_default;

	[core_settings_pathAbs,_data joinString endl,false] call file_write;
	
	if (_showMessage) then {
		["Editor settings saved"] call printLog;
	};
};

function(core_settings_openWinow)
{
	private _list = array_copy(core_settings_list_default);
	
	core_settings_internal_map_cachedPresetup = createHashMap;
	core_settings_internal_list_allWidgets = [];
	
	private _indResizer = _list findif {issectregion(_x) && {_x select 1 == "Тестовые настройки"}};
	if (_indResizer != -1 && !cfg_debug_devMode) then {
		_list resize _indResizer;
	};

	[
		_list,
		//create element
		{
			if (_i == 0) then {
				core_settings_internal_list_allWidgets = [];
			};

			__checkLastItem = {
				if (_isLastItem) then {
					_b = [_d,BUTTON,[5,_sizeH * (_i + 2),90,_sizeH],_ctg] call createWidget;
					_b ctrlSetText "Сбросить на стандартные";
					_b ctrladdeventhandler ["MouseButtonUp",{
						{
							_t = _x getvariable "type";
							_def = _x getvariable "default";
							core_settings_internal_map_cachedPresetup set [_x getvariable "name",_def];
							if (_t == "check") then {
								_x cbSetChecked _def;
							};
							if (_t == "input" || _t == "num_input") then {
								_x ctrlsettext ifcheck(equalTypes(_def,""),_def,str _def);
							};
							if (_t == "list") then {
								_x lbSetCurSel ((_x getVariable "allValues") find _def);
							};
						} foreach core_settings_internal_list_allWidgets;
					}];
				};
			};
			_sizeH = 7;

			if issectregion(_this) exitwith {
				_this params ["","_name",["_desc",[""]]];
				_t = [_d,TEXT,[20,_sizeH * _i+(_sizeH/4),60,_sizeH/2],_ctg] call createWidget;
				[_t,format["<t align='center'>%1</t>",_name]] call widgetSetText;
				_t ctrlSetTooltip _desc;
				_t ctrlSetTooltipMaxWidth (40 call widgetGetSizeFromPrecent);
				_color = "#328C32" call color_HTMLtoRGBA;
				_color set [3,0.6];
				_t setBackgroundColor _color;
			};

			_this params ["_name","_ctxSetting"];
			_ctxSetting params ["_text",["_desc",""],"_defDataStruct",["_canSetCode",{true}],["_postCreateCode",{}]];
			_defDataStruct params ["_defaultValue","_valueType","_currentValue",["_optAllValues",[]]];
			
			

			_back = [_d,BACKGROUND,[0,_sizeH * _i,100,_sizeH],_ctg] call createWidget;
			_back setBackgroundColor ifcheck(_i%2==0,vec4(0.1,0.1,0.1,0.8),vec4(0.6,0.6,0.6,0.5));

			if (_valueType == "check") then {
				_t = [_d,TEXT,[0,_sizeH * _i,85,_sizeH],_ctg] call createWidget;
				[_t,format["<t align='left'>%1</t>",_text]] call widgetSetText;
				_t ctrlSetTooltip _desc;
				_t ctrlSetTooltipMaxWidth (40 call widgetGetSizeFromPrecent);

				_ch = [_d,"RscCheckBox",[85,_sizeH * _i,10,_sizeH],_ctg] call createWidget;
				core_settings_internal_list_allWidgets pushBack _ch;
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
			if (_valueType == "list") then {
				_t = [_d,TEXT,[0,_sizeH * _i,50,_sizeH],_ctg] call createWidget;
				[_t,format["<t align='left'>%1</t>",_text]] call widgetSetText;
				_t ctrlSetTooltip _desc;
				_t ctrlSetTooltipMaxWidth (40 call widgetGetSizeFromPrecent);

				_list = [_d,"RscCombo",[50,_sizeH * _i,45,_sizeH],_ctg] call createWidget;
				core_settings_internal_list_allWidgets pushBack _list;
				_list setvariable ["validator",_canSetCode];
				_list setvariable ["current",_currentValue];
				_list setvariable ["default",_defaultValue];
				_list setvariable ["name",_name];
				_list setvariable ["type",_valueType];

				_list setvariable ["allValues",_optAllValues];

				{
					_it = _list lbAdd ifcheck(equalTypes(_x,""),_x,str _x);
					if (_x == _currentValue) then {
						_list lbSetCurSel _it;
					};
				} foreach _optAllValues;

				_list ctrladdeventhandler ["LBSelChanged",{
					params ["_wid","_idx"];
					if (_idx == -1) exitWith {};
					_allValues = _wid getvariable "allValues";
					_value = _allValues select _idx;
					_validator = _wid getvariable "validator";
					if (call _validator) then {
						//_wid lbSetCurSel _idx;
						core_settings_internal_map_cachedPresetup set [_wid getvariable "name",_value];
					} else {
						_wid lbSetCurSel (_allValues find (_wid getvariable "current"));
					};
				}];
			};
			if (_valueType == "input" || _valueType == "num_input") then {
				_t = [_d,TEXT,[0,_sizeH * _i,50,_sizeH],_ctg] call createWidget;
				[_t,format["<t align='left'>%1</t>",_text]] call widgetSetText;
				_t ctrlSetTooltip _desc;
				_t ctrlSetTooltipMaxWidth (40 call widgetGetSizeFromPrecent);

				_inp = [_d,INPUT,[50,_sizeH * _i,50,_sizeH],_ctg] call createWidget;
				core_settings_internal_list_allWidgets pushBack _inp;
				_inp setvariable ["validator",_canSetCode];
				_inp setvariable ["current",_currentValue];
				_inp setvariable ["default",_defaultValue];
				_inp setvariable ["name",_name];
				_inp setvariable ["type",_valueType];

				if (_valueType == "input") then {
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


			call __checkLastItem;
		},
		//save
		{
			private _hasAnyUpdate = false;
			{
				_curval = _x call core_settings_getValue;
				if not_equals(_curval,_y) then {
					
					if ([_x,_y] call core_settings_setValue) then {
						_hasAnyUpdate = true;
						["Update settings value for %1",_x] call printLog;
					} else {
						["Cannot update settings value for %1",_x] call printWarning;
					};
				};

			} foreach core_settings_internal_map_cachedPresetup;

			if (_hasAnyUpdate) then {
				[true] call core_settings_save;
			};

			nextFrame(displayClose);
			core_settings_internal_map_cachedPresetup = null;
		},
		"Настройки ReEditor",
		"Сохранить и выйти",
		null,
		{
			nextFrame(displayClose);
			core_settings_internal_map_cachedPresetup = null;
		}
	] call golib_openArraySelector;
}

#undef issectregion

#undef SETP_SECT_PROPNAME
#undef SETP_SECT_DATASTRUCT
#undef SETP_IDX_NAME
#undef SETP_IDX_DESC
#undef SETP_IDX_DEFDATA
#undef SETP_IDX_DEFDATA_DEFALUT
#undef SETP_IDX_DEFDATA_TYPE
#undef SETP_IDX_DEFDATA_CURRENTVAL
#undef SETP_IDX_DEFDATA_ALLVALUES
#undef SETP_IDX_VALIDATE
#undef SETP_IDX_POSTSETUP