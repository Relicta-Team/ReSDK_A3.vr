// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\SETTINGS.h>

#define ENABLE_LINE_IN_FILES

#ifdef ENABLE_LINE_IN_FILES
	#define __pragma_preprocess preprocessFileLineNumbers
#else
	#define __pragma_preprocess preprocessFile
#endif

#define __pragma_prep_cli preprocessFile

// logger
#define arg ,

#define conDllCall "debug_console" callExtension

#define log(message) "debug_console" callExtension (message + "#1111")
#define logformat(provider,formatText) "debug_console" callExtension (format[provider + "#1111",formatText])

#define warning(message) "debug_console" callExtension ("WARN: " + message + "#1101"); [message] call discWarning
#define error(message) "debug_console" callExtension ("ERROR: " + message + "#1001"); [message] call discError

#define warningformat(message,fmt) "debug_console" callExtension (format ["WARN: " + message + "#1101",fmt]); [format[message,fmt]] call discWarning
#define errorformat(message,fmt) "debug_console" callExtension (format ["ERROR: " + message  + "#1001",fmt]); [format[message,fmt]] call discError

#ifdef __TRACE__ENABLED
	#define trace(message) "debug_console" callExtension ("TRACE: " + message + "#1011");
	#define traceformat(message,fmt) "debug_console" callExtension (format ["TRACE: " + message + "#1011",fmt]);
#else
	#define trace(message)
	#define traceformat(message,fmt)
#endif