// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\struct.hpp>

/*
	Yaml parser.
	Reworked from the CBA yaml parser.
*/

#define ASCII_COLON 58
#define ASCII_MINUS 45
#define ASCII_HASH 35
#define ASCII_VERTICAL_BAR 124

#define ASCII_NEWLINE 10
#define ASCII_CR 13
#define ASCII_TAB 9
#define ASCII_SPACE 32

// White-space, used by the SPON_stringTrim* functions.
#define WHITE_SPACE [ASCII_TAB, ASCII_SPACE, ASCII_NEWLINE, ASCII_CR]

#define YAML_MODE_STRING 0
#define YAML_MODE_ASSOC_KEY 1
#define YAML_MODE_ASSOC_VALUE 2
#define YAML_MODE_ARRAY 3

#define YAML_TYPE_UNKNOWN 0
#define YAML_TYPE_SCALAR 1
#define YAML_TYPE_ARRAY 2
#define YAML_TYPE_ASSOC 3

#define ASCII_YAML_COMMENT ASCII_HASH
#define ASCII_YAML_ASSOC ASCII_COLON
#define ASCII_YAML_ARRAY ASCII_MINUS

// from CBA_fnc_parseYAML
io_praseYaml = {
	params ["_file",["_loadFromString",false]];
	
	private _yamlString = ifcheck(_loadFromString,_file,LoadFile _file);
	private _yaml = toArray _yamlString;
	private _lineBreaks = [ASCII_NEWLINE, ASCII_CR];

	// Ensure input ends with a newline.
	if (count _yaml > 0) then
	{
		if !((_yaml select ((count _yaml) - 1)) in _lineBreaks) then {
			_yaml pushBack ASCII_NEWLINE;
		};
	};

	_pos = -1;

	_retVal = ([_yaml, _pos, -1, [[]]] call io_yml_parse);
	_pos = _retVal select 0;
	_value = _retVal select 1;
	_error = _retVal select 2;

	if (_error) then {
		nil // Return.
	} else {
		_value // Return.
	};
};

// cba_fnc_formatNumber
io_yml_formatNumber = {
	
	#define DEFAULT_INTEGER_WIDTH 1
	#define DEFAULT_DECIMAL_PLACES 0
	#define DEFAULT_SEPARATE_THOUSANDS false

	params ["_number", ["_integerWidth", DEFAULT_INTEGER_WIDTH], ["_decimalPlaces", DEFAULT_DECIMAL_PLACES], ["_separateThousands", DEFAULT_SEPARATE_THOUSANDS]];

	private _isNegative = _number < 0;
	private _return = (abs _number) toFixed _decimalPlaces;
	private _dotIndex = if (_decimalPlaces == 0) then {count _return} else {_return find "."};


	while {_integerWidth > _dotIndex} do { // pad with leading zeros
		_return = "0" + _return;
		_dotIndex = _dotIndex + 1;
	};
	if ((_integerWidth == 0) && {_return select [0, 1] == "0"}) then {
		_return = _return select [1]; // toFixed always adds zero left of decimal point, remove it
	};
	if (_separateThousands) then { // add localized thousands seperator "1,000"
		private _thousandsSeparator = ".";
		for "_index" from (_dotIndex - 3) to 1 step -3 do {
			_return = (_return select [0, _index]) + _thousandsSeparator + (_return select [_index]);
			_dotIndex = _dotIndex + 1;
		};
	};

	// Re-add negative sign if there is at least one decimal place != 0.
	if (_isNegative && {toArray _return arrayIntersect toArray "123456789" isNotEqualTo []}) then {
		_return = "-" + _return;
	};

	_return
};

io_yml_raiseError = {
	params ["_message", "_yaml", "_pos", "_lines"];

	private _lastLine = _lines select ((count _lines) - 1);
	private _lastChar = _lastLine select ((count _lastLine) - 1);

	_lastLine resize ((count _lastLine) - 1);

	_lastLine pushBack ASCII_VERTICAL_BAR;
	_lastLine pushBack ASCII_HASH;
	_lastLine pushBack ASCII_VERTICAL_BAR;
	_lastLine pushBack _lastChar;

	_pos = _pos + 1;
	while {_pos < (count _yaml)} do {
		_char = _yaml select _pos;

		if (_char in [ASCII_YAML_COMMENT, ASCII_CR, ASCII_NEWLINE]) exitWith {};

		_lastLine pushBack _char;

		_pos = _pos + 1;
	};

	private _errorBlock = "";

	for [{_i = 0 max ((count _lines) - 6)}, {_i < count _lines}, {_i = _i + 1}] do {
		_errorBlock = _errorBlock + format ["\n%1: %2", [_i + 1, 3] call io_yml_formatNumber,
			toString (_lines select _i)];
	};

	_message = format ["%1, in ""%2"" at line %3:\n%4", _message,
		_file, count _lines, _errorBlock];

	errorformat("YAML parser error: %1", _message);
};

