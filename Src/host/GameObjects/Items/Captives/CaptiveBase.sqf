// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

/*
	Предмет для связывания.
	На данном этапе связанная цель может делать только:
		+ читать что-то
		+ открывать дверь незапертую
		+ брать предметы в руки
		+ садиться на стулья

	Не может:
		+ драться никак, защита тоже провал 
		+ уворачиваться
		+ снимать со слотов предметы
		- бросать что-то, воровать и любые злые действия кроме пинания вне комбата
	
	Реализовать:
		+ просмотр инвентаря
		+ связку
		+ освобождение
		+ описать метод открытия с помощью предметов
		+ наручники лочатся. не залоченные наручники можно зарезистить по лайту
			лок снимается ключом
			потом если кликнуть пустой рукой по наручникам то снимаем их в активку
		+ открывалка ключами, 
			- медленный взлом отмычками
		- развязка медленная
			- срезание холодным оружием

*/

//системные функции для кодов наручников
server_handcuff_internal_random = rand(-99,99);
server_handcuff_internal_codeToString = {
	//select [0,5] joinString "-"
	private _hashed = toarray hashValue (_this + str server_handcuff_internal_random);
	private _ret = [];
	for "_i" from 0 to 4 step 2 do {
		_ret pushBack (str (_hashed select _i) + str (_hashed select (_i+1)));
	};
	_ret joinString "-";
};

