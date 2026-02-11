// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define GENDER_MALE 0
#define GENDER_FEMALE 1
#define GENDER_NEUTER 2

#define GENDER_LIST_ALL_ [GENDER_MALE,GENDER_FEMALE,GENDER_NEUTER]
#define GENDER_STR_LIST_ALL_ ["GENDER_MALE","GENDER_FEMALE","GENDER_NEUTER"]

#define GENDER_PARSESTRING(val) (GENDER_LIST_ALL_ select (GENDER_STR_LIST_ALL_ find (val)))