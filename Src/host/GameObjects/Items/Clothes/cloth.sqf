// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"


#include "port_headgears.sqf"
#include "port_models.sqf"

editor_attribute("InterfaceClass")
class(Cloth) extends(Container)
	var(material,"MatCloth");
	var(name,"Одежда");
	var(desc,"Обычная одежда");
	var(size,ITEM_SIZE_MEDIUM);
	var(model,"relicta_models2\misc\s_clothes\s_clothes.p3d");
	//var(model,"ml\ml_object_new\model_05\podyshka.p3d");
	//var(icon,null); //в одежде иконка получается по методу getIcon

	var(dr,0); //сопротивление повреждениям
	var_num(bodyPartsCovered); //какие части тела покрывает броня
	var(coverage,100);//процент покрытия брони НЕ ИСПОЛЬЗУЕТСЯ В ДАННЫЙ МОМЕНТ
	var_str(armaClass); //класс для экипировки
	var_str(notes);//условия (защита только спереди и тд..)

	var(allowedSlots,[INV_CLOTH]);
	var(armaClass,"U_I_pilotCoveralls");

	var_exprval(countSlots,DEFAULT_CLOTH_STORAGE);
	var(maxSize,ITEM_SIZE_SMALL);
	var(weight,gramm(520));

	getterconst_func(getExamine3dItemType,"cloth");

	getter_func(getDropSound,"dropping\cloth");

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		getVar(_usr,owner) forceAddUniform getSelf(armaClass);
	};

	func(setUniformClass)
	{
		objParams_1(_class);
		setSelf(armaClass,_class);
		if callSelf(isInWorld) exitwith {};
		private _loc = getSelf(loc);
		if !isTypeOf(_loc,BasicMob) exitwith {};

		if (getSelf(slot) in getSelf(allowedSlots)) then {
			callSelfParams(armaItemAddImpl,_loc);
			callFuncAfter(_loc,requestSMDUpdate,0.2);
		};
	};

	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		removeUniform getVar(_usr,owner);
		callFunc(_usr,onApplyDefaultUniform);
	};

	func(onEquip) {
		objParams_1(_usr);

		callSuper(Container,onEquip);

		callSelfParams(armaItemAddImpl,_usr);

		callFuncAfter(_usr,requestSMDUpdate,0.2);
	};

	func(onUnequip) {
		objParams_1(_usr);

		callSuper(Container,onUnequip);

		callSelfParams(armaItemRemoveImpl,_usr);

		callFuncAfter(_usr,requestSMDUpdate,0.2);
	};

	func(getContainerOwerflowText)
	{
		private _name = callSelf(getName);
		selectRandom ["Не хватает места!","А места-то больше нет!","Так ведь битком набито!",_name + " больше не может вместить в себя!"];
	};
	
	//Смотри: client -> inventory_widgetSetPicture
	/*func(getIcon)
	{
		objParams();
		"!" + callSelf(getName);
	};*/

endclass


