// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define moduleName common

#define ___fullmodulename(var)  moduleName##_##var

#define mFunction(name) ___fullmodulename(name) = 

#define mVariable(name) ___fullmodulename(name)

#define mCallFunc(name) call ___fullmodulename(name)

#define mGetVar(name) ___fullmodulename(name)

#define mSetVar(name) ___fullmodulename(name)