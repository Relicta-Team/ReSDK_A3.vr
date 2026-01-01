// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*

	Some medical variables...

*/
#include <..\WidgetSystem\widgets.hpp>

#include "..\..\host\lang.hpp"
namespace(clientData,cd_)

// Задержка между проверками. Каждые 100 мс
macro_const(cd_unconsciousCheckDelay)
#define __UNCONSCIOUS_DELAY__ 0.1

decl(bool)
cd_isUnconscious = false; //в бессознанке
decl(bool)
cd_internal_uncState = false; //внутрення переменная перехода состояния

decl(void())
cd_onUnconsciousCode = {

	// faster
	if not_equals(cd_isUnconscious,cd_internal_uncState) then {
		cd_internal_uncState = cd_isUnconscious;
		[cd_isUnconscious] call cd_onUnconsciousEvent;
	};

}; startUpdate(cd_onUnconsciousCode,__UNCONSCIOUS_DELAY__);

//fired when unc state is changed
//например замутить персонажа, закрыть все дисплеи и тд.
decl(void(bool))
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
