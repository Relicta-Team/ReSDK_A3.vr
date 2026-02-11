// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(InteractibleInterior) extends(SmallDecorations) 
	var(name,"Штуковина"); 
	var(desc,"С этим хочется что-то сделать" pcomma " но пока не знаю что...");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,20);
	var(dr,2);
endclass


class(PipeStove) extends(InteractibleInterior)
	var(model,"ca\buildings\furniture\dkamna_bila.p3d");
endclass

class(Samovar) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_24\samovar.p3d");
	getter_func(isMovable,true);
endclass

class(HoochMachine) extends(InteractibleInterior)
	var(model,"ml_shabut\exoduss\samogonapparat.p3d");
endclass

class(Grill) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_05\grill.p3d");
endclass

class(StationTea) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_14_10\chai.p3d");
	getter_func(isMovable,true);
endclass

class(Scales) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_14_10\wesi.p3d");
	getter_func(isMovable,true);
endclass

class(OldEngine) extends(InteractibleInterior)
	var(model,"metro_ob\model\engine_sm_01.p3d");
endclass

class(ElectricPump) extends(InteractibleInterior)
	var(model,"metro_ob\model\engine_turbo_01.p3d");
endclass

class(DrumGenerator) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_24\generator.p3d");
endclass

class(SmallGreenGenerator) extends(InteractibleInterior)
	var(model,"metro_ob\model\genagenagenerator.p3d");
endclass

class(BigElectricPumpFan) extends(InteractibleInterior)
	var(model,"ml_shabut\exodus\turbonasos.p3d");
endclass

class(BigPipePump) extends(InteractibleInterior)
	var(model,"ml_shabut\exoduss\turbosos.p3d");
	getterconst_func(getName,"Водяной насос");
endclass

class(Forge) extends(InteractibleInterior)
	var(model,"ml_shabut\exoduss\forge.p3d");
endclass

class(Anvil) extends(InteractibleInterior)
	var(model,"ml\ml_object_new\model_14_10\nakowal.p3d");
	getter_func(isMovable,true);
endclass