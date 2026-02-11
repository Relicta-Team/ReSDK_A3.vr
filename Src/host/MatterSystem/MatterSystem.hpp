// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//pseudoname
#define newReagents call ms_createOnObject

#define newReagentsFood call {[_this]newReagents}

//rs: reagent structure (MatterType,amount)
#define rs(mat,am) [#mat,am]

//is: item structure for matters (required_reagents): (TypeName_item,count)
#define ri(object,__cnt) [#object,__cnt]

#define MS_STRUCT_INDEX_SOURCE 0
#define MS_STRUCT_INDEX_CAPACITY 1
#define MS_STRUCT_INDEX_MATTERS 2
#define MS_STRUCT_INDEX_MATDATA 3

#define getMatter(strname) (ms_map_allMatters get (strname))
#define getMatterProp(strname,pname) (ms_map_allMatters get (strname) get #pname )

#define isReagentTypeOf(strname,checkedtype) ((tolower checkedtype) in (ms_map_allMatters get (strname) get "__typelist"))

#define ms_getCapacity(ms) (ms select MS_STRUCT_INDEX_CAPACITY)
#define ms_setCapacity(ms,cap) ms set [MS_STRUCT_INDEX_CAPACITY,cap]

#define ms_getSource(ms) (ms select MS_STRUCT_INDEX_SOURCE)

#define ms_getMatterList(ms) (ms select MS_STRUCT_INDEX_MATTERS)

#define ms_getMatterData(ms) (ms select MS_STRUCT_INDEX_MATDATA)

#define ms_getFilledSpace(ms) call{private _it=0;{_it = _it + _x}count(values ms_getMatterList(ms)); _it}

#define ms_getFreeSpace(ms) call{private _it=0;{_it = _it + _x}count(values ms_getMatterList(ms)); ms_getCapacity(ms) - _it}

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