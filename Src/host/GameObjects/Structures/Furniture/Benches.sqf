// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BenchBase) extends(IChair)
	var(name,"Скамья");
	var(desc,"Многоместное сиденье");
	//многоместное сидение(лавка)
endclass

class(HospitalBench) extends(BenchBase)
	var(model,"ca\structures\furniture\chairs\hospital_bench\hospital_bench.p3d");
endclass

class(WoodenBench) extends(BenchBase)
	var(model,"a3\structures_f\furniture\bench_f.p3d");
endclass

class(WoodenNewBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_04_f.p3d");
endclass

class(WoodenOldBench) extends(BenchBase)
	var(model,"a3\structures_f_epc\civ\accessories\bench_01_f.p3d");
endclass

class(WoodenSmallBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_05_f.p3d");
endclass

class(WoodenAncientBench) extends(BenchBase)
	var(model,"a3\structures_f_exp\civilian\accessories\bench_03_f.p3d");
endclass

class(Bench1) extends(BenchBase)
	var(model,"ca\structures_e\misc\misc_interier\bench_ep1.p3d");
endclass

class(Bench2) extends(BenchBase)
	var(model,"ca\buildings\misc\lavicka_3.p3d");
endclass

class(Bench3) extends(BenchBase)
	var(model,"ml\ml_object_new\model_14_10\skameika.p3d");
endclass