// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

class(Bucket1) extends(Bucket)
	var(name,"Ведро");
	var(model,"a3\structures_f\items\vessels\bucket_painted_f.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(weight,1.2);
	var(size,ITEM_SIZE_MEDIUM);
endclass

class(Bucket2) extends(Bucket)
	var(name,"Ведро");
	var(model,"a3\structures_f\items\vessels\bucket_clean_f.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(weight,1.2);
	var(size,ITEM_SIZE_MEDIUM);
endclass

class(WoodenBucket) extends(Bucket)
	var(name,"Деревянное ведро");
	var(model,"ca\structures_e\misc\misc_interier\bucket_ep1.p3d");
	var(material,"MatWood");
	var(weight,gramm(770));
	var(size,ITEM_SIZE_LARGE);
	var(reagents,vec2(this,200) call ms_create);
endclass


class(Teapot) extends(IReagentNDItem)
	var(name,"Чайник");
	var(model,"relicta_models\models\interier\props\kitchen\chaynik.p3d");
	var(material,"MatMetal");
	var(weight,gramm(400));
	var(size,ITEM_SIZE_MEDIUM);
	var(reagents,vec2(this,100) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 20 arg 30]);
endclass

class(Teapot1) extends(Teapot)
	var(name,"Заварник");
	var(model,"ml_shabut\furniture\teabaggin.p3d");
	var(material,"MatGlass");
	var(weight,gramm(300));
	var(size,ITEM_SIZE_MEDIUM);
	var(reagents,vec2(this,100) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 20 arg 30]);
endclass

class(Canister) extends(IReagentNDItem)
	var(name,"Канистра");
	var(weight,gramm(5000));
	var(model,"ml\ml_object_new\model_14_10\benzin.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(size,ITEM_SIZE_BIG);
	var(reagents,vec2(this,1000) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 25 arg 30 arg 60]);
endclass

class(Canister1) extends(Canister)
	var(name,"Канистра");
	var(weight,gramm(1000));
	var(model,"ml\ml_object_new\model_14_10\redbalon.p3d");
	var(dr,2);
endclass

class(Canister2) extends(Canister)
	var(name,"Канистра");
	var(weight,gramm(400));
	var(model,"ml_exodusnew\kanistorka.p3d");
	var(material,"MatSynt");
	var(dr,2);
	var(reagents,vec2(this,500) call ms_create);
endclass


