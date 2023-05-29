// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BedBase) extends(IChair)
	var(name,"Кровать");
	var(desc,"Место для сна");
	/*
		Не подходят:
		Acts_LyingWounded_loop
		AinjPpneMstpSnonWnonDnon
		UnconsciousReviveArms
		Hepler_InjuredNon
		UnconsciousReviveDefault_Base

		UnconsciousReviveDefault - проблема при переходе в комбат
		UnconsciousFaceUp

		--- with anims
		HubWoundedProne_idle1
		HubWoundedProne_idle2

		//normal:
		Acts_StaticDeath_10
		UnconsciousReviveMedic_Base

	*/
	getter_func(getChairSitdownAnimation,[
		"UnconsciousReviveMedic_Base"
	]);

	//кровать (возможно двухместная)

	getter_func(getMainActionName,"Лечь");
endclass

class(BedOld) extends(BedBase)
	var(model,"ca\buildings\furniture\postel_panelak2.p3d");
	getter_func(getChairOffsetPos,[[0.5 arg 0.2 arg 0.3]]);
endclass

class(HospitalBed) extends(BedBase)
	var(model,"relicta_models\models\interier\bed2.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0.2 arg -0.01]]);
endclass

class(LuxuryDoubleBed) extends(BedBase)
	var(model,"a3\props_f_orange\furniture\woodenbed_01_f.p3d");
	getter_func(getChairOffsetPos,[[0.5 arg -0.1 arg 0.07] arg [-0.4 arg -0.1 arg 0.07]]);
	getter_func(getChairOffsetDir,0);
endclass

class(GreenBed) extends(BedBase)
	var(model,"relicta_models\models\interier\bed5.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0.2 arg 0.15]]);
endclass
