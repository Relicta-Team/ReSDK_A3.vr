// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


class(Key) extends(Item)
	var(name,"Ключ");
	var(model,"relicta_models\models\interier\props\key.p3d");
	var(icon,invicon(key));
	var(weight,gramm(10));

	var_array(keyOwner); //что можно открыть этим ключом

	getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\keyring_up");
	getter_func(getPutdownSound,"updown\keyring_up");

endclass


class(Lockpick) extends(Item)

	var(name,"Отмычка");
	var(model,"relicta_models\models\interier\props\spichka.p3d");
	var(icon,invicon(key));
	var(weight,gramm(15));

	getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\keyring_up");
	getter_func(getPutdownSound,"updown\keyring_up");

	//Модификатор отмычки (опциональный)
	var(lockpickBonus,0);

endclass
