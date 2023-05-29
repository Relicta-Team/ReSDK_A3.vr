// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SofaBase) extends(IChair)
	var(name,"Диван");
	//диваны
endclass

class(SofaBrown) extends(SofaBase)
	var(model,"smg_metro_building\drugoe\smg_bomjdivan.p3d");
endclass

class(RedSofa) extends(SofaBase)
	var(model,"ml_shabut\sofa\sofa.p3d");
endclass

class(Sofa01) extends(SofaBase)
	var(model,"a3\props_f_orange\furniture\sofa_01_f.p3d");
endclass

class(CoolSofa) extends(SofaBase)
	var(model,"ml_shabut\furniture\vitoriansofa.p3d");
endclass
