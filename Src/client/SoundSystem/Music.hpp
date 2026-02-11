// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(AudioSystem.Music,music_)

enum(MusicSmoothType,MUSIC_SMOOTH_)
#define MUSIC_SMOOTH_NO 0
#define MUSIC_SMOOTH_START 1
#define MUSIC_SMOOTH_END 2
#define MUSIC_SMOOTH_FULL 3
enumend

enum(MusicRepeatType,MUSIC_REPEAT_)
#define MUSIC_REPEAT_NO 0
#define MUSIC_REPEAT_YES 1
#define MUSIC_REPEAT_AND_BACKWARD 2
enumend

macro_const(music_smooth_time_default)
#define MUSIC_SMOOTH_TIME_DEFAULT 5

enum(MusicChannel,MUSIC_CHANNEL_)
//системный. не используется
#define MUSIC_CHANNEL_BASE 0
//канал лобби
#define MUSIC_CHANNEL_LOBBY 1
//эмбиент - основной 
#define MUSIC_CHANNEL_AMBIENT 2
//эмбиент - локальный. вход в интересное место или подобное
#define MUSIC_CHANNEL_AMBIENT_LOCAL 3
//боевой эмбиент - пока не задействован
#define MUSIC_CHANNEL_COMBATAMBIENT 4
//музыка конца раунда, или любого важного события
#define MUSIC_CHANNEL_EVENT_GLOBAL 5
enumend

inline_macro
#define chm(a,b) [ a , b ]
macro_const(music_list_internal_allChannels)
#define MUSIC_MAP_INTERNAL_ALLCHANNELS [ \
chm("MUSIC_CHANNEL_BASE",0), \
chm("MUSIC_CHANNEL_LOBBY",1), \
chm("MUSIC_CHANNEL_AMBIENT",2), \
chm("MUSIC_CHANNEL_AMBIENT_LOCAL",3), \
chm("MUSIC_CHANNEL_COMBATAMBIENT",4), \
chm("MUSIC_CHANNEL_EVENT_GLOBAL",5) \
]

macro_const(music_list_node_enum_def)
#define MUSIC_LIST_NODE_ENUM_DEF [ \
'Базовый:MUSIC_CHANNEL_BASE:Базовый начальный канал. Имеет самый низший приоритет воспроизведения.', \
'Лобби:MUSIC_CHANNEL_LOBBY:Канал лобби. В нем играет музыка для лобби', \
'Эмбиент:MUSIC_CHANNEL_AMBIENT:Основной канал для эмбиентов', \
'Локальный эмбиент:MUSIC_CHANNEL_AMBIENT_LOCAL:Локационный и ситуативный эмбиент', \
'Сражение:MUSIC_CHANNEL_COMBATAMBIENT:Боевой эмбиент. Пока не задан', \
'Глобальное событие:MUSIC_CHANNEL_EVENT_GLOBAL:Музыка конца раунда, или любого важного события. Имеет на текущий момент наивысший приоритет воспроизведения.' \
]

