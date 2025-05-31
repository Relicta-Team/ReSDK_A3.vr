// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// === UNIFORM
class(IFalloutCloth) extends(BodyClothBase)

endclass

#define BodyClothBase IFalloutCloth

class(BomberJacketBlack) extends(BodyClothBase)
	var(name,"Кожанка");
	var(armaClass,"MMM_BomberJacket_black");
endclass

class(BomberJacketBrown) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_brown");
endclass

class(BomberJacketChocolate) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_Chocolate");
endclass

class(BomberJacketDarkChocolate) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_DarkChocolate");
endclass

class(BomberJacketLightBrown) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_LightBrown");
endclass

class(BomberJacketRedBrown) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_RedBrown");
endclass

class(BomberJacketBlackOpen) extends(BomberJacketBlack)
	var(armaClass,"MMM_BomberJacket_open_black");
endclass

class(BomberJacketBrownOpen) extends(BomberJacketBrown)
	var(armaClass,"MMM_BomberJacket_open_brown");
endclass

class(BomberJacketChocolateOpen) extends(BomberJacketChocolate)
	var(armaClass,"MMM_BomberJacket_open_Chocolate");
endclass

class(BomberJacketDarkChocolateOpen) extends(BomberJacketDarkChocolate)
	var(armaClass,"MMM_BomberJacket_open_DarkChocolate");
endclass

class(BomberJacketLightBrownOpen) extends(BomberJacketLightBrown)
	var(armaClass,"MMM_BomberJacket_open_LightBrown");
endclass

class(BomberJacketRedBrownOpen) extends(BomberJacketRedBrown)
	var(armaClass,"MMM_BomberJacket_open_RedBrown");
endclass

class(FemaleArmyForm) extends(BodyClothBase)
	var(name,"Женская военная форма");
	var(armaClass,"B_FemalePress_Uniform");
endclass

editor_attribute("InternalImpl")
class(SC_Orgur_Katari_Uniform) extends(BodyClothBase)
	//монстр инопланетный синяк
	var(armaClass,"SC_Orgur_Katari_Uniform");
endclass

class(VillageCloth1) extends(BodyClothBase)
	var(name,"Деревенская одежда");
	var(armaClass,"EoO_Fant_Aldorf_Uni_1");
endclass

class(VillageCloth2) extends(VillageCloth1)
	var(armaClass,"EoO_Fant_Aldorf_Uni_11");
endclass

class(VillageCloth3) extends(VillageCloth1)
	var(armaClass,"EoO_Fant_Aldorf_Uni_9");
endclass

class(ThickRusticCloth1) extends(BodyClothBase)
	var(name,"Плотная деревенсккая одежда");
	var(armaClass,"EoO_Breton_Uni_2");
endclass

class(ThickRusticCloth2) extends(ThickRusticCloth1)
	var(armaClass,"EoO_Breton_Uni_3");
endclass

class(ThickRusticCloth3) extends(ThickRusticCloth1)
	var(armaClass,"EoO_Breton_Uni_5");
endclass

class(ReinforcedRusticCloth) extends(BodyClothBase)
	var(name,"Укрепленная деревенская одежда");
	var(armaClass,"EoO_Breton_Knight_Uni_1");
endclass

class(LongRusticCloth) extends(BodyClothBase)
	var(name,"Длинная деревенская одежда");
	var(armaClass,"EoO_Fant_FireWizard_Uni_1");
endclass

class(LuxRusticCloth1) extends(BodyClothBase)
	var(name,"Роскошная деревенская одежда");
	var(armaClass,"EoO_Fant_Uni_17");
endclass

class(LuxRusticCloth2) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_18");
endclass

class(LuxRusticCloth3) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_12");
endclass

class(LuxRusticCloth4) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_13");
endclass

class(LuxRusticCloth5) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_14");
endclass

class(LuxRusticCloth6) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_3");
endclass

class(LuxRusticCloth7) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_7");
endclass

class(LuxRusticCloth8) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Uni_5");
endclass

class(HuntingCaveCloak1) extends(BodyClothBase)
	var(name,"Охотничий пещерный плащ");
	var(armaClass,"EoO_Fant_WitchHunter_Uni_1");
