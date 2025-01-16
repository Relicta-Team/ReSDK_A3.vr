# ColorThemes.h

## theme(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
ct_internal_currentRegTheme = createHashMap; _name__ = tolower (name); if ((_name__ in ct_map_themes)) exitWith {errorformat("[ColorThemes]: Theme %1 already defined",_name__)}; ct_map_themes set [_name__,ct_internal_currentRegTheme];
```
File: [client\ColorThemes\ColorThemes.h at line 11](../../../Src/client/ColorThemes/ColorThemes.h#L11)
## var(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
_vName__ = tolower (name); _dat__ = [_vName__,val]; if (_vName__ in ct_internal_currentRegTheme) then {warningformat("[ColorThemes]: Double define variable %1 in theme %2",_vName__ arg _name__)}; ct_internal_currentRegTheme set _dat__;
```
File: [client\ColorThemes\ColorThemes.h at line 13](../../../Src/client/ColorThemes/ColorThemes.h#L13)
## copyFrom(__theme,key__)

Type: constant

Description: 
- Param: __theme
- Param: key__

Replaced value:
```sqf
[[tolower '__theme','key__',__LINE__],ct_internal_copy]
```
File: [client\ColorThemes\ColorThemes.h at line 17](../../../Src/client/ColorThemes/ColorThemes.h#L17)
## copy(key__)

Type: constant

Description: 
- Param: key__

Replaced value:
```sqf
[[_name__,tolower 'key__',__LINE__],ct_internal_copy]
```
File: [client\ColorThemes\ColorThemes.h at line 17](../../../Src/client/ColorThemes/ColorThemes.h#L17)
## fromHTML(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
[#val] call color_HTMLtoRGBA
```
File: [client\ColorThemes\ColorThemes.h at line 22](../../../Src/client/ColorThemes/ColorThemes.h#L22)
## html(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
#val
```
File: [client\ColorThemes\ColorThemes.h at line 24](../../../Src/client/ColorThemes/ColorThemes.h#L24)
# ColorThemes_init.sqf

## defVec4

Type: constant

Description: 


Replaced value:
```sqf
vec4(1,1,1,1)
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 12](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L12)
## defHTML

Type: constant

Description: 


Replaced value:
```sqf
"ffffff"
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 14](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L14)
## ct_internal_currentRegTheme

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 17](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L17)
## ct_map_colors

Type: Variable

Description: Помещаем ссылку


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 20](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L20)
## ct_map_defaultColors

Type: Variable

Description: 


Initial value:
```sqf
+ct_map_colors
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 62](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L62)
## ct_map_themes

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 66](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L66)
## ct_load

Type: function

Description: 
- Param: _themeName

File: [client\ColorThemes\ColorThemes_init.sqf at line 68](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L68)
## ct_reset

Type: function

Description: 


File: [client\ColorThemes\ColorThemes_init.sqf at line 87](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L87)
## ct_applyTheme

Type: function

Description: 


File: [client\ColorThemes\ColorThemes_init.sqf at line 93](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L93)
## ct_internal_copy

Type: function

Description: 
- Param: _name
- Param: _key
- Param: _line

File: [client\ColorThemes\ColorThemes_init.sqf at line 124](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L124)
## ct_getValue

Type: function

Description: 
- Param: _name

File: [client\ColorThemes\ColorThemes_init.sqf at line 150](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L150)
## ct_debug_viewColors

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _themeName

File: [client\ColorThemes\ColorThemes_init.sqf at line 158](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L158)
