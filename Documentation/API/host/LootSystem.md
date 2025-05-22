# LootSystem_init.sqf

## loot_mapConfigs

Type: Variable

Description: cleanup all


Initial value:
```sqf
createHashMap //all crafts map
```
File: [host\LootSystem\LootSystem_init.sqf at line 10](../../../Src/host/LootSystem/LootSystem_init.sqf#L10)
## loot_mapTemplates

Type: Variable

Description: all crafts map


Initial value:
```sqf
createHashMap //template map (tagged)
```
File: [host\LootSystem\LootSystem_init.sqf at line 11](../../../Src/host/LootSystem/LootSystem_init.sqf#L11)
## loot_list_loader

Type: Variable

Description: template map (tagged)


Initial value:
```sqf
[]// список файлов для загрузки
```
File: [host\LootSystem\LootSystem_init.sqf at line 12](../../../Src/host/LootSystem/LootSystem_init.sqf#L12)
## loot_internal_catchedError

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
false
```
File: [host\LootSystem\LootSystem_init.sqf at line 15](../../../Src/host/LootSystem/LootSystem_init.sqf#L15)
## loot_internal_editor_previewBuffer

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\LootSystem\LootSystem_init.sqf at line 175](../../../Src/host/LootSystem/LootSystem_init.sqf#L175)
## loot_init

Type: function

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 18](../../../Src/host/LootSystem/LootSystem_init.sqf#L18)
## loot_addConfig

Type: function

Description: 
- Param: _cfgPath

File: [host\LootSystem\LootSystem_init.sqf at line 26](../../../Src/host/LootSystem/LootSystem_init.sqf#L26)
## loot_prepareAll

Type: function

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 32](../../../Src/host/LootSystem/LootSystem_init.sqf#L32)
## loot_loadConfig

Type: function

Description: 
- Param: _path

File: [host\LootSystem\LootSystem_init.sqf at line 56](../../../Src/host/LootSystem/LootSystem_init.sqf#L56)
## loot_processObject

Type: function

Description: 
- Param: _type
- Param: _obj

File: [host\LootSystem\LootSystem_init.sqf at line 127](../../../Src/host/LootSystem/LootSystem_init.sqf#L127)
## loot_internal_editor_reloadLooting

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 152](../../../Src/host/LootSystem/LootSystem_init.sqf#L152)
## loot_editor_isLoadedLib

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 161](../../../Src/host/LootSystem/LootSystem_init.sqf#L161)
## loot_editor_getTemplateByInput

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _input

File: [host\LootSystem\LootSystem_init.sqf at line 165](../../../Src/host/LootSystem/LootSystem_init.sqf#L165)
# LootSystem_structs.sqf

## LOOT_COMPARE_BY_NAME

Type: constant

Description: 


Replaced value:
```sqf
'name'
```
File: [host\LootSystem\LootSystem_structs.sqf at line 10](../../../Src/host/LootSystem/LootSystem_structs.sqf#L10)
## LOOT_COMPARE_BY_REGEX

Type: constant

Description: 


Replaced value:
```sqf
'regex'
```
File: [host\LootSystem\LootSystem_structs.sqf at line 11](../../../Src/host/LootSystem/LootSystem_structs.sqf#L11)
## LOOT_COMPARE_BY_TYPEOF

Type: constant

Description: 


Replaced value:
```sqf
'typeof'
```
File: [host\LootSystem\LootSystem_structs.sqf at line 12](../../../Src/host/LootSystem/LootSystem_structs.sqf#L12)
## LOOT_COMPARE_MODE_MAP

Type: constant

Description: 


Replaced value:
```sqf
'map'
```
File: [host\LootSystem\LootSystem_structs.sqf at line 14](../../../Src/host/LootSystem/LootSystem_structs.sqf#L14)
## LOOT_COMPARE_MODE_GAMEMODE

Type: constant

Description: 


Replaced value:
```sqf
'gamemode'
```
File: [host\LootSystem\LootSystem_structs.sqf at line 15](../../../Src/host/LootSystem/LootSystem_structs.sqf#L15)