/*
	naked
"u_FRITH_RUIN_undltr_ref"
"U_FRITH_RUIN_undbld_ref"
"U_FRITH_RUIN_undfab_ref"

cochev
U_FRITH_RUIN_sdr_ltr
U_FRITH_RUIN_sdr_ltrdrk
U_FRITH_RUIN_sdr_ltrred
U_FRITH_RUIN_sdr_fabkak
U_FRITH_RUIN_sdr_fabgrn
U_FRITH_RUIN_sdr_faboli
U_FRITH_RUIN_sdr_fab
U_FRITH_RUIN_sdr_fabdpm
U_FRITH_RUIN_sdr_fabtan
U_FRITH_RUIN_sdr_fabmtp
U_FRITH_RUIN_sdr_fabrus

U_FRITH_RUIN_sdr_ltr_rs
U_FRITH_RUIN_sdr_ltrdrk_rs
U_FRITH_RUIN_sdr_ltrred_rs
U_FRITH_RUIN_sdr_fabkak_rs
U_FRITH_RUIN_sdr_fabbrn_rs
U_FRITH_RUIN_sdr_fabgrn_rs
U_FRITH_RUIN_sdr_faboli_rs
U_FRITH_RUIN_sdr_fab_rs
U_FRITH_RUIN_sdr_fabdpm_rs
U_FRITH_RUIN_sdr_fabtan_rs
U_FRITH_RUIN_sdr_fabmtp_rs
U_FRITH_RUIN_sdr_fabrus_rs

army
U_FRITH_RUIN_cofftan
U_FRITH_RUIN_offtan
U_FRITH_RUIN_coffgrn
U_FRITH_RUIN_offgrn
U_FRITH_RUIN_coffdpm
U_FRITH_RUIN_offdpm


citizen
U_FRITH_RUIN_SDR_Tshirt_wht
U_FRITH_RUIN_SDR_Tshirt_wht_zap
U_FRITH_RUIN_SDR_Tshirt_wht_fpk
U_FRITH_RUIN_SDR_Tshirt_cry
U_FRITH_RUIN_SDR_Tshirt_oli
U_FRITH_RUIN_SDR_Tshirt_oli_bet
U_FRITH_RUIN_SDR_Tshirt_blk_cyp
U_FRITH_RUIN_SDR_Tshirt_blk_boy
U_FRITH_RUIN_SDR_Tshirt_blk_drj

worker
U_FRITH_RUIN_WKR_lite
U_FRITH_RUIN_WKR_dark
U_FRITH_RUIN_WKR_tan
U_FRITH_RUIN_TSH_wht
U_FRITH_RUIN_TSH_wht_zap
U_FRITH_RUIN_TSH_wht_stk
U_FRITH_RUIN_TSH_wht_fpk
U_FRITH_RUIN_TSH_cry
U_FRITH_RUIN_TSH_oli
U_FRITH_RUIN_TSH_oli_bet
U_FRITH_RUIN_TSH_blk_cyp
U_FRITH_RUIN_TSH_blk_boy
U_FRITH_RUIN_TSH_blk_drj


trait
U_FRITH_RUIN_SDR_snip_crow
U_FRITH_RUIN_SDR_snip_bld
U_FRITH_RUIN_SDR_snip_hawk



*/

editor_attribute("InterfaceClass")
class(BodyClothBase) extends(Cloth)
	var(bodyPartsCovered,TORSO+LEGS+ARMS);
	var(dr,1);
	var(weight,gramm(340));

	func(onEquip)
	{
		objParams_1(_usr);
		super();
		callFuncParams(_usr,syncSmdVar,"decals" arg GERM_CONV_VALUE_TO_VISIBILITY_DECAL(getSelf(germs)));
	};

	func(onUnequip)
	{
		objParams_1(_usr);
		super();
		callFuncParams(_usr,syncSmdVar,"decals" arg 0);
	};

	func(onGermsChanged)
	{
		objParams();
		
		if callSelf(isInWorld) exitWith {};
		private _loc = getSelf(loc);
		if isNullReference(_loc) exitWith {};
		if !isTypeOf(_loc,BasicMob) exitWith {};
		
		callFuncParams(_loc,syncSmdVar,"decals" arg GERM_CONV_VALUE_TO_VISIBILITY_DECAL(getSelf(germs)));
	};

endclass

//var_runtime
//getArray(configFile >> "cfgVehicles" >> "FRITH_RUIN_SDR_Tshirt_wht" >> "hiddenSelectionsTextures")
#define generateSmartPicture() ___val = call compile((_fields select ((count _fields) - 1)) select 1); \
___cfg__ = ___val select [2,count ___val]; \
___val = getArray(configFile >> "cfgVehicles" >> ___cfg__ >> "hiddenSelectionsTextures"); \
var_exprval(icon,str (___val select 0))

//Шмоткам теперь вручную всё пишется
#define generateSmartPicture() ;

class(Castoffs1) extends(BodyClothBase)
	var(name,"Обноски");
	var(desc,"Куча тряпья, частично закрывающее тело");
	var(armaClass,"u_FRITH_RUIN_undltr_ref"); generateSmartPicture();
	var(countSlots,0);
	var(dr,0);
	var(canUseContainer,false);
	var(weight,gramm(320));
endclass

class(Castoffs2) extends(Castoffs1) var(armaClass,"U_FRITH_RUIN_undbld_ref"); generateSmartPicture(); endclass
class(Castoffs3) extends(Castoffs1) var(armaClass,"U_FRITH_RUIN_undfab_ref"); generateSmartPicture(); endclass

class(GreatcoatBlack) extends(BodyClothBase)
	var(name,"Черная шинель");
	var(armaClass,"mantel_reich");
	var(weight,gramm(580));
endclass

class(NomadCloth1) extends(BodyClothBase)
	var(name,"Одежда кочевника");
	var(desc,"Такая одежда пользуется большой популярностью среди кочевников благодаря её удобности и вместительности");
	var(armaClass,"U_FRITH_RUIN_sdr_ltr"); generateSmartPicture();
	var(countSlots,4);
	var(weight,gramm(650));
endclass

