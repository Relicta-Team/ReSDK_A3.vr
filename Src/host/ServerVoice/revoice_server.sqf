// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include "..\ServerRpc\serverRpc.hpp"
#include "..\PointerSystem\pointers.hpp"

//сюда заносятся отметки кто говорит и на какой частоте
vs_server_map_transferData = createHashMap;

//синхронизирует сетевую переменную с клиентами
vs_server_syncSpeakNetVar = {
	netSetGlobal(vs_netSpeakers,vs_server_map_transferData);
};

//событие вызывается когда клиент начал говорить в частоту
vs_server_onRadioSpeakStart = {
	params ["_actor","_ptr"];
	
	private _radio = pointer_get(_ptr);
	if !pointer_isValidResult(_radio) exitWith {}; //invalid pointer

	private _actorName = _actor getvariable ["rv_name",""];
	if (_actorName == "") exitWith {}; //no name

	private _freq = callFunc(_radio,getRadioFrequencyKey);
	private _wavePower = callFunc(_radio,getRadioWavePower);

	private _args = [_actorName,_ptr,_freq,_wavePower];
	rpcSendToAll("vsr_onspk",_args);
};
rpcAdd("vssrv_spk",vs_server_onRadioSpeakStart);

//событие вызывается когда клиент закончил говорить в частоту
vs_server_onRadioSpeakStop = {
	params ["_actor","_ptr"];
	
	private _radio = pointer_get(_ptr);
	if !pointer_isValidResult(_radio) exitWith {}; //invalid pointer

	private _actorName = _actor getvariable ["rv_name",""];
	if (_actorName == "") exitWith {}; //no name

	private _freq = callFunc(_radio,getRadioFrequencyKey); //!частота могла поменяться?

	private _args = [_actorName,_ptr,_freq];
	rpcSendToAll("vsr_onnspk",_args);
};
rpcAdd("vssrv_nspk",vs_server_onRadioSpeakStop);


vs_server_onClientDisconnected = {
	params ["_clientName"];
	rpcSendToAll("vsr_oncldis",[_clientName]);
};