// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

//TODO: "relicta_models\models\weapons\melee\butcher.p3d" - мясной нож?!
// "relicta_models\models\weapons\melee\shank\shank.p3d" - заточка
// "relicta_models\models\weapons\melee\sickle\sickle.p3d" - серп

class(Knife) extends(IMeleeWeapon)
	var(name,"Нож");
	getter_func(getDropSound,"dropping\knife_drop");
	getter_func(getPutdownSound,"updown\knife_equip");
	getter_func(getPickupSound,"updown\knife_equip");
	getter_func(getEquipSound,"updown\knife_equip");
	getter_func(getUnequipSound,"updown\knife_equip");
	var(attachedWeap,weaponModule(WeapKnife));
	var(weight,gramm(200));
	var(dr,6);
	var(size,ITEM_SIZE_MEDIUM);

	var(allowedSlots,[INV_BELT]);

	getter_func(getAttacksTypeAssoc,ATTACK_TYPE_ASSOC_STANDARD);
	
	getterconst_func(canUseInteractToMethod,true);
	func(interactTo)
	{
		objParams_2(_targ,_usr);
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {};
		callFuncParams(_usr,startProgress,_targ arg "item.incision" arg getVar(_usr,rta)*3 arg INTERACT_PROGRESS_TYPE_FULL arg this);
	};
	func(incision)
	{
		objParams_2(_targ,_usr);
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {};
		if !getVar(_part,isIncised) then {
			setVar(_part,isIncised,true);
			callFunc(_targ,recalcBloodLoss);
			callFuncParams(_usr,meSay,"делает надрез на "+callFunc(_part,getName)+" с помощью "+callSelf(getName));
		};
	};
	
	
endclass

class(LittleKnife) extends(Knife)
	var(name,"Маленький нож");
	var(model,"relicta_models\models\weapons\melee\knife1\knife1.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(attachedWeap,weaponModule(WeapLittleKnife));
	var(weight,gramm(130));
endclass

class(CustomKnife) extends(LittleKnife)
	var(name,"Самодельный нож");
	var(model,"relicta_models\models\weapons\melee\nailknife.p3d");
	var(weight,gramm(400));
endclass

class(KitchenKnife) extends(Knife)
	var(name,"Кухонный нож");
	var(desc,"Иногда для готовки" + comma + " иногда для самообороны.");
	var(model,"relicta_models\models\weapons\melee\knife2\knife2.p3d");
	var(attachedWeap,weaponModule(WeapLittleKnife));
	var(dr,3);
endclass

class(CombatKnife) extends(Knife)
	var(name,"Боевой нож");
	var(model,"relicta_models\models\weapons\melee\warknife3\warknife3.p3d");
	var(weight,gramm(750));
	var(size,ITEM_SIZE_SMALL);
endclass

class(DaggerKnife) extends(Knife)
	var(name,"Кинжал");
	var(model,"relicta_models\models\weapons\melee\ceremonial.p3d");
	var(attachedWeap,weaponModule(WeapDaggerKnife));
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(600));
endclass

class(SurgeryScalpel) extends(Knife)
	var(name,"Скальпель");
	var(model,"relicta_models\models\weapons\melee\shank\shank.p3d");
	var(attachedWeap,weaponModule(WeapLittleKnife));
	var(dr,4);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(460));
	
endclass