__metaInfo__ = 'Builded on editor version: 1.14-path.3';__metaInfoVersion__ = 4;go_editor_globalRefs = createHashMap;

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
_4011_387453934_407238_72868 = ['LampWall',[4011.39,3934.41,13.7134,true],[-0.550381,0.203735,-0.809674],[-0.28107,-0.958379,-0.0500938], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4011_509774007_692144_30183 = ['LampWall',[4011.51,4007.69,4.30183],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4018_365484002_925058_34225 = ['LampWall',[4018.37,4002.93,13.3269,true],[-0.0903129,-0.579884,-0.809678],[0.995118,-0.08503,-0.0500995], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4052_792974007_779306_28485 = ['LampWall',[4052.79,4007.78,11.2696,true],92.5038,[-0.0255269,0.998418,-0.050099], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_POINTLIGHT_var];}] call InitStruct; 
_4027_155764020_753918_18947 = ['LampWall',[4027.16,4020.75,13.1766,true],[-0.248061,0.494812,-0.832842],[-0.966927,-0.0738237,0.244138], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4030_172364011_237068_56621 = ['LampWall',[4030.17,4011.24,13.5401,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4037_536874011_193126_70353 = ['LampWall',[4037.54,4011.19,11.6774,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4018_212403961_056408_66822 = ['LampWall',[4018.21,3961.06,13.6421,true],[-0.981406,0.191945,9.63596e-009],[-0.191945,-0.981406,1.17031e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4019_863534010_298349_98452 = ['LampWall',[4019.86,4010.3,14.9584,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
['BlockDirt',[4076.4,4046.91,4.45789],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4076.81,4037.05,11.8332],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4067.13,4047.16,12.259],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4086.56,4046.95,12.007],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4076.86,4056.31,11.7679],0,[0,0,1]] call InitDecor; 
_4076_094734047_1113310_85253 = ['LampWall',[4076.09,4047.11,15.8264,true],[-1.04251e-015,-1,8.74228e-008],[1,0,1.19249e-008], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
_4073_305664043_026126_03741 = ['LampWall',[4073.31,4043.03,11.0221,true],92.5038,[-0.0255269,0.998418,-0.050099], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_POINTLIGHT_var];}] call InitStruct; 
_4019_154053970_360846_61759 = ['LampWall',[4019.15,3970.36,11.5915,true],[0.999397,-0.00219717,-0.0346479],[0.00169832,0.999895,-0.0144206], {_thisObj setvariable ['light',SLIGHT_TEMPLATE_DIRECTLIGHT_var];}] call InitStruct; 
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
_4035_430914008_929445_07424 = ['Key',[4035.43,4008.93,10.0772,true],0,[0.0245368,0.0395618,0.998916], {_thisObj setvariable ['preinit@__keytypesstr',"keymain"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['LampKerosene',[4034.98,4008.49,5.07318],354.914,[0,0,1]] call InitItem; 
['Struct_DebugMaterial__',[4012.44,3920.85,12.3975,true],271.564,[0.00707365,0.00547057,0.99996]] call InitStruct; 
_4015_640383927_993906_85391 = ['IStruct',[4015.64,3927.99,11.3564,true],181.077,[0.00698782,0.000890776,0.999975], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelRustyStairs',[4016.14,3940.64,1.77481],179.603,[0,0,1]] call InitStruct; 
['Struct_DebugMaterial__',[4011.15,3920.88,13.9987,true],[3.28912e-009,1.3238e-007,1],[0.999627,-0.0272955,3.25496e-010]] call InitStruct; 
_4011_279793924_421638_99115 = ['Struct_DebugMaterial__',[4011.28,3924.42,13.9914,true],[3.28912e-009,1.3238e-007,1],[0.999627,-0.0272955,3.25496e-010]] call InitStruct; 
_4012_566413924_391607_23487 = ['Struct_DebugMaterial__',[4012.57,3924.39,12.3902,true],271.564,[0.00707365,0.00547057,0.99996]] call InitStruct; 
_4011_311773927_723398_93429 = ['Struct_DebugMaterial__',[4011.31,3927.72,13.9345,true],[3.28912e-009,1.3238e-007,1],[0.999627,-0.0272955,3.25496e-010]] call InitStruct; 
_4012_598143927_693857_17801 = ['Struct_DebugMaterial__',[4012.6,3927.69,12.3333,true],271.564,[0.00707365,0.00547057,0.99996]] call InitStruct; 
_4011_336183930_926278_90679 = ['Struct_DebugMaterial__',[4011.34,3930.93,13.907,true],[3.28912e-009,1.3238e-007,1],[0.999627,-0.0272955,3.25496e-010]] call InitStruct; 
_4012_622073930_897227_15050 = ['Struct_DebugMaterial__',[4012.62,3930.9,12.3058,true],271.564,[0.00707365,0.00547057,0.99996]] call InitStruct; 
_4011_401863934_082528_91799 = ['Struct_DebugMaterial__',[4011.4,3934.08,13.9182,true],[3.28912e-009,1.3238e-007,1],[0.999627,-0.0272955,3.25496e-010]] call InitStruct; 
_4012_688963934_052737_16170 = ['Struct_DebugMaterial__',[4012.69,3934.05,12.317,true],271.564,[0.00707365,0.00547057,0.99996]] call InitStruct; 
_4019_294923920_997568_90728 = ['Struct_DebugMaterial__',[4019.29,3921,13.9075,true],[4.69226e-007,-7.2466e-005,1],[-0.999979,-0.00643161,3.14353e-009]] call InitStruct; 
_4018_009033920_983407_15099 = ['Struct_DebugMaterial__',[4018.01,3920.98,12.3063,true],89.6322,[-0.00689436,-0.00570072,0.99996]] call InitStruct; 
_4018_027593924_435067_12754 = ['Struct_DebugMaterial__',[4018.03,3924.44,12.2829,true],89.6322,[-0.00689436,-0.00570072,0.99996]] call InitStruct; 
_4019_315673924_449958_88382 = ['Struct_DebugMaterial__',[4019.32,3924.45,13.8841,true],[4.69226e-007,-7.2466e-005,1],[-0.999979,-0.00643161,3.14353e-009]] call InitStruct; 
_4018_055183927_927257_12787 = ['Struct_DebugMaterial__',[4018.06,3927.93,12.2832,true],89.6322,[-0.00689436,-0.00570072,0.99996]] call InitStruct; 
_4019_342293927_940928_88415 = ['Struct_DebugMaterial__',[4019.34,3927.94,13.8844,true],[4.69226e-007,-7.2466e-005,1],[-0.999979,-0.00643161,3.14353e-009]] call InitStruct; 
_4018_114993931_276617_13945 = ['Struct_DebugMaterial__',[4018.11,3931.28,12.2948,true],89.6322,[-0.00689436,-0.00570072,0.99996]] call InitStruct; 
_4019_401373931_289318_89573 = ['Struct_DebugMaterial__',[4019.4,3931.29,13.896,true],[4.69226e-007,-7.2466e-005,1],[-0.999979,-0.00643161,3.14353e-009]] call InitStruct; 
_4018_126953934_797367_16311 = ['Struct_DebugMaterial__',[4018.13,3934.8,12.3184,true],89.6322,[-0.00689436,-0.00570072,0.99996]] call InitStruct; 
_4019_412843934_810558_91940 = ['Struct_DebugMaterial__',[4019.41,3934.81,13.9196,true],[4.69226e-007,-7.2466e-005,1],[-0.999979,-0.00643161,3.14353e-009]] call InitStruct; 
_4013_550053937_320317_17449 = ['Struct_DebugMaterial__',[4013.55,3937.32,12.3298,true],0.488543,[0.00557879,-0.00695958,0.99996]] call InitStruct; 
_4013_554693938_609628_93078 = ['Struct_DebugMaterial__',[4013.55,3938.61,13.931,true],[0.00010068,1.06473e-006,1],[-0.00848736,-0.999964,1.9192e-006]] call InitStruct; 
['SmallStoveGrill',[4016.84,3932.27,6.26683],271.564,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var];}] call InitStruct; 
['SmallStoveGrill',[4015.68,3922.46,6.34121],271.564,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var];}] call InitStruct; 
['SmallStoveGrill',[4013.43,3932.95,6.22299],271.564,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var];}] call InitStruct; 
_3995_750493947_491462_62894 = ['IStruct',[3995.75,3947.49,7.80345,true],0,[0.00566557,-0.00693192,0.99996], {_thisObj setvariable ['model','a3\props_f_exp\infrastructure\traffic\vergerock_01_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3995_705573948_096922_63359 = ['IStruct',[3995.71,3948.1,7.64089,true],0,[0.00566557,-0.00693192,0.99996], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_02_1m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallPileOfConcreteFragments',[3998.84,3949.12,7.90119,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[4031.91,4009.77,8.20142,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['MediumStoneHouseRuins',[4026.77,4016.45,5.41418],0,[0,0,1]] call InitDecor; 
_4030_869384005_106204_52781 = ['MediumStoneHouseRuins',[4030.87,4005.11,4.52781],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\commercial\market\woodenshelter_01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TreeRoots1',[4012.72,3963.27,0.430415],101.066,[0,0,1]] call InitStruct; 
['TreeRoots2',[4007.34,3945.8,1.91884],0,[0,0,1]] call InitStruct; 
['TreeRootsNoGeom',[4016.47,3966.06,2.73867],101.066,[0,0,1]] call InitStruct; 
_4003_656253965_768802_80272 = ['MetalAndConcreteRuins',[4003.66,3965.77,2.80272],101.066,[0,0,1], {_thisObj setvariable ['model','ca\structures\misc\misc_woodpile\misc_woodpile.p3d'];}] call InitStruct; // !!! realocated model !!!
['TestShotgun',[4015.07,3921.52,12.3637,true],271.564,[0.00699163,0.000901551,0.999975]] call InitItem; 
['TestRifle',[4014.29,3920.38,12.3701,true],271.564,[0.00699163,0.000901551,0.999975]] call InitItem; 
['TestPistol',[4015.03,3920.5,12.4363,true],271.564,[0.00699163,0.000901551,0.999975]] call InitItem; 
['WoodenDoor',[3997.04,3960.36,2.84591],0,[0,0,1]] call InitStruct; 
['Bandage',[4011.37,3967.57,2.83049],101.066,[0,0,1]] call InitItem; 
['BodyPart',[4010.15,3967.53,2.83159],101.066,[0,0,1]] call InitItem; 
['Forceps',[4010.33,3968.04,2.83224],101.066,[0,0,1]] call InitItem; 
['FryingPan',[4009.78,3967.92,2.83295],101.066,[0,0,1]] call InitItem; 
['Polovnik',[4009.58,3967.47,2.83337],101.066,[0,0,1]] call InitItem; 
['Lockpick',[4009.4,3968.24,2.83373],101.066,[0,0,1]] call InitItem; 
['Baseballbat',[4009.8,3968.46,2.8331],101.066,[0,0,1]] call InitItem; 
['Baton',[4010.9,3967.19,2.83244],101.066,[0,0,1]] call InitItem; 
['Scepter',[4010.35,3966.92,2.83273],101.066,[0,0,1]] call InitItem; 
['CombatKnife',[4010.46,3968.79,2.83241],101.066,[0,0,1]] call InitItem; 
['GMPreyDaggerKnife',[4011.31,3968.59,2.83305],101.066,[0,0,1]] call InitItem; 
['KitchenKnife',[4010.85,3969.19,2.83183],101.066,[0,0,1]] call InitItem; 
['HalfHandedSword',[4012.01,3968.65,2.83128],101.066,[0,0,1]] call InitItem; 
['ShortSword',[4011.97,3968.26,2.83071],101.066,[0,0,1]] call InitItem; 
['SwordScimitar',[4010.81,3968.91,2.83109],101.066,[0,0,1]] call InitItem; 
['TwoHandedSword',[4012,3969.02,2.83065],101.066,[0,0,1]] call InitItem; 
['PenBlack',[4012.05,3969.25,2.83102],101.066,[0,0,1]] call InitItem; 
['BarChair',[4010.79,3968.47,8.22661,true],101.066,[0.0330653,0.0327462,0.998917]] call InitItem; 
['Brain',[4008.39,3968.68,2.83447],101.066,[0,0,1]] call InitItem; 
['Pestik',[4008.54,3968.97,2.83408],101.066,[0,0,1]] call InitItem; 
['CetalinBox',[4008.77,3968.58,2.83407],101.066,[0,0,1]] call InitItem; 
['SmallBattery',[4009.07,3969.5,2.8338],101.066,[0,0,1]] call InitItem; 
['Tooth',[4008.72,3970.03,2.83316],101.066,[0,0,1]] call InitItem; 
['Stethoscope',[4008.67,3970.34,2.8334],101.066,[0,0,1]] call InitItem; 
['PistolHandmade',[4007.9,3970.15,7.90989,true],101.066,[0.0330653,0.0327462,0.998917]] call InitItem; 
['Revolver',[4006.44,3970.93,2.83911],101.066,[0,0,1]] call InitItem; 
['RifleAuto',[4006.95,3971.06,7.91871,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['RifleBastard',[4006.41,3971.51,7.91562,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['RifleFinisher',[4006.82,3970.27,7.92423,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['Shotgun',[4006.43,3969.49,7.83655,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['WoodenBucket',[4008.03,3970.89,8.15155,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['ChemBowl',[4007.71,3970.94,2.83709],101.066,[0,0,1]] call InitItem; 
['Cup',[4005.25,3970.69,2.8365],101.066,[0,0,1]] call InitItem; 
['SoupPlate',[4008.16,3971.02,2.83642],101.066,[0,0,1]] call InitItem; 
['Syringe',[4008.23,3970.76,2.83624],101.066,[0,0,1]] call InitItem; 
['SawedOff',[4005.76,3970.81,2.83983],101.066,[0,0,1]] call InitItem; 
['PaperHolder',[4005.67,3971.14,2.84033],101.066,[0,0,1]] call InitItem; 
['Book',[4004.98,3971,2.84137],101.066,[0,0,1]] call InitItem; 
['Paper',[4005.06,3970.11,2.84036],101.066,[0,0,1]] call InitItem; 
['Bread',[4005.33,3971.41,2.84093],101.066,[0,0,1]] call InitItem; 
['Tea',[4005.82,3972.23,2.84039],101.066,[0,0,1]] call InitItem; 
['Shavirma',[4005.63,3972.16,2.84066],101.066,[0,0,1]] call InitItem; 
['Poo',[4005.84,3971.99,2.8403],101.066,[0,0,1]] call InitItem; 
['Pill',[4005.61,3971.78,2.8492],101.066,[0,0,1]] call InitItem; 
['PiePiece',[4005.26,3972.49,2.84072],101.066,[0,0,1]] call InitItem; 
['Pie',[4005.44,3972.46,2.84065],101.066,[0,0,1]] call InitItem; 
['Pancakes',[4005.13,3971.92,2.84111],101.066,[0,0,1]] call InitItem; 
['Omlet',[4006.2,3971.94,2.84091],101.066,[0,0,1]] call InitItem; 
['Gnilokornik',[4007.37,3972.18,8.44591,true],101.066,[-0.000322256,0.00678436,0.999977]] call InitItem; 
['Yaichnik',[4007.77,3972.39,7.94995,true],101.066,[0.0330653,0.0327462,0.998917]] call InitItem; 
['Forceps',[3994.8,3948.93,7.66426,true],[0,0.998949,0.0458355],[-0.613355,-0.0362012,0.788978]] call InitItem; 
['Crutch',[3994.77,3949.06,7.82306,true],[0,0.998949,0.0458355],[-0.613355,-0.0362012,0.788978]] call InitItem; 
['ChemDistiller',[3994.27,3949.03,8.00351,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['Bone',[3994.41,3948.5,2.70052],0,[0,0,1]] call InitItem; 
['Body',[3994.84,3947.96,2.66193],0,[0,0,1]] call InitItem; 
['Rag',[3995.03,3948.53,7.66751,true],[0,0.73204,0.681262],[-0.613355,-0.538066,0.578171]] call InitItem; 
['AmmoBoxPistolHandmade',[3994.47,3949.28,8.13407,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['AmmoBoxRifle',[3994.07,3950.06,7.77205,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['AmmoBoxPBMNonLethal',[3994.69,3949.57,7.72195,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['OrangeCapet',[4084.96,4046.52,12.0347],0,[0,0,1]] call InitStruct; 
['RedCarpet',[4088,4042.76,12.0351],0,[0,0,1]] call InitStruct; 
['CoinBag',[4083.89,4044.21,17.1454,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['AbbatCloth',[4084.45,4043.24,12.04],0,[0,0,1]] call InitItem; 
['HatUshanka',[4085.38,4044.04,12.0388],0,[0,0,1]] call InitItem; 
['NomadCloth1',[4083.42,4043.09,12.037],0,[0,0,1]] call InitItem; 
['WoolCoat',[4082.74,4042.56,12.0398],0,[0,0,1]] call InitItem; 
['ArmorCityNew',[4085.1,4041.93,12.0421],0,[0,0,1]] call InitItem; 
['Briefcase',[4087.92,4048.39,12.032],0,[0,0,1]] call InitItem; 
['Suitcase',[4084.36,4045.88,12.036],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4086.5,4042.85,17.137,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['BedOld',[4010.8,3970.87,2.7989],1.30342,[0,0,1]] call InitStruct; 
['BrownOldSofa',[4013.62,3971.53,2.7989],1.30342,[0,0,1]] call InitStruct; 
['CoolSofa',[4013.98,3969.48,2.7989],1.30342,[0,0,1]] call InitStruct; 
['RedSofa',[4013.09,3967.49,2.7989],1.30342,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4009.37,3970.96,2.7989],1.30342,[0,0,1]] call InitStruct; 
['SmallRoundWoodenTable1',[4011.16,3968.49,2.7989],1.30342,[0,0,1]] call InitStruct; 
['SmallRoundWoodenTable',[4009.27,3968.97,2.7989],1.30342,[0,0,1]] call InitStruct; 
['SurgeryBlueTable',[4010.24,3968.21,2.7989],1.30342,[0,0,1]] call InitStruct; 
['TinyWoodenTable',[4009.44,3964.19,2.7989],1.30342,[0,0,1]] call InitStruct; 
['WoodenOfficeTable2',[4010.91,3963.86,2.7989],1.30342,[0,0,1]] call InitStruct; 
['WoodenTableHandmade',[4009.93,3965.24,2.7989],1.30342,[0,0,1]] call InitStruct; 
['Workbench',[4009.34,3963.27,2.7989],1.30342,[0,0,1]] call InitStruct; 
['LuxuryDoubleBed',[4006.62,3964.92,2.7989],1.30342,[0,0,1]] call InitStruct; 
['HospitalBedWheels',[4008.43,3966.38,2.7989],1.30342,[0,0,1]] call InitStruct; 
['HospitalBed',[4003.57,3965.98,2.7989],1.30342,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[4006.25,3959.89,2.7989],1.30342,[0,0,1]] call InitStruct; 
['DoubleCitizenBed',[4005.08,3962.51,2.7989],1.30342,[0,0,1]] call InitStruct; 
['BrownLeatherChair',[4006.71,3957.86,2.7989],1.30342,[0,0,1]] call InitStruct; 
['GreenBed',[4006.2,3959.46,2.7989],1.30342,[0,0,1]] call InitStruct; 
['MediumWoodenWall',[3993.98,3956.14,2.92961],84.0118,[0,0,1]] call InitStruct; 
['MediumWoodenWall',[3993.86,3958.72,2.9191],266.991,[0,0,1]] call InitStruct; 
['MediumWoodenWall',[3995.27,3954.93,2.9367],357.451,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3995.81,3956.63,5.67015],0,[0,0,1]] call InitStruct; 
['MediumWoodenWall',[3998.15,3955.02,3.09238],357.451,[0,0,1]] call InitStruct; 
['WoodenSmallFence',[3998.8,3960.33,3.4001],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[3996.03,3959.19,8.38806,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['WoodenSmallFloor',[3995.89,3956.79,2.66305],0,[0,0,1]] call InitStruct; 
['LongRottenBoards',[4001.05,3955.64,9.21678,true],[0.902262,0.0218368,-0.430634],[0.430737,0,0.902478]] call InitStruct; 
['LongRottenBoards',[4002.99,3922.19,1.98959],21.7915,[0,0,1]] call InitStruct; 
['LongRottenBoards',[4001.56,3918.71,10.792,true],[1.49475e-007,-1.03471e-007,-1],[0.371226,0.928542,-4.05879e-008]] call InitStruct; 
['LongRottenBoards',[3998.19,3920.18,14.3927,true],[0.928542,-0.371226,0.00104493],[0.371226,0.928543,-4.05879e-008]] call InitStruct; 
['LongRottenBoards',[3994.34,3921.72,10.8562,true],[1.49475e-007,-1.03471e-007,-1],[0.371226,0.928542,-4.05879e-008]] call InitStruct; 
['WoodenSmallFloor',[3994.91,3923.3,1.88387],21.7915,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3996.26,3926.54,1.90787],21.7915,[0,0,1]] call InitStruct; 
['MediumWoodenWall',[3996.95,3928.04,2.14657],15.5949,[0,0,1]] call InitStruct; 
['Candle',[4023.95,4031.39,14.5054],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_ATMOS_FIRE_1_var];}] call InitItem; 
['Candle',[4020.5,4031.13,14.5816],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_ATMOS_FIRE_2_var];}] call InitItem; 
['Candle',[4016.26,4031.01,14.333],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_ATMOS_FIRE_3_var];}] call InitItem; 
['BlockStone',[4006.35,3970.29,2.90235],0,[0,0,1]] call InitDecor; 
['BlockStone',[4016.82,3970.52,2.73865],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3989.12,3964.47,3.12283],88.1118,[0,0,1]] call InitDecor; 
['BlockStone',[3996.02,3970.02,3.09295],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3994.36,3976.35,2.83412],179.67,[0,0,1]] call InitDecor; 
['BigStoneWall',[4023.27,3963.82,5.49139],272.74,[0,0,1]] call InitDecor; 
['BigStoneWall',[4013.69,3976.47,3.77553],179.67,[0,0,1]] call InitDecor; 
['BlockStone',[3996.21,3959.34,2.84619],0,[0,0,1]] call InitDecor; 
['BlockStone',[4006.53,3959.6,2.78112],0,[0,0,1]] call InitDecor; 
['BlockStone',[4017.01,3959.84,2.49189],0,[0,0,1]] call InitDecor; 
['BlockStone',[3996.44,3938.2,2.36631],0,[0,0,1]] call InitDecor; 
['BlockStone',[4006.77,3938.46,2.17572],0,[0,0,1]] call InitDecor; 
['BlockStone',[4017.24,3938.69,2.01201],0,[0,0,1]] call InitDecor; 
['BlockStone',[3996.26,3948.88,2.61307],0,[0,0,1]] call InitDecor; 
['BlockStone',[4006.58,3949.15,2.42247],0,[0,0,1]] call InitDecor; 
['BlockStone',[4017.06,3949.38,2.25877],0,[0,0,1]] call InitDecor; 
['BlockStone',[3996.71,3916.79,1.82572],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007.03,3917.06,1.63512],0,[0,0,1]] call InitDecor; 
['BlockStone',[4017.51,3917.29,1.47142],0,[0,0,1]] call InitDecor; 
['BlockStone',[3996.52,3927.48,2.07247],0,[0,0,1]] call InitDecor; 
['BlockStone',[4006.85,3927.74,1.88188],0,[0,0,1]] call InitDecor; 
['BlockStone',[4017.32,3927.98,1.71817],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3989.86,3924.88,1.97363],90.7785,[0,0,1]] call InitDecor; 
['BigStoneWall',[3990.12,3944.2,2.91504],90.7785,[0,0,1]] call InitDecor; 
['BigStoneWall',[4023.09,3944.71,5.11102],271.026,[0,0,1]] call InitDecor; 
['BigStoneWall',[4022.75,3925.38,6.05243],271.026,[0,0,1]] call InitDecor; 
['BigStoneWall',[4016.26,3913.02,5.3313],1.1774,[0,0,1]] call InitDecor; 
['BigStoneWall',[3996.94,3913.41,6.27271],1.1774,[0,0,1]] call InitDecor; 
['MediumWoodenWall',[3995.1,3960.17,2.94268],353.803,[0,0,1]] call InitStruct; 
['Campfire',[4009.54,3959.19,8.03733,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['Campfire',[4005.19,3950.16,7.57013,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['Campfire',[4004.82,3933.9,7.30728,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['BrickThinWall',[4014.29,3918.14,8.07354,true],271.501,[0.000849549,-0.00702072,0.999975]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4017.49,3921.3,8.07725,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['BrickThinWall',[4014.25,3918.27,10.1142,true],271.501,[0.000849549,-0.00702072,0.999975]] call InitStruct; 
['BrickThinWall',[4017.54,3921.5,10.5,true],359.622,[-0.00698694,-0.00106839,0.999975]] call InitStruct; 
['ConcreteGreenSmallFloor',[4016,3917.12,6.06905],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[4020.68,3917.57,6.19916],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[4019.84,3920,6.33359],0,[0,0,1]] call InitStruct; 



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
if (!isNil'_4011_387453934_407238_72868') then {
	_4011_387453934_407238_72868 setvariable ['edreqpower',0];
};
if (!isNil'_4011_509774007_692144_30183') then {
	_4011_509774007_692144_30183 setvariable ['edreqpower',0];
};
if (!isNil'_4018_365484002_925058_34225') then {
	_4018_365484002_925058_34225 setvariable ['edreqpower',0];
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
if (!isNil'_4018_212403961_056408_66822') then {
	_4018_212403961_056408_66822 setvariable ['edreqpower',0];
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
if (!isNil'_4019_154053970_360846_61759') then {
	_4019_154053970_360846_61759 setvariable ['edreqpower',0];
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
if (!isNil'_4035_430914008_929445_07424') then {
	_4035_430914008_929445_07424 setvariable ['name',"Ключ от главного входа"];
};
if (!isNil'_4011_279793924_421638_99115') then {
	_4011_279793924_421638_99115 setvariable ['material',"MatBeton"];
};
if (!isNil'_4012_566413924_391607_23487') then {
	_4012_566413924_391607_23487 setvariable ['material',"MatBeton"];
};
if (!isNil'_4011_311773927_723398_93429') then {
	_4011_311773927_723398_93429 setvariable ['material',"MatDirt"];
};
if (!isNil'_4012_598143927_693857_17801') then {
	_4012_598143927_693857_17801 setvariable ['material',"MatDirt"];
};
if (!isNil'_4011_336183930_926278_90679') then {
	_4011_336183930_926278_90679 setvariable ['material',"MatWood"];
};
if (!isNil'_4012_622073930_897227_15050') then {
	_4012_622073930_897227_15050 setvariable ['material',"MatWood"];
};
if (!isNil'_4011_401863934_082528_91799') then {
	_4011_401863934_082528_91799 setvariable ['material',"MatMetal"];
};
if (!isNil'_4012_688963934_052737_16170') then {
	_4012_688963934_052737_16170 setvariable ['material',"MatMetal"];
};
if (!isNil'_4019_294923920_997568_90728') then {
	_4019_294923920_997568_90728 setvariable ['material',"MatSynt"];
};
if (!isNil'_4018_009033920_983407_15099') then {
	_4018_009033920_983407_15099 setvariable ['material',"MatSynt"];
};
if (!isNil'_4018_027593924_435067_12754') then {
	_4018_027593924_435067_12754 setvariable ['material',"MatOrganic"];
};
if (!isNil'_4019_315673924_449958_88382') then {
	_4019_315673924_449958_88382 setvariable ['material',"MatOrganic"];
};
if (!isNil'_4018_055183927_927257_12787') then {
	_4018_055183927_927257_12787 setvariable ['material',"MatFlesh"];
};
if (!isNil'_4019_342293927_940928_88415') then {
	_4019_342293927_940928_88415 setvariable ['material',"MatFlesh"];
};
if (!isNil'_4018_114993931_276617_13945') then {
	_4018_114993931_276617_13945 setvariable ['material',"MatPaper"];
};
if (!isNil'_4019_401373931_289318_89573') then {
	_4019_401373931_289318_89573 setvariable ['material',"MatPaper"];
};
if (!isNil'_4018_126953934_797367_16311') then {
	_4018_126953934_797367_16311 setvariable ['material',"MatCloth"];
};
if (!isNil'_4019_412843934_810558_91940') then {
	_4019_412843934_810558_91940 setvariable ['material',"MatCloth"];
};
if (!isNil'_4013_550053937_320317_17449') then {
	_4013_550053937_320317_17449 setvariable ['material',"MatGlass"];
};
if (!isNil'_4013_554693938_609628_93078') then {
	_4013_554693938_609628_93078 setvariable ['material',"MatGlass"];
};
