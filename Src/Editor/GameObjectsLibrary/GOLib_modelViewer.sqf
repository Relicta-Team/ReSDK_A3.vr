// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(golib_mv_modelSetPos)
{
	golib_mv_model setPosAtl (golib_mv_observ_centerPos vectorAdd _this)
}

function(golib_mv_loadModel)
{
	if !isNullReference(golib_mv_model) then {
		deleteVehicle golib_mv_model;
	};
	golib_mv_model = createSimpleObject [_this,[0,0,0]];
	[0,0,0] call golib_mv_modelSetPos;
	[golib_mv_model,[0,0,0]] call core_SetPitchBankYaw;
	
	call golib_mv_setCamera;
	
	nextFrame(golib_mv_observ_checkGeom);
}

//DEPRECATED
function(golib_mv_setOrient)
{
	golib_mv_model setVectorDirAndUp _this
}

function(golib_mv_setCamera)
{
	(boundingBoxReal golib_mv_model) params ["_bb1","_bb2","_size"];
	private _cam = golib_mv_camera;
	_cam camSetPos (golib_mv_model modelToWorldVisual [0,-_size*3,_size]);
	//_cam campreparepos (golib_mv_model modelToWorld [0,-0,0]);
	_cam campreparetarget (golib_mv_model modelToWorld [-_size,0,(_bb1 select 2)/2]);
	_cam campreparefocus [-1,-1];
	_cam campreparefov 0.7;
	_cam camcommitprepared 0;
}

function(golib_mv_setCameraDist)
{
	private _cam = golib_mv_camera;
	(boundingBoxReal golib_mv_model) params ["_bb1","_bb2","_size"];
	_newSize = linearConversion [0,5,_this,0.05,_size * 3];
	_newSizeZ = linearConversion [0,5,_this,_size,0.05];
	_cam camSetPos (golib_mv_model modelToWorldVisual [0,-_size*3,_newSizeZ]);
	//(
	//_cam campreparetarget (golib_mv_model modelToWorld [-_size,0,(_bb1 select 2)/2]);
	_cam camcommitprepared 0.2;
}

function(golib_mv_observ_checkGeom)
{
	_catched = 0;
	
	
	//Проверка для ебланов
	//(boundingBoxReal golib_mv_model) params ["_b1","_b2","_sz"];
	/*{
		([golib_mv_model modelToWorldVisual _x,golib_mv_camera,objNUll,getPosATL golib_mv_camera] call golib_om_getRayCastData) params ["_obj","_atlPos"];
		if !isNullReference(_obj) exitWith {
			INC(_catched)
		};
		//["raycast targ %1",_obj] call printTrace;
	} foreach ([
		[0,0,0],
		_b1,
		_b2,
		[0,0,_sz*2],
		[0,_sz*2,0],
		[_sz*2,0,0],
		
		[0,0,-_sz*2],
		[0,-_sz*2,0],
		[-_sz*2,0,0]
	] + _otherPoints);*/
	
	//проверка для крутых
	_catched = (allLods golib_mv_model)findif {_x select 1 == "geometry"};
	
	_wid = golib_mv_observ_widget_noGeom select 0;
	_wid ctrlShow (_catched == -1);
	golib_mv_observ_hasGeom = (_catched != -1);
}

