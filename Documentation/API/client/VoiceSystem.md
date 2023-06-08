# engine.h

## ENABLE_LINE_IN_FILES

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\engine.h at line 8](../../../Src/client/VoiceSystem/engine.h#L8)
## __pragma_preprocess

Type: constant

> Exists if **ENABLE_LINE_IN_FILES** defined

Description: 


Replaced value:
```sqf
preprocessFileLineNumbers
```
File: [client\VoiceSystem\engine.h at line 11](../../../Src/client/VoiceSystem/engine.h#L11)
## __pragma_preprocess

Type: constant

> Exists if **ENABLE_LINE_IN_FILES** not defined

Description: 


Replaced value:
```sqf
preprocessFile
```
File: [client\VoiceSystem\engine.h at line 13](../../../Src/client/VoiceSystem/engine.h#L13)
## __pragma_prep_cli

Type: constant

Description: 


Replaced value:
```sqf
preprocessFile
```
File: [client\VoiceSystem\engine.h at line 16](../../../Src/client/VoiceSystem/engine.h#L16)
## arg

Type: constant

Description: logger


Replaced value:
```sqf
,
```
File: [client\VoiceSystem\engine.h at line 19](../../../Src/client/VoiceSystem/engine.h#L19)
## conDllCall

Type: constant

Description: 


Replaced value:
```sqf
"debug_console" callExtension
```
File: [client\VoiceSystem\engine.h at line 21](../../../Src/client/VoiceSystem/engine.h#L21)
## log(message)

Type: constant

Description: 
- Param: message

Replaced value:
```sqf
"debug_console" callExtension (message + "#1111")
```
File: [client\VoiceSystem\engine.h at line 23](../../../Src/client/VoiceSystem/engine.h#L23)
## logformat(provider,formatText)

Type: constant

Description: 
- Param: provider
- Param: formatText

Replaced value:
```sqf
"debug_console" callExtension (format[provider + "#1111",formatText])
```
File: [client\VoiceSystem\engine.h at line 24](../../../Src/client/VoiceSystem/engine.h#L24)
## warning(message)

Type: constant

Description: 
- Param: message

Replaced value:
```sqf
"debug_console" callExtension ("WARN: " + message + "#1101"); [message] call discWarning
```
File: [client\VoiceSystem\engine.h at line 26](../../../Src/client/VoiceSystem/engine.h#L26)
## error(message)

Type: constant

Description: 
- Param: message

Replaced value:
```sqf
"debug_console" callExtension ("ERROR: " + message + "#1001"); [message] call discError
```
File: [client\VoiceSystem\engine.h at line 27](../../../Src/client/VoiceSystem/engine.h#L27)
## warningformat(message,fmt)

Type: constant

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension (format ["WARN: " + message + "#1101",fmt]); [format[message,fmt]] call discWarning
```
File: [client\VoiceSystem\engine.h at line 29](../../../Src/client/VoiceSystem/engine.h#L29)
## errorformat(message,fmt)

Type: constant

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension (format ["ERROR: " + message  + "#1001",fmt]); [format[message,fmt]] call discError
```
File: [client\VoiceSystem\engine.h at line 30](../../../Src/client/VoiceSystem/engine.h#L30)
## trace(message)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: 
- Param: message

Replaced value:
```sqf

```
File: [client\VoiceSystem\engine.h at line 34](../../../Src/client/VoiceSystem/engine.h#L34)
## traceformat(message,fmt)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension (format ["TRACE: " + message + "#1011",fmt]);
```
File: [client\VoiceSystem\engine.h at line 34](../../../Src/client/VoiceSystem/engine.h#L34)
## traceformat(message,fmt)

Type: constant

> Exists if **__TRACE__ENABLED** not defined

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf

```
File: [client\VoiceSystem\engine.h at line 37](../../../Src/client/VoiceSystem/engine.h#L37)
# script.h

## SHIFTL

Type: constant

Description: 


Replaced value:
```sqf
42
```
File: [client\VoiceSystem\script.h at line 6](../../../Src/client/VoiceSystem/script.h#L6)
## CTRLL

Type: constant

Description: 


Replaced value:
```sqf
29
```
File: [client\VoiceSystem\script.h at line 7](../../../Src/client/VoiceSystem/script.h#L7)
## ALTL

Type: constant

Description: 


Replaced value:
```sqf
56
```
File: [client\VoiceSystem\script.h at line 8](../../../Src/client/VoiceSystem/script.h#L8)
## ACTIVE_CHANNEL_OFFSET

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\VoiceSystem\script.h at line 9](../../../Src/client/VoiceSystem/script.h#L9)
## VOLUME_OFFSET

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\script.h at line 10](../../../Src/client/VoiceSystem/script.h#L10)
## RADIO_OWNER

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\VoiceSystem\script.h at line 11](../../../Src/client/VoiceSystem/script.h#L11)
# VoiceSystem_Control.sqf

## voice_changer_border_size_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 18](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L18)
## voice_changer_border_size_y

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 19](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L19)
## voice_changer_size_h

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 22](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L22)
## voice_changer_size_w

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 23](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L23)
## voice_changer_bias_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 25](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L25)
## voice_changer_bias_y

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 26](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L26)
## vec4(a,b,c,d)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
[a,b,c,d]
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 28](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L28)
## vs_getWidgetText

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 0)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 32](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L32)
## vs_getWidgetProgress

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 1)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 33](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L33)
## vs_getWidgetGroup

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 3)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 34](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L34)
## vs_voiceDelayFadein

Type: constant

Description: время после которого тухнет диспл


Replaced value:
```sqf
4
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 37](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L37)
## vs_voiceAmountFade

Type: constant

Description: сколько за кадр будет тухнуть хуйня


Replaced value:
```sqf
0.025
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 40](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L40)
## vs_voiceVolumeWidgets

Type: Variable

Description: _bg3 ctrlEnable true;


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 30](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L30)
## vs_curVoiceMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 42](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L42)
## vs_canFadeVoiceVolumeWidget

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 44](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L44)
## vs_voiceVolume_lastUpdate

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 46](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L46)
## vs_voiceVolumeList

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 48](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L48)
## vs_getMaxVolume

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 56](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L56)
## vs_changeVoiceVolume

Type: function

Description: Изменяет громкость разговора
- Param: _mode

File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 61](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L61)
## vs_voiceVolumeOnUpdate

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 88](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L88)
## vs_initChangeVoiceCtrl

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 111](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L111)
# VoiceSystem_HandleTangent.sqf

## vs_tangentSetMode

Type: function

Description: Обработка тангенты
- Param: _obj
- Param: _mode

