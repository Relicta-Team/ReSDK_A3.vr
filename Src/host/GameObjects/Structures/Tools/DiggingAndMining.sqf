// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(BunchOfShit) extends(IStruct)
	var(name,null);
	var(desc,null);
	getterconst_func(getName,"Кучка");
	getterconst_func(getDesc,"Куча отходов жизнедеятельности.");
	var(model,"a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d");
	var(material,"MatDirt");
	var(dr,3);

	var(toShitDigsLeft,randInt(2,10));

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Shovel) exitWith {
			callSelfParams(onDig,_with arg _usr);
		};
	};

	func(onDig)
	{
		objParams_2(_Shovel,_usr);
		if !isNullObject(getVar(_Shovel,content)) exitWith {
			callFuncParams(_usr,localSay,"Сначала надо освободить лопату." arg "error");
		};

		private _roll = callFuncParams(_usr,checkSkill,"engineering");
		if (getRollType(_roll) in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			callFuncParams(_usr,addStaminaLoss,randInt(2,5));
		} else {
			callFuncParams(_usr,addStaminaLoss,randInt(15,20));
			private _r = pick ["значительные","большие","значимые","немалые"];
			callFuncParams(_usr,meSay,"прилагает " + _r + " усилия.");
		};

		callFunc(_Shovel,playDigSound);

		modSelf(toShitDigsLeft,-1);
		if (getSelf(toShitDigsLeft) <= 0) then {
			callFuncParams(_usr,meSay,"насаживает на лопату находку.");
			setVar(_Shovel,content,new(Tumannik));
			setVar(getVar(_Shovel,content),loc,_Shovel);
			setSelf(toShitDigsLeft,randInt(10,15));
		};
	};

endclass

class(MotherBunchOfShit) extends(BunchOfShit)
	getterconst_func(getDesc,"Будто каменная засохшая однородная масса. Её не покопаешь...");
	var(model,"a3\structures_f_enoch\military\training\shellcrater_02_small_f.p3d");
endclass
