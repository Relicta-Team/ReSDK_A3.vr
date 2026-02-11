// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

begin_playerSetup_listCamPos = [
	["VR",[3607.64,3989.39,18.2532],81.2089,0.6,[-1.38961,0],0,0,720,0,0,1,0,1],
	["VR",[3606.02,3988.94,17.3531],175.422,0.5,[0.91566,0],0,0,720,0,1,1,0,1],
	["VR",[3604.36,3989.76,18.9532],262.243,0.63,[-25.0356,0],0,0,720,0,1,1,0,1],
	["VR",[3604.28,3993.36,18.2531],0.0480745,0.68,[-22.1169,0],0,0,720,0,0,1,0,1]
];

begin_playerSetup_camPosPreload = ["VR",[3606.74,3989.36,19.0532],90.4817,0.87,[-20.6313,0],0,0,720,0,0,1,0,1];

begin_playerSetup_selectFaceListCamPos = [
	["VR",[3608.32,3989.74,18.6532],88.1785,0.33,[-5.5102,0],0,0,5.55562,0,1,1,0,1],
	["VR",[3605.75,3987.47,18.0531],171.823,0.38,[-10.6603,0],0,0,720,0,1,1,0,1],
	["VR",[3603.21,3990.18,18.6532],262.477,0.37,[-5.08224,0],0,0,720,0,1,1,0,1],
	["VR",[3604.19,3993.77,18.1531],351.172,0.28,[5.56339,0],0,0,720,0,1,1,0,1]
];

begin_playerSetup_preparedNamePos = ["VR",[3606.11,3990.66,17.6511],300.021,0.42,[-31.6697,10.5583],0,0,8.47788e-05,0,1,1,0,1];

begin_playerSetup_startGameCam = ["VR",[3606.11,3990.66,17.6511],285.767,0.11,[-35.3376,10.5583],0,0,8.47788e-05,0,1,1,0,1];

begin_playerSetup_mainStage = 0;
begin_playerSetup_isProgressRotatePlayer = false;

begin_playerSetup_descriptions = [
	"<t size='2.4'>Корняки</t>"+sbr+ sbr+
	"Коренные жители Сети, восточнославянской внешности. "
	+"Гордятся своими традициями, чтят предков. "
	+"Представляют собой ''духовные корни'' мира Сети - могут быть кем угодно: от уборщика до главы города. "
	+"Лояльны и ответственны, сохраняют культуру и память предков.",

	"<t size='2.4'>Вахатцы</t>" + sbr+ sbr +
	"Наследники тюркских и нахских племён, туземцы восточной Сети. "
	+"Известны как искусные торговцы и ремесленники, часто влиятельны в торговых гильдиях. "
	+"Некоторые служат в теневых сферах: наёмные убийцы и владельцы публичных домов. "
	+"Сильная общинная культура, часто исповедуют Аккузат и чтят семейные узы.",

	"<t size='2.4'>Тегинцы</t>" + sbr+ sbr +
	"Полукочевой народ азиатской и монгольской внешности, живущий племенами в пещерах Сети. "
	+"Сильные воины, ценящие силу, преданность и традиции. "
	+"Создают обереги, почитают духов и следуют законам крови. "
	+"Некоторые из них становятся Истязателями — жестокими рабовладельцами и палачами.",

	"<t size='2.4'>Углярцы</t>" + sbr+ sbr +
	"Темнокожий народ, в прошлом порабощённый, ныне борющийся за выживание. "
	+"Обладают хорошей выносливостью и физической силой, часто работают в шахтах и на каторге. "
	+"Свободные углярцы - Трудокожие, как они сами себя называют, живут в теневых кругах и держатся вместе. "
	+"Несмотря на тяжелую судьбу, они создали уникальную культуру со своими особыми обычаями и жаргоном."
];

begin_playerSetup_curIndex = 0;
begin_playerSetupObjects = [];

begin_playerSetup_getCurMob = {
	begin_playerSetupObjects select begin_playerSetup_curIndex
};