endclass

class(HuntingCaveCloak2) extends(HuntingCaveCloak1)
	var(armaClass,"EoO_Fant_WitchHunter_Uni_2");
endclass

class(HuntingCaveCloak3) extends(HuntingCaveCloak1)
	var(armaClass,"EoO_Fant_WitchHunter_Uni_3");
endclass

class(ChainMail1) extends(BodyClothBase)
	var(name,"Кольчуга");
	var(armaClass,"EoO_Fant_BloodKnight_1");
endclass

class(ChainMail2) extends(ChainMail1)
	var(armaClass,"EoO_Fant_BloodKnight_2");
endclass

class(ReinforcedLuxRusticCloth) extends(BodyClothBase)
	var(name,"Укрепленная роскошная одежда");
	var(armaClass,"EoO_Fant_Ostermark_Uni_1");
endclass

class(LuxRusticCloth9) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Ostermark_Uni_3");
endclass

class(LuxRusticCloth10) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Ostermark_Uni_7");
endclass

class(LuxRusticCloth11) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_1");
endclass

class(LuxRusticCloth12) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_3");
endclass

class(LuxRusticCloth13) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_10");
endclass

class(LuxRusticCloth14) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_11");
endclass

class(LuxRusticCloth15) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_5");
endclass

class(LuxRusticCloth16) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_12");
endclass

class(LuxRusticCloth17) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_13");
endclass

class(LuxRusticCloth18) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_7");
endclass

class(LuxRusticCloth19) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_14");
endclass

class(LuxRusticCloth20) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_8");
endclass

class(LuxRusticCloth21) extends(LuxRusticCloth1)
	var(armaClass,"EoO_Fant_Wissenland_Uni_15");
endclass

class(CaveChainArmor1) extends(BodyClothBase)
	var(name,"Пещерная кольчуга");
	var(armaClass,"Chain_armor_05");
endclass

class(CavePlateArmor) extends(BodyClothBase)
	var(name,"Пещерная броня");
	var(armaClass,"Chain_armor_06");
endclass

class(CaveArmor) extends(BodyClothBase)
	var(name,"Пещерный доспех");
	var(armaClass,"Chain_armor_07");
endclass

editor_attribute("InternalImpl")
class(mbg_uniform_alien_01) extends(BodyClothBase)
	//инопланетянин качественный. тонкорукий, 4 глаза по 4 пальца
	var(armaClass,"mbg_uniform_alien_01");
endclass

editor_attribute("InternalImpl")
class(mbg_uniform_alien_02) extends(BodyClothBase)
	//инопланетянин качественный. толстый,высокий с дырками в висках
	var(armaClass,"mbg_uniform_alien_02");
endclass

editor_attribute("InternalImpl")
class(mbg_uniform_alien_03) extends(BodyClothBase)
	//инопланетянин качественный. здоровый, жирный, страшный и зубастый
	var(armaClass,"mbg_uniform_alien_03");
endclass

editor_attribute("InternalImpl")
class(mbg_uniform_alien_hybrid_01) extends(BodyClothBase)
	//качественный, светлокоричневый с высунутым языком
	var(armaClass,"mbg_uniform_alien_hybrid_01");
endclass

class(PlateCaveArmor1) extends(BodyClothBase)
	var(name,"Латный пещерный доспех");
	var(armaClass,"PT_Crusader_Armor_01");
endclass

class(LeatherCaveArmor1) extends(BodyClothBase)
	var(name,"Шкурный пещерный доспех");
	var(armaClass,"PT_Guardsmen_Armor_01");
endclass

class(LeatherCaveArmor2) extends(LeatherCaveArmor1)
	var(armaClass,"PT_Guardsmen_Armor_02");
endclass

class(KnightCaveArmor1) extends(BodyClothBase)
	var(name,"Доспехи");
	var(armaClass,"PT_Knight_01");
endclass

class(KnightCaveArmor2) extends(KnightCaveArmor1)
	var(armaClass,"PT_Knight_02");
endclass

editor_attribute("InternalImpl")
class(SC_Bocean_Body_Shale) extends(BodyClothBase)
	//рептилия темная
	var(armaClass,"SC_Bocean_Body_Shale");
