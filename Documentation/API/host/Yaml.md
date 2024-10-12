# Yaml.h

## YAML_EXTENSION_NAME

Type: constant

Description: 


Replaced value:
```sqf
"ReYaml"
```
File: [host\Yaml\Yaml.h at line 6](../../../Src/host/Yaml/Yaml.h#L6)
## YAML_COMMAND_PARSE_STRING

Type: constant

Description: 


Replaced value:
```sqf
"parse_string"
```
File: [host\Yaml\Yaml.h at line 8](../../../Src/host/Yaml/Yaml.h#L8)
## YAML_COMMAND_HAS_PARTS

Type: constant

Description: 


Replaced value:
```sqf
"has_parts"
```
File: [host\Yaml\Yaml.h at line 9](../../../Src/host/Yaml/Yaml.h#L9)
## YAML_COMMAND_READ_PART

Type: constant

Description: 


Replaced value:
```sqf
"next_read"
```
File: [host\Yaml\Yaml.h at line 10](../../../Src/host/Yaml/Yaml.h#L10)
## YAML_COMMAND_FREE_PARTS

Type: constant

Description: 


Replaced value:
```sqf
"free_parts"
```
File: [host\Yaml\Yaml.h at line 12](../../../Src/host/Yaml/Yaml.h#L12)
## YAML_COMMAND_GET_LEFT_PARTS_COUNT

Type: constant

Description: 


Replaced value:
```sqf
"get_left_parts_count"
```
File: [host\Yaml\Yaml.h at line 13](../../../Src/host/Yaml/Yaml.h#L13)
## YAML_COMMAND_SET_DEBUG_PRINT

Type: constant

Description: 


Replaced value:
```sqf
"set_debug"
```
File: [host\Yaml\Yaml.h at line 15](../../../Src/host/Yaml/Yaml.h#L15)
## YAML_DEFAULT_CHAR_REPLACER

Type: constant

Description: 


Replaced value:
```sqf
""
```
File: [host\Yaml\Yaml.h at line 17](../../../Src/host/Yaml/Yaml.h#L17)
## YAML_OUTPUT_PREFIX_EXCEPTION

Type: constant

Description: 


Replaced value:
```sqf
"$EX$:"
```
File: [host\Yaml\Yaml.h at line 19](../../../Src/host/Yaml/Yaml.h#L19)
## YAML_OUTPUT_SANITIZE_EXCEPTION(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
((val) select [count YAML_OUTPUT_PREFIX_EXCEPTION,count (val)])
```
File: [host\Yaml\Yaml.h at line 20](../../../Src/host/Yaml/Yaml.h#L20)
## YAML_OUTPUT_PREFIX_PARTIAL

Type: constant

Description: 


Replaced value:
```sqf
"$PART$"
```
File: [host\Yaml\Yaml.h at line 21](../../../Src/host/Yaml/Yaml.h#L21)
# Yaml_init.sqf

## yaml_lastErrorLoadFileString

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Yaml\Yaml_init.sqf at line 11](../../../Src/host/Yaml/Yaml_init.sqf#L11)
## yaml_hasPartsForRead

Type: function

Description: есть куски для чтения


File: [host\Yaml\Yaml_init.sqf at line 17](../../../Src/host/Yaml/Yaml_init.sqf#L17)
## yaml_readNextPart

Type: function

Description: прочитать кусок


File: [host\Yaml\Yaml_init.sqf at line 21](../../../Src/host/Yaml/Yaml_init.sqf#L21)
## yaml_freeParts

Type: function

Description: вычистить куски


File: [host\Yaml\Yaml_init.sqf at line 25](../../../Src/host/Yaml/Yaml_init.sqf#L25)
## yaml_getPartsCount

Type: function

Description: получить количество кусков для чтения


File: [host\Yaml\Yaml_init.sqf at line 29](../../../Src/host/Yaml/Yaml_init.sqf#L29)
## yaml_isExtensionLoaded

Type: function

Description: расширение валидно


File: [host\Yaml\Yaml_init.sqf at line 33](../../../Src/host/Yaml/Yaml_init.sqf#L33)
## yaml_getExtensionVersion

Type: function

Description: получает версию расширения в виде массива


File: [host\Yaml\Yaml_init.sqf at line 37](../../../Src/host/Yaml/Yaml_init.sqf#L37)
## yaml_getLastError

Type: function

Description: 


File: [host\Yaml\Yaml_init.sqf at line 44](../../../Src/host/Yaml/Yaml_init.sqf#L44)
## yaml_loadFile

Type: function

Description: загрузка yml файла. ошибка загрузи или несуществующий файл приведет к возврату null-значения
- Param: _file

File: [host\Yaml\Yaml_init.sqf at line 49](../../../Src/host/Yaml/Yaml_init.sqf#L49)
## yaml_loadData

Type: function

Description: 
- Param: _data
- Param: _refData

File: [host\Yaml\Yaml_init.sqf at line 69](../../../Src/host/Yaml/Yaml_init.sqf#L69)
## yaml_setDLLConfig

Type: function

Description: 
- Param: _debugMode (optional, default false)

File: [host\Yaml\Yaml_init.sqf at line 115](../../../Src/host/Yaml/Yaml_init.sqf#L115)
# Yaml_tests.sqf

## yaml_debug_testData

Type: Variable

> Exists if **YAML_TESTS** defined

Description: 


Initial value:
```sqf
"...
```
File: [host\Yaml\Yaml_tests.sqf at line 9](../../../Src/host/Yaml/Yaml_tests.sqf#L9)
## buf

Type: Variable

Description: 


Initial value:
```sqf
_d1
```
File: [host\Yaml\Yaml_tests.sqf at line 26](../../../Src/host/Yaml/Yaml_tests.sqf#L26)
## yaml_debug_longData

Type: Variable

Description: 


Initial value:
```sqf
_d joinString endl
```
File: [host\Yaml\Yaml_tests.sqf at line 41](../../../Src/host/Yaml/Yaml_tests.sqf#L41)
## yaml_debug_fileContent

Type: Variable

Description: 


Initial value:
```sqf
loadfile "src\host\Yaml\test.yaml"
```
File: [host\Yaml\Yaml_tests.sqf at line 43](../../../Src/host/Yaml/Yaml_tests.sqf#L43)
