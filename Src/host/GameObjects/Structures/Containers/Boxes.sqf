// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


//================== Containers ==================

class(WoodenMedicalBox) extends(SContainer)
	var(name,"Медицинский ящик");
	var(model,"ml_shabut\yashikus\med_crate.p3d");
	var(material,"MatWood");
	var(dr,1);
endclass

class(RedSteelBox) extends(SContainer)
	var(name,"Красный ящик");
	var(model,"metro_ob\model\box_metal_1.p3d");
	var(material,"MatMetal");
	getter_func(isMovable,true);
endclass

class(BoardWoodenBox) extends(SContainer)
	var(name,"Большой деревянный ящик");
	var(model,"metro_ob\model\box_wood_close.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
endclass

class(OldWoodenBox) extends(SContainer)
	var(name,"Деревянный ящик");
	var(model,"ml_exodusnew\bsg_eft\tarkov_wood\tarkov_wood.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(ContainerGreen) extends(SContainer)
	var(name,"Выцветший ящик");
	var(model,"ml_shabut\exoduss\sundugan.p3d");
	var(material,"MatMetal");
	getter_func(isMovable,true);
	var(dr,1);
endclass

editor_attribute("EditorGenerated")
class(ContainerGreen4) extends(ContainerGreen)
	var(model,"ml_shabut\exodus\boxuzk.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(ContainerGreen2) extends(ContainerGreen)
	var(name,"Деревянный ящик");
	var(model,"ml\ml_object_new\shabbat\yashi4ek.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(ContainerGreen3) extends(ContainerGreen)
	var(name,"Плотный деревянный ящик");
	var(model,"relicta_models\models\interier\box.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
endclass

class(WoodenWeaponBox) extends(SContainer)
	var(name,"Оружейный ящик");
	var(model,"ml_shabut\yashikus\oruzhie_crate.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(LongWeaponContainer) extends(SContainer)
	var(name,"Оружейный ящик");
	var(desc,"Сюда залезет всякое длинное.");
	var(model,"a3\structures_f\civ\constructions\woodenbox_f.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(SquareWoodenBox) extends(SContainer)
	var(name,"Деревянная коробка");
	var(desc,"Крупная и пахнет странно");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"a3\props_f_enoch\industrial\supplies\woodenbox_02_f.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass


class(SmallTrashCan) extends(SContainer)
	var(name,"Мусорка");
	var(model,"ml\ml_object_new\model_14_10\pomoika.p3d");
	var(material,"MatMetal");
	getter_func(isMovable,true);
endclass

class(TrashCan) extends(SmallTrashCan)
	var(name,"Мусорка");
	var(model,"smg_metro_building\drugoe\smg_urnametall.p3d");
	var(material,"MatMetal");
endclass