class(NomadCloth2) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_ltrdrk");generateSmartPicture(); endclass
class(NomadCloth3) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_ltrred");generateSmartPicture(); endclass
class(NomadCloth4) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabkak");generateSmartPicture(); endclass
class(NomadCloth5) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabgrn");generateSmartPicture(); endclass
class(NomadCloth6) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_faboli");generateSmartPicture(); endclass
class(NomadCloth7) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fab");generateSmartPicture(); endclass
class(NomadCloth8) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabdpm");generateSmartPicture(); endclass
class(NomadCloth9) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabtan");generateSmartPicture(); endclass
class(NomadCloth10) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabmtp");generateSmartPicture(); endclass
class(NomadCloth11) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabrus");generateSmartPicture(); endclass

class(NomadCloth12) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_ltr_rs");generateSmartPicture(); endclass
class(NomadCloth13) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_ltrdrk_rs");generateSmartPicture(); endclass
class(NomadCloth14) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_ltrred_rs");generateSmartPicture(); endclass
class(NomadCloth15) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabkak_rs");generateSmartPicture(); endclass
class(NomadCloth16) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabbrn_rs");generateSmartPicture(); endclass
class(NomadCloth17) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabgrn_rs");generateSmartPicture(); endclass
class(NomadCloth18) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_faboli_rs");generateSmartPicture(); endclass
class(NomadCloth19) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fab_rs");generateSmartPicture(); endclass
class(NomadCloth20) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabdpm_rs");generateSmartPicture(); endclass
class(NomadCloth21) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabtan_rs");generateSmartPicture(); endclass
class(NomadCloth22) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabmtp_rs");generateSmartPicture(); endclass
class(NomadCloth23) extends(NomadCloth1) var(armaClass,"U_FRITH_RUIN_sdr_fabrus_rs");generateSmartPicture(); endclass

// Одежда ополчения поселенцев
class(ArmyCloth1) extends(BodyClothBase)
	var(name,"Армейская одежда");
	var(desc,"Используется среди военных и стражей закона");
	var(armaClass,"U_FRITH_RUIN_cofftan");generateSmartPicture();
	var(countSlots,6);
	var(weight,gramm(750));
endclass

class(ArmyCloth2) extends(ArmyCloth1) var(armaClass,"U_FRITH_RUIN_offtan");generateSmartPicture(); endclass
class(ArmyCloth3) extends(ArmyCloth1) var(armaClass,"U_FRITH_RUIN_coffgrn");generateSmartPicture(); endclass
class(ArmyCloth4) extends(ArmyCloth1) var(armaClass,"U_FRITH_RUIN_offgrn");generateSmartPicture(); endclass
class(ArmyCloth5) extends(ArmyCloth1) var(armaClass,"U_FRITH_RUIN_coffdpm");generateSmartPicture(); endclass
class(ArmyCloth6) extends(ArmyCloth1) var(armaClass,"U_FRITH_RUIN_offdpm");generateSmartPicture(); endclass

// Обычная одежда поселенцев, различные обноски
class(CitizenCloth1) extends(BodyClothBase)
	var(name,"Одежда");
	var(desc,"Ничем не примечательная одежда");
	var(countSlots,2);
	var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_wht");generateSmartPicture();

	var(weight,gramm(310));
	//var(icon,"friths_ruin_cloth\data\frith_ruin_offDPM_co.paa");
endclass

class(CitizenCloth2) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_wht_zap");generateSmartPicture(); endclass
class(CitizenCloth3) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_wht_fpk");generateSmartPicture(); endclass
class(CitizenCloth4) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_cry");generateSmartPicture(); endclass
class(CitizenCloth5) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_oli");generateSmartPicture(); endclass
class(CitizenCloth6) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_oli_bet");generateSmartPicture(); endclass
class(CitizenCloth7) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_blk_cyp");generateSmartPicture(); endclass
class(CitizenCloth8) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_blk_boy");generateSmartPicture(); endclass
class(CitizenCloth9) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_SDR_Tshirt_blk_drj");generateSmartPicture(); endclass

