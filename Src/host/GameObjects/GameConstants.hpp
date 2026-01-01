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

//fast declaration object class
//not implemented yet
//#define declgotype(_t,_mot,_mdl) class(_t) extends(_mot) var(model,_mdl) endclass
