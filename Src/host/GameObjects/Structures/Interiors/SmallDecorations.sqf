// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

//::декор
editor_attribute("InterfaceClass")
class(SmallDecorations) extends(StructureBasicCategory) endclass

//мусорки < container

//Предметы интерьера, украшения
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(InterierProp) extends(SmallDecorations) 
	var(name,"Предмет интерьера");
	editor_only(var(desc,"Различные украшения интерьера");)
	var(material,"MatGlass");
endclass

class(Vase) extends(InterierProp) 
	var(name,"Великолепная ваза");
	var(desc,"Потрясающее изделие невиданной красоты");
	var(model,"relicta_models\models\interier\props\treasure\vase\vase.p3d");
	getter_func(isMovable,true);
	getterconst_func(getCoefAutoWeight,100);
endclass

//картины
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Picture) extends(SmallDecorations) 
	var(name,"Картина");
	editor_only(var(desc,"Просто картина");)
	var(material,"MatCloth");
	getter_func(isMovable,true);
	getterconst_func(getCoefAutoWeight,5);
endclass

editor_attribute("EditorGenerated")
class(PictureIcon) extends(Picture)
	var(model,"enoch_rip\pravoslavnenko\otetzpi.p3d");
endclass

editor_attribute("EditorGenerated")
class(PictureFranklin) extends(PictureIcon)
	var(model,"ml_exodusnew\ml_plakats3\picture_119.p3d");
endclass

editor_attribute("EditorGenerated")
class(PictureSussy) extends(PictureIcon)
	var(model,"ml_exodusnew\ml_plakats3\picture_117.p3d");
endclass

editor_attribute("EditorGenerated")
class(PictureTwoMans) extends(PictureIcon)
	var(model,"ml\ml_plakats\pictures\picture_02.p3d");
endclass

