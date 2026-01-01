// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

editor_attribute("InterfaceClass")
class(Armor) extends(Cloth)

	var(countSlots,10);
	var(maxSize,ITEM_SIZE_MEDIUM);
	var(dr,2);
	var(coverage,70);
	var(bodyPartsCovered,TORSO);

	var(allowedSlots,[INV_ARMOR]);

	getterconst_func(getExamine3dItemType,"armor");

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		getVar(_usr,owner) addVest getSelf(armaClass);
	};
	
	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		removeVest getVar(_usr,owner);
	};

	getter_func(getDropSound,"updown\armorDown");
	getter_func(getPickupSound,"updown\armorUp");
	getter_func(getPutdownSound,"updown\armorDown");

endclass

class(ArmorVST) extends(Armor)

	getterconst_func(getExamine3dItemType,"unknown");

	//use arma class as vst config
	var(armaClass,-1);

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		callFuncParams(_usr,addVisualState,getSelf(armaClass));
	};
	
	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		callFuncParams(_usr,removeVisualState,getSelf(armaClass));
	};
	
endclass

//"ml_exodusnew\bsg_eft\dverbun.p3d"
class(Breastplate) extends(ArmorVST)
	var(name,"Нагрудник");
	var(desc,"Обеспечивает базовую защиту тела.");
	var(icon,invicon(nagrudnik));
	var(weight,18);
	var(size,ITEM_SIZE_BIG);
	var(allowedSlots,[INV_ARMOR]);
	var(canUseContainer,false);
	var(armaClass,"VST_CLOTH_BREASTPLATE");

	var(bodyPartsCovered,UPPER_TORSO + LOWER_TORSO);
	var(dr,5);
	var(coverage,60);
	var(notes,ARMOR_NOTE_ONLYFRONT);
endclass

class(ArmorCeramic) extends(ArmorVST)
	var(name,"Керамический бронежилет");
	var(desc,"Собирается в больших городах и имеет хорошую защиту.");
	var(armaClass,"VST_CLOTH_CERAMIC");
	
	var(weight,24);
	var(size,ITEM_SIZE_BIG);
	var(allowedSlots,[INV_ARMOR]);
	var(canUseContainer,false);
	
	var(bodyPartsCovered,UPPER_TORSO + LOWER_TORSO);
	var(dr,8);
	var(coverage,80);
endclass

class(ArmorStrong) extends(ArmorCeramic)
	var(armaClass,"VST_CLOTH_STRONGARMOR");
endclass

class(ArmorSteel) extends(ArmorCeramic)
	var(armaClass,"VST_CLOTH_METALARMOR");
endclass

class(Bandolier) extends(Armor)
	var(name,"Патронташ");
	var(desc,"Для всякого разного...");
	var(armaClass,"V_BandollierB_cbr");
	var(canUseContainer,true);
	var(weight,gramm(760));
	var(size,ITEM_SIZE_MEDIUM);
	var(allowedSlots,[INV_ARMOR]);
	var_exprval(countSlots,DEFAULT_BACKPACK_STORAGE);
endclass

class(ArmorLite) extends(Armor)
	var(name,"Легкий бронежилет");
	var(canUseContainer,true);
	var(weight,3.4);
	var(allowedSlots,[INV_ARMOR]);
	var_exprval(countSlots,BASE_STORAGE_CAPACITY(2));
	var(armaClass,"FRITH_ruin_vestia_lite_ltr");
	var(bodyPartsCovered,UPPER_TORSO + LOWER_TORSO);
	var(dr,7);
	var(coverage,80);
endclass

class(ArmorMedium) extends(ArmorLite)
	var(name,"Улучшенный бронежилет");
	var(armaClass,"FRITH_ruin_vestia_ltr");
	var(weight,4.3);
	var(bodyPartsCovered,UPPER_TORSO + LOWER_TORSO + GROIN);
	var(dr,7);
endclass

class(ArmorHeavy) extends(ArmorLite)
	var(name,"Тяжелый бронежилет");
	var(armaClass,"FRITH_ruin_vestiaGL_ltr");
	var(weight,5.8);
	var(bodyPartsCovered,UPPER_TORSO + LOWER_TORSO + GROIN + NECK + ARMS);
	var(dr,10);
endclass

//-------------------------- dlc REQ --------------------------
class(TacticalVest) extends(Bandolier)
	var(name,"Армейская разгрузка");
	var(armaClass,"V_HarnessO_brn");
endclass

class(TacticalVestShoter) extends(TacticalVest)
	var(armaClass,"V_TacChestrig_cbr_F");
endclass

class(PockedVestBlack) extends(Bandolier)
	var(name,"Черная жилетка");
	var(armaClass,"V_Pocketed_black_F");
endclass

class(PockedVestGreen) extends(Bandolier)
	var(name,"Зеленая жилетка");
	var(armaClass,"V_Pocketed_olive_F");
endclass

class(PockedVestBrown) extends(Bandolier)
	var(name,"Коричневая жилетка");
	var(armaClass,"V_Pocketed_coyote_F");
endclass


class(ArmorCityNew) extends(Armor)

	var(name,"Городская броня");
	var(desc,"Современная для наших времён плотная броня.");
	var(armaClass,"V_EOD_coyote_F");
	var(allowedSlots,[INV_ARMOR]);
