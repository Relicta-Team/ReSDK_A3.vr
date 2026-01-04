// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>



class(BlockDirt) extends(Decor)
	var(name,"Земля");
	var(model,"block_dirt");
	var(material,"MatDirt");
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		
		if isTypeOf(_with,Shovel) exitWith {
			callSelfParams(processTrench,_usr arg callFunc(_usr,getLastInteractEndPos) arg _with);
		};
	};
	
	func(processTrench)
	{
		objParams_3(_usr,_pos,_shovel);
		
		private _dir = callFunc(_usr,getDir);
		private _bias = 1.5;
		private _forw = [sin (_dir) * _bias,cos (_dir) * _bias,0];
		_pos = _pos vectorAdd _forw;
		
		if ({_pos distance callFunc(_x,getModelPosition) < 4}count(["Trench",_pos,5,true] call getGameObjectOnPosition)>0) exitWith {
			callFuncParams(_usr,localSay,"Рядом уже выкопана траншея" arg "error");
		};
		
		callFunc(_shovel,playDigSound);
		callFuncParams(_usr,addStaminaLoss,randInt(2,6));
		([10,0,_dir-180] call model_convertPithBankYawToVec) params ["_dir","_up"];
		
		private _t = ["Trench",_pos,_dir,false,_up] call createStructure;
		setVar(_t,trenchSize,1);
	};
	
endclass

class(BlockBrick) extends(Decor)
	var(name,"Кирпич");
	var(model,"block_brick");
	var(material,"MatStone");
endclass

class(BlockStone) extends(Decor)
	var(name,"Камень");
	var(model,"block_strongstone");
	var(material,"MatStone");
endclass