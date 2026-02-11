// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(DiscordRPC,discrpc_)

//#define allowtrace
macro_const(discrpc_extensionName)
#define extname "DiscordRichPresence"

macro_func(discrpc_updateExtensionState,void())
#define updateState() extname callExtension ["UpdatePresence",[]]

macro_func(discrpc_setExtensionTask,any(string,any))
#define setTask(_v,_vl) extname callExtension [_v,[_vl]]

macro_const(discrpc_applicationID)
#define getAppToken() "817839824006414337"

macro_func(discrpc_initApplication,void())
#define initApplication() extname callExtension ["init",[getAppToken()]]

macro_func(discrpc_encodeString,string(string))
#define encodeString(val) (val call discrpc_encodeRu)

//Нерабочий функционал региональных стандартов
//#define USE_LOCALES
