// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define SYMPTOM_RANDOM_STARTING_LEVEL 2

class(SEDiseaseAdvanceBase) extends(SEDiseaseBase)

	var(name,"Неизвестно");
	var(desc,"Неизвестная болезнь");
	var(affectedMobTypes,["Mob"]);
	var(symptoms,[]);
	var(isProcessing,false);

	func(constructor)
	{
		objParams();
		private _newlist = [];
		{
			if equalTypes(_x,"") then {
				_newlist pushBack instantiate(_x);
			} else {
				_newlist pushBack _x;
			};
		} foreach getSelf(symptoms);
		setSelf(symptoms,_newlist);
	};

	func(Mix)
	{
		objParams_1(_advance);
		if !isTypeStringOf(this,callFunc(_advance,getClassName)) then {
			private _possibles = array_shuffle(array_copy(getVar(_advance,symptoms)));
			{
				callSelfParams(addSymptom,_x);
			} foreach _possibles;
		};
	};

	func(hasSymptom)
	{
		objParams_1(_name);
		(getSelf(symptoms) findif {callFunc(_x,getClassName)==_name})!=-1
	};

	//Будет генерировать новые уникальные симптомы, используйте это, если таковых нет. Возвращает список сгенерированных симптомов.
	func(generateSymptoms)
	{
		params ['this',["_typelvllimit",SYMPTOM_RANDOM_STARTING_LEVEL],["_amountget",0]];
		private _possibles = [];
		{
			if (getFieldBaseValue(_x,level) <= _typelvllimit) then {
				if !callSelfParams(hasSymptom,_x) then {
					_possibles pushBack _x;
				};
			};
		} foreach getAllObjectsTypeOf(SymptomBase);

		if (_amountget<=0) then {
			_amountget = randInt(1,count _possibles - 1);
		};

		private _generated = [];
		private _newsymp = 0;
		for "_i" from 1 to _amountget-1 do {
			_newsymp = _possibles deleteAt (_possibles find pick(_possibles));
			_generated pushBack _newsymp;
		};
		_generated;
	};

	//Generate disease properties based on the effects. Returns an associated list.
	func(generateProperties)
	{
		objParams();
		if (count getSelf(symptoms) == 0) exitWith {
			errorformat("no symptoms found to generate properties for %1",this);
		};

		private _props = hashMapNewArgs[["resistance",1],["stealth",1],["stageSpeed",1],["transmittable",1],["severity",1]];


		{
			MODARR(_props,"resistance",+getVar(_x,resistance));
			MODARR(_props,"stealth",+getVar(_x,stealth));
			MODARR(_props,"stageSpeed",+getVar(_x,stageSpeed));
			MODARR(_props,"transmittable",+getVar(_x,transmittable));
			MODARR(_props,"severity",+getVar(_x,severity));
		} foreach getSelf(symptoms);

		_props
	};

	func(assignProperties)
	{
		objParams();
	};
	
	//...code\datums\diseases\advance\advance.dm

endclass
