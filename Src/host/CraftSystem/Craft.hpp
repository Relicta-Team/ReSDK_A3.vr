// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//!!! sort order actual !!!
#define CRAFT_CATEGORY_CLOTH 0
#define CRAFT_CATEGORY_FOOD 1
#define CRAFT_CATEGORY_ALCHEMY 2
#define CRAFT_CATEGORY_MEDICAL 3
#define CRAFT_CATEGORY_WEAPONS 4
#define CRAFT_CATEGORY_FURNITURE 5
#define CRAFT_CATEGORY_LIGHTING 6
#define CRAFT_CATEGORY_BUILDINGS 7
#define CRAFT_CATEGORY_OTHER 8

#define CRAFT_CATEGORY_COUNT_STD 5000
#define CRAFT_CATEGORY_LIST_ALL [0,1,2,3,4,5,6,7,8]
#define CRAFT_CATEGORY_LIST_NAMES ["Одежда","Кулинария","Алхимия","Медицина","Оружие","Мебель","Свет","Постройки","Прочее"]
#define CRAFT_CATEGORY_TO_NAME(cat) (CRAFT_CATEGORY_LIST_NAMES select (cat))

// [_header,_reqinfo,_serverReqItems,_conditionVisible,_handleReqitems,_conditionCraft,_resultAction];
#define CRAFT_RECIPE_SYSTEMID 0
#define CRAFT_RECIPE_NAME 1
#define CRAFT_RECIPE_REQITEMS 2
#define CRAFT_RECIPE_DESC 3
