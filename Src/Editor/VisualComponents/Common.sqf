// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(vcom_openWindow)
{	
	params ["_windType"];
	
	private _d = [[],vcom_event_onCloseGenericEvent] call displayOpen;
	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	
	vcom_mainDisplay set [0,_d];
	vcom_widgets set [0,_ctg];
	
	vcom_windowMode = _windType;
	vcom_visual_canDrawLines = true; //reset to default
	vcom_visual_renderDebugGeometry = false; //reset to default

	_sphereGround = createvehicle ["Sphere_3DEN",[0,0,0],[],0,"none"];
	_sphereNoGround = createvehicle ["SphereNoGround_3DEN",[0,0,0],[],0,"none"];
	_sphereGround setPosAtl (vcom_observ_centerPos vectorAdd [0,0,-30]);
	_sphereNoGround setPosAtl vcom_observ_centerPos;
	
	
	vcom_observedObjects pushBack _sphereGround;
	vcom_observedObjects pushBack _sphereNoGround;
	
	_sphereColor = "#(argb,8,8,3)color(1,1,1,0.3)";
	{
		_x setobjecttexture [0,_sphereColor];
		_x setobjecttexture [1,_sphereColor];
	} forEach [_sphereGround,_sphereNoGround];
	
	_display = [] call bis_fnc_displayMission;
	if (is3DEN) then {
		_display = finddisplay 313;
		["showinterface",false] call bis_fnc_3DENInterface;
		
		vcom_observ_stateLeftPanel = inspector_isexpanded;
		vcom_observ_stateRightPanel = golib_vis_isexpanded;
		
		[false,true] call inspector_onChangeLeftPanelState;
		[false,true] call golib_vis_onChangeRightPanelState;
		(menu_internal_widget_refButtonObjLib select 0) ctrlShow false;
		
		//hide array selector
		_asCtg = call golib_getArraySelectorCtg;
		if !isNullReference(_asCtg) then {
			_asCtg ctrlShow false;
		};
	};
}

function(vcom_getDisplay) {vcom_mainDisplay select 0}
function(vcom_getCtg) {vcom_widgets select 0}

function(vcom_event_onCloseGenericEvent)
{
	removemissioneventhandler ["draw3D",vcom_handler_draw3D];
	vcom_handler_draw3D = -1;

	setviewdistance -1;

	{deleteVehicle _x} foreach vcom_observedObjects;
	deleteVehicle vcom_visualObject;
	vcom_observedObjects = [];

	if (is3DEN) then {

		get3dencamera cameraeffect ["internal","back"];
		["showinterface",true] call bis_fnc_3DENInterface;
		(menu_internal_widget_refButtonObjLib select 0) ctrlShow true;
		
		//[] call BIS_fnc_camera_edenReset;
		
		[vcom_observ_stateLeftPanel] call inspector_onChangeLeftPanelState;
		[vcom_observ_stateRightPanel] call golib_vis_onChangeRightPanelState;

		//restore visible array selector
		_asCtg = call golib_getArraySelectorCtg;
		if !isNullReference(_asCtg) then {
			_asCtg ctrlShow true;
		};
	};
}

function(vcom_createNoGeomWidget)
{
	params ["_ctg","_size"];
	private _d = call vcom_getDisplay;
	if isNullReference(_d) exitwith {};

	private _ngo = [_d,TEXT,_size,_ctg] call createWidget;
	_ngo ctrlSetBackgroundColor [1,0,0,1];
	vcom_widgets set [1,_ngo];
	[_ngo,"<t align='center'>НЕ ОБНАРУЖЕНА ГЕОМЕТРИЯ</t>"] call widgetSetText;
}

function(vcom_loadModel)
{
	params ["_modelOrObj","_pos",["_asSimulated",true]]; //pos only in atl type

	if !isNullReference(vcom_visualObject) then {
		deleteVehicle vcom_visualObject;
	};

	if isNullVar(_pos) then {
		_pos = AGLToASL ASLToATL vcom_observ_centerPos;
	};

	private _modelPath = ifcheck(equalTypes(_modelOrObj,objnull),getModelInfo _modelOrObj select 1,_modelOrObj);
	if (_asSimulated) then {
		private _logic = vcom_logicObject;
		//_asSimulated only load after create camera preview
		if isNullReference(_logic) exitWith {};

		_modelPath = ifcheck(equalTypes(_modelOrObj,objnull),typeof _modelOrObj,_modelOrObj);
		vcom_visualObject = createvehicle [_modelPath,position _logic,[],0,"none"];
		vcom_visualObject attachto [_logic,[0,0,0]];
	} else {
		vcom_visualObject = createSimpleObject [_modelPath,[0,0,0]];
		//(boundingBoxReal vcom_visualObject) params ["_bb1","_bb2","_size"];
		//vcom_visualObject setPosAtl (_pos vectorAdd [0,0,(_bb2 select 2)/2]);
		vcom_visualObject setPosAtl _pos;
	};
	if isNullReference(vcom_visualObject) exitWith {
		setLastError("cannot create model: " + format["%1" arg _modelPath]);
	};

	nextFrame(vcom_checkGeometryVisualObject);
}

