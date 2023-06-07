# ai_init.sqf

## checkState(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
if equals(_state,name) exitWith
```
File: [host\AI\ai_init.sqf at line 51](../../../Src/host/AI/ai_init.sqf#L51)
## gv(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(_vis getVariable 'ai_##name')
```
File: [host\AI\ai_init.sqf at line 52](../../../Src/host/AI/ai_init.sqf#L52)
## sv(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
_vis setVariable ['ai_##name',val]
```
File: [host\AI\ai_init.sqf at line 53](../../../Src/host/AI/ai_init.sqf#L53)
## ai_createMob

Type: function

Description: 
- Param: _pos
- Param: _stats (optional, default ['10', '10', '10', '10'])

File: [host\AI\ai_init.sqf at line 17](../../../Src/host/AI/ai_init.sqf#L17)
## ai_startSM

Type: function

Description: 
- Param: _visual
- Param: _virtual

File: [host\AI\ai_init.sqf at line 35](../../../Src/host/AI/ai_init.sqf#L35)
## ai_mob_onUpdate

Type: function

Description: 
- Param: _vis
- Param: _virt

File: [host\AI\ai_init.sqf at line 47](../../../Src/host/AI/ai_init.sqf#L47)
