// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	This common component. Included in preinit
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

faces_list_man = [];
faces_list_woman = [];
private ___skippedmanclasses = 0;
//replicate mp vars
faces_list_man = [false] call facesys_prepManFaces;
faces_list_woman = call facesys_prepWomanFaces;


//just logged this
if (isServer) then {
	_cman = count (faces_list_man);
	_cwman = count (faces_list_woman);
	logformat("Faces lists loaded. Counts: %1/%2 (man/woman); Skipped man faces %3",_cman arg _cwman arg ___skippedmanclasses);
} else {
	facesys_prepManFaces = null;
	facesys_prepWomanFaces = null;
};
