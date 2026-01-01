// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"

/*
	List typedef(AtmosArea) 
		-> AtmosChunk 
			-> AtmosAreaBase

*/

struct(AtmosChunk)

	def(chCtr) 0; //chunk counter

	def(areaSR) null;//SafeReference to area
	def(chId) null;
	def(chNum) -1; //local chunk id
	def(chLPos) null; //local position in area 
	def(lastUpd) 0;
	def(getChunkCenterPos) {(self getv(chId)) call atmos_chunkIdToPos}
	def(getChunkZoneOffset) {self getv(chLPos)}
	def(getChunkAreaId) {(self getv(chId)) call atmos_chunkIdToAreaId}
	def(getArea)
	{
		self getv(areaSR) callv(getValue)
	}


	def(objInside) null; //gameobjects inside this chunk
	def(lastObjUpdate) 0;
	def(flagUpdObj) true;
	//кеш распространения разных типов атмоса
	def(mapSpreadCache) null; //list<hashmap> key chid,value lastobjects update

	def(cfg) -1;//light config effector
	
	//atmos objects inside this chunk. Used for faster enumerate
	def(atmosList) null;
		def(aFire) null;
		def(aGas) null;
		def(aWater) null;

	def(hasFire) {!isNull(self getv(aFire))};
	def(hasGas) {!isNull(self getv(aGas))};
	def(hasWater) {!isNull(self getv(aWater))};

	def(updateLight)
	{
		if (self callv(hasFire) && {
			self getv(aFire) callv(isActive)
		}) exitWith {
			private _oldCfg = self getv(cfg);
			self setv(cfg,self getv(aFire) callv(getCfg));
			if (_oldCfg!=(self getv(cfg))) then {
				[self] call atmos_onUpdateAreaByChunk;
			};
		};
		if (self callv(hasGas) && {
			self getv(aGas) callv(isActive)
		}) exitWith {
			private _oldCfg = self getv(cfg);
			self setv(cfg,self getv(aGas) callv(getCfg));
			if (_oldCfg!=(self getv(cfg))) then {
				[self] call atmos_onUpdateAreaByChunk;
			};
		};

		self callv(_resetLightAndUpdate)
	}

	def(_resetLightAndUpdate)
	{
		private _oldCfg = self getv(cfg);
		self setv(cfg,-1); //no light founded
		if (_oldCfg!=(self getv(cfg))) then {
			[self] call atmos_onUpdateAreaByChunk;
		};
	}

	//generate packet for client
	def(getPacket)
	{
		[self getv(chNum),self getv(cfg)]
	}

	def(init)
	{
		params ["_chId"];
		
		self setv(objInside, []);
		self setv(atmosList,[]);

		self setv(chId,_chId);

		self setv(mapSpreadCache,vec3(createHashMap,createHashMap,createHashMap));

		//setup local position and chunk localID
		self setv(chLPos,_chId call atmos_getLocalChunkIdInArea);
		self setv(chNum, (self getv(chLPos)) call atmos_encodeChId);

		self setv(chCtr,atmos_chunks_uniqIdx);
		INC(atmos_chunks_uniqIdx);

		INC(atmos_chunks);
	}
	
	def(del)
	{
		DEC(atmos_chunks);
	}

	def(registerArea)
	{
		params ["_aType","_fieldName","_aIdx"];
		private _p = [self getv(chId)];
		private _atr = [_aType,_p] call struct_alloc;
		self set [_fieldName,_atr];
		self getv(atmosList) set [_aIdx,_atr];

		self callv(updateLight); //first loading light

		_atr
	}

	def(unregisterArea)
	{
		params ["_fieldName","_aIdx"];
		//free references
		self set [_fieldName,null];
		self getv(atmosList) set [_aIdx,null];

		self callv(getArea) set [ATMOS_AREA_INDEX_LASTDELETE,tickTime];

		self callv(updateLight); //release atmos obj - update light
	}

	def(getObjectsInChunk)
	{
		self callv(updateObjectsInChunk);
		self getv(objInside);
	}

	def(updateObjectsInChunk)
	{
		if (self getv(flagUpdObj)) then {
			self setv(objInside,[self getv(chId) arg self] call atmos_chunkGetNearObjects);
			self setv(flagUpdObj,false);
			self setv(lastObjUpdate,tickTime);
		};
	}

	def(str)
	{
		private _flags = "";
		if (self callv(hasFire)) then {
			modvar(_flags) + "F";
		};
		if (self callv(hasGas)) then {
			modvar(_flags) + "G";
		};
		if (self callv(hasWater)) then {
			modvar(_flags) + "W";
		};
		if (count _flags > 0) then {
			_flags = "<" + _flags + ">";
		};
		format["A%2Ch%1%3+o%4",self getv(chId),self callv(getChunkAreaId),_flags,count (self getv(objInside))]
	}

	//запрос соседних чанков. генерирует новый объект чанка если не существует
	def(getChunkDown) {[self getv(chId) vectorAdd [0,0,-1]] call atmos_getChunkAtChId}
	def(getChunkUp) {[self getv(chId) vectorAdd [0,0,1]] call atmos_getChunkAtChId}
	def(getChunkFromSide)
	{
		params ["_side"];
		[self getv(chId) vectorAdd _side] call atmos_getChunkAtChId
	}

	def(getChunkUserInfo)
	{
		params ["_usr"];
		//! ВНИМАНИЕ. Похоже что exitWith возвращает null. Не знаю почему так происходит...
		if (self callv(hasFire)) then {
			private _f = self getv(aFire);
			(format ["%1 %2",
				pick["Тут вот","Ещё","Тут","А ещё"],
				pick["горит","пожар","загорелось","огонь хреначит"]
			]) editor_conditional(+ " size:" + (str (_f getv(size))) + "; force:"+(str (_f getv(force))),;);
		} else {
			""
		};
	};

	//вызывается при контакте моба с этим типом атмоса
	//TODO продумать как лучше делать контакт по нескольким зонам
	def(onMobContactBody) {
		params["_mob"];
		{
			if !isNullVar(_x) then {
				_x callp(onMobContactBody,_mob);
			};
			false
		} count (self getv(atmosList));
	}
	def(onMobContactTurf) {
		params["_mob"];
		{
			if !isNullVar(_x) then {
				_x callp(onMobContactTurf,_mob);
			};
			false
		} count (self getv(atmosList));
	}

	def(atmosTemp) 24; //нормальная температура воздуха в градусах
	def(atmosTempNormal) 24; //дефолтная температура
	def(atmosTempNormal_str) "24.00"
	def(nextTempUpdate) 0;//временная отметка следующего обновления температуры
	def(c_tempUpdateDelay) 5; //частота обновления температуры

	def(onTemperatureUpdate)
	{
		self setv(nextTempUpdate,tickTime + (self getv(c_tempUpdateDelay)));

		private _oldTemp = self getv(atmosTemp);
		private _normTemp = self getv(atmosTempNormal);
		
		//значения должны быть одинаковы при уменьшении и при увеличении
		if (_oldTemp > _normTemp) exitWith {
			//охлаждение
			self callp(adjustTemperature,-0.1);
		};
		if (_oldTemp < _normTemp) exitWith {
			//нагревание
			self callp(adjustTemperature,0.1);
		};
	}

	def(adjustTemperature)
	{
		params ["_temp"];
		private _newTemp = ((self getv(atmosTemp))+_temp) max -100 min 100;
		//normalize
		if ((_newTemp toFixed 2) == (self getv(atmosTempNormal_str))) then {
			_newTemp = self getv(atmosTempNormal);
		};
		self setv(atmosTemp,_newTemp);
	}

