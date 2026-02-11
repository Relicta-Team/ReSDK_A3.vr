// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.NetAtmos,nat_atmos_)

//! Отладочная визуализация зон. включать только в редакторе
//#define NAT_DEBUG_ENABLE_VISUAL_HELPER

#ifndef EDITOR
	#undef NAT_DEBUG_ENABLE_VISUAL_HELPER
#endif

macro_const(nat_atmos_loading_slist_states)
#define NAT_LOADING_SLIST_STATES ["err","not_loading","await_resp","loading","ok"]

enum(LoadingState,NAT_LOADING_STATE_)
#define NAT_LOADING_STATE_ERROR -1
#define NAT_LOADING_STATE_NOT_LOADED 0
#define NAT_LOADING_STATE_AWAIT_RESPONE 1
#define NAT_LOADING_STATE_LOADING 2
#define NAT_LOADING_STATE_LOADED 3
enumend


enum(AtmosChunkDataIndex,NAT_CHUNKDAT_)
#define NAT_CHUNKDAT_CFG 0
#define NAT_CHUNKDAT_OBJECT 1
enumend

macro_func(nat_atmos_createChunkData,any[]())
#define NAT_CHUNKDAT_NEW(cfg) [cfg,nil]

enum(AtmosEffectType,NAT_ATMOS_EFFTYPE_)
#define NAT_ATMOS_EFFTYPE_FIRE 0
#define NAT_ATMOS_EFFTYPE_SMOKE 1
enumend

//флаг оптимизации при включенном ENABLE_OPTIMIZATION. Отвечает за отсечение невидимых регионов
macro_def(nat_atmos_optimization_render)
#define NET_ATMOS_OPTIMIZATION_RENDER
//дебаг отрисовка для куллинга
//#define NET_ATMOS_OPTIMIZATION_RENDER_DEBUG

//флаг оптимизации посредством объединения блоков в регионы. 
// ! не должен быть включен вместе с ENABLE_PERBLOCK_ZPASS_CULLING
macro_def(nat_atmos_enable_optimization)
#define ENABLE_OPTIMIZATION

//флаг одиночной оптимизации для каждого блока
// ! не должен быть включен вместе с ENABLE_OPTIMIZATION
//#define ENABLE_PERBLOCK_ZPASS_CULLING