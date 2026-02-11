// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"

class(Sword) extends(IMeleeWeapon)
	var(name,"Меч");
	var(material,"MatMetal");
	var(attachedWeap,weaponModule(WeapSword));
	getter_func(getDropSound,"dropping\axe");
	getter_func(getPutdownSound,"updown\sword_unsheath_0" + str randInt(1,2));
	getter_func(getPickupSound,"updown\sword_unsheath_0" + str randInt(1,2));
	getter_func(getEquipSound,"updown\sword_sheath_0" + str randInt(1,2));
	getter_func(getUnequipSound,"updown\sword_unsheath_0" + str randInt(1,2));

	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
	getter_func(getAttacksTypeAssoc,ATTACK_TYPE_ASSOC_STANDARD);

	var(dr,6);
	var(weight,1.8);
	var(size,ITEM_SIZE_LARGE);
endclass

class(SwordScimitar) extends(Sword)
	var(model,"relicta_models\models\weapons\melee\swordxach\swordxach.p3d");
	var(name,"Скимитар");
	var(size,ITEM_SIZE_LARGE);
	var(weight,3.5);
endclass

class(ShortSword) extends(Sword)
	var(name,"Короткий меч");
	var(model,"relicta_models\models\weapons\melee\swordefault\swordefault.p3d");
	var(weight,1.4);
endclass

class(HalfHandedSword) extends(Sword)
	var(name,"Полуторный меч");
	var(model,"relicta_models\models\weapons\melee\sword.p3d");
	var(weight,1.6);
	var(size,ITEM_SIZE_LARGE);
	var(attachedWeap,weaponModule(WeapHalfHandedSword));
endclass

class(TwoHandedSword) extends(Sword)
	var(name,"Двуручный меч");
	var(model,"relicta_models\models\weapons\melee\swordzyb\swordzyb.p3d");
	var(weight,3.5);
	var(size,ITEM_SIZE_BIG);
	var(attachedWeap,weaponModule(WeapTwoHandedSword));
endclass
