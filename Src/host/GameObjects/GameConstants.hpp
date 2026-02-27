// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\CombatSystem\CombatSystem.hpp"
#include <ConstantAndDefines\item_clothing.h>
#include <ConstantAndDefines\Mobs.h>
#include <ConstantAndDefines\TimeConstants.h>
#include <ConstantAndDefines\Life.h>
#include <ConstantAndDefines\Chemistry.h>
#include <ConstantAndDefines\Cleanable.h>
#include <ConstantAndDefines\ObjectsHP.h>
#include <..\MatterSystem\MatterSystem.hpp>
#include <Items\Item_HandAnim.hpp>
#include <..\CraftSystem\Craft.hpp>
#include <..\GURPS\gurps.hpp>
#include <..\SpecialActions\SpecialActions.hpp>

#include "..\ServerVoice\ReVoicer.hpp"

//todo add QDEL file
// QDEL means query delete for antilagging objects
#define __QDEL_VARNAME 'qdel_isdeleted'
#define QDEL(object) (object) setVariable [__QDEL_VARNAME,true]
#define QDELING(object) !ISNIL{object getVariable __QDEL_VARNAME}



//unsafe prep def
#include <..\..\client\Inventory\inventory.hpp>
#include <..\..\client\LightEngine\LightEngine.hpp>
#include <..\..\client\Interactions\interact.hpp>



//размерность НЕ МЕНЯТЬ ЗНАЧЕНИЯ НУМЕРАТОРА
//размер предмета (1 крошечные предметы: спичка,пуля,колечко; 2 маленькие предметы: камень, ручка, шприц
//3 средние предметы: книга,пистолет,фляжка,одежда; 4 крупные предметы: чайник,ведерко,дубинка;
// 5 большие предметы: винтовка,канистра; 6 огромные: складной стул, гранатомёт )
#define ITEM_SIZE_TINY 1
#define ITEM_SIZE_SMALL 2
#define ITEM_SIZE_MEDIUM 3
#define ITEM_SIZE_LARGE 4
#define ITEM_SIZE_BIG 5
#define ITEM_SIZE_HUGE 6

//базовый занимаемый объём каждым типом
#define BASE_STORAGE_COST(size_type) round (2^(size_type-1))

//базовая вместимость контейнера
#define BASE_STORAGE_CAPACITY(size_type) round (7*(size_type-1))

//дефолтная вместимость одежды, маленькой сумки,рюкзака,малого бокса,большого контейнера
#define DEFAULT_CLOTH_STORAGE BASE_STORAGE_CAPACITY(1.8571429)
#define DEFAULT_ITEMBAG_STORAGE BASE_STORAGE_CAPACITY(3)
#define DEFAULT_BACKPACK_STORAGE BASE_STORAGE_CAPACITY(4)	
#define DEFAULT_BOX_STORAGE BASE_STORAGE_CAPACITY(6)
#define DEFAULT_LARGEBOX_STORAGE BASE_STORAGE_CAPACITY(7)

/*
	gconst_internal_showinfo = {
		private _a1 = format["basecost:[%1,%2,%3,%4,%5,%6]		",
			BASE_STORAGE_COST(ITEM_SIZE_TINY)
			,BASE_STORAGE_COST(ITEM_SIZE_SMALL)
			,BASE_STORAGE_COST(ITEM_SIZE_MEDIUM)
			,BASE_STORAGE_COST(ITEM_SIZE_LARGE)
			,BASE_STORAGE_COST(ITEM_SIZE_BIG)
			,BASE_STORAGE_COST(ITEM_SIZE_HUGE)];
			private _a2 = format
			["capacity:: cloth %1; itembag %2; backpack %3; struct box %4; struct largebox %5",
			DEFAULT_CLOTH_STORAGE,
			DEFAULT_ITEMBAG_STORAGE,
			DEFAULT_BACKPACK_STORAGE,
			DEFAULT_BOX_STORAGE,
			DEFAULT_LARGEBOX_STORAGE
			];
		private _m = _a1 + _a2;
		//"debug_console" callExtension _m;
		_m
	};
	gconst_internal_reload = {
		call compile preprocessFile "src\host\GameObjects\GameConstants.hpp";
	};
*/


#define DEFAULT_TICK_DELAY 1

#define invicon(icon) #icon

//трансформация граммов в киллограммы
#define gramm(amount) amount / 1000

//Перевод киллограммов в граммы
#define kgToGramm(VL) VL * 1000

//из киллограмм в фунты
#define kgToLb(val) ((val)*2)

//дюймы в метры
#define inchToMeters(val) ((val)/39.37)
//метры в футы
#define metersToFeet(val) ((val)*3.289)

#define DISTANCE_WORLDSAY 15

//Умная конвертация двухстороннего режима
#define sideToIndex(_side) (abs ceil ((_side)*.1))
#define SIDE_LEFT -1
#define SIDE_RIGHT 1
#define NODE_SIDE_LIST_ALL ['Левая сторона:SIDE_LEFT','Правая сторона:SIDE_RIGHT']

// =====================================================================
//  Константы системы прижигания (Torch → cauterizeWound)
// =====================================================================

// Референсный уровень навыка (без модификатора при этом значении)
#define CAUT_SKILL_REFERENCE           10

// Базовый шанс смерти
#define CAUT_DEATH_BASE_SELF           0.10
#define CAUT_DEATH_BASE_OTHER          0.04
// Эскалация шанса смерти за каждое предыдущее успешное прижигание
#define CAUT_DEATH_ESCALATION          0.04
// Потолок шанса смерти
#define CAUT_DEATH_CAP                 0.60
// Снижение шанса смерти за каждый пункт навыка выше референса
#define CAUT_SKILL_DEATH_REDUCTION     0.015
// Увеличение шанса смерти за каждый пункт навыка ниже референса
#define CAUT_SKILL_DEATH_INCREASE      0.02

// Модификатор шанса смерти от тяжести раны (лёгкая/обычная/тяжёлая)
#define CAUT_SEV_DEATH_MINOR           0.0
#define CAUT_SEV_DEATH_NORMAL          0.02
#define CAUT_SEV_DEATH_SEVERE          0.05

// Шанс неудачного прижигания: базовый при референсном навыке
// Лучший случай (высокий навык): ~4%, худший случай (низкий навык): ~18%
#define CAUT_FAIL_BASE                 0.10
// Снижение шанса провала за пункт навыка выше референса
#define CAUT_FAIL_SKILL_REDUCTION      0.015
// Увеличение шанса провала за пункт навыка ниже референса
#define CAUT_FAIL_SKILL_INCREASE       0.02
// Абсолютные границы
#define CAUT_FAIL_MIN                  0.04
#define CAUT_FAIL_MAX                  0.18

// Уровней боли при прижигании
#define CAUT_PAIN_LEVELS               2

// Переменная на цели — счётчик успешных прижиганий
#define CAUT_VAR_SUCCESSES             "__cautSuccesses"

// Получить уровень навыка первой помощи актора
#define CAUT_GET_HEALING_SKILL(actor)   callFunc(actor,gethealing)

//fast declaration object class
//not implemented yet
//#define declgotype(_t,_mot,_mdl) class(_t) extends(_mot) var(model,_mdl) endclass
