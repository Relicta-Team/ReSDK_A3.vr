// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

fn_iconViewer = {
	params [
		["_mode", "", [""]],
		["_args", [], [[]]]
	];

	if (!hasInterface) exitWith {};
	disableSerialization;

	private _fnc_GRID_X = {
		pixelW * pixelGridNoUIScale * (((_this) * (2)) / 4)
	};

	private _fnc_GRID_Y = {
		pixelH * pixelGridNoUIScale * ((_this * 2) / 4)
	};	

	switch _mode do {
		case "onload": {
			private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
			if (isNull _display) exitWith {};

			uiNamespace setVariable ["HALs_icons_idd", _display];

			["create", []] call fn_iconViewer;

			if (isNil {localNamespace getVariable "HALs_gameIcons"}) then {
				private _h = [] spawn {
					systemChat "Fetching images from available pbos.";

					private _icons = [];
					private _addons = allAddonsInfo apply {_x select 0};
					{
						_icons append (addonFiles [_x, ".paa"]);
						_icons append (addonFiles [_x, ".jpg"]);
						_icons append (addonFiles [_x, ".tga"]);
						_icons append (addonFiles [_x, ".bmp"]);
					} forEach _addons;

					localNamespace setVariable ["HALs_gameIcons", _icons];
					localNamespace setVariable ["HALs_icons_numIcons", count _icons];
					localNamespace setVariable ["HALs_icons", _icons];

					["update", []] call fn_iconViewer;
				};
			} else {
				["update", []] call fn_iconViewer;
			};
		};

		case "create": {
			private _display = uiNamespace getVariable ["HALs_icons_idd", displayNull];
			if (isNull _display) exitWith {};

			private _TABLE_WIDTH = 130;
			private _TABLE_HEIGHT = 120;

			private _totW = ((_TABLE_WIDTH) call _fnc_GRID_X);
			private _totH = ((_TABLE_HEIGHT) call _fnc_GRID_Y);

			private _pos = [
				safeZoneX + (safeZoneW / 2) - (((_TABLE_WIDTH / 2) call _fnc_GRID_X)),
				safeZoneY + (safeZoneH / 2) - (((_TABLE_HEIGHT / 2) call _fnc_GRID_Y)),
				((_TABLE_WIDTH) call _fnc_GRID_X),
				((_TABLE_HEIGHT) call _fnc_GRID_Y)
			];

			private _ctrlGroupMain = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
			_ctrlGroupMain ctrlSetPosition _pos;
			_ctrlGroupMain ctrlCommit 0;

			private _background = _display ctrlCreate ["RscText", -1, _ctrlGroupMain];
			_background ctrlSetPosition [0, 0, _pos select 2, _pos select 3];
			_background ctrlSetBackgroundColor [0.05, 0.05, 0.05, 0.95];
			_background ctrlEnable false;
			_background ctrlCommit 0;

			private _headerBackground = _display ctrlCreate ["RscText", -1, _ctrlGroupMain];
			_headerBackground ctrlSetPosition [0, 0, _pos select 2, ((3) call _fnc_GRID_Y)];
			_headerBackground ctrlSetBackgroundColor [
				profilenamespace getvariable ['GUI_BCG_RGB_R', 0.3843],
				profilenamespace getvariable ['GUI_BCG_RGB_G', 0.7019],
				profilenamespace getvariable ['GUI_BCG_RGB_B', 0.8862],
				1
			];
			_headerBackground ctrlEnable false;
			_headerBackground ctrlCommit 0;

			private _headerText = _display ctrlCreate ["RscText", -1, _ctrlGroupMain];
			_headerText ctrlSetPosition [0, 0, _pos select 2, ((3) call _fnc_GRID_Y)];
			_headerText ctrlSetFont "RobotoCondensed";
			_headerText ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_headerText ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_headerText ctrlSetText "Icon Viewer";
			_headerText ctrlEnable false;
			_headerText ctrlCommit 0;

			private _closeButton = _display ctrlCreate ["ctrlButtonPictureKeepAspect", -1, _ctrlGroupMain];
			_closeButton ctrlSetText "\a3\3DEN\Data\Displays\Display3DEN\search_end_ca.paa";
			_closeButton ctrlSetPosition [(_pos select 2) - ((3 + 0.5) call _fnc_GRID_X), 0, ((3 + 0.5) call _fnc_GRID_X), ((3) call _fnc_GRID_Y)];
			_closeButton ctrlAddEventHandler ["ButtonClick", {
				private _display = uiNamespace getVariable ["HALs_icons_idd", displayNull];
				if (!isNull _display) then {_display closeDisplay 2;};
			}];
			_closeButton ctrlCommit 0;

			private _footerBackground = _display ctrlCreate ["RscText", -1, _ctrlGroupMain];
			_footerBackground ctrlSetPosition [0, (_pos select 3) - ((5) call _fnc_GRID_Y), _pos select 2, ((5) call _fnc_GRID_Y)];
			_footerBackground ctrlSetBackgroundColor [0.1, 0.1, 0.1, 1];
			_footerBackground ctrlEnable false;
			_footerBackground ctrlCommit 0;

			private _ctrlGroupList = _display ctrlCreate ["RscControlsGroupNoScrollbars", 12002, _ctrlGroupMain];
			_ctrlGroupList ctrlSetPosition [
				0,
				((3 + 0.5) call _fnc_GRID_Y),
				_pos select 2,
				(_pos select 3) - ((3 + 0.5 + 0.5 + 5) call _fnc_GRID_Y)
			];
			_ctrlGroupList ctrlSetBackgroundColor [1, 1, 1, 0.9];
			_ctrlGroupList ctrlCommit 0;

			private _origPos = ctrlPosition _ctrlGroupList;
			private _boxesX = localNamespace getVariable ["HALs_icons_boxesX", 5];
			private _boxesY = localNamespace getVariable ["HALs_icons_boxesY", 5];

			private _w0 = (
				(_origPos select 2) - ((_boxesX + 1) * ((0.5) call _fnc_GRID_X))
			) / _boxesX;
			private _h0 = (
				(_origPos select 3) - ((_boxesY + 1) * ((0.5) call _fnc_GRID_Y))
			) / _boxesY;
			private _x0 = (0.5) call _fnc_GRID_X;
			private _y0 = (0.5) call _fnc_GRID_Y;

			private _ctrls = [];
			for [{_i = 0}, {_i < _boxesY}, {_i = _i + 1}] do {
				private _y = _y0 + (((0.5) call _fnc_GRID_Y) + _h0) * _i;
				private _x = _x0;
				
				for [{_j = 0}, {_j < _boxesX}, {_j = _j + 1}] do {
					_x = _x0 + (((0.5) call _fnc_GRID_X) + _w0) * _j;
					private _pos = [_x, _y, _w0, _h0];

					private _ctrlBox = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGroupList];
					_ctrlBox setVariable ["data", ""];
					_ctrlBox ctrlShow false;

					_ctrlBox ctrlSetPosition _pos;
					_ctrlBox ctrlCommit 0;

					private _ctrlTextBG = _display ctrlCreate ["RscText", -1, _ctrlBox];
					_ctrlTextBG ctrlSetBackgroundColor [1, 1, 1, 0.15];

					_ctrlTextBG ctrlSetPosition [0, 0, _pos select 2, _pos select 3];
					_ctrlTextBG ctrlEnable false;
					_ctrlTextBG ctrlCommit 0;

					private _ctrlPicture = _display ctrlCreate ["RscPictureKeepAspect", -1, _ctrlBox];
					_ctrlPicture ctrlSetText "";
					_ctrlPicture ctrlSetBackgroundColor [1, 1, 1, 0.25];

					_ctrlPicture ctrlSetPosition [0, 0, _pos select 2, _pos select 3];
					_ctrlPicture ctrlEnable false;
					_ctrlPicture ctrlCommit 0;

					private _ctrlTextTitle = _display ctrlCreate ["RscStructuredText", -1, _ctrlBox];
					_ctrlTextTitle ctrlSetStructuredText parseText format ["<t size='0.9' shadow='2' font='puristaMedium' align='center' >%1</t>",
						"a3\ui_f_oldman\data\displays\rscdisplaymain\spotlight_1_old_man_ca.paa"
					];
					_ctrlTextTitle setVariable ["bg", _ctrlTextBG];

					_ctrlTextTitle ctrlSetPosition [0, 0, _pos select 2, (ctrlTextHeight _ctrlTextTitle) min (_pos select 3)];
					_ctrlTextTitle ctrlEnable false;
					_ctrlTextTitle ctrlCommit 0;

					private _ctrlButton = _display ctrlCreate ["ctrlActivePictureKeepAspect", -1, _ctrlBox];
					_ctrlButton setVariable ["bg", _ctrlTextBG];
					_ctrlButton ctrlAddEventHandler ["ButtonDown", {
						private _ctrl = _this select 0;
						private _data = _ctrl getVariable "data";

						if (!isNil "_data") then {
							copyToClipboard str _data;
							hint "Copied to clipboard.";
						};
					}];
					_ctrlButton ctrlAddEventHandler ["MouseEnter", {
						private _ctrl = (_this select 0) getVariable "bg";
						_ctrl ctrlSetBackgroundColor [0, 0.3, 0.6, 0.6];
					}];
					_ctrlButton ctrlAddEventHandler ["MouseExit", {
						private _ctrl = (_this select 0) getVariable "bg";
						_ctrl ctrlSetBackgroundColor [1, 1, 1, 0.15];
					}];

					_ctrlButton ctrlSetText "\a3\Data_f\clear_empty.paa";
					_ctrlButton ctrlSetPosition [0, 0, _pos select 2, _pos select 3];
					_ctrlButton ctrlEnable true;
					_ctrlButton ctrlCommit 0;

					_ctrlBox setVariable ["ctrls", [_ctrlTextBG, _ctrlTextTitle, _ctrlPicture, _ctrlButton]];
					_ctrls pushBack _ctrlBox;
				};
			};

			_ctrlGroupList setVariable ["ctrls", _ctrls];
			_display setVariable ["ctrlList", _ctrlGroupList];

			private _ctrlSearchInfo = _display ctrlCreate ["RscStructuredText", -1, _ctrlGroupMain];
			_ctrlSearchInfo ctrlSetPosition [
				((0.5) call _fnc_GRID_X),
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((_TABLE_WIDTH - 0.5*2) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlSearchInfo ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_ctrlSearchInfo ctrlEnable false;
			_ctrlSearchInfo ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_ctrlSearchInfo ctrlSetStructuredText parseText format ["<t align='right'>%1 images found</t>", 0];
			_ctrlSearchInfo ctrlCommit 0;

			_display setVariable ["searchInfo", _ctrlSearchInfo];

			private _ctrlSearchCheckbox = _display ctrlCreate ["ctrlCheckbox", 12001, _ctrlGroupMain];
			_ctrlSearchCheckbox ctrlSetPosition [
				((_TABLE_WIDTH / 2) call _fnc_GRID_X) - ((_TABLE_WIDTH / 4) call _fnc_GRID_X) - ((3 + 0.5) call _fnc_GRID_X),
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((3) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlSearchCheckbox ctrlAddEventHandler ["CheckedChanged", {
				private _checked = (_this select 1) == 1;

				(_this select 0) ctrlSetTooltip (["Case Insensitive.", "Case Sensitive."] select _checked);
				localNamespace setVariable ["HALs_icons_caseSensitive", _checked];

				["filterItems", []] call fn_iconViewer;
			}];
			_ctrlSearchCheckbox ctrlCommit 0;

			private _checked = localNamespace getVariable ["HALs_icons_caseSensitive", true];
			_ctrlSearchCheckbox ctrlSetTooltip (["Case Insensitive.", "Case Sensitive."] select _checked);
			_ctrlSearchCheckbox cbSetChecked _checked;

			private _ctrlSearch = _display ctrlCreate ["RscEdit", 12001, _ctrlGroupMain];
			_ctrlSearch ctrlSetPosition [
				((_TABLE_WIDTH / 2) call _fnc_GRID_X) - ((_TABLE_WIDTH / 4) call _fnc_GRID_X),
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((_TABLE_WIDTH / 2) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlSearch ctrlSetFont "RobotoCondensed";
			_ctrlSearch ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_ctrlSearch ctrlSetText (localNamespace getVariable ["HALs_icons_searchText", ""]);
			_ctrlSearch ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_ctrlSearch ctrlSetBackgroundColor [0, 0, 0, 0.7];
			_ctrlSearch ctrlCommit 0;

			private _ctrlButtonSearch = _display ctrlCreate ["ctrlButtonPictureKeepAspect", 12001, _ctrlGroupMain];
			_ctrlButtonSearch ctrlSetPosition [
				((_TABLE_WIDTH / 2) call _fnc_GRID_X) - ((_TABLE_WIDTH / 4) call _fnc_GRID_X) + ((_TABLE_WIDTH / 2) call _fnc_GRID_X) + ((0.5) call _fnc_GRID_Y),
				(_pos select 3) - ((4) call _fnc_GRID_Y),
				((3) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlButtonSearch ctrlSetText "\a3\3DEN\Data\Displays\Display3DEN\search_start_ca.paa";
			_ctrlButtonSearch ctrlSetBackgroundColor [0, 0, 0, 0];
			_ctrlSearch setVariable ["button", _ctrlButtonSearch];
			_ctrlButtonSearch setVariable ["edit", _ctrlSearch];
			
			_ctrlButtonSearch ctrlAddEventHandler ["ButtonClick", {
				params [
					["_ctrl", controlNull, [controlNull]]
				];

				private _ctrlEditSearch = _ctrl getVariable ["edit", controlNull];
				private _searchText = ctrlText _ctrlEditSearch;
				private _oldText = localNamespace getVariable ["HALs_icons_searchText", ""];

				if (_searchText != _oldText) then {
					localNamespace setVariable ["HALs_icons_searchText", _searchText];

					["filterItems", []] call fn_iconViewer;
				};
			}];
			_ctrlButtonSearch ctrlCommit 0;

			private _ctrlPageInfo = _display ctrlCreate ["RscStructuredText", -1, _ctrlGroupMain];
			_ctrlPageInfo ctrlSetPosition [
				(1 + 3 + 0.5) call _fnc_GRID_X,
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((10) call _fnc_GRID_X),
				((5) call _fnc_GRID_Y)
			];
			_ctrlPageInfo ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_ctrlPageInfo ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_ctrlPageInfo ctrlSetStructuredText parseText format ["<t align='center'>1 | %2</t>", 99, 99];
			_ctrlPageInfo ctrlEnable false;
			_ctrlPageInfo ctrlCommit 0;

			_display setVariable ["pageInfo", _ctrlPageInfo];

			private _ctrlButtonL = _display ctrlCreate ["ctrlButton", -1, _ctrlGroupMain];
			_ctrlButtonL ctrlSetPosition [
				(1) call _fnc_GRID_X,
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((3) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlButtonL ctrlSetFont "PuristaMedium";
			_ctrlButtonL ctrlSetText "<";
			_ctrlButtonL ctrlSetTooltip "Previous page.";
			_ctrlButtonL ctrlSetBackgroundColor [1, 1, 1, 0.15];
			_ctrlButtonL ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_ctrlButtonL ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_ctrlButtonL ctrlAddEventHandler ["ButtonClick", {["changePage", [-1]] call fn_iconViewer;}];
			_ctrlButtonL ctrlCommit 0;

			private _ctrlButtonR = _display ctrlCreate ["ctrlButton", -1, _ctrlGroupMain];
			_ctrlButtonR ctrlSetPosition [
				(1 + 3 + 0.5 + 10 + 0.5) call _fnc_GRID_X,
				(_pos select 3) - ((1 + 3) call _fnc_GRID_Y),
				((3) call _fnc_GRID_X),
				((3) call _fnc_GRID_Y)
			];
			_ctrlButtonR ctrlSetFont "PuristaMedium";
			_ctrlButtonR ctrlSetText ">";
			_ctrlButtonR ctrlSetTooltip "Next page.";
			_ctrlButtonR ctrlSetBackgroundColor [1, 1, 1, 0.15];
			_ctrlButtonR ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			_ctrlButtonR ctrlSetTextColor [0.95, 0.95, 0.95, 1];
			_ctrlButtonR ctrlAddEventHandler ["ButtonClick", {["changePage", [1]] call fn_iconViewer;}];
			_ctrlButtonR ctrlCommit 0;
		};

		case "filterItems": {
			private _searchText = localNamespace getVariable ["HALs_icons_searchText", ""];
			private _items = localNamespace getVariable ["HALs_gameIcons", []];

			if (_searchText != "") then {
				if (localNamespace getVariable ["HALs_icons_caseSensitive", true]) then {
					_items = _items select {(_x find _searchText) > -1};
				} else {
					_searchText = toLowerANSI _searchText;

					_items = _items select {(toLowerANSI _x find _searchText) > -1};
				};
			};

			localNamespace setVariable ["HALs_icons", _items];
			localNamespace setVariable ["HALs_icons_page", 0];
			["update", []] call fn_iconViewer;
		};

		case "changePage": {
			private _maxIcons = count (localNamespace getVariable ["HALs_icons", []]);
			private _iconsPerPage = (localNamespace getVariable ["HALs_icons_boxesX", 5]) * (localNamespace getVariable ["HALs_icons_boxesY", 5]);
			private _maxPages = ceil (_maxIcons / _iconsPerPage);

			if (_maxPages == 0) exitWith {
				localNamespace setVariable ["HALs_icons_page", 0];
				["update", []] call fn_iconViewer;
			};

			private _page = localNamespace getVariable ["HALs_icons_page", 0];
			private _amt = (_args param [0, 0, [0]]) + _page;

			if (_amt < 0) then {
				_amt = _maxPages - 1;
			} else {
				_amt = _amt % _maxPages;
			};

			localNamespace setVariable ["HALs_icons_page", _amt];
			["update", []] call fn_iconViewer;
		};

		case "update": {
			private _display = uiNamespace getVariable ["HALs_icons_idd", displayNull];
			private _ctrlGroupList = _display getVariable ["ctrlList", controlNull];
			private _ctrls = _ctrlGroupList getVariable ["ctrls", []];

			private _items = localNamespace getVariable ["HALs_icons", []];
			if (_items isEqualTo []) then {
				{_x ctrlShow false} forEach _ctrls;

				(_display getVariable ["pageInfo", controlNull]) ctrlSetStructuredText parseText format ["<t align='center'>0 | 0</t>"];
				(_display getVariable ["searchInfo", controlNull]) ctrlSetStructuredText parseText format ["<t align='right'>0 images found.</t>"];
			} else {
				private _page = localNamespace getVariable ["HALs_icons_page", 0];
				private _iconsPerPage = (localNamespace getVariable ["HALs_icons_boxesX", 5]) * (localNamespace getVariable ["HALs_icons_boxesY", 5]);
				private _maxPages = ceil (count _items / _iconsPerPage);

				private _n = count _items;
				for [{_i = 0}, {_i < _iconsPerPage}, {_i = _i + 1}] do { 
					private _ctrlBox = _ctrls select _i;

					private _idx = _page * _iconsPerPage + _i;
					if (_idx < _n) then {
						private _img = _items select _idx;
						(_ctrlBox getVariable ["ctrls", []]) params ["", "_ctrlTextTitle", "_ctrlPicture", "_ctrlButton"];

						_ctrlPicture ctrlSetText _img;
						_ctrlTextTitle ctrlSetStructuredText parseText format ["<t size='0.9' shadow='2' font='puristaMedium' align='center' >%1</t>", _img];
						_ctrlButton setVariable ["data", _img];

						_ctrlBox ctrlShow true;
					} else {
						_ctrlBox ctrlShow false;
					};
				};

				(_display getVariable ["pageInfo", controlNull]) ctrlSetStructuredText parseText format ["<t align='center'>%1 | %2</t>", _page + 1, _maxPages];
				(_display getVariable ["searchInfo", controlNull]) ctrlSetStructuredText parseText format ["<t align='right'>%1 images found.</t>", count _items];
			};
		};
	};
};