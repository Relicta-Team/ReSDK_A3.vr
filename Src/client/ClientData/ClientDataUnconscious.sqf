// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*

	Some medical variables...

*/
#include <..\WidgetSystem\widgets.hpp>

// Задержка между проверками. Каждые 100 мс
#define __UNCONSCIOUS_DELAY__ 0.1

cd_isUnconscious = false; //в бессознанке
cd_internal_uncState = false; //внутрення переменная перехода состояния
_onUnconsciousCode = {

	// faster
	if not_equals(cd_isUnconscious,cd_internal_uncState) then {
		cd_internal_uncState = cd_isUnconscious;
		[cd_isUnconscious] call cd_onUnconsciousEvent;
	};

}; startUpdate(_onUnconsciousCode,__UNCONSCIOUS_DELAY__);

//fired when unc state is changed
//например замутить персонажа, закрыть все дисплеи и тд.
cd_onUnconsciousEvent = {
	params ["_isUncState"];

	if (_isUncState) then {
		
		//close net display
		if (nd_isOpenDisplay) then {
			call nd_onClose;
		};
		
		if (verb_isMenuLoaded) then {
			call verb_unloadMenu;
		} else {
			if (isOpenedVerbMenu) then {
				call inventory_unloadVerbMenu;
			};
		};
		
	} else {
		if ([player] call smd_isCombatModeEnabled) then {
			[player,true,true] call cc_setCombatMode;
		};
	};

};
