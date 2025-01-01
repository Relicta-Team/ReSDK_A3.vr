// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



display_internal_onCloseEventList = [];

displayAddCloseEvent = {
	params ["_code"];
	display_internal_onCloseEventList pushBack _code;
};

displayCallCloseEvent = {
	{
		call _x;
	} foreach display_internal_onCloseEventList;
	
	display_internal_onCloseEventList = []; //dispose
};
