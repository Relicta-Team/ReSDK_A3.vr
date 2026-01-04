// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>
#include <..\Networking\Network.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include "ServerInteraction_ThrowModes.sqf"


//Различные тесты и проверки
#include "ServerInteractionTests.sqf"
//Проверщик объектов с проблемными моделями, через которые не проходит рейкаст
#include "ServerInteractionShared.sqf"


//клиентское использование интеракта для INTERACT_LODS_CHECK_GEOM
#include <..\..\client\Interactions\interact.hpp>



/*
	Алгоритм расчета траектории: si_debug_projectile (si::projectile)
	Он подходит только для персонажей. Боты стреляют до выбранной цели с коррекцией
*/

si_throwingProcess = {
	params ["_mob","_item","_startPoint"];
	/*
	Вы можете метать
	предметы весом до 2×БГ одной ру-
	кой, для более тяжёлых требуется
	две руки. Сделайте бросок ЛВ-3
	для броска в конкретную цель
	или просто ЛВ для попадания в
	достаточно большую зону. При-
	мените стандартные модифика-
	торы за размер цели, скорость и
	дистанцию.

	Дистанция броска
	1. Разделите вес предмета в
	фунтах на ваш БГ, чтобы вычис-
	лить «коэффициент веса».
	2. Найдите коэффициент веса
	в колонке «коэффициент веса»
	из таблицы выше. Округляйте до
	большего значения.
	3. Запомните соответствую-
	щий Модификатор дистанции из
	колонки «модификатор дистан-
	ции».
	4. Умножьте вашу СЛ на мо-
	дификатор дистанции, чтобы
	определить дистанцию (в ярдах)
	на которую вы можете метнуть
	предмет.

	*/
};

//Общий объект рэйкаста. Арма у нас в одном потоке так что боятся нечего
si_internal_rayObject = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];

//Возвращает визуальный объект
si_rayCast = {
	params ["_rayPosStart","_rayVector",["_retVirtual",false],["_bias",0.001],["_refposret",[]],["_ignored1",objNull],["_normal",[]]];
	#define SI_RAYCAST_DISTANCE 2000
	//Флаг теста этого метода
	//#define __si_raycast_test_0_6_262

	si_internal_rayObject setposatl _rayPosStart;
	si_internal_rayObject setVectorDirAndUp _rayVector;
	//Используются данные визуализации для честных значений (времени рендеринга)
	_rayPosStart = si_internal_rayObject modelToWorldVisual [0,_bias,0]; //Смещаем начальную точку чтобы персонаж не кинул сам в себя
	private _rayPosEnd = si_internal_rayObject modelToWorldVisual [0,SI_RAYCAST_DISTANCE,0];

	([_rayPosStart,_rayPosEnd,_ignored1] call si_getIntersectData) params ["_obj","_pos","_norm"];
	_refposret append _pos;
	_normal append _norm;

	#ifdef __si_raycast_test_0_6_262
		si_internal_rayObject setposatl _pos;
	#endif

	private _defaultReturn = ifcheck(_retVirtual,nullPtr,objnull);

	//Возвращаем правильный тип если объект не найден
	if isNullReference(_obj) exitWith {
		#ifdef __si_raycast_test_0_6_262
			breakpoint(_obj);
		#endif
		_defaultReturn
	};
	#ifdef __si_raycast_test_0_6_262
		lastobj = _obj;
	#endif

	//post ngo redirect
	#ifdef EDITOR_OR_SP_MODE
	//double check
		if (_obj call noe_client_isNGO) then {
			_obj = _obj call noe_client_getNGOSource;
		} else {
			if (_obj call noe_server_isNGO) then {_obj = _obj call noe_server_getNGOSource};
		};
	#else
		if (_obj call noe_server_isNGO) then {_obj = _obj call noe_server_getNGOSource};
	#endif

	#ifdef __si_raycast_test_0_6_262
		breakpoint(_obj);
		lastdat = _obj;
	#endif

	//Логика редактора
	#ifdef EDITOR_OR_SP_MODE
		if (count allVariables _obj == 0) exitWith {_defaultReturn};
		if (typeof _obj == BASIC_MOB_TYPE) then {
			ifcheck(_retVirtual,_obj getVariable "link",_obj);
		} else {
			if !isNull(_obj getvariable "bytearr") exitWith {ifcheck(_retVirtual,_obj getVariable vec2("link",_defaultReturn),_obj);};
			ifcheck(_retVirtual,pointerList get (_obj getVariable "ref"),(pointerList get (_obj getVariable "ref")) getVariable "loc");
		};
	#else
		//Unknown object check
		if isNull(_obj getVariable "link") exitWith {_defaultReturn};

		ifcheck(_retVirtual,_obj getVariable vec2("link",_defaultReturn),_obj);
	#endif
};

