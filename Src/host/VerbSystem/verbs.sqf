// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\ServerRpc\serverRpc.hpp"
#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\PointerSystem\pointers.hpp"
#include "..\..\client\Inventory\inventory.hpp"

#include "ActionsPseudonames.sqf"


verbs_funcData = createHashMap; //only before init verbsCondAndAct.sqf
#include "verbsCondAndAct.sqf"


_onActivateVerb = {
	params ["_mob","_targetHash","_verbId"];

	if equalTypes(_targetHash,objNull) then {
		_targetHash = (_targetHash getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	unrefObject(_usrObj,_mob,errorformat("On activate verb error: Mob is %1",_mob));
	private _thisObj = pointer_get(_targetHash);
	if !pointer_isValidResult(_thisObj) exitWith {errorformat("On activate verb error: Target is %1",_targetHash)};

	private _outArr = [];
	callFunc(_thisObj,getVerbs);

	if (!(_verbId in _outArr)) exitWith {
		warningformat("onVerb: no exists verb %1 in verblist %2", _verb arg _outArr)
	};

	private _probClass = verb_inverted_list get _verbId;
	if isNullVar(_probClass) exitWith {
		errorformat("onVerb: Cant find verb by id %1",_verbId);
	};
	private _action = (verbs_funcData get _probClass) select 1;
	if equals(_action,{true}) then {_action = verb_act_undefinded};
	
	#ifdef SP_MODE
		sp_checkInput("activate_verb",[_thisObj arg _verbId call verb_getTypeById arg _verbId]);
	#endif

	[_thisObj, _usrObj, _mob] call _action;
};
rpcAdd("onActivateVerb",_onActivateVerb);

_onActivateInventoryVerb = {
	params ["_mob","_refItem","_verbId"];

	unrefObject(_usrObj,_mob,errorformat("On activate inventory verb error: Mob is %1",_mob));

	private _thisObj = pointer_get(_refItem);
	if !pointer_isValidResult(_thisObj) exitWith {errorformat("Item reference has no exists in pointers table - %1",_refItem)};

	private _outArr = [];
	callFunc(_thisObj,getVerbs);

	if (!(_verbId in _outArr)) exitWith {
		warningformat("onVerb: no exists verb %1 in verblist %2", _verb arg _outArr)
	};

	private _probClass = verb_inverted_list get _verbId;
	if isNullVar(_probClass) exitWith {
		errorformat("onVerb: Cant find verb by id %1",_verbId);
	};
	private _action = (verbs_funcData get _probClass) select 1;
	if equals(_action,{true}) then {_action = verb_act_undefinded};

	#ifdef SP_MODE
		sp_checkInput("activate_verb",[_thisObj arg _verbId call verb_getTypeById arg _verbId]);
	#endif

	[_thisObj, _usrObj, _mob] call _action;

}; rpcAdd("onActivateInventoryVerb",_onActivateInventoryVerb);

verb_act_undefinded = {
	params ['this',"_usr","_client"];

	warningformat("Undefined verb action: id - %1. Verb source - %2; User - %3",_verbId arg callSelf(getName) arg callFunc(_usr,getName));
};

//Получает вербы объекта из мира
_getObjectVerbs = {
	params ["_callbackOwnwer","_objectHash",["_retAsInv",false]];

	_sourceHashOrObject = _objectHash;

	if equalTypes(_objectHash,objNull) then {
		_objectHash = (_objectHash getvariable ['link',nullPtr]) getvariable ['pointer',"noref"];
	};

	//private _obj = _object getvariable ['link',nullPtr];
	//if (isNullObject(_obj)) exitWith {
	//	warningformat("GameObject::getObjectVerbs - link is undefined (%1) caller is %2",_object arg _callbackOwnwer);
	//};
	private _obj = pointer_get(_objectHash);
	if !pointer_isValidResult(_obj) exitWith {errorformat("On collect verb (from object) error: Object is %1",_objectHash)};


	unrefObject(_mob,_callbackOwnwer,errorformat("On collect verb (from object) error: Target is %1",_callbackOwnwer));

	_verbs = [_mob,_obj] call verb_tryCollectVerbs;
	
	#ifdef SP_MODE
		sp_checkInput("load_verbs",[_obj arg _verbs]);
	#endif

	if (_retAsInv) then {
		rpcSendToObject(_callbackOwnwer,"loadVerbsInventory",[callFunc(_obj,getName) arg _verbs arg -100 arg _objectHash]);
	} else {
		rpcSendToObject(_callbackOwnwer,"loadVerbs",[callFunc(_obj,getName) arg _verbs arg _sourceHashOrObject]);
	};
	
}; rpcAdd("getObjectVerbs",_getObjectVerbs);

_getInventoryVerbs = {
	params ["_callbackOwnwer","_slotId"];

	unrefObject(_mob,_callbackOwnwer,errorformat("On collect verb (from inventory) error: Target is %1",_callbackOwnwer));

	private _obj = callFuncParams(_mob,getItemInSlot,_slotId);

	if (isNullObject(_obj)) exitWith {errorformat("Net::getInventoryVerbs - item in slot %1 is does not exists. Items: %2",_slotId arg getVar(_mob,slots))};
	if isTypeOf(_obj,StolenItem) exitWith {callFuncParams(_obj,onStolen,_mob)};
	
	_verbs = [_mob,_obj] call verb_tryCollectVerbs;

	#ifdef SP_MODE
		sp_checkInput("load_verbs",[_obj arg _verbs]);
	#endif

	_hash = getVar(_obj,pointer);

	rpcSendToObject(_callbackOwnwer,"loadVerbsInventory",[callFunc(_obj,getName) arg _verbs arg _slotId arg _hash]);

}; rpcAdd("getInventoryVerbs",_getInventoryVerbs);

//условия на добавления вербов и отправкой клиенту
verb_tryCollectVerbs = {
	params ["_mob","_targ"];
	//errorformat("Rewrite!!!!!!!! %1 %2 %3 %4",isTypeOf(_targ,SystemHandItem) arg _targ arg getVar(_targ,mode) arg getVar(_targ,mode) != "none");
	if (isTypeOf(_targ,SystemHandItem) && {getVar(_targ,mode) != "none"}) then {
		//error("Rewrite!!!!!!!!");
		_targ = getVar(_targ,object);
	};
	
	private _list = [];

	private _outArr = []; //внешняя ссылка для getVerbs и перезаписанных методов
	callFunc(_targ,getVerbs);

	private _protoSelf = verbConditions getVariable PROTOTYPE_VAR_NAME;
	private _condition = {true};

	//references
	src = _targ;
	usr = _mob;
	private _vData = 0;
	private _redirName = "";
	private _verbClassName = "";
	
	//script check
	private _isScripted = callFunc(_targ,isScriptedObject);
	private _scriptObj = nullPtr;
	if (_isScripted) then {
		_scriptObj = getVar(_targ,__script);
	};

	{
		_verbClassName = verb_inverted_list get _x;
		_vData = (verbs_funcData get _verbClassName);
		_condition = _vData select 0;
		_canAdd = call _condition;

		if (_isScripted) then {
			_canAdd = _canAdd && callFuncParams(_scriptObj,canSeeVerb,_mob arg _verbClassName);
		};

		//logformat("canadd %1 - %2; Scripted - %3",_x arg _canAdd arg _isScripted);
		if (_canAdd) then {
			_redirName = null;
			call (_vData select 2);
			if !isNullVar(_redirName) then {
				_list pushBack [_x,_redirName]
			} else {
				_list pushBack _x
			};
			
		};
	} foreach _outArr;

	_list
};


verb_getTypeById = {
	params ["_id"];
	verb_inverted_list get _id
};