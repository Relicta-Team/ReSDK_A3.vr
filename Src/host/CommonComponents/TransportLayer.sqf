// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//network transport layer

//TODO write

//TODO register client and server rpc with hashes: rpcAdd(addRpcName(someevent),{}) ->
//rpc is non events

//event system in new module addEvent(var) = [];

/*
server:
rpcadd(serverrpctest) -> 1

client:
rpcadd(clientrpctest) -> 3

compile->
client_toserver_rpcs - как получить: при добавлении новых серверных rpc
----
server_toclient_rpcs = [1,"serverrpctest"] < as build
...
Ни клиент, ни сервер в стандартном билде не получает чужих rpc-s. Выдача либо по сети, либо через копирование ассоциаций
Данный функционал рекомендуется реализовать при низкой производительности

*/
rpc_servermap = createHashMap;
rpc_internal_regEnum_server = {
	params ["_enumName"];

	if (!isNull(pc_servermap get _enumName)) exitWith {
		errorformat("Cant add server rpc %1. Rpc already exists",_enumName);
	};

	rpc_servermap set [_enumName,count rpc_servermap];
};
