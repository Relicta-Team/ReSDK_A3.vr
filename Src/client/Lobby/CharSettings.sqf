// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

//serverside includes
#include <..\..\host\Family\Family.hpp>
#include <..\..\host\MatterSystem\bloodTypes.hpp>
#include <..\..\host\GamemodeManager\GamemodeManager.hpp>
//serverside includes end

namespace(Lobby,lobby_)

decl(void())
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
decl(void(widget;int))
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
decl(void(widget;int))
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
decl(void(widget;int))
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
decl(void(widget;int))
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
decl(void(widget;int))
lobby_onSetAgeCode = {
	params ["_wid","_val"];
	[_wid,("Возраст: " + str _val)] call widgetSetText;
};

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
lobby_setAntag = {
	onPressParams();
	
	_mode = getCurrentCharData("antag");
	INC(_mode);
	
	if (_mode > ANTAG_ALL) then {_mode = ANTAG_NONE};
	
	["antag",_mode] call lobby_sendToServerSetting;
};

decl(void(widget;int))
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

decl(void(widget;int))
lobby_setTrait = {
	rpcSendToServer("onClientPressedTrait",[clientOwner]);
};

decl(vector3(vector3;float;float))
lobby_face_internal_relpos = {
	params ["_posI",["_dirPos",0],["_dropRad",2]];
	[(_posI select 0) + (sin _dirPos) * _dropRad, (_posI select 1) + (cos _dirPos) * _dropRad, _posI select 2];
};

