// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


if (!isMultiplayer) then {
	nd_internal_data_ChemReactionsInfo = null;
};

ND_INIT(ChemReactionsInfo)

	_ctg = if (isFirstLoad) then {
		
		_sx = 90;
		_sy = 90;
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
	
	_curY = 0;
	
	FHEADER;
	
	if (count ctxParams == 1 && isNull(nd_internal_data_ChemReactionsInfo)) then {
		regNDWidget(BUTTON,vec4(0,0,100,10),_ctg,null);
		lastNDWidget ctrlSetText "Выгрузить информацию";
		lastNDWidget ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt != MOUSE_LEFT) exitWith {};
			
			[[0,isNull(nd_internal_data_ChemReactionsInfo)]] call nd_onPressButton;
		}];
		
		RETURN(0);
	} else {
		
		regNDWidget(TEXT,vec4(0,0,50,10),_ctg,null);
		[lastNDWidget,format["<t align='center'>РЕАГЕНТЫ</t>"]] call widgetSetText;
		regNDWidget(TEXT,vec4(50,0,50,10),_ctg,null);
		[lastNDWidget,format["<t align='center'>РЕАКЦИИ</t>"]] call widgetSetText;
	};
	
	if !isNull(nd_internal_data_ChemReactionsInfo) then {
		ctxParams = nd_internal_data_ChemReactionsInfo;
	} else {
		nd_internal_data_ChemReactionsInfo = ctxParams;
	};
	ctxParams params ["_reagents","_reactions"];
	
/*	_reagentsSource = +_reagents;
	_reactionsSource = +_reactions;
	_namesReagents = _reagentsSource apply {_x select 0};
	_namesReactions = _reactionsSource apply {_x select 0};
	_namesReagents sort true;
	_namesReactions sort true;
	{
		_reagents set [_x]
	} foreach _reagentsSource;*/
	
	MOD(_curY,+ 10);
	regNDWidget(WIDGETGROUP_H,vec4(0,_curY,50,90),_ctg,null);
	_ctgReagents = lastNDWidget;
	regNDWidget(BACKGROUND,vec4(0,_curY,50,90),_ctg,null);
	lastNDWidget setBackgroundColor [1,0,0,0.01];
	
	regNDWidget(WIDGETGROUP_H,vec4(50,_curY,50,90),_ctg,null);
	_ctgReactions = lastNDWidget;
	regNDWidget(BACKGROUND,vec4(50,_curY,50,90),_ctg,null);
	lastNDWidget setBackgroundColor [0,0,1,0.01];
	
	#include <..\..\..\host\MatterSystem\MatterSystem.hpp>
	
	_curY = 0;
	_reqReagentsToString = {
		if (count _this == 0) exitWith {"NO"};
		_this joinString "+"
	};
	{
		
		_x params ["_classname","_name","_scienceName","_slangName","_state",
			["_chilling_products",[]],["_chilling_point","NO"],
			["_heating_products",[]],["_heating_point","NO"]];
		
		
		regNDWidget(TEXT,vec4(0,30 * _forEachIndex,100,30),_ctgReagents,null);
		lastNDWidget setBackgroundColor [rand(0,0.3),rand(0,0.9),rand(0,0.8),0.2];
		
		_text = ["TypeName: %2%1Name:%3; SciName:%4; SlaName:%5;%1"+
		"state:%6%1"+
		"chilling point(%8°C): %7%1" + 
		"heating point(%10°C): %9%1"
		,sbr,_classname,_name,_scienceName,_slangName,_state,_chilling_products call _reqReagentsToString,
		_chilling_point,_heating_products call _reqReagentsToString,_heating_point];
		[lastNDWidget,format _text] call widgetSetText;
		_text set [1,"\n"];
		lastNDWidget ctrlSetTooltip (format _text);
		
	} foreach _reagents;

	_reactionListInfoToString = {
		if (count _this == 0) exitWith {"NO_REAGENTS"};
		private _data = [];
		{
			_data pushBack (format["%1 (x%2)",_x select 0,_x select 1])
		} foreach _this;
		_data joinString " + "
	};
	
	_itemListInfoToString = {
		if (count _this == 0) exitWith {"NO_ITEMS"};
		private _data = [];
		{
			_data pushBack (format["%1 (x%2)",_x select 0,_x select 1])
		} foreach _this;
		_data joinString " + "
	};
	
	_checkNumberTemp = {
		if (finite _this) then {_this} else {_s = (str _this) select [0,1]; if (_s == "-")then{"-INF"}else{"INF"}}
	};
	{
		_x params ["_className","_name",["_result","NORESULT"],["_resultAmount",0],
		["_reqMatters",[]],["_cata",[]],["_inhib",[]],"_reaType","_minTemp","_maxTemp","_itemsNeed"];
		
		regNDWidget(TEXT,vec4(0,35 * _forEachIndex,100,35),_ctgReactions,null);
		lastNDWidget setBackgroundColor [rand(0,0.3),rand(0,0.9),rand(0,0.8),0.2];
		
		_text = ["SystemName:%2%1" +
			"Name:%3%1" +
			"Result: %4 (x%5)%1" + 
			"Items: %12%1" +
			"Need:%6%1" + 
			"Catalysts:%7%1"+
			"Inhibitors:%8%1"+
			"Reaction type:%9%1" +
			"Need temp: from %10°C to %11°C"
		,//INPUTDATA
		sbr,_className,_name,_result,_resultAmount,_reqMatters call _reactionListInfoToString,
		_cata call _reactionListInfoToString,
		_inhib call _reactionListInfoToString,REACTION_ENUM_TO_NAME(_reaType),_minTemp call _checkNumberTemp,_maxTemp call _checkNumberTemp,
		_itemsNeed call _itemListInfoToString];
		
		[lastNDWidget,format _text] call widgetSetText;
		_text set [1,"\n"];
		lastNDWidget ctrlSetTooltip (format _text);
		
	} foreach _reactions;

	
ND_END