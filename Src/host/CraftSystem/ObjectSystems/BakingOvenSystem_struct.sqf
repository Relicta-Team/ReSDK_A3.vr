// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

//#define ENABLE_THIS_SYSTEM_DEBUG
#include "ObjectSystem.h"

struct(BakingOvenSystem) base(BaseWorldProcessorCraftSystem)
	def(systemType) "baking_oven"

	def(procStage) 0 //disabled, inactive, find items, process
	def(processTimeLeft) 0

	def_null(sourceTransform) //CraftSerializedTransform
	def_null(tempObjectTransform) //CraftSerializedTransform

	def(collectDistance) 0.35

	def(init)
	{
		params ["_src","_paramDict"];
		self setv(sourceTransform,struct_newp(CraftSerializedTransform,_src arg ["lightIsEnabled"]));
		self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,nullPtr));
	}

	def(getObjects_getCollectPos)
	{
		private _o = getVar(self getv(src),loc);
		if isNullReference(_o) then {
			[0,0,0];
		} else {
			_o modelToWorldVisual [-0.8,0.550003,-3.7] //[[-0.8,0.550003,-3.7]]
		};
	}

	def(getDescFor)
	{
		params ["_usr"];
		private _t = "";
		if (self getv(procStage) == 2) then {
			private _convInd = round linearConversion [
				self getv(craftContext) get "duration",
				0,
				self getv(processTimeLeft),
				3,0,true
			];
			private _indexes = ["Почти готово","Припеклось","Готовится","Только прихватилось"];
			_t = format["Там %1",lowerize(_indexes select _convInd)];
		};
		_t
	}

	def(process)
	{
		private _stage = self getv(procStage);
		debug_system("stage is %1" arg _stage)
		if (_stage == 0) exitWith {
			self callv(checkEnabled);
		};
		if (_stage == 1) exitWith {
			self callv(findRecipe);
		};
		if (_stage == 2) exitWith {
			self callv(processCreation);
		};
	}

	def(checkEnabled)
	{
		if !getVar(self getv(src),lightIsEnabled) exitWith {};
		self getv(sourceTransform) callv(updateTransform);

		self setv(procStage,1);
	}

	def(findRecipe)
	{
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
			self setv(isActiveUpdate,false);
		};

		private _src = self getv(src);
		private _objList = self callp(getObjects,"IDestructible" arg self getv(collectDistance));
		
		debug_system("Near objects %1" arg _objList)

		if ([null,_objList,self] call csys_processCraftMain) then {
			self setv(procStage,2);
			self setv(isActiveUpdate,true);

			private _tempItem = ["OrganicDebris1",self getv(craftContext) get "position"] call createGameObjectInWorld;
			setVar(_tempItem,name,"Блюдо");
			setVar(_tempItem,desc,"Готовящееся " + (self getv(craftContext) get "recipe" get "name"));
			setVar(_tempItem,_lockedCanIgnite,true);
			self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,_tempItem));
			//allocate time
			self setv(processTimeLeft,self getv(craftContext) get "duration");
		};
	}

	def(processCreation)
	{
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
			self setv(isActiveUpdate,false);
		};
		if !(self getv(tempObjectTransform) callv(isValid)) exitWith {
			self setv(procStage,1);
			self setv(isActiveUpdate,false);
		};

		self modv(processTimeLeft, - 1);
		if ((self getv(processTimeLeft)) <= 0) then {
			delete(self getv(tempObjectTransform) getv(_origObject));
			self setv(procStage,1); //reset to found item
			self setv(isActiveUpdate,false);
			self callv(processCraft);
			
		};
	}

endstruct