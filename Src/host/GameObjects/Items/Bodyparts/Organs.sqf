// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(Organ) extends(Item)
	var(material,"MatFlesh");
	var(dr,0);
	var(germs,-1);//без микробов на старте
	var_bool(isVital);
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_HEART); //для какого слота этот орган
	var(status,ORGAN_STATUS_OK); //все органы у кого статус >= ORGAN_STATUS_DAMAGED не работают (повреждённые)

	getter_func(getPickupSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getPutdownSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getDropSound,"flesh\flesh_drop");
	getter_func(getEquipSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getUnequipSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);


	func(link)
	{
		objParams_3(_target,_location,_ctx);
		
		private _canLink = true;
		private _implOrganAdd = {};
		
		call {
			if isTypeOf(_target,Body) exitWith {
				private _mob = getVar(_target,loc);
				if isNullReference(_mob) exitWith {_canLink = false};
				if callFuncParams(_mob,hasBodyOrgan,_location) exitWith {_canLink = false};
				
				_implOrganAdd = {
					getVar(_target,organs) set [_location,this];
					setSelf(loc,_target);
				};
			};
			if isTypeOf(_target,Head) exitWith {
				_canLink = false;//TODO implement head linking
			};
			_canLink =false;
		};
		
		if (!_canLink) exitWith {false};
		
		//сначала выгружаем объект из мира
		call {
			if (callSelf(isInWorld)) exitWith {
				callSelf(unloadModel);
			};
			private _probloc = callSelf(getSourceLoc);
			if callFunc(_probloc,isMob) exitWith {
				callFuncParams(_probloc,removeItem,this);
			};
			
			_canLink = false;
		};
		
		if (!_canLink || toString _implOrganAdd == "") exitWith {false};		
		
		call _implOrganAdd;
		callSelfParams(onOrganLinked,_target);
		
		true
	};
	
	
	//приаттаченный орган (считается как сшитый)
	var(isAttached,false);
	
	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = super();
		private _delegate_defaultText = {
			_txt + sbr + (if callSelf(isStatusOk) then {
				"<t color='#61FF61'>Нормальное состояние.</t>"
			} else {
				if callSelf(isStatusDestroyed) exitWith {
					"<t color='#A12757'>Полностью уничтожен.</t>"
				};
				"<t color='#B03896'>Имеет повреждения.</t>"
			})
		};
		if callSelf(isInWorld) exitWith _delegate_defaultText;
		private _src = getSelf(loc);
		if (!isTypeOf(_src,Head) && !isTypeOf(_src,Body)) exitWith _delegate_defaultText;
		private _surgery = callFunc(_usr,getSurgery);
		if (_surgery <= 7) exitWith {_txt + sbr + "Состояние органа не понятно..."};
		
		//информация об органе внутри тела
		_txt + sbr + (if getSelf(isAttached) then {
			"<t color='#61FF61'>Сосуды соединены.</t>"
		} else {
			"<t color='#CC8789'>Сосуды не соединены.</t>"
		}) + sbr + (if callSelf(isStatusOk) then {
			"<t color='#61FF61'>Функционирует.</t>"
		} else {
			if callSelf(isStatusDestroyed) exitWith {
				"<t color='#A12757'>Полностью уничтожен.</t>"
			};
			"<t color='#B03896'>Имеет повреждения.</t>"
		})
	};
	
	func(unlink)
	{
		objParams_1(_target);
		private _mob = callSelf(getSourceLoc);
		private _allOrgans = getVar(getSelf(loc),organs);
		private _organIdx = -1;
		
		{
			if equals(_y,this) exitWith {_organIdx = _x};
		} foreach _allOrgans;
		
		if (_organIdx == -1) exitWith {
			errorformat("cant unlink organ %1 - unknown index",callSelf(getClassName));
		};
		_allOrgans set [_organIdx,nullPtr];
		setSelf(loc,nullPtr);
		callSelfParams(onOrganUnlinked,_mob);
		setSelf(isAttached,false);
		private _doDelete = isNullVar(_target);
		
		if (_doDelete) exitWith {
			delete(this);
		};
		
		if equalTypes(_target,[]) exitWith {
			[this,_target] call noe_loadVisualObject;			
		};
		if equalTypes(_target,objNUll) exitWith {
			[this,_target] call noe_loadVisualObject_OnDrop;
			callFuncParams(this,onDrop,nullPtr);
		};
		if isImplementFunc(_target,addItem) exitWith {
			if callFuncParams(_target,canMoveInItem,this) then {
				callFuncParams(_target,onMoveInItem,this);
			} else {
				[this,getVar(_target,owner)] call noe_loadVisualObject_OnDrop;
				callFuncParams(this,onDrop,_target);
			};
		};
		
		errorformat("Cant allocate new position for %1<%2>",this arg getSelf(pointer));
		delete(this);
	};

	func(onOrganLinked)
	{
		objParams_1(_usr);
		setVar(_usr,weight,getVar(_usr,weight) + getSelf(weight));
		callSelfParams(onRecalcBloodLoss,_usr);
	};


	func(onOrganUnlinked)
	{
		objParams_1(_usr);
		
		if getSelf(isVital) then {
			callFuncParams(_usr,Die,vec2(di_organDamage,_usr))
		};
		
		setVar(_usr,weight,getVar(_usr,weight) - getSelf(weight));
		callSelfParams(onRecalcBloodLoss,_usr);
	};

	func(setStatus)
	{
		objParams_1(_newStatus);
		if (_newStatus == getSelf(status)) exitWith {};

		setSelf(status,_newStatus);
		setSelf(lastStatusChange,tickTime);

		/*#ifdef EDITOR
		if (_newStatus == ORGAN_STATUS_OK) then {setSelf(lastStatusChange,0)};
		#endif*/

		callSelfParams(onRecalcBloodLoss,null);
	};

	func(onRecalcBloodLoss)
	{
		objParams_1(_m);
		if isNullVar(_m) then {_m = callSelf(getSourceLoc)};
		if !isNullReference(_m) then {
			callFunc(_m,recalcBloodLoss);
		};
	};

	func(getBloodLossValue)
	{
		objParams();
		if callSelf(isStatusDamaged) exitWith {BLOOD_LOSS_ORGAN_DAMAGED};
		if callSelf(isStatusDestroyed) exitWith {BLOOD_LOSS_ORGAN_DESTROYED};
		0
	};

	//Время последнего изменения статуса органа
	var(lastStatusChange,0);
	getter_func(isStatusOk,getSelf(status) == ORGAN_STATUS_OK);
	getter_func(isStatusDamaged,getSelf(status) == ORGAN_STATUS_DAMAGED);
	getter_func(isStatusDestroyed,getSelf(status) == ORGAN_STATUS_DESTROYED);
	//Может ли орган быть захилен
	getter_func(canHeal,callSelf(isStatusDamaged) && {tickTime > (getSelf(lastStatusChange) + ORGAN_HEAL_TIMEOUT)});

	func(getOrganPain)
	{
		objParams();
		private _status = getSelf(status);
		if (_status == ORGAN_STATUS_DAMAGED) exitWith {3};
		if (_status == ORGAN_STATUS_DESTROYED) exitWith {4};
		0
	};

	//Переводит орган в следующий уровень повреждения
	func(addDamage)
	{
		objParams();
		private _stat = getSelf(status);
		call {
			if (_stat == ORGAN_STATUS_OK) exitWith {
				callSelfParams(setStatus,ORGAN_STATUS_DAMAGED);

				if getSelf(isVital) then {
					callSelf(onVitalDamaged);
				};

				private _o = callSelf(getSourceLoc);

			};
			if (_stat == ORGAN_STATUS_DAMAGED) exitWith {
				callSelfParams(setStatus,ORGAN_STATUS_DESTROYED);
				private _o = callSelf(getSourceLoc);
				//даём мобу самую сильную боль за уничтоженный орган
				if !isNullReference(_o) then {
					callFuncParams(_o,addPainLevel,PAIN_LEVEL_MAX arg callSelf(getOrganBodyPart));
				};
			};
			//todo if destroyed do pain??
		};
	};

	func(addRegen)
	{
		objParams();
		private _stat = getSelf(status);
		if (_stat == ORGAN_STATUS_DAMAGED) exitWith {
			callSelfParams(setStatus,ORGAN_STATUS_OK);
		};
		//no heal if status ok or destroyed
	};

	func(onVitalDamaged)
	{
		objParams();
	};

	getter_func(canUpdate,getSelf(isAttached) && !getVar(_usr,isDead));

	//internal function update. _usr is current user
	func(onUpdate)
	{
		objParams();
		//THIS IS ABSTRACT METHOD. DO NOT IMPLEMENT
		//error("Organ::onUpdate() -> THIS IS ABSTRACT METHOD. DO NOT IMPLEMENT THIS");
	};

	//private method. do not call outside
	func(handle_heal)
	{
		if callFunc(_usr,isSleep) then {
			callSelfParams(healOrgan,ORGAN_REGEN_TIME_PRE_SECOND);
		} else {
			callSelfParams(healOrgan,-1);//ничего не происходит пока перс не спит
		};

		if callSelf(canHeal) then {
			callSelf(addRegen);
		};
	};

	func(healOrgan)
	{
		objParams_1(_timeDel);

		if callSelf(isStatusDamaged) then {
			modSelf(lastStatusChange, - _timeDel);
		};
	};

