// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define allowtrace

#define extname "DiscordRichPresence"

#define updateState() extname callExtension ["UpdatePresence",[]]

#define setTask(_v,_vl) extname callExtension [_v,[_vl]]

#define getAppToken() "817839824006414337"

#define initApplication() extname callExtension ["init",[getAppToken()]]

#define encodeString(val) (val call discrpc_encodeRu)

//Нерабочий функционал региональных стандартов
//#define USE_LOCALES
