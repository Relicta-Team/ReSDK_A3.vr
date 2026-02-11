// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(systools_imageProcessor)
{
	params [["_fullBuild",true],["_searchPatternUse",false]];

	systools_imageProcessor_isFullBuild = _fullBuild;
	systools_imageProcessor_searchPatterns = [];
	systools_imageProcessor_restoreGEOCursorOnEnd = false;

	private _aborted = false;
	if (_searchPatternUse) then {
		_ref = refcreate(0);
		if ([_ref,"Установка путей генерации картинок",
			"Укажите части путей модели (каждую с новой строки), которые необходимо добавить на проверку. Регистр не учитывается."
		] call widget_winapi_openTextBox) then {
			_ref = refget(_ref);
			systools_imageProcessor_searchPatterns = (_ref splitString endl) apply {tolower _x};
		} else {
			_aborted = true;
		};
	};

	if (_aborted) exitwith {
		["Операция отменена"] call showWarning;
	};

	[ 
	"Вы уверены? Процесс может занять какое-то время. Для отмены генерации зажмите ПКМ", 
	"Генератор иконок", 
	[ 
	"Запустить", 
	{ [] spawn systools_internal_imageProcessor } 
	], 
	[ 
	"Нет", 
	{} 
	], 
	"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
	findDisplay 313 
	] call createMessageBox;
}

