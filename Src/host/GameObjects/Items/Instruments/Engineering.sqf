// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

class(EngineeringToolItem) extends(Item)
	var(icon,invicon(tool_base));
	var(material,"MatSynt");
	var(dr,2);
	var(weight,gramm(150));
endclass

class(Sledgehammer) extends(EngineeringToolItem)
	var(name,"Кувалда");
	var(desc,"Ломает стены, простройки, и в крайнем случае - черепа.");
	var(model,"relicta_models2\tools\s_sledgehammer\s_sledgehammer.p3d");
	var(material,"MatMetal");
	var(weight,gramm(6500));
	var(size,ITEM_SIZE_BIG);
	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
endclass

class(Sledgehammer1) extends(Sledgehammer)
	var(name,"Кувалдушка");
	var(desc,"То же что и кувалда, только поменьше");
	var(model,"relicta_models2\tools\s_sledgehammer1\s_sledgehammer1.p3d");
	var(material,"MatMetal");
	var(weight,gramm(4500));
	var(size,ITEM_SIZE_LARGE);
	var(allowedSlots,[INV_BELT]);
endclass

class(Pickaxe) extends(EngineeringToolItem)
	var(name,"Колотилка");
	var(desc,"Хороший прибор для разламывания камней");
	var(model,"relicta_models2\tools\s_pickaxe\s_pickaxe.p3d");
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(weight,gramm(4000));
	var(size,ITEM_SIZE_BIG);
	var(allowedSlots,[INV_BELT arg INV_BACK arg INV_BACKPACK]);
endclass

class(FireExtinguisher) extends(EngineeringToolItem)
	var(name,"Тушилка");
	var(desc,"Он же ""Тухляк""");
	var(model,"relicta_models2\tools\s_fire_extinguisher\s_fire_extinguisher.p3d");
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(weight,gramm(10000));
	var(size,ITEM_SIZE_BIG);
endclass

class(Screwdriver) extends(EngineeringToolItem)
	var(name,"Отвёртка");
	var(model,"a3\structures_f\items\tools\screwdriver_v1_f.p3d");
	var(weight,gramm(58));
	var(size,ITEM_SIZE_SMALL);
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
endclass

class(WireCutters) extends(EngineeringToolItem)
	var(name,"Кусачки");
	var(desc,"А похожи на плоскогубцы..");
	var(model,"a3\structures_f\items\tools\pliers_f.p3d");
	var(weight,gramm(60));
	var(size,ITEM_SIZE_SMALL);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);

endclass

class(Gloves) extends(EngineeringToolItem)
	var(name,"Перчатки");
	var(weight,gramm(15));
	var(model,"a3\structures_f\items\tools\gloves_f.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(material,"MatCloth");
	var(dr,1);
endclass

class(Multimeter) extends(EngineeringToolItem)
	var(name,"Мультиметр");
	var(desc,"Электроизмерительный прибор");
	var(model,"a3\structures_f\items\tools\multimeter_f.p3d");
	var(weight,gramm(80));
	var(size,ITEM_SIZE_SMALL);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
endclass

class(Wrench) extends(EngineeringToolItem)
	var(name,"Гаечный ключ");
	var(model,"a3\structures_f\items\tools\wrench_f.p3d");
	var(material,"MatMetal");
	var(weight,gramm(62));
	var(size,ITEM_SIZE_TINY);
endclass

class(Hammer) extends(EngineeringToolItem)
	var(name,"Мотолок");
	var(model,"a3\structures_f\items\tools\hammer_f.p3d");
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(weight,gramm(800));
	var(size,ITEM_SIZE_SMALL);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
endclass

class(Crowbar) extends(EngineeringToolItem)
	var(name,"Лом");
	var(desc,"Против лома нет приёма!");
	var(model,"a3\props_f_orange\items\tools\crowbar_01_f.p3d");
	var(material,"MatMetal");
	var(attachedWeap,weaponModule(WeapCrowbar));
	var(weight,5.2);
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);

	var(leftBreaked,randInt(2,4));

endclass

class(Shovel) extends(EngineeringToolItem)
	var(name,"Лопата");
	var(attachedWeap,weaponModule(WeapShovel));
	var(model,"a3\structures_f_epa\items\tools\shovel_f.p3d");
	var(weight,1.3);
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);

	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	
	getter_func(getDropSound,vec2("UNCATEGORIZED\shovel_drop",getRandomPitchInRange(.85,1.3)));

	getter_func(playDigSound,callSelfParams(playSound,"UNCATEGORIZED\dig_shovel" arg getRandomPitchInRange(0.8,1.3)));
	getter_func(playEmptySound,callSelfParams(playSound,"UNCATEGORIZED\empty_shovel" arg getRandomPitchInRange(0.8,1.3)));

	var(content,nullPtr);

	func(canMoveOutItem)
	{
		objParams_1(_item);
		private _cnt = getSelf(content);
		equals(_cnt,_item);
	};

	func(onMoveOutItem)
	{
		objParams_1(_item);
		setSelf(content,nullPtr);
	};
	getter_func(getMainActionName,"Проверить лопату");
	func(onMainAction)
	{
		objParams_1(_usr);
		if !isNullObject(getSelf(content)) then {
			callFuncParams(getSelf(content),moveItem,_usr);
		};
	};

endclass

class(ToolPipe) extends(EngineeringToolItem)
	var(name,"Труба");
	var(model,"relicta_models\models\weapons\melee\tire\tire.p3d");
	var(weight,3.4);
	var(material,"MatMetal");
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
endclass

class(ToolStraigthPipe) extends(ToolPipe)
	var(name,"Труба");
	var(model,"ml\ml_object_new\model_24\tryba_3.p3d");
	var(weight,3.7);
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);
endclass

//Перенести в другую категорию!
class(Shield) extends(Item)
	var(name,"Металлический щит.");
	var(desc,"Лучше с ним, чем без него.");
	var(model,"relicta_models\models\cloth\shieldcircle\shieldcircle.p3d");
	var(weight,3.7);
	var(material,"MatMetal");
	var(size,ITEM_SIZE_MEDIUM);
endclass
