# BasicDefines.sqf

## printInfoIf(val__,text__,var__)

Type: constant

Description: 
- Param: val__
- Param: text__
- Param: var__

Replaced value:
```sqf
(if (getSelf(var__) val__ ) then {text__ + (str getSelf(var__)) + sbr} else {""})
```
File: [host\GameModes\BasicDefines.sqf at line 194](../../../Src/host/GameModes/BasicDefines.sqf#L194)
## printInfoIf_Handled(val__,text__,var__,__hnd)

Type: constant

Description: 
- Param: val__
- Param: text__
- Param: var__
- Param: __hnd

Replaced value:
```sqf
(if (getSelf(var__) val__ ) then {text__ + (__hnd) + sbr} else {""})
```
File: [host\GameModes\BasicDefines.sqf at line 195](../../../Src/host/GameModes/BasicDefines.sqf#L195)
# BasicTask.sqf

## editor_task_test

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf

```
File: [host\GameModes\BasicTask.sqf at line 22](../../../Src/host/GameModes/BasicTask.sqf#L22)
## taskSystem_allTasks

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameModes\BasicTask.sqf at line 11](../../../Src/host/GameModes/BasicTask.sqf#L11)
## taskSystem_checkedOnEndRound

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameModes\BasicTask.sqf at line 12](../../../Src/host/GameModes/BasicTask.sqf#L12)
## taskSystem_increment

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\GameModes\BasicTask.sqf at line 13](../../../Src/host/GameModes/BasicTask.sqf#L13)
## taskSystem_map_tags

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //map of all tagged tasks
```
File: [host\GameModes\BasicTask.sqf at line 15](../../../Src/host/GameModes/BasicTask.sqf#L15)
# CommonGameAspects.sqf

## DEFAULT_WEIGHT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameModes\CommonGameAspects.sqf at line 9](../../../Src/host/GameModes/CommonGameAspects.sqf#L9)
## proto_class(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
server_gameAspects_list_nopicked pushBack #name; class(name)
```
File: [host\GameModes\CommonGameAspects.sqf at line 10](../../../Src/host/GameModes/CommonGameAspects.sqf#L10)
## server_gameAspects_list_nopicked

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameModes\CommonGameAspects.sqf at line 8](../../../Src/host/GameModes/CommonGameAspects.sqf#L8)
# GameMode.h

## skill(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
['name',val]
```
File: [host\GameModes\GameMode.h at line 13](../../../Src/host/GameModes/GameMode.h#L13)
## skillrand(name,min,max)

Type: constant

Description: 
- Param: name
- Param: min
- Param: max

Replaced value:
```sqf
['name',[min,max]]
```
File: [host\GameModes\GameMode.h at line 14](../../../Src/host/GameModes/GameMode.h#L14)
## regKeyInUniform(cloth,owners,name__)

Type: constant

Description: 
- Param: cloth
- Param: owners
- Param: name__

Replaced value:
```sqf
callFuncParams(cloth,createItemInContainer,"Key" arg null arg null arg [vec3("var","keyOwner",owners) arg vec3("var","name",name__)])
```
File: [host\GameModes\GameMode.h at line 16](../../../Src/host/GameModes/GameMode.h#L16)
## load(path)

Type: constant

Description: 
- Param: path

Replaced value:
```sqf
loadFile("src\host\GameModes\" + (path))
```
File: [host\GameModes\GameMode.h at line 18](../../../Src/host/GameModes/GameMode.h#L18)
## rolerep(pm,potvred,otvet)

Type: constant

Description: 
- Param: pm
- Param: potvred
- Param: otvet

Replaced value:
```sqf
[pm,potvred,otvet]
```
File: [host\GameModes\GameMode.h at line 20](../../../Src/host/GameModes/GameMode.h#L20)
## ROLEREP_INDEX_LOCATION

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\GameModes\GameMode.h at line 21](../../../Src/host/GameModes/GameMode.h#L21)
## ROLEREP_INDEX_POTENTIALHARM

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GameModes\GameMode.h at line 22](../../../Src/host/GameModes/GameMode.h#L22)
## ROLEREP_INDEX_RESPONIBILITY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GameModes\GameMode.h at line 23](../../../Src/host/GameModes/GameMode.h#L23)
# ScriptedSkillsDecl.hpp

## _r(v1,v2)

Type: constant

Description: Тут определеены константы для навыков
- Param: v1
- Param: v2

Replaced value:
```sqf
[v1,v2]
```
File: [host\GameModes\ScriptedSkillsDecl.hpp at line 8](../../../Src/host/GameModes/ScriptedSkillsDecl.hpp#L8)
## skills_nodes_allowedMinSkillDefIndex

Type: Variable

Description: 


Initial value:
```sqf
4
```
File: [host\GameModes\ScriptedSkillsDecl.hpp at line 9](../../../Src/host/GameModes/ScriptedSkillsDecl.hpp#L9)
## skills_nodes_listKinds

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\GameModes\ScriptedSkillsDecl.hpp at line 10](../../../Src/host/GameModes/ScriptedSkillsDecl.hpp#L10)
# DetectiveModeRoles.sqf

## evidCheck(lvl,time,othrcond)

Type: constant

> Exists if **EDITOR** defined

Description: 
- Param: lvl
- Param: time
- Param: othrcond

Replaced value:
```sqf
(_curEvid == lvl && gm_roundDuration >= (time) && othrcond)
```
File: [host\GameModes\Detective\DetectiveModeRoles.sqf at line 355](../../../Src/host/GameModes/Detective/DetectiveModeRoles.sqf#L355)
## evidCheck(lvl,time,othrcond)

Type: constant

> Exists if **EDITOR** not defined

Description: 
- Param: lvl
- Param: time
- Param: othrcond

Replaced value:
```sqf
(_curEvid == lvl && gm_roundDuration >= ((time)*60) && othrcond)
```
File: [host\GameModes\Detective\DetectiveModeRoles.sqf at line 357](../../../Src/host/GameModes/Detective/DetectiveModeRoles.sqf#L357)
# StationRoles.sqf

## regKeyInUniform(cloth,owners,name__)

Type: constant

Description: 
- Param: cloth
- Param: owners
- Param: name__

Replaced value:
```sqf
callFuncParams(cloth,createItemInContainer,"Key" arg null arg null arg [vec3("var","keyOwner",owners) arg vec3("var","name",name__)])
```
File: [host\GameModes\Dirtpit\StationRoles.sqf at line 95](../../../Src/host/GameModes/Dirtpit/StationRoles.sqf#L95)
## gm_getStationRoleList

Type: function

Description: Получает массив ролей с мобами


File: [host\GameModes\Dirtpit\StationRoles.sqf at line 9](../../../Src/host/GameModes/Dirtpit/StationRoles.sqf#L9)
# GM_Hunt.sqf

## gmhunt_debug_canend

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
false
```
File: [host\GameModes\Hunt\GM_Hunt.sqf at line 107](../../../Src/host/GameModes/Hunt/GM_Hunt.sqf#L107)
# HuntRoles.sqf

## DP

Type: constant

Description: 


Replaced value:
```sqf
vec3(3926.05,3961.74,9.64964)
```
File: [host\GameModes\Hunt\HuntRoles.sqf at line 8](../../../Src/host/GameModes/Hunt/HuntRoles.sqf#L8)
# Okopovo.h

## DP

Type: constant

Description: 


Replaced value:
```sqf
vec2("izcmd",[0 arg 0 arg 0]) call getSpawnPosByName
```
File: [host\GameModes\Okopovo\Okopovo.h at line 6](../../../Src/host/GameModes/Okopovo/Okopovo.h#L6)
## DEBUG_TASK

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GameModes\Okopovo\Okopovo.h at line 8](../../../Src/host/GameModes/Okopovo/Okopovo.h#L8)
## DEBUG_TASKNAME

Type: constant

Description: 


Replaced value:
```sqf
"ROkopovoTaskDefend"
```
File: [host\GameModes\Okopovo\Okopovo.h at line 9](../../../Src/host/GameModes/Okopovo/Okopovo.h#L9)
# System.sqf

## global_function_rOkopovo_createDocs

Type: function

Description: 


File: [host\GameModes\Okopovo\System.sqf at line 73](../../../Src/host/GameModes/Okopovo/System.sqf#L73)
# GM_Prey.sqf

## overrideCanPickup

Type: constant

Description: 


Replaced value:
```sqf
\
	func(onPickup) \
	{ \
		objParams_1(_usr); \
		super(); \
		if isTypeOf(getVar(_usr,basicRole),RPreyEater) then { \
			callFuncParams(_usr,meSay,"обессиливает перед священной реликвией"); \
			callFuncParams(_usr,addStaminaLoss,10000); \
		}; \
	}; \
	
```
File: [host\GameModes\Prey\GM_Prey.sqf at line 368](../../../Src/host/GameModes/Prey/GM_Prey.sqf#L368)
# SaloonRoles.sqf

## __isOldGM

Type: constant

Description: 


Replaced value:
```sqf
(callFunc(gm_currentMode,getClassName)=="GMSaloon")
```
File: [host\GameModes\Saloon\SaloonRoles.sqf at line 8](../../../Src/host/GameModes/Saloon/SaloonRoles.sqf#L8)
## __skipIfOldGM

Type: constant

Description: 


Replaced value:
```sqf
if __isOldGM exitWith {null};
```
File: [host\GameModes\Saloon\SaloonRoles.sqf at line 9](../../../Src/host/GameModes/Saloon/SaloonRoles.sqf#L9)
