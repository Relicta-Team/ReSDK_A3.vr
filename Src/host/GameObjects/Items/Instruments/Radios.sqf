// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


class(RadioBaikal) extends(ItemRadio)
	getterconst_func(name,"Рация");
	var(model,"ml_exodusnew\ratziya.p3d");
	var(material,"MatSynt");
	var(dr,2);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(830));
endclass