// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\bitflags.hpp>

#define DIR_FRONT 0
#define DIR_LEFT 1
#define DIR_RIGHT 2
#define DIR_BACK 3
#define DIR_RANDOM (selectRandom[DIR_FRONT,DIR_BACK,DIR_RIGHT,DIR_LEFT])
#define NODE_DIR_LIST_ALL ['Спереди:DIR_FRONT','Слева:DIR_LEFT','Справа:DIR_RIGHT','Сзади:DIR_BACK']

#define BONE_STATUS_OK 0
#define BONE_STATUS_CRACK 1
#define BONE_STATUS_BROKEN 2

#define BONE_STATUS_LIST_NODE_BINDING [ 'В порядке:BONE_STATUS_OK:Кости в порядке' \
	,'Трещина:BONE_STATUS_CRACK:Образовались трещины в костях' \
	,'Сломаны:BONE_STATUS_BROKEN:Открытый или закрытый перелом' \
]

#define ORGAN_STATUS_OK 0
#define ORGAN_STATUS_DAMAGED 1
#define ORGAN_STATUS_DESTROYED 2

#define STANCE_UP 2
#define STANCE_MIDDLE 1
#define STANCE_DOWN 0
#define NODE_STANCE_LIST_ALL ['В полный рост:STANCE_UP','В присяди:STANCE_MIDDLE','Лежа:STANCE_DOWN']

#define SPEED_MODE_STOP 0
#define SPEED_MODE_WALK 1
#define SPEED_MODE_RUN 2
#define SPEED_MODE_SPRINT 3
#define NODE_SPEED_MODE_LIST_ALL ['Без движения:SPEED_MODE_STOP','Ходьба:SPEED_MODE_WALK','Бег:SPEED_MODE_RUN','Спринт:SPEED_MODE_SPRINT']

#define LIGHT_NO 0
#define LIGHT_LOW 1
#define LIGHT_MEDIUM 2
#define LIGHT_LARGE 3
#define LIGHT_FULL 4
#define LIGHT_GET_MODIF_STEALTH(val) ([+5,+3,0,-3,-8]select(val))
#define NODE_LIGHT_LIST_ALL ['Нет света:LIGHT_NO','Слабый свет:LIGHT_LOW','Средний свет:LIGHT_MEDIUM','Большой свет:LIGHT_LARGE','Полный свет:LIGHT_FULL']

#define VIEW_MODE_NONE 0
//одного глаза нет например. ухудшенное зрение
#define VIEW_MODE_MEDIUM 1
#define VIEW_MODE_FULL 2

//режим видимости. устанавливается через canSeeObject. НЕ МЕНЯТЬ ПОРЯДОК НУМЕРАЦИИ. Только добавлять новые ниже.
//Эти значения означают насколько сильно должно быть видно объект. Например при VISIBILITY_MODE_LOW достаточно 1-2 точек видимости из 10
#define VISIBILITY_MODE_NONE 0
#define VISIBILITY_MODE_LOW 1
#define VISIBILITY_MODE_MEDIUM 2
#define VISIBILITY_MODE_FULL 3

#define NODE_VISIBILITY_MODE_LIST_ALL ['Не видно:VISIBILITY_MODE_NONE:Цель не видно' \
,'Плохо видно:VISIBILITY_MODE_LOW:Видно менее 50 процентов цели' \
,'Видно:VISIBILITY_MODE_MEDIUM:Цель видима. Имеется прямой зрительный контакт по 50+ процентам площади её тела.' \
,'Полностью видно:VISIBILITY_MODE_FULL:Вся площадь цели находится в видимом пространстве.']

#define UNC_ANIM_LIST ["Acts_StaticDeath_04","Acts_StaticDeath_05","Acts_StaticDeath_06","Acts_StaticDeath_10","Acts_StaticDeath_13"]
#define UNC_ANIM 'Incapacitated'
#define DEUNC_ANIM 'amovppnemstpsnonwnondnon'

#define UNC_MIMIC 'unconscious'
#define DEFAULT_MIMIC 'neutral'
#define DEAD_MIMIC 'dead'

#define CUSTOM_ANIM_ACTION_NONE 0
#define CUSTOM_ANIM_ACTION_SEAT 1
#define CUSTOM_ANIM_ACTION_STAND 2

//hunger and thirst coefs

//1.8h for non-activity
#define HUNGER_PER_TICK_LESS 0.015
//rand(0.05,0.06)

#define THIRST_PER_TICK_LESS 0
//rand(0.06,0.07)

//for non-encum: ~50min regen, for full encum: 16 min
#define HUNGER_STAMINA_LESS 0.034

#define HUNGER_UNC_TIME randInt(10,60 * 3)
#define THIRST_UNC_TIME randInt(10,60 * 2)

//pain system
//ограничения уровней
#define PAIN_LEVEL_MAX 4
#define PAIN_LEVEL_MIN 1
#define PAIN_LEVEL_NO 0

#define PAIN_LEVEL_TO_TEXT(val) (["","слабая боль","боль","сильная боль","ужасная боль"] select val)

