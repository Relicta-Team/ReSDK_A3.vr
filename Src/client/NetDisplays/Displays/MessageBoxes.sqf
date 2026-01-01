// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(MessageBox) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,30,20,false] call nd_stdLoad;
		call nd_cleanupData;
		
		_args params [["_text",""],["_ok","ОК"],["_can","Закрыть"]];
		
		private _textWid = [BACKGROUND,[1,1,98,79],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		private _ctgin = [WIDGETGROUP_H,[1,1,98,79],_ctg] call nd_regWidget;
		
		_textWid = [TEXT,WIDGET_FULLSIZE,_ctgin] call nd_regWidget;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _textWid;
		};
		[_textWid,_text] call widgetSetText;
		[_textWid,[0,0,100,_textWid call widgetGetTextHeight]] call widgetSetPosition;
		
		_textWid = [BUTTON,[5.5,81,44,18],_ctg] call nd_regWidget;
		_textWid ctrlSetText _ok;
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
			[1] call nd_onPressButton;
		}];
		
		_textWid = [(self getv(thisDisplay)),[50.5,81,44,18],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText _can;
		
	};

endstruct

struct(Listbox) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];	
		private _ctg = [_isFirstCall,30,50,false] call nd_stdLoad;
		call nd_cleanupData;
		
		private _textWid = [BACKGROUND,[1,1+5,98,79-5],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		private _txtval = _args deleteAt 0;
		_textWid = [TEXT,[1,1,98,5],_ctg] call nd_regWidget;
		[_textWid,_txtval] call widgetSetText;
		
		private _list = [LISTBOX,[1,1+5,98,79-5],_ctg] call nd_regWidget;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _list;
		};
		private _data = "";
		private _item = "";
		{
			_data = "";
			if !equalTypes(_x,"") then {
				_x = format["[%1] ОШИБКА ТИПА",_forEachIndex]
			} else {
				if ("|"in _x) then {
					(_x splitString "|")params["_n","_d"];
					_x = _n;
					_data = _d;
				} else {
					_data = _x;
				};
			};
			_item = _list lbAdd _x;
			_list lbSetData [_item, _data];
		} foreach _args;
		
		_textWid = [BUTTON,[5.5,81,44,18],_ctg] call nd_regWidget;
		_textWid ctrlSetText "Выбрать";
		_textWid setVariable ["_listbox",_list];
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
			_list = _c getVariable "_listbox";
			_idx = lbCurSel _list;
			if (_idx == -1) exitWith {["Выберите что-то из списка!","error"] call chatPrint};
			[[_list lbData _idx,_idx]] call nd_onPressButton;
		}];
		
		_textWid = [(self getv(thisDisplay)),[50.5,81,44,18],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText "Закрыть";
	};

endstruct

struct(Text) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,60,80,false] call nd_stdLoad;

		call nd_cleanupData;
		
		_args params [["_text",""],["_close","Закрыть"]];
		
		private _textWid = [BACKGROUND,[1,1,98,89],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		private _ctgin = [WIDGETGROUP_H,[1,1,98,89],_ctg] call nd_regWidget;
		
		_textWid = [TEXT,WIDGET_FULLSIZE,_ctgin] call nd_regWidget;
		
		[_textWid,_text] call widgetSetText;
		[_textWid,[0,0,100,_textWid call widgetGetTextHeight]] call widgetSetPosition;
		
		_textWid = [(self getv(thisDisplay)),[5,91,90,8],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText _close;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _textWid;
		};
	};

endstruct

struct(Alert) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,30,20,false] call nd_stdLoad;
		call nd_cleanupData;
		
		_args params [["_text",""],["_ok","Да"],["_can","Нет"]];

		private _textWid = [BACKGROUND,[1,1,98,79],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		private _ctgin = [WIDGETGROUP_H,[1,1,98,79],_ctg] call nd_regWidget;
		
		_textWid = [TEXT,WIDGET_FULLSIZE,_ctgin] call nd_regWidget;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _textWid;
		};
		[_textWid,_text] call widgetSetText;
		[_textWid,[0,0,100,_textWid call widgetGetTextHeight]] call widgetSetPosition;
		
		_textWid = [BUTTON,[5.5,81,44,18],_ctg] call nd_regWidget;
		_textWid ctrlSetText _ok;
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
			[true] call nd_onPressButton;
		}];
		
		_textWid = [BUTTON,[50.5,81,44,18],_ctg] call nd_regWidget;
		_textWid ctrlSetText _can;
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
			[false] call nd_onPressButton;
		}];
	};

