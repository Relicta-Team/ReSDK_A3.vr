// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define DP vec2("izcmd",[0 arg 0 arg 0]) call getSpawnPosByName

#define DEBUG_TASK
#define DEBUG_TASKNAME "ROkopovoTaskDefend"


#ifndef EDITOR
	#undef DEBUG_TASK
	#undef DEBUG_TASKNAME
#endif