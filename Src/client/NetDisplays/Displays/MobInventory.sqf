// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


ND_INIT(MobInventory)
	//getWidthByHeightToSquare
	//_ctg = [(40),(40)] call nd_stdLoad;
	_ctg = if (isFirstLoad) then {
		_sx = 40;
		_sy = 70;
		private _ctg = [thisDisplay,WIDGETGROUP,[50 - _sx/2,50-_sy/2,_sx,_sy]] call createWidget;
		addSavedWdiget(_ctg);

		_back = [thisDisplay,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
		_back setBackgroundColor [0.3,0.3,0.3,0.5];

		_closer = [thisDisplay,[0,90,100,10],_ctg] call nd_addClosingButton;
		_closer ctrlSetText "Закрыть";

		_ctgLeft = [thisDisplay,WIDGETGROUPSCROLLS,[0,0,100,90],_ctg] call createWidget;
		addSavedWdiget(_ctgLeft);
		
		_ctgLeft
	} else {
		getSavedWidgets select 1
	};
	
	call nd_cleanupData;
	
	__allocTxt = {
		if equals(_this,[]) then {
			_ptr = "";
			inventory_slotnames_default select _i;
		} else {
			_this params ["_name","_icn","_ptrex"];
			_ptr = _ptrex;
			if (!(".paa" in _icn)) then { //realoc if not fullpath
				_icn = PATH_PICTURE_INV(_icn);
			};
			format["(%1) <img size='1.3' image='%2'/> %3",inventory_slotnames_default select _i,_icn,_name];
		};	
	};
	_lall = INV_LIST_ALL;
	_sizeH = 100 / (count _lall);
	_ptr = ""; //outside reference
	for "_i" from 0 to (count _lall) - 1 do {
		regNDWidget(TEXT,vec4(0,_sizeH * _i,100,_sizeH),_ctg,null);
		[lastNDWidget,format["<t align='center'>%1</t>",(ctxParams deleteAt 0) call __allocTxt]] call widgetSetText;
		lastNDWidget setVariable ["ref",_ptr];
		lastNDWidget setVariable ["slotid",_lall select _i];
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			_id = _ct getVariable ["slotid",null];
			if !isNullVar(_id) then {
				[_id] call nd_onPressButton;
			};
		}]
	};	
	
	/*#define SIZE_INVSLOT 7
	#define SLOT_BIASH 0.3
	
	[0,0,getWidthByHeightToSquare(SIZE_INVSLOT),SIZE_INVSLOT] params ["_xp","_yp","_wp","_hp"];

	_xp = 50 - transformSizeByAR(SIZE_INVSLOT) / 2;
	_yp = 50 - SIZE_INVSLOT;

	private _biasW = transformSizeByAR(SLOT_BIASH);

	#define allocpos__(xpos,ypos) [_xp + ((_wp + _biasW) * xpos),_yp + ((_hp + SLOT_BIASH) * ypos),_wp,_hp]
	
	{
		(inventory_slotpos_map select _x) params ["_xMap","_yMap"];
		regNDWidget(PICTURE,allocpos__(_xMap,_yMap),null,null);
		lastNDWidget ctrlSetText (inventory_sloticons_default select _x);
	} foreach inventory_openModeSlotsId;*/
	
	
ND_END