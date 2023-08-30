# GameConstants.hpp

## __QDEL_VARNAME

Type: constant

Description: QDEL means query delete for antilagging objects


Replaced value:
```sqf
'qdel_isdeleted'
```
File: [host\GameObjects\GameConstants.hpp at line 22](../../../Src/host/GameObjects/GameConstants.hpp#L22)
## QDEL(object)

Type: constant

Description: 
- Param: object

Replaced value:
```sqf
(object) setVariable [__QDEL_VARNAME,true]
```
File: [host\GameObjects\GameConstants.hpp at line 23](../../../Src/host/GameObjects/GameConstants.hpp#L23)
## QDELING(object)

Type: constant

Description: 
- Param: object

Replaced value:
```sqf
!ISNIL{object getVariable __QDEL_VARNAME}
```
File: [host\GameObjects\GameConstants.hpp at line 24](../../../Src/host/GameObjects/GameConstants.hpp#L24)
## ITEM_SIZE_TINY

Type: constant

Description: 5 большие предметы: винтовка,канистра; 6 огромные: складной стул, гранатомёт )


Replaced value:
```sqf
1
```
File: [host\GameObjects\GameConstants.hpp at line 39](../../../Src/host/GameObjects/GameConstants.hpp#L39)
## ITEM_SIZE_SMALL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\GameConstants.hpp at line 40](../../../Src/host/GameObjects/GameConstants.hpp#L40)
## ITEM_SIZE_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\GameConstants.hpp at line 41](../../../Src/host/GameObjects/GameConstants.hpp#L41)
## ITEM_SIZE_LARGE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\GameConstants.hpp at line 42](../../../Src/host/GameObjects/GameConstants.hpp#L42)
## ITEM_SIZE_BIG

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\GameObjects\GameConstants.hpp at line 43](../../../Src/host/GameObjects/GameConstants.hpp#L43)
## ITEM_SIZE_HUGE

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\GameConstants.hpp at line 44](../../../Src/host/GameObjects/GameConstants.hpp#L44)
## BASE_STORAGE_COST(size_type)

Type: constant

Description: базовый занимаемый объём каждым типом
- Param: size_type

Replaced value:
```sqf
round (2^(size_type-1))
```
File: [host\GameObjects\GameConstants.hpp at line 47](../../../Src/host/GameObjects/GameConstants.hpp#L47)
## BASE_STORAGE_CAPACITY(size_type)

Type: constant

Description: базовая вместимость контейнера
- Param: size_type

Replaced value:
```sqf
round (7*(size_type-1))
```
File: [host\GameObjects\GameConstants.hpp at line 50](../../../Src/host/GameObjects/GameConstants.hpp#L50)
## DEFAULT_CLOTH_STORAGE

Type: constant

Description: дефолтная вместимость одежды, маленькой сумки,рюкзака,малого бокса,большого контейнера


Replaced value:
```sqf
BASE_STORAGE_CAPACITY(1.8571429)
```
File: [host\GameObjects\GameConstants.hpp at line 53](../../../Src/host/GameObjects/GameConstants.hpp#L53)
## DEFAULT_ITEMBAG_STORAGE

Type: constant

Description: 


Replaced value:
```sqf
BASE_STORAGE_CAPACITY(3)
```
File: [host\GameObjects\GameConstants.hpp at line 54](../../../Src/host/GameObjects/GameConstants.hpp#L54)
## DEFAULT_BACKPACK_STORAGE

Type: constant

Description: 


Replaced value:
```sqf
BASE_STORAGE_CAPACITY(4)	
```
File: [host\GameObjects\GameConstants.hpp at line 55](../../../Src/host/GameObjects/GameConstants.hpp#L55)
## DEFAULT_BOX_STORAGE

Type: constant

Description: 


Replaced value:
```sqf
BASE_STORAGE_CAPACITY(6)
```
File: [host\GameObjects\GameConstants.hpp at line 56](../../../Src/host/GameObjects/GameConstants.hpp#L56)
## DEFAULT_LARGEBOX_STORAGE

Type: constant

Description: 


Replaced value:
```sqf
BASE_STORAGE_CAPACITY(7)
```
File: [host\GameObjects\GameConstants.hpp at line 57](../../../Src/host/GameObjects/GameConstants.hpp#L57)
## DEFAULT_TICK_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\GameConstants.hpp at line 86](../../../Src/host/GameObjects/GameConstants.hpp#L86)
## invicon(icon)

Type: constant

Description: 
- Param: icon

Replaced value:
```sqf
#icon
```
File: [host\GameObjects\GameConstants.hpp at line 88](../../../Src/host/GameObjects/GameConstants.hpp#L88)
## gramm(amount)

Type: constant

Description: трансформация граммов в киллограммы
- Param: amount

Replaced value:
```sqf
amount / 1000
```
File: [host\GameObjects\GameConstants.hpp at line 91](../../../Src/host/GameObjects/GameConstants.hpp#L91)
## kgToGramm(VL)

Type: constant

Description: Перевод киллограммов в граммы
- Param: VL

Replaced value:
```sqf
VL * 1000
```
File: [host\GameObjects\GameConstants.hpp at line 94](../../../Src/host/GameObjects/GameConstants.hpp#L94)
## kgToLb(val)

Type: constant

Description: из киллограмм в фунты
- Param: val

Replaced value:
```sqf
((val)*2)
```
File: [host\GameObjects\GameConstants.hpp at line 97](../../../Src/host/GameObjects/GameConstants.hpp#L97)
## DISTANCE_WORLDSAY

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [host\GameObjects\GameConstants.hpp at line 99](../../../Src/host/GameObjects/GameConstants.hpp#L99)
## sideToIndex(_side)

Type: constant

Description: Умная конвертация двухстороннего режима
- Param: _side

Replaced value:
```sqf
(abs ceil ((_side)*.1))
```
File: [host\GameObjects\GameConstants.hpp at line 102](../../../Src/host/GameObjects/GameConstants.hpp#L102)
## SIDE_LEFT

Type: constant

Description: 


Replaced value:
```sqf
-1
```
File: [host\GameObjects\GameConstants.hpp at line 103](../../../Src/host/GameObjects/GameConstants.hpp#L103)
## SIDE_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\GameConstants.hpp at line 104](../../../Src/host/GameObjects/GameConstants.hpp#L104)
# GameObject.sqf

## PIC_PREP

Type: constant

Description: 


Replaced value:
```sqf
<img size='0.8' image='%2'/>
```
File: [host\GameObjects\GameObject.sqf at line 190](../../../Src/host/GameObjects/GameObject.sqf#L190)
## startSectorIndex

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\GameObject.sqf at line 467](../../../Src/host/GameObjects/GameObject.sqf#L467)
## sectorSize

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\GameObject.sqf at line 468](../../../Src/host/GameObjects/GameObject.sqf#L468)
## flyingObject

Type: Variable

Description: летящий объект. системная переменная


Initial value:
```sqf
createObj
```
File: [host\GameObjects\GameObject.sqf at line 50](../../../Src/host/GameObjects/GameObject.sqf#L50)
## go_internal_updateMethodsAfterStart

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameObjects\GameObject.sqf at line 232](../../../Src/host/GameObjects/GameObject.sqf#L232)
## debug_internal_collectInheritanceDesign

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\GameObjects\GameObject.sqf at line 37](../../../Src/host/GameObjects/GameObject.sqf#L37)
# Chemistry.h

## CHEM_TIME_SLOW_UPDATE

Type: constant

Description: через сколько секунд будет ассимилироваться материя в желуке и крови


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 8](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L8)
## REM

Type: constant

Description: Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick


Replaced value:
```sqf
0.2
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 11](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L11)
## CHEM_TOUCH

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 13](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L13)
## CHEM_INGEST

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 14](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L14)
## CHEM_BLOOD

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 15](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L15)
## SOLID

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 17](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L17)
## LIQUID

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 18](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L18)
## GAS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 19](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L19)
## CE_STABLE

Type: constant

Description: 


Replaced value:
```sqf
"stable"       // Inaprovaline
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 23](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L23)
## CE_ANTIBIOTIC

Type: constant

Description: Inaprovaline


Replaced value:
```sqf
"antibiotic"   // Spaceacilin
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 24](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L24)
## CE_BLOODRESTORE

Type: constant

Description: Spaceacilin


Replaced value:
```sqf
"bloodrestore" // Iron/nutriment
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 25](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L25)
## CE_PAINKILLER

Type: constant

Description: Iron/nutriment


Replaced value:
```sqf
"painkiller"
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 26](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L26)
## CE_ALCOHOL

Type: constant

Description: Liver filtering


Replaced value:
```sqf
"alcohol"      // Liver filtering
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 27](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L27)
## CE_ALCOHOL_TOXIC

Type: constant

Description: Liver filtering


Replaced value:
```sqf
"alcotoxic"    // Liver damage
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 28](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L28)
## CE_SPEEDBOOST

Type: constant

Description: Liver damage


Replaced value:
```sqf
"gofast"       // Hyperzine
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 29](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L29)
## CE_SLOWDOWN

Type: constant

Description: Hyperzine


Replaced value:
```sqf
"goslow"       // Slowdown
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 30](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L30)
## CE_PULSE

Type: constant

Description: Slowdown


Replaced value:
```sqf
"xcardic"      // increases or decreases heart rate
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 31](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L31)
## CE_NOPULSE

Type: constant

Description: increases or decreases heart rate


Replaced value:
```sqf
"heartstop"    // stops heartbeat
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 32](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L32)
## CE_ANTITOX

Type: constant

Description: stops heartbeat


Replaced value:
```sqf
"antitox"      // Dylovene
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 33](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L33)
## CE_OXYGENATED

Type: constant

Description: Dylovene


Replaced value:
```sqf
"oxygen"       // Dexalin.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 34](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L34)
## CE_BRAIN_REGEN

Type: constant

Description: Dexalin.


Replaced value:
```sqf
"brainfix"     // Alkysine.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 35](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L35)
## CE_ANTIVIRAL

Type: constant

Description: Alkysine.


Replaced value:
```sqf
"antiviral"    // Anti-virus effect.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 36](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L36)
## CE_TOXIN

Type: constant

Description: Anti-virus effect.


Replaced value:
```sqf
"toxins"       // Generic toxins, stops autoheal.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 37](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L37)
## CE_BREATHLOSS

Type: constant

Description: Generic toxins, stops autoheal.


Replaced value:
```sqf
"breathloss"   // Breathing depression, makes you need more air
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 38](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L38)
## CE_MIND

Type: constant

Description: Breathing depression, makes you need more air


Replaced value:
```sqf
"mindbending"  // Stabilizes or wrecks mind. Used for hallucinations
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 39](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L39)
## CE_CRYO

Type: constant

Description: Stabilizes or wrecks mind. Used for hallucinations


Replaced value:
```sqf
"cryogenic"    // Prevents damage from being frozen
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 40](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L40)
## CE_BLOCKAGE

Type: constant

Description: Prevents damage from being frozen


Replaced value:
```sqf
"blockage"     // Gets in the way of blood circulation, higher the worse
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 41](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L41)
## CE_SQUEAKY

Type: constant

Description: Gets in the way of blood circulation, higher the worse


Replaced value:
```sqf
"squeaky"      // Helium voice. Squeak squeak.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 42](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L42)
## CE_THIRDEYE

Type: constant

Description: Helium voice. Squeak squeak.


Replaced value:
```sqf
"thirdeye"     // Gives xray vision.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 43](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L43)
## CE_SEDATE

Type: constant

Description: Gives xray vision.


Replaced value:
```sqf
"sedate"       // Applies sedation effects, i.e. paralysis, inability to use items, etc.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 44](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L44)
## CE_ENERGETIC

Type: constant

Description: Applies sedation effects, i.e. paralysis, inability to use items, etc.


Replaced value:
```sqf
"energetic"    // Speeds up stamina recovery.
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 45](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L45)
## CE_VOICELOSS

Type: constant

Description: Speeds up stamina recovery.


Replaced value:
```sqf
"whispers"     // Lowers the subject's voice to a whisper
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 46](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L46)
## CE_STIMULANT

Type: constant

Description: Lowers the subject's voice to a whisper


Replaced value:
```sqf
"stimulants"   // Makes it harder to disarm someone
```
File: [host\GameObjects\ConstantAndDefines\Chemistry.h at line 47](../../../Src/host/GameObjects/ConstantAndDefines/Chemistry.h#L47)
# Cleanable.h

## GERM_COUNT_MAX

Type: constant

Description: 


Replaced value:
```sqf
100 
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 7](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L7)
## GERM_LIST_NAMES

Type: constant

Description: 


Replaced value:
```sqf
["","<t color='#ddddbb'>Грязновато</t>","<t color='#aaaa55'>Грязно</t>","<t color='#666633' size='1.3'>Очень грязно</t>","<t color='#4d4d00' size='1.6'>ГРЯЗИЩА</t>"]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 8](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L8)
## GERM_LIST_HUMAN_INFO

Type: constant

Description: 


Replaced value:
```sqf
["","немного грязи","грязь","много грязи","очень грязно"]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 9](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L9)
## GERM_LIST_HUMAN_COLOR

Type: constant

Description: 


Replaced value:
```sqf
["","#ddddbb","#aaaa55","#666633","#4d4d00"]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 10](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L10)
## GERM_LIST_COUNTS

Type: constant

Description: 


Replaced value:
```sqf
[0,20,40,60,GERM_COUNT_MAX]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 11](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L11)
## GERM_COUNT_TO_NAME(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(GERM_LIST_NAMES select (GERM_LIST_COUNTS findif {val <= _x}))
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 12](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L12)
## GERM_HUMAN_COUNT_TO_NAME(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(GERM_LIST_HUMAN_INFO select (GERM_LIST_COUNTS findif {val <= _x}))
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 13](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L13)
## GERM_HUMAN_COUNT_TO_COLOR(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(GERM_LIST_HUMAN_COLOR select (GERM_LIST_COUNTS findif {val <= _x}))
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 14](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L14)
## GERM_COUNT_INFECTION

Type: constant

Description: сколько микробов должно быть для инфекции


Replaced value:
```sqf
25
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 17](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L17)
## GERM_MIN_WOUND_SIZE

Type: constant

Description: минимальный размер раны для инфекции


Replaced value:
```sqf
WOUND_SIZE_MINOR
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 19](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L19)
## INFECTION_MAX_LEVEL

Type: constant

Description: размер инфекции


Replaced value:
```sqf
4
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 21](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L21)
## INFECTION_MIN_LEVEL

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 22](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L22)
## INFECTION_LEVEL_TOSMELL

Type: constant

Description: больше или равно этому значению будет пахнуть


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 24](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L24)
## INFECTION_LEVEL_TO_CAN_HEAL

Type: constant

Description: все что выше этого уровня считается непоправимым и нужно только отрубать конечность


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 27](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L27)
## INFECTION_LIST_DELAY_NEXTLEVEL

Type: constant

Description: Время для уровней. 5+6+10+15 = 36 минуты для уровней 1-4.


Replaced value:
```sqf
[0, 60*5, 60*6, 60*10, 60*15]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 29](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L29)
## INFECTION_LIST_DELAY_NEXTLEVEL

Type: constant

> Exists if **EDITOR** defined

Description: Время для уровней. 5+6+10+15 = 36 минуты для уровней 1-4.


Replaced value:
```sqf
[0, 30, 30, 30, 60]
```
File: [host\GameObjects\ConstantAndDefines\Cleanable.h at line 32](../../../Src/host/GameObjects/ConstantAndDefines/Cleanable.h#L32)
# item_clothing.h

## HEAD

Type: constant

Description: Bitflags for clothing parts.


Replaced value:
```sqf
0x1
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 9](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L9)
## FACE

Type: constant

Description: 


Replaced value:
```sqf
0x2
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 10](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L10)
## EYES

Type: constant

Description: 


Replaced value:
```sqf
0x4
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 11](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L11)
## UPPER_TORSO

Type: constant

Description: 


Replaced value:
```sqf
0x8
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 12](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L12)
## LOWER_TORSO

