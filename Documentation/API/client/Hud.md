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
File: [client\Hud\Hud_init.sqf at line 57](../../../Src/client/Hud/Hud_init.sqf#L57)
## hud_encumb_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перегруз",[[0,""],[1,"#A46EF0"],[2,"#6926C7"],[3,"#8104B3"],[4,"#8C0052"]],true]
```
File: [client\Hud\Hud_init.sqf at line 59](../../../Src/client/Hud/Hud_init.sqf#L59)
## hud_temp

Type: Variable

Description: 


Initial value:
```sqf
36 //внешняя температура
```
File: [client\Hud\Hud_init.sqf at line 61](../../../Src/client/Hud/Hud_init.sqf#L61)
## hud_oxy

Type: Variable

Description: 


Initial value:
```sqf
100 //дыхалка
```
File: [client\Hud\Hud_init.sqf at line 64](../../../Src/client/Hud/Hud_init.sqf#L64)
## hud_oxy_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кислород",[[90,""],[70,"#46F0E7"],[50,"#7ACFCA"],[30,"#5F9C99"],[10,"#2E705D"],[5,"#0B5434"],[1,"#AD0017"]],false]
```
File: [client\Hud\Hud_init.sqf at line 66](../../../Src/client/Hud/Hud_init.sqf#L66)
## hud_holdbreath

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 68](../../../Src/client/Hud/Hud_init.sqf#L68)
## hud_holdbreath_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Не дышу",[[0,""],[1,"#718BD9"]],true]
```
File: [client\Hud\Hud_init.sqf at line 70](../../../Src/client/Hud/Hud_init.sqf#L70)
## hud_tox

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 72](../../../Src/client/Hud/Hud_init.sqf#L72)
## hud_tox_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Отравление",[[0,""],[10,"#A9E084"],[25,"#82C456"],[50,"#539129"],[100,"#245206"]],true]
```
File: [client\Hud\Hud_init.sqf at line 74](../../../Src/client/Hud/Hud_init.sqf#L74)
## hud_pee

Type: Variable

Description: 


Initial value:
```sqf
0 //малая нужда
```
File: [client\Hud\Hud_init.sqf at line 76](../../../Src/client/Hud/Hud_init.sqf#L76)
## hud_pee_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Мочевой пузырь",[[0,""],[20,"#E3E691"],[40,"#D0D45D"],[60,"#E0D238"],[80,"#FFB805"]],true]
```
File: [client\Hud\Hud_init.sqf at line 78](../../../Src/client/Hud/Hud_init.sqf#L78)
## hud_poo

Type: Variable

Description: 


Initial value:
```sqf
0 //большая нужда
```
File: [client\Hud\Hud_init.sqf at line 80](../../../Src/client/Hud/Hud_init.sqf#L80)
## hud_poo_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кишечник",[[0,""],[20,"#80715B"],[40,"#665235"],[60,"#573E18"],[80,"#472400"]],true]
```
File: [client\Hud\Hud_init.sqf at line 82](../../../Src/client/Hud/Hud_init.sqf#L82)
## hud_pain

Type: Variable

Description: 


Initial value:
```sqf
0//уровень боли
```
File: [client\Hud\Hud_init.sqf at line 85](../../../Src/client/Hud/Hud_init.sqf#L85)
## hud_pain_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Боль",[[0,""],[1,"#693F60"],[2,"#913463"],[3,"#C91C59"],[4,"#FF033D"]],true]
```
File: [client\Hud\Hud_init.sqf at line 87](../../../Src/client/Hud/Hud_init.sqf#L87)
## hud_bone

Type: Variable

Description: 


Initial value:
```sqf
0//переломы
```
File: [client\Hud\Hud_init.sqf at line 89](../../../Src/client/Hud/Hud_init.sqf#L89)
## hud_bone_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Перелом",[[0,""],[1,"#FA9F3E"]],true]
```
File: [client\Hud\Hud_init.sqf at line 91](../../../Src/client/Hud/Hud_init.sqf#L91)
## hud_sleep

Type: Variable

Description: 


Initial value:
```sqf
0 //сон
```
File: [client\Hud\Hud_init.sqf at line 93](../../../Src/client/Hud/Hud_init.sqf#L93)
## hud_sleep_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Сон",[[0,""],[1,"#133AAC"]],true]
```
File: [client\Hud\Hud_init.sqf at line 95](../../../Src/client/Hud/Hud_init.sqf#L95)
## hud_stealth

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 97](../../../Src/client/Hud/Hud_init.sqf#L97)
## hud_stealth_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Скрытность",[[0,""],[1,"#0C87B0"]],true]
```
File: [client\Hud\Hud_init.sqf at line 99](../../../Src/client/Hud/Hud_init.sqf#L99)
## hud_light

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 101](../../../Src/client/Hud/Hud_init.sqf#L101)
## hud_light_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 103](../../../Src/client/Hud/Hud_init.sqf#L103)
## hud_bleeding

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 117](../../../Src/client/Hud/Hud_init.sqf#L117)
## hud_bleeding_overlay

Type: Variable

Description: 


Initial value:
```sqf
["Кровотечение",[[0,""],[0.1,"#FF7A66"],[1,"#E04128"],[5,"#A61A05"],[10,"#540D02"],[20,"#210601"]],true]
```
File: [client\Hud\Hud_init.sqf at line 119](../../../Src/client/Hud/Hud_init.sqf#L119)
## hud_combStyle

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 121](../../../Src/client/Hud/Hud_init.sqf#L121)
## hud_combStyle_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 131](../../../Src/client/Hud/Hud_init.sqf#L131)
## hud_combatMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 140](../../../Src/client/Hud/Hud_init.sqf#L140)
## hud_combatMode_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 146](../../../Src/client/Hud/Hud_init.sqf#L146)
## hud_specAct

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 153](../../../Src/client/Hud/Hud_init.sqf#L153)
## hud_specAct_overlay

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Hud\Hud_init.sqf at line 165](../../../Src/client/Hud/Hud_init.sqf#L165)
## hud_vs_lastError

Type: Variable

Description: linking vs_lastError


Initial value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 174](../../../Src/client/Hud/Hud_init.sqf#L174)
## hud_vs_lastError_overlay

Type: Variable

Description: 


Initial value:
```sqf
["!!!ТИМСПИК!!!",[[0,""],[1,"#ED002F"]],true]
```
File: [client\Hud\Hud_init.sqf at line 176](../../../Src/client/Hud/Hud_init.sqf#L176)
## hud_combStyle_onCombatUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 123](../../../Src/client/Hud/Hud_init.sqf#L123)
## hud_combatMode_sync

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 142](../../../Src/client/Hud/Hud_init.sqf#L142)
## hud_specAct_update

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 156](../../../Src/client/Hud/Hud_init.sqf#L156)
## hud_recalculateStat

Type: function

Description: 
- Param: _name

File: [client\Hud\Hud_init.sqf at line 200](../../../Src/client/Hud/Hud_init.sqf#L200)
## hud_cleanup

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 208](../../../Src/client/Hud/Hud_init.sqf#L208)
## hud_init

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 215](../../../Src/client/Hud/Hud_init.sqf#L215)
## hud_onUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 270](../../../Src/client/Hud/Hud_init.sqf#L270)
