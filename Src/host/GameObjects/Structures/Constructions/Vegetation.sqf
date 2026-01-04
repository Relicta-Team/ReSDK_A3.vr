// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//Растительность
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(Vegetation) extends(Constructions) 
	var(name,"Растительность"); 
	editor_only(var(desc,"Растительность");) 
	var(material,"MatOrganic");
	var(dr,1);
endclass

editor_attribute("EditorGenerated")
class(SmallMushroom) extends(Vegetation)
	var(model,"veg_gliese\br1.p3d");
	var(name,"Гриб");
endclass

editor_attribute("EditorGenerated")
class(SmallMushroom4) extends(SmallMushroom)
	var(model,"veg_gliese\hrock1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallMushroom3) extends(SmallMushroom)
	var(model,"veg_gliese\tt1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallMushroom2) extends(SmallMushroom)
	var(model,"veg_gliese\bb1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallMushroom1) extends(SmallMushroom)
	var(model,"veg_gliese\tw2.p3d");
endclass

editor_attribute("InterfaceClass")
class(IWoodenVegetation) extends(Vegetation)
	func(getOnDestroyTypesFromMaterial)
	{
		objParams();
		private _mat = callSelf(getMaterial);
		if !isNullReference(_mat) exitWith {
			if isTypeOf(_mat,MatWood) exitWith {
				["LogDebris1" arg "LogDebris2"];
			};
			super();
		};
		super();
	};
endclass

editor_attribute("EditorGenerated")
class(BigMushroom) extends(IWoodenVegetation)
	var(model,"veg_gliese\tx2.p3d");
	var(name,"Гриб");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom10) extends(BigMushroom)
	var(model,"veg_gliese\tx3.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom9) extends(BigMushroom)
	var(model,"veg_gliese\ts1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom8) extends(BigMushroom)
	var(model,"veg_gliese\tx9.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom7) extends(BigMushroom)
	var(model,"veg_gliese\t1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom6) extends(BigMushroom)
	var(model,"veg_gliese\tw1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom5) extends(BigMushroom)
	var(model,"veg_gliese\tx1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom4) extends(BigMushroom)
	var(model,"veg_gliese\t2.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom3) extends(BigMushroom)
	var(model,"veg_gliese\tx7.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom2) extends(BigMushroom)
	var(model,"veg_gliese\t3.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigMushroom1) extends(BigMushroom)
	var(model,"veg_gliese\tp1.p3d");
endclass

editor_attribute("EditorGenerated")
class(TreeRoots1) extends(TreeRoots)
	var(model,"ml\ml_object_new\shabbat\nowoederewo.p3d");
	var(name,"Корни");
endclass

editor_attribute("EditorGenerated")
class(TreeRoots) extends(IWoodenVegetation)
	var(model,"ml\ml_object_new\model_24\derevo.p3d");
	var(name,"Корни");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(TreeRoots2) extends(TreeRoots)
	var(model,"ml\ml_object_new\model_24\yolka.p3d");
	var(name,"Корни");
endclass

editor_attribute("EditorGenerated")
class(TreeRootsNoGeom) extends(TreeRoots)
	var(model,"ml\ml_object_new\shabbat\gardentree.p3d");
	var(name,"Корни");
endclass