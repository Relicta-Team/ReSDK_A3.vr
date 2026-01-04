// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\..\client\WidgetSystem\widgets.hpp>
#include <..\..\..\client\Inventory\inventory.hpp>
#include <..\..\keyboard.hpp>
#include <..\..\oop.hpp>

proxEd_object = objNUll;

proxEd_modifierPosBias = 1000;
proxEd_scrollValue = 1000;
proxEd_data_pos = [0,0,0];
proxEd_data_vec = [0,0,0];
proxEd_curSelection = 0;
proxEd_target = vasya; //player;
proxEd_targetList = [vasya,player];

proxEd_data_all = [];
proxEd_data_all resize (count INV_LIST_ALL);
proxEd_data_all = proxEd_data_all apply {[[0,0,0],[0,0,0]]};
proxEd_data_all set [proxEd_curSelection,[proxEd_data_pos,proxEd_data_vec]];

proxEd_openEditor = {

	_d = call dynamicDisplayOpen;
	_d displayAddEventHandler ["KeyUp",{
		params ["_d","_key"];
		if (_key == KEY_U) then {
			call proxEd_closeEditor;
		};
	}];

	_ctg = [_d,WIDGETGROUP,[70,30,30,100 - 30 * 2]] call createWidget;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [.3,.3,.3,0.6];

	_sizeX = 40;
	_sizeY = 5;

	_x = [_d,SLIDERWNEW,[0,20 + _sizeY * 0,_sizeX,_sizeY],_ctg] call createWidget;
	_y = [_d,SLIDERWNEW,[0,20 + _sizeY * 1,_sizeX,_sizeY],_ctg] call createWidget;
	_z = [_d,SLIDERWNEW,[0,20 + _sizeY * 2,_sizeX,_sizeY],_ctg] call createWidget;
	_d setvariable ['posarr',[_x,_y,_z]];

	{
		_x setvariable ['index',_forEachIndex];
		_x sliderSetRange [-proxEd_scrollValue,proxEd_scrollValue];
		_x ctrlSetTooltip ("Pos " + (["x","y","z"] select _forEachIndex));

		_x ctrlAddEventHandler ["SliderPosChanged",{
			params ["_wid", "_newValue"];
			_wid ctrlSetTooltip ("Pos " + (["x","y","z"] select (_wid getvariable 'index')) + str (_newValue / proxEd_modifierPosBias));
			//traceformat("new value is %1",_newValue);
			proxEd_data_pos set [_wid getvariable 'index',_newValue / proxEd_modifierPosBias];
			call proxEd_onChangeObjectData;
		}];
		_x ctrlAddEventHandler ["MouseButtonUp",{
			params ["_wid","_key"];
			if (_key == MOUSE_RIGHT) exitWith {
				_newValue = 0;
				_wid ctrlSetTooltip ("Pos " + (["x","y","z"] select (_wid getvariable 'index')) + str (_newValue / proxEd_modifierPosBias));
				//traceformat("new value is %1",_newValue);
				proxEd_data_pos set [_wid getvariable 'index',_newValue / proxEd_modifierPosBias];
				_wid sliderSetPosition ((proxEd_data_pos select (_wid getvariable 'index')) * proxEd_modifierPosBias);
				call proxEd_onChangeObjectData;
			};
		}];

		_x sliderSetPosition ((proxEd_data_pos select _forEachIndex) * proxEd_modifierPosBias);
	} foreach [_x,_y,_z];

	//vectors

	_x = [_d,SLIDERWNEW,[0,20 + _sizeY * 5,_sizeX,_sizeY],_ctg] call createWidget;
	_y = [_d,SLIDERWNEW,[0,20 + _sizeY * 6,_sizeX,_sizeY],_ctg] call createWidget;
	_z = [_d,SLIDERWNEW,[0,20 + _sizeY * 7,_sizeX,_sizeY],_ctg] call createWidget;
	_d setvariable ['vecarr',[_x,_y,_z]];

	{
		_x setvariable ['index',_forEachIndex];
		_x sliderSetRange [-360,360];
		_x ctrlSetTooltip ("Vec " + (["x","y","z"] select _forEachIndex));

		_x ctrlAddEventHandler ["SliderPosChanged",{
			params ["_wid", "_newValue"];
			_wid ctrlSetTooltip ("Vec " + (["x","y","z"] select (_wid getvariable 'index')) + str _newValue);
			//traceformat("new value is %1",_newValue);
			proxEd_data_vec set [_wid getvariable 'index',_newValue ];
			call proxEd_onChangeObjectData;
		}];

		_x ctrlAddEventHandler ["MouseButtonUp",{
			params ["_wid","_key"];
			if (_key == MOUSE_RIGHT) exitWith {
				_newValue = 0;
				_wid ctrlSetTooltip ("Vec " + (["x","y","z"] select (_wid getvariable 'index')) + str _newValue);
				//traceformat("new value is %1",_newValue);
				proxEd_data_vec set [_wid getvariable 'index',_newValue ];
				call proxEd_onChangeObjectData;
				_wid sliderSetPosition ((proxEd_data_vec select (_wid getvariable 'index')) );
			};
		}];

		_x sliderSetPosition ((proxEd_data_vec select _forEachIndex) );
	} foreach [_x,_y,_z];



	_input = [_d,INPUT,[_sizeX,20,60,10],_ctg] call createWidget;
	getDisplay setvariable ['proxEd_input',_input];

	_createByConfig = [_d,BUTTON,[_sizeX,30,20,10],_ctg] call createWidget;
	_createByConfig ctrlSetText "CFG/MODEL"; _createByConfig ctrlSetTooltip "Loading model by classname or modelpath";
	_createByConfig ctrlAddEventHandler ["MouseButtonUp",proxEd_loadByConfig];

	_createByConfig = [_d,BUTTON,[_sizeX + 20,30,20,10],_ctg] call createWidget;
	_createByConfig ctrlSetText "GOBJ"; _createByConfig ctrlSetTooltip "Loading model by gameobject";
	_createByConfig ctrlAddEventHandler ["MouseButtonUp",proxEd_loadByGameObject];

	_createByConfig = [_d,BUTTON,[_sizeX + 20 * 2,30,20,10],_ctg] call createWidget;
	_createByConfig ctrlSetText "PIT"; _createByConfig ctrlSetTooltip "Loading data from proxIt configs";
	_createByConfig ctrlAddEventHandler ["MouseButtonUp",proxEd_loadFromBuffer];

	_list = [_d,LISTBOX,[_sizeX,40,60,60],_ctg] call createWidget;
	_seldata = proxIt_list_selections;//["spine3","spine3","head","rightshoulder","spine3","face","lefthand","pelvis","righthand"];
	_namedata = inventory_slotnames_default;
	{
		_list lbAdd (_namedata select _forEachIndex);
		_list lbSetData [_forEachIndex,_seldata select _forEachIndex];
	} foreach INV_LIST_ALL;
	_list lbSetCurSel proxEd_curSelection;
	_list ctrlAddEventHandler ["LBSelChanged",{
		params ["_list","_index"];
		proxEd_data_all set [proxEd_curSelection,[proxEd_data_pos,proxEd_data_vec]];
		proxEd_curSelection = _index;

		proxEd_data_pos = proxEd_data_all select proxEd_curSelection select 0;
		proxEd_data_vec = proxEd_data_all select proxEd_curSelection select 1;

		call proxEd_onChangeObjectData;
	}];

	_save = [_d,BUTTON,[0,95,20,5],_ctg] call createWidget;
	_save ctrlSetText "Save config";
	_save ctrlAddEventHandler ["MouseButtonUp",proxEd_saveConfig];

	_switchTarg = [_d,BUTTON,[0,20 + _sizeY * 9,_sizeX,_sizeY],_ctg] call createWidget;
	_switchTarg ctrlSetText "Сменить цель";
	_switchTarg ctrlAddEventHandler ["MouseButtonUp",proxEd_switchTarget];

	_switchTarg = [_d,BUTTON,[0,20 + _sizeY * 10,_sizeX,_sizeY],_ctg] call createWidget;
	_switchTarg ctrlSetText "Переключить частицы";
	_switchTarg ctrlAddEventHandler ["MouseButtonUp",proxEd_switchParticle];

};

