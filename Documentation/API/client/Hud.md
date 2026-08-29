# Hud_init.sqf

## HUD_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Hud\Hud_init.sqf at line 15](../../../Src/client/Hud/Hud_init.sqf#L15)
## STAT_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Hud\Hud_init.sqf at line 18](../../../Src/client/Hud/Hud_init.sqf#L18)
## canVisibleAttribute(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
(data != "")
```
File: [client\Hud\Hud_init.sqf at line 21](../../../Src/client/Hud/Hud_init.sqf#L21)
## getWidgetVar(_w,var)

Type: constant

Description: 
- Param: _w
- Param: var

Replaced value:
```sqf
(_w getvariable #var)
```
File: [client\Hud\Hud_init.sqf at line 24](../../../Src/client/Hud/Hud_init.sqf#L24)
## setWidgetVar(_w,var,val)

Type: constant

Description: 
- Param: _w
- Param: var
- Param: val

Replaced value:
```sqf
_w setVariable [#var,val]
```
File: [client\Hud\Hud_init.sqf at line 26](../../../Src/client/Hud/Hud_init.sqf#L26)
## hud_vars

Type: Variable

Description: 


Initial value:
```sqf
["oxy","hunger","thirst","encumb","pee","poo","vs_lastError","combatMode","bone","pain","sleep","bleeding","stealth","light","combStyle","specAct",...
```
File: [client\Hud\Hud_init.sqf at line 29](../../../Src/client/Hud/Hud_init.sqf#L29)
## hud_map_defaultValues

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 32](../../../Src/client/Hud/Hud_init.sqf#L32)
## hud_map_widgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 34](../../../Src/client/Hud/Hud_init.sqf#L34)
## hud_thirst

Type: Variable

Description: 


Initial value:
```sqf
100 //жажда
```
File: [client\Hud\Hud_init.sqf at line 39](../../../Src/client/Hud/Hud_init.sqf#L39)
## hud_thirst_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Жажда",[[51,""],[50,"#56C9F0"],[40,"#2AA7D1"],[30,"#0C87B0"],[20,"#078A8F"],[10,"#03704E"]],false]
```
File: [client\Hud\Hud_init.sqf at line 41](../../../Src/client/Hud/Hud_init.sqf#L41)
## hud_hunger

Type: Variable

Description: 


Initial value:
```sqf
100 //голод
```
File: [client\Hud\Hud_init.sqf at line 43](../../../Src/client/Hud/Hud_init.sqf#L43)
## hud_hunger_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 45](../../../Src/client/Hud/Hud_init.sqf#L45)
## hud_encumb

Type: Variable

Description: 


Initial value:
```sqf
0 //перегруз
```
File: [client\Hud\Hud_init.sqf at line 56](../../../Src/client/Hud/Hud_init.sqf#L56)
## hud_encumb_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перегруз",[[0,""],[1,"#A46EF0"],[2,"#6926C7"],[3,"#8104B3"],[4,"#8C0052"]],true]
```
File: [client\Hud\Hud_init.sqf at line 58](../../../Src/client/Hud/Hud_init.sqf#L58)
## hud_temp

Type: Variable

Description: 


Initial value:
```sqf
36 //внешняя температура
```
File: [client\Hud\Hud_init.sqf at line 60](../../../Src/client/Hud/Hud_init.sqf#L60)
## hud_oxy

Type: Variable

Description: 


Initial value:
```sqf
100 //дыхалка
```
File: [client\Hud\Hud_init.sqf at line 63](../../../Src/client/Hud/Hud_init.sqf#L63)
## hud_oxy_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кислород",[[90,""],[70,"#46F0E7"],[50,"#7ACFCA"],[30,"#5F9C99"],[10,"#2E705D"],[5,"#0B5434"],[1,"#AD0017"]],false]
```
File: [client\Hud\Hud_init.sqf at line 65](../../../Src/client/Hud/Hud_init.sqf#L65)
## hud_holdbreath

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 67](../../../Src/client/Hud/Hud_init.sqf#L67)
## hud_holdbreath_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Не дышу",[[0,""],[1,"#718BD9"]],true]
```
File: [client\Hud\Hud_init.sqf at line 69](../../../Src/client/Hud/Hud_init.sqf#L69)
## hud_tox

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 71](../../../Src/client/Hud/Hud_init.sqf#L71)
## hud_tox_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Отравление",[[0,""],[10,"#A9E084"],[25,"#82C456"],[50,"#539129"],[100,"#245206"]],true]
```
File: [client\Hud\Hud_init.sqf at line 73](../../../Src/client/Hud/Hud_init.sqf#L73)
## hud_pee

Type: Variable

Description: 


Initial value:
```sqf
0 //малая нужда
```
File: [client\Hud\Hud_init.sqf at line 75](../../../Src/client/Hud/Hud_init.sqf#L75)
## hud_pee_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Мочевой пузырь",[[0,""],[20,"#E3E691"],[40,"#D0D45D"],[60,"#E0D238"],[80,"#FFB805"]],true]
```
File: [client\Hud\Hud_init.sqf at line 77](../../../Src/client/Hud/Hud_init.sqf#L77)
## hud_poo

Type: Variable

Description: 


Initial value:
```sqf
0 //большая нужда
```
File: [client\Hud\Hud_init.sqf at line 79](../../../Src/client/Hud/Hud_init.sqf#L79)
## hud_poo_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кишечник",[[0,""],[20,"#80715B"],[40,"#665235"],[60,"#573E18"],[80,"#472400"]],true]
```
File: [client\Hud\Hud_init.sqf at line 81](../../../Src/client/Hud/Hud_init.sqf#L81)
## hud_pain

Type: Variable

Description: 


Initial value:
```sqf
0//уровень боли
```
File: [client\Hud\Hud_init.sqf at line 84](../../../Src/client/Hud/Hud_init.sqf#L84)
## hud_pain_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Боль",[[0,""],[1,"#693F60"],[2,"#913463"],[3,"#C91C59"],[4,"#FF033D"]],true]
```
File: [client\Hud\Hud_init.sqf at line 86](../../../Src/client/Hud/Hud_init.sqf#L86)
## hud_bone

Type: Variable

Description: 


Initial value:
```sqf
0//переломы
```
File: [client\Hud\Hud_init.sqf at line 88](../../../Src/client/Hud/Hud_init.sqf#L88)
## hud_bone_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перелом",[[0,""],[1,"#FA9F3E"]],true]
```
File: [client\Hud\Hud_init.sqf at line 90](../../../Src/client/Hud/Hud_init.sqf#L90)
## hud_sleep

Type: Variable

Description: 


Initial value:
```sqf
0 //сон
```
File: [client\Hud\Hud_init.sqf at line 92](../../../Src/client/Hud/Hud_init.sqf#L92)
## hud_sleep_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Сон",[[0,""],[1,"#133AAC"]],true]
```
File: [client\Hud\Hud_init.sqf at line 94](../../../Src/client/Hud/Hud_init.sqf#L94)
## hud_stealth

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 96](../../../Src/client/Hud/Hud_init.sqf#L96)
## hud_stealth_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Скрытность",[[0,""],[1,"#0C87B0"]],true]
```
File: [client\Hud\Hud_init.sqf at line 98](../../../Src/client/Hud/Hud_init.sqf#L98)
## hud_light

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 100](../../../Src/client/Hud/Hud_init.sqf#L100)
## hud_light_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 102](../../../Src/client/Hud/Hud_init.sqf#L102)
## hud_bleeding

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 116](../../../Src/client/Hud/Hud_init.sqf#L116)
## hud_bleeding_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кровотечение",[[0,""],[0.1,"#FF7A66"],[1,"#E04128"],[5,"#A61A05"],[10,"#540D02"],[20,"#210601"]],true]
```
File: [client\Hud\Hud_init.sqf at line 118](../../../Src/client/Hud/Hud_init.sqf#L118)
## hud_combStyle

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 120](../../../Src/client/Hud/Hud_init.sqf#L120)
## hud_combStyle_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 130](../../../Src/client/Hud/Hud_init.sqf#L130)
## hud_combatMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 139](../../../Src/client/Hud/Hud_init.sqf#L139)
## hud_combatMode_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 145](../../../Src/client/Hud/Hud_init.sqf#L145)
## hud_specAct

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 152](../../../Src/client/Hud/Hud_init.sqf#L152)
## hud_specAct_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 164](../../../Src/client/Hud/Hud_init.sqf#L164)
## hud_vs_lastError

Type: Variable

Description: linking vs_lastError


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 173](../../../Src/client/Hud/Hud_init.sqf#L173)
## hud_vs_lastError_overlay

Type: Variable

Description: 


Initial value:
```sqf
["!!!ТИМСПИК!!!",[[0,""],[1,"#ED002F"]],true]
```
File: [client\Hud\Hud_init.sqf at line 175](../../../Src/client/Hud/Hud_init.sqf#L175)
## hud_combStyle_onCombatUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 122](../../../Src/client/Hud/Hud_init.sqf#L122)
## hud_combatMode_sync

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 141](../../../Src/client/Hud/Hud_init.sqf#L141)
## hud_specAct_update

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 155](../../../Src/client/Hud/Hud_init.sqf#L155)
## hud_recalculateStat

Type: function

Description: 
- Param: _name

File: [client\Hud\Hud_init.sqf at line 199](../../../Src/client/Hud/Hud_init.sqf#L199)
## hud_cleanup

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 207](../../../Src/client/Hud/Hud_init.sqf#L207)
## hud_init

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 214](../../../Src/client/Hud/Hud_init.sqf#L214)
## hud_onUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 269](../../../Src/client/Hud/Hud_init.sqf#L269)
