// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
	PROFILING
*/
struct(ProfilerStatistics)
	def(call_count) 0;
	def(lastTime) 0
	def(midTime) 0

	def(onCaptured)
	{
		params ["_t"];
		private _newtime = ((self getv(lastTime))+_t)/2;
		self setv(lastTime,_t);
		self setv(midTime,_newtime);
		self setv(call_count,(self getv(call_count))+1);
	}

	def(_pzName) "";
	def(_pzFile) "";
	def(_pzLine) 0;

	def(str)
	{
		format["%1(%2)[%3:%4]",struct_typename(self),self getv(_pzName),self getv(call_count),self getv(midTime)];
	}

	def(init)
	{
		params ["_pz"];
		self setv(_pzName,_pz getv(_name));
		self setv(_pzFile,_pz getv(_file));
		self setv(_pzLine,_pz getv(_line));
	}

	def(_getNormalStringName)
	{
		format["%1 (%2 at %3)",self getv(_pzName),self getv(_pzFile),self getv(_pzLine)];
	}

	def(getStringStatistics)
	{
		format["%1: calls %2, mid %3ms",self callv(_getNormalStringName),self getv(call_count),(self getv(midTime)) *1000];
	}
endstruct

profiler_getSystemContainer = {
	["ProfileZone","_system"] call struct_reflect_getTypeValue
};

profiler_getResults = {
	params [["_printOnConsole",false]];
	
	private _sys = call profiler_getSystemContainer;
	
	if (_printOnConsole) then {
		log("PROFILER RESULTS:");
		private _stats = "";
		{
			_stats = _y callv(getStringStatistics);
			logformat("    %1",_stats);
		} foreach _sys;
		logformat("Total zones: %1",count _sys);
	};

	values _sys
};

profiler_clearResults = {
	private _sys = call profiler_getSystemContainer;
	{
		_sys deleteAt _x;
	} foreach (keys _sys);
};

struct(ProfileZone)
	def(_name) "Anon_Scope";
	def(_file) "";
	def(_line) 0;
	def(_time) 0;
	def(_isScoped) false;

	def(_system) createHashMap;

	def(init)
	{
		params [["_name",""],"_file","_line",["_isScoped",false]];
		
		if (_name!="") then {
			self setv(_name,_name);
		};
		self setv(_file,_file);
		self setv(_line,_line);
		self setv(_isScoped,_isScoped);		
		
		self setv(_time,tickTime); //захватываем время в конце после инициализации всех данных
	}
	//statistics storage name
	def(_getSSN)
	{
		format["[%1]%2(%3)",self getv(_name),self getv(_file),self getv(_line)];
	}

	def(str)
	{
		format["%1<%2>",struct_typename(self),self callv(_getSSN)]
	}

	def(del)
	{
		private _delta = tickTime - (self getv(_time));
		private _ssn = self callv(_getSSN);
		private _sys = self getv(_system);
		private _sstor = _sys get _ssn;
		if isNullVar(_sstor) then {
			_sstor = struct_newp(ProfilerStatistics,self);
			_sys set [_ssn,_sstor];
		};

		_sstor callp(onCaptured,_delta);
	}
endstruct