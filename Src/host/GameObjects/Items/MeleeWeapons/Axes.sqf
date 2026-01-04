// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"

editor_attribute("InterfaceClass")
class(IMeleeWeapon) extends(Item)

	func(onPickup)
	{
		objParams_1(_usr);

		callSuper(Item,onPickup);

		if (getVar(getSelf(attachedWeap),reqST) > callFunc(_usr,getST)) then {
			private _name = callSelf(getName);
			private _randMes = ["Тяжеловато.",_name + " мне не по силе.",_name + "? Да я надорвусь!","У меня сил не хватит!"];
			callFuncParams(_usr,localSay,pick _randMes arg "info");
		};
	};

	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
	var(material,"MatMetal");
	var(dr,4);

endclass

editor_attribute("InterfaceClass")
class(AxeBase) extends(IMeleeWeapon)
	var(material,"MatWood");

	// func(getEfficiencyOnAttack)
	// {
	// 	objParams_2(_dam,_targ);
	// 	private _effdam = super();
	// 	if isTypeOf(callFunc(_targ,getMaterial),MatWood) then {
	// 		_effdam = _effdam * 3;
	// 	};
	// 	_dam
	// };
endclass

class(CaveAxe) extends(AxeBase)
	var(name,"Топорчик");
	var(desc,"Им обычно пользуются кочевники и прочие пещерные обитатели.");
	var(icon,invicon(axe));
	var(attachedWeap,weaponModule(WeapAxe));
	var(weight,1.8);
	var(size,ITEM_SIZE_MEDIUM);
	var(model,"relicta_models\models\weapons\melee\axehandmade1\axehandmade1.p3d");

	var(allowedSlots,[INV_BELT]);

	getter_func(getDropSound,"dropping\axe");
	getter_func(getPutdownSound,"updown\axeUp");
	getter_func(getPickupSound,"updown\axeUp");
	getter_func(getEquipSound,"updown\axeEquip");
	getter_func(getUnequipSound,"updown\axeEquip");


	func(onEquip)
	{
		objParams_1(_usr);
		callSelfParams(playEventSound, "equip");
	};

endclass

class(WorkingAxe) extends(CaveAxe)
	var(name,"Топор");
	var(weight,1.2);
	var(size,ITEM_SIZE_LARGE);
	var(model,"a3\structures_f\items\tools\axe_f.p3d");
	var(attachedWeap,weaponModule(WeapWorkingAxe));

	var(allowedSlots,[INV_BELT]);
endclass

class(BattleAxe) extends(CaveAxe)
	var(name,"Секира");
	var(weight,2.5);
	var(size,ITEM_SIZE_BIG);
	var(model,"relicta_models\models\weapons\melee\waraxe.p3d");
	var(material,"MatMetal");
	var(attachedWeap,weaponModule(WeapBattleAxe));
	getter_func(getAttacksTypeAssoc,ATTACK_TYPE_ASSOC_SWING_HANDLE);
	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
endclass
