// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



init_function(golib_cs_initAll)
{
	params [["_syncMarks",true],["_syncElectronic",true]];
	private _hash = null;
	private _isNeedReload = false;
	{
		if (_x call golib_hasHashData) then {
			_hash = _x call golib_getHashData;
			_hasMark = "mark" in _hash;
			if (_syncMarks) then {
				if (_hasMark) then {
					private _curMark = _hash get "mark";
					if (_curMark in golib_internal_map_marks) then {
						private _oldMark = _curMark;
						
						//only 10k elements
						while {_curMark in golib_internal_map_marks} do {
							if ([_curMark,"\(\d+\)$"] call regex_isMatch) then {
								private _numStr = [_curMark,"\(\d+\)$"] call regex_getFirstMatch;
								_numStrNew = "("+(str((parseNumber (_numStr select [1,count _numStr - 2]))+1))+")";
								_curMark = ([_curMark,"\(\d+\)$",""] call regex_replace)+_numStrNew;
							} else {
								_curMark = _curMark + " (1)";
							};
						};
						
						["Mark '%1' already registered. Replaced to '%2'",_oldMark,_curMark] call printError;
						_hash set ["mark",_curMark];
						[_x,_hash] call golib_setHashData;

						if (!_isNeedReload && {_x in (call golib_getSelectedObjects)}) then {
							_isNeedReload = true;
						};
					};
					golib_internal_map_marks set [_curMark,_x];
				};
			};
			
		};
	} foreach (all3DENEntities select 0);
	
	if (_syncElectronic) then {
		{
			if (_x call golib_hasHashData) then {
				_hash = [_x,false] call golib_getHashData;
				_hasMark = "mark" in _hash;
				//second pass for electronics
				if ("edConnected" in _hash && _hasMark) then {
					//["validate %1 (%2)",_hash get "mark",_hash get "edConnected"] call printTrace;
					_listEd = _hash get "edConnected";
					_baseCount = count _listEd;
					{
						if (!(_x in golib_internal_map_marks)) then {
							_listEd set [_forEachIndex,objnull];
						};
					} foreach _listEd;
					_listEd = _listEd - [objnull];
					if (count _listEd == 0) exitwith {
						_hash deleteat "edConnected";
						[_x,_hash] call golib_setHashData;
						["Non-existen mark removed from connected objects at %1",_x] call printWarning;
					};
					
					_hash set ["edConnected",_listEd];

					if (count _listEd != _baseCount) then {
						[_x,_hash] call golib_setHashData;
						["Updated hash data for object %1",_x] call printLog;
					};

					golib_internal_map_connected set [_hash get "mark",_hash get "edConnected"];
				};
			};
		} foreach (all3DENEntities select 0);		
	};
	
	if (_isNeedReload) then {
		[null] call inspector_menuLoad;
	};
}

init_function(golib_cs_initHandler)
{
	["onPaste",{
		call golib_cs_syncMarks;
	}] call Core_addEventHandler;
	["onUndo",{
		call golib_cs_syncMarks;
	}] call Core_addEventHandler;
	["onRedo",{
		call golib_cs_syncMarks;
	}] call Core_addEventHandler;
}

function(golib_cs_getObjectByMark)
{
	golib_internal_map_marks getOrDefault [_this,objnull];
}

function(golib_cs_syncMarks)
{
	golib_internal_map_marks = createHashMap;
	golib_internal_map_connected = createHashMap;
	[true,true] call golib_cs_initAll; //второй true потому что удаленные ссылки не будут работать
}