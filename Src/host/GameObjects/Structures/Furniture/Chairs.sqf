// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(IChair) extends(Furniture)
	var(name,"Сиденье");
	var(material,"MatWood");
	var(dr,2);

	#include "..\..\Interfaces\ISeat.Interface"

	getterconst_func(getChairOffsetPos,vec3(0,0,0));
	getterconst_func(getChairOffsetDir,0);
	getterconst_func(getCoefAutoWeight,10);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair) extends(IChair)
	var(model,"ml_exodusnew\virusbratan.p3d");
	var(material,"MatSynt");
	var(dr,1);
	var(name,"Коляска");
	var(desc,"Поговаривают если долго на ней сидеть, то можно подцепить вирус...");
	getter_func(getChairOffsetPos,[0 arg -0.05 arg -0.65]);
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getCoefAutoWeight,40);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair2) extends(Wheelchair)
	var(model,"relicta_models\models\nocategory\wheelchair2.p3d");
	getter_func(getChairOffsetPos,[0 arg 0 arg -0.73]);
	getterconst_func(getChairOffsetDir,180);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair1) extends(Wheelchair)
	var(model,"relicta_models\models\nocategory\wheelchair1.p3d");
	getter_func(getChairOffsetPos,[0 arg 0.09 arg -0.45]);
	getterconst_func(getChairOffsetDir,180);
endclass

editor_attribute("EditorGenerated")
class(OldGreenToiletBowl) extends(IChair)
	var(model,"ml\ml_object_new\model_24\tolchek.p3d");
	var(material,"MatMetal");
	var(name,"Туалет");
	var(desc,"Сюда нужно справить нужду");
	getter_func(isMovable,false);
	getter_func(getChairOffsetPos,[-0.0479994 arg -0.0999994 arg -1.1]);
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getCoefAutoWeight,20);
endclass

class(OldLightToilet) extends(OldGreenToiletBowl)
	var(model,"ca\structures\furniture\bathroom\toilet_b_02\toilet_b_02.p3d");
	var(material,"MatBeton");
	getter_func(getChairOffsetPos,[0 arg 0.05 arg -0.06]);
	getterconst_func(getChairOffsetDir,0);
endclass

editor_attribute("EditorGenerated")
class(BrownOldArmchair) extends(IChair)
	var(model,"ml\ml_object_new\model_14_10\kreslo.p3d");
	getter_func(getChairOffsetPos,[0 arg 0.3 arg -0.5]);
	getterconst_func(getCoefAutoWeight,20);
endclass


class(HeadThrone) extends(IChair)
	var(name,"Трон");
	getterconst_func(getChairOffsetPos,vec3(0,-0.15,-1.1));
	getterconst_func(getChairOffsetDir,180);
	var(model,"relicta_models\models\interier\throne.p3d");
	var(dr,3);
endclass

//kresla

class(RedLuxuryChair) extends(IChair)
	getterconst_func(getChairOffsetDir,90);
	getterconst_func(getChairOffsetPos,vec3(0.2,0,-0.7));
	var(model,"ml_shabut\kryslo\kryslo.p3d");
endclass

class(ArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.5));
	getterconst_func(restBias,vec3(0,0.68,0));
	var(model,"a3\props_f_orange\furniture\armchair_01_f.p3d");
endclass

class(ArmChairBrown) extends(IChair)
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0,-0.1,0));
	var(model,"ca\buildings\furniture\armchair.p3d");
endclass

class(LobbyChair) extends(IChair)
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0,-0.1,0));
	var(model,"ca\structures\furniture\chairs\lobby_chair\lobby_chair.p3d");
endclass

editor_attribute("Deprecated" arg "Заменить на BrownLeatherChair. Будет удален с редактором 1.20")
class(BumArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,0.2,-0.5));
	getterconst_func(restBias,vec3(0,0.8,0));
	var(model,"smg_metro_building\drugoe\smg_bomjkreslo.p3d");
	var(dr,1);
endclass
	class(BrownLeatherChair) extends(BumArmChair)
		var(model,"smg_metro_building\drugoe\smg_bomjkreslo.p3d");
	endclass

class(GreenArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,-0.25,-0.4));
	getterconst_func(getChairOffsetDir,180);
	var(model,"ml\ml_object_new\model_14_10\diwan.p3d");
endclass
	//EQUALS
	editor_attribute("Deprecated" arg "Заменить на GreenArmChair. Будет удален с редактором 1.20")
	class(GreenChair) extends(GreenArmChair)
		var(model,"ml\ml_object_new\model_14_10\diwan.p3d");
	endclass

class(Bath) extends(IChair)
	var(model,"ca\structures\furniture\bathroom\bath\bath.p3d");
	var(name,"Ванна");
	var(desc,"Такое только у настоящих богачей!")
	var(material,"MatStone");

	getterconst_func(getChairOffsetPos,vec3(0.25,0,-0.2));
	getterconst_func(getChairOffsetDir,-90);

	getter_func(getChairSitdownAnimation,[
		"Acts_SittingWounded_breath"
	]);

	var(sourceMatter,"Water");
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,IReagentNDItem) exitWith {
			if !callSelfParams(canUseWaterSink,_usr) exitWith {};
			if callFuncParams(_with,addReagent,getSelf(sourceMatter) arg getVar(_with,curTransferSize)) then {
				callFuncParams(_usr,meSay,"наполняет " + callFunc(_with,getName));
				callSelf(playSinkSound);
			};
		};
	};

	func(onClick)
	{
		objParams_1(_usr);
		if !callSelfParams(canUseWaterSink,_usr) exitWith {};
		private _pt = nullPtr;
		{
			_pt = callFuncParams(_usr,getPart,_x);
			if !isNullReference(_pt) then {
				callFuncParams(_pt,setGerms,(getVar(_pt,germs) - randInt(40,60)) max 0);
			};
		} foreach BP_INDEX_ALL;

		if !isNullReference(_pt) then {
			callFunc(_usr,syncGermsVisual);
			private _m = pick["моется","принимает ванную","очищается водой","запускает водяные брызги","плещется","плавает"];
			callFuncParams(_usr,meSay,_m);
			callSelf(playSinkSound);
		};
	};

	func(canUseWaterSink)
	{
		objParams_1(_usr);
		if (getSelf(hp)<=(getSelf(hpMax)/3)) exitWith {
			private _m = pick["слишком сильно повреждено."];
			callFuncParams(_usr,localSay,callSelf(getName) + " "+_m arg "error");
			false;
		};

		if !callFunc(_usr,isConnected) exitWith {
			private _m = pick["Нужно сначала залезть в ванну."];
			callFuncParams(_usr,localSay,_m arg "error");
			false;
		};
		true
	};

	func(playSinkSound)
	{
		objParams();
		callSelfParams(playSound,"reagents\sink.ogg" arg getRandomPitchInRange(0.9,1.3));
	};

endclass