endclass

class(ITwoSidedOrgan) extends(Organ)
	var(side,-1); //-1 left,1 right

	func(constructor)
	{
		objParams();
		if (ctxParams isEqualType 0) then {
			if (ctxParams > 0) then {
				setSelf(side,1);
			} else {
				setSelf(side,-1);
			};
		};
	};

	func(getSideName)
	{
		objParams();
		if (getSelf(side) > 0) then {"Правая"} else {"Левая"}
	};

	func(getName)
	{
		objParams();
		callSelf(getSideName) + " " + callSuper(Organ,getName)
	};
endclass

editor_attribute("InterfaceClass")
class(VitalOrgan) extends(Organ)
	var(name,"Жизненно важный орган");
	var(isVital,true);

	func(onVitalDamaged)
	{
		objParams();
		private _loc = callSelf(getSourceLoc);

		if !isNullObject(_loc) then {
			callFuncParams(_loc,Die,vec2(di_organDamage,this));
		};
	};

endclass

/*
=====================================
	CATEGORY: HEAD ORGANS
=====================================
*/
class(Brain) extends(VitalOrgan)
	var(model,"relicta_models\models\anatomy\brain\brain.p3d");
	var(icon,invicon(brain));
	var(name,"Мозг");
	var(desc,"Кто-то решил выбросить все свои знания.");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(450));
	getterconst_func(getOrganBodyPart,BP_INDEX_HEAD);
	var(memories,new(VirtualMemoryStorage));

	func(desctructor)
	{
		objParams();
		delete(getSelf(memories));
	};

