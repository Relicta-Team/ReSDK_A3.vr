// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(ColorThemes,ct_)

macro_func(ct_registerTheme,void(string))
#define theme(name) ct_internal_currentRegTheme = createHashMap; _name__ = tolower (name); if ((_name__ in ct_map_themes)) exitWith {errorformat("[ColorThemes]: Theme %1 already defined",_name__)}; ct_map_themes set [_name__,ct_internal_currentRegTheme];
macro_func(ct_addProp,void(string,string))
#define var(name,val) _vName__ = tolower (name); _dat__ = [_vName__,val]; if (_vName__ in ct_internal_currentRegTheme) then {warningformat("[ColorThemes]: Double define variable %1 in theme %2",_vName__ arg _name__)}; ct_internal_currentRegTheme set _dat__;

//Копирование параметров
inline_macro
#define copyFrom(__theme,key__) [[tolower '__theme','key__',__LINE__],ct_internal_copy]
inline_macro
#define copy(key__) [[_name__,tolower 'key__',__LINE__],ct_internal_copy]

inline_macro
#define fromHTML(val) [#val] call color_HTMLtoRGBA
inline_macro
#define html(val) #val