Type: constant

Description: 


Replaced value:
```sqf
0x10
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 13](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L13)
## TORSO

Type: constant

Description: 


Replaced value:
```sqf
0x18
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 14](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L14)
## LEG_LEFT

Type: constant

Description: 


Replaced value:
```sqf
0x20
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 15](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L15)
## LEG_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
0x40
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 16](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L16)
## LEGS

Type: constant

Description: 


Replaced value:
```sqf
0x60   /*  LEG_LEFT | LEG_RIGHT*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 17](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L17)
## FEET

Type: constant

Description: 


Replaced value:
```sqf
0x180  // FOOT_LEFT | FOOT_RIGHT*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 20](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L20)
## ARM_LEFT

Type: constant

Description: FOOT_LEFT | FOOT_RIGHT*/


Replaced value:
```sqf
0x200
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 21](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L21)
## ARM_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
0x400
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 22](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L22)
## ARMS

Type: constant

Description: 


Replaced value:
```sqf
0x600 /*  ARM_LEFT | ARM_RIGHT*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 23](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L23)
## HANDS

Type: constant

Description: 


Replaced value:
```sqf
0x1800 // HAND_LEFT | HAND_RIGHT*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 26](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L26)
## GROIN

Type: constant

Description: HAND_LEFT | HAND_RIGHT*/


Replaced value:
```sqf
0x2000
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 27](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L27)
## NECK

Type: constant

Description: 


Replaced value:
```sqf
0x4000
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 28](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L28)
## FULL_BODY

Type: constant

Description: 


Replaced value:
```sqf
0xFFFF
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 30](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L30)
## SLOT_BACKPACK

Type: constant

Description: НЕ ИСПОЛЬЗУЕТСЯ


Replaced value:
```sqf
b_0
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 36](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L36)
## SLOT_ARMOR

Type: constant

Description: 


Replaced value:
```sqf
b_1
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 37](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L37)
## SLOT_HEAD

Type: constant

Description: 


Replaced value:
```sqf
b_2
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 38](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L38)
## SLOT_BACK

Type: constant

Description: НЕ ИСПОЛЬЗУЕТСЯ


Replaced value:
```sqf
b_3
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 36](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L36)
## SLOT_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
b_4
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 40](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L40)
## SLOT_FACE

Type: constant

Description: 


Replaced value:
```sqf
b_5
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 41](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L41)
## SLOT_OTHER

Type: constant

Description: 


Replaced value:
```sqf
b_6
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 42](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L42)
## SLOT_HANDS

Type: constant

Description: 


Replaced value:
```sqf
b_7
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 43](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L43)
## SLOT_BELT

Type: constant

Description: 


Replaced value:
```sqf
b_8
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 44](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L44)
## ARMOR_NOTE_ONLYFRONT

Type: constant

Description: Обстоятельства брони


Replaced value:
```sqf
"F" /*Обеспечивает защитой только спереди*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 47](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L47)
## ARMOR_NOTE_DOUBLEDR

Type: constant

Description: Обеспечивает защитой только спереди


Replaced value:
```sqf
"D" /*Двойное сп*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 48](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L48)
## ARMOR_NOTE_HIDE

Type: constant

Description: Двойное сп


Replaced value:
```sqf
"H" /*скрытное ношение*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 49](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L49)
## ARMOR_NOTE_FLEXIBLE

Type: constant

Description: скрытное ношение


Replaced value:
```sqf
"*" /*означает гибкую броню*/]
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 50](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L50)
## EQUIP_HASPART

Type: constant

Description: Флаги возможности экипировывания предмета


