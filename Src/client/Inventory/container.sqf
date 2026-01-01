// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "..\ClientRpc\clientRpc.hpp"
#include "inventory.hpp"
#include "helpers.hpp"
#include "..\Interactions\interact.hpp"

namespace(Inventory,inventory_)

macro_const(inventory_widgetContainerSizeW)
#define CONTAINER_SIZE_W 3
macro_const(inventory_widgetContainerSizeH)
#define CONTAINER_SIZE_Y
macro_const(inventory_widgetContainerSizeButton)
#define SIZE_BUTTON 3

macro_const(inventory_timeContainerOnLoad)
#define TIME_CONTAINER_ONLOAD 0.25
//из TIME_PREPARE_SLOTS
macro_const(inventory_timeContainerOnUnload)
#define TIME_CONTAINER_ONUNLOAD 0.09

decl(void())
inventory_openContainer = {
	if (!isInventoryOpen) exitWith {};

	inventory_invWidgetSize params ["_leftX","_leftY","_rigthX","_rigthY"];

	private _d = getDisplay;

	private _w = abs (_leftX - _rigthX);
	private _h = abs (_leftY - _rigthY);
	
	// fix for 4:3 screensize (after 0.8.239)
	private _xContPos = _leftX - (_w * CONTAINER_SIZE_W);
	private _isProblemScreenSize = false;
	private _biasXContPos = if (_xContPos < 0) then {
		_isProblemScreenSize = true;
		_leftX
	} else {
		_w * CONTAINER_SIZE_W
	};
	private _ctgRealPos = [(_xContPos) max 0,_leftY,_biasXContPos,_h];

	private _ctg = [_d,WIDGETGROUP,_ctgRealPos] call createWidget;
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [1,1,1,0.2];
	private _ctgScrolling = [_d,WIDGETGROUP_H,[1.5,2.5,100 - 1.5,100 - 2.5],_ctg] call createWidget;

	private _textRealPos = [_leftX - (_w * CONTAINER_SIZE_W),_leftY - SIZE_BUTTON,_w * CONTAINER_SIZE_W,SIZE_BUTTON];
	
	// fix for 4:3 screensize (after 0.8.239)
	if (_isProblemScreenSize) then {
		_textRealPos set [0,_ctgRealPos select 0];
		_textRealPos set [2,_ctgRealPos select 2];
	};
	
	private _text = [_d,TEXT,_textRealPos] call createWidget;
	_text setBackgroundColor [0,0.02,0,0.8];

	private _containerName = inventory_containerCommonData select 0;

	[_text,format["<t align='center' valign='middle'>%1</t>",_containerName]] call widgetSetText;

	inventory_contWidgetSize = [
		_leftX - (_w * CONTAINER_SIZE_W),
		_leftY - SIZE_BUTTON,
		_leftX - (_w * CONTAINER_SIZE_W) + (_w * CONTAINER_SIZE_W) ,
		_leftY - SIZE_BUTTON + SIZE_BUTTON + _h];

	inventory_containerWidgets = [_ctg,_ctgScrolling,_text];

	//creating icons
	call inventory_loadContainerSlots;

	//positions saving
	
	_ctg setvariable ['realPos',_ctgRealPos];
	_ctg setVariable ['textwidget',_text];
	private _ctgNotReadyPos = [_leftX - (_w * CONTAINER_SIZE_W) + (_w * CONTAINER_SIZE_W),_leftY,0,_h];
	_ctg setFade 1;
	[_ctg,_ctgNotReadyPos] call widgetSetPosition;
	_ctg setVariable ["notreadypos",_ctgNotReadyPos];

	_text setVariable ['realPos',_textRealPos];
	private _textNotReadyPos = +_textRealPos;
	MODARR(_textNotReadyPos,0,+ (_w * CONTAINER_SIZE_W));
	_textNotReadyPos set [2,0];
	_text setFade 1;
	[_text,_textNotReadyPos] call widgetSetPosition;
	_text setVariable ["notreadypos",_textNotReadyPos];

	//added close event for text
	_text ctrlAddEventHandler ["MouseButtonUp",{
		params ["_text","_key"];
		if (_key != MOUSE_LEFT) exitWith {};

		_text ctrlEnable false;
		getContainerMainCtg ctrlEnable false;

		nextFrame(inventory_closeContainer);
	}];

	true call inventory_onPrepareContainer;

	inventory_isOpenContainer = true;
};

