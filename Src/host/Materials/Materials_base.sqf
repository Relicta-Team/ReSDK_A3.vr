// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Materials.h"
#include "..\Networking\Network.hpp"

class(MatBase) attribute(staticInit)
	
	func(staticInit)
	{
		params ["_thisClass","_thisType"];
		if (_thisClass!="MatBase") exitWith {};

		private _mdata = createHashMap;
		{
			private _class = _x;
			
			private _obj = instantiate(_class);
			private _objClass = callFunc(_obj,getClassName);

			mat_map_all set [tolower _objClass,_obj];

			callFuncParams(_obj,applyStepDataForGlobalVar,_mdata);
		} foreach getAllObjectsTypeOfStr(_thisClass);

		netSetGlobal(materials_map_stepData,_mdata);
	};
	
	var(name,"Материал");
	var(color,"ffffff");
	var(stepSound,["cr_step" arg 2]);

	var(damageEffect,0);
	var(damageSounds,[]);

	var(resistSounds,[]);

	func(applyStepDataForGlobalVar)
	{
		objParams_1(_hm);

		if (callSelf(getStepDataKey) in _hm) exitWith {
			setLastError("Duplicated step config for " + callSelf(getClassName));
		};

		_hm set [callSelf(getStepDataKey),
			[
				getSelf(stepSound)
			]
		]
	};

	getter_func(getStepDataKey,getSelf(damageEffect));
	

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

	func(getResistSound)
	{
		objParams();
		private _list = getSelf(resistSounds);
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

	//коэффициент для вычисления хп с помощью веса объекта
	getterconst_func(getWeightCoefForCalcHP,1);

	getter_func(getDamageCoefOnAttack,1);

endclass

class(MatStone) extends(MatBase)

	var(name,"Камень");
	var(color,"3D3833");
	var(stepSound,["stone" arg 6]);

	var(damageEffect,SLIGHT_DAM_STONE);
	var(damageSounds,["damage\stone_1" arg "damage\stone_2" arg "damage\stone_3"]);
	var(resistSounds,["damage\block_stone_1" arg "damage\block_stone_2"]);
	

	getterconst_func(getWeightCoefForCalcHP,150);

	getter_func(getDamageCoefOnAttack,0.2);

endclass

class(MatBeton) extends(MatStone)

	var(name,"Бетон");
	var(damageEffect,SLIGHT_DAM_BETON);
	var(color,"8C8C8C");
	var(stepSound,["concrete" arg 5]);

	var(resistSounds,["damage\block_beton_1" arg "damage\block_beton_2" arg "damage\block_beton_3"]);
	getterconst_func(getWeightCoefForCalcHP,120);

	getter_func(getDamageCoefOnAttack,0.3);

endclass

class(MatDirt) extends(MatBase)
	var(name,"Земля");
	var(color,"704402");
	var(stepSound,["mud" arg 5]);
	var(damageEffect,SLIGHT_DAM_DIRT);
	var(damageSounds,["damage\cloth_1" arg "damage\cloth_2" arg "damage\cloth_3"]);
	getterconst_func(getWeightCoefForCalcHP,50);

	getter_func(getDamageCoefOnAttack,0.6);
endclass

class(MatWood) extends(MatBase)

	var(name,"Дерево");
	var(color,"362D25");
	var(stepSound,["wood" arg 8]);

	var(damageEffect,SLIGHT_DAM_WOOD);
	var(damageSounds,["damage\wood_1" arg "damage\wood_2" arg "damage\wood_3"]);
	var(resistSounds,["damage\block_wood_1" arg "damage\block_wood_2" arg "damage\block_wood_3"]);
	getterconst_func(getWeightCoefForCalcHP,50);

	getter_func(getDamageCoefOnAttack,1.3);
endclass

class(MatMetal) extends(MatBase)

	var(name,"Металл");
	var(color,"822B14");
	var(stepSound,["baremetal" arg 4]);

	var(damageEffect,SLIGHT_DAM_METAL);
	var(damageSounds,["damage\metal_1" arg "damage\metal_2"]);
	var(resistSounds,["damage\block_metal_1" arg "damage\block_metal_2"]);
	getterconst_func(getWeightCoefForCalcHP,100);

	getter_func(getDamageCoefOnAttack,0.7);
endclass


class(MatGlass) extends(MatBase)

	var(name,"Стекло");
	var(color,"147182");
	var(stepSound,["glass" arg 1]);
	var(damageEffect,SLIGHT_DAM_GLASS);
	var(damageSounds,["damage\glass_1" arg "damage\glass_2" arg "damage\glass_3"]);
	var(resistSounds,["steps\glass1"]);
	getterconst_func(getWeightCoefForCalcHP,200);

	getter_func(getDamageCoefOnAttack,3.2);
endclass

class(MatCloth) extends(MatBase)

	var(name,"Ткань");
	var(color,"5CAD8A");
	var(damageEffect,SLIGHT_DAM_CLOTH);
	var(damageSounds,["damage\cloth_1" arg "damage\cloth_2" arg "damage\cloth_3"]);
	var(stepSound,["capet" arg 7]);
	getterconst_func(getWeightCoefForCalcHP,20);

	getter_func(getDamageCoefOnAttack,1.5);
endclass

class(MatPaper) extends(MatBase)

	var(name,"Бумага");
	var(color,"E8E5B0");
	var(stepSound,["paper" arg 1]);
	var(damageEffect,SLIGHT_DAM_PAPER);
	var(damageSounds,["damage\paper_1" arg "damage\paper_2" arg "damage\paper_3"]);
	getterconst_func(getWeightCoefForCalcHP,10);


	getter_func(getDamageCoefOnAttack,4);
endclass

class(MatFlesh) extends(MatBase)

	var(name,"Плоть");
	var(color,"B04A6A");
	var(stepSound,["flesh" arg 2]);
	var(damageEffect,SLIGHT_DAM_FLESH);
	var(damageSounds,["damage\flesh_1" arg "damage\flesh_2" arg "damage\flesh_3"]);
	getterconst_func(getWeightCoefForCalcHP,30);

	getter_func(getDamageCoefOnAttack,1.5);
endclass

class(MatOrganic) extends(MatBase)

	var(name,"Органика");
	var(color,"85497A");
	var(stepSound,["org" arg 4]);
	var(damageEffect,SLIGHT_DAM_ORGANIC);
	var(damageSounds,["damage\organic_1" arg "damage\organic_2"]);
	getterconst_func(getWeightCoefForCalcHP,25);

	getter_func(getDamageCoefOnAttack,2);

endclass

class(MatSynt) extends(MatBase)
	//это пластик и прочая хрень
	var(name,"Синтетика");
	var(color,"6038A6");
	var(stepSound,["cr_step" arg 2]);
	var(damageEffect,SLIGHT_DAM_SYNT);
	var(damageSounds,["damage\synt_1" arg "damage\synt_2" arg "damage\synt_3"]);
	getterconst_func(getWeightCoefForCalcHP,50);

	getter_func(getDamageCoefOnAttack,1.2);
endclass


