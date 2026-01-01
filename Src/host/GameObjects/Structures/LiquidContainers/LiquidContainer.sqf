// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//Контейнеры для жидкостей
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(LiquidContainer) extends(IStruct) var(name,"Ёмкость"); var(desc,"Сюда можно что-то налить"); endclass

//Железные бочки
class(MetalBarrel) extends(LiquidContainer)
	var(name,"Ржавая бочка");
	var(desc,"Сюда можно что-то налить, да и начерпать отсюда тоже!")
	var(model,"ml\ml_object_new\model_14_10\oldbarrel.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,15);
	var(dr,2);
endclass

class(MetalBarrel1) extends(MetalBarrel)
	var(name,"Бидон");
	var(model,"ml\ml_object_new\model_14_10\galon.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass

class(MetalBarrel3) extends(MetalBarrel)
	var(name,"Бочка");
	var(model,"ml\ml_object_new\model_14_10\bochka.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass

class(MetalBarrel4) extends(MetalBarrel)
	var(name,"Бочка");
	var(model,"ca\misc\barel3.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass

class(MetalBarrel5) extends(MetalBarrel)
	var(name,"Бочка");
	var(model,"ca\misc\barel4.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass

class(MetalBarrel6) extends(MetalBarrel)
	var(name,"Бочка");
	var(model,"relicta_models\models\interier\barrel.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass

class(MetalBarrel7) extends(MetalBarrel)
	var(name,"Бочка");
	var(model,"ca\misc\barel8.p3d");
	var(material,"MatMetal");
	var(dr,2);
endclass


//Пластик
class(PlasticBarrel) extends(LiquidContainer)
	var(name,"Бочка");
	var(model,"a3\structures_f_epb\items\vessels\barrelwater_grey_f.p3d");
	var(material,"MatSynt");
	getterconst_func(getCoefAutoWeight,10);
endclass

class(PlasticBarrel1) extends(PlasticBarrel)
	var(name,"Бочка");
	var(model,"a3\structures_f\items\vessels\barrelwater_f.p3d");
	var(material,"MatSynt");
endclass

class(PlasticBarrel2) extends(PlasticBarrel)
	var(name,"Канистра");
	var(model,"ml\ml_object_new\model_14_10\whitebottle.p3d");
	var(material,"MatSynt");
endclass

class(PlasticBarrel3) extends(PlasticBarrel)
	var(name,"Канистра");
	var(model,"a3\structures_f\items\vessels\canisterplastic_f.p3d");
	var(material,"MatSynt");
endclass


//Глина керамика
class(ClayPot) extends(LiquidContainer)
	var(name,"Горшок");
	var(desc,"Сюда можно что-то налить, да и начерпать отсюда тоже!")
	var(model,"ca\structures_e\misc\misc_interier\vase_loam_ep1.p3d");
	var(material,"MatGlass");
	getterconst_func(getCoefAutoWeight,50);
	var(hp,5);
endclass

class(ClayPot1) extends(ClayPot)
	var(model,"ca\structures_e\misc\misc_interier\vase_loam_2_ep1.p3d");
	var(material,"MatGlass");
	var(hp,5);
endclass

class(ClayPot2) extends(ClayPot)
	var(model,"ca\structures_e\misc\misc_interier\vase_loam_3_ep1.p3d");
	var(material,"MatGlass");
	var(hp,5);
endclass