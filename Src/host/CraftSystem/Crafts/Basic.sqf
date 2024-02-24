// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>
#include <..\..\ServerRpc\serverRpc.hpp>
#include <..\Craft.hpp>

/*
	Компиляция:
	Реплицируются все рецепты в виде: id рецепта, название рецепта,строка заголовка, строка доп описания.

*/
//#define DEBUG_DISTANCE_NEAREST

#define src _src
#define usr _usr

//список предметов для удаления
#define collectedItems _reqItemPointers

#ifndef EDITOR
#undef DEBUG_DISTANCE_NEAREST
#endif

class(Craft_Base) extends(RefCounterObject);
	var(name,""); //название рецепта
	var(desc,""); //нижнее описание рецепта
	var(categoryName,""); //название категории рецепта
	var(categoryID,null); //категория рецепта
	var(recipeId,-1); //уникальный айди рецепта
	
	var(reqItems,[]); //vec2 list
	var(__reqItemsName,[]);
	var(resultItem,""); //если не пустая строка то создаст итем 
	var(__resultItemName,"");
	var(resultAmount,1); //если количество больше 0 то будет создавать предмет или несколько
	
	func(constructor)
	{
		objParams();
		private _list = getSelf(__reqItemsName);
		{
			_x params ["_type","_count"];
			_list pushBack vec2(getFieldBaseValueWithMethod(_type,"name","getName"),_count)
		} foreach getSelf(reqItems);
		
		setSelf(__resultItemName,getFieldBaseValueWithMethod(getSelf(resultItem),"name","getName"));
	};
	
	//дистанция стандартного коллекционирования предметов
	var(collectNearItemsDistance,1);
	
	var_num(allReqItemsAmount); //переменная, принимающая значения сколько собрано предметов
	
	//видимость рецепта
	func(hasVisible)
	{
		objParams();
		true
	};
	
	//алгоритм сбора предметов
	func(collectItems)
	{
		objParams();
		callSelf(collectNearItems);
	};
	
	
	#define vecForward(pos,dir,bias) (pos) vectorAdd [sin (dir) * bias,cos (dir) * bias,0]
	func(collectNearItems)
	{
		objParams();
		
		#ifdef DEBUG_DISTANCE_NEAREST
		_listdel = [];
		for "_i" from 0 to 360 step 5 do {
			_newpos = vecForward(getPosATL getVar(src,loc),_i,getSelf(collectNearItemsDistance));
			_itm = "Sign_Arrow_F" createVehicle [0,0,0];
			_itm setPosAtl _newpos;
			_listdel pushBack _itm;
		};
		invokeAfterDelayParams({{deleteVehicle _x}foreach _this},10,_listdel);
		#endif
		
		callFuncParams(src,getNearItems,getSelf(collectNearItemsDistance));
	};
	
	//Позволяет обработать список оставшихся предметов, не вошедших в collectedItems
	func(handleAdditionalItems)
	{
		objParams_1(_list);
	};
	
	func(canCraft)
	{
		objParams();
		getSelf(allReqItemsAmount) == count collectedItems
	};
	
	//успешный крафт
	func(onCraftSuccess)
	{
		objParams();
		callSelf(CreateItemSTD);
	};
	
	//провальный крафт
	func(onCraftFail)
	{
		objParams();
		
	};
	
	func(conditionalDeleteSTD)
	{
		objParams_1(_obj);
		true
	};
	
	func(CreateItemSTD)
	{
		private _i = getPosATL getVar(collectedItems select 0,loc);
		callSelf(DeleteItemSTD);
		
		if (getSelf(resultItem) == "") exitWith {};
		for "_c" from 1 to getSelf(resultAmount) do {
			[getSelf(resultItem),_i,null,false] call createItemInWorld;
		};
	};
	
	func(DeleteItemSTD)
	{
		objParams();
		{
			if callSelfParams(conditionalDeleteSTD,_x) then {
				delete(_x);
			};
		} foreach collectedItems;
	};	
	
endclass


//include files here

#include "Food.sqf"




