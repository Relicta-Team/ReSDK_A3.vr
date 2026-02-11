// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>

#include <loader.hpp>


class(SEBase) extends(object)
	var(name,"Статус");
	
	getterconst_func(isOnetimeStatus,false);//единоразовые статусы не копируются в массив
	
	var_num(startTime); //отметка старта статуса
	var(loc,nullPtr); //источник статус эффекта
	
	func(destructor)
	{
		objParams();
		
		if isNullReference(getSelf(loc)) exitWith {};

		private _ref = getVar(getSelf(loc),__allStatusEffects);
		_ref deleteAt (_ref find this);
		callSelf(onDestroy);
	};
	
	//Вызывается при создании
	func(onCreate)
	{
		objParams_1(_data);
	};
	
	//событие если isOnetimeStatus == true и попытка повтороного создания
	func(onRecreate)
	{
		objParams_1(_data);
	};
	
	func(onDestroy)
	{
		objParams();
	};
	
	//Метод обработки
	func(onUpdate)
	{
		objParams();
	};
	
endclass

	#ifdef EDITOR
		class(SETest) extends(SEBase)
			var(counter,0);
			func(onCreate)
			{
				objParams_1(_data);
				callFuncParams(getSelf(loc),ShowMessageBox,"Text" arg "Эффект создан...");
			};
			
			func(onUpdate)
			{
				objParams();
				modSelf(counter, + 1);
				trace("status effect "+str getSelf(counter))
				if (getSelf(counter) >= 10) exitWith {
					delete(this);
				};
			};
			
			func(onDestroy)
			{
				objParams();
				callFuncParams(getSelf(loc),ShowMessageBox,"Text" arg "Эффект удален...");
			};
		endclass
	#endif

class(SEMedicalBase) extends(SEBase)
	var(name,"Медицинский эффект");
	
	getter_func(getCureMessage,"");//сообщение при излечении
	
	//триггеры срабатывания
	var(__triggers,null);
	getterconst_func(triggers,[]);
	
	//излечивание
	var(__cures,null);
	getterconst_func(cures,[]);
	
	func(getTriggers)
	{
		objParams();
		if isNull(getSelf(__triggers)) then {
			setSelf(__triggers,callSelf(triggers));
		} else {
			getSelf(__triggers);
		};
	};
	
	func(getCures)
	{
		objParams();
		if isNull(getSelf(__cures)) then {
			setSelf(__cures,callSelf(cures));
		} else {
			getSelf(__cures);
		};
	};
	
	//Может ли проявиться
	func(canManifest)
	{
		objParams();
		
		private _usr = getSelf(loc);
		
		if (
			({callFuncParams(getVar(_usr,reagents),getReagentVolume,_x select 0) >= (_x select 1)}count callSelf(getTriggers))>0
			) exitWith {true};
		false
	};
	
	//может ли излечить
	func(canCure)
	{
		objParams();
		
		private _usr = getSelf(loc);
		
		if (({
			_x params ["_n","_a"];
			callFuncParams(getVar(_usr,reagents),hasReagent,_n arg _a)
		} count callSelf(getCures)) > 0) exitWith {
			true
		};
		
		false
	};
	
	func(Cure)
	{
		objParams();
		private _usr = getSelf(loc);
		
		if not_equals(callSelf(getCureMessage),"") then {
			callFuncParams(_usr,mindSay,callSelf(getCureMessage));
		};
		
		delete(this);
	};
	
	func(onUpdate)
	{
		objParams();
		
	};
	
endclass