endclass

class(InsulatedSnowCloth) extends(BodyClothBase)
	var(name,"Утепленная одежда");
	var(armaClass,"SC_ColdGuard_Uniform");
endclass

editor_attribute("InternalImpl")
class(AM_Ghoul_01_uniform) extends(BodyClothBase)
	//гуль фаллаут
	var(armaClass,"AM_Ghoul_01_uniform");
endclass

class(CaveLeatherJacket) extends(BodyClothBase)
	var(name,"Пещерная кожаная куртка");
	var(armaClass,"Armored_Coat_uniform");
endclass

class(ThickArmorCloth) extends(BodyClothBase)
	var(name,"Плотные доспехи");
	var(armaClass,"Tactics_Brotherhood_Armor_uniform");
endclass

class(WhiteArmyCoat) extends(BodyClothBase)
	var(name,"Светлое солдатское пальто");
	var(armaClass,"colonelautumn_Arctic_General_uniform");
endclass

class(SturdyLeatherJacket) extends(BodyClothBase)
	var(name,"Крепкая кожаная куртка");
	var(armaClass,"combat_ranger_05_uniform");
endclass

class(SturdyJacket1) extends(BodyClothBase)
	var(name,"Крепкая куртка");
	var(armaClass,"geonox_riot_03_uniform");
endclass

class(WhoreOutfit1) extends(BodyClothBase)
	var(name,"Шлюший наряд");
	var(armaClass,"prosfemale02_uniform");
endclass

class(WhoreOutfit2) extends(WhoreOutfit1)
	var(armaClass,"prosfemale03_uniform");
endclass

editor_attribute("InternalImpl")
class(sm_light_1_Brn_uniform) extends(BodyClothBase)
	//супермутант классика. веса костей проебаны
	var(armaClass,"sm_light_1_Brn_uniform");
endclass

editor_attribute("InternalImpl")
class(sm_unarmored_1_Brn_uniform) extends(BodyClothBase)
	//супермутант огуречный. веса костей проебаны
	var(armaClass,"sm_unarmored_1_Brn_uniform");
endclass

editor_attribute("InternalImpl")
class(sm_unarmored_1_DC_uniform) extends(BodyClothBase)
	//супермутант классика. без одежды
	var(armaClass,"sm_unarmored_1_DC_uniform");
endclass

class(CaveCombatUniform) extends(BodyClothBase)
	var(name,"Пещерная боевая форма");
	var(armaClass,"AM_Uniform_DesertCoat_S");
endclass

class(CityLightweightCloth1) extends(BodyClothBase)
	var(name,"Городская одежда");
	var(armaClass,"1950stylecasual04_uniform");
endclass

class(CityLightweightCloth2) extends(CityLightweightCloth1)
	var(name,"1950stylecasual04_mold_uniform");
	var(armaClass,"1950stylecasual04_mold_uniform");
endclass

class(LongLeatherRobe1) extends(BodyClothBase)
	var(name,"Длинная красная роба");
	var(armaClass,"Brotherhood_Scribe_robe_uniform");
endclass

class(LongLeatherRobe2) extends(LongLeatherRobe1)
	var(name,"Длинная синяя роба");
	var(armaClass,"Brotherhood_elder_robe_uniform");
endclass

class(SturdyJacket2) extends(SturdyJacket1)
	var(armaClass,"Geonox_riot_uniform");
endclass

class(LightLeatherArmorCloth) extends(BodyClothBase)
	var(name,"Светлая кожаная броня");
	var(armaClass,"boone02_winter_uniform");
endclass

class(LuxuryCaveRobe) extends(BodyClothBase)
	var(name,"Роскошное пещерное одеяние");
	var(armaClass,"caesar_uniform");
endclass

class(GreenArmyCoat) extends(WhiteArmyCoat)
	var(name,"Зеленое солдатское пальто");
	var(armaClass,"colonelautumn_uniform");
endclass

class(LeatherClothWithArmor) extends(BodyClothBase)
	var(name,"Кожаный плащ с бронёй");
	var(armaClass,"combat_ranger_Wanderer_uniform");
endclass