endclass

	editor_attribute("HiddenClass")
	class(VirtualMemoryStorage) extends(object)

		var(originalOwner,nullPtr); //базовый владелец воспоминаний (моб)
		var(currentOwner,nullPtr); //текущий владелец воспоминаний (моб)

		var_array(messages); //полученные сообщения

		var(canKnownSelf,true); //помнит ли информацию о себе

		func(addMemory)
		{
			objParams_1(_mem);
			getSelf(messages) pushBack _mem;
		};

		func(removeMemory)
		{
			objParams_1(_mind);
			private _marr = getSelf(messages);
			if (_mind < 0 || _mind >= count _marr) exitWith {false};
			if (count _marr == 0) exitWith {false};
			_marr deleteAt _mind;
			true
		};

		func(constructor)
		{
			objParams();
		};

		func(desctructor)
		{
			objParams();
		};

	endclass

class(Tongue) extends(Organ)
	var(name,"Язык");
	var(icon,invicon(tongue));
	var(model,"relicta_models\models\anatomy\tongue.p3d");
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(10));
	getterconst_func(getOrganBodyPart,BP_INDEX_HEAD);
endclass

class(Eye) extends(ITwoSidedOrgan)
	var(name,"Глаз");
	var(icon,invicon(eye));
	var(model,"relicta_models\models\anatomy\eye.p3d");
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(5));
	getterconst_func(getOrganBodyPart,BP_INDEX_HEAD);
	func(onOrganLinked)
	{
		objParams_1(_usr);
		setVar(_usr,weight,getVar(_usr,weight) + getSelf(weight));
	};


	func(onOrganUnlinked)
	{
		objParams_1(_usr);
		setVar(_usr,weight,getVar(_usr,weight) - getSelf(weight));
		//todo ограниченное поле обзора
	};
