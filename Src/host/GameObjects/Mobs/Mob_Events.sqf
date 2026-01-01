// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define use_protect_log
#ifdef use_protect_log
	#define protectLog(tp,message,format) warningformat("Duplicate try catch - " + tp + "; " + message,format)
#else
	#define protectLog(tp,message,format)
#endif

#define protectLocMob(event,item,mob,args) if not_equals(getVar(item,loc),mob) exitWith {protectLog('event'," %1 as %2",getVar(item,pointer) arg callFunc(item,getClassName))}
#define protectLocWorld(event,item,args) if (!callFunc(item,isInWorld)) exitWith {protectLog('event'," %1 as %2",getVar(item,pointer) arg callFunc(item,getClassName))}

//Генеральное событие взаимодействия
_iact = {
	//data getted in flat array
	/*
		0 xpos
		1 ypos
		2 zpos
		3 xvec
		4 yvec
		5 zvec
		6 vuzvec
		7 type
		8 unit

		9 * ?4? = 36 bytes
	*/
	//[ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz]
	if (count _this < 9) exitWith {
		errorformat("rpc<iact>() - Wrong params count => %1",count _this);
	};
	
	_renderPos = _this select [0,3];
	_renderVec = [_this select [3,3],[0,0,_this select 6]];
	_type = _this select 7;
	_unit = _this select 8;
	private _optTarg = null;
	if (count _this > 9) then {
		_optTarg = _this select 9;
	};
	
	unrefObject(this,_unit,errorformat("rpc<iact>() - Mob object has no exists virtual object - %1",_unit));

	_item = callSelf(getItemInActiveHand);//pre check stolen

	if (!isNullReference(_item) && isTypeOf(_item,StolenItem)) exitWith {callFuncParams(_item,onStolen,this);};

	//Нужно больше тестов
	//_bias = (_renderPos distance2d (eyepos _unit)) * (vectorMagnitude (velocity _unit));
	_bias = _renderPos distance2d (eyePos _unit); //temporary solution
	traceformat("render interact obj %1 with bias %2",vec4(_renderPos,_renderVec,false,_bias) call si_rayCast arg _bias)
	_ignore = _unit;// ВЫЗЫАЕТ ОШИБКИ И ПРОБЛЕМЫ,.. ifcheck(getSelf(isCombatModeEnable),_unit,objNull);
	private _pos = [];
	private _normal = [];
	private _target = [_renderPos,_renderVec,true,_bias,_pos,_ignore,_normal] call si_rayCast;
	if !isNullVar(_optTarg) then {
		if equalTypes(_optTarg,objNull) then {
			_optTarg = (_optTarg getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
		};
		private _vobj__ = pointer_get(_optTarg);
		if !pointer_isValidResult(_vobj__) exitWith {};
		_target = _vobj__;
		_renderPos = callSelf(getPos);
		
		if (callFunc(_target,isInWorld) && !isNullReference(getVar(_target,loc))) then {
			_pos = callFunc(_target,getPos);
		} else {
			_pos = _renderPos;
		};
	};

	//отмена прогресса при активности
	callSelfParams(stopProgress,true);

	if !callSelf(isActive) exitWith {}; //мертв, спит или без сознания
	//сериализация последнего объекта
	callSelfParams(saveLastInteract,_renderPos arg _pos arg _target arg _renderVec arg _normal);
	
	private _isLegAction = getSelf(specialAction)in[SPECIAL_ACTION_KICK] && _type == INTERACT_RPC_EXTRA;
	private _actPart = callSelfParams(getActiveHandPart,_isLegAction);
	private _isHandAction = !_isLegAction && !(getSelf(specialAction)in[SPECIAL_ACTION_BITE]);
	private _isHeadAction = !_isLegAction && !_isHandAction;
	
	traceformat("isLegAction %1 isHandAction %2 isHeadAction %3",_isLegAction arg _isHandAction arg _isHeadAction);
	traceformat("actpart %1",_actPart);

	if (isNullReference(_actPart) && !_isHeadAction) exitWith {
		callSelfParams(localSay,"Нет части тела"+comma+" которой можно сделать это" arg "error");
	};
	if (!callFunc(_actPart,canUsePart)) exitWith {
		callSelfParams(localSay,callFunc(_actPart,getName) + " не может использоваться" arg "error");
	};
	if (_isHandAction && {callFunc(_actPart,isBoneBroken) && prob(60) && callSelf(canFeelPain)}) exitWith {
		callSelf(doMoan);
		callSelfParams(Stun,randInt(2,3) arg null arg true);
	};
	
	if (_type == INTERACT_RPC_CLICK) exitWith {
		#ifdef SP_MODE
			sp_checkInput("click_target",[_target]);
		#endif
		callSelfParams(clickTarget,_target);
	};
	if (_type == INTERACT_RPC_CLICK_SELF) exitWith {
		_target = this;
		#ifdef SP_MODE
			sp_checkInput("click_self",[callSelf(getItemInActiveHandRedirect)]);
		#endif
		callSelfParams(clickTarget,_target);
	};
	if (_type == INTERACT_RPC_ALTCLICK) exitWith {

	};
	if (_type == INTERACT_RPC_MAIN) exitWith {
		#ifdef SP_MODE
			sp_checkInput("main_action",[_target]);
		#endif
		callSelfParams(mainAction,_target);
	};
	if (_type == INTERACT_RPC_EXAMINE) exitWith {

	};
	if (_type == INTERACT_RPC_EXTRA) exitWith {
		//скриптовая проверка с защитой переполнения стека
		if (callFunc(_target,isScriptedObject) && {isNullVar(__SCRIPT_EXACT_ACTION__)}) exitWith {
			private __SCRIPT_EXACT_ACTION__ = true;
			callFuncParams(getVar(_target,__script),onExtraAction,this);
		};
		#ifdef SP_MODE
			sp_checkInput("extra_action",[_target]);
		#endif
		callSelfParams(extraAction,_target);
	};

}; rpcAdd("iact",_iact);

//state progress
_stprg = {
	params ["_player","_isSuccess"];
	//unrefObject(this,_player,errorformat("stprg() - Mob object has no exists virtual object - %1",_player));

	private this = pointer_get(_player);
	if !pointer_isValidResult(this) exitWith {errorformat("stprg() - Mob object has no exists virtual object - %1",_player)};

	if (_isSuccess) then {
		callSelf(successProgress);
	} else {
		callSelfParams(stopProgress,false);
	};
}; rpcAdd("stprg",_stprg);

// Событие осмотра предмета
_examine = {
	params ["_player","_target"];

	unrefObject(this,_player,errorformat("examine() - Mob object has no exists virtual object - %1",_player));

	if equalTypes(_target,objNull) then {
		_target = (_target getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};
	private _obj = pointer_get(_target);
	if !pointer_isValidResult(_obj) exitWith {errorformat("Examine error: Object is %1",_target)};

	if (isTypeOf(_obj,StolenItem)) exitWith {callFuncParams(_obj,onStolen,this);};

	callSelfParams(examine,_obj);
}; rpcAdd("examine",_examine);

_emoteTxt = {
	params ["_player","_txt"];
	unrefObject(this,_player,errorformat("emoteTxt() - Mob object has no exists virtual object - %1",_player));
	
	if isTypeOf(this,MobGhost) exitWith {};
	#ifdef SP_MODE
		sp_checkInput("emote_text",[_txt]);
	#endif

	[format["(EMOTE) - %1 %2 (%3)",callSelfParams(getNameEx,"кто"),_txt,getVar(getSelf(client),name)]] call rpLog;

	callSelfParams(meSay,_txt);
}; rpcAdd("emoteTxt",_emoteTxt);

_emoteAct = {
	params ["_player","_emt",["_optString",""]];
	unrefObject(this,_player,errorformat("emoteAct() - Mob object has no exists virtual object - %1",_player));

	[format["(EMOTE_ACTION) - %1 perform emote '%2' (%3)",callSelfParams(getNameEx,"кто"),_emt,getVar(getSelf(client),name)]] call rpLog;

	#ifdef SP_MODE
		sp_checkInput("emote_action",[_emt arg _optString]);
	#endif
	
	//Сохраняем строку если она передана по сети
	setSelf(lastEmoteActionString,_optString);

	[this,_emt] call ie_action_call;
}; rpcAdd("emoteAct",_emoteAct);

_onClickTarget = {
	params ["_mobObj","_target"];

	unrefObject(this,_mobObj,errorformat("onClickTarget() - Mob object has no exists virtual object - %1",_mobObj));
	if equalTypes(_target,objNull) then {
		_target = (_target getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};
	private _obj = pointer_get(_target);
	if !pointer_isValidResult(_obj) exitWith {errorformat("onClickTarget() error: Object is %1",_target)};
	if (isTypeOf(_obj,StolenItem)) exitWith {callFuncParams(_obj,onStolen,this);};

	#ifdef SP_MODE
		sp_checkInput("click_target",[_obj]);
	#endif

	callSelfParams(clickTarget,_obj);

}; rpcAdd("onClickTarget",_onClickTarget);

_onAltClickTarget = {
	params ["_mobObj","_target"];

	unrefObject(this,_mobObj,errorformat("onAltClickTarget() - Mob object has no exists virtual object - %1",_mobObj));
	if equalTypes(_target,objNull) then {
		_target = (_target getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};
	private _obj = pointer_get(_target);
	if !pointer_isValidResult(_obj) exitWith {errorformat("onAltClickTarget() error: Object is %1",_target)};
	if (isTypeOf(_obj,StolenItem)) exitWith {callFuncParams(_obj,onStolen,this);};

	callSelfParams(altClickTarget,_obj);

}; rpcAdd("onAltClickTarget",_onAltClickTarget);


_onDropItem = {
	params ["_mobObj","_slotId",["_isSafePutdown",false]];

	unrefObject(this,_mobObj,errorformat("onDropItem() - Mob object has no exists virtual object - %1",_mobObj));
	private _item = callSelfParams(getItemInSlot,_slotId);
	if (!isNullReference(_item) && {isTypeOf(_obj,StolenItem)}) exitWith {callFuncParams(_item,onStolen,this);};
	
	#ifdef SP_MODE
		sp_checkInput("drop_item",[_slotId arg _isSafePutdown]);
	#endif

	callSelfParams(dropItem,_slotId arg _isSafePutdown);
}; rpcAdd("onDropItem",_onDropItem);

_onPutdownItem = {
	params ["_mobObj","_refItem","_positionData",["_isFastButton",false]];
	//_positionData: vec4(posATL,dir(float),vup(vec3),ptrPlace)

	private _vObjMob = getVObjectLink(_mobObj);
	private _vObjItem = pointer_get(_refItem);

	if !isExistsObject(_vObjMob) exitWith {errorformat("onPutdownItem() - Mob object has no exists virtual object - %1",_mobObj);};
	if !pointer_isValidResult(_vObjItem) exitWith {errorformat("onPutdownItem() - Item reference has no exists in pointers table - %1",_refItem)};
	if !isExistsObject(_vObjItem) exitWith {errorformat("onPutdownItem() - Item object has no exists virtual object - %1 as %2",_refItem arg _vObjItem);};
	if (isTypeOf(_vObjItem,StolenItem)) exitWith {callFuncParams(_vObjItem,onStolen,_vObjMob);};
	
	private _pdPlacePtr = _positionData select 3;
	private _placerObj = pointer_get(_pdPlacePtr);
	if !pointer_isValidResult(_placerObj) exitWith {errorformat("onPutdownItem() - Placer reference has no exists in pointers table - %1",_pdPlacePtr)};
	_positionData set [3, _placerObj];

	#ifdef SP_MODE
		sp_checkInput("putdown_item",[_vObjItem arg _positionData]);
	#endif

	callFuncParams(_vObjMob,putdownItem, _vObjItem arg _positionData);
	// 2022-2022 RIP. ЗДЕСЬ БЫЛА ЛОГИКА НА ЗАДЕРЖКУ ПРИ ВЫКЛАДЫВАНИИ С ПОМОЩЬЮ КНОПКИ БЫСТРОГО ВЫКЛАДЫВАНИЯ
	/*if (_isFastButton) then {
		setVar(_vObjMob,__fastputdownbuffer,vec2(_vObjItem,_positionData));
		callFuncParams(_vObjMob,startSelfProgress,"onPutdownBindPress" arg getVar(_vObjMob,rta / 4) arg INTERACT_PROGRESS_TYPE_FULL);
	} else {
		callFuncParams(_vObjMob,putdownItem, _vObjItem arg _positionData);
	};*/

}; rpcAdd("onPutdownItem",_onPutdownItem);

_onTransferItem = {
	params ["_mobObj","_from","_to"];

	unrefObject(this,_mobObj,errorformat("onTransferItem() - Mob object has no exists virtual object - %1",_mobObj));
	
	if (callSelf(isHandcuffed) && {
		!(_from in INV_LIST_HANDS) ||
		!(_to in INV_LIST_HANDS)
	}) exitwith {}; //связаны руки
	
	private _item = callSelfParams(getItemInSlot,_from);
	if (!isNullReference(_item) && isTypeOf(_item,StolenItem)) exitWith {callFuncParams(_item,onStolen,this);};
	
	if !callSelfParams(canUseActivePart,false) exitWith {};
	
	#ifdef SP_MODE
		sp_checkInput("transfer_slots_item",[_from arg _to]);
	#endif

	callSelfParams(transferItem,args2(_from,_to));
}; rpcAdd("onTransferItem",_onTransferItem);

_onInteractWith = {
	params ["_mobObj","_targHash","_withObj"];

	//errorformat("onInteractWith() NOT DEPREACTED - remove this. ctx: %1",_this);

	unrefObject(this,_mobObj,errorformat("onInteractWith() - Mob object has no exists virtual object - %1",_mobObj));

	if equalTypes(_targHash,objNull) then {
		_targHash = (_targHash getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	private _item = pointer_get(_targHash);
	if !pointer_isValidResult(_item) exitWith {errorformat("onInteractWith() - Target reference has no exists in pointers table - %1",_targHash)};

	private _withItem = pointer_get(_withObj);
	if !pointer_isValidResult(_withItem) exitWith {errorformat("onInteractWith() - Item reference has no exists in pointers table - %1",_withObj)};

	if (isTypeOf(_withItem,StolenItem)) exitWith {callFuncParams(_withItem,onStolen,this);};

	//Перезаписываем системный предмет для взаимодействия схваченного
	if isTypeOf(_withItem,SystemItem) then {
		_withItem = callFunc(_withItem,rewriteSystemItem);
	};

	if (callFunc(_item,isMob) || callFunc(_item,isContainer)) then {
		
		#ifdef SP_MODE
			sp_checkInput("interact_with",[_item arg _withItem]);
		#endif

		private __DRAG_EXTERNAL_FLAG__ = true;
		traceformat("ctx: %1",vec3(getVar(_item,pointer),getVar(_withItem,pointer),getVar(this,pointer)))
		traceformat("ctx2: %1",vec3(getVar(_item,name),getVar(_withItem,name),getVar(this,name)))
		callFuncParams(_item,onInteractWith,_withItem arg this);
	};


}; rpcAdd("onInteractWith",_onInteractWith);

_onInteractInventoryWith = {
	params ["_mobObj","_withHash","_targHash"];

	unrefObject(this,_mobObj,errorformat("onInteractInventoryWith() - Mob object has no exists virtual object - %1",_mobObj));
	private _withItem = pointer_get(_withHash);
	private _item = pointer_get(_targHash);

	if !pointer_isValidResult(_withItem) exitWith {errorformat("onInteractInventoryWith() - Item reference has no exists in pointers table - %1",_withHash)};
	if !pointer_isValidResult(_item) exitWith {errorformat("onInteractInventoryWith() - Target reference has no exists in pointers table - %1",_targHash)};
	if callSelf(isHandcuffed) exitwith {};
	if (isTypeOf(_withItem,StolenItem)) exitWith {callFuncParams(_withItem,onStolen,this);};

	if isTypeOf(_withItem,SystemItem) then {
		_withItem = callFunc(_withItem,rewriteSystemItem);
	};

	//emplace item into container
	if callFunc(_item,isContainer) then {
		#ifdef SP_MODE
			sp_checkInput("interact_with",[_item arg _withItem]);
		#endif

		callFuncParams(_item,onInteractWith,_withItem arg this);
	};

}; rpcAdd("onInteractInventoryWith",_onInteractInventoryWith);

_onMainAction = {
	params ["_mobObj","_targHash"];

	FHEADER;

	if equalTypes(_targHash,objNull) then {
		_targHash = (_targHash getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	if equals(_targHash,"noref") exitWith {
		error("onMainAction() - Target hash is noref");
	};

	unrefObject(this,_mobObj,errorformat("onMainAction() - Mob object has no exists virtual object - %1",_mobObj));

	private _item = if (_targHash isEqualType "") then {
		private _itemRef = pointer_get(_targHash);
		if !pointer_isValidResult(_item) exitWith {
			errorformat("onMainAction() - Target reference has no exists in pointers table - %1",_targHash);
			RETURN(0);
		};
		_itemRef
	} else {
		errorformat("onMainAction() - Unexpected case - target hash is not string -> type: %1",typeName _targHash);
		RETURN(0);
	};
	if callSelf(isHandcuffed) exitwith {};
	if (isTypeOf(_item,StolenItem)) exitWith {callFuncParams(_item,onStolen,this);};

	if callFunc(_item,isScriptedObject) exitWith {callFuncParams(getVar(_item,__script),onMainAction,this)};
	
	#ifdef SP_MODE
		sp_checkInput("main_action",[_item]);
	#endif

	callFuncParams(_item,onMainAction,this);
}; rpcAdd("onMainAction",_onMainAction);

_onExtraAction = {
	params ["_mobObj","_targHash"];

	FHEADER;

	if equalTypes(_targHash,objNull) then {
		_targHash = (_targHash getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	if equals(_targHash,"noref") exitWith {
		error("onExtraAction() - Target hash is noref");
	};

	unrefObject(this,_mobObj,errorformat("onExtraAction() - Mob object has no exists virtual object - %1",_mobObj));

	private _item = if (_targHash isEqualType "") then {
		private _itemRef = pointer_get(_targHash);
		if !pointer_isValidResult(_item) exitWith {
			errorformat("onExtraAction() - Item reference has no exists in pointers table - %1",_targHash);
			RETURN(0);
		};
		_itemRef
	} else {
		unrefObject(_itemRef,_targHash,errorformat("onExtraAction() - Item object has no exists virtual object - %1",_mobObj); RETURN(0));
		_itemRef;
	};
	if (isTypeOf(_item,StolenItem)) exitWith {callFuncParams(_item,onStolen,this);};

	#ifdef SP_MODE
		sp_checkInput("extra_action",[_item]);
	#endif

	callFuncParams(_item,onExtraAction,this);
}; rpcAdd("onExtraAction",_onExtraAction);

_onRemoveItemFromContainer = {
	//rpcSendToServer("onRemoveItemFromContainer",[player arg _hashContainer arg _hashContItem arg _idTo]);
	params ["_mobObj","_hashCont","_hashItem","_slot"];

	unrefObject(this,_mobObj,errorformat("onRemoveItemFromContainer() - Mob object has no exists virtual object - %1",_mobObj));
	private _cont = pointer_get(_hashCont);
	if !pointer_isValidResult(_cont) exitWith {errorformat("onRemoveItemFromContainer() - Container reference has no exists in pointers table - %1",_hashCont)};

	private _item = pointer_get(_hashItem);
	if !pointer_isValidResult(_item) exitWith {errorformat("onRemoveItemFromContainer() - Target reference has no exists in pointers table - %1",_hashItem)};
	
	if !callSelfParams(canUseActivePart,false) exitWith {};
	
	callFuncParams(_cont,removeItem,_item arg this arg _slot);

}; rpcAdd("onRemoveItemFromContainer",_onRemoveItemFromContainer); //dbg = _onRemoveItemFromContainer;

_onContainerClose = {
	params ["_mobObj","_contRef"];

	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));

	private _itemRef = pointer_get(_contRef);
	if !pointer_isValidResult(_itemRef) exitWith {errorformat("Target reference has no exists in pointers table - %1",_contRef);};

	callFuncParams(_itemRef,onContainerClose,this);

}; rpcAdd("onContainerClose",_onContainerClose);

_closeNetDisplay = {
	params ["_mobObj","_ref"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));

	if equalTypes(_ref,objNull) then {
		_ref = (_ref getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	private _obj = pointer_get(_ref);
	if !pointer_isValidResult(_obj) exitWith {
		errorformat("NetDisplay target reference has no exists in pointers table - %1",_ref);
		_obj = getSelf(openedNDisplay);
		warningformat("[NetDisplay] closing display on mob with helper field: Mob::openedNDisplay = %1",_obj);
		if isNull(getVar(_obj,ndOpenedBy)) exitWith {};
		callFuncParams(_obj,closeNDisplay,this);
	};

	if isNull(getVar(_obj,ndOpenedBy)) exitWith {};

	callFuncParams(_obj,closeNDisplay,this);
}; rpcAdd("closeNetDisplay",_closeNetDisplay);

_ndInput = {
	params ["_mobObj","_ref","_data"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));

	if equalTypes(_ref,objNull) then {
		_ref = (_ref getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	private _obj = pointer_get(_ref);
	if !pointer_isValidResult(_obj) exitWith {errorformat("NetDisplay target reference has no exists in pointers table - %1",_ref);};

	if isNull(getVar(_obj,ndOpenedBy)) exitWith {};

	callFuncParams(_obj,handleNDInput,this arg _data);
}; rpcAdd("ndInput",_ndInput);


_getmemories = {
	params ["_mobObj",["_mode",0]];

	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	
	#ifdef SP_MODE
		sp_checkInput("get_memories",[_mode]);
	#endif

	if (_mode == 1) exitWith {
		callFunc(this,getSkillsInfoText);
	};
	callFunc(this,getMemories)
}; rpcAdd("getmemories",_getmemories);


/*
================================================================================
		CATEGORY: Sync data (client to server)
================================================================================
*/

#define __onUpdateImpl(content,varName) \
_o_upd_impl_internal = { \
	params ["_mobObj","_var"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	setSelf(varName,_var); \
}; rpcAdd('content',_o_upd_impl_internal)

#define __onUpdateImplMethod(content,varName) \
_o_upd_impl_internal = { \
	params ["_mobObj","_var"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	callSelfParams(varName,_var); \
}; rpcAdd('content',_o_upd_impl_internal)

#define __onUpdateImplMethodNoParams(content,varName) \
_o_upd_impl_internal = { \
	params ["_mobObj"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	callSelf(varName); \
}; rpcAdd('content',_o_upd_impl_internal)


_onUpdateSelection = {
	params ["_mobObj","_selection"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	setSelf(curTargZone,_selection);
	callSelfParams(onChangeAttackType,"sync");
}; rpcAdd("onUpdateSelection",_onUpdateSelection);


_onUpdateSpecAct = {
	params ["_mobObj","_act",["_isPlayed",false],["_lightLevel",0]];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	
	#ifdef SP_MODE
		sp_checkInput("press_specact",[_act]);
	#endif

	if isTypeOf(this,MobGhost) exitWith {};
	//todo more logic and boolean condition

	if (_isPlayed) then {
		if (_act == SPECIAL_ACTION_STEALTH) then {
			setSelf(__lastClientLighting,_lightLevel);
		};
		[this,_act] call (missionNamespace getVariable [format["specact_%1",_act],{}]);
	} else {
		private _actcall = if (getSelf(specialAction) == -1) then {_act} else {getSelf(specialAction)};

		setSelf(specialAction,_act);
		callSelfParams(onChangeAttackType,"sync");
		[this,_actcall] call (missionNamespace getVariable [format["specact_%1",_actcall],{}]);
	};

}; rpcAdd("onUpdateSpecAct",_onUpdateSpecAct);

_onResist = {
	params ["_mobObj","_ctx"];

	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	
	if callSelf(isConnected) exitWith {
		callSelf(disconnectFromSeat);
	};
	if callSelf(isHandcuffed) exitwith {
		//когда тело связано и заграбано то высвободиться не получится
		//... и это отключено потому что какого хуя
		//if !callSelf(isGrabbed) then {
			callFunc(getSelf(handcuffObject),tryFree);
		//};
	};
	if callSelf(isGrabbed) exitWith {
		callSelf(tryReleaseFromGrab);
	};

}; rpcAdd("onResist",_onResist);

_setCombatMode = {
	params ["_mobObj","_ctx"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	#ifdef SP_MODE
		sp_checkInput("set_combat",[_ctx]);
	#endif
	callSelfParams(setCombatMode,_ctx);
}; rpcAdd("setCombatMode",_setCombatMode);


_onCrushingToObject = {
	params ["_mobObj"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	callSelf(generateLastInteractOnServer);
	
	#ifdef SP_MODE
		sp_checkInput("crush_contact",[callSelf(getLastInteractTarget)]);
	#endif
	
	callFuncParams(callSelf(getLastInteractTarget),onCrushingContact,this);
}; rpcAdd("onCrushingToObject",_onCrushingToObject);

//__onUpdateImpl(onUpdateCombatStyle,curCombatStyle);
__onUpdateImplMethod(onUpdCS,setCombatStyle);
__onUpdateImpl(onUpdateDefType,curDefType);
__onUpdateImplMethod(onUpdateAttackType,setAttackType);
__onUpdateImplMethodNoParams(onUpdateActiveHand,switchActiveHand);
__onUpdateImplMethodNoParams(switchTwoHands,switchTwoHands);

// ---- antistrafe event -----
_onStrafeCatch = {
	params ["_mobObj"];
	
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));

	#ifdef SP_MODE
		sp_checkInput("strafe",[]);
	#endif

	if (callSelf(isActive)) then {
		if (callSelf(getStance) > STANCE_DOWN) then {
			callSelf(KnockDown);
			//callSelfParams(Stun,randInt(5,10) arg true arg true); //По запросу https://github.com/Relicta-Team/ReSDK_A3.vr/issues/257
			private _mRand = pick ["неуклюже","неумело","глупо","смешно","безумно"];
			callSelfParams(meSay,_mRand + " падает");
		};
	};
}; rpcAdd("onStrafeCatch",_onStrafeCatch);

__resetCustomAnim = {
	params ["_mobObj"];
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));
	callSelfParams(setCustomActionState,CUSTOM_ANIM_ACTION_NONE arg true);
}; rpcAdd("__resetCustomAnim",__resetCustomAnim);

_onSyncPullProcess = {
	params ["_ref","_tdat"];
	private _obj = pointer_get(_ref);
	if !pointer_isValidResult(_obj) exitWith {
		errorformat("Gameobject object has no exists virtual object - %1",_ref)
	};
	
	setVar(_obj,__pullProc_tdat,_tdat);
}; rpcAdd("snc_ppc",_onSyncPullProcess);

_ppc_forceStop = {
	params ["_mobObj","_ref"];

	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj));

	private _obj = pointer_get(_ref);
	if !pointer_isValidResult(_obj) exitWith {
		errorformat("Gameobject object has no exists virtual object - %1",_ref)
	};
	
	_cond = {
		params ["_sysHandItm","_ctxTuple"];
		_ctxTuple params ["_obj"];
		equals(_obj,getVar(_sysHandItm,object))
	};
	callFuncParams(this,stopGrabIf,_cond arg [_obj]);
}; rpcAdd("ppc_forceStop",_ppc_forceStop);

/**************************************************************************
|					ONE SYNC SERVER EVENTS								  |
**************************************************************************/
_os_fall = {
	params ["_mobObj","_ctx"];
	unrefObject(this,_mobObj,errorformat("OS_FALL: Mob object has no exists virtual object - %1",_mobObj));

	#ifdef SP_MODE
		sp_checkInput("on_falling",[_ctx]);
	#endif

	callSelfParams(onFalling,_ctx);
}; rpcAdd("os_fall",_os_fall);

_os_lt = {
	params ["_mobObj","_ctx"];
	unrefObject(this,_mobObj,errorformat("OS_LIGHT: Mob object has no exists virtual object - %1",_mobObj));

	setSelf(__lastClientLighting,_ctx);
}; rpcAdd("os_lt",_os_lt);

//onesync step get data
_os_sgd = {
	params ["_mobObj","_ctx"];
	unrefObject(this,_mobObj,errorformat("OS_STEPDATA: Mob object has no exists virtual object - %1",_mobObj));
	private _floorPtr = pointer_get(_ctx);
	if !pointer_isValidResult(_floorPtr) exitWith {};
	
	callSelfParams(handleStepSounds,_floorPtr);
}; rpcAdd("os_sgd",_os_sgd);


//replicator common
repl_doLocal = {
	params ["_unit","_method","_ctx"];
	if (local _unit) exitWith {
		_ctx call (repl_map_funcs getOrDefault [(_method),{
			errorformat("repl::doLocal() - unsupported method ctx[%1]",_method);
		}]);
	};
	//#ifndef EDITOR
	rpcSendToObject(_unit,"replloc",[_method arg _ctx]);
	//#endif
};