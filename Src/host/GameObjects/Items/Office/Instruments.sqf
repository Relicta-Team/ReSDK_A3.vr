// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

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