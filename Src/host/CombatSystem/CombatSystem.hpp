// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <CombatRules.hpp>

#define reqSkillAdd(name,minval) [#name,minval]
#define wmLog(text,fmt) ["<Roleplay::WeapModule>",format[text,fmt],"#0111"] call stdoutPrint;

//типы защиты уворот, парирование, блок
#define DEF_TYPE_DODGE "def_dodge"
#define DEF_TYPE_PARRY "def_parry"
//#define DEF_TYPE_BLOCK 2

//Полезности тут https://imaginaria.ru/p/boevka-gurps-dlya-novichkov.html

//Маневры для боёвки
#define COMBAT_STYLE_NO "cs_no" /*без использования стиля*/
#define COMBAT_STYLE_T_DEFENSE "cs_totaldef" /*тотальная защита: дает +2 к броску защиту ИЛИ возможность защититься 2 разными защитами*/
#define COMBAT_STYLE_RETEART "cs_reteart" /*отступление: возможность отойти на шаг назад и получить +3 к броску защиты против контактной атаки противника*/
#define COMBAT_STYLE_FINT "cs_fint" /*финт*/
#define COMBAT_STYLE_STRONG_ATTACK "cs_strong" /*сильная атака: увеличивает урон противнику +1, для оружия зависящего от силы (удар со всей силы)*/
#define COMBAT_STYLE_DOUBLE_ATTACK "cs_doubat" /*двойная атака: позволяет провести атаку основной и второй рукой. Если у вас 2 оружия, вы можете атаковать обеими руками сразу. Вторая рука получает штраф -4, но если вы Обоюдорукий, то получится 2 полноценные атаки*/
#define COMBAT_STYLE_AIMED_ATTACK "cs_aimed" /*прицельная атака: увеличивает шанс попадания на +4 для холодного оружия (+1 для оружия дальнего боя),*/
#define COMBAT_STYLE_FAST_ATTACK "cs_fast" /*Скоростной удар (с.370) — возможность провести два удара вместо одного, но пониженной точности с -6. Позволяет провести удары по разным противникам.*/
#define COMBAT_STYLE_WEAK "cs_weak" /*щадящая атака. для дружеских тумаков*/

//этот лист только для ata_buf_process
#define COMBAT_STYLE_LIST_ALL [COMBAT_STYLE_NO,COMBAT_STYLE_T_DEFENSE,COMBAT_STYLE_FINT,COMBAT_STYLE_STRONG_ATTACK,COMBAT_STYLE_DOUBLE_ATTACK,COMBAT_STYLE_AIMED_ATTACK,COMBAT_STYLE_FAST_ATTACK,COMBAT_STYLE_WEAK]

#define _____COMBAT_STYLE_AIM 8 /* СКОРЕЕ ВСЕГО ИДЁТ КАК ОТДЕЛЬНАЯ КНОПКА?! прицеливание (или оценка в ближнем бою)*/

//При добавлении новых типов атаки сделайте ассоциации в ata_buf_process
//do not change this values
#define ATTACK_TYPE_SPECIAL "at_spec" /*только для специальных атак (укус например)*/
#define ATTACK_TYPE_THRUST "at_thrust" /*Прямые точечные*/
#define ATTACK_TYPE_SWING "at_swing" /*амплитудные размашистые*/
#define ATTACK_TYPE_HANDLE "at_handle" /*рукоятка?*/
//Тут можно добавить массу типов атаки

#define ATTACK_TYPE_LIST_NODE_BINDING [ 'Прямая:'+ATTACK_TYPE_THRUST+':Прямые или точечные атаки' \
	,'Амплитудная:'+ATTACK_TYPE_SWING+':Амплитудные или размашистые атаки.' \
	,'Рукоятью:'+ATTACK_TYPE_HANDLE+':Атаки рукоятью.' \
	,'Специальная:'+ATTACK_TYPE_SPECIAL+':Специальная атака.' \
]


//Парировательная способность
#define WEAPON_PARRY_UNABLE 0 /*не парировательное */
#define WEAPON_PARRY_UNBALANCED 1 /*несбалансированное*/
#define WEAPON_PARRY_FENCING 2 /* фехтование */
#define WEAPON_PARRY_ENABLE 3 /* возможно */

/*
================================================================================
	CATEGORY: DAMAGES
================================================================================
*/