function(systools_internal_imageProcessor)
{
	if (geoCursor_enabled) then {
		call geoCursor_toggle;
		systools_imageProcessor_restoreGEOCursorOnEnd = true;
	};
	//prep scene
	_posZ = 10;
	_pos = [1024,1024,_posZ];

	_cam = "camera" camcreate _pos;
	_cam cameraeffect ["internal","back"];
	_cam campreparefocus [-1,-1];
	_cam campreparefov 0.4;
	_cam camcommitprepared 0;
	_cam setVariable ["iscamera",true];
	showcinemaborder false;

	_sphereColor = "#(argb,8,8,3)color(0,1,0,0.1)"; //--- VR ground
	//_sphereColor = "#(argb,8,8,3)color(0.93,1.0,0.98,0.028)"; //--- VR sky
	//_sphereColor = "#(argb,8,8,3)color(1,1,1,1)"; //--- White
	_sphereGround = createvehicle ["Sphere_3DEN",_pos,[],0,"none"];
	_sphereNoGround = createvehicle ["SphereNoGround_3DEN",_pos,[],0,"none"];
	{
		_x setposatl _pos;
		_x setdir 0;
		_x setobjecttexture [0,_sphereColor];
		_x setobjecttexture [1,_sphereColor];
		_x hideobject true;
	} foreach [_sphereGround,_sphereNoGround];
	bcondabort = false;
	if( ISNIL{debug_test_hdr}) then {debug_test_hdr = false;};
	if( ISNIL{debug_helper_bbx}) then {debug_helper_bbx = false};
	if( ISNIL{debug_create_center}) then {debug_create_center = false};
	if( ISNIL{debug_hdr_values}) then {debug_hdr_values = [6,30,20,200];};
	//setaperture 40;// 35;
	//setApertureNew debug_hdr_values;
	setaperture 40;
	setdate [2035,5,28,10,0];
	
	_model = "\ml_shabut\meshok\meshok2.p3d";
	
	_display = [] call bis_fnc_displayMission;
	if (is3DEN) then {
		_display = finddisplay 313;
		["showinterface",false] call bis_fnc_3DENInterface;
		
		[false,true] call golib_vis_onChangeRightPanelState;
		[false,true] call inspector_onChangeLeftPanelState;
		(menu_internal_widget_refButtonObjLib select 0) ctrlShow false;
	};
	
	_helpers = [];
	if (debug_helper_bbx) then {
		_helperObject = "Sign_Sphere10cm_F";//"Brush_01_green_F";//
		_helpers = [
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1],
			_helperObject createvehicle [1,1,1]
		];
		{
			(_helpers select _foreachindex) enableSimulation false;
			(_helpers select _foreachindex) setobjecttexture [0,_x];
			["created sphere %2 at color %1",_helpers select _forEachIndex,_x] call printLog;
		} foreach [
			"#(argb,8,8,3)color(1,1,1,1)",
			"#(argb,8,8,3)color(0,0,1,1)",
			"#(argb,8,8,3)color(0,1,0,1)",
			"#(argb,8,8,3)color(0,1,1,1)",
			"#(argb,8,8,3)color(1,0,0,1)",
			"#(argb,8,8,3)color(1,0,1,1)",
			"#(argb,8,8,3)color(1,1,0,1)",
			"#(argb,8,8,3)color(1,1,1,1)"
		];
		//{(_helpers select _x) setObjectTexture [0,"#(argb,8,8,3)color(1,0,0,1)"]} foreach [0,1,2,3,4,5];
	};
	_centerObject = objNUll;
	if (debug_create_center) then {
		_centerObject = "Sign_Sphere10cm_F" createvehicle [1,1,1];
		_centerObject enableSimulation false;
		_centerObject setobjecttexture [0,"#(argb,8,8,3)color(1,0,0,1)"];
	};
	
	if (canSuspend) then {
		
		_delay = 1;
		
		//screen sizes
		_screenTop = safezoneY;
		_screenBottom = safezoneY + safezoneH;
		_screenLeft = safezoneX;
		_screenRight = safezoneX + safezoneW;
		
		_camDirH = 135;
		_camDirV = 40;
		_posLocal = +_pos;
		
		
		//collect models
		_modelList = [];
		_listClasses = ["Item",true] call oop_getinhlist;
		
		//_listClasses = _listClasses select [307,1];
		
		{
			_modelList pushBackUnique (tolower([_x,"model",true] call oop_getfieldbasevalue))
		} foreach _listClasses;
		
		//new models
		/*if (!isNIL{golib_om_internal_lastgenerated} && {count golib_om_internal_lastgenerated > 0}) then {
			_modelList = array_copy(golib_om_internal_lastgenerated);
			["getted %1 models",count _modelList] call printLog;
		} else {
			_modelList = [];
			_hasErr = false;
			_brokens = 0;
			_bigger = 0;
			_blacklistCount = 0;
			_blacklist = ["leaf_","_grass","_leaf","plakats2","plakat1"];
			isNIL {
				{
					_object = createSimpleObject [_x,[0,0,0]];
					_object setPosAtl (getPosATL cameraOn);
					if isNullReference(_object) then {
						["error at model path: %1",_x] call printError;
						_hasErr = true;
						INC(_brokens);
						continue
					};
					if (_x in _blacklist) then {
						INC(_blacklistCount);
					};
					_size = ((boundingBoxReal _object) select 2);
					if (_size > 0.9 || _size == 0) then {
						//no act
						INC(_bigger);
					} else {
						_modelList pushBack _x;
					};
					deleteVehicle _object;
				} foreach array_copy(golib_om_internal_iconsavedmodels);
			};
			if (_hasErr) then {
				bcondabort = true;
			};
			golib_om_internal_lastgenerated = _modelList;
			["Collected models %1 (broken %2, bigger %3)",count _modelList,_brokens,_bigger] call printLog;
			uiSleep 2;
		};*/
		_bigger = 0;
		if (!isNIL{core_modelBBX}) then {
			_modelList = [];
			
			{
				_size = _y select 2;
				if (_size > 0.9 || _size == 0) then {
					INC(_bigger);
				} else {
					_modelList pushBack _x;
				}
			} foreach core_modelBBX;
			
		};

		if !(systools_imageProcessor_isFullBuild) then {
			["Enabled non-full build"] call printLog;
			_countPre = count _modelList;
			{
				_path = "Resources\ui\inventory\items\gen\" +
				(_x splitString "/\." joinString "+") + ".paa";
						
				if ([_path] call file_exists) then {
					_modelList set [_foreachindex,objNUll];
				};
			} foreach _modelList;

			_modelList = _modelList - [objNUll];
			["New models count - %1",count _modelList] call printLog;
		};

		if (count systools_imageProcessor_searchPatterns > 0) then {
			["Enabled only pattern-based models"] call printLog;
			_countPre = count _modelList;
			{
				_lpath = tolower _x;
				if ((systools_imageProcessor_searchPatterns findif {_x in _lpath}) == -1) then {
					_modelList set [_foreachindex,objNUll];
				};
			} foreach _modelList;

			_modelList = _modelList - [objNUll];
			["New models count - %1",count _modelList] call printLog;
		};

		["Collected models %1 (bigger %2)",count _modelList,_bigger] call printLog;
		uiSleep 2;
		
		_folderName = SYSTEMTIME select [0,5] joinString "_";
		systools_imageProcessor_lastUsedFolder = _folderName;
		
		{
			waitUntil {isNullReference(findDisplay 316000)};
			if (bcondabort) exitWith {};
			_model = _x;
			
			_fileName = _folderName+"\"+(_model splitString "/\." joinString"+")+".png";
			
			_object = createSimpleObject [_model,_pos];
			
			//_size = selectMax((boundingBoxReal _object) select 1);
			_size = ((boundingBoxReal _object) select 2);
			/*if (_size > 1.5 || _size == 0) then {
				["------> bbx too big or low %1",(boundingBoxReal _object)] call printWarning;
				_object setposatl [0,0,0];
				deleteVehicle _object;
				//uisleep 0.01;
				continue;
			};*/
			if isNullReference(_object) exitWith {
				["error at model path: %1",_model] call printError;
			};
			//_object setPosAtl (_pos vectorAdd [0,4,0]);
			
			_objectModelCenter = (getModelInfo _object select 3);
			
			_object setPosAtl (_posLocal);
			_timeCapture = tickTime + _delay;
			
			_bbox = boundingboxreal _object;
			_bbox1 = _bbox select 0;
			_bbox2 = _bbox select 1;
			_bboxSize = _bbox select 2;
			_worldPositions = [
				_object modeltoworld ([_bbox1 select 0,_bbox1 select 1,_bbox1 select 2]  ),
				_object modeltoworld ([_bbox1 select 0,_bbox1 select 1,_bbox2 select 2]  ),
				_object modeltoworld ([_bbox1 select 0,_bbox2 select 1,_bbox1 select 2]  ),
				_object modeltoworld ([_bbox1 select 0,_bbox2 select 1,_bbox2 select 2]  ),
				_object modeltoworld ([_bbox2 select 0,_bbox1 select 1,_bbox1 select 2]  ),
				_object modeltoworld ([_bbox2 select 0,_bbox1 select 1,_bbox2 select 2]  ),
				_object modeltoworld ([_bbox2 select 0,_bbox2 select 1,_bbox1 select 2]  ),
				_object modeltoworld ([_bbox2 select 0,_bbox2 select 1,_bbox2 select 2]  )
			];
			_needCount = count _worldPositions;
			/*_worldPositions = [
				_object modelToWorldVisual [_bboxSize,_bboxSize,_bboxSize],
				_object modelToWorldVisual [_bboxSize,-_bboxSize,_bboxSize],
				_object modelToWorldVisual [_bboxSize,_bboxSize,-_bboxSize],
				_object modelToWorldVisual [-_bboxSize,-_bboxSize,-_bboxSize],
				
				_object modelToWorldVisual [-_bboxSize,-_bboxSize,-_bboxSize],
				_object modelToWorldVisual [-_bboxSize,_bboxSize,-_bboxSize],
				_object modelToWorldVisual [-_bboxSize,-_bboxSize,_bboxSize],
				_object modelToWorldVisual [-_bboxSize,-_bboxSize,-_bboxSize]
			];*/
			//_worldPositions = _worldPositions + _worldPositions;
			
			if (debug_helper_bbx) then {
				{
					_x setposatl (_worldPositions select _foreachindex);
					["position helper %1 setted to %2 -> %3",_forEachIndex,getPosATL _x,_object worldToModel (getPosATL _x)] call printTrace;
				} foreach _helpers;
			};
	
			//--- Set background sphere
			_pointLowest = 0;
			_pointHighest = 0;
			{
				_xZ = (_x select 2) - _posZ;
				if (_xZ > _pointHighest) then {_pointHighest = _xZ;};
				if (_xZ < _pointLowest) then {_pointLowest = _xZ;};
			} foreach _worldPositions;
			_sphere = if (abs(_pointLowest) > abs(_pointHighest * 2/3)) then {_sphereNoGround} else {_sphereGround};
			_sphere = _sphereGround;
			_sphere hideobject false;
			_adxPos = if equals(_sphereGround,_sphere) then {vec3(0,0,-3)} else {vec3(0,0,0)};
			_sphere setPosAtl (_pos vectorAdd _adxPos);
			
			//--- Set camera
			_camAngle = _camDirV;
			_camDis = (1.5 * ((_bbox select 2) max 0.1)) min 124 max 0.2; //--- 125 m is a sphere diameter
			_camPos = [_posLocal,_camDis,_camDirH] call bis_fnc_relpos;
			//_camPos set [2,/*_posZ*/((_object modeltoworld [0,0,0]) select 2) + (tan _camAngle * _camDis)];
			_camPos set [2,((_object modelToWorldVisual [0,0,0]) select 2)+ (tan _camAngle * _camDis) ];
			//_camPos set [1,(_camPos select 1) + _camDis];
			_cam campreparepos (_camPos /*vectorAdd _objectModelCenter*/);
			//_cam campreparetarget (_object modeltoworld (_objectModelCenter vectorAdd [0,0,(tan _camAngle * _camDis)/2]));
			//_cam campreparetarget (asltoatl(getPosWorldVisual _object));
			//_cam campreparetarget (_object modelToWorldVisual [0,0,(boundingBoxReal _object select 1 select 2)/2]);
			_cam campreparefocus [-1,-1];
			_cam campreparefov 0.7;
			_cam camcommitprepared 0;
			sleep 0.01; //--- Delay for camera to load
			
			if (debug_create_center) then {
				_centerObject setPosAtl (_object modelToWorldVisual [0,0,(boundingBoxReal _object select 1 select 2)/2]);
			};
			
			//--- Calculate target
			_extremes = [0.5,0.5,0.5,0.5]; //--- Left, Right, Top, Bottom
			//_extremes = [_screenLeft,_screenRight,_screenTop,_screenBottom];
			{
				_screenPos = worldtoscreen _x;
				if (count _screenPos > 0) then {
					_screenPosX = _screenPos select 0;
					_screenPosY = _screenPos select 1;
					if (_screenPosX < (_extremes select 0)) then {_extremes set [0,_screenPosX];};
					if (_screenPosX > (_extremes select 1)) then {_extremes set [1,_screenPosX];};
					if (_screenPosY > (_extremes select 3)) then {_extremes set [3,_screenPosY];};
					if (_screenPosY < (_extremes select 2)) then {_extremes set [2,_screenPosY];};
				};
			} foreach _worldPositions;
			_cam campreparetarget screentoworld [
				(_extremes select 0) + ((_extremes select 1) - (_extremes select 0)) / 2,
				(_extremes select 2) + ((_extremes select 3) - (_extremes select 2)) / 2
			];
	
			//--- Calculate zoom - get the closest zoom where all bounding box corners are still visible
			_fovStart = if (_camDis < 0.35) then {0.4} else {0.1}; //--- When camera is too close, it cuts into the model itself
			for "_f" from _fovStart to 0.7 step 0.01 do {
				_cam campreparefov _f;
				_cam camcommitprepared 0;
				uiSleep 0.01; //--- Delay for camera to load
				_onScreen = true;
				{
					_screenPos = worldtoscreen _x;
					if (count _screenPos == 0) then {_screenPos = [10,10];};
					if (abs (linearconversion [_screenLeft,_screenRight,_screenPos select 0,-1,1]) > 1) exitwith {_onScreen = false;};
					if (abs (linearconversion [_screenTop,_screenBottom,_screenPos select 1,-1,1]) > 1) exitwith {_onScreen = false;};
				} foreach _worldPositions;
				if (_onScreen) exitwith {};
			};
			
			waitUntil { 10 preloadObject _object };
			waituntil {tickTime > _timeCapture};
			if (debug_test_hdr) then {
				_fileName = "debug_test_hdr.png"; 
				debug_test_hdr_locker = true;
				waitUntil {!debug_test_hdr_locker};
			};
			if (!screenshot _fileName) then {
				bcondabort = true;
				["Error on save %1 (%2/%3) [bbx:%4]. Operation aborted...",_fileName, _forEachIndex,(count _modelList)-1,_size] call printError;
			} else {
				["saved icon: %1 (%2/%3) [bbx:%4]",_fileName, _forEachIndex,(count _modelList) - 1,_size] call printLog;
			};
			sleep 0.01;
	
			if (debug_helper_bbx) then {
				sleep 1.5;
			};
	
			//--- Delete the object
			_object setpos [10,10,10];
			deletevehicle _object;
			_sphere hideobject true;

			if (inputMouse 1 > 0) exitWith {
				["User abort catched"] call printError;
			};
			
		} foreach _modelList;
	};
	
	
	["script done"] call printTrace;
	_cam cameraeffect ["terminate","back"];
	camdestroy _cam;
	deletevehicle _sphereGround;
	deletevehicle _sphereNoGround;
	setAperture -1;
	if (is3DEN) then {
		get3dencamera cameraeffect ["internal","back"];
		["showinterface",true] call bis_fnc_3DENInterface;
		(menu_internal_widget_refButtonObjLib select 0) ctrlShow true;
		
		//[] call BIS_fnc_camera_edenReset
	};
		
	if (debug_helper_bbx) then {
		{deletevehicle _x;} foreach _helpers;
	};
	if (debug_create_center) then {
		deleteVehicle _centerObject;
	};
	
	if (systools_imageProcessor_restoreGEOCursorOnEnd) then {
		call geoCursor_toggle;
	};

	call systools_imageProcessor_convertAndSave;
}


