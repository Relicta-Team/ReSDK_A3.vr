// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("HiddenClass")
class(GMRevolution) extends(GMStationBase)
	var(name,"Революция");
	var(desc,"Кто-то задумал переворот. Остановите злодея или присоединитесь к нему.");
	var(descExtended,"Нынешний правитель кому-то сильно не понравился. Он должен выжить или погибнуть.");
	
	var(head,nullPtr);
	var(antag,nullPtr)
	
	var(duration,60*(60*2.5));
	
	func(postSetup)
	{
		objParams();
	};
	
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration>=getSelf(duration)) exitWith {1};
		
		if (isNullReference(getSelf(head)) || {getVar(getSelf(head),isDead)}) exitWith {2};
		if (isNullReference(getSelf(antag)) || {getVar(getSelf(antag),isDead)}) exitWith {3};
		0
	};
	
	func(getLeadingRolesInfo)
	{
		objParams();
		private _txt = "В главных ролях:";
		if !isNullReference(getSelf(head)) then {
			_txt = _txt + sbr + "Правитель - " + callFuncParams(getSelf(head),getNameEx,"кто") + (format[" (%1)",getVar(getVar(getSelf(head),client),name)]);
		};	
		if !isNullReference(getSelf(antag)) then {
			_txt = _txt + sbr + "Революционер - " + callFuncParams(getSelf(antag),getNameEx,"кто") + (format[" (%1)",getVar(getVar(getSelf(antag),client),name)]);
		};
		
		if (_txt != "") then {
			[_txt,"event"] call cm_sendOOSMessage;
		};
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		
		call {
			_fr = getSelf(finishResult);
			if (_fr == 1) exitWith {"Сегодня революционер не смог устроить переворот."};
			if (_fr == 2) exitWith {"Правитель скончался."};
			if (_fr == 3) exitWith {"Революционер погиб."};
			"Конец истории..."
		};
	};
	
endclass