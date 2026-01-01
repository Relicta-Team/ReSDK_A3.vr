// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//код выполяемый в цикле
struct(LoopedFunction)
	//токен остановки
	def(__cancellationToken) false
	
	def(code) {}
	def(params) []

	def(updateDelay) 0
	def(lastUpdate) 0

	def(stopLoop)
	{
		self setv(__cancellationToken,true);
	}

	def(init)
	{
		params ["_code","_params",["_updateDelay",0]];
		self setv(code,_code);
		self setv(params,_params);
		self setv(updateDelay,_updateDelay);

		self callv(beginUpdate);
	}

	def(str)
	{
		format["%1=>%2",struct_typename(self),self getv(params)]
	}

	def(beginUpdate)
	{
		startAsyncInvoke
		{
			private self = _this;
			if !(self getv(__cancellationToken)) then {
				private _udl = self getv(updateDelay);
				if (_udl > 0) then {
					if (tickTime<(self getv(lastUpdate)))exitWith{};
					self setv(lastUpdate,tickTime+_udl);
					(self getv(params)) call (self getv(code));
				} else {
					(self getv(params)) call (self getv(code));
				};
				false
			} else {
				true
			}
		},{},self
		endAsyncInvoke
	}
endstruct

//выполяет цикл обновления пока существует объект
struct(LoopedObjectFunction) base(LoopedFunction)
	def(srcObj) objNull
	def(init)
	{
		params ["_code","_params",["_updateDelay",0],"_objSrc"];
		self setv(srcObj,_objSrc);
	}

	def(beginUpdate)
	{
		startAsyncInvoke
		{
			private self = _this;
			if !(self getv(__cancellationToken)) then {
				private _udl = self getv(updateDelay);
				if (_udl > 0) then {
					if (tickTime<(self getv(lastUpdate)))exitWith{};
					self setv(lastUpdate,tickTime+_udl);
					(self getv(params)) call (self getv(code));
				} else {
					(self getv(params)) call (self getv(code));
				};
				isNullReference(self getv(srcObj))
			} else {
				true
			}
		},{},self
		endAsyncInvoke
	}

endstruct