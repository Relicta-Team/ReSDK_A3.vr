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
		nextID=2223;
	};
	class LayerIndexProvider
	{
		nextID=203;
	};
	class Camera
	{
		pos[]={3952.603,23.093201,4097.564};
		dir[]={-0.45835817,-0.54751039,-0.70013887};
		up[]={-0.29989773,0.83677799,-0.45809361};
		aside[]={-0.83667731,-5.7368015e-007,0.54774594};
	};
};
binarizationWanted=0;
sourceName="relicta";
addons[]=
{
	"A3_Characters_F",
	"A3_Props_F_Orange_Humanitarian_Supplies",
	"cba_xeh"
};
class AddonsMetaData
{
	class List
	{
		items=2;
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
		items=3;
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
				init="{createHashMapFromArray[[""customProps"",createHashMapFromArray[]],[""missionName"",""SandboxMap""],[""version"",4]]}";
			};
			id=2205;
			type="Land_Orange_01_F";
			atlOffset=-1000;
		};
	};
};
