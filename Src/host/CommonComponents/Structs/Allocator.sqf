// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//only one reference to allocator
mmr_allocator_s = null;
//for initialize use:  mmr_allocator_s = struct_new(DefaultAllocator);

//use STRUCT_ROOT_TYPE StructBase for use allocator functionality
struct(StructBase)
    def(init)
    {
        self callv(getAllocator) callp(allocate,_o);
    }
    def(del)
    {
        self callv(getAllocator) callp(deallocate,_o getv(_address));
    }
    
    def(getAllocator) { mmr_allocator_s }
    def(_address) -1
endstruct

struct(IAllocator)
    def(init) {}
    def(del) {}
    def(allocate) {params ["_o"]};
    def(deallocate) {params["_p"]};
endstruct

struct(DefaultAllocator) base(IAllocator)
    
    def(init)
    {
        params ["_ocount"];
        
        if !isNullVar(_ocount) then {
            self setv(maxObjectCount,_ocount);
        };

        self setv(mmr_pool,[]); //initialize storage
    }

    def(del)
    {
        {
            if !isNullVar(_x) then {
                struct_erase(_x);
            };
        } foreach (self getv(mmr_pool));
    }
    
    def(mmr_pool) null;

    def(maxObjectCount) 999999
    def(_i) 0 //this is next given pointer for next allocation
    //allocate object in memory address and return pointer/address of object
    def(allocate)
    {
        params ["_o"];
        private _icur = self getv(_i);
        //check limit
        if (_icur >= (self getv(maxObjectCount))) exitWith {
            setLastError("Memory limit reached");
        };

        self getv(mmr_pool) set [_icur,_o];
        _o setv(_address,_icur);
        self setv(_i,_icur + 1);
    }

    def(deallocate)
    {
        params ["_ptr"];
        self getv(mmr_pool) set [_ptr, null];
    }
endstruct
