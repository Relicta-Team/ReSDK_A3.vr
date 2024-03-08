// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"

class(Baseballbat) extends(IMeleeWeapon)
	var(name,"Бита");
	var(model,"relicta_models\models\weapons\melee\baseballbite.p3d");
	
	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
endclass

class(Baton) extends(Baseballbat)
	var(name,"Дубинка");
	var(desc,"Созданная лучишими умами Сети для сдерживания быдла и хвостов. Обладает особыми свойствами успокаивания буйных и укладывания убегающих.");
	var(model,"ml_shabut\eft\svd_trubka.p3d");
	var(allowedSlots,[INV_BELT]);
	var(weight,gramm(1420));
	var(attachedWeap,weaponModule(WeapBaton));

	getter_func(getPickupSound,"updown\clothUp");
	getter_func(getPutdownSound,"updown\clothDown");
	getter_func(getDropSound,vec2("dropping\smallfall",getRandomPitchInRange(.85,1.3)));
	getter_func(getEquipSound,"updown\clothUp");
	getter_func(getUnequipSound,"updown\clothUp");

	func(onAttackedMob)
	{
		objParams_4(_mob,_bodyPart,_damageType,_woundSize);
		
		if (_woundSize >= WOUND_SIZE_MINOR) then {
			callFuncParams(_mob,Stun,randInt(4,6) arg false arg false);
			if (_bodyPart in [BP_INDEX_LEG_R,BP_INDEX_LEG_L] && prob(35)) then {
				callFunc(_mob,KnockDown);
			};
		};
	};
endclass

class(Scepter) extends(Baseballbat)
	var(name,"Скипетр");
	var(model,"relicta_models\models\interier\props\treasure\scepter\scepter.p3d");
	var(weight,gramm(1200));
	getterconst_func(getHandAnim,ITEM_HANDANIM_TORCH);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
endclass