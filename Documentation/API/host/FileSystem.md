# FileSystem_init.sqf

## FSO_INDEX_FILES

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\FileSystem\FileSystem_init.sqf at line 33](../../../Src/host/FileSystem/FileSystem_init.sqf#L33)
## FSO_INDEX_FOLDERS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\FileSystem\FileSystem_init.sqf at line 34](../../../Src/host/FileSystem/FileSystem_init.sqf#L34)
## FSO_PATH_DELIMETER

Type: constant

Description: 


Replaced value:
```sqf
"/"
```
File: [host\FileSystem\FileSystem_init.sqf at line 36](../../../Src/host/FileSystem/FileSystem_init.sqf#L36)
## FSO_NEW_DATA

Type: constant

Description: 


Replaced value:
```sqf
[[],[]]
```
File: [host\FileSystem\FileSystem_init.sqf at line 38](../../../Src/host/FileSystem/FileSystem_init.sqf#L38)
## FSO_NORMALIZE_PATH(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
((tolower (p)) splitString "\/" joinString FSO_PATH_DELIMETER)
```
File: [host\FileSystem\FileSystem_init.sqf at line 40](../../../Src/host/FileSystem/FileSystem_init.sqf#L40)
## FSO_PATH_JOIN(p1,p2)

Type: constant

Description: 
- Param: p1
- Param: p2

Replaced value:
```sqf
([p1,p2] joinString FSO_PATH_DELIMETER)
```
File: [host\FileSystem\FileSystem_init.sqf at line 42](../../../Src/host/FileSystem/FileSystem_init.sqf#L42)
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


File: [host\FileSystem\FileSystem_init.sqf at line 14](../../../Src/host/FileSystem/FileSystem_init.sqf#L14)
## fso_buildTree

Type: function

Description: tree builder maker
- Param: _flist

File: [host\FileSystem\FileSystem_init.sqf at line 47](../../../Src/host/FileSystem/FileSystem_init.sqf#L47)
## fso_getFiles

Type: function

Description: 
- Param: _pathDir
- Param: _extension (optional, default "")
- Param: _recursive (optional, default false)
- Param: _internalFlag (optional, default true)

File: [host\FileSystem\FileSystem_init.sqf at line 89](../../../Src/host/FileSystem/FileSystem_init.sqf#L89)
## fso_debug_createTreeExample

Type: function

> Exists if **EDITOR** defined

Description: тестовая функция для просмотра директорий. параметр _t - строка (путь)
- Param: _t

File: [host\FileSystem\FileSystem_init.sqf at line 133](../../../Src/host/FileSystem/FileSystem_init.sqf#L133)
