// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "ServerInteraction_ThrowModes.sqf"
/*
	Публичные данные
*/
interact_map_secondPass = createHashMap;
#define addInteractSecondPassObj(path) interact_map_secondPass set [tolower path,false]
#include "interact_secondPassObjects.sqf"

//Проверка
#define isNotSecondPassObject(obj) (interact_map_secondPass getOrDefault [toLower(getModelInfo (obj) select 1),true])

interact_throwlist = [];

//Это псевдоним функции si::getIntersectData()
interact_th_getItscData = {
	params ["_p1","_p2",["_ig1",objnull],["_ig2",objnull]];

	private _ins = lineIntersectsSurfaces [
  		AGLToASL _p1,
  		AGLToASL _p2,
  		_ig1,
		_ig2,
		true,
		1,
		INTERACT_LODS_CHECK_STANDART
 	];
	if (count _ins == 0) exitWith {[objnull,[0,0,0],[0,0,0]]};
	if isNotSecondPassObject(_ins select 0 select 2) exitWith {[_ins select 0 select 2,asltoatl (_ins select 0 select 0),_ins select 0 select 1]};
	_ins = lineIntersectsSurfaces [
		AGLToASL _p1,
		AGLToASL _p2,
  		_ig1,
		_ig2,
		true,
		1,
		INTERACT_LODS_CHECK_GEOM
 	];
	if (count _ins == 0) exitWith {[objnull,[0,0,0],[0,0,0]]};
	[_ins select 0 select 2,asltoatl (_ins select 0 select 0),_ins select 0 select 1]
};

//копия с noe_visual_getRelRadiusPos. Константа DROP_RADIUS 0.6 на текущий момент
interact_th_getRelRadiusPos = {
	params ["_posI",["_dirPos",random 360],["_dropRad",0.6]];
	[(_posI select 0) + (sin _dirPos) * _dropRad, (_posI select 1) + (cos _dirPos) * _dropRad, _posI select 2];
};

//Событие остановки света
interact_th_onThrowingEnd = {
	params ["_obj","_targ"];
	if isNullReference(_obj) exitWith {false};

	#ifdef SP_MODE
	[_obj,_targ] call sp_internal_handleTargetThrowingContact;
	#endif

	/*_pos = if (typeof _barrierObj == BASIC_MOB_TYPE) then {
		[getPosATL _barrierObj] call interact_th_getRelRadiusPos
	} else {
		getPosATL _tempObj
	};
	_obj setPosAtl _pos;
	_obj setDir (_obj getVariable "_genRDir");
	_obj setVectorUp [0,0,1];*/
	if ([_obj] call le_isLoadedLight) then {
		[_obj] call le_unloadLight;
	};
	deleteVehicle _obj;
};

// internal impl. of calculating start point of projectile
interact_th_calculateStartPoint = {
	if (_mode == "th") exitWith {_tempObj modelToWorld [0,0.1,0]};
	if (_mode == "sh") exitWith {
		_sourceObj modelToWorld ((_sourceObj selectionPosition "spine3")vectorAdd [0,0.5,0]);
	};
	_vp //default position
};

