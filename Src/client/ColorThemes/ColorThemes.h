// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define theme(name) _params__ = createHashMap; _name__ = tolower 'name'; if ((_name__ in ct_map_themes)) exitWith {errorformat("[ColorThemes]: Theme %1 already defined",_name__)}; ct_map_themes set [_name__,_params__];
#define var(name,val) _vName__ = tolower 'name'; _dat__ = [_vName__,val]; if (_vName__ in _params__) then {warningformat("[ColorThemes]: Double define variable %1 in theme %2",_vName__ arg _name__)}; _params__ set _dat__;

//Копирование параметров
#define copyFrom(__theme,key__) [[tolower '__theme','key__',__LINE__],ct_internal_copy]
#define copy(key__) [[_name__,tolower 'key__',__LINE__],ct_internal_copy]


#define fromHTML(val) [#val] call color_HTMLtoRGBA
#define html(val) #val
