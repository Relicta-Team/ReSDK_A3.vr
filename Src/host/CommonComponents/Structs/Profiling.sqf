// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
	PROFILING
*/
prof_map_zones = createHashMap;

//this can be used for hotreload fixing
struct(ProfilerSystem)
	def(zone) createHashMap

endstruct

struct(ProfileZone)
	def(_name) "Anon_Scope";
	def(_line) 0;
	def(_time) 0;
	def(_isScoped) false;
	def(init)
	{
		params ["_name","_line",["_isScoped"]];
		self setv(_name,_name);
		self setv(_line,_line);
		self setv(_isScoped,_isScoped);
		//TODO work scoped: add to stack

		self setv(_time,tickTime);
	}

	def(del)
	{
		private _delta = tickTime - (self getv(_time));
		//TODO set result
	}
endstruct