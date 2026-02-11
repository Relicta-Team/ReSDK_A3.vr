// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\text.hpp"
#include <..\ClientRpc\clientRpc.hpp>
#include "..\WidgetSystem\widgets.hpp"
#include "lobby.hpp"

namespace(LobbySys,lobby_sys_)

/* -----------------------------------------------------------------------------
	CATEGORY: SYSTEM LOBBY SETTINGS
----------------------------------------------------------------------------- */

decl(widget[])
lobby_sys_listWidgets = [];
decl(string)
lobby_sys_curActionCategory = "system";
decl(int)
lobby_sys_maxCatPerList = 4; //сколько элементов грузится
decl(int)
lobby_sys_curCatList = 0; //индекс начала
decl(map<string;any[]>)
lobby_sys_buttonActions = createHashMapFromArray [
	["system",[
		["Меню",{[true] call esc_openMenu}],
		["Окно команд",{[true] call cd_openSendCommandWindow}],
		["Персонажи",{call lobby_sys_bc_charachters}],
		["Кто в сети?!","system_whoonline"],
		["Список изменений","system_whatnews"]
		//["ref:https://relicta.ru/wiki@На вики",{}],// for references use this
		//["<t colorLink='#ffffff'><a href='https://relicta.ru/wiki'>На вики</a></t>",{}],//font='Ringbear' colorLink='#77DE4E'
		//["<t colorLink='#ffffff'><a href='https://relicta.ru/wiki/%D0%9F%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B0%23%D0%9F%D1%80%D0%B8%D0%B2%D1%8F%D0%B7%D0%BA%D0%B0_%D0%B4%D0%B8%D1%81%D0%BA%D0%BE%D1%80%D0%B4%D0%B0_%D0%BA_%D0%B8%D0%B3%D1%80%D0%BE%D0%B2%D0%BE%D0%BC%D1%83_%D0%B0%D0%BA%D0%BA%D0%B0%D1%83%D0%BD%D1%82%D1%83'>Инструкция по привязке к Discord</a></t>",{}],
		//["Обучение",{["Ждите в грядущих обновлениях...","event"] call chatPrint}]
	]],
	["wiki",[
		["ref:https://relicta.ru/wiki@Главная страница",{}]
		,["ref:https://relicta.ru/wiki/%D0%9C%D0%B8%D1%80_%D0%A1%D0%B5%D1%82%D0%B8@История Мира",{}]
		,["ref:https://relicta.ru/wiki/%D0%9F%D0%BE%D0%B4%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BA%D0%B0@Лобби",{}]
		,["ref:https://relicta.ru/wiki/%D0%A3%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5@Управление",{}]
		,["ref:https://relicta.ru/wiki/%D0%A1%D0%BE%D0%B2%D0%B5%D1%82%D1%8B@Рекомендации по отыгрышу",{}]
		,["ref:https://relicta.ru/wiki/%D0%A1%D0%BB%D0%BE%D0%B2%D0%B0%D1%80%D1%8C@Словарь",{}]
		,["ref:https://relicta.ru/wiki/%D0%9C%D0%B8%D1%80%D0%BE%D0%B2%D0%B8%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5@Религии",{}]
		,["ref:https://relicta.ru/wiki/%D0%9D%D0%B0%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5@Национальности",{}]
	]],
	//рестарты, время раунда, глобальное сообщение и тд и тд
	["server",[
		
	]],
	//инфо о конце раунда. записки сюда можно поместить
	["endgame",[
		
	]],
	//админские кнопки выдаются в эту категорию. лок, баны, всё для удобства...
	["admin",[
		
	]]
];
decl(string[])
lobby_sys_buttonActions_sortedList = ["system","wiki","endgame","server","admin"];
decl(any[])
lobby_sys_buttonActions_sortedListName = [["Система","55780E"],["Вики страницы","04B810"],["Конец раунда","55780E"],["Сервер","C4AD68"],["Админ","8F3140"]];

