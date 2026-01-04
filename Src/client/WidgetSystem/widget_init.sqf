// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "widgets.hpp"
#include "blockedButtons.hpp"

namespace(WidgetSystem,NULL)


//init gui
("GUI" call bis_fnc_rsclayer) cutrsc ["GUI", "PLAIN"];
_display = uinamespace getvariable ["gui",DisplayNull];

#include "functions.sqf"
#include "defines.sqf"

decl(void())
removealldisplayevents = {
	(findDisplay 46) displayRemoveAllEventHandlers "keydown";
	(findDisplay 46) displayRemoveAllEventHandlers "keyup";
	(findDisplay 46) displayRemoveAllEventHandlers "mousebuttondown";
	(findDisplay 46) displayRemoveAllEventHandlers "mousebuttonup";
	(findDisplay 46) displayRemoveAllEventHandlers "MouseZChanged";
	(findDisplay 46) displayRemoveAllEventHandlers "MouseMoving";

	if (!isNil{h_d3d_recomp}) then {
		removeMissionEventHandler ["Draw3D",h_d3d_recomp];
		h_d3d_recomp = nil;
	};
};

//disable arma input

	call removealldisplayevents;


// enable blocking button
(findDisplay 46) displayAddEventHandler ["keydown",{
	params ["_obj","_key"];

	if (_key in (FORBIDDEN_BUTTONS) || {[_key] call input_movementCheck}) then {true} else {false}
}];

/*(findDisplay 46) displayAddEventHandler ["mousebuttondown",{
	params ["_obj","_key"];
	_key = [65536,65665,65538,65539,65540] select _key;
	traceformat("%1 -> %2",_key in (FORBIDDEN_BUTTONS) || {[_key] call input_movementCheck} arg _this)
	if (_key in (FORBIDDEN_BUTTONS) ) then {true} else {false}
}];*/

#ifdef DEBUG

