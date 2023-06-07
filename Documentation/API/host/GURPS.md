# gurps.hpp

## D6

Type: constant
Description: ======================================================


Replaced value:
```sqf
(selectRandom[1,2,3,4,5,6])
```
File: [host\GURPS\gurps.hpp at line 7](../../../src/host/GURPS/gurps.hpp#L7)
## _3D6

Type: constant
Description: 


Replaced value:
```sqf
(D6 + D6 + D6)
```
File: [host\GURPS\gurps.hpp at line 8](../../../src/host/GURPS/gurps.hpp#L8)
## throw3d6(vs)

Type: constant
Description: 
- Param: vs

Replaced value:
```sqf
((vs) call gurps_rollstd)
```
File: [host\GURPS\gurps.hpp at line 10](../../../src/host/GURPS/gurps.hpp#L10)
## throw3d6nocrit(vs)

Type: constant
Description: 
- Param: vs

Replaced value:
```sqf
((vs) call gurps_rollnocrit)
```
File: [host\GURPS\gurps.hpp at line 11](../../../src/host/GURPS/gurps.hpp#L11)
## getRollTypeText(dice_rez)

Type: constant
Description: 
- Param: dice_rez

Replaced value:
```sqf
(["Success","Fail","CritFail","CritSuccess"] select ([DICE_SUCCESS,DICE_FAIL,DICE_CRITFAIL,DICE_CRITSUCCESS] find dice_rez))
```
File: [host\GURPS\gurps.hpp at line 13](../../../src/host/GURPS/gurps.hpp#L13)
## unpackRollResult(rez,amount,diceRez,d36Amount)

Type: constant
Description: прототип _amount,_diceRez,_3d6Amount
- Param: rez
- Param: amount
- Param: diceRez
- Param: d36Amount

Replaced value:
```sqf
(rez) params ['amount','diceRez','d36Amount']
```
File: [host\GURPS\gurps.hpp at line 16](../../../src/host/GURPS/gurps.hpp#L16)
## customRollResult(amnt,type,dices)

Type: constant
Description: 
- Param: amnt
- Param: type
- Param: dices

Replaced value:
```sqf
[amnt,type,dices]
```
File: [host\GURPS\gurps.hpp at line 18](../../../src/host/GURPS/gurps.hpp#L18)
## getRollAmount(throwExec)

Type: constant
Description: величина успеха
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 0)
```
File: [host\GURPS\gurps.hpp at line 21](../../../src/host/GURPS/gurps.hpp#L21)
## getRollType(throwExec)

Type: constant
Description: тип возврата
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 1)
```
File: [host\GURPS\gurps.hpp at line 13](../../../src/host/GURPS/gurps.hpp#L13)
## getRollDiceAmount(throwExec)

Type: constant
Description: результат 3d6
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 2)
```
File: [host\GURPS\gurps.hpp at line 25](../../../src/host/GURPS/gurps.hpp#L25)
## DICE_SUCCESS

Type: constant
Description: 


Replaced value:
```sqf
1
```
File: [host\GURPS\gurps.hpp at line 27](../../../src/host/GURPS/gurps.hpp#L27)
## DICE_FAIL

Type: constant
Description: 


Replaced value:
```sqf
-1
```
File: [host\GURPS\gurps.hpp at line 28](../../../src/host/GURPS/gurps.hpp#L28)
## DICE_CRITSUCCESS

Type: constant
Description: 


Replaced value:
```sqf
2
```
File: [host\GURPS\gurps.hpp at line 29](../../../src/host/GURPS/gurps.hpp#L29)
## DICE_CRITFAIL

Type: constant
Description: 


Replaced value:
```sqf
-2
```
File: [host\GURPS\gurps.hpp at line 30](../../../src/host/GURPS/gurps.hpp#L30)
## DICE_ISSUCCESS(v)

Type: constant
Description: 
- Param: v

Replaced value:
```sqf
((v) > 0)
```
File: [host\GURPS\gurps.hpp at line 32](../../../src/host/GURPS/gurps.hpp#L32)
## DICE_ISFAIL(v)

Type: constant
Description: 
- Param: v

Replaced value:
```sqf
((v) < 0)
```
File: [host\GURPS\gurps.hpp at line 33](../../../src/host/GURPS/gurps.hpp#L33)
## SKILL_BASE

Type: constant
Description: 


Replaced value:
```sqf
0
```
File: [host\GURPS\gurps.hpp at line 35](../../../src/host/GURPS/gurps.hpp#L35)
## SKILL_MOD

Type: constant
Description: 


Replaced value:
```sqf
1
```
File: [host\GURPS\gurps.hpp at line 36](../../../src/host/GURPS/gurps.hpp#L36)
# Gurps.sqf

## log_onEncumbranceRecalculate

Type: constant
Description: 


Replaced value:
```sqf

```
File: [host\GURPS\Gurps.sqf at line 13](../../../src/host/GURPS/Gurps.sqf#L13)
## AMOUNT

Type: constant
Description: 


Replaced value:
```sqf
_skill - _d
```
File: [host\GURPS\Gurps.sqf at line 56](../../../src/host/GURPS/Gurps.sqf#L56)
## RET(type)

Type: constant
Description: 
- Param: type

Replaced value:
```sqf
[AMOUNT,type,_d]
```
File: [host\GURPS\Gurps.sqf at line 57](../../../src/host/GURPS/Gurps.sqf#L57)
## initWPart(part,val)

Type: constant
Description: 
- Param: part
- Param: val

Replaced value:
```sqf
setVar(_selections get part,weight,val)
```
File: [host\GURPS\Gurps.sqf at line 208](../../../src/host/GURPS/Gurps.sqf#L208)
## wToPrec(val)

Type: constant
Description: 
- Param: val

Replaced value:
```sqf
_w * (val) / 100
```
File: [host\GURPS\Gurps.sqf at line 209](../../../src/host/GURPS/Gurps.sqf#L209)
## initWOrg(part,val)

Type: constant
Description: расчёт органов
- Param: part
- Param: val

Replaced value:
```sqf
setVar(_borgans get part,weight,val)
```
File: [host\GURPS\Gurps.sqf at line 225](../../../src/host/GURPS/Gurps.sqf#L225)
## __ex_ini(part,wei)

Type: constant
Description: 
- Param: part
- Param: wei

Replaced value:
```sqf
MOD(_bodyLeft,- wei); _orgWeight = wToPrec(wei); initWOrg(part,_orgWeight)
```
File: [host\GURPS\Gurps.sqf at line 246](../../../src/host/GURPS/Gurps.sqf#L246)
## skill_alloc(basicval)

Type: constant
Description: 
- Param: basicval

Replaced value:
```sqf
basicval
```
File: [host\GURPS\Gurps.sqf at line 304](../../../src/host/GURPS/Gurps.sqf#L304)
## leadToZero(value)

Type: constant
Description: 
- Param: value

Replaced value:
```sqf
(value) max 0
```
File: [host\GURPS\Gurps.sqf at line 339](../../../src/host/GURPS/Gurps.sqf#L339)
## gurps_throwdices

Type: function
Description: #define log_onEncumbranceRecalculate


File: [host\GURPS\Gurps.sqf at line 15](../../../src/host/GURPS/Gurps.sqf#L15)
## gurps_rollstd

Type: function
Description: 
- Param: _skill

File: [host\GURPS\Gurps.sqf at line 23](../../../src/host/GURPS/Gurps.sqf#L23)
## gurps_rollnocrit

Type: function
Description: 
- Param: _skill

File: [host\GURPS\Gurps.sqf at line 53](../../../src/host/GURPS/Gurps.sqf#L53)
## gurps_getDamageByStrength

Type: function
Description: вычисляет силу удара с руки
- Param: _st

File: [host\GURPS\Gurps.sqf at line 69](../../../src/host/GURPS/Gurps.sqf#L69)
## gurps_getFallingSpeedByDistance

Type: function
Description: Высчитывает скорость из дистанции по системе
- Param: _dist

File: [host\GURPS\Gurps.sqf at line 137](../../../src/host/GURPS/Gurps.sqf#L137)
## gurps_calculateCharHeight

Type: function
Description: расчёт роста


File: [host\GURPS\Gurps.sqf at line 150](../../../src/host/GURPS/Gurps.sqf#L150)
## gurps_calculateCharWeight

Type: function
Description: расчёт веса (Выполняться должен только после создания всех нужных частей тела)


File: [host\GURPS\Gurps.sqf at line 172](../../../src/host/GURPS/Gurps.sqf#L172)
## gurps_getEncumbrance

Type: function
Description: 


File: [host\GURPS\Gurps.sqf at line 261](../../../src/host/GURPS/Gurps.sqf#L261)
## gurps_recalcuateEncumbrance

Type: function
Description: 


File: [host\GURPS\Gurps.sqf at line 273](../../../src/host/GURPS/Gurps.sqf#L273)
## gurps_initSkills

Type: function
Description: 
- Param: this
- Param: _st
- Param: _iq
- Param: _dx
- Param: _ht

File: [host\GURPS\Gurps.sqf at line 301](../../../src/host/GURPS/Gurps.sqf#L301)
## gurps_initPeacefullSkills

Type: function
Description: 


File: [host\GURPS\Gurps.sqf at line 338](../../../src/host/GURPS/Gurps.sqf#L338)
## gurps_getDistanceModificator

Type: function
Description: модификатор дистанции для стрельбы
- Param: _dist (optional, default 0)
- Param: _speed (optional, default 0)

File: [host\GURPS\Gurps.sqf at line 354](../../../src/host/GURPS/Gurps.sqf#L354)
# Gurps_init.sqf

## vd(a,b,c,d)

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
File: [host\GURPS\Gurps_init.sqf at line 9](../../../src/host/GURPS/Gurps_init.sqf#L9)
## allocSTVal(val,data)

Type: constant
Description: 
- Param: val
- Param: data

Replaced value:
```sqf
obj_gurps_combat setvariable [str val,data]
```
File: [host\GURPS\Gurps_init.sqf at line 10](../../../src/host/GURPS/Gurps_init.sqf#L10)
## allocSTVal_inArr(vals,data)

Type: constant
Description: 
- Param: vals
- Param: data

Replaced value:
```sqf
{allocSTVal(_x,data)} foreach [vals]
```
File: [host\GURPS\Gurps_init.sqf at line 11](../../../src/host/GURPS/Gurps_init.sqf#L11)
## allocSTVal_inRange_excludeUp(low,up,data)

Type: constant
Description: 
- Param: low
- Param: up
- Param: data

Replaced value:
```sqf
for "_i" from low to (up - 1) do {allocSTVal(_i,data)}
```
File: [host\GURPS\Gurps_init.sqf at line 12](../../../src/host/GURPS/Gurps_init.sqf#L12)
