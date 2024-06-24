// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	В памяти клиента хранится временная информация о последних трансформах объектов
	Пример поднятия предмета и отработки интерполяции:
		1. персонаж делает запрос поднятия.
		2. с клиента выгружается мировой объект. 
			в этот момент в буфер трансформации заносится текущая информация объекта (указатель, позиция и т.д.)
		3. приходит обновление smd слота - по указателю смотрим в карту. объект найден - применяем интерполяцию
		- если lastupd вышел по таймауту - удаляем объект из буфера
	Пример выкладывания предмета:
		1. персонаж делает запрос выкладывания
		2. подгружается визуал в мире
		3. обновление smd слота удаляет предмет.
*/

//проверка буфера раз в секунду
#define NOE_CLIENT_INTERP_BUFFER_CHECK_TIMEOUT 1

noe_client_map_interp = createHashMap; //key ptr, val: vec2<pos,transf>
noe_client_list_ibuff = [];//[lastupd,ptr]

// noe_client_handleInterp = {
// 	params ["_o"];
// };

// noe_client_interpRegisterPtr = {
// 	params ["_o","_ptr"];
	
// 	if (_ptr in noe_client_map_interp) then {
// 		//update timeout
// 		private _dat = noe_client_map_interp get _ptr;
		
// 	} else {

// 	};
// };

// noe_client_onUpdateInterp = {
// 	private _del = false;
// 	private _buff = noe_client_list_ibuff;
// 	private _indexOffset = 0;
// 	{
// 		_x params ["_upd","_ptr"];
		
// 		if (_indexOffset > 0) then {
// 			(noe_client_map_interp get _ptr) set [0,_forEachIndex + _indexOffset];
// 		};

// 		if (tickTime >= _upd) then {
// 			_del = true;
// 			noe_client_map_interp deleteAt _ptr;
// 			_buff set [_forEachIndex,objNull];
// 			INC(_indexOffset);
// 		};
		
// 	} foreach _buff;

// 	if (_del) then {
// 		noe_client_list_ibuff = _buff - [objNull];
// 	};
// };

// noe_client_onUpdateInterp_handle = startUpdate(noe_client_onUpdateInterp,NOE_CLIENT_INTERP_BUFFER_CHECK_TIMEOUT); 



//!performance issues
// noe_client_handleNetworkInterpolation = {
// 	params ["_ptr","_tfrom","_tto"];
// }; rpcAdd("nitrp",noe_client_handleNetworkInterpolation);