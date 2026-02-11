// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\WidgetSystem\widgets.hpp>
#include <..\..\host\text.hpp>
#include <..\..\host\CombatSystem\CombatSystem.hpp>

namespace(Hud,hud_)

macro_const(hud_size_x)
#define HUD_SIZE_X 10

macro_const(hud_size_y)
#define STAT_SIZE_H 4

macro_func(hud_canVisibleAttribute,bool(string))
#define canVisibleAttribute(data) (data != "")

inline_macro
#define getWidgetVar(_w,var) (_w getvariable #var)
inline_macro
#define setWidgetVar(_w,var,val) _w setVariable [#var,val]

decl(string[])
hud_vars = ["oxy","hunger","thirst","encumb","pee","poo","vs_lastError","combatMode","bone","pain","sleep","bleeding","stealth","light","combStyle","specAct",
"holdbreath","tox"];
decl(map)
hud_map_defaultValues = createHashMap;
decl(map)
hud_map_widgets = createHashMap;

//hud_[var]_overlay select 0 -название. может быть кодом для рантайм вычисления. _value будет текущим значением (!!!_curval рантайм значение!!!)
//hud_[var]_overlay select 1 - сортировка. true для тех где от меньшего к большему и false наоборот
decl(float)
hud_thirst = 100; //жажда
	decl(any[])
	hud_thirst_overlay = ["Жажда",[[51,""],[50,"#56C9F0"],[40,"#2AA7D1"],[30,"#0C87B0"],[20,"#078A8F"],[10,"#03704E"]],false];
decl(float)
hud_hunger = 100; //голод
	decl(any[])
	hud_hunger_overlay = ["Голод",[[51,""],[50,"#F2BF8F"],[40,"#D18E4F"],[30,"#A8611E"],[20,"#8C420D"],[10,"#630603"]],false];
decl(float)
hud_encumb = 0; //перегруз
	decl(any[])
	hud_encumb_overlay = ["Перегруз",[[0,""],[1,"#A46EF0"],[2,"#6926C7"],[3,"#8104B3"],[4,"#8C0052"]],true];
decl(float)
hud_temp = 36; //внешняя температура
	//hud_hunger_overlay = ["Температура",[[0,""],[1,""],[2,""],[3,""],[4,""]]];
decl(float)
hud_oxy = 100; //дыхалка
	decl(any[])
	hud_oxy_overlay = ["Кислород",[[90,""],[70,"#46F0E7"],[50,"#7ACFCA"],[30,"#5F9C99"],[10,"#2E705D"],[5,"#0B5434"],[1,"#AD0017"]],false];
decl(float)
hud_holdbreath = 0;
	decl(any[])
	hud_holdbreath_overlay = ["Не дышу",[[0,""],[1,"#718BD9"]],true];
decl(float)
hud_tox = 0;
	decl(any[])
	hud_tox_overlay = ["Отравление",[[0,""],[10,"#A9E084"],[25,"#82C456"],[50,"#539129"],[100,"#245206"]],true];
decl(float)
hud_pee = 0; //малая нужда
	decl(any[])
	hud_pee_overlay = ["Мочевой пузырь",[[0,""],[20,"#E3E691"],[40,"#D0D45D"],[60,"#E0D238"],[80,"#FFB805"]],true];
decl(float)
hud_poo = 0; //большая нужда
	decl(any[])
	hud_poo_overlay = ["Кишечник",[[0,""],[20,"#80715B"],[40,"#665235"],[60,"#573E18"],[80,"#472400"]],true];

decl(float)
hud_pain = 0;//уровень боли
	decl(any[])
	hud_pain_overlay = ["Боль",[[0,""],[1,"#693F60"],[2,"#913463"],[3,"#C91C59"],[4,"#FF033D"]],true];
decl(float)
hud_bone = 0;//переломы
	decl(any[])
	hud_bone_overlay = ["Перелом",[[0,""],[1,"#FA9F3E"]],true];
decl(float)
hud_sleep = 0; //сон
	decl(any[])
	hud_sleep_overlay = ["Сон",[[0,""],[1,"#133AAC"]],true];
decl(float)
hud_stealth = 0;
	decl(any[])
	hud_stealth_overlay = ["Скрытность",[[0,""],[1,"#0C87B0"]],true];
