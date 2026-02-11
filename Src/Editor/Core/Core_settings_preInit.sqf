// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//настройки из конфига
//! Порядок структуры с дефолтным значением не должен быть изменён
/*	название, 
		описание, 
		значение по умолчанию и тип настройки (check,input, num_input,list,region), 
			check - 2 значения вкл и выклю
			input - строковое значение
			num_input - как строковое но работает с числом
			list - выпадающий список
			region - раздел настроек (без значений)
		валидатор значения для установки (_value значение для проверки)
		событие после установки значения при успешной валидации (_value входное значение)
			Это событие так же вызывается при инициализации настроек (во время загрузки редактора)
			Здесь так же доступна переменная _isInit, принимающая значение true если это первичная загрузка
			Если настройка типа list то так же есть переменная _allValues которая предоставляет лист всех возможных значений
	
	Получить значение настройки можно через: "NAME" call core_settings_getValue
	
	Все настройки так же доступны по своим переменным: cfg_[name]
*/

#define validate_check {equalTypes(_value,false)}
#define validate_list_str {equalTypes(_value,"") && _value in _allValues}
#define validate_list_num {equalTypes(_value,0) && _value in _allValues}

#define list_variants_addrange(values) +[null,values]

core_settings_list_default = [
	["region","System","Различные системные настройки"],
		["system_enableChunkviewOnLoad",
			[
				"Отображать чанки при загрузке редактора",
				"Включает отображение чанков при загрузке редактора",
				[false,"check"],validate_check,
				{
					if (_isInit && _value) then {
						call pertest_chunkViewToggle;
					};
				}
			]
		],
		["system_enableIconsOnLoad",
			[
				"Включить иконки объектов при загрузке редактора",
				"Включает отображение иконок при загрузке редактора\nОбратите внимание, что отключенные иконки также отключат отображение названий объектов",
				[true,"check"],validate_check,
				{
					if (_isInit && _value) then {
						if !(call MouseArea_isEnabledIcons) then {
							call MouseArea_toggleIcons;
						};
					};
				}
			]
		],
		["system_enableLinesOnLoad",
			[
				"Включить линии границ объектов при загрузке редактора",
				"Включает отображение линий границ объектов при загрузке редактора",
				[true,"check"],validate_check,
				{
					if (_isInit && _value) then {
						if !(call MouseArea_isEnabledLines) then {
							call MouseArea_toggleLines;
						};
					};
				}
			]
		],
		["system_enableClassNamesOnLoad",
			[
				"Включить отображение класснеймов объектов при загрузке редактора",
				"Включает отображение имен классов объектов при загрузке редактора",
				[false,"check"],validate_check,
				{
					if (_isInit && _value) then {
						if !(drawNames_enabled) then {
							(_value) call drawNames_setEnable;
						};
					};
				}
			]
		],
		["system_extendedInfoInClassname",
			[
				"Расширенная информация в имени класса",
				"Отображает дополнительную информацию вместе с именами классов (материал, хп и т.д.)",
				[false,"check"],validate_check
			]
		],
		["system_classNamesDrawDistance",
			[
				"Расстояние отображения класснеймов объектов",
				"Устанавливает расстояние отображения имен классов в сцене. Число в диапазоне от 5 до 200",
				[50,"num_input"],
				{finite _value && inRange(floor _value,5,200)},
				{drawNames_distance = _value}
			]
		],
		["system_classNamesNoShown",
			[
				"Не отображаемые имена классов",
				"Укажите список классов, которые не будут отображаться при включенном режиме отображения классов в сцене\nНапример: blockdirt,decor,candle - выключит отображение имен всех блоков земли, декораций и свечей",
				["","input"],
				{true},
				{
					drawNames_internal_listNoShown = (_value splitString ";, |") apply {tolower _x};
				}
			]
		],
		["system_enableDrawCursorOnLoad",
			[
				"Включить отображение курсора геометрии при загрузке редактора",
				"Включает отображение курсора геометрии при загрузке редактора",
				[false,"check"],validate_check,
				{
					if (_isInit && _value) then {
						if !(geoCursor_enabled) then {
							call geoCursor_toggle;
						};
					};
				}
			]
		],
		["system_enableKeymapInfoOnVcomLoad",
			[
				"Показать информацию о клавишах в редакторе эмиттеров и позиций модели",
				"Включает показ скрываемого информационного сообщения с доступными клавишами управления",
				[true,"check"],validate_check
			]
		],

	["region","General","Общие настройки редактора"],
		["gen_leftTabSize",
			[
				"Размер панели инспектора",
				"Устанавливает ширину панели инспектора.\nЗначение, равное 0 сбросит ширину на стандартный размер"+
				"\n\nПри изменении потребует перезапуска редактора",
				[0,"num_input"],
				{finite _value && inRange(floor _value,0,30)},
				{if (!_isInit) then {
					["Для изменения настройки размера полей инспектора перезапустите или рекомпилируйте редактор"] call showInfo;
				}}
			]
		],
		["gen_rightTabSize",
			[
				"Размер панели библиотеки объектов",
				"Устанавливает ширину панели библиотеки объектов.\nЗначение, равное 0 сбросит ширину на стандартный размер"+
				"\n\nПри изменении потребует перезапуска редактора",
				[0,"num_input"],
				{finite _value && inRange(floor _value,0,30)},
				{if (!_isInit) then {
					["Для изменения настройки размера полей библиотеки объектов перезапустите или рекомпилируйте редактор"] call showInfo;
				}}
			]
		],
	/*
		gen_leftTabSize
		gen_rightTabSize
	*/
	["region","Emitter editor","Настройки редактора эмиттеров"],
		["emed_enableFloorByDefault",
			[
				"Показывать пол при запуске",
				"Включает показ пола при запуске редактора эмиттеров",
				[true,"check"],validate_check
			]
		],
		["emed_enableCustomRenderByDefault",
			[
				"Собственный рендер при запуске",
				"Включает показ собственного рендера при запуске редактора эмиттеров",
				[true,"check"],validate_check
			]
		],
		["emed_enableNightByDefault",
			[
				"Ночь при запуске",
				"Включает темное время суток при запуске редактора эмиттеров",
				[true,"check"],validate_check
			]
		],
	["region","File watcher system","Система отслеживания изменения файлов в проекте"],
		["fws_enabled",
			[
				"Включить отслеживание изменения",
				"Включает отслеживание изменения файлов в проекте",
				[true,"check"],validate_check,{
					if (!_isInit) then {
						["Для изменения режима отслеживания изменений перезапустите редактор"] call messageBox;
					} else {
						call fileWatcher_initialie;
					};
				}
			]
		],
		["fws_autorecompEditor",
			[
				"Авторекомпиляция редактора при изменении",
				"Включает авторекомпиляцию редактора при изменении кода редактора",
				[true,"check"],validate_check
			]
		],
	["region","Prefab creator",""],
	/*
		map_enableGeometryCursorOnLoad
	*/
		["prefab_openFileAfterCreated",
			[
				"Показать сгенерированный объект при создании префаба в редакторе кода",
				"Открывает редактор VS Code и показывает файл, в котором сгенерирован новый префаб",
				[false,"check"],validate_check
			]
		],
	["region","Debug","Отладочные настройки, не предназначенные для использования в пользовательской среде."],
		["debug_devMode", //debug_devMode - отключает блокировки некоторых вещей
			[
				"Режим отладки",
				"",
				[false,"check"],validate_check,{
					call winapi_setWinHeader;
				}
			]
		],
		["debug_enableGeneratorsMenu",
			[
				"Включить меню генерации",
				"Активирует пункт меню с различными системными генераторами",
				[false,"check"],
				validate_check,
				{
					_nf = {
						private _value = _this;
						[menu_path_generators,_value] call menu_setEnable;
					}; 
					if (_isInit) then {
						//из-за порядка инициализации в следующем кадре
						nextFrameParams(_nf,_value);
					} else {
						_value call _nf;
					};
				}
			]

		],
		["debug_allowTraceMessages",
			[
				"Разрешить трассировочные сообщения",
				"",
				[false,"check"],validate_check,{}
			]
		],
		["debug_allowEditorRecompile",
			[
				"Разрешить рекомпиляцию редактора",
				"",
				[false,"check"],validate_check,{
					_nf = {
						private _value = _this;
						[menu_path_recompEditor,_value] call menu_setEnable;
						[menu_path_recompEditorFull,_value] call menu_setEnable;
					}; 
					if (_isInit) then {
						nextFrameParams(_nf,_value);
					} else {
						_value call _nf;
					};
				}
			]
		],
		["debug_allowClassLibRecompile",
			[
				"Разрешить рекомпиляцию библиотеки объектов",
				"",
				[false,"check"],validate_check,{
					_nf = {
						private _value = _this;
						[menu_path_recompClassLib,_value] call menu_setEnable;
					}; 
					if (_isInit) then {
						nextFrameParams(_nf,_value);
					} else {
						_value call _nf;
					};
				}
			]
		],
		["debug_allowPlatformTools",
			[
				"Разрешить использование встроенных инструментов",
				"Сюда входят: Просмотрщик конфигураций, консоль отладки, просмотр анимаций и расширенная камера",
				[false,"check"],validate_check,{
					_nf = {
						private _value = _this;
						for "_i" from 0 to (menu_path_platformSysTools call menu_getSize) - 1 do {
							[menu_path_platformSysTools+[_i],_value] call menu_setEnable;
						};
					}; 
					if (_isInit) then {
						nextFrameParams(_nf,_value);
					} else {
						_value call _nf;
					};
				}
			]
		],
		["debug_allowSelectUnits",
			[
				"Разрешить выделение юнитов",
				"Разрешает выделение юнитов в редакторе, что позволяет перемещать их\n\n"+
				"При включенном режиме отладки значение этого параметра игнорируется",
				[false,"check"],validate_check,{}
			]
		],
		["debug_allowSelectSystemObject",
			[
				"Разрешить выделение системного объекта",
				"Разрешает выделение системного объекта, в котором хранится базовая информация о текущей редактируемой карте\n\n"+
				"При включенном режиме отладки значение этого параметра игнорируется",
				[false,"check"],validate_check,{}
			]
		],
	/*
		
		,
		
		
	*/
	["region","Object library","Настройки обозревателя объектов"],
		["objlib_showHiddenClasses",
			[
				"Показывать скрытые классы",
				"Показывать классы, помеченные атрибутом HiddenClass в библиотеке объектов",
				[false,"check"],
				validate_check,
				{
					if (!_isInit) then {call golib_vis_loadObjList};
				}
			]
		],
	/*
		objlib_defaultSearchType - name,classname
		objlib_showHiddenClasses
		objlib_canCreateInterfaceClassObject - do not enable
	*/
	["region","Simulation",""],
	/*
		simulation_buildMapBeforeSimulate
	*/
		["sim_startAtNight",
			[
				"Выключать глобальное освещение при старте",
				"При старте симуляции выключает глобальное освещение, полностью эмулируя освещение подземного окружения\n"+
				"Иными словами - этот параметр включает 'ночь' при симуляции",
				[true,"check"],validate_check
			]
		],
		["sim_startWithLogVars",
			[
				"Показывать окно отладки в симуляции",
				"Показывает окно отладки во время симуляции в котором содержатся различные статистики",
				[true,"check"],validate_check
			]
		],
		["sim_startWithMemUsageInfo",
			[
				"Показывать информацию о затратах памяти в симуляции",
				"Показывает окно с информацией о затратах памяти во время симуляции",
				[false,"check"],validate_check
			]
		],
		["sim_disableRayCastSphere",
			[
				"Выключить отображение сферы при взаимодействии с миром",
				"Отключает отображение сферы при взаимодействии с миром в режиме симуляции.",
				[false,"check"],validate_check
			]
		],
	["region","Map",""],
		
		["map_autosaveBinary",
			[
				"Сохранять файл карты при сохранении в рабочей области",
				"Автоматически сохраняет карту в хранилище карт при сохранении карты в рабочей области",
				[false,"check"],validate_check
			]
		],
		["map_canBuildBeforeSimulate",
			[
				"Собирать карту перед симуляцией",
				"Автоматически собирает карту перед запуском симуляции",
				[true,"check"],validate_check
			]
		],
	/*
		map_enableGeometryCursorOnLoad
	*/

	["region","Тестовые настройки","Тестовые настройки разных типов"]
	// ["test_list",
	// 	[
	// 		"testing list",
	// 		"select any element",
	// 		["A","list"] + list_variants_addrange(["A" arg "B"]),
	// 		validate_list_str
	// 	]
	// ],
	// ["test_list_numeric",
	// 	[
	// 		"testing list (numbers)",
	// 		"select any element",
	// 		[24,"list"] + list_variants_addrange([24 arg 525 arg 16 arg 287 arg 994 arg 161]),
	// 		validate_list_num
	// 	]
	// ],
	// ["test_check",
	// 	[
	// 		"Тестовая настройка check",
	// 		"This is check",
	// 		[false,"check"],
	// 		{equalTypes(_value,false)},
	// 		{}
	// 	]
	// ],
	// ["test_input",
	// 	[
	// 		"testing input floor (0-100)",
	// 		"Input some number here...",
	// 		[0,"num_input"],
	// 		{inRange(_value,0,100) && {floor _value == _value}}
	// 	]
	// ],
	// ["test_input_string",
	// 	[
	// 		"testing input somestring (maxchar 32)",
	// 		"some string",
	// 		["hello!!!","input"],
	// 		{equalTypes(_value,"") && {count _value <= 32}}
	// 	]
	// ]
];


#undef validate_check
#undef validate_list_str
#undef validate_list_num

#undef list_variants_addrang