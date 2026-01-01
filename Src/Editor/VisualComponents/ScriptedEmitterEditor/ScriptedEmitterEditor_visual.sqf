// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	["_zoneColor",[0,0,100,100],_ctgLight,
		["color",["x","y","z"],[0,1],0.001,null],
		{
			params ["_varname","_value"];
		}
	]

	Для синхронизации визуальных значений (взятых из реальных)
	 вызывайте __onSyncFunction передав в параметр объект ctg зоны
	 _z = ["_ctgLight","_zoneColor"] call vcom_emit_getVarInSetg;
	 _z call (_z getvariable "__onSyncFunction")
*/
function(vcom_emit_internal_createZoneVec3)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate",["_colorPalette",false]]; //_eventUpdate - функция контроля за объектом из UI
	
	_props params ["_varsysname","_listnames","_rangeVec2","_delta",["_backColor",[0.5,0.5,0.5,0.7]],["_sizeNameModif",1]];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};

	private _syncFunction = {
		setScopeName("vcom_emit_internal_createZoneVec3<_syncFunction>");
		private _zone = _this;
		private _emit = call vcom_emit_relpos_getSelectedEmitter;
		if isNullReference(_emit) exitwith {};
		private _isParticle = (_emit getvariable "emitType")=="particle";
		private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);
		private _data = _emit getvariable "data";
		private _clearSysName = _zone getvariable "_varsysname";
		private _updateColor = false;
		private _lastSlider = widgetNull;
		private _newcolorPalette = [0,0,0,1];
		for "_i" from 0 to 2 do {
			_sli = _zone getvariable ("_slid_"+str _i);
			_inp = _zone getvariable ("_inp_"+str _i);

			_val = [_data,_sli getvariable "_varsysname",_assocFunc] call vcom_emit_prop_getPropByName;
			
			_inp ctrlsettext ifcheck(equalTypes(_val,""),_val,str _val);;
			_sli sliderSetPosition ifcheck(equalTypes(_val,""),parseNumber _val,_val);

			if (_sli getvariable ["_colorPalette",false]) then {
				_updateColor = true;
				_lastSlider = _sli;
				_newcolorPalette set [_i,clamp( ifcheck(equalTypes(_val,""),parseNumber _val,_val) ,0,1)];
			};
		};
		if _updateColor then {
			private _colorPalette = _lastSlider getvariable "_colorPaletteWidget";
			_colorPalette setBackgroundColor _newcolorPalette;
		};
	};


	_perbut = 100/3;
	_colorPaletteSizeSlid = 62;
	_allSliders = [];
	for "_i" from 0 to 2 do {
		_col = [0,0,0,1];
		_col set [_i,1];

		_t = [_d,TEXT,[0,_perbut*_i,10,_perbut],_zone] call createWidget;
		[_t,format["<t align='center' size='%2'>%1</t>",_listnames select _i,_sizeNameModif]] call widgetSetText;
		_t ctrlsettextColor _col;
		if (count _listnames >= 4) then {
			_t ctrlSetTooltip (_listnames select 3);
		};

		_inp = [_d,INPUT,[10,_perbut*_i,20,_perbut-8],_zone] call createWidget;
		_inp setvariable ["_index",_i];

		_inp ctrladdeventhandler ["KillFocus",{
			private _passedValue = ctrlText (_this select 0);
			[(_this select 0) getvariable "_varsysname",parseNumberSafe(_passedValue),_this select 0,_passedValue] call ((_this select 0) getvariable "__eventUpdate");
			nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
		}];
		_sizeWSlider = ifcheck(_colorPalette,_colorPaletteSizeSlid,70);
		_slid = [_d,SLIDERWNEW,[20+10,_perbut*_i,_sizeWSlider,_perbut-8],_zone] call createWidget;
		_slid ctrlSetActiveColor _col;
		_slid ctrlSetForegroundColor _col;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,_delta,_delta];
		_slid sliderSetRange _rangeVec2;
		_slid setvariable ["_index",_i];
		_slid setvariable ["_colorPalette",_colorPalette];
		_allSliders pushBack _slid;

		_slid ctrladdeventhandler ["SliderPosChanged",{
			private _passedValue = _this select 1;
			[(_this select 0)getvariable "_varsysname",_passedValue,_this select 0,str _passedValue] call ((_this select 0) getvariable "__eventUpdate");
			nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
		}];

		{
			_x setvariable ["__eventUpdate",_eventUpdate];
			_x setvariable ["_varsysname",_varsysname+(_listnames select _i)];
			_x setvariable ["__onSyncFunction",_syncFunction];
			_x setvariable ["_zone",_zone];
		} foreach [_slid,_inp];

		_zone setvariable ["_slid_"+str _i,_slid];
		_zone setvariable ["_inp_"+str _i,_inp];
		_zone setvariable ["__onSyncFunction",_syncFunction];
	};

	if (_colorPalette) then {
		_color = [_d,TEXT,[20+10+_colorPaletteSizeSlid +1,_perbut*0+2,70-_colorPaletteSizeSlid - 2,(_perbut*3)-8],_zone] call createWidget;
		_color setBackgroundColor [1,1,1,1];
		{_x setvariable ["_colorPaletteWidget",_color]} foreach _allSliders;
		_color setvariable ["__onSyncFunction",_syncFunction];
		_color setvariable ["_zone",_zone];
		_color setvariable ["_allSliders",_allSliders];
		_color ctrlSetTooltip "Нажмите ЛКМ для открытия палитры цветов";
		_color ctrladdeventhandler ["MouseButtonUp",{
			params ["_wid","_key"];
			_zone = _wid getvariable "_zone";
			_syncFunction = _wid getvariable "__onSyncFunction";
			if (_key == MOUSE_LEFT) then {
				_ref = refcreate(0);
				if ([_ref,ctrlBackgroundColor _wid,4] call widget_winapi_openColor) then {
					_ref = refget(_ref);
					{
						_passedValue = _ref select _foreachIndex;
						[_x getvariable "_varsysname",_passedValue,_x,str _passedValue] call (_x getvariable "__eventUpdate");
					} foreach (_wid getvariable "_allSliders");
					nextFrameParams(_syncFunction,_zone);
				};
			};
		}];
	};

	_zone setvariable ["_varsysname",_varsysname];

	_zone
}
/*
	["_zoneIntensity",[0,0,100,100],_ctgLight,
		["intensity",["varname","and description"], false, [0,1],0.001,null],
		{
			params ["_varname","_value"];
		}
	]
*/
function(vcom_emit_internal_createZoneInput)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate"];
	_props params ["_varsysname","_textName","_addSlider","_rangeVec2","_delta",["_backColor",[0.5,0.5,0.5,0.7]],["_sizeNameModif",1],"_precentageOrientY",["_clampInputValue",false]];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};
	
	private _funcWidgetGetPos = if !isNullVar(_precentageOrientY) then {
		{
			if (_this > 2) exitwith {
				setLastError(__FUNC__ + " - _addSlider not implemented on horizontal orientation");
				WIDGET_FULLSIZE
			};
			[
				[0,0,_precentageOrientY,100],
				[_precentageOrientY,0,100-_precentageOrientY,100],
				[0,0,100,100]
			] select _this
		}
	} else {
		{
			[
				[0,_perbut*0,100,_perbut],
				[0,_perbut*1,100,_perbut-8],
				[0,_perbut*2,100,_perbut-8]
			] select _this
		}
	};

	private _syncFunction = {
		setScopeName("vcom_emit_internal_createZoneInput<_syncFunction>");
		
		private _zone = _this;
		private _emit = call vcom_emit_relpos_getSelectedEmitter;
		if isNullReference(_emit) exitwith {};
		private _data = _emit getvariable "data";
		private _isParticle = (_emit getvariable "emitType")=="particle";
		private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);
		private _inp = _zone getvariable ("_inp_");
		private _varname = _inp getvariable "_varsysname";

		_val = [_data,_varname,_assocFunc] call vcom_emit_prop_getPropByName;
		
		if ([_varname,_isParticle] call vcom_emit_lowlevel_isRenderParamName) then {
			private _curInd = _emit getvariable "animIndex";
			private _list = [_data,_varname] call vcom_emit_lowlevel_getRenderParamsValueFromData;
			private _maxIndex = count _list - 1;
			
			//Условия видимости: предпоследний элемент установлен
			_inp ctrlEnable !(_curInd - 1 > _maxIndex);

			if (_curInd > _maxIndex) then {
				_val = "";
			} else {
				_val = _list select _curInd;
			};
		};
		
		_inp ctrlsettext ifcheck(equalTypes(_val,""),_val,str _val);
		if (_zone getvariable "_hasSlider") then {
			// if not_equalTypes(_val,0) exitwith {
			// 	setLastError("vcom_emit_internal_createZoneInput<_syncFunction> - wrong value type for setup in slider:"+typename _val);
			// };
			(_zone getvariable ("_slid_")) sliderSetPosition _val;
		};
		
	};

	private _maxIndex = ifcheck(_addSlider,3,2);

	private _perbut = 100/_maxIndex;

	private _t = [_d,TEXT,0 call _funcWidgetGetPos,_zone] call createWidget;
	if equalTypes(_textName,[]) then {
		_textName params ["_t__","_des"];
		_t ctrlSetTooltip _des;
		_textName = _t__;
	};
	[_t,format["<t align='center' size='%2'>%1</t>",_textName,_sizeNameModif]] call widgetSetText;

	private _inp = [_d,INPUT,1 call _funcWidgetGetPos,_zone] call createWidget;
	_inp setvariable ["_clampInputValue",_clampInputValue];
	_inp setvariable ["_rangeVec2",_rangeVec2];
	_inp ctrladdeventhandler ["KillFocus",{
		private _passedValue = ctrlText (_this select 0);
		private _numValue = parseNumberSafe(_passedValue);
		if ((_this select 0) getvariable "_clampInputValue") then {
			((_this select 0) getvariable "_rangeVec2")params["_minV","_maxV"];
			_numValue = clamp(_numValue,_minV,_maxV);
		};
		[(_this select 0) getvariable "_varsysname",_numValue,_this select 0,_passedValue] call ((_this select 0) getvariable "__eventUpdate");
		nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
	}];

	private _slid = widgetNull;
	if (_addSlider) then {
		_slid = [_d,SLIDERWNEW,2 call _funcWidgetGetPos,_zone] call createWidget;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,_delta,_delta];
		_slid sliderSetRange _rangeVec2;

		_slid ctrladdeventhandler ["SliderPosChanged",{
			[(_this select 0)getvariable "_varsysname",_this select 1,_this select 0] call ((_this select 0) getvariable "__eventUpdate");
			nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
		}];

		_zone setvariable ["_slid_",_slid];
	};
	_zone setvariable ["_hasSlider",_addSlider];


	{
		if isNullReference(_x) then {continue};

		_x setvariable ["__eventUpdate",_eventUpdate];
		_x setvariable ["_varsysname",_varsysname];
		_x setvariable ["__onSyncFunction",_syncFunction];
		_x setvariable ["_zone",_zone];
	} foreach [_slid,_inp];

	
	_zone setvariable ["_inp_",_inp];
	_zone setvariable ["__onSyncFunction",_syncFunction];
	_zone setvariable ["_text",_t];
	_zone setvariable ["_varsysname",_varsysname];

	_zone
	
};
/*
	["_zoneUseFlare",[0,0,100,100],_ctgLight,
		["useflare","varname",null,1.5],
		{
			params ["_varname","_newvalue"];
		}
	]

	_checkedValuesAsBool - конвертирует значение чекбокса в бул. по умолчанию в движке значения чекбокса это int-значения
*/
function(vcom_emit_internal_createZoneCheckbox)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate"];
	_props params ["_varsysname","_textName",["_backColor",[0.5,0.5,0.5,0.7]],["_sizeNameModif",1],["_checkedValuesAsBool",true]];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};
	
	private _syncFunction = {
		private _zone = _this;
		private _emit = call vcom_emit_relpos_getSelectedEmitter;
		if isNullReference(_emit) exitwith {};
		private _data = _emit getvariable "data";
		private _isParticle = (_emit getvariable "emitType")=="particle";
		private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);

		_check = _zone getvariable ("_check");
		_val = [_data,_check getvariable "_varsysname",_assocFunc] call vcom_emit_prop_getPropByName;
		//update value check for _checkedValuesAsBool
		if equalTypes(_val,0) then {
			_val = _val > 0;
		};
		_check cbSetChecked _val;
	};

	private _t = [_d,TEXT,[0,0,70,100],_zone] call createWidget;
	if equalTypes(_textName,[]) then {
		_textName params ["_t__","_des"];
		_t ctrlSetTooltip _des;
		_textName = _t__;
	};
	[_t,format["<t align='center' size='%2'>%1</t>",_textName,_sizeNameModif]] call widgetSetText;

	private _check = [_d,"RscCheckBox",[70,0,20,100],_zone] call createWidget;
	_check setvariable ["_doConvertToBool",_checkedValuesAsBool];
	_check ctrladdeventhandler ["CheckedChanged",{
		params ["_wid","_val"];
		if (_wid getvariable "_doConvertToBool") then {
			_val = _val > 0;
		};
		[_wid getvariable "_varsysname",_val,_wid] call ((_this select 0) getvariable "__eventUpdate");
		nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
	}];

	_check setvariable ["__eventUpdate",_eventUpdate];
	_check setvariable ["_varsysname",_varsysname];
	_check setvariable ["__onSyncFunction",_syncFunction];
	_check setvariable ["_zone",_zone];

	_zone setvariable ["_check",_check];
	_zone setvariable ["__onSyncFunction",_syncFunction];
	_zone setvariable ["_text",_t];

	_zone
};
/*
	Это специальный обработчик для кнопки добавления или удаления кадра 
	["_zoneAddFrame",[0,0,100,100],_ctgLight,
		["+",null],
		{
			//this handler without params
		}
	]
*/
function(vcom_emit_internal_createZone_buttonFrameMod)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate"];
	_props params ["_textName",["_backColor",[0.5,0.5,0.5,0.7]]];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};

	private _t = [_d,BUTTON,[0,0,100,100],_zone] call createWidget;
	if equalTypes(_textName,[]) then {
		_textName params ["_t__","_des"];
		_t ctrlSetTooltip _des;
		_textName = _t__;
	};
	_t ctrlsettext _textName;
	_t ctrladdeventhandler ["MouseButtonUp",{
		nextFrame((_this select 0) getvariable "__eventUpdate_onPress");
	}];

	_t setvariable ["__eventUpdate_onPress",_eventUpdate];
	_t setvariable ["__onSyncFunction",{}];
	_t setvariable ["_zone",_zone];

	_zone setvariable ["_check",_check];
	_zone setvariable ["__onSyncFunction",{}];
	_zone setvariable ["_button",_t];

	_zone
};

