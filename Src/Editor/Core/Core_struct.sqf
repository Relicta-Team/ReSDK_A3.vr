// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(core_initStruct)
{
    if !isNullVar(core_objPool) then {
        core_objPool = null; //cleanup object pool (on recompile editor code)
    };
    core_objPool = struct_new(ObjectPool);
};

struct(BaseObject)
    def(_address) -1;

    def(init)
    {
        core_objPool callp(new_,self);
    }

    def(del)
    {
        core_objPool callp(delete_,self);
    }

endstruct

struct(ObjectPool)
    
    def(_pool) null;
    def(_iaddr) 0;
    
    def(init)
    {
        self setv(_pool,createHashMap);
    }

    def(new_)
    {
        params ["_obj"];
        private _addr = self getv(_iaddr);
        _obj setv(_address,_addr);
        self getv(_pool) set [str _addr,_obj];
        self setv(_iaddr,_iaddr + 1);
    }

    def(delete_)
    {
        params ["_obj"];
        private _addr = _obj getv(_address);
        self getv(_pool) deleteAt (str _addr);
    }

    def(del)
    {
        {
            struct_erase(_y);
        } foreach (self getv(_pool));
    }
endstruct