interact_th_addTask = {
	params ["_mode","_ctx"]; // _mode in ["th","sh"]
	_ctx params ["_mdlOrEnum","_vp","_vd","_dist","_pd","_lvl","_spd",["_LE_eff",0]];

	private _dur = _dist/_spd;
	private _tempObj = createSimpleObject[
		ifcheck(equalTypes(_mdlOrEnum,""),_mdlOrEnum,[_mdlOrEnum] call model_getAssoc),
	[0,0,0],true];
	private _sourceObj = ifcheck(isNullVar(_mob),player,_mob);

	if (_mode == "sh") then {
		//params ["_file","_source",["_vol",1],["_pitch",1],["_maxDist",20],["_soundExtension","ogg"],["_offset",0],["_isLocal",false]];
		private _argsCtx = [interact_map_shassoc_keyint get _vp,_sourceObj,null,_vd select 0,_vd select 1];
		invokeAfterDelayParams(soundProcessor_play,0.01,_argsCtx);

		_tempObj setPosATL ifcheck(equals(_sourceObj,player),cam_renderPos,_sourceObj modelToWorld (_sourceObj selectionPosition "head"));
		_tempObj setVectorDirAndUp ifcheck(equals(_sourceObj,player),cam_renderVec,vec2(vectordir _sourceObj,vectorUp _sourceObj));
		#ifdef SP_MODE
		if not_equals(_sourceObj,player) then {
			_tempObj setVectorDirAndUp (_sourceObj getvariable "__sp_temp_lookat_redirect");
		};
		#endif
	} else {
		_tempObj setPosATL _vp;
		_tempObj setVectorDirAndUp _vd;
	};

	{_tempObj disableCollisionWith _x} forEach allPlayers;//(_tempObj nearEntities _dist);
	//set basic vars
	_tempObj setVariable ["_startPoint",call interact_th_calculateStartPoint];
	_tempObj setposatl (_tempObj getVariable "_startPoint");
	_tempObj setVariable ["_orient",[_tempObj] call model_getPitchBankYaw];
	private _ep = _tempObj modelToWorld [0,_dist,0];
	MODARR(_ep,2,/_pd);
	_tempObj setVariable ["_endPoint",_ep];
	_tempObj setVariable ["_startTime",tickTime];
	_tempObj setVariable ["_durationTime",tickTime + _dur];
	_tempObj setVariable ["_speed",_spd];
	_tempObj setVariable ["_distance",_dist];
	//_tempObj setVariable ["_bbx",(boundingBoxReal _tempObj) select 2];
	(boundingBoxReal _tempObj select 0)params ["_b1","","_b2"];
	_tempObj setVariable ["_bbxDat",[[_b1,0,_b2],[-_b1,0,_b2],[_b1,0,-_b2],[-_b1,0,-_b2]]];
	_tempObj setVariable ["_points",[
		_tempObj getVariable "_startPoint",
		_tempObj modelToWorld [0,_dist*_pd/100,_lvl],
		_tempObj getVariable "_endPoint"
	]];
	_tempObj setVariable ["_lastNonCastedPos",_tempObj getVariable "_startPoint"];
	_tempObj setVariable ["_throwerObj",_sourceObj];

	_tempObj setVariable ["_throwAlg", interact_th_delegates select (interact_th_map_codeAssoc getOrDefault [_mode,0])];
	_tempObj setVariable ["_throwMode",_mode];

	//add second objects to shotguns
	if (_mode == "sh") then {
		if equals(_LE_eff,"BFX_BULLET_SHOTGUN") then {
			//TODO: use effects as shot
		};
	};


	if !isNullVar(_LE_eff) then {
		if (_LE_eff call le_isLightConfig) exitWith {
			[_LE_eff,_tempObj] call le_loadLight;
		};
		if (_LE_eff call bfx_containConfig) exitWith {
			[
				_LE_eff,
				ifcheck(isNullVar(_mob),player,_mob),
				[ifcheck(_slotHandAtt==INV_HAND_L,-1,1)]
			] call bfx_doShot;
		};
	};
	#ifdef SP_MODE
		//do noting
	#else
	//Вне МП на клиенте не кидаем
	if !isMultiplayer exitWith {
		deleteVehicle _tempObj;
	};
	#endif
	interact_throwlist pushBack _tempObj;
};

interact_th__clith = {
	_del = false;
	{
		if isNullReference(_x) then {_del = true;continue;};

		_endTime = _x getVariable "_durationTime";
		if (tickTime > _endTime) then {
			_pos = _x getVariable "_lastNonCastedPos";
			([_pos,_pos vectorDiff [0,0,2000],_x] call interact_th_getItscData) params ["_obj","_p","_norm"];
			if (_p distance (getPosATL _x) > 0.2) then {
				_x setPosATL _p;
				_x setVectorUp _norm;
			};

			[_x,_obj] call interact_th_onThrowingEnd;
			_del = true;
			continue;
		};
		_thrower = _x getVariable "_throwerObj";
		_interp = linearConversion [
			_x getVariable "_startTime",
			_endTime,
			tickTime,
			0,
			1
		];

		_newPos = _interp bezierInterpolation (_x getVariable "_points");

		_oldpos = getPosATL _x;
		/*
			Рейкаст пред поза и текущего
		*/
		([_oldpos,_newPos,_x] call interact_th_getItscData) params ["_obj","_p","_norm"];
		if equals(_thrower,_obj) then {_obj = objNULL};
		if isNullReference(_obj) then {
			_to = _x;
			//_bbx = _to getVariable "_bbx";
			{
				([_to modelToWorld _x,_newPos,_to] call interact_th_getItscData) params ["_objex","_pex","_normex"];
				if equals(_thrower,_objex) then {_objex = objNULL};
				if !isNullReference(_objex) exitWith {
					_obj = _objex;
					_p = _pex;
					_norm = _normex;
				};
			} foreach (_to getVariable "_bbxDat");
		};

		//ничто не мешает
		if isNullReference(_obj) then {
			call ((_x getVariable "_throwAlg") select 0);
		} else {
			call ((_x getVariable "_throwAlg") select 1);
		};

	} foreach interact_throwlist;
	if (_del) then {
		modvar(interact_throwlist) - [objNull];
	};
};
if (!isServer && isMultiplayer) then {startUpdate(interact_th__clith,0)};

