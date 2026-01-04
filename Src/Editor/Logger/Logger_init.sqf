// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define __redit_logger_std_header__ \
(if equalTypes(_this,[]) then { \
	format _this \
} else { \
	if not_equalTypes(_this,"") then {str _this} else {_this} \
})

function(printLog)
{
	"debug_console" callExtension (__redit_logger_std_header__ + "#1111");
}

function(printWarning)
{
	"debug_console" callExtension ("[REDIT::WARN]	" + __redit_logger_std_header__ + "#1101");
}

function(printError)
{
	"debug_console" callExtension ("[REDIT::ERROR]	" + __redit_logger_std_header__ + "#1001");
}


function(printTrace)
{
	if (cfg_debug_devMode || cfg_debug_allowTraceMessages) then {
		"debug_console" callExtension ("[REDIT::TRACE]	" + __redit_logger_std_header__ + "#1011");
	};
}

init_function(print_init_redirects)
{
	cprintErr = printError;
	cprintWarn = printWarning;
	cprint = printLog;
}