//pain timings, 1 lvl - 2 min (120),2 lvl - 4 min(240),3lvl - 6 min(360)б 4lvl - 30 min;1800 => 2+4+6+30=33min to full heal
//4 уровень боли регенится только лекарствами
#define PAIN_LIST_RESTORE_TIME [0,120,240,360,1800]
#define PAIN_LEVEL_GET_RESTORE_TIME(lvl) (PAIN_LIST_RESTORE_TIME select lvl)

//сколько максимально боли может быть на части тела
#define PAIN_MAX_AMOUNT 2520

//по одной единице боли уменьшается за секунду игровой симуляции
#define PAIN_DEFAULT_RESTORE 1

//за сон уменьшается время боли только если она не агоническая
#define PAIN_SLEEP_RESTORE 2

//Проверка органов каждые 5-6 секунд

//через сколько секунд излечится орган без мед-вмешательства (10 минут)
#define ORGAN_HEAL_TIMEOUT 100
//хил органов во сне (за 2.5 мин)
#define ORGAN_REGEN_TIME_PRE_SECOND 4
//за 1 минуту лечит органы мед. препаратами
#define ORGAN_MEDICAL_REGEN_TIME_PER_SECOND 10

//BP REGEN

//60 секунд должно пройти перед началом регена
#define BODY_PART_REGEN_DELAY 60

//если голода осталось ниже этого значения то броски к регену со штрафом
#define BODY_PART_HUNGER_REGEN_LOWLEVEL 40


// Appearance change flags
#define APPEARANCE_UPDATE_DNA  0x1
#define APPEARANCE_RACE       (0x2|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_GENDER     (0x4|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_SKIN        0x8
#define APPEARANCE_HAIR        0x10
#define APPEARANCE_HAIR_COLOR  0x20
#define APPEARANCE_FACIAL_HAIR 0x40
#define APPEARANCE_FACIAL_HAIR_COLOR 0x80
#define APPEARANCE_EYE_COLOR 0x100
#define APPEARANCE_ALL_HAIR (APPEARANCE_HAIR|APPEARANCE_HAIR_COLOR|APPEARANCE_FACIAL_HAIR|APPEARANCE_FACIAL_HAIR_COLOR)
#define APPEARANCE_ALL       0xFFFF


// Click cooldown
#define DEFAULT_SLOW_COOLDOWN	16 //The default cooldown for slow actions.*/
#define DEFAULT_ATTACK_COOLDOWN 8 //Default timeout for aggressive actions*/
#define DEFAULT_QUICK_COOLDOWN  4

// Gluttony levels.
#define GLUT_TINY 1       /* Eat anything tiny and smaller*/
#define GLUT_SMALLER 2    /* Eat anything smaller than we are*/
#define GLUT_ANYTHING 4   /* Eat anything, ever*/

#define GLUT_ITEM_TINY 8         /* Eat items with a w_class of small or smaller*/
#define GLUT_ITEM_NORMAL 16      /* Eat items with a w_class of normal or smaller*/
#define GLUT_ITEM_ANYTHING 32    /* Eat any item*/
#define GLUT_PROJECTILE_VOMIT 64 /* When vomitting, does it fly out?*/

// Devour speeds, returned by can_devour()
#define DEVOUR_SLOW 1
#define DEVOUR_FAST 2

// Флаги дееспособности (свои)
#define INCAPACITATION_NONE 0
#define INCAPACITATION_STUNNED 1 /*оглушение*/
#define INCAPACITATION_KNOCKDOWN 2 /*нокдаун. Падение вниз. Короткое время бездействия*/
#define INCAPACITATION_LYING 4 /*лежит. либо персонаж лёг на кровать, либо просто лежит в анимке*/
#define INCAPACITATION_RESTRAINED 8 /*держится кем-то*/

#define INCAPACITATION_ALL (INCAPACITATION_STUNNED + INCAPACITATION_KNOCKDOWN + INCAPACITATION_LYING + INCAPACITATION_RESTRAINED)



#define NUTRITION_LEVEL_FAT 550
#define NUTRITION_LEVEL_FULL 500
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

//Thirst levels for humans
#define THIRST_LEVEL_MAX 800
#define THIRST_LEVEL_FILLED 600
#define THIRST_LEVEL_MEDIUM 300
#define THIRST_LEVEL_THIRSTY 200
#define THIRST_LEVEL_DEHYDRATED 50
#define THIRST_FACTOR 0.5

#define STARVATION_MIN 60 /*If you have less nutrition than this value, the hunger indicator starts flashing - THIS ISN'T USED!*/
#define STARVATION_NOTICE 45 /*If you have more nutrition than this value, you get an occasional message reminding you that you're going to starve soon*/
#define STARVATION_WEAKNESS 20 /*Otherwise, if you have more nutrition than this value, you occasionally become weak and receive minor damage*/
#define STARVATION_NEARDEATH 5 /*Otherwise, if you have more nutrition than this value, you have seizures and occasionally receive damage*/
