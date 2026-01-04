// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include <..\InputSystem\inputKeyHandlers.hpp>
#include "..\ClientRpc\clientRpc.hpp"
#include "inventory.hpp"
#include "helpers.hpp"

namespace(Inventory,inventory_)

macro_const(invetory_widgetSizeInvSlot)
#define SIZE_INVSLOT 7

macro_const(inventory_widgetMyPersonFadeValExit)
#define MYPERSON_FADEVAL_EXIT 0.9
macro_const(inventory_widgetMyPersonFadeValEnter)
#define MYPERSON_FADEVAL_ENTER 0.2
macro_const(inventory_widgetMyPersonFadeTime)
#define MYPERSON_FADETIME 0.5

decl(void())
inventory_init = {

	private _offsetW = transformSizeByAR(SIZE_INVSLOT);
	private _biasW = transformSizeByAR(SLOT_BIASH);

	[getGUI,INV_HAND_L call inventoryGetSlotNameById,[50 - _offsetW - _biasW,100 - SIZE_INVSLOT,SIZE_INVSLOT,SIZE_INVSLOT],INV_HAND_L] call createWidget_invSlot;
	[getGUI,INV_HAND_R call inventoryGetSlotNameById,[50 + _biasW,100 - SIZE_INVSLOT,SIZE_INVSLOT,SIZE_INVSLOT],INV_HAND_R] call createWidget_invSlot;

	startUpdate(inventory_onUpdate,0);

	rpcAdd("updateGermsInv",inventory_syncGerms);
	rpcAdd("updateslotinfo",inventory_onSlotUpdate);
	rpcAdd("updateslotlistinfo",inventory_onSlotListUpdate);
	rpcAdd("onContainerOpen",inventory_onContainerOpen);
	rpcAdd("onContainerContentUpdate",inventory_onContainerContentUpdate);
	rpcAdd("onChangeLocContainer",inventory_onChangeLocContainer);
	
	rpcAdd("invsetglobvis",inventory_setGlobalVisible);
};

decl(void(bool))
inventory_setHideHands = {
	params ["_mode"];

	if (_mode == inventory_canHideHands) exitWith {
		warningformat("inventory::setHideHands() - Already setted on %1",_mode);
	};

	inventory_canHideHands = _mode;

	if (_mode) then {
		private _update = {

			if (isInventoryOpen) exitWith {};

			if (tickTime > inventory_hideTimestamp) then {
				if (inventory_isFullHide) exitWith {};
				_hv = inventory_hideValue;
				MOD(_hv, + 0.1);
				{
					_x setFade _hv;
					_x commit INV_HIDE_PERUPDATE_DELAY;
				} foreach [INV_HAND_L call inventoryGetWidgetById,INV_HAND_R call inventoryGetWidgetById];

				if (_hv >= 1) then {
					inventory_isFullHide = true;
					_hv = 1;
				};
				inventory_hideValue = _hv;
			};
		};

		//first init vars
		inventory_hideTimestamp = tickTime + inventory_hideAfter;
		inventory_isFullHide = false;
		inventory_hideValue = 0;

		inventory_hideHandler = startUpdate(_update,INV_HIDE_UPDATE_DELAY);
	} else {
		if (inventory_hideHandler != -1) then {stopUpdate(inventory_hideHandler)};
		inventory_hideHandler = -1;

		if (inventory_hideValue != 0) then {
			{
				_x setFade 0;
				_x commit 0;
			} foreach [INV_HAND_L call inventoryGetWidgetById,INV_HAND_R call inventoryGetWidgetById];
			inventory_hideValue = 0;
		};
	};
};

decl(void(bool;bool))
inventory_restoreHide = {
	params ["_now",["_applyCommit",true]];
	if (inventory_hideValue != 0) then {
		inventory_hideValue = 0;
		{
			_x setFade 0;
			if (_applyCommit) then {
				_x commit ([INV_HIDE_PERUPDATE_DELAY,0] select _now);
			};
		} foreach [INV_HAND_L call inventoryGetWidgetById,INV_HAND_R call inventoryGetWidgetById];
	};
	inventory_hideTimestamp = tickTime + inventory_hideAfter;
	inventory_isFullHide = false;
};

inventory_isGlobalVisible = true;

//установка видимости слотов на глобальном уровне
decl(void(bool))
inventory_setGlobalVisible = {
	params ["_mode"];
	if equals(_mode,inventory_isGlobalVisible) exitWith {};
	
	inventory_isGlobalVisible = _mode;
	{
		if !isNullReference(_x) then {
			_x ctrlShow _mode;
		};
	} foreach inventor_slot_widgets;
	private _valmod = ifcheck(_mode,-100,+100);
	{
		_x set [1,(_x select 1)+_valmod];
	} foreach inventory_slotpos_map;
	
	call inventory_resetPositionHandWidgetsForced;
};

decl(void())
inventory_applyColorTheme = {
	{
		(_x getVariable "background") setBackgroundColor (["inv_slot_back"] call ct_getValue)
	} foreach [INV_HAND_L call inventoryGetWidgetById,INV_HAND_R call inventoryGetWidgetById];
};

//Псевдоним widgetSetPicture в этом модуле
decl(void(widget;string))
inventory_widgetSetPicture = {
	params ["_pic","_val"];
	if isNullReference(_pic getVariable vec2("text",widgetNull)) exitWith {
		[_pic,_val] call WidgetSETPICTURE;
	};
	if (_val in inventory_sloticons_default) then {
		[_pic getVariable "text",""] call widgetSetText;
		[_pic,_val] call WidgetSETPICTURE;
	} else {
		private ["_picval","_textval"];
		FORCEUnicode 1;
		if ("\!" in _val) then {
			_idx = _val find "\!";
			if (_idx != -1) then {
				_textval = _val select [_idx+2,count _val];
				_textval = _textval select [0,count _textval - 4];
			} else {
				_textval = "err_idx_not_found_inv_wsp";
			};
			_picval = "";
		} else {
			_picval = _val;
			_textval = "";
		};
		
		[_pic getVariable "text",format["<t align='center' font='Ringbear' size='0.65'>%1</t>",_textval]] call widgetSetText;
		[_pic,_picval] call WidgetSETPICTURE;
	};
};