//функция выбора модели. данный дисплей возможно использовать во многих элементах
//например как в выборе модели, создателе игрового объекта и тд...
//Парамтер _eventOnPressElement принимает в себя переменную _value равную путю до модели
function(golib_openModelViewer)
{
	params ["_eventOnPressElement",["_eventOnExit",{}]];
	
	_d = [[],[]] call displayOpen;
	
	_cam = "camera" camcreate [0,0,0];
	_cam setPosAtl golib_mv_observ_centerPos;
	_cam cameraeffect ["internal","back"];
	_cam campreparefocus [-1,-1];
	_cam campreparefov 0.4;
	_cam camcommitprepared 0;
	_cam setVariable ["iscamera",true];
	golib_mv_camera = _cam;
	showcinemaborder false;

	_sphereGround = createvehicle ["Sphere_3DEN",[0,0,0],[],0,"none"];
	_sphereNoGround = createvehicle ["SphereNoGround_3DEN",[0,0,0],[],0,"none"];
	_sphereGround setPosAtl (golib_mv_observ_centerPos vectorAdd [0,0,-30]);
	_sphereNoGround setPosAtl golib_mv_observ_centerPos;
	
	golib_mv_list_observObjects pushBack _cam;
	golib_mv_list_observObjects pushBack _sphereGround;
	golib_mv_list_observObjects pushBack _sphereNoGround;
	
	_sphereColor = "#(argb,8,8,3)color(1,1,1,0.3)";
	{
		_x setobjecttexture [0,_sphereColor];
		_x setobjecttexture [1,_sphereColor];
	} forEach [_sphereGround,_sphereNoGround];
	
	_display = [] call bis_fnc_displayMission;
	if (is3DEN) then {
		_display = finddisplay 313;
		["showinterface",false] call bis_fnc_3DENInterface;
		
		golib_mv_observ_stateLeftPanel = inspector_isexpanded;
		golib_mv_observ_stateRightPanel = golib_vis_isexpanded;
		
		[false,true] call inspector_onChangeLeftPanelState;
		[false,true] call golib_vis_onChangeRightPanelState;
		(menu_internal_widget_refButtonObjLib select 0) ctrlShow false;
		_asCtg = call golib_getArraySelectorCtg;
		if !isNullReference(_asCtg) then {
			_asCtg ctrlShow false;
		};
	};
	
	_closeGenericEvent = {
		if (is3DEN) then {			
			get3dencamera cameraeffect ["internal","back"];
			["showinterface",true] call bis_fnc_3DENInterface;
			(menu_internal_widget_refButtonObjLib select 0) ctrlShow true;
			
			//[] call BIS_fnc_camera_edenReset;
			
			{deleteVehicle _x} foreach golib_mv_list_observObjects;
			deleteVehicle golib_mv_model;
			golib_mv_list_observObjects = [];
			
			[golib_mv_observ_stateLeftPanel] call inspector_onChangeLeftPanelState;
			[golib_mv_observ_stateRightPanel] call golib_vis_onChangeRightPanelState;

			_asCtg = call golib_getArraySelectorCtg;
			if !isNullReference(_asCtg) then {
				_asCtg ctrlShow true;
			};
		};
	};
	
	// main code
	
	//главный дизайн
	_mH = 80;
	_mW = 70;
	//_ctg = [_d,WIDGETGROUP,[50-_mW/2,50-_mH/2,_mW,_mH]] call createWidget;
	_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	_back = [_d,BACKGROUND,[0,0,50,100],_ctg] call createWidget;
	_back setBackgroundColor [0.5,.5,.5,.8];
	
	_ngo = [_d,TEXT,[50,0,50,5],_ctg] call createWidget;
	_ngo ctrlSetBackgroundColor [1,0,0,1];
	golib_mv_observ_widget_noGeom set [0,_ngo];
	[_ngo,"<t align='center'>НЕ ОБНАРУЖЕНА ГЕОМЕТРИЯ</t>"] call widgetSetText;
	
	
	_zoneDrag = [_d,TEXT,[50,0,50,100],_ctg] call createWidget;
	_zoneDrag ctrlSetTooltip "Тяните мышку чтобы вращать объект";
	_zoneDrag setVariable ["_curPos",0.7];
	_zoneDrag ctrlAddEventHandler ["MouseButtonDown",{
		params ["_wid","_key","_posX","_posY"];
		_model = golib_mv_model;
		_model setVariable ["_ispressed",true];
		_model setVariable ["_origpos",_model call core_getPitchBankYaw];
	}];
	_zoneDrag ctrlAddEventHandler ["MouseButtonUp",{
		_wid = _this select 0;
		_model = golib_mv_model;
		_model setVariable ["_ispressed",false];
		_model setVariable ["_origpos",_model call core_getPitchBankYaw];
	}];
	_zoneDrag ctrlAddEventHandler ["MouseMoving",{
		params ["_wid","_posX", "_posY"];
		_model = golib_mv_model;
		if (_model getVariable ["_ispressed",false]) then {
			_oldX = _model getVariable ["_xpos",0];
			_oldY = _model getVariable ["_ypos",0];
			_oldX =  + (_posX * 500);
			_oldY =  + (_posY * 500);
			[_model,[0,_oldY,-_oldX]] call core_SetPitchBankYaw;
			
			_model setVariable ["_xpos",_oldX];
			_model setVariable ["_ypos",_oldY];
		};
	}];
	_zoneDrag ctrlAddEventHandler ["MouseZChanged",{
		params ["_zoneDrag","_val"];
		_val = _val / 0.1;
		_pos = _zoneDrag getVariable ["_curPos",0.7];
		//["val %1, pos %2",_val,_pos] call printTrace;
		//_model = _zoneDrag getVariable "_model";
		_pos = _pos + _val;
		_zoneDrag setVariable ["_curPos",_pos];
		// _pos call golib_mv_setCameraDist; //сломано нахуй
		///_model ctrlSetPosition [1, _pos, 0.5];
	}];
	
	_szInput = 50-3*2;
	
	_button = [_d,BUTTON,[3,1,_szInput/2/2,8],_ctg] call createWidget;
	_button ctrlSetText "Выбрать";
	_button ctrlSetTooltip "Выбрать модель и закрыть окно";
	_button setVariable ["eventResetCamera",_closeGenericEvent];
	_button ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		_lb = _b getVariable "_lb";
		_val = lbCurSel _lb;
		if (_val == -1) exitWith {
			["Не выбран элемент списка"] call showWarning;
		};
		
		_event = _b getVariable ["_evOnSel",{}];
		_valData = _lb lbData _val;
		["Selected model: %1",_valData] call printTrace;
		nextFrame(displayClose);
		nextFrameParams({params ["_value" arg "_hasGeometry" arg "___event"]; _value call ___event },vec3(_valData,golib_mv_observ_hasGeom,_event));
		
		call (_b getVariable "eventResetCamera");
	}];
	
	_buttonAppl = [_d,BUTTON,[3+_szInput/2/2+(_szInput/2/2/2),1,_szInput/2/2/2,8],_ctg] call createWidget;
	_buttonAppl ctrlSetText ("Применить");
	_buttonAppl ctrlSetTooltip "Применить фильтр";
	_buttonAppl ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		_search = _b getVariable "_search";
		[_search] call (_search getVariable "_kfSearch");	
	}];
	//_buttonAppl ctrlSetFontHeight 0.035;
	
	_close = [_d,BUTTON,[47,0,3,3],_ctg] call createWidget;
	_close ctrlSetBackgroundColor [1,0,0,1];
	_close ctrlSetText "X";
	_close ctrlSetTooltip "Закрыть окно";
	_close setVariable ["evOnClose",_eventOnExit];
	_close setVariable ["eventResetCamera",_closeGenericEvent];
	_close ctrlAddEventHandler ["MouseButtonUp",{
		_w = (_this select 0);
		
		nextFrame(_w getVariable vec2("evOnClose",{}));
		nextFrame(displayClose);
		
		call (_w getVariable "eventResetCamera");
	}];
	
	_search = [_d,INPUT,[3+(_szInput/2),1,_szInput/2,8],_ctg] call createWidget;
	_search ctrlSetTooltip 	(	"Доступные фильтры поиска:\n\n"+
			"[name] - поиск по имени конфига или его части\n"+
			"radius[< | > | <= | >=]:[value] - посик по радиусу boundingBox-а модели в метрах\n"+
			"path:[name] - поиск по части пути\n"+
			"\n\nРежимы могут быть скомбинированы через точку с запятой: Пример: radius<=:3.5;path:relicta_models\weapons\"
	);
	_kfSearch = {
	
		params ["_search"];
		_text = ctrlText _search;
		_lb = _search getVariable "_lb";
		_condArr = [];
		
		{
			call {
				if ("radius>:" in _x || "radius<:" in _x || "radius>=" in _x || "radius<=" in _x) exitWith {
					(_x splitString ":") params ["_radiusText","_valText"];
					
					_condArr pushBack (format["(((core_modelBBX get _x) select 2) %1 %2)",_radiusText select [6,2],_valText]);
				};
				if ("path:" in _x) exitWith {
					_path = tolower ((_x splitString ":") select 1);
					_condArr pushBack (format["('%1' in _x)",_path]);
				};
				_condArr pushBack (format["(if(_isListCfg)then {(_m findif {'%1' in _x})!=-1} else {'%1' in _m})",_x]);
			};
		} foreach (_text splitString ";");
		_code = compile (_condArr joinString " && ");
		
		if (count _condArr == 0) then {
			_code = {true};
		};
		
		["model searcher checking code: %1",_code] call printTrace;
		[_code] call (_lb getVariable "loadList");
		
	
	};
	//_search ctrlAddEventHandler ["KillFocus",_kfSearch];
	_search setVariable ["_kfSearch",_kfSearch];
	
	//create list
	_lb = [_d,LISTBOX,[3,10,50-3*2,100-10],_ctg] call createWidget;
	_lb setVariable ["_model",_model];
	_search setVariable ["_lb",_lb];
	_buttonAppl setVariable ["_search",_search];
	_button setVariable ["_lb",_lb];
	_button setVariable ["_evOnSel",_eventOnPressElement];
	_button setVariable ["_model",_model];
	
	_lb ctrlAddEventHandler ["LBSelChanged",{
		params ["_wid","_idx"];
		if (_idx == -1) exitWith {};
		_modelPath = _wid lbData _idx;
		_dummy = createSimpleObject [_modelPath,[0,0,0]];
		if isNullReference(_dummy) exitWith {
			["Cannot load model " + _modelPath] call showWarning;
		};
		
		//diag_log text format["[Reditor]: (Model loader)		try load model %1",_modelPath];
		
		_modelPath call golib_mv_loadModel;
		
		_zoneDrag = _wid getVariable "_zoneDrag";
		_zoneDrag setVariable ["_curPos",0.7];
	}];
	
	_lb setVariable ["_back",_back];
	_lb ctrlAddEventHandler ["KeyUp",{
		params ["_lb","_key","_shift","_ctrl","_alt"];
		if (_key == KEY_C && _ctrl) then {
			_idx = lbCurSel _lb;
			if (_idx == -1) exitWith {};
			_back = _lb getVariable "_back";
			_back setBackgroundColor [0.5,1,.5,.8];
			_code = {if !isNullReference(_this) then {_this setBackgroundColor [0.5,.5,.5,.8]}};
			invokeAfterDelayParams(_code,0.3,_back);
			copyToClipboarD (_lb lbData _idx);
			["Value copied to clipboard: %1",_lb lbData _idx] call printLog;
		};
	}];
	
	_lb setVariable ["_zoneDrag",_zoneDrag];
	
	//вот тут впихиваем алгоритм перерасчета и оборачиваем в локальную функцию
	_lb setVariable ["loadList",{
		lbClear _lb;
		
		params ["_conditions"];
		{
			_m = (core_model2cfg getVariable _x);
			_isListCfg = equalTypes(_m,[]);
			if (call _conditions) then {
				_item = _lb lbAdd ifcheck(_isListCfg,format vec3("%2 (%1 configs)",count _m,_m select 0),_m);
				_lb lbSetData [_item,_x]; //в дате модель
				if (_isListCfg) then {
					//["%1",_x] call printTrace;
					_lb lbSetTooltip [_item,_x + "\n\nConfigs:\n" + (_m joinString "\n")];
				} else {
					_lb lbSetTooltip [_item,_x];
				};
			};
			
		} foreach (allVariables core_model2cfg);
		
		if (lbSize _lb > 0) then {
			_lb lbSetCurSel 0;
		};
	}];
	[{true}] call (_lb getVariable "loadList");
	
}

