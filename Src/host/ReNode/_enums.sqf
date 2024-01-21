// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
#define _r(v1,v2) [v1,v2]
skills_nodes_allowedMinSkillDefIndex = 4;
skills_nodes_listKinds = [
        _r("fp","усталость"),
		_r("will","воля"),
		_r("per","восприятие"),
		_r("hp","жизнь"),
		//other
		_r("fight","рукопашный бой"),
		_r("shield","щиты"),
		_r("fencing","фехтование"),
		_r("axe","топоры"),
		_r("baton","дубины"),
		_r("spear","копья"),
		_r("sword","мечи"),
		_r("knife","ножи"),
		_r("whip","кнуты"),

		_r("pistol","пистолеты"),
		_r("rifle","винтовки"),
		_r("shotgun","дробовики"),
		_r("crossbow","луки"),

		_r("throw","метание"),

		_r("chemistry","химичество"),
		_r("alchemy","грибничество"),

		_r("engineering","инженерия"),
		_r("traps","ловушки"),
		_r("repair","ремонт"),
		_r("blacksmithing","кузнечество"),
		_r("craft","создание"),

		_r("theft","воровство"),
		_r("stealth","скрытность"),
		_r("agility","акробатика"),
		_r("lockpicking","взлом"),

		_r("healing","первая помощь"),
		_r("surgery","хирургия"),

		_r("cavelore","знание пещер"),

		_r("cooking","готовка"),
		_r("farming","фермерство")
];
#undef _r

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
	_capArr pushBack ((INV_LIST_SLOTNAMES select _foreachIndex)+":"+(INV_LIST_ALL select _foreachIndex));
} foreach INV_LIST_VARNAME;
["InventorySlot",_capArr,
	"name:Тип слота
	namelib:Тип слота инвентаря
	desc:Перечисление типов инвентарных слотов. Содержит все слоты, в которые могут быть назначены предметы игровым персонажам
	"
]
node_enum

//enum helper
nodeModule_register("enumhelper")
nodeModule_setPath("Перечисления.Преобразования")
nodeModule_setRenderType("NoHeaderText")

[
	"enumGetNames","Имена перечислений:Получить имена перечислений",
	"values enum_vToK_@gettype.in.1.clear_type()","auto:Перечисление",
	"list[string]:Массив имён:Массив имён перечисления",
	"Этот узел позволяет получать список имен, хранящихся в перечислении."
] reg_unary

[
	"enumGetValues","Значения перечислений:Получить значения перечислений",
	"(+enum_values_@gettype.in.1.clear_type())",
	"auto:Перечисление"
		opt "typeget=value;@type:allowtypes=*enum",
	"auto:Массив значений:Массив значений перечисления"
		opt "typeget=array;@type",
	"Этот узел позволяет получать список значений перечислений, хранящихся в перечислении."
] reg_unary