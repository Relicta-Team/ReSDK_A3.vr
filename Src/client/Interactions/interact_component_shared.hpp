// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractShared,interact_shared_)

macro_func(interact_shared_getObjReference,string(actor))
#define getObjReference(obj) (obj getVariable ["ref","noref"])

macro_func(interact_shared_getObjReferenceWithMob,string(actor))
#define getObjReferenceWithMob(obj) (if (typeof obj == BASIC_MOB_TYPE) then {obj} else {getObjReference(obj)})