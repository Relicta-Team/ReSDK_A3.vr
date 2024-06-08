// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

//internal class for chunk metadata
class(AtmosChunk)
    var(realPos,vec3(0,0,0)); //center pos of chunk
    var(aObj,[]); //atmos objects
    
    func(getLeadObject)
    {
        objParams();
        private _objlist = getSelf(aObj);
        if (count _objlist == 0) exitWith {nullPtr};
        _objlist select 0
    };


endclass

editor_attribute("HiddenClass")
class(AtmosAreaBase) extends(ILightibleStruct)
	var(name,null);
	var(light,-1);
	var(lightIsEnabled,false);
    var(layer,0);

    getterconst_func(canContactOnMob,false);
    getterconst_func(canContactOnObjects,false);

	func(onMobContact)
	{
		objParams_1(_mob);
	};

	func(onObjectContact)
	{
		objParams_1(_obj);
	};

	func(onUpdate)
	{
		objParams();
	};

    func(canActivity)
    {
        objParams();
    };

endclass


class(AtmosAreaFire) extends(AtmosAreaBase)
	var(size,1);//1-3

    getterconst_func(canContactOnMob,true);
    getterconst_func(canContactOnObjects,true);

endclass

class(AtmosAreaSmoke) extends(AtmosAreaBase)
    getterconst_func(canContactOnMob,true);
endclass

class(AtmosAreaMiasm) extends(AtmosAreaBase)
    getterconst_func(canContactOnMob,true);
endclass