proxEd_loadByConfig = {
	_data = call proxEd_getMainInput;
	_data call proxEd_createObject;
};

proxEd_loadByGameObject = {
	
	_input = call proxEd_getMainInput;
	_o = instantiate(_input);
	_model = getVar(_o,model);
	traceformat("Loaded from game object %1; Ref %2",_input arg _o);
	delete(_o);
	_model call proxEd_createObject;
};

proxEd_indexTarget = 0;
proxEd_switchTarget = {

	proxEd_targetList = proxEd_targetList - [objNULL];

	INC(proxEd_indexTarget);
	if (proxEd_indexTarget > (count proxEd_targetList - 1)) then {
		proxEd_indexTarget = 0;
	};

	proxEd_target = proxEd_targetList select proxEd_indexTarget;
	call proxEd_onChangeObjectData;
};


proxEd_switchParticle = {
	if (isnil { proxEd_object getvariable '__light'}) then {
		(parseNumber call proxEd_getMainInput) call proxEd_loadParticles
	} else {
		call proxEd_disableParticles;
	};
};

proxEd_loadParticles = {
	private _cfg = _this;
	[_cfg,proxEd_object] call le_loadLight;
};
proxEd_disableParticles = {
	[proxEd_object] call le_unloadLight;

	proxEd_object setvariable ['__light',null];
};

