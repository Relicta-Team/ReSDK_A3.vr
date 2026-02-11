// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BenchBase) extends(IChair)
	var(name,"Скамья");
	editor_only(var(desc,"Многоместное сиденье");)
	var(material,"MatWood");
	var(dr,2);
	getterconst_func(getCoefAutoWeight,10);
	//многоместное сидение(лавка)
endclass

editor_attribute("EditorGenerated")
class(ChurchBench) extends(BenchBase)
	var(model,"ca\structures\furniture\chairs\church_chair\church_chair.p3d");
	getter_func(getChairOffsetPos,[[0.25 arg -1.2 arg -0.5] arg [0.25 arg -0.6 arg -0.5] arg [0.25 arg 0 arg -0.5] arg [0.25 arg 0.6 arg -0.5] arg [0.25 arg 1.2 arg -0.5]]);
	getter_func(getChairOffsetDir,90);
	getter_func(isMovable,true);
endclass

class(HospitalBench) extends(BenchBase)
	var(model,"ca\structures\furniture\chairs\hospital_bench\hospital_bench.p3d");
	var(material,"MatSynt");
	getter_func(getChairOffsetPos,[[0.3 arg 0 arg -0.1] arg [-0.3 arg 0 arg -0.1]]);
	getter_func(getChairOffsetDir,180);
endclass

class(WoodenBench) extends(BenchBase)
	var(model,"a3\structures_f\furniture\bench_f.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0.6 arg -0.15] arg [0 arg 0 arg -0.15] arg [0 arg -0.6 arg -0.15]]);
	getter_func(getChairOffsetDir,90);
	getter_func(isMovable,true);
endclass

class(WoodenNewBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_04_f.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0 arg -0.5] arg [0.6 arg 0 arg -0.5] arg [-0.6 arg 0 arg -0.5]]);
	getter_func(getChairOffsetDir,180);
endclass

class(WoodenOldBench) extends(BenchBase)
	var(model,"a3\structures_f_epc\civ\accessories\bench_01_f.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0 arg -0.55] arg [0.6 arg 0 arg -0.55] arg [-0.6 arg 0 arg -0.55]]);
	getter_func(getChairOffsetDir,180);
	var(dr,1);
endclass

class(WoodenSmallBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_05_f.p3d");
	getter_func(getChairOffsetPos,[[0.6 arg 0 arg -0.15] arg [0 arg 0 arg -0.15] arg [-0.6 arg 0 arg -0.15]]);
	getter_func(getChairOffsetDir,180);
	var(dr,1);
endclass

class(WoodenAncientBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_03_f.p3d");
	getter_func(getChairOffsetPos,[[0.6 arg 0 arg -0.4] arg [-0.6 arg 0 arg -0.4] arg [0 arg 0 arg -0.4]]);
	getter_func(getChairOffsetDir,180);
endclass

class(Bench1) extends(WoodenBench)
	var(model,"ca\structures_e\misc\misc_interier\bench_ep1.p3d");
	getter_func(isMovable,true);
endclass

class(Bench2) extends(BenchBase)
	var(model,"ca\buildings\misc\lavicka_3.p3d");
	getter_func(getChairOffsetPos,[[-0.65 arg 0 arg -0.4] arg [0.65 arg 0 arg -0.4] arg [0 arg 0 arg -0.4]]);
endclass

class(Bench3) extends(BenchBase)
	var(model,"ml\ml_object_new\model_14_10\skameika.p3d");
	getter_func(getChairOffsetPos,[[0 arg 0 arg -0.3] arg [0.7 arg 0 arg -0.3] arg [1.4 arg 0 arg -0.3] arg [-0.7 arg 0 arg -0.3] arg [-1.4 arg 0 arg -0.3]]);
endclass