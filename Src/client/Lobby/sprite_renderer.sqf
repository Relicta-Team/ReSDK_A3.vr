// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\thread.hpp"

namespace(LobbySprite,lobby_sprite_)

macro_def(lobby_sprite_using_renderer)
#define LOBBY_USING_SPRITE_RENDERER

decl(widget[])
lobby_sprite_list = [];

decl(widget[])
lobby_sprite_readyButton = [widgetNull];

macro_const(lobby_sprite_lifeTime)
#define SPRITE_LIFETIME 15
macro_const(lobby_sprite_counter)
#define SPRITE_COUNTER 500

macro_func(lobby_sprite_getStartPos,vector2())
#define SPRITE_STARTPOS [50 + rand(-50,50),-5 - rand(-5,0)]
macro_func(lobby_sprite_getEndPos,vector2())
#define SPRITE_ENDPOS [50 + rand(-50,50),100]

macro_const(lobby_sprite_colors)
#define COLORS [[1,0,0,1],[0,1,0,1],[0,0,1,1]]

decl(void())
lobby_sprite_onUpdateCode = {
	if (!isLobbyOpen) exitWith {};
	
	private _d = getDisplay;
	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
	_ctg ctrlEnable false;
	private _fog = 0;
	
	
	//fire on down
	_h = 25;
	_w = getWidthByHeightToSquare(_h);
	_args = [_d,PICTURE,[50 - _w / 2,100 - _h / 2,_w,_h],_ctg];
	_fog = _args call createWidget;
	_fog ctrlEnable false;
	_fog ctrlSetTextColor [0,0,0,0];
	[_fog,PATH_PICTURE("lobby\fire.paa")] call widgetSetPicture;
	_fog setVariable ['lastupdate',tickTime + rand(0,0.5)];
	
	_fog setFade 1;
	_fog commit 0;
	lobby_sprite_readyButton set [0,_fog];
	
	private _updFire = {
		if (!isLobbyOpen) exitWith {
			stopThisUpdate();
		};
		
		if (lobby_background_local != lobby_background) then {
			lobby_background_local = lobby_background;
			_pic = lobby_backgroundWidget select 0;
			if !isNullReference(_pic) then {
				[_pic,lobby_background_local] call widgetSetPicture;
			};
		};
		
		
		private _fire = _this select 0;
		
		
		_lastUpd = _fire getVariable 'lastupdate';
		if (tickTime >= _lastUpd) then {
			_h = rand(70,71);//if (lobby_isReadyToPlay) then {rand(70,71)} else {1};
			_w = getWidthByHeightToSquare(_h);
			_newPos = [50 - _w / 2,100 - _h / 2 + 10,_w,_h];
			_newTime = rand(0.001,0.1);
			[_fire,_newPos,_newTime] call widgetSetPosition;
			_fire ctrlSetTextColor [rand(0.9,1),rand(0.6,0.7),0,rand(0.3,0.35)];
			_fire setVariable ['lastupdate',tickTime + _newTime];
		};
		
	};
	
	startUpdateParams(_updFire,0,_fog);
	
	
	
	private _allfogs = [];
	//log("start onupdate " + str diag_ticktime);
	for "_i" from 1 to SPRITE_COUNTER do {
		
		_h = 0.51 - random 0.5;
		_args = [_d,PICTURE,[50 + random 10,50 + random 10,getWidthByHeightToSquare(_h),_h],_ctg];
		
		_args = [_d,PICTURE,[50 + random 10,-10 + random 10,getWidthByHeightToSquare(_h),_h],_ctg];
		
		_fog = _args call createWidget;
		_fog ctrlEnable false;
		_fog ctrlSetTextColor [1,1,1,0.1];
		
		_allfogs pushback _fog;
		
		[_fog,PATH_PICTURE("lobby\snowparticle.paa")] call widgetSetPicture; //test particle
		_fog setVariable ['lastupdate',tickTime + rand(1,10)];
		//[_fog,[0,60],SPRITE_LIFETIME] call widgetSetPositionOnly;
	};
	//logformat("allf %1",_allfogs);
	
	private _onFrameCode = {
		if (!isLobbyOpen) exitWith {
			stopThisUpdate();
		};
		
		{
			_lastUpd = _x getVariable 'lastupdate';
			if (tickTime >= _lastUpd) then {
				//_x setFade 0;
				[_x,SPRITE_STARTPOS] call widgetSetPositionOnly;
				_randBias = rand(1,10);
				//_x setFade 1;
				[_x,SPRITE_ENDPOS,SPRITE_LIFETIME - _randBias] call widgetSetPositionOnly;
				_x setVariable ['lastupdate',tickTime + SPRITE_LIFETIME-_randBias];
			} else {
				//traceformat("t %1; lu %2 is %3 : cond %4",tickTime arg _lastUpd - SPRITE_LIFETIME arg tickTime >= _lastUpd - SPRITE_LIFETIME arg ((_x call widgetGetPosition) select 1))
				if (tickTime >= _lastUpd - SPRITE_LIFETIME) then {
					_posY = ((_x call widgetGetPosition) select 1);
					#define WINDPOS 50
					if (prob(70) && {_posY >= WINDPOS && _posY <= WINDPOS + 0.1}) then {
						//error("TRY");
						//_x setFade 0;
						_r = rand(SPRITE_LIFETIME / 3,SPRITE_LIFETIME / 2);
						[_x,SPRITE_ENDPOS,_r] call widgetSetPositionOnly;
						
						_x setVariable ['lastupdate',tickTime + _r];
					};
				};
			};
		} foreach (_this select 0);
	};
	
	startUpdateParams(_onFrameCode,0,_allfogs);

	
	//local fog
	_localFogs = [];
	for "_i" from 1 to 100 do {
		
		_h = 70;
		_args = [_d,PICTURE,[-100,-100,rand(40,70),rand(40,70)],_ctg];
		
		_fog = _args call createWidget;
		_fog ctrlEnable false;
		_fog ctrlSetTextColor [1,1,1,0.4];
		
		_localFogs pushback _fog;
		
		[_fog,PATH_PICTURE("lobby\fog.paa")] call widgetSetPicture;
		_fog setVariable ['lastupdate',tickTime + rand(1,10)];
		//[_fog,[0,60],SPRITE_LIFETIME] call widgetSetPositionOnly;
	};
	
	private _onFrameCodeFog = {
		if (!isLobbyOpen) exitWith {
			stopThisUpdate();
		};
		
		{
			_lastUpd = _x getVariable 'lastupdate';
			if (tickTime >= _lastUpd) then {
				_x setFade 0;
				_sp = SPRITE_STARTPOS; _sp set [1,-30 - rand(-30,-10)];
				[_x,_sp] call widgetSetPositionOnly;
				_randBias = rand(1,10);
				_x setFade 0;
				_x ctrlSetAngle [random 360, 0.5, 0.5,false];
				[_x,SPRITE_ENDPOS,SPRITE_LIFETIME - _randBias] call widgetSetPositionOnly;
				_x setVariable ['lastupdate',tickTime + SPRITE_LIFETIME-_randBias];
			};
		} foreach (_this select 0);
	};
	
	startUpdateParams(_onFrameCodeFog,0,_localFogs);
	
	
	
};

