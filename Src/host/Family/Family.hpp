// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// одиночество
#define FAMILY_LONELINES 0

//холостятство
#define FAMILY_SINGLE 1

//в семье
#define FAMILY_FULL 2

//Значение по-умолчанию
#define FAMILY_DEFAULT FAMILY_LONELINES

//Проверка семейного положения в enum-ах 
#define FAMILY_IS_EXISTS(num) (num >= 0 && num <= 2) 