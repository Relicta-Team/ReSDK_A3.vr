_module = "";
{
	private _path = __PARSED_FILE_PATH__;
	private _bPath = _path;
	diag_log ("Start allocate module for path: "+_path);
	_foldArr = _path splitString "\";
	_count = count _foldArr;
	if (_count < 2) then {
		throw "Invalid path";
	};
	_fname = _foldArr select (_count - 1);
	_mfoldname = _foldArr select (_count - 2);
	_module = _mfoldname;
	_path = "";
	{
		_testedPath = _x;
		_content = LOADFILE _testedPath;
		diag_log format["Tested path: %1", _testedPath];
		if (count _content > 0) exitWith {
			diag_log format["Found module: %1", _testedPath];
			_path = _testedPath;
		};
	} foreach [
		__MODULE_DIRECTORY_PATH__ + "\" + _mfoldname + ".sqf",
		__MODULE_DIRECTORY_PATH__ + "\" + _mfoldname + "_init.sqf",
		__MODULE_DIRECTORY_PATH__ + "\" + _mfoldname + "init.sqf",
		__MODULE_DIRECTORY_PATH__ + "\" + _fname
	];
	
	if (count _path == 0) then {
		throw "Module not found";
	};

	compile preprocessFileLineNumbers _path;
} 
except__ 
{
	diag_log format["EXCEPTION: %1",_exception];
	exitcode__ -1;
};


diag_log format["MODULE PARSED! - %1",_module];
exitcode__ 0;