//загружает окно системных настроек
decl(void())
lobby_sysLoadMenu = {
	
	lobby_sys_listWidgets = [];
	
	_d = getDisplay;
	_xSize = CHAT_SIZE_X + 2 + CHARSETMENU_SIZE_X;
	_ctg = [_d,WIDGETGROUP_H,[_xSize,0,100 - _xSize,100]] call createWidget;
	setSettingCtg(_ctg);
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,.8];
	
	_sizeChanger = 6; //размер кнопок переключения режимов
	_ctgSettings = [_d,WIDGETGROUP,[_sizeChanger,0,100-(_sizeChanger*2),5],_ctg] call createWidget;
	
	_bl = [_d,TEXT,[0,0,_sizeChanger,5],_ctg] call createWidget;
	[_bl,slt] call widgetSetText;
	_bl setVariable ["mod",-1];
	_br = [_d,TEXT,[100-_sizeChanger,0,_sizeChanger,5],_ctg] call createWidget;
	[_br,sgt] call widgetSetText;
	_br setVariable ["mod",+1];
	_ev = {
		params ["_b"];
		if (["lobby_sys_changesettingsmode",0.5] call input_spamProtect) exitWith {};
		
		_mod = _b getVariable "mod";
		_list = lobby_sys_buttonActions_sortedList;
		_maxIndex = 0;//count _list - 1;
		{if (count(_y) > 0) then {INC(_maxIndex)};} forEach lobby_sys_buttonActions;
		lobby_sys_curCatList = (lobby_sys_curCatList + _mod) max 0 min ( (_maxIndex-(lobby_sys_maxCatPerList-1)) max 0);
		_ctg = _b getVariable "_ctgSettings";
		nextFrameParams(_ctg getVariable "_loadSettings",_ctg);
	};
	{
		_x setBackgroundColor [0.2,0.2,0.2,.8];
		_x ctrlAddEventHandler ["MouseButtonUp",_ev];
		_x setVariable ["_ctgSettings",_ctgSettings];
	} foreach [_bl,_br];
	private _loadSettings = {
		private _ctg = _this;
		private _d = getDisplay;
		{ctrlDelete _x} foreach (allControls _ctg);
		_range = [];
		for "_i" from 0 to (lobby_sys_maxCatPerList-1) do {
			_curitem = lobby_sys_buttonActions_sortedList select (lobby_sys_curCatList+_i);
			if (count (lobby_sys_buttonActions get _curitem) > 0) then {
				_range pushBack _curitem;
			};
		};
		
		_cntRange = (count _range);
		if (_cntRange == 0) exitWith {}; 
		_sizeX = 100/_cntRange;
		for "_i" from 0 to _cntRange - 1 do {
			_item = _range select _i;
			(lobby_sys_buttonActions_sortedListName select (lobby_sys_buttonActions_sortedList find _item)) params ["_name",["_col","C7F66F"]];
			//categ buttons
			_button = [_d,TEXT,[_sizeX*_i,0,_sizeX,100],_ctg] call createWidget;
			_button setBackgroundColor ([_col] call color_HTMLtoRGBA);//[0.804,0,0.455,.8];
			[_button,format["<t  align='center'>%1</t>",_name,_col]] call widgetSetText;//color='#%2'
			_button setVariable ["cat",_item];
			_button ctrlAddEventHandler ["MouseButtonUp",{
				params ["_b"];
				if (["lobby_sys_pressednewcat",0.5] call input_spamProtect) exitWith {};
				_namecat = _b getVariable ["cat","system"];
				nextFrameParams(lobby_sysLoadSettings,_namecat);
			}];
		};
		
	};
	_ctgSettings setVariable ["_loadSettings",_loadSettings];
	_ctgSettings call _loadSettings;
	
	
