// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Структуры токенов пакетной обработки

	Usage:
		set var VARNAME as VALUE where CONDITION

	Example:
		set type Item where typeof GameObject
		set var.weight as 0.5 where var.size > ITEM_SIZE_TINY and var.name != "Предмет or typeof IDestructible

	set var VARNAME as VALUE [where CONDITION]

	set type TYPENAME [where CONDITION]

	CONDITION:
		EXPRESSION [ (and | or) EXPRESSION ]
	
	EXPRESSION:
		var NAME [== | != | >= | <= | > | <] VALUE
		typeof TYPENAME
		regex STRING REGEX (regex in quotes)
*/

struct(BatchVariableInfo)
	def(type) null;
	def(name) null;
	def(visibleName) null;
	def(definedIn) null;
	def(onLoadWidget) null;
	def(editorContext) null;

	def(init)
	{
		params ["_visname","_definedType","_sysname","_type","_edCtx"];
		self setv(editorContext,_edCtx);
		self setv(visibleName,_visname);
		self setv(definedIn,_definedType);
		self setv(name,_sysname);
		self setv(type,_type);
		private _loader = missionNamespace getVariable ["goasm_attributes_handleProvider_"+_type,{}];

		self setv(onLoadWidget,_loader);
	}

	def(str)
	{
		format["%1::%2(%3)",self getv(definedIn),self getv(name),self getv(type)]
	}
endstruct

struct(BatchTokenBase)
	def(name) "Базовый токен";
	def(description) "Описание";

	def(tokenType) "Base";
	def(nextTokens) []; //one of next type tokens required
	def(canBeEnd) false; //can be last token in token queue

	def(getDisplay) {call getOpenedDisplay};
	def(getTokenIndex) {goasm_batch_executeTokenList find self};
	def(_mainCtg) widgetNull;
	def(_internalCtg) widgetNull;
	def(_widgets) [];

	def(sizeHeight) 15;
	def(sizeWidth) 100;

	def(textSize) 6;
	def(textWidget) widgetNull;

	def(init)
	{
		self setv(_widgets,[]);
		private _ctg = goasm_batch_widgetMap get "ctg";
		private _d = call getOpenedDisplay;
		assert(!isNullReference(_d));
		private _internalCtg = [_d,WIDGETGROUP,[0,0,self getv(sizeWidth),self getv(sizeHeight)],_ctg] call createWidget;
		private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_internalCtg] call createWidget;
		_back setBackgroundColor [0.1,0.1,0.1,1];

		self setv(_mainCtg,_ctg);
		self setv(_internalCtg,_internalCtg);

		private _t = [_d,TEXT,[0,50,self getv(textSize),50],_internalCtg] call createWidget;
		self setv(textWidget,_t);
		//[_t,format["<t align='right'>%1</t>",self getv(name)]] call widgetSetText;
		_t ctrlSetTooltip (self getv(description));

		//button group
		{
			_x params ["_mode","_desc"];
			private _perButton = (self getv(textSize)) / 3;
			private _b = [_d,BUTTON,[_perButton * _foreachindex,0,(_perButton),50],_internalCtg] call createWidget;
			_b ctrlSetText _mode;
			_b ctrlSetTooltip _desc;
			_b setvariable ["mode",_mode];
			_b setvariable ["tok",self];
			_b ctrlAddEventHandler ["MouseButtonUp",{
				private _mode = (_this select 0) getvariable "mode";
				private _tok = (_this select 0) getvariable "tok";
				if (_mode=="+") then {
					_tok callp(swapToken,-1);
				};
				if (_mode=="-") then {
					_tok callp(swapToken,+1);
				};
				if (_mode=="x") then {
					_tok callv(removeToken);
				};
			}];
		} foreach [
			["+","Поднять выше"],
			["-","Опустить ниже"],
			["x","Удалить"]
		]
	}

	def(updateName)
	{
		params ["_pos"];
		[self getv(textWidget),format["<t align='right' size='0.85'>%2: %1</t>",self getv(name),_pos]] call widgetSetText;
	}

	def(str)
	{
		struct_typename(self)
	}

	def(swapToken)
	{
		params ["_ind"];
		private _myIndex = self callv(getTokenIndex);
		private _ofsIndex = _myIndex + _ind;
		private _maxIndex = (count goasm_batch_executeTokenList)-1; 
		["swap index: %1 (side: %2)",_myIndex,_ind] call printTrace;
		
		assert(_myIndex != -1);
		
		if (_ofsIndex < 0 || _ofsIndex > (_maxIndex)) exitWith {};

		[goasm_batch_executeTokenList,_myIndex,_ofsIndex] call arraySwap;
		call goasm_batch_updateRender;
	}

	def(removeToken)
	{
		private _del = [goasm_batch_executeTokenList,self] call arrayDeleteItem;
		["Token removing: %1",_del] call printTrace;
		[self getv(_internalCtg),true] call deleteWidget;
		call goasm_batch_updateRender;
	}

	

	def(onAdded)
	{

	}

	def(prepare)
	{
		//todo implement
	};

	def(renderUpdate)
	{

	}

