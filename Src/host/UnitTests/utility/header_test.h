// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define MACRO_TEST 1
#define MACRO_TEST_INTERNAL 2
#define MACRO_TEST_INTERNAL2 3
#define output(_varname,_val) _varname = _val;
#define comment(text) ; text ;
_dummyVal = 1;

//ifdef nested tests
comment("ifdef nested tests")
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
comment("ifdef nested tests END")

#define version 1

#define _ONE 1

//if nested cannot be used
comment("if nested cannot be used")
#if version >= _ONE
	output(_versionMes, "true")
#else
	output(_versionMes, "version error")
#endif
comment("if nested cannot be used END")

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
comment("mixed if/ifdef")
#ifdef included_macro
	comment("mixed if/ifdef 0")
	#ifndef MACRO_TEST
		comment("mixed if/ifdef FALSE")
	#else
		comment("mixed if/ifdef 1")
		#ifdef included_macro
			comment("mixed if/ifdef 2")
			#ifdef MACRO_TEST
				comment("mixed if/ifdef 3")
				#ifdef MACRO_TEST_INTERNAL
					comment("mixed if/ifdef 4")
					#ifdef MACRO_TEST_INTERNAL2
						comment("mixed if/ifdef 5")
						_mixedValue = 1;
					#endif
				#endif
			#endif
		#endif
	#endif
#endif

comment("ifdef-if macrotest")
#ifdef MACRO_TEST
	comment("ifdef-if macrotest 0")
	#if 1
		_mixedValue = _mixedValue + 1;"ifdef-if";
	#endif
	comment("ifdef-if macrotest 1")
#endif
comment("ifdef-if macrotest END")

comment("ifdef-ifdef-if macrotest")
#ifdef MACRO_TEST
	comment("ifdef-ifdef-if macrotest 0")
	#ifdef included_macro
		comment("ifdef-ifdef-if macrotest 1")
		#if 1
			_mixedValue = _mixedValue + 1;"ifdef-ifdef-if";
		#endif
		comment("ifdef-ifdef-if macrotest 2")
	#endif
	comment("ifdef-ifdef-if macrotest 3")
#endif
comment("ifdef-ifdef-if macrotest END")

comment("if-ifdef-ifdef macrotest")
#if 1
	comment("if-ifdef-ifdef macrotest 0")
	#ifdef included_macro
		comment("if-ifdef-ifdef macrotest 1")
		#ifdef MACRO_TEST
			_mixedValue = _mixedValue + 1;"if-ifdef-ifdef";
		#endif
		comment("if-ifdef-ifdef macrotest 2")
	#endif
	comment("if-ifdef-ifdef macrotest 3")
#endif
comment("if-ifdef-ifdef macrotest END")

comment("if-ifdef macrotest")
#if 1
	comment("if-ifdef macrotest 0")
	#ifdef included_macro
		_mixedValue = _mixedValue + 1;"if-ifdef";
	#endif
	comment("if-ifdef macrotest 1")
#endif
comment("if-ifdef macrotest END")


// //post including define and set
// #define __endmacro

// #ifdef __endmacro
// 	output(_endmacro,"ok")
// #endif