io_yml_parse = {
	params ["_yaml", "_pos", "_indent", "_lines"];
	assert(!isNull(cba_fnc_trim));
	assert(!isNull(CBA_fnc_strLen));
	private _error = false;
	private _currentIndent = _indent max 0;
	private _key = [];
	private _value = [];
	private _return = false;
	private _mode = YAML_MODE_STRING;
	private _dataType = YAML_TYPE_UNKNOWN;
	private "_data"; //is initially undefined.

	while {_pos < ((count _yaml) - 1) && !_error && !_return} do {
		_pos = _pos + 1;
		_char = _yaml select _pos;

		if (_char == ASCII_YAML_COMMENT) then {
			// Trim comments.
			while {!(_char in _lineBreaks)} do {
				_pos = _pos + 1;
				_char = _yaml select _pos;
			};

			_pos = _pos - 1; // Parse the newline normally.
		} else {
			if (_char in _lineBreaks) then {
				_currentIndent = 0;
				_lines pushBack [];
			} else {
				(_lines select ((count _lines) - 1)) pushBack _char;
			};

			switch (_mode) do {
				case YAML_MODE_ARRAY: {
					if (_char in _lineBreaks) then {
						_value = [toString _value] call CBA_fnc_trim;

						// If remainder of line is blank, assume
						// multi-line data.
						if (([_value] call CBA_fnc_strLen) == 0) then {
							private _retVal = ([_yaml, _pos, _currentIndent, _lines] call io_yml_parse);

							_pos = _retVal select 0;
							_value = _retVal select 1;
							_error = _retVal select 2;
						};

						if !(_error) then {
							_data pushBack _value;
							_mode = YAML_MODE_STRING;
						};
					} else {
						_value pushBack _char;
					};
				};
				case YAML_MODE_ASSOC_KEY: {
					if (_char in _lineBreaks) then {
						["Unexpected new-line, when expecting ':'", _yaml, _pos, _lines] call io_yml_raiseError;
						_error = true;
					} else {
						switch (_char) do {
							case ASCII_YAML_ASSOC: {
								_key = [toString _key] call CBA_fnc_trim;
								_mode = YAML_MODE_ASSOC_VALUE;
							};
							default {
								_key pushBack _char;
							};
						};
					};
				};
				case YAML_MODE_ASSOC_VALUE: {
					if (_char in _lineBreaks) then {
						_value = [toString _value] call CBA_fnc_trim;

						// If remainder of line is blank, assume
						// multi-line data.
						if (([_value] call CBA_fnc_strLen) == 0) then {
							private _retVal = ([_yaml, _pos, _currentIndent, _lines] call io_yml_parse);

							_pos = _retVal select 0;
							_value = _retVal select 1;
							_error = _retVal select 2;
						};

						if !(_error) then {
							//TRACE_1("Added Hash element",_value);
							_data set [_key,_value];
							_mode = YAML_MODE_STRING;
						};
					} else {
						_value pushBack _char;
					};
				};
				case YAML_MODE_STRING: {
					switch (_char) do {
						case ASCII_CR: {
							// Already dealt with.
						};
						case ASCII_NEWLINE: {
							// Already dealt with.
						};
						case ASCII_SPACE: {
							_currentIndent = _currentIndent + 1;
						};
						case ASCII_TAB: {
							["Tab character not allowed for indenting YAML; use spaces instead", _yaml, _pos, _lines] call io_yml_raiseError;
							_error = true;
						};
						case ASCII_YAML_ASSOC: {
							["Can't start a line with ':'", _yaml, _pos, _lines] call io_yml_raiseError;
							_error = true;
						};
						case ASCII_YAML_ARRAY: {
							if (_currentIndent > _indent) then {
								if (_dataType == YAML_TYPE_UNKNOWN) then {
									_data = [];
									_dataType = YAML_TYPE_ARRAY;

									_indent = _currentIndent;

									_value = [];
									_mode = YAML_MODE_ARRAY;
								} else {
									_error = true;
								};
							} else {
								if (_currentIndent < _indent) then {
									// Ignore and pass down the stack.
									_pos = _pos - 1;
									_return = true;
								} else {
									if (_dataType == YAML_TYPE_ARRAY) then {
										_value = [];
										_mode = YAML_MODE_ARRAY;
									} else {
										_error = true;
									};
								};
							};
						};
						default { // Anything else must be the start of an associative key.
							if (_currentIndent > _indent) then {
								if (_dataType == YAML_TYPE_UNKNOWN) then {
									_data = createHashMap;
									_dataType = YAML_TYPE_ASSOC;

									_indent = _currentIndent;

									_key = [_char];
									_value = [];
									_mode = YAML_MODE_ASSOC_KEY;
								} else {
									_error = true;
								};
							} else {
								if (_currentIndent < _indent) then {
									// Ignore and pass down the stack.
									_pos = _pos - 1;
									_return = true;
								} else {
									if (_dataType == YAML_TYPE_ASSOC) then {
										_key = [_char];
										_value = [];
										_mode = YAML_MODE_ASSOC_KEY;
									} else {
										_error = true;
									};
								};
							};
						};
					};
				};
			};
		};
	};

	[_pos, _data, _error]; // Return.
};

// ----------------------------------------------------------------------------

fileExists_Node = {
	params ["_f"];
	FileExists _f
};

fileLoad_Node = {
	params ["_f",["_doPreprocess",false]];
	if !([_f] call fileExists_Node) exitWith {""};
	if (_doPreprocess) then {
		PreprocessFileLineNumbers _f
	} else {
		LoadFile _f
	};
};