// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(prox_initialize)
{
	prox_targetObj = objNull;

	prox_nowpnAnims = ["amovppnemstpsnonwnondnon","amovpknlmstpsnonwnondnon","amovpercmstpsnonwnondnon"];
	prox_wpnAnims = ["amovppnemstpsraswpstdnon","amovpknlmstpsraswpstdnon","amovpercmstpsraswpstdnon"];
	
	prox_map_modes = createHashMapFromArray[["combat",false],["twohand",false],["attack",false],["parry",false]];

	prox_map_currentAnimListMode = "combat";

	prox_currentStance = 2; //текущая стойка
	prox_curSelection = 0; //текущий слот инвентаря
	prox_curCfg = []; //текущий полный сохранённый конфиг
	
	//!do not change variable postfix
	prox_curCfgPos = [0,0,0]; 
	prox_curCfgVec = [0,0,0];
	
	prox_itemObj = objNull;

	prox_widgetsPos = [];
	prox_widgetsVec = [];
	prox_centerObjOffset = [0,0,0];
	prox_centerObj = "Sign_Sphere10cm_F" createvehicle [0,0,0];

	prox_widgetsTrans = []; //inscene widgets transform
	prox_posRange = 1;

	prox_vecRange = 180;

	prox_widgetsHands = []; //ссылки на виджеты рук. виджеты типа Listbox

	//animations variables
	#include "..\..\host\GameObjects\Items\Item_HandAnim.hpp"


	prox_anim_handStates = ["na","na"];
	prox_anim_handBlend = [0,0];
	prox_anim_legsExists = [true,true]; //r, l

	// prox_anim_handBlendMode = [
	// 	["Без смешивания",0],
	// 	["Половина",0.5],
	// 	["Полное",1]
	// ];
	call {
		#include "..\..\host\Namings\FacesHelpers.sqf"
		#include "..\..\host\Namings\PrepareFaces.sqf"
	};

	prox_inv_allFaces = faces_list_man + faces_list_woman;
	prox_inv_allFaces insert [0,["",(faces_list_man select 0)+"_nohead"]];

	//enum: name, type, list items (first item is empty slot), code unload,code load
	prox_inv_types = [
		["Одежда","Uniform",[""],{removeUniform prox_targetObj},{prox_targetObj forceAddUniform _this}],
		["Броня","Vest",[""],{removeVest prox_targetObj},{prox_targetObj addVest _this}],
		["Шапки","Headgear",[""],{removeHeadgear prox_targetObj},{prox_targetObj addHeadgear _this}],
		["Лицо","Glasses",[""],{removeGoggles prox_targetObj},{prox_targetObj addGoggles _this}],
		["Спина","Backpack",[""],{removeBackpack prox_targetObj},{prox_targetObj addBackpack _this}],
		["Персона","---",prox_inv_allFaces,{prox_targetObj setFace ""},{prox_targetObj setFace _this}]
	];
	prox_inv_widgetCurrentList = [widgetNull,widgetNull]; //ссылка на текущие виджеты категории предметов и списка предметов
	prox_inv_curTypeIdx = 0; //какая категория открыта

	//что загружено на персонажа в данный момент. индексы для prox_inv_types
	prox_inv_dataCurIndexes = prox_inv_types apply {0};

	private _configArray = (
		("true" configClasses (configFile >> "CfgWeapons")) +
		("true" configClasses (configFile >> "CfgVehicles")) +
		("true" configClasses (configFile >> "CfgGlasses"))
	);

	private _unicalMap = createHashMap;
	private _assocIndexMap = createHashMap;
	{
		_assocIndexMap set [_x select 1,_foreachIndex];
	} foreach prox_inv_types;
	private _cat = null;
	private _idxSet = null;
	private _classname = null;
	{
		private _itemScope = if (isNumber (_x >> "scopeArsenal")) then { getNumber (_x >> "scopeArsenal") } else { getNumber (_x >> "scope") };
		if (_itemScope < 2) then {continue};

		// if (_itemScope == 2 && {
		// 	getText (_x >> "protocol") != "RadioProtocolBase"
		// }) then {
		// };
		_classname = configName _x;
		_cat = (_classname call bis_fnc_itemType) select 1;
		if (_cat in _assocIndexMap) then {
			
			if (_classname in _unicalMap) exitWith {};

			_idxSet = _assocIndexMap get _cat;
			(prox_inv_types select _idxSet select 2) pushBack _classname;

			_unicalMap set [_classname,null];
		};
	} foreach _configArray;


	call prox_loadInternalCode;
	
	#include "..\..\client\Inventory\inventory.hpp"

	prox_slotListData = [];
	{
		prox_slotListData set [_foreachindex,
			[_x,INV_LIST_SLOTNAMES select _foreachindex,INV_LIST_ALL select _foreachindex,INV_LIST_VARNAME select _foreachindex]
		]
	} foreach proxIt_list_selections;
}