//системная функция обработки и модификации параметра (конвертация из мирового объекта в виртуальный)
si_handleObjectReturnCheckVirtual = {
	params ["_obj"];

	private _defaultReturn = nullPtr;

	//post ngo redirect
	#ifdef EDITOR_OR_SP_MODE
	//double check
		if (_obj call noe_client_isNGO) then {
			_obj = _obj call noe_client_getNGOSource;
		} else {
			if (_obj call noe_server_isNGO) then {_obj = _obj call noe_server_getNGOSource};
		};
	#else
		if (_obj call noe_server_isNGO) then {_obj = _obj call noe_server_getNGOSource};
	#endif

	//Логика редактора
	#ifdef EDITOR_OR_SP_MODE
		if (count allVariables _obj == 0) exitWith {_defaultReturn};
		if (typeof _obj == BASIC_MOB_TYPE) then {
			_obj getVariable "link";
		} else {
			if !isNull(_obj getvariable "bytearr") exitWith {_obj getVariable vec2("link",_defaultReturn);};
			pointerList get (_obj getVariable "ref");
		};
	#else
		//Unknown object check
		if isNull(_obj getVariable "link") exitWith {_defaultReturn};

		_obj getVariable vec2("link",_defaultReturn);
	#endif
};

//Получает информацию об объекте пересечения в виде: [object, intersect position as ATL,vectorUp lod]
//При изменении данной функции исправь реализацию в interact::th::getItscData()
si_getIntersectData = {
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
	if isNotSecondPassObject(_ins select 0 select 2) exitWith {
		[_ins select 0 select 2,asltoatl (_ins select 0 select 0),_ins select 0 select 1]
	};
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

si_getIntersectDataV2 = {
	params ["_p1","_p2",["_ig1",objnull],["_ig2",objnull]];
	private _ins = lineIntersectsSurfaces [
  		AGLToASL _p1,
  		AGLToASL _p2,
  		_ig1,
		_ig2,
		true,
		100,
		INTERACT_LODS_CHECK_STANDART
 	];
	#ifdef EDITOR_OR_SP_MODE
	_ins = _ins select {isNull((_x select 2)getvariable "link")};
	#endif
	if (count _ins == 0) exitWith {[objnull,[0,0,0],[0,0,0]]};
	
	[_ins select 0 select 2,asltoatl (_ins select 0 select 0),_ins select 0 select 1]
};

si_getIntersectObjects = {
	params ["_p1","_p2",["_ig1",objNUll],["_ig2",objNUll],["_countObjs",10],["_retUnique",true],["_retAsVObj",false],["_retIPos",false]];
	private _ins = lineIntersectsSurfaces [
  		AGLToASL _p1,
  		AGLToASL _p2,
  		_ig1,
		_ig2,
		true,
		_countObjs,
		INTERACT_LODS_CHECK_STANDART,
		_retUnique
 	];
	//second pass
	if (count _ins == 0) then {
		_ins = lineIntersectsSurfaces [
			AGLToASL _p1,
			AGLToASL _p2,
			_ig1,
			_ig2,
			true,
			_countObjs,
			INTERACT_LODS_CHECK_GEOM,
			_retUnique
		];
	};
	if (count _ins == 0) exitWith {[]};
	if _retAsVObj then {
		if _retIPos then {
			_ins apply {
				[[_x select 2] call si_handleObjectReturnCheckVirtual, asltoatl (_x select 0)]
			}
		} else {
			_ins apply {
				[_x select 2] call si_handleObjectReturnCheckVirtual
			}
		};
	} else {
		if _retIPos then {
			_ins apply {
				[_x select 2,asltoatl (_x select 0)]
			}
		} else {
			_ins apply {_x select 2}
		};
	};
};

#include "ServerInteraction_rayTrace.sqf"

//Отладчик эдитора
//#define SI_THROW_DEBUG
#define SH_DEBUG_SHOTGUN

//Список задач летящих объектов
si_throwTasks = []; //obj, vecpos, vecdir, dist, precdown, downlevel, speed

#ifdef SI_THROW_DEBUG
#define debug_t(data) traceformat("[THROW_DEBUG]: %1",data)
#define debug_line(p,v,clr) __D_IL_OBJ = "Sign_Arrow_F" createVehicle [0,0,0]; si_debug_listVectors pushBack __D_IL_OBJ; \
__D_IL_OBJ setPosAtl p; __D_IL_OBJ setVectorUp v; __D_IL_OBJ setObjectTexture [0,format["#(rgb,8,8,3)color(%1,%2,%3,1)",clr select 0,clr select 1,clr select 2]];

si_debug_listVectors = [];
#else
	#define debug_t(data)
	#define debug_line(p,v,clr)
#endif

si_addThrowTask = {
	params ["_gobj","_vecPos","_vecDir","_distance","_precdown","_leveldown","_speed","_refThis",["_throwMode",SI_TM_THROW],"_addPenaltySupressFire"];
	private _duration = _distance / _speed; //находим время полета объекта

	#ifdef SI_THROW_DEBUG
	{deleteVehicle _x} foreach si_debug_listVectors;
	#endif

	private _model = getVar(_gobj,model);
	private _bullet = nullPtr;
	if (_throwMode == SI_TM_SHOOT) then {
		_bullet = callFuncParams(_gobj,prepareProjectile,_refThis);
		_model = callFunc(_bullet,getProjectileModel);
	};

	private _tempObj = createSimpleObject[_model,[50,50,50],true];
	#ifndef EDITOR_OR_SP_MODE
	_tempObj hideObject true;
	#endif

	_tempObj setPosATL _vecPos;
	_tempObj setVectorDirAndUp _vecDir;
	//{_tempObj disableCollisionWith _x} forEach allPlayers;//(_tempObj nearEntities _distance);

	_tempObj setVariable ["_throwerRef",_refThis];
	_tempObj setVariable ["_startPoint",_tempObj modelToWorld [0,0.1,0]];
	_tempObj setVariable ["_basePoint",_tempObj modelToWorld [0,0.1,0]];
	_tempObj setposatl (_tempObj getVariable "_startPoint");
	_tempObj setVariable ["_orient",[_tempObj] call model_getPitchBankYaw];
	_tempObj setVariable ["_midPoint",_tempObj modelToWorld [0,_distance*_precdown/100,_leveldown]];
	private _ep = _tempObj modelToWorld [0,_distance,0];
	MODARR(_ep,2,/_precdown);
	_tempObj setVariable ["_endPoint",_ep];
	_tempObj setVariable ["_startTime",tickTime];
	_tempObj setVariable ["_durationTime",tickTime + _duration];
	_tempObj setVariable ["_speed",_speed];
	_tempObj setVariable ["_distance",_distance];
	//_tempObj setVariable ["_bbx",(boundingBoxReal _tempObj) select 2];
	(boundingBoxReal _tempObj select 0)params ["_b1","","_b2"];
	_tempObj setVariable ["_bbxDat",[[_b1,0,_b2],[-_b1,0,_b2],[_b1,0,-_b2],[-_b1,0,-_b2]]];
	_tempObj setVariable ["_points",[
		_tempObj getVariable "_startPoint",
		_tempObj getVariable "_midPoint",
		_tempObj getVariable "_endPoint"
	]];
	_tempObj setVariable ["_lastNonCastedPos",_tempObj getVariable "_startPoint"];
	_tempObj setVariable ["_throwerObj",getVar(_refThis,owner)];


	_tempObj setVariable ["_throwAlg",si_throwModes select _throwMode];

	call {
		if (_throwMode == SI_TM_THROW) exitWith {
			_tempObj setVariable ["_sysRef",_gobj];

			_tempObj setVariable ["_dmgData",callFuncParams(_gobj,thGetDamageData,_refThis)];
			_tempObj setVariable ["_isContacted",false];

			_tempObj setVariable ["_finalizeAction",si_onThrowingEnd];

			//interact_th_addTask["_mdlOrEnum","_vp","_vd","_dist","_pd","_lvl","_spd","_LE_eff"];
			private _dat = [
				[_model] call model_getAssoc,
				_vecPos,
				_vecDir,
				_distance,
				_precdown,
				_leveldown,
				_speed
			];
			if getVar(_gobj,lightIsEnabled) then {
				_dat pushBack getVar(_gobj,light);
			};

			//replicate throw data
			callFunc(_refThis,getAttackerWeapon) params ["_attWeapon","_attItem"];
			callFuncParams(_refThis,applyAttackVisualEffects,_attWeapon arg "throw" arg _dat);
			callFuncParams(_refThis,addStaminaLoss,6);

			//unlink item from hand
			callFuncParams(_refThis,removeItem,_item);
			
			//системная установка владелца как летящего объекта
			setVar(_gobj,loc,flyingObject);
		};
		if (_throwMode == SI_TM_SHOOT) exitWith {
			_tempObj setVariable ["_sysRef",_bullet];
			_tempObj setVariable ["_finalizeAction",si_onBulletAct];

			_tempObj setVariable ["_dmgData",callFuncParams(_gobj,getShootDamageData,_bullet arg _refThis)];
			if !isNullVar(_addPenaltySupressFire) then {
				_tempObj setVariable ["__penaltySupressFire__",_addPenaltySupressFire];
			};

			private _vdata = callFunc(_gobj,getAttackVisualData);
			callFunc(_gobj,getShootSound) params ["_path","_pitchMin","_pitchMax"];
			private _dat = [
				[_model] call model_getAssoc,
				interact_map_shassoc_keystr get _path,
				[rand(_pitchMin,_pitchMax),callFunc(_gobj,getShootSoundDistance)],
				_distance,
				_precdown,
				_leveldown,
				_speed
			];
			if not_equals(_vData,"") then {
				_dat pushBack _vData;
			};

			callFuncParams(_refThis,applyAttackVisualEffects,_gobj arg "shot" arg _dat);
			//callFuncParams(_gobj,playShootSound,_refThis);
			
			setVar(_bullet,loc,flyingObject);
		};
	};

	debug_t("-> add task " + getVar(_gobj,name))
	si_throwTasks pushBack _tempObj;
};

//Системная функция когда возникло действие с летящим итемом, требующим загрузки в точке действия
//например взрыв летящей гранаты
si_onFlyWorldActionLoad = {
	params ["_tempObj"];
	debug_t("start onfly action object")
	if isNullReference(_tempObj) exitWith {false};
	private _item = _tempObj getVariable ["_sysRef",nullPtr];
	private _thrower = _tempObj getVariable ["_throwerRef",nullPtr];
	setVar(_item,_flagFlyLoad,true);
	private _pos = getPosATL _tempObj;
	private _real = [_item,_pos,random 360,[0,0,1]] call noe_loadVisualObject;
	
	callFunc(_item,onStopFlying);
	debug_t("++++++++++++++DONE++++++++++++++")
	deleteVehicle _tempObj;
	true;
};

si_onThrowingEnd = {
	params ["_tempObj","_barrierObj"];
	debug_t("start stopping object")
	//params ["_item","_posAtl",["_dir",random 360],["_vup",vec3(0,0,1)]];
	if isNullReference(_tempObj) exitWith {false};
	private _item = _tempObj getVariable ["_sysRef",nullPtr];
	private _thrower = _tempObj getVariable ["_throwerRef",nullPtr];
	if (isNullReference(_item) || isNullReference(_thrower)) exitWith {deleteVehicle _tempObj; false};
	debug_t("object not null. load positions")
	private _pos = if (typeof _barrierObj == BASIC_MOB_TYPE) then {
		debug_t("mob interacted-V")
		[getPosATL _barrierObj] call noe_visual_getRelRadiusPos
	} else {
		debug_t("object interacted")
		getPosATL _tempObj
	};
	debug_t(format vec4("POS DATA LOAD: [%1:%2:%3]",_item,_pos,_tempObj))
	private _real = [_item,_pos,random 360,[0,0,1]] call noe_loadVisualObject;
	if isNullReference(_real) exitWith {
		deleteVehicle _tempObj; false;
	};
	callFuncParams(_item,onDrop,_thrower arg true);
	debug_t("++++++++++++++DONE++++++++++++++")
	_tempObj setvariable ["__pend_del",true];
	deleteVehicle _tempObj;

	true;
};

si_onBulletAct = {
	params ["_tempObj","_barrierObj"];
	debug_t("start bullet action" + format[" %1 %2" arg _tempObj arg _barrierObj])
	
	if isNullReference(_tempObj) exitWith {false};
	private _item = _tempObj getVariable ["_sysRef",nullPtr];
	private _thrower = _tempObj getVariable ["_throwerRef",nullPtr];
	if (isNullReference(_item) || isNullReference(_thrower)) exitWith {
		debug_t("some null references: " + format["%1 %2" arg _item arg _thrower])
		deleteVehicle _tempObj;
		delete(_item);
		false
	};

	private _targ = _barrierObj getVariable "link";

	#ifdef EDITOR_OR_SP_MODE
	if isNullVar(_targ) then {
		{
			_targ = _obj getVariable _x;

			if !isNullVar(_targ) exitWith {
				if equalTypes(_targ,"") then {
					_targ = pointerList get _targ;
				};
			};
		} foreach ["ref","ptr"];
	};
	#endif
	(_tempObj getVariable "_dmgData") params ["_dam","_type","_selection","_usr","_weapon"];
	private _throwed = _tempObj getVariable "_sysRef";

	private _distance = (_tempObj getVariable "_basePoint") distance _p;
	private _halfDistance = callFuncParams(_weapon,getHalfDistance,_usr);

	#ifdef SH_DEBUG_SHOTGUN
		#define logshotgun(txt,vars) errorformat("[SH_DEBUG_SHOTGUN]: %1 %2",txt arg [vars]);
	#else
		#define logshotgun(txt,vars)
	#endif

	logshotgun("Process bullet damage: ",_dam arg _type arg _selection arg _usr arg _weapon)
	logshotgun("Distance and half distance info:",_distance arg _halfDistance)

	//половина повреждений при дистанции большей чем 1/2
	if (_distance >= _halfDistance) then {
		logshotgun("Too much distance. old and new damage:",_dam arg round(_dam/2))
		_dam = round (_dam / 2);
	};
	private _exShotDRMod = null; //exref (used in applyDamage)
	//для дроби правила
	if isImplementFunc(_throwed,getFractionModifier) then {
		logshotgun("Shotgun shot! Distance and half distance:",_distance arg _halfDistance)
		if (_distance < _halfDistance) then {
			if (_distance < precentage(_halfDistance,10)) then {
				logshotgun("Very low distance: ",_distance arg precentage(_halfDistance,10))
				private _modLowDist = floor(callFunc(_throwed,getFractionModifier) / 2);
				callFuncParams(_weapon,getBasicDamage,_usr) params [["_dices",1],["_mod",1]];

				_dam = ((_dices call gurps_throwdices) * _modLowDist) + (_mod * _modLowDist);
				_exShotDRMod = _modLowDist;
				logshotgun("New damage and DR modif:",_dam arg _exShotDRMod)
			} else {
				private _modLowDist = floor(callFunc(_throwed,getFractionModifier) / 2);
				callFuncParams(_weapon,getBasicDamage,_usr) params [["_dices",1],["_mod",1]];

				_dam = ((_dices call gurps_throwdices) * _modLowDist) + (_mod * _modLowDist);
				//_exShotDRMod = _modLowDist;
				logshotgun("New damage and DR modif:",_dam arg _exShotDRMod)
			};
		};

	};

	//подавление при попадании рядом с целью
	_penaltySupressFire = _tempObj getvariable ["__penaltySupressFire__",0]; 
	if (_penaltySupressFire > 0) then {
		if (_tempObj getVariable ["_psf_lastcheckpos",vec3(0,0,0)] distance _p > 5) then {
			//collect mobs
			private _list = ["Mob",_p,5,true] call getMobsOnPosition;

			{
				callFuncParams(_x,handlePenaltySUpressFireAdd,_penaltySupressFire);
			} foreach (_list-[_thrower]);
		};

	};

	callFuncParams(_targ,onBulletAct,_dam arg _type arg _selection arg _usr arg _distance arg _throwed);

	debug_t("++++++++++++++DONE++++++++++++++")
	_tempObj setvariable ["__pend_del",true];
	deleteVehicle _tempObj;

	true;
};

//Серверный обработчик летащих объектов
__onThrowing = {
	_del = false;
	{
		if isNullReference(_x) then {
			_del = true;
			continue;
		};
		if (_x getvariable ["__pend_del",false]) exitwith {
			_del = true;
			continue;
		};
		
		if !isNull(_x getVariable "_sysRef" getVariable "_flagFlyLoad") exitWith {
			[_x] call si_onFlyWorldActionLoad;
			_del = true;
			continue;
		};
		
		_endTime = _x getVariable "_durationTime";
		if (tickTime > _endTime) then {
			debug_t("time end")

			_pos = _x getVariable "_lastNonCastedPos";
			([_pos,_pos vectorDiff [0,0,2000],_x] call si_getIntersectData) params ["_obj","_p","_norm"];
			if (_p distance (getPosATL _x) > 0.2) then {
				debug_t("on fly. dropdown")
				_x setPosATL _p;
				_x setVectorUp _norm;
			};

			[_x,_obj] call (_x getvariable "_finalizeAction");
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
		([_oldpos,_newPos,_x] call si_getIntersectData) params ["_obj","_p","_norm"];
		debug_line(_p,_norm,vec3(1,0,0));
		if equals(_thrower,_obj) then {_obj = objNULL};
		if isNullReference(_obj) then {
			_to = _x;
			//_bbxDat = _to getVariable "_bbxDat";
			{
				([_to modelToWorld _x,_newPos,_to] call si_getIntersectData) params ["_objex","_pex","_normex"];
				if equals(_thrower,_objex) then {_objex = objNULL};
				if !isNullReference(_objex) exitWith {
					_obj = _objex;
					_p = _pex;
					_norm = _normex;
				};
			} foreach (_to getVariable "_bbxDat");//[[_bbx,0,_bbx],[-_bbx,0,_bbx],[_bbx,0,-_bbx],[-_bbx,0,-_bbx]];
		};


		//ничто не мешает
		if isNullReference(_obj) then { //TODO do inline code in conditional op
			call (_x getVariable "_throwAlg" select 0)
		} else {
			call (_x getVariable "_throwAlg" select 1)
		};

	} foreach si_throwTasks;
	if (_del) then {
		modvar(si_throwTasks) - [objNull];
	};
};

//список алгоритмов полета объектов. каждый элемент - структура из 2 сегментов кода
si_throwModes = [
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
			debug_t("ANGLE WAS "+str _angle)
			_hasMoving = (_oldpos distance _newPos) > 0.01;
			_orient = _x getVariable "_orient";
			if (_angle < 0.65 && _hasMoving) then {
				//handle hit
				if !(_x getVariable "_isContacted") then {
					_x setVariable ["_isContacted",true];
					_targ = _obj getVariable "link";
					#ifdef EDITOR
					if isNullVar(_targ) then {
						{
							_targ = _obj getVariable _x;
							if !isNullVar(_targ) exitWith {
								if equalTypes(_targ,"") then {
									_targ = pointerList get _targ;
								};
							};
						} foreach ["ref","ptr"];
					};
					#endif
					(_x getVariable "_dmgData")params ["_dam","_type","_selection","_usr"];
					_throwed = _x getVariable "_sysRef";
					__INTERNAL_THROWED_VIRTUAL__ = _x;
					_distance = linearConversion[0,1,_interp,0,(_x getVariable "_distance")];
					callFuncParams(_targ,onThrowHit,_dam arg _type arg _selection arg _usr arg _distance arg _throwed)
				};

				debug_t("ricochet process apply from object ["+str _obj+"]")
				//отскок
				/*
					инверсия ротации и применение
					Режем скорость от проделанного расстояния
				*/
				//_orient = [_x] call model_getPitchBankYaw;
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
				//_x setVectorUp _norm;
				//Остановка
				[_x,_obj] call (_x getVariable "_finalizeAction");
				_del = true;
			};
		}
	],
	[
		{
			_x setPosATL _newPos;
			_x setVectorDir (vectorNormalized ((_x getVariable "_lastNonCastedPos") vectorDiff _newPos  ) vectorMultiply -1);

			/*_orient = _x getVariable "_orient";
			// 3 is CONSTANT
			MODARR(_orient,0, - 3 * (_x getVariable "_speed"));
			[_x,_orient] call model_SetPitchBankYaw;*/
			_x setVariable ["_lastNonCastedPos",_newPos];

			_penaltySupressFire = _x getVariable ["__penaltySupressFire__",0];
			if (_penaltySupressFire > 0) then {
				if (_x getVariable ["_psf_lastcheckpos",vec3(0,0,0)] distance _newPos > 5) then {
					_x setVariable ["_psf_lastcheckpos",_newPos];
					//collect mobs
					private _list = ["Mob",_newPos,5,true] call getMobsOnPosition;

					{
						callFuncParams(_x,handlePenaltySUpressFireAdd,_penaltySupressFire);
					} foreach (_list-[_x getVariable ["_throwerRef",objNUll]]);
				};

			};
		},
		{
			//TODO fixme
			/*
			_pass = false;
			debug_t(format["---------------> HADLER COLLIDER %1 %2" arg _obj arg _obj call pencfg_isExistsModel]);
			if (_obj call pencfg_isExistsModel) then {
				_pass = [_obj] call pencfg_handleObject_canPenetrate;
			};
			if (_pass) exitWith {
				debug_t("pencfg_handleObject_canPenetrate() - success pass")
				//copyofcode
				s_x setPosATL _newPos;
				//_x setPosAtl (asltoatl (_x ))
				//_x setVectorDir (vectorNormalized ((_x getVariable "_lastNonCastedPos") vectorDiff _newPos  ) vectorMultiply -1);
				_x setVariable ["_lastNonCastedPos",_newPos];

			};
			*/


			/*traceformat("orient was %1",[_x] call model_getPitchBankYaw);
			traceformat("normal %1",_norm);
			traceformat("vecdir %1",vectorDirVisual _x);
			traceformat("cos %1",(vectorDirVisual _x) vectorCos _norm)
			traceformat("dot %1 or %2",_norm vectorDotProduct (vectorDirVisual _x) arg (vectorDirVisual _x) vectorDotProduct _norm)*/
			_cos = (vectorDirVisual _x) vectorCos _norm;
			if (_cos >= -0.45 && _cos <= 0.45) then {
				//error("RICOCHET");
				/*_x setposatl (_x getVariable "_lastNonCastedPos");
				([_x] call model_getPitchBankYaw) params ["_oldx","_oldy","_oldz"];*/
				/*[_x,[_oldx * cos _oldx - _oldy * sin _oldx,
				_oldx * sin _oldx + _oldy * cos _oldx,
				_oldz]] call model_SetPitchBankYaw;*/
				//_x setVectorDir vectorNormalized(_norm vectorMultiply _cos);
				//_x setVectorDir vectorNormalized(_norm vectorAdd [cos _cos,sin _cos,tg _cos]);

				/*_x setVariable ["_startPoint",_x modelToWorld [0,0.05,0]];
				_newdist = (_x getVariable "_distance") * (_interp*100)/100;
				_x setVariable ["_distance",_newdist];*/
				//_x setVariable ["_endPoint",(_x modelToWorld [0,_newdist,0]) vectordiff [0,0,0/*_newPos select 2*/]];
				/*_x setVariable ["_points",[
					_x getVariable "_startPoint",
					_x getVariable "_endPoint"
				]];*/

				//nearesting all units
				// prob ricochet...
				[_x,_obj] call (_x getvariable "_finalizeAction");
				_del = true;
			} else {
				[_x,_obj] call (_x getvariable "_finalizeAction");
				_del = true;
			};

		}
	]
];

startUpdate(__onThrowing,0);
