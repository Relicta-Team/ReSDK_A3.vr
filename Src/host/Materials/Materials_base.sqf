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
	var(color,"ffffff");
	var(stepSound,["cr_step" arg 2]);

	var(damageEffect,0);
	var(damageSounds,[]);

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
	
	func(getStepSoundNetworkData)
	{
		objParams();
		getSelf(stepSound)
	};

endclass

class(MatStone) extends(MatBase)

	var(name,"Камень");
	var(color,"3D3833");
	var(stepSound,["stone" arg 6]);

	var(damageEffect,SLIGHT_DAM_STONE);
	var(damageSounds,["damage\stone_1" arg "damage\stone_2" arg "damage\stone_3"]);

endclass

class(MatBeton) extends(MatStone)

	var(name,"Бетон");
	var(damageEffect,SLIGHT_DAM_BETON);
	var(color,"8C8C8C");
	var(stepSound,["concrete" arg 5]);

endclass

class(MatDirt) extends(MatBase)
	var(name,"Земля");
	var(color,"704402");
	var(stepSound,["mud" arg 5]);
	var(damageEffect,SLIGHT_DAM_DIRT);
	var(damageSounds,["damage\cloth_1" arg "damage\cloth_2" arg "damage\cloth_3"]);
endclass

class(MatWood) extends(MatBase)

	var(name,"Дерево");
	var(color,"362D25");
	var(stepSound,["wood" arg 8]);

	var(damageEffect,SLIGHT_DAM_WOOD);
	var(damageSounds,["damage\wood_1" arg "damage\wood_2" arg "damage\wood_3"]);
endclass

class(MatMetal) extends(MatBase)

	var(name,"Металл");
	var(color,"822B14");
	var(stepSound,["baremetal" arg 4]);

	var(damageEffect,SLIGHT_DAM_METAL);
	var(damageSounds,["damage\metal_1" arg "damage\metal_2"]);

endclass


class(MatGlass) extends(MatBase)

	var(name,"Стекло");
	var(color,"147182");
	var(stepSound,["glass" arg 1]);
	var(damageEffect,SLIGHT_DAM_GLASS);
	var(damageSounds,["damage\glass_1" arg "damage\glass_2" arg "damage\glass_3"]);
endclass

class(MatCloth) extends(MatBase)

	var(name,"Ткань");
	var(color,"5CAD8A");
	var(damageEffect,SLIGHT_DAM_CLOTH);
	var(damageSounds,["damage\cloth_1" arg "damage\cloth_2" arg "damage\cloth_3"]);
	var(stepSound,["capet" arg 7]);
endclass

class(MatPaper) extends(MatBase)

	var(name,"Бумага");
	var(color,"E8E5B0");
	var(stepSound,["paper" arg 1]);
	var(damageEffect,SLIGHT_DAM_PAPER);
	var(damageSounds,["damage\paper_1" arg "damage\paper_2" arg "damage\paper_3"]);

endclass

class(MatFlesh) extends(MatBase)

	var(name,"Плоть");
	var(color,"B04A6A");
	var(stepSound,["flesh" arg 2]);
	var(damageEffect,SLIGHT_DAM_FLESH);
	var(damageSounds,["damage\flesh_1" arg "damage\flesh_2" arg "damage\flesh_3"]);

endclass

class(MatOrganic) extends(MatBase)

	var(name,"Органика");
	var(color,"85497A");
	var(stepSound,["org" arg 4]);
	var(damageEffect,SLIGHT_DAM_ORGANIC);
	var(damageSounds,["damage\organic_1" arg "damage\organic_2"]);

endclass

class(MatSynt) extends(MatBase)
	//это пластик и прочая хрень
	var(name,"Синтетика");
	var(color,"6038A6");
	var(stepSound,["cr_step" arg 2]);
	var(damageEffect,SLIGHT_DAM_SYNT);
	var(damageSounds,["damage\synt_1" arg "damage\synt_2" arg "damage\synt_3"]);

endclass


