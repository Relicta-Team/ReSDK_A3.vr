// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

rve_loadlib = {
	params ["_libName"];
	"intercept" callExtension ("load_extension:" + _libName);
};

rve_unloadlib = {
	params ["_libName"];
	"intercept" callExtension ("unload_extension:" + _libName);
};

rve_getloadedlibs = {
	("intercept" callExtension "list_extensions:") splitString ", ";
};

rve_unloadall = {
	{
		[_x] call rve_unloadlib;
	} foreach (call rve_getloadedlibs);
};