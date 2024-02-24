// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//тип ручной анимации
#define ANIM_INDEX_HANDED 0
#define ANIM_INDEX_COMBAT 1
//todo отрицательные значения для двуручного, где -1 мирный хват, -2 комбат

//список индексов которые подмешивают только ладошку
#define ITEM_HANDANIM_NOFULLBLEND_LIST [ITEM_HANDANIM_LOWERONLYHAND]
//тоже самое для двуручки
#define ITEM_2HANDANIM_NOFULLBLEND_LIST []

#define ITEM_HANDANIM_LIST_ALLANIMS ["lwr","lwr","fl","tch","lmp"]

#define ITEM_HANDANIM_ENUM_TO_ANIM(idx) (ITEM_HANDANIM_LIST_ALLANIMS select (idx))

#define ITEM_HANDANIM_LOWER 0
#define ITEM_HANDANIM_LOWERONLYHAND 1
#define ITEM_HANDANIM_FLASHLIGHT 2
#define ITEM_HANDANIM_TORCH 3
#define ITEM_HANDANIM_LAMP 4

//twohanded non combat.
#define ITEM_TWOHANDANIM_LIST_ALLANIMS ["lwr","swd","pst","rfl","pswda","pswdb","capb"]

#define ITEM_2HANIM_LOWER 0
#define ITEM_2HANIM_SWORD 1
#define ITEM_2HANIM_PISTOL 2
#define ITEM_2HANIM_RIFLE 3
#define ITEM_2HANIM_PARRY_SWORD_1 4
#define ITEM_2HANIM_PARRY_SWORD_2 5
#define ITEM_2HANIM_CAPTIVEBACK 6

// combat category

//Лист для хватов комбата
#define ITEM_COMBATANIM_LIST_ALLANIMS ["hnd","sht","avt","avt"]
//лист для хватов атаки
#define ITEM_ATTACKANIM_LIST_ALLANIMS ["hnd","sht","gun","sht"]

//Получает стейт другой руки при атаке огнестрелом или холодным оружием
#define ITEM_GET_OTHERHAND_ANIM(tex,ret,istwohands) (if (tex == "gun") then {ret} else {if(istwohands)exitWith{tex};"bck"})

#define ITEM_COMBATANIM_ENUM_TO_ANIM(idx) (ITEM_COMBATANIM_LIST_ALLANIMS select (idx))
#define ITEM_ATTACKANIM_ENUM_TO_ANIM(idx) (ITEM_ATTACKANIM_LIST_ALLANIMS select (idx))

//используются данные: ITEM_COMBATANIM_LIST_ALLANIMS для комбат простоя, ITEM_ATTACKANIM_LIST_ALLANIMS для комбат атак
#define ITEM_COMBATANIM_HAND 0
#define ITEM_COMBATANIM_SHORT 1
#define ITEM_COMBATANIM_GUN 2
//анимация держания оружия но удар рукояткой
#define ITEM_COMBATANIM_GUN_HANDLE 3

//лист для двуручных хватов комбата
#define ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS ["lwr","swd","pst","rfl"]
//Лист для двуручных хватов атаки
#define ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS ["lwr","swd","pst","rfl"]

#define ITEM_2HANIM_COMBAT_LOWER 0
#define ITEM_2HANIM_COMBAT_SWORD 1
#define ITEM_2HANIM_COMBAT_PISTOL 2
#define ITEM_2HANIM_COMBAT_RIFLE 3

//Всё для парирования
#define __item_parry_list_anims__ ["parh1","parh2","pars1","pars2"]
#define ITEM_PARRY_ENUM_TO_ANIM(idx) (__item_parry_list_anims__ select idx)

#define ITEM_PARRY_HAND_1 0
#define ITEM_PARRY_HAND_2 1
#define ITEM_PARRY_SWORD_1 2
#define ITEM_PARRY_SWORD_2 3
