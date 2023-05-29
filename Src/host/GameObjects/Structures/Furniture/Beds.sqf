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
	//кровать (возможно двухместная)
endclass

class(BedOld) extends(BedBase)
	var(model,"ca\buildings\furniture\postel_panelak2.p3d");
endclass

class(HospitalBed) extends(BedBase)
	var(model,"relicta_models\models\interier\bed2.p3d");
endclass

class(LuxuryDoubleBed) extends(BedBase)
	var(model,"a3\props_f_orange\furniture\woodenbed_01_f.p3d");
endclass

class(GreenBed) extends(BedBase)
	var(model,"relicta_models\models\interier\bed5.p3d");
endclass
