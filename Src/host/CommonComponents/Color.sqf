// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

//todo
/*
BIS_fnc_3DENDiagFonts;

BIS fnc colorConfigToRGBA
BIN fnc colorHSLtoRGB
BIS fnc colorMarker
BIS fnc colorRGBAtoHTML
BIS fnc colorRGBAtoTexture
*/
#define importNative(funcname__) BIS_fnc_##funcname__
#ifdef DEBUG
	color_diagfonts = importNative(3DENDiagFonts);
#endif


/*color_hexTable256 = [
"00","01","02","03","04","05","06","07","08","09","0A","0B","0C","0D","0E","0F",
"10","11","12","13","14","15","16","17","18","19","1A","1B","1C","1D","1E","1F",
"20","21","22","23","24","25","26","27","28","29","2A","2B","2C","2D","2E","2F",
"30","31","32","33","34","35","36","37","38","39","3A","3B","3C","3D","3E","3F",
"40","41","42","43","44","45","46","47","48","49","4A","4B","4C","4D","4E","4F",
"50","51","52","53","54","55","56","57","58","59","5A","5B","5C","5D","5E","5F",
"60","61","62","63","64","65","66","67","68","69","6A","6B","6C","6D","6E","6F",
"70","71","72","73","74","75","76","77","78","79","7A","7B","7C","7D","7E","7F",
"80","81","82","83","84","85","86","87","88","89","8A","8B","8C","8D","8E","8F",
"90","91","92","93","94","95","96","97","98","99","9A","9B","9C","9D","9E","9F",
"A0","A1","A2","A3","A4","A5","A6","A7","A8","A9","AA","AB","AC","AD","AE","AF",
"B0","B1","B2","B3","B4","B5","B6","B7","B8","B9","BA","BB","BC","BD","BE","BF",
"C0","C1","C2","C3","C4","C5","C6","C7","C8","C9","CA","CB","CC","CD","CE","CF",
"D0","D1","D2","D3","D4","D5","D6","D7","D8","D9","DA","DB","DC","DD","DE","DF",
"E0","E1","E2","E3","E4","E5","E6","E7","E8","E9","EA","EB","EC","ED","EE","EF",
"F0","F1","F2","F3","F4","F5","F6","F7","F8","F9","FA","FB","FC","FD","FE","FF"
];*/
color_hexTable256 = [];
color_map_hexStrToNum = createHashMap;
__inc = 0;
for "_i" from 0 to 15 do {
	for "_j" from 0 to 15 do {
		_val = format["%1%2",toUpper(table_hex select _i),toUpper(table_hex select _j)];
		color_hexTable256 pushBack _val;
		color_map_hexStrToNum set [_val,__inc];
		INC(__inc);
	};
	
};


//свои
color_RGBAtoHTML = {
	params ["_r","_g","_b","_a"];
	private _ht = color_hexTable256;
	format [
	"#%1%2%3%4",
	_ht select linearConversion [0, 1, _a, 0, 255, true],
	_ht select linearConversion [0, 1, _r, 0, 255, true],
	_ht select linearConversion [0, 1, _g, 0, 255, true],
	_ht select linearConversion [0, 1, _b, 0, 255, true]
	]
};

color_RGBtoHTML = {
	params ["_r","_g","_b"];
	private _ht = color_hexTable256;
	format [
	"#%1%2%3",
	_ht select linearConversion [0, 1, _r, 0, 255, true],
	_ht select linearConversion [0, 1, _g, 0, 255, true],
	_ht select linearConversion [0, 1, _b, 0, 255, true]
	]
};

color_RGBAtoTex = {
	params ["_r","_g","_b",["_a",1]];

	format [
	"#(argb,8,8,3)color(%1,%2,%3,%4)", 
	linearConversion [0, 1, _r, 0, 1, true],
	linearConversion [0, 1, _g, 0, 1, true],
	linearConversion [0, 1, _b, 0, 1, true],
	linearConversion [0, 1, _a, 0, 1, true]
	]
};

color_HTMLtoRGBA = {
	params ["_html"];
	if (_html select [0,1] == "#") then {
		_html = _html select [1,count _html - 1];
	};
	//add alpha
	if (count _html == 6) then {
		_html = "FF"+_html;
	};
	
	//for map finder
	_html = toUpper _html;
	
	//return RGBA
	[
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [2,2]), 0,1,true],
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [4,2]), 0,1,true],
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [6,2]), 0,1,true],
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [0,2]), 0,1,true]
	]
};

color_HTMLtoRGB = {
	params ["_html"];
	if (_html select [0,1] == "#") then {
		_html = _html select [1,count _html - 1];
	};
	
	//remove alpha
	if (count _html == 8) then {
		_html = _html select [2,count _html - 2];
	};
	
	//for map finder
	_html = toUpper _html;
	
	//return RGB
	[
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [0,2]), 0,1,true],
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [2,2]), 0,1,true],
		linearConversion [0, 255, color_map_hexStrToNum get (_html select [4,2]), 0,1,true]
	]
};