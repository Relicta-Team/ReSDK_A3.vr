// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

rve_hasloadedlib = {
	_this in rve_internal_libmap
};

rve_unloadall = {
	{
		[_x] call rve_unloadlib;
	} foreach (call rve_getloadedlibs);
};

#ifdef EDITOR
rve_debug_reloadlibs = {
	if isNull(file_copy) exitWith {setLastError("rve::debug::reloadlibs: file_copy function not found");};
	if isNull(file_delete) exitWith {setLastError("rve::debug::reloadlibs: file_delete function not found");};

	private _loadedNames = call rve_getloadedlibs;
	if (count _loadedNames == 0) exitWith {setLastError("rve::debug::reloadlibs: no loaded libraries");};
	call rve_unloadall;

	//["Src\RVEngine\vcproj64\build\Debug\plugins\rv_client_x64.dll"] call file_exists
	private _platformPath = ["WorkspaceHelper","getworkdir",[],true] call rescript_callCommand;
	if (_platformPath == "") exitWith {setLastError("rve::debug::reloadlibs: platform path is empty");};

	{
		private _pathFrom = format["Src\RVEngine\vcproj64\build\Debug\plugins\%1_x64",_x];
		private _pathLib = _pathFrom + ".dll";
		private _pathPDB = _pathFrom + ".pdb";
		if !([_pathLib] call file_exists) exitWith {setLastError("rve::debug::reloadlibs: file not found: " + _pathLib);};
		if !([_pathPDB] call file_exists) exitWith {setLastError("rve::debug::reloadlibs: file not found: " + _pathPDB);};

		{
			if (
				[_x,_platformPath + "\@EditorContent\intercept\",[true,false],true] call file_copy
			) then {
				[format["rve::debug::reloadlibs: copied %1 to %2",_x,_platformPath + "\@EditorContent\intercept\"]] call rve_log;
			} else {
				[format["rve::debug::reloadlibs: failed to copy %1 to %2",_x,_platformPath + "\@EditorContent\intercept\"]] call rve_log;
			};
		} foreach [_pathLib,_pathPDB];

	} foreach _loadedNames;

	{
		[_x] call rve_loadlib;
	} foreach _loadedNames;
};
#endif