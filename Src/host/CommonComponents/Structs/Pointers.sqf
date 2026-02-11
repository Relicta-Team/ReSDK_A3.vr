// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define SAFE_REFERENCE_POOL_CONTAINER 0
#define SAFE_REFERENCE_POOL_COUNTER 1
#define SAFE_REFERENCE_POOL_NAME 2

#define SAFE_REFERENCE_MEMORY_ADDR "mpstor"

//создание нового пула для безопасных ссылок
SafeReference_CreatePool = {
	params ["_poolName"];
	if (_poolName == "") then {
		_poolName = format["AnonimousPool at %1 (frame %2)",tickTime,diag_frameNo];
	};
	private _m = mem_alloc(); 
	private _pool = [createHashMap,1,_poolName];
	mem_set(_m)[SAFE_REFERENCE_MEMORY_ADDR,_pool];
	_m
};

sref_defaultPool = ["DefaultPool"] call SafeReference_CreatePool;

/* 
	Safe reference. Used for bypass crossreferences and possible memory leaks
	
	!Required str override for fix memory leaks on print
	
	Usage:

		Default allocator:

		_ref = struct_newp(SafeReference,"some value");
		_val = _ref callv(getValue); //some value
		_ptr = _ref callv(getPtr); // 1
		_ref = null; //called releaseRef

		Custom allocator:

		_alloc = ["ExamplePool"] call SafeReference_CreatePool;
		_ref = struct_newp(SafeReference,"value" arg _alloc);
		_val = _ref callv(getValue); //value
		_ptr = _ref callv(getPtr); // 1
		_ref = null; //called releaseRef
*/
struct(SafeReference)
	def(_ctsr) null  //safereference pointers pool

	def(iptr) 0 //null pointer by default

	def(init)
	{
		params ['_obj',["_ctObj",sref_defaultPool]];
		
		self setv(_ctsr,_ctObj);
		
		//unpack storage
		_ctObj = mem_get(_ctObj,SAFE_REFERENCE_MEMORY_ADDR);

		private _curi = _ctObj select SAFE_REFERENCE_POOL_COUNTER;
		self setv(iptr, _curi);
		_ctObj select SAFE_REFERENCE_POOL_CONTAINER set [_curi,_obj];
		_ctObj set [SAFE_REFERENCE_POOL_COUNTER,_curi + 1];
	}

	// получает объект контейнера хранящего значения ссылок
	def(_getContainer) { mem_get(self getv(_ctsr),SAFE_REFERENCE_MEMORY_ADDR) select SAFE_REFERENCE_POOL_CONTAINER}

	// получает сырой указатель. Указатели равные 0 высвобождены
	def(getPtr) {self getv(iptr)}

	// получает значение
	def(getValue) {(self callv(_getContainer)) get (self getv(iptr))}

	//освобождение ссылки
	def(releaseRef)
	{
		(self callv(_getContainer)) deleteAt (self getv(iptr));
		self setv(iptr,0);
	}

	def(del)
	{
		self callv(releaseRef);
	}

	def(str)
	{
		private _pn = mem_get(self getv(_ctsr),SAFE_REFERENCE_MEMORY_ADDR) select SAFE_REFERENCE_POOL_NAME;
		format["ref:%1<%2>=>%3",self getv(iptr),_pn,self callv(getValue)]
	}

	//сравнение типа ссылки. Если они из одного контейнера возвращает true
	def(isEqualPoolType)
	{
		params ["_other"];
		private _c1 = self callv(_getContainer);
		private _c2 = _other callv(_getContainer);
		_c1 isEqualRef _c2
	}

endstruct

//test validate circular reference
// struct(__debugContainer)
// 	def(_alloc) (["test_alloc"] call SafeReference_CreatePool);
// 	def(_selfPtr) null
// 	def(init)
// 	{
// 		self setv(_selfPtr,struct_newp(SafeReference,self arg self getv(_alloc)));
// 	}
// 	def(del)
// 	{
// 		traceformat("OBJDEL %1",tickTime)
// 	}
// 	def(str)
// 	{
// 		"container[x]"
// 	}	
// endstruct
// debug_ptrs = {
// 	_p = ["__debugContainer"] call struct_alloc;
// 	["SafeReference",[_p,_p get "_alloc"]] call struct_alloc
// };

//!noerror but resources not released
// struct(_debugCStr)
// 	def(_ref)null
// 	def(init)
// 	{
// 		params ["_r"];
// 		self setv(_ref,_r);
// 	}
// 	def(str) {"debug cstr"}
// 	def(del){traceformat("cstr deleted",0)}
// endstruct
// struct(_refCtt)
// 	def(_orig) null
// 	def(str) {"ref ctt"}
// 	def(del){traceformat("reference deleted",0)}
// endstruct
// debug_ccref_str = {
// 	_o = struct_new(_refCtt);
// 	_o2 = struct_newp(_debugCStr,_o);
// 	_o setv(_orig,_o2);
// 	_o2
// };

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