// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define CRAFT_CATEGORY_TO_NAME(v) (CRAFT_CONST_CATEGORY_LIST_NAMES select (v))

#define CRAFT_CATEGORY_ID_CLOTH 0
#define CRAFT_CATEGORY_ID_FOOD 1
#define CRAFT_CATEGORY_ID_ALCHEMY 2
#define CRAFT_CATEGORY_ID_MEDICAL 3
#define CRAFT_CATEGORY_ID_WEAPONS 4
#define CRAFT_CATEGORY_ID_FURNITURE 5
#define CRAFT_CATEGORY_ID_LIGHTING 6
#define CRAFT_CATEGORY_ID_BUILDINGS 7
#define CRAFT_CATEGORY_ID_OTHER 8

#define CRAFT_CONST_CATEGORY_LIST_NAMES [ \
	"Одежда", \
	"Кулинария", \
	"Алхимия", \
	"Медицина", \
	"Оружие", \
	"Мебель", \
	"Свет", \
	"Постройки", \
	"Прочее" \
] 

#define CRAFT_CONST_CATEGORY_LIST_SYS_NAMES [ \
	"Cloth", \
	"Food", \
	"Alchemy", \
	"Medical", \
	"Weapon", \
	"Furniture", \
	"Light", \
	"Building", \
	"Other" \
]

#define CRAFT_CONST_CATEGORY_LIST_IDS (call{ private _idIter = -1; CRAFT_CONST_CATEGORY_LIST_SYS_NAMES apply \
{_idIter = _idIter + 1; _idIter} \
})