File: [client\VoiceSystem\VoiceSystem_HandleTangent.sqf at line 10](../../../Src/client/VoiceSystem/VoiceSystem_HandleTangent.sqf#L10)
# VoiceSystem_init.sqf

## VOICE_DISABLE_LEGACYCODE

Type: constant

Description: Включенный флаг отключает компиляцию старых функций


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 11](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L11)
## VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION

Type: constant

Description: Новый алгоритм затухания звука


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 14](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L14)
# VoiceSystem_keysConstant.sqf

## TF_tangent_sw_scancode

Type: Variable

Description: 


Initial value:
```sqf
58
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 6](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L6)
## TF_tangent_sw_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false,false,false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 7](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L7)
## TF_tangent_sw_2_scancode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 9](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L9)
## TF_tangent_sw_2_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false,false,false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 10](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L10)
## TF_tangent_additional_sw_scancode

Type: Variable

Description: 


Initial value:
```sqf
20
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 12](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L12)
## TF_tangent_additional_sw_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false,false,false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 13](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L13)
## TF_dialog_sw_scancode

Type: Variable

Description: 


Initial value:
```sqf
25
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 15](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L15)
## TF_dialog_sw_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 16](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L16)
## TF_sw_cycle_next_scancode

Type: Variable

Description: 


Initial value:
```sqf
27
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 18](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L18)
## TF_sw_cycle_next_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 19](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L19)
## TF_sw_cycle_prev_scancode

Type: Variable

Description: 


Initial value:
```sqf
26
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 21](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L21)
## TF_sw_cycle_prev_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 22](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L22)
## TF_sw_stereo_both_scancode

Type: Variable

Description: 


Initial value:
```sqf
200
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 24](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L24)
## TF_sw_stereo_both_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 25](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L25)
## TF_sw_stereo_left_scancode

Type: Variable

Description: 


Initial value:
```sqf
203
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 27](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L27)
## TF_sw_stereo_left_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 28](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L28)
## TF_sw_stereo_right_scancode

Type: Variable

Description: 


Initial value:
```sqf
205
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 30](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L30)
## TF_sw_stereo_right_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 31](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L31)
## TF_sw_channel_1_scancode

Type: Variable

Description: 


Initial value:
```sqf
79
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 33](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L33)
## TF_sw_channel_1_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 34](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L34)
## TF_sw_channel_2_scancode

Type: Variable

Description: 


Initial value:
```sqf
80
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 36](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L36)
## TF_sw_channel_2_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 37](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L37)
## TF_sw_channel_3_scancode

Type: Variable

Description: 


Initial value:
```sqf
81
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 39](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L39)
## TF_sw_channel_3_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 40](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L40)
## TF_sw_channel_4_scancode

Type: Variable

Description: 


Initial value:
```sqf
75
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 42](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L42)
## TF_sw_channel_4_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 43](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L43)
## TF_sw_channel_5_scancode

Type: Variable

Description: 


Initial value:
```sqf
76
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 45](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L45)
## TF_sw_channel_5_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 46](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L46)
## TF_sw_channel_6_scancode

Type: Variable

Description: 


Initial value:
```sqf
77
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 48](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L48)
## TF_sw_channel_6_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 49](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L49)
## TF_sw_channel_7_scancode

Type: Variable

Description: 


Initial value:
```sqf
71
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 51](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L51)
## TF_sw_channel_7_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 52](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L52)
## TF_sw_channel_8_scancode

Type: Variable

Description: 


Initial value:
```sqf
72
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 54](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L54)
## TF_sw_channel_8_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 55](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L55)
## TF_tangent_lr_scancode

Type: Variable

Description: 


Initial value:
```sqf
58
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 57](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L57)
## TF_tangent_lr_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 58](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L58)
## TF_tangent_lr_2_scancode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 60](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L60)
## TF_tangent_lr_2_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 61](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L61)
## TF_tangent_additional_lr_scancode

Type: Variable

Description: 


Initial value:
```sqf
21
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 63](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L63)
## TF_tangent_additional_lr_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 64](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L64)
## TF_dialog_lr_scancode

Type: Variable

Description: 


Initial value:
```sqf
25
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 66](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L66)
## TF_dialog_lr_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 67](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L67)
## TF_lr_cycle_next_scancode

Type: Variable

Description: 


Initial value:
```sqf
27
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 69](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L69)
## TF_lr_cycle_next_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 70](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L70)
## TF_lr_cycle_prev_scancode

Type: Variable

Description: 


Initial value:
```sqf
26
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 72](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L72)
## TF_lr_cycle_prev_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 73](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L73)
## TF_lr_stereo_both_scancode

Type: Variable

Description: 


Initial value:
```sqf
200
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 75](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L75)
## TF_lr_stereo_both_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 76](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L76)
## TF_lr_stereo_left_scancode

Type: Variable

Description: 


Initial value:
```sqf
203
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 78](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L78)
## TF_lr_stereo_left_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 79](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L79)
## TF_lr_stereo_right_scancode

Type: Variable

Description: 


Initial value:
```sqf
205
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 81](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L81)
## TF_lr_stereo_right_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, true]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 82](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L82)
## TF_lr_channel_1_scancode

Type: Variable

Description: 


Initial value:
```sqf
79
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 84](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L84)
## TF_lr_channel_1_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 85](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L85)
## TF_lr_channel_2_scancode

Type: Variable

Description: 


Initial value:
```sqf
80
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 87](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L87)
## TF_lr_channel_2_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 88](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L88)
## TF_lr_channel_3_scancode

Type: Variable

Description: 


Initial value:
```sqf
81
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 90](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L90)
## TF_lr_channel_3_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 91](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L91)
## TF_lr_channel_4_scancode

Type: Variable

Description: 


Initial value:
```sqf
75
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 93](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L93)
## TF_lr_channel_4_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 94](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L94)
## TF_lr_channel_5_scancode

Type: Variable

Description: 


Initial value:
```sqf
76
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 96](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L96)
## TF_lr_channel_5_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 97](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L97)
## TF_lr_channel_6_scancode

Type: Variable

Description: 


Initial value:
```sqf
77
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 99](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L99)
## TF_lr_channel_6_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 100](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L100)
## TF_lr_channel_7_scancode

Type: Variable

Description: 


Initial value:
```sqf
71
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 102](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L102)
## TF_lr_channel_7_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 103](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L103)
## TF_lr_channel_8_scancode

Type: Variable

Description: 


Initial value:
```sqf
72
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 105](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L105)
## TF_lr_channel_8_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 106](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L106)
## TF_lr_channel_9_scancode

Type: Variable

Description: 


