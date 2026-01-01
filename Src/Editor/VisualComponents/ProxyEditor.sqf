// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//animations variables
#include "..\..\host\GameObjects\Items\Item_HandAnim.hpp"
#include "..\..\client\Inventory\inventory.hpp"

#define PROX_SDATA_INDEX_SELNAME 0
#define PROX_SDATA_INDEX_SLOTNAME 1
#define PROX_SDATA_INDEX_ID 2
#define PROX_SDATA_INDEX_VARNAME 3

#include <ProxyEditor\ProxyAnim.sqf>
#include <ProxyEditor\ProxyInventory.sqf>
#include <ProxyEditor\ProxyObject.sqf>

init_function(prox_initialize)
{
	if !isNullVar(prox_targetObj) then {
		deletevehicle prox_targetObj;
		deletevehicle prox_centerObj;
		deletevehicle prox_itemObj;
	};
	prox_targetObj = objNull; //моб
	
	prox_stateConstFormatter = "Amov%1%2%3%4%5";

	prox_stateNames = ["Стоя","Сидя","Лежа"];
		prox_statePref = ["Perc","Pknl","Ppne"];//1
	prox_moveNames = ["Стоять","Идти","Бежать","Спринт"];
		prox_movePref = ["Mstp","Mwlk","Mrun","Meva"];//2

	prox_wpnStatePref = ["Sras","Slow"];//3

	prox_wpnPref = ["Wnon","Wpst"];//4

	prox_moveDirNames = ["Вперёд","Назад","Вправо","Влево","Вперед-вправо","Вперед-влево","Назад-вправо","Назад-влево"];
		prox_moveDirPref = ["Df","Db","Dr","Dl","Dfr","Dfl","Dbr","Dbl"];//5

	prox_animSpeedCoef = 1;

	/*
		бег - Mrun,Mwlk,Meva, Mstp
		Оружие стейт - Slow,Sras - без оружия Snon
		комбат - Wpst\Wnon
		направление Dnon, Df,Db,Dl,Dr,Dfl,Dfr,Dbl,Dbr
		AmovPercMrunSlowWpstDf - поднятое оружие стоя
		AmovPercMrunSlowWpstDb - поднятое оружие стоя назад
		AmovPercMwlkSnonWnonDf
		AmovPercMwlkSrasWpstDf
		AmovPercMevaSlowWpstDf
	*/

	prox_map_currentAnimListMode = "normal";

	prox_isCombat = false;
	prox_isTwoHanded = false;

	prox_currentStance = 0; //текущая стойка
	prox_currentStanceDefault = 0;//стоя
	prox_curMoveSpeed = 0;
	prox_curMoveSpeedDefault = 0;
	prox_moveDir = 0;
	prox_moveDirDefault = 0;

	prox_wpnState = 0;
	prox_wpnStateDefault = 0;

	prox_curSelection = 0; //текущий слот инвентаря
	prox_curCfg = []; //текущий полный сохранённый конфиг
	
	//!do not change variable postfix
	prox_curCfgPos = [0,0,0]; 
	prox_curCfgVec = [0,0,0];
	
	prox_itemObj = objNull; //объект предмета

	//ссылки на виджеты
	prox_widgetsPos = [];
	prox_widgetsVec = [];
	prox_widgetsOffset = [];

	//прокси центр
	prox_centerObjOffset = [0,0,0];
	prox_centerObjRange = 2;
	prox_centerObj = "Sign_Sphere10cm_F" createvehicle [0,0,0];

	//хелперы трансформа сцены
	prox_widgetsTrans = []; //inscene widgets transform
	prox_posRange = 1;

	prox_vecRange = 180;

	prox_widgetsHands = []; //ссылки на виджеты рук. виджеты типа Listbox
	prox_widgetStateNameRef = [];

	prox_anim_handEnumStates = [-1,-1];//r,l
	prox_anim_handEnumStatesCached = createHashMapFromArray [
		["combat",[-1,-1]]

	];
	prox_anim_partsExists = [true,true,true,true]; //r, l

	call {
		#include "..\..\host\Namings\FacesHelpers.sqf"
		#include "..\..\host\Namings\PrepareFaces.sqf"
	};

	call {
		#define ANIMATOR_EDITOR
		smd_isCombatModeEnabled = {prox_isCombat};
		smd_isTwoHandedModeEnabled = {prox_isTwoHanded};
		smd_isSitting = {false};
		smd_getAnimValue = {
			params ["_mob","_hnd","_categ"];
			// if ((prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_ID) != _hnd) exitWith {
			// 	-1
			// };
			//return -1 if no blend, categ - 0 noncombat, 1 combat
			private _indexOf = ifcheck(_hnd==INV_HAND_R,0,1);
			prox_anim_handEnumStates select _indexOf
			//-1
		};
		smd_isCustomAnimationEnabled = {false};

		prox_initOnMob = {
			params ["_mob"];
			_mob setvariable ["smd_bodyParts",prox_anim_partsExists];//reference
		};

		#include "..\..\host\CommonComponents\Animator.sqf"
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

	prox_slotListData = [];
	{
		prox_slotListData set [_foreachindex,
			[_x,INV_LIST_SLOTNAMES select _foreachindex,INV_LIST_ALL select _foreachindex,INV_LIST_VARNAME select _foreachindex]
		]
	} foreach proxIt_list_selections;
}

function(prox_loadInternalCode)
{
	#include "..\..\client\ProxyItems\ProxyItems.sqf"
}

function(prox_isItemLoaded) {!isNullReference(prox_itemObj)}

function(prox_openEditor)
{
	params [["_curGameObject",null]];

	prox_currentStance = prox_currentStanceDefault;
	prox_curSelection = 0;

	if !isNullReference(prox_targetObj) then {
		deletevehicle prox_targetObj;
	};
	if !isNullReference(prox_itemObj) then {
		deletevehicle prox_itemObj;
	};
	
	["prox"] call vcom_openWindow;

	private _unitRef = [objNull];

	private _offsLeft = 30;
	private _offsDown = 30;
	[[_offsLeft,0,100-_offsLeft,100-_offsDown],_unitRef] call vcom_observ_loadCameraController;
	private _logic = vcom_logicObject;
	private _unit = _unitRef select 0;

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

	// loading left panel
	call prox_internal_loadLeftPanel;

	[true,true] call prox_updateWidgetsVisual;

	private _t = [_d,TEXT,[_offsLeft,0,100-_offsLeft,5],_ctg] call createWidget;
	[_t,null,[""]+( notificationSounds select 1 select [1,2] )] call setNotificationContext;
	["onDisplayClose",{[null] call setNotificationContext;}] call Core_addEventHandler;

	// -------- load anim handler section -----------------
	call prox_internal_loadBottomPanel;

	//загрузка списка анимаций
	call prox_anim_loadHandWidgets;
	//prox_logicPos = getposatl _logic;
	
	
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
	prox_isExternalCam = true;
	if !isNullReference(prox_firstPersonCamera) then {
		deletevehicle prox_firstPersonCamera;
	};

	prox_firstPersonCamera = call{private _c = "camera" createVehicleLocal [0,0,0]; _c hideObject true; _c};
	prox_cam_dragControl = [0,0];
	prox_cam_vec_lastDirect = [0,0];

	prox_cam_defaultPos = [-0.05,-0.05,0.12];

	[_unit] call prox_initOnMob;
	call prox_syncAnim;

	call prox_initializeModelList;

	["Редактор загружен"] call showInfo;

	if !isNullVar(_curGameObject) then {
		_m = [_curGameObject,"model",true] call oop_getFieldBaseValue;
		[_m] call prox_loadModel;
	};
	
}

function(prox_onChangedCameraMode)
{
	params ["_newmode"];
	prox_isExternalCam = _newmode;
	if (!_newmode) then {
		private _cam = prox_firstPersonCamera;
		_cam cameraeffect ["internal", "back"];
		
		// _cam campreparefov 0.70;
		// _cam camcommitprepared 0;
		// _cam attachTo [prox_targetObj, prox_cam_defaultPos,"head",true];
		// _cam setVectorUp [0,0,1];
		// _cam attachTo [prox_targetObj, prox_cam_defaultPos,"head",true];
		detach _cam;
	} else {
		private _cam = vcom_camObject;
		_cam cameraeffect ["internal", "back"];
		_cam campreparefocus [-1,-1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
	};
}

function(prox_cam_updateInternalCamera)
{
	_cam_isNewCamera = false;
	_unit = prox_targetObj;

	_isArcadeMode = false;
	_lamp = prox_firstPersonCamera;
	
	_cameraVector = getCameraViewDirection _unit;//(if (!cam_isNewCamera) then {_unit} else {cam_object}); //z offset
	_offsetVector = [0,0.06,0.01];

	_dir = if(_isArcadeMode) then
	{
		[0,0,0] getdir _cameraVector;
	} else {
		if (!_cam_isNewCamera) then {
		[0,0,0] getdir (eyeDirection _unit);
		} else {
		[0,0,0] getdir (vectorDirVisual cam_object)
		};
	};


	_pitch = (_cameraVector select 2) * 90;

	//_cam_camshakeDir
	//getMousePosition params ["_x","_y"];
	_ref = (call vcom_getDisplay) getvariable "____zoneDragRef";
	(if (_ref call isMouseInsideWidget && (count (vcom_observ_buttons select 0) > 0)) then {
		_d = (_ref call getMousePositionInWidget) vectoradd [-50,-50];
		prox_cam_vec_lastDirect = _d;
		_d
		//prox_cam_dragControl //todo fix cam rotator
	} else {
		//[0,0]
		prox_cam_vec_lastDirect
	}) params ["_x","_y"];
	
	MOD(_dir, + _x /100 * 250);
	MOD(_pitch, - _y /100 * 250);

	_vuz = cos _pitch;

	_oldPos = if (!_cam_isNewCamera) then {
		AGLToASL(_unit modelToWorldVisual ((_unit selectionPosition "head")vectoradd[-0.06,0.0,0.0889]))/*eyePos _unit*/
		} else {
			getPosASLVisual //cam_object
			prox_firstPersonCamera
		};

	//_offsetVector = _offsetVector vectorAdd [0,0,0];
	
	_rvec = [ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz] ];
	_rpos = ((_oldPos) vectorAdd [
		((_offsetVector select 0) * cos _dir) + ((_offsetVector select 1) * sin _dir),
		(((_offsetVector select 1) * cos _dir) - (_offsetVector select 0) * sin _dir),
		_offsetVector select 2
		]);
	
	//save pos
	_cam_renderPos = ASLToATL _rpos;
	_cam_renderVec = _rvec;
	//calculate mouse vector
	_mousepos = screenToWorld getMousePosition;
	_i = lineIntersectsSurfaces [_rpos,AGLToASL _mousepos,_unit,_lamp,true,5,"VIEW","NONE"];
	
	//мы получили вектор направления для мыши. Если луч не прокнул то 
	_cam_renderVecMouse = [
		if(count _i > 0)then {
			vectorNormalized ((ASLToATL(_i select 0 select 0)) vectorDiff _cam_renderPos)
		}else{
			_rvec select 0
		}
		,
		_rvec select 1
	];
	
	_lamp setVectorDirAndUp _rvec;
	_lamp setPosASL _rpos;
}


//загрузчик левой панели (трансформ, слоты и т.д.)
function(prox_internal_loadLeftPanel)
{
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

	[[_d,TEXT,[0,_curY,100,4],_ctgLeft] call createWidget,"<t align='center'>Центр</t>"] call widgetSetText;
	modvar(_curY) + 4;
	_sizeDragOfs = 1.5;
	_color = [0,0,0,1];
	{
		private _s = [_d,SLIDERWNEW,[0,_curY,100,_sizeDragOfs],_ctgLeft] call createWidget;
		_s sliderSetRange [-prox_centerObjRange,prox_centerObjRange];
		_s sliderSetSpeed [0.1,0.1];
		_s setvariable ["name",_x];
		_s setvariable ["type","ofs"];
		_s setvariable ["index",_foreachIndex];
		private _newcolor = array_copy(_color);
		_newcolor set [_foreachIndex,2];
		_s ctrlSetForegroundColor _newcolor;
		_s ctrlSetActiveColor _newcolor;

		modvar(_curY) + _sizeDragOfs + _offsetDrag;
		prox_widgetsOffset set [_foreachindex,_s];
	} foreach ["Xofs","Yofs","Zofs"];

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
	} foreach (prox_widgetsVec + prox_widgetsPos + prox_widgetsOffset);
}

