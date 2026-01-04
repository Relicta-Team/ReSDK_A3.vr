// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>

#define OVERRIDE_ENABLE_AS_ACTIVATOR() \
func(activate) {objParams();if (getSelf(edIsEnabled) && getSelf(edIsUsePower)) then {{callFunc(_x,onActivate)} foreach getSelf(edConnected);}; callSelfParams(playSound, "electronics\lightswitch" arg getRandomPitch arg 7);}; \
getter_func(getMainActionName,"Нажать"); \
func(onMainAction) {objParams_1(_usr); callSelf(activate)}

class(PowerSwitcherBox) extends(ElectronicDeviceNode)
	var(name,"Выключатель");
	var(desc,"Одно нажатие и снова что-нибудь перестанет работать!");
	var(model,"metro_ob\model\rubilnik_5.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,10);
	var(dr,3);
	
/*	func(constructor)
	{
		callSelf(setEnable,true);
	};*/
	var(edIsEnabled,true);
	
	func(onChangeEnable)
	{
		objParams();
		callSelfParams(playSound, "electronics\lightswitch" arg getRandomPitch arg 7);
	};	
	
endclass

	class(PowerSwitcherBox_Activator) extends(PowerSwitcherBox)
		OVERRIDE_ENABLE_AS_ACTIVATOR();
	endclass

class(PowerSwitcher) extends(PowerSwitcherBox)
	var(model,"metro_ob\model\rubilnik_4.p3d");
endclass

	class(PowerSwitcher_Activator) extends(PowerSwitcher)
		OVERRIDE_ENABLE_AS_ACTIVATOR();
	endclass

class(PowerSwitcherBig) extends(PowerSwitcherBox)
	var(model,"ml\ml_object_new\model_14_10\electron.p3d");
endclass

	class(PowerSwitcherBig_Activator) extends(PowerSwitcherBig)
		OVERRIDE_ENABLE_AS_ACTIVATOR();
	endclass


class(RedButton) extends(PowerSwitcherBox)
	var(name,"Кнопка");
	var(desc,"Сочная кнопочка! Она хочет чтобы её нажали!");
	//NOGEON
	var(model,"ml\ml_object_new\model_14_10\knopka.p3d");
	var(material,"MatSynt");
	var(dr,1);
endclass

	class(RedButton_Activator) extends(RedButton)
		OVERRIDE_ENABLE_AS_ACTIVATOR();
	endclass

class(Tumbler) extends(PowerSwitcherBox)
	var(name,"Переключатель");
	var(desc,"Надо срочно проверить что произойдёт если переключить его.");
	//NOGEON
	var(model,"ml\ml_object_new\model_14_10\tumbler.p3d");
	var(dr,2);
endclass

	class(Tumbler_Activator) extends(Tumbler)
		OVERRIDE_ENABLE_AS_ACTIVATOR();
	endclass