begin_playerSetup_syncCamPos = {
	private _mob = call begin_playerSetup_getCurMob;
	_interpTime = 1.3;
	private _campos = begin_playerSetup_listCamPos select begin_playerSetup_curIndex;
	if (begin_playerSetup_mainStage == 1) then {
		_interpTime = 0.9;
		_campos = begin_playerSetup_selectFaceListCamPos select begin_playerSetup_curIndex;
	};
	if (begin_playerSetup_mainStage == 2) then {
		_campos = begin_playerSetup_preparedNamePos;
	};

	call sp_cam_stopAllInterp;
	["all",_campos,_interpTime] call sp_cam_interpTo;

	_tleft = begin_playerSetup_widgets select 0;
	_desc = begin_playerSetup_descriptions select begin_playerSetup_curIndex;

	[_tleft,format["<t align='left' size='2'>%2%2%2%2%1</t>",_desc,sbr]] call widgetSetText;
};
begin_playerSetup_isLoading = true;
begin_playerSetup_syncUIRender = {
	{
		if (begin_playerSetup_mainStage == _foreachIndex) then {
			_x ctrlEnable true;
			_x setFade 0;
			_x commit ifcheck(begin_playerSetup_isLoading,0,0.5);
		} else {
			_x ctrlEnable false;
			_x setFade 1;
			_x commit ifcheck(begin_playerSetup_isLoading,0,0.2);
		};
	} foreach begin_playerSetup_zones;

	_beginTextList = ["Выберите народность","Выберите лицо","Укажите имя"];
	[_beginTextList select begin_playerSetup_mainStage] call begin_playerSetup_setHeaderText;

	_list = begin_playerSetup_widgets select 2;
	lbclear _list;
	_mob = call begin_playerSetup_getCurMob;
	_f = face _mob;
	_curi = -1;
	{
		_i = _list lbAdd (format["Лицо %1",_foreachIndex+1]);
		_list lbSetData [_i,_x];
		if (_x == _f) then {_curi = _foreachIndex}
	} foreach (_mob getvariable "faces");
	if (_curi != -1) then {
		_list lbSetCurSel _curi;
	} else {
		errorformat("Invalid face for mob: %1",_f);
		_list lbSetCurSel 0;
		_mob setFace (_mob getvariable "faces" select 0);
	};
};

begin_playerSetup_widgets = [widgetNull,widgetNull];
begin_playerSetup_zones = [];

begin_playerSetup_setHeaderText = {
	params ["_txt"];
	[(begin_playerSetup_widgets select 1),format["<t align='center' size='1.5'>%1</t>",_txt]] call widgetSetText;
};

begin_playerSetup_checkName = {
	params ["_txtFirstNameInput","_txtLastNameInput","_startplay"];
	forceunicode 0;
	private _canPlay = true;
	{
		if (count ctrltext _x > 32) exitWith {_canPlay = false};
		if (_foreachindex == 0 && count ctrltext _x <= 2) exitWith {_canPlay = false};
		if (!([ctrltext _x,"^[А-Яа-я]+$"] call regex_isMatch)) exitWith {_canPlay = false};
	} foreach [_txtFirstNameInput,_txtLastNameInput];

	_startplay ctrlEnable _canPlay;
	if (_canPlay) then {
		widgetSetFade(_startplay,0,0.2);
	} else {
		widgetSetFade(_startplay,1,0.2);
	};
};

