// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

#define TRACE_MESSAGES

#ifdef TRACE_MESSAGES
	#define debug(m) trace(m)
	#define debugformat(m,f) traceformat(m,f)
#else
	#define debug(m)
	#define debugformat(m,f)
#endif

struct(FryingPanSystem) base(BaseWorldProcessorCraftSystem)
	def(systemType) "frying_pan"

	def(procStage) 0 //default, 1 found campfire, 2 found recipe, 3 cooking

	def_null(campfireTransform) //CraftSerializedTransform
	def_null(sourceTransform) //CraftSerializedTransform
	def_null(tempObjectTransform) //CraftSerializedTransform

	def(processTimeLeft) 0

	def(toString)
	{
		#ifdef EDITOR
		private _b = callbase(toString);
		text format["%1 [stage:%2, time:%3]",_b,self getv(procStage),self getv(processTimeLeft)]
		#else
		callbase(toString)
		#endif
	}

	def(init)
	{
		params ["_src"];
		self setv(sourceTransform,struct_newp(CraftSerializedTransform,_src));
		self setv(campfireTransform,struct_newp(CraftSerializedTransform,nullPtr));
		self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,nullPtr));
	}

	def(process)
	{
		private _stage = self getv(procStage);
		debugformat("frypan: curstage %1",_stage)
		if (_stage == 0) exitWith {
			self callv(findNearCampfire);
		};
		if (_stage == 1) exitwith {
			self callv(findRecipe);
		};
		if (_stage == 2) exitWith {
			self callv(processCreation);
		};
	}

	def(findNearCampfire)
	{
		private _itList = (self callp(getObjects,"IDestructible" arg 0.4))
			//filter firelights
			select {
				callFunc(_x,isFireLight)
				&& {callFunc(_x,isInWorld)}
				&& {callFunc(_x,isStruct)}
			};
		private _src = self getv(src);

		//sortby distance [near...far]
		private _nearList = [_itList,{callFunc(_x,getDistanceTo,_src)}] call sortBy;
		if (count _nearList == 0) exitWith {
			debugformat("frypan: no campfire found",_src)
			//todo optimize
			self setv(procStage,0);
		};
		private _near = _nearList select 0; //select first

		self setv(campfireTransform,struct_newp(CraftSerializedTransform,_near));
		self getv(sourceTransform) callv(updateTransform);
		self setv(procStage,1);

		debugformat("frypan: found campfire %1",_near)
	}

	def(collectDistance) 0.25;

	def(findRecipe)
	{
		//reset stage if campfire invalid
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};

		private _pos = callFunc(self getv(src),getPos);
		private _objList = self callp(getObjects,"IDestructible" arg self getv(collectDistance));
		
		debugformat("frypan: near objects: %1",_objList)
		//save context
		if ([null,_objList,self] call csys_processCraftMain) then {
			self setv(procStage,2);

			private _tempItem = ["OrganicDebris1",self getv(craftContext) get "position"] call createGameObjectInWorld;
			setVar(_tempItem,_lockedCanIgnite,true);
			self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,_tempItem));
			//allocate time
			self setv(processTimeLeft,10);
		};
	}

	def(processCreation)
	{
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0); //reset to find campfire
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};
		if !(self getv(tempObjectTransform) callv(isValid)) exitWith {
			self setv(procStage,1); //reset to find items
		};
		self modv(processTimeLeft, - 1);
		debugformat("frypan: timeleft %1",self getv(processTimeLeft))

		if ((self getv(processTimeLeft)) <= 0) then {
			delete(self getv(tempObjectTransform) getv(_origObject));
			self setv(procStage,1); //reset to found item
			debugformat("frypan: cancraft by skills: %1",self getv(craftContext) get "can_craft_by_skills")
			self callv(processCraft);
			
		};
	}

	

endstruct