// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#ifdef RELEASE
	#undef ENABLE_THIS_SYSTEM_DEBUG
#endif
#ifndef EDITOR
	#undef ENABLE_THIS_SYSTEM_DEBUG
#endif

#ifdef ENABLE_THIS_SYSTEM_DEBUG
	#define debug_system(argvals) [format ['<%1> %2',self,format [argvals]]] call cprint;
#else
	#define debug_system(argvals)
#endif

