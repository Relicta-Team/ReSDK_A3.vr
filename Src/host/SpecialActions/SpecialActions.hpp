// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//специальный макрос для флагов
#define __FLAG(flag) + flag


// Список пользовательских действий
// Действия помеченные как переключаемые или проигрываемые опредлены тут: src\client\Interactions\interactMenu_defines.sqf

#define SPECIAL_ACTION_NO -1

#define SPECIAL_ACTION_KICK 0
#define SPECIAL_ACTION_GRAB 1
#define SPECIAL_ACTION_BITE 2
#define SPECIAL_ACTION_JUMP 3
#define SPECIAL_ACTION_STEAL 4
#define SPECIAL_ACTION_STEALTH 5
#define SPECIAL_ACTION_EYES 6
#define SPECIAL_ACTION_SLEEP 7
#define SPECIAL_ACTION_THROW 8
#define SPECIAL_ACTION_BREATH 9


#define SPECIAL_ACTION_LIST_NODE_BINDING ['Без действия:SPECIAL_ACTION_NO:Спец.действие не определено' \
	,'Пинок:SPECIAL_ACTION_KICK:Специальное действие пинания персонажей или объектов' \
	,'Схватить:SPECIAL_ACTION_GRAB:Специальное действие хватания персонажей' \
	,'Кусать:SPECIAL_ACTION_BITE:Специальное действие укуса' \
	,'Прыжок:SPECIAL_ACTION_JUMP:Специальное действие прыжка' \
	,'Красть:SPECIAL_ACTION_STEAL:Специальное действие воровства предметов' \
	,'Прятаться:SPECIAL_ACTION_STEALTH:Специальное действие скрытности' \
	,'Глаза:SPECIAL_ACTION_EYES:Специальное действие для открытия и закрытия глаз' \
	,'Сон:SPECIAL_ACTION_SLEEP:Специальное действие для засыпания и пробуждения' \
	,'Бросать:SPECIAL_ACTION_THROW:Специальное действие для броска предметов' \
	,'Дыхание:SPECIAL_ACTION_BREATH:Специальное действие для задержания дыхания' \
]