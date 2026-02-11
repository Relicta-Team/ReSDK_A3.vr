// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>



//интоксикация
class(SEAlcoholHangover) extends(SEMedicalBase)
	var(name,"Алкогольное опьянение");
	getterconst_func(triggers,[vec2("Spirt",15)]);
	getterconst_func(cures,[vec2("Milk",1)]);
	var(size,5);
	var(lastMessage,0);

	getterconst_func(isOnetimeStatus,true);

	getter_func(getCureMessage,"Мне стало легче");

	func(onCreate)
	{
		objParams_1(_data);

	};

	func(onRecreate)
	{
		objParams_1(_data);
	};

	func(canCure)
	{
		objParams();
		super() || callFunc(getSelf(loc),isSleep) || tickTime>=(getSelf(startTime)+(60*
			#ifdef EDITOR
			1
			#else
			2
			#endif
			))
	};

	func(onDestroy)
	{
		objParams();
		callFuncParams(getSelf(loc),fastSendInfo,"pp_alc_amount" arg 0);
	};

	func(onUpdate)
	{
		objParams();

		callFuncParams(getSelf(loc),fastSendInfo,"pp_alc_amount" arg getSelf(size));

		if callSelf(canManifest) exitWith {
			modSelf(size, + 1);
			if (getSelf(size) >= 40 && prob(35)) then {
				private _m = pick["Меня сейчас вырвет...","Сейчас блевану...","Меня тошнит."];
				callFuncParams(getSelf(loc),mindSay,setstyle(_m,style_redbig));
			};
			if (getSelf(size) >= 60) then {
				callFunc(getSelf(loc),Vomit);
				modSelf(size, - 40);
			};
		};

		if (tickTime > getSelf(lastMessage)) exitWith {

			setSelf(lastMessage,tickTime + randInt(30,60));
			_pre = pick["У меня в голове","Моя голова","Ох... Голова","Моя бошка"];
			_m = pick["гудит","звенит","кружится","шумит"];
			callFuncParams(getSelf(loc),mindSay,"<t size='1.7'>"+_pre+" "+_m+"</t>");
		};

		if callSelf(canCure) exitWith {
			modSelf(size, - 1);
			if (getSelf(size)<=0) then {
				callSelf(Cure);
			};
		};

	};

endclass