/*	_button = [_d,TEXT,[50,0,50,5],_ctg] call createWidget;
	_button setBackgroundColor [1,1,0,.8];*/
	
	//settings
	_ctgSet = [_d,WIDGETGROUP_H,[0,5,90,60],_ctg] call createWidget;
	_back = [_d,BACKGROUND,[0,0,100,100],_ctgSet] call createWidget;
	_back setBackgroundColor [0,0,0,.8];
	
	_d setVariable ["ctgSystemSettings",_ctgSet];
	_d setVariable ["ctgSystemSettingsBackground",_back];
	
	[lobby_sys_curActionCategory] call lobby_sysLoadSettings;
	
	_textRender = [_d,TEXT,[0,65,100,35],_ctg] call createWidget;
	_textRender setBackgroundColor [0,0.1,0,0.6];
	_ctg setvariable ["textRender",_textRender];
	startUpdateParams(lobby_thread_textRender,0,[_textRender]);
	
};

decl(void(string))
lobby_sysLoadSettings = {
	params ["_cat"];
	FORCEUnicode 1;
	private _d = getDisplay;
	
	private _ctg = _d getVariable "ctgSystemSettings";
	private _backCtg = _d getVariable "ctgSystemSettingsBackground";
	
	{
		[_x] call deleteWidget;
	} foreach lobby_sys_listWidgets;
	lobby_sys_listWidgets = [];
	lobby_sys_curActionCategory = _cat;
	//Генерик категории грузятся обычным списком
	//if (_cat == "system") exitWith {
		private _listButtons = (lobby_sys_buttonActions get _cat);
		private _hsize = 12;
		private _but = null;
		{
			_x params ["_name","_code"];
			_but = [_d,TEXT,[0,_forEachIndex * _hsize,100,_hsize - 4],_ctg] call createWidget;
			_but setBackgroundColor [0.149,0.592,0.176,0.12];
			private _isRefButton = false; private _refLink = "";
			if ([_name,"ref:"] call stringStartWith) then {
				_isRefButton = true;
				
				_name = _name select [4,count _name];
				(_name splitString "@") params ["_newref","_newname"];
				_refLink = _newref;
				_name = _newname;
			};

			[_but,format["<t align='center'>%1</t>",_name]] call widgetSetText;
			_but setVariable ["code",_code];
			lobby_sys_listWidgets pushBack _but;
			
			_but ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt == MOUSE_LEFT) then {
					if (["lobby_sysact_pressact",0.3] call input_spamProtect) exitWith {};
					_dat = _ct getVariable ["code",{}];
					if equalTypes(_dat,"") then {
						rpcSendToServer("playLobbySystemAction",vec2(clientOwner,_dat));
					} else {
						0 call _dat;
					};
				};	
			}];
			
			//фикс чтобы бэкграунд не наслаивался поверх кнопок
			ctrlSetFocus _but;

			if (_isRefButton) then {
				_but ctrlEnable false;
				_but = [_d,BUTTON,[0,_forEachIndex * _hsize,100,_hsize - 4],_ctg] call createWidget;
				_but setFade 1;
				_but commit 0;
				_but ctrlSetUrl _refLink;
				lobby_sys_listWidgets pushBack _but;
				ctrlSetFocus _but;
			};

			
		} foreach _listButtons;
		
		[_backCtg,[0,0,100,((count _listButtons) * _hsize)max 100]] call widgetSetPosition;
	//};
};	

decl(bool)
lobby_sys_isActive = false;

decl(void(bool))
lobby_sysSetEnable = {
	params ["_mode"]; //режим включения - если true то всё скрывается и становится неактивным
	
	private _list = [
		getMainCtg, //role setup
		getReadyButton, //ready button
		getSettingCtg //settings category
	];
	
	private _isPreGame = call gmc_isRoundPreload;
	
	{
		//skip charset if pregame
		if (_isPreGame && _forEachIndex == 0) then {continue};
		
		if (_mode) then {
			_x setFade (if (_forEachIndex<2)then{1}else{0.8});
			_x commit 1.3;
			_x ctrlEnable false;
		} else {
			_x setFade 0;
			_x commit 0.7;
			_x ctrlEnable true;
		};
	} foreach _list;
	
	lobby_sys_isActive = _mode;
};	

