// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\..\host\keyboard.hpp>
#include <..\InputSystem\inputKeyHandlers.hpp>
#include <..\WidgetSystem\widgets.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\Interactions\interact.hpp>
#include <..\Inventory\inventory.hpp>



nd_map_displays = createHashMap;
//filling hashmap in this file
#include "Displays\Displays.loader"

if !isNullVar(_IINTERNALCOMPILER) exitWith {};

nd_handleUpdate = -1;

nd_list_widgets = [[],[]]; //список виджетов с данными. В левом стеке неочищаемые данные до закрытия окна, в правом обновляемый список
nd_sourceObject = objNUll;
nd_interactionDistance = 0;
nd_isOpenDisplay = false;
nd_openedDisplayType = "";
nd_sourceRef = "";
nd_checkedPos = vec3(0,0,0);

//variables for lobby
nd_lobby_isOpen = false;

nd_internal_attemptLoad = 0;

#ifdef DEBUG
	nd_createTestDisplay = {
		params ["_class","_data"];
		_IINTERNALCOMPILER = true;
		call compile preprocessFileLineNumbers "src\client\NetDisplays\NetDisplays.sqf";
		private _code = nd_map_displays get _class;
		if isNullVar(_code) exitWith {
			errorformat("NetDisplay::createTestDisplay() - cant find display by type %1",_class);
		};
		
		private _d = call dynamicDisplayOpen;
		_d displayRemoveAllEventHandlers "KeyDown";
		_d displayRemoveAllEventHandlers "KeyUp";
		_d setvariable ['isdebugdisplay',true];
	
		[_data,true] call _code;
	};	
#endif

