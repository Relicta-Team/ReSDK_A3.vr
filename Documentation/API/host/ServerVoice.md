# ServerVoice_init.sqf

## MAX_RADIO_COUNT

Type: constant

Description: 


Replaced value:
```sqf
1000
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 91](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L91)
## vsm_map_freqAndCode

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //карта ассоциаций кода и частоты
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 8](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L8)
## vsm_map_inverted

Type: Variable

Description: карта ассоциаций кода и частоты


Initial value:
```sqf
createHashMap //инвертированная карта
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 9](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L9)
## vsm_counter

Type: Variable

Description: инвертированная карта


Initial value:
```sqf
1 //для ассоциаций. является value в FCData и key в inverted. Не должно быть меньше нуля
```
File: [host\ServerVoice\ServerVoice_init.sqf at line 10](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L10)
## vsm_registerFCData

Type: function

Description: регистрирует ид и возвращает его
- Param: _key

File: [host\ServerVoice\ServerVoice_init.sqf at line 13](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L13)
## vsm_packFreqData

Type: function

Description: Пакует значения частоты и кода
- Param: _freq
- Param: _code

File: [host\ServerVoice\ServerVoice_init.sqf at line 27](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L27)
## vsm_unpackFreqData

Type: function

Description: возвращает массив частоты и кода
- Param: _intval

File: [host\ServerVoice\ServerVoice_init.sqf at line 40](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L40)
## vsm_generateFrequencies

Type: function

Description: Генерирует частоту
- Param: _min
- Param: _max
- Param: _rounder (optional, default 0)

File: [host\ServerVoice\ServerVoice_init.sqf at line 58](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L58)
## vsm_Init

Type: function

Description: initialize voice manager


File: [host\ServerVoice\ServerVoice_init.sqf at line 67](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L67)
## TFAR_fnc_processGroupFrequencySettings

Type: function

Description: 


File: [host\ServerVoice\ServerVoice_init.sqf at line 177](../../../Src/host/ServerVoice/ServerVoice_init.sqf#L177)
