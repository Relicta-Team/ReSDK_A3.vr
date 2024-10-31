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

#define version 1

#define _ONE 1

//if nested cannot be used
#if version >= _ONE
	output(_versionMes, "true")
#else
	output(_versionMes, "version error")
#endif

// #define included_macro "not_connected"

// //including in nested tests
// #if __has_include("unexisten_header.h") == 0
// 	#if __has_include("included_header_test.h")
// 		#define REDEFINE_TEST_HEADER
// 		#include "included_header_test.h"
// 	#endif
// #endif

// output(_included_def, included_macro)

//mixed if/ifdef
#ifdef included_macro
	#ifndef MACRO_TEST
	#else
		#ifdef included_macro
			#ifdef MACRO_TEST
				#ifdef MACRO_TEST_INTERNAL
					#ifdef MACRO_TEST_INTERNAL2
						_mixedValue = 1;
					#endif
				#endif
			#endif
		#endif
	#endif
#endif

#ifdef MACRO_TEST
	#if 1
		_mixedValue = _mixedValue + 1;"ifdef-if";
	#endif
#endif
#ifdef MACRO_TEST
	#ifdef included_macro
		#if 1
			_mixedValue = _mixedValue + 1;"ifdef-ifdef-if";
		#endif
	#endif
#endif
#if 1
	#ifdef included_macro
		#ifdef MACRO_TEST
			_mixedValue = _mixedValue + 1;"if-ifdef-ifdef";
		#endif
	#endif
#endif
#if 1
	#ifdef included_macro
		_mixedValue = _mixedValue + 1;"if-ifdef";
	#endif
#endif
// //post including define and set
// #define __endmacro

// #ifdef __endmacro
// 	output(_endmacro,"ok")
// #endif