nd_loadDisplay = {
	params ["_type",["_data",[]],"_srcRef","_interactDistance"];
	
	if (nd_isOpenDisplay) exitWith {
		trace("NetDisplay::loadDisplay() - next frame reload display")
		call nd_unloadDisplay;
		nextFrameParams(nd_loadDisplay,_this);
	};
	
	FHEADER;
	
	if (isDisplayOpen) exitWith {
		trace("NetDisplay::loadDisplay() - display opened")
		if (isInventoryOpen) exitWith {
			trace("NetDisplay::loadDisplay() - inventory opened")
			if (!inventory_supressInventoryOpen) then {
				if (inventory_isOpenContainer) then {
					call inventory_closeContainer;
				};
				call inventory_resetPositionHandWidgets;call closeInventory_handle;
				trace("NetDisplay::loadDisplay() - 	not opened inventory in supress mode")
				nextFrameParams(nd_loadDisplay,_this);
			} else {
				//fix 0.6.190 - supressed inventory
				inventory_supressInventoryOpen = false;
				call inventory_resetPositionHandWidgets;call closeInventory_handle;
				call verb_resetDataForND;
				trace("NetDisplay::loadDisplay() - 	opened inventory in supress mode")
				nextFrameParams(nd_loadDisplay,_this);
				//				TIME_PREPARE_SLOTS----\/
				//invokeAfterDelayParams(nd_loadDisplay,0.5,_this);
			};
		};
		if (chat_isHistoryOpen) exitwith {
			chat_isHistoryOpen = false;
			call displayClose;
			nextFrameParams(nd_loadDisplay,_this);
		};
		_d = getDisplay;
		if (_d getVariable ["cd_sendCommand_isEnabled",false]) exitWith {
			trace("NetDisplay::loadDisplay() - send command flag enabled")
			invokeAfterDelayParams(nd_loadDisplay,0.08,_this);
		};
		errorformat("NetDisplay::loadDisplay() - not handled statement: %1 %2; Attempt reload disp",nd_isOpenDisplay arg _type);
		INC(nd_internal_attemptLoad);
		if (nd_internal_attemptLoad >= 10) exitwith {
			errorformat("NetDisplay::loadDisplay() - cant load display %1",_type)
		};
		nextFrameParams(nd_loadDisplay,_this);
	};	

	nd_internal_attemptLoad = 0; //free attempt loader

	private _code = nd_map_displays get _type;
	if isNullVar(_code) exitWith {
		errorformat("NetDisplay::loadDisplay() - cant find display by type %1",_type);
		call nd_onClose;
	};

	nd_isOpenDisplay = true;
	
	if equalTypes(_srcRef,[]) then {
		//for internal
		_srcRef params ["_ref","_objCheck"];

		nd_sourceObject = _objCheck;
		nd_sourceRef = _ref;
		nd_interactionDistance = _interactDistance;
		nd_openedDisplayType = _type;
		//find nearest intersection point
		nd_checkedPos = [nd_sourceObject] call interact_getNearPointForObject;
		
		private _onUpdCode = if not_equals(player,nd_sourceObject) then {
			{
				if (isNullReference(nd_sourceObject) ||
					getCenterMobPos(player) distance nd_checkedPos > nd_interactionDistance) then {
						call nd_onClose;
					}
			}
		} else {
			{
				if (isNullReference(nd_sourceObject)) then {call nd_onClose}
			}
		};
		nd_handleUpdate = startUpdate(_onUpdCode,0.05);
	} else {
		//for objects
		if equalTypes(_srcRef,"") then {
			nd_sourceObject = noe_client_allPointers getOrDefault [_srcRef,objNull];
		} else {
			nd_sourceObject = ifcheck(equalTypes(_srcRef,objnull),_srcRef,objnull);
		};
		nd_sourceRef = _srcRef; // used in nd::onClose
		if isNullReference(nd_sourceObject) exitWith {
			errorformat("NetDisplay::loadDisplay() - cant find source pointer %1",criptPtr(_srcRef));
			call nd_onClose;
		};	
		nd_interactionDistance = _interactDistance;
		nd_openedDisplayType = _type;
		
		
		//find nearest intersection point
		nd_checkedPos = [nd_sourceObject] call interact_getNearPointForObject;
		
		private _onUpdCode = {
			// FIXME 0.5.132: may throws closing display by distance (too much for ElectricalShield for std dist INTERACTION_DISTANCE)
			if (isNullReference(nd_sourceObject) ||
				getCenterMobPos(player) distance nd_checkedPos > nd_interactionDistance) then {
					call nd_onClose;
				}
		};
		nd_handleUpdate = startUpdate(_onUpdCode,0.05);
	};


	private _d = call dynamicDisplayOpen;
	
	//adding common inputs
	_d displayAddEventHandler ["KeyUp",{
		params ["_d","_key"];

		doPrepareKeyData(_this);
		
		if (ctrlType(focusedCtrl _d) == 2) exitWith {};
		
		//сброс и смена активной руки
		if isPressed(input_act_dropitem) exitWith {
			[] call inventory_onDropItem;
		};
		if isPressed(input_act_putdownitem) exitWith {
			[null,true] call inventory_onPutDownItem;
		};
		if isPressed(input_act_changeActHand) exitWith {
			call inventory_changeActiveHand;
		};
		if isPressed(input_act_switchTwoHands) exitWith {call inventory_changeTwoHandsMode};
		if isPressed(input_act_combatMode) exitWith {
			if (call smd_isStunned) exitWith {};
			if (call input_passThroughWallsProtect) exitWith {};
			[!([player] call smd_isCombatModeEnabled)] call interact_setCombatMode;
		};
	}];

	[_data,true] call _code;

}; rpcAdd("opnND",nd_loadDisplay);

nd_loadDisplay_lobby = {
	params ["_type",["_data",[]]];
	if (!isLobbyOpen) exitWith {
		errorformat("Cant open net display %1 - lobby not opened",_type);
	};
	
	private _d = getDisplay;
	if !isNull(_d getvariable "__lobby_hints_loadingProgress") exitWith {
		invokeAfterDelayParams(nd_loadDisplay_lobby,0.1,_this);
	};

	//Закрываем предыдущий
	if (nd_lobby_isOpen) then {
		call nd_closeND_lobby;
	};
	
	private _code = nd_map_displays get _type;
	if isNullVar(_code) exitWith {
		errorformat("NetDisplay::loadDisplay() - cant find display by type %1",_type);
		call nd_onClose;
	};
	
	if (!lobby_sys_isActive) then {
		[false] call lobby_sysSetEnable;
	};
	
	nd_lobby_isOpen = true;
	nd_openedDisplayType = _type;
	[true] call lobby_sysSetEnable;
	private _d = getDisplay;
	[_data,true] call _code;
	
}; rpcAdd("opnNDLobby",nd_loadDisplay_lobby);

