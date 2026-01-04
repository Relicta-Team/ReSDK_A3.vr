// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define SOLID 1
#define LIQUID 2
#define GAS 3

#define TOUCH 1
#define INGEST 2
#define INJECT 3

// сварить. Такая реакция возникает при варке в колбах и кастрюлях
#define REACTION_COOKING 0
// смешать. Такая реакция возникает при смешивании
#define REACTION_BLENDING 1
// молоть. Реакция возникнет при размоле
#define REACTION_GRIND 2
// химическая реакция. происходит только в хим блендере или химсистеме
#define REACTION_CHEM 5
// DEPREACTED::::::::::::::::::::::::::::: жарить. Реакция возникнет при жарке на сковороде или открытом огне
#define REACTION_FRY 3
// DEPREACTED::::::::::::::::::::::::::::: сушка - вытяжка. Реакция возникнет
#define REACTION_DRYING 4

#define REACTION_ENUM_TO_TYPENAME(enum) (["REACTION_COOKING","REACTION_BLENDING","REACTION_GRIND","REACTION_FRY","REACTION_DRYING"] select enum)
#define REACTION_ENUM_TO_NAME(enum) (["Готовка","Смешивание","Перемалывание","Жарка","Сушка"] select enum)

// температура абсолютного нуля для кельвинов
#define __KELVIN__ 273.15

// умная замена: var(temp,TOCELSIUS(3000))
#define TOCELSIUS(val) ((val) - __KELVIN__)

// конвертация из цельсиев в кельвины
#define TCEL(val) (val-__KELVIN__)
// конвертация из кельвинов в цельсии (используется для визуализации)
#define TKEL(val) (val+__KELVIN__)

//стандартная температура созданных мсов
#define DEFAULT_TEMPERATURE 26


#define _UNC_GRAMM_VALUE_ 28.35

#define U * _UNC_GRAMM_VALUE_

//унции меньше грамма. В унциях все мсы
#define OZ(gramm) (gramm U)

/*
	1 литр ---------- ~35.3 унции
	0,5 литра ---------- ~17.6 унции

*/

//милилитры в унции
#define REAGENT_ML2OZ(am) (am / 28.35)
//литры в унции
#define REAGENT_L2OZ(am) (1000*(am) / 28.35)