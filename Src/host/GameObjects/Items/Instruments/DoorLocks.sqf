// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

key_sameAccess = {
	params ["_a","_b"];
	count (_a - _b) == 0 && {count (_b - _a) == 0}
};

// Explicit factory: moving/spawning a lock alone must never manufacture a key.
doorLock_createPair = {
	params ["_class","_pos",["_keyData",[]]];
	private _inWorld = equalTypes(_pos,[]);
	private _lock = ifcheck(_inWorld,[_class arg _pos] call createItemInWorld,[_class arg _pos] call createItemInContainer);
	if isNullReference(_lock) exitWith {[]};
	private _key = ifcheck(_inWorld,["Key" arg _pos vectorAdd [0.12 arg 0 arg 0]] call createItemInWorld,["Key" arg _pos] call createItemInContainer);
	if isNullReference(_key) exitWith {delete(_lock); []};
	if (count _keyData == 0) then {
		private _roll = random 100;
		private _words = ["Потёртый","Невзрачный","Кривоватый","Уродский"];
		if (_roll >= 70) then {_words = ["Красивый","Аккуратный","Бомжатский","Нарядный"]};
		if (_roll >= 95) then {_words = ["Изысканный","Щегольский","Роскошный"]};
		if (_roll >= 99) then {_words = ["Кайфовый"]};
		_keyData = [["crafted_lock:" + getVar(_lock,pointer)],(pick _words) + " ключ"];
	};
	setVar(_lock,keyTypes,array_copy(_keyData select 0));
	setVar(_key,keyOwner,array_copy(_keyData select 0));
	setVar(_key,name,_keyData select 1);
	if (!_inWorld) then {callFunc(_pos,onContainerContentUpdate)};
	[_lock,_key]
};

doorLock_deliverItem = {
	params ["_container","_type","_count"];
	if !(_type in ["DoorLock","StrongDoorLock"]) exitWith {
		callFuncParams(_container,createItemInContainer,_type arg _count)
	};
	for "_i" from 1 to _count do {[_type,_container] call doorLock_createPair};
};