function(golib_modelViewerContextOpen)
{
	[{
		private _infoList = [];
		private _info = "Model: " + str _value;
		_infoList pushBack _info;

		_cfg = core_model2cfg getVariable _value;

		if equalTypes(_cfg,[]) then {
			_cfgText = "Finded "+str (count _cfg)+ " configs:";
			_infoList pushBack ""; _infoList pushBack "";
			_infoList pushBack ("Finded "+str (count _cfg)+ " configs");

			{
				private _listElement = "Config ("+str(1+_foreachIndex)+"): " + str _x;
				_cfgText = _cfgText + endl + "    Config ("+str(1+_foreachIndex)+"): " + str _x;
				if !(_x call config_isEditorVisible) exitWith {
					modvar(_cfgText) + " (NOT VISIBLE IN EDITOR)";
					modvar(_listElement) + " (NOT VISIBLE IN EDITOR)";
				};

				_infoList pushBack _listElement;
			} foreach _cfg;

			modvar(_info) + endl + _cfgText;
		} else {
			_cfgText = "Config: " + str _cfg;
			if !(_cfg call config_isEditorVisible) exitWith {
				modvar(_cfgText) + " (NOT VISIBLE IN EDITOR)";
			};
			_infoList pushBack _cfgText;

			modvar(_info) + endl + _cfgText;
		};

		["Информация о выбранной модели и найденных конфигах также помещена в буфер обмена",10] call showInfo;
		copyToClipboarD _info;

		[
			_infoList,
			{},
			{},
			null,
			"Отчет о модели"
		] call control_createList;
	},{}] call golib_openModelViewer;
}
