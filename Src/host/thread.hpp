// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


/*
	Example:

	_t = threadNew(null) {
		threadName("This is thread");
		threadSleep(10);

	};
	threadStart(_t);

	threadStart(threadNew(null) some_function );

*/

#define threadNew(code) [[],code]

#define threadNewArgs(code,args) [args,code]

#define threadStart(thdObj) thdObj call {private _t = (_this select 0)spawn(_this select 1);allThreads pushback _t; _t}

#define threadName(name) scriptname (name)

#define thisThread _thisScript

#define threadStop(thd) terminate (thd)

#define threadSleep(time) uisleep (time)

#define threadNull ScriptNull

#define isAsyncContext canSuspend

//critical section

#define criticalSectionStart isNil {

#define criticalSectionEnd };


//mutex

#define mutexNew() []

#define mutexLock(mutex) waitUntil { (mutex pushBackUnique 0) == 0;}

#define mutexUnlock(mutex) mutex deleteAt 0

#define mutexTryLock(mutex) if(((mutex) pushBackUnique 0) == 0) then {true} else {false}
#define mutexIsLocked(mutex) (count (mutex) > 0)

// diag_tickTime becomes less accurate the longer a mission is running, so higher timeout value is better for robustness
#define mutexTryLockTimeout(mutex, timeout) [] call { private _timer = diag_tickTime; private _locked = false; waitUntil { _locked = ((mutex) pushBackUnique 0) == 0; _locked || {diag_tickTime > (_timer + (timeout))} }; _locked }