function(systools_imageProcessor_convertAndSave)
{
	[displayNull] call loadingScreen_start;
	// systools_imageProcessor_lastUsedFolder (SYSTEMTIME mark)

	//C:\Users\Username\Documents\Arma 3\missions\MissionName.Altis

	//<PROFILEDIR>\Screenshots\ <--- screenshots path
	private _screenshotsPath = (getMissionPath "") + "..\..\Screenshots\";
	private _customProfiles = call Core_getCliArgs get "profiles";
	
	if !isNullVar(_customProfiles) then {
		_screenshotsPath = format["%1\Users\%2\Screenshots\",_customProfiles,profileName];
	};

	private _generatedPath = _screenshotsPath + systools_imageProcessor_lastUsedFolder;
	private _outputFolder = _screenshotsPath + "output";
	
	private _imgRemoverGreenScreenExe = getMissionPath "Third-party\ImageConverter\icon_builder.exe";
	private _paltopac = getMissionPath "Third-party\ImageConverter\Pal2PacE.exe";
	private _nogreenOutputRelative = "Third-party\ImageConverter\icon_output";
	private _nogreenOutput = getMissionPath _nogreenOutputRelative;

	private _pathGeneratedIcons = "Resources\ui\inventory\items\gen\";

	if !([_imgRemoverGreenScreenExe,false] call file_exists) exitWith {
		["%1 not found",_imgRemoverGreenScreenExe] call printError;
		call loadingScreen_stop;
	};

	[1,"Определение путей"] call loadingScreen_setProgress;

	if ([_outputFolder,false] call folder_exists) then {
		_outputNameReplacer = "_oldfrom_"+(SYSTEMTIME select [0,5] joinString "_");
		["Старая папка output уже существует; Переименовываем в output%1",_outputNameReplacer] call printLog;
		[
			_outputFolder,
			_outputFolder + _outputNameReplacer,
			false
		] call dir_move;
	};

	if isNullVar(__SYSNOCONV__) then {
		if (canSuspend) then {
			[12,"Prepare to suspend..."] call loadingScreen_setProgress;
			["Preparing..."] call printLog;
			sleep 5;
		};
		[10,"Запуск очистки фона..."] call loadingScreen_setProgress;
		["Generating path: %1",_generatedPath] call printLog;

		private _result = [_imgRemoverGreenScreenExe,false,""""+_generatedPath+""" 600"] call file_openReturn;
		["Icon converter result: %1",_result] call printLog;
		if (_result != 0) exitwith {
			["Icon converter exitcode error... [CODE %1]",_result] call printError;
			call loadingScreen_stop;
		};
	};
	
	["Icons converted path: %1",_nogreenOutput] call printLog;
	
	if !([_nogreenOutput,false] call folder_exists) exitwith {
		["%1 not found",_nogreenOutput] call printError;
		call loadingScreen_stop;
	};
	
	private _fileList = [_nogreenOutput,false,"*.png",false] call file_getFileList;
	["Count of png icons: %1",count _fileList] call printLog;

	{
		["Processing %1",_x] call printLog;
		forceUnicode 0;
		_newname = (_x select [0,count _x -4])+".paa";
		_fullPathPaaTemp = _nogreenOutput+"\"+_newname;
		[_paltopac,false,""""+_nogreenOutput+"\"+_x+""" """+_fullPathPaaTemp+""""] call file_openReturn;
		_newpath = _pathGeneratedIcons + _newname;
		if ([_newpath,true] call file_exists) then {

			if ([_newpath,true] call file_isLocked) then {
				["file locked - %1; awaiting unlock",_newpath] call printWarning;
				while {[_newpath,true] call file_isLocked} do {
					["unlock attempt..."] call printTrace;
					call file_clearFileLock;
					sleep 0.5;
				};
				["file unlocked - %1",_newpath] call printLog;
			};

			if !([_newpath] call file_delete) then {
				["CANNOT DELETE FILE %1",_newpath] call printError;
			} else {
				["Alredy exists; Move status - %1",[_fullPathPaaTemp,_newpath,[false,true]] call file_move] call printLog;
			};
		} else {
			["Move status - %1",[_fullPathPaaTemp,_newpath,[false,true]] call file_move] call printLog;
		};
	} foreach _fileList;

	private _deletedTemp = [_nogreenOutputRelative] call folder_delete;
	["temp deleted (%2) - %1",_deletedTemp,_nogreenOutputRelative] call printLog;

	["DONE!"] call printLog;
	call loadingScreen_stop;

	if (["Очистить папку с сгенерированными исходниками иконок?"+endl+
		(format["При подтверждении будет удалена папка ""%1"" со всем содержимым.",_generatedPath]) +
		endl+endl+"Удалить папку?"] call messageBoxRet) then {
			_unsafeDeleteExternalFolder = {
				params ["_path"];
				if ([_path,false] call folder_exists) then {
					["FileManager","FolderDelete",[_path]] call rescript_callCommandVoid;
					true
				} else {false};
			};
			["Delete generated icons folder: %1 -> result: %2",_generatedPath,[_generatedPath] call _unsafeDeleteExternalFolder] call printLog;
	} else {
		if (["Вы хотите открыть папку с исходниками сгенерированных png иконок?"] call messageBoxRet) then {
			// ["FileManager","Open",[ 
			// 	"explorer.exe",
			// 	[_generatedPath,"""","~"] call stringReplace,
			// 	"~"
			// ],true] call rescript_callCommand;

			["WorkspaceHelper","openfolder",[_generatedPath,0,"with_select"],true] call rescript_callCommand;
		};
	};	

	["Процедура успешно завершена. Перезапустите редактор для обновления иконок"] call messageBox;
}
