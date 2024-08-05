// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! Отладочная визуализация зон. включать только в редакторе
//#define NAT_DEBUG_ENABLE_VISUAL_HELPER

#ifndef EDITOR
	#undef NAT_DEBUG_ENABLE_VISUAL_HELPER
#endif

#define NAT_LOADING_SLIST_STATES ["err","not_loading","await_resp","loading","ok"]

#define NAT_LOADING_STATE_ERROR -1
#define NAT_LOADING_STATE_NOT_LOADED 0
#define NAT_LOADING_STATE_AWAIT_RESPONE 1
#define NAT_LOADING_STATE_LOADING 2
#define NAT_LOADING_STATE_LOADED 3



#define NAT_CHUNKDAT_CFG 0
#define NAT_CHUNKDAT_OBJECT 1
#define NAT_CHUNKDAT_NEW(cfg) [cfg,nil]