Initial value:
```sqf
73
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 108](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L108)
## TF_lr_channel_9_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 109](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L109)
## TF_tangent_dd_scancode

Type: Variable

Description: 


Initial value:
```sqf
41
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 112](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L112)
## TF_tangent_dd_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 113](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L113)
## TF_tangent_dd_2_scancode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 115](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L115)
## TF_tangent_dd_2_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 116](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L116)
## TF_dialog_dd_scancode

Type: Variable

Description: 


Initial value:
```sqf
25
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 118](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L118)
## TF_dialog_dd_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[true, false, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 119](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L119)
## TF_speak_volume_scancode

Type: Variable

Description: 


Initial value:
```sqf
15
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 121](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L121)
## TF_speak_volume_modifiers

Type: Variable

Description: 


Initial value:
```sqf
[false, true, false]
```
File: [client\VoiceSystem\VoiceSystem_keysConstant.sqf at line 122](../../../Src/client/VoiceSystem/VoiceSystem_keysConstant.sqf#L122)
# VoiceSystem_part2.sqf

## TFAR_fnc_setActiveLrRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 8](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L8)
## TFAR_fnc_setActiveSwRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 38](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L38)
## TFAR_fnc_setAdditionalLrChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 63](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L63)
## TFAR_fnc_setAdditionalLrStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 101](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L101)
## TFAR_fnc_setAdditionalSwChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 136](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L136)
## TFAR_fnc_setAdditionalSwStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 172](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L172)
## TFAR_fnc_setChannelFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 204](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L204)
## TFAR_fnc_setChannelViaDialog

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 253](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L253)
## TFAR_fnc_setLongRangeRadioFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 318](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L318)
## TFAR_fnc_setLrChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 342](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L342)
## TFAR_fnc_setLrFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 376](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L376)
## TFAR_fnc_setLrRadioCode

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 404](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L404)
## TFAR_fnc_setLrSettings

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 433](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L433)
## TFAR_fnc_setLrSpeakers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 463](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L463)
## TFAR_fnc_setLrStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 508](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L508)
## TFAR_fnc_setLrVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 546](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L546)
## TFAR_fnc_setPersonalRadioFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 580](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L580)
## TFAR_fnc_setRadioOwner

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 604](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L604)
## TFAR_fnc_setSwChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 642](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L642)
## TFAR_fnc_setSwFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 674](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L674)
## TFAR_fnc_setSwRadioCode

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 702](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L702)
## TFAR_fnc_setSwSettings

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 730](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L730)
## TFAR_fnc_setSwSpeakers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 768](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L768)
## TFAR_fnc_setSwStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 808](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L808)
## TFAR_fnc_setSwVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 844](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L844)
## TFAR_fnc_setVoiceVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 876](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L876)
## TFAR_fnc_setVolumeViaDialog

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 903](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L903)
## TFAR_fnc_ShowHint

Type: function

Description: VOICE_DISABLE_LEGACYCODE


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 956](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L956)
## TFAR_fnc_ShowRadioInfo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1002](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1002)
## TFAR_fnc_showRadioSpeakers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1053](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1053)
## TFAR_fnc_ShowRadioVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1101](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1101)
## TFAR_fnc_swRadioMenu

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1157](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1157)
## TFAR_fnc_swRadioSubMenu

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1217](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1217)
## TFAR_fnc_TaskForceArrowheadRadioInit

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1250](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1250)
## TFAR_fnc_unableToUseHint

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1286](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1286)
## TFAR_fnc_updateDDDialog

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1290](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1290)
## TFAR_fnc_updateLRDialogToChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1318](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1318)
## TFAR_fnc_updateProgrammatorDialog

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1358](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1358)
## TFAR_fnc_updateSWDialogToChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1368](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1368)
## TFAR_fnc_vehicleId

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1408](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1408)
## TFAR_fnc_vehicleLr

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1443](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1443)
## TFAR_fnc_vehicleIsIsolatedAndInside

Type: function

Description: VOICE_DISABLE_LEGACYCODE


File: [client\VoiceSystem\VoiceSystem_part2.sqf at line 1486](../../../Src/client/VoiceSystem/VoiceSystem_part2.sqf#L1486)
# VoiceSystem_publicInterface.sqf

## VOICE_DISABLE_IN_SINGLEPLAYERMODE

Type: constant

Description: при включенном режиме не будет запускать войс в СП-моде


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 15](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L15)
## VOICE_DEBUG

Type: constant

Description: режим отладки войс системы (для возможности изменения переменных кода)


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 18](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L18)
## VS_ERROR_CONNECTION_TIMEOUT

Type: constant

Description: таймаут до кика


Replaced value:
```sqf
30
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 21](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L21)
## VS_ERROR_NOTINGAMECHANNEL_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 22](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L22)
## VS_INTERCOM_MAXDISTANCE_TRANSMITH

Type: constant

Description: 


Replaced value:
```sqf
1.25
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 24](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L24)
## itermes(me,data)

Type: constant

Description: 
- Param: me
- Param: data

Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 724](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L724)
## getRadioVar(obj,var)

Type: constant

Description: 
- Param: obj
- Param: var

Replaced value:
```sqf
(obj getvariable '__radio_##var')
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 926](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L926)
## vs_init

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 30](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L30)
## vs_sendVersionInfo

Type: function

Description: Sends information about the current TFAR version.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 165](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L165)
## vs_isPluginEnabled

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 171](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L171)
## vs_getCurrentTSChannel

Type: function

Description: Получает строковое название канала


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 176](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L176)
## vs_isIngameTSChannel

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 180](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L180)
## vs_getCurrentTSServer

Type: function

Description: получает строковое название сервера


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 185](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L185)
## vs_isSpeaking

Type: function

Description: Говорит ли юнит в данный момент


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 190](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L190)
## vs_onProcessPlayerPosition

Type: function

Description: Process some player positions on each call and sends it to the plugin.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 195](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L195)
## vs_startHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 323](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L323)
## vs_stopHandleProcessPlayerPos

Type: function

Description: останавливает процессинг


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 333](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L333)
## vs_sendFrequencyInfo

Type: function

Description: отсылает частоты раций у игрока в плагин


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 341](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L341)
## vs_calculateInteraction

Type: function

Description: 
- Param: _curVoice
- Param: _unit

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 441](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L441)
## vs_processSpeakerRadios

Type: function

Description: Обрабатывает все радио спикерные


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 446](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L446)
## vs_sendPlayerInfo

Type: function

Description: Notifies the plugin about a player


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 541](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L541)
## vs_preparePositionCoordinates

Type: function

Description: Prepares the position coordinates of the passed unit.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 604](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L604)
## vs_processSpeakingLangs

Type: function

Description: Калькулирует понимание речи персонажа
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 688](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L688)
## vs_calcVoiceIntersection

Type: function

Description: Просчитывает гашение звука от препятствий
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 716](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L716)
## vs_internal_getObjBBXData

Type: function

Description: возвращает высоту объекта и площадь
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 835](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L835)
## vs_debug_voiceIntersection

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _unit
- Param: _posesASL

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 849](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L849)
## vs_getNearInGameMobs

Type: function

Description: Получает ближайших мобов


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 870](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L870)
## vs_releaseAllTangents

Type: function

Description: вырубает локальному плееру все рации


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 920](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L920)
# VoiceSystem_Transmith.sqf

## VS_TRANSMITHINFO_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
[objNUll,["","",""]]
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 64](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L64)
## vs_tangent_pressed

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 9](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L9)
## vs_transmithDistance

Type: Variable

Description: 


Initial value:
```sqf
1000
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 11](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L11)
## vs_startTransmith