endstruct

struct(AtmosAreaBase)
	def(c_areaTypeId) ATMOS_TYPEID_FIRE; //constant typeid

	def(getCfg) {-1} //interface for getting light cfg
	def(chunkId) null; //vec3 to chunk id
	def(getChunk) {[self getv(chunkId)] call atmos_getChunkAtChIdUnsafe}
	def(getChunkTo)
	{
		params ["_side"];
		[(self getv(chunkId))vectorAdd _side] call atmos_getChunkAtChId
	}

	def(c_spreadTimeout) 5;
	def(lastActivity) 0;

	def(canActivity) {tickTime > self getv(lastActivity)}
	def(isActive) {true} //по умолчанию. требуется переопределение
	
	//spread setup. constval, getting by ref
	def(c_spreadCountMin) 5
	def(c_spreadCountMax) 6
	def(c_spreadType) ATMOS_SPREAD_TYPE_NORMAL //тип распространения

	def(c_spreadSearchMode) ATMOS_SEARCH_MODE_FIRST_INTERSECT //режим поиска для возможности распространения

	def(onActivity) {
		self setv(lastActivity,tickTime + (self getv(c_spreadTimeout)));

		private _sides = [
			randInt(self getv(c_spreadCountMin),self getv(c_spreadCountMax)),
			self getv(c_spreadType)
		] call atmos_getNextRandAroundChunks;
		
		{
			if (self callp(canSpreadTo,_x)) then {
				self callp(onSpreadTo,_x);
			};
			false
		} count _sides;
	}

	def(canSpreadTo) {
		params ["_side"];
		private _chTo = self callp(getChunkTo,_side);
		private _cinf = self callv(getChunk) getv(mapSpreadCache) select (self getv(c_areaTypeId));
		if (_chTo getv(flagUpdObj)) then {
			_chTo callv(updateObjectsInChunk);
		};
		private _lastUpd = _chTo getv(lastObjUpdate);
		//info cached. check timestamp
		if (_side in  _cinf) then {
			//objects has updated. need recalculate
			if (_lastUpd > ((_cinf get _side) select 0)) then {

				private _r = [self getv(chunkId),_side,self getv(c_spreadSearchMode)] call atmos_getIntersectInfo;
				_cinf set [_side,[_lastUpd,_r]];
				_r
			} else {
				//info not updated. get last actual value
				_cinf get _side select 1
			};
		} else {
			private _r = [self getv(chunkId),_side,self getv(c_spreadSearchMode)] call atmos_getIntersectInfo;
			//info not cached. need recalculate and update timestamp
			_cinf set [_side,[_lastUpd,_r]];
			_r
		};
		

	}

	def(onSpreadTo) {
		params ["_side"];
		private _makePos = self callp(getChunkTo,_side) callv(getChunkCenterPos);
		private _p = [_makePos,struct_typename(self)] call atmos_createProcess;
		_p
	}

	//вызывается при контакте объекта с этим типом атмоса
	def(onObjectContact) {params["_obj","_contextRef"]}
	def(postObjectsContact) {params ["_contextRef"]};
	def(onMobContactBody) {params["_mob"]}
	def(onMobContactTurf) {params["_mob"]}
	

	def(updateLight)
	{
		self callv(getChunk) callv(updateLight);
	}

	def(init)
	{
		params ["_chId"];
		self setv(chunkId,_chId);
		self setv(lastActivity,tickTime + (self getv(spreadTimeout)) + rand(1,3));

		INC(atmos_areas);
	}

	def(del)
	{
		DEC(atmos_areas);
	}

	//принудительное создание обрабатывает параметры указанные при создании
	def(onManualCreated)
	{
		//параметры могут быть динамическими
	}

	//вызывается при инициализации объекта. параметры динамические
	def(onInitialized)
	{

	}
	
	def(str)
	{
		format["%1<%2>",struct_typename(self),self getv(chunkId)]
	}

	def(getUnlinkStructInfo) {
		atmos_imap_process_t get struct_typename(self)
	}

	//release resource
	def(unlinkStruct)
	{
		(self callv(getUnlinkStructInfo)) params ["_memName","_idx"];
		self callv(getChunk) callp(unregisterArea,_memName arg _idx)
	}

	def(hasFireAt)
	{
		params ["_chId"];
		self callp(getChunkTo,_chId) callv(hasFire);
	}

	def(hasGasAt)
	{
		params ["_chId"];
		self callp(getChunkTo,_chId) callv(hasGas);
	}
