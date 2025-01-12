// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define __rpcmode_client

//#ifdef __rpcmode_server
	//error("cant add client rpc - is server module")
//#endif

#define rpcAdd(name,code) [name,code] call client_addEvent

#define rpcAddGlobal(name,code) [name,code] call rpc_addEventGlobal

#define rpcRemove(name,id) [name,id] call client_removeEvent

#define rpcRemoveGlobal(name,id) [name,id] call rpc_removeEventGlobal

#define rpcCall(name,args) [name,args] call client_callEvent

#define rpcSendToServer(name,args) [name,args] call client_sendToServer


//Здесь не существует rpcSendGlobal потому что изначально клиентам запрещено делать общие рассылки. Мы следуем модели клиент-сервер