endstruct

struct(Input) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,40,40,false] call nd_stdLoad;
		
		call nd_cleanupData;
		
		private _textWid = [BACKGROUND,[1,1,98,84],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];

		_args params [["_t",""],["_def",""],["_ok","ОК"],["_can","Закрыть"],["_ischatmode",false]];

		private _ctgin = [WIDGETGROUP_H,[1,1,98,35],_ctg] call nd_regWidget;
		
		_textWid = [TEXT,WIDGET_FULLSIZE,_ctgin] call nd_regWidget;
		//_textWid setBackgroundColor [1,0,0,1];
		[_textWid,_t] call widgetSetText;
		[_textWid,[0,0,100,_textWid call widgetGetTextHeight]] call widgetSetPosition;

		private _input = [INPUTMULTI,[1,37,98,48],_ctg] call nd_regWidget;
		_input call widget_registerInput;
		_input ctrlSetText _def;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _input;
		};

		_textWid = [BUTTON,[2,86,48,13],_ctg] call nd_regWidget;
		_textWid ctrlSetText _ok;
		_textWid setvariable ["input",_input];
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			_input = _c getvariable "input";
			_txt = ctrlText _input;
			if (count _txt > (1024 * 4)) exitwith {
				["Слишком много данных для отправки. Переполнение на " + str (
					(count _txt) - (1024*4)
				) + " символов","system"] call chatPrint;
			};
			if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
			[_txt] call nd_onPressButton;
		}];
		_buttonSend = _textWid;
		
		_textWid = [(self getv(thisDisplay)),[52,86,46,13],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText _can;
		if (_ischatmode) then {
			[_ctg,
				[
					0,
					chat_size_y
				]
			] call widgetSetPositionOnly;
			ctrlSetFocus _input;
			if isNull((self getv(thisDisplay)) getvariable "___event_onpress") then {
				(self getv(thisDisplay)) setvariable ["___buttonSend",_buttonSend];
				(self getv(thisDisplay)) setvariable ["___event_onpress",(self getv(thisDisplay)) displayAddEventHandler ["KeyUp",{
					params ["_d","_key"];
					if (_key == KEY_RETURN) then {
						_c = {
							//!КОПИПАСТА
							params ["_c","_b"];
							_input = _c getvariable "input";
							_txt = ctrlText _input;
							if (count _txt > (1024 * 4)) exitwith {
								["Слишком много данных для отправки. Переполнение на " + str (
									(count _txt) - (1024*4)
								) + " символов","system"] call chatPrint;
							};
							if (["nd_mb_apply",1] call input_spamProtect) exitWith {};
							[_txt] call nd_onPressButton;
						}; _args = [_d getvariable "___buttonSend",MOUSE_LEFT];
						nextFrameParams(_c,_args);
					};
				}]];
			};
		};
	};

endstruct