interact_th_map_codeAssoc = createHashMapFromArray [["th",0],["sh",1]];

// mode -> vec2: success fly, intersection
interact_th_delegates = [
	//mode for throwing
	[
		{
			_x setPosATL _newPos;
			_orient = _x getVariable "_orient";
			// 3 is CONSTANT
			MODARR(_orient,0, - 3 * (_x getVariable "_speed"));
			[_x,_orient] call model_SetPitchBankYaw;
			_x setVariable ["_lastNonCastedPos",_newPos];
		},
		{
			_angle = _norm select 2;
			_hasMoving = (_oldpos distance _newPos) > 0.01;
			_orient = _x getVariable "_orient";
			if (_angle < 0.65 && _hasMoving) then {
				//отскок
				/*
					инверсия ротации и применение
					Режем скорость от проделанного расстояния
				*/
				MODARR(_orient,0,* -1);
				MODARR(_orient,2,+rand(-90,90));
				[_x,_orient] call model_SetPitchBankYaw;
				_x setVariable ["_startPoint",_x modelToWorld [0,0.05,0]];
				_newdist = (_x getVariable "_distance") * (_interp*100)/100;
				_x setVariable ["_distance",_newdist];
				_x setVariable ["_endPoint",(_x modelToWorld [0,_newdist,0]) vectordiff [0,0,_newPos select 2]];
				_x setVariable ["_points",[
					_x getVariable "_startPoint",
					_x getVariable "_endPoint"
				]];
				_x setVariable ["_startTime",tickTime];
				_newSpeed = -(_x getVariable "_speed")/2;
				_newdur = _newdist/(abs _newSpeed);
				_x setVariable ["_durationTime",tickTime + _newdur];
				_x setVariable ["_speed",_newSpeed];
			} else {
				_x setPosATL _p;
				//Остановка
				[_x,_obj] call interact_th_onThrowingEnd;
				_del = true;
			};
		}
	],
	//mode for shooting
	[
		{
			_x setPosATL _newPos;
			_x setVectorDir (vectorNormalized ((_x getVariable "_lastNonCastedPos") vectorDiff _newPos  ) vectorMultiply -1);
			_x setVariable ["_lastNonCastedPos",_newPos];

			//do miss sound around players (non thrower call)
			if (player distance _x <= 6) then {
				if !(_x getVariable ["_isCatchedMissSound",false]) then {
					if not_equals(player,_x getVariable "_throwerObj") then {
						["guns\miss"+str randInt(1,4),_x,null,rand(0.8,1.3),25] call soundLocal_play;
						[0.03,5.1,0.12,0.4] call cam_addCamShake; //vfx cam effect
						_x setVariable ["_isCatchedMissSound",true];
					};
				};
			};
		},
		{
			_cos = (vectorDirVisual _x) vectorCos _norm;
			if (_cos >= -0.45 && _cos <= 0.45) then {
				[_x,_obj] call interact_th_onThrowingEnd;
				_del = true;
			} else {
				[_x,_obj] call interact_th_onThrowingEnd;
				_del = true;
			};
		}
	]
];

interact_shassoc_idx = 0;
interact_map_shassoc_keyint = createHashMap;
interact_map_shassoc_keystr = createHashMap;

{
	private _str = _x;
	INC(interact_shassoc_idx);
	interact_map_shassoc_keyint set [interact_shassoc_idx,_str];
	interact_map_shassoc_keystr set [_str,interact_shassoc_idx];
} foreach [
	"guns\pistol_fire1",
	"guns\pistol_fire2",
	"guns\revolver_fire",
	"guns\hpistol_fire",
	"guns\pistoln1","guns\pistoln2",
	"guns\la_fire1","guns\la_fire2","guns\la_fire3","guns\la_fire4",
	"guns\ltrifle_fire",
	"guns\ak_fire",
	"guns\bar_fire",
	"guns\shotgun_fire",
	"guns\shotgunp_fire",
	"guns\revolver"
	//place here new shoot sounds
];
