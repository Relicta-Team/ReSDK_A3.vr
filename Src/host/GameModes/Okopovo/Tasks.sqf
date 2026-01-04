// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

class(ROkopovoTask) extends(IGamemodeSpecificClass)
	var(name,"");
	var(desc,"");

	var(side,"");
	var(enemySide,"");

	func(handleTask)
	{
		objParams_1(_side); //side is string
		setSelf(side,_side);
		setSelf(enemySide,ifcheck(_side=="na","iz","na"));
	};

	func(canDone)
	{
		objParams();
		//Описывается условие. Возврат > 0 = победа по задаче, < = проигрышь по задаче
		//0 - пропуск 
	};

	var(result,0);

	func(getTextResult)
	{
		objParams();
		""
	};

	getter_func(sideToName,ifcheck(getSelf(side)=="na","Новая Армия","Истязатели"));
	getter_func(enemySideToName,ifcheck(getSelf(enemySide)=="na","Новая Армия","Истязатели"));

	getter_func(sideToNameWho,ifcheck(getSelf(side)=="na","Новой Армии","Истязателей"));
	getter_func(enemySideToNameWho,ifcheck(getSelf(enemySide)=="na","Новой Армии","Истязателей"));

endclass

//задача только для одной из сторон
class(ROkopovoTaskDefend) extends(ROkopovoTask)
	var(name,"Оборона");
	var(desc,"Нужно отбить все атаки противника и удержать позиции");

	func(canDone)
	{
		objParams();
		/*
			Правило:
				количество врагов 2/3 от количества вашего - проигрышь
				вас больше - без изменений
		*/
		private _mobsSide = callFuncParams(gm_currentMode,getActiveMobsInSide,getSelf(side));
		private _enemySide = callFuncParams(gm_currentMode,getActiveMobsInSide,getSelf(enemySide));
		private _mobsSideCount = 0;
		private _enemySideCount = 0;
		{
			if callFuncParams(gm_currentMode,isMobInBase,_x arg getSelf(side)) then {INC(_mobsSideCount)};
		} foreach _mobsSide;
		{
			if callFuncParams(gm_currentMode,isMobInBase,_x arg getSelf(side)) then {INC(_enemySideCount)};
		} foreach _enemySide;
		if (_mobsSideCount == 0 && _enemySideCount == 0) exitWith {0};
		
		private _isRoundEnd = (gm_roundDuration >= getVar(gm_currentMode,duration));
		private _enemyCaptived = _enemySideCount * 2 >= _mobsSideCount * 3;
		if (_isRoundEnd) then {
			if (_enemyCaptived) then {
				-1
			} else {
				1
			};
		} else {
			0
		};
	};

	func(getTextResult)
	{
		objParams();
		private _r = getSelf(result);
		if (_r == -1) exitwith {callSelf(sideToName) + " не смогли удержать точку"};
		if (_r == 1) exitwith {callSelf(sideToName) + " удержали позицию"};
		"---"
	};
endclass

//задача только для одной из сторон
class(ROkopovoTaskCaptive) extends(ROkopovoTask)
	var(name,"Штурм");
	var(desc,"Нужно захватить базу противника");

	func(canDone)
	{
		objParams();
		/*
			Правило:
				количество врагов 2/3 от количества вашего - проигрышь
				вас больше - без изменений
		*/
		private _mobsSide = callFuncParams(gm_currentMode,getActiveMobsInSide,getSelf(side));
		private _enemySide = callFuncParams(gm_currentMode,getActiveMobsInSide,getSelf(enemySide));
		private _mobsSideCount = 0;
		private _enemySideCount = 0;
		{
			if callFuncParams(gm_currentMode,isMobInBase,_x arg getSelf(enemySide)) then {INC(_mobsSideCount)};
		} foreach _mobsSide;
		{
			if callFuncParams(gm_currentMode,isMobInBase,_x arg getSelf(enemySide)) then {INC(_enemySideCount)};
		} foreach _enemySide;

		if (_mobsSideCount == 0 && _enemySideCount == 0) exitWith {0};

		private _myCaptived = _mobsSideCount * 2 >= _enemySideCount * 3;
		if (_myCaptived) then {
			1
		} else {
			if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
			0
		};
	};

	func(getTextResult)
	{
		objParams();
		private _r = getSelf(result);
		if (_r == -1) exitwith {callSelf(sideToName) + " не смогли захватить базу " + callSelf(enemySideToNameWho)};
		if (_r == 1) exitwith {callSelf(sideToName) + " захватили базу " + callSelf(enemySideToNameWho)};
		"---"
	};

