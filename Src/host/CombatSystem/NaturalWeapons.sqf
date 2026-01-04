// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "CombatSystem.hpp"

class(Fists) extends(MeleeWeapon)

	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"бьёт кулаком"));
	var(defenceBy,"руки");
	getter_func(getMissAttackWeaponText,"кулаком");
	varpair(reqSkills,pair("fight",0) ; pair("dx",0));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_ENABLE);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	var(reach, REACH_DEFAULT);

	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,-1));

	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CRUSHING));
	var(notes,hashSet_createList(3));


	//событие при критическом провале атаки или ПАРИРОВАНИЯ
	func(onCritFailAttack)
	{
		objParams();

		private _d = _3D6;

		//Переменная которая указывает что был бросок защиты. в противном случае идёт как провал при атаке
		private _isDefRoll = !isNullVar(_defRollType);

		#ifdef cf_emulate_rule
			_d = cf_emulate_rule_roll;
		#endif

		if (_d in [3,18]) exitWith {
			/*
			Вы вырубили себя! Подроб-
			ности – на усмотрение Масте-
			ра – возможно, вы поскользну-
			лись и ударились головой, или
			наткнулись лицом на щит или
			кулак противника. Бросайте ЗД
			каждые 30 минут для восста-
			новления сознания.
			*/
			private _rand = [
				" %1 умудряется вырубить себя.",
				" %1 подскальзывается и падает.",
				" %1 неудачно спотыкается и грохается головой вниз."
			];
			MOD(_postMessageEffect, + format[pick(_rand) arg callFuncParams(_caller,getNameEx,"кто")]);
			callFuncParams(_caller,setUnconscious,randInt(10,180));
		};
		if (_d in [4,17]) exitWith {
			/*
			Если вы парировали или ата-
			ковали конечностью, вы растя-
			нули ее: получите 1 единицу
			вреда, конечность считается
			«покалеченной». Вы не можете
			использовать ее для атаки и за-
			щиты в течение 30 минут. Если
			вы били головой, кусали и т.д.,
			вы потянули мышцы и ощуща-
			ете умеренную боль (см. Раздра-
			жающие состояния, с.428) в тече-
			ние (20-ЗД) минут, минимум 1
			минуту.
			*/
			warning("----------TODO RULE AND EFFECT----------");
			if (_isDefRoll) then {
				//TODO... при парировании делай красиво
				private _mes = " Получено растяжение " + callFuncParams(_target,getTargetZoneName,_attTargetZone) + ".";
				MOD(_postMessageEffect, + _mes);
			} else {
				private _zone = pick [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L];
				private _mes = " " + capitalize(callFuncParams(_caller,getTargetZoneName,_zone)) + " получает растяжение.";
				MOD(_postMessageEffect, + _mes);
			};

		};
		if (_d in [5,16]) exitWith {
			/*
			Вы ударили в твердый объект
			(стену, пол и т.д.) вместо врага
			или парирования его атаки. Ис-
			пользуемая конечность получа-
			ет тупой вред, равный вашему
			прямому вреду, ей наносимо-
			му; СП защищает нормально.
			Исключение: если вы атакуете
			противника, вооруженного го-
			товым проникающим оружием,
			то попадаете по оружию! Вы
			получаете вред от оружия, но
			основанный на своей СЛ, а не на
			СЛ противника.
			*/
			MOD(_postMessageEffect,+ " Удар пришёлся в " + pick["стену." arg "пол." arg "какой-то твёрдый предмет."]);

			private _dmgArr = callFuncParams(_caller,getDmgByAttackType,ATTACK_TYPE_THRUST);
			private _basicDamage = ((_dmgArr select 0) call gurps_throwdices) + (_dmgArr select 1);

			callFuncParams(_caller,applyDamage,_basicDamage arg DAMAGE_TYPE_CRUSHING arg pick [TARGET_ZONE_ARM_R arg TARGET_ZONE_ARM_L] arg DIR_FRONT arg di_crushingContact);
		};
		if (_d == 6) exitWith { //TODO вместить этот пункт к вышнему и просто обыграть условиями
			/*
			Аналогично 5, но получается
			половина вреда. Исключение:
			Если вы атаковали природным
			оружием – когтями, зубами и
			т.д.- оно ломается: -1 вреда от
			будущих атак, пока вы не вы-
			лечитесь (восстановление см. в
			разделе Длительность калеча-
			щих повреждений, с.422).
			*/
		};
		if (_d in [7,14]) exitWith {
			/*
			Вы спотыкаетесь. Если вы атако-
			вали, то проходите на один ярд
			за противника и заканчиваете
			свой ход, отвернувшись от него;
			сейчас он за вами! Парируя, вы
			падаете; см. 8.
			*/
		};
		if (_d == 8) exitWith {
			//Упасть
		};
		if (_d in [9,10,11]) exitWith {
			/*
			Вы теряете равновесие.
			Вы не можете ничего больше де-
			лать (даже свободных действий)
			до следующего своего хода, а
			все ваши активные защиты по-
			лучают в это время -2.
			*/
		};
		if (_d == 12) exitWith {
			/*
			Вы поскользнулись. Бросьте
			ЛВ, чтобы не упасть. Если вы
			били ногами, то бросайте ЛВ-
			4, или с удвоенным обычным
			штрафом, если использовали
			технику, требующую броска
			ЛВ даже при обычном провале
			(например, ЛВ-8 для Удара в
			прыжке).
			*/
		};
		if (_d == 13) exitWith {
			/*
			Вы ослабили защиту. Все виды
			активной защиты на следую-
			щий ход получают -2, любые
			премии Оценки или штрафа
			Финта против вас до следующе-
			го вашего хода имеют удвоенный
			эффект. Это очевидно находя-
			щимся поблизости врагам.
			*/
		};
		if (_d == 15) exitWith {
			/*
			Вы растянули мышцы. Полу-
			чите 1к-3 вреда используемой
			конечности (одной из них, если
			использовали несколько) или
			шее если кусали, бодали и т.д.
			Вы также теряете равновесие
			и получаете -1 на все атаки и
			защиту на следующий ход. Вы
			получаете -3 на любое дейс-
			твие, где нужно использовать
			поврежденную конечность (на
			любое действие, если повредили
			шею!) до исцеления повреж-
			дений. Если вы обладаете Вы-
			соким болевым порогом, этот
			штраф уменьшается до -1.
			*/
		};

	};

