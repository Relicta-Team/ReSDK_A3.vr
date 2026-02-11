// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


class(BigShroomHat1) extends(HeadgearBase)
	var(name,"Большая грибошляпа");
	var(armaClass,"EoO_Fant_Aldorf_Helm_1");
endclass

class(SmallSteelHelmet1) extends(HeadgearBase)
	var(name,"Стальная шлемка");
	var(material,"MatMetal");
	var(weight,3);
	var(dr,3);
	var(coverage,70);
	var(bodyPartsCovered,HEAD);
	var(armaClass,"EoO_Fant_Sallet_Helm_2");
endclass

class(SmallSteelHelmet2) extends(SmallSteelHelmet1)
	var(armaClass,"EoO_Fant_Sallet_Helm_4A");
endclass

class(SmallSteelHelmet3) extends(SmallSteelHelmet1)
	var(armaClass,"EoO_Fant_Averland_Helm_6");
endclass

class(SmallShroomHat1) extends(HeadgearBase)
	var(name,"Грибошляпа");
	var(armaClass,"EoO_Fant_Averland_Helm_4");
endclass

class(SmallShroomHat2) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Averland_Helm_5");
endclass

class(BigShroomHat2) extends(BigShroomHat1)
	var(armaClass,"EoO_Fant_Averland_Helm_1");
endclass

class(ClosedSteelKnightHelmet) extends(HeadgearBase)
	var(name,"Закрытый стальной шлем");
	var(material,"MatMetal");
	var(weight,4);
	var(coverage,100);
	var(bodyPartsCovered,FACE + HEAD);
	var(armaClass,"EoO_Breton_Knight_Helm_1");
endclass

class(SmallCoveredSteelHelmet1) extends(HeadgearBase)
	var(name,"Крытая стальная шлемка");
	var(material,"MatMetal");
	var(weight,5);
	var(dr,4);
	var(coverage,80);
	var(bodyPartsCovered,HEAD);
	var(armaClass,"EoO_Fant_ArcheryHelm_1");
endclass

class(SmallCoveredSteelHelmet2) extends(SmallCoveredSteelHelmet1)
	var(armaClass,"EoO_Fant_ArcheryHelm_2");
endclass

class(EoO_Fant_FireWizard_Helm_1) extends(HeadgearBase)
	var(name,"Шлем"); //todo correct name
	var(armaClass,"EoO_Fant_FireWizard_Helm_1");
endclass

class(BlackSteelCrown) extends(HeadgearBase)
	var(name,"Стальная корона");
	var(material,"MatMetal");
	var(dr,4);
	var(coverage,20);
	var(bodyPartsCovered,HEAD);
	var(weight,2.5);
	var(armaClass,"EoO_Fant_Burgundian_Helm_11");
endclass

class(BigSteelOpenableHelmet1) extends(HeadgearBase)
	var(name,"Тёмный стальной шлем");
	var(material,"MatMetal");
	var(dr,5);
	var(bodyPartsCovered,HEAD);
	var(armaClass,"EoO_Fant_Burgundian_Helm_15"); //closestate EoO_Fant_Burgundian_Helm_20
endclass

class(BigSteelOpenableHelmet2) extends(BigSteelOpenableHelmet1)
	var(name,"Светлый стальной шлем");
	var(armaClass,"EoO_Fant_Burgundian_Helm_16"); //!FIXME is closable
endclass

class(KnightBucketHelm) extends(HeadgearBase)
	var(name,"Шлем");
	var(material,"MatMetal");
	var(dr,4);
	var(coverage,70);
	var(bodyPartsCovered,HEAD);
	var(weight,4);
	var(armaClass,"EoO_Fant_FlatHelm_1");
endclass

class(SmallShroomSteelHelmet1) extends(HeadgearBase)
	var(name,"Грибошлем");
	var(material,"MatMetal");
	var(dr,4);
	var(coverage,70);
	var(bodyPartsCovered,HEAD);
	var(weight,4);
	var(armaClass,"EoO_Fant_KettleHelm_1");
endclass

class(PeasantHat) extends(HeadgearBase)
	var(name,"Шапка");
	var(armaClass,"EoO_Fant_PaddedCap_1");
endclass

class(SmallSteelHelmetCovered1) extends(HeadgearBase)
	var(name,"Светлый стальной шлем");
	var(coverage,85);
	var(bodyPartsCovered,HEAD);
	var(weight,4);
	var(material,"MatMetal");
	var(armaClass,"EoO_Fant_Sallet_Helm_1");
endclass

class(SmallSteelHelmetCovered2) extends(SmallSteelHelmetCovered1)
	var(name,"Темный стальной шлем");
	var(armaClass,"EoO_Fant_Sallet_Helm_5");
