// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Visual scripted particle and lighting editor
	
	config storage emplace:
	Скриптовые конфиги создаются в рантайме

	regScriptEmit(name) //ineditor: start of cfg location
			[ //this is array
				["particle",
					[custom events] //function reference on special conditions
					["setParticleParams",[...]],
					["setParticleRandom",[...]],
					...
				],
				["light",
					null // if null - no custom events
					["setLightColor",[...]],
					["setLightAttenuation",[...]]
				],
				[..etc type]
			]
	endScriptEmit //ineditor: eocfg location

*/

#include "ScriptedEmitterEditor\ScriptedEmitterEditor_properties.sqf"
#include "ScriptedEmitterEditor\ScriptedEmitterEditor_lowLevel.sqf"
#include "ScriptedEmitterEditor\ScriptedEmitterEditor_properties_particles.sqf"
#include "ScriptedEmitterEditor\ScriptedEmitterEditor_visual.sqf"
#include "ScriptedEmitterEditor\ScriptedEmitterEditor_io.sqf"

pragma_line




init_function(vcom_emit_initialize)
{

	//!do not change this values
	vcom_emit_minConfigId = 2100;
	vcom_emit_maxConfigId = 4900;

	vcom_emit_pathToConfigsData = ""; //here writed data
	vcom_emit_pathToConfigsId = ""; //here writed

	vcom_emit_widgets = [widgetNull,widgetNull];

	//насколько каждая точка может быть от начала координат (для любой оси)
	vcom_emit_maxPointDistance = 50;
	vcom_emit_sliderPosChangeDelta = 0.001;

	vcom_emit_emitterTypeAssoc = createHashMapFromArray [
		["pointlight",["#lightpoint","lt","Точечный свет"]],
		["directlight",["#lightreflector","ltd","Направленный свет"]],
		["particle",["#particlesource","pt","Частицы"]]
	];

	vcom_emit_assocCfgNameShortToFull = createHashMap;
	{
		vcom_emit_assocCfgNameShortToFull set [_y select 1,_x];
	} foreach vcom_emit_emitterTypeAssoc;

	vcom_emit_emitterTypeKeysSorted = ["pointlight","directlight","particle"];
	//данные для копирования: vec2: isParticle(bool),data(emitterData)
	vcom_emit_internal_copyedData = null;

	vcom_emit_envObject_ground = objNull;
		vcom_emit_envObject_groundAreaList = [];
	vcom_emit_envObjects_list_box = [];
}

function(vcom_emit_closeVisualWindow)
{
	[ 
		"Вы уверены? Несохраненные данные будут утеряны.", 
		"Закрытие редактора", 
		[ 
			"Закрыть", 
			{ 
				nextFrame(vcom_emit_closeVisualWindowHandled)
			} 
		], 
		[ 
			"Отмена", 
			{ } 
		], 
			"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
			call vcom_getDisplay
	] call createMessageBox;
}

function(vcom_emit_closeVisualWindowHandled)
{
	//! конфиги не должны сохраняться при выходе
	//[vcom_emit_io_list_allConfigsNames] call vcom_emit_io_saveAllConfigs;

	call displayClose;
	false call rendering_setInGameHDR;

	if (lsim_mode) exitWith {
		// call lsim_internal_buildScriptedConfigs
		// call lsim_internal_rebuildAllLights;
		if !(call rendering_isNightEnabled) then {
			true call rendering_setNight;
		};
		if (!call rendering_isInGameHDREnabled) then {
			true call rendering_setInGameHDR;
		};
	};

	if (call rendering_isNightEnabled) then {
		false call rendering_setNight;
	};
}