decl(widget[](display;string|int;vector4;int;widget))
createWidget_contSlot = {
	params ["_display","_slotName","_pos","_slotId","_ctgScr"];

	private _offsetW = transformSizeByAR(SIZE_INVSLOT);

	//private _isDragger = if (_slotName isequalto INDEX_DRAGGER) then {true} else {false};


	private _ctg = [_display,WIDGETGROUP,_pos,_ctgScr] call createWidget;
	private _background = [_display,BACKGROUND,[0,0,100,100],_ctg] call createWidget;

	_background setBackgroundColor BACKGROUND_COLOR;

	private _pic = [_display,PICTURE,[0,0,100,100],_ctg] call createWidget;

	_ctg setvariable ['background',_background];
	_ctg setVariable ["icon",_pic];
	_ctg setVariable ["slotid",_slotId];
	_ctg setvariable ["isContainerSlot",true];

	inventory_containerSlots pushBack _ctg;
	/*if (!_isDragger) then {

		if (isEmptySlot(_slotId)) then {
			[_pic,_slotId call inventoryGetPictureById] call widgetSetPicture;
		} else {
			[_pic,getSlotDataById(_slotId) select SD_ICON] call widgetSetPicture;
		};


		//common vars
		_ctg setvariable ["slotname",_slotname];
		_ctg setVariable ["slotid",_slotId];

		//post save
		inventor_slot_widgets set [_slotId,_ctg];

	};*/

	_ctg
};

decl(void())
inventory_loadContainerSlots = {

	private _ctgScrolling = getContainerSlotsCtg;
	private _d = getDisplay;
	
	// Если в момент обновления драгали контейнерный слот то отменяем процесс
	if (isDragProcess) then {
		private _pressed = getPressedSlot;
		if isContainerSlot(_pressed) then {
			// сброс таскания
			inventory_pressedwidget set [PRESSED_LINK,widgetNull];
			getDragSlot setFade 1;
			getDragSlot commit TIME_PREPARE_DRAG;
		
			isInsidePressedSlot = false;
		};
	};
	
	//Если уже был открыт перегружаем содержимое
	{
		ctrlDelete _x;
	} foreach (inventory_containerSlots+inventory_freeSpaceSlots);
	inventory_freeSpaceSlots = [];
	inventory_containerSlots = [];// сброс

	//Переустанавливаем текст (имя) контейнера
	private _containerName = inventory_containerCommonData select container_index_name;
	[getContainerNameText,format["<t align='center' valign='middle'>%1</t>",_containerName]] call widgetSetText;

	//столбец col, ряд row

	private _colCount = 0;
	private _curRow = 0;

	private _ctgSizeW = _w * CONTAINER_SIZE_W;
	private _ctgSizeH = _h;
	//logformat(" CONTAINER:: %1",[_ctgSizeW arg _ctgSizeH]);
	private _sizeH = 100 / 3 * 0.9;
	private _sizeW = 100 / 9 * 0.9;
	//logformat(" SIZES:: %1",[_sizeW arg _sizeH]);

	private _curData = "";
	
	private _freeSpace = inventory_containerData deleteAt 0; //first always freespace
	
	private _maxIndexSlot = (count inventory_containerData) - 1;

	for "_i" from 0 to _maxIndexSlot do {

		_curData = inventory_containerData select _i;

		_slot = [_d,INDEX_DRAGGER,[
			_sizeW * _colCount + (_sizeW / 8 * _colCount),//_sizeW * _colCount, //x
			_sizeH * _curRow + (_sizeH / 8 * _curRow),//_sizeH * _curRow, //y
			_sizeW,
			_sizeH
			],_i,_ctgScrolling] call createWidget_contSlot;

		//realocate picutre path
		private _icn = _curData select SD_ICON;
		if (!(".paa" in _icn)) then {
			_curData set [SD_ICON,PATH_PICTURE_INV(_curData select SD_ICON)];
		};

		(_slot getvariable 'icon') ctrlSetText (_curData select SD_ICON);
		(_slot getvariable 'icon') ctrlSetTooltip (_curData select SD_NAME);

		if (_colCount == 7) then {
			INC(_curRow);
			_colCount = 0;
		} else {
			INC(_colCount);
		};

	};
	
	
	for "_i" from 1 to _freeSpace do {
		_slot = [_d,BACKGROUND,[
		_sizeW * _colCount + (_sizeW / 8 * _colCount),//_sizeW * _colCount, //x
		_sizeH * _curRow + (_sizeH / 8 * _curRow),//_sizeH * _curRow, //y
		_sizeW,
		_sizeH
		],_ctgScrolling] call createWidget;
		_slot setBackgroundColor BACKGROUND_COLOR_NOITEM;
		inventory_freeSpaceSlots pushBack _slot;
		
		if (_colCount == 7) then {
			INC(_curRow);
			_colCount = 0;
		} else {
			INC(_colCount);
		};
	};
};

