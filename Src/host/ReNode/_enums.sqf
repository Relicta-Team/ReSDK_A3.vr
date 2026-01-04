// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

node_system_group("enums")

["SpawnPointType",
	[
		"Спавнпоинт:0:Точка спавна является единственной с уникальным именем.",
		"Случайный спавнпоинт:1:Точка спавна является множественной. Случайные спавнпоинты имеют общие имена и при выборе точки спавна для случайных выбирается одна из точек с одинаковым именем."
	],
"name:Тип спавнпоинта
desc:Тип точки спавна. Точки спавна бывают случайные и уникальные"]
node_enum

["SpawnLocationConnectionType",
	[
		"Глобальная ссылка:0:Уникальное имя объекта для спавна",
		"Тип объекта:1:Тип искомого объекта для спавна",
		"Не определено:2:Не использовать привязку к объекту при спавне"
	],
"name:Точка привязки
desc:Точка привязки персонажа к объекту. Эта структура предназначена для расположения заспавненных персонажей на стульях или кроватях."
] node_enum

//skills_internal_list_otherSkillsSystemNames
#include "..\GameModes\ScriptedSkillsDecl.hpp"

_capArr = [];
{
	_x params ["_sSys",'_sRu'];
	_capArr pushBack (capitalize(_sRu) +":"+ (str _foreachIndex));
} foreach skills_nodes_listKinds;

["SkillType",
	_capArr,
	"
	name:Вторичный атрибут
	namelib:Перечисление вторичных атрибутов
	desc:Перечисление вторичных атрибутов, содержащее все возможные вторичные атрибуты, которыми может владеть персонаж.
	"
]
node_enum

_capArr = [];
{
	_capArr pushBack ((INV_LIST_SLOTNAMES select _foreachIndex)+":"+(str(INV_LIST_ALL select _foreachIndex)));
} foreach INV_LIST_VARNAME;
["InventorySlot",_capArr,
	"name:Тип слота
	namelib:Тип слота инвентаря
	desc:Перечисление типов инвентарных слотов. Содержит все слоты, в которые могут быть назначены предметы игровым персонажам
	"
]
node_enum

assert_str(!isNull(go_internal_chatMesMapText),"go_internal_chatMesMap is null. Cant generate enum ChatMessageChannel");
_capArr = [];
{
	(_x splitString ":") params ["_mName","_mDesc"];
	_capArr pushBack (_mName +":"+ (str _forEachIndex)+":"+_mDesc);
} foreach go_internal_chatMesMapText;
["ChatMessageChannel",_capArr,
	"name:Тип сообщения чата
	namelib:Тип сообщения чата
	desc:Перечисление типов сообщений чата отвечает за накладываемый стиль на текст, который будет выведен в чате игрока.
	"
]
node_enum

//access
_capArr = [];
{
	(_x splitstring ":") params ["_acclvlStr","_accName",["_desc",""]];
	private _val = _accName + ":" + _acclvlStr;
	if (_desc != "") then {_val = _val + ":" + _desc};
	_capArr pushBack _val;
} foreach ACCESS_LIST_NODE_BINDING;
["AccessLevel",_capArr,
	"
	name:Уровень доступа
	desc:Перечисление уровней доступа. Содержит все доступные уровни доступа."
]
node_enum


["MusicChannel",MUSIC_LIST_NODE_ENUM_DEF,
	"name:Музыкальный канал
	desc:Канал для воспроизведения музыки. Каждый канал имеет свой приоритет, где базовый канал является каналом с самым низким приоритетом.
	"
]
node_enum


["Gender",[
	"Мужчина:0",
	"Женщина:1",
	"Общий:2"
],
	"name:Пол сущности"
]
node_enum

["NamingDeclension",[
	"Им. (кто):0:Имя в именительном падеже - Человек",
	"Род. (кого):1:Имя в родительном падеже - Человека",
	"Дат. (кому):2:Имя в дательном падеже - Человеку",
	"Вин. (кого,что):3:Имя в винительном падеже - Человека",
	"Твор. (кем):4:Имя в творительном падеже - Человеком",
	"Предл. (О ком):5:Имя в предложном падеже - Человеке"
],
	"name:Склонение имён
	desc:Склонения имён сущностей."
]
node_enum

#include "..\Namings\FaceList_categories.h"
["Nation",face_list_category apply {format["%1:%2:",_x select 3,_x select 0]},
	"name:Национальность
	desc:Перечисление национальностей. Содержит все типы национальностей для людей.
	enumtype:string
	"
]
node_enum

#include "..\GameObjects\ConstantAndDefines\Mobs.h"
["DirectionSide",NODE_DIR_LIST_ALL,
	"name:Направление
	desc:Перечисление направлений. Содержит 4 основных направления.
	"
]
node_enum

["BoneStatus",BONE_STATUS_LIST_NODE_BINDING,
"
	name:Состояние костей
	desc:Перечисление состояния костей для части тела.
"] node_enum

["EntityStance",NODE_STANCE_LIST_ALL,
	"name:Положение моба
	desc:Перечисление активных положений тела мобов. Существует всего 3 активных положения: Стоя, сидя и лежа.
	"
] node_enum

["EntitySpeedMode",NODE_SPEED_MODE_LIST_ALL,
"
	name:Режим движения
	desc:Перечисления состяний движения сущности.
"
] node_enum

["LightMode",NODE_LIGHT_LIST_ALL,
	"
		name:Освещённость
		desc:Перечисление состояний освещённости объектов.
	"
] node_enum

["VisibilityMode",NODE_VISIBILITY_MODE_LIST_ALL,
"
	name:Видимость
	desc:Видимость физического тела. Используется в проверках возможности видимости объектов.
"] node_enum

#include "..\GameObjects\GameConstants.hpp"
["SideIndex",NODE_SIDE_LIST_ALL,
	"name:Сторона
	desc:Данное перечисление содержит 2 значения\: левая сторона и правая. Перечисление может быть использовано например для определения частей тела с разных сторон.\n"+
	"Для преобразования стороны в индекс используйте формулу\: ABS CEIL (side * 0.1)
	"
] node_enum


#include "..\GamemodeManager\GamemodeManager.hpp"
["GameState",GAME_STATE_LIST_NODE_BINDING,
"
	name:Состояние игры
	desc:Перечисление состояний игровой сессии. Существует 4 состояния: ожидание установки режима, расстановка по ролям в лобби, процесс игры, конец раудна. "+
	"Вы можете использовать математические операторы сравнения для определения состояний игры.
"
] node_enum

#include "ReNode.h"
["ConsoleLogType",RENODE_MSG_CONSOLE_TYPE_LIST_NODE_BINDING,
"
	name:Тип сообщения консоли
	desc:Типы сообщений, которые можно вывести в консоль.
"] node_enum


#include "..\CombatSystem\CombatSystem.hpp"
["DamageType",DAMAGE_TYPE_LIST_NODE_BINDING,
"
	name:Тип урона
	desc:Перечисление типов урона.
	enumtype:string
"
] node_enum

["TargetZone",TARGET_ZONE_LIST_NODE_BINDING,
"
	name:Целевая зона
	desc:Целевая зона персонажа (например, для повреждений) 
"] node_enum

["BodyPart",BODY_PART_LIST_NODE_BINDING,
"
	name:Часть тела
	desc:Часть тела персонажа для ссылки на объекты частей тела. 
"] node_enum

["AttackType",ATTACK_TYPE_LIST_NODE_BINDING,
"
	name:Тип атаки
	desc:Тип атаки. Отвечает за то как будет производиться атака.
	enumtype:string
"] node_enum

#include "..\GURPS\gurps.hpp"
["DiceResult",DICE_RESULT_LIST_NODE_BINDING,
"
	name:Результат броска кубиков
	desc:Результат броска кубиков. Успех, провал, крит.успех или крит.провал.
"
] node_enum

#include "..\SpecialActions\SpecialActions.hpp"
["SpecialActionType",SPECIAL_ACTION_LIST_NODE_BINDING,
"
	name:Специальное действие
	desc:Специальное действие, производимое персонажем. По умолчанию вызывается через кнопку ""F"".
"] node_enum

//!!! enum helper
nodeModule_register("enumhelper")
nodeModule_setPath("Перечисления.Преобразования")
nodeModule_setRenderType("NoHeaderText")

[
	"enumGetNames","Имена перечислений:Получить имена перечислений",
	"values enum_vToK_@gettype.in.1.clear_type()",
	"auto:Перечисление"
		opt "typeget=value;@type:allowtypes=*enum",
	"array[string]:Массив имён:Массив имён перечисления",
	"Этот узел позволяет получать список имен, хранящихся в перечислении."
] reg_unary

[
	"enumGetValues","Значения перечислений:Получить значения перечислений",
	"(+enum_values_@gettype.in.1.clear_type())",
	"auto:Перечисление"
		opt "typeget=value;@type:allowtypes=*enum",
	"array[int]:Массив значений:Массив значений перечисления",
	"Этот узел позволяет получать список значений перечислений, хранящихся в перечислении."
] reg_unary