if (!isMultiplayer) then {
	//adding recompile button
	(findDisplay 46) displayAddEventHandler ["keyup",{
		params ["_obj","_key"];

		if (_key == KEY_F6) then {
			call go;
		};
	}];

	h_d3d_recomp = addMissionEventHandler ["Draw3d", {
		if(!isNull(findDisplay 49)) then {
			if ((findDisplay 49)getvariable["__escapeMenuReady",false]) exitwith {};
			(findDisplay 49) setvariable ["__escapeMenuReady",true];

			//serialize character info
			call editorDebug_serializePlayerSettings;

			_abort1 = (findDisplay 49 displayCtrl 103);
			_abort1 ctrlEnable false;
			_abort1 ctrlShow false;

			_batset = (findDisplay 49 displayCtrl 122);
			_batset ctrlEnable false;
			_batset ctrlShow false;

			_reload = (findDisplay 49 displayCtrl 2);
			_reload ctrlsettext "Продолжить";
			_reload ctrlSetTooltip "Закрывает данное окно, передавая управление симуляции";

			_reload = (findDisplay 49 displayCtrl 119);
			_reload ctrlsettext "Перезапуск симуляции";
			_reload ctrlSetTooltip "Полный перезапуск симуляции с очисткой всех ресурсов";

			_esc = (findDisplay 49 displayCtrl 104);
			_esc ctrlsettext "Вернуться в ReEditor";
			_esc ctrlSetTooltip "Останавливает симуляцию, высвобождает все объекты из памяти и выходит в редактор.";

			//footer mission
			_wid = (findDisplay 49 displayCtrl 120);
			_wid ctrlShow false;
			//cba center
			//nextFrame(_wid = (findDisplay 49 displayCtrl 1100);_wid ctrlShow false;);
			_wid = (findDisplay 49 displayCtrl 1001);//back
			_wid ctrlShow false;
			_wid = (findDisplay 49 displayCtrl 121);//mod icon
			_wid ctrlShow false;

			_ver = (findDisplay 49 displayCtrl 1005);
			_ver ctrlSetText (format["Platform v%1, Relicta v%2",ctrlText _ver,project_version]);

			_colorize = {
				_bt setBackgroundColor (_this call color_HTMLtoRGBA);
			};

			_bt = (findDisplay 49) ctrlCreate ["RscButton",-1];
			tds = diag_ticktime;
			#define precent_to_real(proc_val) (proc_val / 100)
			_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
			precent_to_real(20) * safezoneH + safezoneY,
			precent_to_real(20) * safezoneW,
			precent_to_real(10) * safezoneH];
			_bt ctrlCommit 0;
			"#DF004F" call _colorize;
			_bt ctrlSetText "COMPILE AND RUN";
			_bt ctrlSetTooltip "Рекомпиляция проекта";
			_bt ctrlAddEventHandler ["MouseButtonUp",{
					(findDisplay 49) closeDisplay 0;
					//Для работы трассировки стека при ошибках в редакторе на этапе компиляции
					[] spawn {
						waituntil{isNullReference(findDisplay 49)};
						ISNIL{call go}
					};
				}];

			_bt = (findDisplay 49) ctrlCreate ["RscButton",-1];
			_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
			precent_to_real(32) * safezoneH + safezoneY,
			precent_to_real(20) * safezoneW,
			precent_to_real(10) * safezoneH];
			_bt ctrlCommit 0;
			#ifdef SP_MODE
			_bt ctrlSetText "RELOAD SCENARIO";
			#else
			_sysEnabled = call editorDebug_isVisibleWidgets;
			_bt ctrlSetText ifcheck(_sysEnabled,"Выключить дебагинфо","Включить дебагинфо");
			_bt ctrlSetTooltip "Переключение отладчика цели,игрока и активной руки";
			#endif
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				_bt = _this select 0;
				#ifdef SP_MODE
				call sp_internal_reloadScenario;
				#else
				_sysEnabled = call editorDebug_isVisibleWidgets;
				[!_sysEnabled] call editorDebug_setVisibleWidgets;
				_sysEnabled = call editorDebug_isVisibleWidgets;
				_bt ctrlSetText ifcheck(_sysEnabled,"Выключить дебагинфо","Включить дебагинфо");
				#endif
				//(findDisplay 49) closeDisplay 0;
			}];

			_bt = (findDisplay 49) ctrlCreate ["RscButton",-1];
			_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
			precent_to_real(44) * safezoneH + safezoneY,
			precent_to_real(20) * safezoneW,
			precent_to_real(10) * safezoneH];
			_bt ctrlCommit 0;
			_bt ctrlSetText "Reload c++ libs";
			_bt ctrlSetTooltip "Перезагрузка с++ библиотек RVEngine";
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				(findDisplay 49) closeDisplay 0;
				call rve_debug_reloadlibs;
			}];

			_bt = (findDisplay 49) ctrlCreate ["RscButton",-1];
			_bt ctrlSetPosition [precent_to_real(0) * safezoneW + safezoneX,
			precent_to_real(56) * safezoneH + safezoneY,
			precent_to_real(20) * safezoneW,
			precent_to_real(10) * safezoneH];
			_bt ctrlCommit 0;
			_bt ctrlSetText "TEMP BUTTON 3";
			_bt ctrlSetTooltip "Зарезервированная кнопка для доп. функционала";
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				(findDisplay 49) closeDisplay 0;
			}];
		};
	}];


	if (productVersion select 4 == "Development") then {
		_gd = findDisplay 46;
		(_gd displayCtrl 1000) ctrlSetText ("Vers: " + project_version);
		(_gd displayCtrl 1001) ctrlSetText format["%3 %1%2",toUpper (productVersion select 6 select [0,3]),productVersion select 7,"Relicta dev"];
	};

};
#endif

//(findDisplay 46) displayAddEventHandler ["mousebuttondown",{params ["_obj","_key"];if (_key in FORBIDDEN_BUTTONS) then {true} else {false}}];
//disabling all hud and ingame ui
if (true) then { //isMultiplayer
	showChat false;
	showHUD [
		true, // scriptedHUD
		false, // info
		false, // radar
		false, // compass
		false, // direction
		false, // menu
		false, // group
		false, // cursors
		false, // panels
		false, // kills
		true  // showIcon3D
	];
	//showHUD false; //WARN
};
inGameUISetEventHandler ["PrevAction", "true"];
inGameUISetEventHandler ["NextAction", "true"];
inGameUISetEventHandler ["Action","true"];

//disabling CA_VINGETTE
_ving = ((allControls (findDisplay 46)) select 0);
if (ctrlClassName _ving == "CA_Vignette") then {
	_ving ctrlSetFade 1;
	_ving ctrlCommit 0;
};

log("widget system loaded!");
