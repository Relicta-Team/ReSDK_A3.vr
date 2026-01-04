// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define usecavelog


#define gvar(name) cave_##name


#define dfunc(name) cave_##name
#define cfunc(name) call dfunc(name)


#define vector(x,y,z) [x,y,z]

#define get_x(vec) ((vec) select 0)
#define get_y(vec) ((vec) select 1)
#define get_z(vec) ((vec) select 2)

#define set_x(vec,val) (vec) set [0,val]
#define set_y(vec,val) (vec) set [1,val]
#define set_z(vec,val) (vec) set [2,val]


//inline function
#define math_sign(value) (call \
			{ \
				private _idtvl = value; \
				if (_idtvl < 0) exitwith {-1}; \
				if (_idtvl > 0) exitwith {1}; \
				0 \
			})

//inline helpers for std math
#define math_max(x,y) ((x) max (y))
#define math_min(x,y) ((x) min (y))

#define math_rand(min,max) random((max) - (min)) + (min)

//private inline macro
#define setGrid(x,y,z,val) gvar(grid) select (x) select (y) set [z,val]
#define getGrid(x,y,z) (gvar(grid) select (x) select (y) select (z))

#ifdef usecavelog  
	#define cavelog(a) trace("[CAVELOG]:	" + a) 
	#define cavelogformat(a,f) traceformat("[CAVELOG]:	" + a,f)
#else
	#define cavelog(a)
	#define cavelogformat(a,f) 
#endif 