function(prox_internal_loadBottomPanel)
{
	_ctgDown = [_d,WIDGETGROUP,[_offsLeft,100-_offsDown,100-_offsLeft,_offsDown],_ctg] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgDown] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,0.8];
	_back ctrlEnable false;


	_sizeSwitcherX = 10;
	_sizePerButtonY = 100/6;
	_offsetY = 2;
	_curY = 0;

	_t = [_d,TEXT,[0,_curY,_sizeSwitcherX,_sizePerButtonY],_ctgDown] call createWidget;
	[_t,"<t align='center'>Состояния</t>"] call widgetSetText;
	_t ctrlSetTooltip "Различные переключатели состояний";
	modvar(_curY) + _sizePerButtonY;

	private _stateModeWidgets = [];
	{
		_x params ["_sysname","_name"];

		_b = [_d,BUTTON,[0,_curY,_sizeSwitcherX,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		_stateModeWidgets pushBack _b;
		_b ctrlsettext (_name);
		_b ctrlSetTooltip ("Стейт " + (ctrltext _b));
		_b setvariable ["sysname",_sysname];
		_b setvariable ["name",_name];
		_b ctrlAddEventHandler ["MouseButtonUp",{_this call prox_anim_switchState}];

		// _b = [_d,"RscCheckBox",[_sizeSwitcherX/2,_curY,_sizeSwitcherX/2,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		// _b ctrlsettext _name;
		// _b setvariable ["name",_sysname];
		// _b ctrlAddEventHandler ["CheckedChanged",{_this call prox_anim_switchState}];

		modvar(_curY) + _sizePerButtonY;
	} foreach [
		["normal","Стандарт"],
		["combat","Комбат"],
		["attack","Атака"],
		["parry","Парирование"]
	];
	
	private _midX = _sizeSwitcherX/2;
	{
		_x params ["_sysname","_name","_idxSetvar"];
		_b = [_d,BUTTON,[_midX*_foreachIndex,_curY,_midX,_sizePerButtonY-_offsetY],_ctgDown] call createWidget;
		_b ctrlsettext _name;
		_b setvariable ["name",_sysname];
		_b setvariable ["idxSetvar",_idxSetvar+2];//offset for hands
		_b ctrlAddEventHandler ["MouseButtonUp",{_this call prox_anim_switchLegState}];
	} foreach [
		["switch_leg_l","Л.нога",1],
		["switch_leg_r","П.нога",0]
	];
	
	//widgetzone config
	private _posX = _sizeSwitcherX;
	_sizeZone = 20;
	_ofsY = 2;
	private _ctg = [_d,WIDGETGROUP,[_posX,_ofsY,_sizeZone,100],_ctgDown] call createWidget;
	_szPb = 10;
	_th = [_d,BUTTON,[0,_ofsY,100,_szPb],_ctg] call createWidget;
	_th ctrlsettext "Двуручный";
	_th ctrlAddEventHandler ["MouseButtonUp",{
		params ["_wid","_bt"];
		prox_isTwoHanded = !prox_isTwoHanded;
		call prox_syncAnim;
		call prox_anim_loadHandWidgets;
	}];
	modvar(_ofsY) + _szPb;

	//cam
	_cam = [_d,BUTTON,[0,_ofsY,100,_szPb],_ctg] call createWidget;
	_cam ctrlsettext "Камера";
	_cam ctrlAddEventHandler ["MouseButtonUp",{
		[!prox_isExternalCam] call prox_onChangedCameraMode;
	}];
	modvar(_ofsY) + _szPb;

	//stance
	_st = [_d,"RscCombo",[0,_ofsY,100,_szPb],_ctg] call createWidget;
	{
		private _i = _st lbadd _x;
	} foreach prox_stateNames;
	_st ctrlAddEventHandler ["LBSelChanged",{
		params ["_wid","_idx"];
		prox_currentStance = _idx;
		call prox_syncAnim;
	}];
	_st lbSetCurSel prox_currentStanceDefault;
	modvar(_ofsY) + _szPb;

	//walk,run etc
	_st = [_d,"RscCombo",[0,_ofsY,100,_szPb],_ctg] call createWidget;
	{private _i = _st lbadd _x} foreach prox_moveNames;
	_st ctrlAddEventHandler ["LBSelChanged",{
		params ["_wid","_idx"];
		prox_curMoveSpeed = _idx;
		call prox_syncAnim;
	}];
	_st lbSetCurSel (prox_curMoveSpeedDefault);
	modvar(_ofsY) + _szPb;

	//moving direction
	_st = [_d,"RscCombo",[0,_ofsY,100,_szPb],_ctg] call createWidget;
	{private _i = _st lbadd _x} foreach prox_moveDirNames;
	_st ctrlAddEventHandler ["LBSelChanged",{
		params ["_wid","_idx"];
		prox_moveDir = _idx;
		call prox_syncAnim;
	}];
	_st lbSetCurSel (prox_moveDirDefault);
	modvar(_ofsY) + _szPb;

	//wpn state(raise,lower)
	
	_st = [_d,SLIDERWNEW,[0,_ofsY,100,_szPb],_ctg] call createWidget;
	_st ctrlAddEventHandler ["SliderPosChanged",{
		params ["_w","_val"];
		prox_animSpeedCoef = _val;
		prox_targetObj setAnimSpeedCoef prox_animSpeedCoef;
	}];
	_st ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w","_ct"];
		if (_ct==MOUSE_RIGHT) exitWith {prox_animSpeedCoef = 1;
		prox_targetObj setAnimSpeedCoef prox_animSpeedCoef;
		_w sliderSetPosition prox_animSpeedCoef;
		};
	}];
	_st sliderSetRange [0,2];
	_st sliderSetSpeed [0.01,0.1];
	_st sliderSetPosition prox_animSpeedCoef;


	_posX = _posX + _sizeZone;
	private _handSizeX = 15;
	private _textHeaderSize = 8;
	private _curHeader = 6;
	_curMode = [_d,TEXT,[_posX,0,_handSizeX*2,_curHeader],_ctgDown] call createWidget;
	_curMode setBackgroundColor [0.1,0.1,0.1,0.7];
	[_curMode,"<t align='center'>Текущий сет: НЕИЗВЕСТНО</t>"] call widgetSetText;
	prox_widgetStateNameRef set [0,_curMode];

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
			private _lbDat = _w lbData _id;
			if (_lbDat == "") then {_lbDat = "na"};
			
			_lbDat = parseNumber _lbDat;

			prox_anim_handEnumStates set [_idxSet,_lbDat];
			if (prox_isTwoHanded) then {
				prox_anim_handEnumStates = prox_anim_handEnumStates apply {_lbDat};
			};

			call prox_syncHandAnimations;
		}];
		prox_widgetsHands set [_foreachIndex,_w];
		_w setvariable ["handAnimStateIndex",_stateId];

	} foreach [
		["Левая рука",1],
		["Правая рука",0]
	];
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
	deletevehicle prox_itemObj;

	_object disableCollisionWith prox_targetObj;
	prox_itemObj = _object;
	
	prox_curCfg = prox_slotListData apply {[[0,0,0],[0,0,0]]};
	prox_curCfgPos = [0,0,0];
	prox_curCfgVec = [0,0,0];
	prox_centerObjOffset = [0,0,0];

	call prox_syncItemObjTransform;

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

		drawLine3D [prox_centerObj modeltoworld (_posOfs vectorMultiply -1),prox_centerObj modeltoworld _posOfs,_color];

		drawLine3D [prox_itemObj modeltoworld (_posOfs vectorMultiply -1),prox_itemObj modeltoworld _posOfs,_color];
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

	{
		private _value = prox_centerObjOffset select _foreachIndex;
		if (_syncSliders) then {
			_x sliderSetPosition _value;
		};
		if (_syncTooltips) then {
			_x ctrlSetTooltip (format["Offset %1: %2",_x getvariable "name" select [0,1],_value]);
		};
	} foreach prox_widgetsOffset;
}

//вызывается при пользовательском изменении трансформа
function(prox_onUpdateWidgetValue)
{
	params ["_type","_index","_newvalue"];

	if !((tolower _type) in ["pos","vec","ofs"]) exitWith {};

	private _data = missionNamespace getvariable ("prox_curCfg"+_type);
	if (_type == "ofs") then {
		_data = prox_centerObjOffset;
	};
	if isNullVar(_data) exitWith {
		setLastError("Unknown type transform - "+_type);
	};

	_data set [_index,_newvalue];
	
	call prox_syncItemObjTransform;

	//post sync description
	[true,true] call prox_updateWidgetsVisual;
}