decl(void())
inventory_onPrepareContainer = {

	private _ctg = getContainerMainCtg;
	private _text = _ctg getvariable 'textwidget';

	if (_this) then {
		_ctg setFade 0;
		[_ctg,_ctg getVariable 'realPos',TIME_CONTAINER_ONLOAD] call widgetSetPosition;

		_text setFade 0;
		[_text,_text getVariable 'realpos',TIME_CONTAINER_ONLOAD] call widgetSetPosition;
	} else {
		_ctg setFade 1;
		[_ctg,_ctg getVariable 'notreadypos',TIME_CONTAINER_ONUNLOAD] call widgetSetPosition;

		_text setFade 1;
		[_text,_text getVariable 'notreadypos',TIME_CONTAINER_ONUNLOAD] call widgetSetPosition;
	};

};

decl(void())
inventory_closeContainer = {

	rpcSendToServer("onContainerClose",[player arg getContainerRef]);

	call inventory_unloadContainerMenu;

	//reset common container vars
	inventory_containerCommonData = nullContainerCommonData;
	inventory_containerData = [];// check SD_<var>
	inventory_containerSlots = [];//список виджетов иконок внутри контейнера
	inventory_contWidgetSize = [0,0,0,0];
};

decl(void())
inventory_onChangeLocContainer = {
	if (isInventoryOpen) then {
		if (inventory_isOpenContainer) then {
			call inventory_unloadContainerMenu;
		};
	};

	inventory_containerCommonData = nullContainerCommonData;
	inventory_containerData = [];// check SD_<var>
	inventory_containerSlots = [];//список виджетов иконок внутри контейнера
	inventory_contWidgetSize = [0,0,0,0];
};

decl(void())
inventory_unloadContainerMenu = {
	false call inventory_onPrepareContainer;

	_postcallCode = {
		inventory_isOpenContainer = false;

		if (isDragProcess) then {
			getDragSlot setFade 1;
			getDragSlot commit TIME_PREPARE_DRAG;
		};

		private _ctg = getContainerMainCtg;
		if (_ctg isEqualTo widgetNull) exitWith {};
		private _text = _ctg getVariable 'textwidget';
		[_ctg] call deleteWidget;
		if (_text isEqualTo widgetNull) exitWith {};
		[_text] call deleteWidget;

	};

	invokeAfterDelay(_postcallCode,TIME_CONTAINER_ONUNLOAD + 0.01);
};

