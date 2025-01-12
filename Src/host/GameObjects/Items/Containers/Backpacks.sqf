// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"
#include "..\..\..\..\client\Inventory\inventory.hpp"

class(CoinBag) extends(Container)

	var(name,"Мешочек");
	var(desc,"Маленький мешочек для хранения звяков и бряков.");
	var(model,"relicta_models\models\interier\props\bagforgold.p3d");
	var(icon,invicon(meshochek));
	var(weight,gramm(130));
	var(allowedSlots,[INV_BELT]);

	var_exprval(countSlots,BASE_STORAGE_CAPACITY(1.4));
	var(size,ITEM_SIZE_SMALL);
	var(maxSize,ITEM_SIZE_SMALL);


endclass

class(SmallBackpack) extends(Container)
	var(name,"Рюкзак");
	var(desc,"Отлично подходит для таскания всякого барахла.");
	var(model,"a3\props_f_enoch\military\decontamination\deconkit_01_f.p3d");
	var(weight,gramm(600));
	var(allowedSlots,[INV_BACKPACK]);

	var_exprval(countSlots,DEFAULT_BACKPACK_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_LARGE);

	var(icon,"\A3\weapons_f\ammoboxes\bags\data\ui\icon_B_C_Gorod_khk_ca.paa");

	func(onEquip)
	{
		objParams_1(_usr);

		callSuper(Container,onEquip);
		private _mob = getVar(_usr,owner);
		[_mob,"addBackpack",vec2(_mob,"B_Respawn_Sleeping_bag_brown_F")] call repl_doLocal;
	};

	func(onUnequip)
	{
		objParams_1(_usr);

		callSuper(Container,onUnequip);
		private _mob = getVar(_usr,owner);
		[_mob,"removeBackpack",_mob] call repl_doLocal;
	};

endclass


class(FabricBagBig1) extends(Container)
	var(name,"Мешок");
	var(allowedSlots,[INV_BACKPACK]);
	var_exprval(countSlots,DEFAULT_BOX_STORAGE);
	var(maxSize,ITEM_SIZE_BIG);
	var(size,ITEM_SIZE_HUGE);
	var(weight,gramm(800));
	var(model,"ml_shabut\meshok\meshok1.p3d");
	var(icon,invicon(bigsack));
	
endclass

class(FabricBagBig2) extends(FabricBagBig1)
	var(model,"ml_shabut\meshok\meshok2.p3d");
endclass
