// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "Basic.sqf"


matter(Matter)
	prop(name,"Материя") //системное название (для рецептов и тд)
	
	// ------- DO NOT USE OR CHANGE THIS DEFINES
	prop(scienceName,"???") //Научное название (видят учёные и инструменты)
	prop(slangName,"???") //Сленговое название (видят обычные тупачки)
	// ------- 
	
	prop(isVisible,false); //видимость реагента. скрытые реагенты не видно при приготовлении и обычным людям
	
	
	//prop(heatDifficulty,1) //сложность нагрева для единицы вещества
	prop(metabolism,1) //скорость поглощения за тик дефолтным организмом
	prop(overdose,0) //количество для передозировки
	
	prop(state,LIQUID); //состояние реагента (жидкое, твёрдое, газообразное)
	
	// ------- DO NOT USE OR CHANGE THIS DEFINES
	prop(chilling_products,[]) //продукты которые выделятся в результате заморозки
	prop(chilling_point,null) //температура прехода в холодное состояние. Если null то охлаждения не произойдёт
	prop(chilling_message,"") //сообщение которое выведется при охлаждении
	
	prop(heating_products,[]) //продукты которые выделятся в результате нагрева
	prop(heating_point,null)
	prop(heating_message,"")
	// ------- 
	
	def(onOverdosed)
		//событие вызывается при передозировке
	end
	
	def(onAssimBlood)
		//Событие вызываемое при усваивании в организме через кровь
	end

	def(onAssimIngest)
		//Событие вызываемое при усваивании через поглощение
		#ifdef EDITOR
		callSelfParams(localSay,(thisMatter get "name") + " потихоньку усваивается" arg "info");
		#endif
	end

	def(onAssimTouch)
		//Событие вызываемое через троганье материи
	end

	def(onMixingData)
		//событие вызывается если в материи есть данные и мы подгружаем новые данные
		MIXING_DATA_CONTAINER set [MIXING_DATA_NAME,MIXING_DATA_CTX];
	end