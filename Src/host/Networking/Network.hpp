// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

#define netSendVar(var,val,own) [var,val,own] call net_send

#define netSendVarToObject(var,val,objs) [var,val,objs] call net_sendToObject

#ifdef ENABLE_LAG_NETWORK
	#define netSetGlobal(var,val) invokeAfterDelayParams({missionNamespace setVariable ['var' arg _this arg true]},__LAG_NETWORK_GET_LAG__,val)
	#define nsind(ind) (_this select ind)
	#define netSyncObjVar(obj,var,val) invokeAfterDelayParams({nsind(0) setvariable [nsind(1) arg nsind(2) arg true]},__LAG_NETWORK_GET_LAG__,[obj arg var arg val])
#else
	#define netSetGlobal(var,val) missionNamespace setVariable ['var',val,true]
	#define netSyncObjVar(obj,var,val) obj setvariable [var,val,true]
#endif