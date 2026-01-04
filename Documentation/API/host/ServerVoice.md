# ReVoicer.hpp

## RADIO_TYPE_WALKIETALKIE

Type: constant

Description: 


Replaced value:
```sqf
"WalkieTalkie"
```
File: [host\ServerVoice\ReVoicer.hpp at line 6](../../../Src/host/ServerVoice/ReVoicer.hpp#L6)
## RADIO_TYPE_LOUDSPEAKER

Type: constant

Description: 


Replaced value:
```sqf
"Loudspeaker"
```
File: [host\ServerVoice\ReVoicer.hpp at line 7](../../../Src/host/ServerVoice/ReVoicer.hpp#L7)
## RADIO_TYPE_TELEPHONE

Type: constant

Description: 


Replaced value:
```sqf
"Telephone"
```
File: [host\ServerVoice\ReVoicer.hpp at line 8](../../../Src/host/ServerVoice/ReVoicer.hpp#L8)
## RADIO_TYPE_INTERCOM

Type: constant

Description: 


Replaced value:
```sqf
"Intercom"
```
File: [host\ServerVoice\ReVoicer.hpp at line 9](../../../Src/host/ServerVoice/ReVoicer.hpp#L9)
## RADIO_TYPE_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[RADIO_TYPE_WALKIETALKIE, RADIO_TYPE_LOUDSPEAKER, RADIO_TYPE_TELEPHONE, RADIO_TYPE_INTERCOM]
```
File: [host\ServerVoice\ReVoicer.hpp at line 11](../../../Src/host/ServerVoice/ReVoicer.hpp#L11)
## RADIO_TYPE_ENUM_TO_STRING(enumt)

Type: constant

Description: 
- Param: enumt

Replaced value:
```sqf
(RADIO_TYPE_LIST_ALL select (enumt))
```
File: [host\ServerVoice\ReVoicer.hpp at line 13](../../../Src/host/ServerVoice/ReVoicer.hpp#L13)
## RADIO_TYPE_STRING_TO_ENUM(stringt)

Type: constant

Description: 
- Param: stringt

Replaced value:
```sqf
(RADIO_TYPE_LIST_ALL find (stringt))
```
File: [host\ServerVoice\ReVoicer.hpp at line 14](../../../Src/host/ServerVoice/ReVoicer.hpp#L14)
# revoice_server.sqf

## vs_server_map_transferData

Type: Variable

Description: сюда заносятся отметки кто говорит и на какой частоте


Initial value:
```sqf
createHashMap
```
File: [host\ServerVoice\revoice_server.sqf at line 12](../../../Src/host/ServerVoice/revoice_server.sqf#L12)
## vs_server_syncSpeakNetVar

Type: function

Description: синхронизирует сетевую переменную с клиентами


File: [host\ServerVoice\revoice_server.sqf at line 15](../../../Src/host/ServerVoice/revoice_server.sqf#L15)
## vs_server_onRadioSpeakStart

Type: function

Description: событие вызывается когда клиент начал говорить в частоту
- Param: _actor
- Param: _ptr

File: [host\ServerVoice\revoice_server.sqf at line 20](../../../Src/host/ServerVoice/revoice_server.sqf#L20)
## vs_server_onRadioSpeakStop

Type: function

Description: событие вызывается когда клиент закончил говорить в частоту
- Param: _actor
- Param: _ptr

File: [host\ServerVoice\revoice_server.sqf at line 38](../../../Src/host/ServerVoice/revoice_server.sqf#L38)
## vs_server_onClientDisconnected

Type: function

Description: 
- Param: _clientName

File: [host\ServerVoice\revoice_server.sqf at line 55](../../../Src/host/ServerVoice/revoice_server.sqf#L55)
# ServerVoice_init.sqf

## MAX_RADIO_COUNT

Type: constant

Description: 


Replaced value:
```sqf
1000
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 95](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L95)
## vsm_map_freqAndCode

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //карта ассоциаций кода и частоты
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 12](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L12)
## vsm_map_inverted

Type: Variable

Description: карта ассоциаций кода и частоты


Initial value:
```sqf
createHashMap //инвертированная карта
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 13](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L13)
## vsm_counter

Type: Variable

Description: инвертированная карта


Initial value:
```sqf
1 //для ассоциаций. является value в FCData и key в inverted. Не должно быть меньше нуля
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 14](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L14)
## vsm_registerFCData

Type: function

Description: регистрирует ид и возвращает его
- Param: _key

File: [host\ServerVoice\ServerVoice_init.sqf at line 17](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L17)
## vsm_packFreqData

Type: function

Description: Пакует значения частоты и кода
- Param: _freq
- Param: _code

File: [host\ServerVoice\ServerVoice_init.sqf at line 31](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L31)
## vsm_unpackFreqData

Type: function

Description: возвращает массив частоты и кода
- Param: _intval

File: [host\ServerVoice\ServerVoice_init.sqf at line 44](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L44)
## vsm_generateFrequencies

Type: function

Description: Генерирует частоту
- Param: _min
- Param: _max
- Param: _rounder (optional, default 0)

File: [host\ServerVoice\ServerVoice_init.sqf at line 62](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L62)
## vsm_Init

Type: function

Description: initialize voice manager


File: [host\ServerVoice\ServerVoice_init.sqf at line 71](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L71)
## TFAR_fnc_processGroupFrequencySettings

Type: function

Description: 


File: [host\ServerVoice\ServerVoice_init.sqf at line 181](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L181)
