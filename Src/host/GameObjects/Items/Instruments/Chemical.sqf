// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

// REACTION_COOKING
class(ChemDistiller) extends(Item)
	var(name,"Дистилятор");
	var(model,"relicta_models\models\medical\distilation.p3d");
	var(desc,"Отлично подойдёт для химических реакций");

	var(weight,gramm(4200));
	var(size,ITEM_SIZE_BIG);

	var(connected,nullPtr); //что подключено к нему

	var(isEnabled,false); //включенный дистиллятор будет нагревать вещество

	autoref var_num(handle_update);

	var(material,"MatGlass");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
endclass