endstruct

struct(AtmosAreaFire) base(AtmosAreaBase)
	def(c_areaTypeId) ATMOS_TYPEID_FIRE;

	def(force) 3; //default fire force
	def(size) 1;
	def(isActive) {self getv(force) > 0}
	def(hasFireDown) {
		private _ch = self callv(getChunk);
		private _chD = _ch callv(getChunkDown);
		_chD callv(hasFire);
	}

	def(init)
	{
		params ["_chId"];
	}

	def(getCfg)
	{
		self callv(getLightTypeBySize)
	}

	def(calcFireSize)
	{
		round linearConversion [1,15,self getv(force),1,3,true];
	}

	def(getLightTypeBySize)
	{
		[
			"SLIGHT_ATMOS_FIRE_1" call lightSys_getConfigIdByName,
			"SLIGHT_ATMOS_FIRE_2" call lightSys_getConfigIdByName,
			"SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName
		] select ((self getv(size))-1)
	}

	def(onActivity)
	{
		callbase(onActivity);

		private _newForce = -1;
		
		self callv(getChunk) callp(adjustTemperature,1.2 * (self getv(size)));

		self callp(adjustForce,_newForce);
		if (self callv(isActive)) then {
			//создаем дым
			private _gas = [
				self callv(getChunk) callv(getChunkCenterPos),
				"AtmosAreaGas",
				true,
				["GasBase",1 * (self getv(size))]
			] call atmos_createProcess;
			_gas callp(adjustGas,"GasBase" arg 1.0 * (self getv(size)) arg true);
		};
	}

	def(canSpreadTo)
	{
		params ["_side"];
		
		if (self getv(force)<=
			ifcheck(equals(_side,vec3(0,0,1)),5,7) // огонь быстрее распространяется вверх
		) exitWith {false};
		if (self callp(hasFireAt,_side)) exitWith {false};
		if !(callbase(canSpreadTo)) exitWith {false};
		//check materials in next chunk
		private _nChunk = self callp(getChunkTo,_side);

		if (_nChunk callv(hasFire)) exitWith {false};
		private _matObj = nullPtr;
		private _found = false;
		{
			_matObj = callFunc(_x,getMaterial);
			if isNullReference(_matObj) then {continue};
			if prob(callFunc(_matObj,getFireDamageIgniteProb)) exitWith {
				_found = true;
			};
		} foreach (_nChunk callv(getObjectsInChunk));

		_found
	}

	def(onObjectContact)
	{
		params ["_obj","_contextRef"];
		if callFunc(_obj,canApplyDamage) then {
			private _m = callFunc(_obj,getMaterial);
			if isNullReference(_m) exitwith {};

			private _dam = floor (D6 * callFunc(_m,getFireDamageModifier));
			if (_dam > 0) then {
				if (callFunc(_m,getFireDamageModifier) <= 1) exitWith {};
				//ограничение урона.
				if (tickTime<getVar(_obj,__atm_lastFireDamage)) exitWith {
					refset(_contextRef,refget(_contextRef) + 1);
				};
				
				private _oldHP = getVar(_obj,hp);
				private _mpos = null;//ifcheck(prob(30),callFunc(_obj,getModelPosition),null);
				callFuncParams(_obj,applyDamage,_dam arg DAMAGE_TYPE_BURN arg _mpos);
				if not_equals(_oldHP,getVar(_obj,hp)) then {
					//self callp(adjustForce,2); //because decrement is 1
					refset(_contextRef,refget(_contextRef) + 1);
					setVar(_obj,__atm_lastFireDamage,tickTime+rand(0.2,0.7));
				};
			};
		};
	}

	def(postObjectsContact)
	{
		params ["_contextRef"];
		private _count = refget(_contextRef);
		if (_count > 0) then {
			self callp(adjustForce,round(_count/2) + 1);
		};
	}

	def(adjustForce)
	{
		params ["_force"];
		private _newForce = ((self getv(force))+_force) max 0 min 30;
		if !(self callv(hasFireDown)) then {
			if (_newForce > 2) then {
				//тут нечему гореть. совсем
				if (count (self callv(getChunk) callv(getObjectsInChunk)) == 0) then {
					_newForce = 0;
				};
			};
		} else {
			if (_newForce > 2) then {
				if (count (self callv(getChunk) callv(getObjectsInChunk)) == 0) then {
					_newForce = _newForce min 2;
				};
			};
		};

		self setv(force,_newForce);
		private _size = self callv(calcFireSize);
		if (_size!=(self getv(size))) then {
			self setv(size,_size);
			self callv(updateLight);//size changed. request for updating light
		};

		if !(self callv(isActive)) then {
			self callv(unlinkStruct);
		};
	}

	def(applyFireDamage)
	{
		params ["_m","_sel"];
		if (tickTime >= getVar(_m,__lastFireDamage)) then {
			private _dam = D6 - 1;
			callFuncParams(_m,applyDamage,_dam arg DAMAGE_TYPE_BURN arg _sel arg DIR_RANDOM);
			setVar(_m,__lastFireDamage,tickTime+0.3);//each 300ms
		};
	}

	def(onMobContactTurf)
	{
		params ["_mob"];
		private _dz = TARGET_ZONE_TORSO;

		//turf calculate random body part
		call {
			private _sta = callFunc(_mob,getStance);
			private _tzList = [];
			if (_sta <= STANCE_UP) then {
				_tzList append [TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R];
			};
			if (_sta <= STANCE_MIDDLE) then {
				_tzList append TARGET_ZONE_LIST_TORSO;
				_tzList append [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L];
			};
			if (_sta <= STANCE_DOWN) then {
				_tzList append TARGET_ZONE_LIST_HEAD;
			};
			if (count _tzList > 0) then {
				_dz = pick _tzList;
			};
		};

		self callp(applyFireDamage,_mob arg _dz);
	}

	def(onMobContactBody)
	{
		params ["_mob"];
		private _tzlist = TARGET_ZONE_LIST_HEAD;
		_tzlist append TARGET_ZONE_LIST_TORSO;

		self callp(applyFireDamage,_mob arg pick _tzlist);
	}