Type: function

Description: запускает потоковую передачу
- Param: _freqAndCode
- Param: _dist (optional, default vs_transmithDistance)
- Param: _curT (optional, default "digital")

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 17](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L17)
## vs_stopTransmith

Type: function

Description: останавливает потоковую передачу
- Param: _freqAndCode
- Param: _dist (optional, default vs_transmithDistance)
- Param: _curT (optional, default "digital")

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 43](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L43)
## vs_doStopTransmith

Type: function

Description: Логика остановки передачи в радио


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 69](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L69)
## vs_handleTransmith

Type: function

Description: запускаем передачу
- Param: _mode

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 79](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L79)
## vs_canUseIntercomObject

Type: function

Description: 
- Param: _obj
- Param: _pos

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 124](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L124)
## vs_handleProcessedTransmith

Type: function

Description: Обработчик цикла
- Param: _obj
- Param: _tData

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 130](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L130)
## vs_addProcessingRadio

Type: function

Description: В параметрах надо указать частоту и громкость передачи
- Param: _obj
- Param: _rParams

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 146](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L146)
## vs_removeProcessingRadio

Type: function

Description: Убирает процессироуемое радио
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 171](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L171)
## vs_clearProcessingRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 189](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L189)
## vs_onProcessingRadios

Type: function

Description: Получает все радио игрока


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 192](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L192)
# VoiceSystem_uncategorized.sqf

## TFAR_fnc_activeLrRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 7](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L7)
## TFAR_fnc_activeSwRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 49](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L49)
## TFAR_fnc_addEventHandler

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 77](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L77)
## TFAR_fnc_backpackLr

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 128](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L128)
## TFAR_fnc_calcTerrainInterception

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 156](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L156)
## TFAR_fnc_canSpeak

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 203](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L203)
## TFAR_fnc_canUseDDRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 235](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L235)
## TFAR_fnc_canUseLRRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 263](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L263)
## TFAR_fnc_canUseSWRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 305](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L305)
## TFAR_fnc_ClientInit

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 345](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L345)
## TFAR_fnc_copyRadioSettingMenu

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 730](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L730)
## TFAR_fnc_CopySettings

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 778](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L778)
## TFAR_fnc_currentDirection

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 833](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L833)
## TFAR_fnc_currentLRFrequency

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 877](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L877)
## TFAR_fnc_currentSWFrequency

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 881](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L881)
## TFAR_fnc_currentUnit

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 885](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L885)
## TFAR_fnc_defaultPositionCoordinates

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 909](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L909)
## TFAR_fnc_eyeDepth

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 958](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L958)
## TFAR_fnc_fireEventHandlers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 963](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L963)
## TFAR_fnc_forceSpectator

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1002](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1002)
## TFAR_fnc_getAdditionalLrChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1033](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1033)
## TFAR_fnc_getAdditionalLrStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1060](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1060)
## TFAR_fnc_getAdditionalSwChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1091](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1091)
## TFAR_fnc_getAdditionalSwStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1116](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1116)
## TFAR_fnc_getChannelFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1145](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1145)
## TFAR_fnc_getConfigProperty

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1186](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1186)
## TFAR_fnc_getCurrentLrStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1239](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1239)
## TFAR_fnc_getCurrentSwStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1271](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1271)
## TFAR_fnc_getDefaultRadioClasses

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1301](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1301)
## TFAR_tryResolveFactionClass

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line -1](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L-1)
## TFAR_fnc_getLrChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1352](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1352)
## TFAR_fnc_getLrFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1379](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1379)
## TFAR_fnc_getLrRadioCode

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1405](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1405)
## TFAR_fnc_getLrRadioProperty

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1428](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1428)
## TFAR_fnc_getLrSettings

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1500](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1500)
## TFAR_fnc_getLrSpeakers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1599](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1599)
## TFAR_fnc_getLrStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1630](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1630)
## TFAR_fnc_getLrVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1661](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1661)
## TFAR_fnc_getNearPlayers

Type: function