function(vcom_observ_loadCameraController)
{
	params [["_sizes",[0,0,100,100]],["_ctxRef",null]];

	//reset buttons
	vcom_observ_buttons = call vcom_const_observ_buttons;

	private _logicPos = array_copy(vcom_observ_centerPos);

	private _logic = createagent ["Logic",_logicPos,[],0,"none"];
	_logic setpos _logicPos;
	_logic setdir 180;
	vcom_logicObject = _logic;
	vcom_observedObjects pushBack _logic;

	_target = createagent ["Logic",_logicPos,[],0,"none"];
	_target setpos _logicPos;
	vcom_targetObject = _target;
	vcom_observedObjects pushBack _target;

	setviewdistance 1;
	private _cam = "camera" camcreate position _logic;
	_cam cameraeffect ["internal","back"];
	_cam campreparefocus [-1,-1];
	_cam camcommitprepared 0;
	cameraEffectEnableHUD true;
	showcinemaborder false;
	
	vcom_camObject = _cam;
	vcom_observedObjects pushBack _cam;
	vcom_observ_camPos = array_copy(vcom_defaultCamPos);

	private _d = call vcom_getDisplay;
	private _ctg = call vcom_getCtg;
	if (isNullReference(_d) || isNullReference(_ctg)) exitwith {};
	private _bc = [_d,WIDGETGROUP,_sizes,_ctg] call createWidget;
	private _zoneDrag = [_d,TEXT,WIDGET_FULLSIZE,_bc] call createWidget;
	_zoneDrag ctrlSetTooltip "Тяните мышку чтобы вращать объект";
	_ctg setvariable ["_zoneDragWidget",_zoneDrag];
	_ctg setvariable ["_wgroupRef",_bc];

	_d DisplayAddEventHandler ["mousebuttondown",{['MouseButtonDown',_this] call vcom_observ_handleControl;}];
	_d DisplayAddEventHandler ["mousebuttonup",{['MouseButtonUp',_this] call vcom_observ_handleControl;}];
	_d DisplayAddEventHandler ["mousezchanged",{['MouseZChanged',_this] call vcom_observ_handleControl;}];
	//not used
	//_d DisplayAddEventHandler ["keydown",{['KeyDown',_this] call vcom_observ_handleControl;}];

	_zoneDrag ctrladdeventhandler ["mousemoving",{['Mouse',_this] call vcom_observ_handleControl;}];
	_zoneDrag ctrladdeventhandler ["mouseholding",{['Mouse',_this] call vcom_observ_handleControl;}];
	ctrlsetfocus _zoneDrag;

	_d setvariable ["____zoneDragRef",_zoneDrag];

	if (cfg_system_enableKeymapInfoOnVcomLoad) then {
		private _widHelp = [_d,TEXT,
			_sizes
		,_ctg] call createWidget;
		[_widHelp,format["<t size='1.7'>%1Управление визуальной сценой:%1%1ЛКМ (зажать) - движение камеры%1ПКМ (зажать) - вращение камеры%1"+
		"ЛКМ+Q или ЛКМ+W - поднять камеру%1"+
		"ЛКМ+Z или ЛКМ+S - опустить камеру камеру%1"+
		"Добавление Shift к модификаторам камеры (Q,W,S,Z) - увеличение шага изменения высоты камеры%1%1"+
		"Нажмите на это окно для закрытия, либо оно само закроется через 10 секунд</t>",sbr]] call widgetSetText;
		_widHelp setBackgroundColor [0.1,0.1,0.1,0.9];
		_widHelp ctrladdeventhandler ["MouseButtonUp",{
			(_this select 0)setFade 1;
			(_this select 0) commit 0.2;
			(_this select 0) ctrlEnable false;
		}];
		ctrlsetfocus _widHelp;
		private _post = {
			_this ctrlEnable false;
			_this setFade 1;
			_this commit 1.3;
		};
		invokeAfterDelayParams(_post,10,_widHelp);
	};


	vcom_observ_camModifier = 0;
	vcom_observ_internal_camModifKeyVal = 0;
	_d DisplayAddEventHandler ["KeyDown",{
		params ["_wid","_key","_shift","_ctrl","_alt"];
		vcom_observ_internal_camModifKeyVal = 0;
		_shifMod = ifcheck(_shift,10,1);
		if (_key in [KEY_Q,KEY_W]) exitwith {
			vcom_observ_internal_camModifKeyVal = 0.01 * _shifMod;
			//!((_wid getvariable "____zoneDragRef") call isMouseInsideWidget);
		};
		if (_key in [KEY_Z,KEY_S]) exitwith {
			vcom_observ_internal_camModifKeyVal = -0.01 * _shifMod;
			//!((_wid getvariable "____zoneDragRef") call isMouseInsideWidget);
		};
		false
	}];
	_d DisplayAddEventHandler ["KeyUp",{
		params ["","_key"];
		vcom_observ_internal_camModifKeyVal = 0;
	}];

	if (vcom_windowMode=="prox") then {
		private _unit = createvehicle [BASIC_MOB_TYPE,position _logic,[],0,"none"];
		_ctxRef set [0,_unit];
		vcom_prox_center = _unit; //unit
		vcom_observedObjects pushBack vcom_prox_center;

		//caminit
		vcom_observ_camPos = [10,-45,15,[0,0,-1]]; //[5,0,0,[0,0,0.85]];
		//detach vcom_targetObject;
		vcom_targetObject attachto [vcom_prox_center,vcom_observ_camPos select 3,""];
		private _cam = vcom_camObject;
		_cam cameraeffect ["internal", "back"];
		_cam campreparefocus [-1,-1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
	};

	vcom_handler_draw3D = addMissionEventHandler ["draw3D",{['draw3D',_this] call vcom_observ_handleControl;}];

	call vcom_observ_reloadCamPos;
}

function(vcom_observ_reloadCamPos)
{
	vcom_observ_buttons = [[0,0],[0,0]];
	["Mouse",[controlnull,0,0]] call vcom_observ_handleControl;
	if (vcom_windowMode=="prox") then {
		["draw3D",[controlnull,0,0]] call vcom_observ_handleControl;
		["MouseZChanged",[controlnull,0]] call vcom_observ_handleControl;
	};	
	vcom_observ_buttons = [[],[]];
}

//!test function
function(vcom_debug_testReload)
{
	params ["_t","_d"];
	_c = {
		//vcom_observ_camPos = _this;

		_cam = vcom_camObject;
		_logic = vcom_logicObject;
		_target = vcom_targetObject;

		_target attachto [_logic,_this,""];

		// _cam attachto [_target,_this,""];
		// _cam campreparetarget _target;
		// _cam camcommitprepared 0;

		vcom_observ_buttons = [[0,0],[0,0]];
		["Mouse",[controlnull,0,0]] call vcom_observ_handleControl;
		vcom_observ_buttons = [[],[]];
		//call vcom_observ_reloadCamPos;
	};
	invokeAfterDelayParams(_c,_t,_d);
}

function(vcom_observ_centerAtModel)
{
	(boundingBoxReal vcom_visualObject) params ["_b1","_b2","_s"];
	private _relPos = [_b2 select 2,_b2 select 1,0];
	private _target = vcom_targetObject;
	_target attachto [vcom_logicObject,_relPos,""];
	call vcom_observ_reloadCamPos;
}
//центрировать на конкретном объекте
function(vcom_observ_centerAtObject)
{
	params ["_obj"];
	(boundingBoxReal _obj) params ["_b1","_b2","_s"];
	private _relPos = [(_b2 select 2),(_b2 select 1),0];
	private _target = vcom_targetObject;
	_target attachto [_obj,_relPos,""];
	call vcom_observ_reloadCamPos;
}

function(vcom_observ_handleControl)
{
	params ["_controlType","_thisParams"];
	
	_isMobCamControl = vcom_windowMode == "prox";

	call {
		if (_controlType == "MouseButtonDown") exitwith {
			if !(((call vcom_getDisplay) getvariable "____zoneDragRef") call isMouseInsideWidget) exitwith {};
			
			vcom_observ_buttons set [_thisParams select 1,GetMousePosition /*[_thisParams select 2,_thisParams select 3]*/];
		};
		if (_controlType == "MouseButtonUp") exitwith {
			if !(((call vcom_getDisplay) getvariable "____zoneDragRef") call isMouseInsideWidget) exitwith {};

			vcom_observ_buttons set [_thisParams select 1,[]];
		};
		if (_controlType == "MouseZChanged") exitwith {
			if !(((call vcom_getDisplay) getvariable "____zoneDragRef") call isMouseInsideWidget) exitwith {};
			
			if (_isMobCamControl) exitWith {
				_cam = vcom_camObject;
				_center = vcom_prox_center;
				_target = vcom_targetObject;
				private _disMax = (boundingboxreal _center select 0 vectordistance (boundingboxreal _center select 1)) * 1.5;

				_dis = vcom_observ_camPos select 0;
				_dis = _dis - ((_thisParams select 1) / _disMax);
				_dis = _dis max (_disMax * 0.05) min _disMax;
				vcom_observ_camPos set [0,_dis];
			};

			_z = _thisParams select 1;
			_dis = vcom_observ_camPos select 0;
			_dis = _dis - (_z / 4);
			_dis = _dis max 1 min 30; //prev 10
			vcom_observ_camPos set [0,_dis];
		};
		if (_controlType=="Mouse" && _isMobCamControl) exitWith {
			[_thisParams select 1,GetMousePosition select 0,GetMousePosition select 1] params ["_ctrl", "_mX", "_mY"];

			_cam = vcom_camObject;
			_center = vcom_prox_center;
			_target = vcom_targetObject;
			
			vcom_observ_camPos params ["_dis", "_dirH", "_dirV", "_targetPos"];
			vcom_observ_buttons params ["_LMB", "_RMB"];
			if (isNullReference(_thisParams select 0)) then {
				_LMB = [0,0];
			};

			if (count _LMB > 0) then 
			{
				_LMB params ["_cX", "_cY"];
				vcom_observ_buttons set [0,[_mX, _mY]];

				//first person camera
				prox_cam_dragControl set [0,(_cX - _mX)];
				prox_cam_dragControl set [1,(_cY - _mY)];

				boundingboxreal _center params ["_minBox", "_maxBox"];
				private _centerSizeBottom = _minBox select 2;
				private _centerSizeUp = _maxBox select 2;
				private _centerSize = sqrt ([_minBox select 0, _minBox select 1] distance2D [_maxBox select 0, _maxBox select 1]);

				private _z = _targetPos select 2;
				_targetPos = _targetPos getPos [(_cX - _mX) * _centerSize, _dirH - 90];
				_z = (_z - (_cY - _mY) * _centerSize) max _centerSizeBottom min _centerSizeUp;
				_targetPos = [0,0,0] getPos [([0,0,0] distance2D _targetPos) min _centerSize, [0,0,0] getDir _targetPos];
				_targetPos set [2, _z max ((_minBox select 2) + 0.2)];

				vcom_observ_camPos set [3, _targetPos];
			};
			if (count _RMB > 0) then {
				_RMB params ["_cX", "_cY"];

				private _dX = (_cX - _mX) * 0.75;
				private _dY = (_cY - _mY) * 0.75;
				private _z = _targetPos select 2;
				
				_targetPos = [0,0,0] getPos [[0,0,0] distance2D _targetPos, ([0,0,0] getDir _targetPos) - _dX * 180];
				_targetPos set [2, _z];

				vcom_observ_camPos set [1, (_dirH - _dX * 180) % 360];
				vcom_observ_camPos set [2, (_dirV - _dY * 100) max -89 min 89];
				vcom_observ_camPos set [3, _targetPos];
				vcom_observ_buttons set [1, [_mX,_mY]];
			};
		};
		if (_controlType == "Mouse") exitWith {
			ifcheck(equals(_thisParams select 0,controlnull),_thisParams select vec2(1,2),GetMousePosition) params ["_mX","_mY"];
			//_mX = _thisParams select 1;
			//_mY = _thisParams select 2;

			_cam = vcom_camObject;
			_logic = vcom_logicObject;
			_target = vcom_targetObject;

			_dis = vcom_observ_camPos select 0;
			_dirH = vcom_observ_camPos select 1;
			_dirV = vcom_observ_camPos select 2;
			_disLocal = _dis;

			_LMB = vcom_observ_buttons select 0;
			_RMB = vcom_observ_buttons select 1;

			if (count _LMB > 0) then {

				_cX = _LMB select 0;
				_cY = _LMB select 1;
				_dX = (_cX - _mX) * 10;
				_dY = (_cY - _mY) * 10;
				vcom_observ_buttons set [0,[_mX,_mY]];

				if (vcom_observ_internal_camModifKeyVal!=0) then {
					modvar(vcom_observ_camModifier) + vcom_observ_internal_camModifKeyVal;
					vcom_observ_camModifier = clamp(vcom_observ_camModifier,-30,30);
				};
				
				_targetPos = position _target;
				_logicPos = position _logic;
				_targetPos = [
					(_logicPos select 0) - (_targetPos select 0),
					(_logicPos select 1) - (_targetPos select 1),
					vcom_observ_camModifier
				];
				_targetPos = [_targetPos,_dY,_dirH + 00] call bis_fnc_relpos;
				_targetPos = [_targetPos,_dX,_dirH - 90] call bis_fnc_relpos;
				_targetPos set [0,(_targetPos select 0) max (-50) min (+50)]; //min/max editor area size
				_targetPos set [1,(_targetPos select 1) max (-50) min (+50)];
				_target attachto [_logic,_targetPos,""];
				
			};

			if (count _RMB > 0) then {
				_cX = _RMB select 0;
				_cY = _RMB select 1;
				_dX = (_cX - _mX);
				_dY = (_cY - _mY);

				_dirH = (_dirH - _dX * 180) % 360;
				_dirV = (_dirV - _dY * 100) max -89 min 89;

				vcom_observ_camPos set [1,_dirH];
				vcom_observ_camPos set [2,_dirV];
				vcom_observ_buttons set [1,[_mX,_mY]];
			};

			_x = cos _dirV * _dis;
			_z = sin _dirV * _dis;
			_campos = [[0,0,_z],_x,_dirH] call bis_fnc_relpos;
			_cam attachto [_target,_campos,""];
			_cam campreparetarget _target;
			_cam camcommitprepared 0;
		};
		if (_controlType == "draw3D") exitwith {

			if (_isMobCamControl) then {
				_cam = vcom_camObject;
				_center = vcom_prox_center;
				_target = vcom_targetObject;

				if (prox_isExternalCam) then {
					vcom_observ_camPos params ["_dis","_dirH","_dirV","_targetPos"];
					
					[_target, [_dirH + 180, -_dirV, 0]] call bis_fnc_setobjectrotation;
					_target attachto [_center, _targetPos, ""]; //--- Reattach for smooth movement

					//_cam setvectordirandup [vectordirvisual _target, vectorupvisual _target];
					//_cam setPosASL (_target modeltoworldvisualworld [0, -_dis, 0]); //--- Don't use setPosASL, can be blacklisted on server
					_cam attachto [_target,[0, -_dis, 0],""];
					_cam setdir 0;
				} else {
					call prox_cam_updateInternalCamera
				};

				

				call prox_syncVisualSceneWidgets;	
			};

			if (vcom_visual_renderDebugGeometry) then {
				call vcom_visual_drawDebugGeometry;
			};

			if (!vcom_visual_canDrawLines) exitwith {};
			
			_logic = vcom_logicObject;

			for "_x" from -5 to 5 step 1 do {
				drawLine3D [
					_logic modeltoworld [_x,-5],
					_logic modeltoworld [_x,+5],
					[0,0,0,1]
				];
			};
			for "_y" from -5 to 5 step 1 do {
				drawLine3D [
					_logic modeltoworld [-5,_y],
					_logic modeltoworld [+5,_y],
					[0,0,0,1]
				];
			};
			drawLine3D [
				_logic modeltoworld [0,0,-5],
				_logic modeltoworld [0,0,+5],
				[0.2,0,0,1]
			];
			drawLine3D [
				_logic modeltoworld [0,-5,0],
				_logic modeltoworld [0,+5,0],
				[0.2,0,0,1]
			];
			drawLine3D [
				_logic modeltoworld [-5,0,0],
				_logic modeltoworld [+5,0,0],
				[0.2,0,0,1]
			];
		};
	};
}


function(vcom_checkGeometryVisualObject)
{
	private _catched = 0;
	_catched = (allLods vcom_visualObject)findif {_x select 1 == "geometry"};
	
	private _wid = vcom_widgets select 1;
	if isNullReference(_wid) exitWith {};
	_wid ctrlShow (_catched == -1);
	vcom_observ_hasGeometry = (_catched != -1);
}