// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//стена
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallWall) extends(Constructions) 
	var(name,"Стена"); 
	editor_only(var(desc,"Маленькие стена" pcomma " которую можно разрушить");)
	var(material,"MatBeton");
	var(dr,2);
endclass

editor_attribute("EditorGenerated")
class(SmallBlueConcreteWall) extends(SmallWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_4m_plain_blue_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallTileWall) extends(SmallWall)
	var(model,"ml_shabut\sbs\plitkastenka2.p3d");
endclass

class(SmallTileWall1) extends(SmallTileWall)
	var(model,"ml_shabut\sbs\plitkastenka.p3d");
endclass

editor_attribute("EditorGenerated")
class(WhiteBrickWall) extends(SmallWall)
	var(model,"a3\structures_f\walls\city2_4m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldBrickWallMedium) extends(SmallWall)
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_04_l_5m_old_f.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(OldBrickWallMedium1) extends(OldBrickWallMedium)
	var(model,"ca\structures\wall\wall_cbrk_5.p3d");
endclass

editor_attribute("EditorGenerated")
class(StoneWall) extends(SmallWall)
	var(model,"a3\structures_f\walls\stone_4m_f.p3d");
	var(name,"Стена");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(BigStoneWallWithPassage) extends(StoneWall)
	var(model,"ml\ml_object_new\model_24\barikada.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumLightWall) extends(SmallWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_4m_plain_grey_f.p3d");
	var(name,"Стена");
endclass

class(MediumLightWall1) extends(MediumLightWall)
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_02_l_5m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumRuinedLightFrame) extends(MediumLightWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_4m_plain_dmg_grey_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigLightWall) extends(MediumLightWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_8m_plain_grey_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallRuinedLightWall) extends(MediumLightWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(LargeConcreteWallWithReinforcement) extends(SmallWall)
	var(model,"a3\structures_f\walls\canal_wallsmall_10m_f.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(MediumRuinedWhiteConcreteWall) extends(SmallWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_8m_dmg_whiteblue_f.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(MediumWhiteConcreteWall) extends(SmallWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_8m_plain_whiteblue_f.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(SmallWhiteConcreteWall) extends(MediumWhiteConcreteWall)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_4m_plain_whiteblue_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumWoodenWall) extends(SmallWall)
	var(model,"ml_shabut\sbs\woodstenka.p3d");
	var(name,"Стена");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(PlywoodThinWall) extends(SmallWall)
	var(model,"ml_exodusnew\fanerka_vata.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(ConcreteWallWithNetfence) extends(SmallWall)
	var(model,"a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallWallNetfence) extends(ConcreteWallWithNetfence)
	var(model,"a3\structures_f_exp\walls\net\netfence_02_m_2m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(NormalClayWall) extends(SmallWall)
	var(model,"ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d");
	var(material,"MatDirt");
endclass

editor_attribute("EditorGenerated")
class(LuxuryClayWall) extends(SmallWall)
	var(model,"ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d");
	var(material,"MatDirt");
endclass

class(RuinedLuxuryClayWall) extends(LuxuryClayWall)
	var(model,"ca\structures_e\wall\wall_l\wall_l2_5m_end_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallConcreteArch) extends(SmallWall)
	var(model,"a3\structures_f\walls\cncshelter_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteWall) extends(SmallWall)
	var(model,"a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallConcreteWallRed) extends(ConcreteWall)
	var(model,"ml_shabut\sbs\stukaturkastenka.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigConcreteWall) extends(ConcreteWall)
	var(model,"ml_shabut\stena\stena.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteWallDestroyed) extends(ConcreteWall)
	var(model,"a3\structures_f_argo\walls\military\mil_wallbig_4m_damaged_left_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigConcreteWallDestroyed) extends(ConcreteWall)
	var(model,"a3\structures_f\walls\canal_wall_d_left_f.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteWall) extends(ConcreteWall)
	var(model,"a3\structures_f\walls\concrete_smallwall_4m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteWallDestroyed) extends(ConcreteWall)
	var(model,"a3\structures_f_exp\walls\concrete\concretewall_01_m_d_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ClayWallSmall) extends(SmallWall)
	var(model,"ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d");
	var(name,"Глиняная стена");
	var(material,"MatDirt");
endclass

editor_attribute("EditorGenerated")
class(ClayWallBig) extends(ClayWallSmall)
	var(model,"ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallSmall) extends(SmallWall)
	var(model,"csa_constr\csa_obj\kr_stena_m.p3d");
	var(name,"Кирпичная стена");
endclass

class(BrickWall) extends(BrickThinWallSmall)
	var(name,"Красивая кирпичная стена");
	var(desc,"Очень приятно выглядит");
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_04_l_5m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWall) extends(BrickThinWallSmall)
	var(model,"csa_constr\csa_obj\kr_stena.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallWindow) extends(BrickThinWall)
	var(model,"csa_constr\csa_obj\kr_stena_1o.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallWindow3) extends(BrickThinWallWindow)
	var(model,"csa_constr\csa_obj\kr_stena_3o.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallWindow2) extends(BrickThinWallWindow)
	var(model,"csa_constr\csa_obj\kr_stena_o.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallDoorway) extends(BrickThinWall)
	var(model,"csa_constr\csa_obj\kr_stena_1d.p3d");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallTwoDoorways) extends(BrickThinWallDoorway)
	var(model,"csa_constr\csa_obj\kr_stena_2d.p3d");
	var(name,"Стена");
endclass

editor_attribute("EditorGenerated")
class(BrickThinWallDoorwayWindow) extends(BrickThinWallDoorway)
	var(model,"csa_constr\csa_obj\kr_stena_do1.p3d");
endclass

class(BrickThinWallDoorwayBig) extends(BrickThinWallDoorway)
	var(model,"csa_constr\csa_obj\kr_stena_3d.p3d");
endclass

editor_attribute("EditorGenerated")
class(SteelThinWallSmall) extends(SmallWall)
	var(model,"ml_exodusnew\ganzazhelezo3.p3d");
	var(name,"Стальная стена");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(SteelThinWallMedium) extends(SteelThinWallSmall)
	var(model,"ml_exodusnew\ganzazhelezo2.p3d");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(SteelThinWallBig) extends(SteelThinWallSmall)
	var(model,"ml_shabut\exoduss\zhelstenabig.p3d");
endclass


class(Trench) extends(SmallWall)
	var(name,"Траншея");
	var(model,"a3\structures_f_exp\military\trenches\trench_01_forest_f.p3d");
	var(material,"MatDirt");
	
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
	var(name,"Бетонная стена");
	var(desc,"Стены никогда не видел?");
endclass