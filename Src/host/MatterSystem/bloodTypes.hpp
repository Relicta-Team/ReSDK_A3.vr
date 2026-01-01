// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//https://thumbs.dreamstime.com/z/таблица-диаграмма-совместимости-группы-крови-с-дарителем-и-132726781.jpg

//Случайная группа. не используется в значениях
#define BLOOD_TYPE_RANDOM -1

#define BLOOD_TYPE_O_MINUS 10
#define BLOOD_TYPE_O_PLUS 11
#define BLOOD_TYPE_A_MINUS 20
#define BLOOD_TYPE_A_PLUS 21
#define BLOOD_TYPE_B_MINUS 30
#define BLOOD_TYPE_B_PLUS 31
#define BLOOD_TYPE_AB_MINUS 40
#define BLOOD_TYPE_AB_PLUS 41


#define BLOOD_LIST_ALL_TYPES [BLOOD_TYPE_O_MINUS,BLOOD_TYPE_O_PLUS,BLOOD_TYPE_A_MINUS,BLOOD_TYPE_A_PLUS,BLOOD_TYPE_B_MINUS,BLOOD_TYPE_B_PLUS,BLOOD_TYPE_AB_MINUS,BLOOD_TYPE_AB_PLUS]
#define BLOOD_LIST_ALL_MATTERS ["Blood_OMinus","Blood_OPlus","Blood_AMinus","Blood_APlus","Blood_BMinus","Blood_BPlus","Blood_ABMinus","Blood_ABPlus"]
#define BLOOD_LIST_ALL_NAMES ["O-","O+","A-","A+","B-","B+","AB-","AB+"]

#define BLOOD_ENUM_TO_STRING(enum) (BLOOD_LIST_ALL_NAMES select (BLOOD_LIST_ALL_TYPES find (enum)))
#define BLOOD_ENUM_TO_MATTER(enum) (BLOOD_LIST_ALL_MATTERS select (BLOOD_LIST_ALL_TYPES find (enum)))