Description: VOICE_DISABLE_LEGACYCODE


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1691](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1691)
## TFAR_fnc_getRadioOwner

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1733](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1733)
## TFAR_fnc_getSideRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1762](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1762)
## TFAR_fnc_getSwChannel

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1806](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1806)
## TFAR_fnc_getSwFrequency

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1831](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1831)
## TFAR_fnc_getSwRadioCode

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1855](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1855)
## TFAR_fnc_getSwSettings

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1878](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1878)
## TFAR_fnc_getSwSpeakers

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1946](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1946)
## TFAR_fnc_getSwStereo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 1975](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L1975)
## TFAR_fnc_getSwVolume

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2004](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2004)
## TFAR_fnc_getTransmittingDistanceMultiplicator

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2029](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2029)
## TFAR_fnc_getVehicleSide

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2056](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2056)
## TFAR_fnc_hasVehicleRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2096](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2096)
## TFAR_fnc_haveDDRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2124](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2124)
## TFAR_fnc_haveLRRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2154](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2154)
## TFAR_fnc_haveProgrammator

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2177](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2177)
## TFAR_fnc_haveSWRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2200](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2200)
## TFAR_fnc_HideHint

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2229](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2229)
## TFAR_fnc_initialiseBaseModule

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2251](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2251)
## TFAR_fnc_initialiseEnforceUsageModule

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2343](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2343)
## TFAR_fnc_initialiseFreqModule

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2382](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2382)
## TFAR_fnc_inWaterHint

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2444](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2444)
## TFAR_fnc_isAbleToUseRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2448](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2448)
## TFAR_fnc_isForcedCurator

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2457](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2457)
## TFAR_fnc_isRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2486](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2486)
## TFAR_fnc_isSameRadio

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2515](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2515)
## TFAR_fnc_isSpeaking

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2551](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2551)
## TFAR_fnc_isTeamSpeakPluginEnabled

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2575](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2575)
## TFAR_fnc_isTurnedOut

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2597](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2597)
## TFAR_fnc_isVehicleIsolated

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2703](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2703)
## TFAR_fnc_lrRadioMenu

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2729](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2729)
## TFAR_fnc_lrRadiosList

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2772](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2772)
## TFAR_fnc_lrRadioSubMenu

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2817](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2817)
## TFAR_fnc_objectInterception

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2830](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2830)
## KK_fnc_inString

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2834](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2834)
## TFAR_fnc_onAdditionalLRTangentPressed

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2876](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2876)
## TFAR_fnc_onAdditionalLRTangentReleased

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2903](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2903)
## TFAR_fnc_onAdditionalSwTangentPressed

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2923](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2923)
## TFAR_fnc_onAdditionalSwTangentReleased

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2953](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2953)
## TFAR_fnc_onDDDialogOpen

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2972](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2972)
## TFAR_fnc_onDDTangentPressed

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 2985](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L2985)
## TFAR_fnc_onDDTangentReleased

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3009](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3009)
## TFAR_fnc_onDDTangentReleasedHack

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3020](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3020)
## TFAR_fnc_onGroundHint

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3040](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3040)
## TFAR_fnc_onLRDialogOpen

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3044](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3044)
## TFAR_fnc_onLRTangentPressed

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3066](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3066)
## TFAR_fnc_onLRTangentReleased

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3095](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3095)
## TFAR_fnc_onLRTangentReleasedHack

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3113](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3113)
## TFAR_fnc_onSpeakVolumeChange

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3133](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3133)
## TFAR_fnc_onSwDialogOpen

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3160](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3160)
## TFAR_fnc_onSwTangentPressed

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3176](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3176)
## TFAR_fnc_onSwTangentPressedHack

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3205](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3205)
## TFAR_fnc_onSwTangentReleased

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3226](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3226)
## TFAR_fnc_onSwTangentReleasedHack

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3245](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3245)
## TFAR_fnc_preparePositionCoordinates

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3259](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3259)
## TFAR_fnc_processCuratorKey

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3338](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3338)
## TFAR_fnc_processLRChannelKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3366](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3366)
## TFAR_fnc_processLRCycleKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3402](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3402)
## TFAR_fnc_processLRStereoKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3464](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3464)
## TFAR_fnc_processPlayerPositions

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3498](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3498)
## TFAR_fnc_processRespawn

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3634](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3634)
## TFAR_fnc_processSpeakerRadios

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3701](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3701)
## TFAR_fnc_processSWChannelKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3787](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3787)
## TFAR_fnc_processSWCycleKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3823](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3823)
## TFAR_fnc_processSWStereoKeys

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3885](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3885)
## TFAR_fnc_ProcessTangent

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3919](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3919)
## TFAR_fnc_radioReplaceProcess

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 3957](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L3957)
## TFAR_fnc_radiosList

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4079](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4079)
## TFAR_fnc_radiosListSorted

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4116](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4116)
## TFAR_fnc_radioToRequestCount

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4137](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4137)
## TFAR_fnc_removeEventHandler

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4223](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4223)
## TFAR_fnc_requestRadios

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4264](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4264)
## TFAR_fnc_sendFrequencyInfo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4358](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4358)
## TFAR_fnc_sendPlayerInfo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4470](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4470)
## TFAR_fnc_sendPlayerKilled

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4529](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4529)
## TFAR_fnc_sendVersionInfo

Type: function

> Exists if **VOICE_DISABLE_LEGACYCODE** not defined

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4554](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4554)
## TFAR_fnc_sessionTracker

Type: function

Description: VOICE_DISABLE_LEGACYCODE


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4582](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4582)
## cvar

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 4610](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L4610)
# VoiceSystem_widgetEnums.h

## SW_EDIT

Type: constant

Description: 


Replaced value:
```sqf
1400
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 6](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L6)
## SW_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
1604
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 7](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L7)
## ID_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
12345
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 8](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L8)
## ID_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
123456
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 9](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L9)
## LR_EDIT

Type: constant

Description: 


Replaced value:
```sqf
1410
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 11](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L11)
## LR_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
1411
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 12](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L12)
## IDD_ANPRC152_RADIO_DIALOG

Type: constant

Description: --- anprc152_radio_dialog


Replaced value:
```sqf
1333
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 15](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L15)
## IDD_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
67676
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 16](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L16)
## IDC_ANPRC152_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 18](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L18)
## IDC_ANPRC152_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 19](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L19)
## IDC_ANPRC152_ENTER

Type: constant

Description: 


Replaced value:
```sqf
1600
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 20](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L20)
## IDC_ANPRC152_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
1601
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 21](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L21)
## IDC_ANPRC152_NEXT

Type: constant

Description: 


Replaced value:
```sqf
1602
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 22](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L22)
## IDC_ANPRC152_PREV

Type: constant

Description: 


Replaced value:
```sqf
1603
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 23](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L23)
## IDC_ANPRC152_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 24](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L24)
## IDC_ANPRC152_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
1605
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 25](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L25)
## IDC_ANPRC152_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
1606
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 26](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L26)
## IDC_ANPRC152_STEREO

Type: constant

Description: 


Replaced value:
```sqf
1607
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 27](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L27)
## IDC_ANPRC152_RADIO_DIALOG_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 28](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L28)
## IDC_ANPRC152_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 29](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L29)
## IDD_ANPRC148JEM_RADIO_DIALOG

Type: constant

Description: --- anprc148jem


Replaced value:
```sqf
6000
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 32](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L32)
## IDC_ANPRC148JEM_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 33](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L33)
## IDC_ANPRC148JEM_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 34](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L34)
## IDC_ANPRC148JEM_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 35](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L35)
## IDC_ANPRC148JEM_ENTER

Type: constant

Description: 


Replaced value:
```sqf
6468
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 36](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L36)
## IDC_ANPRC148JEM_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
6469
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 37](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L37)
## IDC_ANPRC148JEM_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
6470
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 38](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L38)
## IDC_ANPRC148JEM_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
6471
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 39](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L39)
## IDC_ANPRC148JEM_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
6472
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 40](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L40)
## IDC_ANPRC148JEM_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
6473
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 41](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L41)
## IDC_ANPRC148JEM_STEREO

Type: constant

Description: 


Replaced value:
```sqf
6474
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 42](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L42)
## IDC_ANPRC148JEM_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 43](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L43)
## IDC_ANPRC148JEM_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 44](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L44)
## IDD_FADAK_RADIO_DIALOG

