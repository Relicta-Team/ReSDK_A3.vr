# FaceList.sqf

## man_list_camo_pre

Type: Variable

Description: 


Initial value:
```sqf
"PersianHead_A3_04_a PersianHead_A3_04_l PersianHead_A3_04_sa WhiteHead_22_a WhiteHead_22_l WhiteHead_22_sa GreekHead_A3_10_a GreekHead_A3_10_l GreekHead_A3_10_sa"
```
File: [host\Namings\FaceList.sqf at line 6](../../../Src/host/Namings/FaceList.sqf#L6)
## man_facelist_pre

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Namings\FaceList.sqf at line 9](../../../Src/host/Namings/FaceList.sqf#L9)
## woman_facelist_pre

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Namings\FaceList.sqf at line 59](../../../Src/host/Namings/FaceList.sqf#L59)
# FaceList_categories.h

## face_list_category

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Namings\FaceList_categories.h at line 6](../../../Src/host/Namings/FaceList_categories.h#L6)
# FacesHelpers.sqf

## facesys_generatedConfig

Type: Variable

> Exists if **DEBUG** defined

Description: 


Initial value:
```sqf
"NO_CALLED"
```
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


File: [host\Namings\FacesHelpers.sqf at line 97](../../../Src/host/Namings/FacesHelpers.sqf#L97)
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


Initial value:
```sqf
loadMobNames(ManFirstName)
```
File: [host\Namings\ParseNaming.sqf at line 15](../../../Src/host/Namings/ParseNaming.sqf#L15)
## naming_list_WomanFirstName

Type: Variable

Description: 


Initial value:
```sqf
loadMobNames(WomanFirstName)
```
File: [host\Namings\ParseNaming.sqf at line 16](../../../Src/host/Namings/ParseNaming.sqf#L16)
## naming_list_ManCavenick

Type: Variable

Description: 


Initial value:
```sqf
loadMobNames(ManCavenick)
```
File: [host\Namings\ParseNaming.sqf at line 23](../../../Src/host/Namings/ParseNaming.sqf#L23)
## naming_list_WomanCavenick

Type: Variable

Description: 


Initial value:
```sqf
loadMobNames(WomanCavenick)
```
File: [host\Namings\ParseNaming.sqf at line 24](../../../Src/host/Namings/ParseNaming.sqf#L24)
## naming_list_ManSecondName

Type: Variable

Description: 


Initial value:
```sqf
loadMobNames(ManSecondName)
```
File: [host\Namings\ParseNaming.sqf at line 26](../../../Src/host/Namings/ParseNaming.sqf#L26)
## naming_list_WomanSecondName

Type: Variable

Description: 


Initial value:
```sqf
loadMobNames(WomanSecondName)
```
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

Description: список всех лиц без категорий


Initial value:
```sqf
[false] call facesys_prepManFaces
```
File: [host\Namings\PrepareFaces.sqf at line 23](../../../Src/host/Namings/PrepareFaces.sqf#L23)
## faces_list_woman

Type: Variable

Description: 


Initial value:
```sqf
call facesys_prepWomanFaces
```
File: [host\Namings\PrepareFaces.sqf at line 24](../../../Src/host/Namings/PrepareFaces.sqf#L24)
## faces_map_man

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key: en-name, value : listfaces
```
File: [host\Namings\PrepareFaces.sqf at line 16](../../../Src/host/Namings/PrepareFaces.sqf#L16)
## faces_map_woman

Type: Variable

Description: key: en-name, value : listfaces


Initial value:
```sqf
createHashMap
```
File: [host\Namings\PrepareFaces.sqf at line 17](../../../Src/host/Namings/PrepareFaces.sqf#L17)
