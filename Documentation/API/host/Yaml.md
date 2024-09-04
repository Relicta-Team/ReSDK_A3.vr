# Yaml_init.sqf

## YAML_EXTENSION_NAME

Type: constant

Description: 


Replaced value:
```sqf
"ReYaml"
```
File: [host\Yaml\Yaml_init.sqf at line 9](../../../Src/host/Yaml/Yaml_init.sqf#L9)
## YAML_COMMAND_PARSE_STRING

Type: constant

Description: 


Replaced value:
```sqf
"parse_string"
```
File: [host\Yaml\Yaml_init.sqf at line 11](../../../Src/host/Yaml/Yaml_init.sqf#L11)
## YAML_COMMAND_HAS_PARTS

Type: constant

Description: 


Replaced value:
```sqf
"has_parts"
```
File: [host\Yaml\Yaml_init.sqf at line 12](../../../Src/host/Yaml/Yaml_init.sqf#L12)
## YAML_COMMAND_READ_PART

Type: constant

Description: 


Replaced value:
```sqf
"next_read"
```
File: [host\Yaml\Yaml_init.sqf at line 13](../../../Src/host/Yaml/Yaml_init.sqf#L13)
## YAML_COMMAND_FREE_PARTS

Type: constant

Description: 


Replaced value:
```sqf
"free_parts"
```
File: [host\Yaml\Yaml_init.sqf at line 15](../../../Src/host/Yaml/Yaml_init.sqf#L15)
## YAML_COMMAND_GET_LEFT_PARTS_COUNT

Type: constant

Description: 


Replaced value:
```sqf
"get_left_parts_count"
```
File: [host\Yaml\Yaml_init.sqf at line 16](../../../Src/host/Yaml/Yaml_init.sqf#L16)
## YAML_COMMAND_SET_DEBUG_PRINT

Type: constant

Description: 


Replaced value:
```sqf
"set_debug"
```
File: [host\Yaml\Yaml_init.sqf at line 18](../../../Src/host/Yaml/Yaml_init.sqf#L18)
## YAML_DEFAULT_CHAR_REPLACER

Type: constant

Description: 


Replaced value:
```sqf
""
```
File: [host\Yaml\Yaml_init.sqf at line 20](../../../Src/host/Yaml/Yaml_init.sqf#L20)
## YAML_OUTPUT_PREFIX_EXCEPTION

Type: constant

Description: 


Replaced value:
```sqf
"$EX$:"
```
File: [host\Yaml\Yaml_init.sqf at line 22](../../../Src/host/Yaml/Yaml_init.sqf#L22)
## YAML_OUTPUT_SANITIZE_EXCEPTION(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
((val) select [count YAML_OUTPUT_PREFIX_EXCEPTION,count (val)])
```
File: [host\Yaml\Yaml_init.sqf at line 23](../../../Src/host/Yaml/Yaml_init.sqf#L23)
## YAML_OUTPUT_PREFIX_PARTIAL

Type: constant

Description: 


Replaced value:
```sqf
"$PART$"
```
File: [host\Yaml\Yaml_init.sqf at line 24](../../../Src/host/Yaml/Yaml_init.sqf#L24)
## yaml_debug_testData

Type: Variable

> Exists if **YAML_TESTS** defined

Description: 


Initial value:
```sqf
"...
```
File: [host\Yaml\Yaml_init.sqf at line 122](../../../Src/host/Yaml/Yaml_init.sqf#L122)
## buf

Type: Variable

Description: 


Initial value:
```sqf
_d1
```
File: [host\Yaml\Yaml_init.sqf at line 139](../../../Src/host/Yaml/Yaml_init.sqf#L139)
## yaml_debug_longData

Type: Variable

Description: 


Initial value:
```sqf
_d joinString endl
```
File: [host\Yaml\Yaml_init.sqf at line 154](../../../Src/host/Yaml/Yaml_init.sqf#L154)
## yaml_debug_fileContent

Type: Variable

Description: 


Initial value:
```sqf
loadfile "src\host\Yaml\test.yaml"
```
File: [host\Yaml\Yaml_init.sqf at line 156](../../../Src/host/Yaml/Yaml_init.sqf#L156)
## yaml_hasPartsForRead

Type: function

Description: есть куски для чтения


File: [host\Yaml\Yaml_init.sqf at line 30](../../../Src/host/Yaml/Yaml_init.sqf#L30)
## yaml_readNextPart

Type: function

Description: прочитать кусок


File: [host\Yaml\Yaml_init.sqf at line 34](../../../Src/host/Yaml/Yaml_init.sqf#L34)
## yaml_freeParts

Type: function

Description: вычистить куски


File: [host\Yaml\Yaml_init.sqf at line 38](../../../Src/host/Yaml/Yaml_init.sqf#L38)
## yaml_getPartsCount

Type: function

Description: получить количество кусков для чтения


File: [host\Yaml\Yaml_init.sqf at line 42](../../../Src/host/Yaml/Yaml_init.sqf#L42)
## yaml_isExtensionLoaded

Type: function

Description: расширение валидно


File: [host\Yaml\Yaml_init.sqf at line 46](../../../Src/host/Yaml/Yaml_init.sqf#L46)
## yaml_loadFile

Type: function

Description: загрузка yml файла. ошибка загрузи или несуществующий файл приведет к возврату null-значения
- Param: _file

File: [host\Yaml\Yaml_init.sqf at line 51](../../../Src/host/Yaml/Yaml_init.sqf#L51)
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

File: [host\Yaml\Yaml_init.sqf at line 112](../../../Src/host/Yaml/Yaml_init.sqf#L112)
