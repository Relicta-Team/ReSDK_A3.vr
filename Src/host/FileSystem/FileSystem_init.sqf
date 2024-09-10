// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\engine.hpp>
#include <..\struct.hpp>


fso_map_tree = createhashMap; //flat object
fso_baseObject = null;

//initialize filesystem
fso_init = {
	private _nativeCollection = addonFiles ["src\"];
	private _useNativeCollector = count _nativeCollection > 0;
	if (!_useNativeCollector) then {
		_nativeCollection = ["src\",null,null,true] call file_getFileList;
	};
	
	[_nativeCollection] call fso_buildTree;
};

/*
	tree builder maker
*/
fso_buildTree = {
	params ["_flist"];
	private _tree = createhashMap;
	_flist = _flist apply {tolower _x splitString "\/"};
	private _parts = null;
	private _checkTree = {
		params ["_basePath","_pathSpec"];
		private _first = _pathSpec deleteAt 0;
		if 
	};

	{
		_parts = _x;
		{
			
		} foreach _parts;
	} foreach _flist;
};

// Get all files in selected directory
fso_getFiles = {
	params ["_pathDir","_extension",[["_recursive",false]]];
};