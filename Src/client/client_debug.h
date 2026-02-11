// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//серверный флаг отладки. Работает только в синглплеере
#define EDITOR 1

//скрывает серверные объекты (только в режиме отладки)
#define NOE_DEBUG_HIDE_SERVER_OBJECT
//скрывает серверный свет. работает только под редактором
#define NOE_DEBUG_HIDE_SERVER_LIGHT
//скрывает весь клиентский свет
//#define NOE_DEBUG_HIDE_CLIENT_LIGHT

//TODO: change colors for client and server lights (red/green)

// Использование клиентского кода из скомпилированных исходников
// !Устаревший
//#define USE_COMPILED_CLIENT

// при включенном режиме не будет генерировать карту 
//#define DO_NOT_CREATE_MAP

/*
    Use sdk_hasSystemFlag, sdk_getPropertyValue
    for get startup info
*/
// подстановка режима и роли
// #define EDITOR_AUTO_PLAY
// // выключенный флаг не будет стартовать игру
// #define EDITOR_CAN_AUTOSTART

// //Название режима для старта игры
// #define EDITOR_GAMEMODE GMSaloon

// //Название роли для старта игры
// #define EDITOR_STARTUP_ROLE RBarmenSaloon

//replaced to sdk var: sdk_temp_internal_forcedAspect
// #define EDITOR_FORCED_ASPECT "DirtpitIsRealAspect"

// #ifndef EDITOR
//     #undef EDITOR_AUTO_PLAY
// #endif