// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

editor_attribute("InterfaceClass")
class(HeadgearBase) extends(Cloth)
	var(name,"Головной убор");
	var(bodyPartsCovered,HEAD);
	var(dr,1);
	var(coverage,70);
	var(weight,gramm(80));
	var(allowedSlots,[INV_HEAD]);

	getterconst_func(getExamine3dItemType,"helmet");

	var(canUseContainer,false);
	var(countSlots,0);

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		getVar(_usr,owner) addHeadgear getSelf(armaClass);
	};

	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		removeHeadgear getVar(_usr,owner);
	};
endclass

editor_attribute("InterfaceClass")
class(HatProxy) extends(HeadgearBase)
	func(armaItemAddImpl)
	{
		objParams_1(_usr);
	};

	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
	};
endclass

//headgears
//Шляпы
class(Hat) extends(HeadgearBase)
	var(armaClass, "H_Hat_brown");
	var(name, "Коричневая шляпа");
endclass

class(Hat1) extends(Hat)
	var(armaClass, "H_Hat_Grey");
	var(name, "Серая шляпа");
endclass

class(Hat2) extends(Hat)
	var(armaClass, "H_Hat_tan");
	var(name, "Жёлтая шляпа");
endclass

//Ушанки с ушами
class(HatUshanka) extends(HeadgearBase)
	var(armaClass,"Skyline_HeadGear_Chapka_01_F");
	var(weight,gramm(170));
	var(maxSize,ITEM_SIZE_SMALL);
	var(name, "Чёрная ушастая шапка");
endclass

class(HatUshanka1) extends(HatUshanka)
	var(armaClass,"Skyline_HeadGear_Chapka_02_F");
	var(name, "Синяя ушастая шапка");
endclass

class(HatUshanka2) extends(HatUshanka)
	var(armaClass,"Skyline_HeadGear_Chapka_03_F");
	var(name, "Зелёная ушастая шапка");
endclass

//Короны
class(Crown1) extends(HatProxy)
	var(name,"Корона");
	var(model,"relicta_models\models\interier\props\treasure\crown\crown1.p3d");
	var(weight,gramm(600));
    var(material,"MatMetal");
endclass

class(Crown2) extends(Crown1)
	var(name,"Корона");
	var(model,"relicta_models\models\interier\props\treasure\crown\crown2.p3d");
endclass

class(HatBeret) extends(HeadgearBase)
	var(armaClass,"H_Beret_Colonel");
	var(name,"Берет");
endclass

class(HatArmyCap) extends(HeadgearBase)
	var(armaClass,"H_ParadeDressCap_01_US_F");
	var(name,"Фуражка");
endclass

//Банданы и повязки
class(HatBandana) extends(HeadgearBase)
	var(armaClass,"H_Bandanna_gry");
	var(name,"Чёрная повязка на голову");
endclass

class(HatBandana1) extends(HatBandana)
	var(armaClass,"H_Bandanna_cbr");
	var(name,"Коричневая повязка на голову");
endclass

class(HatBandana2) extends(HatBandana)
	var(armaClass,"H_Bandanna_sand");
	var(name,"Жёлтая повязка на голову");
endclass

class(HatBandana3) extends(HatBandana)
	var(armaClass,"H_Bandanna_sgg");
	var(name,"Зелёная повязка на голову");
endclass

class(HatShemag) extends(HeadgearBase)
	var(armaClass,"H_ShemagOpen_tan");
	var(name,"Головная повязка");
endclass

//Ушанки ухи к верху
class(HatUshankaUp) extends(HeadgearBase)
	var(armaClass,"rds_Woodlander_cap1");
	var(name,"Коричневая безухая шапка");
endclass

class(HatUshankaUp1) extends(HatUshankaUp)
	var(armaClass,"rds_Woodlander_cap2");
	var(name,"Зелёная безухая шапка");
endclass

class(HatUshankaUp2) extends(HatUshankaUp)
	var(armaClass,"rds_Woodlander_cap3");
	var(name,"Тёмно-коричневая безухая шапка");
endclass

class(HatUshankaUp3) extends(HatUshankaUp)
	var(armaClass,"rds_Woodlander_cap4");
	var(name,"Светло-коричневая безухая шапка");
endclass

//Устаревший класс
editor_attribute("Deprecated" arg "Заменить на HatUshankaUp2.")
class(HatOldUshanka) extends(HeadgearBase)
	var(armaClass,"rds_Woodlander_cap3");
endclass

//Устаревший класс
editor_attribute("Deprecated" arg "Заменить на HatUshankaUp.")
class(HatGrayOldUshanka) extends(HatOldUshanka)
	var(armaClass,"rds_Woodlander_cap1");
endclass

//Шапки
class(WorkerCap) extends(HeadgearBase)
	var(armaClass,"rds_worker_cap2");
	var(name,"Жёлтая шапка");
endclass

class(WorkerCap1) extends(WorkerCap)
	var(armaClass,"rds_worker_cap3");
	var(name,"Светло-коричневая шапка с узором");
endclass

class(WorkerCap2) extends(WorkerCap)
	var(armaClass,"rds_worker_cap4");
	var(name,"Коричневая шапка с узором");
endclass

class(CookerCap) extends(HeadgearBase)
	var(armaClass,"rds_Villager_cap4");
	var(name,"Поварская шапочка");
	var(desc,"С пипкой на макушке!");
	var(weight,gramm(200));
endclass

class(CookerCap1) extends(CookerCap)
	var(armaClass,"rds_Villager_cap1");
	var(name,"Чёрный чепчик");
	var(desc,"С пипкой на макушке! Сделан из шкуры чумазёдных мельтешат!");
endclass

class(CookerCap2) extends(CookerCap)
	var(armaClass,"rds_Villager_cap2");
	var(name,"Коричневый чепчик");
	var(desc,"С пипкой на макушке! Сделан из мельтешиной шкурки!");
endclass

//Устаревший класс
editor_attribute("Deprecated" arg "Заменить на WorkerCap2.")
class(WorkerCoolCap) extends(WorkerCap)
	var(armaClass,"rds_worker_cap4");
	var(name,"Коричневая шапка");
endclass

//Капюшоны
class(HoodAbbat) extends(HeadgearBase)
	var(armaClass,"TIOW_Priest_Hood_Red");
	var(name,"Капюшон");
endclass

class(HoodClirik) extends(HoodAbbat)
	var(armaClass,"TIOW_Priest_Hood_Grey");
	var(name,"Капюшон");

	var(coverage,85);
	var(weight,gramm(300));
endclass

class(HoodBrown) extends(HoodAbbat)
	var(armaClass,"TIOW_Cultist_Hood");
endclass

class(HoodChemicalProt) extends(HoodAbbat)
	var(armaClass,"Skyline_HeadGear_NBC_Hazmat_01_F");
	var(name,"Капюшон");
endclass

//combat headgears
class(CombatHat) extends(HeadgearBase)
	var(name,"Боевая каска");
	var(weight,1.3);
	var(bodyPartsCovered,HEAD);
	var(dr,6);
	var(coverage,80);
	var(armaClass,"FRITH_ruin_modhat_ltr");
    var(material,"MatMetal");
endclass