function(vcom_emit_internal_createZone_runtimeInput)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate"];
	_props params ["_toolTip",["_backColor",[0.5,0.5,0.5,0.7]],["_isReadOnly",false]];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};

	private _t = [_d,ifcheck(_isReadOnly,"RscEditReadOnly",INPUT),[0,0,100,100],_zone] call createWidget;
	_t ctrlSetTooltip _toolTip;

	_t setvariable ["_varsysname",_varsysname];
	_t setvariable ["__onSyncFunction",_eventUpdate];
	_t setvariable ["_zone",_zone];

	_zone setvariable ["_check",_check];
	_zone setvariable ["__onSyncFunction",_eventUpdate];
	_zone setvariable ["_input",_t];

	_zone
}

/*
	["_zoneParticleShape",[0,0,100,100],_ctgParticle,
		["particleShape","property name",null,1.5,_itemList],
		{
			params ["_varname","_newvalue"];
		}
	]

	_itemList - List<vec2(string,string)>

	Есть несколько режимов соответствия; Использовать _compareMode параметр для изменения
*/
function(vcom_emit_internal_createZoneComboBox)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate"];
	_props params ["_varsysname","_textName",["_backColor",[0.5,0.5,0.5,0.7]],["_sizeNameModif",1],["_itemList",[]],["_compareMode","equal"]];

	if (count _itemList == 0) exitwith {
		setLastError(__FUNC__ + " - _itemList cannot be empty"); widgetNull
	};
	if !(_itemList select 1 isequaltypearray ["",""]) exitwith {
		setLastError(__FUNC__ + " - Wrong data type in array elements (_itemList):"+str(_itemList select 1));
	};

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};
	
	private _comparerFunc = call {
		if (_compareMode == "equal") exitwith {{equals(_val,_x select 1)}};
		if (_compareMode == "contains") exitwith {{_val in (_x select 1)}};
		if (_compareMode == "equalnocase") exitwith {{_val == _x select 1}};
		setLastError(__FUNC__ + " - cannot find compare mode _compareMode:" +_compareMode);
		{false}
	};

	private _syncFunction = {
		setScopeName("vcom_emit_internal_createZoneComboBox<_syncFunction>");
		private _zone = _this;
		private _emit = call vcom_emit_relpos_getSelectedEmitter;
		if isNullReference(_emit) exitwith {};
		private _data = _emit getvariable "data";
		private _list = _zone getvariable ("_list");

		_val = [_data,_list getvariable "_varsysname",ifcheck((_emit getvariable "emitType")=="particle",vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc)] call vcom_emit_prop_getPropByName;
		_itemList = _list getvariable "_itemList";

		//["setup at index %1 => %2",_itemList findif (_list getvariable "___comparerFunc"),_val] call printTrace;
		
		private _idxSet = (_itemList findif (_list getvariable "___comparerFunc"));
		if (_idxSet == -1) exitWith {
			setLastError(__FUNC__ + " index not found in _itemList <"+format["%1" arg _val]+">");
		};
		if (_idxSet == lbcursel _list && (_list lbdata _idxSet)==_val) exitwith {};
		
		_list lbsetcursel _idxSet; 
	};

	private _t = [_d,TEXT,[0,0,40,100],_zone] call createWidget;
	if equalTypes(_textName,[]) then {
		_textName params ["_t__","_des"];
		_t ctrlSetTooltip _des;
		_textName = _t__;
	};
	[_t,format["<t align='center' size='%2'>%1</t>",_textName,_sizeNameModif]] call widgetSetText;

	private _list = [_d,"RscCombo",[40,0,60,100],_zone] call createWidget;
	private _it = null;
	{
		_x params ["__n",["__ds",""]];
		_it = _list lbadd __n;
		_list lbSetTooltip [_it,__ds];
		_list lbSetData [_it,__ds];
	} foreach _itemList;

	_list ctrladdeventhandler ["LBSelChanged",{
		params ["_wid","_idx"];
		if (_idx == -1) exitWith {};
		[_wid getvariable "_varsysname",_wid lbData _idx,_wid] call ((_this select 0) getvariable "__eventUpdate");
		nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
	}];

	_list setvariable ["__eventUpdate",_eventUpdate];
	_list setvariable ["_varsysname",_varsysname];
	_list setvariable ["__onSyncFunction",_syncFunction];
	_list setvariable ["_zone",_zone];
	_list setvariable ["_itemList",_itemList];

	_list setvariable ["___comparerFunc",_comparerFunc];

	
	_zone setvariable ["_list",_list];
	_zone setvariable ["__onSyncFunction",_syncFunction];
	_zone setvariable ["_text",_t];

	_zone
};


