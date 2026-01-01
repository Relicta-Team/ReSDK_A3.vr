// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

//as ShortSword
class(WeapSword) extends(MeleeWeapon)

	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"рубит мечом"); pair(ATTACK_TYPE_THRUST,"колет мечом"));
	var(defenceBy,"меча");
	getter_func(getMissAttackWeaponText,"мечом");
	var(reqST,6);
	varpair(reqSkills,pair("knife",-4); pair("dx",-5); pair("fencing",-4); pair("sword",0));
	var(closeCombat,false);
	var(parryCapability,WEAPON_PARRY_ENABLE);
	var(parryBonus,0);
	var(attackType,hashSet_createList(ATTACK_TYPE_SWING arg ATTACK_TYPE_THRUST));
	var(reach, REACH_DEFAULT + 0.7);

	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,0); pair(ATTACK_TYPE_THRUST,0));

	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CUTTING); pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_IMPALING));

	var(attackSoundList,[soundData("attacks\wpnhit1",0.8,1.5) arg soundData("attacks\wpnhit2",0.8,1.5) arg soundData("attacks\wpnhit3",0.8,1.5)]);
	var(missSoundList,[soundData("attacks\blademiss1",0.8,1.5) arg soundData("attacks\blademiss2",0.8,1.5) arg soundData("attacks\blademiss3",0.8,1.5) arg soundData("attacks\blademiss4",0.8,1.5)])
endclass

//мечи берутся из двуручного 

class(WeapHalfHandedSword) extends(WeapSword)
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+2); pair(ATTACK_TYPE_THRUST,+3));
	var(reqST,10);
	var(reach, REACH_DEFAULT + 0.8);
	var(reqTwoHands,true);
endclass

class(WeapTwoHandedSword) extends(WeapSword)
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+3); pair(ATTACK_TYPE_THRUST,+3));
	var(reqST,12);
	var(reach, REACH_DEFAULT + 0.95);
	var(reqTwoHands,true);
endclass