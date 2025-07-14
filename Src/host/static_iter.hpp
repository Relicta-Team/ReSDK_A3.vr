// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
    Static iter header lib

    Used for generate compile-time iterator
*/

#ifdef ENABLE_STATIC_FOR_DEBUG
    #define __static_for_debug_message logformat("Generator static_for at %1",_tok);
#else
    #define __static_for_debug_message
#endif
#define static_for(varname, startindex, endindex, code) \
    [format["%1-%2",__FILE__,__LINE__]] call { \
        params ["_tok"]; \
        private _c = statfor_map_generator get _tok; \
        if (isnil "_c") then { \
            private _stack = ['private varname = startindex;']; \
            for "_i" from (startindex) to (endindex) do { \
                _stack pushBack ((tostring (code))+';varname = varname + 1;'); \
            }; __static_for_debug_message \
            _c = compile (_stack joinString endl); \
            statfor_map_generator set [_tok,_c]; \
        }; \
        call _c; \
    }


;if (isnil {statfor_map_generator}) then {
    statfor_map_generator = createhashmap;
};