endclass

/*
=====================================
	CATEGORY: BODY ORGANS
=====================================
*/
class(Heart) extends(VitalOrgan)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_HEART);
	var(name,"Сердце");
	var(icon,invicon(heart));
	var(model,"relicta_models\models\anatomy\hearth.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(900));
	
	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);
			
			if callSelf(isStatusOk) then {
				//тут можно крутить логику генерации крови
			} else {
				private _rr = getRollType(callFuncParams(_usr,checkSkill,"ht" arg 2));//совсем немного бонуса для сердца
				if DICE_ISFAIL(_rr) then {
					private _m = pick["В груди болит","Сердечко...","В груди больно"];
					callFuncParams(_usr,mindSay,_m);
				};
				if (_rr == DICE_FAIL) exitWith {
					callFuncParams(_usr,addHP, - 1);
				};
				if (_rr == DICE_CRITFAIL) exitWith {
					callFuncParams(_usr,addHP, - 2);
				};
			};
		};

	};

endclass

class(Liver) extends(Organ)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_LIVER);
	var(name,"Печень");
	var(icon,invicon(liver));
	var(model,"relicta_models\models\anatomy\liver\liver.p3d");
	var(weight,1.4);
	var(size,ITEM_SIZE_SMALL);
	var(nextCheckTime,0); //для рвоты кровью
	
	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);
			
			if callSelf(isStatusOk) then {
				//rem alco
				callFuncParams(_usr,adjustToxin,-4);
			} else {
				private _mod = 0;
				if callSelf(isStatusDestroyed) then {
					modvar(_mod) - 4;
				};
				
				private _t = getSelf(nextCheckTime);
				if (tickTime > _t) then {
					private _rt = getRollType(callFuncParams(_usr,checkSkill,"ht" arg _mod));
					if DICE_ISFAIL(_rt) then {
						callFunc(_usr,vomitBlood);
						setSelf(nextCheckTime,tickTime + randInt(10,60));
					};
				};

				callFuncParams(_usr,adjustToxin,randInt(2,4));
			};
		};
	};
endclass

class(Kidney) extends(ITwoSidedOrgan)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,vec2(BO_INDEX_KIDNEY_L,BO_INDEX_KIDNEY_R) select sideToIndex(getSelf(side)));
	var(name,"Почка");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(750));
	var(icon,invicon(kidney));
	var(model,"relicta_models\models\anatomy\kidneyleft.p3d");
	
	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);

			if callSelf(isStatusOk) then {
				//rem toxins
				callFuncParams(_usr,adjustToxin, - 1);
			} else {
				callFuncParams(_usr,adjustToxin, randInt(1,5));
				if callSelf(isStatusDamaged) then {
					//add pee
				};
			};
		};
	};
endclass

