// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <Craft.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <..\Networking\Network.hpp>
#include <..\PointerSystem\pointers.hpp>


//запрос открытия крафт меню
craft_requestOpenMenu = {
	params ["_objSrc","_usr"];
	
	if !callFunc(_objSrc,canUseAsCraftSpace) exitWith {};
	private _allowedCateg = callFunc(_objSrc,getAllowedCraftCategories);
	if (isNullVar(_allowedCateg) || not_equalTypes(_allowedCateg,[]) || count _allowedCateg == 0) exitWith {
		errorformat("craft::requestOpenMenu() - catched unhandled error after calling: %1::getAllowedCraftCategories()",callFunc(_objSrc,getClassName));
	};	
	
	private _data = [
		getVar(_objSrc,pointer),
		getVar(_usr,pointer),
		_allowedCateg,
		[_allowedCateg select 0,_usr] call craft_data_getRecipes
	];
	
	callFuncParams(_usr,sendInfo,"openCraftMenu" arg _data);	
};	

craft_requestLoadCateg = {
	params ["_usrptr","_cat"];
	
	unrefObject(this,_usrptr,errorformat("craft::tryCraft() - Mob object has no exists virtual object - %1",_usrptr); rpcSendToObject(_usrptr,"onCraftLoadCateg",["PTR_ERR"]));
	private _list = [_cat,this] call craft_data_getRecipes;
	rpcSendToObject(_usrptr,"onCraftLoadCateg",[_cat,_list]);
	
}; rpcAdd("processLoadCatCraft",craft_requestLoadCateg);

#define craft_trycraft_debug_flag

craft_tryCraft = {
	params ["_usrptr","_srcptr","_recipeID"];
	
	unrefObject(this,_usrptr,errorformat("craft::tryCraft() - Mob object has no exists virtual object - %1",_usrptr);false);
	private _obj = pointer_get(_srcptr);
	if !pointer_isValidResult(_obj) exitWith {errorformat("craft::tryCraft() - target reference has no exists in pointers table - %1",_srcptr);false};
	
	if !(_recipeID in craft_data_allRecipes) exitWith {
		errorformat("craft::tryCraft() - Cant find recipe id - %1",_recipeID);
		false
	};
	
	[this,_obj,_recipeID] call craft_tryCraft_internal
	
}; rpcAdd("tryCraft",craft_tryCraft);

//Внутренний метод попытки крафта с отбросом всех исключений
craft_tryCraft_internal = {
	
	params ['this',"_obj","_recipeID"];
	
	private _recipe = craft_data_allRecipes get _recipeID;
	
	private _src = _obj;
	private _usr = this;
	
	_listRefsReqItems = callFunc(_recipe,collectItems);
		_listTypenamesReqItems = _listRefsReqItems apply {callFunc(_x,getClassName)};
		//_listPtrsReqItems = _listRefsReqItems apply {getVar(_x,pointer)};
	_reqItems = getVar(_recipe,reqItems);
	_reqItemPointers = []; //list of item pointers to be deleted
	_allCount = 0;
	
	{
		_x params ["_type","_amount"];
		MOD(_allCount, + _amount);
		{
			if (_type == _x) then {
				_reqItemPointers pushBack (_listRefsReqItems select _forEachIndex);
				DEC(_amount);
			};
			if (_amount <= 0) exitWith {}; //no more items
		} foreach _listTypenamesReqItems;
	} foreach _reqItems; //list of vec2(str,int)
	
	setVar(_recipe,allReqItemsAmount,_allCount);
	
	callFuncParams(_recipe,handleAdditionalItems,_listRefsReqItems - _reqItemPointers);
	
#ifdef craft_trycraft_debug_flag
	trace("--------------- craft_trycraft_debug_flag ------------------");
	traceformat("prevcount %1; cur %2",_allCount arg getVar(_recipe,allReqItemsAmount));
	traceformat("_listRefsReqItems: %1;",_listRefsReqItems);
	traceformat("ptrs: %1;",_listRefsReqItems apply {getVar(_x,pointer)});
	traceformat("_reqItemPointers: %1;",_reqItemPointers);
	traceformat("canCraft: %1;",callFunc(_recipe,canCraft));
	trace("--------------- craft_trycraft_debug_flag ------------------");
#endif
	
	private _can = callFunc(_recipe,canCraft);
	if (_can) then {
		callFunc(_recipe,onCraftSuccess);
	} else {
		callFunc(_recipe,onCraftFail);
	};
	
	_can
};


#include "Craft_initData.sqf"
//do not place here code...
//ниже кода не может быть