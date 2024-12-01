# Music.hpp

## MUSIC_SMOOTH_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 8](../../../Src/client/SoundSystem/Music.hpp#L8)
## MUSIC_SMOOTH_START

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 9](../../../Src/client/SoundSystem/Music.hpp#L9)
## MUSIC_SMOOTH_END

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 10](../../../Src/client/SoundSystem/Music.hpp#L10)
## MUSIC_SMOOTH_FULL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SoundSystem\Music.hpp at line 11](../../../Src/client/SoundSystem/Music.hpp#L11)
## MUSIC_REPEAT_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 13](../../../Src/client/SoundSystem/Music.hpp#L13)
## MUSIC_REPEAT_YES

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 14](../../../Src/client/SoundSystem/Music.hpp#L14)
## MUSIC_REPEAT_AND_BACKWARD

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 15](../../../Src/client/SoundSystem/Music.hpp#L15)
## MUSIC_SMOOTH_TIME_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\SoundSystem\Music.hpp at line 17](../../../Src/client/SoundSystem/Music.hpp#L17)
## MUSIC_CHANNEL_BASE

Type: constant

Description: системный. не используется


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 21](../../../Src/client/SoundSystem/Music.hpp#L21)
## MUSIC_CHANNEL_LOBBY

Type: constant

Description: канал лобби


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 23](../../../Src/client/SoundSystem/Music.hpp#L23)
## MUSIC_CHANNEL_AMBIENT

Type: constant

Description: эмбиент - основной


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 25](../../../Src/client/SoundSystem/Music.hpp#L25)
## MUSIC_CHANNEL_AMBIENT_LOCAL

Type: constant

Description: эмбиент - локальный. вход в интересное место или подобное


Replaced value:
```sqf
3
```
File: [client\SoundSystem\Music.hpp at line 27](../../../Src/client/SoundSystem/Music.hpp#L27)
## MUSIC_CHANNEL_COMBATAMBIENT

Type: constant

Description: боевой эмбиент - пока не задействован


Replaced value:
```sqf
4
```
File: [client\SoundSystem\Music.hpp at line 29](../../../Src/client/SoundSystem/Music.hpp#L29)
## MUSIC_CHANNEL_EVENT_GLOBAL

Type: constant

Description: музыка конца раунда, или любого важного события


Replaced value:
```sqf
5
```
File: [client\SoundSystem\Music.hpp at line 31](../../../Src/client/SoundSystem/Music.hpp#L31)
## chm(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
[ a , b ]
```
File: [client\SoundSystem\Music.hpp at line 33](../../../Src/client/SoundSystem/Music.hpp#L33)
## MUSIC_MAP_INTERNAL_ALLCHANNELS

Type: constant

Description: 


Replaced value:
```sqf
[ \
chm("MUSIC_CHANNEL_BASE",0), \
chm("MUSIC_CHANNEL_LOBBY",1), \
chm("MUSIC_CHANNEL_AMBIENT",2), \
chm("MUSIC_CHANNEL_AMBIENT_LOCAL",3), \
chm("MUSIC_CHANNEL_COMBATAMBIENT",4), \
chm("MUSIC_CHANNEL_EVENT_GLOBAL",5) \
]
```
File: [client\SoundSystem\Music.hpp at line 34](../../../Src/client/SoundSystem/Music.hpp#L34)
## MUSIC_LIST_NODE_ENUM_DEF

Type: constant

Description: 


Replaced value:
```sqf
[ \
'Базовый:MUSIC_CHANNEL_BASE:Базовый начальный канал. Имеет самый низший приоритет воспроизведения.', \
'Лобби:MUSIC_CHANNEL_LOBBY:Канал лобби. В нем играет музыка для лобби', \
'Эмбиент:MUSIC_CHANNEL_AMBIENT:Основной канал для эмбиентов', \
'Локальный эмбиент:MUSIC_CHANNEL_AMBIENT_LOCAL:Локационный и ситуативный эмбиент', \
'Сражение:MUSIC_CHANNEL_COMBATAMBIENT:Боевой эмбиент. Пока не задан', \
'Глобальное событие:MUSIC_CHANNEL_EVENT_GLOBAL:Музыка конца раунда, или любого важного события. Имеет на текущий момент наивысший приоритет воспроизведения.' \
]
```
File: [client\SoundSystem\Music.hpp at line 43](../../../Src/client/SoundSystem/Music.hpp#L43)
# Music.sqf

## BUFFER_PRIORITY_MAX

Type: constant

Description: 


Replaced value:
```sqf
32
```
File: [client\SoundSystem\Music.sqf at line 99](../../../Src/client/SoundSystem/Music.sqf#L99)
## MUSIC_DEBUG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 101](../../../Src/client/SoundSystem/Music.sqf#L101)
## mlog(text)

Type: constant

> Exists if **MUSIC_DEBUG** defined

Description: 
- Param: text

Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 109](../../../Src/client/SoundSystem/Music.sqf#L109)
## mlogformat(text,args)

Type: constant

> Exists if **MUSIC_DEBUG** defined

Description: 
- Param: text
- Param: args

Replaced value:
```sqf
logformat("[MUSIC::DEBUG]: " + text,args);
```
File: [client\SoundSystem\Music.sqf at line 109](../../../Src/client/SoundSystem/Music.sqf#L109)
## mlogformat(text,args)

Type: constant

> Exists if **MUSIC_DEBUG** not defined

Description: 
- Param: text
- Param: args

Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 112](../../../Src/client/SoundSystem/Music.sqf#L112)
## music_internal_class2path

Type: Variable

Description: двойная ассоциация класса и пути


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 57](../../../Src/client/SoundSystem/Music.sqf#L57)
## music_internal_path2class

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 58](../../../Src/client/SoundSystem/Music.sqf#L58)
## music_internal_folderData

Type: Variable

Description: хэш карта папок и композиций внутри них


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 60](../../../Src/client/SoundSystem/Music.sqf#L60)
## music_internal_durationMap

Type: Variable

Description: карта длительности (key: musicname, val: duration)


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 62](../../../Src/client/SoundSystem/Music.sqf#L62)
## music_playedObject

Type: Variable

Description: объект композиции который играет в данную минуту


Initial value:
```sqf
null
```
File: [client\SoundSystem\Music.sqf at line 65](../../../Src/client/SoundSystem/Music.sqf#L65)
## music_internal_priority

Type: Variable

Description: 


Initial value:
```sqf
_buffer apply ...
```
File: [client\SoundSystem\Music.sqf at line 121](../../../Src/client/SoundSystem/Music.sqf#L121)
## music_internal_paused

Type: Variable

Description: 


Initial value:
```sqf
_buffer apply ...
```
File: [client\SoundSystem\Music.sqf at line 122](../../../Src/client/SoundSystem/Music.sqf#L122)
## music_internal_lastPriority

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SoundSystem\Music.sqf at line 123](../../../Src/client/SoundSystem/Music.sqf#L123)
## music_internal_map_chanToEnum

Type: Variable

Description: строковая карта всех каналов


Initial value:
```sqf
createHashMapFromArray MUSIC_MAP_INTERNAL_ALLCHANNELS
```
File: [client\SoundSystem\Music.sqf at line 247](../../../Src/client/SoundSystem/Music.sqf#L247)
## music_internal_handleOnUpdate

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(music_internal_onUpdate,0)
```
File: [client\SoundSystem\Music.sqf at line 443](../../../Src/client/SoundSystem/Music.sqf#L443)
## music_play

Type: function

Description: 
- Param: _file
- Param: _priority (optional, default 0)
- Param: _params (optional, default [])

File: [client\SoundSystem\Music.sqf at line 136](../../../Src/client/SoundSystem/Music.sqf#L136)
## music_setPause

Type: function

Description: 
- Param: _chan
- Param: _mode
- Param: _smooth (optional, default false)

File: [client\SoundSystem\Music.sqf at line 300](../../../Src/client/SoundSystem/Music.sqf#L300)
## music_stop

Type: function

Description: принудительная остановка музыки на данном канале и очистка канала. параметр -1 чистит все каналы
- Param: _chan (optional, default -1)

File: [client\SoundSystem\Music.sqf at line 333](../../../Src/client/SoundSystem/Music.sqf#L333)
## music_internal_setFade

Type: function

Description: 
- Param: _fade
- Param: _time (optional, default -1)

File: [client\SoundSystem\Music.sqf at line 359](../../../Src/client/SoundSystem/Music.sqf#L359)
## music_internal_onUpdate

Type: function

Description: 


File: [client\SoundSystem\Music.sqf at line 364](../../../Src/client/SoundSystem/Music.sqf#L364)
# MusicManager.sqf

## getStructData(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(music_currentPlay get var)
```
File: [client\SoundSystem\MusicManager.sqf at line 7](../../../Src/client/SoundSystem/MusicManager.sqf#L7)
## setStructData(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
music_currentPlay set [var,val]
```
File: [client\SoundSystem\MusicManager.sqf at line 8](../../../Src/client/SoundSystem/MusicManager.sqf#L8)
## music_categories

Type: Variable

Description: 


Initial value:
```sqf
hashSet_createList("ambient" arg "caveambient" arg "lobby" arg "events")
```
File: [client\SoundSystem\MusicManager.sqf at line 10](../../../Src/client/SoundSystem/MusicManager.sqf#L10)
## music_durations

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\MusicManager.sqf at line 11](../../../Src/client/SoundSystem/MusicManager.sqf#L11)
## music_currentPlay

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [["type","nan"],["duration",0],["isplaying",false]]
```
File: [client\SoundSystem\MusicManager.sqf at line 12](../../../Src/client/SoundSystem/MusicManager.sqf#L12)
## music_volume

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\SoundSystem\MusicManager.sqf at line 13](../../../Src/client/SoundSystem/MusicManager.sqf#L13)
## music_mainThread_handle

Type: Variable

Description: music_counters = createHashMapFromArray []; //сколько конфигураций для музыки


Initial value:
```sqf
startUpdate(music_onUpdate,0)
```
File: [client\SoundSystem\MusicManager.sqf at line 161](../../../Src/client/SoundSystem/MusicManager.sqf#L161)
## music_lastPlayedTheme

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\SoundSystem\MusicManager.sqf at line 16](../../../Src/client/SoundSystem/MusicManager.sqf#L16)
## music_settedLobbyTheme

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\SoundSystem\MusicManager.sqf at line 26](../../../Src/client/SoundSystem/MusicManager.sqf#L26)
## music_isStartedAmbientMode

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\SoundSystem\MusicManager.sqf at line 127](../../../Src/client/SoundSystem/MusicManager.sqf#L127)
## music_internal_createStruct

Type: function

Description: Создаёт структуру категории музыки
- Param: _countSounds

File: [client\SoundSystem\MusicManager.sqf at line 29](../../../Src/client/SoundSystem/MusicManager.sqf#L29)
## music_resetCurrentPlayMemory

Type: function

Description: сборс параметров музыки


File: [client\SoundSystem\MusicManager.sqf at line 35](../../../Src/client/SoundSystem/MusicManager.sqf#L35)
## music_initCurrentPlayMemory

Type: function

Description: Вызывается только внутри запускатора музыки
- Param: _t
- Param: _d

File: [client\SoundSystem\MusicManager.sqf at line 41](../../../Src/client/SoundSystem/MusicManager.sqf#L41)
## music_isStarted

Type: function

Description: Находится ли музыка в буфере


File: [client\SoundSystem\MusicManager.sqf at line 49](../../../Src/client/SoundSystem/MusicManager.sqf#L49)
## music_isPlaying

Type: function

Description: играет ли музка в данный момент


File: [client\SoundSystem\MusicManager.sqf at line 51](../../../Src/client/SoundSystem/MusicManager.sqf#L51)
## music_pause

Type: function

Description: пауза музыки


File: [client\SoundSystem\MusicManager.sqf at line 54](../../../Src/client/SoundSystem/MusicManager.sqf#L54)
## music_return

Type: function

Description: возобновить проигрывание


File: [client\SoundSystem\MusicManager.sqf at line 60](../../../Src/client/SoundSystem/MusicManager.sqf#L60)
## music_getPlayedTime

Type: function

Description: Вовзаращет текущее время с начала композиции


File: [client\SoundSystem\MusicManager.sqf at line 71](../../../Src/client/SoundSystem/MusicManager.sqf#L71)
## music_play

Type: function

Description: 
- Param: _config
- Param: _startTime (optional, default 0)

File: [client\SoundSystem\MusicManager.sqf at line 75](../../../Src/client/SoundSystem/MusicManager.sqf#L75)
## music_stop

Type: function

Description: 
- Param: _fadetime (optional, default 0)

File: [client\SoundSystem\MusicManager.sqf at line 90](../../../Src/client/SoundSystem/MusicManager.sqf#L90)
## music_changeToNew

Type: function

Description: плавная смена композиции
- Param: _config
- Param: _startTime
- Param: _fadeOld (optional, default 5)
- Param: _fadeNew (optional, default 5)

File: [client\SoundSystem\MusicManager.sqf at line 110](../../../Src/client/SoundSystem/MusicManager.sqf#L110)
## music_setVolume

Type: function

Description: ----- VOLUME MUSIC MANAGMENT ------
- Param: _fade
- Param: _time (optional, default 0)

File: [client\SoundSystem\MusicManager.sqf at line 117](../../../Src/client/SoundSystem/MusicManager.sqf#L117)
## music_playRandomAmbientMusic

Type: function

Description: testing sound


File: [client\SoundSystem\MusicManager.sqf at line 123](../../../Src/client/SoundSystem/MusicManager.sqf#L123)
## music_setRoundMusicMode

Type: function

Description: 
- Param: _mode

File: [client\SoundSystem\MusicManager.sqf at line 129](../../../Src/client/SoundSystem/MusicManager.sqf#L129)
## music_onUpdate

Type: function

Description: регулярный цикл обновления музыки


File: [client\SoundSystem\MusicManager.sqf at line 143](../../../Src/client/SoundSystem/MusicManager.sqf#L143)
# MusicManager_experimental.sqf

## MM_CHANNELS_MAX_ORDER_ID

Type: constant

Description: Layer component


Replaced value:
```sqf
512
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 35](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L35)
## MM_LAYER_NULL

Type: constant

Description: 


Replaced value:
```sqf
objnull
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 36](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L36)
## MM_STATE_PLAYED

Type: constant

Description: TODO move to public header


Replaced value:
```sqf
0
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 39](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L39)
## MM_STATE_PAUSED

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 40](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L40)
## MM_STATE_STOPPED

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 41](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L41)
## mm_list_channels

Type: Variable

Description: elements info in mm_channels_internal_initStruct


Initial value:
```sqf
[]
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 45](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L45)
## mm_internal_mainThread_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 56](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L56)
## mm_currentChannel

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 58](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L58)
## mm_globalVolume

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\SoundSystem\MusicManager_experimental.sqf at line 59](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L59)
## mm_channels_internal_initStruct

Type: function

Description: 


File: [client\SoundSystem\MusicManager_experimental.sqf at line 47](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L47)
## mm_init

Type: function

Description: 


File: [client\SoundSystem\MusicManager_experimental.sqf at line 61](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L61)
## mm_internal_thread_onUpdate

Type: function

Description: 


File: [client\SoundSystem\MusicManager_experimental.sqf at line 70](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L70)
## mm_channel_register

Type: function

Description: 
- Param: _id

File: [client\SoundSystem\MusicManager_experimental.sqf at line 75](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L75)
## mm_layer_unregister

Type: function

Description: 
- Param: _channel

File: [client\SoundSystem\MusicManager_experimental.sqf at line 85](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L85)
## mm_setChannelPlaying

Type: function

Description: 
- Param: _mode
- Param: _channel (optional, default mm_currentChannel)

File: [client\SoundSystem\MusicManager_experimental.sqf at line 98](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L98)
## mm_setChannelVolume

Type: function

Description: 
- Param: _vol
- Param: _channel (optional, default mm_currentChannel)

File: [client\SoundSystem\MusicManager_experimental.sqf at line 102](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L102)
## mm_getChannelVolume

Type: function

Description: 
- Param: _ch (optional, default mm_currentChannel)

File: [client\SoundSystem\MusicManager_experimental.sqf at line 106](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L106)
## mm_internal_play

Type: function

Description: 
- Param: _id (optional, default mm_currentChannel)
- Param: _config
- Param: _startTime (optional, default 0)
- Param: _smoothStart (optional, default 0)
- Param: _isLooped (optional, default false)

File: [client\SoundSystem\MusicManager_experimental.sqf at line 110](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L110)
## mm_getPlayedTime

Type: function

Description: 
- Param: _layer (optional, default mm_currentChannel)

File: [client\SoundSystem\MusicManager_experimental.sqf at line 116](../../../Src/client/SoundSystem/MusicManager_experimental.sqf#L116)
# Sound3d.sqf

## sound3d_internal_list_soundBuff

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\SoundSystem\Sound3d.sqf at line 166](../../../Src/client/SoundSystem/Sound3d.sqf#L166)
## soundProcessor_play

Type: function

Description: Рантайм вычисление процессор громкости звука


File: [client\SoundSystem\Sound3d.sqf at line 19](../../../Src/client/SoundSystem/Sound3d.sqf#L19)
## sound3d_playOnObject

Type: function

Description: функция локальна
- Param: _source
- Param: _class
- Param: _dist
- Param: _pitch (optional, default 1)
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 41](../../../Src/client/SoundSystem/Sound3d.sqf#L41)
## sound3d_playOnObjectLooped

Type: function

Description: функция локальна
- Param: _additionalObjects
- Param: _3dSoundData
- Param: _soundDuration (optional, default -1)

File: [client\SoundSystem\Sound3d.sqf at line 69](../../../Src/client/SoundSystem/Sound3d.sqf#L69)
## sound_selfPlay

Type: function

Description: Проигрывает локальный звук
- Param: _path
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 104](../../../Src/client/SoundSystem/Sound3d.sqf#L104)
## sound3d_playLocal

Type: function

Description: from say3D [sound, maxDistance, pitch, isSpeech, offset]
- Param: _obj
- Param: _clsSound
- Param: _pitch (optional, default 1)
- Param: _distance (optional, default 10)
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 113](../../../Src/client/SoundSystem/Sound3d.sqf#L113)
## sound3d_playLocalOnObjectLooped

Type: function

Description: 
- Param: _file
- Param: _src
- Param: _pitch (optional, default 1)
- Param: _dist (optional, default 10)
- Param: _offset (optional, default 0)
- Param: _preendbuf (optional, default 0)
- Param: _vol (optional, default 1)

File: [client\SoundSystem\Sound3d.sqf at line 125](../../../Src/client/SoundSystem/Sound3d.sqf#L125)
## sound3d_stopLocalLopped

Type: function

Description: 
- Param: _soundPtr

File: [client\SoundSystem\Sound3d.sqf at line 147](../../../Src/client/SoundSystem/Sound3d.sqf#L147)
## sound3d_internal_localHandler

Type: function

Description: 
- Param: _src
- Param: _sid
- Param: _preend
- Param: _psParams

File: [client\SoundSystem\Sound3d.sqf at line 167](../../../Src/client/SoundSystem/Sound3d.sqf#L167)
