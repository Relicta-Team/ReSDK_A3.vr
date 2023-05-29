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
//таблички
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallSign) extends(SmallDecorations) var(name,"Табличка"); var(desc,"Табличка или указатель"); endclass