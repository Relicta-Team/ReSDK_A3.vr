// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "CombatSystem.hpp"



class(WeapAxe) extends(MeleeWeapon)

	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"рубит топором"));
	var(defenceBy,"топора");
	getter_func(getMissAttackWeaponText,"топором");
	var(reqST,11);
	varpair(reqSkills,pair("axe",0); pair("dx",-5));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_ENABLE);
	var(parryBonus,0);
	var(attackType,hashSet_createList(ATTACK_TYPE_SWING));
	var(reach, REACH_DEFAULT+0.2);

	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+0));

	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CUTTING));
	var(notes,hashSet_createEmpty());

	var(attackSoundList,[soundData("attacks\wpnhit1",0.8,1.5) arg soundData("attacks\wpnhit2",0.8,1.5) arg soundData("attacks\wpnhit3",0.8,1.5)]);
	var(missSoundList,[soundData("attacks\swing1",0.8,1.5) arg soundData("attacks\swing2",0.8,1.5) arg soundData("attacks\swing3",0.8,1.5) arg soundData("attacks\swing4",0.8,1.5)]);
endclass

class(WeapWorkingAxe) extends(WeapAxe)
	var(reqST,8);
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+2));
	var(notes,hashSet_createList(1));
	var(parryCapability,WEAPON_PARRY_UNBALANCED);
	var(reach, REACH_DEFAULT+0.4);
endclass

class(WeapBattleAxe) extends(WeapAxe)
	var(reqST,12);
	var(reqTwoHands,true);
	var(reach, REACH_DEFAULT + 1.2);
	varpair(attackedBy,pair(ATTACK_TYPE_SWING,"рубит секирой"); pair(ATTACK_TYPE_HANDLE,"бьёт рукоятью секиры"));
	var(defenceBy,"секиры");
	getter_func(getMissAttackWeaponText,"секирой");
	var(parryCapability,WEAPON_PARRY_UNBALANCED);
	var(notes,hashSet_createEmpty());
	var(attackType,hashSet_createList(ATTACK_TYPE_SWING arg ATTACK_TYPE_HANDLE));
	varpair(dmgType,pair(ATTACK_TYPE_SWING,DAMAGE_TYPE_CUTTING); pair(ATTACK_TYPE_HANDLE,DAMAGE_TYPE_CRUSHING));
	varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+4); pair(ATTACK_TYPE_HANDLE,+4));
	
	var(missSoundList,[soundData("attacks\wpn_swing_axe_01",0.8,1.5) arg soundData("attacks\wpn_swing_axe_02",0.8,1.5)]);
	
	func(getAttackSoundData)
	{
		objParams_1(_att);
		if (_att == ATTACK_TYPE_HANDLE) exitWith {
			pick [soundData("attacks\crowbarhit",0.8,1.5) arg soundData("attacks\crowbarhit2",0.8,1.5)]
		};
		pick getSelf(attackSoundList);
	};
endclass