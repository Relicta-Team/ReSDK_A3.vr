// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//!FIXME performance issues
init_function(golib_cs_initAll)
{
	params [["_syncMarks",true],["_syncElectronic",true]];
	private _hash = null;
	// private _isNeedReload = false; //!update is always performed
	private _selectedObjects = call golib_getSelectedObjects;

	private _cs_markProcessor = {
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
	};

	{
		if (_x call golib_hasHashData) then {
			_hash = _x call golib_getHashData;
			_hasMark = "mark" in _hash;
			if (_syncMarks) then {
				if (_hasMark) then {
					private _curMark = _hash get "mark";
					if (_curMark in golib_internal_map_marks) then {
						private _oldMark = _curMark;
						
						call _cs_markProcessor;
						
						["Mark '%1' already registered. Replaced to '%2'",_oldMark,_curMark] call printError;
						_hash set ["mark",_curMark];
						[_x,_hash] call golib_setHashData;
					};
					
					//if (!_isNeedReload && {_x in _selectedObjects}) then {_isNeedReload = true;};
					
					golib_internal_map_marks set [_curMark,_x];
				};

				//check container content marks
				if ("containerContent" in _hash) then {
					private _conCont = _hash get "containerContent";
					private _hdList = _conCont apply {(_x select 0) call golib_deserializeHashData};
					private _curMark = null;
					private _curHash = null;
					private _updateHD = false;
					{
						_curHash = _x;
						_curMark = _curHash get "mark";
						if !isNullVar(_curMark) then {
							if (_curMark in golib_internal_map_marks) then {
								_updateHD = true;
								_oldMark = _curMark;

								call _cs_markProcessor;

								["Container mark '%1' already registered. Replaced to '%2'",_oldMark,_curMark] call printError;
								_curHash set ["mark",_curMark];
								(_conCont select _foreachIndex) set [0,[_curHash] call golib_serializeHashData];
							};

							golib_internal_map_marks set [_curMark,objNull];
							hashSet_add(golib_internal_map_contMarks,_curMark);
						};

					} foreach _hdList;

					if (_updateHD) then {
						_hash set ["containerContent",_conCont];
						[_x,_hash] call golib_setHashData;
					};
				};

			};
			
		};
	} foreach (all3DENEntities select 0);
	
	if (_syncElectronic) then {
		private _objPtr = objNull;
		private _markName = null;
		{
			_markName = _x;
			_objPtr = _y;

			//check if mark defined in container-side
			if (_markName in golib_internal_map_contMarks) then {continue};

			if (_objPtr call golib_hasHashData) then {
				_hash = [_objPtr,false] call golib_getHashData;
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
						[_objPtr,_hash] call golib_setHashData;
						["Non-existen mark '%2' removed from connected objects at %1",_objPtr,_markName] call printWarning;
					};
					
					_hash set ["edConnected",_listEd];

					if (count _listEd != _baseCount) then {
						[_objPtr,_hash] call golib_setHashData;
						["Updated hash data for object %1 (%2)",_objPtr,_markName] call printLog;
					};

					golib_internal_map_connected set [_hash get "mark",_hash get "edConnected"];
				};
			} else {

				["Unexpected object on sync electronics %1",_x] call printError;
			};
		} foreach ifcheck(_syncMarks,golib_internal_map_marks,all3DENEntities select 0);		
	};
	
	// Обновление нужно в любом случае: нарпимер если марку на выбранном объекте удалили
	if (count _selectedObjects == 0) then {
		_selectedObjects = null;
	};
	//!TEMPFIX
	nextFrameParams(inspector_menuLoad,[_selectedObjects]);
	
}

init_function(golib_cs_initHandler)
{
	golib_history_markDirty = false;
	golib_history_changeMode = 0; //1 redo, -1 undo;
	golib_history_skippedHistoryStageFlag = "#SYSTEM#";

	["onPaste",{
		call golib_cs_syncMarks;
	}] call Core_addEventHandler;
	["onUndo",{
		golib_history_markDirty = true;
		golib_history_changeMode = -1;
	}] call Core_addEventHandler;
	["onRedo",{
		golib_history_markDirty = true;
		golib_history_changeMode = 1;
	}] call Core_addEventHandler;

	["onFrame",{
		if (golib_history_markDirty) then {
			_changeMode = "";
			if (golib_history_changeMode == 1) then {_changeMode = "Redo"};
			if (golib_history_changeMode == -1) then {_changeMode = "Undo"};
			_historyText = call nativeWidgets_getCurrentHistoryText;
			["[%3] (%2) %1",_historyText,lbcursel (call nativeWidgets_getListboxHistory),_changeMode] call printTrace;
			golib_history_markDirty = false;
			golib_history_changeMode = 0;

			if (golib_history_skippedHistoryStageFlag in _historyText) then {
				if (_changeMode != "") then {
					do3DENAction _changeMode;
				} else {
					["Unexpected history stage"] call showWarning;
				};
			} else {
				call golib_cs_syncMarks;
			};

		};
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
	golib_internal_map_contMarks = createhashMap;
	[true,true] call golib_cs_initAll; //второй true потому что удаленные ссылки не будут работать
}