Replaced value:
```sqf
0x1
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 53](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L53)
## EQUIP_BLOCKED

Type: constant

Description: 


Replaced value:
```sqf
0x2 /*заблокировано например другим предметом*/
```
File: [host\GameObjects\ConstantAndDefines\item_clothing.h at line 54](../../../Src/host/GameObjects/ConstantAndDefines/item_clothing.h#L54)
# Life.h

## BLOOD_LOSS_VALUE

Type: constant

Description: прим. с 5 царапин тратися 5 ед. а с 1 малой тратится 6 ед


Replaced value:
```sqf
0.00045
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 13](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L13)
## BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(size)

Type: constant

Description: Получает количество единиц крови которые будут затрачены с однйо раны уровня						
- Param: size

Replaced value:
```sqf
(BLOOD_LOSS_VALUE*(6^size))
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 26](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L26)
## BLOOD_LOSS_ARTERY_HEAD

Type: constant

Description: с конечностей за примерно 4 минуты


Replaced value:
```sqf
23
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 31](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L31)
## BLOOD_LOSS_ARTERY_LIMB

Type: constant

Description: 


Replaced value:
```sqf
12
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 32](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L32)
## BLOOD_LOSS_ARTERY_TORSO

Type: constant

Description: 


Replaced value:
```sqf
11
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 33](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L33)
## BLOOD_LOSS_INCISED

Type: constant

Description: 


Replaced value:
```sqf
0.3
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 35](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L35)
## BLOOD_LOSS_ORGAN_DAMAGED

Type: constant

Description: ~28 min


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 39](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L39)
## BLOOD_LOSS_ORGAN_DESTROYED

Type: constant

Description: ~23 min


Replaced value:
```sqf
3.5
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 41](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L41)
## BLOOD_MAX_VALUE_OZ

Type: constant

Description: 5 литров


Replaced value:
```sqf
176.367
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 45](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L45)
## BLOOD_LOWPRESSURE_LEVEL_OZ

Type: constant

Description: уровень ниже которого кровь хуже качается и медленнее вытекает (2 литра)


Replaced value:
```sqf
70.5467
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 48](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L48)
## BLOOD_LOWPRESSURE_FACTOR

Type: constant

Description: при низком кровяном давлении


Replaced value:
```sqf
0.05
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 52](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L52)
## BLOOD_BLOCKED_HEALING_WOUNDSIZE

Type: constant

Description: Раны выше или равные этому уровню залечатся только если забинтованы


Replaced value:
```sqf
WOUND_SIZE_MAJOR
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 55](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L55)
## BLOOD_BLOCKED_BANDAGE_WOUNDSIZE

Type: constant

Description: Бинт не остановит кровотечение если рана этого типа или выше


Replaced value:
```sqf
WOUND_SIZE_CRITICAL
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 58](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L58)
## BLOODPOOL_DISTANCE_TO_CAN_CREATE

Type: constant

Description: Дистанция на которых может быть создана кровь


Replaced value:
```sqf
1.8
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 63](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L63)
## BLOODPOOL_VOLUME_NEED_TO_CREATE

Type: constant

Description: Сколько должно тратиться крови чтобы создать лужу


Replaced value:
```sqf
7
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 66](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L66)
## BLOODPOOL_DELAY_TO_NEXT_CHECK

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 72](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L72)
## BLOODPOOL_DELAY_TO_NEXT_CHECK

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
randInt(20,30)
```
File: [host\GameObjects\ConstantAndDefines\Life.h at line 74](../../../Src/host/GameObjects/ConstantAndDefines/Life.h#L74)
# Mobs.h

## DIR_FRONT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 8](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L8)
## DIR_LEFT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 9](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L9)
## DIR_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 10](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L10)
## DIR_BACK

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 11](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L11)
## DIR_RANDOM

Type: constant

Description: 


Replaced value:
```sqf
(selectRandom[DIR_FRONT,DIR_BACK,DIR_RIGHT,DIR_LEFT])
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 12](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L12)
## BONE_STATUS_OK

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 14](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L14)
## BONE_STATUS_CRACK

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 15](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L15)
## BONE_STATUS_BROKEN

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 16](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L16)
## ORGAN_STATUS_OK

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 18](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L18)
## ORGAN_STATUS_DAMAGED

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 19](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L19)
## ORGAN_STATUS_DESTROYED

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 20](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L20)
## STANCE_UP

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 22](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L22)
## STANCE_MIDDLE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 23](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L23)
## STANCE_DOWN

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 24](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L24)
## SPEED_MODE_STOP

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 26](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L26)
## SPEED_MODE_WALK

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 27](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L27)
## SPEED_MODE_RUN

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 28](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L28)
## SPEED_MODE_SPRINT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 29](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L29)
## LIGHT_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 31](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L31)
## LIGHT_LOW

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 32](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L32)
## LIGHT_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 33](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L33)
## LIGHT_LARGE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 34](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L34)
## LIGHT_FULL

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 35](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L35)
## LIGHT_GET_MODIF_STEALTH(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
([+5,+3,0,-3,-8]select(val))
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 36](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L36)
## VIEW_MODE_NONE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 38](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L38)
## VIEW_MODE_MEDIUM

Type: constant

Description: одного глаза нет например. ухудшенное зрение


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 40](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L40)
## VIEW_MODE_FULL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 41](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L41)
## VISIBILITY_MODE_NONE

Type: constant

Description: Эти значения означают насколько сильно должно быть видно объект. Например при VISIBILITY_MODE_LOW достаточно 1-2 точек видимости из 10


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 45](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L45)
## VISIBILITY_MODE_LOW

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 46](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L46)
## VISIBILITY_MODE_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 47](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L47)
## VISIBILITY_MODE_FULL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 48](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L48)
## UNC_ANIM_LIST

Type: constant

Description: 


Replaced value:
```sqf
["Acts_StaticDeath_04","Acts_StaticDeath_05","Acts_StaticDeath_06","Acts_StaticDeath_10","Acts_StaticDeath_13"]
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 50](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L50)
## UNC_ANIM

Type: constant

Description: 


Replaced value:
```sqf
'Incapacitated'
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 50](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L50)
## DEUNC_ANIM

Type: constant

Description: 


Replaced value:
```sqf
'amovppnemstpsnonwnondnon'
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 52](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L52)
## UNC_MIMIC

Type: constant

Description: 


Replaced value:
```sqf
'unconscious'
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 54](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L54)
## DEFAULT_MIMIC

Type: constant

Description: 


Replaced value:
```sqf
'neutral'
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 55](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L55)
## HUNGER_PER_TICK_LESS

Type: constant

Description: 1.8h for non-activity


Replaced value:
```sqf
0.015
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 60](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L60)
## THIRST_PER_TICK_LESS

Type: constant

Description: rand(0.05,0.06)


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 63](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L63)
## HUNGER_STAMINA_LESS

Type: constant

Description: for non-encum: ~50min regen, for full encum: 16 min


Replaced value:
```sqf
0.034
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 67](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L67)
## HUNGER_UNC_TIME

Type: constant

Description: 


Replaced value:
```sqf
randInt(10,60 * 3)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 69](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L69)
## THIRST_UNC_TIME

Type: constant

Description: 


Replaced value:
```sqf
randInt(10,60 * 2)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 70](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L70)
## PAIN_LEVEL_MAX

Type: constant

Description: ограничения уровней


Replaced value:
```sqf
4
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 74](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L74)
## PAIN_LEVEL_MIN

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 75](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L75)
## PAIN_LEVEL_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 76](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L76)
## PAIN_LEVEL_TO_TEXT(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(["","слабая боль","боль","сильная боль","ужасная боль"] select val)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 78](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L78)
## PAIN_LIST_RESTORE_TIME

Type: constant

Description: 4 уровень боли регенится только лекарствами


Replaced value:
```sqf
[0,120,240,360,1800]
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 82](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L82)
## PAIN_LEVEL_GET_RESTORE_TIME(lvl)

Type: constant

Description: 
- Param: lvl

Replaced value:
```sqf
(PAIN_LIST_RESTORE_TIME select lvl)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 83](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L83)
## PAIN_MAX_AMOUNT

Type: constant

Description: сколько максимально боли может быть на части тела


Replaced value:
```sqf
2520
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 86](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L86)
## PAIN_DEFAULT_RESTORE

Type: constant

Description: по одной единице боли уменьшается за секунду игровой симуляции


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 89](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L89)
## PAIN_SLEEP_RESTORE

Type: constant

Description: за сон уменьшается время боли только если она не агоническая


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 92](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L92)
## ORGAN_HEAL_TIMEOUT

Type: constant

Description: через сколько секунд излечится орган без мед-вмешательства (10 минут)


Replaced value:
```sqf
100
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 97](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L97)
## ORGAN_REGEN_TIME_PRE_SECOND

Type: constant

Description: хил органов во сне (за 2.5 мин)


Replaced value:
```sqf
4
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 99](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L99)
## ORGAN_MEDICAL_REGEN_TIME_PER_SECOND

Type: constant

Description: за 1 минуту лечит органы мед. препаратами


Replaced value:
```sqf
10
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 101](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L101)
## BODY_PART_REGEN_DELAY

Type: constant

Description: 60 секунд должно пройти перед началом регена


Replaced value:
```sqf
60
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 106](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L106)
## BODY_PART_HUNGER_REGEN_LOWLEVEL

Type: constant

Description: если голода осталось ниже этого значения то броски к регену со штрафом


Replaced value:
```sqf
40
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 109](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L109)
## APPEARANCE_UPDATE_DNA

Type: constant

Description: Appearance change flags


Replaced value:
```sqf
0x1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 113](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L113)
## APPEARANCE_RACE

Type: constant

Description: 


Replaced value:
```sqf
(0x2|APPEARANCE_UPDATE_DNA)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 114](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L114)
## APPEARANCE_GENDER

Type: constant

Description: 


Replaced value:
```sqf
(0x4|APPEARANCE_UPDATE_DNA)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 115](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L115)
## APPEARANCE_SKIN

Type: constant

Description: 