endclass



class(SmallShroomHat3) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Milita_Hat_2");
endclass

class(SmallShroomHat4) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Milita_Hat_3");
endclass

class(SmallShroomHat5) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Milita_Hat_4");
endclass

class(BatHelmet1) extends(HeadgearBase)
	var(name,"Крылатый шлем");
	var(armaClass,"EoO_Fant_SkeletonHelm_5");
endclass

class(BatHelmet2) extends(BatHelmet1)
	var(armaClass,"EoO_Fant_SkeletonHelm_6");
endclass

class(SteelSpikeHelmet) extends(HeadgearBase)
	var(name,"Шлем с шипом");
	var(armaClass,"EoO_Fant_SkeletonHelm_2");
endclass

class(SmallShroomHat6) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Wissenland_Helm_3");
endclass

class(SmallShroomHat7) extends(SmallShroomHat1)
	var(armaClass,"EoO_Fant_Wissenland_Helm_4");
endclass

class(BigSteelShroomHelmet) extends(HeadgearBase)
	var(name,"Ритуальная грибошляпа");
	var(material,"MatMetal");
	var(armaClass,"SC_KatariCap");
endclass

class(BarbutHelmet) extends(HeadgearBase)
	var(name,"Шлем");
	var(coverage,90);
	var(bodyPartsCovered,HEAD+FACE);
	var(material,"MatMetal");
	var(dr,3);
	var(weight,5);
	var(armaClass,"Barbut_Helmet");
endclass

class(KnightCoveredHelmet1) extends(HeadgearBase)
	var(name,"Закрытый шлем");
	var(coverage,95);
	var(dr,4);
	var(bodyPartsCovered,HEAD+FACE);
	var(weight,4);
	var(material,"MatMetal");
	var(armaClass,"CoatOfPlate_Helmet");
endclass

class(CompositSteelOpenableHelmet) extends(HeadgearBase)
	var(name,"Composit_Helmet_Open");
	var(armaClass,"Composit_Helmet_Open"); //closable Composit_Helmet
endclass

class(SmallShroomSteelHelmet2) extends(SmallShroomSteelHelmet1)
	var(armaClass,"Metal_Hat_imsmhelmets");
endclass

class(Hornedklapp_Helmet) extends(HeadgearBase)
	var(name,"Hornedklapp_Helmet");
	var(armaClass,"Hornedklapp_Helmet");
endclass

class(InflatedSteelOpenableHelmet) extends(HeadgearBase)
	var(name,"Дутый шлем");
	var(coverage,100);
	var(bodyPartsCovered,HEAD);
	var(material,"MatLeather");
	var(weight,3);
	var(dr,3);
	var(armaClass,"Hornedklapp_Helmet_Open"); //closable Hornedklapp_Helmet
endclass

class(KnightHelmet1) extends(HeadgearBase)
	var(name,"Стальной шлем");
	var(armaClass,"Upper_Knight_Helmet"); //closable Upper_Knight_Helmet_Open
endclass

class(KnightHelmet2) extends(KnightHelmet1)
	var(armaClass,"Knight_Helmet_01_Open"); //Knight_Helmet_01
endclass

class(KnightCoveredHelmet2) extends(KnightCoveredHelmet1)
	var(armaClass,"Templar_Helmet");
endclass

//red
class(Turban1) extends(HeadgearBase)
	var(name,"Тюрбан");
	var(armaClass,"SC_Turban_ft1");
endclass

//black
class(Turban2) extends(Turban1)
	var(armaClass,"SC_Turban_Black");
endclass

//white
class(Turban3) extends(Turban1)
	var(armaClass,"SC_Turban_White");
endclass

//green
class(Turban4) extends(Turban1)
	var(armaClass,"SC_Turban_Tan");
endclass

class(InsulatedSnowHood) extends(HoodAbbat)
	var(name,"Утеплённый капюшон");
	var(armaClass,"SC_ColdGuardHood");
endclass

class(CombatHelmet) extends(HeadgearBase)
	var(name,"Боевой шлем");
	var(armaClass,"Army_Helmet_02");
endclass

//обломанные рога и лезвие на верхушке
class(FormidableHelmet) extends(HeadgearBase)
	var(name,"Грозный шлем");
	var(armaClass,"marked_men_faceless");
endclass

//cowboy hat
class(StetsonHat) extends(HeadgearBase)
	var(name,"Шляпа");
	var(armaClass,"Musketeer_Hat");
endclass

class(ShroomUpHat) extends(HeadgearBase)
	var(name,"Деревенская грибошляпа");
	var(armaClass,"Raoul_hat");
endclass

