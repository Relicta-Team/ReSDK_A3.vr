// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
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

	editor_attribute("alias" arg "Типы ключа")
	editor_attribute("Tooltip" arg "Тип или типы ключей, которые подходят к совместимым дверям (с учетом регистра).\n\nЗдесь можно перечислить типы с разделитерями: \n точка с запятой (;)\n запятой (" pcomma ")\n прямой чертой (|)\n пробелом ( )\n\nПример: ""key1;key2;key3""")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:512")
	var(preinit@__keyTypesStr,""); //системная переменная для установки ключей через редактор

	func(__handlePreInitVars__)
	{
		objParams();
		super();
		private _ktypes = getSelf(preinit@__keyTypesStr);
		if (count _ktypes > 0) then {
			private _listKeys = _ktypes splitString ";| ,";
			_listKeys append getSelf(keyOwner); //append types setted from code
			setSelf(keyOwner,_listKeys);
		};
		setSelf(preinit@__keyTypesStr,null);
	};

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
