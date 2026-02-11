// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

class(WeapPistolHandle) extends(MeleeWeapon)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"бьет рукояткой пистолета"));
	var(defenceBy,"рукоятки пистолета");
	getter_func(getMissAttackWeaponText,"рукояткой пистолета");
	varpair(reqSkills,pair("fight",-1) ; pair("dx",-2));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_UNABLE);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CRUSHING));
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,+1));
endclass


class(WeapLongRangeHandle) extends(WeapPistolHandle)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"бьет оружием"));
	var(defenceBy,"оружия");
	getter_func(getMissAttackWeaponText,"оружием");
	varpair(reqSkills,pair("fight",-1) ; pair("dx",-2));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_UNABLE);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CRUSHING));
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,+2));
endclass

class(WeapLongRangeButt) extends(WeapLongRangeHandle)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"бьет прикладом"));
	var(defenceBy,"приклада");
	getter_func(getMissAttackWeaponText,"прикладом");
endclass
