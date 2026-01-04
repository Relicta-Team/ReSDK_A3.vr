// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#ifdef POINTER_SYSTEM_EXPERIMENTAL

	//create and return pointer
	#define pointer_new(ref) ((ref) call pointer_create)

	#define pointer_delete(ref) (ref) call pointer_del

	#define pointer_exists(id) (id) call pointer_isExists

	#define pointer_get(id) (pointerList getOrDefault [id,'_nf_'])

	#define pointer_isValidResult(result) (!(result isEqualTo "_nf_"))
	
	#define pointer_tryUnpack(_ref,_varName) private _varName = (pointerList getOrDefault [_ref,locationNull])
	#define pointer_tryUnpackLazy(_ref,_varName) pointer_tryUnpack(_ref,_varName); if (ISNULL _varName) exitWith {};
	
#else
	//create and return pointer
	#define pointer_new(ref) ((ref) call pointer_create)

	#define pointer_delete(ref) (ref) call pointer_del

	#define pointer_exists(id) (id) call pointer_isExists

	#define pointer_get(id) (pointerList getvariable [id,'_nf_'])

	#define pointer_isValidResult(result) (!(result isEqualTo "_nf_"))
	
	#define pointer_tryUnpack(_ref,_varName) private _varName = (pointerList getVariable [_ref,locationNull])
	#define pointer_tryUnpackLazy(_ref,_varName) pointer_tryUnpack(_ref,_varName); if (ISNULL _varName) exitWith {};
#endif
