// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractCombat,interactCombat_)

decl(bool)
interactCombat_disableGlobal = false; //true means upper combat menu is not shown

decl(bool)
interactCombat_isLoadedMenu = false;

decl(int)
interactCombat_csModesType = 0; //0 handed,1 shooting

inline_macro
#define addCStyle(_color,name,nameranged,_enum) ['name','_color',_enum,'nameranged']
decl(any[])
interactCombat_styleMap = [
	//+++ заниженный урон в 3 раза
	addCStyle(#20C92C,Слабая атака,Слабая атака,COMBAT_STYLE_WEAK),
	//контраатака с бонусом если кто-то пытается атаковать цель. при стрельбе так же
	//++Увеличивает вашу реакцию - парирование и уворот, даёт возможность контратаковать. Цена: замедляет перемещения, ослабляет вашу атаку, повышает уязвимость к финтам.
	//(пока только как ближний бой) при атаке с огнестрелом автоматически атакует
	addCStyle(#DE6F14,Защита,Стрельба при нападении,COMBAT_STYLE_T_DEFENSE),
	//бонус к защите +3, ... я не вижу смысла в этом стиле...
	//addCStyle(#3B34CF,Отступление,Отступление,COMBAT_STYLE_RETEART),

	//++обманка. если чел защищается заставит преждевременно парировать. открывая для настоящей атаки.
	//++в случае со стрельбой понижает точность но цель в которую стреляли начинает испытывать штраф к точности
	addCStyle(#C1D911,Финт,Подавление,COMBAT_STYLE_FINT),
	//++тратит больше стамины, но выбирает большую силу при атаке
	addCStyle(#D91120,Сильная атака,Сильная атака,COMBAT_STYLE_STRONG_ATTACK),
	//только для одноручных
	//++атака сразу двумя оружиями разными. первым и вторым
	//++при стрельбе стреляет второй рукой
	addCStyle(#1871B5,Двойная атака,Стрельба двумя руками,COMBAT_STYLE_DOUBLE_ATTACK),
	//++дольше задержка после атаки, но выше шанс попасть. (броня пока упрощённая)укол по конечностям будет в сочленения брони
	//++при стрельбе повышает точность, но дольше задержка и персонаж должен стоять на месте перед атакой.
	addCStyle(#0EC06A,Прицельная атака,Меткая стрельба,COMBAT_STYLE_AIMED_ATTACK),
	//++быстрая атака. цели штраф к защите. но удары с -2 к силе. меньше задержка
	//++стрельба: меньше задержка между выстрелами но понижена точность
	addCStyle(#9413B9,Яростная атака,Быстрая стрельба,COMBAT_STYLE_FAST_ATTACK)
];
decl(map)
interactCombat_map_widgetStyles = createHashMap;
decl(map)
interactCombat_hud_map_Styles = createHashMap;
{
	interactCombat_hud_map_Styles set [_x select CS_MAP_INDEX_ENUM,
		[
			_x select CS_MAP_INDEX_COLOR,
			_x select CS_MAP_INDEX_TEXT,
			_X select CS_MAP_INDEX_TEXT_RANGED
		]
	];
} foreach interactCombat_styleMap;

decl(widget[])
interactCombat_curWidgets = [widgetNull,widgetNull,widgetNull]; //CM_CUR_IND_CS,CM_CUR_IND_ATT,CM_CUR_IND_DEF
//сюда вносятся типы атак
decl(any[])
interactCombat_at_list_types = [];
decl(int)
interactCombat_at_assocEnum = ATTACK_TYPE_ASSOC_HAND;
//карта ассоциаций виджетов типов атаки. ключ тип
decl(map)
interactCombat_map_attTypeWidgets = createHashMap;
//карта виджетов типов защиты. ключ тип
decl(map)
interactCombat_map_defTypeWidgets = createHashMap;
//cd_curAttackType - текущий тип атаки

//виджеты комбата в порядке объявления
decl(widget[])
interactCombat_at_widgets = [];