Type: constant

Description: --- fadak


Replaced value:
```sqf
7777
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 47](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L47)
## IDC_FADAK_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 48](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L48)
## IDC_FADAK_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 49](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L49)
## IDC_FADAK_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 50](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L50)
## IDC_FADAK_ENTER_FADAK

Type: constant

Description: 


Replaced value:
```sqf
2616
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 51](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L51)
## IDC_FADAK_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
2617
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 52](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L52)
## IDC_FADAK_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
2618
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 53](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L53)
## IDC_FADAK_PREVIOUS_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
2619
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 54](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L54)
## IDC_FADAK_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
2620
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 55](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L55)
## IDC_FADAK_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
2621
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 56](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L56)
## IDC_FADAK_STEREO

Type: constant

Description: 


Replaced value:
```sqf
2622
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 57](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L57)
## IDC_FADAK_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 58](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L58)
## IDC_FADAK_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 59](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L59)
## IDD_RT1523G_RADIO_DIALOG

Type: constant

Description: --- rt1523g_radio_dialog


Replaced value:
```sqf
1666
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 64](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L64)
## IDC_RT1523G_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 65](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L65)
## IDC_RT1523G_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 66](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L66)
## IDC_RT1523G_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 67](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L67)
## IDC_RT1523G_ENTER

Type: constant

Description: 


Replaced value:
```sqf
1610
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 68](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L68)
## IDC_RT1523G_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
1611
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 69](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L69)
## IDC_RT1523G_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
1612
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 70](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L70)
## IDC_RT1523G_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
1613
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 71](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L71)
## IDC_RT1523G_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 85](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L85)
## IDC_RT1523G_CHANNEL_01

Type: constant

Description: 


Replaced value:
```sqf
1701
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 74](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L74)
## IDC_RT1523G_CHANNEL_02

Type: constant

Description: 


Replaced value:
```sqf
1702
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 75](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L75)
## IDC_RT1523G_CHANNEL_03

Type: constant

Description: 


Replaced value:
```sqf
1703
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 76](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L76)
## IDC_RT1523G_CHANNEL_04

Type: constant

Description: 


Replaced value:
```sqf
1704
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 77](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L77)
## IDC_RT1523G_CHANNEL_05

Type: constant

Description: 


Replaced value:
```sqf
1705
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 78](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L78)
## IDC_RT1523G_CHANNEL_06

Type: constant

Description: 


Replaced value:
```sqf
1706
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 79](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L79)
## IDC_RT1523G_CHANNEL_07

Type: constant

Description: 


Replaced value:
```sqf
1707
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 80](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L80)
## IDC_RT1523G_CHANNEL_08

Type: constant

Description: 


Replaced value:
```sqf
1708
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 81](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L81)
## IDC_RT1523G_CHANNEL_09

Type: constant

Description: 


Replaced value:
```sqf
1709
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 82](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L82)
## IDC_RT1523G_STEREO

Type: constant

Description: 


Replaced value:
```sqf
1710
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 83](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L83)
## IDC_RT1523G_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 84](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L84)
## IDD_MR3000_RADIO_DIALOG

Type: constant

Description: --- mr3000


Replaced value:
```sqf
1998
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 89](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L89)
## IDC_MR3000_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 90](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L90)
## IDC_MR3000_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 91](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L91)
## IDC_MR3000_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 92](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L92)
## IDC_MR3000_ENTER

Type: constant

Description: 


Replaced value:
```sqf
2392
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 93](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L93)
## IDC_MR3000_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
2393
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 94](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L94)
## IDC_MR3000_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
2394
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 95](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L95)
## IDC_MR3000_PREVIOUS_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
2395
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 96](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L96)
## IDC_MR3000_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
2396
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 97](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L97)
## IDC_MR3000_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
2397
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 98](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L98)
## IDC_MR3000_VOLUME_SWITCH

Type: constant

Description: 


Replaced value:
```sqf
2398
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 99](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L99)
## IDC_MR3000_CHANNEL_1

Type: constant

Description: 


Replaced value:
```sqf
2399
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 100](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L100)
## IDC_MR3000_CHANNEL_2

Type: constant

Description: 


Replaced value:
```sqf
2400
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 101](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L101)
## IDC_MR3000_CHANNEL_3

Type: constant

Description: 


Replaced value:
```sqf
2401
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 102](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L102)
## IDC_MR3000_CHANNEL_4

Type: constant

Description: 


Replaced value:
```sqf
2402
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 103](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L103)
## IDC_MR3000_CHANNEL_5

Type: constant

Description: 


Replaced value:
```sqf
2403
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 104](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L104)
## IDC_MR3000_CHANNEL_6

Type: constant

Description: 


Replaced value:
```sqf
2404
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 105](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L105)
## IDC_MR3000_CHANNEL_7

Type: constant

Description: 


Replaced value:
```sqf
2405
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 106](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L106)
## IDC_MR3000_CHANNEL_8

Type: constant

Description: 


Replaced value:
```sqf
2406
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 107](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L107)
## IDC_MR3000_CHANNEL_9

Type: constant

Description: 


Replaced value:
```sqf
2407
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 108](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L108)
## IDC_MR3000_STEREO

Type: constant

Description: 


Replaced value:
```sqf
2408
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 109](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L109)
## IDC_MR3000_CHANNEL_SWITCH

Type: constant

Description: 


Replaced value:
```sqf
2399
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 110](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L110)
## IDC_MR3000_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 111](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L111)
## IDC_MR3000_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 112](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L112)
## IDD_ANPRC155_RADIO_DIALOG

Type: constant

Description: --- anprc155


Replaced value:
```sqf
7666
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 115](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L115)
## IDC_ANPRC155_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 116](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L116)
## IDC_ANPRC155_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 117](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L117)
## IDC_ANPRC155_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 118](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L118)
## IDC_ANPRC155_ENTER

Type: constant

Description: 


Replaced value:
```sqf
3606
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 119](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L119)
## IDC_ANPRC155_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
3607
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 120](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L120)
## IDC_ANPRC155_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3608
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 121](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L121)
## IDC_ANPRC155_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3609
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 122](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L122)
## IDC_ANPRC155_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3610
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 123](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L123)
## IDC_ANPRC155_STEREO

Type: constant

Description: 


Replaced value:
```sqf
3611
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 124](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L124)
## IDC_ANPRC155_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 125](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L125)
## IDC_ANPRC155_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 126](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L126)
## IDD_DIVER_RADIO_DIALOG