decl(void(widget;int))
lobby_setFace = {
	onPressParams();

	_isWomanMode = getCurrentCharData('gender') != 0;

	false call lobby_setEnableCharSetting;

	_list = [getDisplay,"RscTree",[0,0,50,100],getMainCtg] call createWidget;
	addWidToList(_list);
	_mapFaces = if (_isWomanMode) then {faces_map_woman} else {faces_map_man};

	//полный случайный выбор
	private _id = _list tvAdd [[],"Случайно"];
	_list tvSetData [[_id],"['','rand']"];
	_defaultIndex = [_id];
	_curValue = getCurrentCharData("face");
	{
		_x params ["_catSys","_manCatName","_womanCatName","_catCommonName"];
		private _raceCatId = _list tvAdd [[],_catCommonName];
		_list tvSetData [[_raceCatId],format["['%1','cat']",_catSys]];
		
		//выбор из категории случайного лица
		private _newItem = _list tvAdd [[_raceCatId],format["Случайн%1 %2",ifcheck(_isWomanMode,"ая","ый"),ifcheck(_isWomanMode,_womanCatName,_manCatName)]];
		_list tvSetData [[_raceCatId,_newItem],format["['%1','rand','%2']",_catSys,ifcheck(_isWomanMode,_womanCatName,_manCatName)]];

		{
			_newItem = _list tvAdd [[_raceCatId],format["%1 %2",ifcheck(_isWomanMode,_womanCatName,_manCatName),_foreachIndex + 1]];
			_list tvSetData [[_raceCatId,_newItem],format["['%1','select','%2']",_x,_catSys]];

			if (_x == _curValue) then {_defaultIndex = [_raceCatId,_newItem]};
		} foreach (_mapFaces getOrDefault [_catSys,[]]);
		
	} foreach face_list_category;

	//reset cam r2t
	lobby_internal_rttcamera cameraEffect ["terminate", "back"];

	//sync render lighting
	call render_hdr_init;

	//creating camera, using for lobby_glob_dummy_man
	lobby_internal_rttcamera cameraEffect ["INTERNAL", "BACK", "lobby_face_rtt"];
	private _campos = (lobby_glob_dummy_man modeltoworldvisual (lobby_glob_dummy_man selectionPosition "head"));
	lobby_internal_rttcamera setposatl (_campos vectoradd [0,1,0.15]);
	lobby_internal_rttcamera campreparetarget (_camPos vectoradd [-0.05,0,0.11]);
	lobby_internal_rttcamera camSetFov 0.16;
	lobby_internal_rttcamera camcommitprepared 0;
	private _defPos = getPosATL lobby_internal_rttcamera;

	//adding wall
	// deletevehicle lobby_internal_backwallObject;
	// lobby_internal_backwallObject = createSimpleObject [
	// 	//"a3\structures_f_enoch\walls\brick\brickwall_01_l_5m_f.p3d"
	// 	"a3\structures_f\walls\stone_4m_f.p3d"
	// 	,[0,0,0]];
	// lobby_internal_backwallObject setposatl (_campos vectoradd [0,-1,0]);
	{
		_y params ["_initData"];
		_initData params ["_model","_pos",["_dir",0]];
		private _o = createSimpleObject [_model,[0,0,0],true];
		_o setposatl (_campos vectoradd _pos);
		_o setdir _dir;
		if !isNullReference(lobby_internal_backwallObjects get _x) then {
			deletevehicle (lobby_internal_backwallObjects get _x);
		};
		lobby_internal_backwallObjects set [_x,_o];
		_o hideObject true;
	} foreach lobby_internal_backwallSettings;

	if !isNullReference(lobby_internal_rttlight) then {
		deletevehicle lobby_internal_rttlight;
	};
	private _rttlt = "#lightreflector" createVehicleLocal [0,0,0];
	_rttlt setPosAtl (_campos vectoradd [1,0.2,1.7]);
	private _ps = -90;
	[_rttlt,[0,_ps,0]] call BIS_fnc_setObjectRotation;
	[_rttlt,[0,_ps,0]] call BIS_fnc_setObjectRotation;
	_rttlt setLightColor [0.48,0.48,0.45];
	_rttlt setLightAmbient [0.03,0.03,0.04];
	_rttlt setLightIntensity 1000;
	_rttlt setLightAttenuation [1,0,0,0,5,7];
	_rttlt setLightConePars [122.52,30.46,2];

	lobby_internal_rttlight = _rttlt;

	_ctg = [getDisplay,WIDGETGROUP,[50,0,50,50],getMainCtg] call createWidget;
	addWidToList(_ctg);
	_startPos = 90;
	_pic = [getDisplay,PICTURE,
		[-30/2,0,100+30,100]
		//WIDGET_FULLSIZE
		//[-_startPos / 2,-_startPos / 2,100 + _startPos,100 + _startPos]
	,_ctg] call createWidget;
	_pic ctrlSetText "#(argb,512,512,1)r2t(lobby_face_rtt,1)";

	_pic ctrlAddEventHandler ["Destroy",{
		lobby_internal_rttcamera cameraEffect ["terminate", "back"];
		deletevehicle lobby_internal_rttlight;
		{
			deletevehicle _y;
		} foreach lobby_internal_backwallObjects;
	}];
	
	//camera rotator
	_pic ctrlEnable true;
	_pic setvariable ["defPos",_defPos];
	_pic setvariable ["_interpExit",false];
	_pic setvariable ["_interpEnter",false];
	startAsyncInvoke
	{
		_this params ["_pic"];
		if isNullReference(_pic) exitWith {true};
		
		//if equals(getPosATL lobby_internal_rttcamera,_pic getvariable "defPos") exitWith {false};

		if (_pic getvariable ["_interpExit",false]) then {
			
			_newpos = vectorLinearConversion [
				(_pic getvariable "_interpStartTime"),
				(_pic getvariable "_interpStartTime") + 0.7,
				tickTime,
				_pic getvariable "_interpCamPos",
				_pic getvariable "defPos",
				true
			];
			lobby_internal_rttcamera setPosATL _newpos;
		};
		if (_pic getvariable ["_interpEnter",false]) then {
			_stime = _pic getvariable "_interpEnterStartTime";
			_stimeEnd = _stime+0.5;
			// if (tickTime > _stimeEnd) exitWith {
			// 	//_pic setvariable ["_interpEnter",false];
			// };
			
			_endPos = vectorLinearConversion [
				_stime,
				_stimeEnd,
				tickTime,
				_pic getvariable "_interpCamPos",
				_pic getvariable "_mouseMovingCamPos",
				true
			];

			lobby_internal_rttcamera setPosATL _endPos;
		};
		false
	},
	{
		_this params ["_pic","_defPos"];
		lobby_internal_rttcamera setPosATL _defPos;
	},
	[_pic,_defPos]
	endAsyncInvoke
	_pic setvariable ["mimicEnable",{
		params ["_mode"];
		// if (_mode && {!(simulationEnabled lobby_glob_dummy_man)}) then {
		// 	lobby_glob_dummy_man enablesimulation _mode;
		// };
		//! Это не работает из-за каких-то сетевых ебаных чешких тонкостей.
		//Для решения проблемы возможно стоит создавать dummy чара для каждого клиента
		// lobby_glob_dummy_man setMimic "default";
		// lobby_glob_dummy_man enableMimics _mode;
	}];
	_pic ctrladdeventhandler ["MouseExit",{
		params ["_w"];
		//lobby_internal_rttcamera setposatl (_w getvariable "defPos");
		[false] call (_w getvariable "mimicEnable");
		_w setvariable ["_interpCamPos",getPosATL lobby_internal_rttcamera];
		_w setvariable ["_interpStartTime",tickTime];
		_w setvariable ["_interpExit",true];
		_w setvariable ["_interpEnter",false];
	}];
	_pic ctrladdeventhandler ["MouseEnter",{
		params ["_w"];
		_w setvariable ["_interpExit",false];
		_w setvariable ["_interpEnter",true];
			_w setvariable ["_interpCamPos",getPosATL lobby_internal_rttcamera];
			_w setvariable ["_interpEnterStartTime",tickTime];
		[true] call (_w getvariable "mimicEnable");
		ctrlSetFocus _w;
	}];
	_pic ctrladdeventhandler ["MouseMoving",{
		params ["_w","_xm","_ym"];
		(ctrlPosition _w) params ["_bpx","_bpy","_szX","_szY"];

		private _campos = (lobby_glob_dummy_man modeltoworldvisual (lobby_glob_dummy_man selectionPosition "head"));
		private _defPos = _w getvariable "defPos";
		
		private _rad = _campos distance _defPos;
		private _mul = 100;
		private _dirX = linearConversion [0,_szX,_xm,-_rad* _mul,_rad* _mul];
		private _dirY = linearConversion [0,_szY,_ym,0.3,-0.3];

		_endPos = (_defPos vectoradd [
			0 + (sin _dirX) * (_rad),
			0,
			_dirY
		]);
		_w setvariable ["_mouseMovingCamPos",_endPos];
		
	}];

	addWidToList(_pic);
	_list setvariable ["pic",_pic];

	_text = [getDisplay,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	_text setBackgroundColor [0,0,0,1];
	_text ctrlEnable false; //fix for mouseenter rtt-picture
	_text setFade 0;
	_text commit 0;
	_list setvariable ["text",_text];

	_onTreeSelChanged = {
		params ["_list", "_selectedPath"];
		(parseSimpleArray (_list tvData _selectedPath)) params ["_config","_optionName",["_optData",""]];
		traceformat("changed cat %1; cfg:%2; opt:%3; optData:%4",_selectedPath arg _config arg _optionName arg _optData)
		
		_pic = _list getVariable "pic";
		_text = _list getVariable "text";
		if (!isPiPEnabled) exitwith {
			[_text,"<t color='#ff0000'>Включите PIP (картинка в картинке) в настройках графики Arma 3</t>"] call widgetSetText;
			_text setFade 0;
			_text commit 0;
		};
		if (_optionName == "cat") exitwith {
			[_text,format["Категория: %1",_list tvText _selectedPath]] call widgetSetText;
			_text setFade 0;
			_text commit 0.1;
		};
		if (_optionName == "select") exitwith {
			lobby_glob_dummy_man setFace _config;

			#ifdef SP_MODE
			[format["facecopy: %1",_config]] call chatPrint;
			copyToClipboard _config;
			#endif		
			
			_text setFade 1;
			_text commit 0.2;
			//_optData here is category (white,black,asian etc...)
			{
				_y hideObject (_optData != _x);
				if (_optData == _x) then {
					((lobby_internal_backwallSettings get _x) select 1)
					params ["_color",["_biasPos",[1,0.2,1.7]]];
					private _rttlt = lobby_internal_rttlight;
					private _campos = (lobby_glob_dummy_man modeltoworldvisual (lobby_glob_dummy_man selectionPosition "head"));
					_rttlt setPosAtl (_campos vectoradd _biasPos);
					_rttlt setLightColor _color;
				};
			} foreach lobby_internal_backwallObjects;
		};
		if (_optionName == "rand") exitwith {
			private _newText = if (_config == "") then {
				"Будет случайно выбран один из всех возможных лиц и народностей"
			} else {
				format["Будет случайно выбран %1",
					_optData
				]
			};
			[_text,_newText] call widgetSetText;
			_text setFade 0;
			_text commit 0.1;
		};

		assert(!isNullVar(_optionName));
	};
	

	_list ctrlAddEventHandler ["TreeSelChanged",_onTreeSelChanged];
	setMainWid("currentControl",_list);

	[_list,_defaultIndex] call _onTreeSelChanged;
	_list tvSetCurSel _defaultIndex;

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

decl(void(widget;int))
lobby_onSetFace = {
	onPressParams();
	_faceIndex = tvCurSel getMainWid("currentControl");

	if (_faceIndex isequalto [] || _faceIndex isequalto [-1]) exitWith {
		["Ошибочка. Лицо не то.","error"] call chatPrint;
		call lobby_onCloseSetting;
	};

	_faceData = getMainWid("currentControl") tvData _faceIndex;
	(parseSimpleArray _faceData) params ["_config","_cat"];

	if (_cat == "cat") exitwith {}; //пропускаем если выбрана сама категория

	if (_cat == "rand") then {
		if (_config == "") then {
			_config = _cat;
		} else {
			private _isWomanMode = getCurrentCharData('gender') != 0;
			private _mapSearched = ifcheck(_isWomanMode,faces_map_woman,faces_map_man);
			_config = pick (_mapSearched getOrDefault [_config,_mapSearched get "white"]);
		};
	};

	["face",_config] call lobby_sendToServerSetting;

	call lobby_onCloseSetting;
};

decl(void(widget;string))
lobby_onSetFaceCode = {
	params ["_wid","_val"];

	_text = if (_val == "rand") then {
		"Случайно"
	} else {
		//поиск категории
		private _idx = -1;
		private _isman = null;
		{
			private _arr = _x;
			_idx = _arr findif {_x == _val};
			if (_idx != -1) exitwith {
				_isman = _foreachIndex == 0;
			};
		} foreach [faces_list_man,faces_list_woman];

		if (_idx == -1) exitwith {"НЕИЗВЕСТНО"};

		private _mapSearched = ifcheck(_isman,faces_map_man,faces_map_woman);
		private _foundedText = null;
		{
			_x params ["_cat","_mName","_wName"];
			{
				if (_x == _val) exitwith {
					_foundedText = format["%1 %2",ifcheck(_isman,_mName,_wName),_foreachIndex + 1];
				};
			} foreach (_mapSearched get _cat);
		} foreach face_list_category;
		
		if isNullVar(_foundedText) exitwith {"ОШИБКА"};
		_foundedText
	};

	[_wid,("Лицо: " + _text)] call widgetSetText;
	_wid ctrlSetTooltip _text;
};

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;string))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
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

decl(void(widget;int))
lobby_onSetMainHandCode = {
	params ["_wid","_val"];
	_eval = ["левая","правая"]; _evalsetting = ["Левша","Правша"];
	_txt = format ["Основная рука персонажа - %1",_eval select _val];
	_wid ctrlSetTooltip _txt;
	[_wid,(_evalsetting select _val)] call widgetSetText;
};

//событие при выборе
decl(void(widget;int))
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
decl(void(widget;int))
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
decl(void(int))
lobby_resizingByRoleChanged = {
	private _startingInd = _this;

	_wid = getMainWid("setRole" + str _startingInd);
	private _hNew = _wid call widgetGetTextHeight;
	(_wid call widgetGetPosition) params ["_x","_y","_w"];

	[_wid,[_x,_y,_w,_hNew]] call widgetSetPosition;

};

//Событие при выборе роли
decl(void(widget;int))
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

decl(void(bool))
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

/*
================================================================================
	GROUP: COMMON
================================================================================
*/

decl(void())
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
decl(void(widget;int))
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

decl(void(int))
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