endstruct

struct(AtmosAreaGas) base(AtmosAreaBase)
	def(c_areaTypeId) ATMOS_TYPEID_GAS;

	def(isActive) {self getv(volume) > 0}

	def(c_spreadCountMin) 3
	def(c_spreadCountMax) 4
	def(c_spreadType) ATMOS_SPREAD_TYPE_NO_Z //тип распространения

	def(c_spreadSearchMode) ATMOS_SEARCH_MODE_NO_INTERSECT

	def(gCont) null //контейнер газов
	def(volume) 0 //текущее количество
	def(leftVol) 1000 //оставшееся количество
	def(c_maxVolume) 1000 //макс количество
	def(leadingGas) null //лидирующий газ. отвечает за то какой будет визуал

	def(getCfg)
	{
		self getv(leadingGas) callv(getLightCfg)
	}

	def(init)
	{
		params ["_chId"];
		self setv(gCont,createHashMap);
	}

	def(onInitialized)
	{
		params ["_gas","_vol"];
		if !isNullVar(_gas) then {
			self callp(adjustGas,_gas arg _vol arg true);
		};
	}

	def(onActivity) {
		self setv(lastActivity,tickTime + (self getv(c_spreadTimeout)));

		if !(self callv(isActive)) exitWith {
			self callv(unlinkStruct);
		};

		self callp(removeVolume,0.1 arg true);

		private _sides = [
			randInt(self getv(c_spreadCountMin),self getv(c_spreadCountMax)),
			self getv(c_spreadType)
		] call atmos_getNextRandAroundChunks;
		
		private _chunk = self callv(getChunk);
		private _curTemp = _chunk getv(atmosTemp);
		if (_curTemp > (_chunk getv(atmosTempNormal))) then {
			_sides pushBack [0,0,1]; //up
		} else {
			_sides pushBack [0,0,-1];
		};

		private _psides = [];
		{
			if (self callp(canSpreadTo,_x)) then {
				_psides pushBack _x;
			};
			false
		} count _sides;

		private _iterCnt = count _psides;
		if (_iterCnt==0) exitWith {};

		private _DIFF_RATE = 0.5;
		private _valPass = (self getv(volume)) * _DIFF_RATE;
		private _val = _valPass/_iterCnt;

		private _TEMP_DIFFRATE = 0.05;
		private _tempPass = _curTemp * _TEMP_DIFFRATE;
		_chunk callp(adjustTemperature, -_tempPass/2);
		private _tempPerCh = _tempPass/_iterCnt;
		{
			self callp(onSpreadTo,_x arg _val arg _tempPerCh);
			false
		} count _psides;
	}

	def(canSpreadTo)
	{
		params ["_side"];
		if (self getv(volume)<=0.2) exitWith {false}; //! может вызывать ошибку из-за отсутсвия ret_def()
		callbase(canSpreadTo)
	}

	def(onSpreadTo)
	{
		params ["_side","_transVal","_transTemp"];
		if ((self getv(volume))<=0)exitWith {};
		private _newGas = callbase(onSpreadTo);
		self callp(transferTo,_newGas arg _transVal);

		self callp(getChunkTo,_side) callp(adjustTemperature,_transTemp);
	}

	// volume management

	def(updateLeadingGas)
	{
		private _ld = null;
		private _max = 0;
		private _cur = 0;

		{
			_cur = _y getv(volume);
			if (_cur > _max) then {
				_max = _cur;
				_ld = _y;
			};
		} foreach (self getv(gCont));

		if !isNullVar(_ld) then {
			self setv(leadingGas,_ld);
			self callv(updateLight);
		};
	}

	def(adjustGas)
	{
		params ["_gas","_vol",["_updateLead",false]];
		private _left = self getv(leftVol);
		_vol = _vol max 0 min _left;
		//_gas = tolower _gas;//! это не позволит создать структуру газа
		private _gc = self getv(gCont);
		//!здесь может возникнуть ошибка переполнения - фактический объем может стать меньше чем внутри газа
		if (_gas in _gc) then {
			private _gStruct = _gc get _gas;
			_gStruct setv(volume,(_gStruct getv(volume))+_vol);
		} else {
			private _gStruct = [_gas] call struct_alloc;
			_gc set [_gas,_gStruct];
			_gStruct setv(volume,_vol);
		};
		self setv(leftVol,(_left-_vol)max 0);
		self setv(volume,((self getv(volume)) + _vol) min (self getv(c_maxVolume)));

		if (_updateLead) then {
			self callv(updateLeadingGas);
		};

		true
	}

	def(removeGas)
	{
		params ["_gas","_vol",["_updateLead",false]];
		//_gas = tolower _gas;
		private _gc = self getv(gCont);
		if !(_gas in _gc) exitWith {false};
		private _gobj = _gc get _gas;
		private _newamount = (_gobj getv(volume)) - _vol;
		if (_newamount <= 0 || (_newamount toFixed 4) == "0.0000") then {
			_vol = _gobj getv(volume);
			_gc deleteAt _gas;
		} else {
			_gobj setv(volume,_newamount);
		};

		self setv(volume,((self getv(volume)) - _vol) max 0);
		self setv(leftVol,((self getv(leftVol)) +_vol) min (self getv(c_maxVolume)));
		
		if (_updateLead) then {
			self callv(updateLeadingGas);
		};

		true
	}

	def(addVolume)
	{
		params ["_v"];
	}

	def(removeVolume)
	{
		params ["_val",["_updateLead",false]];

		private _curvol = self getv(volume);
		if (_curvol<=0) exitWith {false};
		_val = _val max 0 min _curvol;
		private _gcmap = self getv(gCont);
		private _trEach = _val / _curvol;
		private _trans = 0;
		private _newamount = 0;
		private _newvol = 0;
		private _toDel = [];
		{
			_trans = (_y getv(volume)) * _trEach;
			_y setv(volume,(_y getv(volume)) - _trans);
			_newamount = _y getv(volume);
			//traceformat("trans %1(%3) new %2",_trans arg _newamount toFixed 4 arg _y);
			if (_newamount <= 0 || (_newamount toFixed 4) == "0.0000") then {
				_toDel pushBack _x;
				_newamount = 0;
			};

			modvar(_newvol) + _newamount;
		} foreach _gcmap;

		self setv(leftVol,(self getv(c_maxVolume)) - _newvol);
		self setv(volume,_newvol max 0);

		{
			_gcmap deleteAt _x;
		} foreach _toDel;

		if (_updateLead) then {
			self callv(updateLeadingGas);
		};

		true
	}

	def(transferTo)
	{
		params ["_toAreaGas","_vol",["_updateLead",false]];
		_vol = _vol max 0 min (self getv(volume));
		_vol = _vol max 0 min (_toAreaGas getv(leftVol));

		if (_vol==0) exitWith {false};

		private _gcFrom = self getv(gCont);
		private _trEach = _vol/(self getv(volume));
		private _trans = 0;
		{
			_trans = (_y getv(volume)) * _trEach;
			self callp(removeGas,_x arg _trans);
			_toAreaGas callp(adjustGas,_x arg _trans);
		} foreach +_gcFrom;

		if (_updateLead) then {
			self callv(updateLeadingGas);
			_toAreaGas callv(updateLeadingGas);
		};

		true
	}
	
	//метод пересчета текущего и оставшегося объема
	def(updateVolume)
	{
		private _vol = 0;
		{
			modvar(_vol) + (_x getv(volume));
		} foreach (self getv(gCont));
		self setv(volume,_vol);
		self setv(leftVol,(self getv(c_maxVolume)) - _vol);
		_vol
	}

	def(onMobContactBody)
	{
		params ["_mob"];
		{
			_y callp(onBreathing,_mob);
			_y callp(onSkinContact,_mob);
		} foreach (self getv(gCont));
	}


endstruct

#include "Atmos_Gases.sqf"