decl(void(...any[]))
lobby_thread_textRender = {
	(_this select 0) params ["_textRender"];
	
	if equals(_textRender,widgetNull) exitWith {
		stopThisUpdate();
	};
	
	if equals(lobby_timeLeft,-1) exitWith {
		//не рендерим текст
		[_textRender,format["<t size='0.75'>%1</t>","Раунд идёт."]] call widgetSetText;
	};
	
	_startText = if (call gmc_isRoundPlaying) then {"Гости могут приехать через"} else {"До старта"};
	
	_text = if (call gmc_isRoundPreload) then {format["Режим будет выбран через %1 сек...",lobby_timeLeft]} else {format["%2 %1 сек" + sbr + sbr,lobby_timeLeft,_startText]};
	
	if ([">=","GAME_STATE_PLAY"] call gmc_checkState) then {
		{
			_char = format["Группа %1: %2" + sbr,_x select 0,(_x select 1) joinString ", "];
			MOD(_text,+ _char);
		} foreach lobby_RoleContenders;
	} else {
		{
			_char = format["%1: %2" + sbr,_x select 0,(_x select 1) joinString ", "];
			MOD(_text,+ _char);
		} foreach lobby_RoleContenders;
	};

	
	[_textRender,format["<t size='0.75'>%1</t>",_text]] call widgetSetText;
	_textSizeH = _textRender call widgetGetTextHeight;
	if (_textSizeH > 35) then {
		[_textRender,[0,65,100,_textSizeH]] call widgetSetPosition;
	} else {
		[_textRender,[0,65,100,35]] call widgetSetPosition;
	};
};


// ====================== custom settings ====================== 

//isnide event calling
decl(widget[])
lobby_sys_bc_widgets = [widgetNull,widgetNull]; //виджеты контрольных групп
decl(any[])
lobby_sys_bc_slots = []; //виджеты слотов персонажей
decl(bool())
lobby_sys_bc_isAsking = {count lobby_sys_bc_isAskingData > 0};
	decl(any[])
	lobby_sys_bc_isAskingData = [];
	decl(void())
	lobby_sys_bc_restoreAfterAsking = {
		_ctgsaves = lobby_sys_bc_widgets select 1;
		_ctgsaves ctrlEnable true;
		_ctgsaves setFade 0;
		_ctgsaves commit 0.1;
		{[_x]call deleteWidget} foreach (lobby_sys_bc_isAskingData select 1);
		lobby_sys_bc_isAskingData = [];
	};

decl(void())
lobby_sys_bc_charachters = {
	
	if (call gmc_isRoundPreload) exitWith {
		["Сохранять и загружать шаблоны персонажей можно только когда установлен игровой режим.","error"] call chatPrint;
	};
	
	lobby_sys_bc_isAskingData = [];
	
	[true] call lobby_sysSetEnable;
	
	_d = getDisplay;
	_w = 30;
	_h = 50;
	_ctg = [_d,WIDGETGROUP,[50-_w/2,50-_h/2,_w,_h]] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.3,.3,.3,.85];
	
	_ctgin = [_d,WIDGETGROUP_H,[5,5,90,75],_ctg] call createWidget;

	
	_close = [_d,BUTTON,[5,85,90,10],_ctg] call createWidget;
	_close setVariable ["ctg",_ctg];
	_close ctrlSetText "Закрыть";
	
	_close ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w"];
		
		if (call lobby_sys_bc_isAsking) exitWith {
			call lobby_sys_bc_restoreAfterAsking;
		};
		
		_ctg = _w getVariable ["ctg",widgetNull];
		
		_c = {
			params ["_ctg"];
			[_ctg,false] call deleteWidget;
			[false] call lobby_sysSetEnable;
			lobby_sys_bc_isAskingData = [];
		};
		nextFrameParams(_c,[_ctg]);
	}];
	
	lobby_sys_bc_widgets = [_ctg,_ctgin];
	
	["init"] call lobby_sys_ba_action;
};

