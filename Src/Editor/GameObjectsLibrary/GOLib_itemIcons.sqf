// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



init_function(golib_internal_initItemIcons)
{
	if isNull(golib_internal_buffer_icons) then {
		golib_internal_buffer_icons = [];
	};
	
	if (count golib_internal_buffer_icons == 0) then {
		private _r = ["FileManager","GetFileEnumerator",[getMissionPath (PATH_PICTURE_FOLDER + "inventory\items\gen"),"*.paa"],false] call rescript_callCommand;
		for "_i" from 0 to (_r select 0) do {
			_icon = "gen\"+((["FileManager","EnumerateFile",[_i],false] call rescript_callCommand) select 0);
			_icon = _icon select [0,count _icon - 4];
	 		golib_internal_buffer_icons pushBack _icon;
		};
	};
}

