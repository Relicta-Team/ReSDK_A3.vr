// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "interact.hpp"

namespace(Interact,interact_)

macro_def(interact_log_mainHandle)
#define __log_mainhandle

#ifdef RELEASE
	#undef __log_mainhandle
#endif

#ifdef __log_mainhandle 
	macro_func(interact_finalizeMainHandle,void(any))
	#define ON_FINALIZE(reason) warningformat("Abort - %1",reason);interact_mainHandleLock = true; nextFrame(_codeExit)
#else
	#define ON_FINALIZE(reason) interact_mainHandleLock = true;nextFrame(_codeExit)
#endif

decl(bool)
interact_mainHandleLock = false;

_upd = {
	if (interact_mainHandleLock) exitWith {};
	
	if (verb_isMenuLoaded) then {
		
		#define checkExiter() if (_exiter) exitWith {}
		#define setExiter(mode) _exiter = mode
		
		private setExiter(false);
		
		private _codeExit = verb_unloadMenu;
		
		verb_lastCheckedObjectData params ["_obj","_mtwPos","_isMob"];
		
		if isNullVar(_obj) exitWith {ON_FINALIZE("target null")};
		if isNullReference(_obj) exitWith {ON_FINALIZE("target null reference")};
		
		_worldPos = _obj modelToWorld _mtwPos;
		if !([_obj,_worldPos] call interact_canInteractWithObject) exitWith {ON_FINALIZE("canInteractWithObject pass fall")};
		
		// За данные на этом этапе можно не беспокоиться, так как видимость отсекается на этапе interact_canInteractWithObject
		(_worldPos call positionWorldToScreen) params ["_xpos","_ypos"];
		
		private _wid = verb_widgets select 0;
		(_wid call widgetGetPosition) params ["","","_w","_h"];
		
		MOD(_xpos,- _w / 2);
		MOD(_ypos, - _h / 2);
		
		// probably depreacted checking...
		if ((_xpos + _w) < 0 || (_ypos + _h) < 0 || _xpos >= 100 || _ypos >= 100) exitWith {ON_FINALIZE("out of screen size " + format["%1:%2" arg _xpos arg _ypos])};
		
		[_wid,[_xpos,_ypos]] call widgetSetPositionOnly;
		
		#ifndef RELEASE
		if (false) then {
			_lastTarget = verb_lastTargetObjectData select 0;
			
			if (isnil"_lastTarget") exitWith {ON_FINALIZE("target null")};
			if (_lastTarget isEqualTo objnull) exitWith {ON_FINALIZE("target null reference")};
			private _pos = getPosATL _lastTarget;
			
			if (typeOf _lastTarget == BASIC_MOB_TYPE) then {
				_pos = _lastTarget call interact_findNearPosMob;
				if !([_pos] call interact_canHandReach /*&& {_lastTarget call interact_canSeeObject}*/) exitWith {setExiter(true); ON_FINALIZE("canhandreach pass fall")};
			} else {
				//fix bigobjects 0.8.65
				if !([_lastTarget] call interact_canHandReach /*&& {_lastTarget call interact_canSeeObject}*/) exitWith {setExiter(true); ON_FINALIZE("canhandreach pass fall")};
			};
			
			checkExiter();
			
			//setting new widget pos
			
			//Дополнительная позиция виджета для центровки 
			private _bbr = boundingBoxReal _lastTarget select 1 select 2;
			private _screenpos = worldToScreen (_pos vectorAdd [0,0,(_bbr max 0 min 1.6) / 2]);
			if (_screenpos isEqualTo []) exitWith {ON_FINALIZE("3d>2d returns nulldata")};
			(_screenpos call convertScreenCoords) params ["_xpos","_ypos"];
			
			private _wid = verb_widgets select 0;
			(_wid call widgetGetPosition) params ["","","_w","_h"];
			
			MOD(_xpos,- _w / 2);
			MOD(_ypos, - _h / 2);
			
			//if (typeOf _lastTarget == BASIC_MOB_TYPE) then {_w = 0;_h = 0;}; //Временный костыль
			
			if ((_xpos + _w) < 0 || (_ypos + _h) < 0 || _xpos >= 100 || _ypos >= 100) exitWith {ON_FINALIZE("out of screen size " + format["%1:%2" arg _xpos arg _ypos])};
			
			[_wid,[_xpos,_ypos]] call widgetSetPositionOnly;
			//if (ctrlCommitted _wid) then {_wid ctrlcommit 0.02};
		};
		#endif
		
		
	};
};

startUpdate(_upd,0);