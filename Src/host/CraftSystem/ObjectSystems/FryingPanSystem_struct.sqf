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


struct(FryingPanSystem) base(BaseWorldProcessorCraftSystem)
	def(systemType) "frying_pan"

	def(procStage) 0 //default, 1 found campfire, 2 found recipe, 3 cooking

	def_null(campfireTransform) //CraftSerializedTransform
	def_null(sourceTransform) //CraftSerializedTransform
	def_null(tempObjectTransform) //CraftSerializedTransform


	def(weakUpdateDelay) 5
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
		params ["_src","_paramDict"];
		self setv(sourceTransform,struct_newp(CraftSerializedTransform,_src));
		self setv(campfireTransform,struct_newp(CraftSerializedTransform,nullPtr));
		self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,nullPtr));
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
				3,0
			];
			private _indexes = ["Почти готово","Поджарилось","Готовится","Только прихватилось"];
			_t = format["Там %1",lowerize(_indexes select _convInd)];
		};
		_t
	}

	def(process)
	{
		private _stage = self getv(procStage);
		debug_system("frypan: curstage %1" arg _stage)
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
		private _src = self getv(src);
		private _placed = callFunc(_src,getObjectPlace);
		private _itList = (self callp(getObjects,"IDestructible" arg 1.4));
		_itList append (self callp(getObjects,"BlackSmallStove" arg 5)); //fix for fuckedup offset of small stove
		_itList = _itList //filter firelights
			select {
				callFunc(_x,isFireLight)
				&& {callFunc(_x,isInWorld)}
				&& {callFunc(_x,isStruct)}
				&& {getVar(_x,lightIsEnabled)}
			} 
				//apply {traceformat("FIRST VALIDATE %1",_x); _x} 
			select {
				//filter 
				//если тип костёр до дистанция должна быть меньше 0.4
				if isTypeOf(_x,Campfire) then {
					//traceformat("DIST CHECK %1",callFuncParams(_x,getDistanceTo,_src))
					callFuncParams(_x,getDistanceTo,_src) <= 0.43 && {
						(callFunc(_x,getPos) select 2) <= (callFunc(_src,getPos) select 2)
					}
				} else {
					//иначе сковорода должна лежать на печи
					equals(_placed,_x)
				}
				
			} 
				//apply {traceformat("SECOND VALIDATE %1",_x); _x}
			;

		//sortby distance [near...far]
		private _nearList = [_itList,{callFuncParams(_x,getDistanceTo,_src)}] call sortBy;
		if (count _nearList == 0) exitWith {
			debug_system("frypan: no campfire found" arg _src)
			//todo optimize
			self setv(procStage,0);
		};
		private _near = _nearList select 0; //select first

		self setv(campfireTransform,struct_newp(CraftSerializedTransform,_near arg ["lightIsEnabled"]));
		self getv(sourceTransform) callv(updateTransform);
		self setv(procStage,1);

		debug_system("frypan: found campfire %1" arg _near)
	}

	def(collectDistance) 0.25; //todo decrease to 0.15
	def(modelToWorldOffset) [0,0.1,0];

	def(getObjects_getCollectPos)
	{
		if (self callv(isInWorld)) then {
			getVar(self getv(src),loc) modelToWorld (self getv(modelToWorldOffset))
		} else {
			callbase(getObjects_getCollectPos)
		};
	}

	def(findRecipe)
	{
		//reset stage if campfire invalid
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};

		//private _pos = callFunc(self getv(src),getPos);
		private _objList = self callp(getObjects,"IDestructible" arg self getv(collectDistance));
		
		debug_system("frypan: near objects: %1" arg _objList)
		//save context
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
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0); //reset to find campfire
			self setv(isActiveUpdate,false);
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
			self setv(isActiveUpdate,false);
		};
		if !(self getv(tempObjectTransform) callv(isValid)) exitWith {
			self setv(procStage,1); //reset to find items
			self setv(isActiveUpdate,false);
		};
		self modv(processTimeLeft, - 1);
		debug_system("frypan: timeleft %1" arg self getv(processTimeLeft))

		if ((self getv(processTimeLeft)) <= 0) then {
			delete(self getv(tempObjectTransform) getv(_origObject));
			self setv(procStage,1); //reset to found item
			debug_system("frypan: cancraft by skills: %1" arg self getv(craftContext) get "can_craft_by_skills")
			self callv(processCraft);
			self setv(isActiveUpdate,false);

			private _rmes = pick ["манит ароматом.","шкварчит.","испускает дивный аромат."];
			private _mes = format["%1 %2",callFunc(self getv(src),getName),_rmes];
			callFuncParams(self getv(src),worldSay,_mes arg "info");	
		};
	}

	

endstruct