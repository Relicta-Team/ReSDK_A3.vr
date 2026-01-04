// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"

class(Baseballbat) extends(IMeleeWeapon)
	var(name,"Бита");
	var(model,"relicta_models\models\weapons\melee\baseballbite.p3d");
	var(material,"MatWood");
	var(dr,4);
	var(weight,1.1);
	var(size,ITEM_SIZE_MEDIUM);

	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
endclass

class(WoodBaton) extends(Baseballbat)
	var(name,"Дубина");
	var(desc,"Какой-то деревянный корешок.");
	var(model,"relicta_models2\melee_weapon\s_baton\s_baton.p3d");
	var(material,"MatWood");
	var(allowedSlots,[INV_BELT]);
	var(size,ITEM_SIZE_LARGE);
	var(weight,gramm(2000));
endclass

//TODO Нужна отдельная категория для боевых молотов
class(BattleSledgehammer) extends(Baseballbat)
	var(name,"Костолом");
	var(desc,"Таким инструментом можно и бошку проломить.");
	var(model,"relicta_models2\melee_weapon\s_battle_sledgehammer\s_battle_sledgehammer.p3d");
	var(material,"MatMetal");
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	var(size,ITEM_SIZE_BIG);
	var(weight,gramm(8000));
endclass

class(Baton) extends(Baseballbat)
	var(name,"Дубинка");
	var(desc,"Созданная лучишими умами Сети для сдерживания быдла и хвостов. Обладает особыми свойствами успокаивания буйных и укладывания убегающих.");
	var(model,"ml_shabut\eft\svd_trubka.p3d");
	var(material,"MatSynt");
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

class(Baton1) extends(Baton)
	var(model,"relicta_models2\melee_weapon\s_baton1\s_baton1.p3d");
	var(material,"MatMetal");
	var(weight,gramm(2000));
endclass

class(Scepter) extends(Baseballbat)
	var(name,"Скипетр");
	var(model,"relicta_models\models\interier\props\treasure\scepter\scepter.p3d");
	var(material,"MatMetal");
	var(weight,gramm(1200));
	getterconst_func(getHandAnim,ITEM_HANDANIM_TORCH);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
endclass