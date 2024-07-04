// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
    This is profiling header
    Usage:

    testFunc = {
        PROFILE_NAME(Function) | PROFILE

        if (true) then {

            PROFILE_SCOPE_NAME(innerscope) | PROFILE_SCOPE
        }
    };

*/

#include "struct.hpp"

#define PROFILE_TOSTRING(val) #val

#define PROFILE_DECLVAR private _##__RAND_UINT16__##__LINE__

#define PROFILE private PROFILE_DECLVAR = struct_newp(ProfileZone, PROFILE_TOSTRING(__FILE__) arg __LINE__);
#define PROFILE_NAME(x) PROFILE_DECLVAR = struct_newp(ProfileZone, x arg __LINE__);
#define PROFILE_SCOPE PROFILE_DECLVAR = struct_newp(ProfileZone, PROFILE_TOSTRING(__FILE__) arg __LINE__);
#define PROFILE_SCOPE_NAME(x) PROFILE_DECLVAR = struct_newp(ProfileZone, x arg __LINE__);