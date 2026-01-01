// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>
#include <..\..\host\struct.hpp>
#include <..\..\host\thread.hpp>

namespace(LightScriptedCulling,lesc_)

//#define LESC_ENABLE_CULLING


#define LESC_USE_FAST_UPDATE

//#define ENABLE_VISUAL_SPHERE_DEBUG

struct(AbstractLightData)
	decl(mesh) def(src) objNull
	decl(vector3()) def(getPos) {getposatl (self getv(src))}

	decl(bool) def(_enabledDebugRender) false
	decl(struct_t.AutoModelPtr) def(_dbgrndObj) null
	decl(struct_t.LoopedFunction) def(_renderLoop) null

	decl(void(mesh)) def(init)
	{
		params ["_obj"];
		self setv(src,_obj);
	}

	decl(void(bool)) def(setDebugRender)
	{
		params ["_mode"];
		if equals(_mode,self getv(_enabledDebugRender)) exitWith {};
		
		self setv(_enabledDebugRender,_mode);

		if (_mode) then {
			private _s = self callv(_onActivateDebugRender);
			if !isNullReference(_s) then {
				self setv(_dbgrndObj,struct_newp(AutoModelPtr,_s));
			};

			private _f = {
				params ['self'];
				self callv(_onDrawRender);
			};
			self setv(_renderLoop,struct_newp(LoopedFunction,_f arg [self]));
		} else {
			self getv(_renderLoop) callv(stopLoop);
			self setv(_renderLoop,null);
			self setv(_dbgrndObj,null);
		};
	}

	decl(mesh()) def(_onActivateDebugRender)
	{
		objNull
	}

	decl(void()) def(_onDrawRender)
	{

	}

	decl(void()) def(del)
	{
		self callp(setDebugRender,false);
	}

	decl(bool(vector3)) def(isPointInside)
	{
		params ["_point"];
		false
	}

	decl(vector3[]()) def(getBoundingBox)
	{
		[[0,0,0],[0,0,0]]
	}

	decl(bool) def(_culled) false
	decl(float) def(_lum) 0//cached setLightIntensity

	decl(void(bool)) def(setCull)
	{
		params ["_mode"];
		if equals(_mode,_culled) exitWith {};
		self setv(_mode,_mode);
		private _src = self getv(src);
		if (_mode) then {
			_src setLightIntensity 0;
		} else {
			_src setLightIntensity (self getv(_lum));
		};
	}

endstruct

struct(ScriptedPointLightData) base(AbstractLightData)
	decl(float) def(radius) 0
	decl(float) def(startRadius) 0

	decl(void(mesh;...any[])) def(init)
	{
		params ["_obj","_kvargs"];
		{
			self set _x;
		} foreach _kvargs;
	}

	decl(override) def(_onActivateDebugRender)
	{
	#ifdef ENABLE_VISUAL_SPHERE_DEBUG
		private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
		private _clr = [random(1),random(1),random(1)] joinString ",";
		_s setObjectTexture [0,"#(rgb,8,8,3)color("+_clr+",0.01)"];
		_s setposatl (getposatl(self getv(src)));
		_s setobjectscale ((self getv(radius)) * 2 * 10);
		_s
	#else
		objNull
	#endif
	}

	decl(override) def(_onDrawRender)
	{
		private _p = getposatl (self getv(src));
		[_p,[1,1,0,1],30,self getv(radius),16] call debug_drawSphereEx;
		[_p,[1,0,0,1],15,self getv(startRadius),16] call debug_drawSphereEx;
	}

	decl(string()) def(str)
	{
		format["PointLight(%1)<%2>",self getv(radius),self getv(src)]
	}

	decl(override) def(isPointInside)
	{
		params ["_pos"];
		[getposatl(self getv(src)),self getv(radius),_pos] call interact_isPointInSphere
	}

	decl(override) def(getBoundingBox)
	{
		private _sphereRadius = self getv(radius);

		// В локальном пространстве центр сферы — это начало координат
		private _sphereCenter = [0, 0, 0];

		// Минимальные и максимальные точки BBX
		private _minPos = [
			(_sphereCenter select 0) - _sphereRadius,
			(_sphereCenter select 1) - _sphereRadius,
			(_sphereCenter select 2) - _sphereRadius
		];

		private _maxPos = [
			(_sphereCenter select 0) + _sphereRadius,
			(_sphereCenter select 1) + _sphereRadius,
			(_sphereCenter select 2) + _sphereRadius
		];

		[_minPos, _maxPos]
	}

