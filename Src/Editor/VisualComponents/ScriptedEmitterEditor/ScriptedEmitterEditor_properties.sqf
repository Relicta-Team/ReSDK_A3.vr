// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	процедура загрузки и синхронизации:
	Все данные хранятся в сериализованном массиве 
	
*/

function(vcom_emit_getPropertiesCtg) {(call vcom_emit_getWidgetCtgProperties) getvariable _this}

function(vcom_emit_getVarInProps) {
	private _setName = _this deleteAt 0; 
	private _ctg = _setName call vcom_emit_getPropertiesCtg;
	private _temp = _ctg;
	{
		_temp = _temp getvariable _x;
	} foreach _this;
	_temp
}

function(vcom_emit_loadPropertiesWidgets)
{
	private _d = call vcom_getDisplay;
	private _ctg = call vcom_emit_getWidgetCtgProperties;

	private _emitTypes = vcom_emit_emitterTypeKeysSorted;
	
	//do not change order of initialize

	private _ctgLight = [_d,WIDGETGROUP,WIDGET_FULLSIZE,_ctg] call createWidget;
	_ctg setvariable ["_ctgLight",_ctgLight];

	private _ctgReflector = [_d,WIDGETGROUP,WIDGET_FULLSIZE,_ctg] call createWidget;
	_ctg setvariable ["_ctgReflector",_ctgLight];

	private _ctgParticle = [_d,WIDGETGROUP,WIDGET_FULLSIZE,_ctg] call createWidget;
	_ctg setvariable ["_ctgParticle",_ctgParticle];

	private _allEmitCtgs = [_ctgLight,_ctgReflector,_ctgParticle];
	_ctg setvariable ["_allEmittersCtg",_allEmitCtgs];

	{
		_x setvariable ["_type",_emitTypes select _foreachindex];
	} foreach _allEmitCtgs;

	[_ctgLight] call vcom_emit_internal_makeLightWidgetProperties;
	[_ctgReflector,true] call vcom_emit_internal_makeLightWidgetProperties;
	[_ctgParticle] call vcom_emit_internal_makeParticleWidgetProperties;

}

//функция общего назначения. скрывает невидимые виджеты, показывает видимые и вызывает __onSyncFunction
function(vcom_emit_syncPropsToWidgets)
{
	private _obj = call vcom_emit_relpos_getSelectedEmitter;
	private _type = if isNullReference(_obj) then {""} else {_obj getvariable "emitType"};
	private _ctg = widgetNull;
	{
		if ((_x getvariable "_type") == _type) then {
			_x ctrlEnable true;
			_x ctrlShow true;
			_ctg = _x;
		} else {
			_x ctrlEnable false;
			_x ctrlShow false;
		};
	} foreach (["_allEmittersCtg"] call vcom_emit_getVarInProps);

	if isNullReference(_ctg) exitwith {};

	//это обновление тут не должно происходить однако происходит...
	//Без него например при загрузке частиц из конфига не будет синхроинизирован максимальный допустимый индекс
	if (!isNullReference(_obj) && _type == "particle") then {
		_obj setvariable ["animIndex",(_obj getvariable "animIndex") min (call vcom_emit_lowlevel_RenderParams_getMaxStepnr)];
	};

	{
		//["setup prop before %1",_x getvariable "_thisZoneName"] call printTrace;
		_x call (_x getvariable "__onSyncFunction");
	} foreach (_ctg getvariable "_allZones");
}

