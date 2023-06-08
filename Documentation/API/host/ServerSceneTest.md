# Debug.sqf

## this

Type: Variable

Description: 


Initial value:
```sqf
_vMob
```
File: [host\ServerSceneTest\Debug.sqf at line 7](../../../Src/host/ServerSceneTest/Debug.sqf#L7)
# serverscrene_init.sqf

## vecForward(bias)

Type: constant

Description: 
- Param: bias

Replaced value:
```sqf
(getposatl player) vectorAdd [sin (getdir player) * bias,cos (getdir player) * bias,0]
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 13](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L13)
## dist_it

Type: constant

Description: wm_fists = new(Fists);


Replaced value:
```sqf
1
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 347](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L347)
## forwardPos

Type: constant

Description: 


Replaced value:
```sqf
(getposatl player) vectorAdd [sin (getdir player) * dist_it,cos (getdir player) * dist_it,0]
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 348](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L348)
## randDist_chunk

Type: constant

Description: 


Replaced value:
```sqf
65
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 405](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L405)
## rd

Type: constant

Description: 


Replaced value:
```sqf
rand(-randDist_chunk,randDist_chunk)
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 406](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L406)
## memcloth

Type: Variable

Description: 


Initial value:
```sqf
_virtCloth
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 410](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L410)
## memplay

Type: Variable

Description: 


Initial value:
```sqf
_vMob
```
File: [host\ServerSceneTest\serverscrene_init.sqf at line 411](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L411)
## tptomap

Type: function

Description: 


File: [host\ServerSceneTest\serverscrene_init.sqf at line 20](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L20)
## setnight

Type: function

Description: 


File: [host\ServerSceneTest\serverscrene_init.sqf at line 21](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L21)
## debug_setReadySettings

Type: function

Description: startUpdate(_upd,1);


File: [host\ServerSceneTest\serverscrene_init.sqf at line 33](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L33)
## gm_startFromLobbyCondition

Type: function

> Exists if **ENABLE_LAG_NETWORK** defined

Description: 


File: [host\ServerSceneTest\serverscrene_init.sqf at line 43](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L43)
## debug_asyncCode

Type: function

Description: 


File: [host\ServerSceneTest\serverscrene_init.sqf at line 67](../../../Src/host/ServerSceneTest/serverscrene_init.sqf#L67)
