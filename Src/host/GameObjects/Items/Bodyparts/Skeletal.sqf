// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\GameConstants.hpp>

class(Bone) extends(Item)
	var(name,"Костошка");
	var(model,"ml\ml_object_new\model_14_10\kosti.p3d");
	var(material,"MatOrganic");
	var(dr,DR_SP_1);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(randInt(100,600)));
endclass