// дробящий (cr) причиняет Ущерб через тупой удар, как дубинкой или взрывчаткой.
#define DAMAGE_TYPE_CRUSHING "dt_crushing"
// режущий
#define DAMAGE_TYPE_CUTTING "dt_cutting"
//(прон) bleeding наносит колотые раны, как копье или Стрела
#define DAMAGE_TYPE_IMPALING "dt_impaling" /*колющий*/
//(pi-) малый колющий - это повреждение, которое может включать в себя быстрый, тупой снаряд, такой как пуля, или острый, но слишком маленький, чтобы квалифицироваться как пронзающий, как дротик или жало
/*
Малая пробивная атака (Пи -): низкоэнергетический снаряд или атака, оставляющая небольшой раневой канал, например бронебойная пуля.
Обычная колющая атака (Пи): большинство обычных винтовочных и пистолетных пуль.
Большая пробивающая атака (pi+): крупнокалиберные твердые пули или атака, которая оставляет большой канал, такой как пуля с полой точкой или рикошетом.
Огромная пронзительная атака (pi++):
*/
#define DAMAGE_TYPE_PIERCING_SM "dt_pi-"
#define DAMAGE_TYPE_PIERCING_NO "dt_pi"
#define DAMAGE_TYPE_PIERCING_LA "dt_pi+"
#define DAMAGE_TYPE_PIERCING_HU "dt_pi++"

//гореть
#define DAMAGE_TYPE_BURN "dt_burn"
// разъедание (cor) это атака, повреждение которой включает кислоту, распад или что-то подобное.
#define DAMAGE_TYPE_CORROSION "dt_cor"


//не записывающиеся в mob.wounds

#define DAMAGE_TYPE_TOXIC "dt_tox"

//усталость
#define DAMAGE_TYPE_FATIGUE "dt_fat"
//взд
#define DAMAGE_TYPE_AFFLICTION "dt_aff"
//по условиям оружия
#define DAMAGE_TYPE_SPEC "dt_spec"

#define DAMAGE_TYPE_LIST_NODE_BINDING [ "Дробящий:"+DAMAGE_TYPE_CRUSHING+":Ущерб через тупой удар, как дубинкой или взрывчаткой." \
	,"Режущий:"+DAMAGE_TYPE_CUTTING + ":Ущерб через острые предметы." \
	,"Проникающий:"+DAMAGE_TYPE_IMPALING + ":Колотые раны, полученные например копьем или стрелой." \
	,"Малый пробивной:"+DAMAGE_TYPE_PIERCING_SM +":Низкоэнергетический снаряд или атака, оставляющая небольшой раневой канал, например бронебойная пуля." \
	,"Обычный пробивной атака:"+DAMAGE_TYPE_PIERCING_NO +":Большинство обычных винтовочных и пистолетных пуль." \
	,"Большой пробивной:"+DAMAGE_TYPE_PIERCING_LA +":Крупнокалиберные твердые пули или атака, которая оставляет большой канал, такой как пуля с полой точкой или рикошетом." \
	,"Огромный пронзительный:"+DAMAGE_TYPE_PIERCING_HU +":" \
	,"Огненный:"+DAMAGE_TYPE_BURN \
	,"Разъедающий:"+DAMAGE_TYPE_CORROSION \
	,"Токсический:"+DAMAGE_TYPE_TOXIC \
	,"Изнуряющий:"+DAMAGE_TYPE_FATIGUE \
	,"Воздействующий:"+DAMAGE_TYPE_AFFLICTION \
	,"Специализированный:"+DAMAGE_TYPE_SPEC \
]

/*
================================================================================
	CATEGORY: WOUND TYPES
================================================================================
*/
//типы ран
//ушибы, синяки
#define WOUND_TYPE_BRUISE 0
//все резанные
#define WOUND_TYPE_BLEEDING 1
//кожа и мясо
#define WOUND_TYPE_BURN WOUND_TYPE_BRUISE
//#define WOUND_TYPE_BURN 2
//#define WOUND_TYPE_TOXIC 3

/*
================================================================================
	CATEGORY: WOUND SIZES
================================================================================
*/

#define WOUND_SIZE_SCRATCH 0
#define WOUND_SIZE_MINOR 1
#define WOUND_SIZE_MODERATE 2
#define WOUND_SIZE_MAJOR 3
#define WOUND_SIZE_CRITICAL 4
#define WOUND_SIZE_MASSIVE 5
#define WOUND_SIZE_GAWDAWFUL 6
#define WOUND_SIZE_DESTRUCTION 7

/*
================================================================================
	CATEGORY: HUMAN CONSTANTS
================================================================================
*/

//Зоны для ассоциации с частями тела моба (bodyParts)
#define BP_INDEX_HEAD 0
#define BP_INDEX_TORSO 1
#define BP_INDEX_ARM_R 2
#define BP_INDEX_ARM_L 3
//#define LIMB_INDEX_HAND_R 3
//#define LIMB_INDEX_HAND_L 4
#define BP_INDEX_LEG_R 4
#define BP_INDEX_LEG_L 5
//#define LIMB_INDEX_FOOT_R 7
//#define LIMB_INDEX_FOOT_L 8
#define BP_INDEX_ALL [BP_INDEX_HEAD,BP_INDEX_TORSO,BP_INDEX_ARM_R,BP_INDEX_ARM_L,BP_INDEX_LEG_R,BP_INDEX_LEG_L]

