// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

//::декор
editor_attribute("InterfaceClass")
class(SmallDecorations) extends(StructureBasicCategory) endclass

//мусорки < container

//картины
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Picture) extends(SmallDecorations) var(name,"Картина"); editor_only(var(desc,"Просто картина");) endclass

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
class(PosterLive) extends(Picture)
	var(model,"metro_ob\model\sovet3.p3d");
endclass
//ковры
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Carpet) extends(SmallDecorations) var(name,"Ковер"); editor_only(var(desc,"Красивый ковер");) endclass

editor_attribute("EditorGenerated")
class(RedCarpetWall) extends(Carpet)
	var(model,"ca\structures_e\misc\misc_interier\carpet_wall_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(RedCarpet) extends(Carpet)
	var(model,"ml_shabut\carpet\carpet.p3d");
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
class(SmallSign) extends(SmallDecorations) var(name,"Табличка"); editor_only(var(desc,"Табличка или указатель");) endclass

editor_attribute("EditorGenerated")
class(WoodenGraveCross) extends(SmallSign)
	var(model,"ca\buildings\misc\hrobecek_krizek2.p3d");
endclass

editor_attribute("EditorGenerated")
class(SignWelcome) extends(SmallSign)
	var(model,"metro_ob\model\dobro.p3d");
endclass


//Монументы, памятники, могилы
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(MonumentBase) extends(SmallDecorations) var(name,"Монумент"); editor_only(var(desc,"Монументы - памятники - могилы");) endclass

editor_attribute("EditorGenerated")
class(AncientMonument) extends(MonumentBase)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\petroglyphwall_01_f.p3d");
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
class(Statue9) extends(Statue)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_17_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue8) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancienthead_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue7) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancientstatue_02_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue6) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Statue5) extends(Statue)
	var(model,"a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d");
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