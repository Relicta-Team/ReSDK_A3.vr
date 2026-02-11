// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define __rpcmode_server

//#ifdef __rpcmode_client
	//error("cant add server rpc - is client module")
//#endif

#define rpcAdd(name,code) [name,code] call server_addEvent

#define rpcAddGlobal(name,code) [name,code] call rpc_addEventGlobal

#define rpcRemove(name,id) [name,id] call server_removeEvent

#define rpcRemoveGlobal(name,id) [name,id] call rpc_removeEventGlobal

#define rpcCall(name,args) [name,args] call server_callEvent

// rpcSend(rpcTypeClient,0,"test",null)
#define rpcSendToClient(owner,name,args) [owner,name,args] call server_sendtoclient
#define rpcSendToObject(owner,name,args) [owner,name,args] call server_sendtoclientobject

#define rpcSendToAll(name,args) [name,args] call server_sendtoallclients

#define rpcSendGlobal(name,args) [name,args] call rpc_sendGlobal

#define getVObjectLink(ref) (ref getvariable ['link',locationnull])

#define unrefObject(assignVar,ref,iferrordo) private assignVar = getVObjectLink(ref); if !isExistsObject(assignVar) exitWith {iferrordo}