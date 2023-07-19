// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//стена
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallWall) extends(Constructions) var(name,"Стена"); var(desc,"Маленькие стена" pcomma " которую можно разрушить"); endclass


class(Trench) extends(SmallWall)
	var(name,"Траншея");
	var(model,"a3\structures_f_exp\military\trenches\trench_01_forest_f.p3d");
	
	//Размер траншеи. по умолчанию полностью выкопана. при достижении единицы - удаляется
	var(trenchSize,5);
	
	getter_func(getModelPosition,getPosWorldVisual callSelf(getBasicLoc));
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Shovel) exitWith {
			callSelfParams(digTrench,_usr arg _with);
		};
	};
	
	func(digTrench)
	{
		objParams_2(_usr,_shovel);
		
		
		
		private _isUpper = equals(callFuncParams(_usr,getDirTo,this),DIR_FRONT);
		
		if (getSelf(trenchSize) >= 20 && _isUpper) exitWith {
			callFuncParams(_usr,localSay,"Больше не выкопать." arg "error");
		};
		private _time = ifcheck(_isUpper,getVar(_usr,rta) * 1,getVar(_usr,rta) * 5);
		callFunc(_shovel,playDigSound);
		callFuncParams(_usr,startProgress,this arg "target.doDigTrench" arg _time arg INTERACT_PROGRESS_TYPE_FULL arg _shovel);
	};
	
	func(doDigTrench)
	{
		objParams_2(_usr,_shovel);
		private _isUpper = equals(callFuncParams(_usr,getDirTo,this),DIR_FRONT);
		if (getSelf(trenchSize) >= 20 && _isUpper) exitWith {
			callFuncParams(_usr,localSay,"Больше не выкопать." arg "error");
		};
		
		private _roll = callFuncParams(_usr,checkSkill,"engineering");
		if (getRollType(_roll) in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			private _staLoss = randInt(5,10);
			if callFuncParams(_usr,isHoldedTwoHands,_shovel) then {
				_staLoss = randInt(1,5);
			};
			if (_isUpper) then {modvar(_staLoss) * 2};
			callFuncParams(_usr,addStaminaLoss,_staLoss);
		} else {
			private _staLoss = randInt(15,20);
			if callFuncParams(_usr,isHoldedTwoHands,_shovel) then {
				_staLoss = randInt(5,10);
			};
			if (_isUpper) then {modvar(_staLoss) * 2};
			callFuncParams(_usr,addStaminaLoss,_staLoss);
			private _r = pick ["значительные","большие","значимые","немалые"];
			callFuncParams(_usr,meSay,"прилагает " + _r + " усилия.");
		};
		
		callFunc(_shovel,playEmptySound);
		private _modifVal = ifcheck(_isUpper,+1,-1);
		private _modifBias = ifcheck(_isUpper,+0.06,-0.06);
		modSelf(trenchSize,+ _modifVal);
		
		if (getSelf(trenchSize)<= 0 && !_isUpper) exitWith {
			delete(this);
		};
		
		getSelf(loc) setPosWorld (callSelf(getModelPosition) vectorAdd [0,0,_modifBias]);
		callSelf(replicateObject);
	};
	
endclass

editor_attribute("EditorGenerated")
class(MediumBetonWall) extends(SmallWall)
	var(model,"ml_shabut\sbs\betonblocksbs.p3d");
endclass