class(RitualMaskHat) extends(HeadgearBase)
	var(name,"Ритуальная маска");
	var(armaClass,"salt_wounds");
endclass

class(Hat3) extends(Hat1)
	var(name,"Коричневая шляпа");
	var(armaClass,"1950_style_hat02");
endclass

class(Hat4) extends(Hat1)
	var(name,"Черная шляпа");
	var(armaClass,"1950_style_hat");
endclass

class(HatBandanaOpen1) extends(HatBandana)
	var(name,"Красная бандана");
	var(armaClass,"bandanared");
endclass

class(LeatherHat) extends(HeadgearBase)
	var(name,"Плотная кожаная шапка");
	var(armaClass,"boomerhat03");
endclass

class(HatArmyCap1) extends(HatArmyCap)
	var(name,"Офицерская фуражка");
	var(armaClass,"chinesecommando_hat_general");
endclass

class(HatUshankaUpArmy) extends(HatUshankaUp)
	var(name,"Солдатская ушанка");
	var(armaClass,"chinesecommando_hat");
endclass

class(HatUshankaUpArmyOld) extends(HatUshankaUpArmy)
	var(name,"Старая солдатская ушанка");
	var(armaClass,"chinesecommando_cap_old");
endclass

class(StetsonHat1) extends(StetsonHat)
	var(armaClass,"cowboy_hat_01");
endclass

class(StetsonHat2) extends(StetsonHat)
	var(name,"Плетёная шляпа");
	var(armaClass,"cowboy_hat_02");
endclass

class(StetsonHat3) extends(StetsonHat)
	var(name,"Светлая шляпа");
	var(armaClass,"cowboy_hat_03");
endclass

class(StetsonHat4) extends(StetsonHat)
	var(name,"Высокая шляпа");
	var(armaClass,"cowboy_hat_05");
endclass

class(StetsonHat5) extends(StetsonHat)
	var(name,"Шляпа");
	var(armaClass,"lucassimms_hat");
endclass

class(RitualSkullHat1) extends(HeadgearBase)
	var(name,"Ритуальная шапка");
	var(armaClass,"fiendhelmet03");
endclass

class(RitualSkullHat2) extends(RitualSkullHat1)
	var(armaClass,"fiendhelmet");
endclass

class(ScavengerHat) extends(HeadgearBase)
	var(name,"Шляпа");
	var(armaClass,"hat_wasteland_clothing_02");
endclass

class(HatBandana4) extends(HatBandana)
	var(name,"Серая повязка на голову");
	var(armaClass,"headwrap_01");
endclass

class(HatBandana5) extends(HatBandana)
	var(name,"Светлая повязка на голову");
	var(armaClass,"headwrap_02");
endclass

class(HatBandana6) extends(HatBandana)
	var(name,"Желтая повязка на голову");
	var(armaClass,"headwrap_03");
endclass

class(HatBandana7) extends(HeadgearBase)
	var(name,"Серая повязка на голову");
	var(armaClass,"headwrap_04");
endclass

class(ToyBugMask) extends(HeadgearBase)
	var(name,"Жучья масочка");
	var(armaClass,"helmet_antagonizer");
endclass

class(HatBandanaOpen2) extends(HatBandanaOpen1)
	var(name,"Зелёная бандана");
	var(armaClass,"jessupbandana");
endclass

//у него меш чуть поломан
class(BandagedHelmet) extends(HeadgearBase)
	var(name,"Бинты");
	var(armaClass,"jgraham_helmet");
endclass

class(CoveredHood) extends(HoodAbbat)
	var(name,"Крытый тёмный капюшон");
	var(armaClass,"legionhood");
endclass

class(ToyTheaterMask) extends(HeadgearBase)
	var(name,"Театральная маска");
	var(armaClass,"mask"); //todo rename class
endclass

class(ToyRobotMask) extends(HeadgearBase)
	var(name,"Железячная масочка");
	var(armaClass,"mechanist_helm");
endclass

class(StetsonHat6) extends(StetsonHat4)
	var(armaClass,"PlagueMask_Head");
endclass

class(StetsonHat7) extends(StetsonHat)
	var(name,"Строгая шляпа");
	var(armaClass,"stetson_enclave");
endclass

class(CombatBowlerHat) extends(HeadgearBase)
	var(name,"Котелок");
	var(armaClass,"combat_ranger_helmet_open_rusty");
endclass

class(OldGrayClothHood) extends(HoodAbbat)
	var(name,"Старый капюшон");
	var(armaClass,"WBK_FuedalInquisitor_Cape"); //closable WBK_FuedalInquisitor_CapeMask
endclass

class(CombatHelmet1) extends(CombatHelmet)
	var(armaClass,"AFO_H_CombatHelmet_BOS");
endclass