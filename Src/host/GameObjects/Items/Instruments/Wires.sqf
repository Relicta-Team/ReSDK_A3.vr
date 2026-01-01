// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


class(Wire) extends(Item)
	var(name,"Провод");
	var(model,"a3\structures_f_heli\items\electronics\hdmicable_01_f.p3d");
	var(material,"MatSynt");
	var(weight,gramm(40));
	var(size,ITEM_SIZE_SMALL);
	
	var(wireColor,null);
	
	getterconst_func(wireColor,vec3(1,1,1)); //функция цвета проводов (константа)
	getterconst_func(getColor,if isNull(getSelf(wireColor)) then {callSelf(wireColor)} else {getSelf(wireColor)});
	
	var(isConnected,false); //подключен ли вставленный провод
	var(isDestroyed,false); //уничтожен ли провод
	
	func(generateRandomColor)
	{
		objParams();
		setSelf(wireColor,vec3(rand(0,1),rand(0,1),rand(0,1)));
	};
	
endclass

