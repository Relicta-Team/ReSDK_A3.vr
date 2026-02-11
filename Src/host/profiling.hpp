// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	This is profiling header
	Usage:

	testFunc = {
		PROFILE_NAME(Function) | PROFILE

		if (true) then {

			PROFILE_SCOPE_NAME(innerscope) | PROFILE_SCOPE
		}
	};

*/

#include "struct.hpp"

//#define ASP_USE_PROFILING

#define USE_SCRIPTED_PROFILING

#ifdef RELEASE
	#undef USE_SCRIPTED_PROFILING
#endif

#ifdef USE_SCRIPTED_PROFILING

	#define PROFILE_DECLVAR private _##__RAND_UINT16__##__LINE__

	#define PROFILE private PROFILE_DECLVAR = struct_newp(ProfileZone, null arg (__FILE__) arg __LINE__);
	#define PROFILE_NAME(x) PROFILE_DECLVAR = struct_newp(ProfileZone, x arg (__FILE__) arg __LINE__);
	#define PROFILE_SCOPE PROFILE_DECLVAR = struct_newp(ProfileZone, null arg (__FILE__) arg __LINE__ arg true);
	#define PROFILE_SCOPE_NAME(x) PROFILE_DECLVAR = struct_newp(ProfileZone, x arg (__FILE__) arg __LINE__ arg true);
#else
	#define PROFILE
	#define PROFILE_NAME(x)
	#define PROFILE_SCOPE
	#define PROFILE_SCOPE_NAME(x)
#endif

#ifndef EDITOR
	#undef ASP_USE_PROFILING
#endif

#ifdef ASP_USE_PROFILING
	//log message
	#define ASP_MESSAGE(mes) profilerLog (mes);
	//auto region scope - will automatically deleted on scope exit
	#define ASP_REGION(name) private _ascp__ = createProfileScope (name);

	//
	#define ASP_BEGIN_SCOPE(name) private _asR__ = createProfileScope (name);
	#define ASP_END_SCOPE(name) _asR__ = 0;
#else
	#define ASP_MESSAGE(mes)
	#define ASP_REGION(name)
	#define ASP_BEGIN_SCOPE(name)
	#define ASP_END_SCOPE(name)
#endif
