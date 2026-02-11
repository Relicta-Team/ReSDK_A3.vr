// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//basic medical

reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Kenazin",1) arg vec2("Feronin",1) arg vec2("Metaficin",1)]);
	prop(result,"Neyrizin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Kenazin",1) arg vec2("Imunit",1) arg vec2("Opirin",1)]);
	prop(result,"Metaficin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Metaficin",1) arg vec2("Ceriy",1) arg vec2("Rebuliy",1)]);
	prop(result,"Sepivitin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Askadiy",1) arg vec2("Fadiy",1) arg vec2("Neyrizin",1)]);
	prop(result,"Demitolin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Demitolin",1) arg vec2("Vodiy",1) arg vec2("Metaficin",1)]);
	prop(result,"Demidrocin");
	prop(result_amount,1);

//painless

reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Sugar",1) arg vec2("Toniy",1) arg vec2("Karbidin",1)]);
	prop(result,"Cetalin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Cetalin",1) arg vec2("Karbidin",1) arg vec2("Bodrin",1)]);
	prop(result,"Cetalin");
	prop(result_amount,3);
	
//burns
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Vodiy",1) arg vec2("Stomacin",1)]);
	prop(result,"Kodizin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Kodizin",1) arg vec2("Paradol",1) arg vec2("Rebuliy",1)]);
	prop(result,"Todizin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Cetalin",1) arg vec2("Demitolin",1)]);
	prop(result,"Tovimin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Imunit",1) arg vec2("Karbidin",1) arg vec2("Demitolin",1)]);
	prop(result,"Koradizin");
	prop(result_amount,2);

//diseases

reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Tovimin",1) arg vec2("Metaficin",1)]);
	prop(result,"Procerin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Muteliy",1) arg vec2("Detoklomin",1)]);
	prop(result,"Getomizitin");
	prop(result_amount,2);
	
//sleepers
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Spirt",1) arg vec2("Karbidin",1) arg vec2("Kenazin",1)]);
	prop(result,"Somniy");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Cetalin",1) arg vec2("Somniy",1)]);
	prop(result,"Komatin");
	prop(result_amount,2);
	
// farm
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Muteliy",1) arg vec2("Celicin",1)]);
	prop(result,"Sulfanid");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Stomacin",1) arg vec2("Blood",1)]);
	prop(result,"Pemidil");
	prop(result_amount,1);
	
//toxins
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Opirin",1) arg vec2("Toniy",1) arg vec2("Pariliy",1)]);
	prop(result,"Onicid");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Ceriy",1) arg vec2("Pariliy",1)]);
	prop(result,"Hloritin");
	prop(result_amount,1);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Neyrizin",1) arg vec2("Alvitin",1) arg vec2("Stomacin",1)]);
	prop(result,"Paraneyrin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Paraneyrin",1) arg vec2("Demitolin",1) arg vec2("Imunit",1)]);
	prop(result,"Mertvin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Askadiy",1) arg vec2("Muteliy",1)]);
	prop(result,"Gribicin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Sugar",2) arg vec2("Hloritin",1) arg vec2("Detoklomin",1)]);
	prop(result,"Zhivognilin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Sepivitin",1) arg vec2("Toniy",1) arg vec2("Alvitin",1)]);
	prop(result,"Verbin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Psihodin",1) arg vec2("Neyrizin",1) arg vec2("Komatin",1)]);
	prop(result,"Psihobadin");
	prop(result_amount,3);
	
//other...
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Celicin",1) arg vec2("Water",1) arg vec2("Hloritin",1)]);
	prop(result,"Chistin");
	prop(result_amount,3);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Fadiy",1) arg vec2("Rebuliy",1)]);
	prop(result,"Salt");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Celicin",1) arg vec2("Detoklomin",1)]);
	prop(result,"Bumilin");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_BLENDING);
	prop(required_reagents,[vec2("Karbidin",1) arg vec2("Askadiy",1)]);
	prop(result,"Water");
	prop(result_amount,2);
	
reactgen extends(Reaction)
	prop(reaction_type,REACTION_CHEM);
	prop(required_reagents,[vec2("Radoniy",1) arg vec2("Opirin",1) arg vec2("Tovimin",1)]);
	prop(result,"Mutacin");
	prop(result_amount,2);