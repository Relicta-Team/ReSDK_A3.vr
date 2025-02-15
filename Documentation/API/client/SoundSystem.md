# Music.hpp

## MUSIC_SMOOTH_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 11](../../../Src/client/SoundSystem/Music.hpp#L11)
## MUSIC_SMOOTH_START

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 12](../../../Src/client/SoundSystem/Music.hpp#L12)
## MUSIC_SMOOTH_END

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 13](../../../Src/client/SoundSystem/Music.hpp#L13)
## MUSIC_SMOOTH_FULL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SoundSystem\Music.hpp at line 14](../../../Src/client/SoundSystem/Music.hpp#L14)
## MUSIC_REPEAT_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 18](../../../Src/client/SoundSystem/Music.hpp#L18)
## MUSIC_REPEAT_YES

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 19](../../../Src/client/SoundSystem/Music.hpp#L19)
## MUSIC_REPEAT_AND_BACKWARD

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 20](../../../Src/client/SoundSystem/Music.hpp#L20)
## MUSIC_SMOOTH_TIME_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\SoundSystem\Music.hpp at line 24](../../../Src/client/SoundSystem/Music.hpp#L24)
## MUSIC_CHANNEL_BASE

Type: constant

Description: системный. не используется


Replaced value:
```sqf
0
```
File: [client\SoundSystem\Music.hpp at line 28](../../../Src/client/SoundSystem/Music.hpp#L28)
## MUSIC_CHANNEL_LOBBY

Type: constant

Description: канал лобби


Replaced value:
```sqf
1
```
File: [client\SoundSystem\Music.hpp at line 30](../../../Src/client/SoundSystem/Music.hpp#L30)
## MUSIC_CHANNEL_AMBIENT

Type: constant

Description: эмбиент - основной


Replaced value:
```sqf
2
```
File: [client\SoundSystem\Music.hpp at line 32](../../../Src/client/SoundSystem/Music.hpp#L32)
## MUSIC_CHANNEL_AMBIENT_LOCAL

Type: constant

Description: эмбиент - локальный. вход в интересное место или подобное


Replaced value:
```sqf
3
```
File: [client\SoundSystem\Music.hpp at line 34](../../../Src/client/SoundSystem/Music.hpp#L34)
## MUSIC_CHANNEL_COMBATAMBIENT

Type: constant

Description: боевой эмбиент - пока не задействован


Replaced value:
```sqf
4
```
File: [client\SoundSystem\Music.hpp at line 36](../../../Src/client/SoundSystem/Music.hpp#L36)
## MUSIC_CHANNEL_EVENT_GLOBAL

Type: constant

Description: музыка конца раунда, или любого важного события


Replaced value:
```sqf
5
```
File: [client\SoundSystem\Music.hpp at line 38](../../../Src/client/SoundSystem/Music.hpp#L38)
## chm(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
[ a , b ]
```
File: [client\SoundSystem\Music.hpp at line 42](../../../Src/client/SoundSystem/Music.hpp#L42)
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
File: [client\SoundSystem\Music.hpp at line 44](../../../Src/client/SoundSystem/Music.hpp#L44)
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
File: [client\SoundSystem\Music.hpp at line 54](../../../Src/client/SoundSystem/Music.hpp#L54)
# Music.sqf

## BUFFER_PRIORITY_MAX

Type: constant

Description: 


Replaced value:
```sqf
32
```
File: [client\SoundSystem\Music.sqf at line 105](../../../Src/client/SoundSystem/Music.sqf#L105)
## MUSIC_DEBUG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 108](../../../Src/client/SoundSystem/Music.sqf#L108)
## mlog(text)

Type: constant

> Exists if **MUSIC_DEBUG** defined

Description: 
- Param: text

Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 118](../../../Src/client/SoundSystem/Music.sqf#L118)
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
File: [client\SoundSystem\Music.sqf at line 118](../../../Src/client/SoundSystem/Music.sqf#L118)
## mlogformat(text,args)

Type: constant

> Exists if **MUSIC_DEBUG** not defined

Description: 
- Param: text
- Param: args

Replaced value:
```sqf

```
File: [client\SoundSystem\Music.sqf at line 121](../../../Src/client/SoundSystem/Music.sqf#L121)
## music_internal_class2path

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 61](../../../Src/client/SoundSystem/Music.sqf#L61)
## music_internal_path2class

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 63](../../../Src/client/SoundSystem/Music.sqf#L63)
## music_internal_folderData

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 66](../../../Src/client/SoundSystem/Music.sqf#L66)
## music_internal_durationMap

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\SoundSystem\Music.sqf at line 69](../../../Src/client/SoundSystem/Music.sqf#L69)
## music_playedObject

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\SoundSystem\Music.sqf at line 73](../../../Src/client/SoundSystem/Music.sqf#L73)
## music_internal_priority

Type: Variable

Description: 


Initial value:
```sqf
_buffer apply ...
```
File: [client\SoundSystem\Music.sqf at line 134](../../../Src/client/SoundSystem/Music.sqf#L134)
## music_internal_paused

Type: Variable

Description: 


Initial value:
```sqf
_buffer apply ...
```
File: [client\SoundSystem\Music.sqf at line 135](../../../Src/client/SoundSystem/Music.sqf#L135)
## music_internal_lastPriority

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SoundSystem\Music.sqf at line 136](../../../Src/client/SoundSystem/Music.sqf#L136)
## music_internal_map_chanToEnum

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray MUSIC_MAP_INTERNAL_ALLCHANNELS
```
File: [client\SoundSystem\Music.sqf at line 262](../../../Src/client/SoundSystem/Music.sqf#L262)
## music_internal_handleOnUpdate

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(music_internal_onUpdate,0)
```
File: [client\SoundSystem\Music.sqf at line 469](../../../Src/client/SoundSystem/Music.sqf#L469)
## music_play

Type: function

Description: 
- Param: _file
- Param: _priority (optional, default 0)
- Param: _params (optional, default [])

File: [client\SoundSystem\Music.sqf at line 150](../../../Src/client/SoundSystem/Music.sqf#L150)
## music_internal_mproc

Type: function

Description: 


File: [client\SoundSystem\Music.sqf at line 265](../../../Src/client/SoundSystem/Music.sqf#L265)
## music_setPause

Type: function

Description: 
- Param: _chan
- Param: _mode
- Param: _smooth (optional, default false)

File: [client\SoundSystem\Music.sqf at line 319](../../../Src/client/SoundSystem/Music.sqf#L319)
## music_stop

Type: function

Description: 
- Param: _chan (optional, default -1)

File: [client\SoundSystem\Music.sqf at line 353](../../../Src/client/SoundSystem/Music.sqf#L353)
## music_internal_setFade

Type: function

Description: 
- Param: _fade
- Param: _time (optional, default -1)

File: [client\SoundSystem\Music.sqf at line 380](../../../Src/client/SoundSystem/Music.sqf#L380)
## music_internal_onUpdate

Type: function

Description: 


File: [client\SoundSystem\Music.sqf at line 386](../../../Src/client/SoundSystem/Music.sqf#L386)
# Sound3d.sqf

## sound3d_internal_list_soundBuff

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\SoundSystem\Sound3d.sqf at line 177](../../../Src/client/SoundSystem/Sound3d.sqf#L177)
## sound3d_internal_handle3dSounds

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(sound3d_internal_localHandler,0.1)
```
File: [client\SoundSystem\Sound3d.sqf at line 222](../../../Src/client/SoundSystem/Sound3d.sqf#L222)
## soundProcessor_play

Type: function

Description: 


File: [client\SoundSystem\Sound3d.sqf at line 21](../../../Src/client/SoundSystem/Sound3d.sqf#L21)
## sound3d_playOnObject

Type: function

Description: 
- Param: _source
- Param: _class
- Param: _dist
- Param: _pitch (optional, default 1)
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 44](../../../Src/client/SoundSystem/Sound3d.sqf#L44)
## sound3d_playOnObjectLooped

Type: function

Description: 
- Param: _additionalObjects
- Param: _3dSoundData
- Param: _soundDuration (optional, default -1)

File: [client\SoundSystem\Sound3d.sqf at line 73](../../../Src/client/SoundSystem/Sound3d.sqf#L73)
## sound_selfPlay

Type: function

Description: 
- Param: _path
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 110](../../../Src/client/SoundSystem/Sound3d.sqf#L110)
## sound3d_playLocal

Type: function

Description: 
- Param: _obj
- Param: _clsSound
- Param: _pitch (optional, default 1)
- Param: _distance (optional, default 10)
- Param: _offset (optional, default 0)

File: [client\SoundSystem\Sound3d.sqf at line 120](../../../Src/client/SoundSystem/Sound3d.sqf#L120)
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

File: [client\SoundSystem\Sound3d.sqf at line 133](../../../Src/client/SoundSystem/Sound3d.sqf#L133)
## sound3d_stopLocalLopped

Type: function

Description: 
- Param: _soundPtr

File: [client\SoundSystem\Sound3d.sqf at line 156](../../../Src/client/SoundSystem/Sound3d.sqf#L156)
## sound3d_internal_localHandler

Type: function

Description: 
- Param: _src
- Param: _sid
- Param: _preend
- Param: _psParams

File: [client\SoundSystem\Sound3d.sqf at line 180](../../../Src/client/SoundSystem/Sound3d.sqf#L180)
