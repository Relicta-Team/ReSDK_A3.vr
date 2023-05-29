// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//serverside includes
#include <..\..\host\Family\Family.hpp>
#include <..\..\host\MatterSystem\bloodTypes.hpp>
//serverside includes end




lobby_onCloseSetting = {
	if (!isLobbyOpen) exitWith {
		error("lobby::onCloseSetting() - lobby already closed");
	};

	true call lobby_setEnableCharSetting;

	{
		[_x] call deleteWidget;
	} foreach lobby_openedCharSetWidList;

	setMainWid("currentControl",widgetNull);

	lobby_openedCharSetWidList = [];
};

//событие при ОК имени
lobby_onSetName = {
	onPressParams();

	_text = ctrlText getMainWid("currentControl");
	if (count _text >= 128) exitWith {
		["Слишком длинное имя","log"] call chatPrint;
		call lobby_onCloseSetting;
	};

	//проверка на русские символы
	_blockedKeys = "abcdefghijklmnopqrstuvwxyz";
	_blockedKeys = _blockedKeys + (toUpper _blockedKeys);
	if not_equals((toArray _text) arrayIntersect (toArray _blockedKeys),[]) exitWith {
		["Реликта для русских! (имя только русскими символами если чё...)","log"] call chatPrint;
		call lobby_onCloseSetting;
	};
	
	_textBase = _text;
	_text = _text splitString " ";
	if (count _text > 2 || count _text < 2) exitWith {
		["Допускается только имя и фамилия","log"] call chatPrint;
		call lobby_onCloseSetting;
	};

	forceUnicode 1;  
	//ну теперь то точно без наёбок...
	if !([_textBase,"^[А-Я][а-я]+ [А-Я][а-я]+$/"] call regex_ismatch) exitWith {
		["Нет. Введите имя и фамилию с большой буквы. Например: Вася Пупкин","log"] call chatPrint;
		call lobby_onCloseSetting;
	};
	if (_textBase == "Вася Пупкин") exitWith {
		call lobby_onCloseSetting;
		["<t size='3'>Это слишком крутое имя для тебя.</t>","error"] call chatPrint;
	};

	{
		_text set [_forEachIndex,capitalize(_x)];
	} foreach _text;

	_text = _text joinString " ";

	traceformat("Set name: %1",_text);

	["name",_text] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

//событие рандомного имени
lobby_onSetRandomName = {
	onPressParams(); //DELAY_TO_PICKRANDOMNAME

	if equals(wid getVariable ["lastPick" arg -1],-1) then {
		wid setVariable ["lastPick",tickTime];
	};

	if (tickTime >= (wid getVariable "lastPick")) then {
		wid setVariable ["lastPick",tickTime + DELAY_TO_PICKRANDOMNAME];
		["r-name",0] call lobby_sendToServerSetting;
	} else {
		private _rand = [
			"Погоди ты...",
			"Прекрати это!",
			"Ты такой быстрый!",
			"Спокойно!",
			"Завязывай с этим.",
			"Совсем заняться нечем?",
			"Ну ты и приведера.",
			"Может лучше придумать своё имя?",
			"Тебе это доставляет удовольствие?",
			"Ты всё-равно умрёшь. Так зачем так тщательно подбирать имя?",
			"Ещё один раз и я...",
			"И что ты надеешься тут увидеть?",
			"Ты думаешь, что если без конца клацать по бедной кнопочке тебе выпадет нож?",
			"А ведь это могла быть кнопка для самокика...",
			"Напиши. Себе. Своё. Имя."
		];
		[pick _rand,"system"] call chatPrint;
	};

};

// событие когда сервер заколбечил и подтвердил изменения
lobby_onSetNameCode = {
	params ["_wid","_val"];
	[_wid,("Имя: " + _val)] call widgetSetText;
	private _hNew = _wid call widgetGetTextHeight;
	(_wid call widgetGetPosition) params ["_x","_y","_w"];

	[_wid,[_x,_y,_w,_hNew]] call widgetSetPosition;

	//todo resizing others
	_xPos = _x;
	_yPos = _y;
	_sizeH = getMainProp("sizeH");
	_biasY = getMainProp("biasY");

	MOD(_yPos,+_hNew + _biasY);

	{
		_wid = getMainWid(_x);
		//logformat("--------- %1 -> %2 %3 : %4 %5",_wid arg _sizeH arg _biasY arg _xPos arg _yPos);
		[_wid,[_xPos,_yPos]] call widgetSetPositionOnly;
		MOD(_yPos,+_sizeH + _biasY);
	} foreach lobby_listResizingName;
};

//Событие при выборе имени
lobby_setName = {
	onPressParams();

	false call lobby_setEnableCharSetting;

	_w = [getDisplay,TEXT,[0,0,100,20],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Введите имя вашего персонажа</t>"] call widgetSetText;
	addWidToList(_w);

	_w = [getDisplay,INPUT,[0,20,100,40],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);

	_w = [getDisplay,BUTTON,[0,60,100,20],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetName);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[0,80,100,20],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);
};

//callback on server
lobby_onSetAgeCode = {
	params ["_wid","_val"];
	[_wid,("Возраст: " + str _val)] call widgetSetText;
};

lobby_setAge = {
	onPressParams();

	false call lobby_setEnableCharSetting;

	_w = [getDisplay,TEXT,[0,0,100,20],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Введите возраст вашего персонажа</t>"] call widgetSetText;
	addWidToList(_w);

	_w = [getDisplay,INPUT,[0,20,100,40],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);

	_w = [getDisplay,BUTTON,[0,60,100,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetAge);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[0,70,100,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,{["age" arg randInt(18,80)] call lobby_sendToServerSetting; call lobby_onCloseSetting;});
	_w ctrlSetText "Случайно";

	_w = [getDisplay,BUTTON,[0,80,100,20],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);
};

lobby_onSetAge = {
	onPressParams();

	_text = ctrlText getMainWid("currentControl");

	_num = parseNumber _text;
	if (_num == 0) exitWith {
		["Некорректный возраст","log"] call chatPrint;
		call lobby_onCloseSetting;
	};
	if (_num < 18 || _num > 80) exitWith {
		["Возраст может быть в диапазоне от 18 до 80","log"] call chatPrint;
		call lobby_onCloseSetting;
	};

	traceformat("Set age: %1",_num);

	["age",_num] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

lobby_setFaith = {
	onPressParams();

	false call lobby_setEnableCharSetting;

	_w = [getDisplay,TEXT,[0,0,100,10],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Выбери свою веру</t>"] call widgetSetText;
	addWidToList(_w);

	_desc = [getDisplay,TEXT,[0,40,100,50],getMainCtg] call createWidget;
	addWidToList(_desc);

	_w = [getDisplay,LISTBOX,[0,10,100,30],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);

	_w setVariable ["desc",_desc];

	_defaultData = getCurrentCharData("faith");

	_ind = _w lbAdd "Случайно";
	_listbox_desc_list = ["Будет выбрана одна из доступных вер случайным образом."];
	_w lbSetData [_ind,"rand"];
	_w lbSetCurSel _ind;

	{
		_x params ["_class","_attributes"];
		_attributes params ["_name","_probDesc"];

		_ind = _w lbAdd _name;

		if not_equalTypes(_probDesc,"") then {
			if (_class in lobby_faithDesc_map) then {
				_probDesc = lobby_faithDesc_map get _class;
			} else {
				_probDesc = "Описание отсутствует";
			};
		};

		_w lbSetData [_ind,_class];
		_listbox_desc_list set [_ind,_probDesc];

		if (_defaultData == _class) then {
			_w lbSetCurSel _ind;
		};

	} foreach lobby_faithList;

	_w setvariable ["_listbox_desc_list",_listbox_desc_list];

	_onLbSelChanged = {
		params ["_list", "_selectedIndex"];
		_listbox_desc_list = _list getVariable "_listbox_desc_list";
		_desc = _list getVariable "desc";

		[_desc,'Описание:br_inline br_inline'+ (_listbox_desc_list select _selectedIndex)] call widgetSetText;
	};
	_w ctrlAddEventHandler ["LBSelChanged",_onLbSelChanged];
	[_w,lbCurSel _w] call _onLbSelChanged;


	_w = [getDisplay,BUTTON,[0,90,50,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetFaith);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[50,90,50,10],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);
};

lobby_onSetFaith = {
	onPressParams();
	_faithIndex = lbCurSel getMainWid("currentControl");

	if (_faithIndex < 0) exitWith {
		["Ошибочка. Вера не та.","error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_faithClass = getMainWid("currentControl") lbData _faithIndex;

	["faith",_faithClass] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

lobby_onSetFaithCode = {
	params ["_wid","_val"];

	#define _faith_text "<t size='0.7'>Вера: " + _faithName + "</t>"

	if equals(_val,"rand") exitWith {
		_faithName = "Случайно";
		[_wid,_faith_text] call widgetSetText;
		_wid ctrlSetTooltip _faithName;
	};

	_ind = lobby_faithList findif {equals(_x select 0,_val)};
	if (_ind == -1) exitWith {
		errorformat("lobby::onSetFaithCode() - Invalid enum %1",_val);
	};
	_faithName = lobby_faithList select _ind select 1 select 0;

	[_wid,_faith_text] call widgetSetText;
	_wid ctrlSetTooltip _faithName;
};


lobby_setAntag = {
	onPressParams();
	
	_mode = getCurrentCharData("antag");
	INC(_mode);
	
	if (_mode >= 4) then {_mode = 0};
	
	["antag",_mode] call lobby_sendToServerSetting;
};

lobby_onSetAntagCode = {
	params ["_wid","_val"];
	
	_tEnumList = [
		"Нет",
		"Скрытый",
		"Особый",
		"Да!"
	];
	_tEnumListDesc = [
		"Вы не будете становиться злодеем.",
		"Вы сможете стать злодеем на своей роли.",
		"Вы сможете стать злодеем, получив отдельную роль.",
		"Вы сможете стать скрытым или особенным злодеем."
	];
	
	_antagValue = _tEnumList select _val;
	
	[_wid,format["Злодей: %1",_antagValue]] call widgetSetText;
	_wid ctrlSetTooltip (_tEnumListDesc select _val);
};

lobby_setTrait = {
	rpcSendToServer("onClientPressedTrait",[clientOwner]);
};

lobby_setFace = {
	onPressParams();

	_isWomanMode = getCurrentCharData('gender') != 0;

	false call lobby_setEnableCharSetting;

	_list = [getDisplay,LISTBOX,[0,0,50,100],getMainCtg] call createWidget;
	addWidToList(_list);
	_listFaces = if (_isWomanMode) then {faces_list_woman} else {faces_list_man}; //if in profile setted woman gender then select from faces_list_woman

	private _cfgFaces = configfile >> "CfgFaces" >> "Man_A3";
	/*    private _allFacesForType = [];
    for "_i" from 0 to (count _cfgFaces - 1) do {
        _face = _cfgFaces select _i;

        if (isclass _face) then {
            //if (getnumber(_face >> "disabled") == 0) then {

                //_allFacesForType pushback [(configname _face),getText(_face >> "texture")];
                _ind = _list lbAdd getText(_face >> "displayName");
				_list lbSetData [_ind,str [getText(_face >> "texture"),(configname _face)]];
            //};
        };
    };*/

	_list lbAdd "Случайно";
	_list lbSetData [0,"['nontext','rand']"];
	_defaultIndex = 0;
	_curValue = getCurrentCharData("face");
	{
		_face = _cfgFaces >> _x; //(configname _face);//
		_ind = _list lbAdd ([getText(_face >> "displayName"),"Female","Цаца "] call cba_fnc_replace); //временная замена имён цац
		_configName = configName _face;
		_list lbSetData [_ind,
			if (_isWomanMode) then {
				_mapWoman = [
					"women\data\baker_co1.paa",
					"women\data\europ_co1.paa|women\data\hair\enslerhair_ca.paa",
					"women\data\baker_co1.paa|women\data\hair\rockerhair_co.paa",
					"women\data\europ_co1.paa",
					"women\data\baker_co1.paa|women\data\hair\rockerhair_v2_co.paa",
					"women\data2\hooker1_co.paa",
					"women\data2\hooker3_co.paa",
					"women\data2\hooker2_co.paa",
					"women\data3\sportswoman1_co.paa",
					"women\data3\sportswoman2_co.paa",
					"women\data3\sportswoman5_co.paa",
					"women\data\baker_co1.paa|women\data4\hair1.paa",
					"women\data\baker_co1.paa|women\data4\hair1_bis.paa",
					"women\data\baker_co1.paa|women\data4\hair.paa",
					"women\data5\valentinafit_co.paa"
				];
				_ind = parseNumber (_x select [10,2]); //"max_femaleNN"
				str [_mapWoman select (_ind - 1),_configName]
			} else {
				str [getText(_face >> "texture"),_configName]
			}

		];

		if (_configName == _curValue) then {_defaultIndex = _ind};
	} foreach _listFaces;


	_ctg = [getDisplay,WIDGETGROUP,[50,0,50,50],getMainCtg] call createWidget;
	addWidToList(_ctg);
	_startPos = 90;
	_pic = [getDisplay,PICTURE,[-_startPos / 2,-_startPos / 2,100 + _startPos,100 + _startPos],_ctg] call createWidget;
	addWidToList(_pic);
	_list setvariable ["pic",_pic];

	if (_isWomanMode) then {

		[_pic,[-75,-50,500,500]] call widgetSetPosition;

		_startPos = 90;
		_pic = [getDisplay,PICTURE,[-35,-135,170,170],_ctg] call createWidget;
		addWidToList(_pic);
		_pic setFade 0.5;
		_pic commit 0;
		_list setvariable ["picHair",_pic];
	};

	_onLbSelChanged = {
		params ["_list", "_selectedIndex"];

		(parseSimpleArray (_list lbData _selectedIndex)) params ["_texture","_config"];

		_pic = _list getVariable "pic";

		_handleRand = (_pic getvariable ["__handleRandFace",-1]);
		if (_handleRand != -1) then {stopUpdate(_handleRand)};

		//traceformat("updated pic %1 -> %2",_texture arg _config);

		if (_texture == "nontext") then {
			_updrandFace = {
				(_this select 0) params ["_pic","_list"];
				if (equals(_pic,widgetNull) || equals(_list,widgetNull)) exitWith {
					stopThisUpdate();
				};
				_lastInd = lbSize _list - 1;
				_randIndex = randInt(1,_lastInd);
				(parseSimpleArray (_list lbData _randIndex)) params ["_texture","_config"];

				[_pic,_texture] call widgetSetPicture;
			};
			_hrand = startUpdateParams(_updrandFace,RANDFACE_UPD_TIME,[_pic arg _list]);
			_pic setVariable ["__handleRandFace",_hrand];
		} else {
			[_pic,_texture] call widgetSetPicture;
		};

	};
	if (_isWomanMode) then {
		_onLbSelChanged = {
			params ["_list", "_selectedIndex"];

			(parseSimpleArray (_list lbData _selectedIndex)) params ["_texture","_config"];

			_pic = _list getVariable "pic";
			_picHair = _list getVariable "picHair";

			_handleRand = (_pic getvariable ["__handleRandFace",-1]);
			if (_handleRand != -1) then {stopUpdate(_handleRand)};

			if (_texture == "nontext") then {
				_updrandFace = {
					(_this select 0) params ["_pic","_picHair","_list"];
					if (equals(_pic,widgetNull) || equals(_list,widgetNull)) exitWith {
						stopThisUpdate();
					};
					_lastInd = lbSize _list - 1;
					_randIndex = randInt(1,_lastInd);
					(parseSimpleArray (_list lbData _randIndex)) params ["_texture","_config"];

					if ("|" in _texture) then {
						_listTex = _texture splitString "|";
						_face = _listTex select 0;
						_hairs = _listTex select 1;

						[_pic,_face] call widgetSetPicture;
						[_picHair,_hairs] call widgetSetPicture;

					} else {
						[_pic,_texture] call widgetSetPicture;
						[_picHair,""] call widgetSetPicture;
					};
				};
				_hrand = startUpdateParams(_updrandFace,RANDFACE_UPD_TIME,[_pic arg _picHair arg _list]);
				_pic setVariable ["__handleRandFace",_hrand];

			} else {

				if ("|" in _texture) then {
					_listTex = _texture splitString "|";
					_face = _listTex select 0;
					_hairs = _listTex select 1;

					[_pic,_face] call widgetSetPicture;
					[_picHair,_hairs] call widgetSetPicture;

				} else {
					[_pic,_texture] call widgetSetPicture;
					[_picHair,""] call widgetSetPicture;
				};
			};
		};
	};

	_list ctrlAddEventHandler ["LBSelChanged",_onLbSelChanged];
	setMainWid("currentControl",_list);

	[_list,_defaultIndex] call _onLbSelChanged;
	_list lbSetCurSel _defaultIndex;

	_w = [getDisplay,BUTTON,[52,52,50 - 4,20],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetFace);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[52,52 + 20 + 2,50 - 4,20],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);

	//[_pic,"a3\Characters_F_Enoch\Heads\data\m_livonianHead_6_co.paa"] call widgetSetPicture;

};

lobby_onSetFace = {
	onPressParams();
	_faceIndex = lbCurSel getMainWid("currentControl");

	if (_faceIndex < 0) exitWith {
		["Ошибочка. Лицо не то.","error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_faceData = getMainWid("currentControl") lbData _faceIndex;
	(parseSimpleArray _faceData) params ["_texture","_config"];

	["face",_config] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

lobby_onSetFaceCode = {
	params ["_wid","_val"];

	_text = if (_val == "rand") then {
		"Случайно"
	} else {
		_rez = getText(configfile >> "CfgFaces" >> "Man_A3" >> _val >> "displayName");

		if ("Female" in _rez) then {
			forceUnicode 0;
			[_rez,"Female","Цаца "] call cba_fnc_replace //временная замена имён цац
		} else {
			_rez
		}
	};

	[_wid,("Лицо: " + _text)] call widgetSetText;
	_wid ctrlSetTooltip _text;
};

lobby_setVice = {
	onPressParams();

	false call lobby_setEnableCharSetting;

	_w = [getDisplay,TEXT,[0,0,100,10],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Выбери свой порок</t>"] call widgetSetText;
	addWidToList(_w);

	_w = [getDisplay,LISTBOX,[0,10,100,80],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);

	_currentVice = getCurrentCharData("vice");

	_ind = _w lbAdd "Случайно";
	_w lbSetData [_ind,"rand"];
	_w lbSetCurSel _ind;
	{
		_x params ["_class","_name"];
		_index = _w lbAdd _name;
		_w lbSetData [_index,_class];
		if (_class == _currentVice) then {
			_w lbSetCurSel _index;
		};
	} foreach lobby_viceList;

	_w = [getDisplay,BUTTON,[0,90,50,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetVice);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[50,90,50,10],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);
};

lobby_onSetVice = {
	onPressParams();
	_viceIndex = lbCurSel getMainWid("currentControl");

	if (_viceIndex < 0) exitWith {
		["Ошибочка. Не тот порок.","error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_viceData = getMainWid("currentControl") lbData _viceIndex;

	["vice",_viceData] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

lobby_onSetViceCode = {
	params ["_wid","_val"];

	_sizeText = 0.7;

	if (_val == "rand") exitWith {
		_text = "Случайный";
		[_wid,format["<t size='%2'>%1</t>","Порок: " + _text,_sizeText]] call widgetSetText;
		_wid ctrlSetTooltip _text;
	};

	_index = lobby_viceList findif {equals(_x select 0,_val)};
	if (_index == -1) exitWith {
		errorformat("lobby::onSetViceCode() - Cant find vice %1",_val);
	};
	_text = lobby_viceList select _index select 1;

	[_wid,format["<t size='%2'>%1</t>","Порок: " + _text,_sizeText]] call widgetSetText;
	_wid ctrlSetTooltip _text;
};

lobby_setBlood = {
	onPressParams();

	false call lobby_setEnableCharSetting;

	getMainWid("setBlood") ctrlSetTooltip "";

	_w = [getDisplay,TEXT,[0,0,100,10],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Выбери свою группу крови</t>"] call widgetSetText;
	addWidToList(_w);

	_w = [getDisplay,LISTBOX,[0,10,100,80],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);

	_currentBlood = getCurrentCharData("blood");

	_ind = _w lbAdd "Случайно";
	_w lbSetData [_ind,'BLOOD_TYPE_RANDOM'];
	_w lbSetTooltip [_ind,"Ты получишь случайную группу крови."];
	_w lbSetCurSel _ind;

	_bloodNamesList = BLOOD_LIST_ALL_NAMES;
	_resus = ["отрицательная","положительная"];
	_group = ["первая","вторая","третья","четвёртая"];
	{
		_ind = _w lbAdd (_bloodNamesList select _forEachIndex);
		_w lbSetData [_ind,str _x];

		//setting description
		_w lbSetTooltip [_ind,format ["Группа крови: %1 (%2)",_group select ((floor(_x / 10)) - 1),_resus select (_x % 10)]];

		if (_currentBlood == _x) then {
			_w lbSetCurSel _ind;
		};
	} foreach BLOOD_LIST_ALL_TYPES;

	_w = [getDisplay,BUTTON,[0,90,50,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetBlood);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[50,90,50,10],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);
};

lobby_onSetBlood = {
	onPressParams();

	_bloodIndex = lbCurSel getMainWid("currentControl");

	if (_bloodIndex < 0) exitWith {
		["Ошибочка. Не та кровь.","error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_blood = getMainWid("currentControl") lbData _bloodIndex;

	_bloodEnum = parseNumber _blood;
	if (!array_exists(BLOOD_LIST_ALL_TYPES,_bloodEnum) && _bloodEnum != BLOOD_TYPE_RANDOM) exitWith {
		errorformat("lobby::onSetBlood() - Invalid enum %1 as data %2",_bloodEnum arg _blood);
	};

	["blood",_bloodEnum] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

lobby_onSetBloodCode = {
	params ["_wid","_val"];

	_bloodText = "Случайно";
	_bloodDesc = "Группа крови: случайная";

	if not_equals(_val,BLOOD_TYPE_RANDOM) then {
		_resus = ["отрицательная","положительная"];
		_group = ["первая","вторая","третья","четвёртая"];

		_bloodText = BLOOD_ENUM_TO_STRING(_val);
		_bloodDesc = format ["Группа крови: %1 (%2)",_group select ((floor(_val / 10)) - 1),_resus select (_val % 10)];
	};

	_wid ctrlSetText ("Кровь: " + _bloodText);
	_wid ctrlSetTooltip (_bloodDesc);

};

lobby_onSetGender = {
	onPressParams();

	if equals(wid getVariable ["lastPick" arg -1],-1) then {
		wid setVariable ["lastPick",tickTime];
	};

	if (tickTime >= (wid getVariable "lastPick")) then {
		wid setVariable ["lastPick",tickTime + DELAY_TO_PICKGENDER];
		_newVal = if (getCurrentCharData("gender") == 0) then {1} else {0};
		["gender",_newVal] call lobby_sendToServerSetting;
	} else {
		private _rand = [
			"Не спеши!",
			"Оставайся собой.",
			"Смена пола это очень серьёзный шаг. Подумай дважды...",
			"Какая разница что у тебя будет между ног?!",
			"Пол не имеет значения..."
		];
		[pick _rand,"system"] call chatPrint;
	};
};

lobby_onSetGenderCode = {
	params ["_wid","_val"];
	_gend = if (_val == 0) then {"мужской"} else {"женский"};
	[_wid,("Пол: " + _gend)] call widgetSetText;

	//changing face
	/*if (isNullVar(_isLoadSettingsFlag)) then {
		["face","rand"] call lobby_sendToServerSetting;
	};*/

	//todo blocking beard
};

lobby_onSetFamily = {
	onPressParams();

	if equals(wid getVariable ["lastPick" arg -1],-1) then {
		wid setVariable ["lastPick",tickTime];
	};

	if (tickTime >= (wid getVariable "lastPick")) then {
		wid setVariable ["lastPick",tickTime + DELAY_TO_PICKFAMILY];

		_curFam = getCurrentCharData("family");
		if (!FAMILY_IS_EXISTS(_curFam)) exitWith {
			errorformat("lobby::onSetFamily() - invalid enum %1",_curFam);
		};
		INC(_curFam);
		if (!FAMILY_IS_EXISTS(_curFam)) then {
			_curFam = FAMILY_DEFAULT;
		};

		["family",_curFam] call lobby_sendToServerSetting;
	} else {
		private _rand = [
			"Зачем что-то менять?",
			"А мне и так хорошо...",
			"Это очень серьёзный шаг!",
			"Умирать ты всё-равно будешь в одиночестве."
		];
		[pick _rand,"system"] call chatPrint;
	};
};

lobby_onSetFamilyCode = {
	params ["_wid","_val"];


	if (!FAMILY_IS_EXISTS(_val)) exitWith {
		errorformat("lobby::onSetFamilyCode() - Invalid enum value %1",_val);
		[_wid,"Ошибка!"] call widgetSetText;
		_wid ctrlSetTooltip "ошибочка?!";
	};

	_sizeText = 0.8;

	_familyList = ["Одиночество","Холостятство","Есть семья"];
	_famText = _familyList select _val;

	[_wid,format["<t size='%2'>%1",_famText,_sizeText]] call widgetSetText;
	_wid ctrlSetTooltip ("Семейное положение: " + _famText);
};

lobby_onSetMainHand = {
	onPressParams();

	if equals(wid getVariable ["lastPick" arg -1],-1) then {
		wid setVariable ["lastPick",tickTime];
	};

	if (tickTime >= (wid getVariable "lastPick")) then {
		wid setVariable ["lastPick",tickTime + DELAY_TO_PICKMAINHAND];
		_newVal = if (getCurrentCharData("mainhand") == 0) then {1} else {0};
		["mainhand",_newVal] call lobby_sendToServerSetting;
	};
};

lobby_onSetMainHandCode = {
	params ["_wid","_val"];
	_eval = ["левая","правая"]; _evalsetting = ["Левша","Правша"];
	_txt = format ["Основная рука персонажа - %1",_eval select _val];
	_wid ctrlSetTooltip _txt;
	[_wid,(_evalsetting select _val)] call widgetSetText;
};

//событие при выборе
lobby_onSetRole = {
	onPressParams();

	_roleIndex = lbCurSel getMainWid("currentControl");
	//traceformat("roleIndex %1",_roleIndex);

	if (_roleIndex < 0) exitWith {
		_rnd = ["А судьба-то не выбрана...","А ничего и не выбрано.","Надо... выбрать!"];
		[pick _rnd,"error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_roleClass = getMainWid("currentControl") lbData _roleIndex;
	//traceformat("Role class is %1",_roleClass);

	_roleInd = getMainWid("currentControl") getVariable "roleIndex";

	["role" + str _roleInd,_roleClass] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

//событие вызывается когда сервер подтвердил изменения
lobby_onSetRoleCode = {
	params ["_wid","_val"];

	_val params ["_class","_roleInd"];

	_roleName = "Неизвестно";

	if (_class == "none") exitWith {
		_roleName = "Случайно";
		[_wid,format["%1: <t size='0.8'>%2</t>",_roleInd,_roleName]] call widgetSetText;

		_roleInd call lobby_resizingByRoleChanged;

		//discord update
		[] call discrpc_setInLobbyStatus;
	};

	_ind = lobby_roleList findif {(_x select 0) == _class};
	if (_ind == -1) then {
		errorformat("Cant find role index for <%1>",_class);
		_roleName = "Неизвестная роль";
	} else {
		_roleName = lobby_roleList select _ind select 1;
	};

	[_wid,format["%1: <t size='0.8'>%2</t>",_roleInd,_roleName]] call widgetSetText;

	_roleInd call lobby_resizingByRoleChanged;

	if (_roleInd == 1 && lobby_isReadyToPlay) then {
		[_roleName] call discrpc_setInLobbyStatus;
	};
};

//вызывается когда установлена новая роль и надо изменить размер
lobby_resizingByRoleChanged = {
	private _startingInd = _this;

	_wid = getMainWid("setRole" + str _startingInd);
	private _hNew = _wid call widgetGetTextHeight;
	(_wid call widgetGetPosition) params ["_x","_y","_w"];

	[_wid,[_x,_y,_w,_hNew]] call widgetSetPosition;

};

//Событие при выборе роли
lobby_setRole = {
	onPressParams();
	
	if ([">","GAME_STATE_LOBBY"] call gmc_checkState) exitWith {
		["Назначить желаемые роли можно только до начала раунда. Нажмите ""Подключиться"" и выберите свою роль.","log"] call chatPrint;
	};
	
	false call lobby_setEnableCharSetting;

	_w = [getDisplay,TEXT,[0,0,100,10],getMainCtg] call createWidget;
	[_w,sbr + "<t align='center'>Выбери свою судьбу</t>"] call widgetSetText;
	addWidToList(_w);

	_w = [getDisplay,LISTBOX,[0,10,100,80],getMainCtg] call createWidget;
	addWidToList(_w);
	setMainWid("currentControl",_w);
	_w setVariable ["roleIndex",wid getVariable "roleIndex"];

	_ind = _w lbAdd "Случайно";
	_w lbSetTooltip [_ind,"Пусть случай решит мою судьбу"];
	_w lbSetData [_ind,"none"];

	{
		_x params ["_class","_name","_desc"];
		_index = _w lbAdd _name;
		_w lbSetData [_index,_class];
		_w lbSetTooltip [_index,_desc];

	} foreach lobby_roleList;




	_w = [getDisplay,BUTTON,[0,90,50,10],getMainCtg] call createWidget;
	addWidToList(_w);
	addOnPressEvent(_w,lobby_onSetRole);
	_w ctrlSetText "Ок";

	_w = [getDisplay,BUTTON,[50,90,50,10],getMainCtg] call createWidget;
	_w ctrlSetText "Отмена";
	addWidToList(_w);
	addCloseEvent(_w);

};

/*
================================================================================
	GROUP: WIDGET HELPERS
================================================================================
*/

lobby_setEnableCharSetting = {
	private _mode = _this;

	lobby_isOpenCharSetting = !_mode;

	private _fadeVal = if _mode then {0} else {1};

	{
		_x ctrlEnable _mode;
		_x setFade _fadeVal;
		_x commit 0.25;
	} foreach lobby_charSetWidList;
};

lobby_createInput = {

};

//создаёт выборку цвета
lobby_createColorize = {};

/*
================================================================================
	GROUP: COMMON
================================================================================
*/

lobby_initReadyButton = {
	
	if isNullReference(getDisplay) exitWith {warning("lobby::initReadyButton() - Display closed")};
	
	private _wid = getReadyButton;
	
	if (call gmc_isRoundPreload) exitWith {
		[_wid,"<t align='center'>Загружаем...</t>"] call widgetSetText;
		_wid setBackgroundColor READY_BUTTON_COLOR_OFF;
		_wid ctrlShow false;
		_fire = lobby_sprite_readyButton select 0;
		_fire setFade 1;
		_fire commit DELAY_TO_READY;
	};
	if (call gmc_isRoundEnding) exitWith {
		[_wid,"<t align='center'>Раунд окончен</t>"] call widgetSetText;
		_wid setBackgroundColor READY_BUTTON_COLOR_OFF;
		_wid ctrlShow false;
		_fire = lobby_sprite_readyButton select 0;
		_fire setFade 1;
		_fire commit DELAY_TO_READY;
	};
	
	_wid ctrlShow true;
	
	if (call gmc_isRoundPlaying) exitWith {
		[_wid,format["<t align='center'>%1</t>",["Подключиться","Выйти из группы"]select lobby_isSelectedEmbarkRole]] call widgetSetText;
		_wid setBackgroundColor ([READY_BUTTON_COLOR_ON,READY_BUTTON_COLOR_OFF]select lobby_isSelectedEmbarkRole);
		_fire = lobby_sprite_readyButton select 0;
		_fire setFade 0;
		_fire commit DELAY_TO_READY;
	};
	//lobby handler
	if (lobby_isReadyToPlay) then {
		[_wid,"<t align='center'>Вы готовы</t>"] call widgetSetText;
		_wid setBackgroundColor READY_BUTTON_COLOR_ON;
		_fire = lobby_sprite_readyButton select 0;
		_fire setFade 0;
		_fire commit DELAY_TO_READY;
	} else {
		[_wid,"<t align='center'>Нажмите для готовности</t>"] call widgetSetText;
		_wid setBackgroundColor READY_BUTTON_COLOR_OFF;
		_fire = lobby_sprite_readyButton select 0;
		_fire setFade 1;
		_fire commit DELAY_TO_NOT_READY;
	};
};

//переключение режима готовности моба
lobby_switchReady = {
	params ["_wid","_butt"];

	if (lobby_isOpenCharSetting) exitWith {}; //с открытыми настройками готовности/подключения не разрешают


	private _newMode = !lobby_isReadyToPlay;

	//call lobby_initReadyButton;

	if (call gmc_isRoundPlaying) exitWith {
		_newMode = false;
		_wid ctrlEnable false;
		rpcSendToServer("getAllowedLateRoles",[clientOwner]);
	};

	if (_newMode) then {
		_roleClass = getCurrentCharData("role1") select 0;
		if (_roleClass == "none") exitWith {};

		_ind = lobby_roleList findif {(_x select 0) == _roleClass};
		if (_ind == -1) exitWith {};

		[lobby_roleList select _ind select 1] call discrpc_setInLobbyStatus;
	} else {
		[] call discrpc_setInLobbyStatus;
	};

	rpcSendToServer("onClientPrepareToPlay",[_newMode arg clientOwner]);
};

lobby_onSwitchReadyCallback = {
	params ["_newMode"];
	
	if equalTypes(_newMode,0) then {
		lobby_isSelectedEmbarkRole = _newMode > 0;
		
		if (!lobby_isSelectedEmbarkRole) then {
			getReadyButton ctrlEnable true;
		};	
	} else {
		lobby_isReadyToPlay = _newMode;
	};
	
	call lobby_initReadyButton;
	
}; rpcAdd("onClientPrepareToPlayCallback",lobby_onSwitchReadyCallback);
