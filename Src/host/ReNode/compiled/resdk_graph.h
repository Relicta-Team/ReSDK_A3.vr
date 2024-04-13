// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>
#include <..\..\Networking\Network.hpp>
#include <..\..\GameObjects\GameConstants.hpp>
#include <..\..\..\client\Inventory\inventory.hpp>

/*
    REGION: graph macrohelpers
*/

#define __THIS_GRAPH__ UNRESOLVED_GRAPH_PATH

#define __bp_serialize(value__) #value__

#define __bp_preser_sig(id__,toid__,graph__) __bp_serialize(id__@toid__@graph__)

#define __bp_send_signal(id__,toid__) __bp_preser_sig(id__,toid__,__THIS_GRAPH__) call nbp_sigsend;

//execution signal
#define BP_EXEC(id__,toid__) __bp_send_signal(id__,toid__)

//pure signal
#define BP_PS(id__,toid__) call{ __bp_send_signal(id__,toid__)

#define BP_PE }


//disable graph debugger outside editor
#ifndef EDITOR
    #define BP_EXEC(id__,toid__)
    #define BP_PS(id__,toid__)
    #define BP_PE
#endif

// ---------------- utility macros ---------------------

#ifdef EDITOR
    #define __GLOBAL_MACRO_RESDK_EDITOR__ true
#else
    #define __GLOBAL_MACRO_RESDK_EDITOR__ false
#endif

#ifdef RELEASE
    #define __GLOBAL_MACRO_RESDK_RELEASE__ true
#else
    #define __GLOBAL_MACRO_RESDK_RELEASE__ false
#endif

#ifdef DEBUG
    #define __GLOBAL_MACRO_RESDK_DEBUG__ true
#else
    #define __GLOBAL_MACRO_RESDK_DEBUG__ false
#endif