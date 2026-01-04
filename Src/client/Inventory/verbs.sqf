// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "inventory.hpp"
#include "helpers.hpp"
#include "..\ClientRpc\clientRpc.hpp"

namespace(Inventory,inventory_)

//as TIME_PREPARE_SLOTS
macro_const(inventory_timePrepareVerbMenu)
#define TIME_PREPARE_VERBMENU 0.09

decl(void(int))
inventory_onGetItemVerbs = {
	params ["_slot"];
	
	//if already opened do not action
	if (isOpenedVerbMenu) exitWith {
		invlog("Inventory::onGetItemVerbs - verb menu already opened",0);
	};
	
	private _id = getSlotId(_slot);
	
	inventory_lastPressedSlotId = _id;
	
	rpcSendToServer("getInventoryVerbs",[player arg _id]);
	
	//todo block double press
};

decl(void(string;any[];int;string))
inventory_onLoadVerbsInventory = {
	
	params ["_targetName","_verbList","_slotId","_pointer"];
	
	if (verb_isMenuLoaded) then {
		call verb_unloadMenu;
	};
	
	reverse _verbList; //after 0.8.136
	
	_trVL = [];
	{
		if equalTypes(_x,[]) then {
			_verbList set [_forEachIndex,_x select 0];
			_trVL pushBack ((_x select 1)+([_x select 0]call verb_internal_checkBind));
		} else {
			_trVL pushBack (_x call verb_translate);
		};
	} foreach _verbList;
	
	//-100 специальный флаг для селф вербов
	if equals(_slotId,-100) then {
		_targetName = format["%1",_targetName];
		
		private _ctg = [_trVL,_verbList,_targetName,true] call verb_loadMenu;
	} else {
		_targetName = format["%1: %2",_slotId call inventoryGetSlotNameById,_targetName];
		
		private _ctg = [_trVL,_verbList,_targetName,true] call verb_loadMenu;
		_ctg setvariable ["currentViewSlotId",_slotId];
	};
	
	true call inventory_onPrepareVerbMenu;
	
	inventory_verbItemPointer = _pointer;
	
}; rpcAdd("loadVerbsInventory",inventory_onLoadVerbsInventory);

decl(void())
inventory_onPrepareVerbMenu = {
	
	private _menuWidget = getVerbMenuWidget;
	
	private _newPos = if (_this) then {
		_menuWidget setFade 0;
		_menuWidget getvariable "onCreatePos";
		
	} else {
		_menuWidget ctrlEnable false; //disable menu
		_menuWidget setFade 1;
		_menuWidget getVariable "onDeletePos";
	};
	
	[_menuWidget,_newPos,TIME_PREPARE_VERBMENU] call widgetSetPosition;
};

decl(void(widget))
inventory_onPressVerb = {
	params ["_control"];
	
	_verbId = _control getvariable ["verbId",-1];
	
	call inventory_unloadVerbMenu;
	
	invlog("Inventory::onPressVerb - Pressed on verb %1",_verbId);
	
	if (inventory_verbItemPointer == "") exitWith {
		error("Value in 'Inventory.verbItemPointer' is empty");
	};
	if (_verbId == -1) exitWith {
		error("Inventory::onPressVerb - undefined verb id");
	};	
	
	rpcSendToServer("onActivateInventoryVerb",[player arg inventory_verbItemPointer arg _verbId]);
	
};

decl(void())
inventory_unloadVerbMenu = {
	
	false call inventory_onPrepareVerbMenu;
	
	private _code = {
		if (isOpenedVerbMenu) then {
			getVerbMenuWidget call deleteWidget;
			inventory_verbItemPointer = "";
		};
	};
	
	invokeAfterDelay(_code,TIME_PREPARE_VERBMENU + 0.01);
};