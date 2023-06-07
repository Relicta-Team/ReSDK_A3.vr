# CaveSystem.h

## usecavelog

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CaveSystem\CaveSystem.h at line 7](../../../Src/host/CaveSystem/CaveSystem.h#L7)
## gvar(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
cave_##name
```
File: [host\CaveSystem\CaveSystem.h at line 10](../../../Src/host/CaveSystem/CaveSystem.h#L10)
## dfunc(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
cave_##name
```
File: [host\CaveSystem\CaveSystem.h at line 13](../../../Src/host/CaveSystem/CaveSystem.h#L13)
## cfunc(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
call dfunc(name)
```
File: [host\CaveSystem\CaveSystem.h at line 14](../../../Src/host/CaveSystem/CaveSystem.h#L14)
## vector(x,y,z)

Type: constant

Description: 
- Param: x
- Param: y
- Param: z

Replaced value:
```sqf
[x,y,z]
```
File: [host\CaveSystem\CaveSystem.h at line 17](../../../Src/host/CaveSystem/CaveSystem.h#L17)
## get_x(vec)

Type: constant

Description: 
- Param: vec

Replaced value:
```sqf
((vec) select 0)
```
File: [host\CaveSystem\CaveSystem.h at line 19](../../../Src/host/CaveSystem/CaveSystem.h#L19)
## get_y(vec)

Type: constant

Description: 
- Param: vec

Replaced value:
```sqf
((vec) select 1)
```
File: [host\CaveSystem\CaveSystem.h at line 20](../../../Src/host/CaveSystem/CaveSystem.h#L20)
## get_z(vec)

Type: constant

Description: 
- Param: vec

Replaced value:
```sqf
((vec) select 2)
```
File: [host\CaveSystem\CaveSystem.h at line 21](../../../Src/host/CaveSystem/CaveSystem.h#L21)
## set_x(vec,val)

Type: constant

Description: 
- Param: vec
- Param: val

Replaced value:
```sqf
(vec) set [0,val]
```
File: [host\CaveSystem\CaveSystem.h at line 23](../../../Src/host/CaveSystem/CaveSystem.h#L23)
## set_y(vec,val)

Type: constant

Description: 
- Param: vec
- Param: val

Replaced value:
```sqf
(vec) set [1,val]
```
File: [host\CaveSystem\CaveSystem.h at line 24](../../../Src/host/CaveSystem/CaveSystem.h#L24)
## set_z(vec,val)

Type: constant

Description: 
- Param: vec
- Param: val

Replaced value:
```sqf
(vec) set [2,val]
```
File: [host\CaveSystem\CaveSystem.h at line 25](../../../Src/host/CaveSystem/CaveSystem.h#L25)
## math_sign(value)

Type: constant

Description: inline function
- Param: value

Replaced value:
```sqf
(call \
			{ \
				private _idtvl = value; \
				if (_idtvl < 0) exitwith {-1}; \
				if (_idtvl > 0) exitwith {1}; \
				0 \
			})
```
File: [host\CaveSystem\CaveSystem.h at line 29](../../../Src/host/CaveSystem/CaveSystem.h#L29)
## math_max(x,y)

Type: constant

Description: inline helpers for std math
- Param: x
- Param: y

Replaced value:
```sqf
((x) max (y))
```
File: [host\CaveSystem\CaveSystem.h at line 38](../../../Src/host/CaveSystem/CaveSystem.h#L38)
## math_min(x,y)

Type: constant

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
((x) min (y))
```
File: [host\CaveSystem\CaveSystem.h at line 39](../../../Src/host/CaveSystem/CaveSystem.h#L39)
## math_rand(min,max)

Type: constant

Description: 
- Param: min
- Param: max

Replaced value:
```sqf
random((max) - (min)) + (min)
```
File: [host\CaveSystem\CaveSystem.h at line 41](../../../Src/host/CaveSystem/CaveSystem.h#L41)
## setGrid(x,y,z,val)

Type: constant

Description: private inline macro
- Param: x
- Param: y
- Param: z
- Param: val

Replaced value:
```sqf
gvar(grid) select (x) select (y) set [z,val]
```
File: [host\CaveSystem\CaveSystem.h at line 44](../../../Src/host/CaveSystem/CaveSystem.h#L44)
## getGrid(x,y,z)

Type: constant

Description: 
- Param: x
- Param: y
- Param: z

Replaced value:
```sqf
(gvar(grid) select (x) select (y) select (z))
```
File: [host\CaveSystem\CaveSystem.h at line 45](../../../Src/host/CaveSystem/CaveSystem.h#L45)
## cavelog(a)

Type: constant

> Exists if **usecavelog** defined

Description: 
- Param: a

Replaced value:
```sqf

```
File: [host\CaveSystem\CaveSystem.h at line 49](../../../Src/host/CaveSystem/CaveSystem.h#L49)
## cavelogformat(a,f)

Type: constant

> Exists if **usecavelog** defined

Description: 
- Param: a
- Param: f

Replaced value:
```sqf
traceformat("[CAVELOG]:	" + a,f)
```
File: [host\CaveSystem\CaveSystem.h at line 49](../../../Src/host/CaveSystem/CaveSystem.h#L49)
## cavelogformat(a,f)

Type: constant

> Exists if **usecavelog** not defined

Description: 
- Param: a
- Param: f

Replaced value:
```sqf

```
File: [host\CaveSystem\CaveSystem.h at line 52](../../../Src/host/CaveSystem/CaveSystem.h#L52)
# CaveSystem.hpp

## cave_setOptionGeneral(a,b,c,d)

Type: constant

Description: / <param name="optionTurnChanceBranch">Шанс поворота для веток</param>
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
gvar(optionMidwayPoints) = a; gvar(optionSize) = b; gvar(optionTurnChanceEdge) = c; gvar(optionTurnChanceBranch) = d
```
File: [host\CaveSystem\CaveSystem.hpp at line 18](../../../Src/host/CaveSystem/CaveSystem.hpp#L18)
## cave_setOptionBranches(a,b,c,d)

Type: constant

Description: / <param name="branchChance">Шанс заспавнить ветку</param>
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
gvar(branchesMax) = a; gvar(branchSizeMin) = b; gvar(branchSizeMax) = c; gvar(branchChance) = d
```
File: [host\CaveSystem\CaveSystem.hpp at line 27](../../../Src/host/CaveSystem/CaveSystem.hpp#L27)
## cave_setOptionSideBranches(a,b,c,d)

Type: constant

Description: / <param name="branchSideChance">Шанс заспавнить ветку</param>
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
gvar(branchesSideMax) = a; gvar(branchSideSizeMin) = b; gvar(branchSideSizeMax) = c; gvar(branchSideChance) = d
```
File: [host\CaveSystem\CaveSystem.hpp at line 37](../../../Src/host/CaveSystem/CaveSystem.hpp#L37)
## cave_setOptionEntry(a,b)

Type: constant

Description: / <param name="entryExit">Вход конца пещеры</param>
- Param: a
- Param: b

Replaced value:
```sqf
gvar(entryOrigin) = a; gvar(entryExit) = b;
```
File: [host\CaveSystem\CaveSystem.hpp at line 44](../../../Src/host/CaveSystem/CaveSystem.hpp#L44)
# CaveSystem.sqf

## _print(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
conDllCall ((mes) + "#0100")
```
File: [host\CaveSystem\CaveSystem.sqf at line 400](../../../Src/host/CaveSystem/CaveSystem.sqf#L400)
# CaveSystemInit.sqf

## setmdl(strvar)

Type: constant

Description: 
- Param: strvar

Replaced value:
```sqf
setSelf(model,strvar) 
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 423](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L423)
## structmdl(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
["IStruct",{setmdl(p)}]
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 110](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L110)
## structmdlname(p,n)

Type: constant

Description: 
- Param: p
- Param: n

Replaced value:
```sqf
["IStruct",{setmdl(p); setSelf(name,n)}]
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 425](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L425)
## ALG_ITEM

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 538](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L538)
## ALG_STRUCT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 539](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L539)
## ALG_DEC

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 540](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L540)
## GLOBADD(probVal,getInitializer,getCounter,vector_pos,vector_dir,alg_idx)

Type: constant

Description: 
- Param: probVal
- Param: getInitializer
- Param: getCounter
- Param: vector_pos
- Param: vector_dir
- Param: alg_idx

Replaced value:
```sqf
\
		if prob(probVal) then { \
			_cur = getInitializer; \
			_isArray = equalTypes(_cur,[]); \
			_cls = ifcheck(_isArray,_cur select 0,_cur); \
			_inicode = ifcheck(_isArray,_cur select 1,{}); \
			_posvecadd = ifcheck(_isArray && {count _cur >= 3},_cur select 2,vec3(0,0,0)); \
			_algCODE = if (alg_idx == ALG_ITEM) then {{[_cls,_newpos,random 360,false,_newvec] call createItemInWorld}} else { \
				if (alg_idx == ALG_STRUCT)then {{[_cls,_newpos,random 360,_newvec,_inicode] call initStruct}} else { \
					{[_cls,_newpos,random 360,_newvec,_inicode] call initDecor} \
				} \
			}; \
			for "_i" from 1 to randInt(1,getCounter) do { \
				_newpos = (_vPos vectorAdd vector_pos) vectorAdd _posvecadd; \
				_newvec = vector_dir; \
				gvar(objectsList) pushBack (call _algCODE); \
			}; \
		}; 
```
File: [host\CaveSystem\CaveSystemInit.sqf at line 541](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L541)
## initDecor

Type: function

Description: 


File: [host\CaveSystem\CaveSystemInit.sqf at line 414](../../../Src/host/CaveSystem/CaveSystemInit.sqf#L414)