Replaced value:
```sqf
0x8
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 116](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L116)
## APPEARANCE_HAIR

Type: constant

Description: 


Replaced value:
```sqf
0x10
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 117](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L117)
## APPEARANCE_HAIR_COLOR

Type: constant

Description: 


Replaced value:
```sqf
0x20
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 118](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L118)
## APPEARANCE_FACIAL_HAIR

Type: constant

Description: 


Replaced value:
```sqf
0x40
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 119](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L119)
## APPEARANCE_FACIAL_HAIR_COLOR

Type: constant

Description: 


Replaced value:
```sqf
0x80
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 120](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L120)
## APPEARANCE_EYE_COLOR

Type: constant

Description: 


Replaced value:
```sqf
0x100
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 121](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L121)
## APPEARANCE_ALL_HAIR

Type: constant

Description: 


Replaced value:
```sqf
(APPEARANCE_HAIR|APPEARANCE_HAIR_COLOR|APPEARANCE_FACIAL_HAIR|APPEARANCE_FACIAL_HAIR_COLOR)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 122](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L122)
## APPEARANCE_ALL

Type: constant

Description: 


Replaced value:
```sqf
0xFFFF
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 122](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L122)
## DEFAULT_SLOW_COOLDOWN

Type: constant

Description: Click cooldown


Replaced value:
```sqf
16 //The default cooldown for slow actions.*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 127](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L127)
## DEFAULT_ATTACK_COOLDOWN

Type: constant

Description: The default cooldown for slow actions.*/


Replaced value:
```sqf
8 //Default timeout for aggressive actions*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 128](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L128)
## DEFAULT_QUICK_COOLDOWN

Type: constant

Description: Default timeout for aggressive actions*/


Replaced value:
```sqf
4
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 129](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L129)
## GLUT_TINY

Type: constant

Description: Gluttony levels.


Replaced value:
```sqf
1       /* Eat anything tiny and smaller*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 132](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L132)
## GLUT_SMALLER

Type: constant

Description: Eat anything tiny and smaller


Replaced value:
```sqf
2    /* Eat anything smaller than we are*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 133](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L133)
## GLUT_ANYTHING

Type: constant

Description: Eat anything smaller than we are


Replaced value:
```sqf
4   /* Eat anything, ever*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 134](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L134)
## GLUT_ITEM_TINY

Type: constant

Description: 


Replaced value:
```sqf
8         /* Eat items with a w_class of small or smaller*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 136](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L136)
## GLUT_ITEM_NORMAL

Type: constant

Description: Eat items with a w_class of small or smaller


Replaced value:
```sqf
16      /* Eat items with a w_class of normal or smaller*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 137](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L137)
## GLUT_ITEM_ANYTHING

Type: constant

Description: Eat items with a w_class of normal or smaller


Replaced value:
```sqf
32    /* Eat any item*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 138](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L138)
## GLUT_PROJECTILE_VOMIT

Type: constant

Description: Eat any item


Replaced value:
```sqf
64 /* When vomitting, does it fly out?*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 139](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L139)
## DEVOUR_SLOW

Type: constant

Description: Devour speeds, returned by can_devour()


Replaced value:
```sqf
1
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 142](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L142)
## DEVOUR_FAST

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 143](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L143)
## INCAPACITATION_NONE

Type: constant

Description: Флаги дееспособности (свои)


Replaced value:
```sqf
0
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 146](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L146)
## INCAPACITATION_STUNNED

Type: constant

Description: 


Replaced value:
```sqf
1 /*оглушение*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 147](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L147)
## INCAPACITATION_KNOCKDOWN

Type: constant

Description: оглушение


Replaced value:
```sqf
2 /*нокдаун. Падение вниз. Короткое время бездействия*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 148](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L148)
## INCAPACITATION_LYING

Type: constant

Description: 


Replaced value:
```sqf
4 /*лежит. либо персонаж лёг на кровать, либо просто лежит в анимке*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 149](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L149)
## INCAPACITATION_RESTRAINED

Type: constant

Description: 


Replaced value:
```sqf
8 /*держится кем-то*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 150](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L150)
## INCAPACITATION_ALL

Type: constant

Description: 


Replaced value:
```sqf
(INCAPACITATION_STUNNED + INCAPACITATION_KNOCKDOWN + INCAPACITATION_LYING + INCAPACITATION_RESTRAINED)
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 152](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L152)
## NUTRITION_LEVEL_FAT

Type: constant

Description: 


Replaced value:
```sqf
550
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 156](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L156)
## NUTRITION_LEVEL_FULL

Type: constant

Description: 


Replaced value:
```sqf
500
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 157](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L157)
## NUTRITION_LEVEL_WELL_FED

Type: constant

Description: 


Replaced value:
```sqf
450
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 158](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L158)
## NUTRITION_LEVEL_FED

Type: constant

Description: 


Replaced value:
```sqf
350
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 159](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L159)
## NUTRITION_LEVEL_HUNGRY

Type: constant

Description: 


Replaced value:
```sqf
250
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 160](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L160)
## NUTRITION_LEVEL_STARVING

Type: constant

Description: 


Replaced value:
```sqf
150
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 161](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L161)
## THIRST_LEVEL_MAX

Type: constant

Description: Thirst levels for humans


Replaced value:
```sqf
800
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 164](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L164)
## THIRST_LEVEL_FILLED

Type: constant

Description: 


Replaced value:
```sqf
600
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 165](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L165)
## THIRST_LEVEL_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
300
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 166](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L166)
## THIRST_LEVEL_THIRSTY

Type: constant

Description: 


Replaced value:
```sqf
200
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 167](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L167)
## THIRST_LEVEL_DEHYDRATED

Type: constant

Description: 


Replaced value:
```sqf
50
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 168](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L168)
## THIRST_FACTOR

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 169](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L169)
## STARVATION_MIN

Type: constant

Description: 


Replaced value:
```sqf
60 /*If you have less nutrition than this value, the hunger indicator starts flashing - THIS ISN'T USED!*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 171](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L171)
## STARVATION_NOTICE

Type: constant

Description: 


Replaced value:
```sqf
45 /*If you have more nutrition than this value, you get an occasional message reminding you that you're going to starve soon*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 172](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L172)
## STARVATION_WEAKNESS

Type: constant

Description: 


Replaced value:
```sqf
20 /*Otherwise, if you have more nutrition than this value, you occasionally become weak and receive minor damage*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 173](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L173)
## STARVATION_NEARDEATH

Type: constant

Description: 


Replaced value:
```sqf
5 /*Otherwise, if you have more nutrition than this value, you have seizures and occasionally receive damage*/
```
File: [host\GameObjects\ConstantAndDefines\Mobs.h at line 174](../../../Src/host/GameObjects/ConstantAndDefines/Mobs.h#L174)
# TimeConstants.h

## TIME_UNCONSCIOUS_ONWOUND

Type: constant

Description: 


Replaced value:
```sqf
randInt(10,60)
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 7](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L7)
## TIME_STUN_ONWOUND

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 9](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L9)
## TIME_RTA_MODIF_READY_FOR_FIGHT

Type: constant

Description: модификатор входа в комбат


Replaced value:
```sqf
0.3
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 12](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L12)
## TIME_RTA_MODIF_ATTACK_MELEE

Type: constant

Description: модификатор для RTA после атаки ближнего боя


Replaced value:
```sqf
1.3
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 14](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L14)
## TIME_RTA_MODIF_ATTACK_RANGED

Type: constant

Description: модификатор задержки времени стрельбы


Replaced value:
```sqf
0.5
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 16](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L16)
## TIME_RTA_MODIF_THROWING

Type: constant

Description: модификатор метания


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 18](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L18)
## TIME_RTA_MODIF_PARRY

Type: constant

Description: модификатор парирования


Replaced value:
```sqf
1.1
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 20](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L20)
## TIME_RTA_MODIF_PARRY_UNBALANCED

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 21](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L21)
## TIME_RTA_MODIF_PARRY_FENCING

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\GameObjects\ConstantAndDefines\TimeConstants.h at line 22](../../../Src/host/GameObjects/ConstantAndDefines/TimeConstants.h#L22)
# Decor.sqf

## oop_internal_decor_makeUnicalName

Type: function

Description: 


File: [host\GameObjects\Decors\Decor.sqf at line 12](../../../Src/host/GameObjects/Decors/Decor.sqf#L12)
# Item.sqf

## DEBUG_TARG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Items\Item.sqf at line 14](../../../Src/host/GameObjects/Items/Item.sqf#L14)
## copyProp(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
setSelf(name,getVar(_item,name))
```
File: [host\GameObjects\Items\Item.sqf at line 727](../../../Src/host/GameObjects/Items/Item.sqf#L727)
## methodReference(name__,parm,refparam)

Type: constant

Description: 
- Param: name__
- Param: parm
- Param: refparam

Replaced value:
```sqf
func(name__) {parm; callFuncParams(getSelf(object),name__,refparam)}
```
File: [host\GameObjects\Items\Item.sqf at line 1124](../../../Src/host/GameObjects/Items/Item.sqf#L1124)
## generateItemSize

Type: function

Description: 
- Param: _bmin
- Param: _bmax
- Param: _radius

File: [host\GameObjects\Items\Item.sqf at line 172](../../../Src/host/GameObjects/Items/Item.sqf#L172)
# Item_HandAnim.hpp

## ANIM_INDEX_HANDED

Type: constant

Description: тип ручной анимации


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 8](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L8)
## ANIM_INDEX_COMBAT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 9](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L9)
## ITEM_HANDANIM_NOFULLBLEND_LIST

Type: constant

Description: список индексов которые подмешивают только ладошку


Replaced value:
```sqf
[ITEM_HANDANIM_LOWERONLYHAND]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 13](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L13)
## ITEM_2HANDANIM_NOFULLBLEND_LIST

Type: constant

Description: тоже самое для двуручки


Replaced value:
```sqf
[]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 15](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L15)
## ITEM_HANDANIM_LIST_ALLANIMS

Type: constant

Description: 


Replaced value:
```sqf
["lwr","lwr","fl","tch","lmp"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 17](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L17)
## ITEM_HANDANIM_ENUM_TO_ANIM(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(ITEM_HANDANIM_LIST_ALLANIMS select (idx))
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 19](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L19)
## ITEM_HANDANIM_LOWER

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 21](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L21)
## ITEM_HANDANIM_LOWERONLYHAND

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 22](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L22)
## ITEM_HANDANIM_FLASHLIGHT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 23](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L23)
## ITEM_HANDANIM_TORCH

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 24](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L24)
## ITEM_HANDANIM_LAMP

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 25](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L25)
## ITEM_TWOHANDANIM_LIST_ALLANIMS

