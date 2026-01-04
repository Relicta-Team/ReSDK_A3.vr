// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

//facewears
editor_attribute("InterfaceClass")
class(ItemMask) extends(Cloth)
	var(canUseContainer,false);
	var(allowedSlots,[INV_FACE]);
	var(armaClass,"TIOW_Cultist_FaceCover");
	var(weight,gramm(20));
	var(maxSize,ITEM_SIZE_SMALL);
	var(countSlots,0);
	var(name,"Маска");

	var(coverage,40);
	var(dr,1);
	var(bodyPartsCovered,FACE);

	getterconst_func(getExamine3dItemType,"mask");

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		getVar(_usr,owner) addGoggles getSelf(armaClass);
	};

	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		removeGoggles getVar(_usr,owner);
	};
	
	//есть ли доступ ко рту
	//todo переработать на dr covered FACE
	getter_func(canAccessToMouth,false);
	
endclass

class(FaceCoverMask) extends(ItemMask)
	var(name,"Тряпичная масочка");
	var(weight,gramm(35));
	var(notes,ARMOR_NOTE_ONLYFRONT);
endclass

class(BalaclavaMask) extends(ItemMask)
	var(name,"Балаклава");
	var(armaClass,"G_Balaclava_blk");
	var(weight,gramm(70));
	getter_func(canAccessToMouth,true);
endclass

class(BalaclavaMask2) extends(BalaclavaMask)
	var(armaClass,"G_Balaclava_oli");
	getter_func(canAccessToMouth,true);
endclass

class(BrownBandannaMask) extends(ItemMask)
	var(name,"Бандана");
	var(armaClass,"G_Bandanna_khk");
	var(weight,gramm(40));
	var(notes,ARMOR_NOTE_ONLYFRONT);
endclass

class(BlackBandannaMask) extends(BrownBandannaMask)
	var(armaClass,"G_Bandanna_blk");
endclass

/*class(BlindfoldBlackMask) extends(ItemMask)
	var(name,"Повязка на глаза");
	var(armaClass,"G_Blindfold_01_black_F");
	func(onEquip) {
		objParams_1(_usr);
		callSuper(ItemMask,onEquip);
		callFuncParams(_usr,changeVisionBlock,+1 arg "itmeq");
	};

	func(onUnequip) {
		objParams_1(_usr);
		callSuper(ItemMask,onUnequip);
		callFuncParams(_usr,changeVisionBlock,-1 arg "itmuneq");
	};
endclass

class(BlindfoldWhiteMask) extends(BlindfoldBlackMask)
	var(armaClass,"G_Blindfold_01_white_F");
endclass*/
class(GasmaskBase) extends(ItemMask)
	var(coverage,90);
	var(bodyPartsCovered,FACE+EYES);
	var(notes,ARMOR_NOTE_ONLYFRONT);
	//TODO implement gas protect
endclass

class(Gasmask) extends(GasmaskBase)
	var(name,"Противогаз");
	var(armaClass,"exoximza_mask_1");
	var(weight,gramm(600));
endclass

class(RespiratorMask) extends(GasmaskBase)
	var(name,"Респиратор");
	var(armaClass,"exoximza_mask_2");
	var(bodyPartsCovered,FACE);
	var(weight,gramm(450));
endclass

/**************************************

           NEW EXPORT MASKS

*****************************************/

//!unresloved class
class(Bface_base_aat) extends(ItemMask)
	var(name,"Bface_base_aat");
	var(armaClass,"Bface_base_aat");
endclass

//!unresolved class
class(Bface_base_fmsk) extends(ItemMask)
	var(name,"Bface_base_fmsk");
	var(armaClass,"Bface_base_fmsk");
endclass

//!unresolved
class(Bface_base_fu) extends(ItemMask)
	var(name,"Bface_base_fu");
	var(armaClass,"Bface_base_fu");
endclass

//!unresolved
class(Bface_base_fu02) extends(ItemMask)
	var(name,"Bface_base_fu02");
	var(armaClass,"Bface_base_fu02");
endclass
//!unresolved
class(Bface_base_whml_port) extends(ItemMask)
	var(name,"Bface_base_whml_port");
	var(armaClass,"Bface_base_whml_port");
endclass

class(GasmaskOld) extends(Gasmask)
	var(name,"Старый противогаз");
	var(armaClass,"GasMask_fm1");
endclass

class(DustGlasses) extends(ItemMask)
	var(name,"Пылевые очки");
	var(armaClass,"goggles_wastelandclothing03");
endclass

class(RespiratorMaskTubes) extends(RespiratorMask)
	var(name,"Респиратор");
	var(armaClass,"nvrebreather_mask");
endclass

class(TheatricalMask) extends(ItemMask)
	var(name,"Маска");
	var(material,"MatWood");
	var(armaClass,"Samurai_mask_fm1");
endclass

class(SlaveCollar) extends(ItemMask)
	var(name,"Рабский ошейник");
	var(material,"MatMetal");
	var(armaClass,"slavecollar_mask");
endclass

class(FaceShieldSpartan) extends(ItemMask)
	var(name,"Пластина");
	var(desc,"Пластина для лица");
	var(dr,4);
	var(coverage,60);
	var(bodyPartsCovered,FACE);
	var(armaClass,"Spartan_FaceShield_Mask");
endclass

//red
class(FaceCoverMaskBig1) extends(ItemMask)
	var(name,"Большая тряпичная маска");
	var(armaClass,"trouper_1recon");
endclass

//brown
class(FaceCoverMaskBig2) extends(FaceCoverMaskBig1)
	var(armaClass,"trouper_mask_fm1");
endclass

//green
class(FaceCoverMaskBig3) extends(FaceCoverMaskBig1)
	var(armaClass,"trouper_mask_green_fm1");
endclass

//gray
class(FaceCoverMaskBig4) extends(FaceCoverMaskBig1)
	var(armaClass,"trouper_mask_winter_fm1");
endclass

class(IronVisorMask) extends(ItemMask)
	var(name,"Железная маска");
	var(dr,4);
	var(coverage,60);
	var(material,"MatMetal");
	var(bodyPartsCovered,EYES);
	var(weight,2);
	var(armaClass,"WBK_FuedalInquisitor_Mask");
endclass

class(WatcherMask1) extends(ItemMask)
	var(name,"Железная маска");
	var(dr,3);
	var(coverage,80);
	var(material,"MatMetal");
	var(bodyPartsCovered,FACE);
	var(weight,2);
	var(armaClass,"WBK_FeudalCultistMask_1");
endclass

class(WatcherMask2) extends(WatcherMask1)
	var(coverage,60);
	var(armaClass,"WBK_FeudalCultistMask_2");
endclass

class(PlagueMask1) extends(GasmaskBase)
	var(name,"Маска-носач");
	var(armaClass,"PlagueMask_fm1");
	var(coverage,100);
endclass

class(PlagueMask2) extends(PlagueMask1)
	var(armaClass,"WBK_FeudalCrowMask_1");
endclass

class(PlagueMask3) extends(PlagueMask1)
	var(armaClass,"WBK_FeudalCrowMask_2");
endclass