//workers
class(CitizenCloth10) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_WKR_lite");generateSmartPicture(); endclass
class(CitizenCloth11) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_WKR_dark");generateSmartPicture(); endclass
class(CitizenCloth12) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_WKR_tan");generateSmartPicture(); endclass
class(CitizenCloth13) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_wht");generateSmartPicture(); endclass
class(CitizenCloth14) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_wht_zap");generateSmartPicture(); endclass
class(CitizenCloth15) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_wht_stk");generateSmartPicture(); endclass
class(CitizenCloth16) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_wht_fpk");generateSmartPicture(); endclass
class(CitizenCloth17) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_cry");generateSmartPicture(); endclass
class(CitizenCloth18) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_oli");generateSmartPicture(); endclass
class(CitizenCloth19) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_oli_bet");generateSmartPicture(); endclass
class(CitizenCloth20) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_blk_cyp");generateSmartPicture(); endclass
class(CitizenCloth21) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_blk_boy");generateSmartPicture(); endclass
class(CitizenCloth22) extends(CitizenCloth1) var(armaClass,"U_FRITH_RUIN_TSH_blk_drj");generateSmartPicture(); endclass

// Одежда торговца, надо переместить в другую категорию, зачем она тут отдельно живёт?
class(TorgashPalthCloth) extends(HeadCloth)
	var(name,"Клетчатое пальто");
	var(armaClass,"Skyline_Character_U_CivilA_08_F");
endclass

// Категоризировать
class(WhiteRobeCloth) extends(CliricCloth)
	var(armaClass,"U_TIOW_Priest");
	var(name,"Белая роба");
endclass

// Категоризировать
class(GreatcoatBrown) extends(GreatcoatBlack)
	var(armaClass,"sovietisher");
	var(name,"Коричневая шинель");
endclass

// Категоризировать
class(GreatcoatWhiteBrown) extends(GreatcoatBlack)
	var(armaClass,"mantel_snew");
	var(name,"Светлая коричневая шинель");
endclass

// Категоризировать
class(WomanBasicCloth) extends(GreatcoatBlack)
	var(armaClass,"woman4_5");
	var(name,"Женская одежда");
endclass

// Категоризировать
class(ZnatCloth) extends(GreatcoatBlack)
	var(armaClass,"rds_uniform_citizen4");
	var(name,"Знатная одежда");
endclass

//Халат
class(BlueRobe) extends(BodyClothBase)
	var(armaClass,"rds_uniform_schoolteacher");
	var(name,"Синий халат");
endclass

//Пальто
class(GreenCoat) extends(BodyClothBase)
	var(armaClass,"Skyline_Character_U_CivilA_03_F");
	var(name,"Зелёное пальто");
endclass

class(YellowCoat) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_02_F");
	var(name,"Жёлтое пальто");
endclass

class(BlackPlaidCoat) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_09_F");
	var(name,"Чёрное клетчатое пальто");
endclass

class(BluePlaidCoat) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_06_F");
	var(name,"Синее клетчатое пальто");
endclass

class(WhitePlaidCoat) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_04_F");
	var(name,"Белое клетчатое пальто");
endclass

class(RedPlaidCoat) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_10_F");
	var(name,"Красное клетчатое пальто");
endclass

//Куртки(Сюда бы все куртки пермеместить...)
class(GreenJacketCloth) extends(GreenCoat)
	var(armaClass,"Skyline_Character_U_CivilA_10_F");
	var(name,"Зелёная куртка");
	var(desc,"Хорошая куртка из плотной ткани")
endclass

//кожанка
class(LeatherJacketCloth) extends(BodyClothBase) var(armaClass,"Skyline_Character_U_CivilC_06_F"); endclass

//химза
class(ChemicalProtectionSuit) extends(BodyClothBase) var(armaClass,"Skyline_Character_U_CivilD_01_F"); endclass

//новоармеец
class(NewArmyStdCloth) extends(BodyClothBase) var(armaClass,"Skyline_Character_U_Pompier_02_F"); endclass

//голова, Категоризировать
class(HeadCloth) extends(BodyClothBase)
	var(armaClass,"Skyline_Character_U_CivilA_01_F");
	var(name,"Роскошное Головинское пальто");
endclass

//зам головы, Категоризировать
class(KnutCloth) extends(BodyClothBase)
	var(armaClass,"Skyline_Character_U_CivilA_07_F");
	var(name,"Кнутовка");
endclass

class(BrightRedCloth) extends(HeadCloth)
	var(name,"Яркое красное пальто");
	var(armaClass,"Skyline_Character_U_CivilA_05_F");
endclass

class(CookerCloth) extends(BodyClothBase)
	var(armaClass,"rds_uniform_Villager4");
	var(name,"Кухарская одежка");
	var(weight,gramm(250));
endclass

class(GreenWorkerCloth) extends(BodyClothBase)
	var(armaClass,"rds_uniform_Villager3");
	var(name,"Зелёная рабочая рубашка");
	var(weight,gramm(270));
endclass

