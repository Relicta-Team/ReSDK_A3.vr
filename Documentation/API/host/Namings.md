# FacesHelpers.sqf

## wrongName(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(var in _name || var in _class)
```
File: [host\Namings\FacesHelpers.sqf at line 67](../../../Src/host/Namings/FacesHelpers.sqf#L67)
## facesys_generateConfig

Type: function

> Exists if **DEBUG** defined

Description: Генерирует конфиг для нохедов и лиц


File: [host\Namings\FacesHelpers.sqf at line 14](../../../Src/host/Namings/FacesHelpers.sqf#L14)
## facesys_hasFace

Type: function

Description: 


File: [host\Namings\FacesHelpers.sqf at line 35](../../../Src/host/Namings/FacesHelpers.sqf#L35)
## facesys_prepManFaces

Type: function

Description: 
- Param: _isFemMode (optional, default false)

File: [host\Namings\FacesHelpers.sqf at line 39](../../../Src/host/Namings/FacesHelpers.sqf#L39)
## facesys_prepWomanFaces

Type: function

Description: 


File: [host\Namings\FacesHelpers.sqf at line 79](../../../Src/host/Namings/FacesHelpers.sqf#L79)
# Naming_init.sqf

## naming_parseNames

Type: function

Description: 
- Param: _path

File: [host\Namings\Naming_init.sqf at line 11](../../../Src/host/Namings/Naming_init.sqf#L11)
## naming_generateName

Type: function

Description: Генерирует имя персонажа в разных склонениях
- Param: this
- Param: _f (optional, default "")
- Param: _s (optional, default "")

File: [host\Namings\Naming_init.sqf at line 28](../../../Src/host/Namings/Naming_init.sqf#L28)
## naming_generateName_old

Type: function

Description: 
- Param: this
- Param: _f (optional, default "")
- Param: _s (optional, default "")

File: [host\Namings\Naming_init.sqf at line 67](../../../Src/host/Namings/Naming_init.sqf#L67)
# ParseNaming.sqf

## NAMING_VALIDATE_CASING

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Namings\ParseNaming.sqf at line 9](../../../Src/host/Namings/ParseNaming.sqf#L9)
## loadMobNames(filename)

Type: constant

Description: #define NAMING_VALIDATE_CASING
- Param: filename

Replaced value:
```sqf
['Mobs\##filename##.txt'] call naming_parseNames
```
File: [host\Namings\ParseNaming.sqf at line 12](../../../Src/host/Namings/ParseNaming.sqf#L12)
## naming_getRandomName

Type: function

Description: 
- Param: _gender
- Param: _retAsString (optional, default false)

File: [host\Namings\ParseNaming.sqf at line 78](../../../Src/host/Namings/ParseNaming.sqf#L78)
