// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

#include <..\..\..\host\GameObjects\Structures\Electronics\Devices\HeadControlPanel.hpp>


struct(HeadConsole) base(NDBase)

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];

		_ctg = if (_isFirstCall) then {
			_sx = 30;
			_sy = 70;
			private _ctg = [(self getv(thisDisplay)),WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
			self callp(addSavedWidget, _ctg);

			_back = [(self getv(thisDisplay)),BACKGROUND,[0,0,100,100],_ctg] call createWidget;
			_back setBackgroundColor [0.3,0.3,0.3,0.5];

			_closer = [(self getv(thisDisplay)),[0,90,100,10],_ctg] call nd_addClosingButton;
			_closer ctrlSetText "Закрыть";

			_ctgLeft = [(self getv(thisDisplay)),WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
			self callp(addSavedWidget, _ctgLeft);
			
			if equalTypes(_args select 0,true) then {
				_ctgLeft setVariable ["isHeadAccess",_args deleteAt 0];
			};
			
			_ctgLeft
		} else {
			(self callv(getSavedWidgets)) select 1
		};

		_mode = _args deleteAt 0;
		_canHead = _args deleteAt 0;
		
		//serialze text
		_prevtext = ctrlText (_ctg getVariable ["input",widgetNull]);

		call nd_cleanupData;
		//self callp(addWidget, TEXT arg vec4(0,0,100,5) arg _ctg arg null);
		//[vec2(0,_text)] call nd_onPressButton;
		//

		_ypos = 0;
		call {
			//no power for console
			if (_mode == MODE_NOPOWER) exitWith {

			};
			//main menu
			if (_mode == MODE_MENU) exitWith {

				_isAlarm = _args deleteAt 0;
				_isEscapeLaunch = _args deleteAt 0;
				_isHead = _ctg getVariable ["isHeadAccess",false];
				
				//новые кнопки инициализируются тут
				_Btns = [
					["Должности",{},MENU_BUTTON_TOASSIGNROLE], //name, handle name load, var
					["Изгнание",{},MENU_BUTTON_TOEXILE],
					["Указ",{},MENU_BUTTON_TODECREE],
					["Тревога",{ifcheck(_isAlarm,"Выключить тревогу","Тревога")},MENU_BUTTON_ALARM],
					["Побег",{ifcheck(_isEscapeLaunch,"Отмена эвакуации","Эвакуация")},MENU_BUTTON_ESCAPE]
				];
				
				if (_canHead) then {
					_Btns pushBack ["Оголовиться",{},MENU_BUTTON_SETHEAD];
				};
				
				if (_isHead) then {
					_Btns pushBack ["Уйти на покой",{},MENU_BUTTON_RETIRE];
				};
				
				
				//buttons:
				//(menu) assign to role
				//(menu) kick citizen
				//(menu) указ
				//тревога

				_sizeH = 100 / (count _Btns);

				//smart creation
				for "_i" from 0 to (count _Btns) - 1 do {
					(_Btns select _i) params ["_t","_evT","_var"];
					self callp(addWidget, TEXT arg vec4(5,_i * _sizeH,90,_sizeH) arg _ctg arg null);
					(self getv(lastNDWidget)) setVariable ["data",_var];
					(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
						params ["_c","_b"];
						if (["nd_headconsole_menu_button",1] call input_spamProtect) exitWith {};
						_v = _c getVariable "data";
						[[MODE_MENU,_v]] call nd_onPressButton;
					}];
					
					(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseExit",{_this select 0 setBackgroundColor [0,0,0,0]}];
					(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseEnter",{_this select 0 setBackgroundColor [.15,.15,.15,.6]}];

					[(self getv(lastNDWidget)),format["<t align='center'>%1</t>",ifcheck(equals(_evT,{}),_t,call _evT)]] call widgetSetText;
				};
			};
			//assign to role
			if (_mode == MODE_ASSIGNROLE) exitWith {
				_listUsers = _args deleteAt 0;
				_listRoles = _args deleteAt 0;
				
				_ypos = 0;
				self callp(addWidget, TEXT arg vec4(0,0,100,5) arg _ctg arg null);
				[(self getv(lastNDWidget)),"<t align='center'>Поселенцы</t>"] call widgetSetText;
				modvar(_ypos) + 5;
				
				self callp(addWidget, LISTBOX arg vec4(0,_ypos,100,30) arg _ctg arg null);
				_lbUsers = (self getv(lastNDWidget));
				{
					_x params ["_name","_ptr"];
					_idx = _lbUsers lbAdd _name;
					_lbUsers lbSetData [_idx,_ptr];
				} foreach _listUsers;
				
				modvar(_ypos) + 30;
				self callp(addWidget, TEXT arg vec4(0,_ypos,100,5) arg _ctg arg null);
				[(self getv(lastNDWidget)),"<t align='center'>Должности</t>"] call widgetSetText;
				modvar(_ypos)+5;
				
				self callp(addWidget, LISTBOX arg vec4(0,_ypos,100,30) arg _ctg arg null);
				_lbRoles = (self getv(lastNDWidget));
				{
					_x params ["_type","_name"];
					_idx = _lbRoles lbAdd _name;
					_lbRoles lbSetData [_idx,_type];
				} foreach _listRoles;
				
				modvar(_ypos)+30;
				
				//buttons: assign, reasign
				self callp(addWidget, BUTTON arg vec4(0,_ypos,100,15) arg _ctg arg null);
				_btAssign = (self getv(lastNDWidget));

				_btAssign setVariable ["lbRoles",_lbRoles];
				_btAssign setVariable ["lbUsers",_lbUsers];

				//_btAssign setVariable ["listRoles",_listRoles];
				//_btAssign setVariable ["listUsers",_listUsers];

				_btAssign ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					if (["nd_headconsole_menu_button",1] call input_spamProtect) exitWith {};

					_lbRoles = _w getVariable "lbRoles";
					_lbUsers = _w getVariable "lbUsers";

					_idx = lbCurSel _lbRoles;
					if (_idx == -1) exitWith {[pick["Должность не выбрана.","Надо выбрать должность.","А на кого назначать?"],"error"]call chatPrint}; //no selected role
					_idx2 = lbCurSel _lbUsers;
					if (_idx2 == -1) exitWith {[pick["Кого назначать-то?","Надо выбрать поселенца.","Для назначения надо выбрать кого-то."],"error"]call chatPrint}; //no selected user
					_ptrUser = _lbUsers lbData _idx2;
					_roleType = _lbRoles lbData _idx;
					[[MODE_ASSIGNROLE,ASSIGNROLE_DOASSIGN,[_ptrUser,_roleType]]] call nd_onPressButton;
				}];
				_btAssign ctrlSetText "Назначить";
				
				modvar(_ypos)+15;
				
				self callp(addWidget, BUTTON arg vec4(50-20,_ypos,40,15) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Назад";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					[[MODE_ASSIGNROLE,BUTTON_GENERIC_BACK]] call nd_onPressButton;
				}];
			};
			// leave village
			if (_mode == MODE_EXILE) exitWith {

				_listUsers = _args deleteAt 0;
				_ypos = 0;
				
				self callp(addWidget, TEXT arg vec4(0,_ypos,100,5) arg _ctg arg null);
				[(self getv(lastNDWidget)),"<t align='center'>Поселенцы</t>"] call widgetSetText;
				modvar(_ypos)+5;
				
				self callp(addWidget, LISTBOX arg vec4(0,_ypos,100,40) arg _ctg arg null);
				_lbUsers = (self getv(lastNDWidget));
				{
					_x params ["_name","_ptr"];
					_idx = _lbUsers lbAdd _name;
					_lbUsers lbSetData [_idx,_ptr];
				} foreach _listUsers;
				modvar(_ypos)+40;
				
				self callp(addWidget, BUTTON arg vec4(0,_ypos,100,15) arg _ctg arg null);
				_btAssign = (self getv(lastNDWidget));

				_btAssign setVariable ["lbUsers",_lbUsers];

				//_btAssign setVariable ["listUsers",_listUsers];

				_btAssign ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					if (["nd_headconsole_menu_button",1] call input_spamProtect) exitWith {};

					_lbUsers = _w getVariable "lbUsers";

					_idx2 = lbCurSel _lbUsers;
					if (_idx2 == -1) exitWith {}; //no selected user
					_ptrUser = _lbUsers lbData _idx2;
					[[MODE_EXILE,EXILE_DOEXILE,_ptrUser]] call nd_onPressButton;
				}];
				_btAssign ctrlSetText "Изгнать";
				modvar(_ypos) + 15;
				
				self callp(addWidget, BUTTON arg vec4(50-20,_ypos+15/2,40,15) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Назад";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					[[MODE_EXILE,BUTTON_GENERIC_BACK]] call nd_onPressButton;
				}];
			};
			//окно указа
			if (_mode == MODE_DECREE) exitWith {
				_ypos = 5;
				self callp(addWidget, INPUTMULTI arg vec4(5,_ypos,90,40) arg _ctg arg null);

				_input = (self getv(lastNDWidget));
				_input ctrlSetText _prevtext;

				_ctg setVariable ["input",(self getv(lastNDWidget))];
				(self getv(lastNDWidget)) ctrlSetText _bufferedText;
				(self getv(lastNDWidget)) ctrlAddEventHandler ["KeyUp",{
					params ["_w","_key"];
					if (_key == KEY_BACKSPACE) exitWith {
						forceUnicode 0;
						_text = ctrlText _w;
						_sel = ctrlTextSelection _w;

						_sel params ["_idxDel","_countDel","_tex"];
						_aText = toArray _text;
						if (_countDel != 0) then {
							if (_countDel > 0) then {
								_aText deleteRange [_idxDel,_countDel];
								_w ctrlSetText (toString _aText);
								_w ctrlSetTextSelection [_idxDel,0];
							} else {
								_aText deleteRange [_idxDel+_countDel,abs _countDel];
								_w ctrlSetText (toString _aText);
								_w ctrlSetTextSelection [_idxDel+_countDel,0];
							};

						} else {
							_aText deleteRange [_idxDel-1,1];
							_w ctrlSetText (toString _aText);
							_w ctrlSetTextSelection [_idxDel-1,0];
						};

					};
					//auto-send by enter press
					if (_key == KEY_RETURN) exitWith {
						if equals(focusedCtrl getDisplay,_w) then {
							_w ctrlSetText (ctrlText _w + endl);
						};
					};
				}];
				modvar(_ypos) + 40 + 5;
				
				self callp(addWidget, BUTTON arg vec4(5,_ypos,90,20) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Издать";
				(self getv(lastNDWidget)) setVariable ["input",_input];
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					if (["netdisplay_headconsole_dodecree",1] call input_spamProtect) exitWith {};

					_inp = _w getVariable "input";
					_text = ctrlText _inp;
					forceUnicode 1;
					if (count _text >= 1024) exitWith {
						["Слишком много знаков...","error"] call chatPrint;
					};
					if (count _text == 0) exitWith {};

					_inp ctrlSetText "";


					//preparation of text

					_text = sanitize(_text);
					_text = _text regexReplace ["(\r\n|\n)",sbr];

					[[MODE_DECREE,DECREE_DODECREE,_text]] call nd_onPressButton;
				}];
				
				(self getv(lastNDWidget)) ctrlSetFontHeight 0.05;
				
				modvar(_ypos)+20;
				
				self callp(addWidget, BUTTON arg vec4(50-20,_ypos+15/2,40,15) arg _ctg arg null);
				(self getv(lastNDWidget)) ctrlSetText "Назад";
				(self getv(lastNDWidget)) ctrlAddEventHandler ["MouseButtonUp",{
					params ["_w","_b"];

					[[MODE_DECREE,BUTTON_GENERIC_BACK]] call nd_onPressButton;
				}];
			};

		};

	};

endstruct
