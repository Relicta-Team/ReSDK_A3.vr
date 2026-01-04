// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



class(ObjectiveBase) extends(ManagedObject)
	var(name,"Задача");
	var(explanationText,"Ничего"); //описательный текст что делать
	//здесь используются воспоминания так как игровые объекты могут быть удалены. воспоминания же остаются в игре до конца раунда
	var(owner,nullPtr); //владелец заадчи - объект воспоминаний
	var(target,nullPtr); //объект (моб или задача) если задача ориентирована на него
	var(completed,0); //Отражает результат выполнения. значения отличные от нуля считаются выполненными
	
	getterconst_func(possibleGameModes,"");//на каких режимах доступа данная задача. список разделяется через |. пустой массив означает что все режимы
	
	//динамические задачи продолжают процесситься даже после успешного статуса.
	//с выключенным флагом при выполнении задачи процесс будет остановлен
	getterconst_func(isDynamic,true);
	
	//может ли сущность получить данную задачу
	func(canGetObjective)
	{
		objParams_2(_mob,_usr);
	};
	
	func(constructor)
	{
		objParams();
		
		objsys_list_all pushBack this;
	};
	
	func(destructor)
	{
		objParams();
		
		objsys_list_all deleteAt (objsys_list_all find this);
	};
	
	//проверка успеха
	func(checkSuccess)
	{
		objParams();
		getSelf(completed) != 0
	};
	
	//инициализация задачи
	func(initObjective)
	{
		objParams_2(_owner,_context);
	};
	
	//публичные задачи показываются ВСЕМ в конце раунда.
	getterconst_func(isPublicObjective,false);
	
	//текст который высвечивается при выполнении задачи
	func(getCompletionText)
	{
		objParams_1(_status);
	};
	
endclass