//customized net messagex box for testing
struct(TestingReputation) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,50,70,false] call nd_stdLoad;
		
		call nd_cleanupData;

		private _textWid = [BACKGROUND,[1,1,98,89],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		private _ctgin = [WIDGETGROUP,[1,1,98,89],_ctg] call nd_regWidget;
		
		_textWid = [TEXT,[0,0,100,60],_ctgin] call nd_regWidget;
		private _tDat = _args deleteAt 0;
		forceUnicode 1;
		
		private _isCustom = (_tDat find "▬")!=-1;
		if (_isCustom) then {_tDat = [_tDat,"\▬",""]call regex_replace};
		[_textWid,_tDat] call widgetSetText;
		if (nd_lobby_isOpen) then {
			ctrlSetFocus _textWid;
		};

		private _listCtg = [WIDGETGROUP_H,[0,60,100,40],_ctgin] call nd_regWidget;
		//if custom question then create input
		if (_isCustom) exitwith {

			#define __ND_MB_INPUT_MAX_CHARS 255
			#define __ND_MB_INPUT_MIN_CHARS 100

			private _input = [INPUTMULTIV2,[0,0,100,80],_listCtg] call nd_regWidget;

			private _butApply = [BUTTON,[0,80,100,20],_listCtg] call nd_regWidget;
			_butApply ctrlSetText "Отправить";
			_butApply setVariable ["_input",_input];
			_butApply ctrlAddEventHandler ["MouseButtonUp",{
				params ["_c","_b"];
				if (["nd_mbqt_apply",1] call input_spamProtect) exitWith {};
				_input = ctrlText(_c getVariable "_input");
				forceUnicode 1;
				_inpCount = count _input;
				if (_inpCount == 0) exitWith {["Введите что-то!","system"] call chatPrint};
				if (_inpCount < __ND_MB_INPUT_MIN_CHARS) exitWith {["Введите больше чем "+ str __ND_MB_INPUT_MIN_CHARS +" символа!","system"] call chatPrint};
				if (_inpCount > __ND_MB_INPUT_MAX_CHARS) exitWith {[format["Превышен лимит на %1 знаков. ",_inpCount- __ND_MB_INPUT_MAX_CHARS],"system"] call chatPrint};
				[[_input,true]] call nd_onPressButton;
			}];
		};

		private _data = "";
		private _item = "";
		private _items = array_shuffle(_args deleteAt 0);
		for "_i" from 0 to (count _items) - 1 do {
			_tw = [TEXT,[0,_i*20,100,20],_listCtg] call nd_regWidget;
			((_items select _i)splitString "|")params ["_text","_data"];
			_tw setvariable ["data",_data];
			[_tw,"<t size='0.9'>"+_text+"</t>"] call widgetSetText;
			_tw ctrlAddEventHandler ["MouseButtonDblClick",{
				params ["_c","_b"];
				if (["nd_mbqt_apply",1] call input_spamProtect) exitWith {};
				_data = _c getVariable "data";
				[[_data]] call nd_onPressButton;
			}];
			_tw ctrlAddEventHandler ["MouseEnter",{
				params ["_c","_b"];
				_c setBackgroundColor [0.6,0.6,0.6,0.5];
			}];
			_tw ctrlAddEventHandler ["MouseExit",{
				params ["_c","_b"];
				_c setBackgroundColor [0.6,0.6,0.6,0.3];
			}];
			_tw setBackgroundColor [0.6,0.6,0.6,0.3];
		};

		_textWid = [TEXT,[5,91,90,8],_ctg] call nd_regWidget;
		_timeout = (3 * 60);
		#ifdef DEBUG
		_timeout = 15;
		#endif
		_textWid setVariable ["_timeout",tickTime + _timeout];
		//асинхронный таймер. когда он истекает отсылается dummy ответ
		startAsyncInvoke
			{
				params ["_wid"];
				if isNullReference(_wid) exitwith {true};
				[_wid,format["<t align='center'>Осталось %1 сек.</t>",round((_wid getVariable "_timeout") - tickTime)]] call widgetSetText;
				false
			},
			{
				//no action
			},
			[_textWid],
			_timeout,
			{
				[["___NANDATA___"]] call nd_onPressButton;
			}
		endAsyncInvoke;
		
		//[[_data]] call nd_onPressButton;
		/*
		_textWid = [BUTTON,[5,91,90,8],_ctg] call nd_regWidget;
		_textWid ctrlSetText "Выбрать ответ";
		_textWid setvariable ["_listbox",_list];
		_textWid ctrlAddEventHandler ["MouseButtonUp",{
			params ["_c","_b"];
			if (["nd_mbqtrep_apply",1] call input_spamProtect) exitWith {};
			_list = _c getVariable "_listbox";
			_idx = lbCurSel _list;
			if (_idx == -1) exitWith {["Выберите вариант ответа","system"] call chatPrint};
			[[_list lbData _idx,_idx]] call nd_onPressButton;
		}];
		*/

		
	};

