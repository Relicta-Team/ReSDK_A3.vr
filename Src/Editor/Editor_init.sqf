// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Редактор карт. Версия 2.0

	Запланированные возможности:
		Всё в одном месте - редактор теперь часть кор системы. Все объекты существуют в редакторе при разработке.
		Обратная совместимость - ммпорт старых версий карт.
		Хранение карт в бинарных файлах - загрузка карт не требует разных веток.
		Удобное создание - библиотека игровых объектов для быстрого прототипирования.
		Переработанный e-code язык - редактирование состояния инициализации на макро-языке для ООПа так же как и в игре.
		Создание наборов заранее подготовленных сцен - используется например при создании событийных малых локаций или локаций обучения

	Компоненты:
		- core - системные компоненты, настройки, управление файловой системой, инициализатор.
		- gameobjectassembly - менеджер сборки игровых объектов
		- gameobjectinspector - функционал просмотра и изменения свойств объектов
		- gameobjectlibrary - обозреватель объектов
		- keyboardinput - управление пользовательским вводом
		- logger - функции логирования
		- mapsmanager - загрузчик и сборщик карт
		- simulation - функции опциональной симуляции и настроек симуляции
		- systemtools - различные сторонние компоненты и утилиты 
		- visualcomponents - утилиты для редакторов с предпросмотром
		- widgets - компоненты для работы с ui
		
		
		иконки для истории:
		a3\3den\data\Cfg3DEN\History\connectItems_ca.paa
		a3\3den\data\Cfg3DEN\History\createComment_ca.paa
		a3\3den\data\Cfg3DEN\History\rotateItems_ca.paa
		a3\3den\data\Cfg3DEN\History\pasteItems_ca.paa
		a3\3den\data\Cfg3DEN\History\deleteItems_ca.paa
		a3\3den\data\Cfg3DEN\History\disconnectItems_ca.paa
		a3\3den\data\Cfg3DEN\History\multipleOperations_ca.paa
		a3\3den\data\Cfg3DEN\History\addToLayer_ca.paa
		a3\3den\data\Cfg3DEN\History\create_ca.paa
		a3\3den\data\Cfg3DEN\History\makeNewLayer_ca.paa
		a3\3den\data\Cfg3DEN\History\changeSeat_ca.paa
		a3\3den\data\Cfg3DEN\History\removeFromLayer_ca.paa
		a3\3den\data\Cfg3DEN\History\changeAttributes_ca.paa
		a3\3den\data\Cfg3DEN\History\moveItems_ca.paa
		a3\3den\data\Cfg3DEN\History\scaleItems_ca.paa
		a3\3den\data\Cfg3DEN\History\missionNew_ca.paa

		
*/
#include <..\host\engine.hpp>
#include <..\host\oop.hpp>
#include <..\host\text.hpp>
#include <..\host\keyboard.hpp>
#include <..\host\GameObjects\GameConstants.hpp>

#include <..\client\Inventory\inventory.hpp>

#include <Widgets\Widgets.hpp>

//assertion
call compile __pragma_preprocess "src\host\CommonComponents\Assert.sqf";

//встраиваемые предварительные функции
#include <..\host\precompiled.sqf>

//структуры
#define STRUCT_INIT_FUNCTIONS
#include <..\host\struct.hpp>
#undef STRUCT_INIT_FUNCTIONS
//структурная библиотека
#include <..\host\CommonComponents\StructLib.sqf>
//дефайны для лута
#include <..\host\LootSystem\LootSystem_structs.sqf>
//algorithm
call compile __pragma_preprocess "src\host\CommonComponents\Algorithm.sqf";
//light system
call compile __pragma_preprocess "src\host\CommonComponents\LightCfg.sqf";
//dynamic map loader
call compile __pragma_preprocess "src\host\MapManager\DynamicMapLoader.sqf";

//Отладчик
#include <..\host\Tools\EditorWorkspaceDebug\InternalImpl.sqf>
;relicta_debug_onPostErrorHandle = {
	//fix lock engine on posterror
	cba_common_perFrameHandlerArray = [];
	cba_common_PFHhandles = [];
	cba_common_waitAndExecArray = [];

	cba_common_waitAndExecArray = [];
	cba_common_waitAndExecArrayIsSorted = false;
	cba_common_nextFrameNo = diag_frameno + 1;
	cba_common_nextFrameBufferA = [];
	cba_common_nextFrameBufferB = [];
	cba_common_waitUntilAndExecArray = [];
};

#include <..\host\CommonComponents\ModelTransform.hpp>
#include <..\client\Rendering\Render_debug.sqf>
#include <..\host\Yaml\Yaml_init.sqf>

//renode отладчик
#include "..\host\ReNode\ReNode_debugger.sqf"

#include <EditorEngine.h>

//Строковое название версии. Пишется в пользовательском интерфейсе редактора
Core_version_name = "1.19";
//Номер версии сборки редактора. Используется в бинарных файлах карт.
Core_version_number = 5;

Editor_enableAutoloadGOLIB = true;

//core
componentInit(Core)
#include "Core\Core_init.sqf"
componentInit(Core_struct)
#include "Core\Core_struct.sqf"
componentInit(Core_fileWatcher)
#include "Core\Core_fileWatcher.sqf"
componentInit(Core_pathes)
#include "Core\Core_pathes.sqf"
componentInit(Core_io)
#include "Core\Core_io_helper.sqf"
componentInit(Core_context)
#include "Core\Core_context.sqf"
componentInit(Core_common)
#include "Core\Core_common.sqf"
componentInit(Core_common_colors)
;table_hex = "0123456789abcdef"splitString ""; //зависимость
#include "..\host\CommonComponents\Color.sqf"
componentInit(PerFrame)
#include "Core\Core_perFrameHandler.sqf"
componentInit(Settings)
#include "Core\Core_settings.sqf"
componentInit(System_tools)
#include "SystemTools\SystemTools_init.sqf"
componentInit(Logger)
#include "Logger\Logger_init.sqf"
componentInit(Simulation)
#include "Simulation\Simulation_init.sqf"
//ui
componentInit(Widget)
#include "Widgets\Widget_init.sqf"
componentInit(Keyboard_input)
#include "KeyboardInput\KBInput_init.sqf"
componentInit(Game_objects_inspector)
#include "GameObjectsInspector\Inspector_init.sqf"
componentInit(Game_objects_assembly)
#include "GameObjectsAssembly\GOAsm_init.sqf"
componentInit(Game_objects_library)
#include "GameObjectsLibrary\GOLib_init.sqf"
componentInit(GameMode_manager)
#include "GamemodesManager\GamemodeManager_init.sqf"
componentInit(Maps_manager)
#include "MapsManager\Maps_manager_init.sqf"
componentInit(Viusal_components)
#include "VisualComponents\VisualComponents_init.sqf"
componentInit(Visual_scripting)
#include "VisualScripting\VisualScripting_init.sqf"

componentInit(Core_postInit)
#include "Core\Core_postInit.sqf"
