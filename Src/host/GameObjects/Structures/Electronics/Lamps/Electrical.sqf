// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>

class(StreetLamp) extends(ElectronicDeviceLighting)
	var(name,"Фонарный столб");
	var(light,"SLIGHT_LEGACY_STREETLAMP" call lightSys_getConfigIdByName);
	var(lightIsEnabled,false);
	//var(model,"a3\structures_f_enoch\infrastructure\lamps\lampindustrial_01_f.p3d"); //"Land_LampIndustrial_01_F"
	var(model,"a3\structures_f\civ\lamps\lampshabby_off_f.p3d"); //"Land_LampShabby_F"
	var(material,"MatWood");
	getterconst_func(getCoefAutoWeight,1.5);
	var(dr,2);
	var(edReqPower,12); //сколько требует электричества в 1 сек
	//getter_func(isEnabled,getSelf(lightIsEnabled));
	//var(edIsEnabled,false);
	var(edIsEnabled,true);
	var(edReqPower,200);
	
	func(onChangeEnable) {
		objParams();

		if (getSelf(edIsUsePower)) then {
			callSelfParams(lightSetMode,getSelf(edIsEnabled));
		};

	};

	func(onChangeUsePower) {
		objParams();
		private _lightEnabled = getSelf(lightIsEnabled);
		if (!getSelf(edIsUsePower) || !getSelf(edIsEnabled)) exitWith {
			if (_lightEnabled) then {
				callSelfParams(lightSetMode,false);
				//error("1");
			};
			//error("end 1");
		};
		if (getSelf(edIsUsePower) && getSelf(edIsEnabled)) exitWith {
			if (!_lightEnabled) then {
				callSelfParams(lightSetMode,true);
				//error("2");
			};
			//error("end 2");
		};
		//error("NOT");
	};

endclass

class(StreetLampEnabled) extends(StreetLamp)
	var(edIsEnabled,true);
	//var(lightIsEnabled,true);
	/*func(constructor)
	{
		callSelf(setEnable,true);
	};*/
endclass


class(LampCeiling) extends(StreetLampEnabled)
	var(name,"Лампа");
	var(edReqPower,50);
	var(light,"SLIGHT_LEGACY_LAMP_CEILING" call lightSys_getConfigIdByName);
	var(model,"atmobjects\lamps\data\model\lamp_tarelka.p3d")
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,80);
	var(dr,1);
endclass

editor_attribute("EditorGenerated")
class(Chandelier) extends(LampCeiling)
	var(model,"ml\ml_object_new\shabbat\lustra.p3d");
	getterconst_func(getCoefAutoWeight,200);
endclass

//для бара свет
class(LampCeiling_Red) extends(LampCeiling)
	var(light,"SLIGHT_LEGACY_LAMP_CEILING_REDLIGHT" call lightSys_getConfigIdByName);
endclass

class(LampWall) extends(StreetLampEnabled)
	var(name,"Лампа");
	var(material,"MatGlass");
	getterconst_func(getCoefAutoWeight,80);
	var(dr,1);
	var(edReqPower,50);
	var(light,"SLIGHT_LEGACY_LAMP_WALL" call lightSys_getConfigIdByName);
	var(model,"atmobjects\lamps\data\model\lamp_stena.p3d");
endclass