/*

	See: vcom_emit_internal_createZoneVec3
*/
//used only for color
function(vcom_emit_internal_createZone_Vec4_RenderParams)
{
	params ["_varname","_size","_ctg","_props","_eventUpdate",["_colorPalette",true]]; //_eventUpdate - функция контроля за объектом из UI
	
	_props params ["_varsysname","_listnames","_rangeVec2_s","_delta",["_backColor",[0.5,0.5,0.5,0.7]],["_sizeNameModif",1]];
	_rangeVec2_s params ["_rangeVec3","_rangeAlpha"];

	private _d = call vcom_getDisplay;
	private _zone = [_d,WIDGETGROUP,_size,_ctg] call createWidget;
	_zone setvariable ["_thisZoneName",_varname];
	_ctg setvariable [_varname,_zone];
	private _listZones = _ctg getvariable ["_allZones",[]];
	_listZones pushBack _zone;
	_ctg setvariable ["_allZones",_listZones];

	if !isNullVar(_backColor) then {
		_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zone] call createWidget;
		_back setBackgroundColor _backColor;
	};

	private _syncFunction = {
		setScopeName("vcom_emit_internal_createZone_Vec4_RenderParams<_syncFunction>");
		private _zone = _this;
		private _emit = call vcom_emit_relpos_getSelectedEmitter;
		if isNullReference(_emit) exitwith {};
		private _isParticle = (_emit getvariable "emitType")=="particle";
		private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);
		private _data = _emit getvariable "data";
		private _clearSysName = _zone getvariable "_varsysname";
		private _updateColor = false;
		private _lastSlider = widgetNull;
		private _newcolorPalette = [0,0,0,1];
		private _enabledPalette = true;
		for "_i" from 0 to 3 do {
			_sli = _zone getvariable ("_slid_"+str _i);
			_inp = _zone getvariable ("_inp_"+str _i);
			_val = null;//[_data,_sli getvariable "_varsysname",_assocFunc] call vcom_emit_prop_getPropByName;
			if ([_clearSysName,_isParticle] call vcom_emit_lowlevel_isRenderParamName) then {
				private _list = [_data,_clearSysName] call vcom_emit_lowlevel_getRenderParamsValueFromData;
				private _curInd = _emit getvariable "animIndex";
				private _maxIndex = count _list - 1;
			
				//Условия видимости: предпоследний элемент установлен
				_inp ctrlEnable !(_curInd - 1 > _maxIndex);
				_sli ctrlEnable !(_curInd - 1 > _maxIndex);

				if (_curInd > _maxIndex) then {
					_val = "";
				} else {
					_val = _list select _curInd select _i;
				};
				//["updated val isrenderparam: %1",_val] call printTrace;
			};
			//["preset val %1 => %2",_sli getvariable "_varsysname",_val] call printTrace;
			
			_inp ctrlsettext ifcheck(equalTypes(_val,""),_val,str _val);
			_sli sliderSetPosition ifcheck(equalTypes(_val,""),parseNumber _val,_val);

			if (_sli getvariable ["_colorPalette",false]) then {
				_updateColor = true;
				_lastSlider = _sli;
				_val = ifcheck(equalTypes(_val,""),parseNumber _val,_val);
				if (_i <= 2) then {_val = clamp( _val ,0,1)};
				_newcolorPalette set [_i,_val];
				if !(ctrlEnabled _sli) then {
					_enabledPalette = false;
				};
			};
		};

		if _updateColor then {
			forceUnicode 0;
			private _colorPalette = _lastSlider getvariable "_colorPaletteWidget";
			private _alpha = _newcolorPalette select 3;
			_text = if (_alpha <= 0.5) then {format["<t size='1' color='%1'>%2</t>",_newcolorPalette call color_RGBtoHTML,
				("Цвет"splitString "" joinstring sbr)
			]} else {""};
			if (!_enabledPalette) then {
				_text = "<t size='1'>"+("выкл"splitString "" joinstring sbr)+"</t>";
			};
			[_colorPalette,_text] call widgetSetText;
			_colorPalette setBackgroundColor _newcolorPalette;
			_colorPalette ctrlEnable _enabledPalette;
		};
	};


	_perbut = 100/4;
	_colorPaletteSizeSlid = 62;
	_allSliders = [];
	for "_i" from 0 to 3 do {
		_col = [0,0,0,1];
		if (_i > 2) then {_col = [1,1,1,1]};
		_col set [_i,1];

		_t = [_d,TEXT,[0,_perbut*_i,10,_perbut],_zone] call createWidget;
		[_t,format["<t align='center' size='%2'>%1</t>",_listnames select _i,_sizeNameModif]] call widgetSetText;
		_t ctrlsettextColor _col;
		if (count _listnames >= 5) then {
			_t ctrlSetTooltip (_listnames select 4);
		};

		_inp = [_d,INPUT,[10,_perbut*_i,20,_perbut-8],_zone] call createWidget;
		_inp setvariable ["_index",_i];

		_inp ctrladdeventhandler ["KillFocus",{
			private _passedValue = ctrlText (_this select 0);
			private _varsysname = (_this select 0) getvariable "_varsysnameReal";
			_arrOffsetIdx = (_this select 0) getvariable "_index";
			/*
				Задача:
				1. Модифицировать структуру текущего кадра анимации и передать его в параметры
			*/
			private _emit = call vcom_emit_relpos_getSelectedEmitter;
			if isNullReference(_emit) exitwith {setLastError("vcom_emit_internal_createZone_Vec4_RenderParams - fatal error. Emitter cannot be null...")};
			_data = _emit getvariable "data";
			_curInd = _emit getvariable "animIndex";
			_list = [_data,_varsysname] call vcom_emit_lowlevel_getRenderParamsValueFromData;
			private _maxIndex = count _list - 1;
			if (_curInd > _maxIndex) then {
				_passedValue = "";
			} else {
				_tempVec4 = array_copy(_list select _curInd);
				_tempVec4 set [_arrOffsetIdx,parseNumberSafe(_passedValue)];
				_passedValue = str _tempVec4;
			};
			_zeroVec4Str = "[0,0,0,0]";
			//["Passed %1 outrange %2",_passedValue,_curInd > _maxIndex] call printTrace;

			[
				_varsysname,
				ifcheck(count _passedValue > 0,parseSimpleArray _passedValue,vec4(0,0,0,0)),
				_this select 0,
				ifcheck(equals(_passedValue,_zeroVec4Str),"",_passedValue)
			] call ((_this select 0) getvariable "__eventUpdate");

			nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
		}];

		_sizeWSlider = ifcheck(_colorPalette,_colorPaletteSizeSlid,70);
		_slid = [_d,SLIDERWNEW,[20+10,_perbut*_i,_sizeWSlider,_perbut-8],_zone] call createWidget;
		_slid ctrlSetActiveColor _col;
		_slid ctrlSetForegroundColor _col;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,_delta,_delta];
		
		_slid sliderSetRange ifcheck(_i>2,_rangeAlpha,_rangeVec3);
		_slid setvariable ["_index",_i];
		_slid setvariable ["_colorPalette",_colorPalette];
		_allSliders pushBack _slid;

		_slidPosChanged = {
			private _passedValue = _this select 1;
			private _varsysname = (_this select 0) getvariable "_varsysnameReal";
			_arrOffsetIdx = (_this select 0) getvariable "_index";
			
			/*
				Задача:
				1. Модифицировать структуру текущего кадра анимации и передать его в параметры
			*/
			private _emit = call vcom_emit_relpos_getSelectedEmitter;
			if isNullReference(_emit) exitwith {setLastError("vcom_emit_internal_createZone_Vec4_RenderParams - fatal error. Emitter cannot be null...")};
			_data = _emit getvariable "data";
			_curInd = _emit getvariable "animIndex";
			_list = [_data,_varsysname] call vcom_emit_lowlevel_getRenderParamsValueFromData;
			private _maxIndex = count _list - 1;
			if (_curInd > _maxIndex) then {
				_passedValue = "";
			} else {
				_tempVec4 = array_copy(_list select _curInd);
				_tempVec4 set [_arrOffsetIdx,_passedValue];
				_passedValue = str _tempVec4;
			};
			_zeroVec4Str = "[0,0,0,0]";
			
			[
				_varsysname,
				ifcheck(count _passedValue > 0,parseSimpleArray _passedValue,vec4(0,0,0,0)),
				_this select 0,
				str ifcheck(equals(_passedValue,_zeroVec4Str),"",_passedValue)
			] call ((_this select 0) getvariable "__eventUpdate");

			nextFrameParams((_this select 0)getvariable "__onSyncFunction",(_this select 0)getvariable "_zone");
		};
		_slid ctrladdeventhandler ["SliderPosChanged",_slidPosChanged];
		_slid setvariable ["_slidPosChanged",_slidPosChanged];

		{
			_x setvariable ["__eventUpdate",_eventUpdate];
			_x setvariable ["_varsysname",_varsysname+(_listnames select _i)];
			_x setvariable ["_varsysnameReal",_varsysname];
			_x setvariable ["__onSyncFunction",_syncFunction];
			_x setvariable ["_zone",_zone];
			//for system check in vcom_emit_internal_common_currentEmitterPropertySetup
			_x setvariable ["__internal_const_isRenderParamVec4",true];
		} foreach [_slid,_inp];

		_zone setvariable ["_slid_"+str _i,_slid];
		_zone setvariable ["_inp_"+str _i,_inp];
		_zone setvariable ["__onSyncFunction",_syncFunction];
	};

	if (_colorPalette) then {
		_color = [_d,TEXT,[20+10+_colorPaletteSizeSlid +1,_perbut*0+2,70-_colorPaletteSizeSlid - 2,(_perbut*4)-8],_zone] call createWidget;
		_color setBackgroundColor [1,1,1,1];
		{_x setvariable ["_colorPaletteWidget",_color]} foreach _allSliders;
		_color setvariable ["__onSyncFunction",_syncFunction];
		_color setvariable ["_zone",_zone];
		_color setvariable ["_allSliders",_allSliders];
		_color ctrlSetTooltip "Нажмите ЛКМ для открытия палитры цветов";
		_color ctrladdeventhandler ["MouseButtonUp",{
			params ["_wid","_key"];
			_zone = _wid getvariable "_zone";
			_syncFunction = _wid getvariable "__onSyncFunction";
			if (_key == MOUSE_LEFT) then {
				_ref = refcreate(0);
				_buildedColor = [0,0,0,0];
				{_buildedColor set [_foreachIndex,sliderPosition _x]} foreach (_wid getvariable "_allSliders");
				if ([_ref,_buildedColor,4] call widget_winapi_openColor) then {
					_ref = refget(_ref);
					_ref set [3,_buildedColor select 3];
					_allSliders = array_copy(_wid getvariable "_allSliders");
					reverse _allSliders; //if not setted rendercolor then alpha basicly set to 0
					reverse _ref;
					{
						_passedValue = _ref select _foreachIndex;
						[_x,_passedValue] call (_x getvariable "_slidPosChanged");
					} foreach _allSliders;
					//nextFrameParams(_syncFunction,_zone);
				};
			};
		}];
	};

	_zone setvariable ["_varsysname",_varsysname];

	_zone
}