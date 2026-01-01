// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\GameConstants.hpp>

//Ручные протезы в следующем обновлении
class(ArmHook) extends(Arm)
	getterconst_func(isOrganic,false);
	var(name,"Крюк");
	var(model,"relicta_models\models\weapons\melee\sickle2\sickle2.p3d");
	var(material,"MatMetal");
	var(dr,1);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(850));
endclass