function(vcom_emit_internal_makeLightWidgetProperties)
{
	params ["_ctg",["_addReflectorsButtons",false]];
	private _d = call vcom_getDisplay;
	private _yPos = 0; _dropYPos = {_yPos = 0;};
	private _xPos = 0; _dropXPos = {_xPos = 0;};
	private _defBackground = [0.3,0.3,0.3,1];

	private _listConfigs = [_d,LISTBOX,[0,0,10,50],_ctg] call createWidget;
	_ctg setvariable ["_listConfigs",_listConfigs];
	_listConfigs setvariable ["_isReflectorList",_addReflectorsButtons];
	_listConfigs setvariable ["__handleReloadList",{
		params ["_listConfigs"];
		private _it = null;
		private _addReflectorsButtons = _listConfigs getvariable "_isReflectorList";
		private _refList = ifcheck(_addReflectorsButtons,vcom_emit_lowlevel_allReflectors,vcom_emit_lowlevel_allLights);
		lbclear _listConfigs;
		_listConfigs lbsetcursel -1;

		{
			_x params ["_confgiName","_configRef"];
			_it = _listConfigs lbAdd _confgiName;
			_listConfigs lbSetTooltip [_it,_confgiName];
		} foreach _refList;
	}];
	[_listConfigs] call (_listConfigs getvariable "__handleReloadList");

	modvar(_yPos) + 50;

	private _butLoad = [_d,BUTTON,[_xPos,_yPos,10,20],_ctg] call createWidget;
	_butLoad ctrlsettext "Загрузить";
	_butLoad ctrlSetTooltip "Загружает настройки освещения из конфигурации";
	_butLoad ctrladdeventhandler ["MouseButtonUp",{
		_c = {
			params ["_listConfigs"];
			private _idx = lbcursel _listConfigs;
			private _addReflectorsButtons = _listConfigs getvariable "_isReflectorList";
			private _refList = ifcheck(_addReflectorsButtons,vcom_emit_lowlevel_allReflectors,vcom_emit_lowlevel_allLights);
			if (_idx < 0 || _idx > ((count _refList) - 1)) exitwith {};

			private _ltDat = _refList select _idx select 1;
			
			private _emit = call vcom_emit_relpos_getSelectedEmitter;
			if isNullReference(_emit) exitwith {};
			if ((_emit getvariable "emitType") == "particle") exitwith {setLastError("Undefined behaviour at load config to selected emitter")};
			
			private _data = _emit getvariable "data";
			_emit setvariable ["data",
				//deep copy data
				call compile str _ltDat
			];
			//update render value
			[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
			//sync visual values
			call vcom_emit_syncPropsToWidgets;
		};
		nextFrameParams(_c,[(_this select 0)getvariable "_listConfigs"]);
	}];
	_butLoad setvariable ["_listConfigs",_listConfigs];

	//debug----------------------
		// _codecheck = [_d,INPUT,[0,50,10,30],_ctg] call createWidget;
		// _inp = [_d,BUTTON,[0,50+30,10,20],_ctg] call createWidget;
		// _inp setvariable ["_codecheck",_codecheck];
		// _inp ctrladdeventhandler ["mousebuttonup",{
		// 	_c = call compile ctrlText ((_this select 0) getvariable "_codecheck");
		// 	["output:%1",_c] call printTrace;
		// }];
	//--------------------debugend
	
	modvar(_xPos) + 10;
	call _dropYPos;

	private _eventControlVec3 = vcom_emit_internal_common_currentEmitterPropertySetup;
	private _t = widgetNull;

	_t = [_d,TEXT,[_xPos,_yPos,30,5],_ctg] call createWidget;
	[_t,"<t align='center'>Цвет источника света</t>"] call widgetSetText;
	_t ctrlSetTooltip "Установите рассеянный цвет света.\nОсвещает поверхности, обращенные к свету";
	_t setBackgroundColor [0.2,0.2,0.2,0.2];
	modvar(_yPos) + 5;
	["_zoneColor",[_xPos,_yPos,30,30-5],_ctg,
		["color",["R","G","B"],[0,1],0.01,_defBackground,1.7],
		_eventControlVec3,true
	] call vcom_emit_internal_createZoneVec3;
	modvar(_yPos) + 25;

	_t = [_d,TEXT,[_xPos,_yPos,30,5],_ctg] call createWidget;
	[_t,"<t align='center'>Цвет окружающего освещения</t>"] call widgetSetText;
	_t ctrlSetTooltip "Задайте цвет окружающего освещения.\nСюда входят поверхности, которые обращены в сторону от света, в отличие от цвета источника";
	_t setBackgroundColor [0.2,0.2,0.2,0.2];
	modvar(_yPos) + 5;
	["_zoneAmbient",[_xPos,_yPos,30,30-5],_ctg,
		["ambient",["R","G","B"],[0,1],0.01,_defBackground,1.7],
		_eventControlVec3,true
	] call vcom_emit_internal_createZoneVec3;
	modvar(_yPos) + 25;

	if (_addReflectorsButtons) then {
		private _colAngleSettings = "#702B4B" call color_HTMLtoRGBA;
		private _colAngleSettings2 = "#A66382" call color_HTMLtoRGBA;
		["_zoneConeOuterAngle",[_xPos,_yPos,15,20],_ctg,
			["coneouterangle","Внешний угол",true,[0,360],0.01,_colAngleSettings,0.7],
			_eventControlVec3
		] call vcom_emit_internal_createZoneInput;
		//modvar(_yPos) + 15;

		["_zoneConeInnerAngle",[_xPos+15+1,_yPos,15-1,20],_ctg,
			["coneinnerangle","Внутренний угол",true,[0,360],0.01,_colAngleSettings,0.7],
			_eventControlVec3
		] call vcom_emit_internal_createZoneInput;
		modvar(_yPos) + 20;

		["_zoneConeFadeCoef",[_xPos,_yPos,30,20],_ctg,
			["conefadecoef","Коэффициент затухания",true,[0,10000],0.01,_colAngleSettings2,0.7],
			_eventControlVec3
		] call vcom_emit_internal_createZoneInput;
	};


	call _dropYPos; modvar(_xPos) + 30;

	// _t = [_d,TEXT,[_xPos,_yPos,30,5],_ctg] call createWidget;
	// [_t,"<t align='center'>Интенсивность свечения</t>"] call widgetSetText;
	// _t ctrlSetTooltip "Задаёт интенсивность источника света";
	// _t setBackgroundColor [0.2,0.2,0.2,0.2];
	// modvar(_yPos) + 5;
	private _colIntensity = "#E3C739" call color_HTMLtoRGBA;
	["_zoneIntensity",[_xPos,_yPos,30,30-5],_ctg,
		["intensity","Интенсивность света",true,[0,400000],0.01,_colIntensity,1.7],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;

	modvar(_yPos) + 30-5  + 10;

	private _backUseFlare = "#5B9E37" call color_HTMLtoRGBA;

	["_zoneUseFlare",[_xPos,_yPos,30,5],_ctg,
		["useflare","Видимость блика",_backUseFlare,1.1],
		_eventControlVec3
	] call vcom_emit_internal_createZoneCheckbox;

	modvar(_yPos) + 5;

	["_zoneFlareSize",[_xPos,_yPos,30,30-5],_ctg,
		["flaresize","Размер блика",true,[0,100],0.001,_backUseFlare,1.7],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;

	modvar(_yPos) + 30-5;

	["_zoneFlareMaxDist",[_xPos,_yPos,30,30-5],_ctg,
		["flaremaxdist","Дальность видимости блика",true,[0,100],0.01,_backUseFlare,1.7],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;

	call _dropYPos; modvar(_xPos) + 30;

	_t = [_d,TEXT,[_xPos,_yPos,30,5],_ctg] call createWidget;
	[_t,"<t align='center'>Затухание</t>"] call widgetSetText;
	modvar(_yPos) + 5;
	private _attenTextSize = 0.8;
	
	private _attenuationColor = "#E35E39" call color_HTMLtoRGBA;
	private _attenuationColor2 = "#704438" call color_HTMLtoRGBA;

	["_zoneAttenuationStart",[_xPos,_yPos,30,15],_ctg,
		["attenuationstart",["Старт","Дистанция со 100% интенсивностью, спад начинается здесь.\n\n"+
		"Этот параметр определяет диапазон, в котором источник света вступает в силу.\n"+
		"Цвет окружающей среды ландшафта будет залит 'light ambient' в пределах диапазона,\n"+
		"а его покрытые объекты будут отражать цвет с помощью 'light color'"],true,[0,999999],0.01,_attenuationColor,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

	["_zoneAttenuationConst",[_xPos,_yPos,30,15],_ctg,
		["attenuationconstant",["Константа","Постоянный коэффициент затухания.\n\n"+
		"Этот параметр определяет пропорцию яркости источника света, чем больше число,\n"+
		"тем меньше будет яркость, и наоборот. Этот параметр связан с 'Интенсивностью' света"],true,[0,999999],0.01,_attenuationColor,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

	["_zoneAttenuationLinear",[_xPos,_yPos,30,15],_ctg,
		["attenuationlinear",["Линейный коэфф.","Коэффициент линейного затухания\n\n"+
		"Этот параметр определяет концентрацию источника света, чем больше число,\n"+
		"тем больше концентрируется свет, и наоборот.\n"+
		"Другими словами, этот параметр превратит источник в прожектор и сделает его границу светлого круга более резкой."],true,[0,999999],0.01,_attenuationColor,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

	["_zoneAttenuationQuadratic",[_xPos,_yPos,30,15],_ctg,
		["attenuationquadratic",["Квадратичный коэфф.","Квадратичный коэффициент затухания\n\n"+
		"Этот параметр определяет диапазон, в котором виден источник света, и его визуальное\n"+
		"представление похоже на линейное. 0 означает максимальную видимую дальность."],true,[0,999999],0.01,_attenuationColor,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

	["_zoneAttenuationHardlimitStart",[_xPos,_yPos,30,15],_ctg,
		["attenuationhardlimitstart",["Старт жесткого ограничения","Максимальное расстояние начала жесткого ограничения (начало уменьшения интенсивности до 0) в метрах"],true,[0,100],0.001,_attenuationColor2,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

	["_zoneAttenuationHardlimitEnd",[_xPos,_yPos,30,15],_ctg,
		["attenuationhardlimitend",["Конец жесткого ограничения","Максимальное расстояние до конца жесткого ограничения (конец затухания интенсивности до 0) в метрах"],true,[0,100],0.001,_attenuationColor2,_attenTextSize],
		_eventControlVec3
	] call vcom_emit_internal_createZoneInput;
	modvar(_yPos) + 15;

}

//Общая функция установки значений
//_rawValue - сырое значение. возможно строка
function(vcom_emit_internal_common_currentEmitterPropertySetup)
{
	params ["_varname","_val","_widget","_rawValue"];

	private _emit = call vcom_emit_relpos_getSelectedEmitter;
	if isNullReference(_emit) exitwith {};
	private _data = _emit getvariable "data";
	private _isParticle = (_emit getvariable "emitType")=="particle";
	private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);

	private _isVec4RenderParamVal = !isNullReference(_widget) && {_widget getvariable ["__internal_const_isRenderParamVec4",false]};

	//если свойство является свойством рендеринга частицы
	if ([_varname,_isParticle] call vcom_emit_lowlevel_isRenderParamName) then {
		
		//берем старое значение, обновляем по индексу и устанавливаем
		private _oldProp = [_data,_varname,_assocFunc] call vcom_emit_prop_getPropByName;
		//["Old prop (%1) at index %3 was %2",_varname,_oldProp,_curIndex] call printTrace;

		private _curIndex = _emit getvariable "animIndex";
		private _maxIndex = count _oldProp - 1;

		//Проверка ограничений - если предыдущие значения
		private _hasError = false;
		for "_i" from 0 to _curIndex - 1 do {
			if isNull(_oldProp select _i) exitwith {
				_hasError = true;
				setLastError(__FUNC__ + " - empty data at index; Data:"+str _oldProp + "; Index:"+str _i);
			};
		};
		if (_hasError) exitwith {_val = _oldProp;};
		
		//val logic
		private _hasValue = not_equals(_rawValue,"");
		
		//мы можем удалить значение только у последнего индекса
		if (!_hasValue && _curIndex != _maxIndex) then {_hasValue = true};

		if (_hasValue) then {
			_oldProp set [_curIndex,_val];
		} else {
			//проверяем условия:
			//текущий индекс не превышает максимальный индекс
			if (_curIndex > _maxIndex) exitwith {
				setLastError(__FUNC__ + " cannot update value '"+_varname+"': _curIndex > _maxIndex");	
			};
			//?может ли быть текущий индекс не равен последнему - нет, не может
			if (_curIndex != _maxIndex) exitwith {
				setLastError(__FUNC__ + " implemented only last removing element on " + _varname);
			};

			//значения нет. удаляем данные
			_oldProp deleteAt _curIndex;
		};

		
		_val = _oldProp;
		//["UPDATED Old prop (%1) at index %3 was %2",_varname,_oldProp,_curIndex] call printTrace;
	};

	[_data,_varname,_val,_assocFunc] call vcom_emit_prop_setPropByName;
	[_emit] call vcom_emit_prop_syncEmitterPropsFromData;	
}
//combobox is listbox but with drop-down logic
function(vcom_emit_internal_common_currentEmitterPropertySetup_forComboBox)
{
	//Поскольку логика идентична - выполняем такие же действия как и в стандарном сетапере
	_this call vcom_emit_internal_common_currentEmitterPropertySetup
	// params ["_varname","_val","_widget"];
	// private _itemList = _widget getvariable "_itemList";

	// private _emit = call vcom_emit_relpos_getSelectedEmitter;
	// if isNullReference(_emit) exitwith {};
	// private _data = _emit getvariable "data";
	// private _isParticle = (_emit getvariable "emitType")=="particle";
	// private _assocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);
	// if ([_varname,_isParticle] call vcom_emit_lowlevel_isRenderParamName) then {
	// 	private _oldProp = [_data,_varname,_assocFunc] call vcom_emit_prop_getPropByName;
	// 	_oldProp set [_emit getvariable "animIndex",_val];
	// 	_val = _oldProp;
	// };
	// [_data,_varname,_val,_assocFunc] call vcom_emit_prop_setPropByName;
	// [_emit] call vcom_emit_prop_syncEmitterPropsFromData;	
}

//Первичная загрузка свойств, установка в объект переменных с данными
function(vcom_emit_createEmitterProperties)
{
	params ["_emitObj","_optData"];
	private _emitType = _emitObj getvariable "emitType";

	if !isNullVar(_optData) then {
		private _emitterStorage = ifcheck(_emitType == "particle",call vcom_emit_lowlevel_createParticleData,call vcom_emit_lowlevel_createLightData);
		_optData resize (count _emitterStorage);
		{
			private _cur = _optData select _foreachIndex;
			if !isNullVar(_cur) then {
				_emitterStorage set [_foreachIndex,_cur];
			};
		} foreach _emitterStorage;
		_emitObj setvariable ["data",_emitterStorage];
	} else {
		private _emitterStorage = ifcheck(_emitType == "particle",call vcom_emit_lowlevel_createParticleData,call vcom_emit_lowlevel_createLightData);
		_emitObj setvariable ["data",_emitterStorage];
	};
	
	if (_emitType == "particle") then {
		_emitObj setvariable ["animIndex",0];
	};

	[_emitObj] call vcom_emit_prop_syncEmitterPropsFromData;
}

//Получает значение из propData: [_emitterStorage,"ambient",vcom_emit_prop_internal_getLightAssoc] call vcom_emit_prop_getPropByName
function(vcom_emit_prop_getPropByName)
{
	params ["_propdata","_propname",["_assocFunc",{[]}]];
	private _indexier = [];
	_propname = toLower _propname;
	private _assocList = call _assocFunc;
	{
		if ((_x select 0) == _propname) exitwith {
			_indexier = _x select 1;
		};
	} foreach _assocList;
	if (count _assocList == 0) exitwith {setLastError(__FUNC__ + " - empty assoc func; Prop:" + _propname)};
	if (count _indexier==0) exitwith {setLastError(__FUNC__ + " - Out of range error; Prop:" + _propname)};
	if (count _propdata==0) exitWith {setLastError(__FUNC__ + " - propdata is empty; Prop:"+_propname)};

	private _temp = _propdata;
	{
		if (_x >(count _temp -1) ) then {
			private _d = format["%1; %2; %3; %4",_temp,_x,_propname,_propdata];
			setLastError(__FUNC__ + " - Array out of bounds error:" +_d);
		};
		_temp = _temp select _x;
	} foreach _indexier;
	_temp
}
//записать значение в data
function(vcom_emit_prop_setPropByName)
{
	params ["_propdata","_propname","_val",["_assocFunc",{[]}]];
	private _indexier = [];
	_propname = toLower _propname;
	private _assocList = call _assocFunc;
	{
		if ((_x select 0) == _propname) exitwith {
			_indexier = _x select 1;
		};
	} foreach _assocList;
	if (count _indexier==0) exitwith {setLastError(__FUNC__ + " - Out of range error; Prop:"+_propname)};

	private _temp = _propdata;
	private _lastSetter = array_remlast(_indexier);
	{
		_temp = _temp select _x;
	} foreach _indexier;

	_temp set [_lastSetter,_val];
}

function(vcom_emit_prop_internal_getLightAssoc)
{
	[
		["color", [0]], 
		["colorr", [0, 0]], 
		["colorg", [0, 1]], 
		["colorb", [0, 2]], 
		["ambient", [1]], 
		["ambientr", [1, 0]], 
		["ambientg", [1, 1]], 
		["ambientb", [1, 2]], 
		["intensity", [2]], 
		["useflare", [3]], 
		["flaresize", [4]], 
		["flaremaxdist", [5]], 
		["daylight", [6]], 
		["attenuation", [7]], 
		["attenuationstart", [7, 0]], 
		["attenuationconstant", [7, 1]], 
		["attenuationlinear", [7, 2]], 
		["attenuationquadratic", [7, 3]], 
		["attenuationhardlimitstart", [7, 4]], 
		["attenuationhardlimitend", [7, 5]],
		["conepars",[8]],
		["coneouterangle", [8,0]],
		["coneinnerangle", [8,1]],
		["conefadecoef", [8,2]]
	]
}

function(vcom_emit_prop_syncEmitterPropsFromData)
{
	params ["_emit"];
	private _isParticle = (_emit getvariable "emitType")=="particle";
	private _lightAssocFunc = ifcheck(_isParticle,vcom_emit_prop_internal_getParticleAssoc,vcom_emit_prop_internal_getLightAssoc);
	private _light = _emit call vcom_emit_getEmitterVisual;
	private _data = _emit getvariable "data";

	if (_isParticle) then {

		_light setParticleParams ([_data,"particleParams",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setParticleRandom ([_data,"particleRandom",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setParticleCircle ([_data,"particleCircle",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setDropInterval ([_data,"particleDropInterval",_lightAssocFunc] call vcom_emit_prop_getPropByName);

		_light setParticleParams ([_data,"particleParams",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setParticleRandom ([_data,"particleRandom",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setParticleCircle ([_data,"particleCircle",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setDropInterval ([_data,"particleDropInterval",_lightAssocFunc] call vcom_emit_prop_getPropByName);
	} else {
		_light setLightColor ([_data,"color",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setLightAmbient ([_data,"ambient",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setLightIntensity ([_data,"intensity",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setLightUseFlare ([_data,"useflare",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setLightFlareSize ([_data,"flaresize",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		_light setLightFlareMaxDistance ([_data,"flaremaxdist",_lightAssocFunc] call vcom_emit_prop_getPropByName);
		
		//system setup
		_light setLightDayLight true;

		_light setLightAttenuation ([_data,"attenuation",_lightAssocFunc] call vcom_emit_prop_getPropByName);

		if ((_emit getvariable "emitType") == "directlight") then {
			_light setLightConePars ([_data,"conepars",_lightAssocFunc] call vcom_emit_prop_getPropByName)
		};
	};
	
}