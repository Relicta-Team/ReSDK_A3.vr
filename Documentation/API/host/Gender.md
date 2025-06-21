# Gender.hpp

## GENDER_MALE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\Gender\Gender.hpp at line 6](../../../Src/host/Gender/Gender.hpp#L6)
## GENDER_FEMALE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Gender\Gender.hpp at line 7](../../../Src/host/Gender/Gender.hpp#L7)
## GENDER_NEUTER

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Gender\Gender.hpp at line 8](../../../Src/host/Gender/Gender.hpp#L8)
## GENDER_LIST_ALL_

Type: constant

Description: 


Replaced value:
```sqf
[GENDER_MALE,GENDER_FEMALE,GENDER_NEUTER]
```
File: [host\Gender\Gender.hpp at line 10](../../../Src/host/Gender/Gender.hpp#L10)
## GENDER_STR_LIST_ALL_

Type: constant

Description: 


Replaced value:
```sqf
["GENDER_MALE","GENDER_FEMALE","GENDER_NEUTER"]
```
File: [host\Gender\Gender.hpp at line 11](../../../Src/host/Gender/Gender.hpp#L11)
## GENDER_PARSESTRING(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(GENDER_LIST_ALL_ select (GENDER_STR_LIST_ALL_ find (val)))
```
File: [host\Gender\Gender.hpp at line 13](../../../Src/host/Gender/Gender.hpp#L13)
# Genders.sqf

## gender_enumToObject

Type: function

Description: Конвертация гендера из типа int в object
- Param: _genderEnum (optional, default GENDER_MALE)

File: [host\Gender\Genders.sqf at line 29](../../../Src/host/Gender/Genders.sqf#L29)
## gender_objectToEnum

Type: function

Description: 
- Param: _genderObj (optional, default gender_male)

File: [host\Gender\Genders.sqf at line 36](../../../Src/host/Gender/Genders.sqf#L36)
