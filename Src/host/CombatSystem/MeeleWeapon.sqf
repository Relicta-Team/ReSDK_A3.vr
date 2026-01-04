// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include "..\GURPS\gurps.hpp"
#include <CombatSystem.hpp>
#include <..\GameObjects\GameConstants.hpp>

#include "Functions.sqf"

class(WeaponModuleBase) attribute(weapModule)
	var(isCommon,true); //Флаг общего модуля. Такие модули распространяются на целые слои типов ссылаясь на один объект. Изменять можно только уникальные модули

	func(Copy) //копирует общий модуль, делая его уникальным
	{
		objParams();
		private _nobj = createObj;
		private _val = 0;
		{
			_val = this getvariable _x;

			if (_val isEqualType []) then {
				_val = parseSimpleArray str _val;//unref array
			};
			// copy hashmaps
			if equalTypes(_val,hashMapNull) then {
				_val = createHashMapFromArray parseSimpleArray str _val;
			};

		    _nobj setVariable [_x,_val];
		} forEach (allVariables this);
		setVar(_nobj,isCommon,false);
		_nobj
	};
	
	func(copyIfCommon)
	{
		objParams();
		if getSelf(isCommon) then {
			callSelf(Copy)
		} else {
			this
		}
	};
	
endclass

//Чтобы использовать модификатор двуручного оружия добавьте к типу постфикс ATTACK_TYPE_SWING+"2h"
class(MeleeWeapon) extends(WeaponModuleBase)

	var(defenceBy,"оружия");//с помощью чего отразит или парирует атаку

	getter_func(getMissAttackWeaponText,"оружием"); //при промахах

	//Список звуков (как sound data) при атаке
	var(attackSoundList,[soundData("attacks\punch1",0.8,1.5) arg soundData("attacks\punch2",0.8,1.5) arg soundData("attacks\punch3",0.8,1.5)]);
	func(getAttackSoundData)
	{
		objParams_1(_att);
		pick getSelf(attackSoundList)
	};

	var(missSoundList,[soundData("attacks\punchmiss",0.8,1.5)]);
	getter_func(getMissSoundData, pick getSelf(missSoundList));

	varpair(reqSkills,pair("fight",0)); //Требуемые навыки и бонусы (выбирается из самого большего.)
	var(closeCombat,false); //возможность атаки вплотную
	//var(canParry,false); //можно ли парировать
	//правило для парирования: НЕСБАЛАНСИРОВАННОЕ ОРУЖИЕ НЕ МОЖЕТ ПАРИРОВАТЬ ЕСЛИ ЮЗЕР УЖЕ АТАКОВАЛ В СВОЙ ХОД. Однако можно парировать второй рукой если там есть чем
	var(parryCapability,WEAPON_PARRY_UNABLE); //ДЛЯ ПАРИРОВАНИЯ: явялется ли оружие несбалансированным или фехтовальным
	var_num(parryBonus); //собсна сам бонус к парированию
	/*
		Не парировательное - все парирования с провалом
		Несбалансированное - после атаки будет не готово. дольше в 2 раза
		Парировательное - просто отражаем удар. обычная неготовность оружия после парировния
		Фехтовальное - как парировательное но с бонусом отражения. без задержек
	*/

	//Хэшсет возможных типов атаки
	var_hashmap(attackType); //ассоциация с dmg для ?видов? атаки

	varpair(attackedBy,pair(ATTACK_TYPE_THRUST,"атакует оружием") ; pair(ATTACK_TYPE_SWING,"атакует оружием")); //ассоциатор текста атаки оружием
	var(reach,REACH_DEFAULT); //максимальная досягаемость оружия (в метрах). 0 доступен только при closeCombat
	varpair(dmgBonus,pair(ATTACK_TYPE_THRUST,3) ; pair(ATTACK_TYPE_SWING,4)); // БОНУС: урон от оружия с выбранным типом атаки (attackType) -> attackType.find(ATTACK_TYPE_SWING)
	var_hashmap(dmgType); //типы повреждений для каждого attackType

	var(turnsToRecharge,0); //время на подготовку
	var(unreadyAfterAttack,false); //неготовность оружия после атаки (B270)
	var(reqSt,0); //мин. сила. от неё так же зависит урон (не может быть выше reqST *3) (see B270)
	var(reqTwoHands,false); //надо 2 руки для атаки

	var_bool(canBlock); //можно ли заблокировать атаку оружием

	var_hashmap(notes); //примечания из гурпсы

	/*
		rollAttack
		rollDefenseParry
		rollDefenseBlock
		onCritiSuccessAttack
		onCritFailAttack

		getAttackWeaponText - получить текстовое описание атаки оружием от урона
	*/

	//функция дистанции. Так например если схватить копье или секиру двумя руками до дистанция получится дальше
	func(getReach)
	{
		objParams_1(_usr);
		1
	};

	//может ли атаковать этим оружием в данной ситуации
	func(canAttackWithWeapon)
	{
		objParams_2(_src,_targ);
		true
	};

	//Находит максимальный требуемый скилл и использует его
	func(getMaxReqSkill)
	{
		objParams_1(_mob);

		private _curStat = 0;
		private _basicSkill = 0;
		private _stats = [];

		{
			_basicSkill = callFuncReflect(_mob,"get" + _x);
			_curStat = _basicSkill + _y;

			_stats pushback _curStat;
		} foreach getSelf(reqSkills);

		if (_stats isEqualTo []) exitWith {
			warningformat("Cant find max value in reqSkills - %1",callSelf(getClassName));
			0
		};

		wmLog("getMaxReqSkill: skills is %1",_stats);

		selectMax _stats
	};

	func(rollAttack)
	{
		objParams();
		private _maxSkill = callSelfParams(getMaxReqSkill,_caller);

		private _reqST = getSelf(reqSt);
		private _callerSt = callFunc(_caller,getST);

		if (_reqST > 0) then {
			if (_reqST > _callerSt) then {
				wmLog("rollAttack: reqST > callerSt on %1 points; stamina loss cur: %2; new: %3",_reqST - _callerSt arg _stamina_loss_amount arg _stamina_loss_amount+((_reqST - _callerSt)*5));
				MOD(_maxSkill,- (_reqST - _callerSt));
				//тратим больше стамины. за каждое очко разницы 5 ед
				modvar(_stamina_loss_amount) + ((_reqST - _callerSt)*5);
				//TODO: и теряете дополнительное очко ЕУ в конце любой схватки вызывающей усталость.
			};
		};

		if (getSelf(reqTwoHands)) then {
			//если он не держит оружие в двух руках то атака медленнее
			if !callFuncParams(_caller,isHoldedTwoHands,_attItem) then {
				wmLog("rollAttack: req two hands and single-handed attack. More delay for next attack (old:%1 new:%2)",_delay_next_attack arg _delay_next_attack * 1.7)
				modvar(_delay_next_attack) * 1.7;
			};
			//TODO нужны функции прорвеки наличия рук
		};

		MOD(_maxSkill,+ callSelf(attackModifier));

		//MOD(_maxSkill,+5);//combat mode

		wmLog(" -> Effective skill value %1",_maxSkill);

		throw3d6(_maxSkill)
	};

	func(attackModifier)
	{
		objParams();
		private _modif = 0;
		//за зону попадания
		#define isZoneIn(zones,modif,aimmodif) if (_attTargetZone in [zones]) exitWith {ifcheck(_isAimed,MOD(_modif,aimmodif),MOD(_modif,modif))}
		if (!_attIsRandomTargetZone) then {
			private _isAimed = equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK);
			wmLog("attackModifier: is non-random target zone. Атакуем %1",[_attTargetZone arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString);

			isZoneIn(TARGET_ZONE_TORSO arg TARGET_ZONE_ABDOMEN,+4,+0);
			isZoneIn(TARGET_ZONE_ARM_R arg TARGET_ZONE_ARM_L arg TARGET_ZONE_LEG_L arg TARGET_ZONE_LEG_R,+2,-2);
			isZoneIn(TARGET_ZONE_GROIN,+1,-3);
			isZoneIn(TARGET_ZONE_FACE arg TARGET_ZONE_NECK arg TARGET_ZONE_MOUTH,-1,-5);
			isZoneIn(TARGET_ZONE_HEAD,-3,-7);
			isZoneIn(TARGET_ZONE_EYE_R arg TARGET_ZONE_EYE_L,-5,-9);
		} else {
			if equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK) then {
				modvar(_modif) + 3;
			};
		};

		if (callFunc(_target,isGrabbed) && !_attIsRandomTargetZone) then {
			//по схваченному легче попасть (с 400 - Захваты и зоны попадания)
			_modif = round(_modif / 2);

			wmLog("attackModifier: target is grabbed. New modif value is %1",_modif);
		};
		if callFunc(_caller,isGrabbed) then {
			modvar(_modif) - 4;//модификаторы контактного боя
		};

		//за маневры и движенеие
		if (_attCombatStyle == COMBAT_STYLE_AIMED_ATTACK) then {
			wmLog("attackModifier: is combat style aimed attack.",0);
			MOD(_modif,+4);
		};


		//За скорость
		private _callerSpeed = callFunc(_caller,getSpeedMode);
		wmLog("attackModifier: caller speed mode was <%1>",_callerSpeed);
		//private _targetSpeed = callFunc(_target,getSpeedMode);
		if (_callerSpeed > SPEED_MODE_RUN) then {
			wmLog("attackModifier: caller was sprinting. set restrictionByModifier = true",0);
			_restrictionByModifier = true; //ограничение по модификатору
			MOD(_modif,-2);
		};

		//За положение атакующего
		private _callerStance = callFunc(_caller,getStance);
		private _targetStance = callFunc(_target,getStance);
		wmLog("attackModifier: caller stance %1, target stance %2",_callerStance arg _targetStance)
		//c 547
		//ты лежишь тебе штраф
		if (_callerStance == STANCE_MIDDLE) then {MOD(_modif,-1)};
		if (_callerStance == STANCE_DOWN) then {MOD(_modif,-4)};

		//он присел - проще попасть
		if (_targetStance == STANCE_MIDDLE) then {modvar(_modif) + 4};
		private _targActivity = !callFunc(_target,isActive) || callFunc(_target,isStunned);
		if (_targActivity || _targetStance == STANCE_DOWN) then {
			wmLog("attackModifier: target is non active %1; is down stance %2",_targActivity arg _targetStance == STANCE_DOWN);
			if (_targActivity) then {
				MOD(_modif,+ 14);//по бессознательному проще попасть
			} else {
				modvar(_modif) + 10;//По лежащему проще попасть но он в сознании
			};
		};

		//reqST меньше силы персонажа => -1 за каждое очко разницы
		
		if !callFuncParams(_caller,hasPerk,"PerkSeeInDark") then {
			private _callerLight = callFunc(_caller,getLighting);
			if (_callerLight < LIGHT_MEDIUM) then {
				if (_callerLight == LIGHT_LOW) exitWith {modvar(_modif) -2};
				modvar(_modif) -4; //драка в полной темноте
			};
		};
		
		//с закрытыми глазами или без них не повоюешь
		private _viewmode = callFunc(_caller,getViewMode);
		if (_viewmode < VIEW_MODE_FULL) then {
			modvar(_modif) + ifcheck(equals(_viewmode,VIEW_MODE_MEDIUM),-5,-10);
			_restrictionByModifier = true;
		};

		//атака неосновной рукой
		if (!callSelfParams(isHoldedTwoHands,_attItem) && {getVar(_caller,mainHand)!=getVar(_attItem,slot)}) then {
			modvar(_modif) - 2;
		};

		//когда по персонажу ведут огонь на подавление ему сложнее драться
		/*if (getVar(_caller,penaltySupressFire)>0)then{
			modvar(_modif) - getVar(_caller,penaltySupressFire);
		};*/

		// --- TODO ---
		//бонус калеру за комбат мод
		//бонус калеру если таргет не включил комбат мод
		//так же проще попасть по цели, которая лежит, застанена или без сознания
		// если цель НЕ ЛЕЖИТ то
		/*
			_isSideChecked = false;
			#define SSC _isSideChecked = true;
			if (!_isSideChecked and {_side == "l" and _selectedPart in ["hand_r","arm_r","leg_r","foot_r","eye_r"]}) then {SSC _mod -= 2};
			if (!_isSideChecked and {_side == "r" and _selectedPart in ["hand_l","arm_l","leg_l","foot_l","eye_l"]}) then {SSC _mod -= 2};
			if (!_isSideChecked and {_side == "back" and _selectedPart in ["groin","stomach","eye_r","eye_l","mouth","face"]}) then {SSC _mod -= 2};
		*/

		if (_restrictionByModifier) then {
			_modif = _modif min 9; //из правил
		};
		wmLog("attackModifier: Final attack mod %1",_modif);
		_modif
	};

	func(rollDefenseBlock)
	{
		objParams();

		if !getSelf(canBlock) exitWith {
			customRollResult(0,DICE_FAIL,0);
		};
	};

	func(rollDefenseParry)
	{
		objParams_1(_mob);

		if (getSelf(parryCapability)<=WEAPON_PARRY_UNABLE) exitWith {
			customRollResult(-5,DICE_FAIL,0);
		};

		private _defCurCombatStyle = getVar(_mob,curCombatStyle);
		if !getVar(_mob,isCombatModeEnable) then {
			_defCurCombatStyle = COMBAT_STYLE_NO;
		};
		private _isDefenceStyle = equals(_defCurCombatStyle,COMBAT_STYLE_T_DEFENSE);
		private _maxSkillDef = callSelfParams(getMaxReqSkill,_mob);
		if (_isDefenceStyle) then {
			modvar(_maxSkillDef) + 3;
		};
		//вызовется при контратаке - этому персонажу сложнее уберечься
		if !isNullVar(_flagTDEF_onAttack) then {
			modvar(_maxSkillDef) - 3;
		};

		if !isNullVar(_attCurCombatStyle) then {
			//от яростной атаки цель испытывает штраф к защите
			if equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK) then {
				modvar(_maxSkillDef) - 2;
			};

			// уязвимость к финтам при защите
			if (equals(_attCurCombatStyle,COMBAT_STYLE_FINT) && _isDefenceStyle) then {
				modvar(_maxSkillDef) - 2;
			};
		};
		//добавляем бонус к парированию
		modvar(_maxSkillDef) + getSelf(parryBonus);

		throw3d6(3 + (floor (_maxSkillDef/2)))
	};

	func(getAttackWeaponText)
	{
		objParams_1(_attType);

		getSelf(attackedBy) getOrDefault [_attType,"!!!атакует!!!"]
	};

	func(getFeintWeaponText)
	{
		objParams();
		//"обманно","разводно","финтуя","фальшиво","уловочно"
		pick["финтует в","проводит обманную атаку в","уловкой атакует","финтит в","разводит финт в","облапошивает в"]
	};

	func(getDmgBonus)
	{
		objParams_1(_attType);
		getSelf(dmgBonus) getOrDefault [_attType,0]
	};


	func(getDmgType)
	{
		objParams_1(_attType);
		#ifdef EDITOR
		if !(_attType in getSelf(dmgType)) then {
			errorformat("CANT FIND DAMAGE TYPE %1 IN WEAPON MODULE %2 -> %3",_attType arg callSelf(getClassName) arg getSelf(dmgType));
		};
		#endif
		private _dt = getSelf(dmgType) getOrDefault [_attType,"NONDEF"];
		if (_dt == "NONDEF") then {
			private _map = getSelf(dmgType);
			if (count _map == 0) exitWith {_dt = DAMAGE_TYPE_CRUSHING};
			_dt = _map get ((keys _map) select 0);
		};
		_dt
	};

	//событие при критическом попадании.
	func(onCritiSuccessAttack)
	{
		objParams();

		//Используется внутренняя ссылка _rules_critAttack

		//Любое удваивание или утраивание повреждений относится к базовому вреду (но не к урону)

		private _d = _3D6;
		#ifdef ca_emulate_rule
			_d = ca_emulated_rule_roll;
		#endif

		_rules_critAttack = if (_attTargetZone in TARGET_ZONE_LIST_HEAD) then {
			traceformat("CRITSUCCESS: TO HEAD RESULT - %1",_d);
			if (_d == 3) exitWith {
				//максимальный обычный вред и игнор СП
				RULE_CA_HEAD_MAXDMG_INGNORSP
			};
			if (_d in [4,5]) exitWith {
				/*
				CП цели защищает с поло-
				винной эффективностью (ок-
				ругляется вниз) после приме-
				нения всех делителей брони.
				Если любое количество вреда
				прошло через СП, считайте
				этот удар как нанесший серьёз-
				ную рану, независимо от реаль-
				но нанесенного вреда
				*/
				RULE_CA_HEAD_SP2_MAJW
			};
			if (_d in [6,7]) exitWith {
				/*
				Если атака была нацелена в
				лицо или череп, удар попадает
				в глаз, даже если эта атака не
				может естественным образом
				наноситься в глаз. Если удар в
				глаза невозможен (например,
				удар сзади), считайте анало-
				гично результату 4.
				*/

				if (_dir == DIR_BACK || !(_attTargetZone in [TARGET_ZONE_FACE,TARGET_ZONE_HEAD])) exitWith {RULE_CA_HEAD_SP2_MAJW};

				private _tzeyesarr = [TARGET_ZONE_EYE_R arg TARGET_ZONE_EYE_L];
				private _first_eye = _tzeyesarr deleteat randInt(0,1);
				private _second_eye = _tzeyesarr select 0;

				if (!callFuncParams(_target,hasPartToApplyDamage,_first_eye)) then {
					//один из рандомных глазов уже отсутствует. Выберем другой
					if (!(callFuncParams(_target,hasPartToApplyDamage,_second_eye))) exitWith {RULE_CA_HEAD_SP2_MAJW};
					_attTargetZone = _second_eye;
					_attackedZoneText = _attackedZoneText + ", но попадает в " + callFuncParams(_target,getTargetZoneName,_attTargetZone) + ".";
					RULE_CA_HEAD_RELOCTOEYE
				} else {
					//can reselect eye
					_attTargetZone = _first_eye;
					_attackedZoneText = _attackedZoneText + ", но попадает в " + callFuncParams(_target,getTargetZoneName,_attTargetZone) + ".";
					RULE_CA_HEAD_RELOCTOEYE
				};

			};
			if (_d == 8) exitWith {
				//Обычное повреждение от удара по голове, цель теряет равновесие. (Прим дев. возможно накинуть стан)
				callFunc(_target,KnockDown);
				MOD(_postMessageEffect, + " Цель теряет равновесие.");
				RULE_CA_HEAD_NO
			};
			if (_d in [9,10,11]) exitWith {
				//обычный вред
				RULE_CA_HEAD_NO
			};
			if (_d in [12,13]) exitWith {
				/*
				Обычный вред от удара по
				голове. Если любое количество
				вреда прошло через СП, тупая
				атака вызывает глухоту (восста-
				новление – см. Длительность
				увечий, с.422), любая другая
				наносит жуткий шрам (жертва
				теряет один уровень внешнос-
				ти, а в случае разъедающего или
				обжигающего вреда – два).
				*/
				RULE_CA_HEAD_DEAF
			};
			if (_d == 14) exitWith {
				/*
				Обычный вред от удара в
				голову, жертва роняет оружие
				(если имела два оружия, брось-
				те еще кубик, чтобы опреде-
				лить, какое из них уронит).
				*/
				RULE_CA_HEAD_DROPWEAP
			};
			if (_d == 15) exitWith {
				//максимальный обычный вред
				RULE_CA_HEAD_MAXDMG
			};
			if (_d == 16) exitWith {RULE_CA_HEAD_DDAM}; //двойной вред
			if (_d == 17) exitWith {
				/*
				CП цели защищает с поло-
				винной эффективностью (ок-
				ругляется вниз) после примене-
				ния всех делителей брони.
				*/
				RULE_CA_HEAD_SP2
			};
			if (_d == 18) exitWith {
				//Тройной вред
				RULE_CA_HEAD_TDAM
			};
			-1
		} else {
			//traceformat("CRITSUCCESS: TO RESULT - %1",_d);
			if (_d in [3,18]) exitWith {
				//тройной вред
				RULE_CA_HEAD_TDAM
			};
			if (_d in [4,17]) exitWith {
				/*
				СП цели защищает с половин-
				ной эффективностью (округля-
				ется вниз) после применения
				всех делителей брони.
				*/
				RULE_CA_HEAD_SP2
			};
			if (_d in [5,16]) exitWith {RULE_CA_HEAD_DDAM};//двойной вред
			if (_d in [6,15]) exitWith {RULE_CA_HEAD_MAXDMG}; //обычный максимальный вред
			if (_d in [7,13,14]) exitWith {
				/*
					Если любое количество вреда
					прошло через СП, считайте
					этот удар как нанесший серьёз-
					ную рану, независимо от реаль-
					но нанесенного вреда.
				*/
				RULE_CA_MAJW
			};
			if (_d == 8) exitWith {
				/*
				Если любое количество вреда
				пробивает СП, удар наносит
				удвоенный болевой шок (до
				максимального штрафа -8).
				Если удар пришелся в конеч-
				ность или придаток, он также
				калечит их. Это только времен-
				ный эффект: увечье пройдет
				через (16-ЗД) секунд, минимум
				через две, если нанесенного
				вреда было недостаточно для
				реального увечья.
				*/
				RULE_CA_DSHOCK
			};
			if (_d in [9,10,11]) exitWith {
				//обычный вред
				RULE_CA_HEAD_NO
			};
			if (_d == 12) exitWith {
				/*
				Обычный вред, и жертва ро-
				няет все, что держит, независи-
				мо от того, пробил ли удар СП.
				*/
				RULE_CA_DROPALL
			};
			-1
		};

	};

	//событие перед нанесением урона. возможна модификация значений или выполнение дополнительных действий
	abstract_func(onDamage);

	//событие при критическом провале атаки или ПАРИРОВАНИЯ (сейчас работается как крит провал в рукопашке)
	func(onCritFailAttack)
	{
		objParams();

		private _d = _3D6;

		//Переменная которая указывает что был бросок защиты. в противном случае идёт как провал при атаке
		private _isDefRoll = !isNullVar(_defRollType);

		#ifdef cf_emulate_rule
			_d = cf_emulate_rule_roll;
		#endif

		if (_d in [3,4, 17,18]) exitWith {
			/*
			 - Ваше оружие ломается и ста-
			новится бесполезным. Исклю-
			чение: Некоторые виды ору-
			жия устойчивы к поломке. Это
			твердые, прочные виды тупого
			оружия (палицы, цепы, булавы,
			металлические прутья и т.д.),
			магическое оружие, огнестрель-
			ное оружие (кроме оружия с ко-
			лесцовым замком, управляемых
			ракет и лучевого оружия) и ору-
			жие отличного качества. Если
			у вас подобное оружие, брось-
			те еще раз; Только если второй
			раз выпал результат «поломка
			оружия», то оно действительно
			ломается. Если вы выбросили
			другое число, то роняете оружие.
			См. Сломанное оружие (с.485).
			*/

			MOD(_postMessageEffect, + format[" %1 чуть не ломает оружие." arg callFuncParams(_caller,getNameEx,"кто")]);
		};
		if (_d in [5,6]) exitWith {
			/*
			Вы ухитрились попасть по сво-
			ей руке или ноге (50% шанс для
			каждого случая). Исключение:
			Если это была проникающая или
			пробивающая дистанционная
			атака, бросьте еще раз. Пырнуть
			себя трудно, но возможно. Если
			второй раз выпал результат «по-
			падание по себе», считайте что
			он и случился - наносится поло-
			вина или полные повреждения,
			в зависимости от обстоятельств.
			Если же выпал другой результат
			– используйте его.
			*/
			MOD(_postMessageEffect, + format[" %1 попадает по себе." arg callFuncParams(_caller,getNameEx,"кто")]);

		};
		if (_d in [7,13]) exitWith {
			/*
			Вы теряете равновесие. Вы ничего
			не можете делать (даже свобод-
			ных действий) до следующего
			хода. Все виды активной защиты
			получают -2 до следующего хода.
			*/
			MOD(_postMessageEffect, + format[" %1 теряет равновесие." arg callFuncParams(_caller,getNameEx,"кто")]);

		};
		if (_d in [8,12]) exitWith {
			/*
			Рука соскальзывает с оружия.
			Потратьте дополнительный ход
			на Подготовку, чтобы пригото-
			вить его перед следующим ис-
			пользованием.
			*/
			MOD(_postMessageEffect, + format[" Рука %1 соскальзывает с оружия." arg callFuncParams(_caller,getNameEx,"кого")]);
		};
		if (_d in [9,10,11]) exitWith {
			/*
			Вы роняете оружие. Ис-
			ключение: Дешевое оружие лома-
			ется, см. 3.
			*/
			MOD(_postMessageEffect, + format[" %1 роняет оружие из рук." arg callFuncParams(_caller,getNameEx,"кто")]);
			callFunc(_caller,dropAllItemsInHands);
		};
		if (_d == 14) exitWith {
			/*
			При проведении амплитудной
			контактной атаки ваше оружие
			вылетает из руки на 1к ярдов - с
			50% вероятностью прямо вперед
			или прямо назад. Находящиеся
			в месте падения, должны сделать
			успешную проверку ЛВ или по-
			лучить половину повреждений
			от падающего оружия! Если вы
			делали прямую атаку в контакт-
			ном бою, парировали или атако-
			вали дистанционным оружием,
			вы просто роняете оружие, как
			описано в пункте 9 выше.
			*/
		};
		if (_d == 15) exitWith {
			/*
			Вы растянули плечо! Рука, ко-
			торой вы держали оружие, «сло-
			мана» до конца встречи. Вы не
			обязательно роняете оружие, но
			не можете использовать его ни
			для защиты, ни для нападения
			в течение 30 минут.
			*/
		};
		if (_d == 16) exitWith {
			/*
			Вы падаете! (При использова-
			нии дистанционного оружия
			см. 7)
			17, 18 – Ваше
			*/
			callFunc(_caller,KnockDown);

		};

	};

	//вызывается при промахе
	func(onMiss)
	{
		objParams();
		callFuncParams(_caller,playSoundData,callSelf(getMissSoundData));
	};

endclass
