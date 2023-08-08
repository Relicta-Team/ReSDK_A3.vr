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
class(Picture) extends(SmallDecorations) var(name,"Картина"); var(desc,"Просто картина"); endclass
//ковры
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Carpet) extends(SmallDecorations) var(name,"Ковер"); var(desc,"Красивый ковер"); endclass

editor_attribute("EditorGenerated")
class(OrangeCapet) extends(Carpet)
	var(model,"ml_shabut\kovrik\kovernew.p3d");
endclass
//таблички
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallSign) extends(SmallDecorations) var(name,"Табличка"); var(desc,"Табличка или указатель"); endclass

editor_attribute("EditorGenerated")
class(OldTombstone3) extends(SmallSign)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_08_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstone2) extends(SmallSign)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_16_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstoneGrave) extends(SmallSign)
	var(model,"a3\structures_f_exp\cultural\cemeteries\grave_07_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldTombstone) extends(SmallSign)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_11_f.p3d");
endclass
editor_attribute("EditorGenerated")
class(WoodenGraveCross) extends(SmallSign)
	var(model,"ca\buildings\misc\hrobecek_krizek2.p3d");
endclass