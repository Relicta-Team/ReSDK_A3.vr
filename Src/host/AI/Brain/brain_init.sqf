// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//загружает поведение из yaml файла
brain_loadYaml = {
	params ["_yamlName","_refData"];
	
	private _path = "src\host\AI\Brain\AIConfigs\" + _yamlName;
	private _yaml = [_yamlName] call yaml_loadFile;
	if !isNullVar(_yaml) then {
		[_yaml] call brain_yamlPrepare;
		refset(_refData,_yaml);
	};

	!isNullVar(_yaml)
};

/*
	
*/
brain_yamlPrepare = {
	params ["_yaml"];
	//todo прогнать загруженный yaml через goap_yaml_parseExpr отсюда
	
};

/*
	предефайны:
		agent - дикт агента
		mob - gameobject сущность
		actor - меш моба	

	синтаксис:
		agent.target -> _agent get "target"
		mob:stamina > 0 -> getVar(_mob,stamina) > 0
		isNull(expr) -> isNull(expr)
		isNullRef(expr) -> isNullReference(expr)
		mob:getHealth() -> callFunc(_mob,getHealth)
		::doSomething() -> [] call doSomething

	!ВНИМАНИЕ! аргументы функции:
		action(arg1,arg2(arg3,arg4)) -> [arg1,[arg3,arg4] call arg2] call action - приведет к ошибке
		внутри параметров метода нельзя использовать другие методы

	!ВНИМАНИЕ! цепочки вызовов
		вызов в одну строку не поддерживается: a.b.c()
		используйте разделение на переменные:
		var t = a.b; t.c();


	example:
	action: |
		if (mob:stamina > 0 && isNull(agent.target) && isNullRef(mob:getItemInActiveHandRedirect())) then {

		}
	

	//tests:
	agent,mob,actor,
	test,struct.var,struct.func(),struct.funcp(a,b,c),
	met:varxr,met:fn(),met.fnargs(1,2,3),
	::globalfunc(),::globalfunc(1+2,2+3,3+4),
	isNull(_test)
	compiled:
	_agent,_mob,_actor,
	test,(struct get "private"),(struct call ["func"]),(struct call ["funcp",[a,b,c]]),
	((met) getvariable ("varxr")),((met) call ((met) getvariable "proto" getvariable ("fn"))),(met call ["fnargs",[1,2,3]]),
	[] call globalfunc,[1+2,2+3,3+4] call globalfunc,
	(isnil{_test})
*/
brain_yamlParseExpr = {
	params ["_expr"];

	private _lines = _expr splitString endl;
	private _stack = ["scopename 'AI_EXPR_SCOPE'; "];
	private _pat_metcall = "(\w+):(\w+)\s*\(([^)]+)\)";
	private _pat_met = "(\w+):(\w+)\s*\(\s*\)";
	private _pat_field = "(\w+):(\w+)";

	private _pat_structcallparam = "(\w+)\.(\w+)\s*\(([^)]+)\)";
	private _pat_structcall = "(\w+)\.(\w+)\s*\(\s*\)";
	private _pat_structfield = "(\w+)\.(\w+)";
	
	private _pat_return = "\s*(return)\s*;?";
	private _pat_vardef = "\b(var)\b";
	private _pat_endl = "[)}\w]\s*$";
	private _pat_istypeof = "isTypeOf\(([^,]+)\,([^)]+)\)";
	private _pat_isnull = "isNull\(([^)]+)\)";
	private _pat_isnullref = "isNullRef\(([^)]+)\)";

	private _pat_functionCall = "\:\:(\w+)\s*\(([^)]*)\)";

	private _pat_agentVar = "\b(agent)\b";
	private _pat_mobVar = "\b(mob)\b";
	private _pat_actorVar = "\b(actor)\b";
	
	{
		private _curLine = _x;

		_curLine = ([_curLine,_pat_metcall,'callFuncParams($1,$2,$3)'] call regex_replace);
		_curLine = ([_curLine,_pat_met,'callFunc($1,$2)'] call regex_replace);
		_curLine = ([_curLine,_pat_field,'getVar($1,$2)'] call regex_replace);
	
		_curLine = ([_curLine,_pat_structcallparam,'($1 callp($2,$3))'] call regex_replace);
		_curLine = ([_curLine,_pat_structcall,'($1 callv($2))'] call regex_replace);
		_curLine = ([_curLine,_pat_structfield,'($1 getv($2))'] call regex_replace);

		_curLine = ([_curLine,_pat_return,"(0) breakout 'AI_EXPR_SCOPE'"] call regex_replace);
		_curLine = ([_curLine,_pat_vardef,"private"] call regex_replace);
		_curLine = ([_curLine,_pat_istypeof,'isTypeOf($1,$2)'] call regex_replace);

		_curLine = ([_curLine,_pat_isnull,'isNull($1)'] call regex_replace);
		_curLine = ([_curLine,_pat_isnullref,'isNullReference($1)'] call regex_replace);

		_curLine = ([_curLine,_pat_agentVar,'_agent'] call regex_replace);
		_curLine = ([_curLine,_pat_mobVar,'_mob'] call regex_replace);
		_curLine = ([_curLine,_pat_actorVar,'_actor'] call regex_replace);

		_curLine = ([_curLine,_pat_functionCall,'[$2] call $1'] call regex_replace);

		_stack pushBack _curLine;
		
		if ([_curLine,_pat_endl] call regex_isMatch) then {
			_stack pushBack ";";
		};
	} foreach _lines;

	private _CODEINSTR_ = null;
	private _code = "_CODEINSTR_ = { params ['_agent','_mob','_actor']; " + (_stack joinString endl) + "};";
	#ifdef EDITOR
	debug_compiler_goap_lastInstructions = [_code,_stack];
	#endif
	isNIL (compile _code);
	_CODEINSTR_
};