editor_attribute("InterfaceClass")
class(CaptiveItemBase) extends(Item)

	var(model,"a3\structures_f_epa\items\tools\metalwire_f.p3d");
	var(size,ITEM_SIZE_SMALL);
	//захваченная сущность
	var(captived,nullPtr);
	var(captiveDirection,0); //-1 задний захват (руками нельзя делать ничего), 1 передний хват (руками можно делать мирные действия)
	var(breakLeft,5);
	getter_func(isCaptiveBreaked,getSelf(breakLeft) <= 0);
	//var(elastic,false);
	
	var(captiveItemST,5); //сила наручников. идет как отрицательный бонус к проверке высвобождения

	//получает анимацию захвата
	func(getCaptiveAnimation)
	{
		objParams();
		//"TWcapbRcapbL"//nlRnlL not blended
		[["capb","capb"],[1,1],"TW"]
	};

	getterconst_func(canUseInteractToMethod,true);
	func(interactTo)
	{
		objParams_2(_targ,_usr);
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {};

		if !isTypeOf(_targ,Mob) exitwith {
			callFuncParams(_targ,localSay,"Это создание нельзя связать." arg "error");
		};

		//пост проверки требуются
		if !callSelf(__handcuffCheckInternal) exitwith {};

		callFuncParams(_usr,meSay,"пытается связать " + callFuncParams(_targ,getNameEx,"вин") + " с помощью " + callSelf(getName));
		
		callFuncParams(_usr,startProgress,_targ arg "item.doHandcuff" arg getVar(_usr,rta)*3 arg INTERACT_PROGRESS_TYPE_FULL arg this);
	};

	//приватный метод проверки до прогресса и после. false завершает процедуру
	func(__handcuffCheckInternal)
	{
		objParams();

		//#ifndef EDITOR
		if equals(_targ,_usr) exitwith {
			callFuncParams(_usr,localSay,"Самого себя связать не получится." arg "error");
			false
		};

		private _dir = callFuncParams(_targ,getDirectionTo,_usr);
		if (_dir != DIR_BACK && callFunc(_targ,isActive)) exitwith {
			callFuncParams(_usr,localSay,"Связать получится только со спины." arg "error");
			false
		};
		//#endif

		if (!callFuncParams(_targ,hasPart,BP_INDEX_ARM_R) || !callFuncParams(_targ,hasPart,BP_INDEX_ARM_L)) exitWith {
			callFuncParams(_usr,localSay,"Нужны две руки для связывания." arg "error");
			false
		};

		if callFunc(_targ,isHandcuffed) exitwith {
			callFuncParams(_usr,localSay,"Цель уже связана." arg "error");
			false
		};

		true
	};

	//событие связывания
	func(doHandcuff)
	{
		objParams_2(_targ,_usr); //TODO direction: forward, backward
		
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {};

		if !callSelf(__handcuffCheckInternal) exitwith {};

		callFuncParams(_usr,removeItem,this);
		setVar(_targ,handcuffObject,this);
		setSelf(captived,_targ);
		
		//sync animation and smd 
		callFuncParamsInline(_targ,setCustomAnimState,callSelf(getCaptiveAnimation));
	};

	func(doFree)
	{
		objParams_1(_dest); //dest was Mob, vec3 poss, if null then dropped to radius from mob pos

		private _usr = getSelf(captived);

		callFuncParams(getSelf(captived),setCustomAnimState,null);

		setVar(getSelf(captived),handcuffObject,nullPtr);
		setSelf(captived,nullPtr);

		//закрываем просмотр инвентаря
		callFunc(getVar(_usr,_internalEquipmentND),closeNDisplayForAllMobs);

		private __eventDrop = {
			callSelfParams(dropItemToWorld,callFunc(_usr,getPos) arg rand(0,.4) arg null arg _usr arg true); //last arg - suppress location error
		};

		if isNullVar(_dest) exitwith {call __eventDrop;};
		if equalTypes(_dest,[]) exitwith {call __eventDrop;};
		if !isTypeOf(_dest,Mob) exitwith {call __eventDrop;};
		if !callFunc(_dest,isEmptyActiveHand) exitwith {call __eventDrop};
		
		callFuncParams(_dest,addItem,this);
	};

	func(tryFree)
	{
		objParams();

		private _usr = getSelf(captived);
		if isNullReference(_usr) exitwith {};

		#ifdef EDITOR
		callFuncParams(_usr,startProgress,this arg "target.onTryingFree" arg 0.5 arg INTERACT_PROGRESS_TYPE_MEDIUM);
		#else
		callFuncParams(_usr,startProgress,this arg "target.onTryingFree" arg rand(8,12) arg INTERACT_PROGRESS_TYPE_MEDIUM);
		#endif
	};

	//внутренний обработчик попытки освобождения
	func(handleTryingFreeResult)
	{
		objParams_1(_rez);
	};

	func(onTryingFree)
	{
		objParams_1(_usr);
		
		private _usr = getSelf(captived);
		if isNullReference(_usr) exitwith {};

		private _bonus = - getSelf(captiveItemST);
		private _res = callFuncParams(_usr,checkSkill,"ST" arg _bonus);
		
		_res = getRollType(_res);
		private _staLoss = 20;
		private _breakAmount = 0;
		call {
			if (_res == DICE_CRITSUCCESS) exitwith {_breakAmount = 2;};
			if (_res == DICE_SUCCESS) exitwith {_breakAmount = 1};
			if (_res == DICE_FAIL) exitwith {};
			if (_res == DICE_CRITFAIL) exitwith {_staLoss = 30;};
		};

		if (_breakAmount > 0) then {
			setSelf(breakLeft, (getSelf(breakLeft) - _breakAmount) max 0);
			
			private _m = pick[
				"Кажется получается...",
				"Есть движения!",
				"Заскрипело...",
				"Расходится помаленьку...",
				"Получается!","Становится свободнее."
			];

			if !callSelf(isCaptiveBreaked) then {
				callFuncParams(_usr,mindSay,_m);
			} else {
				callFuncParams(_usr,mindSay,"Мне удалось освободиться от " +callSelf(getName));
			};
		};

		callSelfParams(handleTryingFreeResult,_res);

		if callSelf(isCaptiveBreaked) then {
			callSelfParams(doFree,null);
		};

		callFuncParams(_usr,addStaminaLoss,_staLoss);
	};

	//процедура освобождения 
	func(releaseHandcuff)
	{
		objParams_2(_with,_usr);
		
	};

endclass

