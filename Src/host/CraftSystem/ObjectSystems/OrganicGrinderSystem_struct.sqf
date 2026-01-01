// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	organic_grinder
	Система давки мяса
*/

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

#include "ObjectSystem.h"

struct(OrganicGrinderSystem) base(BaseInternalCraftSystem)
	def(systemType) "organic_grinder"
	
	def(moveIngredient)
	{
		params ["_ingr","_usr"];
		if (count (self getv(_ingredients)) >= 5) exitWith {
			callFuncParams(_usr,localSay,"Не поддаётся. Надо сначала вытащить прокрученное." arg "error");
		};
		callbase(moveIngredient);
	}

	def(getResultBasePosition)
	{
		params ["_leftComponents"]; //[[0.08,0,-0.2]]
		getVar(self getv(src),loc) modelToWorldVisual [0.08,0,-0.2]
	}

	def(getDescFor)
	{
		params ["_usr"];
		private _itCount = count (self getv(_ingredients));
		if (_itCount == 0) then {"Там пусто."} else {
			format[
				pick[
					"Там %1",
					"Ещё %1","Осталось %1",
					"Загружено %1",
					"%1 хранится внутри"
				],
				[_itCount,["штука","штуки","штук"],true] call toNumeralString
			]
		};
	}

	def(playGrindSound)
	{
		private _src = self getv(src);
		callFuncParams(_src,playSound,"reagents\canopen" arg getRandomPitch);
		if (count (self getv(_ingredients)) > 0) then {
			private _mes = pick ["кряхтит.","работает.","крутит кушанья.","вертит яства."];
			callFuncParams(_src,worldSay,callFunc(_src,getName) + " " +_mes arg "info");	
		};
	}

	def(canAddIngredient)
	{
		params ["_ingr"];
		callFunc(_ingr,isFood)
	}

	//grind process
	def(process)
	{
		private _objListCollection = self callv(getObjects);
		
		if ([null,_objListCollection,self] call csys_processCraftMain) then {
			
			private _objList = self callv(processCraft);
			
			self callv(playGrindSound);
			private _ignoredList = [self getv(src)];
			_ignoredList append _objList;
			{
				private _itsDat = callFuncParams(_x,getNewTransform,null arg null arg 2.5 arg _ignoredList);
				
				private _newpos = _itsDat select 1;
				callFuncParams(_x,changePosition,_newpos);
			} foreach _objList;
			
		} else {
			if (count (self getv(_ingredients)) > 0) then {
				
				self callv(playGrindSound);

				private _ingr = (self getv(_ingredients)) deleteAt 0;
				private _typeList = callFunc(_ingr,getOnDestroyTypes);
				if (count _typeList == 0) exitWith {
					delete(_ingr);
				};
				
				private _countCreate = callFunc(_ingr,getOnDestroyCountCreate);
				if (_countCreate > 0) then {
					private _type = pick _typeList;
					private _startPos = self callv(getResultBasePosition);
					private _wobj = [_type,_startPos] call createGameObjectInWorld;
					private _ignList = [self getv(src),_wobj];
					private _itsDat = callFuncParams(_wobj,getNewTransform,null arg null arg 2.5 arg _ignList);
					private _newpos = _itsDat select 1;
					callFuncParams(_wobj,changePosition,_newpos);
					callFuncParams(_wobj,setHPCurrentPrecentage,randInt(2,15));
				};

				delete(_ingr);
			};
		};
	}

endstruct