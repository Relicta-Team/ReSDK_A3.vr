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
		nextID=2355;
	};
	class LayerIndexProvider
	{
		nextID=212;
	};
	class Camera
	{
		pos[]={4023.158,21.477089,4013.0815};
		dir[]={-0.28791335,-0.75757033,0.58583391};
		up[]={-0.33414283,0.65275216,0.67989981};
		aside[]={0.8974762,-9.9826138e-009,0.44107252};
	};
};
binarizationWanted=0;
sourceName="resdk_fork";
addons[]=
{
	"A3_Characters_F",
	"A3_Props_F_Orange_Humanitarian_Supplies",
	"cba_xeh",
	"rel_vox",
	"A3_Structures_F_Bootcamp_VR_Helpers",
	"AtmObjects",
	"A3_Structures_F_Civ_Camping",
	"RELICTA_models",
	"ml_exonew",
	"Model_14_10",
	"A3_Structures_F_Enoch_Military_Training",
	"A3_Structures_F_Enoch_Infrastructure_Roads",
	"A3_Structures_F_Heli_Furniture",
	"exodus",
	"csa_objects",
	"ml_objects_heavy",
	"pechka"
};
class AddonsMetaData
{
	class List
	{
		items=16;
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
			className="A3_Structures_F_Bootcamp";
			name="Arma 3 Bootcamp Update - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item4
		{
			className="AtmObjects";
			name="AtmObjects";
		};
		class Item5
		{
			className="A3_Structures_F";
			name="Arma 3 - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item6
		{
			className="RELICTA_models";
			name="RELICTA_models";
			author="Yodes and Alien";
		};
		class Item7
		{
			className="ml_exonew";
			name="ml_exonew";
		};
		class Item8
		{
			className="Model_14_10";
			name="Model_14_10";
		};
		class Item9
		{
			className="A3_Structures_F_Enoch_Military";
			name="Arma 3 Contact Platform - Military Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item10
		{
			className="A3_Structures_F_Enoch_Infrastructure";
			name="Arma 3 Contact Platform - Infrastructure Objects";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item11
		{
			className="A3_Structures_F_Heli";
			name="Arma 3 Helicopters - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item12
		{
			className="exodus";
			name="exodus";
		};
		class Item13
		{
			className="csa_objects";
			name="csa_objects";
		};
		class Item14
		{
			className="ml_objects_heavy";
			name="ml_objects_heavy";
		};
		class Item15
		{
			className="pechka";
			name="pechka";
		};
	};
};
dlcs[]=
{
	"Orange",
	"Enoch",
	"Heli"
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
		items=99;
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
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""missionName"",""Template""],[""version"",4]]}";
			};
			id=2205;
			type="Land_Orange_01_F";
			atlOffset=-1000;
		};
		class Item3
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4009.2629,3.736845,4006.5161};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2206;
			type="block_dirt";
			atlOffset=4.1821022;
		};
		class Item4
		{
			dataType="Layer";
			name="Spawn points";
			class Entities
			{
				items=3;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4015.5652,10.428921,4011.0618};
						angles[]={0,1.5519395,0};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""spawnpointname"",""base""]]],[""class"",""SpawnPoint""]]}";
					};
					id=2207;
					type="VR_3DSelector_01_default_F";
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4027.8918,10.493052,4006.4397};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""spawnpointname"",""latespawn""]]],[""class"",""CollectionSpawnPoint""]]}";
					};
					id=2264;
					type="VR_3DSelector_01_default_F";
					atlOffset=4.4440517;
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4039.718,10.436317,4018.1016};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""spawnpointname"",""latespawn""]]],[""class"",""CollectionSpawnPoint""]]}";
					};
					id=2265;
					type="VR_3DSelector_01_default_F";
					atlOffset=0.01010704;
				};
			};
			id=2208;
			atlOffset=4.3996525;
		};
		class Item5
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4019.7263,3.8143272,4006.4888};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2209;
			type="block_dirt";
			atlOffset=4.2595844;
		};
		class Item6
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4019.7922,3.9282589,4017.324};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2210;
			type="block_dirt";
			atlOffset=4.3735161;
		};
		class Item7
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4009.3057,3.7249336,4017.2202};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2211;
			type="block_dirt";
			atlOffset=4.1701908;
		};
		class Item8
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4020.145,13.516785,3996.8796};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2216;
			type="block_strongstone";
			atlOffset=13.962042;
		};
		class Item9
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4009.6892,13.336245,3997.0313};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2217;
			type="block_strongstone";
			atlOffset=13.781502;
		};
		class Item10
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3999.9924,13.303852,4017.1201};
				angles[]={0,1.5508486,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2218;
			type="block_strongstone";
			atlOffset=13.749109;
		};
		class Item11
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4000.0496,13.484392,4006.6636};
				angles[]={0,1.5508486,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2219;
			type="block_strongstone";
			atlOffset=13.929649;
		};
		class Item12
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4009.7573,13.007811,4026.6423};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2220;
			type="block_strongstone";
			atlOffset=13.453068;
		};
		class Item13
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4020.2131,13.188351,4026.4907};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2221;
			type="block_strongstone";
			atlOffset=13.633608;
		};
		class Item14
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4029.5286,4.0859356,4017.0112};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2222;
			type="block_dirt";
			atlOffset=4.5311928;
		};
		class Item15
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4029.4626,3.9720039,4006.176};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2223;
			type="block_dirt";
			atlOffset=4.4172611;
		};
		class Item16
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4040.0078,3.8394794,4017.1792};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2224;
			type="block_dirt";
			atlOffset=4.2847366;
		};
		class Item17
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4039.844,3.7255478,4007.0559};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2225;
			type="block_dirt";
			atlOffset=4.170805;
		};
		class Item18
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4050.7744,3.7476215,4017.2849};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2226;
			type="block_dirt";
			atlOffset=4.1928787;
		};
		class Item19
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4050.7085,3.6336899,4006.4497};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2227;
			type="block_dirt";
			atlOffset=4.0789471;
		};
		class Item20
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4030.718,13.027681,4026.9443};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2228;
			type="block_strongstone";
			atlOffset=13.472939;
		};
		class Item21
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4041.1738,13.208221,4026.7927};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2229;
			type="block_strongstone";
			atlOffset=13.653479;
		};
		class Item22
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4050.7927,13.224848,3996.7498};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2230;
			type="block_strongstone";
			atlOffset=13.670105;
		};
		class Item23
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4060.5776,13.405388,4006.6272};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2231;
			type="block_strongstone";
			atlOffset=13.850645;
		};
		class Item24
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4030.6458,13.204977,3997.0657};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2232;
			type="block_strongstone";
			atlOffset=13.650234;
		};
		class Item25
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4040.7461,13.385517,3996.8677};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2233;
			type="block_strongstone";
			atlOffset=13.830774;
		};
		class Item26
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4060.5642,13.327511,4017.0647};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2234;
			type="block_strongstone";
			atlOffset=13.772768;
		};
		class Item27
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4051.0994,13.155325,4026.8535};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockStone""]]}";
			};
			id=2235;
			type="block_strongstone";
			atlOffset=13.600582;
		};
		class Item28
		{
			dataType="Layer";
			name="Teleports";
			class Entities
			{
				items=4;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4052.5442,10.153395,4007.6423};
						angles[]={0,4.8494072,0};
					};
					side="Empty";
					flags=1;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""destination"",""tp_box""],[""tdistance"",2]]],[""class"",""TeleportBase""]]}";
					};
					id=2236;
					type="VR_3DSelector_01_exit_F";
					atlOffset=4.1043949;
				};
				class Item1
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4075.1406,10.597769,4044.562};
						angles[]={0,0.71301585,0};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""TeleportExit""],[""mark"",""tp_box""]]}";
					};
					id=2255;
					type="VR_3DSelector_01_incomplete_F";
				};
				class Item2
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4053.6282,10.363226,4016.9871};
						angles[]={0,4.4590077,0};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""TeleportExit""],[""mark"",""tp_main""]]}";
					};
					id=2256;
					type="VR_3DSelector_01_incomplete_F";
				};
				class Item3
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={4072.9949,10.582771,4042.8882};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
						init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""destination"",""tp_main""],[""tdistance"",1.3]]],[""class"",""TeleportBase""]]}";
					};
					id=2257;
					type="VR_3DSelector_01_exit_F";
				};
			};
			id=2237;
			atlOffset=4.4270878;
		};
		class Item29
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4034.4604,14.304686,4002.9182};
				angles[]={0.051552292,2.0554483,4.9593592};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2242;
			type="Lamp_stena";
			atlOffset=3.1958008;
		};
		class Item30
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4006.5452,16.165726,4019.7183};
				angles[]={4.7558427,3.7430396,0.44617239};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2243;
			type="Lamp_stena";
			atlOffset=2.5035534;
		};
		class Item31
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4020.543,14.816598,4020.2986};
				angles[]={1.7649295,0.81308496,1.3080926};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2244;
			type="Lamp_stena";
			atlOffset=1.2361364;
		};
		class Item32
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4011.5098,9.3022509,4007.6921};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2246;
			type="Lamp_stena";
		};
		class Item33
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4018.4189,13.326948,4003.0662};
				angles[]={4.1799498,4.2973509,4.8112416};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2247;
			type="Lamp_stena";
			atlOffset=3.9780283;
		};
		class Item34
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4052.793,11.26955,4007.7793};
				angles[]={1.6209327,0.62673491,0.025529686};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_POINTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2248;
			type="Lamp_stena";
			atlOffset=2.0712767;
		};
		class Item35
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4027.1558,13.176592,4020.7539};
				angles[]={5.9895415,4.9471111,1.3128916};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2249;
			type="Lamp_stena";
			atlOffset=3.5211248;
		};
		class Item36
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4030.1724,13.540081,4011.2371};
				angles[]={0,3.1415927,4.712389};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2250;
			type="Lamp_stena";
			atlOffset=4.0496454;
		};
		class Item37
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.5369,11.677396,4011.1931};
				angles[]={0,3.1415927,4.712389};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2251;
			type="Lamp_stena";
			atlOffset=1.8354568;
		};
		class Item38
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4048.7603,15.003607,4018.9414};
				angles[]={0,3.1415927,4.712389};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2252;
			type="Lamp_stena";
			atlOffset=5.70296;
		};
		class Item39
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4019.8635,14.958392,4010.2983};
				angles[]={0,3.1415927,4.712389};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2253;
			type="Lamp_stena";
			atlOffset=5.5883007;
		};
		class Item40
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4076.4038,4.0126305,4046.9065};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2254;
			type="block_dirt";
			atlOffset=4.4578876;
		};
		class Item41
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4076.8074,11.387918,4037.0466};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2258;
			type="block_dirt";
			atlOffset=11.833176;
		};
		class Item42
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4067.1299,11.813709,4047.1555};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2259;
			type="block_dirt";
			atlOffset=12.258966;
		};
		class Item43
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4086.5649,11.561747,4046.9456};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2260;
			type="block_dirt";
			atlOffset=12.007004;
		};
		class Item44
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4076.8643,11.322624,4056.3093};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BlockDirt""]]}";
			};
			id=2261;
			type="block_dirt";
			atlOffset=11.767881;
		};
		class Item45
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4076.0947,15.826404,4047.1113};
				angles[]={0,3.1415927,4.712389};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2262;
			type="Lamp_stena";
			atlOffset=6.2804861;
		};
		class Item46
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4073.3057,11.02211,4043.0261};
				angles[]={1.6209327,0.62673491,0.025529686};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_POINTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2263;
			type="Lamp_stena";
			atlOffset=1.488719;
		};
		class Item47
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4039.448,12.952989,4018.0806};
				angles[]={4.636734,4.6034603,1.3788218};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2266;
			type="Lamp_stena";
			atlOffset=3.5739689;
		};
		class Item48
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4027.2183,13.332714,4007.0874};
				angles[]={4.6110477,4.4152665,1.4067488};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2267;
			type="Lamp_stena";
			atlOffset=3.8115492;
		};
		class Item49
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4076.876,9.9723301,4049.9531};
				angles[]={6.2594357,3.0793765,6.2431402};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f\civ\camping\campingtable_f.p3d""],[""name"",""Столецкий""]]],[""class"",""IStruct""],[""mark"",""table_box""]]}";
			};
			id=2269;
			type="Land_CampingTable_F";
			atlOffset=4.5607948;
		};
		class Item50
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4077.3252,10.442004,4049.9094};
				angles[]={6.2594342,0,6.2431288};
			};
			side="Empty";
			flags=4;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Candle""],[""mark"",""candle_target""]]}";
			};
			id=2270;
			type="svecha";
			atlOffset=9.3460083e-005;
		};
		class Item51
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.5249,9.4506788,4010.8557};
				angles[]={0.039581537,1.5273144,6.2586708};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f\civ\camping\campingtable_f.p3d""],[""name"",""Столецкий""]]],[""class"",""IStruct""],[""mark"",""table_target""]]}";
			};
			id=2271;
			type="Land_CampingTable_F";
			atlOffset=4.0391436;
		};
		class Item52
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.8176,9.3287601,4010.4861};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Campfire""]]}";
			};
			id=2272;
			type="Land_FirePlace_F";
			atlOffset=4.2804661;
		};
		class Item53
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4015.6863,10.054889,4014.1719};
				angles[]={6.2762542,0,0.015460252};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""HospitalBed""]]}";
			};
			id=2274;
			type="bed2";
			atlOffset=4.4054804;
		};
		class Item54
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.0283,10.051018,4014.2937};
				angles[]={0,6.0509152,0};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ChairLibrary""]]}";
			};
			id=2275;
			type="land_biblastul";
		};
		class Item55
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4036.6121,10.4936,4008.1841};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""name"",""Главный вход""],[""islocked"",true],[""preinit@__keytypesstr"",""keymain;keymaster""]]],[""class"",""SteelGreenDoor""]]}";
			};
			id=2276;
			type="dooor";
			atlOffset=4.1280003;
		};
		class Item56
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4034.9595,10.538957,4007.6965};
				angles[]={0,4.7797236,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2281;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.45802879;
		};
		class Item57
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4038.1438,10.346344,4007.6541};
				angles[]={6.2818742,1.523602,0.089672446};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2283;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.32172966;
		};
		class Item58
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4034.7129,10.565599,4004.803};
				angles[]={0,4.8081198,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""name"",""Задняя дверь""],[""islocked"",true],[""preinit@__keytypesstr"",""keyback;keymaster""]]],[""class"",""SteelGreenDoor""]]}";
			};
			id=2284;
			type="dooor";
			atlOffset=4.1999998;
		};
		class Item59
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4035.3779,10.641748,4006.4221};
				angles[]={0,0.016395248,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2286;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.62635517;
		};
		class Item60
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4035.1162,10.713164,4003.1235};
				angles[]={0.086229309,3.1924055,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2287;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.62112808;
		};
		class Item61
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4038.7769,9.9938974,4005.4172};
				angles[]={0.13704026,6.136929,5.2932539};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ConcretePanel""]]}";
			};
			id=2288;
			type="Land_ConcretePanels_02_single_v1_F";
			atlOffset=0.74007797;
		};
		class Item62
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4038.4592,9.9990149,4001.8645};
				angles[]={5.9838343,0.37624466,5.3175631};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""ConcretePanel""]]}";
			};
			id=2292;
			type="Land_ConcretePanels_02_single_v1_F";
			atlOffset=0.73515511;
		};
		class Item63
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4036.4451,10.665472,4003.0696};
				angles[]={0.086229309,3.1924055,0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2293;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.66302967;
		};
		class Item64
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.894,10.368785,4003.0688};
				angles[]={6.280148,1.5863069,0.086175799};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""BetonTrapeciaSmall""]]}";
			};
			id=2294;
			type="Land_Target_Concrete_Support_01_F";
			atlOffset=0.35857391;
		};
		class Item65
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.1814,9.5164251,4004.3691};
				angles[]={0.039598856,1.5298096,0.038489696};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_heli\furniture\rattantable_01_f.p3d""],[""name"",""Столецкий""]]],[""class"",""IStruct""]]}";
			};
			id=2297;
			type="Land_RattanTable_01_F";
			atlOffset=4.1181593;
		};
		class Item66
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4036.8708,10.267884,4004.0818};
				angles[]={0,5.285491,0};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampKerosene""]]}";
			};
			id=2298;
			type="land_keroslampa";
		};
		class Item67
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.229,9.9181671,4004.448};
				angles[]={0.0051836278,0.90465653,6.2369165};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""name"",""Ключ (универсальный)""],[""preinit@__keytypesstr"",""keymaster""]]],[""class"",""Key""]]}";
			};
			id=2299;
			type="key";
			atlOffset=0.66202736;
		};
		class Item68
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4037.104,9.9221678,4004.491};
				angles[]={0.039584067,0,6.258646};
			};
			side="Empty";
			class Attributes
			{
				init="call{{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""name"",""Ключ от заднего входа""],[""preinit@__keytypesstr"",""keyback""]]],[""class"",""Key""]]}}";
			};
			id=2300;
			type="key";
			atlOffset=0.01049614;
		};
		class Item69
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4035.395,9.6747189,4008.7734};
				angles[]={0.045074072,1.685094,0.031902384};
			};
			side="Empty";
			flags=4;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""a3\structures_f_heli\furniture\rattantable_01_f.p3d""],[""name"",""Столецкий""]]],[""class"",""IStruct""]]}";
			};
			id=2301;
			type="Land_RattanTable_01_F";
		};
		class Item70
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4035.438,10.077168,4008.8159};
				angles[]={0.039584067,0,6.258646};
			};
			side="Empty";
			class Attributes
			{
				init="call{{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""name"",""Ключ от главного входа""],[""preinit@__keytypesstr"",""keymain""]]],[""class"",""Key""]]}}";
			};
			id=2302;
			type="key";
			atlOffset=0.79565907;
		};
		class Item71
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4035.0811,10.425241,4008.5847};
				angles[]={0,6.1944156,0};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampKerosene""]]}";
			};
			id=2303;
			type="land_keroslampa";
		};
		class Item72
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4007.0159,13.500762,4018.8792};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2312;
			type="Land_plita_3x3";
			atlOffset=4.0663843;
		};
		class Item73
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4014.248,12.459641,4015.8723};
				angles[]={6.2762132,4.7038774,6.282105};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""model"",""csa_constr\csa_obj\pod_18x6.p3d""]]],[""class"",""IStruct""]]}";
			};
			id=2317;
			type="Land_pod_18x6";
			atlOffset=3.652092;
		};
		class Item74
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4026.9048,10.789816,4015.7175};
				angles[]={0,4.6781583,-0};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""SteelRustyStairs""]]}";
			};
			id=2320;
			type="stair";
			atlOffset=2.8780355;
		};
		class Item75
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4007.011,15.101948,4020.166};
				angles[]={4.712389,0,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2321;
			type="Land_plita_3x3";
			atlOffset=1.2844696;
		};
		class Item76
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4010.5583,15.094611,4020.1335};
				angles[]={4.712389,0,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatBeton""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2322;
			type="Land_plita_3x3";
			atlOffset=1.2844696;
		};
		class Item77
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4010.5632,13.493425,4018.8467};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatBeton""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2323;
			type="Land_plita_3x3";
			atlOffset=4.0793858;
		};
		class Item78
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4013.8594,15.037751,4020.1912};
				angles[]={4.712389,0,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatDirt""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2324;
			type="Land_plita_3x3";
			atlOffset=1.2844696;
		};
		class Item79
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4013.8643,13.436565,4018.9043};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatDirt""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2325;
			type="Land_plita_3x3";
			atlOffset=3.9753151;
		};
		class Item80
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.062,15.010247,4020.2554};
				angles[]={4.712389,0,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatWood""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2326;
			type="Land_plita_3x3";
			atlOffset=1.2844696;
		};
		class Item81
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.0669,13.409061,4018.9685};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatWood""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2327;
			type="Land_plita_3x3";
			atlOffset=3.7689877;
		};
		class Item82
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4020.2188,15.021442,4020.2749};
				angles[]={4.712389,0,0};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatMetal""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2328;
			type="Land_plita_3x3";
			atlOffset=1.2844696;
		};
		class Item83
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4020.2236,13.420257,4018.988};
				angles[]={6.2762542,0,6.2775226};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatMetal""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2329;
			type="Land_plita_3x3";
			atlOffset=3.797946;
		};
		class Item84
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4007.3535,15.010734,4012.0273};
				angles[]={1.5707963,3.141655,0.033732206};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatSynt""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2330;
			type="Land_plita_3x3";
			atlOffset=1.2844734;
		};
		class Item85
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4007.3052,13.409548,4013.313};
				angles[]={0.0067352578,3.1078823,0.0058902316};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatSynt""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2331;
			type="Land_plita_3x3";
			atlOffset=4.0005445;
		};
		class Item86
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4010.7561,13.386095,4013.3872};
				angles[]={0.0067352578,3.1078823,0.0058902316};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatOrganic""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2334;
			type="Land_plita_3x3";
			atlOffset=3.9528427;
		};
		class Item87
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4010.8044,14.987281,4012.1016};
				angles[]={1.5707963,3.141655,0.033732206};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatOrganic""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2335;
			type="Land_plita_3x3";
			atlOffset=1.2844734;
		};
		class Item88
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4014.2478,13.386423,4013.4561};
				angles[]={0.0067352578,3.1078823,0.0058902316};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatFlesh""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2336;
			type="Land_plita_3x3";
			atlOffset=3.9286413;
		};
		class Item89
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4014.2961,14.987609,4012.1704};
				angles[]={1.5707963,3.141655,0.033732206};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatFlesh""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2337;
			type="Land_plita_3x3";
			atlOffset=1.2844734;
		};
		class Item90
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.5969,13.398004,4013.4878};
				angles[]={0.0067352578,3.1078823,0.0058902316};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatPaper""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2338;
			type="Land_plita_3x3";
			atlOffset=3.7869024;
		};
		class Item91
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4017.6453,14.999189,4012.2021};
				angles[]={1.5707963,3.141655,0.033732206};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatPaper""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2339;
			type="Land_plita_3x3";
			atlOffset=1.2844734;
		};
		class Item92
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4021.1165,13.421672,4013.572};
				angles[]={0.0067352578,3.1078823,0.0058902316};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatCloth""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2340;
			type="Land_plita_3x3";
			atlOffset=3.7858934;
		};
		class Item93
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4021.1648,15.022858,4012.2864};
				angles[]={1.5707963,3.141655,0.033732206};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatCloth""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2341;
			type="Land_plita_3x3";
			atlOffset=1.2844734;
		};
		class Item94
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4023.5146,13.433048,4018.2161};
				angles[]={6.277411,1.5519922,0.0068094349};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatGlass""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2342;
			type="Land_plita_3x3";
			atlOffset=3.7752686;
		};
		class Item95
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4024.8027,15.034234,4018.2466};
				angles[]={4.7124152,0.00012896258,1.5519924};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""material"",""MatGlass""]]],[""class"",""Struct_DebugMaterial__""]]}";
			};
			id=2343;
			type="Land_plita_3x3";
			atlOffset=1.2844687;
		};
		class Item96
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4018.5571,12.979201,4014.7854};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""light"",""SLIGHT_STREET_LAMP_DORM""]]],[""class"",""SmallStoveGrill""]]}";
			};
			id=2352;
			type="pechka";
			atlOffset=2.9057827;
		};
		class Item97
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4008.7188,13.053578,4015.6794};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""light"",""SLIGHT_STREET_LAMP_DORM""]]],[""class"",""SmallStoveGrill""]]}";
			};
			id=2353;
			type="pechka";
			atlOffset=3.1775961;
		};
		class Item98
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={4019.145,12.935365,4018.2207};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""light"",""SLIGHT_STREET_LAMP_DORM""]]],[""class"",""SmallStoveGrill""]]}";
			};
			id=2354;
			type="pechka";
			atlOffset=2.8583755;
		};
	};
};