class(HandcuffItem) extends(CaptiveItemBase)
	var(name,"Наручники");
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(dr,DR_SP_2);
	var(desc,"Собраны по архивным чертежам на Веселой Ферме.");
	var(weight,gramm(380));
	var(size,ITEM_SIZE_SMALL);
	var(allowedSlots,[INV_BELT]);
	var(captiveItemST,5);
	var(breakLeft,5);
	
	getter_func(getDropSound,vec2("UNCATEGORIZED\chain_sound",getRandomPitchInRange(.85,1.3)));
	getter_func(getPutdownSound,vec2("UNCATEGORIZED\chain_misc",getRandomPitchInRange(.85,1.3)));
	getter_func(getPickupSound,vec2("UNCATEGORIZED\chain_sound",getRandomPitchInRange(.85,1.3)));

	getter_func(getEquipSound,vec2("UNCATEGORIZED\chain_misc",getRandomPitchInRange(.85,1.3)));
	getter_func(getUnequipSound,vec2("UNCATEGORIZED\chain_misc",getRandomPitchInRange(.85,1.3)));

	editor_attribute("alias" arg "Lockers")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:128") 
	editor_attribute("Tooltip" arg "Какие типы ключей подходят к этому замку")
	var(keyLockers,""); //какие ключи подходят к этим наручникам. разделитель 
	var(isLocked,false); //защелкнуты ли наручники

	func(__handcuffCheckInternal)
	{
		objParams();
		if (!super()) exitwith {false};
		if callSelf(isCaptiveBreaked) exitwith {
			callFuncParams(_usr,localSay,callSelf(getName) + " сломаны." arg "error");
			false
		};
		true
	};

	func(doHandcuff)
	{
		objParams_2(_targ,_usr);
		super();
		callFuncParams(_usr,playSound,"UNCATEGORIZED\handcuffs" arg getRandomPitchInRange(0.9,1.3));
		setSelf(isLocked,true);
	};

	func(tryFree)
	{
		objParams();
		if !getSelf(isLocked) exitwith {
			if isNullReference(getSelf(captived)) exitwith {};
			callSelfParams(doFree,null);
		};
		super();
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr +
		callSelf(getHandcuffsCodes);
	};

	func(getHandcuffsCodes)
	{
		objParams();
		private _lockers = getSelf(keyLockers);
		private _lockerList = _lockers splitString "|";
		if (_lockers=="" || array_count(_lockerList) == 0) exitwith {"На них нет никаких серийных номеров"};

		private _str = "К ним подходят ключи: ";
		private _v = [];
		{
			_v pushBack (_x call server_handcuff_internal_codeToString);
		} foreach _lockerList;
		_str + (_v joinString "; ");
	};

	func(releaseHandcuff)
	{
		objParams_2(_with,_usr);
		
		//traceformat("release handcuff ->  %1",_this)

		if isNullVar(_with) then {_with = nullPtr};

		//действие пустой рукой
		if isNullReference(_with) exitwith {
			if getSelf(isLocked) then {
				callFuncParams(_usr,meSay,"дёргает за " + callSelf(getName) + " " + callFuncParams(getSelf(captived),getNameEx,"кого"));
			} else {
				callSelfParams(doFree,_usr);
			};
		};

		if (!isTypeOf(_with,HandcuffKey) && !isTypeOf(_with,Lockpick) && !isTypeOf(_with,KeyChain)) exitwith {
			callFuncParams(_usr,mindSay,"С этим ничего не выйдет...");
		};
		if (isTypeOf(_with,HandcuffKey) && {!callSelfParams(canOpenWithKey,_with)}) exitwith {
			callFuncParams(_usr,mindSay,"Не подходит...");
		};
		if (isTypeOf(_with,KeyChain) && {!callSelfParams(canOpenWithKeyChain,_with)}) exitwith {
			callFuncParams(_usr,mindSay,"Не подходит...");
		};
		if isTypeOf(_with,Lockpick) exitWith {
			if !getSelf(isLocked) exitWith {
				callFuncParams(_usr,mindSay,"Замок не закрыт...");
			};
			private _targ = getSelf(captived);
			callFuncParams(_usr,meSay,"начинает ковырять " + callSelf(getName) + " " + callFuncParams(getSelf(captived),getNameEx,"кого"));
			private _v = (50 / callFunc(_usr,getLockpicking));
			callFuncParams(_usr,startProgress,_targ arg "item.onTryLockpickRelease" arg rand(_v+1,_v+2) arg INTERACT_PROGRESS_TYPE_FULL arg this);
		};

		callSelfParams(doActionFreeLock,_usr);
	};

	func(doActionFreeLock)
	{
		objParams_1(_usr);
		setSelf(isLocked,false);
		callFuncParams(_usr,playSound,"UNCATEGORIZED\handcuffs" arg getRandomPitchInRange(0.9,1.3));
	};

	//событие попытки взлома отмычкой
	func(onTryLockpickRelease)
	{
		objParams_2(_targ,_usr);
		private _lockpick = callFunc(_usr,getItemInActiveHandRedirect);
		if isNullReference(_lockpick) exitWith {};
		if !isTypeOf(_lockpick,Lockpick) exitWith {
			callFuncParams(_usr,localSay,"Это не отмычка" arg "error");
		};
		if !getSelf(isLocked) exitWith {
			callFuncParams(_usr,mindSay,"Замок не закрыт...");
		};

		private _bonus = 0;
		if !callFuncParams(_usr,hasPerk,"PerkSeeInDark") then {
			if (callFunc(_usr,getLighting) < LIGHT_LARGE) then {
				modvar(_bonus) - 5;
			};
		};

		modvar(_bonus) + getVar(_lockpick,lockpickBonus);

		private _res = callFuncParams(_usr,checkSkill,"lockpicking" arg _bonus);
		_res = getRollType(_res);
		if (_res in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			callFuncParams(_usr,mindSay,"Мне удалось взломать "+callSelf(getName)+"!");
			callSelfParams(doActionFreeLock,_usr);
		} else {
			delete(_lockpick);
			callFuncParams(_usr,localSay,"Отмычка сломалась." arg "error");
		};
	};

	func(handleTryingFreeResult)
	{
		objParams_1(_rez);
		super();
		if callSelf(isCaptiveBreaked) then {
			setSelf(name,"Сломанные "+tolower getSelf(name));
		};
	};

	func(canOpenWithKey)
		{
			objParams_1(_key);
			count 
				((getSelf(keyLockers) splitString ";| ,")
				arrayIntersect
				(getVar(_key,handcuffs) splitString ";| ,"))
			> 0
		};

	func(canOpenWithKeyChain)
		{
			objParams_1(_keyChain);
			if equals(
				(getSelf(keyLockers) splitString ";| ,")
				arrayIntersect
				getVar(_keyChain,handcuffs), []
			) exitwith {false};
			true;
		};

