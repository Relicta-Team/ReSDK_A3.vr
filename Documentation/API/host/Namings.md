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
## facesys_generatedConfig

Type: Variable

> Exists if **DEBUG** defined

Description: 


File: [host\Namings\FacesHelpers.sqf at line 12](../../../Src/host/Namings/FacesHelpers.sqf#L12)
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

## loadMobNames(filename)

Type: constant

Description: #define NAMING_VALIDATE_CASING
- Param: filename

Replaced value:
```sqf
['Mobs\##filename##.txt'] call naming_parseNames
```
File: [host\Namings\ParseNaming.sqf at line 12](../../../Src/host/Namings/ParseNaming.sqf#L12)
## naming_list_ManFirstName

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 15](../../../Src/host/Namings/ParseNaming.sqf#L15)
## naming_list_WomanFirstName

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 16](../../../Src/host/Namings/ParseNaming.sqf#L16)
## naming_list_ManCavenick

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 23](../../../Src/host/Namings/ParseNaming.sqf#L23)
## naming_list_WomanCavenick

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 24](../../../Src/host/Namings/ParseNaming.sqf#L24)
## naming_list_ManSecondName

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 26](../../../Src/host/Namings/ParseNaming.sqf#L26)
## naming_list_WomanSecondName

Type: Variable

Description: 


File: [host\Namings\ParseNaming.sqf at line 27](../../../Src/host/Namings/ParseNaming.sqf#L27)
## naming_getRandomName

Type: function

Description: 
- Param: _gender
- Param: _retAsString (optional, default false)

File: [host\Namings\ParseNaming.sqf at line 78](../../../Src/host/Namings/ParseNaming.sqf#L78)
# PrepareFaces.sqf

## faces_list_man

Type: Variable

Description: replicate mp vars


File: [host\Namings\PrepareFaces.sqf at line 14](../../../Src/host/Namings/PrepareFaces.sqf#L14)
## faces_list_woman

Type: Variable

Description: 


File: [host\Namings\PrepareFaces.sqf at line 15](../../../Src/host/Namings/PrepareFaces.sqf#L15)
