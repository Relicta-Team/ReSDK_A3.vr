# ColorThemes.h

## theme(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_params__ = createHashMap; _name__ = tolower 'name'; if ((_name__ in ct_map_themes)) exitWith {errorformat("[ColorThemes]: Theme %1 already defined",_name__)}; ct_map_themes set [_name__,_params__];
```
File: [client\ColorThemes\ColorThemes.h at line 8](../../../Src/client/ColorThemes/ColorThemes.h#L8)
## var(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
_vName__ = tolower 'name'; _dat__ = [_vName__,val]; if (_vName__ in _params__) then {warningformat("[ColorThemes]: Double define variable %1 in theme %2",_vName__ arg _name__)}; _params__ set _dat__;
```
File: [client\ColorThemes\ColorThemes.h at line 9](../../../Src/client/ColorThemes/ColorThemes.h#L9)
## copyFrom(__theme,key__)

Type: constant

Description: Копирование параметров
- Param: __theme
- Param: key__

Replaced value:
```sqf
[[tolower '__theme','key__',__LINE__],ct_internal_copy]
```
File: [client\ColorThemes\ColorThemes.h at line 12](../../../Src/client/ColorThemes/ColorThemes.h#L12)
## copy(key__)

Type: constant

Description: Копирование параметров
- Param: key__

Replaced value:
```sqf
[[_name__,tolower 'key__',__LINE__],ct_internal_copy]
```
File: [client\ColorThemes\ColorThemes.h at line 12](../../../Src/client/ColorThemes/ColorThemes.h#L12)
## fromHTML(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
[#val] call color_HTMLtoRGBA
```
File: [client\ColorThemes\ColorThemes.h at line 16](../../../Src/client/ColorThemes/ColorThemes.h#L16)
## html(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
#val
```
File: [client\ColorThemes\ColorThemes.h at line 17](../../../Src/client/ColorThemes/ColorThemes.h#L17)
# ColorThemes_init.sqf

## defVec4

Type: constant

Description: 


Replaced value:
```sqf
vec4(1,1,1,1)
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 10](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L10)
## defHTML

Type: constant

Description: 


Replaced value:
```sqf
"ffffff"
```
File: [client\ColorThemes\ColorThemes_init.sqf at line 11](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L11)
## ct_load

Type: function

Description: 
- Param: _themeName

File: [client\ColorThemes\ColorThemes_init.sqf at line 60](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L60)
## ct_reset

Type: function

Description: Восстанавливает тему по-умолчанию


File: [client\ColorThemes\ColorThemes_init.sqf at line 78](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L78)
## ct_applyTheme

Type: function

Description: Применяет установленную тему из ct_map_colors


File: [client\ColorThemes\ColorThemes_init.sqf at line 83](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L83)
## ct_internal_copy

Type: function

Description: 
- Param: _name
- Param: _key
- Param: _line

File: [client\ColorThemes\ColorThemes_init.sqf at line 114](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L114)
## ct_getValue

Type: function

Description: Возвращает цвет с карты
- Param: _name

File: [client\ColorThemes\ColorThemes_init.sqf at line 139](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L139)
## ct_debug_viewColors

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _themeName

File: [client\ColorThemes\ColorThemes_init.sqf at line 146](../../../Src/client/ColorThemes/ColorThemes_init.sqf#L146)
