// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// конфигуратор дампера логов в rpt-файл
// enabled by default
#define SYSTEM_LOG_DUMP_TO_RPT

#ifdef RELEASE
	//always enable in release
	#define SYSTEM_LOG_DUMP_TO_RPT
#endif
// disable in editor
#ifdef EDITOR
	#undef SYSTEM_LOG_DUMP_TO_RPT
#endif
//disable in rbuilder
#ifdef RBUILDER
	#undef SYSTEM_LOG_DUMP_TO_RPT
#endif
#ifdef SYSTEM_LOG_DUMP_TO_RPT
	#define SYSLOG_RPT_DUMP(data) diag_log (data)
#else
	#define SYSLOG_RPT_DUMP(data) 
#endif