decl(float)
hud_light = 0;
	decl(any[])
	hud_light_overlay = [
		{
			//runtile light renamer, use _value as current val
			/*
			#define LIGHT_NO 0
			#define LIGHT_LOW 1
			#define LIGHT_MEDIUM 2
			#define LIGHT_LARGE 3
			#define LIGHT_FULL 4
			*/
			format[["Слабый %1","Средний %1","Умеренный %1","Яркий %1"] select (_value-1),"свет"]
		},[[0,""],[1,"#CC9712"],[2,"#E3B540"],[3,"#F0D695"],[4,"#F7F2E4"]],true];
#include <..\..\host\GameObjects\ConstantAndDefines\Life.h>
decl(float)
hud_bleeding = 0;
	decl(any[])
	hud_bleeding_overlay = ["Кровотечение",[[0,""],[0.1,"#FF7A66"],[1,"#E04128"],[5,"#A61A05"],[10,"#540D02"],[20,"#210601"]],true];
decl(float)
hud_combStyle = 0;
	decl(void())
	hud_combStyle_onCombatUpdate = {
		["combStyle"] call hud_recalculateStat; //reset
		private _r = 0;
		if (cd_curCombatStyle!=COMBAT_STYLE_NO) then {INC(_r)};
		if ([player] call smd_isCombatModeEnabled) then {INC(_r)};
		hud_combStyle = _r;
	};
	decl(any[])
	hud_combStyle_overlay = [
		{
			_rf = (interactCombat_hud_map_Styles getOrDefault [cd_curCombatStyle,["#FFFFFF","error","r-error"]]);
			format["<t color='%1'>%2</t>",_rf select 0,_rf select (interactCombat_csModesType+1)]
		},[[0,""],[2,"#FFFFFF"]],
		true
	];

decl(float)
hud_combatMode = 0;
	decl(void())
	hud_combatMode_sync = {
		hud_combatMode = ifcheck([player] call smd_isCombatModeEnabled,1,0);
	};
	decl(any[])
	hud_combatMode_overlay = [
		"Бой",
		[[0,""],[1,"#ED002F"]],
		true
	];

decl(float)
hud_specAct = 0;
//вызывается при обновлении спец.кнопок.
decl(void())
hud_specAct_update = {
	if (cd_specialAction in interactMenu_specialActions_map_hud)then {
		["specAct"] call hud_recalculateStat;
		hud_specAct = 1;
	} else {
		hud_specAct = 0;
	};
};
decl(any[])
hud_specAct_overlay = [
	{
		interactMenu_specialActions_map_hud get cd_specialAction
	},[[0,""],[1,"#5D0FBD"]],
	true
];

//system
	decl(float)
	hud_vs_lastError = 0;
	decl(any[])
	hud_vs_lastError_overlay = ["!!!ТИМСПИК!!!",[[0,""],[1,"#ED002F"]],true];

/*hud_canHide = true;
	hud_hideAfter = 1;
	hud_hideTimestamp = 0;
	hud_updateTimestamp = {hud_hideTimestamp = tickTime + hud_hideAfter};
	hud_hide_isLocked = false;
	hud_hide_lastviscount = 0;
	hud_hide_lockProcess = false;
	//Восстановить худ
	hud_hide_reset = {
		params [["_enableLock",false],["_lockProcess",false]];
		hud_hide_isLocked = _enableLock;
		call hud_updateTimestamp;
		hud_hide_lockProcess = _lockProcess;
		{
			if getWidgetVar(_x,isVisible) then {
				_x setFade 0;
				_x commit 0.2;
			};
		} foreach hud_widgets;
	};*/

decl(void(string))
hud_recalculateStat = {
	params ["_name"];
	private _w = hud_map_widgets getOrDefault [_name,widgetNull];
	_w setVariable ["curValue",-(_w getVariable "curValue")];
};

//очистка худа - сброс всех переменных на стандартные значения
decl(void())
hud_cleanup = {
	{
		missionNamespace setVariable [_x,_y];
	} foreach hud_map_defaultValues;
};

