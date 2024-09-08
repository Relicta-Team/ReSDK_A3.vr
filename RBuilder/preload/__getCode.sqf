// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

cba_functionList = [
    "CBA_fnc_log",
    "cba_fnc_createNamespace",
    "cba_fnc_addEventHandler",
    "cba_fnc_removeEventHandler",

    "cba_fnc_localEvent",
    "cba_fnc_serverEvent",
    "cba_fnc_targetEvent",
    "cba_fnc_ownerEvent",
    "cba_fnc_globalEvent",

    "cba_fnc_addPerFrameHandler",
    "cba_fnc_removePerFrameHandler",
    "cba_fnc_execNextFrame",
    "cba_fnc_waitUntilAndExecute",
    "cba_fnc_waitAndExecute",
    "CBA_fnc_directCall",

    "cba_fnc_hashSet",
    "cba_fnc_hashGet",
    "CBA_fnc_hashRem",
    "CBA_fnc_hashEachPair"

]; 
cbaFunctionsCopy = {
    private _buf = [];
    {
        _buf pushBack (format["%1 = {",_x]);
        _buf pushBack (toString(missionNamespace getvariable _x));
        _buf pushBack ("};"+endl);
    } foreach cba_functionList;
    private _data = _buf joinString endl;
    copyTOClipboard _data;
    _data
};
