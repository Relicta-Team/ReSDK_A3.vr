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

#define NAT_ATMOS_EFFTYPE_FIRE 0
#define NAT_ATMOS_EFFTYPE_SMOKE 1

//флаг оптимизации при включенном ENABLE_OPTIMIZATION. Отвечает за отсечение невидимых регионов
#define NET_ATMOS_OPTIMIZATION_RENDER
//дебаг отрисовка для куллинга
//#define NET_ATMOS_OPTIMIZATION_RENDER_DEBUG

//флаг оптимизации посредством объединения блоков в регионы. 
// ! не должен быть включен вместе с ENABLE_PERBLOCK_ZPASS_CULLING
#define ENABLE_OPTIMIZATION

//флаг одиночной оптимизации для каждого блока
// ! не должен быть включен вместе с ENABLE_OPTIMIZATION
//#define ENABLE_PERBLOCK_ZPASS_CULLING