endclass

class(HandcuffKey) extends(Key)
	var(name,"Ключ от наручников");

	editor_attribute("alias" arg "Handcuffs")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:128") 
	editor_attribute("Tooltip" arg "Тип или типы ключей, которые подходят к совместимым наручникам (с учетом регистра).\n\nЗдесь можно перечислить типы с разделителями: \n точка с запятой (;)\n запятой (" pcomma ")\n прямой чертой (|)\n пробелом ( )\n\nПример: ""key1;key2;key3""") 
	var(handcuffs,""); //какие наручники можно открыть этими ключами
	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr +
		callSelf(getHandcuffsCodes);
	};

	func(getHandcuffsCodes)
	{
		objParams();
		private _lockers = getSelf(handcuffs);
		private _lockerList = _lockers splitString ";| ,";
		if (_lockers=="" || array_count(_lockerList) == 0) exitwith {"На них нет никаких серийных номеров"};

		private _str = "Для наручников: ";
		private _v = [];
		{
			_v pushBack (_x call server_handcuff_internal_codeToString);
		} foreach _lockerList;
		_str + (_v joinString "; ");
	};
endclass

class(RopeItem) extends(CaptiveItemBase)
	var(name,"Верёвка");
	var(desc,"Простая веревка. Из чего она сделана неизвестно.");
	var(weight,gramm(57));
	var(size,ITEM_SIZE_SMALL);
	var(model,"a3\structures_f_heli\items\tools\rope_01_f.p3d");
	var(material,"MatCloth");
	
	var(captiveItemST,3);

	func(releaseHandcuff)
	{
		objParams_2(_with,_usr);
		if isNullReference(_with) exitwith {
			private _targ = getSelf(captived);
			if isNullReference(_targ) exitwith {};
			callFuncParams(_usr,startProgress,_targ arg "item.postReleaseFree" arg getVar(_usr,rta)*5 arg INTERACT_PROGRESS_TYPE_FULL arg this);
		};
	};

	func(postReleaseFree)
	{
		//objParams_2(_usr,_with);
		objParams_2(_targ,_usr);
		private _targ = getSelf(captived);
		if isNullReference(_targ) exitwith {};
		callSelfParams(doFree,_usr);
		callFuncParams(_usr,meSay,"развязывает " + callFuncParams(_targ,getNameEx,"вин"));
	};
endclass