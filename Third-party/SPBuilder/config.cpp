// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

class CfgPatches
{
    class RELICT_sp
    {
        name = "spmode";
        author = "none";
        authorUrl = "";
		version = "1.0";
	};

};

class CfgFunctions
{
    class RELICT_sp 
		{
		class Bootstrap 
			{
				file = "\sp_mode";
				/* file = "\rel\bootstrap";
				class preInitClient {postInit  = 1;}; // postInit  preInit */
				//class preInitServer {preInit  = 1;}; //выполнение перед инициализацией объектов на миссии
				//class init {postInit  = 1;}; // при запуске миссии после инициализации объектов
			};
		};
};
