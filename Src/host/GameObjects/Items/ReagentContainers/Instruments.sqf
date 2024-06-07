// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

//"relicta_models\models\interier\props\kitchen\kastryla.p3d"
	//"relicta_models\models\interier\props\kitchen\kastrula.p3d"
	//"ml\ml_object_new\model_05\kostrulya.p3d"

class(Bucket) extends(IReagentNDItem)
	var(name,"Ведро");
	var(allowedSlots,[INV_HEAD]);
	var(model,"ca\structures\furniture\decoration\bucket\bucket.p3d");
	var(material,"MatMetal");
	var(reagents,vec2(this,180) call ms_create);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,1.2);
	var(dr,2);
	getter_func(getHandAnim,ITEM_HANDANIM_LOWER);
	getterconst_func(transferAmount,[10 arg 20 arg 30 arg 60 arg 120 arg 150 arg 180]);

	func(onEquip) {
		objParams_1(_usr);
		super();
		callFuncParams(_usr,changeVisionBlock,+1 arg "itmeq");
	};
	func(onUnequip) {
		objParams_1(_usr);
		super();
		callFuncParams(_usr,changeVisionBlock,-1 arg "itmuneq");
	};
endclass

class(WoodenBucket) extends(Bucket)
	var(desc,"Деревянное ведро");
	var(model,"ca\structures_e\misc\misc_interier\bucket_ep1.p3d");
	var(material,"MatWood");
	var(weight,gramm(770));
	var(size,ITEM_SIZE_LARGE);
	var(reagents,vec2(this,200) call ms_create);
endclass

class(Canister) extends(IGlassReagentCont)
	var(name,"Канистра");
	var(weight,gramm(5000));
	var(model,"ml\ml_object_new\model_14_10\benzin.p3d");
	var(material,"MatOrganic");
	var(weight,1.3);
	var(size,ITEM_SIZE_BIG);
	var(reagents,vec2(this,1000) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 20 arg 30]);
endclass