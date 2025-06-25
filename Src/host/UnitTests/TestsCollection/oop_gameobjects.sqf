// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"

TEST(GameObjects_ResourceManagement)
{    
    private _getActiveThreadCount = { count cba_common_perFrameHandlerArray };
    private _curActiveCount = oop_cao;
    logformat("Active objects count before test: %1",_curActiveCount);
    {
        private _runningThreads = call _getActiveThreadCount;
        private _type = _x;
        traceformat("Creating object: %1",_type);
        private _beforeAllocatedList = getAllAllocatedObjects();
        private _o = instantiate(_type);

        ASSERT_STR(!isNullReference(_o),"Null reference on create " + _type);

        traceformat("Running threads: %1",(call _getActiveThreadCount) - _runningThreads);


        delete(_o);
        private _liveObjects = getAllAllocatedObjects() - _beforeAllocatedList;
        private _curActObjCount = oop_cao - _curActiveCount;
        traceformat("Live objects count: %1",count _liveObjects);
        traceformat("current active objects: %1",_curActObjCount);
        private _livObjCtr = 0;
        {
            private _cls = callFunc(_x,getClassName);
            
            //must be null if is type or class (not object)
            if (isNullVar(_cls)) then {continue};

            logformat("Live object: %1 (%2)",_x arg _cls);
            INC(_livObjCtr);
        } foreach _liveObjects;

        //checks counters
        ASSERT_STR(_livObjCtr == _curActObjCount,"Active objects count is not equal to created objects count after delete " + _type + " => left objects: " +str _livObjCtr + "; active: "+ str _curActObjCount);
        ASSERT_STR(_curActObjCount == 0,"Active objects count is not 0 after delete " + _type + " => left objects: " + str _curActObjCount);

    } foreach getAllObjectsTypeOf(GameObject);
}