// Открывает контейнер и загружает данные
decl(void(...any[]))
inventory_onContainerOpen = {
	private _prms = _this;
	params ["_main","_data"];

	FHEADER;

	if (nd_isOpenDisplay) exitWith {
		call nd_onClose;
		nextFrameParams(inventory_onContainerOpen,_prms);
	};	

	//Предварительный диспос контейнера. Вторая проверка сравнивает полученную ссылку с существующей
	if (inventory_isOpenContainer && {!((_main select container_index_ref) isEqualTo getContainerRef)}) then {
		traceformat("inventory::onContainerOpen() - reload container: %1 %2",_main select container_index_ref arg getContainerRef)
		rpcSendToServer("onContainerClose",[player arg getContainerRef]);
	};
	
	//realloc visobj ptr
	// if pointer nonexisten on local client and need generate visual reference -> throw error
	//if (equals(_main select container_index_object,container_object_awaitGenerateValue)) then {
		//container in world
		if (_main select container_index_isInWorld) then {
			if (!array_exists(noe_client_allPointers,_main select container_index_ref)) exitWith {
				errorformat("inventory::onContainerOpen() - Cant find pointer %1",criptPtr(_main select container_index_ref));
				RETURN(false);
			};
			_main set [container_index_object,noe_client_allPointers get (_main select container_index_ref)];
		} else {
			//container in inventory
		};
		
	//} else {
		//warningformat("inventory::onContainerOpen() - Object already initialized as %1",tolower typeName (_main select container_index_object));
	//};

	inventory_containerCommonData = _main;
	inventory_containerData = _data;
	
	if isWorldContainer then {
		_main set [container_index_posoffset,((getWorldContainer worldToModelVisual (call interact_getCursorIntersectPos)))];
	} else {
		_main set [container_index_posoffset,[0,0,0]];
	};
	
	//NOT NEED
	/*if (interact_isOpenMousemode) then {
		call interact_closeMouseMode;
	};*/
	
	
	_nextFrame = {
		FHEADER;
		if (!isInventoryOpen) then {
			call openInventory;
		} else {
			//fix 0.7.378 - cant open container on mainaction as activated verb in world
			if (inventory_supressInventoryOpen) then {
				nextFrameParams(_this,_this);
				RETURN(0);
			};
		};
		if (inventory_isOpenContainer) then {
			call inventory_loadContainerSlots;
		} else {
			call inventory_openContainer;
		};
	};

	nextFrameParams(_nextFrame,_nextFrame);
};

decl(void(...any[]))
inventory_onContainerContentUpdate = {
	private _data = _this;

	// Если контейнер уже закрыт (общая дата очищена то обновление или открытие не требуется) - возможно пришёл устаревший пакет
	if equals(inventory_containerCommonData,nullContainerCommonData) exitWith {
		warning("inventory::onContainerContentUpdate - Obsolete info getting. Container already closed on client");
	};
	// fix singleplayer debug mode - nextframe bug
	//inventory_containerData = _data;
	
	/*if (interact_isOpenMousemode) then {
		call interact_closeMouseMode;
	};*/
	_nextFrame = {
		//for synced work. updated after 0.5.158
		inventory_containerData = _this;
		
		//Вот это условие не должно отрабатывать.
		if (!isInventoryOpen) then {
			//todo если будет вызвано данное предупреждение хоть раз - убрать открытие инвентаря из этого условия
			warning("inventory::onContainerContentUpdate() - critical case of updating with closed inventory");
			call openInventory;
		};
		
		if (inventory_isOpenContainer) then {
			call inventory_loadContainerSlots;
		} else {
			call inventory_openContainer;
		};
	};
	
	nextFrameParams(_nextFrame,_data); //Засчёт передачи данных через параметры мы не пропустим подмену данных в соседнем кадре.
};

//цикл в маин треде
decl(void())
inventory_onUpdateContainer = {

	if (isWorldContainer) then {
		private _worldObj = getWorldContainer;
		if (_worldObj isEqualTo objnull) exitWith {
			warning("Inventory::onUpdateContainer - world object is null reference");
		};
		
		//updated alg 0.7.378
		// Поскольку мировые контейнеры больше не открываются с центральной точки
		// экрана а только через верб меню (кстати ранее в интеракте эта проблема
		// тоже бы возникала), то проверки делаются до точки нажатия по вербу
		if !([_worldObj,(_worldObj modelToWorldVisual getContainerPosOffset)] call interact_canInteractWithObject) exitWith {
			invlog("Inventory::onUpdateContainer - cant interact with object >> %1",inventory_containerCommonData)
			call inventory_closeContainer;
		};
		
		//traceformat("DATA CHECK %1",verb_internal_bufferedObjData select 0);
		/*(objnull call interact_getIntersectData) params ["_obj","_pos"];
		if not_equals(_obj,_worldObj) exitWith {
			["Я не смотрю в контейнер...","error"] call chatPrint;
			invlog("Inventory::onUpdateContainer - not equals objects: %1 %2",_worldObj arg _obj)
			call inventory_closeContainer;
		};
		
		if !([_obj,_pos] call interact_canInteractWithObject) exitWith {
			invlog("Inventory::onUpdateContainer - cant interact with object",0)
			call inventory_closeContainer;
		};*/
	};

};