class(PictureMan) extends(PictureIcon)
	var(model,"a3\props_f_aow\civilian\gallery\galleryframe_01_large_portrait_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(PictureHovan) extends(PictureIcon)
	var(model,"ml\ml_plakats\pictures\picture_03.p3d");
endclass

editor_attribute("EditorGenerated")
class(PictureFoliesBergere) extends(PictureIcon)
	var(model,"ml_exodusnew\ml_plakats3\picture_121.p3d");
endclass

//постеры
editor_attribute("EditorGenerated")
class(PosterLive) extends(Picture)
	var(model,"metro_ob\model\sovet3.p3d");
	var(material,"MatCloth");
	getter_func(isMovable,false);
	var(weight,1.15);
endclass

editor_attribute("EditorGenerated")
class(PosterGirl) extends(PosterLive)
	var(model,"ml\ml_object_new\model_14_10\plakatgirl.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterGirl1) extends(PosterLive)
	var(model,"ml_exodusnew\ml_plakats3\poster_nushi.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterEpidemic) extends(PosterLive)
	var(model,"ml\ml_plakats\biohazard_plakat\biohazard_plakat_8.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterEpidemic1) extends(PosterLive)
	var(model,"ml\ml_plakats\biohazard_plakat\biohazard_plakat_4.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterFireAlarm) extends(PosterLive)
	var(model,"ml\ml_plakats\plakats\01.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterWorkplaceClean) extends(PosterLive)
	var(model,"ml\ml_plakats\plakats\aginka.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterFireSafety) extends(PosterLive)
	var(model,"ml\ml_plakats\plakats\01_plakat.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterWorkingClass) extends(PosterLive)
	var(model,"ml\ml_plakats\transparants\lenin_plakat7.p3d");
endclass

editor_attribute("EditorGenerated")
class(PosterManSuite) extends(PosterLive)
	var(model,"ml\ml_plakats\transparants\lenin_plakat5.p3d");
endclass

//ковры
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Carpet) extends(SmallDecorations) 
	var(name,"Ковер");
	editor_only(var(desc,"Красивый ковер");)
	var(material,"MatCloth");
	getter_func(isMovable,true);
	getterconst_func(getCoefAutoWeight,50);
endclass

editor_attribute("EditorGenerated")
class(RedCarpetWall) extends(Carpet)
	var(model,"ca\structures_e\misc\misc_interier\carpet_wall_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(RedCarpet) extends(Carpet)
	var(model,"ml_shabut\carpet\carpet.p3d");
endclass

editor_attribute("EditorGenerated")
class(RedCarpet1) extends(RedCarpet)
	var(model,"ca\structures_e\misc\misc_interier\carpet_2_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(OrangeCapet) extends(Carpet)
	var(model,"ml_shabut\kovrik\kovernew.p3d");
endclass

editor_attribute("EditorGenerated")
class(OrangeCarpet1) extends(OrangeCapet)
	var(model,"ml_shabut\kovrik\koverold.p3d");
endclass
//таблички
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallSign) extends(SmallDecorations) 
	var(name,"Табличка");
	editor_only(var(desc,"Табличка или указатель");)
	var(material,"MatWood");
	getterconst_func(getCoefAutoWeight,50);
	var(dr,1);
endclass

editor_attribute("EditorGenerated")
class(WoodenGraveCross) extends(SmallSign)
	var(model,"ca\buildings\misc\hrobecek_krizek2.p3d");
	getter_func(isMovable,true);
endclass

editor_attribute("EditorGenerated")
class(SignWelcome) extends(SmallSign)
	var(model,"metro_ob\model\dobro.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignHighVoltage) extends(SignWelcome)
	var(model,"ml\ml_plakats\wm\sign_electrohazard.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignHighVoltage1) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\voltage_04.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignScheme) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\diagram.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignNoEntry) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\stop_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignNoEntry1) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\no_exit_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignNoEntry2) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\no_exit.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignEmergencyExit) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\exit.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignSmokingArea) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\no_smoking_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignInfirmary) extends(SignWelcome)
	var(model,"smg_metro_building\plakatitablichki\smg_plakat2_4.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignGenerator) extends(SignWelcome)
	var(model,"smg_metro_building\plakatitablichki\smg_plakat2_2.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignArmory) extends(SignWelcome)
	var(model,"smg_metro_building\plakatitablichki\smg_plakat2_7.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignChargingUnit) extends(SignWelcome)
	var(model,"ml\ml_plakats\plakats\tablichka_01.p3d");
endclass

//Монументы, памятники, могилы
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(MonumentBase) extends(SmallDecorations) 
	var(name,"Монумент");
	editor_only(var(desc,"Монументы - памятники - могилы");)
	var(material,"MatBeton");
	var(dr,4);
endclass

editor_attribute("EditorGenerated")
class(AncientMonument) extends(MonumentBase)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\petroglyphwall_01_f.p3d");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(AncientMonument3) extends(AncientMonument)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\stonetanoa_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(AncientMonument2) extends(AncientMonument)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\raistone_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(AncientMonument1) extends(AncientMonument)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\petroglyphwall_02_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue) extends(MonumentBase)
	var(model,"relicta_models\models\nocategory\savin\savin.p3d");
endclass

editor_attribute("EditorGenerated")
class(Pedestal) extends(Statue)
	var(model,"a3\structures_f_argo\cultural\statues\pedestal_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue9) extends(Statue)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_17_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue8) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancienthead_01_f.p3d");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(Statue7) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancientstatue_02_f.p3d");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(Statue6) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(Statue5) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(Statue4) extends(Statue)
	var(model,"metro_ob\model\reading_hall_centr_statue.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue3) extends(Statue)
	var(model,"enoch_rip\boxi\baba_statuya.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue2) extends(Statue)
	var(model,"a3\structures_f_argo\cultural\statues\statue_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue1) extends(Statue)
	var(model,"a3\structures_f_argo\cultural\statues\statue_02_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstone) extends(MonumentBase)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_11_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstone3) extends(OldTombstone)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_08_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstone2) extends(OldTombstone)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_16_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstoneGrave) extends(OldTombstone)
	var(model,"a3\structures_f_exp\cultural\cemeteries\grave_07_f.p3d");
endclass