// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "inventory.hpp"
#include "helpers.hpp"
#include "..\Interactions\interact.hpp"
#include "..\WidgetSystem\widgets.hpp"

namespace(Inventory,inventory_)

//угол наклона при котором режим выкладывания меняется с центра экрана на мышь
macro_const(inventory_maxOnMouseCursorDropAngle)
#define MAX_ONMOUSECURSOR_DROP_ANGLE -0.2

//дистанция выкладывания
macro_const(inventory_putDownRadius)
#define PUTDOWN_RADIUS INTERACT_ITEM_DISTANCE

decl(mesh)
inventory_previewObject = objnull;
decl(float)
inventory_lastDirPreviewObject = 0;

decl(void(int))
inventory_createPreviewObject = {
	params ["_slotId"];
	if !isHandDrag exitWith {};
	
	//internal unsafe redirect
	_slotId = [player,_slotId] call smd_getRedirectOnTwoHanded;
	
	private _model = _slotId call inventory_getModelById;
	
	inventory_previewObject = createSimpleObject [_model,[0,0,0],true];
	inventory_previewObject disableCollisionWith player;
	inventory_lastDirPreviewObject = random 360;
	invlog("Inventory::createPreviewObject - object is %1",inventory_previewObject);
	
	inventory_previewObject setVariable ["isInteractible",false];
	inventory_previewObject setVariable ["interactibleTarget",objnull];
	inventory_previewObject setposatl nullPostionPreviewObject;
	
	//if slotid is hand and have model then hide this
	if array_exists(INV_LIST_HANDS,_slotId) then {
		private _obj = [player,_slotId] call smd_getObjectInSlot;
		if !isNullReference(_obj) then {
			inventory_previewObject setVariable ["hiddensmdobj",_obj];
		};
	};
};

decl(void())
inventory_onVisualPreviewObject = {
	if (!isHandDrag || inventory_isPressedRMBDrag) exitWith {};
	
	inline_macro
	#define __internal_resetBackColor  getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR
	inline_macro
	#define resetBackgrounDragSlot _visObj hideObject false; __internal_resetBackColor
		
	private _visObj = inventory_previewObject;
	private _smdObj = _visObj getVariable ["hiddensmdobj",objnull];
	//скрытие если первый раз вышел за зону нажатия
	/*if (inventory_isOutsideDragCatch) then {
		private _smdobj = (_visObj getVariable ["hiddensmdobj",objnull]);
		if !(isObjectHidden _smdobj) then {_smdobj hideObject true};
	};*/
	
	
	//if pos inside widgets inventory then out (setpos 0 0 0)	
	if (
		inventory_invWidgetSize call isMouseInsidePosition || 
		isInsideVerbMenu_inv || 
		{inventory_isOpenContainer && inventory_contWidgetSize call isMouseInsidePosition} ||
		call inventoryIsInsideSelfWidget
	) exitWith {
		_smdObj hideObject false;
		_visObj setposatl nullPostionPreviewObject;
		resetBackgrounDragSlot
	};
	
	(_visObj call interact_getMouseIntersectData) params ["_targ","_pos","_vecup"];
	
	if equals(_targ,objNUll) exitWith {
		_smdObj hideObject false;
		_visObj setposatl nullPostionPreviewObject;
		resetBackgrounDragSlot
	};
	
	if !(_pos call interact_checkPosition) exitWith {
		_smdObj hideObject false;
		_visObj setposatl nullPostionPreviewObject;
		resetBackgrounDragSlot
	};
	
	if (_targ call smd_isSMDObjectInSlot) exitWith {
		_smdObj hideObject false;
		_visObj setposatl nullPostionPreviewObject;
		resetBackgrounDragSlot;
	};
	
	//При грабах переназначаем цель
	if (_targ getVariable ["__ngoext_itt",false]) then {
		_targ = _targ call noe_client_getNGOSource;
	};
	
	private _isInteractible = isInteractible(_targ); //для человека скрывается модель
	
	if _isInteractible then {
		//getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR_CANINTERACT;
		_visObj hideobject true;
	} else {
		resetBackgrounDragSlot;
	};
	//MODARR(_pos,2,+0.001);
	
	_smdObj hideObject true;
	_visObj setposatl _pos;
	_visObj setdir inventory_lastDirPreviewObject;
	_visObj setVectorUp _vecup; //(_vecup vectorDiff [0,0,0.2]); //варик для выкладывания на стенах
	_visObj setVariable ["isInteractible",_isInteractible];
	_visObj setVariable ["interactibleTarget",_targ];
};

decl(void(bool))
inventory_collectInfoOnPutdown = {
	params ["_isFastPutdown"];
	
	if (_isFastPutdown) then {
		//[object, intersect position,vectorUp lod]
		([objnull] call interact_getIntersectData) params ["_obj","_pos","_vup"];
		if isInteractible(_obj) then {_vup = [0,0,-1]};
		[_pos,random 360,_vup,[_obj,true] call noe_client_getObjPtr];
	} else {
		private _visObj = inventory_previewObject;
		
		[getPosATLVisual _visObj,getDir _visObj,vectorUpVisual _visObj,[getInteractibleTarget,true] call noe_client_getObjPtr]
	};
};

decl(void())
inventory_deletePreviewObject = {
	if (true) exitWith {
		// пока вся система ниже не настроена и работает нестабильно
		if !isHandDrag exitWith {};
		private _smdObj = inventory_previewObject getVariable ["hiddensmdobj",objNull];
		if !isNullReference(_smdObj) then {_smdObj hideObject false};
		deleteVehicle inventory_previewObject;
	};
	
	private _isPutdown = _this;
	
	if !isHandDrag exitWith {};
	if isNullVar(_isPutdown) exitWith {
		deleteVehicle inventory_previewObject;
	};
	
	//очищаем память предыщущей модели
	private _memObj = inventory_previewObject;
	inventory_previewObject = objNull;
	
	private _modelPathOld = (getModelInfo _memObj) select 1;
	
	//добавляем логики на случай лага сервера
	//TODO maybee checking direction???
	private _interpolationLogic = {
		(_this select 0) params ["_objectToDelete","_modelPathOld","_originPos","_passes"];
		
		if (_passes >= 10) exitWith {
			errorformat("World model not loading - passes overflow (%1). Autodispoing and stop thread",_passes);
			stopThisUpdate();
		};
		
		(_this select 0) set [3,_passes + 1];
		
		_list = _originPos nearObjects 2;
		_list = _list - [_objectToDelete];
		
		{
			if (_objectToDelete distance _x < 0.001 && ((getModelInfo _x) select 1) == _modelPathOld) exitWith {
				traceformat("disposing object %1; Data %2 | %3==%4 | passes %5",_objectToDelete arg (_objectToDelete distance _x) toFixed 10 arg getdir _x arg getdir _objectToDelete arg _passes);
				
				deleteVehicle _objectToDelete;
				stopThisUpdate();
			};
		} foreach _list;
		
		
	}; startUpdateParams(_interpolationLogic,0.3,[_memObj arg _modelPathOld arg getPosATLVisual _memObj arg 0]);
};