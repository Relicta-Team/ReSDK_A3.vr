// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

class(MobOkopovoGamemode) extends(Mob)
	
	["war","eventPrikaz","eventPrikaz"] call ie_actions_regNew;
	["war","mySquad","getMySquad"] call ie_actions_regNew;

	var(__gmokopovo_mysquad,nullPtr);

	func(constructor)
	{
		objParams();
		//callSelfParams(addAction,"Война" arg "Отдать приказ" arg "war_eventPrikaz");
		callSelfParams(addAction,"Война" arg "Отряд" arg "war_mySquad");
	};

	func(eventPrikaz)
	{
		objParams();
		
		_h = {
			private _basicRole = getSelf(basicRole);
			if (
				!callFuncParams(gm_currentMode,isMobInBase,this arg getVar(_basicRole,side))
			) exitWith {
				callSelf(closeMessageBox);
				callSelfParams(localSay,"Вы слишком далеко от базы." arg "error");
			};
			
			private _squads = getVar(gm_currentMode,sergantesInSide) get getVar(_basicRole,side);
			if (isTypeOf(_basicRole,ROkopovoComBase) || isTypeOf(_basicRole,ROkopovoCombatSergant)) exitWith {
				_baseName = "Штаб";
				if isTypeOf(_basicRole,ROkopovoCombatSergant) then {_baseName = "Отряд"};
				if isTypeOf(_basicRole,ROkopovoCombatCommonRole) then {_baseName = "Приказ"};

				_baseBalue = _value;
				_value = "<t size='1.7' color='#38A8A8'>"+_baseName+": "+_value+"</t>";
				
				private _sqData = (_squads apply {getVar(_x,commander)});
				if isTypeOf(_basicRole,ROkopovoCombatSergant) then {
					_sqData = getVar(getSelf(__gmokopovo_mysquad),soldiers) + [getVar(getSelf(__gmokopovo_mysquad),commander)];
				};
				if isTypeOf(_basicRole,ROkopovoComBase) then {
					_sqData pushBackUnique this;
				};
				
				{
					callFuncParams(_x,mindSay,_value);
					callFuncParams(_x,playSoundLocal,"effects\tension6" arg getRandomPitchInRange(0.7,1.3));
				} foreach _sqData;
				callSelf(closeMessageBox);

				[format["(ARMYLOG) - %1 %2 (%3)",callSelfParams(getNameEx,"кто"),_baseBalue,getVar(getSelf(client),name)]] call rpLog;
			};
			callSelf(closeMessageBox);
		};
		callFuncParams(this,ShowMessageBox,"Input" arg ["Выдавай приказ" arg "" arg "Приказ" arg null] arg _h);
	};

	func(getMySquad)
	{
		objParams();
		private _basicRole = getSelf(basicRole);
		private _squads = getVar(gm_currentMode,sergantesInSide) get getVar(_basicRole,side);

		private _side = getVar(_basicRole,side);
		private _isShtab = isTypeOf(_basicRole,ROkopovoComBase);
		private _info = "";
		if (_isShtab) then {
			modvar(_info) + "Я командир";
		} else {
			modvar(_info) + format["Командир: %1", callFuncParams(getVarReflect(gm_currentMode,"leader"+_side),getNameEx,"кто")];
		};
		
		modvar(_info) + sbr + ifcheck(_isShtab,"Отряды","Наш отряд")+":";
		
		{
			if (_isShtab) then {
				modvar(_info) + sbr + (format[
					"    %1 - %2",
					getVar(_x,squadName),
					callFuncParams(getVar(_x,commander),getNameEx,"кто")
				]);
			} else {
				/*
					squad1
						com - name
						usr1 - name
						usr2 - name
				*/

				//Обычным работягам не видно чужие отряды
				if (isTypeOf(_basicRole,ROkopovoCombatCommonRole) && not_equals(getSelf(__gmokopovo_mysquad),_x)) exitwith {};

				modvar(_info) + sbr + (format["%1%2",getVar(_x,squadName),
					ifcheck(equals(getSelf(__gmokopovo_mysquad),_x)," - НАШ ОТРЯД","")
				]);
				modvar(_info) + sbr + (format[
					"    %1 - %2",
					getVar(getVar(getVar(_x,commander),basicRole),name),
					callFuncParams(getVar(_x,commander),getNameEx,"кто")
				]);
				{
					modvar(_info) + sbr + (format[
						"    %1 - %2",
						getVar(getVar(_x,basicRole),name),
						callFuncParams(_x,getNameEx,"кто")
					]);
				} foreach getVar(_x,soldiers);
			};
		} foreach _squads;

		callSelfParams(ShowMessageBox,"Text" arg _info);
	};

endclass