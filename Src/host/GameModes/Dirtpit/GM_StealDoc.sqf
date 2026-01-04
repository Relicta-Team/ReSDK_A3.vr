// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("HiddenClass")
class(GMStealDoc) extends(GMStationBase)
	var(name,"Спиздили");
	var(desc,"Агент Новой Армии должен выкрасть секретные документы.");
	var(descExtended,"На станцию пробрался агент Новой Армии. Его цель - выкрасть секретные документы.");
	
	var(docs,nullPtr);
	var(antag,nullPtr);
	
	var(duration,60*(60*4));
	
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration>=getSelf(duration)) exitWith {1};
		
		if (isNullReference(getSelf(head)) || {getVar(getSelf(antag),isDead)}) exitWith {2};
		if isNullReference(getSelf(docs)) exitWith {3};
		0
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		
		call {
			_fr = getSelf(finishResult);
			if (_fr == 1) exitWith {"Агент слишком долго пытался выкрасть документы."};
			if (_fr == 2) exitWith {"Агент погиб"};
			if (_fr == 3) exitWith {"Документы уничтожены"};
			"Ничего не случилось..."
		};
	};
	
endclass