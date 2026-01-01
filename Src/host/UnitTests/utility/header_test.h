// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	Основные понятные моменты:

	1. Допускается вложенность if/ifdef. Внутри них могут быть define,include
	2. В if при оценке не допускаются числа с плавающей точкой. Оценка происходит, но дробная часть почему-то выпадает из препроцессора в код что даст синтаксическую ошибку в большинстве случаев.

*/
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

//if simple
comment("if simple")
#if version >= _ONE
	output(_versionMes, "true")
#else
	output(_versionMes, "version error")
#endif
comment("if simple END")

#define included_macro "not_connected"

//including in nested tests
comment("including in nested tests")
#if __has_include("unexisten_header.h") == 0
	comment("including in nested tests 0")
	#if __has_include("included_header_test.h")
		comment("including in nested tests 1")
		#define REDEFINE_TEST_HEADER
		#include "included_header_test.h"
		comment("including in nested tests 2")
	#endif
	comment("including in nested tests 3")
#endif
comment("including in nested tests END")

output(_included_def, included_macro)

//second checks multilevel
#define min_ 1
#define maj_ 2
#define bld_ 3

comment("mulInclAll")
#if __has_include("nofile.h") == 0
	comment("mulInclAll 0")
	#if __has_include("unexisten_header.h") == 0
		comment("mulInclAll 1")
		#ifndef RANDOM_NAME_MACRO
			comment("mulInclAll 2")
			#if __has_include("undefined_func.sqf") == 0
				comment("mulInclAll 3")
				#ifdef included_macro
					comment("mulInclAll 4")
					#if min_ >= 1
						comment("mulInclAll 5")
						#if maj_ < bld_
							comment("mulInclAll 6")
							#if bld_ == 3
								output(_mulInclAll, "success")
							#endif
							comment("mulInclAll 7")
						#endif
						comment("mulInclAll 8")
					#endif
					comment("mulInclAll 9")
				#endif
				comment("mulInclAll 10")
			#endif
			comment("mulInclAll 11")
		#endif
		comment("mulInclAll 12")
	#endif
	comment("mulInclAll 13")
#endif
comment("mulInclAll END")



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
comment("mixed if/ifdef END")

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


comment("multi-mixed if/ifdef")
#ifdef included_macro
	comment("multi-mixed if/ifdef 0")
	#if 1
		comment("multi-mixed if/ifdef 1")
		#ifdef MACRO_TEST
			comment("multi-mixed if/ifdef 2")
			#if 1
				comment("multi-mixed if/ifdef 3")
				#ifdef MACRO_TEST_INTERNAL
					_mixedValue = _mixedValue + 1;"multi-mixed";
				#endif
				comment("multi-mixed if/ifdef 4")
			#endif
			comment("multi-mixed if/ifdef 5")
		#endif
		comment("multi-mixed if/ifdef 6")
	#endif
	comment("multi-mixed if/ifdef 7")
#endif
comment("multi-mixed if/ifdef END")

comment("nocomments test")
#define _simpleOne 234
#if 1
	#ifdef included_macro
		#if _simpleOne == 234
			#ifdef MACRO_TEST
				#ifdef MACRO_TEST_INTERNAL
					//post including define and set
					#define __endmacro
				#endif
			#endif
		#endif
	#endif
#endif

comment("nocomments test END")

#ifdef __endmacro
 	output(_endmacro,"ok")
#endif