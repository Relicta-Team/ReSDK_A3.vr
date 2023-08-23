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
class(SmallDirtPile) extends(Constructions) var(name,"Куча грязи"); editor_only(var(desc,"Небольшая куча грязи");) endclass

editor_attribute("EditorGenerated")
class(MediumPileOfLightMud) extends(SmallDirtPile)
	var(model,"apalon\metro_a3\surfaces\gryazoookass2.p3d");
	var(name,"Куча грязи");
endclass

editor_attribute("EditorGenerated")
class(MediumPileOfDirtAndStones) extends(SmallDirtPile)
	var(model,"ca\structures\castle\a_castle_walls_5_d_ruins.p3d");
	var(name,"Куча грязи");
endclass

editor_attribute("EditorGenerated")
class(SmallGrayStone) extends(SmallDirtPile)
	var(model,"ca\rocks2\r2_stone.p3d");
	var(name,"Маленький камень");
endclass

editor_attribute("EditorGenerated")
class(Grave) extends(SmallDirtPile)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d");
	var(name,"Могила");
endclass

editor_attribute("EditorGenerated")
class(DirtCraterLong) extends(SmallDirtPile)
	var(model,"a3\structures_f_enoch\military\training\craterlong_02_f.p3d");
endclass

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