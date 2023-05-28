diag_log format["Start parsing file: %1",__PARSED_FILE_PATH__];
{
	_testedPath = __PARSED_FILE_PATH__;
	_content = LOADFILE _testedPath;
	diag_log format["Tested path: %1", _testedPath];
	if (count _content > 0) then {
		diag_log format["Found file: %1", _testedPath];
		_path = _testedPath;
	} else {
		throw "FILE_NOT_FOUND_EXCEPTION";
	};
	call compile preprocessFileLineNumbers _testedPath;
} 
except__ 
{
	"debug_console" callEXTENSION "#1000";
	_exStr = format["%1",_exception];
	_exfile = ((_exStr) select [0,_exStr find "]"])splitstring "'[]|" select 3;
	diag_log format["(file %2)EXCEPTION: %1",_exception,_exfile];
	exitcode__ -1;
};


diag_log format["File parsed! - %1",__PARSED_FILE_PATH__];
exitcode__ 0;

