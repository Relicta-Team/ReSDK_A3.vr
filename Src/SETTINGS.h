// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Определяет все константы только в режиме отладки
#if __has_include("client\client_debug.h")
	#include <client\client_debug.h>
#endif

//определение констант для работы RBuilder
#if __has_include("..\preload\rbuilder.h")
	#include <..\preload\rbuilder.h>
#endif

#ifdef EDITOR
	#define EDITOR_OR_RBUILDER
	#define RBUILDER_OR_EDITOR

	#define SP_MODE_OR_EDITOR
	#define EDITOR_OR_SP_MODE
#endif

#ifdef RBUILDER
	#undef EDITOR
	#define EDITOR_OR_RBUILDER
	#define RBUILDER_OR_EDITOR
#endif

//uncomment for enable singleplayer
//#define SP_MODE
//#define SP_PROD
//#define SP_DEBUG

#ifdef SP_MODE
	#define SP_MODE_OR_EDITOR
	#define EDITOR_OR_SP_MODE
	#undef EDITOR
#endif

//disable spdebug on disabled spmode
#ifndef SP_MODE
	#undef SP_DEBUG
#endif

//rbuilder force disable spmode and editor
#ifdef RBUILDER
	#undef SP_MODE_OR_EDITOR
	#undef EDITOR_OR_SP_MODE
#endif

//============================================================================
//			REGION: COMMON SETTINGS
//Флаг указывает что это релизная версия, подготовленная для общего пользования
//#define RELEASE

// Общий флаг отладки
#define DEBUG

//разрешить трейс сообщения. Автоматически выключается при активном RELEASE
#define __TRACE__ENABLED

//Выключает ассерты
//#define DISABLE_ASSERT
//Включает автовыход при отлове ассерта
//#define ENABLE_EXIT_ON_ASSERT

// Позволяет включить лог пакетов в консоли. Зачастую не используется
#define ENABLE_RPCLOG_CONSOLE_SERVER
// позволяет включить лог пакетов в консоли. В Релизе на клиенте отключается
#define ENABLE_RPCLOG_CONSOLE_CLIENT

// Включает загрузку сборки не из PBO файла, а с прямой ссылки. Позволяет изменять контент клиента без перезапуска сервера
// do not change
//#define ENABLE_HOT_RELOAD

//флаг указывает что доступ на сервер только у тех кто в вайтлисте
//#define TEST_WHITELISTED
//============================================================================


// Включенный режим будет загружать картинки и звуки из миссии
#define USE_LOCAL_PATHES

//Эта включенная настройка блокирует загрузку клиентсайда в режиме СП
//Эмуляция подключения клиента в сп. Нужнно выключить в основном билде
//так же в выключенном режиме не работает гейммод менеджер
// do not change
//#define EMULATE_CLIENT_INSP

//Принудительно выключает эскейп меню реликты (работает только в сингле)
#define DISABLE_SCRIPTED_ESCAPE_MENU

//Пароль для серверных комманд
#define SERVER_PASSWORD server_password

#ifndef EDITOR
	#define __FORCE_DISABLE_LOCAL_PATHES__
	//по умолчанию в прод.сп скриптовый эскейп включен всегда
	#undef DISABLE_SCRIPTED_ESCAPE_MENU
#endif

#ifdef __FORCE_DISABLE_LOCAL_PATHES__
	#undef __FORCE_DISABLE_LOCAL_PATHES__
	#undef USE_LOCAL_PATHES
#endif

//in RBUILDER mode force disable local pathes
#ifdef RBUILDER
	#undef USE_LOCAL_PATHES
#endif

//новая аудиосистема
#define ENABLE_NEW_AUDIO_SYSTEM

//Пути до разных сегментов
#ifdef USE_LOCAL_PATHES
	#define PATH_SOUND_FOLDER "resources\sounds\"
	#define PATH_PICTURE_FOLDER "resources\ui\"

	#define PATH_SOUND(sound) (getMissionPath (PATH_SOUND_FOLDER + sound))
	#define PATH_PICTURE(pic) (PATH_PICTURE_FOLDER + pic)
#else
	#ifdef ENABLE_NEW_AUDIO_SYSTEM
		#define PATH_SOUND_FOLDER "rel_gamecontent.pbo\sounds\"
	#else
		#define PATH_SOUND_FOLDER "rel_gamecontent\sounds\"
	#endif
	#define PATH_PICTURE_FOLDER "rel_gamecontent\data\"
	
	//#define PATH_PICTURE_FOLDER "rel_gamecontent\ui\"


	#define PATH_SOUND(sound) (PATH_SOUND_FOLDER + sound)
	#define PATH_PICTURE(pic) (PATH_PICTURE_FOLDER + pic)
