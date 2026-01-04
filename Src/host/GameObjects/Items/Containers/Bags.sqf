// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\..\bitflags.hpp>
#include "..\..\..\ServerRpc\serverRpc.hpp"
#include "..\..\..\PointerSystem\pointers.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

class(Briefcase) extends(Container)
	var(name,"Портфель");
	var(icon,invicon(briefcase));
	var(model,"ml_exodusnew\portfeluga.p3d");
	
	var(weight,gramm(420));
	var(dr,2);
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(Suitcase) extends(Container)
	var(name,"Чемодан");
	var(icon,invicon(suitcase));
	var(model,"ml_shabut\exoduss\chooomadan.p3d");
	var(weight,gramm(480));
	var(dr,2);
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(Suitcase1) extends(Suitcase)
	var(name,"Чемодан");
	var(icon,invicon(suitcase));
	var(model,"metro_ob\model\case_6.p3d");
	var(weight,gramm(480));
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(ShuttleBag) extends(Container)
	var(name,"Челночный баул");
	var(icon,invicon(baul));
	var(model,"metro_ob\model\case_1.p3d");
	var(weight,gramm(850));
	var(dr,1);
	var_exprval(countSlots,DEFAULT_BACKPACK_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_LARGE);
endclass

class(MedicalBag) extends(Container)
	var(name,"Лекарный саквояж");
	var(icon,invicon(medcase));
	var(model,"relicta_models\models\medical\medicbag.p3d");
	var(weight,gramm(370));
	var(dr,1);
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_SMALL);
endclass

class(SteelMedicalBox) extends(Container)
	var(name,"Стальная коробка");
	var(material,"MatMetal");
	var(icon,invicon(medcase2));
	var(model,"ml_exodusnew\medbox.p3d");
	var(weight,gramm(780));
	var(dr,3);
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass


class(SteelBrownContainer) extends(SteelMedicalBox)
	var(name,"Стальной ящичек");
	var(model,"metro_ob\model\box_metal_9.p3d");
endclass