function(vcom_emit_openMainContextMenuSettings)
{
	_stackMenu = [];
	//vec2: name, [code | list] ,["_condToVisible",{true}],["_desc",""]

	_stackMenu pushBack [ifcheck(vcom_visual_canDrawLines,"Выключить","Включить") + " линии расстояния",{vcom_visual_canDrawLines = !vcom_visual_canDrawLines},null,
	"Включает или отключает линии для измерения расстояний"];

	_stackMenu pushBack [ifcheck(vcom_visual_renderDebugGeometry,"Выключить","Включить") + " отладку света",{
		vcom_visual_renderDebugGeometry = !vcom_visual_renderDebugGeometry;
	},null,"Включает или выключает отладочную визуализацию направленных и сферических источников освещения"];

	_setText = ifcheck(call rendering_isNightEnabled,"Включить","Выключить");
	_stackMenu pushBack [_setText+" глобальное освещение",{
		call vcom_emit_opt_switchNight;
	},null,"Переключает глобальное освещение"];
	_stackMenu pushBack [ifcheck(call rendering_isInGameHDREnabled,"Отключить","Включить") + " собственный рендер",{
		call vcom_emit_opt_switchRender;
	},null,"Собственный рендер, это HDR режим, активируемый в симуляции на клиенте"];

	if !isNullReference(vcom_emit_envObject_ground) then {
		_stackMenu pushBack [
			"<t size='1'>"+ifcheck(isObjectHidden vcom_emit_envObject_ground,"Включить","Выключить") + " показ пола</t>",
			{
				call vcom_emit_opt_switchFloor;	_newval = !(isObjectHidden vcom_emit_envObject_ground);
				vcom_emit_envObject_ground hideObject _newval;
				{
					_x hideObject _newval;
				} foreach vcom_emit_envObject_groundAreaList;
			},null,"Показывает или скрывает поверхность под центральной позицией эмиттеров"
		];
	};
	if (count vcom_emit_envObjects_list_box > 0 && {!isNullReference(vcom_emit_envObjects_list_box select 0)}) then {
		_stackMenu pushBack [
			"<t size='1'>"+ifcheck(isObjectHidden (vcom_emit_envObjects_list_box select 0),"Включить","Выключить") + " показ окружения</t>",
			{
				{
					_x hideObject !(isObjectHidden _x);
				} foreach vcom_emit_envObjects_list_box;
			},null,"Показывает или скрывает окружающие объекты вокруг эмиттеров"
		];
	};

	[
		_stackMenu + [["Отмена",{}]],
		call mouseGetPosition,
		[]
	] call dcm_create;
}

	function(vcom_emit_opt_switchNight)
	{
		private _oldMode = call rendering_isNightEnabled;
		(!_oldMode) call rendering_setNight
	}

	function(vcom_emit_opt_switchRender)
	{
		(!call rendering_isInGameHDREnabled) call rendering_setInGameHDR
	}

	function(vcom_emit_opt_switchFloor)
	{
		private _newval = !(isObjectHidden vcom_emit_envObject_ground);
		vcom_emit_envObject_ground hideObject _newval;
		{
			_x hideObject _newval;
		} foreach vcom_emit_envObject_groundAreaList;
	}

	function(vcom_visual_drawDebugGeometry)
	{
		{
			_etype = _x call vcom_emit_getEmitterType;
			if (_etype in ["pointlight","directlight"]) then {
				_vis = _x call vcom_emit_getEmitterVisual;
				_data = _x getvariable "data";
				_atten = [_data,"attenuation",vcom_emit_prop_internal_getLightAssoc] call vcom_emit_prop_getPropByName;
				if (_etype == "pointlight") then {
					_rad = _atten select 5;
					_startRad = _atten select 4;
					
					_p = getposatl _vis;
					[_p,[1,1,0,1],30,_rad,16] call debug_drawSphereEx;
					[_p,[1,0,0,1],15,_startRad,16] call debug_drawSphereEx;
				};
				if (_etype == "directlight") then {
					_cone = [_data,"conepars",vcom_emit_prop_internal_getLightAssoc] call vcom_emit_prop_getPropByName;
					
					_p = getposatl _vis;
					([_vis] call model_getPitchBankYawAccurate) params ["_pt","_bk"];
					_outAngle = _cone select 0;
					_inAngle = _cone select 1;
					_distance = _atten select 5;
					[
						_p,
						_vis modeltoworld [0,_distance,0],
						_outAngle,
						_inAngle,
						0.5, //attenuation
						[1,1,0,1],
						[1,0,0,1],
						15 //width
					] call debug_drawLightConeEx	
				};
				
			};
		} foreach (["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets)
	}

function(vcom_emit_createEmitterObject)
{
	params ["_emitterTypeCfg","_emitType"];
	private _emit = _emitterTypeCfg createVehicleLocal [0,0,0];
	private _storage = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	_storage setvariable ["emitter",_emit];
	_storage setvariable ["type",_emitType];
	_storage setvariable ["attributes",[]];
	_storage
}
function(vcom_emit_getEmitterVisual) {_this getvariable "emitter"}
function(vcom_emit_getEmitterType) {_this getvariable "type"}
function(vcom_emit_deleteEmitterObject) {deleteVehicle(_this call vcom_emit_getEmitterVisual);deleteVehicle _this}

function(vcom_emit_createVisualWindow)
{
	params [["_object",objNull]];
	//cleanup data
	vcom_emit_internal_copyedData = null;

	["emit"] call vcom_openWindow;
	call vcom_emit_createNotifyWidget;
	[[20,0,100-20,60]] call vcom_observ_loadCameraController;

	[ifcheck(isNullReference(_object),"relicta_models\models\nocategory\zvak.p3d",_object),null,false] call vcom_loadModel;
	call vcom_observ_centerAtModel;

	private _d = call vcom_getDisplay;
	private _ctg = call vcom_getCtg;
	private _ctgSettings = [_d,WIDGETGROUP_H,[0,0,20,60],_ctg] call createWidget;
	vcom_emit_widgets set [0,_ctgSettings];

	private _ctgProps = [_d,WIDGETGROUP,[0,60,100,100-60],_ctg] call createWidget;
	vcom_emit_widgets set [1,_ctgProps];

	{
		if isNullReference(_x) then {continue};

		private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_x] call createWidget;
		_back setBackgroundColor [0.5,0.5,0.5,1];
		_x setVariable ["_back",_back];

		//_x ctrladdeventhandler ["MouseEnter",{ctrlsetfocus (_this select 0)}];
	} foreach vcom_emit_widgets;

	call vcom_emit_loadSettingsWidgets;

	call vcom_emit_loadPropertiesWidgets;

	[true] call vcom_emit_loadEnvObjects;

	//Обязательно вызываем в конце сброс выборки	
	[-1] call vcom_emit_updateSelection;

	//current config is empty
	vcom_emit_io_currentConfig = "";

	call vcom_emit_io_readConfigs;

	//reditor config check
	if (cfg_emed_enableFloorByDefault) then {
		call vcom_emit_opt_switchFloor;
	};

	if (!lsim_mode) then {
		if (cfg_emed_enableCustomRenderByDefault) then {
			call vcom_emit_opt_switchRender;
		};
		if (cfg_emed_enableNightByDefault) then {
			call vcom_emit_opt_switchNight;
		};
	};

	["Редактор загружен",10] call showInfo;
	// {
		
	// 	_x ctrladdeventhandler ["SetFocus",{
	// 		_ct = _this select 0;
	// 		_p = ["focus changed to %1(%2); pos:%4 vars:%3",_ct,ctrlclassname _ct,(allVariables _ct) joinstring ",",_ct call widgetGetPosition]; 
	// 		_p = call printTrace;
	// 	}];

	// 	_ct = _x;
	// 	_p = format["%1(%2); pos:%4; vars:%3",_ct,ctrlclassname _ct,(allVariables _ct) joinstring ",",_ct call widgetGetPosition]; 
	// 	_x ctrlSetTooltip (_p splitString ";" joinstring "\n");
		
	// } foreach (allControls _d);
}

function(vcom_emit_getWidgetCtgSettings) {vcom_emit_widgets select 0}
function(vcom_emit_getWidgetCtgProperties) {vcom_emit_widgets select 1}

function(vcom_emit_getSettingsCtg) {(call vcom_emit_getWidgetCtgSettings) getvariable _this}

function(vcom_emit_getVarInSets) {
	private _setName = _this deleteAt 0; 
	private _ctg = _setName call vcom_emit_getSettingsCtg;
	private _temp = _ctg;
	{
		_temp = _temp getvariable _x;
	} foreach _this;
	_temp
}

function(vcom_emit_loadSettingsWidgets)
{
	private _d = call vcom_getDisplay;
	private _ctg = call vcom_emit_getWidgetCtgSettings;
	//(group system) create,save,load,exit
	private _ctgSystem = [_d,WIDGETGROUP_H,[0,0,100,5*5],_ctg] call createWidget;
	_ctg setvariable ["_ctgSystem",_ctgSystem];
	//(group emitters) add particle,remove particle,select configured
	private _ctgMaker = [_d,WIDGETGROUP,[0,5*5,100,(5*5) + (5*5)],_ctg] call createWidget;
	_ctg setvariable ["_ctgMaker",_ctgMaker];
	//(group config) set id, set name, set type
	private _lastItemPos = (5*5) + (5*5) + 5*5 + 0.1;
	private _ctgEmitProp = [_d,WIDGETGROUP_H,[0,_lastItemPos,100,100-_lastItemPos],_ctg] call createWidget;
	_ctg setvariable ["_ctgEmitProp",_ctgEmitProp];

	private _posY = 0; 
	private _setpos = { private _r= [0,_posY,100,_this]; modvar(_posY) + _this; _r};

	//group generic button
	_posY = 0; private _perButtonSize = 100 / 6;
	{
		_x params ["_name","_codeInstr",["_desc",""]];
		if (_name == "") then {
			_perButtonSize call _setpos;
			continue;
		};
		private _w = [_d,BUTTON,_perButtonSize call _setpos,_ctgSystem] call createWidget;
		_w ctrlsettext _name;
		_w setvariable ["funcData",_codeInstr];
		_w ctrladdeventhandler ["MouseButtonUp",{
			_varname = (_this select 0) getvariable "funcData";
			_codeNextFrame = missionNamespace getvariable [_varname,{}];
			nextFrame(_codeNextFrame);
		}];
		_w ctrlSetTooltip _desc;
	} foreach [
		["Создать новый конфиг","vcom_emit_io_createNewConfig_openWindow","Открывает окно создания нового конфига"],
		["Загрузить конфиг","vcom_emit_io_openWindow_selectConfigLoad"],
		["Сохранить конфиг","vcom_emit_io_saveCurrentConfig","Сохраняет конфиг"],
		["Настройки","vcom_emit_openMainContextMenuSettings","Открывает контекстное меню различных настроек редактора"],
		[""],
		["Закрыть редактор","vcom_emit_closeVisualWindow","Закрывает редактор без сохранения"]
	];

	//group emitters (add,remove)
	private _add = [_d,BUTTON,[0,0,30,10],_ctgMaker] call createWidget;
	_add ctrlsettext "Добавить";
	_add ctrladdeventhandler ["MouseButtonUp",{
		private _nf = {
			_stackMenu = [];
			_stackMenu pushBack ["Свет (точка)",{["pointlight"] call vcom_emit_createEmitter}];
			_stackMenu pushBack ["Свет (направленный)",{["directlight"] call vcom_emit_createEmitter}];
			_stackMenu pushBack ["Частицы",{["particle"] call vcom_emit_createEmitter}];
			_stackMenu pushBack ["Отмена",{}];
			[
				_stackMenu,
				call mouseGetPosition,
				[]
			] call dcm_create;
		}; 
		if (call vcom_emit_io_isEditConfig) then {
			nextFrame(_nf);
		} else {
			call vcom_emit_io_createNewConfig_openWindow;
		};
	}];
	private _props = [_d,BUTTON,[35,0,30,10],_ctgMaker] call createWidget;
	_props ctrlsettext "Свойства";
	_props ctrladdeventhandler ["MouseButtonUp",{
		_nf = {
			_stackMenu = [];
			
			_stackMenu pushBack ["Удалить ВСЕ эмиттеры",{
				call vcom_emit_deleteAllEmitters;
			}];

			_stackMenu pushBack ["Отмена",{}];
			[
				_stackMenu,
				call mouseGetPosition,
				[]
			] call dcm_create;
		}; nextFrame(_nf);
	}];
	private _remove = [_d,BUTTON,[30+35+5,0,30,10],_ctgMaker] call createWidget;
	_remove ctrlsettext "Удалить";
	_remove ctrlSetTooltip "Удаляет выбранный эмиттер";
	_remove ctrladdeventhandler ["MouseButtonUp",{
		_nf = {
			call vcom_emit_deleteElement;
		}; nextFrame(_nf);
	}];
	private _list = [_d,LISTBOX,[0,10,100,40  +10],_ctgMaker] call createWidget;
	_list ctrladdeventhandler ["MouseButtonUp",{if ((_this select 1)!=1) exitwith {}; nextFrame(vcom_emit_onPressListElement);}];
	_list ctrladdeventhandler ["LBSelChanged",{params ["_wid","_idx"];[_idx] call vcom_emit_updateSelection;}];
	_list setvariable ["_allEmitters",[]];//!Object emitters storage
	["onDisplayClose",{{_x call vcom_emit_deleteEmitterObject} foreach (["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets)}] call Core_addEventHandler;
	_ctgMaker setvariable ["_list",_list];

	//for"_o"from 0 to 10 do {_list lbadd ("item "+str _o)};

	// ---------------------------- relpos ctg ----------------------------------
	private _zoneRelPos = [_d,WIDGETGROUP,[0,40+10  +10,100,30-5],_ctgMaker] call createWidget;
	// _d displayAddEventHandler ["MouseMoving",{
	// 	if (wch_isEnabled) exitwith {};
	// 	_zoneRelPos = ["_ctgMaker","_zoneRelPos"] call vcom_emit_getVarInSets;
	// 	if (_zoneRelPos call isMouseInsideWidget) then {
	// 		_focus = focusedCtrl (_this select 0);
	// 		if !array_exists(allControls _zoneRelPos,_focus) then {
	// 			ctrlsetfocus (_zoneRelPos getVariable "_slid_0");
	// 		};
	// 	};
	// }];
	_ctgMaker setvariable ["_zoneRelPos",_zoneRelPos];
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zoneRelPos] call createWidget;
	_back setBackgroundColor [0.2,0.2,0.2,0.8];
	for "_i" from 0 to 2 do {
		_perbut = 100/3;
		_col = [0,0,0,1];
		_col set [_i,1];

		_t = [_d,TEXT,[0,_perbut*_i,10,_perbut],_zoneRelPos] call createWidget;
		[_t,format["<t align='center' size='1.2'>%1</t>",["X","Y","Z"] select _i]] call widgetSetText;
		_t ctrlsettextColor _col;

		_inp = [_d,INPUT,[10,_perbut*_i,20,_perbut-8],_zoneRelPos] call createWidget;
		_inp setvariable ["_index",_i];

		_inp ctrladdeventhandler ["KillFocus",{[(_this select 0) getvariable "_index",ctrlText (_this select 0)] call vcom_emit_relpos_updatePositionAtAxis}];

		_slid = [_d,SLIDERWNEW,[20+10,_perbut*_i,70,_perbut-8],_zoneRelPos] call createWidget;
		_slid ctrlSetActiveColor _col;
		_slid ctrlSetForegroundColor _col;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,vcom_emit_sliderPosChangeDelta,vcom_emit_sliderPosChangeDelta];
		_slid sliderSetRange [-vcom_emit_maxPointDistance,vcom_emit_maxPointDistance];
		_slid setvariable ["_index",_i];

		_slid ctrladdeventhandler ["SliderPosChanged",{[(_this select 0)getvariable "_index",_this select 1] call vcom_emit_relpos_updatePositionAtAxis}];

		_zoneRelPos setvariable ["_slid_"+str _i,_slid];
		_zoneRelPos setvariable ["_inp_"+str _i,_inp];
	};

	//-----------------------orient settings ctg----------------------
	private _zoneOrientPos = [_d,WIDGETGROUP,[0,40+10+30   +5,100,20-5],_ctgMaker] call createWidget;
	// _d displayAddEventHandler ["MouseMoving",{
	// 	if (wch_isEnabled) exitwith {};
	// 	_zoneOrientPos = ["_ctgMaker","_zoneOrientPos"] call vcom_emit_getVarInSets;
	// 	if (_zoneOrientPos call isMouseInsideWidget) then {
	// 		_focus = focusedCtrl (_this select 0);
	// 		if !array_exists(allControls _zoneOrientPos,_focus) then {
	// 			ctrlsetfocus (_zoneOrientPos getVariable "_slid_0");
	// 		};
	// 	};
	// }];
	_ctgMaker setvariable ["_zoneOrientPos",_zoneOrientPos];
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zoneOrientPos] call createWidget;
	_back setBackgroundColor [0.2,0.2,0.2,0.8];
	//!Возможно ось Yaw стоит веронуть для частиц хотя это ооочень сомнительная необходимость
	for "_i" from 0 to 1 do { //только 2 оси используются при ротации источника
		_perbut = 100/2;
		_col = [1,1,1,1];
		_col set [_i,0];

		_t = [_d,TEXT,[0,_perbut*_i,10,_perbut],_zoneOrientPos] call createWidget;
		[_t,format["<t align='center' size='0.8'>%1</t>",["Pt","Bk","Yw"] select _i]] call widgetSetText;
		_t ctrlsettextColor _col;

		_inp = [_d,INPUT,[10,_perbut*_i,20,_perbut-8],_zoneOrientPos] call createWidget;
		_inp setvariable ["_index",_i];

		_inp ctrladdeventhandler ["KillFocus",{[(_this select 0) getvariable "_index",ctrlText (_this select 0),null,true] call vcom_emit_relpos_updatePositionAtAxis}];

		_slid = [_d,SLIDERWNEW,[20+10,_perbut*_i,70,_perbut-8],_zoneOrientPos] call createWidget;
		_slid ctrlSetActiveColor _col;
		_slid ctrlSetForegroundColor _col;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,vcom_emit_sliderPosChangeDelta,vcom_emit_sliderPosChangeDelta];
		_slid sliderSetRange [-360,360];
		_slid setvariable ["_index",_i];

		_slid ctrladdeventhandler ["SliderPosChanged",{[(_this select 0)getvariable "_index",_this select 1,null,true] call vcom_emit_relpos_updatePositionAtAxis}];

		_zoneOrientPos setvariable ["_slid_"+str _i,_slid];
		_zoneOrientPos setvariable ["_inp_"+str _i,_inp];
	};


	//group current config setup (id, type etc...)
	// for access use ["_ctgEmitProp","_inputCfgName"] call vcom_emit_getVarInSets;
	_pX = 0;
	_pY = 0;
	_t = [_d,TEXT,[_pX,_pY,50,20],_ctgEmitProp] call createWidget;
	[_t,"<t size='1'>Название конфига:"] call widgetSetText;
	_i = [_d,INPUT,[_pX + 50,_pY,50,20],_ctgEmitProp] call createWidget;
	_ctgEmitProp setvariable ["_inputCfgName",_i];
	_i ctrladdeventhandler ["KillFocus",{
		[(ctrlText (_this select 0))] call vcom_emit_io_internal_attemptUpdateConfigName;
	}];
	modvar(_pY) + 20; _pX = 0;


}
//обновить позицию эмиттера по оси _axisIndex. _optIndexEmitter - индекс эмиттера в _allEmitters, если не указан берется из текущего выбранного
function(vcom_emit_relpos_updatePositionAtAxis)
{
	params ["_axisIndex","_newval",["_optIndexEmitter",-1],["_isOrient",false]];
	if equalTypes(_newval,"") then {
		_newval = parseNumberSafe(_newval);
	};

	private _list = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	private _idx = ifcheck(_optIndexEmitter!=-1,_optIndexEmitter,lbcursel _list);
	if (_idx == -1) exitwith {};

	private _clampValue = ifcheck(_isOrient,360,vcom_relpos_maxPointDistance);
	_newval = clamp(_newval,-_clampValue,_clampValue);

	private _allEmitters = ["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets;
	if (_idx < 0 || _idx > ((count _allEmitters) - 1)) exitwith {};

	private _cur = _allEmitters select _idx;
	private _curPos = _cur getvariable "pos";
	private _curOrient = _cur getvariable "orient";
	if (_isOrient) then {
		_curOrient set [_axisIndex,_newval];
	} else {
		_curPos set [_axisIndex,_newval];
	};
	
	_cur setvariable ["pos",_curPos];
	_cur setvariable ["orient",_curOrient];

	if (isObjectHidden _cur) then {
		_curPos = _curPos vectoradd [0,0,9999];
	};

	//prev attached to vcom_logicObject
	//visual object cant accept attached particles
	_sourceObject = ifcheck((_cur call vcom_emit_getEmitterType)=="particle",vcom_logicObject,vcom_visualObject);
	(_cur call vcom_emit_getEmitterVisual) attachto [_sourceObject,_curPos];
	[_cur call vcom_emit_getEmitterVisual,_curOrient] call BIS_fnc_setObjectRotation;
	//(_cur call vcom_emit_getEmitterVisual) attachto [vcom_visualObject,_curPos];

	//sync from real to visual
	call vcom_emit_relpos_syncValuesFromObjectToWidgets;
}
//синхронизирует значения относительной позиции к визуальным элементам
function(vcom_emit_relpos_syncValuesFromObjectToWidgets)
{
	private _zoneRelPos = ["_ctgMaker","_zoneRelPos"] call vcom_emit_getVarInSets;
	private _o = call vcom_emit_relpos_getSelectedEmitter;
	if isNullReference(_o) exitwith {};
	private _pos = _o getvariable "pos";
	private _orient = _o getvariable "orient";

	for "_i" from 0 to 2 do {
		_sli = _zoneRelPos getvariable ("_slid_"+str _i);
		_sli sliderSetPosition (_pos select _i);

		_inp = _zoneRelPos getvariable ("_inp_"+str _i);
		_inp ctrlsettext (str (_pos select _i));
	};

	private _zoneOrientPos = ["_ctgMaker","_zoneOrientPos"] call vcom_emit_getVarInSets;
	
	for "_i" from 0 to 2 do {
		_sli = _zoneOrientPos getvariable ("_slid_"+str _i);
		_sli sliderSetPosition (_orient select _i);

		_inp = _zoneOrientPos getvariable ("_inp_"+str _i);
		_inp ctrlsettext (str (_orient select _i));
	};

}
//Получает текущий эмиттер который выбран в списке
function(vcom_emit_relpos_getSelectedEmitter)
{
	private _list = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	private _ind = lbcursel _list;
	if (_ind == -1) exitWith {objNull};
	private _allEmitters = ["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets;
	_allEmitters select _ind
}

function(vcom_emit_relpos_hasSelectedEmitter) {!isNullReference(call vcom_emit_relpos_getSelectedEmitter)}

function(vcom_emit_createEmitter)
{
	params ["_emitType",["_emitterName",""],["_dataList",[]],["_serializedEvents","null"]];
	if !(_emitType in vcom_emit_emitterTypeAssoc) exitwith {
		setLastError(__FUNC__ + " - Wrong emitter type: " + _emitType);
	};
	if isNullReference(vcom_visualObject) exitwith {
		setLastError(__FUNC__ + " - vcom::visualObject is nullPtr");
	};

	private _allEmitters = ["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets;

	(vcom_emit_emitterTypeAssoc get _emitType) params ["_engineCfgType","_typeShort","_emitterNameStr"];
	//! Rule: All objects variable name without "_" symbol
	private _o = [_engineCfgType,_emitType] call vcom_emit_createEmitterObject;
	
	if isNullReference(_o) exitwith {
		setLastError(__FUNC__ + " - Cannot create emitter by config: " + _engineCfgType);
	};

	_o setvariable ["emitType",_emitType];
	_o setvariable ["index",_allEmitters pushBack _o];

	_o setVariable ["serializedCustomEvents",_serializedEvents];
	
	//relpos component
	private _defPos = [0,0,0]; private _defOrient = [0,0,0];
	_o setvariable ["pos",_defPos];
	_o setvariable ["orient",_defOrient];
	
	//! THIS DOSEN'T WORK. FUCK BIS
	(_o call vcom_emit_getEmitterVisual) attachto [vcom_logicObject,_defPos];
	[_o call vcom_emit_getEmitterVisual,_defOrient] call BIS_fnc_setObjectRotation;
	//(_o call vcom_emit_getEmitterVisual) attachto [vcom_logicObject,_defPos];

	//unical id
	private _unicalIdStorage = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	private _curId = _unicalIdStorage getvariable ["unicalID_Last",1];
	_o setvariable ["unicalID",_curId];
	if (_emitterName != "" && !(_emitterName call vcom_emit_containsEmitterWithName)) then {
		_o setvariable ["unicalIDStr",_emitterName];
	} else {
		private _newOptName = format["%2 %1",_curId,_emitterNameStr];
		if (_newOptName call vcom_emit_containsEmitterWithName) then {
			modvar(_newOptName) + "<" + hashValue _o + ">";
		};
		_o setvariable ["unicalIDStr",_newOptName];
	};
	_unicalIdStorage setvariable ["unicalID_Last",_curId + 1];

	//called in vcom_emit_reloadEmitterList
	//(["_ctgMaker","_list"] call vcom_emit_getVarInSets) lbsetcursel (- 1);
	if (count _dataList == 0) then {
		[_o] call vcom_emit_createEmitterProperties;
	} else {
		[_o,_dataList] call vcom_emit_createEmitterProperties;
	};

	//update list
	call vcom_emit_reloadEmitterList;

	//sync position (ебал рот чехов кстати)
	[0,0,_o getvariable "index"] call vcom_emit_relpos_updatePositionAtAxis;
	
	_o //return value not used?!
}

function(vcom_emit_reloadEmitterList)
{
	private _list = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	lbclear _list;
	
	_list lbsetcursel -1;
	
	private _itm = null;
	{
		_itm = _list lbAdd (format["%2%1",_x getvariable "unicalIDStr",ifcheck(isObjectHidden _x,"(СКРЫТ) ","")]);
		_list lbSetColor [_itm, 
			(
				["#FFBF00","#4AAB00","#0787E3",
					"#FF0000" //if notfind - error color setup
				] select (
					vcom_emit_emitterTypeKeysSorted find (_x getvariable "emitType")
				)
			) call color_HTMLtoRGBA
		];
		//_list lbSetTooltip [_itm,format["idx:%1\nid:%2",_x getvariable "index",_x getvariable "unicalID"]];
	} foreach (_list getvariable "_allEmitters");

	[-1] call vcom_emit_updateSelection;
}

function(vcom_emit_updateEmitterNamesInList)
{
	private _list = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	{
		_list lbSetText [_x getvariable "index",format["%2%1",_x getvariable "unicalIDStr",ifcheck(isObjectHidden _x,"(СКРЫТ) ","")]];
		//_list lbSetTooltip [_x getvariable "index",format["idx:%1\nid:%2",_x getvariable "index",_x getvariable "unicalID"]];
	} foreach (_list getvariable "_allEmitters");
}

function(vcom_emit_updateSelection)
{
	params ["_newIndex",["_doApplyForWidget",false]];

	if (_doApplyForWidget) then {
		(["_ctgMaker","_list"] call vcom_emit_getVarInSets) lbSetCurSel _newIndex;
	};

	private _zoneRelPos = ["_ctgMaker","_zoneRelPos"] call vcom_emit_getVarInSets;
	private _zoneOrientPos = ["_ctgMaker","_zoneOrientPos"] call vcom_emit_getVarInSets;
	{
		if ((_x getvariable "index")==_newIndex) then {
			//TODO onupdate selection at index
			//[_x] call vcom_relpos_onSelectPointEffect;
			//_x setobjecttexture [0,"#(argb,8,8,3)color(1,0,0,1)"];
		//} else {
			//_x setobjecttexture [0,"#(argb,8,8,3)color(0,1,0,1)"];
		};
	} foreach (["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets);
	if (_newIndex == -1) exitWith {
		{
			_x ctrlEnable false;
			_x ctrlShow false;
		} foreach [_zoneRelPos,_zoneOrientPos];

		call vcom_emit_syncPropsToWidgets;
	};

	{
		_x ctrlEnable true;
		_x ctrlShow true;
	} foreach [_zoneRelPos,_zoneOrientPos];

	//disable orient for particle emitter
	private _o = call vcom_emit_relpos_getSelectedEmitter;
	if !isNullReference(_o) then {
		//только направленные источники света могут быть повернуты.
		if ((_o getvariable "emitType")!="directlight") then {
			{
				_x ctrlEnable false;
				_x ctrlShow false;
			} foreach [_zoneOrientPos];
		};
	};

	call vcom_emit_relpos_syncValuesFromObjectToWidgets;

	call vcom_emit_syncPropsToWidgets;
}

//if param _index null - then delete current
function(vcom_emit_deleteElement)
{
	params ["_index"];
	private _list = ["_ctgMaker","_list"] call vcom_emit_getVarInSets;
	if isNullVar(_index) then {_index = lbcursel _list};

	if (_index == -1) exitWith {objNull};
	private _allEmitters = ["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets;
	private _curObj = _allEmitters select _index;

	if (_index < 0||_index>((count _allEmitters) - 1)) exitWith {setLastError(__FUNC__ + " index out of range")};
	if (_index != (_curObj getvariable "index")) exitwith {setLastError(__FUNC__ + " index logical error")};

	(_allEmitters deleteAt _index) call vcom_emit_deleteEmitterObject;
	//update indexes
	{
		_x setvariable ["index",_foreachindex];
	} foreach _allEmitters;

	call vcom_emit_reloadEmitterList;

	vcom_emit_internal_copyedData = null; //because deleted
}

function(vcom_emit_deleteAllEmitters)
{
	private _emList = call vcom_emit_getEmitterObjectList;
	for "_i" from 0 to (count _emList) - 1 do {
		[(_emList select 0) getvariable "index"] call vcom_emit_deleteElement
	};
}

//событие вызывается при нажатии на элемент
function(vcom_emit_onPressListElement)
{
	private _o = call vcom_emit_relpos_getSelectedEmitter;
	if isNullReference(_o) exitwith {};
	
	private _stackMenu = [["Переименовать",{
		(call dcm_getContextParams) params ["_o"];
		
		_nf = {
			private _o = _this;
			call wch_enable;
			private _d = call vcom_getDisplay;
			_sW = 30;
			_sH = 20;

			_b = [_d,BACKGROUND,[50-_sW*3/2,50-_sH*3/2,_sW*3,_sH*3]] call createWidget;
			(call wch_getControlStorage) pushBack _b;
			_b setBackgroundColor [0.3,0.3,0.3,1];

			_t = [_d,TEXT,[50-_sW/2,25,_sW,5]] call createWidget;
			(call wch_getControlStorage) pushBack _t;
			[_t,"<t align='center'>Введите новое название эмиттера</t>"] call widgetSetText;
			_i = [_d,INPUT,[50-_sW/2,10+20,_sW,20]] call createWidget;
			(call wch_getControlStorage) pushBack _i;
			_i ctrlsettext (_o getvariable "unicalIDStr");
			_b = [_d,BUTTON,[50-_sW/2,10+20+20,_sW,10]] call createWidget;
			_b ctrlsettext "Применить";
			(call wch_getControlStorage) pushBack _b;
			_b setvariable ["_i",_i];
			_b setvariable ["_o",_o];
			_b ctrladdeventhandler ["MouseButtonUp",{
				_o = (_this select 0) getvariable "_o";
				_i = ctrlText((_this select 0)getvariable "_i");
				forceUnicode 0;

				if (_i == "") exitwith {["Имя не может быть пустым"] call showError};
				if (count _i >= 64) exitwith {["Максимальный размер строки превышен (64)"] call showError};
				if ([_i,"[^a-zA-Zа-яА-Я 0-9\-\_]/gi"] call regex_isMatch) exitwith {
					["Недопустимые символы в названии. Разрешено: только буквы, цифры, пробелы, нижнее подчеркивание и дефис"] call showError;
				};
				//check in all particles matches
				if (_i call vcom_emit_containsEmitterWithName 
					//и если имя было изменено с текущего
					&& (_o getvariable "unicalIDStr")!=_i
				) exitwith {
					[format["Эмиттер с именем '%1' уже существует",_i]] call showError;
				};

				vcom_emit_internal_copyedData = null; //because renamed

				call wch_disable;
				_o setvariable ["unicalIDStr",_i];
				call vcom_emit_reloadEmitterList;
			}];

			_b = [_d,BUTTON,[50-_sW/2,10+20+20+10,_sW,10]] call createWidget;
			_b ctrlsettext "Отмена";
			(call wch_getControlStorage) pushBack _b;
			_b ctrladdeventhandler ["MouseButtonUp",{
				call wch_disable;
			}];

			

		}; nextFrameParams(_nf,_o);
	},null,"Открывает окно ввода имени выбранного эмиттера"],["Скопировать свойства",{
		(call dcm_getContextParams) params ["_o"];
		vcom_emit_internal_copyedData = [
			_o getvariable "unicalIDStr",
			(_o getvariable "emitType")=="particle",
			_o getvariable "unicalID"
		];
		["Data copyed: %1",vcom_emit_internal_copyedData] call printTrace;
		[format["Данные эмиттера '%1' скопированы",vcom_emit_internal_copyedData select 0]] call showInfo
	},null,"Копирует свойства выбранного эмиттера"]];

	if !isNull(vcom_emit_internal_copyedData) then {
		vcom_emit_internal_copyedData params ["_name","_isParticle","_unicalID"];
		private _canAdd = equals(_isParticle,(_o getvariable "emitType")=="particle")
			&& _unicalID != (_o getvariable "unicalID");
		if (_canAdd) then {
			_stackMenu pushBack [
				"Вставить свойства из "+_name,
				{
					(call dcm_getContextParams) params ["_o"];
					vcom_emit_internal_copyedData params ["_name","_isParticle","_unicalID"];

					private _emList = call vcom_emit_getEmitterObjectList;
					private _idxDat = _emList findif {(_x getvariable "unicalID")==_unicalID};
					//["index founded: %1; emitters: %2",_idxDat,_emList apply {_x getvariable "unicalID"}] call printTrace;
					if (_idxDat == -1) exitwith {};
					private _copyedObjRef = _emList select _idxDat;
					if equals(_idxDat,_copyedObjRef) exitwith {};

					_o setvariable ["data",
						//deep copy
						call compile str (_copyedObjRef getvariable "data")
					];
					[_o] call vcom_emit_prop_syncEmitterPropsFromData;
					[_o getvariable "index"] call vcom_emit_updateSelection;

					["Data paste: %1",vcom_emit_internal_copyedData] call printTrace;
					[format["Данные эмиттера '%1' скопированы в '%2'",
						_copyedObjRef getvariable "unicalIDStr",_o getvariable "unicalIDStr"]
						,10
					] call showInfo;
				},null,call dcm_copyDescFromName
			];
		};
	};

	if (isObjectHidden _o) then {
		_stackMenu pushBack ["Показать эмиттер",{
			(call dcm_getContextParams) params ["_o"];
			_o hideObject false;
			[0,0,_o getvariable "index"] call vcom_emit_relpos_updatePositionAtAxis;
			call vcom_emit_updateEmitterNamesInList;
		},null,"Включает отображение выбранного эмиттера"];
	} else {
		_stackMenu pushBack ["Скрыть эмиттер",{
			(call dcm_getContextParams) params ["_o"];
			_o hideObject true;
			[0,0,_o getvariable "index"] call vcom_emit_relpos_updatePositionAtAxis;
			call vcom_emit_updateEmitterNamesInList;
		},null,"Отключает отображение выбранного эмиттера"];
	};

	private _emitIdxCur = _o getvariable "index";
	private _countEmitters = count (call vcom_emit_getEmitterObjectList);
	private _emitMaxIndex = _countEmitters - 1;
	
	if (_emitIdxCur > 0 && _countEmitters > 1) then {
		_stackMenu pushBack ["Поднять выше",{[-1]call vcom_emit_swapCurrentEmitter},null,"Поднимает выбранный эмиттер на 1 пункт вверх"]
	};
	if (_emitIdxCur < _emitMaxIndex && _countEmitters > 1) then {
		_stackMenu pushBack ["Опустить ниже",{[+1]call vcom_emit_swapCurrentEmitter},null,"Опускает выбранный эмиттер на 1 пункт вниз"]
	};

	if (_countEmitters > 3 && _emitIdxCur > 0) then {
		_stackMenu pushBack ["В начало списка",{[0,true]call vcom_emit_swapCurrentEmitter},null,"Поднимает выбранный эмиттер в начало списка"]
	};
	if (_countEmitters > 3 && _emitIdxCur < _emitMaxIndex) then {
		_stackMenu pushBack ["В конец списка",{[count(call vcom_emit_getEmitterObjectList)-1,true]call vcom_emit_swapCurrentEmitter},null,"Поднимает выбранный эмиттер в конец списка"]
	};

	[
		_stackMenu + [["Отмена",{}]],
		call mouseGetPosition,
		[_o]
	] call dcm_create;	
}


function(vcom_emit_containsEmitterWithName)
{
	private _name = _this;
	private _matched = "";
	{
		private _checked = _x getvariable "unicalIDStr";
		if equals(_checked,_name) exitwith {
			_matched = _checked;
		};
	} foreach (["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets);

	_matched != ""
}

//Получить список всех эмиттеров
function(vcom_emit_getEmitterObjectList)
{
	(["_ctgMaker","_list","_allEmitters"] call vcom_emit_getVarInSets)
}

//переместить текущий выбранный эмиттер на индекс
function(vcom_emit_swapCurrentEmitter)
{
	params ["_idx",["_idxIsNew",false]];
	private _emit = call vcom_emit_relpos_getSelectedEmitter;
	if isNullReference(_emit) exitwith {};
	private _list = call vcom_emit_getEmitterObjectList;
	if (count _list < 2) exitwith {};

	private _maxIndex = count _list - 1;
	private _curIndex = _emit getvariable "index";
	private _newIndex = ifcheck(_idxIsNew,_idx,_curIndex + _idx);

	if !inRange(_newIndex,0,_maxIndex) exitwith {};

	if (_curIndex == _newIndex) exitwith {}; //not need any action

	//swap values
	private _newEl = _list select _curIndex;
	private _oldEl = _list select _newIndex;
	_list set [_newIndex,_newEl];
	_list set [_curIndex,_oldEl];

	//update indexes
	{
		_x setvariable ["index",_foreachindex];
	} foreach _list;

	call vcom_emit_updateEmitterNamesInList;
	[_newIndex,true] call vcom_emit_updateSelection;
}

function(vcom_emit_loadEnvObjects)
{
	params [["_isInit",false]];

	private _logic = vcom_logicObject;
	if isNullReference(_logic) exitWith {
		setLastError("Logic object is null");
	};

	//cleanup prev objects
	deleteVehicle vcom_emit_envObject_ground;
	{
		deleteVehicle _x;
	} foreach vcom_emit_envObjects_list_box;
	vcom_emit_envObjects_list_box = [];

	private _modelPath = "block_dirt";

	vcom_emit_envObject_ground = createvehicle [_modelPath,position _logic,[],0,"none"];
	vcom_emit_envObject_ground attachto [_logic,[0,0,-5.5]];
	
	{
		private _obj = createvehicle [_modelPath,position _logic,[],0,"none"];
		_obj attachto [_logic,_x];
		
		vcom_emit_envObjects_list_box pushBack _obj;
	} foreach [
		[-10,0,4.5]
		,[10,0,4.5]
		,[0,-10,4.5]
		,[0,10,4.5]
		,[0,0,9.5+5]
	];

	for "_x" from -100 to 100 step 10 do {
		for "_y" from -100 to 100 step 10 do {
			if (_x == 0 && _y == 0) then {continue};
			private _attpos = [_x,_y,-5.5];
			private _obj = createvehicle [_modelPath,position _logic,[],0,"none"];
			_obj attachto [_logic,_attpos];

			vcom_emit_envObject_groundAreaList pushBack _obj;
		};
	};

	if (_isInit) then {
		vcom_emit_envObject_ground hideObject true;
		{_x hideObject true} foreach vcom_emit_envObjects_list_box;
		{_x hideObject true} foreach vcom_emit_envObject_groundAreaList;

		["onDisplayClose",{
			deleteVehicle vcom_emit_envObject_ground;
			{
				deleteVehicle _x;
			} foreach vcom_emit_envObjects_list_box;
			vcom_emit_envObjects_list_box = [];

			{
				deleteVehicle _x;
			} foreach vcom_emit_envObject_groundAreaList;
			vcom_emit_envObject_groundAreaList = [];
		}] call Core_addEventHandler;
	};

}

function(vcom_emit_createNotifyWidget)
{
	private _d = call vcom_getDisplay;
	private _t = [_d,TEXT,[20,0,100-20,5],call vcom_getCtg] call createWidget;
	[_t,null,
		[""]+(notificationSounds select 1 select [1,2])
	] call setNotificationContext;
	["onDisplayClose",{
		[null] call setNotificationContext;
	}] call Core_addEventHandler;
}