#endif

//Когда будем загружать сервер нужно поменять этот путь
#define PATH_TO_CLIENT_DATA "CLIENT"

//debugging

//#define ENABLE_LAG_NETWORK

//настройка позволяет устанавливать динамическую задержку сети в режиме отладки
#define __LAG_NETWORK_MANAGED_TICKTIME
//без рандома
//#define __LAG_NETWORK_NO_RANDOM

#define __LAG_NETWORK_PING_MIN 1
#define __LAG_NETWORK_PING_MAX 10


#ifndef ENABLE_LAG_NETWORK
	#undef __LAG_NETWORK_MANAGED_TICKTIME
	#undef __LAG_NETWORK_NO_RANDOM
#endif

//время задержки в миллисекундах
#ifdef __LAG_NETWORK_MANAGED_TICKTIME
	LAG_NETWORK_TICKTIME_MIN = 0;
	LAG_NETWORK_TICKTIME_MAX = 0;

	lagnet_setrange = {
		params [["_low",1,[0]],["_up",10,[0]]];
		LAG_NETWORK_TICKTIME_MIN = _low / 1000;
		LAG_NETWORK_TICKTIME_MAX = _up / 1000;
	};
#else
	#define LAG_NETWORK_TICKTIME_MIN __LAG_NETWORK_PING_MIN / 1000
	#define LAG_NETWORK_TICKTIME_MAX __LAG_NETWORK_PING_MAX / 1000
#endif

#ifdef __LAG_NETWORK_NO_RANDOM
	#define __LAG_NETWORK_GET_LAG__ LAG_NETWORK_TICKTIME_MIN
#else
	#define __LAG_NETWORK_GET_LAG__ rand(LAG_NETWORK_TICKTIME_MIN,LAG_NETWORK_TICKTIME_MAX)
#endif

//этот флаг отключает систему голосования
//#define DISABLE_VOTING_SYSTEM


//DO NOT UNCOMMENTED
//#define NOE_DEBUG_HIDE_SERVER_OBJECT


//Новый экспериментальный алгоритм работы указателей
#define POINTER_SYSTEM_EXPERIMENTAL

//макрос отладки клиентских потоков
//#define NOE_CLIENT_THREAD_DEBUG

//disable flags
#ifndef EDITOR
	#undef DEBUG
	#undef RELEASE
	#undef TEST_WHITELISTED
	#undef PRIVATELAUNCH
#endif

//прод.запуск сп режима
#ifdef SP_PROD
	#undef DEBUG
	#define RELEASE
#else
	#ifdef SP_MODE
		#undef RELEASE
		#define DEBUG
	#endif
#endif

// -preprocDefine=CMD__MACRONAME
//redirected preproc
#ifdef CMD__DEBUG
	#define DEBUG
#endif

#ifdef CMD__RELEASE
	#define RELEASE
#endif

#ifdef CMD__WHITELIST
	#define TEST_WHITELISTED
#endif

#ifdef CMD__PRIVATELAUNCH
	#define PRIVATELAUNCH
#endif

//принудительная симуляция текстового чата
//#define TEXTCHAT

#ifdef CMD__TEXTCHAT
	#define TEXTCHAT
#endif

//выключение войса - работает только в режиме DEBUG
#ifdef CMD__DISABLETEAMSPEAK
	#define DISABLETEAMSPEAK
#endif

#ifdef RELEASE
	#undef ENABLE_RPCLOG_CONSOLE_CLIENT
	#undef DISABLETEAMSPEAK
#endif

//not implemented now
#ifdef CMD__USELAUNCHCOUNTER
	#define USE_LAUNCH_COUNTER
	#define LAUNCH_COUNTER 2 
#endif
// time restricted by 23 hrs
//#define CMD__USEEVERYDAYRUN
#ifdef CMD__USEEVERYDAYRUN

	#define USEEVERYDAYRUN_HOUR 23
	#define USEEVERYDAYRUN_MINUTE 50
	
	//этот макрос устарел и вызывается не фиксированное количество раз
	#define USEEVERYDAYRUN_doValidation() 

	//эта таска гоняется в цикле каждые 10 секунд (фиксировано)
	#define USEEVERYDAYRUN_THREAD_UPDATE() _hr__ = systemtime select 3; _min__ = systemtime select 4; \
	if (_hr__ >= USEEVERYDAYRUN_HOUR && _min__ >= USEEVERYDAYRUN_MINUTE) then { \
		if (!gm_isLastRound) then { \
			gm_isLastRound = true; \
		}; \
	}
#else
	#define USEEVERYDAYRUN_doValidation() 
	#define USEEVERYDAYRUN_THREAD_UPDATE() 
#endif


