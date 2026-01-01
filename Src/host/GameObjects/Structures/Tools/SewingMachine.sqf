// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\CraftSystem\Craft.hpp>

class(SewingMachine) extends(IStruct) 
    var(name,"Швейная машинка");
    var(desc,"Техническое устройство для соединения и отделки материалов методом шитья.");
    var(material,"MatMetal");
    var(model,"ml_exodusnew\mashinka_zingera.p3d");
    getter_func(canUseAsCraftSpace,true);
	getter_func(getAllowedCraftCategories,[CRAFT_CATEGORY_ID_CLOTH]);
endclass