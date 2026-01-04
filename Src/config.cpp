// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

class CfgPatches
{
    class RELICT
    {
        name = "TEST";
        author = "123aa";
        authorUrl = "";
		version = "1.0";
	};

};

class CfgFunctions
{
    class RELICT 
		{
		class Bootstrap 
			{
				file = "\src";
				/* file = "\rel\bootstrap";
				class preInitClient {postInit  = 1;}; // postInit  preInit */
				//class preInitServer {preInit  = 1;}; //выполнение перед инициализацией объектов на миссии
				class init {postInit  = 1;}; // при запуске миссии после инициализации объектов
			};
		};
};
