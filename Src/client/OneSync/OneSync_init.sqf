// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\ClientRpc\clientRpc.hpp>

namespace(OneSync;os_)

/*
	OneSync - модуль синхронизации.
	Он предназначен для снижения расхода сетевого трафика засчёт единоразовой
	синхронизации и симуляции на клиенте

	Работа системы.

	Система служб синхронизации запускается когда клиент подключается в игру
	(заходит в моба) и отключается когда он выходит с сервера или возвращается
	в лобби.

	Создание модуля.

	Все компоненты данной системы определяются следующим образом:
		1. В os::list::services заносим название службы
		(прим. falling - служба обработки падения персонажа)

		2. Определяя модуль нужен метод как точка входа. Его имя должно принимать вид:
		os_<module_name>_setEnable(bool mode); где,
			module_name - имя модуля, которое должно быть в os::list:services
			mode - режим активации. true - означает активировать модуль

*/

#include "OneSync_Falling.sqf"
#include "OneSync_mobcollision.sqf"
#include "OneSync_light.sqf"
#include "OneSync_steps.sqf"

decl(string[])
os_list_services = ["falling","light","steps" /*,"mobcollision" Коллизия сломана*/];

decl(bool)
os_isActive = false;

decl(void())
os_start = {

	if (os_isActive) exitWith {
		error("[OS::START]: All services already enabled");
	};

	private __nullmodule = {
		params ["_mode"];
		errorformat("[OS::START]: Cant initialize module %1. Entry point not found",toUpper _x);
	};

	{
		[true] call (missionNamespace getVariable ["os_" + _x + "_setEnable",__nullmodule]);
	} foreach os_list_services;

	os_isActive = true;
};

decl(void())
os_stop = {
	if (!os_isActive) exitWith {
		error("[OS::STOP]: All services already stopped");
	};

	private __nullmodule = {
		params ["_mode"];
		errorformat("[OS::STOP]: Cant stop module %1. Entry point not found",toUpper _x);
	};

	{
		[false] call (missionNamespace getVariable ["os_" + _x + "_setEnable",__nullmodule]);
	} foreach os_list_services;

	os_isActive = false;
};
