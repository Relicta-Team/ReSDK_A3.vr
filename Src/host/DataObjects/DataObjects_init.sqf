// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>

//#define LOG_DAMAGE_INFO_EDITOR

class(DataObjectBase)

endclass

#ifndef EDITOR
	#undef LOG_DAMAGE_INFO_EDITOR
#endif

/*
	Этот объект создается на игровых персонажах
	При каждом повреждении ему устанавливаются обновленные значения типа повреждений
*/
class(DODamageInfo) extends(DataObjectBase)

	var(loc,nullPtr);

	//время последней атаки
	var(lastUpdateTime,0);
	var(lastAttacker,nullPtr); //игровой объект или тип объекта
	var(lastAttackOptionalData,null); //дополнительные данные
	var(lastAttackerTime,0);

	//тип DamageInfoBase - последнее структурное повреждение
	var(damageInfo,nullPtr);
	//контекстные данные
	var(damageInfoData,null);

	func(updateDamageInfo)
	{
		objParams_2(_dObj,_ddata);
		setSelf(damageInfo,_dObj);
		setSelf(damageInfoData,_ddata);
		setSelf(lastUpdateTime,tickTime);

		private _m = callSelf(getDamagetInfoFull);
		#ifdef LOG_DAMAGE_INFO_EDITOR
		callFuncParams(getSelf(loc),localSay,_m arg "log");
		#endif
		[_m] call combatLog;
	};

	func(updateLastAttacker)
	{
		objParams_3(_usr,_wm,_optItem);
		//todo serialize common data
		setSelf(lastAttacker,_usr);
		setSelf(lastAttackOptionalData,vec2(_optItem,_wm));
		setSelf(lastAttackerTime,tickTime);

		private _m = callSelf(getDamagetInfoFull);
		#ifdef LOG_DAMAGE_INFO_EDITOR
		callFuncParams(getSelf(loc),localSay,_m arg "log");
		#endif
		[_m] call combatLog;
	};

	//Возвращает полный текст повреждений
	func(getDamagetInfoFull)
	{
		objParams();
		format[
			"Last update %1 sec ago; Last damage info: %2; Damage info %3; Last attacker %4 (%5 sec ago)" +
			"with %6",
			tickTime - getSelf(lastUpdateTime),
			ifcheck(isNullReference(getSelf(damageInfo)),"none",getVar(getSelf(damageInfo),name) + " -> " + callFunc(getSelf(damageInfo),getClassName)),
			getSelf(damageInfoData),
			if isNullReference(getSelf(lastAttacker)) then {"no"} else {
				callFuncParams(gm_currentMode,getCreditsInfo,getSelf(lastAttacker) arg false)
			},
			tickTime - getSelf(lastAttackerTime),
			if isNull(getSelf(lastAttackOptionalData)) then {
				"no_opt_data"
			} else {
				getSelf(lastAttackOptionalData) params ["_itm","_wm"];
				format["%1 (%2) as %3",callFunc(_itm,getName),callFunc(_itm,getClassName),callFunc(_wm,getClassName)]
			}
		]
	};

endclass


class(DamageInfoBase) extends(DataObjectBase)
	var(name,"повреждение");
endclass

class(DamageInfoFalling) extends(DamageInfoBase)
	var(name,"падение");
	attributeParams(initGlobalSingleton,"di_falling")
endclass

class(DamageInfoCrushingContact) extends(DamageInfoBase)
	var(name,"столкновение");
	attributeParams(initGlobalSingleton,"di_crushingContact")
endclass

class(DamageInfoOrganDamage) extends(DamageInfoBase)
	var(name,"повреждение органа");
	attributeParams(initGlobalSingleton,"di_organDamage")
endclass

class(DamageInfoBodyPartVitalLoss) extends(DamageInfoBase)
	var(name,"потеря жизненно важной части тела");
	attributeParams(initGlobalSingleton,"di_vitalPartLoss")
endclass

class(DamageInfoBodyPartVitalRotten) extends(DamageInfoBase)
	var(name,"гниение жизненно важной части тела");
	attributeParams(initGlobalSingleton,"di_vitalPartRotten")
endclass

class(DamageInfoBloodLoss) extends(DamageInfoBase)
	var(name,"кровотечение");
	attributeParams(initGlobalSingleton,"di_BloodLoss")
endclass

class(DamageInfoPartDamage) extends(DamageInfoBase)
	var(name,"повреждение части тела");
	attributeParams(initGlobalSingleton,"di_partDamage")
endclass

class(DamageInfoTrapDamage) extends(DamageInfoBase)
	var(name,"попадание в ловушку");
	attributeParams(initGlobalSingleton,"di_trapDamage")
endclass

class(DamageInfoHPLoss) extends(DamageInfoBase)
	var(name,"потеря жизненной силы");
	attributeParams(initGlobalSingleton,"di_lossHP")
endclass

class(DamageInfoGrenade) extends(DamageInfoBase)
	var(name,"взрыв гранаты");
	attributeParams(initGlobalSingleton,"di_grenade")
endclass
