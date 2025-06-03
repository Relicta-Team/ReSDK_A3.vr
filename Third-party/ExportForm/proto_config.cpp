//		user definition
#define c_name example_name_addon
#define c_name_short ena
#define c_name_desc "example name addon fullname"

/*
	guide:
	
	ФОРМА
	для определения формы надо пихать 2 класса
	в vehicles фактическое тело
	в weapons ссылка для vehicles
	базовый тип b_form
	для типа в weapons b_formwp (использовать через макрофункцию formref)
	
	БРОНИ
	определяются в cfgWeapons
	базовый тип b_vest
	
	РЮКЗАКИ
	определяются в cfgVehicles
	базовый тип b_back
	
	ШАПКИ
	определяются в cfgWeapons
	базовый тип b_head
	
	МАСКИ
	определяются в CfgGlasses
	базовый тип b_face
	
*/

//internal
#define postfix_cls _##c_name_short
#define with_postfix(clsname) clsname##postfix_cls

#define __tostr(val) #val

#define b_form with_postfix(Bbody_base)
#define b_formwp with_postfix(Buni_base)

#define formref(thisclass,reftobody) class thisclass: b_formwp \
	{ \
		scope=2; \
		class ItemInfo: UniformItem \
		{ \
			uniformClass= __tostr(reftobody); \
		}; \
	}

#define b_vest with_postfix(Bvest_base)
#define b_back with_postfix(Bback_base)
#define b_head with_postfix(Bhead_base)
#define b_face with_postfix(Bface_base)


class CfgPatches
{
	class c_name
	{
		name=c_name_desc;
		author="rlct";
		url="https://relicta.ru";
		requiredVersion=0.1;
		requiredAddons[]=
		{
			"A3_Weapons_F",
			"A3_Characters_F"
		};
		units[]={};
		weapons[]={};
	};
};

class DefaultEventhandlers;
class UniformSlotInfo;

class cfgVehicles
{
	class B_Soldier_base_F;
	class b_form : B_Soldier_base_F
	{
		scope=0;
		identityTypes[]=
		{
			"RadioProtocolGRE",
			"Head_Euro"
		};
		side=1;
		//faction="TMPBF";
		author="rlct";
		vehicleClass="Men";
		editorSubcategory="EdSubcat_Personnel";
		genericNames="NATOMen";
		displayName=__tostr(form c_name);
		nakedUniform="U_BasicBody";
	};
	
	class Bag_Base;
	class ContainerSupply;
	class b_back: Bag_Base
	{
		displayName=__tostr(backpack c_name);
		author="rlct";
		picture="\A3\characters_f\data\ui\icon_U_BasicBody_CA.paa";
		maximumLoad=100;
		mass=1;
		scope=0;
		hiddenSelections[]={};
		hiddenSelectionsTextures[]={};
	};
	
	
	//!--------- start clothes decl
	/*class testform_body: b_form
	{
		scope=2;
		model="";
		uniformClass="testform_uniform";
	};*/
	
	
	//!--start backpacks decl
	/*class test_backpack: b_back
	{
		scope=2;
		model="";
		hiddenSelections[]=
		{
			""
		};
		hiddenSelectionsTextures[]=
		{
			""
		};
	};*/
	
};


class cfgWeapons
{
	class InventoryItem_Base_F; //uniform base cfg
	class V_TacVest_khk; //vest basecfg
	
	class ItemCore;
	class b_formwp : ItemCore {
		scope=1;
		displayName=__tostr(form c_name);
		descriptionShort=__tostr(form c_name);
		picture="\A3\characters_f\data\ui\icon_U_BasicBody_CA.paa";
		author="rlct";
	};
	
	class b_vest : V_TacVest_khk {
		scope=1;
		displayName=__tostr(vest c_name);
		picture="\A3\characters_f\data\ui\icon_U_BasicBody_CA.paa";
		author="rlct";
	};

	class b_head : V_TacVest_khk {
		scope=1;
		displayName=__tostr(headgear c_name);
		picture="\A3\characters_f\data\ui\icon_U_BasicBody_CA.paa";
		author="rlct";
	};
	
	class HeadgearItem: InventoryItem_Base_F
	{
		allowedSlots[]={901,605};
		type=605;
		hiddenSelections[]={};
		hitpointName="HitHead";
	};
	class UniformItem: InventoryItem_Base_F
	{
		type=801;
		containerClass="Supply20";
		mass=30;
		uniformModel="-";
	};
	class VestItem: InventoryItem_Base_F
	{
		type=701;
		hiddenSelections[]={};
		armor="5*0";
		passThrough=1;
		hitpointName="HitBody";
		containerClass="Supply20";
		mass=1;
	};
	
	//!------start forms decl (not real uniforms)

	//formref(testform_uniform,testform_body);
	
	//!start vests decl
	/*class test_vest: b_vest
	{
		scope=2;
		model="";
		class ItemInfo: VestItem
		{
			uniformModel="";
		};
	};*/
	
	//!start headgears decl
	/*class test_helmet: b_head
	{
		scope=2;
		model="";
		class ItemInfo: HeadgearItem
		{
			uniformModel="";
		};
	};*/
	
};

class CfgGlasses
{
	class None;
	class b_face: None {
		displayName=__tostr(facewear c_name);
		author="rlct";
		picture="\A3\characters_f\data\ui\icon_U_BasicBody_CA.paa";
		identityTypes[]=
		{
			"NoGlasses",
			0,
			"G_NATO_default",
			0,
			"G_NATO_casual",
			0,
			"G_NATO_pilot",
			0,
			"G_NATO_recon",
			0,
			"G_NATO_SF",
			0,
			"G_NATO_sniper",
			0,
			"G_NATO_diver",
			0,
			"G_IRAN_default",
			0,
			"G_IRAN_diver",
			0,
			"G_GUERIL_default",
			0,
			"G_HAF_default",
			0,
			"G_CIVIL_female",
			0,
			"G_CIVIL_male",
			0
		};
	};

	//!start headgears decl
	/*
	class nvrebreather_mask_02: b_face
	{
		model="";
	};
	*/
};