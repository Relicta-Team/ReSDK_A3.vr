// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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