["begin_playerSetup",{
	
	_gui = getGUI;
	_blackgui = [_gui,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_blackgui setBackgroundColor [0,0,0,1];

	private _cur = "white";
	private _listPoses = [];
	private _listNames = [];
	private _listFaces = [];
	private _anims = [
		"Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop",
		"Acts_CivilIdle_1",
		"Acts_Commenting_On_Fight_loop",
		"Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop"
	];
	{
		_x params ["_t","_n"];
		_posname = "begin_pos_player" + _t;
		_mobname = "begin_playersel"+_t;
		_listPoses pushback _posname;
		_listNames pushback _mobname;
		_listFaces pushBack (faces_map_man get _t);

		[_posname,_mobname,[
			["uniform",[
				"CaretakerCloth",
				"TorgashPalthCloth",
				"NomadCloth9",
				"GriblanCloth"
			] select _foreachindex]
		],{},{

			_this setvariable ["faces",faces_map_man get _t];
			_this setFace (faces_map_man get _t select 0);
			_this setvariable ["name",_n];

			_this setvariable ["posname",_posname];
			_this setvariable ["mobname",_mobname];

			_this switchMove (_anims select _foreachIndex);
			_this setvariable ["defanim",(_anims select _foreachIndex)];

			begin_playerSetupObjects pushback _this;
			//_this switchMove "passenger_flatground_2_Idle_Unarmed";
		}] call sp_ai_createPersonEx;
	} foreach face_list_category;

	[""] call sp_view_setPlayerHudVisible;
	[true,0] call setBlackScreenGUI;
	[_listPoses select 0,0] call sp_setPlayerPos;
	
	[true] call sp_cam_setCinematicCam;

	_dpos = array_copy(begin_playerSetup_listCamPos select 0);
	_dpos select 1 set [2,1000];
	_dpos call sp_cam_prepCamera;

	_d = call displayOpen;

	_tcenter = [_d,TEXT,[0,0,100,5]] call createWidget;
	_tcenter setBackgroundColor [0.1,0.1,0.1,0.5];
	begin_playerSetup_widgets set [1,_tcenter];
	[_tcenter,"Выберите народность"] call widgetSetText;


	_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	begin_playerSetup_zones set [0,_ctg];

	_sizeLeftY = 60;
	_tleft = [_d,TEXT,[0,50-_sizeLeftY/2,50,_sizeLeftY],_ctg] call createWidget;
	begin_playerSetup_widgets set [0,_tleft];
	[_tleft,"Загрузка описания..."] call widgetSetText;
	_tleft setBackgroundColor [0.1,0.1,0.1,0.5];

	_zX = 10;
	_xOffsetCenter = 7;

	_prev = [_d,TEXT,[50-_zX-_xOffsetCenter,90,_zX,8],_ctg] call createWidget;
	_prev setvariable ["val",-1];
	[_prev,"<t align='center' valign='middle' size='1.4'>"+sbr+"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa'/>"+"</t>"] call widgetSetText;

	_next = [_d,TEXT,[50+_xOffsetCenter,90,_zX,8],_ctg] call createWidget;
	_next setvariable ["val",+1];
	[_next,"<t align='center' valign='middle' size='1.4'>"+sbr+"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa'/>"+"</t>"] call widgetSetText;

	_select = [_d,TEXT,[50-_xOffsetCenter + 1,90,_xOffsetCenter*2 - 2,8],_ctg] call createWidget;
	[_select,"<t align='center' valign='middle' size='1.4'>"+sbr+"Выбрать"+"</t>"] call widgetSetText;
	_btstart = [_prev,_next,_select];
	{_x ctrlenable false} foreach _btstart;

	_select ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		INC(begin_playerSetup_mainStage);
		begin_playerSetup_isProgressRotatePlayer = true;
		_mob = call begin_playerSetup_getCurMob;
		
		call begin_playerSetup_syncCamPos;
		call begin_playerSetup_syncUIRender;
		
		startAsyncInvoke
		{
			params ["_t1","_t2","_dir","_pos"];
			_mob = call begin_playerSetup_getCurMob;
			
			if (animationState _mob != "amovpercmstpsnonwnondnon_turnr") then {
				_mob switchmove ["amovpercmstpsnonwnondnon_turnr",0.5,1,false];
			};

			_ndir = linearConversion [_t1,_t2,tickTime,_dir,_dir+180,true];
			_mob setDir _ndir;
			tickTime >= _t2
		},
		{
			begin_playerSetup_isProgressRotatePlayer = false;
			(call begin_playerSetup_getCurMob) switchmove "";
		},
		[tickTime,tickTime + 0.9,getdir _mob]
		endAsyncInvoke
	}];

	//stage 2
	_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	begin_playerSetup_zones set [1,_ctg];

	_back = [_d,TEXT,[50-_zX-_xOffsetCenter,90,_zX,8],_ctg] call createWidget;
	[_back,"<t align='center' valign='middle' size='1.4'>"+sbr+"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa'/>"+"</t>"] call widgetSetText;
	_toname = [_d,TEXT,[50-_xOffsetCenter + 1,90,_xOffsetCenter*2 - 2,8],_ctg] call createWidget;
	[_toname,"<t align='center' valign='middle' size='1.4'>"+sbr+"Выбрать"+"</t>"] call widgetSetText;
	_toname ctrladdeventhandler ["MouseButtonUp",{
		INC(begin_playerSetup_mainStage);
		call begin_playerSetup_syncCamPos;
		call begin_playerSetup_syncUIRender;
	}];
	_back ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		if (begin_playerSetup_isProgressRotatePlayer) exitWith {};

		DEC(begin_playerSetup_mainStage);
		begin_playerSetup_isProgressRotatePlayer = true;
		_mob = call begin_playerSetup_getCurMob;
		
		call begin_playerSetup_syncCamPos;
		call begin_playerSetup_syncUIRender;
		
		startAsyncInvoke
		{
			params ["_t1","_t2","_dir","_pos"];
			_mob = call begin_playerSetup_getCurMob;
			
			if (animationState _mob != "amovpercmstpsnonwnondnon_turnr") then {
				_mob switchmove ["amovpercmstpsnonwnondnon_turnr",0.5,1,false];
			};

			_ndir = linearConversion [_t1,_t2,tickTime,_dir,_dir+180,true];
			_mob setDir _ndir;
			tickTime >= _t2
		},
		{
			begin_playerSetup_isProgressRotatePlayer = false;
			(call begin_playerSetup_getCurMob) switchmove (call begin_playerSetup_getCurMob getvariable "defanim");
		},
		[tickTime,tickTime + 0.7,getdir _mob]
		endAsyncInvoke
	}];

	_list = [_d,LISTBOX,[0,50-_sizeLeftY/2,50,_sizeLeftY],_ctg] call createWidget;
	begin_playerSetup_widgets set [2,_list];
	_list ctrladdeventhandler ["LBSelChanged",{
		params ["_list","_selectedIndex"];
		if (_selectedIndex == -1) exitWith {};
		_face = _list lbData _selectedIndex;
		(call begin_playerSetup_getCurMob) setFace _face;
	}];

	//stage 3
	_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	begin_playerSetup_zones set [2,_ctg];

	_backtoface = [_d,TEXT,[50-_zX-_xOffsetCenter,90,_zX,8],_ctg] call createWidget;
	[_backtoface,"<t align='center' valign='middle' size='1.4'>"+sbr+"<img image='a3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa'/>"+"</t>"] call widgetSetText;
	_startplay = [_d,TEXT,[50-_xOffsetCenter + 1,90,_xOffsetCenter*2 - 2,8],_ctg] call createWidget;
	[_startplay,"<t align='center' valign='middle' size='1.4'>"+sbr+"Начать игру"+"</t>"] call widgetSetText;
	_startplay ctrladdeventhandler ["MouseButtonUp",{
		params ["_b"];

		_txtWidNames = _b getvariable "txtWidNames";
		_fn = ctrltext (_txtWidNames select 0);
		_ln = ctrltext (_txtWidNames select 1);
		callFuncParams(call sp_getActor,generateNaming, capitalize(_fn) arg capitalize(_ln));
		private _face = face (call begin_playerSetup_getCurMob);
		callFuncParams(call sp_getActor,setMobFace,_face);

		[call sp_getActor,[capitalize(_fn),capitalize(_ln),_face]] call sp_saveCharacterData;

		nextFrame(displayClose);
		call sp_cam_stopAllInterp;
		[true,4] call setBlackScreenGUI;
		["all",begin_playerSetup_startGameCam,10] call sp_cam_interpTo;
		[true,true] call sp_audio_setMusicPause;
		_post = {
			[] call sp_audio_stopMusic;
			[!true,true] call sp_audio_setMusicPause;
			["begin_prestart"] call sp_startScene;
		};
		invokeAfterDelay(_post,8);
		["begin\prestart_ready"] call sp_audio_sayPlayer;
	}];
	_backtoface ctrladdeventhandler ["MouseButtonUp",{
		DEC(begin_playerSetup_mainStage);
		call begin_playerSetup_syncCamPos;
		call begin_playerSetup_syncUIRender;
	}];
	_yps = 60;
	_rnd = [_d,TEXT,[30,_yps,10+20,8],_ctg] call createWidget;
	[_rnd,"<t align='center' valign='middle' size='1.4'>"+sbr+"Случайно</t>"] call widgetSetText;
	_rnd ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		(_b getvariable "nameWidgets") params ["_txtFirstNameInput","_txtLastNameInput"];
		_txtFirstNameInput ctrlsettext (pick naming_list_ManFirstName);
		_txtLastNameInput ctrlsettext (pick naming_list_ManSecondName);
	}];

	_txtFirstName = [_d,TEXT,[30,_yps+10,10,8],_ctg] call createWidget;
	[_txtFirstName,sbr+"<t size='1.3'>Имя:</t>"] call widgetSetText;
	_txtFirstNameInput = [_d,INPUT,[40,_yps+10,20,8],_ctg] call createWidget;
	_txtLastName = [_d,TEXT,[30,_yps+20,10,8],_ctg] call createWidget;
	[_txtLastName,sbr+"<t size='1.3'>Фамилия:</t>"] call widgetSetText;
	_txtLastNameInput = [_d,INPUT,[40,_yps+20,20,8],_ctg] call createWidget;

	_txtFirstNameInput ctrlsettext (pick naming_list_ManFirstName);
	_txtLastNameInput ctrlsettext (pick naming_list_ManSecondName);
	_rnd setvariable ["nameWidgets",[_txtFirstNameInput,_txtLastNameInput]];
	_startplay setvariable ["txtWidNames",[_txtFirstNameInput,_txtLastNameInput]];

	{
		_x setBackgroundColor [0.1,0.1,0.1,0.5];
	} foreach [_txtFirstName,_txtLastName,_rnd];
	{
		_x ctrlsetfontHeight 0.1;
	} foreach [_txtFirstNameInput,_txtLastNameInput];

	//todo text validation
	private _adata = [_txtFirstNameInput,_txtLastNameInput,_startplay];
	{
		_x setvariable ["adata",_adata];
		_x ctrladdeventhandler ["KeyUp",{
			params ["_b"];
			(_b getvariable "adata") call begin_playerSetup_checkName;
		}];
	} foreach [_txtFirstNameInput,_txtLastNameInput];

	call begin_playerSetup_syncCamPos;
	call begin_playerSetup_syncUIRender;
	_adata call begin_playerSetup_checkName;

	{
		_x setBackgroundColor [0.1,0.1,0.1,0.5];
		_x ctrladdeventhandler ["MouseEnter",{
			params ["_b"];
			_b setBackgroundColor [0.2,0.2,0.2,0.5];
		}];
		_x ctrladdeventhandler ["MouseExit",{
			params ["_b"];
			_b setBackgroundColor [0.1,0.1,0.1,0.5];
		}];

		if (_foreachIndex <= 1) then {
			_x ctrladdeventhandler ["MouseButtonUp",{
				params ["_b"];
				if (begin_playerSetup_isProgressRotatePlayer) exitWith {};
				_val = _b getvariable ["val",0];
				begin_playerSetup_curIndex = begin_playerSetup_curIndex + _val;

				if (begin_playerSetup_curIndex < 0) then {
					begin_playerSetup_curIndex = (count begin_playerSetup_listCamPos) - 1;
				};
				if (begin_playerSetup_curIndex > ((count begin_playerSetup_listCamPos) - 1)) then {
					begin_playerSetup_curIndex = 0;
				};

				call begin_playerSetup_syncCamPos;
			}];
		};
		
	} foreach [_prev,_next,_back,_toname,_backtoface,_startplay,_select,_rnd];

	
	widgetSetFade(begin_playerSetup_zones select 0,1,0);
	widgetSetFade(begin_playerSetup_widgets select 1,1,0);
	[_blackgui,true] call deleteWidget;
	begin_playerSetup_isLoading = false;
	begin_playerSetup_list_buttons = _btstart;
	
	
	{
		"begin_playerselwhite" call sp_ai_waitForMobLoaded;
		{
			_x setFace (_x getvariable "faces" select 0);
		} foreach begin_playerSetupObjects;	
		begin_playerSetup_camPosPreload call sp_cam_prepCamera;
		0.1 call sp_threadPause;
		["prestart",true] call sp_audio_playMusic;
		["all",begin_playerSetup_listCamPos select 0,6] call sp_cam_interpTo;
		[false,4] call sp_gui_setBlackScreenGUI;

		{
			{_x ctrlenable true} foreach begin_playerSetup_list_buttons;
			widgetSetFade(begin_playerSetup_zones select 0,0,1.4);
			widgetSetFade(begin_playerSetup_widgets select 1,0,1.4);
		} call sp_threadCriticalSection;
	} call sp_threadStart;

}] call sp_addScene;