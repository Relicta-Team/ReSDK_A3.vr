// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
    Main RBuilder loader.
    RBuilder can used for:
        - unit tests
        - parsing code
        - compiling, executing code
*/

#include <..\src\host\engine.hpp>

isRBuilder = true;
RBuilder_map_defines = RBUILDER_DEFINE_LIST;
RBuilder_PID = RBUILDER_PID;
RBuilder_useOutput = "RBUILDER_OUTPUT" in RBuilder_map_defines;

RBuilder_autoReload = "RBUILDER_AUTO_RELOAD" in RBuilder_map_defines;

RBuilder_serverStarted = false;

//RBuilder_password - use as serverpassword
server_password = RBuilder_password;

if canSuspend exitWith {
	diag_log ("[RB] RBuilder cannot run in sheduler environment");
	call rbuilder_fatalShutdownServer;
};

diag_log ("[RB] Initialize cba module");
call compile preprocessFileLineNumbers "preload\rbuilder_cba_functions.sqf";

diag_log ("[RB] Loading cba initializer");
call compile preprocessFileLineNumbers "preload\rbuilder_cba_init.sqf";

//called after logger functions loaded
RBuilder_postInit = {

    rbPrint = {
        params ["_msg",["_fncaller","Unknown_function"]];
        "debug_console" CALLEXTENSION (format["RBuilder(%2): %1",_msg,_fncaller]);
    };

    #define __strval__(v__) 'v__'
    #define definePrinter(__name) \
    __name = { \
        private _ftData = _this; \
        if equalTypes(_ftData,[]) then { \
            if (count _ftData > 0 && {equalTypes(_ftData select 0,"")}) then { \
                _ftData = format _ftData; \
            }; \
        }; \
        [_ftData, __strval__(__name) ] call rbPrint; \
    };

    definePrinter(cprint)
    definePrinter(cprintErr)
    definePrinter(cprintWarn)
    definePrinter(discLog)
    definePrinter(discError)
    definePrinter(discWarning)


    definePrinter(logCritical)
    definePrinter(logError)
    definePrinter(logWarn)
    definePrinter(logInfo)
    definePrinter(logDebug)
    definePrinter(logTrace)

    definePrinter(systemLog)
    definePrinter(gameLog)
    definePrinter(rpLog)
    definePrinter(lifeLog)
    definePrinter(adminLog)
    definePrinter(combatLog)


};
call RBuilder_postInit; //preinit logfile



//initialize rebgidge
["STAGE INITIALIZE REBRIDGE"] call cprint;

//call compile preprocessFileLineNumbers "src\ReBridge\ReBridge_init.sqf";
#include "..\src\ReBridge\ReBridge_init.sqf"

//checks
#ifndef RBUILDER
if (true) exitWith {
    ["This is not RBuilder more or macro not found. Fatal exit"] call cprintErr;
    call rbuilder_fatalShutdownServer;
};
#endif
if isNullVar(ReBridge_getWorkspace) exitWith {
    ["ReBridge::getWorkspace() not found. Fatal exit"] call cprintErr;
    call rbuilder_fatalShutdownServer;
};

// активируем компонет
private _logReBridge = (call ReBridge_getWorkspace)+"\logs\ReEngineLogs";
[] call ReBridge_start;
// Загрузим проект со скриптами (Путь должен быть полным)

private _scriptPath = ((call ReBridge_getWorkspace) + ("\src\Scripts\RBuilder.reproj"));
["Script ReBridge path: %1",_scriptPath] call cprint;

private _buildResult = [_scriptPath] call rescript_build;

if (ReBridge_lastError != "") exitWith {
    ["ReBridge initialization error; Result: %1",_buildResult] call cprintErr;
    call rbuilder_fatalShutdownServer;
};

rbuilder_callback = {
    params ["_msg"];
    ["RBuilder: %1",_msg] call cprint;
};

["Initialize scripts..."] call cprint;

["Breakpoint"] call rescript_initScript;
["ScriptContext"] call rescript_initScript;
["WorkspaceHelper"] call rescript_initScript;
["FileManager"] call rescript_initScript;
["RBuilder"] call rescript_initScript;

#ifndef RBUILDER
["RBuilder header not found"] call cprintErr;
["RBuilder","exit",[-100404]] call rescript_callCommandVoid;
#endif