endstruct

struct(ScriptedDirectLightData) base(AbstractLightData)
	decl(float) def(outAngle) 0
	decl(float) def(inAngle) 0
	decl(float) def(limit) 0

	decl(float) def(pitch) 0
	decl(float) def(bank) 0

	decl(float) def(distance) 0

	decl(void(mesh;...any[])) def(init)
	{
		params ["_obj","_kvargs"];
		{
			self set _x;
		} foreach _kvargs;
	}

	decl(override) def(_onDrawRender)
	{
		private _p = getposatl (self getv(src));
		([self getv(src)] call model_getPitchBankYawAccurate) params ["_pt","_bk"];
		
		[
			_p,
			(self getv(src)) modeltoworld [0,self getv(distance),0],
			//self getv(distance),
			self getv(outAngle),
			self getv(inAngle),
			0.5, //attenuation
			[1,1,0,1],
			[1,0,0,1],
			15 //width
		] call debug_drawLightConeEx
	}

	decl(string()) def(str)
	{
		format["DirectLight(%1)<%2>",format["o:%1 i:%2 d:%3 pb:{%4,%5}",self getv(outAngle),self getv(inAngle),self getv(distance),self getv(pitch),self getv(bank)],self getv(src)]
	}

	decl(override) def(isPointInside)
	{
		params ["_pos"];
		private _obj = self getv(src);
		[
			_obj modelToWorldVisual [0,0,0],
			_obj modelToWorldVisual [0,self getv(distance),0],
			self getv(outAngle),
			_pos
		] call interact_isPointInCone;
	}

	decl(override) def(getBoundingBox)
	{
		private _src = self getv(src);
		private _outerAngle = self getv(outAngle);
		private _distance = self getv(distance);

		// Начало и конец конуса в локальных координатах
		private _coneStartPos = [0, 0, 0];
		private _coneEndPos = [0, _distance, 0];

		// Направление и длина конуса
		private _coneDirection = _coneEndPos vectorDiff _coneStartPos;
		private _coneLength = vectorMagnitude _coneDirection;

		// Максимальный радиус на конце конуса
		private _maxRadius = _coneLength * tan _outerAngle;

		// Минимальные и максимальные точки BBX с учётом радиуса
		private _minPos = [
			(_coneStartPos select 0) min ((_coneEndPos select 0) - _maxRadius),
			(_coneStartPos select 1) min ((_coneEndPos select 1) - _maxRadius),
			(_coneStartPos select 2) min ((_coneEndPos select 2) - _maxRadius)
		];

		private _maxPos = [
			(_coneStartPos select 0) max ((_coneEndPos select 0) + _maxRadius),
			(_coneStartPos select 1) max ((_coneEndPos select 1) + _maxRadius),
			(_coneStartPos select 2) max ((_coneEndPos select 2) + _maxRadius)
		];

		[_minPos, _maxPos]
	}

endstruct

#ifdef EDITOR
decl(void(bool))
lesc_setDebugRender = {
	params ["_mode"];
	{_x callp(setDebugRender,_mode)} foreach lesc_list_allDataObjs;
};
#endif

//all light objects
decl(mesh[])
lesc_list_allObjects = [];

//renderer list point lights
decl(struct_t.AbstractLightData[])
lesc_list_allDataObjs = [];

