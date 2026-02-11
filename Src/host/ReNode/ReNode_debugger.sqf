// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

nbp_sigsend = {
    //params ["_id","_gpath"];
    //["nlink",[_id,_gpath]] call nbp_send;
    
    //faster sending
    ["ReNodeDebugger","nlink",[_this]] call rescript_callCommandVoid;
};

nbp_sendRet = {
    params ["_name",["_data",[]],["_retAsString",true]];
    ["ReNodeDebugger",_name,_data,_retAsString] call rescript_callCommand
};

nbp_send = {
    params ["_name","_data"];
    ["ReNodeDebugger",_name,_data] call rescript_callCommandVoid;
};

nbp_initDebugger = {
    ["ReNodeDebugger"] call rescript_initScript;
    if (call nbp_isEditorConnected) then {
        ["stop"] call nbp_send;
    };
    ["start"] call nbp_send;
};

nbp_isEditorConnected = {
    (["connected"] call nbp_sendRet)=="true"
};



