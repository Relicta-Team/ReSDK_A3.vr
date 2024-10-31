// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define MACRO_TEST 1
#define MACRO_TEST_INTERNAL 2
#define MACRO_TEST_INTERNAL2 3
#define output(_varname,_val) _varname = _val;

_dummyVal = 1;

//ifdef nested tests
#ifdef MACRO_TEST
	#ifdef MACRO_TEST_INTERNAL
		#ifdef MACRO_TEST_INTERNAL2
	 		output(_test1, "true")
	 	#else
	 		_dummyVal = 2;
	 		output(_test1, "false3")
	 	#endif
	#else
		_dummyVal = 3;
		output(_test1, "false2")
	#endif
#else
	_dummyVal = 4;
	output(_test1, "false1")
#endif

// #define major 1
// #define minor 2
// #define build 3

// #define _ONE 1
// #define _TWO 2
// #define _THREE 3

// //if nested tests
// #if major >= _ONE
// 	#if minor < _TWO
// 		#if build ==_THREE
// 			output(_versionMes, "true")
// 		#else
// 			output(_versionMes, "build error")
// 		#endif
// 	#else
// 		output(_versionMes, "minor error")
// 	#endif
// #else
// 	output(_versionMes, "major error")
// #endif

// #define included_macro "not_connected"

// //including in nested tests
// #if __has_include("unexisten_header.h") == 0
// 	#if __has_include("included_header_test.h")
// 		#define REDEFINE_TEST_HEADER
// 		#include "included_header_test.h"
// 	#endif
// #endif

// output(_included_def, included_macro)

// //post including define and set
// #define __endmacro

// #ifdef __endmacro
// 	output(_endmacro,"ok")
// #endif