endstruct

//структуры с виджетами
decl(void())
nd_internal_voterep_cleanupMaps = {
	nd_internal_map_voterepBest = createHashMap;
	nd_internal_map_veoterepBad = createHashMap;
};
decl(any[])
nd_internal_voterep_widgets = [];

enum(VoteRepWidgetIndex,ND_VOTEREP_WIDGET_INDEX_)
#define ND_VOTEREP_WIDGET_INDEX_ERROR 0
#define ND_VOTEREP_WIDGET_INDEX_BESTCTG 1
#define ND_VOTEREP_WIDGET_INDEX_BADCTG 2
enumend

struct(VoteRep) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,70,80,false] call nd_stdLoad;
		
		call nd_internal_voterep_cleanupMaps;
		call nd_cleanupData;
		
		private _loadElem = {
			params ["_tStruct","_ctg","_posY","_sizeY","_colActive","_textModActive"];
			private _dat = _tStruct splitString "|";
			if (count _dat != 4) exitwith {
				errorformat("NDMBX_VOTE - broken struct cont %1",count _dat);
			};
			_dat params ["_nick","_char","_name","_rcls"];
			private _newW = getWidthByHeightToSquare(_sizeY);
			private _t = [TEXT,[1,_posY+1,98,_sizeY-1],_ctg] call nd_regWidget;
			_t setVariable ["dat",_dat];
			_t setvariable ["_tStruct",_tStruct + "|" + str _forEachIndex + "|" + str equals(_ctg,nd_internal_voterep_widgets)];
			_t setVariable ["_defcolor",[0.6,0.6,0.6,0.3]];
			_t setVariable ["_activecolor",_colActive];
			_t setVariable ["_textModActive",_textModActive];
			_t setBackgroundColor (_t getVariable "_defcolor");
			private _defTxt = format["<t align='left'>%1: %2 (%3)</t>",_nick,_char,_name];
			_t setVariable ["_deftext",_defTxt];
			[_t,_defTxt] call widgetSetText;
			_t setvariable ["mainCtg",_ctg];
			_t ctrlAddEventHandler ["MouseButtonUp",{
				_wid = _this select 0;
				_ctg = _wid getVariable "mainCtg";
				_activeFlag = _wid getVariable "isactive";
				_maxcount = _ctg getVariable "maxcount";
				_map = _ctg getVariable "map";
				_tStruct = _wid getVariable "_tStruct";
				(_wid getvariable "dat")params ["_nick","_char","_name"];


				if (count _map >= _maxcount && !_activeFlag) exitwith {
					[format["В данном списке можно выбрать только %1 игроков",_maxcount]] call ((nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_ERROR) getvariable "onError");
				};

				(_activeFlag) call (_wid getvariable "_onchangeactive");
				_wid setVariable ["isactive",!_activeFlag];
			}];
			_t setvariable ["isactive",false];
			_t setvariable ["_onchangeactive",{
				_colNew = 0;
				_textNew = "";
				if (!_this) then {
					_colNew = _wid getVariable "_activecolor";
					_textNew = format[_wid getVariable "_textModActive",_wid getvariable "_deftext"];
					_map set [_tStruct,[_nick,_char,_name]];
				} else {
					_colNew = _wid getVariable "_defcolor";
					_textNew = _wid getVariable "_deftext";
					_map deleteAt _tStruct;
				};
				_wid setBackgroundColor _colNew;
				[_wid,_textNew] call widgetSetText;
			}];
		};

		private _textWid = [BACKGROUND,[1,1,98,98],_ctg] call nd_regWidget;
		_textWid setBackgroundColor [.1,0.1,0.1,.8];
		
		_tHead = [TEXT,[0,0,100,10],_ctg] call nd_regWidget;
		[_tHead,"<t size='1.2' align='center'>"+sbr+"Голосование</t>"] call widgetSetText;

		private _backSize = [1,1,98,98];
		private _ctgin = [WIDGETGROUP,[1,10,98,79],_ctg] call nd_regWidget;
		_ctgLeft = [WIDGETGROUP_H,[0,10,50,90],_ctgin] call nd_regWidget;
		_ctgLeft setvariable ["map",nd_internal_map_voterepBest];
		_ctgLeft setvariable ["maxcount",2];
		nd_internal_voterep_widgets set [ND_VOTEREP_WIDGET_INDEX_BESTCTG,_ctgLeft];
		_txt = [TEXT,[0,0,50,10],_ctgin] call nd_regWidget;
		[_txt,"<t size='1.2' align='center'>Выберите двух самых театрально интересных игроков:</t>"] call widgetSetText;
		_txt setBackgroundColor [0.25,0.4,0.13,0.8];
		//_backLeft = [BACKGROUND,_backSize,_ctgLeft] call nd_regWidget;
		//_backLeft setBackgroundColor [0.6,0.6,0.6,0.3];
		private _sizeY = 10;
		{
			[_x,_ctgLeft,_sizeY * _forEachIndex,_sizeY,
				[0.15,0.8,0.15,0.9],"+++ %1 +++"
			] call _loadElem;
		} foreach ([_args deleteAt 0,[],{
			(_x splitString "|") params ["",["_n",""]];
			_n
		},"ASCEND"] call BIS_fnc_sortBy);

		_ctgRight = [WIDGETGROUP_H,[50,10,50,90],_ctgin] call nd_regWidget;
		_ctgRight setvariable ["map",nd_internal_map_veoterepBad];
		_ctgRight setvariable ["maxcount",3];
		nd_internal_voterep_widgets set [ND_VOTEREP_WIDGET_INDEX_BADCTG,_ctgRight];
		_txt = [TEXT,[50,0,50,10],_ctgin] call nd_regWidget;
		[_txt,"<t size='1.2' align='center'>Выберите до трёх самых томных игроков:</t>"] call widgetSetText;
		_txt setBackgroundColor [0.25,0.1,0.1,0.8];
		//_backRight = [BACKGROUND,_backSize,_ctgRight] call nd_regWidget;
		//_backRight setBackgroundColor [0.6,0.6,0.6,0.3];
		_sizeY = 10;
		{
			[_x,_ctgRight,_sizeY * _forEachIndex,_sizeY,
				[0.8,0.15,0.15,0.9],"+++ %1 +++"
			] call _loadElem;
		} foreach ([_args deleteAt 0,[],{
			(_x splitString "|") params ["",["_n",""]];
			_n
		},"ASCEND"] call BIS_fnc_sortBy);

		_reset = [TEXT,[2,90,20,8],_ctg] call nd_regWidget;
		[_reset,"<t align='center'>Сбросить</t>"] call widgetSetText;
		_reset setBackgroundColor [0.3,0,0,0.8];
		_reset ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0.5,0,0,0.9];}];
		_reset ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor [0.3,0,0,0.8];}];
		_reset ctrlAddEventHandler ["MouseButtonUp",{
			if (["nd_voteprot_reset",0.5] call input_spamProtect) exitwith {};
			{
				_wid = _x;
				_isactive = _wid getVariable "isactive";
				if (_isactive) then {
					_ctg = _wid getVariable "mainCtg";
					_map = _ctg getVariable "map";
					_tStruct = _wid getVariable "_tStruct";
					(_isactive) call (_wid getvariable "_onchangeactive");
					_wid setVariable ["isactive",!_isactive];
				};
			} foreach (
				(allControls (nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_BESTCTG))
				+
				(allControls (nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_BADCTG))
			);
		}];

		_apply = [TEXT,[78,90,20,8],_ctg] call nd_regWidget;
		[_apply,"<t align='center'>Принять выбор</t>"] call widgetSetText;
		_apply setBackgroundColor [0,0.3,0,0.8];
		_apply ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor [0,0.5,0,0.9];}];
		_apply ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor [0,0.3,0,0.8];}];
		_apply ctrlAddEventHandler ["MouseButtonUp",{
			if (["nd_voteprot_apply",0.8] call input_spamProtect) exitwith {};
			//проверка конфликтов
			_errorText = "";
			_checkError = {
				if (_errorText !="") exitwith {
					[_errorText] call (nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_ERROR getvariable "onError");
					true
				};
				false
			};
			_bestCount = 0;
			_bestClients = [];
			_badClients = [];
			_bestStruct = [];
			_badStruct = [];
			{
				_ctg = _x getvariable "mainCtg";
				_isBest = equals(_ctg,nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_BESTCTG);
				_hasError = _errorText != "";
				if (_x getVariable "isactive") then {
					_tStruct = _x getvariable "_tStruct";
					if (_isBest) then {
						INC(_bestCount);
					};
					_listCheck = ifcheck(_isBest,_bestClients,_badClients);
					_listStruct = ifcheck(_isBest,_bestStruct,_badStruct);
					_uniStruct = (_tStruct splitString "|" select [0,3] joinString "|");
					(_x getvariable "dat") params ["_nick","_char","_role","_rcls"];

					if (_uniStruct in _listStruct && !_hasError) exitwith {
						_errorText = format["%1 не может быть выбран дважды",_nick];
					};
					_listStruct pushBack _uniStruct;

					
					// нельзя выбрать одного игрока на двух разных ролях
					if (_nick in (_listCheck apply {(_x splitString "=") select 0}) && !_hasError) exitwith {
						_errorText = format["Нельзя выбрать '%1' на двух разных ролях.",_nick];
					};
					_listCheck pushBack (_nick + "=" + _rcls);
				};
			} foreach (
				(allControls (nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_BESTCTG))
				+
				(allControls (nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_BADCTG))
			);
			_hasError = _errorText != "";
			if (_bestCount < 2 && !_hasError) then {
				_errorText = "Необходимо выбрать двух лучших игроков.";
			};
			_itscArr = (_bestClients apply {(_x splitString "=") select 0}) arrayIntersect (_badClients apply {(_x splitString "=") select 0});
			if (count (_itscArr) > 0 && !_hasError) then {
				_errorText = format["Нельзя выбрать '%1' одновременно лучшим и худшим",_itscArr select 0];
			};
			if (call _checkError) exitWith {};
			//traceformat("CLIENT>> Best %1; Bad %2; COMMON %3; haserr %4",_bestClients arg _badClients arg _itscArr arg _hasError);
			[[_bestClients,_badClients]] call nd_onPressButton;
			
		}];

		_errMes = [TEXT,[23,90,54,8],_ctg] call nd_regWidget;
		[_errMes,"<t align='center' size='1.2' color='red'>Не выбрано ни одного игрока</t>"] call widgetSetText;
		_errMes setBackgroundColor [0.3,0,0,0.8];
		nd_internal_voterep_widgets set [ND_VOTEREP_WIDGET_INDEX_ERROR,_errMes];
		_errMes setFade 1;
		_errMes commit 0;
		_errMes setvariable ["onError",{
			params ["_txt"];
			_wid = nd_internal_voterep_widgets select ND_VOTEREP_WIDGET_INDEX_ERROR;
			_wid setFade 0;
			_wid commit 0.1;
			[_wid,format["<t align='center' size='0.9'>%1</t>",_txt]] call widgetSetText;
			_wid setVariable ["lasterrortime",tickTime + 3];
			_wid setVariable ["lasterrorlock",false];
		}];

		_errMes setVariable ["lasterrortime",tickTime];
		_errMes setVariable ["lasterrorlock",true];
		_onUpd = {
			(_this select 0) params ["_wid"];
			if isNullReference(_wid) exitwith {
				stopThisUpdate();
			};
			if (tickTime > (_wid getVariable "lasterrortime")) then {
				if !(_wid getVariable "lasterrorlock") then {
					_wid setVariable ["lasterrorlock",true];
					_wid setFade 1;
					_wid commit 0.5;
				};
			};
		};
		startUpdateParams(_onUpd,0.1,[_errMes]);


	};

endstruct