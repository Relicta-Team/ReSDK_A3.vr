// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SofaBase) extends(IChair)
	var(name,"Диван");
	var(material,"MatCloth");
	var(dr,2);
	getter_func(isMovable,true);
	getterconst_func(getCoefAutoWeight,10);
	//диваны
endclass

editor_attribute("EditorGenerated")
class(BrownOldSofa) extends(SofaBase)
	var(model,"metro_ob\model\mebel_outdoor_couch_01a.p3d");
	getter_func(getChairOffsetPos,[[0.8 arg 0.25 arg -0.5] arg [0 arg 0.25 arg -0.5] arg [-0.8 arg 0.25 arg -0.5]]);
	var(dr,1);
endclass

class(SofaBrown) extends(SofaBase)
	var(model,"smg_metro_building\drugoe\smg_bomjdivan.p3d");
	getter_func(getChairOffsetPos,[[-0.65 arg 0.2 arg -0.5] arg [0 arg 0.2 arg -0.5] arg [0.65 arg 0.2 arg -0.5]]);
endclass

class(RedSofa) extends(SofaBase)
	var(model,"ml_shabut\sofa\sofa.p3d");
	getter_func(getChairOffsetPos,[[0.2 arg -0.65 arg -0.5] arg [0.2 arg 0 arg -0.5] arg [0.2 arg 0.65 arg -0.5]]);
	getter_func(getChairOffsetDir,90);
endclass

class(Sofa01) extends(SofaBase)
	var(model,"a3\props_f_orange\furniture\sofa_01_f.p3d");
	getter_func(getChairOffsetPos,[[-0.65 arg 0.1 arg -0.5] arg [0 arg 0.1 arg -0.5] arg [0.65 arg 0.1 arg -0.5]]);
endclass

class(CoolSofa) extends(SofaBase)
	var(model,"ml_shabut\furniture\vitoriansofa.p3d");
	getter_func(getChairOffsetPos,[[0 arg -0.1 arg -0.6] arg [-0.55 arg -0.1 arg -0.6] arg [-1.1 arg -0.1 arg -0.6] arg [0.55 arg -0.1 arg -0.6] arg [1.1 arg -0.1 arg -0.6]]);
	getter_func(getChairOffsetDir,180);
	var(dr,1);
endclass