Type: constant

Description: twohanded non combat.


Replaced value:
```sqf
["lwr","swd","pst","rfl","pswda","pswdb","capb"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 28](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L28)
## ITEM_2HANIM_LOWER

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 30](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L30)
## ITEM_2HANIM_SWORD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 31](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L31)
## ITEM_2HANIM_PISTOL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 32](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L32)
## ITEM_2HANIM_RIFLE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 33](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L33)
## ITEM_2HANIM_PARRY_SWORD_1

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 34](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L34)
## ITEM_2HANIM_PARRY_SWORD_2

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 35](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L35)
## ITEM_2HANIM_CAPTIVEBACK

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 36](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L36)
## ITEM_COMBATANIM_LIST_ALLANIMS

Type: constant

Description: Лист для хватов комбата


Replaced value:
```sqf
["hnd","sht","avt","avt"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 41](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L41)
## ITEM_ATTACKANIM_LIST_ALLANIMS

Type: constant

Description: лист для хватов атаки


Replaced value:
```sqf
["hnd","sht","gun","sht"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 43](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L43)
## ITEM_GET_OTHERHAND_ANIM(tex,ret,istwohands)

Type: constant

Description: Получает стейт другой руки при атаке огнестрелом или холодным оружием
- Param: tex
- Param: ret
- Param: istwohands

Replaced value:
```sqf
(if (tex == "gun") then {ret} else {if(istwohands)exitWith{tex};"bck"})
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 46](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L46)
## ITEM_COMBATANIM_ENUM_TO_ANIM(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(ITEM_COMBATANIM_LIST_ALLANIMS select (idx))
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 48](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L48)
## ITEM_ATTACKANIM_ENUM_TO_ANIM(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(ITEM_ATTACKANIM_LIST_ALLANIMS select (idx))
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 49](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L49)
## ITEM_COMBATANIM_HAND

Type: constant

Description: используются данные: ITEM_COMBATANIM_LIST_ALLANIMS для комбат простоя, ITEM_ATTACKANIM_LIST_ALLANIMS для комбат атак


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 52](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L52)
## ITEM_COMBATANIM_SHORT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 53](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L53)
## ITEM_COMBATANIM_GUN

Type: constant

Description: анимация держания оружия но удар рукояткой


Replaced value:
```sqf
2
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 54](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L54)
## ITEM_COMBATANIM_GUN_HANDLE

Type: constant

Description: анимация держания оружия но удар рукояткой


Replaced value:
```sqf
3
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 56](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L56)
## ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS

Type: constant

Description: лист для двуручных хватов комбата


Replaced value:
```sqf
["lwr","swd","pst","rfl"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 59](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L59)
## ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS

Type: constant

Description: Лист для двуручных хватов атаки


Replaced value:
```sqf
["lwr","swd","pst","rfl"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 61](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L61)
## ITEM_2HANIM_COMBAT_LOWER

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 63](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L63)
## ITEM_2HANIM_COMBAT_SWORD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 64](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L64)
## ITEM_2HANIM_COMBAT_PISTOL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 65](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L65)
## ITEM_2HANIM_COMBAT_RIFLE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 66](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L66)
## __item_parry_list_anims__

Type: constant

Description: Всё для парирования


