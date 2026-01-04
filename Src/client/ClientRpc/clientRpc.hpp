// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(ClientRpc,client_)


#define __rpcmode_client

//#ifdef __rpcmode_server
	//error("cant add client rpc - is server module")
//#endif
inline_macro
#define rpcAdd(name,code) [name,code] call client_addEvent
inline_macro
#define rpcAddGlobal(name,code) [name,code] call rpc_addEventGlobal
inline_macro
#define rpcRemove(name,id) [name,id] call client_removeEvent
inline_macro
#define rpcRemoveGlobal(name,id) [name,id] call rpc_removeEventGlobal
inline_macro
#define rpcCall(name,args) [name,args] call client_callEvent
inline_macro
#define rpcSendToServer(name,args) [name,args] call client_sendToServer


//Здесь не существует rpcSendGlobal потому что изначально клиентам запрещено делать общие рассылки. Мы следуем модели клиент-сервер