Type: constant

Description: --- diver_radio


Replaced value:
```sqf
6900
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 130](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L130)
## IDC_DIVER_RADIO_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 132](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L132)
## IDC_DIVER_RADIO_ENTER

Type: constant

Description: 


Replaced value:
```sqf
7193
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 133](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L133)
## IDC_DIVER_RADIO_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
7194
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 134](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L134)
## IDC_DIVER_RADIO_EDIT

Type: constant

Description: 


Replaced value:
```sqf
7393
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 135](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L135)
## IDC_DIVER_RADIO_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
7394
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 136](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L136)
## IDC_DIVER_RADIO_DEPTH_EDIT

Type: constant

Description: 


Replaced value:
```sqf
7395
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 137](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L137)
## IDD_ANPRC210_RADIO_DIALOG

Type: constant

Description: --- anprc210


Replaced value:
```sqf
8423
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 140](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L140)
## IDC_ANPRC210_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 141](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L141)
## IDC_ANPRC210_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
1411
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 142](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L142)
## IDC_ANPRC210_EDIT

Type: constant

Description: 


Replaced value:
```sqf
1410
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 143](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L143)
## IDC_ANPRC210_ENTER

Type: constant

Description: 


Replaced value:
```sqf
3552
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 144](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L144)
## IDC_ANPRC210_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
3553
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 145](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L145)
## IDC_ANPRC210_CHANNEL_SWITCH

Type: constant

Description: 


Replaced value:
```sqf
3554
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 146](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L146)
## IDC_ANPRC210_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3556
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 147](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L147)
## IDC_ANPRC210_STEREO

Type: constant

Description: 


Replaced value:
```sqf
3557
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 148](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L148)
## IDC_ANPRC210_CHANNEL_01

Type: constant

Description: 


Replaced value:
```sqf
3558
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 149](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L149)
## IDC_ANPRC210_CHANNEL_02

Type: constant

Description: 


Replaced value:
```sqf
3559
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 150](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L150)
## IDC_ANPRC210_CHANNEL_03

Type: constant

Description: 


Replaced value:
```sqf
3560
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 151](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L151)
## IDC_ANPRC210_CHANNEL_04

Type: constant

Description: 


Replaced value:
```sqf
3561
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 152](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L152)
## IDC_ANPRC210_CHANNEL_05

Type: constant

Description: 


Replaced value:
```sqf
3562
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 153](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L153)
## IDC_ANPRC210_CHANNEL_06

Type: constant

Description: 


Replaced value:
```sqf
3563
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 154](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L154)
## IDC_ANPRC210_CHANNEL_07

Type: constant

Description: 


Replaced value:
```sqf
3564
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 155](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L155)
## IDC_ANPRC210_CHANNEL_08

Type: constant

Description: 


Replaced value:
```sqf
3565
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 156](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L156)
## IDC_ANPRC210_CHANNEL_09

Type: constant

Description: 


Replaced value:
```sqf
3566
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 157](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L157)
## IDC_ANPRC210_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 158](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L158)
## IDC_ANPRC210_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 159](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L159)
## IDD_MR6000L_RADIO_DIALOG

Type: constant

Description: --- mr6000l_radio_dialog


Replaced value:
```sqf
20135
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 163](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L163)
## IDC_MR6000L_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 164](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L164)
## IDC_MR6000L_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 165](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L165)
## IDC_MR6000L_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 166](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L166)
## IDC_MR6000L_ENTER

Type: constant

Description: 


Replaced value:
```sqf
20536
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 167](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L167)
## IDC_MR6000L_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
20537
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 168](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L168)
## IDC_MR6000L_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
20538
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 169](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L169)
## IDC_MR6000L_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
20539
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 170](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L170)
## IDC_MR6000L_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
20540
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 171](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L171)
## IDC_MR6000L_STEREO

Type: constant

Description: 


Replaced value:
```sqf
20541
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 172](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L172)
## IDC_MR6000L_CHANNEL_01

Type: constant

Description: 


Replaced value:
```sqf
20542
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 173](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L173)
## IDC_MR6000L_CHANNEL_02

Type: constant

Description: 


Replaced value:
```sqf
20543
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 174](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L174)
## IDC_MR6000L_CHANNEL_03

Type: constant

Description: 


Replaced value:
```sqf
20544
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 175](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L175)
## IDC_MR6000L_CHANNEL_04

Type: constant

Description: 


Replaced value:
```sqf
20545
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 176](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L176)
## IDC_MR6000L_CHANNEL_05

Type: constant

Description: 


Replaced value:
```sqf
20546
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 177](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L177)
## IDC_MR6000L_CHANNEL_06

Type: constant

Description: 


Replaced value:
```sqf
20547
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 178](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L178)
## IDC_MR6000L_CHANNEL_07

Type: constant

Description: 


Replaced value:
```sqf
20548
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 179](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L179)
## IDC_MR6000L_CHANNEL_08

Type: constant

Description: 


Replaced value:
```sqf
20549
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 180](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L180)
## IDC_MR6000L_CHANNEL_09

Type: constant

Description: 


Replaced value:
```sqf
20550
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 181](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L181)
## IDC_MR6000L_RADIO_DIALOG_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 182](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L182)
## IDC_MR6000L_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 183](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L183)
## IDD_ANARC164_RADIO_DIALOG

Type: constant

Description: --- anarc164


Replaced value:
```sqf
3174
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 187](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L187)
## IDC_ANARC164_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 188](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L188)
## IDC_ANARC164_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 189](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L189)
## IDC_ANARC164_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 190](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L190)
## IDC_ANARC164_ENTER

Type: constant

Description: 


Replaced value:
```sqf
3575
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 191](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L191)
## IDC_ANARC164_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
3576
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 192](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L192)
## IDC_ANARC164_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3577
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 193](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L193)
## IDC_ANARC164_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3578
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 194](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L194)
## IDC_ANARC164_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3579
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 195](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L195)
## IDC_ANARC164_STEREO

Type: constant

Description: 


Replaced value:
```sqf
3580
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 196](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L196)
## IDC_ANARC164_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 197](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L197)
## IDC_ANARC164_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 198](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L198)
## IDD_ANPRC154_RADIO_DIALOG

Type: constant

Description: --- anprc154


Replaced value:
```sqf
3198
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 201](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L201)
## IDC_ANPRC154_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 202](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L202)
## IDC_ANPRC154_RESET_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3599
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 203](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L203)
## IDC_ANPRC154_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3601
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 204](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L204)
## IDC_ANPRC154_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3602
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 205](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L205)
## IDC_ANPRC154_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3603
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 206](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L206)
## IDC_ANPRC154_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3604
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 207](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L207)
## IDC_ANPRC154_STEREO

