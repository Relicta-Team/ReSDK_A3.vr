__metaInfo__ = 'Builded on editor version: 1.14-path.2';__metaInfoVersion__ = 4;go_editor_globalRefs = createHashMap;

reditor_binding_fc = {
private _o = _this deleteAt 0;
private _m = _this deleteAt 0;
if (count _this == 0) then {
((_o) call ((_o) getvariable "proto" getvariable (_m)))
} else {
(([_o]+(_this)) call ((_o) getvariable "proto" getvariable (_m)))
};
};
	reditor_binding_gv = {
private _o = _this deleteAt 0;
private _m = _this deleteAt 0;
((_o) getvariable (_m))
};
	reditor_binding_sv = {
private _o = _this deleteAt 0;
private _m = _this deleteAt 0;
(_o) setvariable [_m,_this]
};
	reditor_binding_gref = {
private _o = _this deleteAt 0;
private _m = _this deleteAt 0;
go_editor_globalRefs getOrDefault [_m,locationnull];
};

['BlockDirt',[4009.26,4006.52,4.1821],0,[0,0,1]] call InitDecor; 
_4015_565194011_061774_37992 = ['SpawnPoint',[4015.57,4011.06,4.37992],88.9196,[0,0,1]] call InitStruct; 
_4027_891854006_439704_44405 = ['CollectionSpawnPoint',[4027.89,4006.44,4.44405],0,[0,0,1]] call InitStruct; 
_4039_718024018_101564_38732 = ['CollectionSpawnPoint',[4039.72,4018.1,4.38732],0,[0,0,1]] call InitStruct; 
['BlockDirt',[4019.73,4006.49,4.25958],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4019.79,4017.32,4.37352],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4009.31,4017.22,4.17019],0,[0,0,1]] call InitDecor; 
['BlockStone',[4020.15,3996.88,13.962],0,[0,0,1]] call InitDecor; 
['BlockStone',[4009.69,3997.03,13.7815],0,[0,0,1]] call InitDecor; 
['BlockStone',[3999.99,4017.12,13.7491],88.8571,[0,0,1]] call InitDecor; 
['BlockStone',[4000.05,4006.66,13.9296],88.8571,[0,0,1]] call InitDecor; 
['BlockStone',[4009.76,4026.64,13.4531],0,[0,0,1]] call InitDecor; 
['BlockStone',[4020.21,4026.49,13.6336],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4029.53,4017.01,4.53119],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4029.46,4006.18,4.41726],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4040.01,4017.18,4.28474],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4039.84,4007.06,4.1708],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4050.77,4017.28,4.19288],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4050.71,4006.45,4.07895],0,[0,0,1]] call InitDecor; 
['BlockStone',[4030.72,4026.94,13.4729],0,[0,0,1]] call InitDecor; 
['BlockStone',[4041.17,4026.79,13.6535],0,[0,0,1]] call InitDecor; 
['BlockStone',[4050.79,3996.75,13.6701],0,[0,0,1]] call InitDecor; 
['BlockStone',[4060.58,4006.63,13.8506],0,[0,0,1]] call InitDecor; 
['BlockStone',[4030.65,3997.07,13.6502],0,[0,0,1]] call InitDecor; 
['BlockStone',[4040.75,3996.87,13.8308],0,[0,0,1]] call InitDecor; 
['BlockStone',[4060.56,4017.06,13.7728],0,[0,0,1]] call InitDecor; 
['BlockStone',[4051.1,4026.85,13.6006],0,[0,0,1]] call InitDecor; 
_4052_544194007_642334_10439 = ['TeleportBase',[4052.54,4007.64,4.10439],277.851,[0,0,1]] call InitStruct; 
['TeleportExit',[4075.14,4044.56,4.54877],40.8528,[0,0,1], {go_editor_globalRefs set ["tp_box",_thisObj];
}] call InitStruct; 
['TeleportExit',[4053.63,4016.99,4.31423],255.482,[0,0,1], {go_editor_globalRefs set ["tp_main",_thisObj];
}] call InitStruct; 
_4072_994874042_888184_53377 = ['TeleportBase',[4072.99,4042.89,4.53377],0,[0,0,1]] call InitStruct; 
_4034_460454002_918219_31756 = ['LampWall',[4034.46,4002.92,14.3047,true],[0.216314,-0.509493,-0.832842],[0.969658,0.0125973,0.244142], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4006_545174019_7182611_18008 = ['LampWall',[4006.55,4019.72,16.1657,true],[-0.510444,0.20812,-0.834346],[-0.431516,-0.901254,0.0391875], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4020_542974020_298589_83190 = ['LampWall',[4020.54,4020.3,14.8166,true],[0.188643,0.555728,-0.809679],[-0.965691,0.254814,-0.0500989], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4011_509774007_692144_30183 = ['LampWall',[4011.51,4007.69,4.30183],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4018_418954003_066168_34225 = ['LampWall',[4018.42,4003.07,13.3269,true],[-0.0903129,-0.579884,-0.809678],[0.995118,-0.08503,-0.0500995], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4052_792974007_779306_28485 = ['LampWall',[4052.79,4007.78,11.2696,true],92.5038,[-0.0255269,0.998418,-0.050099], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_POINTLIGHT_var];}] call InitStruct; 
_4027_155764020_753918_18947 = ['LampWall',[4027.16,4020.75,13.1766,true],[-0.248061,0.494812,-0.832842],[-0.966927,-0.0738237,0.244138], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4030_172364011_237068_56621 = ['LampWall',[4030.17,4011.24,13.5401,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4037_536874011_193126_70353 = ['LampWall',[4037.54,4011.19,11.6774,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4048_760254018_9414110_02974 = ['LampWall',[4048.76,4018.94,15.0036,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4019_863534010_298349_98452 = ['LampWall',[4019.86,4010.3,14.9584,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
['BlockDirt',[4076.4,4046.91,4.45789],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4076.81,4037.05,11.8332],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4067.13,4047.16,12.259],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4086.56,4046.95,12.007],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4076.86,4056.31,11.7679],0,[0,0,1]] call InitDecor; 
_4076_094734047_1113310_85253 = ['LampWall',[4076.09,4047.11,15.8264,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4073_305664043_026126_03741 = ['LampWall',[4073.31,4043.03,11.0221,true],92.5038,[-0.0255269,0.998418,-0.050099], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_POINTLIGHT_var];}] call InitStruct; 
_4039_448004018_080577_97911 = ['LampWall',[4039.45,4018.08,12.953,true],[-0.189667,0.981237,-0.0346478],[-0.981629,-0.190252,-0.014421], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4027_218264007_087408_35834 = ['LampWall',[4027.22,4007.09,13.3327,true],[-0.156157,0.968125,-0.195832],[-0.986574,-0.162475,-0.016522], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4076_875984049_953134_56122 = ['IStruct',[4076.88,4049.95,9.97233,true],176.437,[0.0400344,-0.0237284,0.998917], {_thisObj setvariable ['model','a3\structures_f\civ\camping\campingtable_f.p3d']; go_editor_globalRefs set ["table_box",_thisObj];
}] call InitStruct; // !!! realocated model !!!
['Candle',[4077.33,4049.91,10.442,true],0,[0.0400458,-0.0237298,0.998916], {go_editor_globalRefs set ["candle_target",_thisObj];
}] call InitItem; 
_4037_524904010_855714_03957 = ['IStruct',[4037.52,4010.86,9.45068,true],87.5654,[0.024512,0.0395593,0.998917], {_thisObj setvariable ['model','a3\structures_f\civ\camping\campingtable_f.p3d']; go_editor_globalRefs set ["table_target",_thisObj];
}] call InitStruct; // !!! realocated model !!!
['Campfire',[4017.82,4010.49,9.32876,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['HospitalBed',[4015.69,4014.17,10.0549,true],0,[-0.0154596,-0.00693025,0.999856]] call InitStruct; 
['ChairLibrary',[4017.03,4014.29,4.4526],346.692,[0,0,1]] call InitItem; 
_4036_612064008_184084_12800 = ['SteelGreenDoor',[4036.61,4008.18,4.128],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"keymain;keymaster"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BetonTrapeciaSmall',[4034.96,4007.7,4.78337],273.858,[0,0,1]] call InitStruct; 
['BetonTrapeciaSmall',[4038.14,4007.65,10.3463,true],[0.994873,0.0470595,0.0895144],[-0.0895523,-0.00130586,0.995981]] call InitStruct; 
_4034_712894004_802984_20000 = ['SteelGreenDoor',[4034.71,4004.8,4.2],275.485,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"keyback;keymaster"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BetonTrapeciaSmall',[4035.38,4006.42,4.88616],0.939378,[0,0,1]] call InitStruct; 
['BetonTrapeciaSmall',[4035.12,4003.12,10.7132,true],[-0.0507909,-0.994999,0.0860113],[0,0.0861225,0.996285]] call InitStruct; 
['ConcretePanel',[4038.78,4005.42,9.9939,true],[-0.0799719,0.996692,-0.0144623],[0.835988,0.0749653,0.543602]] call InitStruct; 
['ConcretePanel',[4038.46,4001.86,9.99901,true],[0.209033,0.977802,-0.0144654],[0.822403,-0.16777,0.543605]] call InitStruct; 
['BetonTrapeciaSmall',[4036.45,4003.07,10.6655,true],[-0.0507909,-0.994999,0.0860113],[0,0.0861225,0.996285]] call InitStruct; 
['BetonTrapeciaSmall',[4037.89,4003.07,10.3688,true],[0.996169,-0.0157713,0.0860113],[-0.0860692,-0.003026,0.996285]] call InitStruct; 
_4037_181404004_369144_11875 = ['IStruct',[4037.18,4004.37,9.51643,true],87.5645,[-0.0384802,0.0395592,0.998476], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\rattantable_01_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['LampKerosene',[4036.87,4004.08,4.91473],302.836,[0,0,1]] call InitItem; 
_4037_229004004_448004_91524 = ['Key',[4037.23,4004.45,9.91817,true],51.8121,[0.0462523,0.00517806,0.998916], {_thisObj setvariable ['preinit@__keytypesstr',"keymaster"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
_4037_104004004_490974_91924 = ['Key',[4037.1,4004.49,9.92217,true],0,[0.0245368,0.0395618,0.998916], {_thisObj setvariable ['preinit@__keytypesstr',"keyback"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
_4035_395024008_773444_27704 = ['IStruct',[4035.4,4008.77,9.67472,true],96.4641,[-0.031897,0.0450359,0.998476], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\rattantable_01_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4035_437994008_815925_07424 = ['Key',[4035.44,4008.82,10.0772,true],0,[0.0245368,0.0395618,0.998916], {_thisObj setvariable ['preinit@__keytypesstr',"keymain"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['LampKerosene',[4035.08,4008.58,5.07209],354.914,[0,0,1]] call InitItem; 



if (!isNil'_4015_565194011_061774_37992') then {
	_4015_565194011_061774_37992 setvariable ['spawnpointname',"base"];
};
if (!isNil'_4027_891854006_439704_44405') then {
	_4027_891854006_439704_44405 setvariable ['spawnpointname',"latespawn"];
};
if (!isNil'_4039_718024018_101564_38732') then {
	_4039_718024018_101564_38732 setvariable ['spawnpointname',"latespawn"];
};
if (!isNil'_4052_544194007_642334_10439') then {
	_4052_544194007_642334_10439 setvariable ['destination',"tp_box"];
	_4052_544194007_642334_10439 setvariable ['tdistance',2];
};
if (!isNil'_4072_994874042_888184_53377') then {
	_4072_994874042_888184_53377 setvariable ['destination',"tp_main"];
	_4072_994874042_888184_53377 setvariable ['tdistance',1.3];
};
if (!isNil'_4034_460454002_918219_31756') then {
	_4034_460454002_918219_31756 setvariable ['edreqpower',0];
};
if (!isNil'_4006_545174019_7182611_18008') then {
	_4006_545174019_7182611_18008 setvariable ['edreqpower',0];
};
if (!isNil'_4020_542974020_298589_83190') then {
	_4020_542974020_298589_83190 setvariable ['edreqpower',0];
};
if (!isNil'_4011_509774007_692144_30183') then {
	_4011_509774007_692144_30183 setvariable ['edreqpower',0];
};
if (!isNil'_4018_418954003_066168_34225') then {
	_4018_418954003_066168_34225 setvariable ['edreqpower',0];
};
if (!isNil'_4052_792974007_779306_28485') then {
	_4052_792974007_779306_28485 setvariable ['edreqpower',0];
};
if (!isNil'_4027_155764020_753918_18947') then {
	_4027_155764020_753918_18947 setvariable ['edreqpower',0];
};
if (!isNil'_4030_172364011_237068_56621') then {
	_4030_172364011_237068_56621 setvariable ['edreqpower',0];
};
if (!isNil'_4037_536874011_193126_70353') then {
	_4037_536874011_193126_70353 setvariable ['edreqpower',0];
};
if (!isNil'_4048_760254018_9414110_02974') then {
	_4048_760254018_9414110_02974 setvariable ['edreqpower',0];
};
if (!isNil'_4019_863534010_298349_98452') then {
	_4019_863534010_298349_98452 setvariable ['edreqpower',0];
};
if (!isNil'_4076_094734047_1113310_85253') then {
	_4076_094734047_1113310_85253 setvariable ['edreqpower',0];
};
if (!isNil'_4073_305664043_026126_03741') then {
	_4073_305664043_026126_03741 setvariable ['edreqpower',0];
};
if (!isNil'_4039_448004018_080577_97911') then {
	_4039_448004018_080577_97911 setvariable ['edreqpower',0];
};
if (!isNil'_4027_218264007_087408_35834') then {
	_4027_218264007_087408_35834 setvariable ['edreqpower',0];
};
if (!isNil'_4076_875984049_953134_56122') then {
	_4076_875984049_953134_56122 setvariable ['name',"Столецкий"];
};
if (!isNil'_4037_524904010_855714_03957') then {
	_4037_524904010_855714_03957 setvariable ['name',"Столецкий"];
};
if (!isNil'_4036_612064008_184084_12800') then {
	_4036_612064008_184084_12800 setvariable ['name',"Главный вход"];
	_4036_612064008_184084_12800 setvariable ['islocked',true];
};
if (!isNil'_4034_712894004_802984_20000') then {
	_4034_712894004_802984_20000 setvariable ['name',"Задняя дверь"];
	_4034_712894004_802984_20000 setvariable ['islocked',true];
};
if (!isNil'_4037_181404004_369144_11875') then {
	_4037_181404004_369144_11875 setvariable ['name',"Столецкий"];
};
if (!isNil'_4037_229004004_448004_91524') then {
	_4037_229004004_448004_91524 setvariable ['name',"Ключ (универсальный)"];
};
if (!isNil'_4037_104004004_490974_91924') then {
	_4037_104004004_490974_91924 setvariable ['name',"Ключ от заднего входа"];
};
if (!isNil'_4035_395024008_773444_27704') then {
	_4035_395024008_773444_27704 setvariable ['name',"Столецкий"];
};
if (!isNil'_4035_437994008_815925_07424') then {
	_4035_437994008_815925_07424 setvariable ['name',"Ключ от главного входа"];
};
