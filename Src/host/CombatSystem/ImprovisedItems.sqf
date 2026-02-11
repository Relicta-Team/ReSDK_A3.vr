// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

class(WeapShovel) extends(WeapHandyItem)
	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьёт лопатой"); pair(ATTACK_TYPE_THRUST,"пронзает лопатой"));
	var(defenceBy,"лопаты");
	getter_func(getMissAttackWeaponText,"лопатой");
	varpair(reqSkills,pair("fight",0); pair("dx",-1));
	var(closeCombat,true);
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,+1); pair(ATTACK_TYPE_SWING,0));
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST arg ATTACK_TYPE_SWING));
	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CRUSHING); pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_IMPALING));
	var(notes,hashSet_createEmpty());
	
	var(attackSoundList,[soundData("attacks\blunt_light",0.8,1.5) arg soundData("attacks\blunt_light2",0.8,1.5) arg soundData("attacks\blunt_light3",0.8,1.5)]);
	
	var(missSoundList,[soundData("attacks\swing3",0.8,1.5) arg soundData("attacks\swing4",0.8,1.5)]);
endclass

class(WeapCrowbar) extends(WeapHandyItem)
	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьёт ломом"); pair(ATTACK_TYPE_THRUST,"пронзает ломом"));
	var(defenceBy,"лома");
	getter_func(getMissAttackWeaponText,"ломом");
	varpair(reqSkills,pair("fight",0); pair("dx",-1));
	var(closeCombat,true);
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,-1); pair(ATTACK_TYPE_SWING,+1));
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST arg ATTACK_TYPE_SWING));
	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CRUSHING); pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_IMPALING));
	var(notes,hashSet_createEmpty());

	var(attackSoundList,[soundData("attacks\crowbarhit",0.8,1.5) arg soundData("attacks\crowbarhit2",0.8,1.5)]);

	var(missSoundList,[soundData("attacks\swing3",0.8,1.5) arg soundData("attacks\swing4",0.8,1.5)]);
endclass

class(WeapBaton) extends(WeapHandyItem)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"бьет дубинкой"));
	var(defenceBy,"дубинки");
	getter_func(getMissAttackWeaponText,"дубинкой");
	varpair(reqSkills,pair("baton",-2) ; pair("dx",-1));
	var(closeCombat,true);
	var(reach, REACH_DEFAULT);
	var(reqST,7);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CRUSHING));
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,0));
	var(parryCapability,WEAPON_PARRY_UNBALANCED);
	var(parryBonus,0);

	var(attackSoundList,[soundData("attacks\baton",0.8,1.5)]);
	var(missSoundList,[soundData("attacks\swing1",0.8,1.5) arg soundData("attacks\swing2",0.8,1.5) arg soundData("attacks\swing3",0.8,1.5) arg soundData("attacks\swing4",0.8,1.5)])
endclass
/*
class(WeapChair) extends(WeapHandyItem)

endclass*/