endclass

class(SteelArmorStrong) extends(Armor)
	var(name,"Укрепленные доспехи");
	var(bodyPartsCovered,TORSO + GROIN + NECK + LEG_LEFT);
	var(coverage,70);
	var(dr,4);
	var(armaClass,"EoO_Fant_Averland_Vest_4");
	var(weight,20);
	var(material,"MatMetal");
endclass

class(SteelArmorLight) extends(Armor)
	var(name,"Легкие доспехи");
	var(bodyPartsCovered,TORSO + LEG_LEFT);
	var(coverage,70);
	var(armaClass,"EoO_Fant_Averland_Vest_1");
	var(weight,15);
	var(material,"MatMetal");
endclass

class(SteelArmorWithChains) extends(Armor)
	var(name,"Кираса в цепях");
	var(bodyPartsCovered,TORSO);
	var(coverage,80);
	var(armaClass,"EoO_Fant_FireWizard_Vest_1");
	var(weight,25);
	var(material,"MatMetal");
endclass

class(SleevelessOuterwear1) extends(Armor)
	var(name,"Безрукавица");
	var(bodyPartsCovered,TORSO + GROIN);
	var(armaClass,"EoO_Fant_Vest_11");
	var(coverage,70);
	var(weight,4);
	var(material,"MatCloth");
endclass

class(SleevelessOuterwear2) extends(SleevelessOuterwear1)
	var(armaClass,"EoO_Fant_Vest_12");
endclass

class(SleevelessOuterwearCuirass1) extends(SleevelessOuterwear1)
	var(name,"Безрукавица с кирасой");
	var(armaClass,"EoO_Fant_Vest_15");
	var(coverage,80);
	var(material,"MatMetal");
	var(weight,8);
endclass

class(SleevelessOuterwearCuirass2) extends(SleevelessOuterwearCuirass1)
	var(armaClass,"EoO_Fant_Vest_16");
endclass

class(LightArmorCuirass1) extends(Armor)
	var(name,"Легкая кираса");
	var(bodyPartsCovered,TORSO);
	var(armaClass,"EoO_Fant_Vest_1A");
	var(coverage,65);
	var(dr,6);
	var(weight,10);
	var(notes,ARMOR_NOTE_ONLYFRONT);
endclass

class(LightArmorCuirass2) extends(LightArmorCuirass1)
	var(armaClass,"EoO_Fant_Vest_2A");
endclass

class(LightArmorCuirass3) extends(LightArmorCuirass1)
	var(armaClass,"EoO_Fant_Vest_3A");
endclass

class(LightArmorCuirass4) extends(LightArmorCuirass1)
	var(armaClass,"EoO_Fant_Vest_5A");
endclass

class(FlexibleArmor1) extends(Armor)
	var(name,"Гибкие доспехи");
	var(bodyPartsCovered,TORSO + GROIN);
	var(armaClass,"EoO_Fant_BloodKnight_Vest_1");
	var(coverage,90);
	var(weight,35);
	var(material,"MatMetal");
	var(dr,7);
endclass

class(FlexibleArmor2) extends(FlexibleArmor1)
	var(armaClass,"EoO_Fant_BloodKnight_Vest_2");
endclass

class(SteelHeavyBelt) extends(Armor)
	var(name,"Стальной пояс");
	var(bodyPartsCovered,LOWER_TORSO);
	var(armaClass,"Knight_Maxon_vest");
	var(coverage,40);
	var(weight,7);
	var(material,"MatMetal");
	var(dr,3);
endclass

/*
vests first 3: (light,med,heavy)
FRITH_ruin_vestia_lite_ltr
FRITH_ruin_vestia_ltr 
FRITH_ruin_vestiaGL_ltr
FRITH_ruin_vestiaGL_ltrmtp
FRITH_ruin_vestia_lite_ghm
FRITH_ruin_vestia_ghm
FRITH_ruin_vestiaGL_ghm
FRITH_ruin_vestiaGL_ghmchk
FRITH_ruin_vestia_lite_nja
FRITH_ruin_vestia_nja
FRITH_ruin_vestiaGL_nja
FRITH_ruin_vestiaGL_njadpm
FRITH_ruin_vestia_lite_tar
FRITH_ruin_vestia_tar
FRITH_ruin_vestiaGL_tar
FRITH_ruin_vestiaGL_tartar
FRITH_ruin_vestia_lite_grn
FRITH_ruin_vestia_grn
FRITH_ruin_vestiaGL_grn
FRITH_ruin_vestiaGL_grnmtp

headgear
FRITH_ruin_modhat_ltr
FRITH_ruin_modhat_ltrpntwht
FRITH_ruin_modhat_ltrpntblk
FRITH_ruin_modhat_ltrpntgrn
FRITH_ruin_modhat_ltrpntred
FRITH_ruin_modhat_fabaaf
FRITH_ruin_modhat_fabdpm
FRITH_ruin_modhat_fabdes
FRITH_ruin_modhat_fabmtp
FRITH_ruin_modhat_fabrus
FRITH_ruin_modhat_fabflw
FRITH_ruin_modhat_fabjap
FRITH_ruin_modhat_fabtar
FRITH_ruin_modhat_mettan
FRITH_ruin_modhat_metgrn




*/