// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

class(WeapHandyItem) extends(MeleeWeapon)
	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьет подручным предметом"));
	var(defenceBy,"подручного предмета");
	getter_func(getMissAttackWeaponText,"подручным предметом");
	varpair(reqSkills,pair("fight",-1) ; pair("dx",-2));
	var(closeCombat,true);
	var(attackType,hashSet_createList(ATTACK_TYPE_SWING));
	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CRUSHING));
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,-4));
	var(parryCapability,WEAPON_PARRY_UNBALANCED);
	var(parryBonus,-3);
endclass

class(GeneratedWeapHandyItem) extends(WeapHandyItem)
	var(attackSoundList,[soundData("attacks\blunt_light",0.8,1.5) arg soundData("attacks\blunt_light2",0.8,1.5) arg soundData("attacks\blunt_light3",0.8,1.5)]);
endclass

class(WeapGrabbedHuman) extends(WeapHandyItem)
	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьет схваченным"));
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,0));
	varpair(reqSkills,pair("fight",-2) ; pair("dx",-3));
endclass