decl(void(widget))
inventory_onPressContainerSlot = {
	private _slotFrom = _this;

	//setPressedSlotPosition(_slotFrom call getMousePositionInWidget); //TODO fixme. returns wrong positions
	setPressedSlotPosition([0 arg 0]);

	inventory_pressedwidget set [PRESSED_LINK,_slotFrom];

	getDragSlot setFade DRAG_FADE_PROCESS;
	getDragSlot commit TIME_PREPARE_DRAG; //Если не нужно мигание при нажатии - поставь тут 0

	private _fromIcon = widgetGetPicture(getSlotIcon(_slotFrom));

	[getSlotIcon(getDragSlot),_fromIcon] call widgetSetPicture;

	isInsidePressedSlot = true;

	getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR; //fix on green after onMainAction

	invlog("Inventory::onPressContainerSlot - start dragging with icon %1. Drag is %2",_fromIcon arg getDragSlot);

	//(getSlotId(_slotFrom) call inventory_getModelById) call inventory_createPreviewObject;
};

decl(void(widget))
inventory_onReleaseSlotFromContainer = {
	private _slotTo = _this;

	private _pressedSlot = getPressedSlot;

	inventory_pressedwidget set [PRESSED_LINK,widgetNull];

	getDragSlot setFade 1;
	getDragSlot commit TIME_PREPARE_DRAG;

	isInsidePressedSlot = false;

	if (_slotTo isEqualTo widgetNull) exitWith {
		invlog("Inventory::onReleaseSlotFromContainer - slot to is null reference",0);
		/*if (isInteractibleAction) then {
			invlog("Inventory::onInteractTargetWith - Interacting on target with <%1> item.",getSlotDataById(getSlotId(_pressedSlot)));

			[getInteractibleTarget,getSlotDataById(getSlotId(_pressedSlot))] call inventory_onInteractTargetWith;
		} else {
			invlog("Inventory::onReleaseSlot - Droping item. Data: <%1>",getSlotDataById(getSlotId(_pressedSlot)));

			[getSlotId(_pressedSlot)] call inventory_onPutDownItem;
		};

		call inventory_deletePreviewObject;*/ //on post putdown
	};

	//call inventory_deletePreviewObject; //при драге с контейнера превью не создаётся

	invlog("Inventory::onReleaseSlotFromContainer - transfer container item from id:%1 to %2",getSlotId(_pressedSlot) arg getSlotName(_slotTo));
	[_pressedSlot,_slotTo] call inventory_onTransferSlotContainer;

};

decl(void(widget;widget))
inventory_onTransferSlotContainer = {
	params ["_containerSlot","_slotTo"];

	private _idFrom = getSlotId(_containerSlot);
	private _IdTo = getSlotId(_slotTo);

	if (!array_exists(INV_LIST_HANDS,_idTo)) exitWith {
		invlog("Inventory::onTransferSlotContainer - Cant transfer from non hand slot %1. Process aborted.",_idTo);

		private _cantrerquip = selectRandom ["%1 можно вытащить только в руки.","%1 надо сначала взять в руки."];
		[format[_cantrerquip,(_idFrom call inventory_getContainerSlotDataById) select SD_NAME],"error"] call chatprint;
	};

	private _hashContainer = getContainerRef;
	private _hashContItem = (_idFrom call inventory_getContainerSlotDataById) select SD_POINTER;

	rpcSendToServer("onRemoveItemFromContainer",[player arg _hashContainer arg _hashContItem arg _idTo]);
};

decl(void())
inventory_onReleaseSlotToContainer = {
	private _pressedSlot = getPressedSlot;

	inventory_pressedwidget set [PRESSED_LINK,widgetNull];

	getDragSlot setFade 1;
	getDragSlot commit TIME_PREPARE_DRAG;

	isInsidePressedSlot = false;

	private _targHash = getContainerRef;
	private _withHash = (getSlotId(_pressedSlot) call inventory_getSlotDataById) select SD_POINTER;

	rpcSendToServer("onInteractInventoryWith",[player arg _withHash arg _targHash]);
};
