# gurps.hpp

## D6

Type: constant

Description: 


Replaced value:
```sqf
(selectRandom[1,2,3,4,5,6])
```
File: [host\GURPS\gurps.hpp at line 7](../../../Src/host/GURPS/gurps.hpp#L7)
## _3D6

Type: constant

Description: 


Replaced value:
```sqf
(D6 + D6 + D6)
```
File: [host\GURPS\gurps.hpp at line 8](../../../Src/host/GURPS/gurps.hpp#L8)
## throw3d6(vs)

Type: constant

Description: 
- Param: vs

Replaced value:
```sqf
((vs) call gurps_rollstd)
```
File: [host\GURPS\gurps.hpp at line 10](../../../Src/host/GURPS/gurps.hpp#L10)
## throw3d6nocrit(vs)

Type: constant

Description: 
- Param: vs

Replaced value:
```sqf
((vs) call gurps_rollnocrit)
```
File: [host\GURPS\gurps.hpp at line 11](../../../Src/host/GURPS/gurps.hpp#L11)
## getRollTypeText(dice_rez)

Type: constant

Description: 
- Param: dice_rez

Replaced value:
```sqf
(["Success","Fail","CritFail","CritSuccess"] select ([DICE_SUCCESS,DICE_FAIL,DICE_CRITFAIL,DICE_CRITSUCCESS] find dice_rez))
```
File: [host\GURPS\gurps.hpp at line 13](../../../Src/host/GURPS/gurps.hpp#L13)
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
File: [host\GURPS\gurps.hpp at line 16](../../../Src/host/GURPS/gurps.hpp#L16)
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
File: [host\GURPS\gurps.hpp at line 18](../../../Src/host/GURPS/gurps.hpp#L18)
## getRollAmount(throwExec)

Type: constant

Description: величина успеха
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 0)
```
File: [host\GURPS\gurps.hpp at line 21](../../../Src/host/GURPS/gurps.hpp#L21)
## getRollType(throwExec)

Type: constant

Description: тип возврата
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 1)
```
File: [host\GURPS\gurps.hpp at line 13](../../../Src/host/GURPS/gurps.hpp#L13)
## getRollDiceAmount(throwExec)

Type: constant

Description: результат 3d6
- Param: throwExec

Replaced value:
```sqf
((throwExec) select 2)
```
File: [host\GURPS\gurps.hpp at line 25](../../../Src/host/GURPS/gurps.hpp#L25)
## DICE_SUCCESS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GURPS\gurps.hpp at line 27](../../../Src/host/GURPS/gurps.hpp#L27)
## DICE_FAIL

Type: constant

Description: 


Replaced value:
```sqf
-1
```
File: [host\GURPS\gurps.hpp at line 28](../../../Src/host/GURPS/gurps.hpp#L28)
## DICE_CRITSUCCESS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GURPS\gurps.hpp at line 29](../../../Src/host/GURPS/gurps.hpp#L29)
## DICE_CRITFAIL

Type: constant

Description: 


Replaced value:
```sqf
-2
```
File: [host\GURPS\gurps.hpp at line 30](../../../Src/host/GURPS/gurps.hpp#L30)
## DICE_RESULT_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
[ \
	'Успех:DICE_SUCCESS' \
	,'Провал:DICE_FAIL' \
	,'Крилический успех:DICE_CRITSUCCESS' \
	,'Критический провал:DICE_CRITFAIL' \
]
```
File: [host\GURPS\gurps.hpp at line 32](../../../Src/host/GURPS/gurps.hpp#L32)
## DICE_ISSUCCESS(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
((v) > 0)
```
File: [host\GURPS\gurps.hpp at line 39](../../../Src/host/GURPS/gurps.hpp#L39)
## DICE_ISFAIL(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
((v) < 0)
```
File: [host\GURPS\gurps.hpp at line 40](../../../Src/host/GURPS/gurps.hpp#L40)
## SKILL_BASE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GURPS\gurps.hpp at line 42](../../../Src/host/GURPS/gurps.hpp#L42)
## SKILL_MOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GURPS\gurps.hpp at line 43](../../../Src/host/GURPS/gurps.hpp#L43)
# Gurps.sqf

## AMOUNT

Type: constant

Description: 


Replaced value:
```sqf
_skill - _d
```
File: [host\GURPS\Gurps.sqf at line 95](../../../Src/host/GURPS/Gurps.sqf#L95)
## RET(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
[AMOUNT,type,_d]
```
File: [host\GURPS\Gurps.sqf at line 96](../../../Src/host/GURPS/Gurps.sqf#L96)
## initWPart(part,val)

Type: constant

Description: 
- Param: part
- Param: val

Replaced value:
```sqf
setVar(_selections get part,weight,val)
```
File: [host\GURPS\Gurps.sqf at line 230](../../../Src/host/GURPS/Gurps.sqf#L230)
## wToPrec(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
_w * (val) / 100
```
File: [host\GURPS\Gurps.sqf at line 231](../../../Src/host/GURPS/Gurps.sqf#L231)
## initWOrg(part,val)

Type: constant

Description: расчёт органов
- Param: part
- Param: val

Replaced value:
```sqf
setVar(_borgans get part,weight,val)
```
File: [host\GURPS\Gurps.sqf at line 247](../../../Src/host/GURPS/Gurps.sqf#L247)
## __ex_ini(part,wei)

Type: constant

Description: 
- Param: part
- Param: wei

Replaced value:
```sqf
MOD(_bodyLeft,- wei); _orgWeight = wToPrec(wei); initWOrg(part,_orgWeight)
```
File: [host\GURPS\Gurps.sqf at line 268](../../../Src/host/GURPS/Gurps.sqf#L268)
## skill_alloc(basicval)

Type: constant

Description: 
- Param: basicval

Replaced value:
```sqf
basicval
```
File: [host\GURPS\Gurps.sqf at line 343](../../../Src/host/GURPS/Gurps.sqf#L343)
## leadToZero(value)

Type: constant

Description: 
- Param: value

Replaced value:
```sqf
(value) max 0
```
File: [host\GURPS\Gurps.sqf at line 378](../../../Src/host/GURPS/Gurps.sqf#L378)
## gurps_throwdices

Type: function

Description: 


File: [host\GURPS\Gurps.sqf at line 29](../../../Src/host/GURPS/Gurps.sqf#L29)
## gurps_rollstd

Type: function

Description: 
- Param: _skill

File: [host\GURPS\Gurps.sqf at line 50](../../../Src/host/GURPS/Gurps.sqf#L50)
## gurps_rollnocrit

Type: function

Description: 
- Param: _skill

File: [host\GURPS\Gurps.sqf at line 92](../../../Src/host/GURPS/Gurps.sqf#L92)
## gurps_getDamageByStrength

Type: function

Description: вычисляет силу удара с руки
- Param: _st

File: [host\GURPS\Gurps.sqf at line 141](../../../Src/host/GURPS/Gurps.sqf#L141)
## gurps_getFallingSpeedByDistance

Type: function

Description: Высчитывает скорость из дистанции по системе
- Param: _dist

File: [host\GURPS\Gurps.sqf at line 159](../../../Src/host/GURPS/Gurps.sqf#L159)
## gurps_calculateCharHeight

Type: function

Description: расчёт роста


File: [host\GURPS\Gurps.sqf at line 172](../../../Src/host/GURPS/Gurps.sqf#L172)
## gurps_calculateCharWeight

Type: function

Description: расчёт веса (Выполняться должен только после создания всех нужных частей тела)


File: [host\GURPS\Gurps.sqf at line 194](../../../Src/host/GURPS/Gurps.sqf#L194)
## gurps_getEncumbrance

Type: function

Description: 


File: [host\GURPS\Gurps.sqf at line 283](../../../Src/host/GURPS/Gurps.sqf#L283)
## gurps_encumLevelToMoveModifier

Type: function

Description: 
- Param: _lvl

File: [host\GURPS\Gurps.sqf at line 295](../../../Src/host/GURPS/Gurps.sqf#L295)
## gurps_recalcuateEncumbrance

Type: function

Description: 


File: [host\GURPS\Gurps.sqf at line 305](../../../Src/host/GURPS/Gurps.sqf#L305)
## gurps_initSkills

Type: function

Description: 
- Param: this
- Param: _st
- Param: _iq
- Param: _dx
- Param: _ht

File: [host\GURPS\Gurps.sqf at line 340](../../../Src/host/GURPS/Gurps.sqf#L340)
## gurps_initPeacefullSkills

Type: function

Description: 


File: [host\GURPS\Gurps.sqf at line 377](../../../Src/host/GURPS/Gurps.sqf#L377)
## gurps_getDistanceModificator

Type: function

Description: модификатор дистанции для стрельбы
- Param: _dist (optional, default 0)
- Param: _speed (optional, default 0)

File: [host\GURPS\Gurps.sqf at line 393](../../../Src/host/GURPS/Gurps.sqf#L393)
## gurps_calculateItemHP

Type: function

Description: 
- Param: _obj
- Param: _weightGr
- Param: _objType

File: [host\GURPS\Gurps.sqf at line 441](../../../Src/host/GURPS/Gurps.sqf#L441)
## gurps_calculateConstructionHP

Type: function

Description: расчетка для построек
- Param: _weight

File: [host\GURPS\Gurps.sqf at line 465](../../../Src/host/GURPS/Gurps.sqf#L465)
## gurps_calculateConstructionWeight

Type: function

Description: 
- Param: _obj

File: [host\GURPS\Gurps.sqf at line 481](../../../Src/host/GURPS/Gurps.sqf#L481)
## gurps_internal_calculateHP

Type: function

Description: only for editor
- Param: _class
- Param: _modelPath
- Param: _matClass

File: [host\GURPS\Gurps.sqf at line 503](../../../Src/host/GURPS/Gurps.sqf#L503)
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
File: [host\GURPS\Gurps_init.sqf at line 9](../../../Src/host/GURPS/Gurps_init.sqf#L9)
## allocSTVal(val,data)

Type: constant

Description: 
- Param: val
- Param: data

Replaced value:
```sqf
obj_gurps_combat set [str val,data]
```
File: [host\GURPS\Gurps_init.sqf at line 10](../../../Src/host/GURPS/Gurps_init.sqf#L10)
## allocSTVal_inArr(vals,data)

Type: constant

Description: 
- Param: vals
- Param: data

Replaced value:
```sqf
{allocSTVal(_x,data)} foreach [vals]
```
File: [host\GURPS\Gurps_init.sqf at line 11](../../../Src/host/GURPS/Gurps_init.sqf#L11)
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
File: [host\GURPS\Gurps_init.sqf at line 12](../../../Src/host/GURPS/Gurps_init.sqf#L12)
## obj_gurps_combat

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\GURPS\Gurps_init.sqf at line 7](../../../Src/host/GURPS/Gurps_init.sqf#L7)