endstruct

struct(BatchTokenSetVar) base(BatchTokenBase)
	def(name) "Установить свойство";
	def(description) "Установка свойства объекта";
	def(nextTokens) ["BatchTokenWhere"];
	def(canBeEnd) true;
	def(widgetList) null;

	def(init)
	{
		
		
		private _ctg = self getv(_internalCtg);
		private _d = self callv(getDisplay);
		private _textSize = self getv(textSize);
		if (count goasm_batch_allFields == 0) exitWith {
			["Не найдено переменных для модификации"] call showWarning;
		};
		private _box = [_d,"RscCombo",[_textSize+2,20,20-2,70],_ctg] call createWidget;
		{
			private _idx = _box lbAdd (_x getv(visibleName));
			_box lbSetTooltip [_idx,str(_x)];
		} foreach goasm_batch_allFields;
		
		_box setvariable ["tok",self];
		_box setvariable ["startpos",_textSize + 2 + 20-2];
		private _lbchange = {
			params ["_list","_index"];
			private self = _list getvariable "tok";
			private _fieldProperty = goasm_batch_allFields select _index;
			
			{
				[_x,true] call deleteWidget;
			} foreach (self getv(widgetList));
			
			private _wlist = [];
			private _startpos = _list getvariable "startpos";
			[self,_fieldProperty,_wlist,_startpos] call goasm_batch_provideProps;
			self setv(widgetList,_wlist);
		};
		_box ctrlAddEventHandler ["LBSelChanged",_lbchange];

		_box lbSetCurSel 0;
		[_box,0] call _lbchange;
	}
endstruct

struct(BatchTokenWhere) base(BatchTokenBase)
	def(name) "Где";
	def(description) "Выбор объектов по заданным условиям";
	def(nextTokens) ["BatchTokenWhereExpressionBase"];
endstruct

struct(BatchTokenWhereExpressionBase) base(BatchTokenBase)
	def(nextTokens) ["BatchTokenWhereAndExpression","BatchTokenWhereOrExpression"];
	def(canBeEnd) true;
	def(name) "Выражение";
endstruct

struct(BatchTokenWhereAndExpression) base(BatchTokenBase)
	def(name) "И"
	def(description) "Логическое объединение двух условий - предыдущего и последующего";
	def(nextTokens) ["BatchTokenWhereExpressionBase"]
endstruct
struct(BatchTokenWhereOrExpression) base(BatchTokenBase)
	def(name) "ИЛИ"
	def(description) "Логическое объединение двух условий - предыдущего и последующего";
	def(nextTokens) ["BatchTokenWhereExpressionBase"]
endstruct


struct(BatchTokenWhereCheckVar) base(BatchTokenWhereExpressionBase)
	def(name) "Сравнение свойства"
	def(description) "Оценка значения свойства объекта";
endstruct


struct(BatchTokenWhereCheckType) base(BatchTokenWhereExpressionBase)
	def(name) "Тип"
	def(description) "Оценка типа объекта";
endstruct