Type: constant

Description: 


Replaced value:
```sqf
3605
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 208](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L208)
## IDC_ANPRC154_RESET_CHANNEL_ALT

Type: constant

Description: 


Replaced value:
```sqf
3706
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 209](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L209)
## IDC_ANPRC154_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 210](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L210)
## IDD_RF7800STR_RADIO_DIALOG

Type: constant

Description: --- rf7800str


Replaced value:
```sqf
4425
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 213](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L213)
## IDC_RF7800STR_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 214](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L214)
## IDC_RF7800STR_NEXT_CHANNEL_ALT

Type: constant

Description: 


Replaced value:
```sqf
4826
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 215](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L215)
## IDC_RF7800STR_PREV_CHANNEL_ALT

Type: constant

Description: 


Replaced value:
```sqf
4827
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 216](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L216)
## IDC_RF7800STR_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
4828
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 216](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L216)
## IDC_RF7800STR_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
4829
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 215](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L215)
## IDC_RF7800STR_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
4830
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 219](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L219)
## IDC_RF7800STR_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
4831
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 220](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L220)
## IDC_RF7800STR_STEREO

Type: constant

Description: 


Replaced value:
```sqf
4832
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 221](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L221)
## IDC_RF7800STR_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 222](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L222)
## IDC_PNR1000A_RADIO_DIALOG

Type: constant

Description: --- pnr1000a


Replaced value:
```sqf
3083
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 225](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L225)
## IDC_PNR1000A_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 226](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L226)
## IDC_PNR1000A_RESET_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3484
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 227](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L227)
## IDC_PNR1000A_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3486
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 228](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L228)
## IDC_PNR1000A_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
3487
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 229](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L229)
## IDC_PNR1000A_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3488
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 230](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L230)
## IDC_PNR1000A_DECREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
3489
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 231](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L231)
## IDC_PNR1000A_STEREO

Type: constant

Description: 


Replaced value:
```sqf
3490
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 232](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L232)
## IDC_PNR1000A_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 233](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L233)
## IDC_MICRODAGR_BACKGROUND

Type: constant

Description: -- microdagr


Replaced value:
```sqf
456547
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 236](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L236)
## IDC_MICRODAGR_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
123123
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 237](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L237)
## IDC_MICRODAGR_ENTER

Type: constant

Description: 


Replaced value:
```sqf
2344565
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 238](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L238)
## IDC_MICRODAGR_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 239](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L239)
## IDC_MICRODAGR_EDIT

Type: constant

Description: 


Replaced value:
```sqf
SW_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 240](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L240)
## IDD_BUSSOLE_RADIO_DIALOG

Type: constant

Description: --- bussole


Replaced value:
```sqf
8666
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 243](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L243)
## IDC_BUSSOLE_BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
IDD_BACKGROUND
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 244](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L244)
## IDC_BUSSOLE_CHANNEL_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_CHANNEL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 245](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L245)
## IDC_BUSSOLE_EDIT

Type: constant

Description: 


Replaced value:
```sqf
LR_EDIT
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 246](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L246)
## IDC_BUSSOLE_ENTER

Type: constant

Description: 


Replaced value:
```sqf
8667
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 247](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L247)
## IDC_BUSSOLE_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
8668
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 248](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L248)
## IDC_BUSSOLE_PREV_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
8669
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 249](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L249)
## IDC_BUSSOLE_NEXT_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
8670
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 250](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L250)
## IDC_BUSSOLE_INCREASE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
8671
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 251](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L251)
## IDC_BUSSOLE_STEREO

Type: constant

Description: 


Replaced value:
```sqf
8672
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 252](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L252)
## IDC_BUSSOLE_ADDITIONAL

Type: constant

Description: 


Replaced value:
```sqf
ID_ADDITIONAL
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 253](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L253)
## IDC_BUSSOLE_SPEAKERS

Type: constant

Description: 


Replaced value:
```sqf
ID_SPEAKERS
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 254](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L254)
## IDC_BUSSOLE_CHANNEL_01

Type: constant

Description: 


Replaced value:
```sqf
8673
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 255](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L255)
## IDC_BUSSOLE_CHANNEL_02

Type: constant

Description: 


Replaced value:
```sqf
8674
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 256](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L256)
## IDC_BUSSOLE_CHANNEL_03

Type: constant

Description: 


Replaced value:
```sqf
8675
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 257](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L257)
## IDC_BUSSOLE_CHANNEL_04

Type: constant

Description: 


Replaced value:
```sqf
8676
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 258](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L258)
## IDC_BUSSOLE_CHANNEL_05

Type: constant

Description: 


Replaced value:
```sqf
8677
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 259](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L259)
## IDC_BUSSOLE_CHANNEL_06

Type: constant

Description: 


Replaced value:
```sqf
8678
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 260](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L260)
## IDC_BUSSOLE_CHANNEL_07

Type: constant

Description: 


Replaced value:
```sqf
8679
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 261](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L261)
## IDC_BUSSOLE_CHANNEL_08

Type: constant

Description: 


Replaced value:
```sqf
8680
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 262](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L262)
## IDC_BUSSOLE_CHANNEL_09

Type: constant

Description: 


Replaced value:
```sqf
8681
```
File: [client\VoiceSystem\VoiceSystem_widgetEnums.h at line 263](../../../Src/client/VoiceSystem/VoiceSystem_widgetEnums.h#L263)
# VoiceSystem_WorldRadioComponent.sqf

## _eyePosAgl

Type: constant

Description: 


Replaced value:
```sqf
_ep
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 90](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L90)
## _currentVolume

Type: constant

Description: 


Replaced value:
```sqf
_cv
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 91](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L91)
## vs_allWorldRadios

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 8](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L8)
## vs_loadWorldRadio

Type: function

Description: Загружает в мир всю инфу о радио. Последний параметр указывает использовать ли радио как наушник
- Param: _obj
- Param: _radioData
- Param: _ptr
- Param: _isHeadpones (optional, default false)

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 10](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L10)
## vs_unloadWorldRadio

Type: function

Description: выгружает мировое радио
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 50](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L50)
## vs_isWorldRadioObject

Type: function

Description: Является ли объект земным радио


File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 86](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L86)
## vs_processWorldRadios

Type: function

Description: Обрабатывает мировые радио записывая их в tf_speakerRadios


File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 89](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L89)
## vs_calcSpeakerIntersection

Type: function

Description: Тушит громкость от пересечений
- Param: _obj
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 124](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L124)
