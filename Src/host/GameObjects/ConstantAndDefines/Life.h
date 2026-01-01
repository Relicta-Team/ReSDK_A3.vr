// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Лайфовые константы

// Все кровяные функции в миллилитрах

//сколько единиц крови тратится с одной самой малой раны
//прим. с 5 царапин тратися 5 ед. а с 1 малой тратится 6 ед
#define BLOOD_LOSS_VALUE 0.00045
//5 ран усредненного уровня вытечет 3 литра за ~16мин

//сколько единиц крови теряется с каждой раны каждого из уровней в сек
// Формула получения траты крови: 0.5 * (2 ^ 3)
// НЕ ПРАВИЛЬНО
//Вот формула 0.04*(6^4)
/*#define BLOOD_LOSS_MAP [0.04, \
						1, \
						2, \
						4]*/

// Получает количество единиц крови которые будут затрачены с однйо раны уровня						
#define BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(size) (BLOOD_LOSS_VALUE*(6^size))

// сколько вытекает с артерий.
//3литра с головы вытечет за ~2.2мин: 3000/23/  60
//с конечностей за примерно 4 минуты
#define BLOOD_LOSS_ARTERY_HEAD 23
#define BLOOD_LOSS_ARTERY_LIMB 12
#define BLOOD_LOSS_ARTERY_TORSO 11

#define BLOOD_LOSS_INCISED 0.3

//сколько вытекает с органа в состоянии поврежденный и уничтоженный
//~28 min
#define BLOOD_LOSS_ORGAN_DAMAGED 3
//~23 min
#define BLOOD_LOSS_ORGAN_DESTROYED 3.5


//5 литров
#define BLOOD_MAX_VALUE_OZ 176.367

//уровень ниже которого кровь хуже качается и медленнее вытекает (2 литра)
#define BLOOD_LOWPRESSURE_LEVEL_OZ 70.5467

//затраченная кровь умноженная на фактор - новое количество затрачиваемой крови
//при низком кровяном давлении
#define BLOOD_LOWPRESSURE_FACTOR 0.05

//Раны выше или равные этому уровню залечатся только если забинтованы
#define BLOOD_BLOCKED_HEALING_WOUNDSIZE WOUND_SIZE_MAJOR

//Бинт не остановит кровотечение если рана этого типа или выше
#define BLOOD_BLOCKED_BANDAGE_WOUNDSIZE WOUND_SIZE_CRITICAL

// ------------ лужи крови --------------

//Дистанция на которых может быть создана кровь
#define BLOODPOOL_DISTANCE_TO_CAN_CREATE 1.8

// Сколько должно тратиться крови чтобы создать лужу
#define BLOODPOOL_VOLUME_NEED_TO_CREATE 7



//Через сколько запустится проверка на создание лужи
#ifdef EDITOR
	#define BLOODPOOL_DELAY_TO_NEXT_CHECK 2
#else
	#define BLOODPOOL_DELAY_TO_NEXT_CHECK randInt(20,30)
#endif
