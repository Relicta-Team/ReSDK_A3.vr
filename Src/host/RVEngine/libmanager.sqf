// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

rve_internal_libmap = createhashmap;

rve_loadlib = {
	params ["_libName"];
	private _prevCount = count rve_internal_libmap;
	
	private _r = "intercept" callExtension ("load_extension:" + _libName);
	if (_r != "-1") exitWith {_r}; //fatal error

	private _loadedLibs = call rve_getloadedlibs;
	private _loaded = _libName in _loadedLibs;
	rve_internal_libmap = (_loadedLibs)createHashMapFromArray [];
	_loaded && (_prevCount != count rve_internal_libmap)
};

rve_unloadlib = {
	params ["_libName"];
	private _prevCount = count rve_internal_libmap;
	
	private _r = "intercept" callExtension ("unload_extension:" + _libName);
	if (_r != "-1") exitWith {_r}; //fatal error

	private _loadedLibs = call rve_getloadedlibs;
	rve_internal_libmap = (_loadedLibs)createHashMapFromArray [];
	_prevCount != count rve_internal_libmap
};

rve_getloadedlibs = {
	("intercept" callExtension "list_extensions:") splitString ", ";
};

rve_unloadall = {
	{
		[_x] call rve_unloadlib;
	} foreach (call rve_getloadedlibs);
};