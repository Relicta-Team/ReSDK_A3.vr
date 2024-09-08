// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

class CfgPatches
{
    class mdl_loader
    {
        name = "mdl_loader";
        author = "mdl_loader";
		units[] = {};
        weapons[] = {};
        requiredAddons[] = {};
        authorUrl = "";
		version = "1.0";
		requiredVersion = 1.0;
	};

};

// class CfgFunctions
// {
//     class mdl_loader 
// 		{
// 		class initer 
// 			{
// 				file = "\mdl_loader";
// 				class init {postInit  = 1;};
// 			};
// 		};
// };

//own location for hostvm works
class CfgLocationTypes
{
	class CBA_NamespaceDummy
	{
		name="";
		drawStyle="area";
		texture="";
		color[]={0,0,0,0};
		size=0;
		textSize=0;
		shadow=0;
		font="PuristaMedium";
	};
};


class CfgVehicles {

	#include "CfgVehicles.hpp"
};
