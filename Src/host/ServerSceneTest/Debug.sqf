// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


this = _vMob;


//callSelfParams(addTimeBouns,"per" arg -5 arg 5);
_postcall = {objParams(); callSelfParams(applyShock,1);
	//_upd = {updateParams(); callSelfParams(addHT,1)};
	//startUpdateParams(_upd,2,this);
};
//invokeAfterDelayParams(_postcall,5,this);

//invokeAfterDelayParams({objParams(); callSelf(dropAllItemsInHands)},6,this);

_c = {

	objParams();
	log("start of");
	_link = vasya getVariable 'link';
	_woundarr = getVar(_link,wounds) select 1 select 0;
	reffe = _woundarr;
	
	callSelfParams(initSt,13);
	
	_i = 0;
	while {(_woundarr find 7) == -1 } do {
		//log("iter");
		callSelfParams(attackOtherMob,_link);
		INC(_i);
	};
	
	logformat("attacks END. All count %1; Std success: %2; Yodes st was %3",_i arg ctr arg callSelf(getST));
};

//invokeAfterDelayParams(_c,2,this);
