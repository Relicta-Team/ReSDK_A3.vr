// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\ClientRpc\clientRpc.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "..\Inventory\helpers.hpp"

#include "..\..\host\lang.hpp"

namespace(InteractVerbs,verb_;interact_)

macro_const(verb_timeFadeoutVerbMenu)
#define TIME_FADEOUT_VERBMENU 0.15
macro_const(verb_timeFadeinVerbMenu)
#define TIME_FADEIN_VERBMENU 0.15

decl(void(any;any[];any))
interact_onLoadVerbs = {

	params ["_targetName","_verbList","_targetHash"];
	
	private _targetObject = objNUll;
	private _canExit = false;
	
	//chech and find visual object
	if not_equalTypes(_targetHash,objNull) then {
		_targetObject = noe_client_allPointers get _targetHash;
		if isNullVar(_targetObject) exitWith {
			errorformat("Interact::onLoadVerbs() - Cant load verbs: null pointer - %1",criptPtr(_targetHash));
			_canExit = true;
		};
	} else {
		_targetObject = _targetHash;
	};
	if (_canExit || isNullReference(_targetObject)) exitWith {};
	
	(verb_internal_bufferedObjData select 0) params ["_lastRequestedObject","_mtvBias","_isMob"];
	if not_equals(_lastRequestedObject,_targetObject) exitWith {
		traceformat("prev %1; outputed %2",_lastRequestedObject arg _targetObject)
		warning("interact::loadVerbs() - Last checked object not actual");
	};
	
	if (verb_internal_isAwaitWorldVerb) then {
		verb_internal_isAwaitWorldVerb = false;
		
		inventory_supressInventoryOpen = true; //для подавления инвентаря
		call openInventory;
		//Последняя позиция объекта
		verb_lastCheckedObjectData = verb_internal_bufferedObjData select 0;//[_obj,_obj worldToModel _posAtl,_isMob];
		//Последняя позиция мыши
		verb_lastclickedpos = verb_internal_bufferedObjData select 1;//[50,50];
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

	[_trVL,_verbList,_targetName] call verb_loadMenu;
	
	//deprecated variable
	verb_lastTargetObjectData = [_targetObject,getPosATL _targetObject];

}; rpcAdd("loadVerbs",interact_onLoadVerbs);

//Проверка бинда и возвращение доп постфикса
decl(string(any))
verb_internal_checkBind = {
	params ["_intorstr"];
	if equalTypes(_intorstr,0) then {
		_intorstr = verb_inverted_list get _intorstr
	};
	if (_intorstr == "mainact") then {
		format[" (%1)",["input_act_mainaction"]call input_getKeyNameByInputName];
	} else {
		""
	};
};

decl(string(any))
verb_translate = {
	private _verb = _this;

	private _probClass = verb_inverted_list get _verb;

	if isNullVar(_probClass) exitWith {
		format["!!!Неизвестное действие (%1)!!!",_verb]
	};
	
	((verb_list get _probClass) select 0)+([_probClass] call verb_internal_checkBind);
};

decl(void(any[];any[];any;bool))
verb_loadMenu = {
	params ["_translateList","_verbList","_targetName",["_isInInventory",false]];

	#define SIZE_WIND_W 15
	#define SIZE_WIND_H 30
	#define SIZE_BUTTON 20

	private _d = getDisplay;

	private ["_mX","_mY","_BasicPosInvMode"];

	private _positionCtg = if (!_isInInventory) then {
		verb_lastclickedpos params ["_mX","_mY"];
		[(_mX - SIZE_WIND_W / 2) max 0 min (100 - SIZE_WIND_W),_mY max 0 min (100 - SIZE_WIND_H),SIZE_WIND_W,SIZE_WIND_H]
	} else {
		inventory_invWidgetSize params ["_bl_x","_bl_y","_br_x","_br_y"]; //border left and right
		private _bl_w = abs (_bl_x - _br_x);
		private _bl_h = abs (_bl_y - _br_y);

		_BasicPosInvMode = [(50 - _bl_w / 2),100 - _bl_h - SELF_CTG_SIZE_H,_bl_w,SIZE_WIND_H];
		[(50 - _bl_w / 2),100 - _bl_h - SIZE_WIND_H - SELF_CTG_SIZE_H,_bl_w,SIZE_WIND_H] //start pos
	};

	private _ctg = [_d,WIDGETGROUP,_positionCtg] call createWidget;

	private _back = [_d,BACKGROUND,[0,0,100,100 - SLOT_BIASH],_ctg] call createWidget;
	_back setBackgroundColor [0.2,0.2,0.2,0.7];

	_text = [_d,TEXT,[0,0,100,SIZE_BUTTON],_ctg] call createWidget;
	//<t size='0.4'><br/></t>
	[_text,format["<t align='center' valign='middle'>%1</t>",_targetName]] call widgetSetText;
	_text setBackgroundColor [0,0.02,0,0.8];

	_ctgScrolling = [_d,WIDGETGROUP_H,[0,SIZE_BUTTON,100,100 - SIZE_BUTTON],_ctg] call createWidget;

	private _codeOnPressButton = if (!_isInInventory) then {verb_onPickVerb} else {inventory_onPressVerb};

	_startPosH = 0;

	for "_i" from 0 to (count _translateList) - 1 do {
		_curVerbId = _verbList select _i;

		_itemList = [_d,BUTTON,[0,_startPosH,100,SIZE_BUTTON],_ctgScrolling] call createWidget;
		_itemList ctrlsettext (_translateList select _i);
		_itemlist setvariable ["verbId",_curVerbId];
		_itemList ctrlAddEventHandler ["MouseButtonUp",_codeOnPressButton];

		if ((count toArray (_translateList select _i)) >= 27) then {
			_itemList ctrlSetTooltip (_translateList select _i)
		};

		MOD(_startPosH, + SIZE_BUTTON);
	};

	if (!_isInInventory) then {
		verb_isMenuLoaded = true;
		verb_widgets = [_ctg];
		widgetFadeout(_ctg,TIME_FADEOUT_VERBMENU);

		//adding close element
		_text ctrlAddEventHandler ["MouseButtonUp",{
			nextFrame(verb_unloadMenu);
		}];
		
		//Вне инвентаря скрываем инвентарные слоты
		[true] call verb_setHideInventory;
	} else {
		inventory_verbMenuWidgets = [_ctg];

		//chaging pos
		_BasicPosInvMode set [3,0];

		//saving pos
		_ctg setvariable ["onCreatePos",_positionCtg];
		_ctg setVariable ["onDeletePos",_BasicPosInvMode];
		_ctg setFade 1;
		[_ctg,_BasicPosInvMode] call widgetSetPosition;

		//adding close element
		_text ctrlAddEventHandler ["MouseButtonUp",{
			nextFrame(inventory_unloadVerbMenu);
		}];
	};

	_ctg
};

//Событие которое возникает при нажатии на кнопку действия
decl(void(widget))
verb_onPickVerb = {
	params ["_control"];
	
	/*#ifdef DEBUG
		#define ON_FINALIZE(reason) warningformat("verb::onPickVerb() - Reason to closed: %1",reason);nextFrame(verb_unloadMenu)
	#else
		#define ON_FINALIZE(reason) nextFrame(verb_unloadMenu)
	#endif*/
	inline_macro
	#define ON_FINALIZE(reason) nextFrame(verb_unloadMenu)

	_verbId = _control getvariable ["verbId",-1];
	
	verb_lastCheckedObjectData params [["_obj",objNull],"_mtwPos",["_isMob",false]];
	
	if isNullReference(_obj) exitWith {ON_FINALIZE("NULL REF")};
	_worldPos = _obj modelToWorld _mtwPos;
	if !([_obj,_worldPos] call interact_canInteractWithObject) exitWith {ON_FINALIZE("CANT INTERACT")};
	
	private _hashData = if (_isMob) then {_obj} else {getObjReference(_obj)};
	rpcSendToServer("onActivateVerb",[player arg _hashData arg _verbId]);
	
	/*_lastTarget = verb_lastTargetObjectData select 0;

	if (isnil"_lastTarget") exitWith {ON_FINALIZE};
	if (_lastTarget isEqualTo objnull) exitWith {ON_FINALIZE};

	private _posTarget = getPosATL _lastTarget;
	private _dobDist = if (typeof _lastTarget == BASIC_MOB_TYPE) then {
		_posTarget = getCenterMobPos(_lastTarget);
		1.2
	} else {0};

	//fix bigobjects 0.8.65
	if !([_lastTarget,_dobDist] call interact_canHandReach && {_lastTarget call interact_canSeeObject}) exitWith {ON_FINALIZE};

	//player target verbid
	rpcSendToServer("onActivateVerb",[player arg getObjReference(_lastTarget) arg _verbId]);*/

	ON_FINALIZE("no errors")
};

decl(void())
verb_resetDataForND = {
	verb_isMenuLoaded = false;
	verb_widgets set [0,widgetNull];
	verb_lastCheckedObjectData = VERB_LASTCHECKEDOBJECTDATA_DEFAULT;
	interact_mainHandleLock = false;
	[false,!isNullVar(__inventory_closeFlag)] call verb_setHideInventory;
	inventory_supressInventoryOpen = false;
};

decl(void())
verb_unloadMenu = {
	verb_isMenuLoaded = false;
	if (inventory_supressInventoryOpen) then {
		widgetFadein(verb_widgets select 0,TIME_FADEIN_VERBMENU / 2);
		verb_widgets set [0,widgetNull];
		verb_lastCheckedObjectData = VERB_LASTCHECKEDOBJECTDATA_DEFAULT;
		interact_mainHandleLock = false;
		[false,!isNullVar(__inventory_closeFlag)] call verb_setHideInventory;
		call closeInventory;
		inventory_supressInventoryOpen = false;
	} else {
		widgetFadein(verb_widgets select 0,TIME_FADEIN_VERBMENU);
	
		invokeAfterDelayParams({_this call deleteWidget; interact_mainHandleLock = false; },TIME_FADEIN_VERBMENU + 0.01,verb_widgets select 0);
		//(verb_widgets select 0) call deleteWidget;
		verb_widgets set [0,widgetNull]; //сброс текущего окна. оно уже отправлено на удаление
		
		verb_lastCheckedObjectData = VERB_LASTCHECKEDOBJECTDATA_DEFAULT;
		
		[false,!isNullVar(__inventory_closeFlag)] call verb_setHideInventory;
	};

};

decl(void(bool;bool))
verb_setHideInventory = {
	params ["_mode",["_closeFlag",false]];
	
	if (_mode) then {
		{
			widgetSetFade(_x,1,TIME_FADEOUT_VERBMENU);
			_x ctrlEnable false;
		} foreach inventor_slot_widgets;
		widgetSetFade(getSelfCtg,1,TIME_FADEOUT_VERBMENU);
		if (inventory_isOpenContainer) then {
			{
				widgetSetFade(_x,1,TIME_FADEOUT_VERBMENU)
			} foreach inventory_containerWidgets;
		};
	} else {
		if (_closeFlag) then {
			{
				if !((_x getVariable "slotId" in INV_LIST_HANDS)) then {
					_x ctrlShow false;
				} else {
					widgetSetFade(_x,0,TIME_FADEOUT_VERBMENU);
				};
			} foreach inventor_slot_widgets;
			getSelfCtg ctrlShow false;
			if (inventory_isOpenContainer) then {
				{
					_x ctrlShow false;
				} foreach inventory_containerWidgets;
			};
		} else {
			{
				widgetSetFade(_x,0,TIME_FADEIN_VERBMENU);
			} foreach inventor_slot_widgets;
			widgetSetFade(getSelfCtg,0,TIME_FADEIN_VERBMENU);
			if (inventory_isOpenContainer) then {
				{
					widgetSetFade(_x,0,TIME_FADEIN_VERBMENU)
				} foreach inventory_containerWidgets;
			};
		};	
	};
};

decl(widget())
verb_isInsideVerbMenu = {
	(verb_widgets select 0) call isMouseInsideWidget;
};

decl(widget[])
verb_widgets = [];
decl(vector2)
verb_lastclickedpos = [0,0];
decl(bool)
verb_isMenuLoaded = false;

// verb_list = []; //не разкоммен

decl(any[])
verb_lastTargetObjectData = [objnull,[0,0,0]]; //колбэк дата последнего захваченного объекта

decl(any)
verb_lastCheckedObjectData = VERB_LASTCHECKEDOBJECTDATA_DEFAULT; //[object reference,interact bias pos (use (object modeltoworld pos)),ismob]


//#include "verb_translates.hpp" //obsolete after 0.8.135
