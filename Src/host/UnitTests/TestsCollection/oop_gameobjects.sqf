// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


TEST(GameObjects_ResourceManagement)
{
    private _getActiveThreadCount = { count cba_common_perFrameHandlerArray };
    {
        private _runningThreads = call _getActiveThreadCount;
        private _type = _x;
        traceformat("Creating object: %1",_type);
        private _o = instatiate(_type);

        ASSERT_STR(!isNullReference(_o),"Null reference on create " + _type);

        traceformat("Active objects count: %1",oop_cao);
        traceformat("Running threads: %1",(call _getActiveThreadCount) - _runningThreads);


        delete(_o);
        private _liveObjects = count getAllCreatedObjects();
        {
            traceformat("Live object: %1 (%2)",_x arg callFunc(_x,getClassName));
        } foreach _liveObjects;

        //checks counters
        ASSERT_STR(count _liveObjects == oop_cao,"Active objects count is not equal to created objects count after delete " + _type + " => left objects: " + str oop_cao);
        ASSERT_STR(oop_cao == 0,"Active objects count is not 0 after delete " + _type + " => left objects: " + str oop_cao);

    } foreach getAllObjectsTypeOf(GameObject);
}