version=54;
class EditorData
{
	moveGridStep=0.125;
	angleGridStep=0.2617994;
	scaleGridStep=100;
	autoGroupingDist=10;
	toggles=2;
	class ItemIDProvider
	{
		nextID=2494;
	};
	class LayerIndexProvider
	{
		nextID=327;
	};
	class Camera
	{
		pos[]={3921.5386,39.871315,4013.5317};
		dir[]={0.90656781,-0.42075449,0.035550393};
		up[]={0.42051125,0.90712523,0.016488742};
		aside[]={0.039186873,1.3877434e-007,-0.99930787};
	};
};
binarizationWanted=0;
sourceName="ReSDK_A3";
addons[]=
{
	"A3_Characters_F",
	"A3_Props_F_Orange_Humanitarian_Supplies",
	"cba_xeh",
	"rel_vox",
	"A3_Structures_F_Enoch_Industrial_Pipes",
	"CUP_A2_EditorObjects",
	"A3_Structures_F_Exp_Military_Pillboxes",
	"l04_catacombs",
	"RELICTA_models",
	"AtmObjects",
	"A3_Structures_F_Civ_Lamps",
	"csa_objects",
	"A3_Structures_F_Walls",
	"A3_Structures_F_Exp_Walls_Concrete",
	"stelazh_ot_seregi",
	"autopsy",
	"pechka",
	"xlamdoor",
	"Model_14_10",
	"exodus",
	"A3_Props_F_Enoch_Industrial_Supplies",
	"A3_Structures_F_Exp_Infrastructure_Roads",
	"ml_objects_heavy",
	"A3_Structures_F_Ind_Pipes",
	"A3_Structures_F_EPA_Civ_Camping",
	"A3_Structures_F_Exp_Naval_Canals"
};
class AddonsMetaData
{
	class List
	{
		items=22;
		class Item0
		{
			className="A3_Characters_F";
			name="Arma 3 Alpha - Characters and Clothing";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item1
		{
			className="A3_Props_F_Orange";
			name="Arma 3 Orange - Decorative and Mission Objects";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item2
		{
			className="rel_vox";
			name="rel_vox";
		};
		class Item3
		{
			className="A3_Structures_F_Enoch_Industrial";
			name="Arma 3 Contact Platform - Industrial Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item4
		{
			className="CUP_A2_EditorObjects";
			name="CUP_A2_EditorObjects";
			author="MemphisBelle";
		};
		class Item5
		{
			className="A3_Structures_F_Exp";
			name="Arma 3 Apex - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item6
		{
			className="l04_catacombs";
			name="l04_catacombs";
		};
		class Item7
		{
			className="RELICTA_models";
			name="RELICTA_models";
			author="Yodes and Alien";
		};
		class Item8
		{
			className="AtmObjects";
			name="AtmObjects";
		};
		class Item9
		{
			className="A3_Structures_F";
			name="Arma 3 - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item10
		{
			className="csa_objects";
			name="csa_objects";
		};
		class Item11
		{
			className="stelazh_ot_seregi";
			name="stelazh_ot_seregi";
		};
		class Item12
		{
			className="autopsy";
			name="autopsy";
		};
		class Item13
		{
			className="pechka";
			name="pechka";
		};
		class Item14
		{
			className="xlamdoor";
			name="xlamdoor";
		};
		class Item15
		{
			className="Model_14_10";
			name="Model_14_10";
		};
		class Item16
		{
			className="exodus";
			name="exodus";
		};
		class Item17
		{
			className="A3_Props_F_Enoch";
			name="Arma 3 Contact Platform - Decorative and Mission Objects";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item18
		{
			className="A3_Structures_F_Exp_Infrastructure";
			name="Arma 3 Apex - Infrastructure Objects";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item19
		{
			className="ml_objects_heavy";
			name="ml_objects_heavy";
		};
		class Item20
		{
			className="A3_Structures_F_Ind";
			name="Arma 3 - Industrial Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item21
		{
			className="A3_Structures_F_EPA";
			name="Arma 3 Survive Episode - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
	};
};
dlcs[]=
{
	"Orange",
	"Enoch",
	"Expansion"
};
randomSeed=11605075;
class ScenarioData
{
	author="Septima";
	saving=0;
};
class CustomAttributes
{
	class Category0
	{
		name="Multiplayer";
		class Attribute0
		{
			property="RespawnTemplates";
			expression="true";
			class Value
			{
				class data
				{
					singleType="ARRAY";
					class value
					{
						items=1;
						class Item0
						{
							class data
							{
								singleType="STRING";
								value="None";
							};
						};
					};
				};
			};
		};
		nAttributes=1;
	};
	class Category1
	{
		name="Scenario";
		class Attribute0
		{
			property="EnableTargetDebug";
			expression="true";
			class Value
			{
				class data
				{
					singleType="SCALAR";
					value=1;
				};
			};
		};
		class Attribute1
		{
			property="EnableDebugConsole";
			expression="true";
			class Value
			{
				class data
				{
					singleType="SCALAR";
					value=2;
				};
			};
		};
		nAttributes=2;
	};
};
class Mission
{
	class Intel
	{
		timeOfChanges=1800.0002;
		startWeather=0;
		startWind=0;
		startWaves=0.1;
		forecastWeather=0;
		forecastWind=0;
		forecastWaves=0.1;
		forecastLightnings=0.1;
		rainForced=1;
		windForced=1;
		day=20;
		hour=13;
		minute=-20;
		startFogDecay=0.014;
		forecastFogDecay=0.014;
	};
	class Entities
	{
		items=58;
		class Item0
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={11.849326,5.092412,8141.3096};
						angles[]={0,1.5586488,0};
					};
					side="West";
					flags=7;
					class Attributes
					{
						isPlayer=1;
						class Inventory
						{
						};
					};
					id=1;
					type="B_Survivor_F";
					atlOffset=0.0909729;
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male04ENG";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=0.97000003;
								};
							};
						};
						class Attribute2
						{
							property="face";
							expression="_this setface _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="WhiteHead_06";
								};
							};
						};
						nAttributes=3;
					};
				};
			};
			class Attributes
			{
			};
			id=0;
			atlOffset=0.0909729;
		};
		class Item1
		{
			dataType="Group";
			side="West";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={17.72065,5.0014391,8141.2852};
						angles[]={0,4.7971487,0};
					};
					side="West";
					flags=7;
					class Attributes
					{
						name="vasya";
						class Inventory
						{
						};
					};
					id=19;
					type="B_Survivor_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="speaker";
							expression="_this setspeaker _value;";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="Male10ENG";
								};
							};
						};
						class Attribute1
						{
							property="pitch";
							expression="_this setpitch _value;";
							class Value
							{
								class data
								{
									singleType="SCALAR";
									value=0.95999998;
								};
							};
						};
						nAttributes=2;
					};
				};
			};
			class Attributes
			{
			};
			id=18;
		};
		class Item2
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={14,-994.9588,8100};
			};
			side="Empty";
			flags=4;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""missionName"",""NRPrison""],[""version"",3]]}";
			};
			id=2205;
			type="Land_Orange_01_F";
			atlOffset=-1000;
		};
		class Item3
		{
			dataType="Layer";
			name="Prison_floor";
			class Entities
			{
				items=11;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4004.7468,14.405367,4009.0579};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2208;
					type="block_brick";
					atlOffset=14.850624;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3995.5879,14.365784,4008.8813};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2206;
					type="block_brick";
					atlOffset=14.811041;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3995.4827,14.292305,4019.8887};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
					};
					id=2211;
					type="block_strongstone";
					atlOffset=14.737562;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4009.4587,14.231031,4019.8635};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
					};
					id=2210;
					type="block_strongstone";
					atlOffset=14.676289;
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4012.3479,14.344172,4008.9922};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2228;
					type="block_brick";
					atlOffset=14.789429;
				};
				class Item5
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4023.1201,14.10479,4008.908};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2229;
					type="block_brick";
					atlOffset=14.550047;
				};
				class Item6
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4022.8687,14.055182,3998.3455};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2230;
					type="block_brick";
					atlOffset=14.500439;
				};
				class Item7
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4023.0549,14.24334,4019.6736};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2232;
					type="block_brick";
					atlOffset=14.688597;
				};
				class Item8
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3931.2231,13.821859,4041.4431};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockBrick""]]}";
					};
					id=2358;
					type="block_brick";
					atlOffset=14.267117;
				};
				class Item9
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4009.4114,14.352095,4031.0325};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
					};
					id=2404;
					type="block_strongstone";
					atlOffset=14.797352;
				};
				class Item10
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3995.5146,14.184732,4030.5129};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
					};
					id=2405;
					type="block_strongstone";
					atlOffset=14.62999;
				};
			};
			id=2209;
			atlOffset=14.855927;
		};
		class Item4
		{
			dataType="Layer";
			name="Background";
			class Entities
			{
				items=2;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4002.2188,8.8131952,4015.8582};
					};
					side="Empty";
					flags=4;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""IndustrialPipes""]]}";
					};
					id=2214;
					type="Land_IndPipe3_big_18_F";
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4002.3474,8.8131952,4028.2058};
					};
					side="Empty";
					flags=4;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""IndustrialPipes""]]}";
					};
					id=2409;
					type="Land_IndPipe3_big_18_F";
				};
			};
			id=2221;
		};
		class Item5
		{
			dataType="Layer";
			name="walls_bg";
			class Entities
			{
				items=15;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4039.9807,36.977642,3985.7009};
						angles[]={6.2815657,0,0.0065963282};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""ca\structures\castle\a_castle_bergfrit_dam.p3d""]]],[""class"",""BigStoneWall""]]}";
					};
					id=2248;
					type="CUP_A2_castle_bergfrit_dam";
					atlOffset=18.837231;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4024.2166,27.47966,3993.3752};
						angles[]={0.0030043011,0.58531189,0.0064063701};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigStoneWall""]]}";
					};
					id=2243;
					type="CUP_A2_castle_wall1_20";
					atlOffset=4.4053421;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4014.8113,25.933895,4000.2524};
						angles[]={6.2822742,0.01686696,0.0070161186};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""ca\structures\castle\a_castle_wall2_corner.p3d""]]],[""class"",""BigStoneWall""]]}";
					};
					id=2245;
					type="CUP_A2_castle_wall2_corner";
					atlOffset=14.877104;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.2307,21.567968,3996.5144};
						angles[]={0.0070239436,1.5707964,0.00085606525};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d""],[""desc"",""Толстая стена из кирпича. Всего несколько метров от свободы.""]]],[""class"",""BetonWallMedium""]]}";
					};
					id=2251;
					type="Land_PillboxWall_01_6m_F";
					atlOffset=1.932066;
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.2166,21.554792,4002.5083};
						angles[]={0.0070239436,1.5707964,0.00085606525};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d""],[""desc"",""Толстая стена из кирпича. Всего несколько метров от свободы.""]]],[""class"",""BetonWallMedium""]]}";
					};
					id=2252;
					type="Land_PillboxWall_01_6m_F";
					atlOffset=1.9558372;
				};
				class Item5
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.2195,21.624966,4008.4995};
						angles[]={0.0070239436,1.5707964,0.00085606525};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d""],[""desc"",""Толстая стена из кирпича. Всего несколько метров от свободы.""]]],[""class"",""BetonWallMedium""]]}";
					};
					id=2253;
					type="Land_PillboxWall_01_6m_F";
					atlOffset=1.8885937;
				};
				class Item6
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.1814,21.605307,4014.3853};
						angles[]={0.0070239436,1.5707964,0.00085606525};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d""],[""desc"",""Толстая стена из кирпича. Всего несколько метров от свободы.""]]],[""class"",""BetonWallMedium""]]}";
					};
					id=2254;
					type="Land_PillboxWall_01_6m_F";
					atlOffset=1.8127289;
				};
				class Item7
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.1475,21.596691,4020.3665};
						angles[]={0.0070239436,1.5707964,0.00085606525};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d""],[""desc"",""Толстая стена из кирпича. Всего несколько метров от свободы.""]]],[""class"",""BetonWallMedium""]]}";
					};
					id=2255;
					type="Land_PillboxWall_01_6m_F";
					atlOffset=1.7161198;
				};
				class Item8
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4016.0129,26.287167,4025.8423};
						angles[]={0.0070111523,1.5822924,0.00095450715};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigStoneWall""]]}";
					};
					id=2260;
					type="CUP_A2_castle_wall1_20";
					atlOffset=17.800266;
				};
				class Item9
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4031.5061,27.367809,4026.3914};
						angles[]={0.00091749371,3.1581054,6.2761831};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""ca\structures\castle\a_castle_wall2_corner.p3d""]]],[""class"",""BigStoneWall""]]}";
					};
					id=2262;
					type="CUP_A2_castle_wall2_corner";
					atlOffset=16.311018;
				};
				class Item10
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4037.418,36.699692,4030.0327};
						angles[]={6.2815657,0,0.0065963282};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""ca\structures\castle\a_castle_bergfrit_dam.p3d""]]],[""class"",""BigStoneWall""]]}";
					};
					id=2264;
					type="CUP_A2_castle_bergfrit_dam";
					atlOffset=18.55928;
				};
				class Item11
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.5872,33.196709,4027.741};
						angles[]={0.007126702,3.2002215,0.0054080836};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""ca\structures\castle\a_castle_wall1_20_turn.p3d""]]],[""class"",""BigStoneWall""]]}";
					};
					id=2289;
					type="CUP_A2_castle_wall1_20_turn";
					atlOffset=5.0565434;
				};
				class Item12
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4016.2493,23.771812,4008.8223};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ConcreteArch""]]}";
					};
					id=2356;
					type="l04_catacombs_00";
					atlOffset=14.637835;
				};
				class Item13
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3991.0117,23.847221,4008.9604};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ConcreteArch""]]}";
					};
					id=2395;
					type="l04_catacombs_00";
					atlOffset=0.60292053;
				};
				class Item14
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4014.8169,36.724861,4006.3965};
						angles[]={0.0070111523,1.5822924,0.00095450715};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigStoneWall""]]}";
					};
					id=2396;
					type="CUP_A2_castle_wall1_20";
					atlOffset=13.332304;
				};
			};
			id=2236;
			atlOffset=0.90271187;
		};
		class Item6
		{
			dataType="Layer";
			name="elektronika";
			class Entities
			{
				items=12;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.9663,20.184607,4002.4556};
						angles[]={6.2436666,4.6713066,0.024610875};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""PowerGenerator""],[""edConnected"",[""StreetLampEnabled G:BDN+S1yZ/S0"",""LampWall G:4wwgg1i6mtk"",""LampWall G:+WLVHg1VIhE"",""LampCeiling G:o1w1FH4lGDs"",""LampCeiling G:mFDepJIrQWg"",""LampCeiling G:N06+vnpJ0sw"",""LampWall G:+WLVHg1VIhE (2)"",""LampWall G:+WLVHg1VIhE (1)"",""StreetLampEnabled G:BDN+S1yZ/S0 (2)"",""StreetLampEnabled G:BDN+S1yZ/S0 (1)""]],[""mark"",""PowerGenerator G:6zjrUq/qWew""]]}";
					};
					id=2259;
					type="controlpanel";
					atlOffset=14.520451;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4034.4375,26.920486,3992.9917};
						angles[]={0,1.501411,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampWall""],[""mark"",""LampWall G:+WLVHg1VIhE""]]}";
					};
					id=2258;
					type="Lamp_stena";
					atlOffset=21.920063;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4034.0955,26.967268,3992.7705};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampWall""],[""mark"",""LampWall G:4wwgg1i6mtk""]]}";
					};
					id=2257;
					type="Lamp_stena";
					atlOffset=21.966845;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.7468,23.319794,3994.2417};
						angles[]={0,5.6546764,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""StreetLampEnabled""],[""mark"",""StreetLampEnabled G:BDN+S1yZ/S0""]]}";
					};
					id=2256;
					type="Land_LampShabby_off_F";
					atlOffset=14.547764;
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.1008,21.246359,4028.1101};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=4;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWall""]]}";
					};
					id=2270;
					type="Land_kr_stena_3x6";
					atlOffset=0.0013027191;
				};
				class Item5
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.9993,25.271255,4023.1895};
						angles[]={0,4.712389,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampWall""],[""mark"",""LampWall G:+WLVHg1VIhE (1)""]]}";
					};
					id=2321;
					type="Lamp_stena";
					atlOffset=20.270832;
				};
				class Item6
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4031.0471,25.281569,4023.2473};
						angles[]={0,4.712389,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampWall""],[""mark"",""LampWall G:+WLVHg1VIhE (2)""]]}";
					};
					id=2322;
					type="Lamp_stena";
					atlOffset=20.281145;
				};
				class Item7
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.218,22.591215,4025.1841};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampCeiling""],[""mark"",""LampCeiling G:mFDepJIrQWg""]]}";
					};
					id=2316;
					type="Lamp_tarelka";
					atlOffset=2.682291;
				};
				class Item8
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4019.8723,22.576323,4034.4431};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampCeiling""],[""mark"",""LampCeiling G:o1w1FH4lGDs""]]}";
					};
					id=2317;
					type="Lamp_tarelka";
					atlOffset=2.6599922;
				};
				class Item9
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.6365,22.522209,4024.8003};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampCeiling""],[""mark"",""LampCeiling G:N06+vnpJ0sw""]]}";
					};
					id=2315;
					type="Lamp_tarelka";
					atlOffset=2.6378822;
				};
				class Item10
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4017.4126,23.274647,4013.7424};
						angles[]={0,1.5953742,-0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""StreetLampEnabled""],[""mark"",""StreetLampEnabled G:BDN+S1yZ/S0 (1)""]]}";
					};
					id=2437;
					type="Land_LampShabby_off_F";
					atlOffset=14.502617;
				};
				class Item11
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4017.502,23.538401,4003.9783};
						angles[]={0,1.3641757,-0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""StreetLampEnabled""],[""mark"",""StreetLampEnabled G:BDN+S1yZ/S0 (2)""]]}";
					};
					id=2438;
					type="Land_LampShabby_off_F";
					atlOffset=14.766371;
				};
			};
			id=2237;
			atlOffset=0.7358799;
		};
		class Item7
		{
			dataType="Layer";
			name="prison_walls";
			class Entities
			{
				items=25;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4025.1409,21.166513,4025.25};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWallWindow3""]]}";
					};
					id=2266;
					type="Land_kr_stena_3x6_3okn";
					atlOffset=14.672976;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4022.2966,21.2034,4028.4243};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWallWindow""]]}";
					};
					id=2268;
					type="Land_kr_stena_3x6_okn_1";
					atlOffset=14.709862;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4025.6462,21.222143,4036.2754};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWall""]]}";
					};
					id=2275;
					type="Land_kr_stena_3x6";
					atlOffset=14.728605;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4022.2988,21.201813,4034.0901};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWallDoorway""]]}";
					};
					id=2269;
					type="Land_kr_stena_3x6_dv";
					atlOffset=14.708275;
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.1038,21.241079,4034.0244};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWall""]]}";
					};
					id=2271;
					type="Land_kr_stena_3x6";
					atlOffset=14.747541;
				};
				class Item5
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4024.6196,22.186401,4036.9348};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2383;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.9346371;
				};
				class Item6
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4023.7861,22.023624,4053.6096};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2382;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.7567654;
				};
				class Item7
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4018.6191,22.204628,4049.8125};
						angles[]={0,1.6733931,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2380;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.9377689;
				};
				class Item8
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.7407,22.078142,4049.7114};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2379;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.8118916;
				};
				class Item9
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4028.7461,22.167717,4040.7813};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2375;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.9106941;
				};
				class Item10
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4018.1716,22.192009,4040.9241};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2374;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.936554;
				};
				class Item11
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.6951,21.248247,4036.2715};
					};
					side="Empty";
					flags=4;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BrickThinWallDoorway""]]}";
					};
					id=2366;
					type="Land_kr_stena_3x6_dv";
				};
				class Item12
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4024.2832,21.226803,4042.8357};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ConcreteWall""]]}";
					};
					id=2376;
					type="Land_ConcreteWall_01_l_8m_F";
					atlOffset=0.56864929;
				};
				class Item13
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4008.6848,21.747162,4015.0706};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2398;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.5021954;
				};
				class Item14
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4013.0105,21.703804,4019.6956};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2399;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.4004765;
				};
				class Item15
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4008.9141,21.741663,4021.468};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2400;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.4660378;
				};
				class Item16
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3996.0806,22.205269,4015.0657};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2401;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.8749142;
				};
				class Item17
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3996.2695,21.735203,4021.5325};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2402;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.4055824;
				};
				class Item18
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3991.4604,22.152048,4019.7478};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2403;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.8145161;
				};
				class Item19
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4008.948,21.737158,4033.8701};
						angles[]={0,0.15236107,-0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2410;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.3323765;
				};
				class Item20
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4013.0759,21.70336,4028.5415};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2411;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.280611;
				};
				class Item21
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3995.4919,22.032795,4034.1167};
						angles[]={0,6.1355033,-0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2412;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.7925587;
				};
				class Item22
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3991.4468,22.143776,4028.6638};
						angles[]={0,1.5707964,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2413;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.9263744;
				};
				class Item23
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4008.7349,21.684679,4027.9197};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2429;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.2929878;
				};
				class Item24
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3996.2229,21.749004,4028.1792};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
					};
					id=2432;
					type="Land_Canal_WallSmall_10m_F";
					atlOffset=3.5141621;
				};
			};
			id=2238;
			atlOffset=3.5441628;
		};
		class Item8
		{
			dataType="Layer";
			name="prison_celling";
			class Entities
			{
				items=14;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.9111,23.646549,4027.2703};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2301;
					type="Land_pod_6x6";
					atlOffset=4.3967457;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.8662,23.650764,4027.4104};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2302;
					type="Land_pod_6x6";
					atlOffset=4.3967457;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.7512,23.653955,4033.2715};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2299;
					type="Land_pod_6x6";
					atlOffset=4.3967457;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.7473,23.650326,4033.3953};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2300;
					type="Land_pod_6x6";
					atlOffset=4.3967457;
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4021.2371,18.744802,4028.0469};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2346;
					type="Land_pod_6x6";
					atlOffset=14.242302;
				};
				class Item5
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.1921,18.749018,4028.187};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2347;
					type="Land_pod_6x6";
					atlOffset=14.246517;
				};
				class Item6
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4021.0771,18.752209,4034.0481};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2348;
					type="Land_pod_6x6";
					atlOffset=14.249708;
				};
				class Item7
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.0732,18.748579,4034.1719};
						angles[]={0,6.2605567,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2349;
					type="Land_pod_6x6";
					atlOffset=14.246078;
				};
				class Item8
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.9644,18.75227,4039.9355};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2369;
					type="Land_pod_6x6";
					atlOffset=14.249769;
				};
				class Item9
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.9675,18.749641,4045.8882};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2370;
					type="Land_pod_6x6";
					atlOffset=14.247141;
				};
				class Item10
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.9668,18.753838,4040.0774};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2371;
					type="Land_pod_6x6";
					atlOffset=14.251337;
				};
				class Item11
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.9688,18.754583,4045.9106};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2372;
					type="Land_pod_6x6";
					atlOffset=14.252083;
				};
				class Item12
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4020.9646,18.763674,4051.8938};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2377;
					type="Land_pod_6x6";
					atlOffset=14.261173;
				};
				class Item13
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.9722,18.763065,4051.9207};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ThickConcreteFloorSmall""]]}";
					};
					id=2378;
					type="Land_pod_6x6";
					atlOffset=14.260565;
				};
			};
			id=2239;
			atlOffset=14.263065;
		};
		class Item9
		{
			dataType="Layer";
			name="decor";
			class Entities
			{
				items=5;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4025.9604,20.785671,4035.6799};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LongShelf""]]}";
					};
					id=2345;
					type="stelazh_ot_seregi";
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.9094,20.496765,4028.6355};
						angles[]={0,3.1415927,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampKeroseneHolder""]]}";
					};
					id=2353;
					type="Land_Net_Fence_pole_F";
					atlOffset=14.746517;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.3943,20.22168,4030.6816};
						angles[]={0,1.5445017,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SurgeryBlueTable""]]}";
					};
					id=2329;
					type="autopsy";
					atlOffset=14.589304;
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4026.3782,23.762774,4026.531};
						angles[]={0,1.5781524,0};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlackSmallStove""]]}";
					};
					id=2352;
					type="pechechkas";
				};
				class Item4
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.4961,20.17555,4026.4719};
						angles[]={0,3.0813689,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SmallStoveGrill""]]}";
					};
					id=2351;
					type="pechka";
					atlOffset=14.566401;
				};
			};
			id=2240;
			atlOffset=14.638344;
		};
		class Item10
		{
			dataType="Layer";
			name="prison_doors";
			class Entities
			{
				items=2;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4022.2197,20.681177,4035.2944};
						angles[]={0,1.5785533,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""WoodenDoor""]]}";
					};
					id=2328;
					type="Land_xlamdoor";
					atlOffset=14.589222;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4019.4792,20.787043,4036.3679};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelGreenDoor""]]}";
					};
					id=2373;
					type="dooor";
					atlOffset=14.421442;
				};
			};
			id=2241;
			atlOffset=14.505333;
		};
		class Item11
		{
			dataType="Layer";
			name="items";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.0574,21.102785,4029.5217};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampKerosene""]]}";
					};
					id=2355;
					type="land_keroslampa";
					atlOffset=0.99811172;
				};
			};
			id=2242;
			atlOffset=0.99811172;
		};
		class Item12
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4027.3213,20.219645,4032.7773};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SquareWoodenBox""]]}";
			};
			id=2386;
			type="Land_WoodenBox_02_F";
			atlOffset=14.732996;
		};
		class Item13
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4028.1807,21.508251,4024.1758};
				angles[]={0,0.030054044,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""InfoBoard""]]}";
			};
			id=2387;
			type="infotablicka";
			atlOffset=1.0278111;
		};
		class Item14
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4027.3926,19.797239,4034.4382};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""desc"",""Этот люк ведёт в погреб, к продуктами и ингредиентам.""]]],[""class"",""SewercoverBase""]]}";
			};
			id=2388;
			type="Land_SewerCover_03_F";
			atlOffset=0.046159744;
		};
		class Item15
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4002.4697,19.613308,4021.416};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigSteelGrating""]]}";
			};
			id=2406;
			type="grating_01";
			atlOffset=8.5077248;
		};
		class Item16
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4002.3306,19.614172,4035.3894};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigSteelGrating""]]}";
			};
			id=2408;
			type="grating_01";
			atlOffset=8.5085888;
		};
		class Item17
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4001.9124,22.018364,4034.6455};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LargeConcreteWallWithReinforcement""]]}";
			};
			id=2423;
			type="Land_Canal_WallSmall_10m_F";
			atlOffset=3.8333759;
		};
		class Item18
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4004.4224,21.565197,4018.3772};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2427;
			type="kaleetka";
		};
		class Item19
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4004.5525,21.491264,4024.7344};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2428;
			type="kaleetka";
			atlOffset=14.699642;
		};
		class Item20
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4004.4263,21.661613,4031.2322};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2430;
			type="kaleetka";
			atlOffset=1.9073486e-006;
		};
		class Item21
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4000.3896,21.558372,4031.4309};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2433;
			type="kaleetka";
			atlOffset=1.9073486e-006;
		};
		class Item22
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4000.3096,21.665955,4024.834};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2434;
			type="kaleetka";
			atlOffset=0.37037086;
		};
		class Item23
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4000.5225,21.63834,4018.3281};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""RustyCell""]]}";
			};
			id=2435;
			type="kaleetka";
			atlOffset=1.9073486e-006;
		};
		class Item24
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4004.8464,20.226053,4012.1719};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampKerosene""]]}";
			};
			id=2436;
			type="land_keroslampa";
			atlOffset=14.872898;
		};
		class Item25
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4013.7751,20.058558,4015.4688};
				angles[]={4.7273145,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LongSteelPipe""]]}";
			};
			id=2441;
			type="Land_IndPipe1_20m_F";
			atlOffset=14.716478;
		};
		class Item26
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3993.5281,19.765242,4020.1985};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""DoubleArmyBed""]]}";
			};
			id=2442;
			type="CUP_A2_vojenska_palanda";
			atlOffset=14.765242;
		};
		class Item27
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3993.5522,19.744852,4016.1643};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""DoubleArmyBed""]]}";
			};
			id=2443;
			type="CUP_A2_vojenska_palanda";
			atlOffset=14.744852;
		};
		class Item28
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3997.3308,19.761745,4020.2832};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""DoubleArmyBed""]]}";
			};
			id=2444;
			type="CUP_A2_vojenska_palanda";
			atlOffset=14.761745;
		};
		class Item29
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3997.3088,19.764347,4016.1404};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""DoubleArmyBed""]]}";
			};
			id=2445;
			type="CUP_A2_vojenska_palanda";
			atlOffset=14.764347;
		};
		class Item30
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4000.0562,19.736835,4015.8555};
				angles[]={0,3.1415927,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2446;
			type="CUP_A2_metalcase_01";
			atlOffset=14.736835;
		};
		class Item31
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3999.6206,19.732079,4015.8367};
				angles[]={0,3.1415927,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2447;
			type="CUP_A2_metalcase_01";
			atlOffset=14.732079;
		};
		class Item32
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3999.1667,19.729183,4015.8301};
				angles[]={0,3.1415927,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2448;
			type="CUP_A2_metalcase_01";
			atlOffset=14.729183;
		};
		class Item33
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3998.7175,19.729164,4015.8069};
				angles[]={0,3.1415927,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2449;
			type="CUP_A2_metalcase_01";
			atlOffset=14.729164;
		};
		class Item34
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3998.5332,19.762438,4020.7344};
				angles[]={6.2815661,0,0.0065963282};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2450;
			type="CUP_A2_metalcase_01";
			atlOffset=14.762438;
		};
		class Item35
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3998.9531,19.778257,4020.7534};
				angles[]={6.2815661,0,0.0065963282};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2451;
			type="CUP_A2_metalcase_01";
			atlOffset=14.778257;
		};
		class Item36
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3999.7813,19.755501,4020.7583};
				angles[]={6.2815661,0,0.0065963282};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2452;
			type="CUP_A2_metalcase_01";
			atlOffset=14.755501;
		};
		class Item37
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3999.3708,19.779461,4020.752};
				angles[]={6.2815661,0,0.0065963282};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelBlueCase""]]}";
			};
			id=2453;
			type="CUP_A2_metalcase_01";
			atlOffset=14.779461;
		};
		class Item38
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4025.8569,20.146431,4020.854};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2456;
			type="Land_WoodenTable_large_F";
			atlOffset=14.714146;
		};
		class Item39
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4025.8438,20.147066,4018.6582};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2458;
			type="Land_WoodenTable_large_F";
			atlOffset=14.714781;
		};
		class Item40
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4022.2542,20.115034,4018.6584};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2459;
			type="Land_WoodenTable_large_F";
			atlOffset=14.682756;
		};
		class Item41
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4022.2673,20.114399,4020.8542};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2460;
			type="Land_WoodenTable_large_F";
			atlOffset=14.682121;
		};
		class Item42
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4025.7959,20.143702,4014.2739};
			};
			side="Empty";
			flags=4;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2463;
			type="Land_WoodenTable_large_F";
			atlOffset=0.042095184;
		};
		class Item43
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4025.8091,20.143066,4016.4697};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2464;
			type="Land_WoodenTable_large_F";
			atlOffset=14.710781;
		};
		class Item44
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4022.2239,20.109734,4014.2993};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2465;
			type="Land_WoodenTable_large_F";
			atlOffset=0.28519821;
		};
		class Item45
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4022.2371,20.109098,4016.4951};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""MediumWoodenTable""]]}";
			};
			id=2466;
			type="Land_WoodenTable_large_F";
			atlOffset=14.676813;
		};
		class Item46
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4021.0017,19.903978,4015.3948};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2467;
			type="skameika";
			atlOffset=14.624178;
		};
		class Item47
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4021.0142,19.961182,4019.7283};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2468;
			type="skameika";
			atlOffset=14.681381;
		};
		class Item48
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4023.1702,19.978365,4019.7896};
				angles[]={0,4.712389,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2469;
			type="skameika";
			atlOffset=14.698565;
		};
		class Item49
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4023.1895,19.973013,4015.5518};
				angles[]={0,4.712389,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2470;
			type="skameika";
			atlOffset=14.693213;
		};
		class Item50
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4026.8726,20.079544,4015.3865};
				angles[]={0,4.712389,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2471;
			type="skameika";
			atlOffset=14.799744;
		};
		class Item51
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4024.6848,20.010509,4015.2295};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2472;
			type="skameika";
			atlOffset=14.730709;
		};
		class Item52
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4024.6973,20.067713,4019.563};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2473;
			type="skameika";
			atlOffset=14.787912;
		};
		class Item53
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4026.8533,20.084896,4019.6243};
				angles[]={0,4.712389,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Bench3""]]}";
			};
			id=2474;
			type="skameika";
			atlOffset=14.805096;
		};
		class Item54
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4002.0747,23.712297,4024.9624};
				angles[]={6.2821498,0,0.0069996584};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BigSteelRoof""]]}";
			};
			id=2478;
			type="Land_krysha_18x18";
			atlOffset=3.5280533;
		};
		class Item55
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3984.0505,19.270184,4025.8828};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\naval\canals\canal_dutch_01_plate_f.p3d""]]],[""class"",""BlockBrick""]]}";
			};
			id=2482;
			type="Land_Canal_Dutch_01_plate_F";
			atlOffset=14.025608;
		};
		class Item56
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3984.0518,19.289545,4013.0925};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\naval\canals\canal_dutch_01_plate_f.p3d""]]],[""class"",""BlockBrick""]]}";
			};
			id=2483;
			type="Land_Canal_Dutch_01_plate_F";
			atlOffset=14.04497;
		};
		class Item57
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3984.1035,19.294491,4000.5215};
				angles[]={0,1.5707964,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_exp\naval\canals\canal_dutch_01_plate_f.p3d""]]],[""class"",""BlockBrick""]]}";
			};
			id=2484;
			type="Land_Canal_Dutch_01_plate_F";
			atlOffset=14.049915;
		};
	};
};
