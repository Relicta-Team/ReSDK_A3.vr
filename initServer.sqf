// Do not modify or delete this file

//only in debug mode
go = {titleCut ["","BLACK IN", 0]; call compile preprocessFileLineNumbers "src\fn_init.sqf"};


// only in debug mode
//call compile preprocessFile "src\host\MapManager\map_manager.sqf";
waitUntil {!isNull (findDisplay 46)};

isNil go;
