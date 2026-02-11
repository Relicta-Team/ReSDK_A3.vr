// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(CuttingBoard) extends(Item)
	var(name,"Доска");
	var(desc,"Доска для резки всякого съедобного...");
	var(model,"ml_exodusnew\doskarez.p3d");
	var(material,"MatWood");
	var(weight,gramm(150));
	var(size,ITEM_SIZE_SMALL);
	var(dr,2);
endclass
/*
	Новые правила готовки:
	
*/
class(FryingPan) extends(Item)
	var(name,"Сковородка");
	var(desc,"Ей можно выпрямить кому-нибудь лицо... ну или зажарить мельтешонка.");
	var(weight,1.45);
	var(size,ITEM_SIZE_MEDIUM);
	var(model,"ml_exodusnew\skovoroda.p3d");//"relicta_models\models\interier\props\kitchen\pan.p3d"
	var(material,"MatMetal");
	getter_func(getDropSound,"dropping\potspans_" + (str randInt(1,4)));
	var(dr,2);

	var(craftComponentName,"FryingPanSystem");
	
endclass

class(Polovnik) extends(Item)
	var(name,"Половник");
	var(model,"relicta_models\models\interier\props\kitchen\ladle.p3d");
	var(material,"MatMetal");
	getter_func(getDropSound,"dropping\potspans_" + (str randInt(1,4)));
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(140));
	var(dr,2);
	
	#include "..\..\Interfaces\INetDisplay.Interface"

	var(ndName,"MessageBox");
	var(ndInteractDistance,INTERACT_DISTANCE);
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
	};
	
	func(getNDInfo)
	{
		objParams();
		[]
	};
	
	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
	};
	
endclass