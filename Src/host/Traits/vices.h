// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Добавляет новый порок. Предыдущий порок записывается
#define addVice(class,name,desc) if (!isNullVar(_ptr)) then {_ptr set [2,_lastViceCode]; _ptr = null; _lastViceCode = null;}; \
_lastViceIndex = traits_viceGlobalList pushBack [class,name]; _ptr = [name,desc,{}]; traits_viceMap set [class,_ptr]; _lastViceCode = 

#define addViceTemplate(class,name,desc) addVice(class,name,desc) {};