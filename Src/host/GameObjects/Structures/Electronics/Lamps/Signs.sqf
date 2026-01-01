// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>

//вывеска бар
class(SignBar) extends(StreetLampEnabled)
	var(name,"Бар");
	var(desc,"Знаменитый Бар ""Кабак""! Эта вывеска так приятно переливается своими цветами и будто зазывает каждого прохожего внутрь.");
	editor_attribute("EditorVisible" arg "type:string") editor_attribute("Tooltip" arg "Описание таблички в выключенном состоянии")
	var(descDisabled,"Знаменитый Бар ""Кабак""! Судя по отсуствию красивой подсветки заведение сейчас не работает.");
	var(light,"SLIGHT_LEGACY_SIGN_BAR" call lightSys_getConfigIdByName);
	var(edIsEnabled,true);
	var(edReqPower,80);
	var(model,"ca\signs2\sign_bar_ru.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,30);
	var(dr,1);

	func(getDescFor)
	{
		objParams_1(_usr);

		private _buf = "";
		private _output = "";
		// Не самое элегантное решение, но чтобы не заморачиваться можно и так оставить
		if !getSelf(edIsEnabled) then {
			private _desc = getSelf(descDisabled);
			if (isNullVar(_desc) || {_desc == ""}) exitWith {super()};
			_desc
		} else {
			super();
		};

	};
endclass

//вывеска кабак
class(SignTableKabak) extends(IStruct)
	var(name,"Кабак");
	var(desc,"И кому же пришло в голову назвать заведение Бар ""Кабак""?! В любом случае это лучшее место чтобы расслабиться в ближайшей округе.");
	var(model,"ca\signs2\signb_pub_ru1.p3d");
	var(material,"MatWood");
	var(dr,1);
endclass


//крест лекарни
class(SignMedical) extends(SignBar)
	var(model,"ca\signs2\signb_pharmacy.p3d");
	var(material,"MatSynt");
	var(name,"Лекарня");
	var(edReqPower,80);
	var(desc,"Иногда лечат, иногда - калечат...");
	var(light,"SLIGHT_LEGACY_SIGN_MEDICAL" call lightSys_getConfigIdByName);
endclass
