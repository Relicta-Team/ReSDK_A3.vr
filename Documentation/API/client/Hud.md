# Hud_init.sqf

## HUD_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Hud\Hud_init.sqf at line 12](../../../Src/client/Hud/Hud_init.sqf#L12)
## STAT_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Hud\Hud_init.sqf at line 14](../../../Src/client/Hud/Hud_init.sqf#L14)
## canVisibleAttribute(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
(data != "")
```
File: [client\Hud\Hud_init.sqf at line 16](../../../Src/client/Hud/Hud_init.sqf#L16)
## getWidgetVar(_w,var)

Type: constant

Description: 
- Param: _w
- Param: var

Replaced value:
```sqf
(_w getvariable #var)
```
File: [client\Hud\Hud_init.sqf at line 18](../../../Src/client/Hud/Hud_init.sqf#L18)
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
File: [client\Hud\Hud_init.sqf at line 19](../../../Src/client/Hud/Hud_init.sqf#L19)
## hud_vars

Type: Variable

Description: 


Initial value:
```sqf
["oxy","hunger","thirst","encumb","pee","poo","tf_lastError","combatMode","bone","pain","sleep","bleeding","stealth","light","combStyle","specAct",...
```
File: [client\Hud\Hud_init.sqf at line 21](../../../Src/client/Hud/Hud_init.sqf#L21)
## hud_map_defaultValues

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 23](../../../Src/client/Hud/Hud_init.sqf#L23)
## hud_map_widgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Hud\Hud_init.sqf at line 24](../../../Src/client/Hud/Hud_init.sqf#L24)
## hud_thirst

Type: Variable

Description: hud_[var]_overlay select 1 - сортировка. true для тех где от меньшего к большему и false наоборот


Initial value:
```sqf
100 //жажда
```
File: [client\Hud\Hud_init.sqf at line 29](../../../Src/client/Hud/Hud_init.sqf#L29)
## hud_thirst_overlay

Type: Variable

Description: жажда


Initial value:
```sqf
["Жажда",[[51,""],[50,"#56C9F0"],[40,"#2AA7D1"],[30,"#0C87B0"],[20,"#078A8F"],[10,"#03704E"]],false]
```
File: [client\Hud\Hud_init.sqf at line 30](../../../Src/client/Hud/Hud_init.sqf#L30)
## hud_hunger

Type: Variable

Description: 


Initial value:
```sqf
100 //голод
```
File: [client\Hud\Hud_init.sqf at line 31](../../../Src/client/Hud/Hud_init.sqf#L31)
## hud_hunger_overlay

Type: Variable

Description: голод


Initial value:
```sqf
["Голод",[[51,""],[50,"#F2BF8F"],[40,"#D18E4F"],[30,"#A8611E"],[20,"#8C420D"],[10,"#630603"]],false]
```
File: [client\Hud\Hud_init.sqf at line 32](../../../Src/client/Hud/Hud_init.sqf#L32)
## hud_encumb

Type: Variable

Description: 


Initial value:
```sqf
0 //перегруз
```
File: [client\Hud\Hud_init.sqf at line 33](../../../Src/client/Hud/Hud_init.sqf#L33)
## hud_encumb_overlay

Type: Variable

Description: перегруз


Initial value:
```sqf
["Перегруз",[[0,""],[1,"#A46EF0"],[2,"#6926C7"],[3,"#8104B3"],[4,"#8C0052"]],true]
```
File: [client\Hud\Hud_init.sqf at line 34](../../../Src/client/Hud/Hud_init.sqf#L34)
## hud_temp

Type: Variable

Description: 


Initial value:
```sqf
36 //внешняя температура
```
File: [client\Hud\Hud_init.sqf at line 35](../../../Src/client/Hud/Hud_init.sqf#L35)
## hud_oxy

Type: Variable

Description: hud_hunger_overlay = ["Температура",[[0,""],[1,""],[2,""],[3,""],[4,""]]];


Initial value:
```sqf
100 //дыхалка
```
File: [client\Hud\Hud_init.sqf at line 37](../../../Src/client/Hud/Hud_init.sqf#L37)
## hud_oxy_overlay

Type: Variable

Description: дыхалка


Initial value:
```sqf
["Кислород",[[90,""],[70,"#46F0E7"],[50,"#7ACFCA"],[30,"#5F9C99"],[10,"#2E705D"],[5,"#0B5434"],[1,"#AD0017"]],false]
```
File: [client\Hud\Hud_init.sqf at line 38](../../../Src/client/Hud/Hud_init.sqf#L38)
## hud_holdbreath

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 39](../../../Src/client/Hud/Hud_init.sqf#L39)
## hud_holdbreath_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Не дышу",[[0,""],[1,"#718BD9"]],true]
```
File: [client\Hud\Hud_init.sqf at line 40](../../../Src/client/Hud/Hud_init.sqf#L40)
## hud_tox

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 41](../../../Src/client/Hud/Hud_init.sqf#L41)
## hud_tox_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Отравление",[[0,""],[10,"#A9E084"],[25,"#82C456"],[50,"#539129"],[100,"#245206"]],true]
```
File: [client\Hud\Hud_init.sqf at line 42](../../../Src/client/Hud/Hud_init.sqf#L42)
## hud_pee

Type: Variable

Description: 


Initial value:
```sqf
0 //малая нужда
```
File: [client\Hud\Hud_init.sqf at line 43](../../../Src/client/Hud/Hud_init.sqf#L43)
## hud_pee_overlay

Type: Variable

Description: малая нужда


Initial value:
```sqf
["Мочевой пузырь",[[0,""],[20,"#E3E691"],[40,"#D0D45D"],[60,"#E0D238"],[80,"#FFB805"]],true]
```
File: [client\Hud\Hud_init.sqf at line 44](../../../Src/client/Hud/Hud_init.sqf#L44)
## hud_poo

Type: Variable

Description: 


Initial value:
```sqf
0 //большая нужда
```
File: [client\Hud\Hud_init.sqf at line 45](../../../Src/client/Hud/Hud_init.sqf#L45)
## hud_poo_overlay

Type: Variable

Description: большая нужда


Initial value:
```sqf
["Кишечник",[[0,""],[20,"#80715B"],[40,"#665235"],[60,"#573E18"],[80,"#472400"]],true]
```
File: [client\Hud\Hud_init.sqf at line 46](../../../Src/client/Hud/Hud_init.sqf#L46)
## hud_pain

Type: Variable

Description: 


Initial value:
```sqf
0//уровень боли
```
File: [client\Hud\Hud_init.sqf at line 48](../../../Src/client/Hud/Hud_init.sqf#L48)
## hud_pain_overlay

Type: Variable

Description: уровень боли


Initial value:
```sqf
["Боль",[[0,""],[1,"#693F60"],[2,"#913463"],[3,"#C91C59"],[4,"#FF033D"]],true]
```
File: [client\Hud\Hud_init.sqf at line 49](../../../Src/client/Hud/Hud_init.sqf#L49)
## hud_bone

Type: Variable

Description: 


Initial value:
```sqf
0//переломы
```
File: [client\Hud\Hud_init.sqf at line 50](../../../Src/client/Hud/Hud_init.sqf#L50)
## hud_bone_overlay

Type: Variable

Description: переломы


Initial value:
```sqf
["Перелом",[[0,""],[1,"#FA9F3E"]],true]
```
File: [client\Hud\Hud_init.sqf at line 51](../../../Src/client/Hud/Hud_init.sqf#L51)
## hud_sleep

Type: Variable

Description: 


Initial value:
```sqf
0 //сон
```
File: [client\Hud\Hud_init.sqf at line 52](../../../Src/client/Hud/Hud_init.sqf#L52)
## hud_sleep_overlay

Type: Variable

Description: сон


Initial value:
```sqf
["Сон",[[0,""],[1,"#133AAC"]],true]
```
File: [client\Hud\Hud_init.sqf at line 53](../../../Src/client/Hud/Hud_init.sqf#L53)
## hud_stealth

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 54](../../../Src/client/Hud/Hud_init.sqf#L54)
## hud_stealth_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Скрытность",[[0,""],[1,"#0C87B0"]],true]
```
File: [client\Hud\Hud_init.sqf at line 55](../../../Src/client/Hud/Hud_init.sqf#L55)
## hud_light

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 56](../../../Src/client/Hud/Hud_init.sqf#L56)
## hud_light_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 57](../../../Src/client/Hud/Hud_init.sqf#L57)
## hud_bleeding

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 70](../../../Src/client/Hud/Hud_init.sqf#L70)
## hud_bleeding_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кровотечение",[[0,""],[0.1,"#FF7A66"],[1,"#E04128"],[5,"#A61A05"],[10,"#540D02"],[20,"#210601"]],true]
```
File: [client\Hud\Hud_init.sqf at line 71](../../../Src/client/Hud/Hud_init.sqf#L71)
## hud_combStyle

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 72](../../../Src/client/Hud/Hud_init.sqf#L72)
## hud_combStyle_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 80](../../../Src/client/Hud/Hud_init.sqf#L80)
## hud_combatMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 88](../../../Src/client/Hud/Hud_init.sqf#L88)
## hud_combatMode_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 92](../../../Src/client/Hud/Hud_init.sqf#L92)
## hud_specAct

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 98](../../../Src/client/Hud/Hud_init.sqf#L98)
## hud_specAct_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 108](../../../Src/client/Hud/Hud_init.sqf#L108)
## hud_tf_lastError

Type: Variable

Description: system


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 116](../../../Src/client/Hud/Hud_init.sqf#L116)
## hud_tf_lastError_overlay

Type: Variable

Description: 


Initial value:
```sqf
["!!!ТИМСПИК!!!",[[0,""],[1,"#ED002F"]],true]
```
File: [client\Hud\Hud_init.sqf at line 117](../../../Src/client/Hud/Hud_init.sqf#L117)
## hud_combStyle_onCombatUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 73](../../../Src/client/Hud/Hud_init.sqf#L73)
## hud_combatMode_sync

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 89](../../../Src/client/Hud/Hud_init.sqf#L89)
## hud_specAct_update

Type: function

Description: вызывается при обновлении спец.кнопок.


File: [client\Hud\Hud_init.sqf at line 100](../../../Src/client/Hud/Hud_init.sqf#L100)
## hud_recalculateStat

Type: function

Description: 
- Param: _name

File: [client\Hud\Hud_init.sqf at line 140](../../../Src/client/Hud/Hud_init.sqf#L140)
## hud_cleanup

Type: function

Description: очистка худа - сброс всех переменных на стандартные значения


File: [client\Hud\Hud_init.sqf at line 147](../../../Src/client/Hud/Hud_init.sqf#L147)
## hud_init

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 153](../../../Src/client/Hud/Hud_init.sqf#L153)
## hud_onUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 208](../../../Src/client/Hud/Hud_init.sqf#L208)
