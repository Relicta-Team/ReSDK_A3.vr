// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Компонент GOLib
	Служит обозревателем библиотеки объектов.
	Подгружает данные из библиотеки.
	Управляет регистрацией новых классов.
*/
golib_vis_debug_createTestClass = false; //создание тестового класса в обозревателе для отладки 

golib_hasUnsavedChanges = false;

//развернутая панелька
golib_vis_isexpanded = false;

golib_vis_loadedCategory = 0;
golib_vis_widget_tree = [widgetNull];

golib_vis_handleUpdate = -1;
golib_vis_isholdedLMB = false;
golib_vis_holdedLMB_data = "";
golib_vis_holdedLMBControl = [widgetNull];
golib_vis_treelastholdedPath = [];
golib_vis_treeLastSeachInput = tickTime;
if (isNIL{golib_vis_assoc_ModelToConfig}) then {
	golib_vis_assoc_ModelToConfig = createHashMap;
	
	golib_om_internal_tovalidatemodels = [];
};

golib_mv_list_observObjects = [];
golib_mv_model = objNUll;
golib_mv_camera = objNUll;
golib_mv_observ_centerPos = [300,300,500];
golib_mv_observ_camPosRelative = [0,-2,2];
golib_mv_observ_widget_noGeom = [widgetNull];
golib_mv_observ_hasGeom = false;
golib_mv_observ_stateLeftPanel = false;
golib_mv_observ_stateRightPanel = false;

#define INTERACT_LODS_CHECK_STANDART "VIEW","FIRE"
//#define INTERACT_LODS_CHECK_STANDART "ROADWAY","VIEW"
#define INTERACT_LODS_CHECK_GEOM "GEOM","VIEW"

golib_vis_isInsideLibPreview = false; //true будет обрабатывать превью

//vars subsystems
golib_internal_buffer_icons = [];
//end vars subsystems

golib_internal_map_marks = createHashMap;
golib_internal_map_connected = createHashMap; //ссылки на которых ссылки подключенных объектов
golib_internal_map_contMarks = createhashMap;

golib_hashData_keys = [
	"class", //референс на текущий объект (строка)
	"initCode", //код, вызываемый после создания объекта. (строка)
	"customProps", //свойства окна состояния установленные через инспектор (массив хэшкарты)
	"invisible", //объект невидим в редакторе
	"mark", //глобальная метка на объект. Доступ к объекту можно получить из любого места и скрипта
	"prob", //вероятность появления объекта
	"rdir", //рандомное направление объекта
	"rpos", //рандомный радиус при спавне
	"containerContent", //содержимое контейнера при спавне
	"edConnected", //какие энергетические источники подключены к этому объекту
	//code segments
	"code_onInit" //вызывается после создания объекта
];

#include "GOLib_energy.sqf"
#include "GOLib_cacheStorage.sqf"
#include "GOLib_functions.sqf"
#include "GOLib_visual.sqf"
#include "GOLib_objectManager.sqf"
#include "GOLib_hashData.sqf"
#include "GOLib_itemIcons.sqf"
#include "GOLib_modelViewer.sqf"
#include "GOLib_arraySelector.sqf"
#include "GOLib_codeEditor.sqf"
#include "GOLib_Layers.sqf"
#include "GOLib_modelAssoc.sqf"