Replaced value:
```sqf
["parh1","parh2","pars1","pars2"]
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 69](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L69)
## ITEM_PARRY_ENUM_TO_ANIM(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(__item_parry_list_anims__ select idx)
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 70](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L70)
## ITEM_PARRY_HAND_1

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 72](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L72)
## ITEM_PARRY_HAND_2

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 73](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L73)
## ITEM_PARRY_SWORD_1

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 74](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L74)
## ITEM_PARRY_SWORD_2

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Items\Item_HandAnim.hpp at line 75](../../../Src/host/GameObjects/Items/Item_HandAnim.hpp#L75)
# Bodyparts.sqf

## _rwt(t)

Type: constant

Description: внутренняя карта для типа раны pair(WOUND_SIZE..,amount)
- Param: t

Replaced value:
```sqf
[t,hashMapNew]
```
File: [host\GameObjects\Items\Bodyparts\Bodyparts.sqf at line 218](../../../Src/host/GameObjects/Items/Bodyparts/Bodyparts.sqf#L218)
# CaptiveBase.sqf

## server_handcuff_internal_random

Type: Variable

Description: системные функции для кодов наручников


Initial value:
```sqf
rand(-99,99)
```
File: [host\GameObjects\Items\Captives\CaptiveBase.sqf at line 41](../../../Src/host/GameObjects/Items/Captives/CaptiveBase.sqf#L41)
## server_handcuff_internal_codeToString

Type: function

Description: 


File: [host\GameObjects\Items\Captives\CaptiveBase.sqf at line 42](../../../Src/host/GameObjects/Items/Captives/CaptiveBase.sqf#L42)
# cloth.sqf

## generateSmartPicture()

Type: constant

Description: getArray(configFile >> "cfgVehicles" >> "FRITH_RUIN_SDR_Tshirt_wht" >> "hiddenSelectionsTextures")
- Param: 

Replaced value:
```sqf
;
```
File: [host\GameObjects\Items\Clothes\cloth.sqf at line 171](../../../Src/host/GameObjects/Items/Clothes/cloth.sqf#L171)
# Books.sqf

## gv(func)

Type: constant

> Exists if **EDITOR** defined

Description: 
- Param: func

Replaced value:
```sqf
_y get #func
```
File: [host\GameObjects\Items\Office\Books.sqf at line 312](../../../Src/host/GameObjects/Items/Office/Books.sqf#L312)
# BasicMob.sqf

## emulate_mp_in_sp

Type: constant

Description: системный макрос эмуляции


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 24](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L24)
## __debug_getinteractiontarget_spheres__

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 209](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L209)
## INTERACT_DIST_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
1.1
```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 240](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L240)
## __animget_impl__()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(getSelf(owner) call anim_getUnitAnim)
```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 668](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L668)
## __data_light_slot__

Type: constant

Description: 


Replaced value:
```sqf
[[INV_BACKPACK,null], [INV_ARMOR,null], [INV_HEAD,null], [INV_BACK,null],[INV_CLOTH,null],[INV_FACE,null],[INV_HAND_R,null],[INV_HAND_L,null],[INV_BELT,null]]
```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 750](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L750)
## debug_internal_getinteractiontarget_spheres

Type: Variable

> Exists if **__debug_getinteractiontarget_spheres__** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\GameObjects\Mobs\BasicMob.sqf at line 211](../../../Src/host/GameObjects/Mobs/BasicMob.sqf#L211)
# Mob.sqf

## __performace_attacklog

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob.sqf at line 25](../../../Src/host/GameObjects/Mobs/Mob.sqf#L25)
## _perf_print()

Type: constant

> Exists if **__performace_attacklog** defined

Description: 
- Param: 

Replaced value:
```sqf
logformat("[PERF::ATTACK]: - %1 sec ========================",tickTime - __log_perf);
```
File: [host\GameObjects\Mobs\Mob.sqf at line 28](../../../Src/host/GameObjects/Mobs/Mob.sqf#L28)
## __perf_print()

Type: constant

> Exists if **__performace_attacklog** not defined

Description: 
- Param: 

Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob.sqf at line 30](../../../Src/host/GameObjects/Mobs/Mob.sqf#L30)
## logmob(funcname,text)

Type: constant

Description: 
- Param: funcname
- Param: text

Replaced value:
```sqf
"debug_console" callExtension ("<server> mob::" + #funcname + "    " + text + "#0111")
```
File: [host\GameObjects\Mobs\Mob.sqf at line 33](../../../Src/host/GameObjects/Mobs/Mob.sqf#L33)
## rp_log(text,fmt)

Type: constant

Description: 
- Param: text
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension ("<server::Roleplay> " + format[text,fmt] + "#0111")
```
File: [host\GameObjects\Mobs\Mob.sqf at line 34](../../../Src/host/GameObjects/Mobs/Mob.sqf#L34)
## DELAY_SHOCK

Type: constant

Description: сколько длится шок


Replaced value:
```sqf
3
```
File: [host\GameObjects\Mobs\Mob.sqf at line 45](../../../Src/host/GameObjects/Mobs/Mob.sqf#L45)
## MOD_DELAY_ATTACK

Type: constant

Description: число делится на bs. Чем меньше значение, тем меньше задержка


Replaced value:
```sqf
10
```
File: [host\GameObjects\Mobs\Mob.sqf at line 47](../../../Src/host/GameObjects/Mobs/Mob.sqf#L47)
## _s(name)

Type: constant

Description: send common
- Param: name

Replaced value:
```sqf
getSelf(name)
```
File: [host\GameObjects\Mobs\Mob.sqf at line 248](../../../Src/host/GameObjects/Mobs/Mob.sqf#L248)
## PIC_PREP

Type: constant

Description: 


Replaced value:
```sqf
<img size='0.8' image='%2'/>
```
File: [host\GameObjects\Mobs\Mob.sqf at line 310](../../../Src/host/GameObjects/Mobs/Mob.sqf#L310)
# MobGhost.sqf

## hasBP(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
!isNullObject(_bpArray getOrDefault [idx arg nullPtr])
```
File: [host\GameObjects\Mobs\MobGhost.sqf at line 87](../../../Src/host/GameObjects/Mobs/MobGhost.sqf#L87)
# MobSkills_idx.hpp

## SKILL_INDEX_ST

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 7](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L7)
## SKILL_INDEX_IQ

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 8](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L8)
## SKILL_INDEX_DX

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 9](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L9)
## SKILL_INDEX_HT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 10](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L10)
## SKILL_INDEX_FP

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 11](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L11)
## SKILL_INDEX_WILL

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 12](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L12)
## SKILL_INDEX_PER

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 13](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L13)
## SKILL_INDEX_HP

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\GameObjects\Mobs\MobSkills_idx.hpp at line 14](../../../Src/host/GameObjects/Mobs/MobSkills_idx.hpp#L14)
# Mob_Combat.sqf

## __performace_attacklog

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 7](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L7)
## _perf_print()

Type: constant

> Exists if **__performace_attacklog** defined

Description: 
- Param: 

Replaced value:
```sqf
logformat("[PERF::ATTACK]: - %1 sec ========================",tickTime - __log_perf);
```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 10](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L10)
## __perf_print()

Type: constant

> Exists if **__performace_attacklog** not defined

Description: 
- Param: 

Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 12](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L12)
## SELECT_SIDEPART(p1,p2)

Type: constant

Description: TODO post check callSelfParams(hasTargetZoneForAttack,_attTargetZone)
- Param: p1
- Param: p2

Replaced value:
```sqf
_d = D6 <= 3; [p1,p2] select _d
```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 672](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L672)
## debuginfo(mes)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: mes

Replaced value:
```sqf
breakpoint("("+getSelf(name)+")::EVENT::("+_mode+") " + mes)
```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 937](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L937)
## debuginfo(mes)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: mes

Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 939](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L939)
## __isZoneIn(zones,modif)

Type: constant

Description: за зону попадания
- Param: zones
- Param: modif

Replaced value:
```sqf
if (_attTargetZone in [zones]) exitWith {MOD(_mod,modif)}
```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 1334](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L1334)
## go_static_internal_map_redirzones

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray[...
```
File: [host\GameObjects\Mobs\Mob_Combat.sqf at line 702](../../../Src/host/GameObjects/Mobs/Mob_Combat.sqf#L702)
# Mob_combat_attdam_enum.hpp

## COMBAT_ATTDAM_ATTACK

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Mobs\Mob_combat_attdam_enum.hpp at line 6](../../../Src/host/GameObjects/Mobs/Mob_combat_attdam_enum.hpp#L6)
## COMBAT_ATTDAM_DAMAGE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Mobs\Mob_combat_attdam_enum.hpp at line 7](../../../Src/host/GameObjects/Mobs/Mob_combat_attdam_enum.hpp#L7)
## COMBAT_ATTDAM_DODGE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Mobs\Mob_combat_attdam_enum.hpp at line 8](../../../Src/host/GameObjects/Mobs/Mob_combat_attdam_enum.hpp#L8)
## COMBAT_ATTDAM_PARRY

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Mobs\Mob_combat_attdam_enum.hpp at line 9](../../../Src/host/GameObjects/Mobs/Mob_combat_attdam_enum.hpp#L9)
## COMBAT_ATTDAM_POINT

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Mobs\Mob_combat_attdam_enum.hpp at line 10](../../../Src/host/GameObjects/Mobs/Mob_combat_attdam_enum.hpp#L10)
# Mob_Emotes.sqf

## addemt(t___)

Type: constant

Description: 
- Param: t___

Replaced value:
```sqf
["emt", #t___ ,"onActEmote"] call ie_actions_regNew
```
File: [host\GameObjects\Mobs\Mob_Emotes.sqf at line 1006](../../../Src/host/GameObjects/Mobs/Mob_Emotes.sqf#L1006)
# Mob_Events.sqf

## use_protect_log

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 6](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L6)
## protectLog(tp,message,format)

Type: constant

> Exists if **use_protect_log** defined

Description: 
- Param: tp
- Param: message
- Param: format

Replaced value:
```sqf
warningformat("Duplicate try catch - " + tp + "; " + message,format)
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 8](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L8)
## protectLog(tp,message,format)

Type: constant

> Exists if **use_protect_log** not defined

Description: 
- Param: tp
- Param: message
- Param: format

Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 10](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L10)
## protectLocMob(event,item,mob,args)

Type: constant

Description: 
- Param: event
- Param: item
- Param: mob
- Param: args

Replaced value:
```sqf
if not_equals(getVar(item,loc),mob) exitWith {protectLog('event'," %1 as %2",getVar(item,pointer) arg callFunc(item,getClassName))}
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 13](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L13)
## protectLocWorld(event,item,args)

Type: constant

Description: 
- Param: event
- Param: item
- Param: args

Replaced value:
```sqf
if (!callFunc(item,isInWorld)) exitWith {protectLog('event'," %1 as %2",getVar(item,pointer) arg callFunc(item,getClassName))}
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 14](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L14)
## __onUpdateImpl(content,varName)

Type: constant

Description: 
- Param: content
- Param: varName

Replaced value:
```sqf
\
_o_upd_impl_internal = { \
	params ["_mobObj","_var"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	setSelf(varName,_var); \
}; rpcAdd('content',_o_upd_impl_internal)
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 446](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L446)
## __onUpdateImplMethod(content,varName)

Type: constant

Description: 
- Param: content
- Param: varName

Replaced value:
```sqf
\
_o_upd_impl_internal = { \
	params ["_mobObj","_var"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	callSelfParams(varName,_var); \
}; rpcAdd('content',_o_upd_impl_internal)
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 453](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L453)
## __onUpdateImplMethodNoParams(content,varName)

Type: constant

Description: 
- Param: content
- Param: varName

Replaced value:
```sqf
\
_o_upd_impl_internal = { \
	params ["_mobObj"]; \
	unrefObject(this,_mobObj,errorformat("Mob object has no exists virtual object - %1",_mobObj)); \
	callSelf(varName); \
}; rpcAdd('content',_o_upd_impl_internal)
```
File: [host\GameObjects\Mobs\Mob_Events.sqf at line 460](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L460)
## repl_doLocal

Type: function

Description: replicator common
- Param: _unit
- Param: _method
- Param: _ctx

File: [host\GameObjects\Mobs\Mob_Events.sqf at line 560](../../../Src/host/GameObjects/Mobs/Mob_Events.sqf#L560)
# Mob_Interact.sqf

## thcheck(r)

Type: constant

Description: 
- Param: r

Replaced value:
```sqf
if (_coefWt <= _val) exitWith {r};
```
File: [host\GameObjects\Mobs\Mob_Interact.sqf at line 513](../../../Src/host/GameObjects/Mobs/Mob_Interact.sqf#L513)
## thadd()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
modvar(_val)+_mod;
```
File: [host\GameObjects\Mobs\Mob_Interact.sqf at line 514](../../../Src/host/GameObjects/Mobs/Mob_Interact.sqf#L514)
## thchange(mod)

Type: constant

Description: 
- Param: mod

Replaced value:
```sqf
_mod = mod;
```
File: [host\GameObjects\Mobs\Mob_Interact.sqf at line 515](../../../Src/host/GameObjects/Mobs/Mob_Interact.sqf#L515)
## mlp(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
'v'
```
File: [host\GameObjects\Mobs\Mob_Interact.sqf at line 1309](../../../Src/host/GameObjects/Mobs/Mob_Interact.sqf#L1309)
# Mob_Inventory.sqf

## __switchVars(prevname,nextname)

Type: constant

Description: __switchVars(otherTargZone,curTargZone)
- Param: prevname
- Param: nextname

Replaced value:
```sqf
_oth = getSelf(prevname); setSelf(prevname,getSelf(nextname)); setSelf(nextname,_oth)
```
File: [host\GameObjects\Mobs\Mob_Inventory.sqf at line 154](../../../Src/host/GameObjects/Mobs/Mob_Inventory.sqf#L154)
# Mob_Life.sqf

## checktime_nextcall

Type: constant

Description: inblood assimilation


Replaced value:
```sqf
randInt(3,4)
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 732](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L732)
## hasBP(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
!isNullObject(_bpArray getOrDefault [idx arg nullPtr])
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 761](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L761)
## AMOUNT_REGEN_STAMINA

Type: constant

Description: =========== stamina regen =========


Replaced value:
```sqf
3.3
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 903](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L903)
## AMOUNT_LESS_STAMINA

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 904](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L904)
## UNC_TO_STAMINALOSS_MIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1159](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1159)
## UNC_TO_STAMINALOSS_MAX

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1160](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1160)
## __dmgAndHp

Type: constant

Description: 


Replaced value:
```sqf
_dmg arg _hp
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1196](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1196)
## log_performance

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1197](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1197)
## lifelog(mes,fmt)

Type: constant

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension (format["[LOG::LIFE]" + (mes) + "#1011",fmt])
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1199](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1199)
## std_check_dam(low,up)

Type: constant

Description: 
- Param: low
- Param: up

Replaced value:
```sqf
if (_dmg >= (low) && _dmg < (up)) exitWith
```
File: [host\GameObjects\Mobs\Mob_Life.sqf at line 1267](../../../Src/host/GameObjects/Mobs/Mob_Life.sqf#L1267)
# Mob_Skills.sqf

## skill_def

Type: constant

Description: 


Replaced value:
```sqf
[10,0]
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 6](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L6)
## SKILL_BASE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 7](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L7)
## SKILL_MOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 8](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L8)
## attr_def

Type: constant

Description: 


Replaced value:
```sqf
[0,0]
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 10](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L10)
## ATTR_BASE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 11](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L11)
## ATTR_MOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 12](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L12)
## replicatePrep(enum,var)

Type: constant

Description: 
- Param: enum
- Param: var

Replaced value:
```sqf
[enum,var]
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 96](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L96)
## great_less(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
max val
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 97](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L97)
## _get_skill_byref(nameref)

Type: constant

Description: 
- Param: nameref

Replaced value:
```sqf
(nameref select SKILL_BASE) + (nameref select SKILL_MOD)
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 98](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L98)
## __alloc_attr(attr,val)

Type: constant

Description: 
- Param: attr
- Param: val

Replaced value:
```sqf
getSelf(attr) set [SKILL_BASE,val]
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 99](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L99)
## __alloc_attr_repl(attr,val,varname)

Type: constant

Description: 
- Param: attr
- Param: val
- Param: varname

Replaced value:
```sqf
private varname = getSelf(attr); varname set [SKILL_BASE,val]
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 100](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L100)
## defFuncSkill(name,recalc,ismod)

Type: constant

Description: 
- Param: name
- Param: recalc
- Param: ismod

Replaced value:
```sqf
__func_noStrName('get' + 'name') {objParams(); private _##name = getSelf(name); ((_##name select SKILL_BASE) + (_##name select SKILL_MOD)) ismod}; \
	__func_noStrName('add' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); MODARR(_ref,SKILL_MOD,+_val); \
		warningformat('Added %1 ed on stat <name>. Now is %2 (%3)',_val arg _ref arg _get_skill_byref(_ref)); \
		recalc \
	}; \
	__func_noStrName('getBase' + 'name') {objParams(); getSelf(name) select SKILL_BASE}; \
	__func_noStrName('getBonus' + 'name') {objParams(); getSelf(name) select SKILL_MOD}; \
	__func_noStrName('init' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); _ref set [SKILL_BASE,_val]; \
		recalc \
	}
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 108](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L108)
## defFuncATTRIBUTE(name,recalc)

Type: constant

Description: 
- Param: name
- Param: recalc

Replaced value:
```sqf
__func_noStrName('get' + 'name') {objParams(); private _##name = getSelf(name); (_##name select SKILL_BASE) + (_##name select SKILL_MOD)}; \
	__func_noStrName('add' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); MODARR(_ref,SKILL_MOD,+_val); \
		recalc \
	}; \
	__func_noStrName('getBase' + 'name') {objParams(); getSelf(name) select SKILL_BASE}; \
	__func_noStrName('getBonus' + 'name') {objParams(); getSelf(name) select SKILL_MOD}; \
	__func_noStrName('init' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); _ref set [SKILL_MOD,_val]; \
		recalc \
	}
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 124](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L124)
## defFuncCommonSkill(name,basev)