decl(void())
hud_init = {
	
	//сначала сериализация дефолтных значений худа
	{
		_fullName = "hud_"+_x;
		hud_map_defaultValues set [_fullName,missionNameSpace getVariable _fullName];
	} foreach hud_vars;
	
	hud_widgets = [];
	hud_zone = [];

	//Зависимость от VoiceSystem
	if isNull(vs_lastError) then {
		vs_lastError = false;
	};

	{

		_varName = "hud_"+_x;

		_curval = missionnamespace getvariable _varName;
		_overlay = missionnamespace getVariable (_varName + "_overlay");
		if (_overlay select 2) then {
			reverse (_overlay select 1);
		};
	} foreach hud_vars;


	private _ctg = [getGUI,WIDGETGROUP,[
		100-HUD_SIZE_X,
		0,
		HUD_SIZE_X,
		100]] call createWidget;
	_back = [getGUI,BACKGROUND,[0,50,100,100],_ctg] call createWidget;
	//_back setBackgroundColor [1,0,0,0.3];

	hud_zone = [_ctg,_back];

	{
		_hudItem = [getGUI,TEXT,[0,50-STAT_SIZE_H/2,100,STAT_SIZE_H],_ctg] call createWidget;
		_hudItem setBackgroundColor [0.2,0.2,0.2,0.2];
		_hudItem setvariable ["var",_x];
		_hudItem setVariable ["isVisible",false];
		_hudItem setFade 1;
		_hudItem commit 0;
		_hudItem setVariable ["curValue",missionnamespace getvariable("hud_"+_x)];
		_hudItem setVariable ["defaultValue",_hudItem getVariable "curValue"];
		hud_map_widgets set [_x,_hudItem];
		hud_widgets pushBack _hudItem;
	} foreach hud_vars;

	startUpdate(hud_onUpdate,0);
};

decl(void())
hud_onUpdate = {

	//linking vs_lastError
	hud_vs_lastError = ifcheck(vs_lastError,1,0);

	_needRecalculatePos = false; //Для перерасчета позиций
	{
		_wid = hud_widgets select _forEachIndex;

		_varName = "hud_"+_x;
		_curval = missionnamespace getvariable _varName;
		//Значение актуально
		if equals(_curval,getWidgetVar(_wid,curValue)) then {continue};

		_overlay = missionnamespace getVariable (_varName + "_overlay");

		_checkval = _curval;
		private _curSettings = (_overlay select 1 select 0);
		_LastIndex = count (_overlay select 1) - 1;
		{
			_x params ["_value","_vis"];
			//traceformat("checkval %1; value %2",_checkval arg _value)
			//if (_checkval < _value) then {_checkval = _value; continue};
			if (_checkval >= _value || _LastIndex == _forEachIndex) exitWith {
				_curSettings = _x;
			};
		} foreach (_overlay select 1);

		_curSettings params ["_value","_vis"];
		setWidgetVar(_wid,curValue,_curval);
		//traceformat("udp val %1",_curSettings)

		_needRecalculatePos = true;

		if canVisibleAttribute(_vis) then {
			if !getWidgetVar(_wid,isVisible) then {
				_wid setFade 0;
				_wid commit 0.2;
				setWidgetVar(_wid,isVisible,true);
			};
			_oldat = _overlay select 0;
			[_wid,format["<t align='center' color='%1'>%2</t>",_vis,ifcheck(equalTypes(_oldat,""),_oldat,call _oldat)]] call widgetSetText;
		} else {
			if getWidgetVar(_wid,isVisible) then {
				_wid setFade 1;
				_wid commit 0.2;
				setWidgetVar(_wid,isVisible,false);
			};
		};

	} foreach hud_vars;

	if (_needRecalculatePos) then {

		_countVision = 0;
		{if getWidgetVar(_x,isVisible) then {INC(_countVision)}}count hud_widgets;

		_i = 0;
		{
			if getWidgetVar(_x,isVisible) then {
				[_x,[0,50-(STAT_SIZE_H/2*_countVision)+(STAT_SIZE_H*_i)]] call widgetSetPositionOnly;
				INC(_i);
			};
		} foreach hud_widgets;

		//Функционал включен
		/*if (hud_canHide) then {
			if (hud_hide_lockProcess) exitWith {};

			if (_i != hud_hide_lastviscount) then {
				trace("RESET");
				false call hud_hide_reset;
				hud_hide_lastviscount = _i;

			};

		};*/
	} else {
		//Функционал выключен
		/*if (!hud_canHide) exitWith {};
		if (hud_hide_lockProcess) exitWith {call hud_updateTimestamp};

		//Не перерасчитываем позицию
		if (tickTime > hud_hideTimestamp) then {
			if (!hud_hide_isLocked) then {
				trace("LOCK");
				hud_hide_isLocked = true;
				{
					if getWidgetVar(_x,isVisible) then {
						_x setFade 1;
						_x commit 0.3;
					};
				} foreach hud_widgets;
			};
		};*/
	};
};



call hud_init;