nd_closeND_lobby = {
	params [["_isRpc",false]];
	[false] call lobby_sysSetEnable;
	{
		if !isNullReference(_x) then {ctrlDelete _x};
	} foreach (nd_list_widgets select 0);
	call nd_closeND_lobbyImpl;
	if (!_isRpc) then {
		rpcSendToServer("onClosedNDLobby",[clientOwner]);
	};
}; rpcAdd("clsNDLobby",nd_closeND_lobby);

nd_closeND_lobbyImpl = {
	nd_lobby_isOpen = false;
	nd_openedDisplayType = "";
	nd_list_widgets = [[],[]];
};

//отсылает тип ввода пользователем. можно отправлять данные. Вся логика обработки на сервере в onHandleNDInput
nd_onPressButton = {
	params ["_data"];
#ifdef DEBUG
	if (getDisplay getvariable ["isdebugdisplay",false]) exitWith {warningformat("ND::INPUT - SEND DATA IN DEBUG TRACE PREP %1",vec3(player,nd_sourceRef,_data))};
#endif
	if (nd_lobby_isOpen) then {
		nextFrameParams({rpcSendToServer("onHandleMBInput",vec2(clientOwner,_this))},_data);
	} else {
		nextFrameParams({rpcSendToServer("ndInput",vec3(player,nd_sourceRef,_this))},_data);
	};
};

// очистка списка виджетов для полной перегрузки визуала
nd_cleanupData = {
	{
		[_x] call deleteWidget;
	} foreach (nd_list_widgets select 1);

	nd_list_widgets set [1,[]];
};

nd_regWidget = {
	params ["_type","_vecpos","_probCtg","_dataType"];
	regNDWidget(_type,_vecpos,_probCtg,_dataType);
	lastNDWidget
};

nd_addClosingButton = {
	params ["_display","_vec4Pos",["_ctg",widgetNull],["_registerAsReloaded",false]]; // _registerAsReloaded означает что виджет регистрируется в буфере который чистится при обновлении
	private _buttonClose = [_display,BUTTON,_vec4Pos,_ctg] call createWidget;
	_buttonClose ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b","_mouse"];
		nextFrame(ifcheck(nd_lobby_isOpen,nd_closeND_lobby,nd_onClose));
	}];
	if (_registerAsReloaded) then {
		if !(_buttonClose in (nd_list_widgets select 1)) then {
			(nd_list_widgets select 1) pushBack _buttonClose;
		};
	};

	_buttonClose
};

nd_onUpdate = {
	_d = getDisplay;
	[_this,false] call (nd_map_displays get nd_openedDisplayType)
}; rpcAdd("updND",nd_onUpdate);


nd_onClose = {
#ifdef DEBUG
	if (getDisplay getvariable ["isdebugdisplay",false]) exitWith {call nd_unloadDisplay};
#endif
	
	rpcSendToServer("closeNetDisplay",vec2(player,nd_sourceRef));
	call nd_unloadDisplay;
};


nd_unloadDisplay = {
	if (!nd_isOpenDisplay) exitWith {};
	if (nd_handleUpdate > -1) then {stopUpdate(nd_handleUpdate)};
	nd_handleUpdate = -1;

	call displayClose;

	nd_sourceObject = objNUll;
	nd_isOpenDisplay = false;
	nd_interactionDistance = 0;
	nd_openedDisplayType = "";
	nd_sourceRef = "";
	nd_list_widgets = [[],[]];
}; rpcAdd("clsND",nd_unloadDisplay);


//стандартный алгоритм
nd_stdLoad = {
	params [["_sx",50],["_sy",50],["_btName","Закрыть"]];
	if (isFirstLoad) then {
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);
		
		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.5];
		
		if (equalTypes(_btName,true) && {equals(_btName,false)}) then {
			_ctg
		} else {
			_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText _btName;
			
			_ctg = [thisDisplay,WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
			addSavedWdiget(_ctg);
			
			_ctg
		};
		
	} else {
		private __svcnt = count getSavedWidgets;
		if (__svcnt == 0) exitWith {widgetNull};
		getSavedWidgets select (__svcnt - 1);
	};
};