class(DoorLock) extends(Item)
	var(name,"Простой замок");
	var(model,"sterben_top\am_items\misc\junk\counductor\counductor.p3d");
	var(material,"MatMetal");
	var(weight,gramm(500));
	var(size,ITEM_SIZE_SMALL);
	var(door,nullPtr);
	var(isFastened,false);
	var_array(keyTypes);
	var(lockHP,5);
	var(repairClass,"DoorLock");
	getter_func(lockGrade,1);
	getter_func(removalSkill,10);
	getter_func(removalDuration,12);
	getter_func(canPickup,isNullReference(getSelf(door)));
	var(toolWorker,nullPtr);
	var(toolItem,nullPtr);
	var(toolRemoving,false);
	var(toolFinishAt,0);
	var(handleToolUpdate,-1);
	var(nextToolSound,0);

	editor_attribute("alias" arg "Типы ключа")
	editor_attribute("EditorVisible" arg "type:string")
	var(preinit@__keyTypesStr,"");
	func(__handlePreInitVars__)
	{
		objParams();
		super();
		if (getSelf(preinit@__keyTypesStr) != "") then {
			setSelf(keyTypes,getSelf(preinit@__keyTypesStr) splitString ";| ,");
		};
	};

	func(getBasicLoc)
	{
		objParams();
		private _door = getSelf(door);
		if !isNullReference(_door) exitWith {
			(getVar(_door,loc) getVariable ["doorLockMeshes",[]]) param [0,getVar(_door,loc)]
		};
		super()
	};

	func(destructor)
	{
		objParams();
		callSelf(clearToolWork);
	};

	func(onClick)
	{
		objParams_1(_usr);
		if isNullReference(getSelf(door)) exitWith {super()};
		if getSelf(isFastened) exitWith {callFuncParams(_usr,localSay,"Замок прикручен к двери." arg "error")};
		if (callFuncParams(_usr,getDistanceTo,this) > 2) exitWith {callFuncParams(_usr,localSay,"Слишком далеко." arg "error")};
		callFunc(getSelf(door),releaseDoorLock);
		callFuncParams(_usr,pickupItem,this);
		callFuncParams(_usr,mindSay,"Я снял замок с двери.");
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		private _door = getSelf(door);
		if isNullReference(_door) exitWith {};
		if (callFuncParams(_usr,getDistanceTo,this) > 2) exitWith {callFuncParams(_usr,localSay,"Слишком далеко." arg "error")};
		if isTypeOf(_with,Screwdriver) exitWith {
			callSelfParams(startToolWork,_usr arg _with);
		};
		if (!getSelf(isFastened) || {callSelf(lockGrade) == 0}) exitWith {callFuncParams(_usr,localSay,"Этот замок сейчас нельзя использовать." arg "error")};
		if (isTypeOf(_with,Key) || isTypeOf(_with,KeyChain)) exitWith {
			private _access = ifcheck(isTypeOf(_with,Key),getVar(_with,keyOwner),getVar(_with,keyOwners));
			if (count (_access arrayIntersect getSelf(keyTypes)) == 0) exitWith {
				callFuncParams(_usr,localSay,"Ключ не подходит." arg "error");
			};
			if callFuncParams(_door,setDoorLock,!getVar(_door,isLocked)) then {
				callFuncParams(_usr,mindSay,ifcheck(getVar(_door,isLocked),"Я запер дверь.","Я отпер дверь."));
			} else {
				callFuncParams(_usr,localSay,"Замок не сработал." arg "error");
			};
		};
		if (callSelf(lockGrade) == 3) exitWith {callFuncParams(_usr,localSay,"Этот замок не поддаётся." arg "error")};
		if isTypeOf(_with,Lockpick) exitWith {callSelfParams(startLockpick,_usr arg _with)};
		if isTypeOf(_with,Crowbar) then {callFuncParams(_usr,localSay,"Ломом надо давить на дверь, а не на замок." arg "error")};
	};

	func(startLockpick)
	{
		objParams_2(_usr,_pick);
		private _door = getSelf(door);
		if (!getVar(_door,isLocked) || {getVar(_door,isOpen)}) exitWith {callFuncParams(_usr,localSay,"Нечего взламывать." arg "error")};
		if (!equals(callFunc(_usr,getItemInActiveHandRedirect),_pick) || {callFuncParams(_usr,getDistanceTo,this) > 2}) exitWith {callFuncParams(_usr,localSay,"Не получается дотянуться до замка с отмычкой." arg "error")};
		if (callSelf(lockGrade) == 2 && {callFunc(_usr,getLockpicking) < 15}) exitWith {
			callFuncParams(_usr,localSay,"Этот замок мне не по силам." arg "error");
		};
		private _duration = 50 / (callFunc(_usr,getLockpicking) max 1);
		callFuncParams(_usr,meSay,"начинает возиться с отмычкой.");
		callFuncParams(_usr,startProgress,this arg "target.finishLockpick" arg rand(_duration+1,_duration+2) arg INTERACT_PROGRESS_TYPE_MEDIUM arg _pick);
	};

	func(finishLockpick)
	{
		objParams_2(_usr,_pick);
		private _door = getSelf(door);
		if (isNullReference(_door) || {isNullReference(_pick)}) exitWith {};
		if (!getSelf(isFastened) || {!getVar(_door,isLocked)} || {getVar(_door,isOpen)}) exitWith {};
		if (callSelf(lockGrade) == 3 || {callSelf(lockGrade) == 0}) exitWith {};
		if (callSelf(lockGrade) == 2 && {callFunc(_usr,getLockpicking) < 15}) exitWith {};
		if (!equals(callFunc(_usr,getItemInActiveHandRedirect),_pick) || {callFuncParams(_usr,getDistanceTo,this) > 2}) exitWith {};
		private _bonus = getVar(_pick,lockpickBonus);
		if (!callFuncParams(_usr,hasPerk,"PerkSeeInDark") && {callFunc(_usr,getLighting) < LIGHT_LARGE}) then {_bonus = _bonus - 5};
		private _roll = callFuncParams(_usr,checkSkill,"lockpicking" arg _bonus);
		if (getRollType(_roll) in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			callFuncParams(_door,setDoorLock,false arg false);
			callFuncParams(_usr,mindSay,"Мне удалось взломать замок!");
		} else {
			delete(_pick);
			callFuncParams(_usr,localSay,"Отмычка сломалась." arg "error");
		};
	};

	getter_func(getMainActionName,"Снять замок");
	func(canUseMainAction)
	{
		objParams();
		private _tool = callFunc(_usr,getItemInActiveHandRedirect);
		getSelf(isFastened) && {!isNullReference(_tool)} && {isTypeOf(_tool,Screwdriver)}
	};
	func(onMainAction)
	{
		objParams_1(_usr);
		if !callSelf(canUseMainAction) exitWith {};
		callSelfParams(startToolWork,_usr arg callFunc(_usr,getItemInActiveHandRedirect));
	};

	func(startToolWork)
	{
		objParams_2(_usr,_tool);
		if (callSelf(lockGrade) == 0 || {isNullReference(getSelf(door))}) exitWith {callFuncParams(_usr,localSay,"Этот замок не прикреплён к двери." arg "error")};
		if (!isTypeOf(_tool,Screwdriver) || {!equals(callFunc(_usr,getItemInActiveHandRedirect),_tool)}) exitWith {callFuncParams(_usr,localSay,"Нужна отвёртка в активной руке." arg "error")};
		if (callFuncParams(_usr,getDistanceTo,this) > 2) exitWith {callFuncParams(_usr,localSay,"Слишком далеко." arg "error")};
		if getVar(getSelf(door),isLocked) exitWith {callFuncParams(_usr,localSay,"Сначала надо отпереть дверь." arg "error")};
		private _removing = getSelf(isFastened);
		if (_removing && {callSelf(lockGrade) == 3 || {callFunc(_usr,getRepair) < callSelf(removalSkill)}}) exitWith {
			callFuncParams(_usr,localSay,"Не могу снять этот замок." arg "error");
		};
		if !isNullReference(getSelf(toolWorker)) exitWith {callFuncParams(_usr,localSay,"С замком уже работают." arg "error")};
		private _duration = ifcheck(_removing,callSelf(removalDuration),6);
		setSelf(toolWorker,_usr);
		setSelf(toolItem,_tool);
		setSelf(toolRemoving,_removing);
		setSelf(toolFinishAt,tickTime + _duration);
		setSelf(nextToolSound,0);
		callFuncParams(_usr,meSay,ifcheck(_removing,"начинает откручивать замок.","начинает прикручивать замок."));
		callFuncParams(_usr,startProgress,this arg "target.finishToolWork" arg _duration arg INTERACT_PROGRESS_TYPE_FULL arg _tool);
		callSelfParams(startUpdateMethod,"updateToolWork" arg "handleToolUpdate");
	};

	func(clearToolWork)
	{
		objParams();
		private _usr = getSelf(toolWorker);
		if (!isNullReference(_usr) && {equals(getVar(_usr,progressData) select 0,this)} && {(getVar(_usr,progressData) select 1) == "target.finishToolWork"}) then {callFuncParams(_usr,stopProgress,true)};
		setSelf(toolWorker,nullPtr);
		setSelf(toolItem,nullPtr);
		callSelfParams(stopUpdateMethod,"handleToolUpdate");
	};

	func(isToolWorkValid)
	{
		objParams();
		private _usr = getSelf(toolWorker);
		private _door = getSelf(door);
		if (isNullReference(_usr) || {isNullReference(_door)} || {isNullReference(getSelf(toolItem))}) exitWith {false};
		!getVar(_door,isLocked) && {equals(getSelf(isFastened),getSelf(toolRemoving))} &&
		{equals(callFunc(_usr,getItemInActiveHandRedirect),getSelf(toolItem))} &&
		{callFuncParams(_usr,getDistanceTo,this) <= 2}
	};

	func(updateToolWork)
	{
		updateParams();
		private _usr = getSelf(toolWorker);
		if (!callSelf(isToolWorkValid) || {!equals(getVar(_usr,progressData) select 0,this)}) exitWith {callSelf(clearToolWork)};
		if (tickTime >= getSelf(nextToolSound)) then {
			callSelfParams(playSound,"doors\lockswitch" arg getRandomPitchInRange(0.8,1.2) arg 10);
			setSelf(nextToolSound,tickTime + 2);
		};
	};

	func(finishToolWork)
	{
		objParams_2(_usr,_tool);
		if (!equals(_usr,getSelf(toolWorker)) || {tickTime < getSelf(toolFinishAt)}) exitWith {};
		if !callSelf(isToolWorkValid) exitWith {callSelf(clearToolWork)};
		private _removing = getSelf(toolRemoving);
		if (_removing && {callFunc(_usr,getRepair) < callSelf(removalSkill)}) exitWith {callSelf(clearToolWork)};
		private _roll = callFuncParams(_usr,checkSkill,"repair" arg ifcheck(_removing,0,2));
		callSelf(clearToolWork);
		if (getRollType(_roll) in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			if (_removing) then {
				callFunc(getSelf(door),releaseDoorLock);
				callFuncParams(_usr,mindSay,"Я снял замок.");
			} else {
				setSelf(isFastened,true);
				callFuncParams(_usr,mindSay,"Я надёжно прикрутил замок.");
			};
		} else {
			callFuncParams(_usr,localSay,"Не получилось. Можно попробовать ещё." arg "error");
		};
	};

	func(applyDamage)
	{
		objParams_4(_amount,_type,_pos,_cause);
		private _grade = callSelf(lockGrade);
		if (_grade == 0 || {_grade == 3}) exitWith {};
		if (_grade == 2 && {_type != DAMAGE_TYPE_BLAST}) exitWith {};
		modSelf(lockHP,-(_amount max 0));
		if (getSelf(lockHP) <= 0) then {callSelf(breakLock)};
	};

	func(onBulletAct)
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_bullet);
		if (callSelf(lockGrade) != 1 || {callFunc(_bullet,isNonLethalAmmo)}) exitWith {};
		callSelfParams(applyDamage,D6 arg _type);
	};

	func(breakLock)
	{
		objParams();
		private _pos = callSelf(getPos);
		private _door = getSelf(door);
		private _broken = new(BrokenDoorLock);
		setVar(_broken,repairClass,ifcheck(callSelf(lockGrade) == 2,"StrongDoorLock","DoorLock"));
		setVar(_broken,keyTypes,array_copy(getSelf(keyTypes)));
		if !isNullReference(_door) then {callFunc(_door,releaseDoorLock)};
		callFuncParams(_broken,loadModel,_pos arg null arg 0 arg true);
		delete(this);
	};
endclass

class(StrongDoorLock) extends(DoorLock)
	var(name,"Прочный замок");
	var(lockHP,20);
	getter_func(lockGrade,2);
	getter_func(removalSkill,12);
	getter_func(removalDuration,20);
endclass

class(StoryDoorLock) extends(DoorLock)
	var(name,"Сюжетный замок");
	getter_func(lockGrade,3);
endclass

class(BrokenDoorLock) extends(DoorLock)
	var(name,"Сломанный замок");
	var(desc,"Его можно починить на слесарном верстаке.");
	getter_func(lockGrade,0);
endclass
