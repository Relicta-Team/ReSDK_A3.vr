// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define RVENGINE_ISREADY (rve_loaded)

#define RVENGINE_INTERNAL_TOSTRING__(x) #x

/*
	exampleFunc = {
		//implementation
	};
	RVENGINE_REGISTER_NFUNC("rv_client",exampleFunc);
*/
#define RVENGINE_REGISTER_NFUNC(module__,fname__) [module__, RVENGINE_INTERNAL_TOSTRING__(fname__)] call rve_nativeFunc; \
[format["RVEngine: registered function %1 from %2",RVENGINE_INTERNAL_TOSTRING__(fname__),module__]] call rve_log;


/*
	Пример регистрации native функций в модуле

	RVENGINE_BEGIN_MODULE("rv_client")
		RVENGINE_SET_WRAPPER_CONDITION(true)
		RVENGINE_DECL_NFUNC(exampleFunc)
		RVENGINE_DECL_NFUNC(exampleFunc2)
		enableWrapperFunc3 = false;
		RVENGINE_SET_WRAPPER_CONDITION(enableWrapperFunc3)
		RVENGINE_DECL_NFUNC(exampleFunc3)
	RVENGINE_END_MODULE
*/
#define RVENGINE_BEGIN_MODULE(module__) _rve_condition__ = nil; _rve_mod__ = module__; _rve_regfunc__ = { [_rve_mod__, _x select 0, _x select 1] call rve_nativeFunc}; _rve_fncnames__ = [];

#define RVENGINE_DECL_NFUNC(fname__) _rve_fncnames__ pushBack [RVENGINE_INTERNAL_TOSTRING__(fname__),_rve_condition__];

#define RVENGINE_SET_WRAPPER_CONDITION(cond__) _rve_condition__ = RVENGINE_INTERNAL_TOSTRING__(cond__);

#define RVENGINE_END_MODULE _rve_regfunc__ foreach _rve_fncnames__; [format["RVEngine: registered %1 functions from %2",count _rve_fncnames__,_rve_mod__]] call rve_log;