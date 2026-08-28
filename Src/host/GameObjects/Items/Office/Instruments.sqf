// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(Holotape) extends(Item)
	var(name,"Кассета");
	var(desc,"Небольшая кассета с магнитной лентой.");
	var(model,"sterben_top\am_items\misc\electronics\holotape\am_holotape.p3d");
	var(material,"MatSynt");
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(80));
endclass

class(Calculator) extends(Item)
	var(name,"Счёты");
	var(model,"ml_exodusnew\gershtele.p3d");
	var(material,"MatWood");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(140));
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	
	//#include "..\..\Interfaces\INetDisplay.Interface"
	
	//var(ndName,"MerchantConsole");
	//var(ndInteractDistance,INTERACT_DISTANCE);
	
	
	
endclass
