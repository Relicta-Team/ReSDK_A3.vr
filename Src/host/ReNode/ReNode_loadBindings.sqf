// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"
//! флаг для внутренний файлов, который выполнит только загрузку функций (без инициализации модуля)
//В заголовочнике engine.hpp доступен через IS_INIT_MODULE
private __FUNCITONS_LOAD_ONLY__ = true;

//Сюда вставляются пути до функций, которые должны быть регистрированы в библиотеке
//внутри файлов с функциями составляются определения через node_func

#include "compiled\resdk_graph.h"

//common headers region
#include "..\ServerRpc\serverRpc.hpp"
#include "..\ClientManager\Client.hpp"
#include "..\..\client\SoundSystem\Music.hpp"
//end common headers region

#include "ReNode_bindingHelpers.sqf"

//тут зарегистрированы узлы общего назначения (работа с типами, операторы)
#include "_systemNodes.sqf"
#include "_array.sqf"
#include "_string.sqf"
#include "_conversions.sqf"
#include "_math.sqf"
#include "_math.logical.sqf"
#include "_model.sqf"
#include "_hashmap.sqf"
#include "_objects.sqf"

//типы стандартных перечислений
#include "_enums.sqf"
//структуры
#include "_structures.sqf"

//dependency enums
#include "_clients.sqf"
#include "_system.sqf"

nodeModule_register("native_functions")

//objects management
nodeModule_setPath("Игровые объекты.Утилиты")
#include "..\NOEngine\NOEngine.h"
#include "..\NOEngine\NOEngine.hpp"
#include "..\PointerSystem\pointers.hpp"
#include "..\NOEngine\NOEngine_ObjectManager.sqf"

nodeModule_setPath("Игровая логика.Ролевая система")
#include "..\GURPS\Gurps.sqf"

nodeModule_register("clients")
nodeModule_setPath("Клиенты")
#include "..\ClientManager\ClientManager.h"
#include "..\ClientManager\functions.sqf"

//gamemode control (get all clients, game duration, gamestate (with enums: LOBBY, PLAY, END))
nodeModule_register("gamemode")
nodeModule_setPath("Контроль игры")
//host\GamemodeManager\GamemodeFunctions.sqf
#include "..\GamemodeManager\GamemodeManager.h"
#include "..\GamemodeManager\GamemodeManager.hpp"
#include "..\GamemodeManager\GamemodeFunctions.sqf"

nodeModule_register("taskSystem")
nodeModule_setPath("Игровая логика.Задачи.Утилиты")

#include "..\GameModes\taskSystem_functions.sqf"

nodeModule_register("namingSystem")
nodeModule_setPath("Игровая логика.Характеристики.Национальности")
#include "..\Namings\Naming_nodes.sqf"

#include "_regex.sqf"

//