#define BODY_PART_LIST_NODE_BINDING [ 'Голова:BP_INDEX_HEAD' \
	,'Туловище:BP_INDEX_TORSO' \
	,'Правая рука:BP_INDEX_ARM_R' \
	,'Левая рука:BP_INDEX_ARM_L' \
	,'Правая нога:BP_INDEX_LEG_R' \
	,'Левая нога:BP_INDEX_LEG_L' \
]

//Зоны для ассоциации органов в массиве
#define BO_INDEX_HEART 0
#define BO_INDEX_LIVER 1
#define BO_INDEX_KIDNEY_R 2
#define BO_INDEX_KIDNEY_L 3
#define BO_INDEX_GUTS 4
#define BO_INDEX_STOMACH 5
#define BO_INDEX_LUNGS 6

#define BO_INDEX_TO_NAME(idx) (["Сердце","Печень","Правая почка","Левая почка","Кишки","Желудок","Легкие"] select idx)

#define BO_INDEX_ALL [BO_INDEX_HEART,BO_INDEX_LIVER,BO_INDEX_KIDNEY_R,BO_INDEX_KIDNEY_L,BO_INDEX_GUTS,BO_INDEX_STOMACH,BO_INDEX_LUNGS]

#define TARGET_ZONE_TORSO 0 /*торс*/
#define TARGET_ZONE_ABDOMEN 1 /*живот*/
#define TARGET_ZONE_HEAD 3 /*голова*/
#define TARGET_ZONE_EYE_L 4
#define TARGET_ZONE_EYE_R 5
#define TARGET_ZONE_FACE 6 /*лицо*/
#define TARGET_ZONE_NECK 7 /*шея*/
#define TARGET_ZONE_GROIN 8 /*пах*/
#define TARGET_ZONE_ARM_L 9
#define TARGET_ZONE_ARM_R 10
#define TARGET_ZONE_LEG_L 11
#define TARGET_ZONE_LEG_R 12
/*#define TARGET_ZONE_HAND_L 13
#define TARGET_ZONE_HAND_R 14
#define TARGET_ZONE_FOOT_L 15
#define TARGET_ZONE_FOOT_R 16*/
#define TARGET_ZONE_MOUTH 20
//#define TARGET_ZONE_WEAPON 17 /*обдумать*/
//#define TARGET_ZONE_LARGEAREA 18 /*не нужное*/
#define TARGET_ZONE_RANDOM 19

#define TARGET_ZONE_LIST_NODE_BINDING [ 'Торс:TARGET_ZONE_TORSO' \
	,'Живот:TARGET_ZONE_ABDOMEN' \
	,'Голова:TARGET_ZONE_HEAD' \
	,'Левый глаз:TARGET_ZONE_EYE_L' \
	,'Правый глаз:TARGET_ZONE_EYE_R' \
	,'Лицо:TARGET_ZONE_FACE' \
	,'Шея:TARGET_ZONE_NECK' \
	,'Пах:TARGET_ZONE_GROIN' \
	,'Левая рука:TARGET_ZONE_ARM_L' \
	,'Правая рука:TARGET_ZONE_ARM_R' \
	,'Левая нога:TARGET_ZONE_LEG_L' \
	,'Правая нога:TARGET_ZONE_LEG_R' \
	,'Рот:TARGET_ZONE_MOUTH' \
	,'Случайно:TARGET_ZONE_RANDOM' \
]


#define TARGET_ZONE_LIST_HEAD [TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_NECK,TARGET_ZONE_MOUTH,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L]
#define TARGET_ZONE_LIST_LIMBS [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L,TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L]
#define TARGET_ZONE_LIST_TORSO [TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO,TARGET_ZONE_GROIN]
#define TARGET_ZONE_LIST_ALL [TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO,TARGET_ZONE_GROIN,TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L,TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L,TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_NECK,TARGET_ZONE_MOUTH,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L]

//падежная форма части тела
//именительный - шея, левая рука
#define TARGET_ZONE_NAME_MAIN 0
// к чему - шее, левой руке
#define TARGET_ZONE_NAME_TO 1
//используется в атаках - атакует что? - шею, левую руку
#define TARGET_ZONE_NAME_WHAT 2

//кажется эти не нужны...
#define WEAPON_CATEGORY_MELEE 0
#define WEAPON_CATEGORY_FIREARMS 0
#define WEAPON_CATEGORY_THROWABLE 0


//макрос для генератора скриптовых оружейных узлов
#define runtimeGenerateWeapon(typename,baseclass) ([typename,baseclass,__FILE__,__LINE__]call cs_runtime_internal_generate)pushBack

#define weaponModule(t) wm_##t

//дистанты
#define REACH_DEFAULT 0.9