proxEd_loadFromBuffer = {
	_input = call proxEd_getMainInput;
	_model = _input call proxIt_prepName;
	warningformat("[ProxEd]:	Settings are not saved %1",proxEd_data_all);

	_data_all = proxIt_configData getVariable _model;
	if isNull(_data_all) exitWith {
		errorformat("[ProxEd]:	Canf find model %1 in config data",_model);
	};

	for "_i" from 0 to (count proxEd_data_all) - 1 do {
		_probDataSegment = _data_all get _i;

		if (isNull(_probDataSegment)) then {
			_data = parseSimpleArray str proxIt_def;
			proxEd_data_all set [_i,parseSimpleArray str _data];
			logformat("[ProxEd]:	Created new selection %1 (%3) -> %2",_i arg _data arg INV_LIST_VARNAME select _i);
		} else {
			proxEd_data_all set [_i,parseSimpleArray str _probDataSegment];
			logformat("[ProxEd]:	Loaded selection %1 (%3) -> %2",_i arg _probDataSegment arg INV_LIST_VARNAME select _i);
		};
	};

	_model call proxEd_createObject;
};

proxEd_saveConfig = {
	_model = (getModelInfo proxEd_object) select 1;
	_text = format["model(""\%1"") [",_model];
	#define endsWith(item) ((_text select [count _text - 1,1]) == item)
	{
		_x params ["_pos","_vec"];
		_haveFound = false;
		if (equals(_pos,proxIt_vec) && equals(_vec,proxIt_vec)) then {
			/*if endsWith("[") then {
				_text = _text + format["[%1,proxIt_posvec]",_forEachIndex];
			} else {
				_text = _text + format[",[%1,proxIt_posvec]",_forEachIndex];
			};*/
			_haveFound = true;
		};
		if (!_haveFound) then {
			_posText = "";
			_vecText = "";
			if equals(_pos,proxIt_vec) then {
				_posText = "proxIt_vec";
			} else {
				_posText = str _pos;
			};
			if equals(_vec,proxIt_vec) then {
				_vecText = "proxIt_vec";
			} else {
				_vecText = str _vec;
			};
			if endsWith("[") then {
				_text = _text + format["[%1,[%2,%3]]",INV_LIST_VARNAME select _forEachIndex,_posText,_vecText];
			} else {
				_text = _text + format[",[%1,[%2,%3]]",INV_LIST_VARNAME select _forEachIndex,_posText,_vecText];
			};

		};

	} foreach proxEd_data_all;

	_text = _text + "]";

	logformat("[ProxEd]: Data saved and putted in clipboard: %1",_text);
	copyToClipboard _text;

};

proxEd_createObject = {
	if !isNullReference(proxEd_object) then {
		deleteVehicle proxEd_object;
	};
	_input = _this;

	proxEd_object = createSimpleObject [_input,[0,0,0]];
	traceformat("Loaded from config or class %1",proxEd_object);
	call proxEd_onChangeObjectData;
	proxEd_object
};

proxEd_getMainInput = {
	ctrlText (getDisplay getvariable 'proxEd_input')
};


proxEd_onChangeObjectData = {
	//		[INV_BACKPACK, INV_ARMOR, INV_HEAD, INV_BACK,INV_CLOTH,INV_FACE,INV_HAND_R,INV_HAND_L,INV_BELT]
	_seldata = proxIt_list_selections;

	[proxEd_object,proxEd_data_vec] call BIS_fnc_setObjectRotation;

	proxEd_object attachTo [
		proxEd_target,
		proxEd_data_pos,
		_seldata select proxEd_curSelection,
		true];

	{
		_x ctrlSetTooltip ("Pos " + (["x","y","z"] select (_x getvariable 'index')) + str ((proxEd_data_pos select (_x getvariable 'index')) / proxEd_modifierPosBias));
		_x sliderSetPosition ((proxEd_data_pos select (_x getvariable 'index')) * proxEd_modifierPosBias);
	} foreach (getDisplay getvariable 'posarr');

	{
		_x ctrlSetTooltip ("Vec " + (["x","y","z"] select (_x getvariable 'index')) + str ((proxEd_data_vec select (_x getvariable 'index'))));
		_x sliderSetPosition ((proxEd_data_vec select (_x getvariable 'index')));
	} foreach (getDisplay getvariable 'vecarr');
};

proxEd_closeEditor = {
	nextFrame({call displayClose});
};
