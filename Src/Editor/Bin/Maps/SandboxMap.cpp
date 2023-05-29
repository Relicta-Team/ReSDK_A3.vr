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
		nextID=2221;
	};
	class LayerIndexProvider
	{
		nextID=201;
	};
	class Camera
	{
		pos[]={3947.4885,15.737948,4089.7224};
		dir[]={-0.55734462,-0.43850288,-0.70507741};
		up[]={-0.27194223,0.89871144,-0.34402603};
		aside[]={-0.78452229,-5.9753074e-007,0.62014413};
	};
};
binarizationWanted=0;
sourceName="relicta";
addons[]=
{
	"A3_Characters_F",
	"A3_Props_F_Orange_Humanitarian_Supplies",
	"cba_xeh",
	"RELICTA_models",
	"AtmObjects",
	"metro_life_lines",
	"A3_Structures_F_Bootcamp_VR_Blocks",
	"A3_Structures_F_System"
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
			className="RELICTA_models";
			name="RELICTA_models";
			author="Yodes and Alien";
		};
		class Item3
		{
			className="AtmObjects";
			name="AtmObjects";
		};
		class Item4
		{
			className="metro_life_lines";
			name="metro_life_lines";
		};
		class Item5
		{
			className="A3_Structures_F_Bootcamp";
			name="Arma 3 Bootcamp Update - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
		};
		class Item6
		{
			className="A3_Structures_F";
			name="Arma 3 - Buildings and Structures";
			author="Bohemia Interactive";
			url="https://www.arma3.com";
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
		items=9;
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
				init="call{{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""missionName"",""SandboxMap""],[""version"",1]]}}";
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
				position[]={3935.6951,5.664156,4075.8311};
				angles[]={0,5.717155,0};
			};
			side="Empty";
			flags=4;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""PowerGenerator""],[""edConnected"",[""PowerSwitcherBox G:eKDFu0uRU6w""]],[""mark"",""PowerGenerator G:f+0reRSIEgI""]]}";
			};
			id=2207;
			type="controlpanel";
		};
		class Item4
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3941.0979,6.1738658,4066.4739};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""LampCeiling""],[""mark"",""LampCeiling G:4TKC07sOs2E""]]}";
			};
			id=2208;
			type="Lamp_tarelka";
			atlOffset=1.0122437;
		};
		class Item5
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3933.7688,6.6906242,4072.2754};
			};
			side="Empty";
			flags=1;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""PowerSwitcherBox""],[""edConnected"",[""PowerSwitcherBox G:eKDFu0uRU6w (1)""]],[""mark"",""PowerSwitcherBox G:eKDFu0uRU6w""]]}";
			};
			id=2209;
			type="rubilnik_5";
			atlOffset=1.152894;
		};
		class Item6
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3940.5693,5.5377302,4070.3765};
			};
			side="Empty";
			flags=5;
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""PowerSwitcherBox""],[""edConnected"",[""LampCeiling G:4TKC07sOs2E""]],[""mark"",""PowerSwitcherBox G:eKDFu0uRU6w (1)""]]}";
			};
			id=2210;
			type="rubilnik_5";
		};
		class Item7
		{
			dataType="Layer";
			name="MapEffects";
			class Entities
			{
				items=1;
				class Item0
				{
					dataType="Object";
					class PositionInfo
					{
						position[]={3931.531,7,4057.4509};
						angles[]={0,1.2554851,0};
					};
					side="Empty";
					flags=5;
					class Attributes
					{
					};
					id=2213;
					type="Land_VR_Block_02_F";
					class CustomAttributes
					{
						class Attribute0
						{
							property="ObjectMaterialCustom0";
							expression="_this setObjectMaterialGlobal [0,_value]";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="";
								};
							};
						};
						class Attribute1
						{
							property="ObjectTextureCustom0";
							expression="_this setObjectTextureGlobal [0,_value]";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="";
								};
							};
						};
						class Attribute2
						{
							property="ObjectTextureCustom1";
							expression="_this setObjectTextureGlobal [1,_value]";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="#(argb,8,8,3)color(1.0,0.0,0.4,1.0,co)";
								};
							};
						};
						class Attribute3
						{
							property="ObjectMaterialCustom1";
							expression="_this setObjectMaterialGlobal [1,_value]";
							class Value
							{
								class data
								{
									singleType="STRING";
									value="";
								};
							};
						};
						nAttributes=4;
					};
				};
			};
			id=2212;
		};
		class Item8
		{
			dataType="Object";
			class PositionInfo
			{
				position[]={3930.7439,6.4981642,4068.5393};
			};
			side="Empty";
			class Attributes
			{
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""class"",""EffectAsStruct""]]}";
			};
			id=2211;
			type="Land_ClutterCutter_small_F";
			atlOffset=1.4981642;
		};
	};
};
