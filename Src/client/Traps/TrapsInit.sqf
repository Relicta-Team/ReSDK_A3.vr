// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\Inventory\inventory.hpp>
#include <..\LightEngine\LightEngine.hpp>
#include <..\ClientRpc\clientRpc.hpp>

namespace(Traps,traps_)

/*
	Порядок работы:
		1. клиент во время подгрузки получает все известные ловушки (перед NOE загрузчиком)
		2. Когда создаётся объект он автоматически сверяется
		3. При добавлении новой ловушки вызывается событие syncTrap, второй параметр указывает видит ли клиент ловушку.
		
	Ремарки:
		- неактивные ловушки удаляются у всех клиентов из списка указателей.
		- у неактивных ловушек выключается освещение
		- при активации свет включается. После активации синхронизируются листы знающих клиентов.
		- если кто-то знал о ловушке вдалеке и она удалилась или отключилась, то
		при возврате ловушки не будет так как выгруженный свет будет удалять из памяти ловушку
		
	Метод ресинка должен вызываться только при авторизации клиента
*/
decl(set<string>)
traps_hashSet_pointers = hashSet_createEmpty();

//Загружает все известные ловушки
decl(void(set<string>))
traps_resyncAllTraps = {
	private _ptrlist = _this;
	call traps_unhideAll;
	//first clear prev
	traps_hashSet_pointers = hashSet_create(_ptrlist);
	call traps_syncAll;
	
}; rpcAdd("resyncTraps",traps_resyncAllTraps);

decl(void())
traps_unhideAll = {
	{
		[_x,true] call traps_syncObject;
	} foreach hashSet_toArray(traps_hashSet_pointers);
};

decl(void())
traps_syncAll = {
	{
		[_x] call traps_syncObject;
	} foreach hashSet_toArray(traps_hashSet_pointers);
};

decl(void(mesh))
traps_checkKnownObject = {
	params ["_o"];
	private _ref = _o getVariable "ref";
	if hashSet_exists(traps_hashSet_pointers,_ref) then {
		[_ref] call traps_syncObject;
	} else {
		[_ref] call traps_syncObject;
	};
};

decl(void(string))
traps_AutoDispose = {
	params ["_ptr"];
	hashSet_rem(traps_hashSet_pointers,_ptr);
};

//
decl(void(string;bool))
traps_syncObject = {
	params ["_ref","_doKnown"];
	private _obj = noe_client_allPointers getOrDefault [_ref,objNUll];
	if isNullReference(_obj) exitWith {};
	
	//sync state
	if isNullVar(_doKnown) then {
		_doKnown = _ref in traps_hashSet_pointers;
	} else {
		if (_doKnown) then {
			hashSet_add(traps_hashSet_pointers,_ref);
		} else {
			hashSet_rem(traps_hashSet_pointers,_ref);
		};
	};
	
	//visualize
	_obj hideObject (!_doKnown);
	
}; rpcAdd("syncTrap",traps_syncObject);