class(AbbatCloth) extends(BodyClothBase)
	var(armaClass,"U_TIOW_Priest_Red");
	var(name,"Роба Аббата");
endclass

class(CliricCloth) extends(BodyClothBase)
	var(armaClass,"U_TIOW_Priest_Grey");
	var(name,"Серая роба");
endclass

//бригадирка
class(BrigadirCloth) extends(BodyClothBase)
	var(armaClass,"rds_uniform_Woodlander1");
	var(name,"Бригадирка");
endclass

//грибланка
class(GriblanCloth) extends(BodyClothBase)
	var(armaClass,"rds_uniform_Woodlander2");
	var(name,"Грибланский костюм");
endclass

class(BarmenCloth) extends(BodyClothBase)
	var(name,"Шмотки Барника");
	var(armaClass,"norRes1");
endclass

class(DoctorCloth) extends(BodyClothBase)
	var(armaClass,"rds_uniform_doctor");
	var(name,"Леканые одеяния");
endclass

class(WatchmanCloth) extends(BodyClothBase)
	var(name,"Вахтерская одежда");
	var(armaClass,"russian_coat");
endclass

class(CleanerCloth) extends(NomadCloth16)
	var(name,"Одежда Уходника");
endclass

class(MerchantCloth) extends(BodyClothBase)
	var(name,"Торговская шинель");
	var(armaClass,"nazi_coat");
endclass

class(GromilaCloth) extends(BodyClothBase)
	var(armaClass,"Skyline_Character_U_CivilC_05_F");
	var(name,"Громилка");
endclass

class(CaretakerCloth) extends(BodyClothBase)
	var(name,"Одеяния смотрителя");
	var(armaClass,"mantel_hbt");
endclass

class(VeteranCloth) extends(ArmyCloth2)
	var(name,"Униформа ополченца");
endclass

class(StreakCloth) extends(ArmyCloth4) //или ArmyCloth3 (без шарфа)
	var(name,"Униформа младшего ополченца");
endclass

//back

//накидка
class(WoolCoat) extends(Cloth)
	var(canUseContainer,false); //в ней ничего нет
	var(allowedSlots,[INV_BACK]);
	var(bodyPartsCovered,UPPER_TORSO);
	var(coverage,70);
	var(dr,2);
	var(armaClass,"Coat_Desert");
	var(name,"Накидка");

	//! Требуется https://github.com/Relicta-Team/ReSDK_A3.vr/issues/169

	func(armaItemAddImpl)
	{
		objParams_1(_usr);
		//! ТРЕБУЕТСЯ ИСПРАВЛЕНИЕ
		if !callFuncParams(_usr,isEmptySlot,INV_BACKPACK) exitWith {};
		getVar(_usr,owner) addBackpackGlobal getSelf(armaClass);
	};

	func(armaItemRemoveImpl)
	{
		objParams_1(_usr);
		//!ТРЕБУЕТСЯ ИСПРАВЛЕНИЕ
		if !callFuncParams(_usr,isEmptySlot,INV_BACKPACK) exitWith {};
		removeBackpackGlobal getVar(_usr,owner);
	};
endclass

class(FabricCape) extends(WoolCoat)
	var(name,"Накидка из ткани");
	var(armaClass,"Knight_Maxon_bag");
endclass


// Новые шмотки 24.05.25
editor_attribute("InterfaceClass")
class(NewClothes) extends(BodyClothBase)
endclass

class(OfficerGreatcoat) extends(NewClothes) //ретекстур
	var(name,"Офицерская шинель");
	var(armaClass,"colonelautumn_General_uniform");
endclass

class(VestAndTie) extends(NewClothes)
	var(name,"Жилетка с галстуком");
	var(armaClass,"AM_Uniform_CowboyOutfit_S");
endclass

class(FormNumber4) extends(NewClothes) //ретекстур
	var(name,"Форма номер 4");
	var(armaClass,"chinesecommando_03_uniform");
endclass

class(CoatWithLeather) extends(NewClothes) //ополчение (ретекстур)
	var(name,"Пальто с кожаными вставками");
	var(armaClass,"ncr_Boone_02_uniform");
endclass

class(CaveSuit) extends(NewClothes) //истязатели (ретекст)
	var(name,"Пещерный комбенизон");
	var(armaClass,"ncr_boone01_uniform");
endclass

class(WorkSuit) extends(NewClothes) //слесарь спальник
	var(name,"Комбенизон работяги");
	var(armaClass,"republican_04_uniform");
endclass

/*******************************************

	        Fallout cloth update

*******************************************/

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