Type: constant

Description: накопленный опыт скилла как сама переменная скилла
- Param: name
- Param: basev

Replaced value:
```sqf
__func_noStrName('get' + 'name') { \
		objParams(); \
		basev + getSelf(name) \
	}; \
	 _csl = 'name'; __var_noStrName(_csl,0)
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 138](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L138)
## defFuncCommonSkillOverride(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
__func_noStrName('get' + 'name') { \
		objParams(); \
		getSelf(name) \
	}; \
	_csl = 'name'; __var_noStrName(_csl,0)
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 144](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L144)
## skills_internal_map_nameAssoc

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray[...
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 518](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L518)
## skills_internal_list_otherSkillsSystemNames

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 618](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L618)
## skills_internal_list_otherSkillsSystemNames_withCategories

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\GameObjects\Mobs\Mob_Skills.sqf at line 630](../../../Src/host/GameObjects/Mobs/Mob_Skills.sqf#L630)
# Mob_WoundSystem.sqf

## usesimplog

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 7](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L7)
## simpLog(mes)

Type: constant

> Exists if **usesimplog** defined

Description: 
- Param: mes

Replaced value:
```sqf
trace("[WOUNDRULES::PROC]: " + mes);
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 10](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L10)
## addWoundEvent(eventname)

Type: constant

> Exists if **usesimplog** defined

Description: 
- Param: eventname

Replaced value:
```sqf
if !(#eventname in _deleg_evNames) then {_deleg_events pushBack woundSystem_##eventname; _deleg_evNames pushBack #eventname }; _deleg_callstack pushBack 'eventname'
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 11](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L11)
## simpLog(mes)

Type: constant

> Exists if **usesimplog** not defined

Description: 
- Param: mes

Replaced value:
```sqf

```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 13](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L13)
## addWoundEvent(eventname)

Type: constant

> Exists if **usesimplog** not defined

Description: 
- Param: eventname

Replaced value:
```sqf
if !(#eventname in _deleg_evNames) then {_deleg_events pushBack woundSystem_##eventname; _deleg_evNames pushBack #eventname }
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 14](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L14)
## convWoundToText(size)

Type: constant

Description: 
- Param: size

Replaced value:
```sqf
(["scratch","minor","moderate","major","critical","massive","gawdawful","destruction"] select size)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 17](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L17)
## canPassWound(size)

Type: constant

Description: 
- Param: size

Replaced value:
```sqf
if (_woundSize < size) exitWith {}; simpLog("In size - " + convWoundToText(size) + " (" +str size + ")")
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 18](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L18)
## isMaximizedWound(size)

Type: constant

Description: 
- Param: size

Replaced value:
```sqf
(_woundSize <= size)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 20](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L20)
## postMessageEffect

Type: constant

Description: константная внешняя ссылка


Replaced value:
```sqf
_postMessageEffect
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 23](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L23)
## woundList

Type: constant

Description: список ран для этого стека


Replaced value:
```sqf
_woundArrCurPart
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 25](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L25)
## isWoundType(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
_woundType == type
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 27](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L27)
## isDamageType(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
(_dmgType == type)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 28](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L28)
## hasCountWounds(level,eqVal)

Type: constant

Description: Внутренние проверки в делегатах
- Param: level
- Param: eqVal

Replaced value:
```sqf
((woundList getOrDefault [level,0]) eqVal)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 31](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L31)
## isWoundMoreThan(level)

Type: constant

Description: 
- Param: level

Replaced value:
```sqf
(((keys woundList) findif {_x > level}) != -1)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 32](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L32)
## checkWound(level,eqVal)

Type: constant

Description: 	Если есть столько-то ран уровня level ИЛИЛ есть рана больше этого уровня level
- Param: level
- Param: eqVal

Replaced value:
```sqf
hasCountWounds(level,eqVal) || isWoundMoreThan(level)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 34](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L34)
## canBreakBone()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
!callFunc(_bodyPartObj,isBoneBroken)
```
File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 214](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L214)
## woundSystem_onWoundProcess

Type: function

Description: 


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 38](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L38)
## woundSystem_stunDelegate

Type: function

Description: бросок на оглушение и нокдаун


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 178](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L178)
## woundSystem_breakDelegate

Type: function

Description: перелом


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 212](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L212)
## woundSystem_limbDestroyDelegate

Type: function

Description: потеря конечности


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 266](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L266)
## woundSystem_limbLossDelegate

Type: function

Description: отрубание конечности


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 280](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L280)
## woundSystem_teethLossDelegate

Type: function

Description: потеря зуба


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 294](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L294)
## woundSystem_eyeLossDelegate

Type: function

Description: 


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 305](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L305)
## woundSystem_impalingDelegate

Type: function

Description: 


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 317](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L317)
## woundSystem_arteryDelegate

Type: function

Description: Открытие артерии


File: [host\GameObjects\Mobs\Mob_WoundSystem.sqf at line 358](../../../Src/host/GameObjects/Mobs/Mob_WoundSystem.sqf#L358)
# IStruct.sqf

## PIC_PREP

Type: constant

Description: 


Replaced value:
```sqf
<img size='0.8' image='%2'/>
```
File: [host\GameObjects\Structures\IStruct.sqf at line 45](../../../Src/host/GameObjects/Structures/IStruct.sqf#L45)
# MerchantConsole.hpp

## MC_CAT_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 7](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L7)
## MC_CAT_LIGHT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 8](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L8)
## MC_CAT_WEAPONS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 9](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L9)
## MC_CAT_AMMO

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 10](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L10)
## MC_CAT_FOOD

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 11](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L11)
## MC_CAT_MEDICAL

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 12](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L12)
## MC_CAT_OTHER

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 13](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L13)
## MC_CAT_CONTAINERS

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 14](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L14)
## MC_CAT_MONEY

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 15](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L15)
## MC_CAT_ENEGRY

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 16](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L16)
## MC_CATSYS_LAST_INDEX

Type: constant

Description: 


Replaced value:
```sqf
MC_CAT_ENEGRY
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 18](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L18)
## MC_MODE_MAINMENU

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 20](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L20)
## MC_MODE_SELECTCAT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 21](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L21)
## MC_MODE_CHANGEMON

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 22](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L22)
## MC_MODE_GETSTATUS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 23](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L23)
## MC_MODE_DISABLED

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 24](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L24)
## MC_MODE_CATLIST

Type: constant

Description: тут список предметов


Replaced value:
```sqf
4
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 26](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L26)
## MC_MODE_PRINT

Type: constant

Description: печатка


Replaced value:
```sqf
5
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 28](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L28)
## MC_MAIN_TOTRADE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 30](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L30)
## MC_MAIN_PRINT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 31](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L31)
## MC_MAIN_CHANGEMON

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 32](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L32)
## MC_MAIN_GETSTATUS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 33](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L33)
## MC_MAIN_SWITCHMODE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 34](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L34)
## MC_CATLIST_DEC

Type: constant

Description: уменьшение и увеличение заказа


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 37](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L37)
## MC_CATLIST_INC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 38](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L38)
## MC_PRINT_DO

Type: constant

Description: заказ


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 41](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L41)
## MC_PRINT_CLEAR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 42](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L42)
## MC_GENERIC_BACK

Type: constant

Description: основная команда возврата


