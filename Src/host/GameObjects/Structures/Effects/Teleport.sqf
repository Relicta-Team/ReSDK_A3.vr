// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

teleportMobToPoint = {
	params ["_usr","_pos","_dir"];
	
	//если эту сущность тащат то отвязываем её
	if callFunc(_usr,isGrabbed) then {
		callFunc(getVar(_usr,grabber),stopAllGrab);
	};

	if callFunc(_usr,isPlayer) then {
		private _params = [_pos,_dir];
		callFuncParams(_usr,sendInfo,"tpLoad" arg _params);
	} else {
		callFuncParams(_usr,setPosServer,_pos);
		if !isNullVar(_dir) then {
			callFuncParams(_usr,setDir,_dir); 
		};
	};
};

editor_attribute("EffectClass" arg "type:teleport")
class(TeleportBase) extends(IStructNonReplicated)

	#include <..\..\Interfaces\ITrigger.Interface>
	;if (!is3DEN) then {
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	}  else {
		var(model,"VR_3DSelector_01_exit_F");
	};

	editor_attribute("EditorVisible" arg "type:float" arg "range:0:1000")
	editor_attribute("alias" arg "Teleport distance")
	editor_attribute("Tooltip" arg "На каком расстоянии работает телепорт")
	var(tDistance,1);
	var(tDelay,0.3);
	var(tCallDelay,0.5);

	//Точка назначения для телепортации
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:128")
	editor_attribute("alias" arg "Teleport exit")
	editor_attribute("Tooltip" arg "Название точки выхода телепорта.\nДля получения объекта использовать getObjectByRef()")
	var(destination,"");

	editor_attribute("InternalImpl")
	var(name,null);
	editor_attribute("InternalImpl")
	var(desc,null);
	editor_attribute("InternalImpl")
	var(weight,null);
	editor_attribute("InternalImpl")
	var(model,null);
	editor_attribute("InternalImpl")
	var(weight,null);

	func(constructor)
	{
		objParams();
		//Обязательно инициализируем телепорт
		//? до правки функция не вызывалась...
		//callSelfAfter(__initTp,2);
	};

	func(__initTp)
	{
		objParams();
		callSelfParams(setTriggerEnalbe,true);
	};

	func(onTriggerActivated)
	{
		objParams_1(_usr);
		
		private _refTo = getSelf(destination) call getObjectByRef;
		if isNullReference(_refTo) exitWith {
			errorformat("Teleport activator - reference not found: %1",getSelf(destination));
		};
		
		// if !getVar(_usr,isCloseEyes) then {
		// 	callFuncParams(_usr,setCloseEyes,true);
		// 	callFuncAfterParams(_usr,setCloseEyes,rand(0.2,0.3),false);
		// 	callFuncAfterParams(_usr,setCloseEyes,rand(0.35,0.4),true);
		// 	callFuncAfterParams(_usr,setCloseEyes,rand(0.45,0.8),false);
		// };

		private _vObj = callFunc(_refTo,getBasicLoc);
		[
			_usr,
			getposatl _vObj,//объект телепорта кривой...
			(getdir _vObj)
		] call teleportMobToPoint;
	};

endclass

editor_attribute("EffectClass" arg "type:teleport")
class(TeleportExit) extends(IStruct)

	;if (!is3DEN) then {
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	}  else {
		var(model,"VR_3DSelector_01_incomplete_F");
	};

	
	editor_attribute("InternalImpl")
	var(name,null);
	editor_attribute("InternalImpl")
	var(desc,null);
	editor_attribute("InternalImpl")
	var(weight,null);
	editor_attribute("InternalImpl")
	var(model,null);
	editor_attribute("InternalImpl")
	var(weight,null);
endclass

editor_attribute("HiddenClass")
class(TeleportInteractible) extends(IStruct)
	
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:128")
	editor_attribute("alias" arg "Teleport exit")
	editor_attribute("Tooltip" arg "Название точки выхода телепорта.\nДля получения объекта использовать getObjectByRef()")
	var(destination,"");

	func(constructor)
	{
		objParams();
		callSelfAfter(__initTPI,2);
	};

	func(__initTPI)
	{
		objParams();
		if not_equals(getSelf(destination),"") then {
			private _refTo = getSelf(destination) call getObjectByRef;
			if isNullReference(_refTo) exitWith {
				setSelf(pointTo,nullPtr);
				errorformat("Teleport interactible activator - reference not found: %1",getSelf(pointTo));
			};
			setSelf(pointTo,_refTo);
		};

	};

	getter_func(teleportDelay,2);

	var(pointTo,nullPtr); //object to

	//if true - custom pos used (for ladders)
	getter_func(isCustomEmplace,false);
	var(nearTeleportExitPos,10);
	
	getter_func(interactMessage,"");

	func(onClick)
	{
		objParams_1(_usr);
		
		//if (true) exitwith {
		///	callFuncParams(_usr,localSay,"крышка люка заварена намертво." arg "error");
		//};

		if isNullReference(getSelf(pointTo)) exitwith {};
		callFuncParams(_usr,startProgress,this arg "target.onTeleported" arg callSelf(teleportDelay) arg INTERACT_PROGRESS_TYPE_MEDIUM);
		private _interactMes = callSelf(interactMessage);
		if not_equals(_interactMes,"") then {
			callFuncParams(_usr,meSay,_interactMes);
		};
	};

	func(onTeleported)
	{
		objParams_1(_usr);
		
		private _pointTo = getSelf(pointTo);
		if isNullReference(_pointTo) exitwith {
			//trace("null point to")
		};
		
		//traceformat("tp data %1 to %2",this arg _pointTo)

		if callFunc(_pointTo,isCustomEmplace) then {
			private _nearTeleport = ["TeleportExit",getPosATL callFunc(_pointTo,getBasicLoc),getVar(_pointTo,nearTeleportExitPos),false,false] call getGameObjectOnPosition;
			if isNullReference(_nearTeleport) exitwith {
				//trace("null near exit")
			};
			
			private _vObj = callFunc(_nearTeleport,getBasicLoc);
			[
				_usr,
				getposatl _vObj,
				(getdir _vObj)
			] call teleportMobToPoint;
		} else {
			//trace("TELEPORTED")
			private _vObj = callFunc(_pointTo,getBasicLoc);
			[
				_usr,
				getposatl _vObj,
				(getdir _vObj)
			] call teleportMobToPoint;
		};
	};

	getter_func(canUseMainAction,isTypeOf(_usr,MobGhost));
	//не пустые строчки установят действие
	getter_func(getMainActionName,"Прорваться");
	//основное действие по предмету
	func(onMainAction) {
		objParams_1(_usr);
		if !callSelf(canUseMainAction) exitWith {};
		callSelfParams(onTeleported,_usr);
	};

endclass

class(LadderBase) extends(TeleportInteractible)
	var(name,"Лестница");
	var(model,"ml\ml_object_new\ml_object_2\l01_jail_ladder\l01_jail_ladder_1a.p3d");
	getter_func(isCustomEmplace,true);
	getter_func(interactMessage,"начинает карабкаться по лестнице");
	
endclass

editor_attribute("EditorGenerated")
class(WoodenLadder) extends(LadderBase)
	var(model,"ml_shabut\sbs\laddersbs.p3d");
	var(name,"Лестница");
endclass

class(SewercoverBase) extends(TeleportInteractible)
	var(name,"Люк");
	getter_func(canApplyDamage,false);
	var(material,"MatMetal");
	var(model,"a3\structures_f_exp\infrastructure\roads\sewercover_03_f.p3d");
	getter_func(interactMessage,"начинает спускаться вниз");
endclass