#define PROX_SDATA_INDEX_SELNAME 0
#define PROX_SDATA_INDEX_SLOTNAME 1
#define PROX_SDATA_INDEX_ID 2
#define PROX_SDATA_INDEX_VARNAME 3

function(prox_loadInternalCode)
{
	#include "..\..\client\ProxyItems\ProxyItems.sqf"
}

function(prox_isItemLoaded) {!isNullReference(prox_itemObj)}

function(prox_openEditor)
{
	params [["_curGameObject",null]];

	prox_currentStance = 2;
	prox_curSelection = 0;

	if !isNullReference(prox_targetObj) then {
		deletevehicle prox_targetObj;
	};

	["prox"] call vcom_openWindow;
	private _offsLeft = 30;
	private _offsDown = 30;
	[[_offsLeft,0,100-_offsLeft,100-_offsDown]] call vcom_observ_loadCameraController;

	private _d = call vcom_getDisplay;
	private _ctg = call vcom_getCtg;
	
	//add dragger arrows
	_ctgDrag = _ctg getvariable "_wgroupRef";
	_sizeH = 2;
	_sizeW = transformSizeByAR(_sizeH);
	{
		private _drag = [_d,BUTTON,[0,0,_sizeW,_sizeH],_ctgDrag] call createWidget;
		private _color = [0,0,0,0.3];
		_color set [_foreachIndex,1];
		_drag setBackgroundColor _color;
		_drag ctrlSetTooltip _x;
		_drag ctrlEnable true;

		//TODO fixoffsets
		_drag ctrlshow false;

		_drag ctrlAddEventHandler ["MouseButtonDown",{
			params ["_w","_b"];
			["proxy pressed on %1",_w] call printTrace;
		}];
		_drag ctrlAddEventHandler ["MouseButtonUp",{
			params ["_w","_b"];
			["proxy release on %1",_w] call printTrace;
		}];
		prox_widgetsTrans set [_foreachIndex,_drag];
	} foreach ["X","Y","Z"];


	_ctgLeft = [_d,WIDGETGROUP,[0,0,_offsLeft,100],_ctg] call createWidget;

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgLeft] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,0.8];
	_back ctrlEnable false;

	_curY = 0;

	_t = [_d,TEXT,[0,_curY,100,3],_ctgLeft] call createWidget;
	[_t,"<t align='center' size='1.5'>Слоты</t>"] call widgetSetText;
	modvar(_curY)+3;
	
	// ------------ fill slotlist ------------------
	_lb = [_d,LISTBOX,[0,_curY,50,30],_ctgLeft] call createWidget;
	
	{
		private _id = _lb lbAdd (_x select PROX_SDATA_INDEX_SLOTNAME);
		_lb lbsetdata [_id,str _foreachindex];
	} foreach prox_slotListData;
	_lb lbSetCurSel prox_curSelection;
	_lb ctrlAddEventHandler ["LBSelChanged",{
		params ["_list","_index"];
		prox_curCfg set [prox_curSelection,[prox_curCfgPos,prox_curCfgVec]];
		prox_curSelection = _index;

		prox_curCfgPos = prox_curCfg select _index select 0;
		prox_curCfgVec = prox_curCfg select _index select 1;
		call prox_syncItemObjTransform;
		[true,true] call prox_updateWidgetsVisual;
	}];

	// --- add inventory
		_t = [_d,TEXT,[50,_curY,50,3],_ctgLeft] call createWidget;
		[_t,"<t align='center' size='1.5'>Инвентарь</t>"] call widgetSetText;
		modvar(_curY)+3;

		_switcher = [_d,"RscCombo",[50,_curY,50,3],_ctgLeft] call createWidget;
		modvar(_curY)+3;
		{
			_x params ["_nameCat","","_listItems"];
			private _it = _switcher lbadd _nameCat;
		} foreach prox_inv_types;
		_switcher ctrlAddEventHandler ["LBSelChanged",{
			params ["_wid","_idx"];
			prox_inv_curTypeIdx = _idx;
			[] call prox_inv_loadInventoryList;
		}];
		

		_itemList = [_d,LISTBOX,[50,_curY,50,50-(36-_curY)],_ctgLeft] call createWidget;
		_itemList ctrlAddEventHandler ["LBSelChanged",{
			params ["_wid","_idx"];
			prox_inv_dataCurIndexes set [prox_inv_curTypeIdx,_idx];
			call prox_inv_onChangeCurrentInventoryItem;
		}];
		prox_inv_widgetCurrentList = [_switcher,_itemList];
		
		//загрузка последней сохранённой категории
		_switcher lbSetCurSel prox_inv_curTypeIdx;
		[] call prox_inv_loadInventoryList;
		//загрузка инвентаря
		[] call prox_inv_onChangeCurrentInventoryItem;

	modvar(_curY)+30;

	// ----------- fill draggers ------------------
	[[_d,TEXT,[0,_curY,100,4],_ctgLeft] call createWidget,"<t align='center'>Позиция</t>"] call widgetSetText;
	modvar(_curY) + 4;

	_sizeDrag = 2.5;
	_offsetDrag = 1;
	_color = [0,0,0,1];
	{
		private _s = [_d,SLIDERWNEW,[0,_curY,100,_sizeDrag],_ctgLeft] call createWidget;
		_s sliderSetRange [-prox_posRange,prox_posRange];
		_s sliderSetSpeed [0.01,0.1];
		_s setvariable ["name",_x];
		_s setvariable ["type","pos"];
		_s setvariable ["index",_foreachIndex];
		private _newcolor = array_copy(_color);
		_newcolor set [_foreachIndex,1];
		_s ctrlSetForegroundColor _newcolor;
		_s ctrlSetActiveColor _newcolor;

		modvar(_curY) + _sizeDrag + _offsetDrag;
		prox_widgetsPos set [_foreachindex,_s];
	} foreach ["X","Y","Z"];

	[[_d,TEXT,[0,_curY,100,4],_ctgLeft] call createWidget,"<t align='center'>Направление</t>"] call widgetSetText;
	modvar(_curY) + 4;

	_color = _color apply {1};
	{
		private _s = [_d,SLIDERWNEW,[0,_curY,100,_sizeDrag],_ctgLeft] call createWidget;
		_s sliderSetRange [-prox_vecRange,prox_vecRange];
		_s sliderSetSpeed [0.1,0.1];
		_s setvariable ["name",_x];
		_s setvariable ["type","vec"];
		_s setvariable ["index",_foreachIndex];
		private _newcolor = array_copy(_color);
		_newcolor set [_foreachIndex,0];
		_s ctrlSetForegroundColor _newcolor;
		_s ctrlSetActiveColor _newcolor;

		modvar(_curY) + _sizeDrag + _offsetDrag;
		prox_widgetsVec set [_foreachindex,_s];
	} foreach ["Pitch","Bank","Yaw"];

	{
		_x ctrlAddEventHandler ["SliderPosChanged",{
			params ["_wid", "_newValue"];
			[_wid getvariable "type",_wid getvariable "index",_newValue] call prox_onUpdateWidgetValue;
		}];
		_x ctrlAddEventHandler ["MouseButtonUp",{
			params ["_wid","_key"];
			//reset value to default
			if (_key == MOUSE_RIGHT) exitWith {
				[_wid getvariable "type",_wid getvariable "index",0] call prox_onUpdateWidgetValue;
			};
		}];
	} foreach (prox_widgetsVec + prox_widgetsPos);

	[true,true] call prox_updateWidgetsVisual;

	private _t = [_d,TEXT,[_offsLeft,0,100-_offsLeft,5],_ctg] call createWidget;
	[_t,null,
		[""]+(notificationSounds select 1 select [1,2])
	] call setNotificationContext;
	["onDisplayClose",{
		[null] call setNotificationContext;
	}] call Core_addEventHandler;

	// -------- load anim handler section -----------------
	_ctgDown = [_d,WIDGETGROUP,[_offsLeft,100-_offsDown,100-_offsLeft,_offsDown],_ctg] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgDown] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,0.8];
	_back ctrlEnable false;

	_sizeSwitcherX = 20;
	_sizePerButtonY = 100/6;
	_offsetY = 2;
	_curY = 0;

	_t = [_d,TEXT,[0,_curY,_sizeSwitcherX,_sizePerButtonY],_ctgDown] call createWidget;
	[_t,"<t align='center'>Переключатели состояний</t>"] call widgetSetText;
	_t ctrlSetTooltip "Различные переключатели состояний";
	modvar(_curY) + _sizePerButtonY;

	{
		_x params ["_sysname","_name"];
		_b = [_d,"RscCheckBox",[0,_curY,_sizeSwitcherX/2,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		_b ctrlsettext _name;
		_b setvariable ["name",_sysname];
		_b ctrlAddEventHandler ["CheckedChanged",{_this call prox_anim_switchState}];

		_b = [_d,BUTTON,[_sizeSwitcherX/2,_curY,_sizeSwitcherX/2,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		_b ctrlsettext ("Анимации " + _name);
		_b ctrlSetTooltip (ctrltext _b);
		_b setvariable ["name","anim_"+_sysname];
		_b ctrlAddEventHandler ["MouseButtonUp",{_this call prox_anim_switchState}];

		modvar(_curY) + _sizePerButtonY;
	} foreach [
		["combat","Комбат"],
		["twohand","Двуручный"],
		["attack","Атака"],
		["parry","Парирование"]
	];
	
	private _midX = _sizeSwitcherX/2;
	{
		_x params ["_sysname","_name","_idxSetvar"];
		_b = [_d,BUTTON,[_midX*_foreachIndex,_curY,_midX,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		_b ctrlsettext _name;
		_b setvariable ["name",_sysname];
		_b setvariable ["idxSetvar",_idxSetvar];
		_b ctrlAddEventHandler ["MouseButtonUp",{_this call prox_anim_switchState}];
	} foreach [
		["switch_leg_l","Левая нога",1],
		["switch_leg_r","Правая нога",0]
	];
	
	private _posX = _sizeSwitcherX;
	private _handSizeX = 15;
	private _textHeaderSize = 8;
	private _curHeader = 6;
	_curMode = [_d,TEXT,[_posX,0,_handSizeX*2,_curHeader],_ctgDown] call createWidget;
	_curMode setBackgroundColor [0.1,0.1,0.1,0.7];
	[_curMode,"<t align='center'>Текущий сет: НЕИЗВЕСТНО</t>"] call widgetSetText;

	{
		
		_x params ["_name","_stateId"];
		_t = [_d,TEXT,[_posX + (_handSizeX * _foreachIndex),_curHeader,_handSizeX,_textHeaderSize],_ctgDown] call createWidget;
		[_t,"<t align='center'>"+_name+"</t>"] call widgetSetText;

		_w = [_d,LISTBOX,[
			_posX + (_handSizeX * _foreachIndex) + (0.5),
			_textHeaderSize + _curHeader,
			_handSizeX  - 1,
			100-_textHeaderSize
		],_ctgDown] call createWidget;
		_w ctrlAddEventHandler ["LBSelChanged",{
			params ["_w","_id"];
			private _idxSet = _w getvariable "handAnimStateIndex";
			private _lbdat = _w lbData _id;
			if (_lbDat == "") then {_lbDat = "na"};
			prox_anim_handStates set [_idxSet,_lbDat];

			call prox_syncHandAnimations;
		}];
		prox_widgetsHands set [_foreachIndex,_w];
		_w setvariable ["handAnimStateIndex",_stateId];

	} foreach [
		["Левая рука",1],
		["Правая рука",0]
	];

	//загрузка списка анимаций
	call prox_anim_loadHandWidgets;

	private _logic = vcom_logicObject;
	//prox_logicPos = getposatl _logic;
	
	private _unit = createvehicle [BASIC_MOB_TYPE,position _logic,[],0,"none"];
	_unit setUnitFreefallHeight (1e38);
	
	_unit attachto [player,[0,0,0]];
	_unit attachto [_logic,[0,0,0]];

	_unit disableai "target";
	_unit disableai "autotarget";
	_unit disableai "anim";
	_unit addEVENThandler ["AnimDone",{
		(_this select 0) switchMove (_this select 1);
	}];

	removeUniform _unit;
	removeAllWeapons _unit;

	prox_targetObj = _unit;
	
	call prox_syncAnim;

	call prox_initializeModelList;

	["Редактор загружен"] call showInfo;

	if !isNullVar(_curGameObject) then {
		_m = [_curGameObject,"model",true] call oop_getFieldBaseValue;
		[_m] call prox_loadModel;
	};
	
}

function(prox_initializeModelList)
{
	prox_map_modelList = createHashMap;
	{
		private _vadata = proxIt_configData getvariable _x;
		prox_map_modelList set [tolower _x,_vadata];
	} foreach (allVariables proxIt_configData);
}

function(prox_loadModel)
{
	params ["_model"];
	if (_model select [0,1]!="\") then {
		_model = "\"+_model;
	};
	_model = _model call proxIt_prepName;

	private _object = createSimpleObject [_model,[0,0,0],true];
	if isNullReference(_object) exitWith {
		["Cannot load model %1",_model] call showError;
	};
	_object disableCollisionWith prox_targetObj;
	prox_itemObj = _object;
	
	prox_curCfg = prox_slotListData apply {[[0,0,0],[0,0,0]]};
	prox_curCfgPos = [0,0,0];
	prox_curCfgVec = [0,0,0];

	call prox_syncItemObjTransform;

}

function(prox_syncAnim)
{
	private _unit = prox_targetObj;
	private _anlist = ifcheck(prox_map_modes get "combat",prox_wpnAnims,prox_nowpnAnims);
	if (prox_map_modes get "combat") then {
		_unit addWeapon "CombatMode";
		_unit selectWeapon (handgunWeapon _unit);
	} else {
		_unit removeWeapon "CombatMode";
	};
	_unit switchMove (_anlist select prox_currentStance);

	call prox_syncHandAnimations;
}

function(prox_syncItemObjTransform)
{
	if !(call prox_isItemLoaded) exitWith {
		//["Объект не загружен"] call showError;
	};
	private _posOffset = prox_curCfgPos;

	//prox_centerObj

	prox_itemObj attachTo [
		prox_targetObj,
		_posOffset,
		prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_SELNAME,
		true];
	[prox_itemObj,prox_curCfgVec] call BIS_fnc_setObjectRotation;
	//fix lag vector
	prox_itemObj attachTo [
		prox_targetObj,
		_posOffset,
		prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_SELNAME,
		true];
}

function(prox_syncVisualSceneWidgets)
{
	private _dist = prox_itemObj modeltoworld [0,0,0] distance vcom_camObject;
	private _offs = 0.3;
	//_offs = linearConversion[0,10,_dist,0.001,1];
	private _xPos = prox_itemObj modelToWorld [-_offs,0,0];
	private _yPos = prox_itemObj modelToWorld [0,-_offs,0];
	private _zPos = prox_itemObj modelToWorld [0,0,_offs];
	private _widMap = [_xPos,_yPos,_zPos];
	{
		private _color = [0,0,0,1];
		_color set [_foreachIndex,1];
		private _wPosEnd = _widMap select _foreachIndex;
		private _screenPos = (worldToScreen _wPosEnd);
		private _posOfs = [0,0,0];
		_posOfs set [_foreachIndex,ifcheck(_foreachIndex==2,2,-2)];

		drawLine3D [prox_itemObj modeltoworld [0,0,0],prox_itemObj modeltoworld _posOfs,_color];
		(_x call widgetGetPosition select [2,2]) params ["_xofs","_yofs"];
		
		_x ctrlSetPosition _screenPos;
		_x ctrlCommit 0;
		
		//[_x,_screenPos ] call widgetSetPositionOnly;
	} foreach prox_widgetsTrans;
}

//обновление виджетов трансформа
function(prox_updateWidgetsVisual)
{
	params [["_syncSliders",true],["_syncTooltips",true]];

	private _itemLoaded = call prox_isItemLoaded;

	{
		private _value = prox_curCfgPos select _foreachIndex;
		if (_syncSliders) then {
			_x sliderSetPosition (_value);
		};
		if (_syncTooltips) then {
			_x ctrlSetTooltip (format["Pos %1: %2",_x getvariable "name",_value]);
		};
	} foreach prox_widgetsPos;

	{
		private _value = prox_curCfgVec select _foreachIndex;
		if (_syncSliders) then {
			_x sliderSetPosition _value;
		};
		if (_syncTooltips) then {
			_x ctrlSetTooltip (format["Vec %1: %2",_x getvariable "name",_value]);
		};
	} foreach prox_widgetsVec;
}

//вызывается при пользовательском изменении трансформа
function(prox_onUpdateWidgetValue)
{
	params ["_type","_index","_newvalue"];

	if !((tolower _type) in ["pos","vec"]) exitWith {};

	private _data = missionNamespace getvariable ("prox_curCfg"+_type);
	if isNullVar(_data) exitWith {
		setLastError("Unknown type transform - "+_type);
	};

	_data set [_index,_newvalue];
	
	call prox_syncItemObjTransform;

	//post sync description
	[false,true] call prox_updateWidgetsVisual;
}

//вызывается при изменении состояния анимации
function(prox_anim_switchState)
{
	params ["_ct","_bt"];

	private _stateName = _ct getvariable "name";
	if ("switch_leg_" in _stateName) then {
		_idx = _ct getvariable "idxSetvar";
		_oldval = prox_anim_legsExists select _idx;
		prox_anim_legsExists set [_idx,!_oldval];
	} else {
		
		if ("anim_" in _stateName) exitWith {
			_stateName = (_stateName splitString "_") select 1;
			prox_map_currentAnimListMode = _stateName;
			call prox_anim_loadHandWidgets;
		};

		//first disable previous state
		_oldState = "";
		{
			if (_y) exitWith {_oldState = _x};
		} foreach prox_map_modes;
		//двуручка может быть вместе с комбатом и т.д.
		if (_oldState!="" && _oldState!=_stateName && !(_oldState in ["twohand"])) then {
			prox_map_modes set [_oldState,!(prox_map_modes get _oldState)];
		};

		//and then update new
		prox_map_modes set [_stateName,!(prox_map_modes get _stateName)];

		
	};

	call prox_syncAnim;
}

//перезагрузка листа по текущей категории инвентаря
function(prox_inv_loadInventoryList)
{
	private _switcher = prox_inv_widgetCurrentList select 0;
	private _lb = prox_inv_widgetCurrentList select 1;
	lbclear _lb;

	{
		private _itm = _lb lbadd _x;
	} foreach (prox_inv_types select prox_inv_curTypeIdx select 2);

	_lb lbSetCurSel (prox_inv_dataCurIndexes select prox_inv_curTypeIdx);
}

//полная перезагрузка слотов инвентаря
function(prox_inv_onChangeCurrentInventoryItem)
{
	{
		_x params ["_n","","_lvals","_codeUnload","_codeLoad"];
		_curVal = _lvals select (prox_inv_dataCurIndexes select _foreachIndex);
		
		call _codeUnload;
		
		if (_curVal!="") then {
			_curVal call _codeLoad;
		};
	} foreach prox_inv_types;

	call prox_syncItemObjTransform;
}

//перезагруказ слотов инвентаря
function(prox_anim_loadHandWidgets)
{
	/*

	*/
	// private _anims = ["na","na","nl","nl"];
	// private _noPartAnims = +_anims;
	// private _blender = [0,0,0,0];
	if (true) exitWith {};
	private _anims = __ITEM_HANDANIM_LIST_NAMESTRUCT;//default animlist

	if (prox_map_currentAnimListMode=="combat") then {
		_anims = __ITEM_COMBATANIM_LIST_NAMESTRUCT;
	};
	if (prox_map_currentAnimListMode=="attack") then {
		_anims = __ITEM_ATTACKANIM_LIST_NAMESTRUCT;
	};
	if (prox_map_currentAnimListMode=="twohand") then {
		_anims = __ITEM_TWOHANDANIM_LIST_NAMESTRUCT;
	};
	if (prox_map_currentAnimListMode=="parry") then {
		_anims = __ITEM_PARRY_LIST_NAMESTRUCT;
	};


	// private _twoHanded = prox_map_modes get "twohand";

	// private _anims = [__ITEM_HANDANIM_LIST_ALLANIMS_NAMES,ITEM_HANDANIM_LIST_ALLANIMS];
	// if (_twoHanded) then {
	// 	_anims = [__ITEM_TWOHANDANIM_LIST_ALLANIMS_NAMES,ITEM_TWOHANDANIM_LIST_ALLANIMS];
	// };

	// if (prox_map_modes get "combat") then {
	// 	_anims = [__ITEM_COMBATANIM_LIST_ALLANIMS_NAMES,ITEM_COMBATANIM_LIST_ALLANIMS];
	// 	if (_twoHanded) then {
	// 		_anims = [__ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS_NAMES,ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS];
	// 	};
	// };

	// if (prox_map_modes get "attack") then {
	// 	_anims = [__ITEM_ATTACKANIM_LIST_ALLANIMS_NAMES,ITEM_ATTACKANIM_LIST_ALLANIMS];
	// 	if (_twoHanded) then {
	// 		_anims = [__ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS_NAMES,ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS];
	// 	};
	// };

	// if (prox_map_modes get "parry") then {
	// 	_anims = [__item_parry_list_anims__,__item_parry_list_anims__];
	// };

	private _animsreal = [["Без смешивания",""]];
	{
		private _animStr = _anims select 1 select _foreachIndex;
		_animsreal pushBack [_x,_animStr];
	} foreach (_anims select 0);
	
	{
		private _list = _x;
		lbclear _list;
		{
			_x params ["_name","_stateStr"];
			private _id = _list lbAdd _name;
			_list lbsetdata [_id,_stateStr];
			
		} foreach _animsreal;
		if (_foreachIndex==0) then {
			_list ctrlshow (!_twoHanded);
		};
	} foreach prox_widgetsHands;
}

function(prox_syncHandAnimations)
{
	private _combat = prox_map_modes get "combat";
	private _twoHanded = prox_map_modes get "twohand";
	private _attack = prox_map_modes get "attack";
	private _parry = prox_map_modes get "parry";

	private _handStates = prox_anim_handStates;

	private _anims = ["na","na","nl","nl"];
	private _blender = [0,0,0,0];

	{
		if (_foreachIndex>(count _handStates-1)) exitWith {};
		_anims set [_foreachIndex,_handStates select _foreachIndex];
		if ((_anims select _foreachIndex)!="na") then {
			_blender set [_foreachIndex,1];
		};
	} foreach _anims;

	private _startLegIndex = 2;
	{
		if (!_x) then {
			_blender set [_startLegIndex+_foreachIndex,1];
		};
	} foreach prox_anim_legsExists;

	private _prefix = ""; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	private _activeAction = false;
	if (_attack) then {
		_prefix = ifcheck(_twoHanded,"att_TW","att_");
		_activeAction = true;
	};
	if (_parry) then {
		_prefix = "par_";
		_activeAction = true;
	};
	if (!_activeAction && _twoHanded) then {
		_prefix = ifcheck(_combat,"com_TW","TW");
	};

	private _stack = [_prefix+"%1R%2L%3R%4L_%5%6%7%8"];
	_stack append _anims;
	_stack append _blender;
	
	private _finalState = format _stack;
	["play state: %1",_finalState] call printTrace;
	prox_targetObj playActionNow _finalState;
}
