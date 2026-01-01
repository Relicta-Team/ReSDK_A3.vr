// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(BrushCleaner) extends(Item)
	var(name,"Щетка");
	var(desc,"Для оттирания крови от пола в самый раз.");
	//var(model,"a3\props_f_enoch\military\decontamination\brush_01_f.p3d"); //желтая
	var(model,"Brush_01_green_F");
	var(material,"MatSynt");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(230));
	var(dr,2);

	getterconst_func(isRedirectedInteractWith,true);
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,CleanableItem) exitwith {
			// !!! WARNING такая лапша может и к переполнению стека привести...
			callFuncParams(_with,onInteractWith,this arg _usr);
		};

		callFuncParams(_with,setGerms,(getVar(_with,germs) - randInt(20,40)) max 0);
		callFuncParams(_usr,meSay,"чистит "+callFunc(_with,getName));
		callFuncParams(_usr,playSound,"UNCATEGORIZED\clean" arg getRandomPitchInRange(0.9,1.3));
	};

	getterconst_func(canUseInteractToMethod,true);
	func(interactTo)
	{
		objParams_2(_targ,_usr);
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {
			callFuncParams(_usr,localSay,"Нет такой части тела" arg "error");
		};
		private _ahp = callFuncParams(_usr,getActiveHandPart,false);
		if isNullReference(_ahp) exitwith {
			callFuncParams(_usr,localSay,"Нечем чистить..." arg "error");
		};
		if (equals(_targ,_usr) && equals(_part,_ahp)) exitwith {
			callFuncParams(_usr,localSay,"Не достать." arg "error");
		};

		callFuncParams(_part,setGerms,(getVar(_part,germs) - randInt(20,40)) max 0);
		callFuncParams(_usr,meSay,"чистит "+ifcheck(equals(_targ,_usr),"себе",callFuncParams(_targ,getNameEx,"кому"))+" "+callFunc(_part,getName));
		callFuncParams(_usr,playSound,"UNCATEGORIZED\clean" arg getRandomPitchInRange(0.9,1.3));
		
		callFunc(_targ,syncGermsVisual);
		
	};

endclass