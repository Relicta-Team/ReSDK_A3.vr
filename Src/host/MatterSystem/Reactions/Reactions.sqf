// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


ms_internal_react_gen = 0;

#include "AllReactions.sqf"



react(Reaction)
	prop(name,""); //Name of the reaction (нигде не используется)
	prop(result,null); //ID полученного реагента. Может быть нулевым. В случае с нулевым значением можно добавить объект
	prop(result_amount,0); //Количество полученного реагента.
	prop(required_reagents,[]); //Реагенты, которые необходимы для реакции и расходуются во время нее.
	prop(required_items,[]); //Предметы которые должны быть помещены в мс для реакции
	prop(catalysts,[]); //То же, что и required_reagents, но не расходуется.
	prop(inhibitors,[]); //Напротив, не допустит возникновения реакции.
	prop(reaction_type,REACTION_BLENDING); //реакция возникнет при...
	
	// ------- DO NOT USE OR CHANGE THIS DEFINES
	prop(minimum_temperature,0) //минимальная комфортная температура для реакции
	prop(maximum_temperature,INFINITY) //максимальная комфортная температура для реакции
	// ------- 

	def(onReaction)
		//Вызывается при реакции
		callSelfParams(worldSay, "Раствор начинает бурлить..." arg "info" arg 10);
	end
	
	// Пост условие на возможность реакции. Например проверяем количество итемов и их свойства
	// Данный метод вызывается когда canReact вернул true 
	def(postCondition)
		true
	end