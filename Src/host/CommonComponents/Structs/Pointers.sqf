// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Safe reference. Used for bypass crossreferences and possible memory leaks
sref_cont = createHashMap;
sref_i = 0;
struct(SafeRef)
	def(iptr) null //integer pointer is just a number

	def(init)
	{
		params ['_obj'];
		private _curi = sref_i;
		self setv(iptr, _curi);
		sref_cont set [_curi,_obj];
		sref_i = _curi + 1;		
	}
	def(releaseRef)
	{
		sref_cont deleteAt (self getv(iptr));
	}
	def(getPtr) {self getv(iptr)}
	def(getValue) {sref_cont get (self getv(iptr))}

	def(del)
	{
		self callv(releaseRef);
	}

	def(str)
	{
		format["ref:%1<%2>",self getv(iptr),self callv(getValue)]
	}
endstruct

//base interface for smart pointers
struct(_SmartPointerBase)
	def(_v) null

	//_ptr callv(get)
	def(get)
	{
		self getv(_v)
	}

	def(deleted) {isNull(self getv(_v))}

	def(dispose)
	{
		if !(self callv(deleted)) then {
			self callv(disposeImpl);
			self setv(_v,null);
		};
	}

	def(disposeImpl) {}

	def(init)
	{
		params ["_value"];
		self setv(_v,_value);
	}

	def(del)
	{
		self callv(dispose);
	}

	def(str) { format["%1[%2]",struct_typename(self),self getv(_v)] }
endstruct

struct(AutoModelPtr) base(_SmartPointerBase)
	def(disposeImpl) { deleteVehicle (self getv(_v)); }
endstruct

struct(AutoObjectPtr) base(_SmartPointerBase)
	def(disposeImpl) { delete(self getv(_v)) }
endstruct

/*
	AutoHandlePtr - smart pointer for update handles
	if (true) {
		_u = startUpdate({},2);
		_ptr = struct_newp(AutoHandlePtr,_u);
	};
*/
struct(AutoHandlePtr) base(_SmartPointerBase)
	def(disposeImpl) { stopUpdate(self getv(_v)) }
endstruct


/*
	AutoPtr - a smart pointer. It deletes the object when the last reference is deleted.

	Example usage:
		if (true) then {
			private _model = "VehicleConfigExample" createVehicle [0,0,0];
			private _obj = struct_newp(AutoPtr,_model);
			logformat("Autoptr value is %1",_obj callv(get));
		};
		assert(isNullReference(_model))

	----
		decl temp class
		class(TempClass)
			var(_p_obj,null);
		endclass

		creating object on heap
		private _vobj = new(TempClass); //base object
		prvate _rfvobj = new(object); // some object
		private _autoptr = struct_newp(AutoPtr,_vobj); //creating autoptr
		setSelf(_vobj,_p_obj,_autoptr); //assign ptr

		_postCalled = {
			_vobj_ref = _this;
			_strong_ref = getVar(_vobj,_p_obj) callv(get);
			assert(!isNullReference( _vobj_ref ));
			assert(!isNullReference( _strong_ref ));

			delete(_vobj_ref);

			assert(isNullReference( _vobj_ref ));
			assert(isNullReference( _strong_ref ));
		};

		invokeAfterDelayParams({delete(_this)},2,_vobj);
*/
struct(AutoPtr) base(_SmartPointerBase)
	def(_v) null
	def(init)
	{
		params ["_data"];
		self setv(_v,_data)
	}
	
	def(del)
	{
		callv(dispose)
	}

endstruct