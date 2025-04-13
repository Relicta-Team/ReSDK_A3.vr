# FileSystem.h

## FSO_INDEX_FILES

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\FileSystem\FileSystem.h at line 6](../../../Src/host/FileSystem/FileSystem.h#L6)
## FSO_INDEX_FOLDERS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\FileSystem\FileSystem.h at line 7](../../../Src/host/FileSystem/FileSystem.h#L7)
## FSO_PATH_DELIMETER

Type: constant

Description: 


Replaced value:
```sqf
"\"
```
File: [host\FileSystem\FileSystem.h at line 9](../../../Src/host/FileSystem/FileSystem.h#L9)
## FSO_NEW_DATA

Type: constant

Description: 


Replaced value:
```sqf
[[],[]]
```
File: [host\FileSystem\FileSystem.h at line 11](../../../Src/host/FileSystem/FileSystem.h#L11)
## FSO_NORMALIZE_PATH(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
((tolower (p)) splitString "\/" joinString FSO_PATH_DELIMETER)
```
File: [host\FileSystem\FileSystem.h at line 13](../../../Src/host/FileSystem/FileSystem.h#L13)
## FSO_PATH_JOIN(p1,p2)

Type: constant

Description: 
- Param: p1
- Param: p2

Replaced value:
```sqf
([p1,p2] joinString FSO_PATH_DELIMETER)
```
File: [host\FileSystem\FileSystem.h at line 15](../../../Src/host/FileSystem/FileSystem.h#L15)
# FileSystem_init.sqf

## fso_map_tree

Type: Variable

Description: 


Initial value:
```sqf
createhashMap //flat object
```
File: [host\FileSystem\FileSystem_init.sqf at line 11](../../../Src/host/FileSystem/FileSystem_init.sqf#L11)
## fso_init

Type: function

Description: initialize filesystem


File: [host\FileSystem\FileSystem_init.sqf at line 15](../../../Src/host/FileSystem/FileSystem_init.sqf#L15)
## fso_buildTree

Type: function

Description: tree builder maker
- Param: _flist

File: [host\FileSystem\FileSystem_init.sqf at line 53](../../../Src/host/FileSystem/FileSystem_init.sqf#L53)
## fso_getFiles

Type: function

Description: 
- Param: _pathDir
- Param: _extension (optional, default "")
- Param: _recursive (optional, default false)
- Param: _internalFlag (optional, default true)

File: [host\FileSystem\FileSystem_init.sqf at line 95](../../../Src/host/FileSystem/FileSystem_init.sqf#L95)
## fso_debug_createTreeExample

Type: function

> Exists if **EDITOR** defined

Description: тестовая функция для просмотра директорий. параметр _t - строка (путь)
- Param: _t

File: [host\FileSystem\FileSystem_init.sqf at line 143](../../../Src/host/FileSystem/FileSystem_init.sqf#L143)