/*
	handle light object adding to scene
	Вызывается при добавлении света
*/
decl(void(mesh;bool))
lesc_handleLight = {
	params ["_lt",["_isDirect",false]];
	lesc_list_allObjects pushBack _lt;
	private _cfg = [];
	{
		_x params ["_prop","_val"];
		[_lt,_prop,_val] call lesc_handleProp;
	} foreach (_x select [3,(count _x) - 3]);

	if (count _cfg > 0) then {
		private _cd = if (_isDirect) then {
			struct_newp(ScriptedDirectLightData,_o arg _cfg);
		} else {
			struct_newp(ScriptedPointLightData,_o arg _cfg);
		};
		lesc_list_allDataObjs pushback _cd;
	};
};

decl(void(any))
lesc_onLightRemove = {
	params ["_dummyParam"];
	if (objNull in lesc_list_allObjects) then {
		lesc_list_allObjects = lesc_list_allObjects - [objNull];
		{
			if isNullReference(_x getv(src)) then {
				lesc_list_allDataObjs set [_foreachIndex,objNull];
			};
		} foreach lesc_list_allDataObjs;
		lesc_list_allDataObjs = lesc_list_allDataObjs - [objNull];
	};
};

decl(void(mesh;string;any))
lesc_handleProp = {
	params ["_o","_prop","_val"];
	if (_prop == "setLightAttenuation") then {
		private _rad = _val select 5;
		if (_rad > 0) then {
			if (_isDirect) then {
				_cfg pushback ["distance",_rad];
			} else {
				_cfg pushBack ["radius",_rad];
				_cfg pushBack ["startRadius",_val select 4];
			};
		};
	};

	if (_prop == "setLightIntensity") then {
		_cfg pushBack ["_lum",_val];
	};

	//only directional settings
	if (_isDirect) then {
		if (_prop == "setOrient") then {
			_val params ["_pitch","_bank"];
			_cfg pushBack ["pitch",_pitch];
			_cfg pushBack ["bank",_bank];
		};
		if (_prop == "setLightConePars") then {
			_val params ["_outAngle","_inAngle","_limit"];
			_cfg pushBack ["outAngle",_outAngle];
			_cfg pushBack ["inAngle",_inAngle];
			_cfg pushBack ["limit",_limit];
		};
	};

};

decl(int)
lesc_cullCnt = 0;

decl(void())
lesc_cullingProcess = {
	
	private _campos = positionCameraToWorld[0,0,0];
	private _culled = 0;
	//sorting
	{
		if (_x callp(isPointInside,_campos)) then {
			//мы внутри этого света. восстанавливаем видимость
			_x callp(setCull,false);
		} else {
			_bps = _x callv(getPos);
			_x callv(getBoundingBox) params ["_min","_max"];
			_canSee = [_bps,_min,_max,
				//linearConversion[1,30,_bps distance _campos,6,1]
				6
				] call render_gbuffCheck_photonVisPrc;
			// traceformat("obj:%1:: p:%2; min:%3; max:%4",_x arg _bps arg _min arg _max)
			// traceformat("    VISIBLE: %1",_canSee)
			if (!_canSee) then {
				//объект перекрывает геометрия
				_x callp(setCull,true);
				INC(_culled);
				continue;	
			};

			//объект видно
			_x callp(setCull,false);
		};
	} foreach lesc_list_allDataObjs;

	lesc_cullCnt = _culled;
};

decl(int) lesc_handle = -1;
decl(thread_handle) lesc_thd = threadNull;

__lesc_culling_start = {
	#ifdef LESC_USE_FAST_UPDATE
		lesc_handle = startUpdate(lesc_cullingProcess,0.5);
	#else
		private _looped = {while {true}do{call lesc_cullingProcess}};
		lesc_thd = threadStart(threadNew(_looped));
	#endif
};


#ifdef LESC_ENABLE_CULLING
	call __lesc_culling_start;
#endif