decl(widget(display;string|int;vector4;int))
createWidget_invSlot = {

	params ["_display","_slotName","_pos","_slotId"];

	private _offsetW = transformSizeByAR(SIZE_INVSLOT);

	private _isDragger = if (_slotName isequalto INDEX_DRAGGER) then {true} else {false};


	private _ctg = [_display,WIDGETGROUP,_pos] call createWidget_square;
	private _background = [_display,BACKGROUND,[0,0,100,100],_ctg] call createWidget;

	_background setBackgroundColor BACKGROUND_COLOR;
	private _pic = [_display,PICTURE,[0,0,100,100],_ctg] call createWidget;
	private _dirtOverlay = [_display,PICTURE,WIDGET_FULLSIZE,_ctg] call createWidget;

	_ctg setvariable ['background',_background];
	_ctg setVariable ["icon",_pic];
	_ctg setvariable ["dirtOverlay",_dirtOverlay];
	_pic setVariable ["text",[_display,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget]; //внутри пикчи создали текст и зареферили на него

	#ifdef INVENTORY_USE_NEW_RENDER_ICONS
	private _obj = _display ctrlCreate ["RscObject",-1,_ctg];//[_display,"RscObject",[0,0,100],_ctg] call createWidget;
	_ctg setvariable ["model",_obj];
	#endif



	if (!_isDragger) then {

		[_dirtOverlay,inventory_const_dirtOverlayIcon] call widgetSetPicture;

		if (isEmptySlot(_slotId)) then {
			#ifndef INVENTORY_USE_NEW_RENDER_ICONS
			[_pic,_slotId call inventoryGetPictureById] call widgetSetPicture;
			#else
			_obj ctrlSetModel "\A3\Weapons_f\dummyweapon.p3d";
			#endif
		} else {
			#ifndef INVENTORY_USE_NEW_RENDER_ICONS
			[_pic,getSlotDataById(_slotId) select SD_ICON] call widgetSetPicture;
			#else
			_obj ctrlSetModel (getSlotDataById(_slotId) select SD_MODEL);
			[_ctg] call inventory_syncModelPos;
			#endif
		};


		//common vars
		_ctg setvariable ["slotname",_slotname];
		_ctg setVariable ["slotid",_slotId];

		//post save
		inventor_slot_widgets set [_slotId,_ctg];
		
		//create hand lastCombatActionTime overlay
		if (_slotId in INV_LIST_HANDS) then {
			private _lca = [_display,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
			_lca setBackgroundColor [1,0.118,0,0.7];
			_lca setFade 1;
			_lca commit 0;
			_lca setVariable ["lca_destr",0];
			_ctg setVariable ["lca",_lca]; 
		};
	};

	_ctg
};

decl(void())
openInventory = {

	#ifdef DEBUG
	private _invTimeCreate = tickTime;
	#endif

	#ifdef SP_MODE
		sp_checkInput("open_inventory",[]);
	#endif

	if (isDisplayOpen) exitWith {};

	private _d = call dynamicDisplayOpen;
	
	[_d] call vs_addDisplayInputHandlers;

	//отладочная консоль в инвентаре
	/*
	_s = [_d,INPUT,[50,50,50,10]] call createWidget;
	_in = [_d,BUTTON,[50,50+10,50,10]] call createWidget;
	_in ctrlAddEventHandler ["MouseButtonUp",{
		_b = _this select 0;
		_in = _b getvariable "inp";
		_c = call compile (ctrlText _in);
		if !isNullVar(_c) then {
			logformat("RETTTTTTTTTTTT: %1",_c);
		};
	}];
	_in setvariable ["inp",_s];
	*/

	if (!inventory_supressInventoryOpen) then {
		_d displayAddEventHandler ["KeyUp",{
			params ["_d","_key"];

			//process input emote text
			if equals(focusedCtrl _d,_d getVariable "ieMenuCtg" getVariable "input") exitWith {};

			doPrepareKeyData(_this);

			if isPressed(input_act_inventory) exitWith {
				nextFrame({call closeInventory});
			};

			if isPressed(input_act_changeActHand) exitWith {
				call inventory_changeActiveHand;
			};

			//if unconscious state cant handle keys
			if (!([] call interact_isActive)) exitWith {};

			if isPressed(input_act_switchTwoHands) exitWith {call inventory_changeTwoHandsMode};
			if isPressed(input_act_pointTo) exitWith {call interact_pointTo};

			if isPressed(input_act_examine) exitWith {
				nextFrame(inventory_onExamine);
			};
			
			if isPressed(input_act_mainAction) exitWith {
				[] call inventory_onMainAction;
			};
			
			//сброс и смена активной руки
			if isPressed(input_act_dropitem) exitWith {
				[] call inventory_onDropItem;
			};
			if isPressed(input_act_putdownitem) exitWith {
				[null,true] call inventory_onPutDownItem;
			};

			// stun check
			if (call smd_isStunned) exitWith {};

			if isPressed(input_act_extraAction) exitWith {
				nextFrame(inventory_onExtraAction);
				//nextFrame(inventory_onAltClick);
			};

			if isPressed(input_act_combatMode) exitWith {
				if (call input_passThroughWallsProtect) exitWith {};
				[!([player] call smd_isCombatModeEnabled)] call interact_setCombatMode;
			};
		}];

		_d displayAddEventHandler ["mousebuttondown",inventory_onMousePress];
		_d displayAddEventHandler ["MouseButtonUp",inventory_onMouseRelease];
		_d displayAddEventHandler ["MouseZChanged",inventory_onMouseScroll];
	};


	private _offsetW = transformSizeByAR(SIZE_INVSLOT);
	private _handPos = [50 - _offsetW / 2,100 - SIZE_INVSLOT,SIZE_INVSLOT,SIZE_INVSLOT];//(INV_HAND_L call inventoryGetWidgetById) call widgetGetPosition;
	private ["_slotId","_wid"];

	{
		_slotId = _x;
		_wid = [_d,_slotId call inventoryGetSlotNameById,_handPos,_slotId] call createWidget_invSlot;
		_wid setFade 1;
		_wid commit 0;
	} foreach inventory_openModeSlotsId;

	//create self widgets
	private _sizeWSelf = transformSizeByAR(SLOT_BIASH) * 2 + _offsetW * 3;
	private _ctgSelf = [_d,WIDGETGROUP,
		[
			50 - _sizeWSelf/2,
			100 - SELF_CTG_SIZE_H,
			_sizeWSelf,
			SELF_CTG_SIZE_H
		]
	] call createWidget;
	_ctgSelf setVariable ["resetpos",vec2(50 - _sizeWSelf/2,100 - SELF_CTG_SIZE_H)];
	widgetFadeNow(_ctgSelf,1);
	setSelfCtg(_ctgSelf);
	private _ctgBackground = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgSelf] call createWidget;
	_ctgBackground setBackgroundColor BACKGROUND_COLOR_ACTIVEHAND;
	private _scaleMyPerson = 32; //ширина кнопки моей персоны
	private _ctgSelfIcon = [_d,PICTURE,[50-(_scaleMyPerson/2),0,_scaleMyPerson,100],_ctgSelf] call createWidget;
	[_ctgSelfIcon,PIC_PATH("myperson")] call widgetSetPicture;
	private _ctgSelfText = [_d,TEXT,[0,30,100,100-30],_ctgSelf] call createWidget;
	setSelfCtgText(_ctgBackground); _ctgBackground setvariable ["__text",_ctgSelfText];
	[_ctgSelfText,"<t align='center'>Моя персона</t>"] call widgetSetText;

	//fade on load
	_ctgSelfText setFade MYPERSON_FADEVAL_EXIT;
	_ctgSelfText commit 0;
	

	true call inventory_onPrepareSlots;

	isInventoryOpen = true;

	//create dragger
	private _drager = [_d,INDEX_DRAGGER,[0,0,_handPos select 2,_handPos select 3]] call createWidget_invSlot;
	onDragInit(_drager);

	inventory_modifierScroll = false;
	if (!inventory_supressInventoryOpen) then {
		_d displayAddEventHandler ["keyDown",{params ["_d","_key","_shift"];
			doPrepareKeyData(_this);

			if (_shift) then {inventory_modifierScroll = true};
			//if isPressed(input_act_mainAction) exitWith {inventory_isPressedInteractButton = true};
			inventory_isHoldMode && _key == KEY_TAB
		}];
		_d displayAddEventHandler ["keyUp",{params ["_d","_key","_shift"];
			doPrepareKeyData(_this);

			if (_shift) then {inventory_modifierScroll = false};
			//if isPressed(input_act_mainAction) exitWith {inventory_isPressedInteractButton = false};
		}];
	};

	inventory_isPressedInteractButton = false;

	nextFrame(interact_openMouseMode);

	#ifdef DEBUG
	private _deltaTime = tickTime - _invTimeCreate;
	logformat("[EXTENDED_INVENTORY_UPDATE]: Inventory loaded at %1 sec (%2 ms)",_deltaTime arg (_deltaTime*1000)toFixed 8);
	#endif

	#ifdef SP_MODE
	nextFrame({call sp_gui_syncInventoryVisible});
	#endif
};

decl(void(bool))
inventory_onPrepareSlots = {
	private _isOpened = _this;



	if (_isOpened) then {

		((INV_HAND_L call inventoryGetWidgetById) call widgetGetPosition) params ["_xp","_yp","_wp","_hp"];

		_xp = 50 - transformSizeByAR(SIZE_INVSLOT) / 2;
		_yp = 100 - SIZE_INVSLOT;

		private _biasW = transformSizeByAR(SLOT_BIASH);

		#define setslotpos(obj,xpos,ypos) [obj,[_xp + ((_wp + _biasW) * xpos),_yp + ((_hp + SLOT_BIASH) * ypos)] , TIME_PREPARE_SLOTS] call widgetSetPositionOnly

		private _fadeVal = ifcheck(inventory_supressInventoryOpen,1,0);
		//setslotpos(INV_BACK,  -1, _hp * -2);
		//setslotpos(INV_ARMOR, _wp * 0, _hp * -2);
		//setslotpos(INV_HEAD, _wp * 1, _hp * -2);
		private "_slotObj";
		{
			(inventory_slotpos_map select _x) params ["_xMap","_yMap"];
			_slotObj = (_x call inventoryGetWidgetById);
			_slotObj setFade _fadeVal;
			setslotpos(_slotObj,_xMap,_yMap);

		} foreach inventory_openModeSlotsId;

		//set pos self widget
		private _ctgSelf = getSelfCtg;
		_ctgSelf setFade _fadeVal;
		[_ctgSelf,[
			_xp + ((_wp + _biasW) * (inventory_slotpos_map select INV_BACKPACK select 0)),
			_yp + ((_hp + SLOT_BIASH) * (inventory_slotpos_map select INV_BACKPACK select 1)) - SELF_CTG_SIZE_H
		],TIME_PREPARE_SLOTS] call widgetSetPositionOnly;

		//setting mouse pos
		//[_xp + transformSizeByAR(SIZE_INVSLOT) / 2,_yp - 10] call mouseSetPosition;
		invokeAfterDelayParams(mouseSetPosition,TIME_PREPARE_SLOTS,
			ifcheck(inventory_supressInventoryOpen,vec2(50,50),vec2(_xp + transformSizeByAR(SIZE_INVSLOT) / 2,_yp - (SIZE_INVSLOT-(SIZE_INVSLOT/2))))
		);

		#define DEMAP(index,side) (inventory_slotpos_map select index select side)
		#define POS_LEFTUP _xp + ((_wp + _biasW) * DEMAP(INV_BACKPACK,0)),_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_BACKPACK,1))
		#define POS_RIGHTDOWN _xp + ((_wp + _biasW) * DEMAP(INV_HAND_R,0)) + _wp,_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_HAND_R,1)) + _hp

		inventory_invWidgetSize = [POS_LEFTUP , POS_RIGHTDOWN];

		//shown hands
		[false,false] call inventory_restoreHide;
		[false,true] call hud_hide_reset;

		{
			(inventory_slotpos_map select _x) params ["_xMap","_yMap"];
			_slotObj = (_x call inventoryGetWidgetById);
			setslotpos(_slotObj,_xMap,_yMap);
		} foreach [INV_HAND_L,INV_HAND_R];

		//germs sync
		inventory_commitNowAllGerms = true;
		inventory_slotdataDirt call inventory_syncGerms;

	} else {

		private _handsWidPos = (INV_HAND_L call inventoryGetWidgetById) call widgetGetPosition;
		_handsWidPos set [0, 50 - transformSizeByAR(SIZE_INVSLOT) / 2];
		_handsWidPos set [1,100 - SIZE_INVSLOT];

		//hide self widget
		private _ctgSelf = getSelfCtg;
		_ctgSelf ctrlEnable false;
		_ctgSelf setFade 1;
		[_ctgSelf,_ctgSelf getVariable "resetpos",TIME_PREPARE_SLOTS] call widgetSetPositionOnly;

		//shown hands
		[false,false] call inventory_restoreHide;
		[false,false] call hud_hide_reset;

		{
			_wObj = _x call inventoryGetWidgetById;
			_wObj setFade 1;
			[_wObj,_handsWidPos,TIME_PREPARE_SLOTS] call widgetSetPosition;
		} foreach inventory_openModeSlotsId;

		call inventory_resetPositionHandWidgets;
	};
};

decl(void())
inventory_resetPositionHandWidgets = {
	private _offsetW = transformSizeByAR(SIZE_INVSLOT);
	private _biasW = transformSizeByAR(SLOT_BIASH);
	if (!inventory_isGlobalVisible) then {
		_biasW = 100; _offsetW = 100;
	};
	[INV_HAND_L call inventoryGetWidgetById,[50 - _offsetW - _biasW,100 - SIZE_INVSLOT],TIME_PREPARE_SLOTS] call widgetSetPositionOnly;
	[INV_HAND_R call inventoryGetWidgetById,[50 + _biasW,100 - SIZE_INVSLOT],TIME_PREPARE_SLOTS] call widgetSetPositionOnly;
};

decl(void())
inventory_resetPositionHandWidgetsForced = {
	private _offsetW = transformSizeByAR(SIZE_INVSLOT);
	private _biasW = transformSizeByAR(SLOT_BIASH);
	if (!inventory_isGlobalVisible) then {
		_biasW = 100; _offsetW = 100;
	};
	[INV_HAND_L call inventoryGetWidgetById,[50 - _offsetW - _biasW,100 - SIZE_INVSLOT],0] call widgetSetPositionOnly;
	[INV_HAND_R call inventoryGetWidgetById,[50 + _biasW,100 - SIZE_INVSLOT],0] call widgetSetPositionOnly;
};

decl(void())
closeInventory = {

	false call inventory_onPrepareSlots;

	if (isDragProcess) then {
		inventory_pressedwidget set [PRESSED_LINK,widgetNull];
		getDragSlot setFade 1;
		getDragSlot commit TIME_PREPARE_DRAG;
		isInsidePressedSlot = false;
		call inventory_deletePreviewObject;
	};

	if (isOpenedVerbMenu) then {
		call inventory_unloadVerbMenu;
	};

	if (inventory_isOpenContainer) then {
		call inventory_closeContainer;
	};

	if (inventory_supressInventoryOpen) then {
		call closeInventory_handle;
	} else {
		invokeAfterDelay(closeInventory_handle,TIME_PREPARE_SLOTS + 0.1);
	};


	private __inventory_closeFlag = true;
	call interact_closeMouseMode;
};

//Событие закрытия инвентаря
decl(void())
closeInventory_handle = {
	call displayClose; isInventoryOpen = false;
};

/*
==============================================================================
					REGION: WIDGET HELPERS
==============================================================================
*/
decl(string(int))
inventoryGetPictureById = {
	inventory_sloticons_default select _this
};

decl(string(int))
inventoryGetSlotNameById = {
	inventory_slotnames_default select _this
};

decl(widget(int))
inventoryGetWidgetById = {
	inventor_slot_widgets select _this
};

decl(widget())
inventoryGetWidgetOnMouse = {
	FHEADER;
	{
		if (_x call isMouseInsideWidget) exitWith {
			RETURN(_x)
		};
	} foreach inventor_slot_widgets;

	widgetNull;
};

decl(widget())
inventoryGetContainerWidgetOnMouse = {
	FHEADER;
	{
		if (_x call isMouseInsideWidget) exitWith {
			RETURN(_x)
		};
	} foreach inventory_containerSlots;

	widgetNull;
};

decl(bool())
inventoryIsInContainerWidgetsZone = {
	inventory_isOpenContainer && {inventory_contWidgetSize call isMouseInsidePosition}
};

decl(bool())
inventoryIsInWidgetsZone = {
	inventory_invWidgetSize call isMouseInsidePosition || {call inventoryIsInContainerWidgetsZone} || call inventoryIsInsideSelfWidget
};

decl(bool())
inventoryIsInsideSelfWidget = {getSelfCtg call isMouseInsideWidget};

/*
==============================================================================
					REGION: HANDLERS UPDATE
==============================================================================
*/

decl(void())
inventory_onUpdate = {
	#ifdef INVENTORY_USE_NEW_RENDER_ICONS
	{
		if !isNullReference(_x) then {
			[_x] call inventory_syncModelPos;
		};
	} foreach inventor_slot_widgets;
	#endif

	//indata_debug = [getDragSlot call widgetGetPosition,ctrlFade getDragSlot];
	if (isInventoryOpen) then {
		if (isDragProcess) then {
			private _dragSlot = getDragSlot;

			if (getPressedSlot call isMouseInsideWidget) then { //находится внутри драгуемого
				// если он видим и применён
				if ((getFade _dragSlot) != 1 && isCommited _dragSlot) then {
					_dragSlot setFade 1;
					isInsidePressedSlot = true;
				};
			} else { //находится снаружи
				//если он невидим и применён
				if ((getFade _dragSlot) == 1 && isCommited _dragSlot) then {
					_dragSlot setFade DRAG_FADE_PROCESS;
					isInsidePressedSlot = false;
				};
				if (!inventory_isOutsideDragCatch) then {inventory_isOutsideDragCatch = true};



			};

			(call mouseGetPosition) params ["_mouseX","_mouseY"];
			getPressedSlotPosition params ["_pressedX","_pressedY"];
			[_dragSlot,[_mouseX - _pressedX,_mouseY - _pressedY]] call widgetSetPositionOnly;

			//драгер
			call inventory_onVisualPreviewObject;

			/*private _onMouseWidget = call inventoryGetWidgetOnMouse;
			if (isEmptyWidget(_onMouseWidget) || (getSlotId(_onMouseWidget) == INV_HAND_L)) then {
				getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR;
			} else {
				getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR_CANINTERACT;
			};*/
		};		

		if (inventory_isOpenContainer) then {
			call inventory_onUpdateContainer;
		};
	};
	
	//TODO: доделать - очень сырой вариант
	//Увеличение иконки при наведении
	_w = call inventoryGetWidgetOnMouse;
	if (!isInventoryOpen) then {_w = widgetNull};
	if !isNullReference(_w) then {
		_lastFocus = inventory_lastFocusedWidget select 0;
		if !isNullReference(_lastFocus) then {
			if equals(_w,_lastFocus) exitWith {};
			_wid = getSlotIcon(_lastFocus);
			[_wid,WIDGET_FULLSIZE,0.1] call widgetSetPosition;
			inventory_lastFocusedWidget set [0,widgetNull];
		};
		
		_wid = getSlotIcon(_w);
		
		if equals(_w,_lastFocus) exitWith {};
		if isEmptyWidget(_w) exitWith {};
		
		_sizeMod = 30;
		[_wid,[0-_sizeMod/2,0-_sizeMod/2,100+_sizeMod,100+_sizeMod],0.3] call widgetSetPosition;
		inventory_lastFocusedWidget set [0,_w];// именно w  а не иконку
	} else {
		_lastFocus = inventory_lastFocusedWidget select 0;
		if !isNullReference(_lastFocus) then {
			_wid = getSlotIcon(_lastFocus);
			[_wid,WIDGET_FULLSIZE,0.1] call widgetSetPosition;
			inventory_lastFocusedWidget set [0,widgetNull];
		};
	};

	//хандлер скрытия текста моей персоны
	if (isInventoryOpen) then {
		_ctgT = getSelfCtgText;
		_t = _ctgT getvariable "__text";
		_state = _t getvariable ["_state",false];
		_stateChanged = _t getvariable ["_isChanged",false];
		
		if (_ctgT call isMouseInsideWidget) then {
			
			if (!_state) then {
				_t setFade MYPERSON_FADEVAL_ENTER;
				_t commit MYPERSON_FADETIME;
				_t setvariable ["_state",true];
			};
		} else {
			if (_state) then {
				_t setFade MYPERSON_FADEVAL_EXIT;
				_t commit MYPERSON_FADETIME;
				_t setvariable ["_state",false];
			};
		};
	};
	
	//sync last combat action color
	//cd_lca_r, cd_lca_l
	_doUnhide = false;
	{
		_x params ["_id","_ref"];
		_val = missionNamespace getVariable _ref;
		_wid = (_id call inventoryGetWidgetById) getVariable "lca";
		if (_val>0) then {
			//traceformat("VAL NON NULL %1",_val);
			_wid setVariable ["lca_destr",tickTime+_val];
			_wid setVariable ["lca_tts",tickTime];
			missionNamespace setVariable [_ref,0];
			[_wid,[0,0,100,100]] call widgetSetPosition;
			_wid setFade 0;
			_wid commit 0;
		};
		_t = _wid getVariable "lca_destr";
		if (_t > 0) then {
			_doUnhide = true;
			_i = linearConversion[_wid getVariable "lca_tts",_t,tickTime,50,0,true];
			_i2 = linearConversion[_wid getVariable "lca_tts",_t,tickTime,100,0,true];
			//traceformat("PROCESS %1",_i);
			[_wid,[50-_i,50-_i,_i2,_i2],0] call widgetSetPosition;
			if (_i <= 0) then {
				_wid setVariable ["lca_destr",0];
				_wid setFade 0;
				_wid commit 0.1;
			};
		};
	} count [[INV_HAND_R,"cd_lca_r"],[INV_HAND_L,"cd_lca_l"]];
	
	if (_doUnhide) then {
		[false] call inventory_restoreHide
	};
};

// Событие при нажатии мышки на слот
decl(bool(widget;int))
inventory_onMousePress = {
	params ["_obj","_key"];

	if (!([] call interact_isActive)) exitWith {};

	if (verb_isMenuLoaded || isInsideVerbMenu_inv) exitWith {
		invlog("Inventory::onMousePress (event) - verb menu opened",null);
		false
	};
	if (call smd_isStunned) exitWith {false};
	if (isDragProcess) exitWith {
		invlog("Inventory::onMousePress - Detect double call onMousePress",null);
		false;
	};

	if (isInsideVerbMenu_inv) exitWith {false};

	inventory_isOutsideDragCatch = false;

	//Клик по самому себе
	if (call inventoryIsInsideSelfWidget) exitWith {
		if (!ctrlEnabled getSelfCtg) exitWith {};
		if (_key == MOUSE_LEFT) exitWith {
			[false,true] call interact_onLMBPress;
		};
		if (_key == MOUSE_RIGHT) exitWith {
			trace("press mouse: no action defined")
		};
	};

	private _probwidget = call inventoryGetWidgetOnMouse;
	if (!(_probwidget isEqualTo widgetNull) && !isDragProcess) then {
		inventory_isPressedRMBDrag = _key == MOUSE_RIGHT;
		onPressSlot(_probwidget);
		invlog("Inventory::onMousePress (event) - isEmpty: %1",str isEmptyWidget(_probwidget));
	} else {

		_probwidget = call inventoryGetContainerWidgetOnMouse;
		if (!(_probwidget isEqualTo widgetNull) && !isDragProcess) then {
			_probwidget call inventory_onPressContainerSlot;
			invlog("Inventory::onMousePress (event) - pressed on container slot. Number item is %1", getSlotId(_probwidget));
		} else {
			invlog("Inventory::onMousePress (event) - No pressed any",0);
		};
	};

};

//событие при отпускании мышки на слоте
decl(bool(widget;int))
inventory_onMouseRelease = {
	params ["_obj","_key"];

	if (!([] call interact_isActive)) exitWith {};

	if (verb_isMenuLoaded || isInsideVerbMenu_inv) exitWith {
		invlog("Inventory::onMouseRelease (event) - verb menu opened",null);
		false
	};
	//Если отпущенная клавиша не ассоциируется с нажатой то выходим
	/*if ((_key == MOUSE_LEFT && inventory_isPressedInteractButton) ||
		(_key == MOUSE_RIGHT && !inventory_isPressedInteractButton)) exitWith {
		invlog("Inventory::onMouseRelease (event) - protect double release mouse buttons",null);
		false
	};*/

	//не хандлим стан здесь во избежании проблем

	if (isDragProcess) then {
		private _probwidget = call inventoryGetWidgetOnMouse;

		if (!isContainerSlot(getPressedSlot)) then {
			if (inventory_isOpenContainer && {(getContainerMainCtg call isMouseInsideWidget)}) then {
				call inventory_onReleaseSlotToContainer;
			} else {
				onReleaseSlot(_probwidget);
			};
		} else {
			_probwidget call inventory_onReleaseSlotFromContainer;
		};

	} else {

		if (call inventoryIsInsideSelfWidget && _key == MOUSE_RIGHT) exitWith {
			rpcSendToServer("getObjectVerbs",[player arg getObjReferenceWithMob(player) arg true]);
		};
	};

	//inventory_isPressedInteractButton = false;
};

// При скроллинге мышкой
decl(void(display;float))
inventory_onMouseScroll = {
	params ["_disp", "_scroll"];

	if (isDragProcess) then {

		if (inventory_invWidgetSize call isMouseInsidePosition) exitWith {};

		private _lastDir = inventory_lastDirPreviewObject;

		private _scrollVal = 4;
		if (inventory_modifierScroll) then {MOD(_scrollVal,*4)};

		MOD(_lastDir, + _scroll * _scrollVal);

		if (_lastDir >= 360 || _lastDir <= -360) then {
			_lastDir = 0;
		};

		inventory_lastDirPreviewObject = _lastDir;
	};
};

/*
==============================================================================
					REGION: EVENTS
==============================================================================
*/

decl(void(int;any;bool))
inventory_onSlotUpdate = {
	params ["_slotid","_data",["_supressRestoreHide",false]];



	if (_slotid == -1) exitWith {
		invlog("Inventory::onSlotUpdate error - slotid is unknown. Data: %1",_data);
		error("Error on update slot info. Unknown slot");
	};

	if (_slotId in INV_LIST_HANDS && !_supressRestoreHide) then {
		[false] call inventory_restoreHide;
	};
	private _wid = _slotid call inventoryGetWidgetById;
	private _widPic = getSlotIcon(_wid);

	inventory_slotdata set [_slotId,_data];

	if (_data isequalto []) then {
		//if (_supressRestoreHide) exitWith {}; //supressed remove if stolen?!
		#ifndef INVENTORY_USE_NEW_RENDER_ICONS
		[_widPic,_slotid call inventoryGetPictureById] call widgetSetPicture;
		#else
		(_wid getvariable "model") ctrlSetModel "\A3\Weapons_f\dummyweapon.p3d";
		#endif
	} else {
		//allocate picture path
		private _icn = _data select SD_ICON;
		if (!(".paa" in _icn)) then { //realoc if not fullpath
			_data set [SD_ICON,PATH_PICTURE_INV(_data select SD_ICON)];
		};
		#ifndef INVENTORY_USE_NEW_RENDER_ICONS
		[_widPic,_data select SD_ICON] call widgetSetPicture;
		#else
		(_wid getvariable "model") ctrlSetModel (_data select SD_MODEL);
		[_wid] call inventory_syncModelPos;
		#endif
	};

	//close verb menu
	if (isOpenedVerbMenu) then {
		if (getVerbMenuWidget getVariable ["currentViewSlotId",-1] == _slotId) then {
			call inventory_unloadVerbMenu;
		};
	};
};

decl(void(...any[]))
inventory_syncGerms = {
	private _data = _this;

	assert(!isNullVar(_data)); //notnull struct
	assert(count _data > 0);//nonempty struct
	assert(({(count _x) == 2} count _data) == (count _data));//correct struct

	inventory_slotdataDirt = _data;

	{
		_x call inventory_internal_syncGermsBodyPartKey;
	} foreach inventory_slotdataDirt;

	if (inventory_commitNowAllGerms) then {
		inventory_commitNowAllGerms = false;
	};
};

decl(void(string;float))
inventory_internal_syncGermsBodyPartKey = {
	params ["_partKey","_opacity"];
	private _idx = inventory_const_partkeyToSlots findif {_x select 0 == _partKey};
	if (_idx == -1) exitwith {
		errorformat("inventory_internal_syncGermsBodyPartKey - Cant find partKey '%1'",_partKey);
	};
	private _partData = inventory_const_partkeyToSlots select _idx select 1;
	if not_equalTypes(_partData,[]) then {_partData = [_partData]};

	private _wid = widgetNull;
	{
		_wid = _x call inventoryGetWidgetById;
		_wid = getSlotDirtOverlay(_wid);
		_wid setFade _opacity;
		_wid commit ifcheck(inventory_commitNowAllGerms,0,0.1);
	} foreach _partData;
};

#ifdef INVENTORY_USE_NEW_RENDER_ICONS
decl(void(widget))
inventory_syncModelPos = {
	params ["_wid"];
	private _obj = _wid getvariable "model";
	private _scale = 1 / (getResolution select 5); // keep object the same size for any interface size
	private _distance = 30 * 4/3;
	if ((getResolution select 4) < (4/3)) then { _distance = _distance * (getResolution select 7); }; // eg 5x4
	private _base = ["3d", [
		(ctrlPosition _wid) select 0,
		(ctrlPosition _wid) select 1,
		_distance
	], _scale] call widgetModel_objectHelper;
	_base = [((ctrlPosition _wid) select 0) + (
		((ctrlPosition _wid) select 2)/2
	),
		((core_modelBBX getOrDefault [ctrlModel _obj,[0,0,1]]) select 2) * (_base select 1), 
		//_base select 1,
	((ctrlPosition _wid) select 1) + (
		((ctrlPosition _wid) select 3)/2
	)];
	
	_obj ctrlSetPosition _base;
	_obj ctrlSetModelScale _scale;
	_obj ctrlSetModelDirAndUp (([60,75,0] call model_convertPithBankYawToVec));

	_obj ctrlSetFadE rand(0.2,0.5);
	_obj ctrlCommit 0;
};
#endif

decl(void(...any[]))
inventory_onSlotListUpdate = {
	private _data = _this;

	{
		_x call inventory_onSlotUpdate
	} foreach _data;
};

decl(void(widget))
inventory_onReleaseSlot = {

	params ["_slotTo"];

	private _pressedSlot = getPressedSlot;

	inventory_pressedwidget set [PRESSED_LINK,widgetNull];

	getDragSlot setFade 1;
	getDragSlot commit TIME_PREPARE_DRAG;

	isInsidePressedSlot = false;

	if (_slotTo isEqualTo widgetNull) exitWith {

		/*if (isInteractibleAction && false) then {
			invlog("Inventory::onInteractTargetWith - Interacting on target with <%1> item.",getSlotDataById(getSlotId(_pressedSlot)));

			[getInteractibleTarget,getSlotDataById(getSlotId(_pressedSlot))] call inventory_onInteractTargetWith;

		} else {
			if (call inventoryIsInsideSelfWidget) then {
				invlog("Inventory::onReleaseSlot - Apply item to self. Data: <%1>",getSlotDataById(getSlotId(_pressedSlot)));
				[player,getSlotDataById(getSlotId(_pressedSlot))] call inventory_onInteractTargetWith;
			} else {
				invlog("Inventory::onReleaseSlot - Droping item. Data: <%1>",getSlotDataById(getSlotId(_pressedSlot)));

				[getSlotId(_pressedSlot)] call inventory_onPutDownItem;
			};
		};*/

		if (!inventory_isPressedRMBDrag) then {
			if (isInteractibleAction) then {
				invlog("Inventory::onInteractTargetWith - Interacting on target with <%1> item.",getSlotDataById(getSlotId(_pressedSlot)));
				[getInteractibleTarget,getSlotDataById(getSlotId(_pressedSlot))] call inventory_onInteractTargetWith;
			} else {
				invlog("Inventory::onReleaseSlot - Putdown item. Data: <%1>",getSlotDataById(getSlotId(_pressedSlot)));
				[getSlotId(_pressedSlot)] call inventory_onPutDownItem;
			};
		} else {
			invlog("Inventory::onReleaseSlot - no slot to slot defined. return from this function-> rmb:%1;itract:%2",inventory_isPressedRMBDrag arg isInteractibleAction);
		};

		true call inventory_deletePreviewObject; //on post putdown
	};

	call inventory_deletePreviewObject; //if not delete

	if (_pressedSlot isEqualTo _slotTo) then {
		if (inventory_isOutsideDragCatch) exitWith {
			invlog("Inventory::onReleaseSlot - onLMBItem - skip main action. Flag inventory::isOutsideDragCatch equals true: %1",getSlotName(_pressedSlot))
		};
		if (inventory_isPressedRMBDrag) exitWith {
			invlog("Inventory::onReleaseSlot - Attempt to load verb info for %1",getSlotName(_pressedSlot));
			[_pressedSlot] call inventory_onGetItemVerbs;
		};
		invlog("Inventory::onReleaseSlot - onLMBItem - preparing to click %1",getSlotName(_pressedSlot));
		[] call inventory_onClick;
	} else {
		if (inventory_isPressedRMBDrag) exitWith {
			invlog("Inventory::onReleaseSlot - protect transfer RMB from %1 to %2",getSlotName(_pressedSlot) arg getSlotName(_slotTo));
		};
		invlog("Inventory::onReleaseSlot - transfer item from %1 to %2",getSlotName(_pressedSlot) arg getSlotName(_slotTo));
		[_pressedSlot,_slotTo] call inventory_onTransferSlot;
	};

};

decl(void(widget))
inventory_onPressSlot = {
	params ["_slotFrom"];

	if (isEmptyWidget(_slotFrom)) exitWith {
		invlog("Inventory::onPressSlot - Slot is empty (%1)",getSlotName(_slotFrom));
	};

	invlog("Inventory::onPressSlot - pressed pos is %1",_slotFrom call getMousePositionInWidget);
	setPressedSlotPosition(_slotFrom call getMousePositionInWidget);

	inventory_pressedwidget set [PRESSED_LINK,_slotFrom];

	getDragSlot setFade DRAG_FADE_PROCESS;
	getDragSlot commit TIME_PREPARE_DRAG; //Если не нужно мигание при нажатии - поставь тут 0

	private _fromIcon = widgetGetPicture(getSlotIcon(_slotFrom));

	[getSlotIcon(getDragSlot),_fromIcon] call widgetSetPicture;

	isInsidePressedSlot = true;

	[getSlotId(_slotFrom)] call inventory_createPreviewObject;
};

//событие при выкладывании на землю
//параметр _isFastPutdown - событие безопасного выкладывания из руки
decl(void(int;bool))
inventory_onPutDownItem = {
	params [["_id",cd_activeHand],["_isFastPutdown",false]];

	if (!array_exists(INV_LIST_HANDS,_id)) exitWith {
		invlog("Inventory::onPutdownItem - attempt to putdown item from slot %1 (non-hand)",_id);
	};

	//дроп под руку
/*	if (_isFastPutdown) exitWith {
		rpcSendToServer("onDropItem",[player arg _id arg true]);
	};*/
	//выкладка при драге не прокает
	if (isDragProcess && _isFastPutdown) exitWith {};
	//анти спам выкладывания
	if (_isFastPutdown && {["fastputdown",0.7] call input_spamProtect}) exitWith {};

	private _sData = getSlotDataById(_id);
	if equals(_sData,[]) exitWith {
		traceformat("inventory::onPutdownItem() - Item already non exists %1",_id);
	};

	private _reference = _sData select SD_POINTER;

	private _posData = [_isFastPutdown] call inventory_collectInfoOnPutdown;

	if !((_posData select 0) call interact_checkPosition) exitWith {

		private _pos = _posData select 0;
		_pos = [round (_pos select 0),round (_pos select 1),round (_pos select 2)];
		if equals(_pos,nullPostionPreviewObject) exitWith {}; //в нулевой позиции просто не достать

		private _randMes = ["Далеко.","Не дотягиваюсь.","Руки короткие.","Не могу положить так далеко.","Слишком далеко для этого.","Я не могу так далеко положить."];
		[pick(_randMes),"error"] call chatprint;
	};
	private _ctx = [player arg _reference arg _posData];
	if (_isFastPutdown) then {_ctx pushBack true};
	rpcSendToServer("onPutdownItem",_ctx);
};

//Событие которое выбрасывает предмет из инвентаря
decl(void(int))
inventory_onDropItem = {
	params [["_id",cd_activeHand]];

	if (isEmptySlot(_id)) exitWith {}; //с пустого слота и выкидывать нечего
	if (_id < 0) exitWith {
		errorformat("Inventory::onDropItem - Unknown slot id %1",_id);
	};

	//private _ref = getSlotDataById(_id) select SD_POINTER;

	rpcSendToServer("onDropItem",[player arg _id]);
};

//Событие при передачи из одного слота в другой
decl(void(widget;widget))
inventory_onTransferSlot = {
	params ["_slotFrom","_slotTo"];

	private _idFrom = getSlotId(_slotFrom);
	private _IdTo = getSlotId(_slotTo);

	private _handsIndex = [INV_HAND_L,INV_HAND_R];

	if (!array_exists(_handsIndex,_idFrom) && !array_exists(_handsIndex,_idTo) && _idFrom != _idTo) exitWith {
		invlog("Inventory::OnTransferSlot - Cant transfer from %1 to %2. Process aborted.",_idFrom arg _idTo);

		_cantrerquip = ["%1 не в руках.","%1 уже на мне."];
		[format[pick(_cantrerquip),(_idFrom call inventory_getSlotDataById) select SD_NAME],"error"] call chatprint;
	};

	//if (isEmptySlot(_idFrom) || isEmptySlot(_idTo)) exitWith {
	//	invlog("Inventory::onInteractInventoryWith - attempt to try interact from %1 (isempty:%2) to %3 (isempty:%4)",_idFrom arg isEmptySlot(_idFrom) arg _idTo arg isEmptySlot(_idTo));
	//};

	if (!isEmptySlot(_idFrom) && !isEmptySlot(_idTo)) exitWith {
		private _hashFrom = getSlotDataById(_idFrom) select SD_POINTER;
		private _hashTo = getSlotDataById(_idTo) select SD_POINTER;
		/*
		invlog("Inventory::onInteractInventoryWith - attempt to try interact from %1 to %2. Hashes %3",_idFrom arg _idTo arg [_hashFrom arg _hashTo]);

		rpcSendToServer("onInteractInventoryWith",[player arg _hashFrom arg _hashTo]);*/
		invlog("Inventory::onInteractInventoryWith - PROTECTED INTERACT. interact from %1 to %2. Hashes %3",_idFrom arg _idTo arg [_hashFrom arg _hashTo]);

		rpcSendToServer("onInteractInventoryWith",[player arg _hashFrom arg _hashTo]);
	};

	invlog("Inventory::OnTransferSlot - Prepare to send info for server: from %1 to %2",_idFrom arg _IdTo);

	rpcSendToServer("onTransferItem",[player arg _idFrom arg _idTo]);
};

decl(void(mesh;any[]))
inventory_onInteractTargetWith = {
	params ["_obj","_slotData"];

	if (_slotData isEqualTo []) exitWith {
		invlog("Inventory::onInteractTargetWith - slot data is empty",0);
	};
	if (_obj isEqualTo objnull) exitWith {
		invlog("Inventory::onInteractWith - target is null reference",0);
	};

	private _hash = _slotData select SD_POINTER;

	if (_obj call noe_client_isNGO) then {_obj = _obj call noe_client_getNGOSource};

	rpcSendToServer("onInteractWith",[player arg getObjReferenceWithMob(_obj) arg _hash]);
};

decl(void())
inventory_onMainAction = {
	
	if (isInsideVerbMenu_inv) exitWith {};

	private _pressedSlot = call inventoryGetWidgetOnMouse;
	if (_pressedSlot isEqualTo widgetNull) exitWith {
		if (call inventoryIsInsideSelfWidget) exitWith {
			//self main action
			rpcSendToServer("onMainAction",[player arg getObjReferenceWithMob(player)]);
		};

		invlog("Inventory::onMainAction - press non item. Probably world press",0);

		if (interactMenu_isLoadedMenu) exitWith {}; //cant interact
		if (interactCombat_isLoadedMenu) exitWith {};
		if (interactEmote_isLoadedMenu) exitWith {};
		if (call inventoryIsInContainerWidgetsZone) exitWith {};

		[true,INTERACT_RPC_MAIN] call interact_sendAction;
		/*(objnull call interact_getMouseIntersectData) params ["_obj","_pos"];
		if isNullReference(_obj) exitWith {};
		if !([_obj,_pos] call interact_canInteractWithObject) exitWith {};
		if (_obj call noe_client_isNGO) then {_obj = _obj call noe_client_getNGOSource};
		rpcSendToServer("onMainAction",[player arg getObjReferenceWithMob(_obj)]);*/
	};
	private _data = getSlotDataById(getSlotId(_pressedSlot));

	if (_data isEqualTo []) exitWith {
		invlog("Inventory::onMainAction - data is empty",0);
	};

	private _hash = _data select SD_POINTER;

	rpcSendToServer("onMainAction",[player arg _hash]);
};

decl(void())
inventory_onExtraAction = {

	/*if (inventory_protectExtraAction) exitWith {};

	private _wid = call inventoryGetWidgetOnMouse;

	if (_wid isEqualTo widgetNull) exitWith {};

	private _data = getSlotDataById(getSlotId(_wid));

	if (_data isEqualTo []) exitWith {
		invlog("Inventory::onExtraAction - data is empty",0);
	};

	private _hash = _data select SD_POINTER;

	inventory_protectExtraAction = true;

	rpcSendToServer("onExtraAction",[player arg _hash]);

	invokeAfterDelay({inventory_protectExtraAction = false;},TIME_TO_RELOAD_EXTRAACTION);*/
	if (isInsideVerbMenu_inv) exitWith {};

	private _pressedSlot = call inventoryGetWidgetOnMouse;
	if (_pressedSlot isEqualTo widgetNull) exitWith {
		if (call inventoryIsInsideSelfWidget) exitWith {
			//self main action
			//экстра действия по себе пока отключены
			//rpcSendToServer("onExtraAction",[player arg getObjReferenceWithMob(player)]);
		};

		invlog("Inventory::onExtraAction - press non item. Probably world press",0);

		if (interactMenu_isLoadedMenu) exitWith {}; //cant interact
		if (interactCombat_isLoadedMenu) exitWith {};
		if (interactEmote_isLoadedMenu) exitWith {};
		if (call inventoryIsInContainerWidgetsZone) exitWith {};


		/*(objnull call interact_getMouseIntersectData) params ["_obj","_pos"];
		if isNullReference(_obj) exitWith {};
		if !([_obj,_pos] call interact_canInteractWithObject) exitWith {};
		if (_obj call noe_client_isNGO) then {_obj = _obj call noe_client_getNGOSource};
		rpcSendToServer("onExtraAction",[player arg getObjReferenceWithMob(_obj)]);*/
		//отправка экстра действия по позиции мыши
		[true,INTERACT_RPC_EXTRA] call interact_sendAction;
	};
	private _data = getSlotDataById(getSlotId(_pressedSlot));

	if (_data isEqualTo []) exitWith {
		invlog("Inventory::onExtraAction - data is empty",0);
	};

	private _hash = _data select SD_POINTER;
	//экстра действия по предметам инвентаря пока отключены
	//rpcSendToServer("onExtraAction",[player arg _hash]);
};

decl(void())
inventory_onClick = {
	if (isInsideVerbMenu_inv) exitWith {};

	private _wid = call inventoryGetWidgetOnMouse;
	if (_wid isEqualTo widgetNull) exitWith {};
	private _data = getSlotDataById(getSlotId(_wid));

	if (_data isEqualTo []) exitWith {
		invlog("Inventory::onClick - data is empty",0);
	};

	private _hash = _data select SD_POINTER;
	rpcSendToServer("onClickTarget",[player arg _hash]);
};

//Логика альтклика перенесена на функционал verb-system
/*inventory_onAltClick = {
	if (isInsideVerbMenu_inv) exitWith {};

	//inventory_protectAltClick
	if (inventory_protectAltClick) exitWith {};

	private _wid = call inventoryGetWidgetOnMouse;

	if (_wid isEqualTo widgetNull) exitWith {};

	private _data = getSlotDataById(getSlotId(_wid));

	if (_data isEqualTo []) exitWith {
		invlog("Inventory::onAltClick - data is empty",0);
	};

	private _hash = _data select SD_POINTER;

	inventory_protectAltClick = true;

	rpcSendToServer("onAltClickTarget",[player arg _hash]);

	invokeAfterDelay({inventory_protectAltClick = false;},TIME_TO_RELOAD_ALTCLICKACTION);
};*/

decl(void())
inventory_onExamine = {
	if (isInsideVerbMenu_inv) exitWith {};
	if (["examine"] call input_spamProtect) exitWith {};

	//getting slot
	private _wid = call inventoryGetWidgetOnMouse;

	if not_equals(_wid,widgetNull) then {
		private _data = getSlotDataById(getSlotId(_wid));

		if (_data isEqualTo []) exitWith {
			invlog("Inventory::onExamine - data is empty",0);
		};


		private _hash = _data select SD_POINTER;

		rpcSendToServer("examine",[player arg _hash]);
	} else {
		_wid = call inventoryGetContainerWidgetOnMouse;
		//мы можем смотреть описание предмета в контейнере только если не драгаем что-то (!isDragProcess)
		if (not_equals(_wid,widgetNull) && !isDragProcess) exitWith {
			private _data = getSlotId(_wid) call inventory_getContainerSlotDataById;
			if (count _data < (SD_POINTER+1)) exitWith {
				invlog("Inventory::onExamine - container pointer error %1",_data);
			};

			private _hash = _data select SD_POINTER;

			rpcSendToServer("examine",[player arg _hash]);
		};
		if (call inventoryIsInsideSelfWidget) exitWith {
			rpcSendToServer("examine",[player arg getObjReferenceWithMob(player)]);
		};

		invlog("Inventory::onExamine - world examine attempt press",0);

		if (interactMenu_isLoadedMenu) exitWith {}; //cant interact
		if (interactCombat_isLoadedMenu) exitWith {};
		if (interactEmote_isLoadedMenu) exitWith {};
		if (call inventoryIsInContainerWidgetsZone) exitWith {};

		(objnull call interact_getMouseIntersectData) params ["_obj","_pos"];
		private _probOnScr = [true,false] call interact_getOnSceenCapturedObject;
		if !isNullVar(_probOnScr) then {
			_obj = _probOnScr;
			_posAtl = getposatl _obj;
		};
		if isNullReference(_obj) exitWith {};
		//fix after Legacy 0.5.146:
		//На данный момент обычный осмотр доступен на неограниченной дистанции..
		//if !([_obj,_pos] call interact_canInteractWithObject) exitWith {};
		if (_obj call noe_client_isNGO) then {_obj = _obj call noe_client_getNGOSource};
		rpcSendToServer("examine",[player arg getObjReferenceWithMob(_obj)]);
	};


};

//Смена активной руки
decl(void())
inventory_changeActiveHand = {
	#ifdef SP_MODE
		sp_checkInput("change_active_hand",[]);
	#endif

	if (verb_isMenuLoaded) then {
		call verb_unloadMenu;
	} else {
		if (isOpenedVerbMenu) then {
			call inventory_unloadVerbMenu;
		};
	};

	rpcSendToServer("onUpdateActiveHand",[player]);
};

decl(void())
inventory_changeTwoHandsMode = {
	#ifdef SP_MODE
		sp_checkInput("change_two_hands",[]);
	#endif

	if (["switch2hands",0.7] call input_spamProtect) exitWith {};
	rpcSendToServer("switchTwoHands",[player]);
};

decl(void(any;any;bool))
inventory_onChangeActiveHand = {
	params ["_notAct","_act",["_setToNew",false]];

	if (isNullVar(_notAct) || {equals(_notAct,_act)}) then { // prob fix if equal params input or client repl. error
		_notAct = if (_act == INV_HAND_R) then {INV_HAND_L} else {INV_HAND_R};
	};
	
	if not_equals(_notAct,_act) then {
		getSlotBackground(_notAct call inventoryGetWidgetById) setBackgroundColor BACKGROUND_COLOR;
	
		getSlotBackground(_act call inventoryGetWidgetById) setBackgroundColor BACKGROUND_COLOR_ACTIVEHAND;
		
		if (_setToNew) then {cd_activeHand = _act};
	};
	
	//on change hand restore hide
	[false] call inventory_restoreHide;
};

/*
==============================================================================
					REGION: COMMON FUNCTIONS
==============================================================================
*/

decl(bool())
inventory_isEmptyHands = {
	(inventory_slotdata select INV_HAND_L) isEqualTo [] && (inventory_slotdata select INV_HAND_R) isEqualTo []
};

decl(bool())
inventory_isEmptyActiveHand = {(inventory_slotdata select cd_activeHand) isEqualTo []};

decl(string(int))
inventory_getModelById = {
	inventory_slotdata select (_this) select SD_MODEL
};

decl(any[](int))
inventory_getSlotDataById = {
	inventory_slotdata select (_this)
};

decl(any[](int))
inventory_getContainerSlotDataById = {
	inventory_containerData select (_this)
};
