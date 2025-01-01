// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <LocalEffects.h>
/*
	Local effects system
	night vision
	footsteps
	etc...

	Events:
		oncreate  - called on event created
		ondestroy - called on event removed
		onupdate - called on event updated


*/

locef_allEffectsCfg = createHashMap; //списки конфигураций эффектов
locef_allActiveEffects = createHashMap; //key:name, value:context data (list)

#define sanitizeCfgName(var) var = tolower var
#define effectExists(checked) (checked in locef_allActiveEffects)

#define callEffectEvent(name,indx) call (locef_allEffectsCfg get (name) select indx)

//? this method not need. use locef::update()
// locef_add = {
// 	params ['thisEventName',"_context"];
// 	sanitizeCfgName(thisEventName);
// 	callEffectEvent(thisEventName,EFFECT_EVENT_INDEX_CREATE);
// };

locef_remove = {
	private thisEventName = _this;
	sanitizeCfgName(thisEventName);
	
	if !effectExists(thisEventName) exitwith {};
	private thisContext = locef_allActiveEffects get thisEventName;
	callEffectEvent(thisEventName,EFFECT_EVENT_INDEX_DESTROY);
	locef_allActiveEffects deleteAt thisEventName;
}; rpcAdd("lcfrem",locef_remove);

locef_update = {
	params ['thisEventName',["_context",[]]];
	sanitizeCfgName(thisEventName);
	private _isExists = effectExists(thisEventName);
	locef_allActiveEffects set [thisEventName,_context];
	private thisContext = _context;
	if _isExists then {
		callEffectEvent(thisEventName,EFFECT_EVENT_INDEX_UPDATE);
	} else {
		callEffectEvent(thisEventName,EFFECT_EVENT_INDEX_CREATE);
	};
}; rpcAdd("lcfupd",locef_update);

locef_removeAll = {
	{
		_x call locef_remove;
	} foreach (keys locef_allActiveEffects);
}; rpcAdd("lcfclr",locef_removeAll);

locef_createTempObject = {
	private _o = [null,null,true] call le_vst_createDummyObj;
	_o
};

#include <..\LightEngine\LightEngine.hpp>
#include <LocalEffects_list.sqf>