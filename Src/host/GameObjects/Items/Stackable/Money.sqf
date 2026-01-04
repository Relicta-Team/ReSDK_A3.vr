// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"

editor_attribute("InterfaceClass")
class(Money) extends(Stack)
	var(stackMaxAmount,10);
	var(name,"Деньги");
	var(material,"MatMetal");
endclass

class(Zvak) extends(Money)
	var(name,"Звяк");
	var(stackName,"Звяки");
	getterconst_func(stackNames,vec3("Звяк","Звяка","Звяков"));
	var(stackCount,1);
	var(stackMaxAmount,10);
	var(desc,"Основная валюта в Сети.");
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(5.75));
	var(icon,invicon(zvyak));
	var(model,"relicta_models\models\nocategory\zvak.p3d");
	getterconst_func(getMultiModel,"relicta_models\models\nocategory\zvaki.p3d");
	//var(weight,gramm(1000));
	
	getter_func(getDropSound,"dropping\drop_small");
	getter_func(canDisentegrate,true);

endclass

class(Bryak) extends(Zvak)
	var(icon,invicon(bryak));
	var(name,"Бряк");
	var(stackName,"Бряки");
	getterconst_func(stackNames,vec3("Бряк","Бряка","Бряков"));
	var(desc,"Основная валюта в Сети. Имеет более высокую ценность чем звяки");
endclass

class(Tooth) extends(Stack)
	var(name,"Зуб");
	var(stackName,"Зубы");
	//var(model,"relicta_models\models\medical\tablet2.p3d");
	var(model,"relicta_models2\misc\s_tooth\s_tooth.p3d");
	var(material,"MatOrganic");
	getterconst_func(stackNames,vec3("Зуб","Зуба","Зубов"));
	var(stackMaxAmount,10);
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(3));

	getter_func(canDisentegrate,true);
endclass

//Перенести в другую категорию!
class(Necklace) extends(Item)
	var(name,"Роскошное ожерелье");
	var(desc,"Отличная безделушка для поднятия настроения!");
	var(model,"relicta_models\models\interier\props\treasure\necklace\necklace.p3d");
	var(weight,gramm(50));
	var(material,"MatMetal");
	var(size,ITEM_SIZE_SMALL);
endclass