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
## loot_internal_editor_previewBuffer

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\LootSystem\LootSystem_init.sqf at line 166](../../../Src/host/LootSystem/LootSystem_init.sqf#L166)
## loot_init

Type: function

Description: список файлов для загрузки


File: [host\LootSystem\LootSystem_init.sqf at line 13](../../../Src/host/LootSystem/LootSystem_init.sqf#L13)
## loot_addConfig

Type: function

Description: 
- Param: _cfgPath

File: [host\LootSystem\LootSystem_init.sqf at line 21](../../../Src/host/LootSystem/LootSystem_init.sqf#L21)
## loot_prepareAll

Type: function

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 27](../../../Src/host/LootSystem/LootSystem_init.sqf#L27)
## loot_loadConfig

Type: function

Description: 
- Param: _path

File: [host\LootSystem\LootSystem_init.sqf at line 47](../../../Src/host/LootSystem/LootSystem_init.sqf#L47)
## loot_processObject

Type: function

Description: 
- Param: _type
- Param: _obj

File: [host\LootSystem\LootSystem_init.sqf at line 118](../../../Src/host/LootSystem/LootSystem_init.sqf#L118)
## loot_internal_editor_reloadLooting

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 143](../../../Src/host/LootSystem/LootSystem_init.sqf#L143)
## loot_editor_isLoadedLib

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\LootSystem\LootSystem_init.sqf at line 152](../../../Src/host/LootSystem/LootSystem_init.sqf#L152)
## loot_editor_getTemplateByInput

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _input

File: [host\LootSystem\LootSystem_init.sqf at line 156](../../../Src/host/LootSystem/LootSystem_init.sqf#L156)
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
