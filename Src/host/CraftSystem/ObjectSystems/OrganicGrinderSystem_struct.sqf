// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	
	def(getResultBasePosition)
	{
		params ["_leftComponents"]; //[[0.08,0,-0.2]]
		getVar(self getv(src),loc) modelToWorldVisual [0.08,0,-0.2]
	}

	def(playGrindSound)
	{
		callFuncParams(self getv(src),playSound,"reagents\canopen" arg getRandomPitch);
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
			
		};
	}

endstruct