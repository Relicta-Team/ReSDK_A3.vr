// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define __COUNT_ELEMENTS_DATA_TRANSPORT__ 6

#define simpleObj_true 0.1
#define simpleObj_false 0
#define wposObj_true 0.01
#define wposObj_false 0
#define vDirObj_true 0.001
#define vDirObj_false 0
#define lightObj_true 0.0001
#define lightObj_false 0

#define animObj_count(val) 0.0000##val
#define animObj_true 0.00001
#define animObj_false 0

#define radioObj_true 0.000001
#define radioObj_false 0

#define transportFlagsToArray(fl) (fl toFixed __COUNT_ELEMENTS_DATA_TRANSPORT__ splitString "")