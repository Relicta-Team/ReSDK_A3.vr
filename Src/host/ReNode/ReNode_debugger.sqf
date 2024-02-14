// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

nbp_sigsend = {
    params ["_id","_gpath"];
    ["nlink",[_id,_gpath]] call nbp_transfer;
};

nbp_transfer = {
    params ["_name","_data"];
    ["ReNodeDebugger",_name,_data] call rescript_callCommand;
};

nbp_initDebugger = {
    ["ReNodeDebugger"] call rescript_initScript;
};

nbp_isEditorConnected = {
    (["ReNodeDebugger","editor_connected",[],true] call rescript_callCommand)=="true"
};



