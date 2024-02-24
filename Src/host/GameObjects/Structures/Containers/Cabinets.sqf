// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


//================== big comods and cabinet ==================
class(LuxuryCabinet) extends(SContainer)
	var(name,"Роскошный комод");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"ml_shabut\furniture\komodvirus.p3d");
endclass

class(BigClothCabinet) extends(SContainer)
	var(name,"Гардеробный шкаф");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"ca\structures\furniture\cases\dhangar_borwnskrin\dhangar_brownskrin.p3d");
endclass

class(BigClothCabinetNew) extends(SContainer)
	var(name,"Новый гардеробный шкаф");
	var(desc,"Либо чудом сохранился, либо его сделали совсем недавно");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"ca\structures\furniture\cases\case_a\case_a.p3d");
endclass

class(ClothCabinet) extends(SContainer)
	var(name,"Гардеробный шкаф");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"ca\buildings\furniture\case_wooden_b.p3d");
endclass


class(SteelGreenCabinet) extends(SContainer)
	var(name,"Стальной ящик");
	var(desc,"На ножках!!!");
	var(model,"ml\ml_object_new\model_14_10\shkafsin.p3d");
endclass

class(OfficeCabinet) extends(SContainer)
	var(name,"Офисный шкаф");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(model,"a3\props_f_orange\furniture\officecabinet_02_f.p3d");
endclass

class(LargeClothCabinet) extends(SContainer)
	var(name,"Здоровый гардеробный шкаф");
	var_exprval(countSlots,DEFAULT_LARGEBOX_STORAGE);
	var(desc,"Он такой большоооой!!");
	var(model,"ca\structures\furniture\cases\almara\almara.p3d");
endclass