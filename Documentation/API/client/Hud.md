# Hud_init.sqf

## HUD_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Hud\Hud_init.sqf at line 14](../../../Src/client/Hud/Hud_init.sqf#L14)
## STAT_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Hud\Hud_init.sqf at line 17](../../../Src/client/Hud/Hud_init.sqf#L17)
## canVisibleAttribute(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
(data != "")
```
File: [client\Hud\Hud_init.sqf at line 20](../../../Src/client/Hud/Hud_init.sqf#L20)
## getWidgetVar(_w,var)

Type: constant

Description: 
- Param: _w
- Param: var

Replaced value:
```sqf
(_w getvariable #var)
```
File: [client\Hud\Hud_init.sqf at line 23](../../../Src/client/Hud/Hud_init.sqf#L23)
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
File: [client\Hud\Hud_init.sqf at line 25](../../../Src/client/Hud/Hud_init.sqf#L25)
## hud_vars

Type: Variable

Description: 


Initial value:
```sqf
["oxy","hunger","thirst","encumb","pee","poo","vs_lastError","combatMode","bone","pain","sleep","bleeding","stealth","light","combStyle","specAct",...
```
File: [client\Hud\Hud_init.sqf at line 28](../../../Src/client/Hud/Hud_init.sqf#L28)
## hud_map_defaultValues

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 31](../../../Src/client/Hud/Hud_init.sqf#L31)
## hud_map_widgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 33](../../../Src/client/Hud/Hud_init.sqf#L33)
## hud_thirst

Type: Variable

Description: 


Initial value:
```sqf
100 //жажда
```
File: [client\Hud\Hud_init.sqf at line 38](../../../Src/client/Hud/Hud_init.sqf#L38)
## hud_thirst_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Жажда",[[51,""],[50,"#56C9F0"],[40,"#2AA7D1"],[30,"#0C87B0"],[20,"#078A8F"],[10,"#03704E"]],false]
```
File: [client\Hud\Hud_init.sqf at line 40](../../../Src/client/Hud/Hud_init.sqf#L40)
## hud_hunger

Type: Variable

Description: 


Initial value:
```sqf
100 //голод
```
File: [client\Hud\Hud_init.sqf at line 42](../../../Src/client/Hud/Hud_init.sqf#L42)
## hud_hunger_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Голод",[[51,""],[50,"#F2BF8F"],[40,"#D18E4F"],[30,"#A8611E"],[20,"#8C420D"],[10,"#630603"]],false]
```
File: [client\Hud\Hud_init.sqf at line 44](../../../Src/client/Hud/Hud_init.sqf#L44)
## hud_encumb

Type: Variable

Description: 


Initial value:
```sqf
0 //перегруз
```
File: [client\Hud\Hud_init.sqf at line 46](../../../Src/client/Hud/Hud_init.sqf#L46)
## hud_encumb_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перегруз",[[0,""],[1,"#A46EF0"],[2,"#6926C7"],[3,"#8104B3"],[4,"#8C0052"]],true]
```
File: [client\Hud\Hud_init.sqf at line 48](../../../Src/client/Hud/Hud_init.sqf#L48)
## hud_temp

Type: Variable

Description: 


Initial value:
```sqf
36 //внешняя температура
```
File: [client\Hud\Hud_init.sqf at line 50](../../../Src/client/Hud/Hud_init.sqf#L50)
## hud_oxy

Type: Variable

Description: 


Initial value:
```sqf
100 //дыхалка
```
File: [client\Hud\Hud_init.sqf at line 53](../../../Src/client/Hud/Hud_init.sqf#L53)
## hud_oxy_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кислород",[[90,""],[70,"#46F0E7"],[50,"#7ACFCA"],[30,"#5F9C99"],[10,"#2E705D"],[5,"#0B5434"],[1,"#AD0017"]],false]
```
File: [client\Hud\Hud_init.sqf at line 55](../../../Src/client/Hud/Hud_init.sqf#L55)
## hud_holdbreath

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 57](../../../Src/client/Hud/Hud_init.sqf#L57)
## hud_holdbreath_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Не дышу",[[0,""],[1,"#718BD9"]],true]
```
File: [client\Hud\Hud_init.sqf at line 59](../../../Src/client/Hud/Hud_init.sqf#L59)
## hud_tox

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 61](../../../Src/client/Hud/Hud_init.sqf#L61)
## hud_tox_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Отравление",[[0,""],[10,"#A9E084"],[25,"#82C456"],[50,"#539129"],[100,"#245206"]],true]
```
File: [client\Hud\Hud_init.sqf at line 63](../../../Src/client/Hud/Hud_init.sqf#L63)
## hud_pee

Type: Variable

Description: 


Initial value:
```sqf
0 //малая нужда
```
File: [client\Hud\Hud_init.sqf at line 65](../../../Src/client/Hud/Hud_init.sqf#L65)
## hud_pee_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Мочевой пузырь",[[0,""],[20,"#E3E691"],[40,"#D0D45D"],[60,"#E0D238"],[80,"#FFB805"]],true]
```
File: [client\Hud\Hud_init.sqf at line 67](../../../Src/client/Hud/Hud_init.sqf#L67)
## hud_poo

Type: Variable

Description: 


Initial value:
```sqf
0 //большая нужда
```
File: [client\Hud\Hud_init.sqf at line 69](../../../Src/client/Hud/Hud_init.sqf#L69)
## hud_poo_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кишечник",[[0,""],[20,"#80715B"],[40,"#665235"],[60,"#573E18"],[80,"#472400"]],true]
```
File: [client\Hud\Hud_init.sqf at line 71](../../../Src/client/Hud/Hud_init.sqf#L71)
## hud_pain

Type: Variable

Description: 


Initial value:
```sqf
0//уровень боли
```
File: [client\Hud\Hud_init.sqf at line 74](../../../Src/client/Hud/Hud_init.sqf#L74)
## hud_pain_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Боль",[[0,""],[1,"#693F60"],[2,"#913463"],[3,"#C91C59"],[4,"#FF033D"]],true]
```
File: [client\Hud\Hud_init.sqf at line 76](../../../Src/client/Hud/Hud_init.sqf#L76)
## hud_bone

Type: Variable

Description: 


Initial value:
```sqf
0//переломы
```
File: [client\Hud\Hud_init.sqf at line 78](../../../Src/client/Hud/Hud_init.sqf#L78)
## hud_bone_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перелом",[[0,""],[1,"#FA9F3E"]],true]
```
File: [client\Hud\Hud_init.sqf at line 80](../../../Src/client/Hud/Hud_init.sqf#L80)
## hud_sleep

Type: Variable

Description: 


Initial value:
```sqf
0 //сон
```
File: [client\Hud\Hud_init.sqf at line 82](../../../Src/client/Hud/Hud_init.sqf#L82)
## hud_sleep_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Сон",[[0,""],[1,"#133AAC"]],true]
```
File: [client\Hud\Hud_init.sqf at line 84](../../../Src/client/Hud/Hud_init.sqf#L84)
## hud_stealth

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 86](../../../Src/client/Hud/Hud_init.sqf#L86)
## hud_stealth_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Скрытность",[[0,""],[1,"#0C87B0"]],true]
```
File: [client\Hud\Hud_init.sqf at line 88](../../../Src/client/Hud/Hud_init.sqf#L88)
## hud_light

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 90](../../../Src/client/Hud/Hud_init.sqf#L90)
## hud_light_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 92](../../../Src/client/Hud/Hud_init.sqf#L92)
## hud_bleeding

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 106](../../../Src/client/Hud/Hud_init.sqf#L106)
## hud_bleeding_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кровотечение",[[0,""],[0.1,"#FF7A66"],[1,"#E04128"],[5,"#A61A05"],[10,"#540D02"],[20,"#210601"]],true]
```
File: [client\Hud\Hud_init.sqf at line 108](../../../Src/client/Hud/Hud_init.sqf#L108)
## hud_combStyle

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 110](../../../Src/client/Hud/Hud_init.sqf#L110)
## hud_combStyle_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 120](../../../Src/client/Hud/Hud_init.sqf#L120)
## hud_combatMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 129](../../../Src/client/Hud/Hud_init.sqf#L129)
## hud_combatMode_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 135](../../../Src/client/Hud/Hud_init.sqf#L135)
## hud_specAct

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 142](../../../Src/client/Hud/Hud_init.sqf#L142)
## hud_specAct_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 154](../../../Src/client/Hud/Hud_init.sqf#L154)
## hud_vs_lastError

Type: Variable

Description: linking vs_lastError


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 163](../../../Src/client/Hud/Hud_init.sqf#L163)
## hud_vs_lastError_overlay

Type: Variable

Description: 


Initial value:
```sqf
["!!!ТИМСПИК!!!",[[0,""],[1,"#ED002F"]],true]
```
File: [client\Hud\Hud_init.sqf at line 165](../../../Src/client/Hud/Hud_init.sqf#L165)
## hud_combStyle_onCombatUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 112](../../../Src/client/Hud/Hud_init.sqf#L112)
## hud_combatMode_sync

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 131](../../../Src/client/Hud/Hud_init.sqf#L131)
## hud_specAct_update

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 145](../../../Src/client/Hud/Hud_init.sqf#L145)
## hud_recalculateStat

Type: function

Description: 
- Param: _name

File: [client\Hud\Hud_init.sqf at line 189](../../../Src/client/Hud/Hud_init.sqf#L189)
## hud_cleanup

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 197](../../../Src/client/Hud/Hud_init.sqf#L197)
## hud_init

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 204](../../../Src/client/Hud/Hud_init.sqf#L204)
## hud_onUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 259](../../../Src/client/Hud/Hud_init.sqf#L259)
