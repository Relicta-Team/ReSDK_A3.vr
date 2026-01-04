// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

//отключив его мы переходим в полный режим отлада
//при режиме отлада вместо гейммода серверсцен загружает карту и создаёт мобов сам
#ifdef EMULATE_CLIENT_INSP
	#define IS_ENABLE_GAMEMODEMANAGER
#else
	//Пользовательское включение
	//#define IS_ENABLE_GAMEMODEMANAGER
#endif

#define getRoleObject(val) (missionNamespace getVariable ["role_"+(val),nullPtr])

//Печатники сообщений
#define gprint(mes) conDllCall format["[GMM]:	%1 #0101",mes]

#define gprintformat(mes,fmt) gprint(format[mes arg fmt]) 

//время в секундах до начала раунда
#define DEFAULT_TIME_TO_START 60
#ifdef EDITOR
#define DEFAULT_TIME_TO_START 5
#endif

//прелобби ожидание после которого пикнется режим
#define PRE_LOBBY_AWAIT_TIME 60*5

//время до выключения сервера при маленьком онлайне
#define PRE_LOBBY_LOW_ONLINE_AWAIT 60*10

#ifdef EDITOR
#define PRE_LOBBY_LOW_ONLINE_AWAIT 100000
//#define PRE_LOBBY_AWAIT_TIME 1
#endif
