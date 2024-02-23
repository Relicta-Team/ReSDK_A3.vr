// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(ItemBaseChair) extends(Item)
	#include "..\..\Interfaces\ISeat.Interface"
endclass

editor_attribute("InterfaceClass")
class(IChairAsItem) extends(ItemBaseChair)
	var(name,"Стул");
	var(size,ITEM_SIZE_HUGE);
	func(canPickup)
	{
		objParams();
		super() && ({!isNullReference(_x)} count getSelf(seatListOwners)) == 0;
	};	
	
	var(attachedWeap,weaponModule(WeapChair));
	runtimeGenerateWeapon("WeapChair","WeapHandyItem")
	{
		varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьет стулом"));
		var(defenceBy,"стула");
		getter_func(getMissAttackWeaponText,"стулом");
		varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+1));
	};
	getterconst_func(getChairOffsetPos,[vec3(0,0,0)]);
	getterconst_func(getChairOffsetDir,0);
	
	//если нельзя сесть то и действия не видно
	getter_func(canUseMainAction,callSelfParams(canSeat,_usr arg 0) && super());
	func(canSeat)
	{
		objParams_2(_usr,_index);
		private _canBase = super();
		if callSelf(isInWorld) then {
			((vectorup getSelf(loc)) select 2)>=0.85 && _canBase
		} else {
			false
		};
	};
endclass

editor_attribute("EditorGenerated")
class(StumpChair) extends(IChairAsItem)
	var(model,"a3\props_f_enoch\civilian\forest\woodenlog_02_f.p3d");
	var(name,"Пенёк");
	getterconst_func(getChairOffsetPos,vec3(0,-0.1,-0.25));
	var(weight,15);
endclass


class(SmallChair) extends(IChairAsItem)
	var(icon,invicon(brownchair));
	var(model,"ca\buildings\furniture\ch_mod_d.p3d");
	getterconst_func(getChairOffsetPos,vec3(0,0,0.01));
	getterconst_func(getChairOffsetDir,-180);
endclass



//THIS IS EQUAL SmallRedseatChair
class(SmallChair2) extends(IChairAsItem)
	var(model,"ca\buildings\furniture\ch_mod_e.p3d");
	var(icon,invicon(redchair));
	getterconst_func(getChairOffsetPos,vec3(0,0,0));
	getterconst_func(getChairOffsetDir,180);
endclass

	class(SmallRedseatChair) extends(SmallChair2)
		var(model,"ca\buildings\furniture\ch_mod_e.p3d");
		getterconst_func(getChairOffsetDir,180);
	endclass
	

class(ChairLibrary) extends(IChairAsItem)
	var(model,"ml_exodusnew\biblastul.p3d");
	var(icon,invicon(libchair));
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.5));
	getterconst_func(getChairOffsetDir,270);
endclass

class(StripedChair) extends(IChairAsItem)
	var(icon,invicon(stripchair));
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.55));
	var(model,"ml_shabut\furniture\stulpin.p3d");
endclass

class(ChairCasual) extends(IChairAsItem)
	var(icon,invicon(caschair));
	getterconst_func(getChairOffsetPos,vec3(0.1,0,-0.45));
	getterconst_func(getChairOffsetDir,90);
	var(model,"ml_exodusnew\stulcasual.p3d");
endclass

class(ChairBigCasual) extends(IChairAsItem)
	var(icon,invicon(caschair2));
	getterconst_func(getChairOffsetPos,vec3(0,0.05,-0.6));
	getterconst_func(restBias,vec3(0,0.35,0));
	var(model,"relicta_models\models\interier\chair2.p3d");
endclass

class(RedPappedChair) extends(IChairAsItem)
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.1));
	var(icon,invicon(redpapchair));
	var(model,"ca\structures\furniture\chairs\ch_mod_h\ch_mod_h.p3d");
endclass

class(RattanChair) extends(IChairAsItem)
	var(icon,invicon(ratchair));
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0, -0, -0.4));
	var(model,"a3\structures_f_heli\furniture\rattanchair_01_f.p3d");
endclass	


//bar chairs

class(BarChair) extends(IChairAsItem)
	var(icon,invicon(barchair));
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.1));
	getterconst_func(getChairOffsetDir,180);
	var(model,"relicta_models\models\interier\chairbar3.p3d");
endclass	

//classForTest = "WoodenChair";

class(WoodenChair) extends(IChairAsItem)
	var(icon,invicon(woodchair));
	getterconst_func(getChairOffsetPos,vec3(0,-0.05,0.05));
	getterconst_func(getChairOffsetDir,180);
	var(model,"a3\structures_f\furniture\chairwood_f.p3d");
endclass