class(BlackLightweightArmyCloth1) extends(BodyClothBase)
	var(name,"Легкая черная броня");
	var(armaClass,"combatarmor_rivetcitysecurity_uniform");
endclass

class(BlackLightweightArmyCloth2) extends(BlackLightweightArmyCloth1)
	var(armaClass,"combatarmor_black_02_uniform");
endclass

class(BlackLightweightArmyCloth3) extends(BlackLightweightArmyCloth1)
	var(name,"Новая черная броня");
	var(armaClass,"combatarmor_enclave_uniform");
endclass

class(ThickWorkerCloth1) extends(BodyClothBase)
	var(name,"Плотная рабочая одежда");
	var(armaClass,"enclave_officer_uniform");
endclass

class(LeatherJacketWithCollars) extends(BodyClothBase)
	var(name,"Кожак");
	var(armaClass,"kings_outfit_uniform");
endclass

class(LeatherCoatWithoutSleeves) extends(BodyClothBase)
	var(name,"Кожаный плащ-безрукавка");
	var(armaClass,"lucassimms_ncr_uniform");
endclass

class(ThickWorkerCloth2) extends(BodyClothBase)
	var(armaClass,"petrochico_01_05_uniform");
endclass

class(LightweightCombatCloth) extends(BodyClothBase)
	var(name,"Облегченная боевая одежда");
	var(armaClass,"stealthsuit_uniform");
endclass

class(TorturerCloth1) extends(BodyClothBase)
	var(name,"Истязательские лохмотья");
	var(armaClass,"wastelandclothing01_uniform");
endclass

class(TorturerCloth2) extends(TorturerCloth1)
	var(name,"wastelandclothing03_uniform");
	var(armaClass,"wastelandclothing03_uniform");
endclass

class(HandmadeDummyLeatherJacket) extends(BodyClothBase)
	var(name,"Самодельная глупая кожанка");
	var(armaClass,"wastelandsettler02_uniform");
endclass

class(GreenLeatherArmorCloth) extends(BodyClothBase)
	var(name,"Зеленая кожаная броня");
	var(armaClass,"armor_ncr_trooper_airtrooper_uniform");
endclass

class(RivetedAncientArmor) extends(BodyClothBase)
	var(name,"Древняя броня");
	var(armaClass,"bosunderarmor_uniform");
endclass

class(LeatherClothWithArmor2) extends(LeatherClothWithArmor)
	var(armaClass,"combat_ranger_new_uniform");
endclass

class(ClosedDarkCloth) extends(BodyClothBase)
	var(name,"Закрытая темная одежда");
	var(armaClass,"WBK_FuedalCultist");
endclass

editor_attribute("InternalImpl")
class(WBK_SpecialInfected_Bloater) extends(BodyClothBase)
	//новый монстр. без головы, без рук
	var(armaClass,"WBK_SpecialInfected_Bloater");
endclass

editor_attribute("InternalImpl")
class(WBK_SpecialInfected_Screamer) extends(BodyClothBase)
	//новый монстр. серый с зубами и наростом на голове
	var(armaClass,"WBK_SpecialInfected_Screamer");
endclass

editor_attribute("InternalImpl")
class(WBK_SpecialInfected_Leaper_1) extends(BodyClothBase)
	//новый монстр. серый с зубами и розовым пузиком
	var(armaClass,"WBK_SpecialInfected_Leaper_1");
endclass

editor_attribute("InternalImpl")
class(WBK_SpecialInfected_Leaper_2) extends(BodyClothBase)
	//новый монстр. серый с розовым пузиком и запаянным лицом
	var(armaClass,"WBK_SpecialInfected_Leaper_2");
endclass

class(GreenLightweightArmyCloth1) extends(BodyClothBase)
	var(name,"Зеленая броня");
	var(armaClass,"AFO_U_CombatArmor");
endclass

class(GreenLightweightArmyCloth2) extends(GreenLightweightArmyCloth1)
	var(armaClass,"AFO_U_CombatArmor_BOS");
endclass

class(GreenLightweightArmyCloth3) extends(GreenLightweightArmyCloth1)
	var(name,"Светло-зеленая броня");
	var(armaClass,"AFO_U_CombatArmor_Tenpenny");
endclass

#undef BodyClothBase