Replaced value:
```sqf
-100
```
File: [host\GameObjects\Structures\Containers\MerchantConsole.hpp at line 45](../../../Src/host/GameObjects/Structures/Containers/MerchantConsole.hpp#L45)
# Tech.sqf

## item_data(typename,lowprice,maxprice,ctg,countslow,countsmax)

Type: constant

Description: 
- Param: typename
- Param: lowprice
- Param: maxprice
- Param: ctg
- Param: countslow
- Param: countsmax

Replaced value:
```sqf
[#typename,randInt(lowprice,maxprice),ctg,randInt(countslow,countsmax),[ #typename ,"name",true,"getName"] call oop_getFieldBaseValue]
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 461](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L461)
## rx_pat(txt)

Type: constant

Description: 
- Param: txt

Replaced value:
```sqf
(txt + "\ *\-\ *\d{1,3}[ ]*(шт(ук|уки)?\.?)?")
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 462](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L462)
## regConsole

Type: constant

Description: 


Replaced value:
```sqf
\
	___s = []; \
	___s resize (MC_CATSYS_LAST_INDEX+1); \
	_global_merchantconsole_tradelist = ___s apply {[]}; \
	_global_merchantconsole_catnames = []; \
	var_inlinevalue(tradelist,_global_merchantconsole_tradelist); \
	var_inlinevalue(tradecats,_global_merchantconsole_catnames);
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1108](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1108)
## regCat(cat,namestr)

Type: constant

Description: 
- Param: cat
- Param: namestr

Replaced value:
```sqf
_global_merchantconsole_catnames pushBack [cat,namestr];
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1116](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1116)
## regItem(cat,typename_std,typename_compiled,minprice,maxprice,mincount,maxcount)

Type: constant

Description: 
- Param: cat
- Param: typename_std
- Param: typename_compiled
- Param: minprice
- Param: maxprice
- Param: mincount
- Param: maxcount

Replaced value:
```sqf
_ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack ["",typename_std,{typename_compiled},randInt(minprice,maxprice),randInt(mincount,maxcount),0];
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1118](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1118)
## regEnergyCount(cat,strname,__code,price,count__)

Type: constant

Description: 
- Param: cat
- Param: strname
- Param: __code
- Param: price
- Param: count__

Replaced value:
```sqf
_ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack [strname,"<NULLOBJ>",__code,price,count__,0];
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1121](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1121)
## regItemDef(cat,typename,minpr,maxpr,minc,maxc)

Type: constant

Description: 
- Param: cat
- Param: typename
- Param: minpr
- Param: maxpr
- Param: minc
- Param: maxc

Replaced value:
```sqf
regItem(cat,typename,typename,minpr,maxpr,minc,maxc)
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1124](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1124)
## regItemCustomName(cat,name,typename,minpr,maxpr,minc,maxc)

Type: constant

Description: 
- Param: cat
- Param: name
- Param: typename
- Param: minpr
- Param: maxpr
- Param: minc
- Param: maxc

Replaced value:
```sqf
_ctbuf = _global_merchantconsole_tradelist select cat; \
	_ctbuf pushBack [name,typename,{typename},randInt(minpr,maxpr),randInt(minc,maxc),0];
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1125](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1125)
## regEnProvider(__GENERATED_TIME__)

Type: constant

Description: 
- Param: __GENERATED_TIME__

Replaced value:
```sqf
{ \
		private _gen = ["PowerGenerator",[3827.37,3728.61,17.0241],4,false] call getGameObjectOnPosition; \
		if !isNullReference(_gen) then { \
			modVar(_gen,gettedEnergy,+ randInt(3000,3600)*60* __GENERATED_TIME__); \
		}; \
	}
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1213](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1213)
## checkMode(m__)

Type: constant

Description: 
- Param: m__

Replaced value:
```sqf
if (_mode == m__) exitWith
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1315](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1315)
## compareInput(t__)

Type: constant

Description: 
- Param: t__

Replaced value:
```sqf
if (_userInput == t__) exitWith
```
File: [host\GameObjects\Structures\Containers\Tech.sqf at line 1316](../../../Src/host/GameObjects/Structures/Containers/Tech.sqf#L1316)
# DoorStatic.sqf

## struct_door_initOpenMode

Type: function

Description: for testing [obj,[-0.73,0.7,-1.365],270] call struct_door_initOpenMode;
- Param: _o
- Param: _vecbias
- Param: _dir

File: [host\GameObjects\Structures\Doors\Static\DoorStatic.sqf at line 83](../../../Src/host/GameObjects/Structures/Doors/Static/DoorStatic.sqf#L83)
# Teleport.sqf

## teleportMobToPoint

Type: function

Description: 
- Param: _usr
- Param: _pos
- Param: _dir

File: [host\GameObjects\Structures\Effects\Teleport.sqf at line 10](../../../Src/host/GameObjects/Structures/Effects/Teleport.sqf#L10)
# Zones.sqf

## zoneLocations_map_all

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\GameObjects\Structures\Effects\Zones.sqf at line 10](../../../Src/host/GameObjects/Structures/Effects/Zones.sqf#L10)
# GeneratorParts.sqf

## STD_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\GeneratorParts.sqf at line 46](../../../Src/host/GameObjects/Structures/Electronics/GeneratorParts.sqf#L46)
# Buttons.sqf

## OVERRIDE_ENABLE_AS_ACTIVATOR()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
\
func(activate) {objParams();if (getSelf(edIsEnabled) && getSelf(edIsUsePower)) then {{callFunc(_x,onActivate)} foreach getSelf(edConnected);}; callSelfParams(playSound, "electronics\lightswitch" arg getRandomPitch arg 7);}; \
getter_func(getMainActionName,"Нажать"); \
func(onMainAction) {objParams_1(_usr); callSelf(activate)}
```
File: [host\GameObjects\Structures\Electronics\Buttons\Buttons.sqf at line 10](../../../Src/host/GameObjects/Structures/Electronics/Buttons/Buttons.sqf#L10)
# Control.sqf

## checkMode(m__)

Type: constant

Description: 
- Param: m__

Replaced value:
```sqf
if (_mode == m__) exitWith
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 250](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L250)
## compareInput(t__)

Type: constant

Description: 
- Param: t__

Replaced value:
```sqf
if (_userInput == t__) exitWith
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 251](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L251)
## compareInputAndJump(t__,newmode__)

Type: constant

Description: 
- Param: t__
- Param: newmode__

Replaced value:
```sqf
if (_userInput == t__) exitWith {callSelfParams(setDispMode,newmode__)}
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 252](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L252)
## compareInputAndUseOptData(t__)

Type: constant

Description: 
- Param: t__

Replaced value:
```sqf
if (_userInput == t__) exitWith
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 254](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L254)
## optData

Type: constant

Description: 


Replaced value:
```sqf
_optData
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 255](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L255)
## throwExceptionWithData()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
errorformat("HeadControlPanel::onHandleNDInput() - Unhandled input: %1 (mode: %2, optdat: %3) at line %4",_userInput arg _userMode arg _optData arg __LINE__)
```
File: [host\GameObjects\Structures\Electronics\Devices\Control.sqf at line 257](../../../Src/host/GameObjects/Structures/Electronics/Devices/Control.sqf#L257)
# HeadControlPanel.hpp

## MODE_NOPOWER

Type: constant

Description: 


Replaced value:
```sqf
-1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 7](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L7)
## MODE_MENU

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 8](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L8)
## MODE_ASSIGNROLE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 9](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L9)
## MODE_EXILE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 10](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L10)
## MODE_DECREE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 11](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L11)
## BUTTON_GENERIC_BACK

Type: constant

Description: 


Replaced value:
```sqf
-101
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 13](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L13)
## MENU_BUTTON_TOASSIGNROLE

Type: constant

Description: meun mode buttons


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 16](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L16)
## MENU_BUTTON_TOEXILE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 17](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L17)
## MENU_BUTTON_TODECREE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 18](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L18)
## MENU_BUTTON_ALARM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 19](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L19)
## MENU_BUTTON_ESCAPE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 20](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L20)
## MENU_BUTTON_RETIRE

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 21](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L21)
## MENU_BUTTON_SETHEAD

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 22](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L22)
## ASSIGNROLE_DOASSIGN

Type: constant

Description: assign roles


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 27](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L27)
## EXILE_DOEXILE

Type: constant

Description: exile sub menu


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 30](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L30)
## DECREE_DODECREE

Type: constant

Description: decree sub menu


Replaced value:
```sqf
1
```
File: [host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp at line 33](../../../Src/host/GameObjects/Structures/Electronics/Devices/HeadControlPanel.hpp#L33)
# Kitchen.sqf

## isclass(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
equals(callFunc(_item,getClassName),'type')
```
File: [host\GameObjects\Structures\Kitchen\Kitchen.sqf at line 92](../../../Src/host/GameObjects/Structures/Kitchen/Kitchen.sqf#L92)
# Spawners.sqf

## spawnPos_internal_list_all

Type: Variable

Description: список всех спавнпойнтов


Initial value:
```sqf
[]
```
File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 29](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L29)
## spawnPos_internal_map_equalCollections

Type: Variable

Description: список спавнпойтов по тегу


Initial value:
```sqf
createHashMap
```
File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 31](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L31)
## spawnPos_internal_list_rnd

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 33](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L33)
## isExistsSpawn

Type: function

Description: 
- Param: _name

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 35](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L35)
## isExistsRandomSpawn

Type: function

Description: 
- Param: _name

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 36](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L36)
## getSpawnPosByName

Type: function

Description: 
- Param: _name
- Param: _def (optional, default ['0', '0', '0'])

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 38](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L38)
## getSpawnDirByName

Type: function

Description: 
- Param: _name
- Param: _def (optional, default random 360)

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 48](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L48)
## getRandomSpawnPosByName

Type: function

Description: 
- Param: _pos
- Param: _defpos (optional, default 0)

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 58](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L58)
## getRandomSpawnDirByName

Type: function

Description: 
- Param: _pos
- Param: _dir (optional, default 0)

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 66](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L66)
## getRandomSpawnByNameProvider

Type: function

Description: 
- Param: _name
- Param: _def

File: [host\GameObjects\Structures\Tools\Spawners.sqf at line 74](../../../Src/host/GameObjects/Structures/Tools/Spawners.sqf#L74)
