// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ============================================================================
// NATIVE OPTIMIZED VERSIONS (using RVEngine C++ extension)
// ============================================================================

//rvengine native function registrations
#include "..\..\RVEngine\RVEngine.hpp"

// Check if RVEngine is available
ai_nav_useNative = {
	"rv_client" call rve_hasloadedlib
};

RVENGINE_BEGIN_MODULE("rv_client")
	RVENGINE_SET_WRAPPER_CONDITION(call ai_nav_useNative)
	RVENGINE_DECL_NFUNC(ai_nav_findNearestNode)
	RVENGINE_DECL_NFUNC(ai_nav_findPathToClosestNode)
	RVENGINE_DECL_NFUNC(ai_nav_findPartialPath)

	RVENGINE_DECL_NFUNC(ai_nav_generateRegionNodes)
	RVENGINE_DECL_NFUNC(ai_nav_updateRegionEntrances_fast)
RVENGINE_END_MODULE