editor_attribute("InterfaceClass")
class(IOrganContainer) extends(Organ)
	#include "..\..\Interfaces\IContainer.Interface"
	var(countSlots,20);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(Guts) extends(IOrganContainer)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_GUTS);
	var(name,"Кишки");
	var(icon,invicon(guts));
	var(model,"relicta_models\models\anatomy\kishki.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,1.7);
	
	func(constructor)
	{
		objParams();
		callSelfParams(createItemInContainer,"Poo" arg randInt(2,6));
	};
	
	//Добавляет предмет в начало контейнера (фек приходит с начальной стороны)
	func(addItemToStartContent)
	{
		objParams_1(_item);

		private _content = getSelf(content);
		reverse _content;

		if (!callSuper(IOrganContainer,addItem)) exitWith {
			reverse _content;
			false
		};
		reverse _content;

		true
	};
	var(nextCheckTime,0);
	
	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);

			if !callSelf(isStatusOk) then {
				callFuncParams(_usr,adjustToxin, 3);
				//add feces
			};
		};
	};

endclass

class(Stomach) extends(IOrganContainer)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_STOMACH);
	var(name,"Желудок");
	var(icon,invicon(stomach));
	var(model,"relicta_models\models\anatomy\stomach.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(500));

	var(countSlots,80);
	var(maxSize,ITEM_SIZE_MEDIUM);

	func(canAdd)
	{
		objParams_1(_item);
		private _can = callSuper(IOrganContainer,canAdd);
		if callFunc(getSelf(loc),isMob) exitWith {
			if (!_can) then {
				//TODO: add vomit
			};
			true
		};
		_can
	};

	#include "..\..\Interfaces\IReagentContainer.Interface"
	var(reagents,vec2(this,130) call ms_create); //4 литра


	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);
			
			//очень много low-level code... всё в угоду оптимизации
			_ms = getSelf(reagents);
			_matterObj = null; __amount__ = 0;
			this = _usr;
			{
				_matterObj = getMatter(_x);
				__amount__ = ms_getMatterList(_ms) get _x;
				[_ms,_x,_matterObj get "metabolism"] call ms_removeMatter;
				if (__amount__ >= (_matterObj get "overdose")) then {
					call (_matterObj get "onOverdosed");
				};
				call (_matterObj get "onAssimIngest");
			} foreach (keys ms_getMatterList(_ms));
		};
	};

endclass

class(Lungs) extends(VitalOrgan)
	getterconst_func(getOrganBodyPart,BP_INDEX_TORSO);
	getter_func(getOrganSocketName,BO_INDEX_LUNGS);
	var(isVital,true);
	var(name,"Легкие");
	var(icon,invicon(lungs));
	var(model,"relicta_models\models\anatomy\legkie\legkie.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,1.5);

	func(onUpdate)
	{
		objParams();
		if callSelf(canUpdate) then {

			callSelf(handle_heal);

			private _checkLovVal = false;
			//breath
			if callFunc(_usr,canBreath) then {
				if callSelf(isStatusOk) then {
					if (getVar(_usr,oxygen)<100) then {
						callFuncParams(_usr,adjustOxyLoss,+randInt(2,4));
					};
				} else {
					callFuncParams(_usr,adjustOxyLoss,-randInt(1,2));
					
					_checkLovVal = true;
				};
			} else {
				callFuncParams(_usr,adjustOxyLoss,-randInt(1,2));
				_oxy = getVar(_usr,oxygen);
				if (_oxy<=10) then {
					if getVar(_usr,isHoldedBreath) then {
						callFuncParams(_usr,setHoldBreath,false);
					};
				};
				_checkLovVal = true;
			};

			if (getVar(_usr,oxygen)<=3) then {
				callFuncParams(_usr,setUnconscious,randInt(10,30));
			};
			
			if (_checkLovVal) then {
				if (getVar(_usr,oxygen)<=0) then {
					if DICE_ISFAIL(getRollType(callFuncParams(_usr,checkSkill,"ht" arg -8))) then {
						callFuncParams(_usr,addHP, - 1);
					};
				};
			}
			
		};
	};
endclass
