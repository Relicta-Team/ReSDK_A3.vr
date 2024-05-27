#include "Materials.h"

class(MatBase) attribute(staticInit)
	
	func(staticInit)
	{
		params ["_thisClass","_thisType"];
		{
			private _class = _x;
			
			private _obj = instantiate(_class);
			private _objClass = callFunc(_obj,getClassName);

			mat_map_all set [tolower _objClass,_obj];
		} foreach getAllObjectsTypeOfStr(_thisClass);
	};
	
	var(name,"Материал");

	var(damageEffect,0);
	var(damageSounds,[]);
	var(damageSoundsBlocked,[]);

	getter_func(getDamageEffect,getSelf(damageEffect));
	func(getDamageSound)
	{
		objParams();
		private _list = getSelf(damageSounds);
		if not_equalTypes(_list,[]) exitWith {
			if not_equalTypes(_list,"") exitWith {""};
			_list;
		};
		if (count _list == 0) exitWith {""};
		pick _list
	};
	func(getDamageSoundBlocked)
	{
		objParams();
		private _list = getSelf(damageSoundsBlocked);
		if not_equalTypes(_list,[]) exitWith {
			if not_equalTypes(_list,"") exitWith {""};
			_list;
		};
		if (count _list == 0) exitWith {""};
		pick _list
	};
endclass

class(MatStone) extends(MatBase)

	var(name,"Камень");

	var(damageEffect,SLIGHT_DAM_STONE);
	var(damageSounds,["damage\stone_1" arg "damage\stone_2" arg "damage\stone_3"]);

endclass

class(MatBeton) extends(MatStone)

	var(name,"Бетон");

endclass

class(MatDirt) extends(MatBase)
	var(name,"Земля");
endclass

class(MatWood) extends(MatBase)

	var(name,"Дерево");

	var(damageEffect,SLIGHT_DAM_WOOD);
	var(damageSounds,["damage\wood_1" arg "damage\wood_2" arg "damage\wood_3"]);
endclass

class(MatMetal) extends(MatBase)

	var(name,"Металл");

	var(damageEffect,SLIGHT_DAM_METAL);
	var(damageSounds,["damage\metal_1" arg "damage\metal_2"]);

endclass


class(MatGlass) extends(MatBase)

	var(name,"Стекло");

endclass

class(MatCloth) extends(MatBase)

	var(name,"Ткань");

endclass

class(MatPaper) extends(MatBase)

	var(name,"Бумага");

endclass

class(MatFlesh) extends(MatBase)

	var(name,"Плоть");

endclass

class(MatOrganic) extends(MatBase)

	var(name,"Органика");

endclass

class(MatSynt) extends(MatBase)
	//это пластик и прочая хрень
	var(name,"Синтетика");

endclass


