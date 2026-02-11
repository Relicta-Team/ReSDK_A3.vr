// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
    Описание:
        Переписанные функции файловой системы, доступные в симуляции и на сервере
    
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

file_const_defaultDelimeter = "";

file_const_defaultAsyncWriteTimeout = 5;

#define PRINT_FILEWRITE_ERROR_REASON
// #define EXTENDED_LOGGING_ASYNCWRITE
// #define EXTENDED_LOGGING_ASYNCCOPY
// #define EXTENDED_LOGGING_ASYNCUNLOCK

file_getSourcePath = {
	#ifdef RBUILDER
		(RBuilder_map_defines get "RBUILDER_RESDK_PATH") + "/" + _this
	#else
		getMissionPath _this
	#endif
};

file_open = {
	params ["_path",["_isRelative",true],["_args",""]];
	
	if (_isRelative) then {_path = _path call file_getSourcePath};

	if !([_path,false] call file_exists) exitwith {false};
	if (_arsgs == "") then {
		["FileManager","Open",[
			_path
		],true] call rescript_callCommand;
	} else {
		_args = _args regexReplace["""/g",file_const_defaultDelimeter];
		["FileManager","Open",[
			_path,_args,file_const_defaultDelimeter
		],true] call rescript_callCommand;
	};

	true
};

file_openReturn = {
	params ["_path",["_isRelative",true],["_args",""]];

	if (_isRelative) then {_path = _path call file_getSourcePath};
	
	if !([_path,false] call file_exists) exitwith {999999};

	if (_args == "") then {
		parseNumber(["FileManager","OpenReturn",[_path],true] call rescript_callCommand);
	} else {
		_args = _args regexReplace["""/g",file_const_defaultDelimeter];
		parseNumber(["FileManager","OpenReturn",[_path,_args,file_const_defaultDelimeter],true] call rescript_callCommand);
	};
};

// Example: ["temp.txt","temp2.txt",true] call file_copy
// this cannot copy directory
file_copy = {
	params ["_path","_dest","_relInfo",["_canOverride",true]];
	
	if isNullVar(_relInfo) then {_relInfo = true};
	if equalTypes(_relInfo,true) then {_relInfo = vec2(_relInfo,_relInfo)};
	_relInfo params [["_isRelative",true],["_isRelativeDest",true]];

	if (_isRelative) then {_path = _path call file_getSourcePath};
	if (_isRelativeDest) then {_dest = _dest call file_getSourcePath};

	(["FileManager","Copy",[
		_path,_dest,_canOverride
	],true] call rescript_callCommand)=="true";
};

file_move = {
	params ["_path","_dest","_relInfo"];
	
	if isNullVar(_relInfo) then {_relInfo = true};
	if equalTypes(_relInfo,true) then {_relInfo = vec2(_relInfo,_relInfo)};
	_relInfo params [["_isRelative",true],["_isRelativeDest",true]];

	if (_isRelative) then {_path = _path call file_getSourcePath};
	if (_isRelativeDest) then {_dest = _dest call file_getSourcePath};

	(["FileManager","Move",[
		_path,_dest
	],true] call rescript_callCommand)=="true";
};

dir_move = {
	_this call file_move;
};

file_getFileList = {
	params ["_path",["_isRelative",true],["_searchOption","*.*"],["_useDeepSearch",false]];

	if (_isRelative) then {_path = _path call file_getSourcePath};

	private _argsQuery = [_path,_searchOption];
	if (_useDeepSearch) then {_argsQuery pushBack "deep"};
	private _retList = [];
	private _r = ["FileManager","GetFileEnumerator",_argsQuery,false] call rescript_callCommand;
	for "_i" from 0 to (_r select 0) do {
		_retList pushBack ((["FileManager","EnumerateFile",[_i],false] call rescript_callCommand) select 0);
	};
	
	_retList
};

file_read = {
	params ["_path",["_isRelative",true]];
	if (_isRelative) then {_path = _path call file_getSourcePath};

	private _data = ["FileManager","Read",[_path,file_const_defaultDelimeter],true] call rescript_callCommand;
	if equals(_data,"$BUFFER_OVERFLOW$") exitWith {
		setLastError("Cannot load file because buffer limit is exceeded. Path: " + _path);
		""
	};
	(_data regexReplace [file_const_defaultDelimeter+ "/g",""""])
};

file_write = {
	params ["_path","_data",["_isRelative",true]];
	
	if (_isRelative) then {_path = _path call file_getSourcePath};

	//before check
	if ([_path,false] call file_isLocked) exitwith {
		#ifdef PRINT_FILEWRITE_ERROR_REASON
        errorformat("%1 - Cant write to %2 - locked","file_write" arg _path);
		#endif
		
		false
	};

	_data = _data regexReplace["""/g",file_const_defaultDelimeter];
	["FileManager","Write",[_path,_data,file_const_defaultDelimeter]] call rescript_callCommandVoid;

	true
};

file_delete = {
	params ["_path"]; //здесь обязательная защита от удаления файлов за директорией sdk
	_path = _path call file_getSourcePath;
	if ([_path,false] call file_exists) then {
		["FileManager","Delete",[_path]] call rescript_callCommandVoid;
		true
	} else {
		false
	};
};

folder_delete = {
	params ["_path"]; //обязательная защита
	_path = _path call file_getSourcePath;
	if ([_path,false] call folder_exists) then {
		["FileManager","FolderDelete",[_path]] call rescript_callCommandVoid;
		true
	} else {
		false
	}
};

file_exists = {
	params ["_path",["_isRelative",true]];
	if (_isRelative) then {_path = _path call file_getSourcePath};
	(["FileManager","Exists",[_path],true] call rescript_callCommand)=="true"
};

folder_exists = {
	params ["_path",["_isRelative",true]];
	if (_isRelative) then {_path = _path call file_getSourcePath};
	(["FileManager","ExistsDir",[_path],true] call rescript_callCommand)=="true"
};


file_isLocked = {
	params ["_path",["_isRelative",true]];
	if (_isRelative) then {_path = _path call file_getSourcePath};

	(["WorkspaceHelper","checkfilelock",[_path],true] call rescript_callCommand)=="false"
};

file_clearFileLock = {
	["FileManager","FreeFileLock",[]] call rescript_callCommandVoid;
};

//! async functions - do not use
/*
file_writeAsync = {
	params ["_path","_data",["_isRelative",true],["_onWrite",{}],["_onTimeout",{}]];
	if ([_path,_isRelative] call file_isLocked) then {
		startAsyncInvoke
			{
				_this set [0,(_this select 0) + 3];
				_this params ["_inc","_path","","_isRelative"];
				
				#ifdef EXTENDED_LOGGING_ASYNCWRITE
				["[%3]: check lock %1 (%2) [%4]",_inc,_inc %2,__FILE__,_path] call printTrace;
				#endif
				
				if (_inc%2 != 0) exitwith {false};

				if (
					[_path,_isRelative] call file_isLocked
				) then {
					
					#ifdef EXTENDED_LOGGING_ASYNCWRITE
					["-------------- try unlock"] call printTrace;
					#endif

					call file_clearFileLock;
					false
				} else {
					true
				};
			},
			{
				setScopeName("file_writeAsync<_onWrite>");

				_this params ["_inc","_path","_data","_isRelative","_onWrite"];
				private _result = [_path,_data,_isRelative] call file_write;
				[_result,_path] call _onWrite;
			},
			[0] + _this,
			file_const_defaultAsyncWriteTimeout,
			{
				setScopeName("file_writeAsync<_onTimeout>");

				_this params ["_inc","_path","","_isRelative","","_onTimeout"];
				[_path,_isRelative] call _onTimeout;
			}
		endAsyncInvoke
	} else {
		[_path,_data,_isRelative] call file_write;
		[true,_path] call _onWrite;
	};
};

file_copyAsync = {
	private _thisParams = array_copy(_this);
	params ["_path","_dest","_relInfo",["_onCopy",{}],["_onTimeout",{}]];

	if isNullVar(_relInfo) then {_relInfo = true};
	if equalTypes(_relInfo,true) then {_relInfo = vec2(_relInfo,_relInfo)};
	_relInfo params [["_isRelative",true],["_isRelativeDest",true]];

	_patFilename = "(?![\\\/])(\w+\.)+\w+$";
	if !([_path,_isRelative] call file_exists) exitwith {false};
	if !([_path,_patFilename] call regex_isMatch) exitwith {false};
	
	
	//first add fileextension if not exists
	if !([_dest,_patFilename] call regex_isMatch) then {
		_fromFileName = [_path,_patFilename] call regex_getFirstMatch;
		_dest = _dest + "\" + _fromFileName;
	};

	_thisParams set [2,[_isRelative,_isRelativeDest]];

	if ([_dest,_isRelativeDest] call file_isLocked) then {
		startAsyncInvoke
			{
				_this set [0,(_this select 0) + 3];
				_this params ["_inc","","_to","_isRelativeList"];
				_isRelativeList params ["","_rT"];

				#ifdef EXTENDED_LOGGING_ASYNCCOPY
				["[%3]: check lock %1 (%2) [%4]",_inc,_inc %2,__FILE__,_to] call printTrace;
				#endif
				
				if (_inc%2 != 0) exitwith {false};

				if (
					[_to,_rT] call file_isLocked
				) then {
					
					#ifdef EXTENDED_LOGGING_ASYNCCOPY
					["-------------- try unlock"] call printTrace;
					#endif

					call file_clearFileLock;
					false
				} else {
					true
				};
			},
			{
				setScopeName("file_copyAsync<_onCopy>");

				_this params ["_inc","_f","_t","_isRelativeList","_onCopy"];
				private _result = [_f,_t,_isRelativeList] call file_copy;
				[_result,_path] call _onCopy;
			},
			[0] + _thisParams,
			file_const_defaultAsyncWriteTimeout,
			{
				setScopeName("file_copyAsync<_onTimeout>");

				_this params ["_inc","_path","_toPath","_isRelativeList","","_onTimeout"];
				[_path,_toPath,_isRelativeList] call _onTimeout;
			}
		endAsyncInvoke

	} else {
		[_path,_dest,[_isRelative,_isRelativeDest]] call file_copy;
		[true,_path] call _onCopy;
	};

	true
};

file_unlockAsync = {
	params ["_path","_ctx",["_isRelative",true],["_onUnlocked",{}],["_onTimeout",{}]];
	if ([_path,_isRelative] call file_isLocked) then {
		startAsyncInvoke
			{
				_this set [0,(_this select 0) + 3];
				_this params ["_inc","_path","_ctx","_isRelative"];
				
				#ifdef EXTENDED_LOGGING_ASYNCUNLOCK
				["[%3]: check lock %1 (%2) [%4]",_inc,_inc %2,__FILE__,_path] call printTrace;
				#endif
				
				if (_inc%2 != 0) exitwith {false};

				if (
					[_path,_isRelative] call file_isLocked
				) then {
					
					#ifdef EXTENDED_LOGGING_ASYNCUNLOCK
					["-------------- try unlock"] call printTrace;
					#endif

					call file_clearFileLock;
					false
				} else {
					true
				};
			},
			{
				setScopeName("file_unlockAsync<_onUnlocked>");

				_this params ["_inc","_path","_ctx","_isRelative","_onUnlocked"];
				_ctx call _onUnlocked;
			},
			[0] + _this,
			file_const_defaultAsyncWriteTimeout,
			{
				setScopeName("file_unlockAsync<_onTimeout>");

				_this params ["_inc","_path","_ctx","_isRelative","","_onTimeout"];
				_ctx call _onTimeout;
			}
		endAsyncInvoke
	} else {
		_ctx call _onUnlocked;
	};
};
*/