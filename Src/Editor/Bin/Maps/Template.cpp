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
		nextID=2272;
	};
	class LayerIndexProvider
	{
		nextID=201;
	};
	class Camera
	{
		pos[]={4000.2576,27.623446,4010.303};
		dir[]={0.84787488,-0.52936733,0.030066406};
		up[]={0.52903807,0.84839094,0.018760435};
		aside[]={0.035438851,8.1659891e-008,-0.99938339};
	};
};
binarizationWanted=0;
sourceName="relicta";
addons[]=
{
	"A3_Characters_F",
	"A3_Props_F_Orange_Humanitarian_Supplies",
	"cba_xeh",
	"rel_vox",
	"A3_Structures_F_Bootcamp_VR_Helpers",
	"AtmObjects",
	"A3_Structures_F_Civ_Camping",
	"RELICTA_models"
};
class AddonsMetaData
{
	class List
	{
		items=7;
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
	};
};
dlcs[]=
{
	"Orange"
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
		items=52;
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
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""layer_nameToPtr"",createHashMapFromArray[[""Spawn points"",2208],[""Teleports"",2237]]],[""missionName"",""Template""],[""version"",2],[""layer_ptrToName"",createHashMapFromArray[[2208,""Spawn points""],[2237,""Teleports""]]]]}";
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
						angles[]={0,1.5519395,-0};
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
					atlOffset=4.4440527;
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
				angles[]={0,1.5508486,-0};
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
				angles[]={0,1.5508486,-0};
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
						angles[]={0,4.8494072,-0};
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
						angles[]={0,0.71301585,-0};
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
						angles[]={0,4.4590077,-0};
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
				angles[]={1.0253149,1.0294688,5.2023082};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[[""edreqpower"",0],[""light"",""SLIGHT_TEMPLATE_DIRECTLIGHT""]]],[""class"",""LampWall""]]}";
			};
			id=2242;
			type="Lamp_stena";
			atlOffset=4.7537527;
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
			atlOffset=6.877697;
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
			atlOffset=5.3418465;
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
	};
};
