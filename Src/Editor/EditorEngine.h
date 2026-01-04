// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define __inline_emptylog() "debug_console" callExtension (" #1111")
#define __inline_log(data) "debug_console" callExtension (format["INLINE_LOG:	%1",data] + "#1111")

#define __FUNC__ ___fn___

#define __fnc_builder_addAttributeAtVar(varname,atrname) if (!isNIL 'varname') then {(__ee_seg select 1) pushBack atrname}

#define function(name) ; __ee_seg = [ #name ,[]]; __fnc_builder_addAttributeAtVar(____exapi,"ext_api"); allFunctions pushBack __ee_seg; __ee_seg pushBack 

#define external_api ;____exapi = true;

#define init_function(name) ;functions_list_init pushBack #name; function(name)

#define componentInit(name) ; if !isNullVar(___component_current_name) then {__inline_log("Component loaded - " + ___component_current_name)}; ___component_current_name = #name;


#define setScopeName(name) private __FUNC__ = name


#define __pragma_line(sharp) sharp##line __LINE__ __FILE__
#define pragma_line __pragma_line(#)

#define variable_define ;