RBuilder_exit = {
    params ["_exitCode",["_msg",""]];
    if (_msg != "") then {
        ["RBuilder exited with reason: %1",_msg] call cprint;
    };
    if (!RBuilder_autoReload) then {
        ["RBuilder","exit",[_exitCode]] call rescript_callCommandVoid;
    } else {
        ["RBuilder autoreload request. Wating commands..."] call cprint;
        ["RBuilder","c_send",["print","$auto_reload_request$"]] call rescript_callCommandVoid;
        if isNull(RBuilder_handle_autoreloadEvent) then {
            RBuilder_handle_autoreloadEvent = [_exitCode] SPAWN {
                params ["_exCode"];
                while {true} do {
                    _data = ["RBuilder","c_get",[],true] call rescript_callCommand;
                    
                    if (_data == "exit") exitWith {
                        ["RBuilder","exit",[_exCode]] call rescript_callCommandVoid;
                    };
                    if (_data != "") exitWith {
                        _r = if isNull(cm_serverCommand) then {
                            rbuilder_password serverCommand "#restart";
                        } else {
                            "#restart" call cm_serverCommand;
                        };
                        if (!_r) then {
                            ["Fatal error on restart"] call cprintErr;
                            ["RBuilder","exit",[-6116]] call rescript_callCommandVoid;
                        };
                    };
                    uisleep 0.5;
                };
            };
        };
    };
};

RBuilder_destroyDefaultErrorHandler = {
    RemoveMissionEventHandler ["ScriptError",RBuilder_scriptLoadingErrorHandle];
};

RBuilder_onServerLockedLoading = {
    ["RBuilder server locked"] call cprintErr;
    ["RBuilder","exit",[-666900]] call rescript_callCommandVoid;
};

//initialize script error handler base
RBuilder_scriptLoadingErrorHandle = addMissionEventHandler ["ScriptError",{
    params ["_errorMsg","_file","_line","_ofs","_cont","_stack"];
    //safecall for 
    call {
        private _stackvars = if(count _stack == 0) then {"EMPTY"} else {
            private _lastStack = _stack select (count _stack - 1);
            _hmVars = _lastStack select 3;
            (_hmVars toArray true) select 0
        };
        _errmes = format["Fatal error: %1 (file %2 at %3) ->>>%5 ERROR#>%4<<<; Stackvars: %6",_errorMsg,ifcheck(_file=="","ANON",_file),_line,_cont select [_ofs,32],_cont select [_ofs-10,10],_stackvars joinString ", "];
        diag_log text _errmes;
        [_errmes] call cprintErr;
        [_errmes] call cprint;
        ["RBuilder","wait",[2 * 1000]] call rescript_callCommandVoid;
    };
    ["RBuilder","exit",[-666969]] call rescript_callCommandVoid;
}];

["RBuilder","init_console_redirect",[RBUILDER_PID]] call rescript_callCommandVoid;

//["RBuilder","write_data",["================ WORKING RBUILDER ================="] ] call rescript_callCommandVoid;
/*
    RBuilder API:
        
        Control server:

    ["RBuilder","c_start",[],true] call rescript_callCommand - start server comm
    ["RBuilder","c_stop",[],true] call rescript_callCommand - stop server comm

    ------------------------------------------------------------

        Commands:

    ["RBuilder","wait",[10 * 1000]] call rescript_callCommandVoid - wait 10 seconds (lock main vm thread)
    ["RBuilder","exit",[code]] call rescript_callCommandVoid - exit with code
    ["RBuilder","c_send",[CMDNAME,ARGOPT]] call rescript_callCommandVoid - send command (arguments optional)
    ["RBuilder","c_get",[],true] call rescript_callCommand - get command queue sended from server. returns string. stringEmpty if queue is empty

*/
_rSrv = ["RBuilder","c_start",[],true] call rescript_callCommand;
if (_rSrv!="true") exitWith {
    ["RBuilder","exit",[-101515]] call rescript_callCommandVoid;
};
RBuilder_serverStarted = true;

["RBuilder","c_send",["_preload"]] call rescript_callCommandVoid;

#ifdef BASE_VM_SANDBOX
    call RBuilder_destroyDefaultErrorHandler;
    ["Starting vm sandbox mode"] call cprint;
    ["RBuilder","c_send",["$interact_mode$"]] call rescript_callCommandVoid;
    for "_i" from 1 to 10 do {
        _i = 1;
        _dat = ["RBuilder","c_get",[],true] call rescript_callCommand;
        if (_dat == "exit") exitWith {
            ["RBuilder","exit",[0]] call rescript_callCommandVoid;
        };
        if (_dat!="") then {
            _ex = nil;
            ISNIL{_ex = call compile _dat;0};
            //["Executed: %1",_ex] call cprint;
            ["RBuilder","c_send",["$interact_mode$",_ex]] call rescript_callCommandVoid;
        };
        ["RBuilder","wait",[0.5 * 1000]] call rescript_callCommandVoid;
    };
    


#endif

//always needed. outside this check nullval
true