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

editor_attribute("EditorGenerated")
class(SleepingMatras) extends(BedBase)
	var(model,"ml\ml_object_new\model_05\matras_2.p3d");
	getter_func(getChairOffsetPos,[[0.1 arg 0 arg 0.05]]);
	getter_func(getChairOffsetDir,90);
endclass

editor_attribute("EditorGenerated")
class(SimpleDoubleBed) extends(BedBase)
	var(model,"ca\buildings\furniture\bed_big_a.p3d");
	getter_func(getChairOffsetPos,[[0.4 arg 0.05 arg 0.5] arg [-0.3 arg 0.05 arg 0.5]]);
endclass

editor_attribute("EditorGenerated")
class(BedOld2) extends(BedBase)
	var(model,"ca\buildings\furniture\postel_panelak1.p3d");
	getter_func(getChairOffsetPos,[[0.45 arg -0.05 arg 0.3]]);
endclass

editor_attribute("EditorGenerated")
class(SurgicalBed) extends(BedBase)
	var(model,"ml_shabut\nvprops\surgtable.p3d");
	getter_func(getChairOffsetPos,[[0.2 arg -0.1 arg 0.5]]);
	getter_func(getChairOffsetDir,90);
endclass

editor_attribute("EditorGenerated")
class(HospitalBedWheels) extends(BedBase)
	var(model,"relicta_models\models\interier\bed1.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0.15 arg 0.15]]);
endclass

editor_attribute("EditorGenerated")
class(DoubleArmyBed) extends(BedBase)
	var(model,"ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d");
	getter_func(getChairOffsetPos,[[0 arg -0.1 arg 0.4] arg [0 arg -0.1 arg 1.2]]);
endclass

editor_attribute("EditorGenerated")
class(SingleWhiteBed) extends(BedBase)
	var(model,"relicta_models\models\interier\bed4.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0.240001 arg 0]]);
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