endclass

class(ROkopovoTaskGetCommander) extends(ROkopovoTask)
	var(name,"Плен");
	var(desc,"Нужно захватить живым вражеского командира или лидера отряда и привести его на нашу базу");

	var(counter,0);
	var(needCount,60 * 2);
	func(canDone)
	{
		objParams();
		private _sergants = callSelf(getAllCommanders);
		traceformat("SERGANTS:%1",_sergants)
		private _hasInMyBase = false;
		{
			if (callFuncParams(gm_currentMode,isMobInBase,_x arg getSelf(side))
				&& {callFunc(_x,isHandcuffed)}
			) exitwith {
				_hasInMyBase = true;
			};
		} foreach _sergants;

		if (_hasInMyBase) then {
			modSelf(counter, + 1);
		};

		if (getSelf(counter) >= getSelf(needCount)) exitWith {1}; 

		0
	};

	func(getTextResult)
	{
		objParams();
		private _r = getSelf(result);
		if (_r == 1) exitwith {callSelf(sideToName) + " захватили командира " + callSelf(enemySideToNameWho)};
		"---"
	};

	func(getAllCommanders)
	{
		objParams();
		private _leaderbase = [ifcheck(getSelf(enemySide)=="na",getVar(gm_currentMode,leaderNA),getVar(gm_currentMode,leaderIZ))];
		
		{
			if isTypeOf(getVar(_x,basicRole),ROkopovoCombatSergant) then {_leaderbase pushBack _x};
		} foreach callFuncParams(gm_currentMode,getActiveMobsInSide,getSelf(enemySide));
		_leaderbase
	};
endclass

class(ROkopovoTaskGetDocs) extends(ROkopovoTask)
	var(name,"Вражеские бумаги");
	var(desc,"Нужно захватить вражеские бумаги и принести командиру");
	var(counter,0);
	var(needCount,60 * 2);
	func(canDone)
	{
		objParams();
		private _enemyDoc = getVar(gm_currentMode,docsInSide) get getSelf(enemySide);
		if isNullReference(_enemyDoc) exitwith {-1};
		if callFuncParams(gm_currentMode,isItemInBase,_enemyDoc arg getSelf(side)) exitwith {
			modSelf(counter, + 1);
			if (getSelf(counter) >= getSelf(needCount)) exitWith {1}; 
		};
		0
	};
	func(getTextResult)
	{
		objParams();
		private _r = getSelf(result);
		if (_r == 1) exitwith {callSelf(sideToName) + " заполучила вражеские ценные документы"};
		if (_r == -1) exitwith {"Ценные документы "+callSelf(enemySideToNameWho)+" были уничтожены"};
		"---"
	};
endclass

	class(ROkopovoPaperDocs) extends(Paper)
		var(name,"Документы");
		var(type,"na"); //тип документов для проверки уничтожения
		getter_func(canWrite,false);
		getter_func(canRead,false);
		var(model,"a3\structures_f\items\documents\file1_f.p3d");
		func(doBurn)
		{
			objParams_2(_srcFire,_usr);
			if (super()) then {
				private _d = callFunc(_usr,getLastPlayerClient);
				if !isNullReference(_d) then {
					callFuncParams(_d,removePoints,3);
				};
				true
			} else {false};
		};
	endclass