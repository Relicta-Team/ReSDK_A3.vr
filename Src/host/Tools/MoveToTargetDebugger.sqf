// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>

#define ACT_WALK "SlowF"
#define ACT_STOP "Stop"


mttd_start = {
	params ["_newposition"];

	if (mttd_curhandle!=-1) then {
		stopUpdate(mttd_curhandle);
	};

	mttd_targetpos = _newposition;

	private _m = {
		/*
			alg moving:

			if distmoving>=(mloc distance startpos)
				stop()

			if canmove(mloc+vec_direct)
				if notmoved
					move(vec_direct)
					startpos = mloc //here start pos as backuped pos
				else
					... no acts
			else
				probvecdir = null
				{
					probvecdir_local = canmove(mloc+x)
					if probvecdir_local
						probvecdir = probvecdir_local
						break
				} each x8_side

				if !probvecdir
					rotate(probvecdir)
				else
					...todo: get last normal position and return to this

		*/
		/*
			variants:
				1. serialize other players positions - low cover, only following, huge mem
				2. emplace generated navmes on unit view plane - low performance, coverage bugs
				3. ...

			sec alg:



		*/


	};
	startUpdate(_m,0.1);

};



mttd_doact = {
	mttd_srcobj playActionNow _this
};
mttd_targetpos = [0,0,0];
mttd_curhandle = -1;
mttd_srcobj = null;
mttd_arrForward = null;
mttd_arrDirect = null;

mttd_ray = {
	params ["_beg","_end"];
	_its = lineIntersectsSurfaces [_beg, _end, mttd_srcobj, objnull, true, 1, "GEOM", "VIEW"]
	if (count _its == 0) exitWith {
		[_beg,[0,0,1],mttd_srcobj]
	};
	[ASLToATL(_its select 0 select 0),_its select 0 select 1,_its select 0 select 2]
};
