// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



class(SymptomBase)
	var(name,"");
	var(stealth,0);
	var(resistance,0);
	var(stageSpeed,0);
	var(transmittable,false);
	var(level,0); //Типовой уровень симптома. Чем выше, тем смертоноснее и труднее генерировать.

	//Вызывается, когда начинается обработка предварительной болезни, которая содержит этот симптом.
	func(onStart)
	{
		objParams_1(_advance);
	};

	//Вызывается, когда предварительная болезнь будет удалена или когда предварительная болезнь прекратит обработку.
	func(onEnd)
	{
		objParams_1(_advance);
	};

	func(onActivate)
	{
		objParams_1(_advance);
	};
endclass
