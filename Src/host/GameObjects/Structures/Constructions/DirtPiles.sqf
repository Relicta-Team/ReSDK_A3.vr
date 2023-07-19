// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//кучи грязи
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallDirtPile) extends(Constructions) var(name,"Куча грязи"); var(desc,"Небольшая куча грязи"); endclass

editor_attribute("EditorGenerated")
class(MediumDirt) extends(SmallDirtPile)
	var(model,"apalon\metro_a3\surfaces\gryazoookass.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallDirtBrown) extends(SmallDirtPile)
	var(model,"ml_shabut\nvprops\gryazyuka4.p3d");
endclass
editor_attribute("EditorGenerated")
class(SmallDirtGrey) extends(SmallDirtPile)
	var(model,"ml_shabut\nvprops\gryazyuka5.p3d");
endclass