endclass

class(Punch) extends(Fists)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"пинает"));
	var(defenceBy,"ноги");
	getter_func(getMissAttackWeaponText,"ногой");
	varpair(reqSkills,pair("fight",-2) ; pair("dx",-2));
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_UNABLE);
	//var(dmgBonus,[0 arg 0]);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CRUSHING));
	var(notes,hashSet_createList(3 arg 4));
endclass

class(Bite) extends(Fists)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"кусает"));
	var(defenceBy,"зубов");
	getter_func(getMissAttackWeaponText,"зубами");
	varpair(reqSkills,pair("fight",0) ; pair("dx",0));
	var(reach,REACH_DEFAULT/2);
	var(closeCombat,true);
	var(parryCapability,WEAPON_PARRY_UNABLE);
	var(attackType,hashSet_createList(ATTACK_TYPE_THRUST));
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,-1));
	varpair(dmgType, pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CUTTING));
	//var(notes,hashSet_createEmpty());
	var(attackSoundList,[soundData("attacks\fangs_flesh",0.6,1.9)]);
endclass

//modded classes
class(Claws) extends(Fists)
	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"рвет когтями"));
	var(defenceBy,"когтей");
	getter_func(getMissAttackWeaponText,"когтями");
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,+2));

	varpair(dmgType,pair(ATTACK_TYPE_THRUST,DAMAGE_TYPE_CUTTING));

	var(attackSoundList,[soundData("attacks\claws",0.6,1.9)]);
	func(getAttackSoundData)
	{
		objParams_1(_att);
		pick getSelf(attackSoundList)
	};
endclass
