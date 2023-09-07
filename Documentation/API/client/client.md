# Init.sqf

## cmplog(fcat)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: fcat

Replaced value:
```sqf
allClientContents pushBack (compile format['log("Init %1")',fcat]);
```
File: [client\Init.sqf at line 49](../../../Src/client/Init.sqf#L49)
## cmplog(fcat)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: fcat

Replaced value:
```sqf

```
File: [client\Init.sqf at line 51](../../../Src/client/Init.sqf#L51)
