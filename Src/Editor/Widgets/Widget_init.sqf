// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Компонент визуального интерфейса

displayObjectRef = [displayNull];
menu_internal_widget_refButtonObjLib = [widgetNull];
menu_internal_dumpNativeMenuItemsLayout = "";

widget_internal_contextmenu_tree = [];

widget_internal_contextmenu_entercolor = [0.3,0.3,0.3,0.7];
widget_internal_contextmenu_exitcolor = [0.6,0.6,0.6,0.7];

//специальный символ, который в дате будет игнорировать выход из листа
control_const_listElementNoExitAtSelect = "<<<$NO_EXIT$>>>";

//любой массив как структура: название, атрибуты, вложенные элементы
//атрибуты по типу строки: "text:Main"
/*
	Доступные атрибуты:
		text - название раздела или кнопки меню
		data - системные данные
		act - код, вызываемый при нажатии
		pic - картинка
		short - хоткей
		check - проверка состояния активности кнопки (переключаемое)
		url - ссылка
		ena - компилируемое условие для активности виджета
		path - сохраняет свой путь в глобальную ссылку
*/
menu_layout_allowedAttributes = ["text","data","act","pic","short","check","url","ena","path"];

menu_structureLayout = [
	["text:Relicta Editor;",
		"text:Статистика;act: []call bis_fnc_3DENMissionStats;",
		"text:Необходимые дополнения;data:OpenRequiredAddons",
		"text:Открыть папку проекта;data:FolderMission",
		"text:Открыть папку логов;data:FolderLog",
		"",
		"text:Полная рекомпиляция редактора;path:menu_path_recompEditorFull;act:"+(toString {[]spawn{isnil compileEditor}})/*+";short:"+str(KEY_P)*/, //ебаные чехи ебаной армы...
		"text:Рекомпиляция редактора;path:menu_path_recompEditor;act:"+(toString{[] spawn {isnil compileEditorOnly}}),
		//"text:Компиляция игровых объектов;act:goasm_builder_postInit_delegate call goasm_builder_build", //!!! не использовать!!!
		//"text:Перезагрузить редактор;",
		"text:Рекомпиляция библиотеки классов;path:menu_path_recompClassLib;act:"+(toString {call goasm_builder_rebuildClasses}),
		"text:Перезапуск редактора;act:"+(toString{[] spawn Core_reloadEditorFull}),
		"",
		"text:Выйти;data:Exit3DEN"
	],
	["text:Карта",
		"text:Сохранить текущую карту в рабочей области;data:MissionSave;short:543",
		"",
		"text:Создать новую карту;act: call mm_createNewMapSelector;",
		"text:Сохранить карту;act:[true] call mm_saveCurrentMapToFile;",
		"text:Открыть карту;act: call mm_openMapSelector;",
		"",
		"text:Выполнить сборку карты;act:[] call mm_build;",
		"text:Собрать все карты;act:['not implemented'] call showError;ena:false"
	],
	["text:Правка",
		"text:Отменить;data:Undo;short:556;pic:a3\3den\data\displays\display3den\toolbar\undo_ca.paa",
		"text:Вернуть;data:Redo;short:533;pic:a3\3den\data\displays\display3den\toolbar\redo_ca.paa",
		"",
		"text:Выбрать все на экране;data:SelectAllOnScreen;short:542;",
		"",
		["text:Режим трансформации",
			"text:Переключить режим;data:WidgetToggle;short:57",
			"text:Нет виджета;data:WidgetNone;short:2;pic:a3\3den\data\displays\display3den\toolbar\widget_none_off_ca.paa;",
			"text:Виджет перемещения;data:WidgetTranslation;short:3;pic:a3\3den\data\displays\display3den\toolbar\widget_translation_off_ca.paa;",
			"text:Виджет вращения;data:WidgetRotation;short:4;pic:a3\3den\data\displays\display3den\toolbar\widget_rotation_off_ca.paa;",
			"text:Виджет масштабирования области;data:WidgetScale;short:5;pic:a3\3den\data\displays\display3den\toolbar\widget_scaling_off_ca.paa;",
			"text:Виджет области;data:WidgetArea;short:6;pic:a3\3den\data\displays\display3den\toolbar\widget_area_off_ca.paa;"
		],
		["text:Сетка",
			"text:Включить сетку перемещения;data:MoveGridToggle;short:39;",
			"text:Включить сетку вращения;data:RotateGridToggle;",
			"text:Включить сетку масштабирования области;data:ScaleGridToggle;",
			"text:Уменьшить размер сетки;data:GridDecrease;act:['decrease'] call bis_fnc_3DENGrid;short:26;",
			"text:Увеличить размер сетки;data:GridIncrease;act:['increase'] call bis_fnc_3DENGrid;short:27;"
		],
		["text:Вертикальный режим",
			"text:Переключить вертикальный режим;data:VerticalToggle;short:40",
			"text:Над уровнем местности (ATL);data:VerticalATL;",
			"text:Над уровнем моря (ASL);data:VerticalASL;"
		],
		"text:Переключить привязку поверхности;data:SurfaceSnapToggle;act:do3DENAction 'SurfaceSnapToggle';short:43",//;check:get3DENActionState 'SurfaceSnapToggle'>0
		["text:Тип шаблона;",
			"text:Объекты;data:SelectObjectMode;short:59;",
			"text:Композиции;data:SelectGroupMode;act:;short:60;",
			"text:Избранное;data:SelectFavoritesMode;act:;short:65;",
			"text:Переключить подтип объекта;data:SubmodeToggle;act:;short:15;"
		]

	],
	["text:Вид",
		"text:Центрировать на выбранном элементе;data:CenterCameraOnSelected;act:call golib_vis_jumpToSelected;short:33;",
		"text:Переключить привязку камеры к выбранному объекту;act:call golib_vis_switchLockCameraOnSelected",
		"",
		"text:Переключить карту;data:ToggleMap;act:;short:50;",
		"text:Переключить текстуры карты;data:ToggleMapTextures;act:;short:532;",
		"",
		"text:Включить фонарик;data:ToggleFlashlight;act:[] call bis_fnc_3DENFlashlight;short:38;pic:a3\3den\data\displays\display3den\toolbar\flashlight_off_ca.paa;",
		"",
		//Пока не получится хандлить состояние стандартных панелек кроме как через onFrame эти фичи выключены
		/*["text:Поиск",
			"text:Поиск в библиотеке объектов (АРМА3);data:SearchCreate;act:;short:545;",
			"text:Поиск в элементах на сцене;data:SearchEdit;act:;short:1569;"
		],*/
		["text:Интерфейс",
			"text:Переключить иконки;act:call MouseArea_toggleIcons",
			"text:Переключить линии объектов;act:call MouseArea_toggleLines",
			"",
			"text:Переключить интерфейс;data:InterfaceToggle;act:with uinamespace do {'showInterface' call BIS_fnc_3DENInterface};short:14;",
			"text:Список элементов сцены;data:InterfacePanelLeft;act:call nativePanels_onToggleLeft;short:18;",
			"text:Библиотека объектов (АРМА3);data:InterfacePanelRight;act:call nativePanels_onToggleRight;short:19;",
			"text:Библиотека объектов (Relicta);act:call golib_vis_onPressButtonObjLib;",
			"text:Виджет навигации;data:InterfaceNavigationWidget;act:with uinamespace do {'navigationWidget' call BIS_fnc_3DENInterface};"
		],
		["text:Сцена",
			"text:Переключить отображение классов;act:(!drawNames_enabled) call drawNames_setEnable",//short:512 + 0x16
			"text:Переключить отображение курсора геометрии;act:call geoCursor_toggle",
			"text:Переключить отображение сетки чанков;act: call pertest_chunkViewToggle;",
			"text:Переключить отображение зон;act: call zoneVis_switchMode",
			"text:Переключить время суток;act:(!call rendering_isNightEnabled) call rendering_setNight"
		]
	],
	["text:Инструменты",
		"text:Пересборка ReVoicer;act: call revoicer_rebuild",
		["text:Системные инструменты;path:menu_path_platformSysTools",
			"text:Консоль отладки;data:DebugConsole;act:(ctrlparent (_this select 0)) createdisplay 'RscDisplayDebugPublic';;short:544;",
			"text:Просмотрщик конфигурации;data:ConfigViewer;act:[ctrlparent (_this select 0)] call (uinamespace getvariable 'bis_fnc_configviewer');short:2082;pic:a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa;",
			"text:Просмотр анимации;data:AnimationViewer;act:[] call (uinamespace getvariable 'bis_fnc_animviewer');",
			"text:Камера;data:SplendidCamera;act:[] call (uinamespace getvariable 'bis_fnc_camera');"
		],
		"",
		["text:Генераторы;path:menu_path_generators",
			//"text:Обновить шаблонные объекты;act:call golib_massoc_syncAndUpdateAllObjects", //IStruct to custom
			"text:Генерировать карту моделей;act:call systools_GenerateModelData",
			["text:Генерировать иконки предметов;",
				"text:Полная генерация;act:[true] call systools_imageProcessor;",
				"text:Только отсутствующие;act:[false] call systools_imageProcessor;",
				"text:Генерация по указанным;act:[true,true] call systools_imageProcessor;"
			],
			"text:Создать объектную библиотеку (ReNode);act:call vs_generateLib",
			"text:Запустить импорт старой карты;act:call mm_doImportOldMap",
			"text:Генерировать подписи библиотек клиента;act: call systools_generateLibInfo"
		],
		["text:Валидаторы",
			["text:Обновление объектов",
				"text:Запуск процедуры обновления;act:call golib_massoc_syncAllObjects",
				"text:Разрешение конфликтов;act:call golib_massoc_resolveConflictsProcess"
			],
			"text:Проверка ''мертвых'' классов (несуществующих классов);act:[false] call classValidator_process",
			"text:Проверка несуществующих конфигов света на карте;act:call lightValidator_process",
			"text:Проверка правильности конфигов света;act:call lightConfig_checkOptimizer",
			"text:Проверка путей классов;act:call systools_checkClassPathes",
			"text:Проверка классов с одинаковыми моделями;act:call classValidator_validateModels",
			"text:Проверка шансов спавна лута;act:call systools_openLootCheck",
			"",
			"text:Проверка нагрузки сцены игровыми объектами;act:call pertest_chunkPerformanceToggle;"
		],
		"",
		"text:Редактор ReNode;act:call vs_openEditor",
		["text:Кодогенерация",
			"text:Создать режим из шаблона;act:call gm_filegen_openWindow"
		],
		// "text:Менеджер режимов;act:call gm_createGamemode",
		// "",
		"text:Просмотр моделей;act:call golib_modelViewerContextOpen",
		"text:Редактор позиций модели;act:[nil] call vcom_relposEditorOpen",//vector maker - relative model positions
		"text:Редактор частиц и освещения;act:[nil] call vcom_emit_createVisualWindow",
		"text:(TODO) Редактор прокси-слотов" //own impl., saving on proxit: new buttons: setanim,setcombat
	],
	["text:Настройки",
		"text:Настройки ReEditor;act:call core_settings_openWinow",
		"",
		"text:Настройки редактора (встроенные);data:Preferences;act:edit3DENMissionAttributes 'Preferences';short:549;",
		"",
		"text:Параметры видео;data:OptionsVideo;",
		"text:Параметры аудио;data:OptionsAudio;",
		"text:Настройки игры;data:OptionsGame;",
		"text:Управление;data:OptionsControls;"
	],
	["text:Запуск;",
		"text:Запустить симуляцию;act:call sim_startupDefault;path:menu_path_launch;", //short:28; data:MissionPreview;
		"text:Запустить симуляцию с режимом;act:[true] call sim_openMapSelector",
		"text:Запустить симуляцию с режимом для этой карты;act:[false] call sim_openMapSelector",
		"text:Запуск симуляции с последним режимом и ролью;act:call sim_startSimFromCache",
		"text:Настроить симуляцию и запустить;act:call sim_openDetaliSetup",
		"",
		"text:Запуск/остановка симуляции частиц и освещения;act:[!lsim_mode] call lsim_setMode"
	],
	["text:Информация",
		"text:Версия редактора "+str Core_version_name + ";ena:false",
		"text:Автор Yodes;ena:false",
		"text:На сайт проекта;url:relicta.ru",
		"",
		"text:Гитхаб;pic:a3\3den\data\controls\ctrlmenu\link_ca.paa;url:github.com/Relicta-Team/ReSDK_A3.vr/tree/main",
		"text:Список изменений;pic:a3\3den\data\controls\ctrlmenu\link_ca.paa;url:github.com/Relicta-Team/ReSDK_A3.vr/commits/main"
	]
];


//scripts init here
#include "Widget_functions.sqf"
#include "Controls.sqf"
#include "Menu_functions.sqf"
#include "Widget_bindings.sqf"
#include "Widget_nativePanels.sqf"
#include "Widget_popup.sqf"
#include "Widget_ContextMenu.sqf"
#include "Widget_DisplayContextMenu.sqf"
#include "Widget_ContextHelper.sqf"
#include "Widget_dragger.sqf"
#include "MouseArea.sqf"
#include "GenericControls.sqf"
#include "LoadingScreen.sqf"
#include "DrawNames.sqf"
#include "Widget_WinApi.sqf"