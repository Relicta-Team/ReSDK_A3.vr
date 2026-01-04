// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


reagentsystem_reactions_counter = 0;

class(ReagentReaction)
	var(name,""); //Name of the reaction (нигде не используется)
	var(result,null); //ID полученного реагента. Может быть нулевым. В случае с нулевым значением можно добавить объект
	var(result_amount,0); //Количество полученного реагента.
	var(required_reagents,[]); //Реагенты, которые необходимы для реакции и расходуются во время нее.
	var(required_items,[]); //Предметы которые должны быть помещены в мс для реакции
	var(catalysts,[]); //То же, что и required_reagents, но не расходуется.
	var(inhibitors,[]); //Напротив, не допустит возникновения реакции.
	var(reaction_type,REACTION_BLENDING); //реакция возникнет при...
	
	// ------- DO NOT USE OR CHANGE THIS DEFINES
	var(minimum_temperature,0) //минимальная комфортная температура для реакции
	var(maximum_temperature,INFINITY) //максимальная комфортная температура для реакции
	// ------- 

	//Вызывается при реакции
	func(onReaction)
	{
		objParams_1(_src);
		callFuncParams(_src,worldSay, "Раствор начинает бурлить..." arg "info" arg 10);

	};
	
endclass



#define reactgen_common INC(reagentsystem_reactions_counter); _reactionName = "react_gen_" + str reagentsystem_reactions_counter; \
class_runtime(_reactionName) extends(ReagentReaction)

#define reactgen_first reactgen_common

#define reactgen endclass reactgen_common

#define endreactgen endclass

//basic medical

reactgen_first
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Kenazin",1) arg vec2("Feronin",1) arg vec2("Metaficin",1)]);
	var(result,"Neyrizin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Kenazin",1) arg vec2("Imunit",1) arg vec2("Opirin",1)]);
	var(result,"Metaficin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Metaficin",1) arg vec2("Ceriy",1) arg vec2("Rebuliy",1)]);
	var(result,"Sepivitin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Askadiy",1) arg vec2("Fadiy",1) arg vec2("Neyrizin",1)]);
	var(result,"Demitolin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Demitolin",1) arg vec2("Vodiy",1) arg vec2("Metaficin",1)]);
	var(result,"Demidrocin");
	var(result_amount,1);

//painless

reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Sugar",1) arg vec2("Toniy",1) arg vec2("Karbidin",1)]);
	var(result,"Cetalin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Cetalin",1) arg vec2("Karbidin",1) arg vec2("Bodrin",1)]);
	var(result,"Cetalin");
	var(result_amount,3);
	
//burns
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Vodiy",1) arg vec2("Stomacin",1)]);
	var(result,"Kodizin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Kodizin",1) arg vec2("Paradol",1) arg vec2("Rebuliy",1)]);
	var(result,"Todizin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Cetalin",1) arg vec2("Demitolin",1)]);
	var(result,"Tovimin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Imunit",1) arg vec2("Karbidin",1) arg vec2("Demitolin",1)]);
	var(result,"Koradizin");
	var(result_amount,2);

//diseases

reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Tovimin",1) arg vec2("Metaficin",1)]);
	var(result,"Procerin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Muteliy",1) arg vec2("Detoklomin",1)]);
	var(result,"Getomizitin");
	var(result_amount,2);
	
//sleepers
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Spirt",1) arg vec2("Karbidin",1) arg vec2("Kenazin",1)]);
	var(result,"Somniy");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Cetalin",1) arg vec2("Somniy",1)]);
	var(result,"Komatin");
	var(result_amount,2);
	
// farm
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Muteliy",1) arg vec2("Celicin",1)]);
	var(result,"Sulfanid");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Stomacin",1) arg vec2("Blood",1)]);
	var(result,"Pemidil");
	var(result_amount,1);
	
//toxins
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Opirin",1) arg vec2("Toniy",1) arg vec2("Pariliy",1)]);
	var(result,"Onicid");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Ceriy",1) arg vec2("Pariliy",1)]);
	var(result,"Hloritin");
	var(result_amount,1);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Neyrizin",1) arg vec2("Alvitin",1) arg vec2("Stomacin",1)]);
	var(result,"Paraneyrin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Paraneyrin",1) arg vec2("Demitolin",1) arg vec2("Imunit",1)]);
	var(result,"Mertvin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Askadiy",1) arg vec2("Muteliy",1)]);
	var(result,"Gribicin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Sugar",2) arg vec2("Hloritin",1) arg vec2("Detoklomin",1)]);
	var(result,"Zhivognilin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Sepivitin",1) arg vec2("Toniy",1) arg vec2("Alvitin",1)]);
	var(result,"Verbin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Psihodin",1) arg vec2("Neyrizin",1) arg vec2("Komatin",1)]);
	var(result,"Psihobadin");
	var(result_amount,3);
	
//other...
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Celicin",1) arg vec2("Water",1) arg vec2("Hloritin",1)]);
	var(result,"Chistin");
	var(result_amount,3);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Fadiy",1) arg vec2("Rebuliy",1)]);
	var(result,"Salt");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Celicin",1) arg vec2("Detoklomin",1)]);
	var(result,"Bumilin");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_BLENDING);
	var(required_reagents,[vec2("Karbidin",1) arg vec2("Askadiy",1)]);
	var(result,"Water");
	var(result_amount,2);
	
reactgen
	var(reaction_type,REACTION_CHEM);
	var(required_reagents,[vec2("Radoniy",1) arg vec2("Opirin",1) arg vec2("Tovimin",1)]);
	var(result,"Mutacin");
	var(result_amount,2);

endreactgen