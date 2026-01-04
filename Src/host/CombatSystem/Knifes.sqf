// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

class(WeapKnife) extends(MeleeWeapon)

	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"рубит ножом"); pair(ATTACK_TYPE_THRUST,"колет ножом"));
	var(defenceBy,"ножа");
	getter_func(getMissAttackWeaponText,"ножом");
	var(reqST,6);
	varpair(reqSkills,pair("knife",0); pair("dx",-4); pair("sword",-3));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_ENABLE);
	var(parryBonus,-1);
	var(attackType,hashSet_createList(ATTACK_TYPE_SWING arg ATTACK_TYPE_THRUST));
	var(reach, REACH_DEFAULT + 0.1);

	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,-2); pair(ATTACK_TYPE_THRUST,0));

	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CUTTING); pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_IMPALING));

	var(attackSoundList,[soundData("attacks\stab1",0.8,1.5) arg soundData("attacks\stab2",0.8,1.5) arg soundData("attacks\stab3",0.8,1.5)]);
	var(missSoundList,[soundData("attacks\swing3",0.8,1.5) arg soundData("attacks\swing4",0.8,1.5)])
endclass

class(WeapLittleKnife) extends(WeapKnife)
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,-3); pair(ATTACK_TYPE_THRUST,-1));
	var(reqST,5);
endclass

class(WeapDaggerKnife) extends(WeapKnife)
	var(reqST,5);
	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_IMPALING));
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,-1));
endclass