// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


struct(Thread_)
	def(__threadId) -1;
	def(_code) null;
	def(_args) null;

	def(isRunning) {
		(self getv(__threadId))!= -1
	}
	def(init)
	{
		params ["_code",["_args",[]]];
		self setv(_code,_code);
		self setv(_args,_args);
	}

	def(start)
	{
		params [["_delay",0]];
		if !(self callv(isRunning)) then {
			private _tId = startUpdateParams(self getv(_code),self getv(_args),_delay);
			self setv(__threadId,_tId);
		};
	}

	def(stop)
	{
		if (self callv(isRunning)) then {
			stopUpdate(self getv(__threadId));
			self setv(__threadId,-1);
		};
	}
endstruct

/*
	StackContext - saving local variables for next context calling
	_a = 3;
	_b = 5;
	private _s = struct_new(StackContext); //after this all local variables onto stack are saved in _s
	
	_afterDelay = {
		
		_code = {
			_a + _b;
		};
		["%1 + %2 = %3",_a,_b,call _code] call messageBox;
	};
	_s callv(save,_afterDelay);
	invokeAfterDelayParams({_this callv(contextCall)},2,_s)

*/
// struct(StackContext)
// 	def(ctxVars) null;
	
// 	def(init)
// 	{
// 		params [["_saveNow",true]];
// 		self setv(ctxVars,createHashMap);
// 		if (self getv(_saveNow)) then {
// 			self callv(save);
// 		};
// 	}

// 	def(save)
// 	{

// 	}

// 	def(load)
// 	{
// 		params ["_calledCode"];
// 	}
// endstruct