decl(void(string;any[]))
lobby_sys_ba_action = {
	params ["_action","_ctxParams"];
	call {
		//Первая загрузка
		if (_action == "init") exitWith {
			rpcSendToServer("lsbReq",[0 arg clientOwner])
		};
		//Сохранение пресета
		if (_action == "sv") exitWith {
			
			_ctxParams params ["_widget"];
			
			_data = [1 arg clientOwner arg _widget getVariable "idx"];
			
			if !(_widget getVariable ["havesave",false]) exitWith {
				nextFrameParams({rpcSendToServer("lsbReq",_this)},_data);
			};
			
			_ctgsaves = lobby_sys_bc_widgets select 1;
			_ctgsaves ctrlEnable false;
			_ctgsaves setFade 1;
			_ctgsaves commit 0.1;
			
			_ctg = lobby_sys_bc_widgets select 0;
			_txt = [getDisplay,TEXT,[5,10,90,50],_ctg] call createWidget;
			[_txt,format["<t align='center'>Вы действительно хотите сохранить персонажа в слот %1? Несохранённые данные будут перезаписаны</t>",(_data select 2)+1]] call widgetSetText;
			_bt = [getDisplay,BUTTON,[5,55,90,15],_ctg] call createWidget;
			_bt ctrlSetText "Сохранить";
			ctrlSetFocus _bt;
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				nextFrame(lobby_sys_bc_restoreAfterAsking);
				nextFrameParams({rpcSendToServer("lsbReq",_this)},lobby_sys_bc_isAskingData select 0);
			}];
			
			lobby_sys_bc_isAskingData = [_data,[_txt,_bt]];
		};
		//Загрузка пресета в текущего перса
		if (_action == "ld") exitWith {
			_ctxParams params ["_widget"];
			_data = [2 arg clientOwner arg _widget getVariable "idx"];
			_cs = lobby_sys_bc_widgets select 1;_cs ctrlEnable false;_cs setFade 1;_cs commit 0.1;
			
			_ctg = lobby_sys_bc_widgets select 0;
			_txt = [getDisplay,TEXT,[5,10,90,50],_ctg] call createWidget;
			[_txt,format["<t align='center'>Вы действительно хотите загрузить персонажа из слота %1? Несохранённые данные будут перезаписаны</t>",(_data select 2)+1]] call widgetSetText;
			_bt = [getDisplay,BUTTON,[5,55,90,15],_ctg] call createWidget;
			_bt ctrlSetText "Загрузить";
			ctrlSetFocus _bt;
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				nextFrame(lobby_sys_bc_restoreAfterAsking);
				nextFrameParams({rpcSendToServer("lsbReq",_this)},lobby_sys_bc_isAskingData select 0);
			}];
			
			lobby_sys_bc_isAskingData = [_data,[_txt,_bt]];
		};
		//Удаление пресета
		if (_action == "del") exitWith {
			_ctxParams params ["_widget"];
			_data = [3 arg clientOwner arg _widget getVariable "idx"];
			_cs = lobby_sys_bc_widgets select 1;_cs ctrlEnable false;_cs setFade 1;_cs commit 0.1;
			
			_ctg = lobby_sys_bc_widgets select 0;
			_txt = [getDisplay,TEXT,[5,10,90,50],_ctg] call createWidget;
			[_txt,format["<t align='center'>Вы действительно хотите удалить персонажа из слота %1?</t>",(_data select 2)+1]] call widgetSetText;
			_bt = [getDisplay,BUTTON,[5,55,90,15],_ctg] call createWidget;
			_bt ctrlSetText "Удалить";
			ctrlSetFocus _bt;
			_bt ctrlAddEventHandler ["MouseButtonUp",{
				nextFrame(lobby_sys_bc_restoreAfterAsking);
				nextFrameParams({rpcSendToServer("lsbReq",_this)},lobby_sys_bc_isAskingData select 0);
			}];
			
			lobby_sys_bc_isAskingData = [_data,[_txt,_bt]];
		};
		//Обновление данных
		if (_action == "upd") exitWith {
			if isNullVar(_ctxParams) exitWith {error("lobby::sys::ba::action() - null vaule on update")};
			if not_equalTypes(_ctxParams,[]) exitWith {errorformat("lobby::sys::ba::action() - type error (%1)",toLower typeName _ctxParams)};
			if (!isLobbyOpen) exitWith {error("lobby::sys::ba::action() - lobby closed")};
			
			private _delete = 0;
			private _save = 0;
			
			{
				[_x] call deleteWidget;
			} foreach lobby_sys_bc_slots;
			lobby_sys_bc_slots = [];
			
			_ctg = lobby_sys_bc_widgets select 1;
			_d = getDisplay;
			
			#define charset_size_h 10
			_falsecolor = [0.659,0.396,0.463,0.4];
			_truecolor =  [0.337,0.561,0.365,0.4];
			_defcolor = [0.278,0.322,0.282,1];
			
			for "_i" from 0 to (count _ctxParams) - 1 do {
				_thisChar = _ctxParams select _i;
				
				_w = [_d,TEXT,[0,_i * charset_size_h,60,charset_size_h],_ctg] call createWidget;
				_w setVariable ["idx",_i];
				
				_save = [_d,TEXT,[60,_i * charset_size_h,20,charset_size_h],_ctg] call createWidget;
				[_save,"<t align='center'>Сохр.</t>"] call widgetSetText;
				_save ctrlSetTooltip format["Сохранить персонажа в слот %1",_i + 1];
				
				_save setVariable ["idx",_i];
				
				_delete = [_d,TEXT,[60+20,_i * charset_size_h,20,charset_size_h],_ctg] call createWidget;
				[_delete,"<t align='center'>Удал.</t>"] call widgetSetText;
				_delete setVariable ["idx",_i];
				
				lobby_sys_bc_slots append vec3(_w,_save,_delete);
				
				//Пустая строка - блокируем удалить и загрузить
				if (_thisChar == "") then {
					[_w,str(_i+1)+". <t align='center'>(пусто)</t>"] call widgetSetText;
					
					_w setBackgroundColor _falsecolor;
					
					_delete setFade 0.9;
					_delete commit 0;
					_delete setBackgroundColor _falsecolor;
					
					_delete ctrlEnable false;
					_w ctrlEnable false;
					
					_save setBackgroundColor _truecolor;
				} else {
					_w setBackgroundColor [0.337,0.561,0.365,0.4];
					_w ctrlSetTooltip format["Загрузить персонажа: %1",_thisChar];
					_delete ctrlSetTooltip format["Удалить персонажа из слота %1",_i + 1];
					_delete setBackgroundColor _falsecolor;
					_save setBackgroundColor _defcolor;
					[_w,str(_i+1)+". <t align='center'>"+_thisChar+"</t>"] call widgetSetText;
					
					_w ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0.337,0.561,0.365,0.7]}];
					_w ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor [0.337,0.561,0.365,0.4]}];
					
					_w ctrlAddEventHandler ["MouseButtonUp",{
						params ["_w"];
						//_idx = _w getVariable ["idx",0];
						//load
						["ld",[_w]]call lobby_sys_ba_action;
						//nextFrameParams({rpcSendToServer("lsbReq",_this)},[2 arg clientOwner arg _idx]);
					}];
					
					_delete ctrlAddEventHandler ["MouseButtonUp",{
						params ["_w"];
						//_idx = _w getVariable ["idx",0];
						//delete
						["del",[_w]] call lobby_sys_ba_action;
						//nextFrameParams({rpcSendToServer("lsbReq",_this)},[3 arg clientOwner arg _idx]);
					}];
				};
				
				_save setVariable ["havesave",_thisChar != ""];
				
				_save ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w"];
					//_idx = _w getVariable ["idx",0];
					//save
					["sv",[_w]] call lobby_sys_ba_action;
					//nextFrameParams({rpcSendToServer("lsbReq",_this)},[1 arg clientOwner arg _idx]);
				}];
			};
			
		};
		errorformat("lobby::sys::ba::action() - Unknown action %1",_action);
	};
}; rpcAdd("lsbAct",lobby_sys_ba_action);