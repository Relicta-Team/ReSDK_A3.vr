// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


//================== Клосеты ==================
class(CaseBedroom) extends(SContainer)
	var(name,"Тумбочка"); //4 sections
	var(model,"ca\buildings\furniture\case_bedroom_b.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(CaseBedroomSmall) extends(CaseBedroom)
	var(name,"Маленькая тумбочка");
	var(model,"ca\structures\furniture\cases\case_bedroom_a\case_bedroom_a.p3d");
endclass

class(CaseBedroomMedium) extends(CaseBedroomSmall)
	var(model,"ml\ml_object_new\model_14_10\yashik.p3d");
endclass

class(ChestCabinet) extends(SContainer)
	var(name,"Сундук на ножках");
	var(model,"ca\structures_e\misc\misc_interier\chest_ep1.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(WallmountedMedicalCabinet) extends(SContainer)
	var(name,"Медицинский шкафчик");
	var(model,"ca\structures\furniture\decoration\lekarnicka\lekarnicka.p3d");
	var(material,"MatWood");
	var(dr,1);
endclass

class(SteelBlueCase)  extends(SContainer)
	var(name,"Шкафчик");
	var(model,"ca\structures\furniture\cases\metalcase\metalcase_01.p3d");
	var(material,"MatMetal");
	getter_func(isMovable,true);
	var(dr,2);
endclass