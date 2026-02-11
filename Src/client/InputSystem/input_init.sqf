// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include <..\ClientRpc\clientRpc.hpp>
#include <..\LightEngine\LightEngine.hpp>
#include <inputKeyHandlers.hpp>

#include "inputManager.sqf"
#include "InputAssoc.sqf"
#include "inputKeyHandlers.sqf"
//#include "inputHelper.sqf"

namespace(Input,input_)

(findDisplay 46) displayAddEventHandler ["KeyUp",onGameKeyInputs];
(findDisplay 46) displayAddEventHandler ["KeyDown",onGameInputs_Down];
(findDisplay 46) displayAddEventHandler ["MouseButtonUp",onGameMouseInputs];

decl(bool)
input_catchedEscape = false;



//Хандлить ли нативную паузу
decl(bool)
input_internal_handleNativeEsc = false;

#ifdef DISABLE_SCRIPTED_ESCAPE_MENU
	if (!isMultiplayer) then {input_internal_handleNativeEsc = true};
#endif

__handleEscapeMenu = {
	if (input_internal_handleNativeEsc) exitWith{};

	if !isNullReference(findDisplay 49) then {
		if (!input_catchedEscape) then {
			input_catchedEscape = true;
			(findDisplay 49) closeDisplay 0;
			[false] call esc_openMenu;
		};
	};
}; startUpdate(__handleEscapeMenu,0);
