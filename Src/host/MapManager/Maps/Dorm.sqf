__metaInfo__ = 'Builded on editor version: 1.19';__metaInfoVersion__ = 5;go_editor_globalRefs = createHashMap;

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

['OldGreenToiletBowl',[4046.66,4020.63,30.9902],265,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4046.68,4021.88,30.9902],275,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4046.68,4023.13,30.9902],265,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4048.45,4023.13,30.9902],90.0003,[0,0,1]] call InitStruct; 
_4045_515144022_7897931_02055 = ['Umivalnik',[4045.52,4022.79,31.0205],270,[0,0,1]] call InitStruct; 
_4043_248294022_4292031_02055 = ['Umivalnik',[4043.25,4022.43,31.0205],90,[0,0,1]] call InitStruct; 
_4043_284424023_7231431_02055 = ['Umivalnik',[4043.28,4023.72,31.0205],90,[0,0,1]] call InitStruct; 
_4044_447754020_6936032_09883 = ['Shower',[4044.45,4020.69,32.0988],0,[0,0,1]] call InitStruct; 
['TrashCan',[4048.42,4025.21,30.9652],285,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; go_editor_globalRefs set ["KoldyrTrash",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Paper',[4046.54,4024.47,31.9364],345,[0,0,1]] call InitItem; 
['Paper',[4046.65,4024.59,36.5999,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['Paper',[4046.49,4024.38,36.5989,true],15,[-0.00702907,0.000811577,0.999975]] call InitItem; 
['Paper',[4046.67,4023.41,31.0205],30,[0,0,1]] call InitItem; 
['Paper',[4047.12,4020.34,31.0205],305,[0,0,1]] call InitItem; 
['Paper',[4048.63,4023.3,31.5584],305,[0,0,1]] call InitItem; 
if ((random 1) < 0.3) then {
	['Crowbar',[4046.85,4021.85,36.5869,true],[0.0868239,0.0871559,0.992404],[-0.00759651,0.996195,-0.0868242]] call InitItem; 
};
['WoodenSmallShelf1',[4046.55,4024.52,36.47,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['PaperHolder',[4046.55,4024.22,37.0118,true],0,[-0.0069996,-0.00688752,0.999952]] call InitItem; 
['SmallStoveGrill',[4018,4023.6,30.6938],5.00015,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['SmallStoveGrill',[4018,4024.73,30.7074],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['SmallStoveGrill',[4018,4022.48,30.7116],350,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['BlackSmallStove',[4020.7,4021.59,30.8872],180,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_BAKE" call lightSys_getConfigIdByName];}] call InitStruct; 
['MediumWoodenTable',[4019.43,4020.7,30.8106],270,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4020.48,4027.89,30.8242],90.0061,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4023.14,4027.9,30.8175],85.0061,[0,0,1]] call InitStruct; 
['SofaBrown',[4026.04,4025.47,30.8929],270,[0,0,1]] call InitStruct; 
['StumpChair',[4023.96,4027.5,36.1752,true],265.001,[0.00639512,0.00624495,0.99996]] call InitItem; 
['SmallWoodenTable',[4022.82,4020.65,30.8317],85,[0,0,1]] call InitStruct; 
['Shelves',[4025.48,4028.94,30.9652],0,[0,0,1]] call InitStruct; 
['StripedChair',[4020.47,4026.38,30.8394],0,[0,0,1]] call InitItem; 
['WoodenChair',[4019.69,4027.44,30.8171],269.998,[0,0,1]] call InitItem; 
['WoodenChair',[4021.09,4027.41,30.8255],94.9982,[0,0,1]] call InitItem; 
['WoodenChair',[4021.11,4028.51,30.8467],74.9982,[0,0,1]] call InitItem; 
['WoodenChair',[4023.21,4026.57,30.8571],169.998,[0,0,1]] call InitItem; 
['WoodenChair',[4022.45,4028.51,30.8048],269.998,[0,0,1]] call InitItem; 
['ChairLibrary',[4023.97,4028.63,30.8547],350,[0,0,1]] call InitItem; 
_4017_911874028_2924832_41013 = ['RedSteelBox',[4017.91,4028.29,32.4101],85,[0,0,1]] call InitStruct; 
_4017_999274026_5935130_85009 = ['BoardWoodenBox',[4018,4026.59,30.8501],355,[0,0,1]] call InitStruct; 
_4018_009774025_5427230_83516 = ['CaseBedroomSmall',[4018.01,4025.54,30.8352],180,[0,0,1]] call InitStruct; 
_4018_027594027_5227130_86050 = ['CaseBedroomSmall',[4018.03,4027.52,30.8605],180,[0,0,1]] call InitStruct; 
_4026_811774028_2036131_82085 = ['WallmountedMedicalCabinet',[4026.81,4028.2,31.8209],90,[0,0,1]] call InitStruct; 
['MeatGrinder',[4020.11,4020.51,31.6492],265,[0,0,1]] call InitStruct; 
['MeatGrinder',[4023.26,4020.61,31.6677],255.001,[0,0,1]] call InitStruct; 
_4017_960214028_3176330_85656 = ['SteelGreenCabinet',[4017.96,4028.32,30.8566],0,[0,0,1]] call InitStruct; 
['FryingPan',[4021.27,4021.01,31.6128],145,[0,0,1]] call InitItem; 
['ContainerGreen',[4019.71,4020.91,36.1304,true],[-0.996195,9.65599e-07,0.0871556],[0.0871556,0,0.996195], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CandleDisabled',[4023.15,4027.95,31.6959],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4020.53,4027.96,31.7045],0,[0,0,1]] call InitItem; 
['Umivalnik',[4023.42,4022.58,30.8611],275,[0,0,1]] call InitStruct; 
['Scales',[4018.8,4020.64,31.645],100,[0,0,1]] call InitStruct; 
['SmallChair',[4019.74,4028.6,30.8599],279.998,[0,0,1]] call InitItem; 
['SmallRedseatChair',[4022.47,4027.29,30.8659],249.998,[0,0,1]] call InitItem; 
['MatchBox',[4019.49,4021.14,31.6642],330,[0,0,1]] call InitItem; 
['KitchenKnife',[4018.07,4025.56,36.402,true],[-0.766707,0.641998,1.04215e-06],[-0.641982,-0.766688,-0.00699091]] call InitItem; 
['MetalCup',[4017.84,4027.49,31.4233],0,[0,0,1]] call InitItem; 
['GlassLargeBowl',[4025.53,4028.96,31.5132],0,[0,0,1]] call InitItem; 
['Bucket',[4023.56,4022.09,35.8661,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['WoodenBucket',[4018.57,4028.88,36.1175,true],0,[-0.00659628,-0.00161913,0.999977]] call InitItem; 
['WoodenBucket',[4023.51,4021.56,36.0958,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['GlassBottle',[4025.2,4028.99,31.0652],0,[0,0,1]] call InitItem; 
['GlassBottle',[4025.89,4028.93,31.0652],0,[0,0,1]] call InitItem; 
['GlassBottle',[4025.9,4028.94,31.5152],0,[0,0,1]] call InitItem; 
['Mug',[4023.67,4022.95,31.7707],0,[0,0,1]] call InitItem; 
['GlassLargeBreaker',[4025.85,4028.98,32.4152],0,[0,0,1]] call InitItem; 
['CuttingBoard',[4018.96,4021.05,31.6752],280,[0,0,1]] call InitItem; 
['CuttingBoard',[4025.19,4028.95,31.9652],95,[0,0,1]] call InitItem; 
['CuttingBoard',[4022.54,4020.7,31.6873],280,[0,0,1]] call InitItem; 
['Kastrula',[4025.18,4028.95,32.4152],0,[0,0,1]] call InitItem; 
['Kastrula',[4023.43,4022.64,36.7327,true],0.43688,[-0.0868241,0.0871557,0.992404]] call InitItem; 
['OlderWoodenCup',[4018.12,4027.42,31.4233],0,[0,0,1]] call InitItem; 
['Polovnik',[4023.43,4022.54,36.8543,true],0,[-0.00659628,0.705945,0.708235]] call InitItem; 
['FoodPlate',[4022.87,4020.94,31.6963],0,[0,0,1]] call InitItem; 
['SoupPlate',[4020.55,4027.76,31.7111],0,[0,0,1]] call InitItem; 
['SoupPlate',[4019.35,4020.52,31.6752],0,[0,0,1]] call InitItem; 
['SoupPlate',[4023.42,4022.9,36.6969,true],0,[0,-0.34202,0.939693]] call InitItem; 
['WoodenCup',[4018.09,4027.63,36.4974,true],0,[-0.00659628,-0.00161913,0.999977]] call InitItem; 
_4018_002694021_1577130_87217 = ['FreezerStruct',[4018,4021.16,30.8722],15,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[4046.2,4032.16,30.95],0,[0,0,1]] call InitStruct; 
['OldGraveFence',[4038.03,4032.23,31.1409],0,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4037.68,4032.23,38.1174,true],180,[0,-1.91609e-05,-1]] call InitStruct; 
['GreenArmChair',[4045.99,4029.84,30.9537],185,[0,0,1]] call InitStruct; 
['BrownOldArmchair',[4046.07,4034.44,30.9479],175,[0,0,1]] call InitStruct; 
['ThickLightConcreteColumn',[4037.57,4031.08,31.5426],0,[0,0,1]] call InitStruct; 
['ThickLightConcreteColumn',[4037.54,4033.33,31.5954],270,[0,0,1]] call InitStruct; 
['BrownOldSofa',[4048,4032.12,30.9501],270,[0,0,1]] call InitStruct; 
['MediumBetonWall',[4038.23,4032.2,35.6817,true],[-1.19231e-08,-0.0174447,0.999848],[1,0,1.19249e-08]] call InitStruct; 
_4037_716064032_2500031_24020 = ['BarrelCampfireBig1',[4037.72,4032.25,31.2402],155,[0,0,1], {_thisObj setvariable ['model','a3\props_f_enoch\military\garbage\garbagebarrel_02_buried_f.p3d']; _thisObj setvariable ['light',"SLIGHT_WEAK_FIRE" call lightSys_getConfigIdByName];}] call InitStruct; // !!! realocated model !!!
['SquareWoodenBox',[4048.13,4029.83,30.9851],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4047.67,4034.49,30.9939],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['PictureFoliesBergere',[4043.77,4029.3,32.2951],0,[0,0,1]] call InitStruct; 
['RedCarpet',[4043.01,4032.13,30.3744],270,[0,0,1]] call InitStruct; 
['LargeClothCabinet',[4042.92,4034.68,30.9523],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBookcase',[4037.3,4029.97,30.9245],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4037_618654032_2187530_70971 = ['Forge',[4037.62,4032.22,30.7097],270,[0,0,1]] call InitStruct; 
_4044_608404034_8510730_91115 = ['SmallRadiator',[4044.61,4034.85,36.3193,true],0,[0.00161964,0.494275,0.869304]] call InitStruct; 
_4031_000004029_2500031_86520 = ['ConcreteWallWithNetfence',[4031,4029.25,31.8652],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SingleWhiteBed',[4028.82,4030.61,30.9646],176.507,[0,0,1], {go_editor_globalRefs set ["RKomendantDormBed",_thisObj];
}] call InitStruct; 
['WoodenOfficeTable',[4032.42,4033.46,30.9754],270,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4029.52,4030.88,30.9652],90,[0,0,1]] call InitStruct; 
_4029_571534030_3750031_36520 = ['KeyHolder',[4029.57,4030.38,31.3652],180,[0,0,1]] call InitStruct; 
['SmallSteelTable',[4027.31,4029.71,30.9652],0,[0,0,1]] call InitStruct; 
['SmallChair',[4031.73,4033.31,30.9614],255,[0,0,1]] call InitItem; 
['SmallChair',[4027.1,4030.2,30.9615],330,[0,0,1]] call InitItem; 
['WoodenSmallShelf1',[4026.81,4031.68,36.467,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['MatchBox',[4027.55,4029.79,31.7703],315,[0,0,1]] call InitItem; 
['PaperHolder',[4032.57,4034.2,31.7965],355,[0,0,1]] call InitItem; 
['Paper',[4032.26,4034.14,31.7984],10,[0,0,1]] call InitItem; 
['Paper',[4032.3,4033.47,31.7981],0,[0,0,1]] call InitItem; 
['PenRed',[4032.25,4032.82,31.7981],325,[0,0,1]] call InitItem; 
['PenBlack',[4032.31,4032.85,31.7981],355,[0,0,1]] call InitItem; 
['MetalCup',[4032.48,4032.64,31.7843],35,[0,0,1]] call InitItem; 
['BigFileCabinet',[4027.8,4034.83,30.9951],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Briefcase',[4026.74,4031.73,31.946],95,[0,0,1]] call InitItem; 
['LuxuryRedCurtain',[4029.2,4034,27.7298],265,[0,0,1]] call InitStruct; 
['Notepad',[4032.46,4032.79,31.7981],0,[0,0,1]] call InitItem; 
['WoodenChair',[4033.49,4033.84,30.9322],20,[0,0,1]] call InitItem; 
['BreadChopped',[4026.95,4031.38,36.5985,true],25,[-0.00678136,0.00201983,0.999975]] call InitItem; 
['BreadChopped',[4026.85,4031.46,36.5973,true],335,[-0.00590623,-0.00389598,0.999975]] call InitItem; 
['ButterPiece',[4026.95,4031.77,36.6149,true],[-0.422618,0.901301,-0.0951407],[-0.00590623,0.102235,0.994743]] call InitItem; 
['ButterPiece',[4026.95,4031.87,36.6101,true],[0.553865,0.826029,0.104451],[-0.0583147,-0.0866568,0.99453]] call InitItem; 
['FoodPlate',[4026.93,4031.83,36.6147,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
_4032_423834032_4235831_25031 = ['SteelMedicalBox',[4032.42,4032.42,36.2465,true],[4.25984e-08,4.85035e-07,1],[-0.0871557,-0.996195,4.86902e-07]] call InitItem; 
['Baton1',[4026.89,4031.67,31.936],185,[0,0,1]] call InitItem; 
['FoodPlate',[4026.92,4031.6,36.2873,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['Lapsha',[4026.92,4031.59,31.2918],316.334,[0,0,1]] call InitItem; 
['Bun',[4026.88,4031.84,36.6257,true],[0.963024,-0.151393,-0.222855],[0.225453,0,0.974254]] call InitItem; 
['LuxuryDoubleBed',[4044.56,4033.86,33.9137],0.000122943,[0,0,1], {go_editor_globalRefs set ["RCexDormBed",_thisObj];
}] call InitStruct; 
['MediumWoodenTable1',[4048.34,4033.22,33.9179],270,[0,0,1]] call InitStruct; 
['WoodenSmallShelf1',[4048.31,4029.78,33.9179],270,[0,0,1]] call InitStruct; 
['OrangeCarpet1',[4046.52,4032.75,33.914],255,[0,0,1]] call InitStruct; 
['Bookcase',[4047.6,4034.76,33.918],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['RedCarpetWall',[4043.04,4033.42,35.55],0,[0,0,1]] call InitStruct; 
['CaseBedroom',[4045.87,4034.86,33.8719],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBookcase',[4043.56,4031.94,33.918],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['LampKerosene',[4048.43,4033.65,34.7928],300,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['SmallStoveGrill',[4048.47,4031.64,33.768],180,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['SmallTrashCan',[4045.5,4031.07,33.918],0.000122943,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MeatGrinder',[4048.48,4032.38,34.7857],195,[0,0,1]] call InitStruct; 
['FryingPan',[4048.56,4032.83,34.7864],30,[0,0,1]] call InitItem; 
['ChairCasual',[4047.55,4033.66,33.9019],15,[0,0,1]] call InitItem; 
['OldGreenToiletBowl',[4043.47,4030.06,33.9216],225,[0,0,1]] call InitStruct; 
['Umivalnik',[4044.49,4031.33,33.9261],180,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[4043.31,4034.61,33.9155],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MatchBox',[4048.22,4032.31,34.802],315,[0,0,1]] call InitItem; 
['Paper',[4048.14,4033.06,34.8049],30,[0,0,1], {_thisObj setvariable ['preinit@__content',"Списоквввцв дел
"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['PenBlack',[4048.21,4032.94,34.8049],60.0003,[0,0,1]] call InitItem; 
['PaperHolder',[4048.23,4033.46,34.8049],0,[0,0,1]] call InitItem; 
['KitchenKnife',[4048.51,4033.24,39.8079,true],[0.984808,-0.173649,-2.14101e-06],[-0.173649,-0.984808,9.50929e-07]] call InitItem; 
_4045_883304034_7033735_03304 = ['Documents',[4045.88,4034.7,35.033],20,[0,0,1], {_thisObj setvariable ['preinit@__content',"Выручки с продажи изделий за прошедший план:


- 36 звяков, простыни


- 14 звяков, две шапки


- 209 звяков, робы для верховного ополчения Канавы


- 12 звяков, штопали носки работяг


- 153 звяков, спецзаказ ковры 2 штуки


- 4 звяков, трусы для цац (Бубулина Секрет)


- 326 звяков, обноски


- 38 звяков, спец. заказ, одежда для мельтешат

ИТОГО ВЫРУЧКИ: 792 звяка





Расходы за прошлый план:


- 56 звяков, выплата зарплаты начальнику цеха


- 20 звяков, выплата зарплаты рабочим фабрики (перерасход 6 звяков)


- 93 звяков, брага


- 32 звяков, самокрутки и сигареты
- 300 звяков, Зав. каз. Ротобор Звяки

ИТОГО РАСХОДЫ: 501 Звяков
ИТОГО ПРИБЫЛИ: 291 Звяков"]; go_editor_globalRefs set ["TaskDocsCex",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
_4048_582764030_6774933_91686 = ['FreezerStruct',[4048.58,4030.68,33.9169],270,[0,0,1]] call InitStruct; 
['PepperShaker',[4048.42,4029.85,34.8859],0,[0,0,1]] call InitItem; 
['SaltShaker',[4048.42,4029.75,34.8859],0,[0,0,1]] call InitItem; 
['SaltShaker',[4048.53,4029.85,34.8859],0,[0,0,1]] call InitItem; 
['SugarShaker',[4048.48,4029.95,34.8859],0,[0,0,1]] call InitItem; 
['PaperHolder',[4042.3,4023.03,31.6624],0,[0,0,1]] call InitItem; 
['Paper',[4042.09,4022.41,31.6624],345,[0,0,1]] call InitItem; 
['PosterGirl1',[4041.36,4025.45,30.9652],0,[0,0,1]] call InitStruct; 
['PenRed',[4042.27,4022.16,31.6624],90,[0,0,1]] call InitItem; 
['PenBlack',[4042.25,4022.25,31.6624],60,[0,0,1]] call InitItem; 
['SignNoEntry2',[4038.41,4025.78,38.0574,true],90,[3.01992e-07,1,-4.37114e-08]] call InitStruct; 
['SingleWhiteBed',[4041.42,4020.65,30.9292],92.0003,[0,0,1], {go_editor_globalRefs set ["RZavZhilBed",_thisObj];
}] call InitStruct; 
['BrickThinWallSmall',[4039.38,4024.25,30.8652],90,[0,0,1]] call InitStruct; 
['BigClothCabinetNew',[4042.09,4025.13,30.9588],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenOfficeTable3',[4042.22,4022.59,30.9652],270,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4037.92,4020.32,31.0822],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; go_editor_globalRefs set ["ZavKartoteka",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelGreenCabinet',[4037.35,4023.5,30.9596],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BrownLeatherChair',[4039.52,4020.48,30.9652],15,[0,0,1]] call InitStruct; 
['Candle',[4040.42,4024.24,31.9218],0,[0,0,1]] call InitItem; 
['SmallChair',[4041.57,4022.28,30.959],255,[0,0,1]] call InitItem; 
['SquareWoodenBox',[4040.05,4024.63,30.9686],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MatchBox',[4042.08,4022.83,31.6624],0,[0,0,1]] call InitItem; 
['Briefcase',[4039.99,4024.29,31.9316],0,[0,0,1]] call InitItem; 
['Bread',[4042.41,4024.29,31.9652],0,[0,0,1]] call InitItem; 
['Shelves',[4042.43,4023.99,30.9652],90,[0,0,1]] call InitStruct; 
_4037_090334021_7871131_70051 = ['KeyHolder',[4037.09,4021.79,31.7005],180,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[4042.22,4021.57,30.9531],266.538,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Zhivoglot',[4042.44,4024.28,31.491],0,[0,0,1]] call InitItem; 
['Muka',[4042.43,4023.63,31.5],260,[0,0,1]] call InitItem; 
['MilkBottle',[4042.45,4023.86,31.5147],0,[0,0,1]] call InitItem; 
['Egg',[4042.39,4023.92,31.9652],0,[0,0,1]] call InitItem; 
['BloodPoolSmall',[4034.53,4030.24,33.9083],0,[0,0,1]] call InitItem; 
['WoodenTableHandmade',[4035.17,4034.53,33.918],182,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4032.51,4030.15,33.918],345,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; go_editor_globalRefs set ["KoldyrAlkoBox",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BloodPoolMedium',[4033.99,4032.03,33.9081],0,[0,0,1]] call InitItem; 
['WoodenChair',[4033.02,4031.31,39.1067,true],[0.258819,-0.965926,-8.66658e-07],[-0.965926,-0.258819,3.08639e-09]] call InitItem; 
['SurgicalSaw',[4032.19,4034.53,33.8924],0,[0,0,1]] call InitItem; 
['GlassBottle',[4033.4,4029.6,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4034.87,4034.52,39.8727,true],[-1.84317e-06,3.3782e-06,1],[0.97437,0.224951,1.036e-06]] call InitItem; 
['GlassBottle',[4032.68,4033.23,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4036.54,4032.1,33.9163],0,[0,0,1]] call InitItem; 
['GlassBottle',[4033.46,4029.78,38.9512,true],[-0.707108,0.707106,-9.12214e-07],[0.707106,0.707108,5.33851e-08]] call InitItem; 
['Kastrula',[4034.31,4033.86,33.918],270,[0,0,1]] call InitItem; 
['Bone',[4034.43,4034.58,34.0936],257,[0,0,1]] call InitItem; 
['Polovnik',[4033.08,4031.52,33.918],90,[0,0,1]] call InitItem; 
['SleepingMatras',[4036.08,4030.69,34.0477],85.0011,[0,0,1], {go_editor_globalRefs set ["RKoldyrDormBed",_thisObj];
}] call InitStruct; 
['FryingPan',[4032.74,4031.89,34.8445],10,[0,0,1]] call InitItem; 
['Candle',[4032.65,4032.83,34.8694],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['Candle',[4034.36,4034.38,34.8522],257,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['Syringe',[4032.52,4032.66,34.8723],0,[0,0,1]] call InitItem; 
['Syringe',[4033.77,4034.33,33.918],167,[0,0,1]] call InitItem; 
['Syringe',[4035.44,4029.72,33.918],320,[0,0,1]] call InitItem; 
['SmallWoodenTableHandmade',[4032.42,4032.59,33.9144],265,[0,0,1]] call InitStruct; 
['SoupPlate',[4033.01,4032.58,33.918],0,[0,0,1]] call InitItem; 
['SmallTrashCan',[4033.28,4028.91,33.918],15,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SaltShaker',[4035.37,4034.31,34.849],0,[0,0,1]] call InitItem; 
['SaltShaker',[4035.46,4034.39,34.8501],0,[0,0,1]] call InitItem; 
['SaltShaker',[4035.36,4034.41,34.8475],0,[0,0,1]] call InitItem; 
['BigClothCabinet',[4036.43,4032.89,33.923],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; go_editor_globalRefs set ["KoldyrShkaf",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BreadChopped',[4035.62,4034.34,34.8518],30,[0,0,1]] call InitItem; 
['ClothDebris1',[4032.18,4033.18,34.8725],0,[0,0,1]] call InitItem; 
['ClothDebris1',[4033.91,4032.62,33.918],0,[0,0,1]] call InitItem; 
['ClothDebris2',[4036.05,4030.37,34.0688],0,[0,0,1]] call InitItem; 
['ClothDebris2',[4035.21,4032.36,33.918],0,[0,0,1]] call InitItem; 
['DirtDebris1',[4032.19,4031.58,33.918],0,[0,0,1]] call InitItem; 
['DirtDebris2',[4036.42,4033.88,33.923],0,[0,0,1]] call InitItem; 
['SyntDebris1',[4036.38,4031.57,39.0683,true],[-0.996277,4.28197e-06,0.0862047],[0.0862045,0.00198366,0.996275]] call InitItem; 
['WoodenDebris1',[4032.55,4030.27,34.8667],0,[0,0,1]] call InitItem; 
['WoodenDebris2',[4035.8,4033.22,33.918],340,[0,0,1]] call InitItem; 
['WoodenDebris4',[4034.32,4030.99,33.918],295,[0,0,1]] call InitItem; 
['WoodenDebris5',[4033.27,4030.41,33.918],0,[0,0,1]] call InitItem; 
['WoodenDebris6',[4032.36,4032.81,33.918],55,[0,0,1]] call InitItem; 
['WoodenDebris7',[4035.78,4034.38,34.0982],260,[0,0,1]] call InitItem; 
['ButterPiece',[4035.71,4034.43,34.8567],0,[0,0,1]] call InitItem; 
['Testo',[4034.99,4034.39,34.8565],0,[0,0,1]] call InitItem; 
['SmallWoodenTable',[4029.57,4034.42,33.9149],93,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4031.02,4030.12,33.917],11.2096,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4031.1,4031.25,33.922],359.266,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4031.09,4030.61,34.874],353.296,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4027_207034034_2902833_91122 = ['RatCage',[4027.21,4034.29,33.9112],357.01,[0,0,1]] call InitStruct; 
_4027_194094032_9877933_91122 = ['RatCage',[4027.19,4032.99,33.9112],1.97399,[0,0,1]] call InitStruct; 
['WoodenChair',[4029.5,4033.6,33.9436],170.001,[0,0,1]] call InitItem; 
['RedSteelBox',[4027.06,4030.11,33.917],240,[0,0,1]] call InitStruct; 
['Bucket',[4029.14,4034.14,33.9314],0,[0,0,1]] call InitItem; 
['Bucket',[4026.87,4031.04,33.9158],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4026.72,4030.71,33.917],0,[0,0,1]] call InitItem; 
['GlassBottle',[4029,4034.71,34.7598],0,[0,0,1]] call InitItem; 
['GlassBottle',[4029.15,4034.75,34.7634],0,[0,0,1]] call InitItem; 
['MilkBottle',[4030.15,4034.5,34.7658],0,[0,0,1]] call InitItem; 
['SteelBlueCase',[4029.64,4029.8,33.922],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BedOld2',[4030.59,4033.94,33.917],2.8042,[0,0,1], {go_editor_globalRefs set ["RMolDormBed",_thisObj];
}] call InitStruct; 
['Candle',[4029.7,4034.7,34.7606],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['ConcretePanelDamaged',[4029.74,4032.84,33.8514],4,[0,0,1]] call InitStruct; 
['MatchBox',[4030.14,4034.14,34.7676],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.51,4034.31,33.9322],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.46,4033.38,33.9346],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.81,4033.33,34.6346],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.73,4034.21,34.6346],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.83,4033.35,33.9411],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.99,4034.15,33.917],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.76,4032.71,33.917],20,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.28,4032.18,33.917],260,[0,0,1]] call InitItem; 
['RatShitMedium',[4028.26,4033.47,33.917],8.53774e-07,[0,0,1]] call InitItem; 
['Muka',[4030.82,4031.18,34.86],340.202,[0,0,1]] call InitItem; 
['SmallBattery',[4041.17,4034.84,34.9113],0,[0,0,1]] call InitItem; 
['SmallBattery',[4041.31,4034.78,34.9113],0,[0,0,1]] call InitItem; 
['Wrench',[4042.22,4033.47,34.9038],30,[0,0,1]] call InitItem; 
['Wrench',[4042.33,4033.28,34.9041],320,[0,0,1]] call InitItem; 
['MediumWoodenTable',[4039.22,4034.3,33.9054],87.5084,[0,0,1]] call InitStruct; 
['MatchBox',[4039.66,4033.89,34.77],0,[0,0,1]] call InitItem; 
['PaperHolder',[4038.67,4034.19,34.7525],110,[0,0,1]] call InitItem; 
['Paper',[4039.16,4034.25,34.77],110,[0,0,1]] call InitItem; 
['Crowbar',[4042.18,4034.62,34.1985],255,[0,0,1]] call InitItem; 
['Shovel',[4041.16,4029.66,39.3952,true],[0,0.258819,-0.965926],[0,0.965926,0.258819]] call InitItem; 
['Shelves',[4041.14,4034.81,33.9113],0,[0,0,1]] call InitStruct; 
['Hammer',[4042.37,4033.06,39.2218,true],[-0.906308,-0.422618,1.69645e-08],[0.422618,-0.906308,1.08076e-08]] call InitItem; 
['Multimeter',[4042.29,4034.34,34.1992],50,[0,0,1]] call InitItem; 
['Screwdriver',[4040.81,4034.8,34.9113],40,[0,0,1]] call InitItem; 
['Gloves',[4042.29,4032.89,34.9105],25,[0,0,1]] call InitItem; 
['Gloves',[4042.17,4033.03,34.9105],65,[0,0,1]] call InitItem; 
['WireCutters',[4041.35,4034.82,34.4613],20,[0,0,1]] call InitItem; 
_4042_386234031_3793934_19823 = ['IStruct',[4042.39,4031.38,34.1982],350,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_bootcamp\training\target_popup_01_mechanism_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['LongShelf',[4042.34,4032.9,33.918],90,[0,0,1]] call InitStruct; 
['PenBlack',[4039.5,4034.07,34.753],325,[0,0,1]] call InitItem; 
['FabricBagBig2',[4040.56,4034.37,33.918],270,[0,0,1]] call InitItem; 
['GreenBed',[4038.18,4030.1,33.9148],265.883,[0,0,1], {go_editor_globalRefs set ["RSlesarDormBed",_thisObj];
}] call InitStruct; 
['Canister',[4042.34,4031.51,35.7386],340,[0,0,1]] call InitItem; 
['SteelBrownContainer',[4038.16,4030.37,33.918],10.0001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['ShuttleBag',[4039.94,4034.13,33.918],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['PowerSwitcherBig',[4042.58,4033.1,40.1635,true],90,[0,1,7.54979e-08]] call InitStruct; 
['Flashlight',[4042.21,4034.35,34.9039],105,[0,0,1]] call InitItem; 
['Flashlight',[4042.3,4034.1,34.9013],45,[0,0,1]] call InitItem; 
['FreezerStruct',[4042.31,4033.4,41.0326,true],[0.996195,0.0871556,1.1055e-07],[0.0871556,-0.996195,9.61925e-07]] call InitStruct; 
['MetalBarrel1',[4042.39,4034,35.7335],0,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4041.6,4030.92,33.9073],0,[0,0,1]] call InitStruct; 
['DrumGenerator',[4041.99,4030.12,33.9147],80.0001,[0,0,1]] call InitStruct; 
['LampKerosene',[4042.29,4031.37,34.8956],340,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['IntercomOld',[4039.83,4034.86,35.1211],270,[0,0,1]] call InitStruct; 
['Anvil',[4039.03,4029.98,33.9155],335,[0,0,1]] call InitStruct; 
['PowerSwitcherBox_Activator',[4042.4,4032.15,39.987,true],[-3.77074e-06,3.69524e-06,1],[0.707106,0.707108,5.33851e-08]] call InitStruct; 
['StationSpeaker',[4038.57,4035.58,35.9123],180,[0,0,1], {go_editor_globalRefs set ["StationSpeaker G:Q54X59FAgzQ",_thisObj];
}] call InitStruct; 
_4039_493414029_6389234_72077 = ['Intercom',[4039.49,4029.64,34.7208],90,[0,0,1], {go_editor_globalRefs set ["Intercom G:4/wwqSRELj8",_thisObj];
}] call InitStruct; 
['RegistrationPanel',[4042.68,4030.56,33.918],0,[0,0,1]] call InitStruct; 
['ToolPipe',[4040.07,4034.35,34.7576],30,[0,0,1]] call InitItem; 
['ToolStraigthPipe',[4042.29,4033.7,34.2226],105,[0,0,1]] call InitItem; 
['Tumbler',[4042.46,4032.62,39.28,true],[1.33308e-07,1.3766e-07,-1],[-0.422618,0.906308,6.84243e-08]] call InitStruct; 
['Tumbler',[4042.4,4032.13,39.287,true],[1.65039e-07,1.04599e-07,-1],[-0.173648,0.984808,7.43509e-08]] call InitStruct; 
['Wheelchair',[4041.42,4031.7,33.923],103.822,[0,0,1]] call InitStruct; 
['SmallChair',[4038.98,4033.71,33.9127],190,[0,0,1]] call InitItem; 
['SmallBattery',[4041.07,4034.78,34.9113],0,[0,0,1]] call InitItem; 
['SteamBarrel',[4037.41,4034.64,33.883],354.781,[0,0,1]] call InitStruct; 
['Workbench',[4037.65,4032.42,33.9144],270,[0,0,1]] call InitStruct; 
['Hammer',[4037.6,4032.41,39.7546,true],[-0.906308,-0.422618,1.69645e-08],[0.422618,-0.906308,1.08076e-08]] call InitItem; 
['Egg',[4040.78,4034.85,39.5742,true],0,[0,0.549827,0.835278]] call InitItem; 
if ((random 1) < 0.5) then {
	['Egg',[4040.99,4034.86,39.5473,true],[0.240555,0.970635,3.36105e-05],[-0.970632,0.240555,-0.00269624]] call InitItem; 
};
['Bucket',[4037.69,4031.55,33.9109],0,[0,0,1]] call InitItem; 
['SteelBlueCase',[4037.38,4030.88,33.875],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Muka',[4041.45,4034.79,39.0807,true],[-0.00777122,0.0213513,0.999742],[-0.939693,-0.34202,4.07854e-09]] call InitItem; 
['MilkBottle',[4041.19,4034.81,39.0422,true],[0,1.91927e-06,1],[0,-1,1.91927e-06]] call InitItem; 
['FryingPan',[4037.77,4031.5,34.7199],310,[0,0,1]] call InitItem; 
['Wheelchair',[4042,4026.29,33.918],103.822,[0,0,1]] call InitStruct; 
_4044_676274026_0610433_88188 = ['IStruct',[4044.68,4026.06,38.8819,true],[-1,4.20091e-12,8.59499e-06],[0,-1,4.88762e-07], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_006104026_0744633_92040 = ['IStruct',[4046.01,4026.07,38.9903,true],270,[-1.11674e-06,-0.00119335,0.999999], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\boots_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4043_334964026_3364333_90652 = ['IStruct',[4043.33,4026.34,38.9765,true],270,[-1.11674e-06,-0.00119335,0.999999], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\boots_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_422614025_9975634_51696 = ['IStruct',[4046.42,4026,40.0308,true],[-0.996194,0.0868278,-0.00759807],[-0.000105655,0.0859711,0.996298], {_thisObj setvariable ['model','ml_shabut\exodus\misharazumcoat.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_837894025_0070834_62084 = ['IStruct',[4045.84,4025.01,34.6208],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\pillow_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_977054025_9995135_16061 = ['IStruct',[4045.98,4026,35.1606],0.000338948,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polotence.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenSmallShelf1',[4043.44,4026.04,39.4266,true],90,[0,0.00119604,0.999999]] call InitStruct; 
['SquareWoodenBox',[4035.76,4028.72,33.9182],355,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4027.22,4020.82,33.918],350,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4029.69,4028.72,33.9257],5.00001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4030.82,4028.75,33.9184],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4030.15,4028.67,34.8961],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenLadder',[4027.25,4022.01,40.3785,true],[-0.996195,4.88762e-07,-0.0871557],[-0.0871557,0,0.996195]] call InitStruct; 
['WoodenOldBench',[4040.09,4026.19,33.9278],175,[0,0,1]] call InitStruct; 
['BigRedEdgesRack',[4048.43,4028.42,39.9637,true],90,[-1.74849e-07,0.00119604,0.999999]] call InitStruct; 
['OrangeCarpet1',[4047.19,4028.28,33.9263],0,[0,0,1]] call InitStruct; 
['RedSteelBox',[4036.39,4024.89,33.9096],260,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bucket',[4033.64,4023.71,33.9152],0,[0,0,1]] call InitItem; 
['Bucket',[4032.36,4024.28,33.9152],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4032.09,4023.93,33.918],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4032.57,4023.82,33.9152],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4041.26,4025.98,39.1608,true],0,[-0.00119604,0,0.999999]] call InitItem; 
['ConcreteSlabsStack',[4032.52,4021.94,33.8874],0,[0,0,1]] call InitStruct; 
['DrumGenerator',[4030.78,4021.17,33.918],10,[0,0,1]] call InitStruct; 
['HospitalBench',[4037.39,4028.9,38.9236,true],0,[-0.00119604,0,0.999999]] call InitStruct; 
['SteelBlueCase',[4032.82,4028.99,38.9266,true],0,[-0.00119604,0,0.999999], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[4043.6,4029.03,38.9297,true],0,[-0.00119604,0,0.999999], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; go_editor_globalRefs set ["PoisonBox3",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelGreenCabinet',[4031.96,4028.73,33.9162],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelGreenCabinet',[4042.74,4028.77,33.9193],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SofaBrown',[4027.26,4023.76,33.918],75,[0,0,1]] call InitStruct; 
['MetalFanSmall',[4028.93,4020.57,39.0355,true],[1.65609e-07,1.04699e-07,-1],[-0.173648,0.984808,7.43509e-08]] call InitStruct; 
['TorchHolderCharged',[4053.55,4033.6,31.0241],270,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[4053.49,4027.01,30.9768],270,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4030.59,4024.24,30.9847],185,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4029.46,4024.21,30.9774],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; go_editor_globalRefs set ["PoisonBox4",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4030.13,4024.29,31.9551],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[4031.98,4023.74,35.968,true],180,[0.00119383,1.61293e-06,0.999999], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelGreenCabinet',[4032.84,4024,30.9575],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenOldBench',[4038.6,4028.54,30.9793],355,[0,0,1]] call InitStruct; 
['HospitalBench',[4040.91,4026.04,35.9752,true],180.001,[0.0011881,-1.25566e-06,0.999999]] call InitStruct; 
_4045_955574026_0163632_20388 = ['IStruct',[4045.96,4026.02,32.2039],0.000338948,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polotence.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenSmallShelf1',[4042.91,4026.05,36.4761,true],90,[0,0.00119604,0.999999]] call InitStruct; 
['HospitalBench',[4036.47,4033.47,30.9536],90.0005,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4046.12,4028.39,30.9559],45,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4045.19,4028.67,30.9487],0,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4027.1,4028.82,30.9604],0,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4027.73,4028.7,30.9517],45,[0,0,1]] call InitStruct; 
['InfoBoard',[4036.68,4024.5,31.7232],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4043.12,4028.68,30.9708],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MetalBarrel',[4048.37,4028.59,30.9587],0,[0,0,1]] call InitStruct; 
['MetalBarrel',[4047.57,4028.67,30.9504],0,[0,0,1]] call InitStruct; 
['MetalBarrel',[4048.47,4026.38,36.2906,true],[0,7.54979e-08,-1],[0,1,7.54979e-08]] call InitStruct; 
['MetalBarrel',[4028.45,4028.77,30.9768],0,[0,0,1]] call InitStruct; 
['ContainerGreen',[4034.61,4021.46,30.9536],295,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcreteSlabsStack',[4024.43,4021.29,33.923],85,[0,0,1]] call InitStruct; 
['WoodenOldBench',[4025.8,4025.63,33.923],85,[0,0,1]] call InitStruct; 
['Canister',[4027.18,4025.69,30.9632],340,[0,0,1]] call InitItem; 
['Paper',[4036.62,4024.74,37.6059,true],[7.59039e-09,0.984808,-0.173648],[-1,0,-4.37114e-08], {_thisObj setvariable ['preinit@__content',"ПРАВИЛА ПРОЖИВАНИЯ В ЖИЛИЩНИКЕ
НАРУШИТЕЛИ БУДУТ НАКАЗАНЫ ВПЛОТЬ ДО ВЫСЕЛЕНИЯ
1. Не орать дурниной — не мешать сожителям отдыхать.
2. Поддерживать порядок в комнате и общих помещениях, своевременно проводить уборку и выбрасывать мусор.
3. Не водить посторонних в Спальник.
4. Не проносить и не распивать брагосодержащие напитки.
5. Бережно относиться к общей собственности, не ломать мебель и вещи общего пользования.
6. Своевременно оплачивать проживание в полном объёме
7. Не затевать драк и не участвовать в них, при конфликте вызывать заведующего или участкового.
В случае нарушения данных правил:
В первый раз - выговор.
Второй раз — штраф в размере стоимости смены аренды.
Третий раз — ВЫСЕЛЕНИЕ ОТСЮДА ТУДА, ГДЕ ВАС ОБЕРУТ И ЗАБЬЮТ В УГОЛ ХНЫКАТЬСЯ. ПРЕВРАЩЕНИЕ В МОХНАТУЮ КУЧУ.

В случае повреждения или разрушения собственности - штраф в размере полной стоимости и личные усилия по восстановлению."]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['Paper',[4036.62,4024.29,37.5525,true],[-8.14188e-15,1,1.86265e-07],[-1,0,-4.37114e-08], {_thisObj setvariable ['preinit@__content',"ПРАВИЛА ПРОЖИВАНИЯ В ПРОЖИТИИ
НАРУШИТЕЛИ БУДУТ НАКАЗАНЫ ВПЛОТЬ ДО ВЫСЕЛЕНИЯ
1. Не орать дурниной — не мешать сожителям отдыхать.
2. Поддерживать порядок в комнате и общих помещениях, своевременно проводить уборку и выбрасывать мусор.
3. Не водить посторонних в Спальник.
4. Не проносить и не распивать брагосодержащие напитки.
5. Бережно относиться к общей собственности, не ломать мебель и вещи общего пользования.
6. Своевременно оплачивать проживание в полном объёме
7. Не затевать драк и не участвовать в них, при конфликте вызывать заведующего или участкового.
В случае нарушения данных правил:
В первый раз - выговор.
Второй раз — штраф в размере стоимости смены аренды.
Третий раз — ВЫСЕЛЕНИЕ ОТСЮДА ТУДА, ГДЕ ВАС ОБЕРУТ И ЗАБЬЮТ В УГОЛ ХНЫКАТЬСЯ. ПРЕВРАЩЕНИЕ В МОХНАТУЮ КУЧУ.

В случае повреждения или разрушения собственности - штраф в размере полной стоимости и личные усилия по восстановлению."]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['Paper',[4036.62,4024.82,37.1973,true],[7.59039e-09,0.984808,-0.173648],[-1,0,-4.37114e-08], {_thisObj setvariable ['preinit@__content',"ПРАВИЛА ПРОЖИВАНИЯ В ОБИХОДЕ
НАРУШИТЕЛИ БУДУТ НАКАЗАНЫ ВПЛОТЬ ДО ВЫСЕЛЕНИЯ
1. Не орать дурниной — не мешать сожителям отдыхать.
2. Поддерживать порядок в комнате и общих помещениях, своевременно проводить уборку и выбрасывать мусор.
3. Не водить посторонних в Спальник.
4. Не проносить и не распивать брагосодержащие напитки.
5. Бережно относиться к общей собственности, не ломать мебель и вещи общего пользования.
6. Своевременно оплачивать проживание в полном объёме
7. Не затевать драк и не участвовать в них, при конфликте вызывать заведующего или участкового.
В случае нарушения данных правил:
В первый раз - выговор.
Второй раз — штраф в размере стоимости смены аренды.
Третий раз — ВЫСЕЛЕНИЕ ОТСЮДА ТУДА, ГДЕ ВАС ОБЕРУТ И ЗАБЬЮТ В УГОЛ ХНЫКАТЬСЯ. ПРЕВРАЩЕНИЕ В МОХНАТУЮ КУЧУ.

В случае повреждения или разрушения собственности - штраф в размере полной стоимости и личные усилия по восстановлению."]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['Paper',[4036.62,4024.43,37.0191,true],[-8.14188e-15,1,1.86265e-07],[-1,0,-4.37114e-08], {_thisObj setvariable ['preinit@__content',"ПРАВИЛА ПРОЖИВАНИЯ В ЖИТНИКЕ
НАРУШИТЕЛИ БУДУТ НАКАЗАНЫ ВПЛОТЬ ДО ВЫСЕЛЕНИЯ
1. Не орать дурниной — не мешать сожителям отдыхать.
2. Поддерживать порядок в комнате и общих помещениях, своевременно проводить уборку и выбрасывать мусор.
3. Не водить посторонних в Спальник.
4. Не проносить и не распивать брагосодержащие напитки.
5. Бережно относиться к общей собственности, не ломать мебель и вещи общего пользования.
6. Своевременно оплачивать проживание в полном объёме
7. Не затевать драк и не участвовать в них, при конфликте вызывать заведующего или участкового.
В случае нарушения данных правил:
В первый раз - выговор.
Второй раз — штраф в размере стоимости смены аренды.
Третий раз — ВЫСЕЛЕНИЕ ОТСЮДА ТУДА, ГДЕ ВАС ОБЕРУТ И ЗАБЬЮТ В УГОЛ ХНЫКАТЬСЯ. ПРЕВРАЩЕНИЕ В МОХНАТУЮ КУЧУ.

В случае повреждения или разрушения собственности - штраф в размере полной стоимости и личные усилия по восстановлению."]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['SteelCanopySmall',[4042.52,4036.81,31.2947],180,[0,0,1]] call InitStruct; 
['WoodenOldBench',[4043.41,4035.81,30.9665],180,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4044.58,4036.53,30.3632],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4043.77,4038.05,30.2082],0,[0,0,1]] call InitStruct; 
['TrashCan',[4041.66,4035.65,30.8503],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; go_editor_globalRefs set ["PoisonBox5",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
if ((random 1) < 0.65) then {
	['WoodenNewBench',[4037.41,4036.08,30.9974],180.001,[0,0,1]] call InitStruct; 
};
['WoodenChair',[4041.24,4024.44,33.918],285,[0,0,1]] call InitItem; 
['SingleWhiteBed',[4042,4021.17,33.9156],0,[0,0,1]] call InitStruct; 
['BrownOldSofa',[4037.79,4022.65,33.918],90,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4039.52,4020.31,33.9151],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MediumWoodenTable',[4042.02,4023.99,33.9179],0,[0,0,1]] call InitStruct; 
['LongWeaponContainer',[4047.31,4025.28,39.8956,true],[-0.999741,-0.0225574,0.00295896],[0.0225576,-0.965925,0.257837], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4048.27,4024.79,33.918],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MatchBox',[4045.86,4021.23,34.7859],0,[0,0,1]] call InitItem; 
['DoubleCitizenBed1',[4048.17,4021.27,33.918],1.06722e-05,[0,0,1], {go_editor_globalRefs set ["RCherDormBed0",_thisObj];
}] call InitStruct; 
['SewercoverBase',[4043.07,4024.42,39.277,true],0,[0.939692,0,0.342021]] call InitStruct; 
['Paper',[4045.98,4020.99,34.7859],20,[0,0,1]] call InitItem; 
['Paper',[4046.27,4020.94,34.7859],335,[0,0,1]] call InitItem; 
['Paper',[4045.96,4022.26,33.918],320,[0,0,1]] call InitItem; 
['Paper',[4046.74,4023.58,33.918],305,[0,0,1]] call InitItem; 
['Paper',[4043.96,4025.16,33.918],55,[0,0,1]] call InitItem; 
['IdentityDocs',[4043.57,4025.05,33.918],25,[0,0,1]] call InitItem; 
['ShortRottenBoards',[4047.32,4022.16,33.918],0,[0,0,1]] call InitStruct; 
['ShortRottenBoards',[4044.55,4022,33.918],0,[0,0,1]] call InitStruct; 
['ShortRottenBoards',[4045.03,4024.32,33.918],95,[0,0,1]] call InitStruct; 
['PenRed',[4046,4021.22,34.7859],35,[0,0,1]] call InitItem; 
['SmallClothShelter',[4046.02,4021.72,34.0177],0,[0,0,1]] call InitStruct; 
['MetalCup',[4045.74,4020.83,34.7859],0,[0,0,1]] call InitItem; 
['Bucket',[4045.46,4020.93,33.918],0,[0,0,1]] call InitItem; 
['Bucket',[4047.21,4024.44,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.7,4025.3,39.0619,true],0,[-0.00119604,0,0.999999]] call InitItem; 
['GlassBottle',[4043.77,4025.05,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.83,4025.35,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.29,4024.97,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.12,4020.84,33.918],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.87,4020.81,34.7859],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.82,4021.68,34.0162],0,[0,0,1]] call InitItem; 
_4047_554934022_0539635_28233 = ['IStruct',[4047.55,4022.05,35.2823],180.001,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_938724023_2272933_89002 = ['IStruct',[4047.94,4023.23,38.89,true],[0.258821,-0.965925,1.49012e-07],[0.96225,0.257837,-0.0871547], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['Cup',[4046.43,4021.58,34.7859],0,[0,0,1]] call InitItem; 
['GreenArmChair',[4043.48,4023.24,33.918],265,[0,0,1]] call InitStruct; 
['CuttingBoard',[4046.28,4021.3,34.7859],55,[0,0,1]] call InitItem; 
['Kastrula',[4046.44,4022.1,33.9202],0,[0,0,1]] call InitItem; 
['DoubleCitizenBed',[4043.58,4021.37,34.5069],85.0001,[0,0,1], {go_editor_globalRefs set ["RCherDormBed1",_thisObj];
}] call InitStruct; 
['OlderWoodenCup',[4045.9,4021.52,34.7859],0,[0,0,1]] call InitItem; 
['Crutch',[4046.52,4020.63,33.9375],300,[0,0,1]] call InitItem; 
['Crutch',[4048.06,4024.59,34.9087],55,[0,0,1]] call InitItem; 
['HoochMachine',[4045.26,4020.3,33.918],0,[0,0,1]] call InitStruct; 
['FryingPan',[4046.35,4024.79,34.6569],0,[0,0,1]] call InitItem; 
['TrashCan',[4043.36,4025.15,33.918],75,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallSteelTable1',[4046.09,4020.93,33.9159],270,[0,0,1]] call InitStruct; 
['SoupPlate',[4045.95,4020.89,33.918],0,[0,0,1]] call InitItem; 
['SoupPlate',[4046.09,4020.95,34.7859],0,[0,0,1]] call InitItem; 
['OldWoodenBox',[4045.94,4024.59,33.9051],5,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Scales',[4046.32,4020.6,34.7859],85,[0,0,1]] call InitStruct; 
['WoodenCup',[4046.48,4020.99,34.7859],0,[0,0,1]] call InitItem; 
['BigClothCabinet',[4048.44,4023.45,33.918],80,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBattery',[4046.16,4021.42,34.7859],0,[0,0,1]] call InitItem; 
['Teapot',[4046.72,4024.94,34.6665],40,[0,0,1]] call InitItem; 
['ButterPiece',[4043.98,4022.84,33.918],15,[0,0,1]] call InitItem; 
['Testo',[4045.74,4020.54,34.7859],0,[0,0,1]] call InitItem; 
['Testo',[4045.05,4020.56,35.1339],305,[0,0,1]] call InitItem; 
['Testo',[4047.96,4024.46,34.8913],230,[0,0,1]] call InitItem; 
['BreadChopped',[4046.23,4021.3,34.809],350,[0,0,1]] call InitItem; 
['MatchBox',[4030.22,4020.7,31.9577],0,[0,0,1]] call InitItem; 
['MatchBox',[4030,4020.75,31.9577],335,[0,0,1]] call InitItem; 
['Shovel',[4030.09,4020.46,31.9577],85,[0,0,1]] call InitItem; 
['LongShelf',[4031.39,4020.54,30.9652],0,[0,0,1]] call InitStruct; 
['BrushCleaner',[4032.91,4020.59,31.9577],15,[0,0,1]] call InitItem; 
['BrushCleaner',[4032.51,4020.58,31.9577],350,[0,0,1]] call InitItem; 
['BrushCleaner',[4032.13,4020.6,31.9577],350,[0,0,1]] call InitItem; 
['BoardWoodenBox',[4029.17,4022.87,30.9402],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bucket',[4032.75,4020.57,31.2458],0,[0,0,1]] call InitItem; 
['Bucket',[4032.08,4020.5,31.2458],0,[0,0,1]] call InitItem; 
['Kastrula',[4032.38,4020.67,31.2458],0,[0,0,1]] call InitItem; 
['Rag',[4029.75,4020.59,31.2458],0,[0,0,1]] call InitItem; 
['Rag',[4030.13,4020.46,31.2458],335,[0,0,1]] call InitItem; 
['SteelGreenCabinet',[4031.13,4022.87,30.9588],95,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['FryingPan',[4031.69,4020.5,31.2458],345,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.98,4020.57,31.9577],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.69,4020.69,31.9577],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.99,4020.49,31.2458],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.67,4020.57,31.2458],0,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.64,4020.54,31.9577],10,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.47,4020.57,31.9577],0,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.31,4020.63,31.9577],0,[0,0,1]] call InitItem; 
['SquareWoodenBox',[4032.88,4022.45,30.9652],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenDoor',[4032.75,4035.13,33.8652],0,[0,0,1]] call InitStruct; 
_4034_250004029_3750033_86520 = ['WoodenDoor',[4034.25,4029.38,33.8652],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKoldyrDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4040_250004029_3750033_86520 = ['WoodenDoor',[4040.25,4029.38,33.8652],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4044_750004025_6250030_99020 = ['WoodenDoor',[4044.75,4025.63,30.9902],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4047_125004025_6250030_99020 = ['WoodenDoor',[4047.13,4025.63,30.9902],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4049_000004021_5000030_99020 = ['WoodenDoor',[4049,4021.5,30.9902],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4032_871834031_1250030_86520 = ['WoodenDoor',[4032.87,4031.13,30.8652],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_375004033_3750030_86520 = ['WoodenDoor',[4026.38,4033.38,30.8652],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4038_500004025_6250033_86520 = ['WoodenDoor',[4038.5,4025.63,33.8652],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"key201"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4044_750004025_6250033_86520 = ['WoodenDoor',[4044.75,4025.63,33.8652],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RCherDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_625004027_3750030_86520 = ['WoodenDoor',[4026.63,4027.38,30.8652],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; KitchenDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4025_625004023_3750030_86520 = ['WoodenDoor',[4025.63,4023.38,30.8652],185,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; PodsobDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_625004021_7500030_99020 = ['WoodenDoor',[4026.63,4021.75,30.9902],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; PodsobDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4047_125004029_3750033_86520 = ['SteelBrownDoor',[4047.13,4029.38,33.8652],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RCexDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4038_500004025_6250030_86520 = ['SteelBrownDoor',[4038.5,4025.63,30.8652],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4041_039794028_9609430_83566 = ['SteelGreenDoor',[4041.04,4028.96,30.8357],0.000748759,[0,0,1]] call InitStruct; 
_4026_375004027_5000033_86520 = ['SteelDoorThinSmall',[4026.38,4027.5,33.8652],90.0001,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey; PloshadkaDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4018_500004029_2500033_99020 = ['Wicket',[4018.5,4029.25,33.9902],90.0003,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey; PloshadkaDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4028_250004029_3750033_86520 = ['WoodenDoor',[4028.25,4029.38,33.8652],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RMolDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4034_987794035_3024930_73840 = ['SteelGridDoor',[4034.99,4035.3,30.7384],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['StoneBigLadderDouble',[4035.25,4022.75,30.6152],180,[0,0,1]] call InitStruct; 
['BigWoodenLadder',[4026.75,4031.75,31.8582,true],180,[0.00699831,0.00103626,0.999975]] call InitStruct; 
['SteelThinWallBig',[4047.13,4033.5,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4040.88,4033.5,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4034.63,4033.5,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4028.38,4033.5,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4028.38,4027.38,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4034.63,4027.38,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4040.88,4027.38,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4047.13,4027.38,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4028.38,4021.25,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4034.63,4021.25,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4040.88,4021.25,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['SteelThinWallBig',[4047.13,4021.25,41.8662,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['BrickThinWall',[4036.88,4022.75,30.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.75,4022.75,30.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4046,4022.75,30.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4020.5,4029.25,30.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4037,4032.25,30.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4029.13,30.8652],180,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4019.88,30.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4031.75,4032.25,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.88,4032.25,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4036.88,4032.25,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4049,4022.75,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4036.88,4022.75,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.75,4022.75,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4039.63,4019.88,33.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4019.88,33.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4033.63,4019.88,33.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4029.25,4019.89,33.8652],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4033,4032.25,30.8652],90,[0,0,1]] call InitStruct; 
['BrickThinWallTwoDoorways',[4045.88,4025.63,30.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4017.5,4023,30.8652],90,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4039.73,4019.88,30.8652],180,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4045.75,4035.13,33.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4039.75,4035.13,33.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4029.25,4035.13,33.8652],4.26887e-05,[0,0,1]] call InitStruct; 
['BigLightWall',[4049,4031.88,35.8646,true],[-1,-3.34978e-06,2.14577e-06],[-2.14577e-06,-8.02679e-07,-1]] call InitStruct; 
['BigLightWall',[4049,4031.88,34.9902],90.0001,[0,0,1]] call InitStruct; 
['MediumLightWall',[4023.88,4021.8,31.8652],90,[0,0,1]] call InitStruct; 
['MediumLightWall',[4017.5,4027.63,31.8652],90.0001,[0,0,1]] call InitStruct; 
['MediumLightWall',[4048.99,4027.5,35.8652,true],[1,4.37114e-08,-4.55078e-14],[0,-1.0411e-06,-1]] call InitStruct; 
['MediumLightWall',[4048.99,4027.5,34.9902],270,[0,0,1]] call InitStruct; 
['SmallBlueConcreteWall',[4033.63,4021.75,31.7402],90,[0,0,1]] call InitStruct; 
['SmallBlueConcreteWall',[4031.63,4023.38,31.7402],1.36604e-05,[0,0,1]] call InitStruct; 
['SmallTileWall',[4044.13,4020,30.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4025,4029.25,30.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.63,4025.63,30.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.63,4022.88,30.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.63,4026.25,30.8652],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.88,4023.38,30.8652],9.90377e-05,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.38,4032.25,30.8652],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.88,4029.13,30.8652],180,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4029.5,4029.38,33.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4035.5,4029.38,33.8652],4.26887e-05,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4041.5,4029.38,33.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4046,4029.38,33.8652],180,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4045.88,4025.63,33.8652],4.26887e-05,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.63,4025.63,33.8652],4.26887e-05,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.38,4026.25,33.8652],90,[0,0,1]] call InitStruct; 
['BigConcreteWall',[4027.63,4019.88,36.5872,true],[-8.02679e-07,1,-1.27952e-06],[3.01992e-07,-1.27952e-06,-1]] call InitStruct; 
['BigLightWall',[4045.75,4035.25,32.7402],180,[0,0,1]] call InitStruct; 
['MediumLightWall',[4027.88,4035.25,37.3652,true],0.000179292,[-9.77819e-07,-1.25567e-06,1]] call InitStruct; 
['BrickThinWallDoorway',[4049,4022.75,30.8652],270,[0,0,1]] call InitStruct; 
['SmallTileWall',[4047.55,4020,30.9902],180,[0,0,1]] call InitStruct; 
['SmallTileWall',[4046.21,4021.37,31.0205],269.656,[0,0,1]] call InitStruct; 
['SmallTileWall',[4046.21,4023.97,30.9604],268.768,[0,0,1]] call InitStruct; 
['SmallTileWall',[4042.86,4021.37,31.021],270.001,[0,0,1]] call InitStruct; 
['SmallTileWall',[4042.87,4023.97,30.9608],269.113,[0,0,1]] call InitStruct; 
['SmallWallNetfence',[4017.5,4020.75,34.1152],270,[0,0,1]] call InitStruct; 
['SmallWallNetfence',[4018.38,4019.88,34.1152],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4024.5,4029.25,34.1152],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4017.5,4027.38,34.1152],90.0002,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4025.13,4019.88,34.1152],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4017.5,4023.5,34.1152],270,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4038.75,4035.25,37.4844,true],[-3.25841e-07,1,-8.02679e-07],[3.01992e-07,-8.02679e-07,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4038.63,4035.13,39.8594,true],180,[-1.04008e-06,1.34309e-06,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4043.38,4035.13,39.8594,true],[-3.25841e-07,1,-8.02679e-07],[3.01992e-07,-8.02679e-07,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4036.13,4035.13,39.7344,true],180,[-1.13994e-06,-2.47161e-06,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4029.25,4035.13,39.8594,true],[-3.25841e-07,1,-8.02679e-07],[3.01992e-07,-8.02679e-07,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4039.63,4019.88,36.7344,true],[-3.25841e-07,1,-8.02679e-07],[3.01992e-07,-8.02679e-07,-1]] call InitStruct; 
['PlywoodThinWall',[4043,4035.13,30.8652],270,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[4017.5,4024.25,31.6152],0,[0,0,1]] call InitStruct; 
['MediumLightConcretePole',[4017.5,4019.88,36.8382,true],0,[0.00566319,-0.00693144,0.99996]] call InitStruct; 
['SmallRuinedLightWall',[4039.13,4035.25,36.6269,true],0,[1,0,1.19249e-08]] call InitStruct; 
['SmallRuinedLightWall',[4039,4035.25,38.3769,true],[-8.08937e-14,1,1.85063e-06],[-1,0,-4.37114e-08]] call InitStruct; 
['SmallRuinedLightWall',[4033.38,4035.25,37.7519,true],0,[7.78829e-07,0,1]] call InitStruct; 
['SmallRuinedLightWall',[4036.5,4035.25,37.7519,true],180,[7.78829e-07,0,1]] call InitStruct; 
['SmallRuinedLightWall',[4031.25,4035.25,36.6269,true],3.62792e-13,[1,0,1.19249e-08]] call InitStruct; 
['SmallRuinedLightWall',[4031.13,4035.25,38.0019,true],[-8.33906e-14,1,1.90775e-06],[-1,0,-4.37114e-08]] call InitStruct; 
['MediumRuinedLightFrame',[4039.13,4035.25,32.7402],0,[0,0,1]] call InitStruct; 
['MediumRuinedLightFrame',[4031.25,4035.25,32.7402],0.00023308,[0,0,1]] call InitStruct; 
['MediumLightConcretePole',[4026.13,4029.38,37.2132,true],0,[0.00566319,-0.00693144,0.99996]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4033.88,4035.13,40.3587,true],180,[-0.00103702,0.0069951,0.999975]] call InitStruct; 
['MediumLightConcretePole',[4029.56,4032.55,36.5866,true],0,[0.00566319,-0.00693144,0.99996]] call InitStruct; 
['MediumLightWall',[4028.25,4029.25,36.8652,true],180,[-6.78625e-07,-3.01992e-07,1]] call InitStruct; 
['SmallTileWall',[4043,4030.53,33.9308],268.768,[0,0,1]] call InitStruct; 
['SmallTileWall',[4044.03,4029.5,33.9115],178.768,[0,0,1]] call InitStruct; 
['SmallTileWall',[4044.03,4031.75,33.9122],178.768,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4021.23,4019.89,34.1152],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4021.38,4029.25,34.1172],0.000313335,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4045.32,4031.09,33.8762],270,[0,0,1]] call InitStruct; 
['MediumLightConcretePole',[4033.63,4023.25,34.4902],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4026.38,4021.38,33.923],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4026.38,4032.25,33.8652],270,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4031.48,4029.32,28.9608],0,[0,0,1]] call InitStruct; 
['MediumRedSteelFence',[4029.87,4035.24,30.9756],0,[0,0,1]] call InitStruct; 
['SmallSteelGreenFence',[4034.02,4034.31,37.5402,true],[1,1.2358e-06,-7.17937e-12],[0,-5.80947e-06,-1]] call InitStruct; 
['MediumConcreteFloor1',[4046,4032.25,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4040,4032.25,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4046,4022.75,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4040,4022.75,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4030.75,4022.75,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4024.75,4022.75,33.6152],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4020.5,4022.75,33.6151],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4020.5,4026.25,33.615],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4023.75,4026.25,33.6149],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4029.38,4032.25,33.6142],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4034,4032.25,33.6152],0,[0,0,1]] call InitStruct; 
['MediumSteelFloor',[4045.88,4027.38,33.7402],270,[0,0,1]] call InitStruct; 
['MediumSteelFloor',[4039.75,4027.38,33.7402],270,[0,0,1]] call InitStruct; 
['MediumSteelFloor',[4033.63,4027.38,33.7402],270,[0,0,1]] call InitStruct; 
['MediumSteelFloor',[4029.63,4027.38,33.7401],270,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4044.75,4021.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4044.75,4025.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4036.75,4025.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4036.75,4021.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4025.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4021.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4029.88,30.8652],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4033.88,30.8652],0,[0,0,1]] call InitStruct; 
['WhiteConcreteFloorBig',[4040.25,4030.63,30.5637],0,[0,0,1]] call InitStruct; 
['WhiteConcreteFloorBig',[4045.38,4030.63,30.5639],0,[0,0,1]] call InitStruct; 
['MediumStoneRoad',[4035,4031.62,30.8967],0,[0,0,1]] call InitStruct; 
['MediumStoneRoad',[4035,4036.21,30.9162],90,[0,0,1]] call InitStruct; 
['MediumStoneRoad',[4035.02,4037.7,35.7658,true],[1,-1.62301e-07,1.41995e-08],[0,0.0871557,0.996195]] call InitStruct; 
['SmallTileFloor',[4044,4020.88,30.8652],0,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4044,4022.96,30.8652],0,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4046.25,4020.88,30.8652],0,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4046.25,4022.96,30.8652],0,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4048,4020.89,30.8642],0,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4048,4022.97,30.8632],0,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[4032.63,4035.5,33.6152],180,[0,0,1]] call InitStruct; 
['SmallTileFloor',[4044.1,4030.63,33.7786],90,[0,0,1]] call InitStruct; 
['MediumStoneRoad',[4033.5,4031.56,30.8967],0,[0,0,1]] call InitStruct; 
['MediumStoneRoad',[4036.34,4031.1,30.8852],0,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[4019.92,4027.57,33.9228],275,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4022.21,4022.13,33.923],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['LongShelf',[4018.12,4025.04,33.9229],90,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4021.13,4020.99,33.9229],5.00001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4022.27,4021.02,33.923],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4021.17,4022.12,33.9229],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4020.07,4021.01,33.9229],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; go_editor_globalRefs set ["PoisonBox1",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4022.11,4021.26,34.8963],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4021.02,4021.07,34.8962],1.02453e-05,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MetalBarrel1',[4019.11,4021.68,33.9229],45,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4017.9,4022.45,33.9229],45,[0,0,1]] call InitStruct; 
['MetalBarrel1',[4020.18,4022,33.9229],325,[0,0,1]] call InitStruct; 
['MetalBarrel',[4019.09,4020.9,33.9229],0,[0,0,1]] call InitStruct; 
['MetalBarrel',[4018.18,4020.75,33.9229],0,[0,0,1]] call InitStruct; 
['MetalBarrel',[4018.11,4021.76,33.9229],0,[0,0,1]] call InitStruct; 
['TrashCan',[4025.69,4024.19,33.923],15,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; go_editor_globalRefs set ["PoisonBox2",_thisObj];
 _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcretePanelDamaged',[4024.07,4027.48,33.9227],270,[0,0,1]] call InitStruct; 
_4007_750004056_3750034_86522 = ['PowerGenerator',[4007.75,4056.38,40.5294,true],180,[0.00659539,0.00162002,0.999977], {go_editor_globalRefs set ["PowerGenerator G:gh057LhnsQs",_thisObj];
}] call InitStruct; 
_4048_045654025_4414132_32677 = ['RedButton',[4048.05,4025.44,37.327,true],[0,9.65599e-07,1],[0,-1,9.65599e-07], {go_editor_globalRefs set ["RedButton G:Y6ExyGIEWaY",_thisObj];
}] call InitStruct; 
_4045_530524025_4428732_37648 = ['RedButton',[4045.53,4025.44,37.3767,true],[0,1.44244e-06,1],[0,-1,1.44244e-06], {go_editor_globalRefs set ["RedButton G:KDFGox8N8IQ",_thisObj];
}] call InitStruct; 
_4037_568854025_4506832_22730 = ['RedButton',[4037.57,4025.45,37.2275,true],[0,4.88762e-07,1],[0,-1,4.88762e-07], {go_editor_globalRefs set ["RedButton G:Xh2Q/W2FGcg",_thisObj];
}] call InitStruct; 
_4042_000004029_2993232_14939 = ['RedButton',[4042,4029.3,37.1492,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:WGtGrZZEY8w",_thisObj];
}] call InitStruct; 
['LampCeiling',[4047.63,4022.38,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:eqHk+Uz0nZA",_thisObj];
}] call InitStruct; 
['LampCeiling',[4044.38,4022.38,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:eqHk+Uz0nZA (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4040.75,4022.38,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:dBf4oFHbP2I",_thisObj];
}] call InitStruct; 
['LampCeiling',[4046.25,4032.13,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:6MHQBqtjCTs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4041.13,4032.13,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:3WTP9DQ1sKw",_thisObj];
}] call InitStruct; 
_4048_632324027_5000031_48298 = ['ElectricalShieldSmall',[4048.63,4027.5,31.483],270,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:D4hhxFJEMKM",_thisObj];
}] call InitStruct; 
_4016_060794021_3747630_85264 = ['ElectricalShield',[4016.06,4021.37,30.8526],6.53137e-05,[0,0,1], {go_editor_globalRefs set ["ElectricalShield G:BR05v5D45ZA",_thisObj];
}] call InitStruct; 
['SignWelcome',[4036.82,4031.88,32.1429],268.53,[0,0,1]] call InitStruct; 
_4037_375004028_9318832_37982 = ['RedButton',[4037.38,4028.93,37.38,true],[-1,6.70552e-07,1.19249e-08],[-6.70552e-07,-1,1.19249e-08], {go_editor_globalRefs set ["RedButton G:TaTtSnTBX9c",_thisObj];
}] call InitStruct; 
_4032_815924032_0000032_52993 = ['RedButton',[4032.82,4032,37.5301,true],0,[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:/bk1HSzuyiI",_thisObj];
}] call InitStruct; 
_4032_817144032_2802732_52950 = ['RedButton',[4032.82,4032.28,37.5296,true],0,[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:ji1Yi/feNFc",_thisObj];
}] call InitStruct; 
_4046_375004029_5481035_41964 = ['RedButton',[4046.38,4029.55,40.4194,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:HfqsSe3iRaU",_thisObj];
}] call InitStruct; 
_4041_150884029_5671435_23565 = ['RedButton',[4041.15,4029.57,40.2354,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:AjebpdJbUNU",_thisObj];
}] call InitStruct; 
_4035_125004029_5617735_39939 = ['RedButton',[4035.13,4029.56,40.3992,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:mIC0aid4Ae8",_thisObj];
}] call InitStruct; 
_4027_482424029_5642135_27439 = ['RedButton',[4027.48,4029.56,40.2742,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:IFPkvF5Dt4w",_thisObj];
}] call InitStruct; 
_4036_982184025_8139635_41375 = ['RedButton',[4036.98,4025.81,40.4135,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:bd1e0L0glps",_thisObj];
}] call InitStruct; 
_4033_625004023_5000035_39939 = ['RedButton',[4033.63,4023.5,40.3992,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:iw44gmmN2Mo",_thisObj];
}] call InitStruct; 
_4026_452394026_6794432_34003 = ['RedButton',[4026.45,4026.68,37.3402,true],0,[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:zbXUtKxPtFc",_thisObj];
}] call InitStruct; 
_4026_437994022_4606932_08858 = ['RedButton',[4026.44,4022.46,37.0887,true],0,[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:QhdIXJ0UnDY",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035,4025.4,33.1652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:DwTizfFKITc",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035,4032.25,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qlQj1u5GQKs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.69,4027.5,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:NjkDlY9gWRQ",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.28,4033.88,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:jbNZsX9IGL8",_thisObj];
}] call InitStruct; 
['LampCeiling',[4046.25,4033,36.8152],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:Kq7SLbsTC+k",_thisObj];
}] call InitStruct; 
['LampCeiling',[4039.47,4027.5,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:zuAmqwZUMgw",_thisObj];
}] call InitStruct; 
['LampCeiling',[4045.63,4027.38,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4040.13,4032.5,36.8051],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:cBClC1cJFO0",_thisObj];
}] call InitStruct; 
_4034_375004032_1250036_78271 = ['LampCeiling',[4034.38,4032.13,36.7827],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:6DmKSV7k0vk",_thisObj];
}] call InitStruct; 
['LampCeiling',[4028.88,4032.38,36.7974],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:YK+y03D0B3c",_thisObj];
}] call InitStruct; 
['LampCeiling',[4044.02,4027.31,36.6852],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:V/ojCDc8RhU",_thisObj];
}] call InitStruct; 
['LampCeiling',[4037.76,4027.32,36.6852],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (2)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4029.75,4022.13,36.6852],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (4)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4029.5,4027.32,36.6852],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:nIWIk6czRII",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035.13,4024,36.6852],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:RzZuM8b6yYs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4021.8,4027.17,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:S5mD+ipln0g",_thisObj];
}] call InitStruct; 
['LampCeiling',[4019.89,4022.9,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:BQuGl8InN4c",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.55,4021.61,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:WmdD2F4ypQg",_thisObj];
}] call InitStruct; 
_4027_875004023_7500031_49020 = ['ElectricalShieldSmall',[4027.88,4023.75,31.4902],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:l2Y+w3c5mwI",_thisObj];
}] call InitStruct; 
_4047_835454025_9511734_68313 = ['ElectricalShieldSmall',[4047.84,4025.95,34.6831],180,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:y2vQzELsluA",_thisObj];
}] call InitStruct; 
_4024_226814021_5002431_56643 = ['ElectricalShieldSmall',[4024.23,4021.5,31.5664],90,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:5tPSYWljSTo",_thisObj];
}] call InitStruct; 
_4028_875004020_2500034_61520 = ['ElectricalShieldSmall',[4028.88,4020.25,34.6152],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:aNkEhGxpPYY",_thisObj];
}] call InitStruct; 
_4004_186044056_9160237_20776 = ['Tumbler',[4004.19,4056.92,37.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:zx+c4iKzc5g",_thisObj];
}] call InitStruct; 
_4004_686044056_9160237_20776 = ['Tumbler',[4004.69,4056.92,37.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:hGnHa7kTbEk",_thisObj];
}] call InitStruct; 
_4003_686044056_9160236_20776 = ['Tumbler',[4003.69,4056.92,36.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:HVC4/Ag7eck",_thisObj];
}] call InitStruct; 
_4004_186044056_9160236_70776 = ['Tumbler',[4004.19,4056.92,36.7078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:umbpX/vnAss",_thisObj];
}] call InitStruct; 
_4003_686044056_9160236_70776 = ['Tumbler',[4003.69,4056.92,36.7078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:OpthpYcZ5Z4",_thisObj];
}] call InitStruct; 
_4003_686044056_9160237_20776 = ['Tumbler',[4003.69,4056.92,37.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:fLGwpoBP83c",_thisObj];
}] call InitStruct; 
['StreetLamp',[4021.75,4043.38,29.8652],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:4Ns/ZphJWgo",_thisObj];
}] call InitStruct; 
['StreetLamp',[4014.07,4028.89,35.1277],90.0001,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E",_thisObj];
}] call InitStruct; 
['StreetLamp',[4010.38,4043.88,30.8007],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:PtjQNHBBpAQ",_thisObj];
}] call InitStruct; 
['StreetLamp',[4032.17,4043.38,29.8652],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:JobENx7FvpM",_thisObj];
}] call InitStruct; 
['StreetLamp',[4043.5,4043.63,29.8652],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac",_thisObj];
}] call InitStruct; 
['StreetLamp',[3995.97,4041.13,30.8652],0.000287722,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:PtjQNHBBpAQ (1)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4053,4046.14,29.8652],270,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4063.8,4066.44,39.2696,true],0,[0,0.573576,0.819152], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:RZhTnTC73d8",_thisObj];
}] call InitStruct; 
_4003_686044056_9160235_70776 = ['Tumbler',[4003.69,4056.92,35.7078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:kWu++T5dkiI",_thisObj];
}] call InitStruct; 
['LampCeiling',[4064.54,4069.39,34.167],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:Tfyf2IaEkFM",_thisObj];
}] call InitStruct; 
['StreetLamp',[3999.76,4028.14,34.8652],0.000475552,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E (5)",_thisObj];
}] call InitStruct; 
['StreetLamp',[3985.5,4027.85,34.8652],9.30613e-05,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E (9)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4006.17,4024.36,38.6241],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:SLKfMovNocM",_thisObj];
}] call InitStruct; 
['LampCeiling',[4005.97,4035.73,38.7531],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:DERdhpwI1BE",_thisObj];
}] call InitStruct; 
['LampCeiling',[3990.44,4035.08,38.4171],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:MOBhI0NCvxc",_thisObj];
}] call InitStruct; 
['LampCeiling',[3992.56,4024.05,38.8256],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:Q/wMdw65U8Y",_thisObj];
}] call InitStruct; 
['LampCeiling',[3977.82,4031.5,39.736],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:SaqNZ03gHeU",_thisObj];
}] call InitStruct; 
['LampCeiling',[3977.29,4031.45,42.9193],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:aTykogdJ1gU",_thisObj];
}] call InitStruct; 
['LampCeiling',[4039.5,4022.13,36.7402],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:GhyA0/mPKB8",_thisObj];
}] call InitStruct; 
_4039_237064025_4521535_34606 = ['RedButton',[4039.24,4025.45,40.3463,true],[0,4.88762e-07,1],[0,-1,4.88762e-07], {go_editor_globalRefs set ["RedButton G:QtralcJPWoA",_thisObj];
}] call InitStruct; 
_4011_000004055_7500034_97359 = ['ElectricalShield',[4011,4055.75,42.0838,true],90,[0,0.0348995,0.999391], {go_editor_globalRefs set ["ElectricalShield G:+luUbpyNzq4",_thisObj];
}] call InitStruct; 
['StreetLamp',[4052.63,4063,28.238],135,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (2)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4072.81,4064.36,28.3238],190,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (3)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4081.5,4074.55,27.9493],270,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (4)",_thisObj];
}] call InitStruct; 
_4017_170414051_3002936_26777 = ['RedButton',[4017.17,4051.3,41.2676,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:2Y5XzDeSbnc",_thisObj];
}] call InitStruct; 
['LampCeiling',[4006.39,4054.05,39.1591],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:g7G/XnsBC9A",_thisObj];
}] call InitStruct; 
['LampCeiling',[4014.18,4054.15,39.1872],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:6Hk0pG2LyqI",_thisObj];
}] call InitStruct; 
['LampCeiling',[4016.33,4050.87,42.3332,true],0,[0,0.48481,0.87462], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:ZtPLJzG0HNM",_thisObj];
}] call InitStruct; 
_4005_186044056_9160236_20776 = ['Tumbler',[4005.19,4056.92,36.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:EWMj6vlYuZw",_thisObj];
}] call InitStruct; 
_4005_686044056_9160236_20776 = ['Tumbler',[4005.69,4056.92,36.2078],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:1V9pkcdGJ9Q",_thisObj];
}] call InitStruct; 
['StreetLamp',[4070.62,4043.79,28.7914],0.000338948,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (5)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4024.88,4025.46,33.3652],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:S5mD+ipln0g (1)",_thisObj];
}] call InitStruct; 
_4000_000004037_5000035_54056 = ['ElectricalShield',[4000,4037.5,35.5406],180,[0,0,1], {go_editor_globalRefs set ["ElectricalShield G:aL5OTxyNxco",_thisObj];
}] call InitStruct; 
_4068_316894067_0622632_29673 = ['RedButton',[4068.32,4067.06,37.2965,true],[0,7.54979e-08,-1],[0,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:EXKORnjUGZM",_thisObj];
}] call InitStruct; 
_4069_492924071_2988332_01056 = ['ElectricalShieldSmall',[4069.49,4071.3,32.0106],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:K+aD+A9Ny5s",_thisObj];
}] call InitStruct; 
_4067_558354068_1237832_35655 = ['RedButton',[4067.56,4068.12,37.3567,true],0,[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:iBr4jx3Wi0I",_thisObj];
}] call InitStruct; 
['LampCeiling',[4045.63,4022.38,36.7402],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:KRZfyWUeOck",_thisObj];
}] call InitStruct; 
_4045_506104025_4533735_37244 = ['RedButton',[4045.51,4025.45,40.3726,true],[0,4.88762e-07,1],[0,-1,4.88762e-07], {go_editor_globalRefs set ["RedButton G:8n4vmOZcVYg",_thisObj];
}] call InitStruct; 
['StreetLamp',[4078.03,4014.96,23.1845],175,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:zVA/rLuMkaA",_thisObj];
}] call InitStruct; 
['LampCeiling',[4062.33,4073.4,34.1212],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:Tfyf2IaEkFM (1)",_thisObj];
}] call InitStruct; 
['BlockStone',[4013.75,4024.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4024.88,14.25],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,4025.5,30.875],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4034.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4024.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4003.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4034.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.75,4034.88,30.8652],270,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4034.88,30.8652],180,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4024.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4034.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4053.88,34.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004.88,4049.63,34.875],180,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993.75,4044.38,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984.75,4063.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3974.75,4064.13,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4064.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4054.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4044.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4074.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4082.75,4074.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4082.75,4084.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4084.88,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4008,4033,35.7402],180,[0,0,1]] call InitDecor; 
['BlockStone',[4008,4023,35.7402],180,[0,0,1]] call InitDecor; 
['BlockStone',[3998,4033,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[3998,4023,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[3988,4033,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[3988,4023,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[3978,4033,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[3978,4023,35.6152],180,[0,0,1]] call InitDecor; 
['BlockStone',[4062.85,4037.03,28.7649,true],0,[0,-0.422618,0.906308]] call InitDecor; 
['BlockStone',[4063.88,4026.47,25.0709,true],0,[0,-0.258819,0.965926]] call InitDecor; 
['BlockDirt',[4073,4006.88,24.8652],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4073,4018,24.8652],90.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[4081.8,4018,23.3183,true],[-6.99328e-06,-1,1.92752e-06],[0.258819,5.18461e-08,0.965926]] call InitDecor; 
['BlockDirt',[4081.8,4006.88,23.3183,true],[-0.965926,9.95337e-07,0.258819],[0.258819,1.10984e-07,0.965926]] call InitDecor; 
['BlockDirt',[4063,4006.88,24.8652],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4063,4018,24.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.6,4055.11,30.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,4055,30.8652],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4053.51,4064.03,24.9911],90,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4024.75,30.875],0,[0,0,1]] call InitDecor; 
['BlockStone',[4015.75,4024.88,14.0547,true],0,[0.0871556,0,0.996195]] call InitDecor; 
['BlockStone',[3965,4064,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3955,4064,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3965,4054,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3955,4054,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3955,4044,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3965,4044,31],270,[0,0,1]] call InitDecor; 
['StoneArch',[4059.25,4049.38,39.8529,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['StoneArch',[3974.73,4063.54,36.6918,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['StoneArch',[4085.96,4049.88,28.6417],89.9979,[0,0,1]] call InitDecor; 
['BigStoneWall',[4038.42,4017.63,39.1021,true],2.86015e-05,[-0.00659113,-0.00162056,0.999977]] call InitDecor; 
['BigStoneWall',[4028.89,4017.75,39.256,true],2.90283e-05,[-0.00659294,-0.00162104,0.999977]] call InitDecor; 
['BigStoneWall',[4012.25,4027.25,24.1152],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4000.25,4056.88,44.2271,true],90,[-0.00161952,0.00659617,0.999977]] call InitDecor; 
['BigStoneWall',[3989.63,4049,39.6021,true],90.0003,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4055.75,4029.88,39.1021,true],270,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4012.25,4059.88,35.7402],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4032.13,4045.88,24.6152],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4047.13,4057.88,30.7402],105,[0,0,1]] call InitDecor; 
['BigStoneWall',[4020.76,4057.32,35.7402],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4000.75,4038.38,30.9902],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3979.75,4057.38,38.2271,true],0.000939598,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[3999.25,4069,36.3521,true],180.001,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4069.88,4031.5,29.2402],270.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4063.5,4057.75,24.4902],0.000475552,[0,0,1]] call InitDecor; 
['BigStoneWall',[4087.63,4067.93,29.7402],305.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4086,4076.13,30.7402],270.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4054.26,4060.24,42.9117,true],[-2.94845e-06,-1.19249e-08,-1],[0,-1,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4073.5,4065.5,42.8521,true],[-2.94845e-06,-1.19249e-08,-1],[0,-1,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4079.05,4081.51,42.8257,true],[0,7.54979e-08,-1],[0,1,7.54979e-08]] call InitDecor; 
['BigStoneWall',[3993,4050.61,45.6021,true],[1.19249e-08,-4.37114e-08,-1],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[3989.63,4062.75,45.561,true],[-4.61738e-06,-4.88757e-07,-1],[-1.13994e-06,-1,4.88762e-07]] call InitDecor; 
['BigStoneWall',[4073.88,4049.09,43.8521,true],[-4.85579e-06,-4.88757e-07,-1],[-1.13994e-06,-1,4.88762e-07]] call InitDecor; 
['BigStoneWall2',[4014.75,4019.38,39.6014,true],225,[0.0281457,0.0243337,0.999308]] call InitDecor; 
['BigStoneWall2',[4011.88,4037.5,30.7402],60,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4020.96,4046.19,24.5984],230.001,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4043.13,4046.38,30.6152],160,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4051.38,4064.93,30.3876],335,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3992.13,4041.13,30.9412],240,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3988.98,4056.73,29.9261],50.0005,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3998.41,4066.27,30.8194],70.0005,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4053.08,4019.67,39.1845,true],159.984,[0.0208885,0.0307892,0.999308]] call InitDecor; 
_4069_875004071_6679726_24020 = ['IStruct',[4069.88,4071.67,26.2402],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumPileOfDirtAndStones',[4014.13,4050,37.0549,true],0,[-0.0069996,-0.174664,0.984603]] call InitStruct; 
['MediumPileOfDirtAndStones',[4055.63,4031.5,32.8652],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3993.06,4067.61,35.6656,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['BigStoneWall',[4003,4018.83,34.8652],360,[0,0,1]] call InitDecor; 
['BigStoneWall',[3983,4018.59,34.8652],360,[0,0,1]] call InitDecor; 
['BigStoneWall',[3972,4029.75,34.8652],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3981.5,4040.13,34.9902],180,[0,0,1]] call InitDecor; 
['LargeConcreteWallWithReinforcement',[4090.09,4049.9,34.6015],90,[0,0,1]] call InitStruct; 
['BigStoneWall',[4061.25,4031,29.3476],90.0015,[0,0,1]] call InitDecor; 
['BigStoneWall',[4059.5,4009.38,29.3652],90.0015,[0,0,1]] call InitDecor; 
['BigStoneWall',[4080,4019,25.8652],190.002,[0,0,1]] call InitDecor; 
['BigStoneWall',[4071.13,4003.75,28.3652],0.00152527,[0,0,1]] call InitDecor; 
['BigStoneWall',[4089.75,4009.25,25.3652],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4070.88,4011,43.8521,true],[-1,-2.19464e-05,1.3273e-10],[0,-6.04789e-06,-1]] call InitDecor; 
['BigStoneWall',[4079.88,4009.88,43.9771,true],[4.37114e-08,2.29001e-05,-1],[-1,0,-4.37114e-08]] call InitDecor; 
['BigStoneWall',[4087.25,4003.5,34.7271,true],0,[0.34202,0,0.939693]] call InitDecor; 
['BigStoneWall',[4062.63,4036,40.6021,true],[1.12057e-08,0.34202,-0.939693],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4062.5,4016.25,37.1021,true],[1.19249e-08,-1.47422e-06,-1],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall2',[4079.34,4042.59,31.3652],155,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4058.36,4067.42,29.6578],185,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3982.16,4068.25,30.9927],5.00047,[0,0,1]] call InitDecor; 
['BigStoneWall',[4009.38,4017.88,34.4616,true],2.90283e-05,[-0.00659294,-0.00162104,0.999977]] call InitDecor; 
['BigStoneWall2',[4012,4019,45.6282,true],[0.0371083,-0.965258,0.25865],[0.999308,0.035147,-0.0122047]] call InitDecor; 
['StoneArch',[3944.5,4063.5,36.7943,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['BigStoneWall',[3959.13,4068.98,30],180.001,[0,0,1]] call InitDecor; 
_3970_125004048_1250029_97929 = ['BigStoneWall',[3970.13,4048.13,38.4869,true],270,[-0.0174524,0,0.999848]] call InitDecor; 
_3958_195314040_1843329_97929 = ['BigStoneWall',[3958.2,4040.18,38.4869,true],0,[0,0.0174524,0.999848]] call InitDecor; 
_3949_000004048_6250030_00000 = ['BigStoneWall',[3949,4048.63,30],90,[0,0,1]] call InitDecor; 
['DestroyedMetalHangar',[4043.75,4104.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4021.75,4104.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4065.75,4104.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[3999.75,4104.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[3999.75,4054.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4021.75,4054.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4043.75,4054.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4065.75,4054.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088,4104.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088,4054.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4000,4004.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4022,4004.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4044,4004.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4066,4004.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088.25,4005.08,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[3977.75,4104.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[3977.75,4054.83,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
['DestroyedMetalHangar',[3978,4004.96,63.243,true],[-4.37896e-06,1,-2.4716e-06],[-1.13994e-06,-2.47161e-06,-1]] call InitDecor; 
_3954_000004055_3750038_51643 = ['IStruct',[3954,4055.38,43.583,true],[1.47526e-06,-1,1.30527e-06],[0.017455,-1.27932e-06,-0.999848], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_concreteramp_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3965_750004055_0000038_51642 = ['IStruct',[3965.75,4055,43.583,true],[-8.02556e-07,1,-1.2655e-06],[-0.0174554,-1.27932e-06,-0.999848], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_concreteramp_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcreteFloorHangarLong',[4026.5,4065.75,41.8652],90,[0,0,1]] call InitDecor; 
['FactoryBigBrick',[4031.13,4053.63,36.2402],90,[0,0,1]] call InitDecor; 
['ConcreteArch',[4080.44,4049.87,27.4515],180,[0,0,1]] call InitDecor; 
['ConcreteArch',[3979.73,4063.48,27.1426],0,[0,0,1]] call InitDecor; 
['ConcreteArch',[4064.8,4049.3,30.1273],180,[0,0,1]] call InitDecor; 
['SmallDirtGrey',[4075.38,4073.88,30.8652],160,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4076.38,4055.25,30.8652],1.06722e-05,[0,0,1]] call InitStruct; 
['BigBlockedTunnel',[4079.13,4082.75,29.7402],90,[0,0,1]] call InitDecor; 
['Rail',[4077.75,4066.75,30.7402],187,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[4052.5,4057.13,37.8313],90,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[4050.13,4056,37.9563],0,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse1',[4050.13,4056,42.0813],1.06722e-05,[0,0,1]] call InitStruct; 
['BigRuinedBrickBuilding',[3990,4051.88,42.7402],270,[0,0,1]] call InitDecor; 
['DirtCraterLong',[4050.88,4055,35.7411,true],10,[-0.00707306,0.000195864,0.999975]] call InitStruct; 
['DirtCraterLong',[3995.82,4051.6,35.3961,true],266.955,[0.00660731,0.00601942,0.99996]] call InitStruct; 
['DirtCraterLong',[3983.1,4058.33,35.8007,true],93.5819,[-0.00120364,0.00668457,0.999977]] call InitStruct; 
['BigPilePipes',[4052.49,4023.89,36.4986,true],270,[0.00161535,-0.00659347,0.999977]] call InitStruct; 
['MetalTruss',[4073.92,4056.24,37.2989,true],270,[-0.00103539,0.00699961,0.999975]] call InitStruct; 
['LongDestroyedPipeWithSupportingStructure',[4059,4048.88,42.9959,true],[-2.71003e-06,1,-4.85579e-06],[-6.70552e-07,-4.85579e-06,-1]] call InitStruct; 
['PipeCutOnSupportingStructure',[4016,4019.75,30.7402],0,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4008.25,4028,30.8652],10,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4036.96,4050.31,30.8627],98.8907,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4026.9,4050.47,30.8812],102.876,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4003.5,4033.5,30.8885],87.5846,[0,0,1]] call InitStruct; 
['MetalTank',[3997.63,4051.75,37.1001,true],85,[-0.00825023,0.0147972,0.999856]] call InitStruct; 
['SmallRuinedWoodenBuilding',[4050.49,4041.57,31.8097],357.34,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4053.13,4022.74,30.8972],180,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4002.58,4048.29,34.8889],27.6409,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4052.99,4038.85,30.9929],340.373,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4074.88,4074.76,35.7381,true],[0.173648,0.984808,-7.48783e-07],[0.254886,-0.0449425,0.965926]] call InitStruct; 
['DestroyedPipeMedium',[4015.37,4039.67,37.2632,true],210,[-0.0258851,0.00959628,0.999619]] call InitStruct; 
['BigIndustrialPipesWithLadder',[3997.13,4063.13,39.573,true],175,[0.00688101,0.00164269,0.999975]] call InitStruct; 
['RustyTank',[4028.13,4044.38,31.6152],90,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4072.88,4068.35,31.027],0,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4083.33,4076.19,30.8933],335,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4051.78,4064.33,31.0083],50,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[3993.07,4042.29,30.8962],314.934,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4009.77,4046.62,30.8917],24.7127,[0,0,1]] call InitStruct; 
['MediumPieceSuspendedPipe',[4049.75,4053.75,37.0249],0,[0,0,1]] call InitStruct; 
['ConcretePanel',[4034.15,4042.2,35.8985,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['ConcretePanel',[4036.09,4042.2,35.9146,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
_4035_132574042_8337430_94849 = ['Statue3',[4035.13,4042.83,30.9485],0,[0,0,1]] call InitStruct; 
if ((random 1) < 0.5) then {
	['WoodenBucket',[4035.11,4042.84,38.5504,true],[-0.604024,0.766042,-0.219851],[0.34202,-5.45912e-06,-0.939693]] call InitItem; 
};
['MediumPileOfLightMud',[4034.1,4045.65,36.0393,true],[0.980421,0.165678,0.106423],[-0.0943911,-0.0788961,0.992404]] call InitStruct; 
['BetonTrapeciaSmall',[4035.09,4044.68,32.232],0,[0,0,1]] call InitStruct; 
if ((random 1) < 0.4) then {
	['Paper',[4035.16,4042.79,37.8812,true],[2.8994e-11,0.819152,-0.573576],[-0.996195,0.0499904,0.0713937], {_thisObj setvariable ['preinit@__content',"Меня зовут Афоня Чиркин.
Я главный на этой фабрике!
Ты больше не будешь мне перечить. Жалкий ты червяк!
Если ты не повинуешься - я буду делать с тобой всё что мне захочется!"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
};
['RedSteelBox',[3997.53,4061.41,30.8644],0,[0,0,1], {go_editor_globalRefs set ["task1redbox",_thisObj];
}] call InitStruct; 
['SteelThinWallSmall',[3997.44,4061.13,37.2773,true],0,[0,0.0871557,0.996195]] call InitStruct; 
['SmallSheetMetalHouse2',[3995.71,4062.97,31.1532],270,[0,0,1]] call InitStruct; 
['Rail',[4075.63,4044.38,30.7402],184,[0,0,1]] call InitStruct; 
['BigBlockedTunnel',[4074.88,4035,30.3652],270,[0,0,1]] call InitDecor; 
['TunnelIntersection',[4079.25,4010,40.5613,true],180,[0,-8.02679e-07,-1]] call InitDecor; 
['ConcreteArch',[4077.1,4058.71,27.1645],90.0003,[0,0,1]] call InitDecor; 
['GateCity',[4079.95,4049.85,31.3299],90.0003,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4080.32,4049.85,35.4139,true],91.0414,[0.0324534,-0.036864,0.998793]] call InitStruct; 
['GateCity',[4064.82,4049.35,33.8362],90.0003,[0,0,1]] call InitStruct; 
['GateCity',[4077.08,4058.74,31.1972],0.000338948,[0,0,1]] call InitStruct; 
['GateCity',[4065.88,4048.14,37.1607,true],[0.944137,0.0973401,0.31485],[-0.317867,0.0168099,0.947986]] call InitStruct; 
['SmallSteelPlate',[4064.57,4049.33,36.3703,true],[-0.0968076,0.99474,-0.0334854],[-0.813497,-0.0596954,0.578498]] call InitStruct; 
['SmallPileOfConcreteFragments',[4070.18,4048.78,35.9669,true],320,[0.00879116,-0.00166821,0.99996]] call InitStruct; 
['DirtCraterLong',[4075.81,4042.21,35.6813,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['WoodenNewBench',[4036.69,4041.28,31.0597],95.0001,[0,0,1]] call InitStruct; 
['WoodenNewBench',[4033.54,4041.3,31.0358],265,[0,0,1]] call InitStruct; 
_3986_000004069_5000038_00227 = ['IStruct',[3986,4069.5,44.041,true],345,[0.00726342,-0.00522914,0.99996], {_thisObj setvariable ['model','ca\structures\castle\a_castle_walls_end.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigVentilationTurbine',[4050.76,4015.38,44.562,true],[0,4.88762e-07,1],[0,-1,4.88762e-07]] call InitStruct; 
['MediumPileOfDirtAndStones',[4061.85,4058.64,35.2128,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['MediumPileOfDirtAndStones',[4069.78,4058.66,35.2104,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['ThickConcreteFloorSmall',[4014.75,4054,34.4903],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4008.75,4054,34.4903],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4002.86,4054.01,34.4953],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4015,4051.13,36.8652],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4009.75,4053.75,34.8692],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4014.25,4057.5,38.7402],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4005.25,4057.5,38.7402],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4002.68,4055.05,38.8538],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4009.75,4058,38.7402],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4007.63,4051.13,38.8537],0.000147703,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4018.27,4055.17,38.8715],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4009.75,4053.02,36.8652],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4015.09,4051.12,34.8987],0,[0,0,1]] call InitStruct; 
_4016_250004051_1250034_99020 = ['SteelDoorThinSmall',[4016.25,4051.13,34.9902],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormGenKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4009_750004052_5000034_99020 = ['SteelDoorThinSmall',[4009.75,4052.5,34.9902],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormGenKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallSteelRustyFence',[4013.88,4051.09,35.6609],90,[0,0,1]] call InitStruct; 
['TinBigFence',[4012.83,4048.22,34.7732],0,[0,0,1]] call InitStruct; 
['TinBigFence',[4007.51,4044.4,34.8493],0,[0,0,1]] call InitStruct; 
['TinBigFence',[4003.46,4044.73,34.8891],10,[0,0,1]] call InitStruct; 
['TinBigFence',[4016.86,4048.27,34.7652],0,[0,0,1]] call InitStruct; 
['BigWoodenLadder',[4018.83,4048.28,24.2355],180,[0,0,1]] call InitStruct; 
['SteelThinWallBig',[4005.3,4052.02,46.9033,true],[-1.03273e-08,-0.499995,0.866028],[1,0,1.19249e-08]] call InitStruct; 
['SteelThinWallBig',[4017.68,4052.04,46.8921,true],[-1.03273e-08,-0.499995,0.866028],[1,0,1.19249e-08]] call InitStruct; 
['SteelThinWallBig',[4011.5,4052.04,46.8956,true],[-1.03273e-08,-0.499995,0.866028],[1,0,1.19249e-08]] call InitStruct; 
['ThickConcreteFloorMedium',[4011.27,4054.03,40.8083],90,[0,0,1]] call InitStruct; 
['ElectricalEngineDevice',[4017.04,4054.65,34.986],180,[0,0,1]] call InitStruct; 
['ElectricalTransformer',[4015.91,4057.34,35.0205],180,[0,0,1]] call InitStruct; 
['FarmGarden',[4018.76,4057.66,36.7769],231.764,[0,0,1]] call InitStruct; 
['BigElectricPumpFan',[4003.76,4053.48,34.9283],180,[0,0,1]] call InitStruct; 
['BigPipePump',[4005.58,4052.14,34.67],270.001,[0,0,1]] call InitStruct; 
['ElectricPump',[4007.92,4052.11,34.9039],270,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[4013.41,4051.86,34.9888],270.794,[0,0,1]] call InitStruct; 
_4015_114264051_7805234_98373 = ['SquareWoodenBox',[4015.11,4051.78,34.9837],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4010_793464054_4775434_84227 = ['SquareWoodenBox',[4010.79,4054.48,34.8423],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MatchBox',[4013.77,4051.84,35.8533],321.649,[0,0,1]] call InitItem; 
['Paper',[4013.52,4051.97,35.8533],271.988,[0,0,1]] call InitItem; 
['Paper',[4013.28,4051.72,35.8533],60.118,[0,0,1]] call InitItem; 
['Paper',[4013.91,4052.08,35.8533],14.3355,[0,0,1]] call InitItem; 
['Shovel',[4009.13,4054.57,35.5373],180,[0,0,1]] call InitItem; 
['Shovel',[4011.87,4051.77,40.4724,true],[0,0.258819,-0.965926],[0,0.965926,0.258819]] call InitItem; 
['Shelves',[4009.09,4054.57,34.9858],89.288,[0,0,1]] call InitStruct; 
['Multimeter',[4009.1,4054.74,35.0906],84.158,[0,0,1]] call InitItem; 
['Screwdriver',[4009.08,4054.67,35.9804],116.562,[0,0,1]] call InitItem; 
['Gloves',[4009.11,4054.14,35.0924],89.5991,[0,0,1]] call InitItem; 
['Gloves',[4009.13,4054.46,35.0924],124.814,[0,0,1]] call InitItem; 
['Gloves',[4009.1,4054.31,35.0924],111.373,[0,0,1]] call InitItem; 
['WireCutters',[4009.1,4054.95,35.1063],284.072,[0,0,1]] call InitItem; 
_4005_032474046_1533234_84484 = ['Decor',[4005.03,4046.15,34.8448],10,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\tank\tank_rust_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['PenBlack',[4013.69,4052.16,35.8533],329.432,[0,0,1]] call InitItem; 
['WoodenChair',[4013.45,4052.7,34.9895],359.967,[0,0,1]] call InitItem; 
['FabricBagBig2',[4014.31,4051.87,34.9908],259.732,[0,0,1]] call InitItem; 
['SmallDirtGrey',[4005.01,4052.33,39.5019,true],265,[-1.86265e-07,0,1]] call InitStruct; 
['SmallDirtGrey',[4002.64,4055.65,39.671,true],0.000147703,[-1.57946e-07,2.00795e-07,1]] call InitStruct; 
['LampWall',[4011.32,4055.18,44.4682,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall625366",_thisObj];
}] call InitStruct; 
['CandleDisabled',[4013.75,4051.58,35.8533],180,[0,0,1]] call InitItem; 
['CandleDisabled',[4013.61,4051.58,35.8533],180,[0,0,1]] call InitItem; 
['ToolPipe',[4009.08,4054.44,35.988],180.147,[0,0,1]] call InitItem; 
['Wrench',[4009.09,4054.93,35.9846],93.865,[0,0,1]] call InitItem; 
['Crowbar',[4009.1,4054.65,36.4358],0,[0,0,1]] call InitItem; 
['Sledgehammer1',[4006.7,4056.03,40.8657,true],[-0.330365,0.907674,0.258818],[0.0885207,-0.24321,0.965926]] call InitItem; 
['Sledgehammer',[4010.73,4054.56,35.812],40,[0,0,1]] call InitItem; 
['NewIndPipe90DegR',[4018.81,4053.87,35.3411],269.294,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[4013.47,4057.53,35.397],270,[0,0,1]] call InitStruct; 
['NewIndPipeUUP',[4000.71,4043.98,32.4896],178.112,[0,0,1]] call InitStruct; 
['IndPipe45DegL',[4004.09,4051.96,42.3324,true],[0.0871553,-0.996195,3.42149e-06],[0.996195,0.0871553,-8.69274e-08]] call InitStruct; 
['IndPipeValve',[4004.83,4042.45,37.3472],0,[0,0,1]] call InitStruct; 
['IndPipeValve',[4004.35,4048.28,37.312],180,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[4018.97,4053.78,34.6491],269.294,[0,0,1]] call InitStruct; 
['OrangeCarpet1',[4064.86,4070.26,31.0101],355,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4062.88,4067.37,30.9558],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4072.91,4070.25,34.9459],90.0003,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4073.72,4072.06,34.9398],105,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4062.72,4067.17,41.381,true],179.999,[-1.13994e-06,-2.47161e-06,-1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4068.76,4067.18,41.4317,true],179.999,[-1.13994e-06,-2.47161e-06,-1]] call InitStruct; 
_4069_080574066_8750030_79514 = ['SteelGridDoor',[4069.08,4066.88,30.7951],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RTorgDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4067_756104068_9772930_86520 = ['SteelGridDoor',[4067.76,4068.98,30.8652],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RTorgDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcreteWall',[4060.88,4071.25,31.7402],270,[0,0,1]] call InitStruct; 
['BigConcreteUnfinishedBuilding',[4066.25,4070.13,30.8652],0,[0,0,1]] call InitDecor; 
['RustyWindowFrameMeduim',[4061.63,4066.84,31.9574],0,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4064.33,4066.86,39.2315,true],1.75006e-07,[-5.36442e-07,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4066.15,4066.84,31.9562],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4071,4069.75,31.0502],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4070.38,4066.88,30.9902],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4067.75,4070.08,31.0502],270.001,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4069.25,4071.63,31.0502],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[4064,4075.13,31.9012],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4064.25,4071.75,31.0502],180,[0,0,1]] call InitStruct; 
['Wicket',[4065.22,4071.73,31.0507],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4064.26,4075.29,30.9548],180,[0,0,1]] call InitStruct; 
['LongRottenBoards',[4063.71,4067.5,31.87],270,[0,0,1]] call InitStruct; 
['LongRottenBoards',[4063.71,4066.97,31.88],90,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4068.86,4061.15,30.6581],90,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4059.21,4061.18,30.7302],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4068.85,4062.47,30.5192],95,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4059.18,4062.55,30.6264],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4065.25,4063.31,30.6933],185,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4062.55,4063.33,30.6932],1.62217e-05,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4067.4,4063.23,36.421,true],[3.82137e-15,-1,-8.74228e-08],[-1,0,-4.37114e-08]] call InitStruct; 
['SteelThinWallSmall',[4060.65,4063.24,36.6003,true],1.09558e-12,[1,0,1.19249e-08]] call InitStruct; 
['SteelCanopySmall1',[4067.52,4061.48,31.3858],90,[0,0,1]] call InitStruct; 
['SteelCanopySmall1',[4063.94,4061.54,31.3858],270,[0,0,1]] call InitStruct; 
['SteelCanopySmall1',[4060.37,4061.51,31.3858],90,[0,0,1]] call InitStruct; 
['BreadChopped',[4065.55,4067.23,32.4384],95,[0,0,1]] call InitItem; 
['BreadChopped',[4065.45,4067.18,32.4384],245,[0,0,1]] call InitItem; 
['BreadChopped',[4065.35,4067.24,32.4384],285,[0,0,1]] call InitItem; 
['BreadChopped',[4065.24,4067.18,32.4384],80,[0,0,1]] call InitItem; 
['BreadChopped',[4065.12,4067.22,32.4384],80,[0,0,1]] call InitItem; 
['BreadChopped',[4065.01,4067.17,32.4384],290,[0,0,1]] call InitItem; 
['Cutlet',[4065.08,4067.21,31.9994],295,[0,0,1]] call InitItem; 
['Cutlet',[4065.19,4067.24,31.996],0,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.15,4067.18,32.4368],0,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.1,4067.18,32.4368],195,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.04,4067.16,32.4368],195,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4061.99,4067.17,32.4368],170,[0,0,1]] call InitItem; 
['Lapsha',[4061.85,4067.15,32.4368],0,[0,0,1]] call InitItem; 
['Lapsha',[4061.67,4067.17,32.4368],0,[0,0,1]] call InitItem; 
['Lepeshka',[4062.43,4067.18,31.9868],0,[0,0,1]] call InitItem; 
['Lepeshka',[4062.24,4067.19,31.9868],300,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.88,4067.19,32.4384],190,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.83,4067.22,32.4384],180,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.78,4067.22,32.4384],175,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.72,4067.21,32.4384],185,[0,0,1]] call InitItem; 
['Bread',[4062.87,4071.37,32.1502],15,[0,0,1]] call InitItem; 
['Briefcase',[4066.81,4072.35,31.9287],100,[0,0,1]] call InitItem; 
['Briefcase',[4066.53,4067.19,32.9032],185,[0,0,1]] call InitItem; 
_4066_747314067_5549331_93539 = ['SteelBrownContainer',[4066.75,4067.55,31.9354],0,[0,0,1]] call InitItem; 
['SpirtBottle',[4062.04,4067.2,37.1215,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4062_497074067_1679732_43538 = ['SpirtBottle',[4062.5,4067.17,37.5723,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.67,4067.19,37.1209,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.89,4067.16,37.1225,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.78,4067.14,37.1217,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4062.37,4067.16,37.5674,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4062.24,4067.15,37.5727,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4066_442634067_1804231_98770 = ['SpirtBottle',[4066.44,4067.18,37.1247,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.31,4067.2,37.1197,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.2,4067.17,37.1251,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4066_913824067_1801832_43532 = ['SpirtBottle',[4066.91,4067.18,37.5723,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.8,4067.23,37.5674,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.72,4067.17,37.5727,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['Bun',[4066.54,4067.18,32.4385],200,[0,0,1]] call InitItem; 
['Bun',[4066.39,4067.21,32.4385],180,[0,0,1]] call InitItem; 
['Bun',[4066.26,4067.2,32.4385],195,[0,0,1]] call InitItem; 
['CoinBag',[4061.79,4067.16,32.8868],230,[0,0,1]] call InitItem; 
['CoinBag',[4061.97,4067.17,32.8868],0,[0,0,1]] call InitItem; 
['CoinBag',[4062.18,4067.15,32.8868],250,[0,0,1]] call InitItem; 
['ShuttleBag',[4061.64,4068.85,31.9066],0,[0,0,1]] call InitItem; 
['SmallBackpack',[4061.49,4069.27,31.8139],105,[0,0,1]] call InitItem; 
['Butter',[4063.25,4071.37,32.1479],315,[0,0,1]] call InitItem; 
['SmallBackpack',[4063.58,4071.36,32.1406],0,[0,0,1]] call InitItem; 
['SmallBackpack',[4063.89,4071.36,32.1358],340,[0,0,1]] call InitItem; 
['BrushCleaner',[4063.58,4071.35,31.8513],40,[0,0,1]] call InitItem; 
['Suitcase',[4064.58,4071.39,31],350,[0,0,1], {go_editor_globalRefs set ["MoneyTorgCase",_thisObj];
}] call InitItem; 
['ToolStraigthPipe',[4067.4,4068.09,36.4849,true],6.51908e-09,[-0.939693,0,0.34202]] call InitItem; 
['Shavirma',[4065.83,4067.2,31.9884],210,[0,0,1]] call InitItem; 
['Shavirma',[4065.63,4067.19,31.9884],20,[0,0,1]] call InitItem; 
['Shavirma',[4065.47,4067.18,31.9884],205,[0,0,1]] call InitItem; 
['SmallChair',[4062.03,4069.69,30.9564],75,[0,0,1]] call InitItem; 
['MatchBox',[4062.93,4071.32,31.8513],0,[0,0,1]] call InitItem; 
['Muka',[4063.39,4072.09,32.1939],10,[0,0,1]] call InitItem; 
['Muka',[4063.09,4072.18,37.3268,true],[-8.14188e-15,1,1.86265e-07],[-1,0,-4.37114e-08]] call InitItem; 
_4063_653324072_1203631_86020 = ['PenBlack',[4063.65,4072.12,31.8602],280,[0,0,1]] call InitItem; 
['MetalCup',[4063.27,4072.18,31.492],0,[0,0,1]] call InitItem; 
['MilkBottle',[4062.82,4072.23,32.2153],0,[0,0,1]] call InitItem; 
['MilkBottle',[4062.67,4072.13,32.2153],0,[0,0,1]] call InitItem; 
['GlassBottle',[4064.25,4072.23,31.1512],0,[0,0,1]] call InitItem; 
['GlassBottle',[4063.99,4072.18,31.1512],0,[0,0,1]] call InitItem; 
['GlassBottle',[4063.79,4072.23,31.1512],0,[0,0,1]] call InitItem; 
['Cup',[4063.73,4072.15,32.2153],0,[0,0,1]] call InitItem; 
['CuttingBoard',[4061.9,4073.33,31.8804],10,[0,0,1]] call InitItem; 
['Kastrula',[4063.32,4072.19,31.1512],0,[0,0,1]] call InitItem; 
['Kastrula',[4063.01,4072.19,31.1512],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4062.82,4071.32,32.5147],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4063.32,4071.37,32.5142],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4063.55,4071.44,32.5141],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.3) then {
	['Meat',[4064.08,4072.02,31.0396],230,[0,0,1]] call InitItem; 
};
['FoodPlate',[4063.65,4072.2,31.5099],0,[0,0,1]] call InitItem; 
['MeatChopped',[4064.26,4072.11,32.2153],335,[0,0,1]] call InitItem; 
['MeatMinced',[4064.07,4072.14,32.2153],0,[0,0,1]] call InitItem; 
['MeatMinced',[4063.97,4072.12,32.2153],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.97,4072.19,31.5099],0,[0,0,1]] call InitItem; 
['PepperShaker',[4063.1,4072.23,31.5099],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.85,4072.24,31.5099],0,[0,0,1]] call InitItem; 
['PepperShaker',[4063.05,4072.12,31.5099],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.86,4072.13,31.5099],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.97,4072.21,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.77,4072.25,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.77,4072.1,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.07,4072.17,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.9,4072.13,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.2,4072.25,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.86,4072.27,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.98,4072.09,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.19,4072.13,31.8602],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.05,4072.26,31.8602],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.68,4072.2,31.8602],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.56,4072.15,31.8602],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.49,4072.23,31.8602],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.65,4072.11,31.8602],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.8,4072.19,31.8602],0,[0,0,1]] call InitItem; 
['FryingPan',[4061.78,4073.96,31.861],245,[0,0,1]] call InitItem; 
['SoupPlate',[4062.62,4072.24,31.1512],0,[0,0,1]] call InitItem; 
['SoupPlate',[4062.59,4072.2,31.5086],0,[0,0,1]] call InitItem; 
['WoodenCup',[4063.07,4071.33,32.5115],0,[0,0,1]] call InitItem; 
['MatchBox',[4062.83,4071.34,31.8513],15,[0,0,1]] call InitItem; 
['WoodenChair',[4070.68,4070.95,36.2253,true],[0.173648,0.984808,1.27118e-07],[-0.984808,0.173648,-9.0392e-08]] call InitItem; 
['WoodenChair',[4070.56,4070.9,30.954],10,[0,0,1]] call InitItem; 
['MatchBox',[4065.59,4073.75,31.8079],15,[0,0,1]] call InitItem; 
['Egg',[4063.41,4072.2,31.8602],0,[0,0,1]] call InitItem; 
['Egg',[4063.2,4072.25,31.8602],0,[0,0,1]] call InitItem; 
['Egg',[4062.98,4072.17,31.8602],0,[0,0,1]] call InitItem; 
['Egg',[4061.4,4072.58,31.8722],0,[0,0,1]] call InitItem; 
['Bucket1',[4062.52,4074.44,31.0136],0,[0,0,1]] call InitItem; 
['Bucket2',[4063.81,4074.61,31.0128],0,[0,0,1]] call InitItem; 
['BrushCleaner',[4063.77,4071.39,31.8439],0,[0,0,1]] call InitItem; 
_4061_627934070_0376031_81717 = ['Key',[4061.63,4070.04,31.8172],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RTorgDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['MeatMinced',[4064,4072.22,32.2206],275,[0,0,1]] call InitItem; 
['MeatMinced',[4063.9,4072.2,32.218],345,[0,0,1]] call InitItem; 
['FabricBagBig2',[4067.08,4073.26,31.0142],175,[0,0,1]] call InitItem; 
['SmallSteelTable1',[4061.8,4065.78,30.8513],95,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4061.65,4068.63,30.9563],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4061_824954070_8850130_95625 = ['SteelGreenCabinet',[4061.82,4070.89,30.9563],30,[0,0,1]] call InitStruct; 
['WoodenSmallShelf',[4063.39,4071.38,31.0862],90,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4066.86,4072.48,30.9553],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BedOld2',[4066.26,4070.54,31.0226],2.56132e-06,[0,0,1], {go_editor_globalRefs set ["RTorgDormBed",_thisObj];
}] call InitStruct; 
['Shelves',[4065.44,4067.18,31.4384],0,[0,0,1]] call InitStruct; 
['Shelves',[4066.54,4067.18,31.4385],0,[0,0,1]] call InitStruct; 
['Shelves',[4062.08,4067.18,31.4368],0,[0,0,1]] call InitStruct; 
['SmallSteelTable',[4061.54,4069.63,31.012],265,[0,0,1]] call InitStruct; 
_4066_609384061_2426830_83279 = ['SmallSteelTable1',[4066.61,4061.24,36.2678,true],86.7988,[-0.00142894,0.00692951,0.999975]] call InitStruct; 
['SteelSmallShelf',[4063.38,4072,30.956],270,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4061.63,4073.38,30.9902],90,[0,0,1]] call InitStruct; 
['Umivalnik',[4063.36,4074.45,30.9562],185,[0,0,1]] call InitStruct; 
['SofaBrown',[4068.07,4061.39,30.8749],265,[0,0,1]] call InitStruct; 
['BrownLeatherChair',[4065.49,4060.76,30.888],65,[0,0,1]] call InitStruct; 
['SmallChair1',[4060.97,4065.99,30.8739],280,[0,0,1]] call InitItem; 
['GreenArmChair',[4066.6,4065.86,30.8628],75,[0,0,1]] call InitStruct; 
['ChairLibrary',[4068.2,4071.15,30.9547],265,[0,0,1]] call InitItem; 
['WoodenAncientBench',[4058.77,4061.53,31.0182],90,[0,0,1]] call InitStruct; 
['WoodenSmallBench',[4057.39,4060.15,30.9933],180,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4060.32,4061.47,36.2458,true],90,[-0.00161855,0.00659637,0.999977]] call InitStruct; 
['MediumWoodenTable1',[4070.24,4069.5,31.0144],265.001,[0,0,1]] call InitStruct; 
['WoodenChair',[4062.52,4065.95,35.8623,true],80,[-0.00584073,-0.00677742,0.99996]] call InitItem; 
['TrashCan',[4063,4063.71,30.8802],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallStoveGrill',[4064.28,4074.33,30.8652],105,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['BlackSmallStove',[4066.63,4073.38,31.0502],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LIGHT_BAKE" call lightSys_getConfigIdByName];}] call InitStruct; 
['PosterWorkplaceClean',[4065.17,4074.94,32.5725],180,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[4063.8,4059.86,31.1696],275,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4003.16,4037.17,35.8464],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['DirtCraterLong',[4000.07,4033.85,40.7223,true],0,[-0.00566278,0.00693103,0.99996]] call InitStruct; 
['WoodenDoor',[3991.36,4027.21,36.3935],180,[0,0,1]] call InitStruct; 
_4005_875004027_3750036_11520 = ['WoodenDoor',[4005.88,4027.38,36.1152],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RPriyatelDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MediumWoodenTable',[3995.78,4023.06,36.3119],0,[0,0,1], {go_editor_globalRefs set ["AntagMoneyCasePoint",_thisObj];
}] call InitStruct; 
['StoneWall',[4013.15,4033.47,36.1152],270,[0,0,1]] call InitStruct; 
['StoneWall',[4013.12,4035.96,36.2155],270,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall',[3990.88,4023.74,36.2402],0,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall1',[4005.25,4023.83,35.9902],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4010.03,4025.45,36.0653],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[3992.68,4020.75,36.2995],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4007.43,4020.78,36.0495],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4013.13,4025.05,37.5239],90.0001,[0,0,1]] call InitStruct; 
['WoodenChair',[3994.95,4022.72,36.2995],250,[0,0,1]] call InitItem; 
['WoodenSmallShelf',[4009.55,4023.39,36.1333],90,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[4009.43,4021.69,36.0635],85,[0,0,1], {go_editor_globalRefs set ["RPriyatelDormBed",_thisObj];
}] call InitStruct; 
['SingleWhiteBed',[4008.45,4036.67,35.8515],355,[0,0,1], {go_editor_globalRefs set ["RLekarDormBed",_thisObj];
}] call InitStruct; 
['CaseBedroom',[4007.26,4037.72,35.847],265.034,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['GreenArmChair',[4006.25,4037.29,35.8509],0,[0,0,1]] call InitStruct; 
['SmallBrickHouse',[4006,4035,35.2574],270,[0,0,1]] call InitStruct; 
_4005_194584033_4079635_84485 = ['SteelGreenDoor',[4005.19,4033.41,35.8449],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RLekarDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelThinWallMedium',[3998.25,4027.25,35.4902],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4011.88,4027.25,35.4902],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3988.13,4020.71,36.2995],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4004.49,4038.01,35.8583],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3985.38,4022.45,36.2995],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3987.12,4027.22,36.2995],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3989.99,4025.22,36.2995],270,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3999.59,4022.67,36.0495],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4004.42,4025.35,36.0495],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4001.55,4027.27,36.0495],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4009.26,4034.98,35.5268],270,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4011.13,4034.57,35.7442],8.53774e-07,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3994.52,4027.71,35.5395],70,[0,0,1]] call InitStruct; 
['ClayWallSmall',[4009.2,4023.84,36.4843],0,[0,0,1]] call InitStruct; 
['LongWoodenLadder',[4012.44,4030.25,34.2836],180,[0,0,1]] call InitStruct; 
['BedOld2',[3991.37,4022.23,36.3317],175,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3993.68,4026.59,36.3075],90.0001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallSteelTable',[4007.32,4026.7,36.0629],0,[0,0,1]] call InitStruct; 
['SmallSteelTable1',[4003.45,4035.73,41.2796,true],270,[-0.00103742,0.00699736,0.999975]] call InitStruct; 
['Wicket',[4013.12,4030.46,36.0167],0,[0,0,1]] call InitStruct; 
['SmallChair',[4009.23,4025.41,36.0495],285,[0,0,1]] call InitItem; 
['SmallChair',[4004.25,4035.9,40.8504,true],75,[0.00281125,-0.00648951,0.999975]] call InitItem; 
['BigClothCabinet',[3993.56,4021.19,36.316],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigClothCabinet',[4005.15,4021.75,36.0613],250,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SpirtBottle',[4010.62,4022.21,36.0804],0,[0,0,1]] call InitItem; 
_4008_528814022_6792036_08043 = ['SpawnPoint',[4008.53,4022.68,36.0804],120,[0,0,1]] call InitStruct; 
['SteelBrownContainer',[4010.05,4025.05,36.0804],35,[0,0,1], {go_editor_globalRefs set ["AlkoBox",_thisObj];
}] call InitItem; 
['PenBlack',[4003.65,4035.89,36.714],295,[0,0,1]] call InitItem; 
_4007_289314036_3161635_85827 = ['SpawnPoint',[4007.29,4036.32,35.8583],45,[0,0,1]] call InitStruct; 
['LiqTovimin',[4003.22,4035.24,36.7178],0,[0,0,1]] call InitItem; 
['LiqPainkiller',[4003.14,4035.58,36.7154],0,[0,0,1]] call InitItem; 
['LiqDemitolin',[4003.44,4035.26,36.7179],0,[0,0,1]] call InitItem; 
_4003_508544033_3056637_17892 = ['WallmountedMedicalCabinet',[4003.51,4033.31,37.1789],180,[0,0,1]] call InitStruct; 
['MedicalBag',[4003.36,4036.2,36.7121],75,[0,0,1]] call InitItem; 
['Crutch',[4005.5,4037.42,41.4328,true],[-8.45339e-07,-1,-2.32255e-06],[-0.939693,0,0.34202]] call InitItem; 
['Syringe',[4003.31,4035.43,36.7158],75,[0,0,1]] call InitItem; 
['PaperHolder',[4003.71,4035.22,36.7182],0,[0,0,1]] call InitItem; 
['SmallSteelRustyFence',[4007.91,4033.49,36.9202],90,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3978.71,4033.32,42.6593,true],0,[0.0025838,0,0.999997]] call InitStruct; 
['DoubleCitizenBed1',[3980.29,4029.95,40.0652],272.903,[0,0,1]] call InitStruct; 
['PaperHolder',[3978.47,4033.82,43.168,true],0,[0.0025838,0,0.999997]] call InitItem; 
['Paper',[3978.4,4033.48,43.0951,true],0,[0.0025838,0,0.999997]] call InitItem; 
['SteelGridDoor',[3977.47,4032.06,39.9345],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKletKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['PenRed',[3978.64,4033.41,43.0997,true],123.955,[-0.00143704,-0.00212842,0.999997]] call InitItem; 
['PenBlack',[3978.54,4033.27,43.1003,true],323.788,[0.00207931,0.00152539,0.999997]] call InitItem; 
['WoodenAncientBench',[3979.6,4034.26,40.1394],0,[0,0,1]] call InitStruct; 
['WoodenChair',[3977.9,4033.78,37.2658],287.129,[0,0,1]] call InitItem; 
['WoodenChair',[3979.66,4033.31,37.248],94.1255,[0,0,1]] call InitItem; 
['MetalCup',[3978.91,4030.02,38.3532],0,[0,0,1]] call InitItem; 
['HospitalBed',[3975.62,4029.78,42.8346,true],270.685,[2.46207e-05,0.00255372,0.999997], {go_editor_globalRefs set ["RUchastDormBed",_thisObj];
}] call InitStruct; 
_3974_669684030_6586937_18520 = ['CaseBedroom',[3974.67,4030.66,42.1852,true],180.922,[-0.00257779,5.20634e-05,0.999997], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Cup',[3978.38,4033.05,43.1445,true],0,[0.0025838,0,0.999997]] call InitItem; 
['HospitalBench',[3981.3,4031.49,37.2908],90.8706,[0,0,1]] call InitStruct; 
['RustyCell',[3977.5,4032.14,40.1199],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3981.39,4033.69,37.3176],359.513,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3977_916754034_9587438_64833 = ['WallmountedMedicalCabinet',[3977.92,4034.96,43.6483,true],0,[0.0025838,0,0.999997]] call InitStruct; 
['BigClothCabinet',[3974.65,4031.7,42.2848,true],269.185,[-4.5079e-05,0.00257916,0.999997], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['LargeTwoStoreyStoneHouse',[3979.54,4033.02,37.1152],180,[0,0,1]] call InitStruct; 
_3981_853764029_6223137_18520 = ['SteelBrownDoor',[3981.85,4029.62,37.1852],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelThinWallSmall',[3974.26,4031.5,40.1052],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3974.19,4029.71,40.0652],270,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3976.56,4034.79,40.0652],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3983.47,4030,35.7627],0,[0,0,1]] call InitStruct; 
['Briefcase',[3978.46,4034.19,38.0923],0,[0,0,1]] call InitItem; 
['SmallDirtGrey',[3977.05,4037.02,35.5417],90,[0,0,1]] call InitStruct; 
_3976_616704034_7785637_30444 = ['SteelBrownDoor',[3976.62,4034.78,37.3044],0.000475552,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3974.74,4026.31,35.6129],5,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3979.85,4023.65,35.5882],5,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3978.33,4029.77,40.1037],355,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MatchBox',[3981.04,4031.8,41.0225],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.4) then {
	['Crowbar',[3981.32,4029.82,45.1447,true],55,[0.00148088,-0.00211316,0.999997]] call InitItem; 
};
['SteelCanopySmall',[3976.38,4025.62,36.0853],0,[0,0,1]] call InitStruct; 
['TinBigFence',[3980.55,4024.88,35.8249],270,[0,0,1]] call InitStruct; 
['TinBigFence',[3980.52,4024.89,37.4902],270,[0,0,1]] call InitStruct; 
['WoodenChair',[3980.56,4031.87,40.0652],225,[0,0,1]] call InitItem; 
['WoodenChair',[3981.18,4032.96,46.5407,true],[-0.0871615,0.996194,7.53972e-06],[-3.02838e-06,7.30355e-06,-1]] call InitItem; 
['WoodenWeaponBox',[3974.79,4024.93,35.5968],75,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3981_222414032_2087441_02331 = ['CoinBag',[3981.22,4032.21,41.0233],0,[0,0,1]] call InitItem; 
['RedSteelBox',[3978.32,4029.84,41.0562],310,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['RedCarpet1',[3979.62,4033.81,40.1213],175,[0,0,1]] call InitStruct; 
_3976_000004034_2500040_17519 = ['CaseBedroomSmall',[3976,4034.25,40.1752],265.001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MediumPileOfDirtAndStones',[3977.95,4019.35,42.1932,true],0,[-0.00566278,0.505982,0.862525]] call InitStruct; 
['LampKeroseneDisabled',[3981.27,4031.94,41.0207],5,[0,0,1]] call InitItem; 
_3979_621344034_0034240_16192 = if ((random 1) < 0.5) then {
	['Key',[3979.62,4034,45.1661,true],120,[-0.00128955,-0.0022338,0.999997], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKletKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
};
_3974_891364021_7397535_64085 = ['WoodenToiletSmall',[3974.89,4021.74,35.6409],80,[0,0,1]] call InitStruct; 
_3974_786134033_5002437_28997 = ['SteelGreenCabinet',[3974.79,4033.5,37.29],355,[0,0,1]] call InitStruct; 
['Lockpick',[3981.13,4032.97,41.0233],25,[0,0,1]] call InitItem; 
['Lockpick',[3981.11,4032.91,41.0233],315,[0,0,1]] call InitItem; 
['SmallWoodenTableHandmade',[3981.18,4032.27,40.0652],85,[0,0,1]] call InitStruct; 
_3980_522714022_0053735_60637 = ['Wicket',[3980.52,4022.01,35.6064],0,[0,0,1]] call InitStruct; 
['BedOld',[3974.63,4033.5,40.1152],0,[0,0,1], {go_editor_globalRefs set ["RUchastHelperDormBed",_thisObj];
}] call InitStruct; 
['RopeItem',[3976.11,4034.24,40.7365],50,[0,0,1]] call InitItem; 
_3977_878424034_2717340_04393 = ['ClayPot',[3977.88,4034.27,45.3916,true],335,[-0.0080614,0.00388847,0.99996]] call InitStruct; 
['Baton1',[3978.41,4032.81,43.1003,true],110,[-0.000882034,-0.00242406,0.999997]] call InitItem; 
['Baton1',[3975.92,4034.1,40.738],0,[0,0,1]] call InitItem; 
_3976_761474026_5017135_60740 = ['LongWeaponContainer',[3976.76,4026.5,40.6074,true],0,[0.00699926,0.00103578,0.999975], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['HouseWithGarageSmall1',[3992.13,4035.06,35.8652],180,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3987.24,4035.65,35.9385],0,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3993.71,4036.88,35.9245],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[3989.5,4038.05,35.9245],0,[0,0,1]] call InitStruct; 
['BigRedEdgesRack',[3997.13,4034.61,35.9407],270,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3991.95,4036.68,35.9245],355,[0,0,1], {go_editor_globalRefs set ["RRostDorm",_thisObj];
}] call InitStruct; 
['SingleWhiteBed',[3996.77,4036.67,35.9378],355,[0,0,1], {go_editor_globalRefs set ["RDolgDormBed",_thisObj];
}] call InitStruct; 
['ChairLibrary',[3988.19,4035.66,35.9506],0,[0,0,1]] call InitItem; 
['ChairLibrary',[3994.47,4036.85,35.9506],0,[0,0,1]] call InitItem; 
['SteelThinWallSmall',[3994.8,4038.17,35.9245],0,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3989.86,4032.3,35.9375],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen',[3997.08,4032.56,35.9398],185,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigClothCabinet',[3989.23,4037.62,35.9416],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3991_640634031_6001035_92449 = ['WoodenDoor',[3991.64,4031.6,35.9245],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RRostDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Notepad',[3987.47,4035.72,36.8031],165,[0,0,1]] call InitItem; 
['RedCarpet',[3990.83,4034.94,35.3655],0,[0,0,1]] call InitStruct; 
['PaperHolder',[3987.3,4034.9,36.8031],0,[0,0,1]] call InitItem; 
['Paper',[3987.34,4035.19,36.8031],0,[0,0,1]] call InitItem; 
['Paper',[3987.29,4035.43,36.8031],340,[0,0,1]] call InitItem; 
['OfficeCabinet',[3992.49,4034.88,35.9553],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['PenBlack',[3987.47,4035.72,36.8139],0,[0,0,1]] call InitItem; 
['OrangeCarpet1',[3995.35,4036.44,35.9397],0,[0,0,1]] call InitStruct; 
['RedCarpetWall',[3993.14,4036.13,37.7153],0,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3995.86,4031.68,36.7164],90,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3987.99,4032.16,35.9554],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['RustyWindowFrameMeduim',[3997.75,4034.88,37.192],270,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[3986.38,4034.37,37.2016],90.0001,[0,0,1]] call InitStruct; 
['PosterGirl',[3986.69,4035.72,42.6481,true],[1.19249e-08,-7.58967e-07,-1],[1,0,1.19249e-08]] call InitStruct; 
_4040_877934021_7102130_99020 = ['SpawnPoint',[4040.88,4021.71,30.9902],146,[0,0,1]] call InitStruct; 
_4027_799074031_1333030_99129 = ['SpawnPoint',[4027.8,4031.13,30.9913],150,[0,0,1]] call InitStruct; 
_4038_526864031_0869133_92296 = ['SpawnPoint',[4038.53,4031.09,33.923],175,[0,0,1]] call InitStruct; 
_4035_017334031_2895533_92296 = ['SpawnPoint',[4035.02,4031.29,33.923],85,[0,0,1]] call InitStruct; 
_4030_096924033_0385733_94363 = ['SpawnPoint',[4030.1,4033.04,33.9436],35,[0,0,1]] call InitStruct; 
_4046_051514032_9072333_92296 = ['SpawnPoint',[4046.05,4032.91,33.923],320,[0,0,1]] call InitStruct; 
_4046_945564022_4687534_02227 = ['SpawnPoint',[4046.95,4022.47,34.0223],140,[0,0,1]] call InitStruct; 
_4044_670654022_3674334_02095 = ['SpawnPoint',[4044.67,4022.37,34.021],220,[0,0,1]] call InitStruct; 
_4065_510254070_0705631_05020 = ['SpawnPoint',[4065.51,4070.07,31.0502],20,[0,0,1]] call InitStruct; 
_3976_206544030_7785637_31403 = ['SpawnPoint',[3976.21,4030.78,37.314],241.65,[0,0,1]] call InitStruct; 
_3990_947754035_8142135_95543 = ['SpawnPoint',[3990.95,4035.81,35.9554],30,[0,0,1]] call InitStruct; 
_3995_703614035_9272535_95543 = ['SpawnPoint',[3995.7,4035.93,35.9554],30,[0,0,1]] call InitStruct; 
_3994_949224063_2680730_96692 = ['CollectionSpawnPoint',[3994.95,4063.27,30.9669],45,[0,0,1]] call InitStruct; 
_3985_375004067_7500030_87143 = ['CollectionSpawnPoint',[3985.38,4067.75,30.8714],280,[0,0,1]] call InitStruct; 
_3997_438724046_3418030_99571 = ['CollectionSpawnPoint',[3997.44,4046.34,30.9957],30,[0,0,1]] call InitStruct; 
_4012_829594047_0022031_03477 = ['CollectionSpawnPoint',[4012.83,4047,31.0348],325,[0,0,1]] call InitStruct; 
_4056_398684055_7150931_90103 = ['CollectionSpawnPoint',[4056.4,4055.72,31.901],320,[0,0,1]] call InitStruct; 
_4077_467534076_2241230_99490 = ['CollectionSpawnPoint',[4077.47,4076.22,30.9949],340,[0,0,1]] call InitStruct; 
_4082_726324071_6984930_96336 = ['CollectionSpawnPoint',[4082.73,4071.7,30.9634],90,[0,0,1]] call InitStruct; 
_4075_615974070_1220731_05119 = ['CollectionSpawnPoint',[4075.62,4070.12,31.0512],310,[0,0,1]] call InitStruct; 
_3976_000004033_0000040_17519 = ['SpawnPoint',[3976,4033,40.1752],320,[0,0,1]] call InitStruct; 
_3965_754884047_4077131_38000 = ['SpawnPoint',[3965.75,4047.41,31.38],65,[0,0,1]] call InitStruct; 
_3952_661624043_9658231_38000 = ['SpawnPoint',[3952.66,4043.97,31.38],220,[0,0,1]] call InitStruct; 
_3954_481454044_1167031_37500 = ['SpawnPoint',[3954.48,4044.12,31.375],140,[0,0,1]] call InitStruct; 
['SmallSteelTable1',[4081.3,4069.66,30.7085],269.998,[0,0,1], {go_editor_globalRefs set ["TaskMoneyCaseTable",_thisObj];
}] call InitStruct; 
['SmallSheetMetalHouse1',[4082.33,4069.82,32.3795],2.13443e-06,[0,0,1]] call InitStruct; 
['MotherBunchOfShit',[4085.55,4008.25,27.7578,true],0,[0.174679,-0.00713907,0.9846]] call InitStruct; 
['BunchOfShit',[4086.13,4015.25,22.9902],305,[0,0,1]] call InitStruct; 
['BunchOfShit',[4083.34,4013.93,28.3428,true],[-0.739941,0.620887,0.258818],[0.357877,0.0375705,0.933013]] call InitStruct; 
['BunchOfShit',[4081.38,4007.13,28.8718,true],[0.34202,0.939693,-5.36442e-07],[0.24321,-0.0885207,0.965926]] call InitStruct; 
['DirtCraterLong',[4081.28,4011.25,29.0501,true],135.954,[0.260379,-0.00659992,0.965484]] call InitStruct; 
['DirtCraterLong',[4073.83,4014.43,29.4355,true],20.0837,[-0.0145697,0.0271876,0.999524]] call InitStruct; 
['SmallStoneRoad',[4066.38,4017.65,29.8313,true],347,[-0.00658753,-0.00258136,0.999975]] call InitStruct; 
['SmallStoneRoad',[4068.57,4014.23,29.8408,true],311.001,[-0.00381412,-0.00595258,0.999975]] call InitStruct; 
['SmallStoneRoad',[4065.87,4021.79,29.8264,true],352,[-0.00678747,-0.0019982,0.999975]] call InitStruct; 
['SmallStoneRoad',[4065.66,4026.89,30.7536,true],0,[0,-0.258819,0.965926]] call InitStruct; 
['SmallStoneRoad',[4065.53,4032.02,32.3553,true],0,[0,-0.422618,0.906308]] call InitStruct; 
['SmallStoneRoad',[4065.69,4036.26,34.3487,true],[0.173648,0.892539,0.416198],[0,-0.422618,0.906308]] call InitStruct; 
['SmallStoneRoad',[4066.73,4042.23,35.8419,true],6.99961,[-0.00658753,-0.00258136,0.999975]] call InitStruct; 
['BunchOfShit',[4065.8,4012.3,23.4849],85,[0,0,1]] call InitStruct; 
['BunchOfShit',[4071.08,4012.49,23.4794],85,[0,0,1]] call InitStruct; 
['BunchOfShit',[4075.93,4012.43,23.5483],265,[0,0,1]] call InitStruct; 
['Shovel',[4070.06,4009.2,30.2199,true],[0,0.258811,-0.965928],[0,0.965928,0.258811]] call InitItem; 
['Grave2',[4069.5,4007.75,24.8652],85,[0,0,1]] call InitStruct; 
['OldTombstoneGrave',[4070.63,4016.75,24.8652],15,[0,0,1]] call InitStruct; 
['Grave3',[4072.63,4008.2,24.8652],90,[0,0,1]] call InitStruct; 
['Grave1',[4063.56,4008.1,24.7402],95,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4072.63,4008.2,24.8652],180,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4070.5,4016.63,24.9902],15.0003,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4076.13,4008.16,25.1152],175,[0,0,1]] call InitStruct; 
['OldGraveFence2',[4069.5,4007.75,24.8652],175,[0,0,1]] call InitStruct; 
['OldGraveFence2',[4074.13,4015.75,24.8652],15.0003,[0,0,1]] call InitStruct; 
['OldGraveFence',[4063.57,4008.22,24.8652],185,[0,0,1]] call InitStruct; 
['OldGraveFence',[4064.17,4016.6,24.9902],265.001,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4065.98,4007.84,24.8652],180,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4064,4013.85,24.7402],270.001,[0,0,1]] call InitStruct; 
['OldTombstone3',[4075.5,4007.28,24.9902],175,[0,0,1]] call InitStruct; 
['OldTombstone',[4077,4007.28,24.8652],0,[0,0,1]] call InitStruct; 
['OldTombstone2',[4072.63,4007.2,24.8652],175,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[4067.13,4019.75,24.8652],270,[0,0,1]] call InitStruct; 
['TinBigFence',[4063.38,4019.5,25.1152],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4069.13,4019.75,25.1152],175,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4066.56,4004.52,31.2595,true],0.176103,[-0.00597826,0.42115,0.906971]] call InitStruct; 
['MediumPileOfDirtAndStones',[4073.76,4004.79,30.7756,true],0.176103,[-0.00597826,0.42115,0.906971]] call InitStruct; 
['MediumPileOfDirtAndStones',[4060.5,4010.12,31.271,true],[0.906991,-0.00278756,-0.42114],[0.421149,0.00597987,0.906972]] call InitStruct; 
['MediumPileOfDirtAndStones',[4060.98,4018.94,30.7727,true],[0.903297,-0.0818265,-0.42114],[0.420067,-0.0307482,0.906972]] call InitStruct; 
['TreeRoots',[4079.55,4007.52,31.6769,true],0,[0.173648,0,0.984808]] call InitStruct; 
['TreeRootsNoGeom',[4085.36,4014.84,34.9678,true],[-0.540973,0.836518,0.0870975],[-0.25,-0.258818,0.933013]] call InitStruct; 
['SmallDirtBrown',[4075.31,4010.73,29.1009,true],[0.977892,0.190809,0.0855545],[-0.0871557,0,0.996195]] call InitStruct; 
['Grave4',[4065.98,4007.71,29.9621,true],180,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['Tumannik',[4086.71,4007.46,28.7535,true],[-0.286553,0.769942,-0.570154],[-0.751697,0.188287,0.63206]] call InitItem; 
['Tumannik',[4083.15,4014.07,29.7249,true],[0.0466238,0.844885,0.532912],[0.152036,-0.533279,0.832165]] call InitItem; 
['Meatflower',[4066.07,4007.81,30.6985,true],[0.341282,0.937665,-0.0656632],[0.104027,0.0317503,0.994068]] call InitItem; 
['TreeRoots1',[4062.1,4012,23.2023],255,[0,0,1]] call InitStruct; 
['Candle',[4072.59,4007.97,25.2507],0,[0,0,1]] call InitItem; 
['Candle',[4069.51,4007.76,30.2929,true],0,[-0.0154596,-0.00693025,0.999856]] call InitItem; 
['Candle',[4063.6,4007.91,30.1588,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['Candle',[4070.49,4016.43,25.3152],0,[0,0,1]] call InitItem; 
['Wicket',[4066.25,4019.53,25.1152],90.0003,[0,0,1]] call InitStruct; 
['TreeRoots2',[4065.54,4020.42,22.9996],180,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4069.26,4009.62,29.3379,true],180,[0.00658776,0.00161472,0.999977]] call InitStruct; 
['WoodenPlanksGarbage',[4067.07,4035,33.5201,true],[-0.258819,0.933013,0.249999],[0,-0.258818,0.965926]] call InitStruct; 
['ConcreteGarbage',[4063.96,4027.85,31.1796,true],[0.996195,0.084186,0.0225576],[0,-0.258819,0.965926]] call InitStruct; 
['SheetMetalGarbage',[4081.07,4014.46,25.1935],265,[0,0,1]] call InitStruct; 
['SheetMetalGarbage1',[4064.42,4039.98,30.4969],250,[0,0,1]] call InitStruct; 
_4087_000004011_0000017_86520 = ['EffectAsStruct',[4087,4011,17.8652],0,[0,0,1]] call InitStruct; // Effect
['BrickThinWallDoorwayWindow',[4068.5,4053.38,30.8555],0,[0,0,1]] call InitStruct; 
_4069_708984053_2189930_60897 = ['SteelGreenDoor',[4069.71,4053.22,30.609],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4067.53,4057.32,30.9375],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[4069.11,4057.32,30.9368],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4067_299804053_3750032_34671 = ['IStruct',[4067.3,4053.38,37.3532,true],[-0.996774,-0.0802532,-5.29794e-06],[-0.0802519,0.996759,-0.00565548], {_thisObj setvariable ['model','metro_ob\model\l19_cell_type_03.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigClothCabinet1',[4066.14,4057.17,37.1346,true],180,[0.00699259,0.00103492,0.999975], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenOfficeTable4',[4067.34,4054.06,30.773],90.0006,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[4070.91,4056.78,35.97,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['SmallChair',[4067.14,4054.85,30.8926],0,[0,0,1]] call InitItem; 
['SteelThinWallBig',[4068.59,4055.13,38.8412,true],[-4.37114e-08,6.71544e-07,1],[-1,0,-4.37114e-08]] call InitStruct; 
['BrickThinWall',[4071.63,4056.23,30.8652],270,[0,0,1]] call InitStruct; 
['MediumLightConcretePole',[4017.56,4031.85,31.7339],15.0003,[0,0,1]] call InitStruct; 
['WoodenTableHandmade',[4016.31,4032.67,31.2411],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4018.38,4036.63,36.4638,true],0,[0.34202,0,0.939693], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenLadder',[4018.65,4035.78,30.8165],275,[0,0,1]] call InitStruct; 
['WoodenGridDoor',[4017.78,4033.73,31.3189],270,[0,0,1]] call InitStruct; 
['ShortRottenBoards',[4019.89,4033.89,36.0356,true],[-0.992404,-0.0871533,0.0868239],[0.0871556,0,0.996195]] call InitStruct; 
['BrickThinWallDoorway',[4017.67,4034.96,31.2356],270,[0,0,1]] call InitStruct; 
['WoodenSmallBench',[4019.65,4037.34,30.9627],295,[0,0,1]] call InitStruct; 
['BigLightWall',[4015.72,4035.19,38.6918,true],[1.19249e-08,-2.90473e-06,-1],[1,0,1.19249e-08]] call InitStruct; 
['SingleWhiteBed',[4016.36,4037.08,31.2384],90,[0,0,1]] call InitStruct; 
['Bucket',[4017.36,4034.58,31.234],0,[0,0,1]] call InitItem; 
['Bucket',[4014.37,4034.68,31.237],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4014.47,4034.14,31.2411],15,[0,0,1]] call InitItem; 
['WoodenBucket',[4015.62,4032.69,31.4285],15,[0,0,1]] call InitItem; 
['WoodenBucket',[4017.12,4032.69,31.431],15,[0,0,1]] call InitItem; 
['WoodenBucket',[4016.62,4032.64,32.1786],15,[0,0,1]] call InitItem; 
['WoodenBucket',[4015.01,4037.41,31.2477],35,[0,0,1]] call InitItem; 
['WoodenBucket',[4014.62,4037.29,31.2469],70,[0,0,1]] call InitItem; 
['WoodenBucket',[4014.9,4036.92,31.2441],15,[0,0,1]] call InitItem; 
['WoodenBucket',[4014.65,4036.57,31.2444],335,[0,0,1]] call InitItem; 
['BigClothCabinetGreen',[4017.23,4035.88,31.2478],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallConcretePipe',[4022.53,4032.75,38.4477,true],[0,2.39611e-06,1],[0,-1,2.39611e-06]] call InitStruct; 
['Kastrula',[4014.96,4032.52,31.2411],345,[0,0,1]] call InitItem; 
['MediumFireGarbagePile',[4014.61,4034.36,40.8883,true],[0.0871511,-0.996195,1.8673e-07],[0.086824,0.0075959,0.996195]] call InitStruct; 
['BigPipePump',[4014.39,4033.82,31.1386],180,[0,0,1]] call InitStruct; 
['Umivalnik',[4014.41,4035.99,31.2342],100,[0,0,1]] call InitStruct; 
['WoodenSmallFence',[4017.03,4035.12,37.3219,true],[4.55078e-14,-1,-1.0411e-06],[-1,0,-4.37114e-08]] call InitStruct; 
['WoodenSmallFence',[4016.23,4035.24,37.3319,true],[4.55078e-14,-1,-1.0411e-06],[-1,0,-4.37114e-08]] call InitStruct; 
['WoodenSmallFence',[4018.41,4037.81,37.0177,true],[0.936117,0.0818989,0.34202],[0.0871546,-0.996195,9.61925e-07]] call InitStruct; 
['BetonGarageMedium',[4013.54,4035.07,31.1051],180,[0,0,1]] call InitStruct; 
['NewIndPipeUUP',[4020.46,4033.69,42.1241,true],115,[-0.00866935,-0.00220273,0.99996]] call InitStruct; 
['IndPipe45DegL',[4014.42,4035.9,40.4352,true],300.002,[-0.0121873,0,0.999926]] call InitStruct; 
['NewIndPipe20m',[4014.39,4022.52,31.4197],0,[0,0,1]] call InitStruct; 
['WoodenDoor',[4054.75,4066.13,30.899],0,[0,0,1]] call InitStruct; 
_4038_990484093_6584524_81828 = ['WoodenDoor',[4038.99,4093.66,30.9102,true],355,[-1.17439e-09,4.65661e-08,1]] call InitStruct; 
['WoodenDoor',[4050.42,4019.44,30.5152],180,[0,0,1]] call InitStruct; 
['WoodenSmallFence4',[4050.53,4019.13,38.4537,true],[-0.00146512,0.967697,-0.252114],[0.00546864,0.252118,0.967681]] call InitStruct; 
['WoodPole1',[4049.62,4019.44,37.9239,true],0,[0.00566367,-0.00693192,0.99996]] call InitStruct; 
['WoodPole1',[4049.61,4019.45,36.3255,true],0,[0.00566367,-0.00693192,0.99996]] call InitStruct; 
['ConcreteLongPole',[4056.04,4066.57,38.8558,true],0,[-0.0384836,0.0261709,0.998916]] call InitStruct; 
['ConcreteLongPole',[4053.55,4066.23,30.9826],0,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[4056.13,4066.13,30.8652],0,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[4053.5,4065.88,31.3652],345,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[4053.8,4065.94,33.1152],165,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[4039.1,4093.59,32.697,true],[0.0871562,-0.996195,7.19301e-08],[0.996195,0.0871562,2.37546e-06]] call InitStruct; 
_4001_246343916_1252417_87500 = ['SteelArmoredDoor2',[4001.25,3916.13,17.875],270,[0,0,1]] call InitStruct; 
['ConcretePole',[4051.27,4019.5,37.4065,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['ThickLightConcreteColumn',[4001.31,3917.35,24.0914,true],0,[0,-0.0348991,0.999391]] call InitStruct; 
['ThickLightConcreteColumn',[4001.25,3914.89,18.625],0,[0,0,1]] call InitStruct; 
_4055_224614066_2077633_85763 = ['WoodPole',[4055.22,4066.21,38.9287,true],0,[-0.0341398,0.317023,0.947803]] call InitStruct; 
_4055_082284066_2734435_20523 = ['WoodPole',[4055.08,4066.27,40.2607,true],0,[-0.0341398,0.0609111,0.997559]] call InitStruct; 
['WoodenSmallFence3',[4055.88,4065,30.8652],0,[0,0,1]] call InitStruct; 
['WoodenSmallFence2',[4055.5,4066.25,34.2402],90,[0,0,1]] call InitStruct; 
['WoodenSmallFence2',[4055.63,4066.25,38.5088,true],270,[-2.14577e-06,7.45058e-07,1]] call InitStruct; 
['WoodenSmallFence2',[4040.29,4093.64,31.0867,true],[4.37114e-08,1.19249e-08,-1],[-1,0,-4.37114e-08]] call InitStruct; 
['WoodenDoor',[3985.95,4068.76,36.9499,true],4.82601,[-0.0118428,-0.0133614,0.999841]] call InitStruct; 
['WoodenSmallFence4',[3985.84,4069.04,38.7994,true],[-0.0769502,-0.960923,-0.265907],[-0.0381122,-0.263667,0.96386]] call InitStruct; 
['WoodPole1',[3986.72,4068.66,38.275,true],184.83,[-0.0169023,-0.00597752,0.999839]] call InitStruct; 
['WoodPole1',[3986.75,4068.67,36.6766,true],184.83,[-0.0169023,-0.00597752,0.999839]] call InitStruct; 
['ConcretePole',[3985.09,4068.76,37.7395,true],184.83,[-0.0169009,-0.00597895,0.999839]] call InitStruct; 
['WoodenSmallFence4',[3985.93,4069,40.0531,true],[-0.0769502,-0.960923,-0.265907],[-0.0381122,-0.263667,0.96386]] call InitStruct; 
['WoodenSmallFence1',[3984.31,4068.5,30.9842],345,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[3984.44,4068.53,32.735],165,[0,0,1]] call InitStruct; 
['WoodenSmallFence2',[3987.52,4068.64,37.1037,true],[0.0871556,3.77132e-06,-0.996195],[-0.996195,-7.61938e-09,-0.0871556]] call InitStruct; 
['ConcretePanel2',[4033.95,3724.98,53.5715,true],270,[-1.74637e-07,0.0348995,0.999391]] call InitStruct; 
['SmallWoodenTable',[4036.78,3718.35,48.7022],90,[0,0,1]] call InitStruct; 
['RedCarpet',[4029.15,3720.69,54.885,true],6.06071e-13,[1,0,1.19249e-08]] call InitStruct; 
['PaperHolder',[4033.37,3718.01,49.1978],110,[0,0,1]] call InitItem; 
['Paper',[4033.4,3718.34,49.1978],325,[0,0,1]] call InitItem; 
['Paper',[4033.21,3718.11,49.1978],260,[0,0,1]] call InitItem; 
['Paper',[4033.26,3718.33,49.2031],0,[0,0,1]] call InitItem; 
['Shelves',[4038.7,3718.43,48.7022],90,[0,0,1]] call InitStruct; 
['OfficeCabinet',[4032.13,3718.03,48.7022],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Documents1',[4038.12,3720.25,49.5801],105,[0,0,1]] call InitItem; 
['BrickThinWall',[4029.5,3723.88,48.625],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4039,3720.75,48.625],90,[0,0,1]] call InitStruct; 
['BrickThinWall',[4036.13,3717.63,48.625],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4031.88,3717.62,48.625],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4035.38,3723.88,48.7022],0,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[4034.98,3717.88,48.625],275,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[4035.13,3724.13,48.875],270,[0,0,1]] call InitStruct; 
['BigConcreteWallDestroyed',[4031.13,3725.88,51.25],180,[0,0,1]] call InitStruct; 
['BigConcreteWallDestroyed',[4036.88,3725.25,54.6123,true],0.000315892,[-1.12163e-06,-0.173648,0.984808]] call InitStruct; 
['OrangeCapet',[4034.18,3722.1,48.6903],90,[0,0,1]] call InitStruct; 
['OrangeCapet',[4034.18,3719.15,48.6909],90,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[4038.15,3722.57,48.6108],180,[0,0,1]] call InitStruct; 
['Bookcase',[4030.58,3718,48.7022],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Book',[4029.74,3722.04,49.6339],260,[0,0,1]] call InitItem; 
['BrickThinWallSmall',[4039.88,3723.88,48.625],0,[0,0,1]] call InitStruct; 
['RedCarpetWall',[4038.84,3720.83,50.0011],180,[0,0,1]] call InitStruct; 
['BigClothCabinetNew',[4036.26,3723.35,48.6021],0,[0,0,1]] call InitStruct; 
['CaseBedroomSmall',[4033.33,3718.15,48.6349],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ChestCabinet',[4038.34,3720.57,48.7022],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcreteSmallFloor1',[4037.53,3721.5,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4034.75,3721.5,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4037.53,3717,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4034.75,3717,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4031.97,3721.5,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4031.97,3717,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4029.19,3721.5,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[4029.19,3717,51],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4030.13,3721.75,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4032.9,3721.75,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4038.46,3721.75,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4035.68,3721.75,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4030.13,3717.22,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4032.91,3717.25,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4038.47,3717.23,48.5],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[4035.69,3717.23,48.5],0,[0,0,1]] call InitStruct; 
_4029_292483719_6250048_75000 = ['SmallBookcase',[4029.29,3719.63,48.75],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['GreenArmChair',[4029.79,3723.18,48.7022],0,[0,0,1]] call InitStruct; 
['CuttingBoard',[4036.76,3718.67,49.5668],255,[0,0,1]] call InitItem; 
_4034_250003723_8750048_12500 = ['SteelBrownDoor',[4034.25,3723.88,48.125],0,[0,0,1]] call InitStruct; 
['LampKerosene',[4029.68,3721.65,49.6312],340,[0,0,1]] call InitItem; 
['KitchenKnife',[4036.41,3718.65,54.5612,true],[0.500001,-0.866025,6.93584e-07],[0.866025,0.500001,3.7749e-08]] call InitItem; 
['SmallStoveGrill',[4035.73,3718.11,48.4952],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['SmallTrashCan',[4035.25,3718.07,48.7022],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['AmmoBoxRifle',[4038.55,3721.15,49.5801],160,[0,0,1]] call InitItem; 
['FleshDebris1',[4038.69,3718.1,48.8478],295,[0,0,1]] call InitItem; 
['OrganicDebris1',[4036.65,3718.21,49.5668],0,[0,0,1]] call InitItem; 
['OrganicDebris1',[4038.7,3718.72,48.8098],0,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[4038.07,3720.88,49.5801],115,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[4038.13,3720.78,49.5801],60,[0,0,1]] call InitItem; 
_4031_031743723_4040548_70220 = ['SteelGreenCabinet',[4031.03,3723.4,48.7022],90.0001,[0,0,1]] call InitStruct; 
['FryingPan',[4036.18,3718.32,49.5668],135,[0,0,1]] call InitItem; 
['RifleSVT',[4038.28,3720.39,54.5968,true],0,[1,0,1.19249e-08]] call InitItem; 
['SmallRoundWoodenTable',[4029.8,3721.7,48.7022],35,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4034.13,3718.25,48.625],180,[0,0,1]] call InitStruct; 
['SmallBookcase',[4029.29,3718.69,48.75],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcreteWall',[4024.88,3717.38,49],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4029,3720.75,48.625],270,[0,0,1]] call InitStruct; 
_4023_500003721_3750048_25000 = ['IStruct',[4023.5,3721.38,48.25],140,[0,0,1], {_thisObj setvariable ['model','ml_shabut\tontech\tektonchamber.p3d'];}] call InitStruct; // !!! realocated model !!!
_4018_000003723_5000050_00000 = ['IStruct',[4018,3723.5,50],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\dwerca.p3d'];}] call InitStruct; // !!! realocated model !!!
['BlockBrick',[3984,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3846,18],1.06722e-05,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3836,18.5547,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3826.15,20.2912,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3816.3,22.0277,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3806.46,23.7642,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3796.61,25.5007,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3786.76,27.2372,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BlockBrick',[4034,3777.89,29.5834,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3768.49,33.0046,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3759.09,36.4226,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3749.7,39.8448,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3740.3,43.2614,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3730.9,46.6833,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BlockBrick',[4034,3723,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4033.88,3713,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3723,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4023.88,3713,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4043.5,3723,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4043.38,3713,48.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3853.23,18.8866,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[4034,3862.5,22.6325,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[4034,3871.78,26.3786,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[4034,3881.05,30.1248,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[4034,3890.32,33.8707,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[3974,3846,18],6.4033e-06,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3926,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[3984,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[3974,3916,18],180,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3906,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3896,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3886,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3876,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3866,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3856,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3916,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3964,3916,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3899.59,37.6168,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockBrick',[4034,3917,39.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3907,39.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3927,39.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3956,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3946,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3936,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3937,39.5],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4024.5,3949,39.5],45,[0,0,1]] call InitDecor; 
['BlockBrick',[4031.57,3941.93,39.5],45,[0,0,1]] call InitDecor; 
['BlockBrick',[4019.38,3955.21,37.7244,true],[0.757103,0.653265,-0.0062855],[-0.211333,0.254006,0.943832]] call InitDecor; 
['BlockBrick',[4033.89,4074.09,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4033.41,4064.12,24.9911],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4043.51,4064.03,24.9911],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4043.89,4083.09,24.8652],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4033.89,4083.09,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,4102,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4044,4102,24.8652],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4044,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,4102,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,4112,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,4122,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,4092,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,4082,24.8652],90,[0,0,1]] call InitDecor; 
['BlockStone',[4056.5,4070.94,28.2038,true],0,[0,0.642788,0.766044]] call InitDecor; 
['BlockBrick',[4023.41,4064.12,24.9911],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4013.88,4064,24.875],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,4064,23.875],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004.23,4073.09,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,4074,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4023.78,4074.18,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4013.78,4074.18,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4013.78,4083.18,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004.37,4083.7,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,4083,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3984,4083,24.8652],180,[0,0,1]] call InitDecor; 
['BlockStone',[3984.5,4070.12,28.1361,true],0,[0,0.642788,0.766044]] call InitDecor; 
['BlockBrick',[3984,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,4102,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,4102,24.8652],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4102,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,4102,24.8652],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,4093,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4023.78,4083.18,24.8652],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4054,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004.87,4058.12,21.3204,true],[1,-3.3485e-08,-2.80969e-08],[0,-0.642783,0.766048]] call InitDecor; 
['BlockBrick',[4004,4054,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3984,4074,24.8652],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004.88,4050.38,14.8459,true],[-1,3.74415e-07,3.14168e-07],[0,-0.642783,0.766048]] call InitDecor; 
['BlockBrick',[4004,4043.88,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,4034,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4007,4024,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4007.25,4014,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4007.25,4004,15],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4007.25,3992,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4007.38,3999.5,15.8047,true],[1,2.80799e-08,1.63647e-07],[-1.60182e-07,0.422618,0.906308]] call InitDecor; 
['BlockBrick',[4006.63,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.5,3993,37],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.38,4003.5,37.25],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.38,4013.5,37.25],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.5,3983,37],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.5,3973,37],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4017.5,3963,37],90,[0,0,1]] call InitDecor; 
['BlockStone',[4053.63,4018.62,28.1376,true],0,[0,-0.642787,0.766045]] call InitDecor; 
['BlockStone',[4053.63,4011.06,21.7235,true],0,[0,-0.642787,0.766045]] call InitDecor; 
['BlockBrick',[4054,3999,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,3989,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4054,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4044,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3983.25,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3976,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4034,3966,18],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4043.89,4074.09,24.8652],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4057.88,4077,27.8652],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4051.74,4076.3,27.8652],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4051.5,4090.88,18.6152],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4057.75,4097,18.6152],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4042.13,4092.13,18.6152],265,[0,0,1]] call InitDecor; 
['BigStoneWall',[4036.5,4083.75,18.6152],90.0002,[0,0,1]] call InitDecor; 
['BigStoneWall',[4042.75,4074.25,18.6152],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4027.25,4080.63,18.6152],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4017.88,4089.88,18.6152],270,[0,0,1]] call InitDecor; 
['StoneArch',[4024.12,4105.24,29.3529,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['BigStoneWall',[4029,4101.38,18.6152],3.84198e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[4038.13,4109,18.6152],180,[0,0,1]] call InitDecor; 
['StoneArch',[4053.61,4121.74,29.7279,true],359.998,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['BigStoneWall',[4049.25,4119.63,18.6152],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4054,4129,18.6152],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4057.75,4117,18.6152],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3989.38,4077.88,27.8652],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3982.38,4079,27.8652],90.0003,[0,0,1]] call InitDecor; 
['BigStoneWall',[4001.06,4104.45,18.6152],145,[0,0,1]] call InitDecor; 
['BigStoneWall',[3992.23,4098.37,18.6152],145,[0,0,1]] call InitDecor; 
['BigStoneWall',[4000.13,4094.5,18.6152],325,[0,0,1]] call InitDecor; 
['BigStoneWall',[3998.63,4079.38,18.6152],180,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3984.09,4090.57,18.6152],310,[0,0,1]] call InitDecor; 
['BigStoneWall2',[3990.38,4088.63,18.6152],345,[0,0,1]] call InitDecor; 
['BigStoneWall',[4009.5,4089.25,18.6152],90.0001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4026.75,4093.75,18.6152],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4040.13,4101.25,18.6152],0,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4018.5,4101,18.6152],320,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4008.96,4099.63,18.6152],50.0005,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4048.57,4109.35,18.6152],165.001,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4051.13,4100.75,18.6152],45.0007,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4038.88,4100.75,18.6152],45.0007,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4035.75,4078,18.4902],55.0007,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4036.38,4093.25,18.6152],90.0007,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4009,4079.5,18.4902],175.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4018.13,4109,18.6152],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031.75,4069.13,18.6152],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4041,4069,18.6152],0.000529766,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4017.54,4062.45,18.4902],155.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4018.13,4060.25,18.6152],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4009.88,4050.25,18],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4001.63,4057,20],90.0001,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4020.75,4069.5,18.4902],10.0007,[0,0,1]] call InitDecor; 
['BigStoneWall2',[4040.13,4071.38,18.4902],145.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031,3931,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4019,3913,11],6.53137e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[4019,3919,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3999,3913,11],6.53137e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[3999,3919,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3979,3913,11],6.53137e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[3979,3919,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3967,3901,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3961,3901,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3967,3881,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3961,3881,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3967,3861,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3961,3861,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4027,3913,11],6.53137e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3923,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[3971,3919,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3961,3909,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3979,3849,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3979,3843,11],6.4033e-06,[0,0,1]] call InitDecor; 
['BigStoneWall',[3999,3849,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[3999,3843,11],6.4033e-06,[0,0,1]] call InitDecor; 
['BigStoneWall',[4019,3849,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4019,3843,11],6.4033e-06,[0,0,1]] call InitDecor; 
['BigStoneWall',[3961,3853,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3971,3843,11],4.61038e-05,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3839,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4022.5,3849,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3829.86,21.4615,true],[-1,1.17437e-08,-2.07073e-09],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4031,3830,21.4615,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4037,3810.16,24.9344,true],[-1,4.81337e-07,-8.48726e-08],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4031,3810.16,24.9344,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4037,3790.47,28.4074,true],[-1,1.17437e-08,-2.07073e-09],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4031,3790.47,28.4074,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitDecor; 
['BigStoneWall',[4037,3770.79,33.6468,true],[-1,1.12052e-08,-4.07986e-09],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4031,3770.79,33.6468,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4037,3752,40.4869,true],[-1,4.59267e-07,-1.6722e-07],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4031,3752,40.4869,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4037,3733.21,47.3288,true],[-1,1.12052e-08,-4.07986e-09],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4031,3733.21,47.3288,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitDecor; 
['BigStoneWall',[4022,3726.88,42],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4046,3727,42],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4026.62,3691.92,42],90.0001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4041,3720,42],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4034,3715.63,42],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031,3860.49,23.2015,true],[1,-4.7159e-06,2.96359e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4037,3860.35,23.1724,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4031,3879.03,30.6936,true],[1,-4.7159e-06,2.96359e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4037,3879.03,30.6936,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4031,3897.58,38.1857,true],[1,-4.7159e-06,2.96359e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4037,3897.58,38.1857,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BigStoneWall',[4037,3912,32.5],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031,3912,32.5],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3932,32.5],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031,3928,32.5],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4020.5,3968,30],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4014.5,3968,30],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4030.16,3947.59,32.5],225,[0,0,1]] call InitDecor; 
['BigStoneWall',[4024.5,3944.76,32.5],45,[0,0,1]] call InitDecor; 
['BigStoneWall',[4015.86,3955.1,39.7137,true],[0.902914,0.427465,0.0449435],[-0.148452,0.212012,0.965926]] call InitDecor; 
['BigStoneWall',[4026.98,3951.02,32.25],226,[0,0,1]] call InitDecor; 
['BigStoneWall',[4022.96,3953.1,49.2853,true],[0.109382,-0.23457,-0.965926],[0.906307,0.422619,3.19069e-08]] call InitDecor; 
_4030_000003920_000007_00000 = ['IStruct',[4030,3920,7],120,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3968_000003912_000007_00000 = ['IStruct',[3968,3912,7],300,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3968_000733850_000007_00000 = ['IStruct',[3968,3850,7],210,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4030_000003842_000497_00000 = ['IStruct',[4030,3842,7],30.0003,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigStoneWall',[4037,3931,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4018.5,3987.5,46.4869,true],[1.19249e-08,-4.37114e-08,-1],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4018.5,3972,46.4869,true],[1.19249e-08,-4.37114e-08,-1],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4018.5,4007.5,46.4869,true],[1.19249e-08,-4.37114e-08,-1],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4031,3971,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4031,3951,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3951,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037,3971,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4045.13,3980.75,11],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4053.38,3991.88,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4048.13,3995.38,11],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4039.5,3985.88,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4022.5,3980.75,11],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4002.88,3980.75,11],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4010,4035,8.75],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4010,4012.63,8.75],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4010,3994.5,11],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4019.63,3985.88,11],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4053.63,4009.13,22.9926],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4047.86,4009.45,23],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4014.5,3988,30],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4014.38,4008.5,30.25],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4020.38,4007.97,30.25],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4020.5,3988,30],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4004.75,4032.13,8.75],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4004.75,4012.13,8.75],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4004.75,3992.38,11],90,[0,0,1]] call InitDecor; 
_4003_625004043_375008_75000 = ['IStruct',[4003.63,4043.38,8.75],30,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigStoneWall',[4020.38,4059.63,21.4902],270.001,[0,0,1]] call InitDecor; 
['BigStoneWall1',[4019.28,3961.68,50.4546,true],0,[-0.00161945,0.00659627,0.999977]] call InitDecor; 
['BigBrickWall1',[4034.75,4024.63,8.875],270,[0,0,1]] call InitDecor; 
['BigBrickWall',[4019.13,4014.25,8.875],0,[0,0,1]] call InitDecor; 
['BigBrickWall',[4018.78,4034.55,8.875],180,[0,0,1]] call InitDecor; 
['BigBrickWall',[4019,4025.38,27.8847,true],180,[0,0.0539779,-0.998542]] call InitDecor; 
['BlockStone',[4032,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4032,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4042,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4042,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4042,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4032,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4022,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4002,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4002,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4012,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4012,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4022,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4022,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4012,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4002,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4052,4123,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4032,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4042,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4052,4113,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4052,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4002,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4012,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4022,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993,4103,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4047,4083,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4048,4073,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,4066,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4015,4066,38.8652],0,[0,0,1]] call InitDecor; 
['BlockStone',[4051,3997.75,31.25],0,[0,0,1]] call InitDecor; 
['BlockStone',[4049,3987,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4039,3983,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4029,3983,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4019,3983,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4009,3986,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,3996,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,4006,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,4016,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,4026,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4007,4036,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3976,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3966,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3956,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3946,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3936,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3926,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[4014,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[3974,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3906,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3896,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3886,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3876,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3866,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3856,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3916,31],90,[0,0,1]] call InitDecor; 
['BlockStone',[3974,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[4014,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3846,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3846,31],2.13443e-06,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3844,31.25],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3838.26,31.3572,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3828.41,33.0937,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3818.56,34.8302,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3808.71,36.5667,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3798.86,38.3032,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3789.02,40.0397,true],0,[0,0.173648,0.984808]] call InitDecor; 
['BlockStone',[4034,3782.33,41.7986,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034,3772.94,45.2248,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034,3763.54,48.6387,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034,3754.14,52.0622,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034,3744.74,55.4819,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034,3735.34,58.8984,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4034.13,3721,62.125],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3732.13,60.3885,true],0,[0,0.34213,0.939653]] call InitDecor; 
['BlockStone',[4039,3721,62.125],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3852.22,32.4309,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3857.64,34.686,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3866.91,38.432,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3876.18,42.1781,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3885.45,45.9243,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3894.72,49.6704,true],[-1.55846e-05,-0.927187,-0.3746],[-4.51437e-06,-0.3746,0.927187]] call InitDecor; 
['BlockStone',[4034,3917,52.5],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3907,52.5],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3937,52.5],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3927,52.5],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024.5,3949,52.5],315,[0,0,1]] call InitDecor; 
['BlockStone',[4031.57,3941.93,52.5],315,[0,0,1]] call InitDecor; 
['BigStoneWall',[4052.25,4076.88,37.9771,true],[4.06824e-08,-0.365774,-0.930704],[-1,0,-4.37114e-08]] call InitDecor; 
['BigStoneWall',[3981,4077.5,36.7271,true],[-1.09321e-08,0.399467,0.916747],[1,0,1.19249e-08]] call InitDecor; 
['BlockStone',[4052,4093,38.8652],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4007.13,4058,33.244,true],[9.52364e-09,0.601815,-0.798636],[1,0,1.19249e-08]] call InitDecor; 
['BigStoneWall',[4049.23,4010.33,33.9717,true],[3.34848e-08,0.642789,-0.766044],[-1,0,-4.37114e-08]] call InitDecor; 
['MediumPileOfDirtAndStones',[3962,3865,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3855,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3962,3855,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3975,3848,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3975,3844,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3985,3848,18],6.4033e-06,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3985,3844,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3994,3848,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3995,3844,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4003,3848,18],6.4033e-06,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4003,3844,18],6.4033e-06,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015,3848,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015,3844,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4025,3848,18],6.4033e-06,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4025,3844,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3964,3845.5,18],225,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4035.73,3844.39,17.9606],275.001,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3854.09,24.5055,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3854.09,24.5055,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3863.37,28.2517,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3863.37,28.2517,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3871.71,31.623,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3872.64,31.9979,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3880.06,34.9948,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3880.06,34.9946,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3891.18,39.49,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3891.18,39.49,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3898.01,42.2488,true],[-1,8.77601e-06,-1.32323e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3898.04,42.2588,true],[1,-5.93172e-06,2.47238e-06],[-4.51437e-06,-0.3746,0.927187]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3906.99,39.5],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3906.82,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3835.05,23.6587,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3825.2,25.3952,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3825.2,25.3952,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3816.33,26.958,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3815.35,27.1316,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3807.47,28.5208,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3807.47,28.5208,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3795.65,30.6046,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3795.65,30.6046,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3785.8,32.3411,true],[1,-4.30473e-08,7.5904e-09],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3785.8,32.3411,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3777.06,34.9927,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3777.06,34.9927,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3767.67,38.4126,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3767.67,38.4126,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3759.21,41.4901,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3758.27,41.8333,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3750.75,44.5698,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3750.75,44.5698,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3739.48,48.6735,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3739.48,48.6735,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3732.16,51.602,true],[1,-4.10735e-08,1.4955e-08],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3732.4,51.5165,true],[-1,9.07328e-07,-3.30361e-07],[0,0.34213,0.939653]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3835.05,23.6587,true],[-1,9.5093e-07,-1.67675e-07],[0,0.173648,0.984808]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3947,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3947,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3935,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3935,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3925,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3925,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4023,3914,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4023,3918,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4013,3914,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4013,3918,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4004,3914,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4003,3918,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3995,3914,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3995,3918,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3983,3914,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3983,3918,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3973,3914,18],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3973,3918,18],0.000147703,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3905,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3962,3905,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3895,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3962,3895,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3886,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3962,3885,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3877,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3962,3877,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3963.5,3917,18],130,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4034.5,3915.5,18],125,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3916,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3916,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3936,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3934.68,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3926,39.5],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3926,39.5],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4023.79,3946.88,39.5],225,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4033.69,3942.64,39.5],45,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4029.2,3941.47,39.5],225,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3966,3865,18],270,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4007.31,3991.3,22.8202,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['DirtCraterLong',[4021.87,3982.76,22.8533,true],270.058,[0.02619,0.0384703,0.998916]] call InitStruct; 
['DirtCraterLong',[4050.63,3991.95,22.839,true],359.925,[0.0149085,-0.0198828,0.999691]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.88,3988.31,22.5924,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.29,3992.3,22.4291,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4010.45,3981.85,22.5427,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4014,3985.03,22.348,true],[-0.00455474,-0.990759,-0.135561],[0.0257905,-0.135633,0.990423]] call InitStruct; 
['MediumPileOfDirtAndStones',[4020.41,3984.99,22.4411,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4026.77,3980.63,23.8042,true],[-0.00227738,0.992104,-0.125398],[0.0260903,0.125415,0.991761]] call InitStruct; 
['MediumPileOfDirtAndStones',[4029.25,3985.25,22.3759,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4040,3982,22.4204,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4034.82,3985.18,22.4095,true],185.003,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4042.27,3985.22,22.3655,true],185.003,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4047.58,3981.71,22.4572,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4052.74,3988.07,22.4645,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4048.93,3989.39,22.5807,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3975,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3975,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3965,18],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3965,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4036,3956,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032,3955,18],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.5,3992,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.5,3992,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.5,3982,37],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.5,3982,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.5,3972,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.5,3972,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.5,3962,37],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.5,3962,37],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4026.62,3949.71,39.5],225,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4051.96,3982.5,18.0319],35,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4041.61,3981.61,22.8204,true],90,[-3.52149e-16,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4052.81,3998.49,22.5178,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4049.02,4001.06,22.5093,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['SmallDirtBrown',[4050.63,4003.66,22.233,true],[1,-1.34876e-08,1.20258e-07],[-9.45722e-08,-0.707107,0.707107]] call InitStruct; 
['DirtCraterLong',[4050.72,4007.23,25.4621,true],0,[-0.00915436,-0.643561,0.76534]] call InitStruct; 
['DirtCraterLong',[4050.52,4014.86,31.9771,true],0,[-0.00915436,-0.643561,0.76534]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.38,4002.5,37.25],90,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.38,4002.5,37.25],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4015.38,4012.5,37.25],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.38,4012.5,37.25],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.15,4000.71,20.6588,true],[-0.996634,0.0816988,-0.00685888],[0.0246102,0.377917,0.925512]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.61,4000.37,20.9275,true],[-0.999657,0.00100963,0.0261696],[0.0246102,0.377917,0.925512]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.18,4007.6,19.4147,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.98,4007.21,19.4137,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['DirtCraterLong',[4007.25,4035.25,19.8628,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['DirtCraterLong',[4007.31,4019.19,19.8693,true],0,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.9,4035.79,20.1952,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.67,4035.71,19.4347,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.32,4026.14,19.7621,true],90.0581,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4008.88,4026,19.1897,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4005.87,4017.2,19.4151,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.09,4017.09,19.4143,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4008.75,4044.27,19.4172,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['SmallDirtBrown',[4003.38,4046.75,15.0964],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4005.75,4049.92,20.7532,true],[-0.642787,0.541676,0.541675],[-1.49012e-07,-0.707106,0.707108]] call InitStruct; 
['MediumPileOfDirtAndStones',[4002.76,4052.12,22.8666,true],[-0.995853,0.0880978,0.0227176],[-0.0359417,-0.61034,0.791324]] call InitStruct; 
['MediumPileOfDirtAndStones',[4008.44,4055.15,25.1865,true],[-0.995853,0.0880978,0.0227176],[-0.0359417,-0.61034,0.791324]] call InitStruct; 
['DirtCraterLong',[4005.57,4054.68,25.2749,true],0,[-0.0020716,-0.637714,0.77027]] call InitStruct; 
['SmallDirtGrey',[4054.6,4069.94,34.9909,true],[-1,8.43935e-07,-4.92939e-07],[-1.51109e-07,0.364792,0.931089]] call InitStruct; 
['SmallDirtGrey',[4053.92,4072.71,33.2456,true],0,[0,0.573576,0.819152]] call InitStruct; 
['DirtCraterLong',[4054.62,4077.34,31.0486,true],0.0338556,[-0.00152177,0.348211,0.937415]] call InitStruct; 
['DirtCraterLong',[4054.72,4082.04,29.8201,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['DirtCraterLong',[4052.21,4105.38,24.6229],60,[0,0,1]] call InitStruct; 
['SmallStoneFragments',[4047.88,4105.99,29.8635,true],290.001,[0.00659634,0.00161941,0.999977]] call InitStruct; 
['SmallPileOfConcreteFragments',[4054.77,4118.19,30.1742,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[4056.42,4092.08,29.2016,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4052.68,4091.85,29.2377,true],90.0578,[0.02619,0.0384703,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4052.16,4096.97,29.9608,true],90.0578,[0.02619,0.0384703,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4056.8,4101.3,29.3463,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4057.03,4110.96,29.6537,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4056.46,4118.74,29.4021,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4056.23,4126.52,29.2741,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4052.98,4127.55,29.5687,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[4050.43,4122.21,29.2759,true],89.9994,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['MediumPileOfDirtAndStones',[4050.37,4113.24,29.2048,true],94.9977,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[4047.97,4102.34,29.5682,true],5.00243,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4044.97,4107.85,29.3265,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4041.8,4087.44,29.5983,true],[-0.994347,-0.0890997,-0.0577487],[-0.0607041,0.0308218,0.99768]] call InitStruct; 
['MediumBarrelGarbage',[4053.52,4122.91,24.6823],285,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4051.64,4118.36,24.6967],0,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4016.15,4104.27,29.6584,true],80.0021,[-0.00693115,-0.00566258,0.99996]] call InitStruct; 
['DirtCraterLong',[4013.69,4097.63,29.6947,true],355,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['DirtCraterLong',[4007.09,4103.75,29.7375,true],70.0001,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['DirtCraterLong',[4013.65,4086.84,29.6683,true],355,[-0.00693115,-0.00566258,0.99996]] call InitStruct; 
['DirtCraterLong',[4039.26,4105.09,29.7053,true],90.0004,[0.00699926,0.00103578,0.999975]] call InitStruct; 
['SmallStoneFragments',[4013.69,4092.9,29.7877,true],0,[0.02619,0.0384704,0.998916]] call InitStruct; 
['SmallStoneFragments',[4024.72,4105.37,29.7732,true],90.0004,[0.00699926,0.00103578,0.999975]] call InitStruct; 
['SmallStoneFragments',[3996.4,4096.47,29.7302,true],240.002,[-0.00693117,-0.00566258,0.99996]] call InitStruct; 
['SmallStoneFragments',[4039.16,4105.29,29.6381,true],270,[0.00699926,0.00103578,0.999975]] call InitStruct; 
['TorchHolderCharged',[4030.17,4096.55,24.9432],90,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[4030.15,4100.14,24.9769],90,[0,0,1]] call InitStruct; 
['WoodenNewBench',[4030.74,4098.29,24.9883],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4037.45,4102.65,29.3408,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4034.01,4107.64,29.2984,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4025.71,4102.69,29.2589,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4021.32,4107.73,29.748,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4009.85,4107.45,29.2703,true],1.15345e-05,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4001.35,4103.01,29.2662,true],325.008,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[3986.35,4092.54,29.6466,true],325.008,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[3988.15,4084.6,29.392,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[3983.91,4081.1,29.2671,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[3995.21,4092.77,29.2771,true],325.008,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4004.03,4098.76,29.3023,true],325.008,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4016.44,4096.5,29.3443,true],275.055,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4010.81,4093.55,29.4143,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['WoodenToiletSmall',[4012.74,4106.23,30.3758,true],[0.499999,-0.866026,-8.21082e-07],[-0.866026,-0.499999,7.21216e-07]] call InitStruct; 
['MediumPileOfDirtAndStones',[4037.48,4087.54,29.4978,true],270.058,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4041.8,4076.08,29.484,true],270.058,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4037.57,4077.76,29.5891,true],270.058,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4038.87,4069.97,29.4069,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4030.12,4070.35,29.3004,true],180,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4032.21,4078.88,29.2673,true],190.006,[0.02619,0.0384701,0.998916]] call InitStruct; 
['DirtCraterLong',[4021.54,4075.08,29.6912,true],275,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['DirtCraterLong',[4015.25,4067.91,29.6132,true],0,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['DirtCraterLong',[4006.6,4074.88,29.6768,true],89.9996,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['SmallStoneFragments',[3998.88,4075.5,29.7016,true],70.0018,[-0.00693115,-0.00566258,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[3991.14,4074.54,30.2323,true],[-0.965926,1.34035e-05,-0.258819],[-0.258819,3.40953e-06,0.965926]] call InitStruct; 
['MediumPileOfDirtAndStones',[3995.66,4078.32,25.8339],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4003.91,4078.28,25.0248],185,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[4034.04,4076.15,25.2513],0,[0,0,1]] call InitStruct; 
['SmallStoneFragments',[4027.68,4074.81,29.7617,true],70.0018,[-0.00693115,-0.00566258,0.99996]] call InitStruct; 
['MediumPileOfDirtAndStones',[4022.94,4070.38,29.2966,true],190.006,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4019.19,4065.39,30.2008,true],275.055,[0.02619,0.0384702,0.998916]] call InitStruct; 
['SmallSheetMetalHouse',[4015.13,4067.25,24.875],90,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4012.46,4062.34,24.908],75,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4022.71,4079.15,29.3391,true],185.003,[0.02619,0.0384701,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4016.36,4083.54,29.3018,true],270.058,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4010.53,4082.22,29.3801,true],275.055,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileGarbageAndBoards',[3992.63,4077.38,30.1814,true],50.0002,[-0.00161945,0.00659626,0.999977]] call InitStruct; 
['SmallStoneFragments',[3985.57,4079.7,29.8229,true],0,[-0.00566278,0.00693103,0.99996]] call InitStruct; 
['SmallSheetMetalHouse1',[4002.61,4076.49,26.2232],0,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4006.63,4070.22,26.8659],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3996.48,4070.28,26.9363],180,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4003.02,4066.79,28.2999,true],280.052,[0.02619,0.0384702,0.998916]] call InitStruct; 
['MediumPileOfDirtAndStones',[4013.41,4061.65,29.3402,true],0.000285372,[0.02619,0.0384701,0.998916]] call InitStruct; 
['SmallDirtBrown',[4007.88,4066,28.9153,true],[-0.0348993,0.999391,-5.9139e-07],[-0.069714,-0.00243386,0.997564]] call InitStruct; 
['SmallDirtBrown',[4008,4063.75,28.9153,true],[-0.241919,0.969705,0.03386],[-0.0507817,-0.0475022,0.997579]] call InitStruct; 
['SmallStoneFragments',[4013.78,4076.33,29.7332,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['SmallDirtBrown',[4013.5,4105.5,24.5],60,[0,0,1]] call InitStruct; 
['ClothDebris1',[4013.21,4106.29,30.3874,true],0,[0.00146467,-0.0435765,0.999049]] call InitItem; 
['ClothDebris2',[4012.82,4105.33,30.342,true],0,[0.00146467,-0.0435765,0.999049]] call InitItem; 
['OrganicDebris1',[4013.63,4105.63,30.2611,true],0,[0.00146467,-0.0435765,0.999049]] call InitItem; 
['LuxuryDoubleBed',[4012.61,4105.64,30.3304,true],240,[-0.00342538,-0.0464101,0.998917]] call InitStruct; 
['SmallSteelRustyFence',[4017.38,4018.75,42.7746,true],[-1,-2.39611e-06,1.13995e-06],[-1.13994e-06,-2.94845e-06,-1]] call InitStruct; 
['SmallSteelRustyFence',[4017.39,4018.75,44.144,true],90.0001,[-6.70552e-07,0,1]] call InitStruct; 
['DirtCraterLong',[4054.77,4096.08,29.7146,true],0,[-0.00693114,-0.00566258,0.99996]] call InitStruct; 
['SmallPileOfConcreteFragments',[4054.5,4089.17,29.968,true],0,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['DirtCraterLong',[3985.73,4086.12,29.7204,true],14.9997,[0.00659634,0.00161941,0.999977]] call InitStruct; 
['DirtCraterLong',[3992.62,4093.85,29.7195,true],50.0002,[-0.00161945,0.00659627,0.999977]] call InitStruct; 
['DirtCraterLong',[4039.53,4085.39,29.7554,true],0,[0.00269634,0.0371157,0.999307]] call InitStruct; 
['BigBlockedTunnel',[4023.52,3915.72,15.6095],0,[0,0,1]] call InitDecor; 
['IndPipeStair',[4019,4024.25,20.0576,true],0,[0.0805818,-0.0016139,0.996747]] call InitStruct; 
['IndPipeUR',[4024.5,4026.75,19.9671,true],90,[-0.00692887,-0.00565972,0.99996]] call InitStruct; 
['NewIndPipeValve',[4027.94,4024.25,19.3889,true],[-7.91446e-06,-1,2.12067e-06],[0.258819,0,0.965926]] call InitStruct; 
['NewIndPipeUUP',[4028.25,4024.5,20.7186,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['IndPipeBroken',[4014.38,4027.13,22.9671,true],0.0345287,[-0.00567337,-0.00693599,-0.99996]] call InitStruct; 
['SmallDirtBrown',[4015.5,4029.13,19.4153,true],[0.98106,0.173648,-0.0858315],[0.0871556,0,0.996195]] call InitStruct; 
['SmallDirtLight',[4012.13,4022.63,14.75],0,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4025.37,4021.98,19.0642,true],294.909,[0.0355167,-0.0147981,0.99926]] call InitStruct; 
['SteelArmoredDoor2',[4009.13,4023.88,15.25],90,[0,0,1]] call InitStruct; 
if ((random 1) < 0.5) then {
	['TrapEnabled',[4012.3,4067.81,24.8815],0,[0,0,1]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4015.63,4065.33,29.913,true],0,[0.00161916,-0.0197215,0.999804]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4006.83,4040.76,20.0529,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4008.72,4074.78,29.948,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4000.65,4075.82,29.9844,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4012.48,4083.63,30.0031,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[3997.25,4097.03,30.0354,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[3988.9,4092.11,30.0056,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4027.24,4105.93,29.9808,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4047.25,4105.33,29.985,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4054.97,4110.89,30.0171,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['TrapEnabled',[4053.12,4115.39,30.0027,true],0,[-0.00693114,-0.00566258,0.99996]] call InitItem; 
};
if ((random 1) < 0.8) then {
	['TrapEnabled',[4008.44,4023.98,15.2331],0,[0,0,1]] call InitItem; 
};
['SquareWoodenBox',[4030.8,4074.94,24.8567],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4001.58,4076.17,24.7711],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[4055.48,4112.99,29.9854,true],[0.984782,-0.173664,0.00671369],[-0.173602,-0.981147,0.0849299], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['OldWoodenBox',[4015.98,4063.95,29.7937,true],180,[-0.00693116,-0.00566258,0.99996], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4024.35,4027.5,14.3493],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4024.91,4027.53,15.3081],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4025.56,4027.42,14.3418],10,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BoardWoodenBox',[4022.13,4027.38,14.125],280,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[4014.25,4021,20.0786,true],0,[0.0871556,0,0.996195], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[4013.31,4025.98,14.7139],265,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['OldWoodenBox',[4011.22,4021.15,15.0283],185,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallWoodenTable',[4017.73,4021.43,19.7797,true],0,[0.0801754,-0.00103218,0.99678]] call InitStruct; 
['WoodenChair',[4016.88,4021.09,19.4162,true],[-0.934193,-0.347549,0.08058],[0.0781799,0.0209482,0.996719]] call InitItem; 
['ClothDebris1',[4016.52,4025.12,19.553,true],0,[0.0752836,0,0.997162]] call InitItem; 
['ClothDebris1',[4027.47,4020.68,19.2984,true],9.60165e-06,[-0.030197,0.0745083,0.996763]] call InitItem; 
['ClothDebris2',[4017.71,4021.73,20.2293,true],0,[0.0801749,-0.00103218,0.99678]] call InitItem; 
['DirtDebris1',[4014.18,4023.6,19.7182,true],[0,0.998565,-0.0535595],[0.343466,0.0503012,0.937817]] call InitItem; 
['DirtDebris2',[4014,4024.69,19.7174,true],[0,0.986754,-0.162223],[0.456631,0.144322,0.877872]] call InitItem; 
['WoodenDebris2',[4021.3,4026.07,14.2624],0.976536,[0,0,1]] call InitItem; 
['WoodenDebris2',[4014.45,4020.87,20.5948,true],[-0.978284,0.188775,0.0855885],[0.0871556,1.56942e-07,0.996195]] call InitItem; 
['WoodenDebris3',[4020,4021,19.2893,true],[-0.600351,0.797169,0.0640295],[0.107269,0.000926963,0.99423]] call InitItem; 
['WoodenDebris3',[4014.33,4021.24,20.5669,true],[-0.991667,-0.0952372,0.0867594],[0.0871556,1.61203e-07,0.996195]] call InitItem; 
['WoodenDebris4',[4026.68,4025.08,14.2588],341.005,[0,0,1]] call InitItem; 
['WoodenDebris5',[4027.72,4026.24,14.2753],353.006,[0,0,1]] call InitItem; 
['WoodenDebris6',[4027.15,4027.25,14.2736],29.4116,[0,0,1]] call InitItem; 
['WoodenDebris6',[4027.01,4027.83,14.2738],349.468,[0,0,1]] call InitItem; 
['WoodenDebris7',[4027.71,4027.7,14.2729],338.818,[0,0,1]] call InitItem; 
['WoodenDebris7',[4019.72,4026.41,14.2747],44.7449,[0,0,1]] call InitItem; 
['Candle',[4017.82,4021.25,20.2823,true],0.00517101,[0.166745,-0.00103183,0.986]] call InitItem; 
if ((random 1) < 0.4) then {
	['Melteshonok',[4018.83,4027.43,20.3278,true],[0,0.931397,-0.364006],[0.0805818,0.362822,0.928368]] call InitItem; 
};
['BigConcretePipe',[4026,4021.5,22.8824,true],[-1.99472e-06,0.00103253,0.999999],[0.00699974,0.999975,-0.00103249]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4012.5,4022.25,17.375],90,[0,0,1]] call InitStruct; 
['SewercoverBase',[4026,4021,23.3651,true],180,[0,-0.0396971,-0.999212]] call InitStruct; 
_4026_000004020_8750016_62500 = ['LadderBase',[4026,4020.88,16.625],180,[0,0,1], {go_editor_globalRefs set ["ExitLuk",_thisObj];
}] call InitStruct; 
_4026_033204020_4653330_99574 = ['SewercoverBase',[4026.03,4020.47,30.9957],0,[0,0,1], {go_editor_globalRefs set ["EnterLuk",_thisObj];
}] call InitStruct; 
if ((random 1) < 0.5) then {
	['WoodBaton',[4003.59,4076.84,25.0539],280,[0,0,1]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['WoodBaton',[4029.27,4076.72,24.8101],45,[0,0,1]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['WoodBaton',[4013.38,4106.08,25.8924],45,[0,0,1]] call InitItem; 
};
['ClothDebris1',[4041.66,4035.62,36.7278,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['ClothDebris1',[4004.98,4047.68,34.8921],325,[0,0,1]] call InitItem; 
['ClothDebris1',[4007.47,4050.32,34.9246],325,[0,0,1]] call InitItem; 
['ClothDebris1',[4049.38,4044.79,30.8478],325,[0,0,1]] call InitItem; 
['ClothDebris1',[3995.99,4053.93,30.856],325,[0,0,1]] call InitItem; 
['ClothDebris1',[3996.77,4059.14,30.9414],325,[0,0,1]] call InitItem; 
['ClothDebris2',[4044.8,4035.73,30.8911],30,[0,0,1]] call InitItem; 
['ClothDebris2',[4008.49,4049.4,34.8884],0,[0,0,1]] call InitItem; 
['ClothDebris2',[4050.76,4045.95,30.864],0,[0,0,1]] call InitItem; 
['ClothDebris2',[3997.24,4057.39,30.9099],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.4) then {
	['Pickaxe',[4016.11,4036.4,34.6815],300,[0,0,1]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['Pickaxe',[4015.82,4063.57,25.582],215,[0,0,1]] call InitItem; 
};
['StoneDebris2',[4045.94,4035.67,35.9088,true],0,[-0.00659628,-0.00161913,0.999977]] call InitItem; 
['SmallStone',[4006.89,4049.13,34.8383],0,[0,0,1]] call InitItem; 
['SmallStone',[4007.75,4047.88,34.8731],0,[0,0,1]] call InitItem; 
['SmallStone',[4008.48,4048.75,39.8865,true],0,[-0.36395,0.00402948,0.93141]] call InitItem; 
['SmallStone',[4033.06,4040.49,30.8129],0,[0,0,1]] call InitItem; 
['SmallStone',[4032.57,4041.96,35.8568,true],0,[-0.36395,0.00402948,0.93141]] call InitItem; 
['SmallStone',[4030.98,4042.33,30.8881],0,[0,0,1]] call InitItem; 
['SmallStone',[4032.33,4042.67,35.9278,true],0,[-0.0384836,0.0261709,0.998916]] call InitItem; 
['SmallStone',[4049.95,4045.55,30.8658],0,[0,0,1]] call InitItem; 
['SmallStone',[4051.41,4045.91,30.8628],0,[0,0,1]] call InitItem; 
['SmallStone',[4052.14,4046.77,35.8977,true],0,[-0.36395,0.00402948,0.93141]] call InitItem; 
['SmallStone',[4045.33,4035.77,30.8578],0,[0,0,1]] call InitItem; 
['SmallStone',[4044.79,4036.34,30.8514],0,[0,0,1]] call InitItem; 
['SmallStone',[3996.05,4058.09,30.9898],0,[0,0,1]] call InitItem; 
['SmallStone',[3996.9,4056.84,30.9918],0,[0,0,1]] call InitItem; 
['SmallStone',[3997.64,4057.71,36.009,true],0,[-0.36395,0.00402948,0.93141]] call InitItem; 
['WoodenDebris1',[4018.14,4023.7,34.2034],20,[0,0,1]] call InitItem; 
['WoodenDebris1',[4009.11,4050.17,34.8789],315,[0,0,1]] call InitItem; 
['WoodenDebris1',[3997.58,4058.51,30.852],315,[0,0,1]] call InitItem; 
['WoodenDebris2',[4018.09,4026.44,34.9061],20,[0,0,1]] call InitItem; 
['WoodenDebris2',[4008.48,4047.41,34.8312],55,[0,0,1]] call InitItem; 
['WoodenDebris2',[4052.29,4045.45,30.8371],55,[0,0,1]] call InitItem; 
['WoodenDebris2',[3997.42,4056.52,30.8505],55,[0,0,1]] call InitItem; 
['WoodenDebris3',[4007.46,4048.78,34.8912],15,[0,0,1]] call InitItem; 
['WoodenDebris3',[3996.61,4057.74,30.893],15,[0,0,1]] call InitItem; 
['WoodenDebris4',[4005.97,4047.67,34.8909],0,[0,0,1]] call InitItem; 
['WoodenDebris4',[3991.95,4055.29,30.8497],0,[0,0,1]] call InitItem; 
['WoodenDebris5',[4007.12,4047.09,34.8571],95,[0,0,1]] call InitItem; 
['WoodenDebris5',[4050.73,4045,30.8632],95,[0,0,1]] call InitItem; 
['WoodenDebris5',[3993.93,4060.91,30.811],95,[0,0,1]] call InitItem; 
['WoodenDebris6',[4018.11,4024.99,34.908],295,[0,0,1]] call InitItem; 
['WoodenDebris6',[4005.6,4049.05,34.8901],0,[0,0,1]] call InitItem; 
['WoodenDebris6',[4051.54,4046.5,30.8603],110,[0,0,1]] call InitItem; 
['WoodenDebris6',[3991.71,4057.37,30.8484],0,[0,0,1]] call InitItem; 
['WoodenDebris7',[4006.37,4049.98,34.889],325,[0,0,1]] call InitItem; 
['WoodenDebris7',[3995.16,4060.32,30.8572],325,[0,0,1]] call InitItem; 
['LogDebris1',[4023.45,4022.47,33.918],260,[0,0,1]] call InitItem; 
['LogDebris2',[4025.02,4022.56,33.9106],95,[0,0,1]] call InitItem; 
['TeleportExit',[4026,4021.13,14.25],0,[0,0,1], {go_editor_globalRefs set ["testExit",_thisObj];
}] call InitStruct; 
['StonePole',[3968.56,4059.23,31.0974],116,[0,0,1]] call InitStruct; 
['StonePole',[3950.72,4059.24,31.0868],254,[0,0,1]] call InitStruct; 
['StonePole',[3951.38,4058.15,36.5255,true],[-0.992983,-0.1096,0.04441],[0.00494175,0.336757,0.941579]] call InitStruct; 
['StonePole',[3951.26,4058.91,37.0465,true],0,[0.857164,0,0.515043]] call InitStruct; 
['StonePole',[3950.13,4061.13,37.0917,true],[-1,-3.368e-06,-2.08407e-05],[-9.96981e-06,0.945514,0.325581]] call InitStruct; 
['StonePole',[3978.37,4066.03,36.1935,true],0.999326,[0.0348977,0,0.999391]] call InitStruct; 
['StonePole',[3970.12,4060.87,31.098],180.001,[0,0,1]] call InitStruct; 
['StonePole',[3949.12,4060.82,31.0732],183.21,[0,0,1]] call InitStruct; 
['StonePole',[3949.1,4065.99,31.0892],357.4,[0,0,1]] call InitStruct; 
['StonePole',[3968.13,4057.13,31.125],86,[0,0,1]] call InitStruct; 
_3966_730224066_9467831_16255 = ['IStruct',[3966.73,4066.95,31.1625],178.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3962_635014066_7729531_14468 = ['IStruct',[3962.64,4066.77,31.1447],178.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3954_532964066_7849131_07203 = ['IStruct',[3954.53,4066.78,31.072],182,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3958_548104066_6892131_09705 = ['IStruct',[3958.55,4066.69,31.097],179.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3950_500004067_0000031_04960 = ['IStruct',[3950.5,4067,31.0496],182,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3971_049324066_0849631_11117 = ['IStruct',[3971.05,4066.08,31.1112],181.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3975_156984066_0766631_08417 = ['IStruct',[3975.16,4066.08,31.0842],181.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3973_278324060_9060131_08356 = ['IStruct',[3973.28,4060.91,31.0836],359.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3977_380864060_9245631_09532 = ['IStruct',[3977.38,4060.92,36.2129,true],0.00080776,[0.0174521,0,0.999848], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigGermoGate1',[3945.75,4063.75,30.6845],270,[0,0,1]] call InitDecor; 
_3952_900634065_1899431_14468 = ['IStruct',[3952.9,4065.19,31.1447],168.998,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcreteTreePlanter',[3965.25,4058.88,31.1447],270,[0,0,1]] call InitStruct; 
['ConcreteTreePlanter',[3963.63,4058.88,31.1447],0,[0,0,1]] call InitStruct; 
['SmallMushroom',[3963.7,4058.82,31.3056],91.3799,[0,0,1]] call InitStruct; 
['SmallMushroom',[3966.82,4058.93,31.3203],275.905,[0,0,1]] call InitStruct; 
['SmallMushroom1',[3965.25,4058.88,31.4059],236.904,[0,0,1]] call InitStruct; 
['ConcreteTreePlanter',[3966.88,4058.88,31.1447],90,[0,0,1]] call InitStruct; 
['StreetLamp',[3966.88,4066.25,29],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:eZRD0jnQn3s",_thisObj];
}] call InitStruct; 
['StreetLamp',[3951.63,4066.13,29],180,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:rx403/5RY94",_thisObj];
}] call InitStruct; 
['StreetLamp',[3967.63,4059.75,37.772,true],295,[3.01992e-07,6.75176e-08,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:bUYa/2ZFq+E",_thisObj];
}] call InitStruct; 
['StreetLamp',[3953,4053.25,29],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:+LbpR6UVeeY",_thisObj];
}] call InitStruct; 
['StreetLamp',[3961.75,4055.25,29],270,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:bUYa/2ZFq+E (2)",_thisObj];
}] call InitStruct; 
['StreetLamp',[3951.38,4060.13,29],40,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_STREET_LAMP_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:+LbpR6UVeeY (2)",_thisObj];
}] call InitStruct; 
_3935_251464057_9597233_17921 = ['PowerGenerator',[3935.25,4057.96,33.1792],87.0855,[0,0,1], {go_editor_globalRefs set ["PowerGenerator G:ypG1zj0SEXE",_thisObj];
}] call InitStruct; 
_3963_916504063_5000036_51882 = ['StreetLamp',[3963.92,4063.5,39.6671,true],[0.5,5.52683e-08,-0.866025],[-0.866025,7.54979e-08,-0.5], {_thisObj setvariable ['model','ml_shabut\projector\projector.p3d']; _thisObj setvariable ['light',"SLIGHT_SEARCHLIGHT_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:eZRD0jnQn3s (2)",_thisObj];
}] call InitStruct; // !!! realocated model !!!
_3955_860604063_4990236_50665 = ['StreetLamp',[3955.86,4063.5,39.655,true],[-0.499998,-4.77272e-06,-0.866026],[0.866026,-3.02393e-06,-0.499998], {_thisObj setvariable ['model','ml_shabut\projector\projector.p3d']; _thisObj setvariable ['light',"SLIGHT_SEARCHLIGHT_DORM" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["StreetLamp G:eZRD0jnQn3s (4)",_thisObj];
}] call InitStruct; // !!! realocated model !!!
_3963_443364045_6232932_32338 = ['IntercomOld',[3963.44,4045.62,32.3234],0,[0,0,1], {go_editor_globalRefs set ["IntercomOld G:4i8ntN3gdtY",_thisObj];
}] call InitStruct; 
['StationSpeaker',[3959.81,4048.51,33.1402],270,[0,0,1], {go_editor_globalRefs set ["StationSpeaker G:PVIZKloCU1M",_thisObj];
}] call InitStruct; 
['LampWall',[3959.45,4047.52,33.6436],180,[0,0,1]] call InitStruct; 
['LampCeiling',[3953.75,4044.88,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:Oyc9VIGwkE4",_thisObj];
}] call InitStruct; 
['LampCeiling',[3957.75,4044.38,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qsyEIvDjAgI",_thisObj];
}] call InitStruct; 
['LampCeiling',[3954.5,4050.25,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:IdCWNfQPGdo",_thisObj];
}] call InitStruct; 
['LampCeiling',[3958,4050.13,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:hK2gB7rgR0k",_thisObj];
}] call InitStruct; 
['GateCity',[3979.88,4063.5,30.9603],270,[0,0,1], {go_editor_globalRefs set ["GateCity G:784RgeR4g/8",_thisObj];
}] call InitStruct; 
['LampCeiling',[3965.7,4045.98,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qsyEIvDjAgI (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[3965.38,4054.95,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qsyEIvDjAgI (2)",_thisObj];
}] call InitStruct; 
['LampCeiling',[3961.26,4044.56,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qsyEIvDjAgI (3)",_thisObj];
}] call InitStruct; 
['LampCeiling',[3961.28,4050.18,33.875],0,[0,0,1], {_thisObj setvariable ['light',"SLIGHT_LAMP_HOUSE" call lightSys_getConfigIdByName]; go_editor_globalRefs set ["LampCeiling G:qsyEIvDjAgI (4)",_thisObj];
}] call InitStruct; 
_3974_457034032_6416038_56679 = ['RedButton',[3974.46,4032.64,43.5666,true],7.70829e-13,[1,0,1.19249e-08]] call InitStruct; 
_3958_965824045_1452632_86649 = ['RedButton',[3958.97,4045.15,37.8666,true],[-1.45414e-17,1,3.32669e-10],[-1,0,-4.37114e-08], {go_editor_globalRefs set ["RedButton G:QaN0z5bZVNU",_thisObj];
}] call InitStruct; 
_3963_535404043_4843832_85275 = ['RedButton',[3963.54,4043.48,37.8526,true],0,[1,0,1.19249e-08], {go_editor_globalRefs set ["RedButton G:bZsBuYUJDIg",_thisObj];
}] call InitStruct; 
_3963_259284048_7844232_85275 = ['RedButton',[3963.26,4048.78,37.8526,true],[-1,-1.12504e-06,-4.88762e-07],[-1.12504e-06,1,7.54979e-08], {go_editor_globalRefs set ["RedButton G:VK9gRE64Vp0",_thisObj];
}] call InitStruct; 
_3964_319094051_8200732_85275 = ['RedButton',[3964.32,4051.82,37.8526,true],90.0001,[-1.12504e-06,-1,4.88762e-07], {go_editor_globalRefs set ["RedButton G:O1FdMlcveHw",_thisObj];
}] call InitStruct; 
_3962_152594064_5339432_39930 = ['PowerSwitcherBox_Activator',[3962.15,4064.53,32.3993],0,[0,0,1], {go_editor_globalRefs set ["PowerSwitcherBox_Activator G:jf50a0d4mCA",_thisObj];
}] call InitStruct; 
_3961_488284064_5471232_41827 = ['PowerSwitcher',[3961.49,4064.55,32.4183],0,[0,0,1], {go_editor_globalRefs set ["PowerSwitcher G:vgfU2yV6Yzg",_thisObj];
}] call InitStruct; 
_3961_178474064_5471232_41665 = ['PowerSwitcher',[3961.18,4064.55,32.4167],0,[0,0,1], {go_editor_globalRefs set ["PowerSwitcher G:7M9Ex3e7DBU",_thisObj];
}] call InitStruct; 
_3963_530764065_6084032_08355 = ['ElectricalShieldSmall',[3963.53,4065.61,32.0835],270,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:AzVfeEX8vOI",_thisObj];
}] call InitStruct; 
_3967_544434050_2976131_95592 = ['ElectricalShieldSmall',[3967.54,4050.3,31.9559],90,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:8DrWNsn9/UM",_thisObj];
}] call InitStruct; 
['StationSpeaker',[3982.38,4031.15,39.9975],270,[0,0,1], {go_editor_globalRefs set ["GuardAlarm",_thisObj];
}] call InitStruct; 
_3959_210694064_5664132_99703 = ['PowerSwitcherBig',[3959.21,4064.57,32.997],180,[0,0,1], {go_editor_globalRefs set ["PowerSwitcherBig G:wORuyt6fg7U",_thisObj];
}] call InitStruct; 
['WhiteBrickWall',[3967.88,4043.75,32.25],270.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3962.75,4056.5,32.25],90.0009,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3962.74,4053.5,32.25],270.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3962.88,4051.99,32.25],0.000720585,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3957.75,4051.99,32.25],180.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3967.63,4052,32.25],0.000720585,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3959.25,4042,32.25],90.0008,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3952,4051.99,32.25],180.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3954.63,4051.99,35.625,true],180.001,[-1.86554e-06,2.35944e-06,1]] call InitStruct; 
['WhiteBrickWall',[3967.88,4056.5,32.25],90.0009,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3967.89,4053.5,32.25],270.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3963.25,4042,32.25],90.0013,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3956.13,4050.49,32.25],90.0016,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3963.25,4046.63,32.25],270.002,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3959.25,4046.63,32.25],270.002,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3959.25,4050,32.25],270.002,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3967.88,4047,32.25],270.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3967.88,4050,32.25],270.001,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3951.13,4043.75,32.25],90.0016,[0,0,1]] call InitStruct; 
_3966_500004042_2500032_25000 = ['IStruct',[3966.5,4042.25,32.25],0.00129517,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city2_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3959_750004042_2500032_25000 = ['IStruct',[3959.75,4042.25,32.25],0.00129517,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city2_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3951_125004048_7500032_25000 = ['IStruct',[3951.13,4048.75,32.25],90.0013,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city2_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3966_500004048_5000032_25000 = ['IStruct',[3966.5,4048.5,32.25],0.00102154,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city2_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3953_250004042_2500032_25000 = ['IStruct',[3953.25,4042.25,32.25],0.00129517,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city2_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallWallNetfence',[3962.75,4052.88,34.125],270,[0,0,1]] call InitStruct; 
['SmallWallNetfence',[3961.63,4052,34.125],0,[0,0,1]] call InitStruct; 
['SmallWallNetfence',[3967.63,4058,34.125],0.00041963,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3964.63,4058,34.125],0,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3962.75,4055.88,34.125],270,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3958.63,4051.99,34.125],0,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3954.63,4051.99,34.125],0,[0,0,1]] call InitStruct; 
['SteelGridDoorElectronic',[3954.88,4052,38.1291,true],1.5785e-12,[1,0,1.19249e-08]] call InitStruct; 
_3966_375004058_0000031_25000 = ['IStruct',[3966.38,4058,31.25],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3964_250004058_0000031_25000 = ['IStruct',[3964.25,4058,31.25],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['WhiteBrickWall',[3952.13,4048.5,32.25],180.002,[0,0,1]] call InitStruct; 
['WhiteBrickWall',[3956.13,4044.13,32.25],90.0016,[0,0,1]] call InitStruct; 
_3960_875004057_1250030_12500 = ['IStruct',[3960.88,4057.13,30.125],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3956_125004057_1250030_12500 = ['IStruct',[3956.13,4057.13,30.125],0.000499884,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3952_625004057_1250030_12500 = ['IStruct',[3952.63,4057.13,30.125],180.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3954_250004057_1215830_12500 = ['IStruct',[3954.25,4057.12,30.125],182,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_pillar_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3962_375004057_1250030_25000 = ['IStruct',[3962.38,4057.13,30.25],92.0001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\city_pillar_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelRustyStairs',[3951.84,4055.5,28.6893],180,[0,0,1]] call InitStruct; 
_3965_250004043_2500030_87500 = ['IStruct',[3965.25,4043.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3959_250004043_2500030_87500 = ['IStruct',[3959.25,4043.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3965_250004049_2500030_87500 = ['IStruct',[3965.25,4049.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3959_250004049_2500030_87500 = ['IStruct',[3959.25,4049.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3965_500004055_2500030_87500 = ['IStruct',[3965.5,4055.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3953_250004049_2500030_87500 = ['IStruct',[3953.25,4049.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3953_250004043_2500030_87500 = ['IStruct',[3953.25,4043.25,30.875],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_3960_000004054_7500031_25000 = ['IStruct',[3960,4054.75,31.25],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\podesta_s5.p3d'];}] call InitStruct; // !!! realocated model !!!
_3955_000004054_7500031_25000 = ['IStruct',[3955,4054.75,31.25],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\podesta_s5.p3d'];}] call InitStruct; // !!! realocated model !!!
_3950_000004054_7500031_25000 = ['IStruct',[3950,4054.75,31.25],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\podesta_s5.p3d'];}] call InitStruct; // !!! realocated model !!!
_3962_000004053_1250031_12500 = ['IStruct',[3962,4053.13,31.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\cobblestonesquare_01_32m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3982_429934063_5161130_77648 = ['IStruct',[3982.43,4063.52,35.771,true],0,[0.0871541,0,0.996195], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\cobblestonesquare_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenDebris5',[3958.48,4057.36,36.2082,true],[-1,1.66214e-06,-9.59637e-07],[0,0.5,0.866025]] call InitItem; 
['MediumConcreteFloor1',[3965.75,4055,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3965.75,4049,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3965.75,4043,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3959.75,4049,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3959.75,4043,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3953.75,4049,34.125],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3953.75,4043,34.125],0,[0,0,1]] call InitStruct; 
_3960_333984051_9055231_18212 = ['SteelGreenDoor',[3960.33,4051.91,31.1821],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RheadGuardDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3965_325444051_9282230_87514 = ['SteelGridDoor',[3965.33,4051.93,30.8751],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RheadGuardDormKletKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3963_475594044_3750031_39762 = ['SteelDoorThinSmall',[3963.48,4044.38,31.3976],90.0009,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RheadGuardDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3959_020264044_2500031_39734 = ['SteelDoorThinSmall',[3959.02,4044.25,31.3973],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RheadGuardDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3933_901864063_3642631_37452 = ['IStruct',[3933.9,4063.36,31.3745],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\kreslishko.p3d'];}] call InitStruct; // !!! realocated model !!!
_3963_589364046_7500032_87500 = ['IStruct',[3963.59,4046.75,32.875],90.0004,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polka.p3d'];}] call InitStruct; // !!! realocated model !!!
_3934_520514061_3027331_37592 = ['IStruct',[3934.52,4061.3,31.3759],0.000146849,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\stulflowa.p3d'];}] call InitStruct; // !!! realocated model !!!
_3966_625004046_1250031_37500 = ['IStruct',[3966.63,4046.13,31.375],90.0004,[0,0,1], {_thisObj setvariable ['model','ml_shabut\furniture\dhangar_psacistul.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenChair',[3961.47,4047.98,31.377],10,[0,0,1]] call InitItem; 
['WoodenChair',[3960.22,4047.08,31.375],185,[0,0,1]] call InitItem; 
['InfoBoard',[3963.06,4046.87,32.1637],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3964.75,4048.07,31.4966],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBookcase',[3967.6,4047.45,31.375],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenSmallShelf1',[3958.38,4042.66,31.38],270,[0,0,1]] call InitStruct; 
['WoodenSmallShelf1',[3957.42,4042.66,31.38],90.0004,[0,0,1]] call InitStruct; 
_3957_408694042_5485832_74214 = ['IStruct',[3957.41,4042.55,32.7421],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polka_ak.p3d'];}] call InitStruct; // !!! realocated model !!!
_3958_387704042_5485832_74214 = ['IStruct',[3958.39,4042.55,32.7421],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polka_ak.p3d'];}] call InitStruct; // !!! realocated model !!!
_3956_583984043_6726131_36909 = ['SteelGreenCabinet',[3956.58,4043.67,31.3691],0.000446097,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3952.08,4046.98,31.38],270,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[3951.64,4047.88,31.38],86.9093,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['DoubleArmyBed',[3951.73,4043.21,31.38],180,[0,0,1], {go_editor_globalRefs set ["RRookieGuardDormBed1",_thisObj];
}] call InitStruct; 
['CaseBedroomMedium',[3952.81,4042.77,31.38],1.56728,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3953_751464042_7878431_38000 = ['SteelBlueCase',[3953.75,4042.79,31.38],178.266,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[3954.41,4042.76,31.38],358.138,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['DoubleArmyBed',[3955.32,4043.21,31.38],180,[0,0,1], {go_editor_globalRefs set ["RRookieGuardDormBed0",_thisObj];
}] call InitStruct; 
['SmallStoveGrill',[3958.68,4048.51,31.2262],340,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',"SLIGHT_LIGHT_STOVE" call lightSys_getConfigIdByName];}] call InitStruct; 
['WoodenOfficeTable4',[3956.8,4050.63,31.3748],180.001,[0,0,1]] call InitStruct; 
_3958_739994051_5573731_37500 = ['FreezerStruct',[3958.74,4051.56,31.375],180,[0,0,1]] call InitStruct; 
['RedSteelBox',[3956.49,4051.25,32.4758],270.001,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Shelves',[3957.88,4051.66,31.3733],9.8184e-06,[0,0,1]] call InitStruct; 
['Umivalnik',[3958.76,4049.23,31.3698],270,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3955.12,4051.27,31.375],270,[0,0,1]] call InitStruct; 
['SmallChair4',[3954,4051.36,31.3733],105,[0,0,1]] call InitItem; 
['SmallChair1',[3955.44,4050.54,31.375],165,[0,0,1]] call InitItem; 
['BigClothCabinet',[3952.56,4051.55,31.375],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigClothCabinet1',[3951.68,4050.71,31.375],90,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelGreenCabinet',[3958.8,4047.17,31.375],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallWoodenTable',[3965.38,4057,31.375],0,[0,0,1]] call InitStruct; 
['WoodenChair',[3964.51,4057.45,31.375],285.001,[0,0,1]] call InitItem; 
['DoubleArmyBed',[3963.63,4056.88,31.375],0,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3967.25,4056.88,31.375],1.36604e-05,[0,0,1]] call InitStruct; 
['WoodenSmallBench',[3967.5,4053.63,31.5],270,[0,0,1]] call InitStruct; 
['SmallTrashCan',[3966.63,4052.38,31.375],260,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['OldGreenToiletBowl',[3963.25,4053,31.375],270,[0,0,1]] call InitStruct; 
['WoodenChair',[3963.38,4053.52,31.375],270,[0,0,1]] call InitItem; 
['WoodenChair',[3963.38,4054.07,31.375],260,[0,0,1]] call InitItem; 
['TrashCan',[3957.63,4057.63,31.1447],270,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3962_701664042_7695331_38000 = ['SteelBlueCase',[3962.7,4042.77,31.38],178.266,[0,0,1]] call InitStruct; 
_3953_302734042_7714831_38000 = ['SteelBlueCase',[3953.3,4042.77,31.38],182.035,[0,0,1]] call InitStruct; 
_3951_548584045_9345731_37671 = ['SteelBlueCase',[3951.55,4045.93,31.3767],274.575,[0,0,1]] call InitStruct; 
_3962_135014042_6677231_38000 = ['SteelBlueCase',[3962.14,4042.67,31.38],181.712,[0,0,1]] call InitStruct; 
_3961_621344042_8173831_38000 = ['SteelBlueCase',[3961.62,4042.82,31.38],178.266,[0,0,1]] call InitStruct; 
_3961_114504042_7404831_38000 = ['SteelBlueCase',[3961.11,4042.74,31.38],181.841,[0,0,1]] call InitStruct; 
_3960_525634042_7482931_38000 = ['SteelBlueCase',[3960.53,4042.75,31.38],178.266,[0,0,1]] call InitStruct; 
_3959_992194042_8356931_38000 = ['SteelBlueCase',[3959.99,4042.84,31.38],187.312,[0,0,1]] call InitStruct; 
['WoodenOfficeTable',[3960.29,4047.82,31.375],180,[0,0,1]] call InitStruct; 
['StripedChair',[3966.59,4047.31,31.375],180,[0,0,1], {go_editor_globalRefs set ["RHeadGuardDormChair",_thisObj];
}] call InitItem; 
['SmallChair1',[3967.35,4045.46,31.375],90,[0,0,1]] call InitItem; 
_3951_633544045_2172931_37498 = ['SteelBlueCase',[3951.63,4045.22,31.375],269.575,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3951.54,4042.84,34.4278],350,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3952.78,4042.78,34.4328],9.8184e-06,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3951.65,4044.11,34.4328],350,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bucket1',[3956.42,4049.48,31.375],330,[0,0,1]] call InitItem; 
['Cup1',[3956.51,4049.82,32.4533],60,[0,0,1]] call InitItem; 
['KitchenKnife',[3956.98,4050.94,37.4767,true],[-0.965926,-0.258819,-1.93881e-06],[-0.258819,0.965926,7.29254e-08]] call InitItem; 
['CuttingBoard',[3956.99,4050.66,32.4758],0,[0,0,1]] call InitItem; 
['Bread',[3956.99,4050.6,32.499],0,[0,0,1]] call InitItem; 
['Kastrula',[3957.53,4051.66,32.3721],0,[0,0,1]] call InitItem; 
['FryingPan',[3958.7,4049.21,37.2253,true],0,[0,0.258819,0.965926]] call InitItem; 
['Bucket2',[3958.81,4049.74,31.375],0,[0,0,1]] call InitItem; 
['FryingPan',[3958.6,4048.49,32.2725],65.0001,[0,0,1]] call InitItem; 
['PaperHolder',[3965.9,4046.06,32.3254],264.908,[0,0,1]] call InitItem; 
['PenRed',[3965.87,4046.26,32.3254],283.014,[0,0,1]] call InitItem; 
['Notepad',[3966.61,4046.53,32.3242],90.912,[0,0,1]] call InitItem; 
['PenBlack',[3966.73,4046.54,32.3242],0,[0,0,1]] call InitItem; 
['Documents',[3967.39,4046.49,32.3254],0,[0,0,1]] call InitItem; 
['Documents1',[3967.62,4046.46,32.3242],0,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.22,4042.6,32.0084],0,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.31,4042.8,32.0084],0,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.22,4042.8,32.0084],355,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.01,4042.62,32.0084],0,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.1,4042.64,32.0084],5,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.77,4042.62,32.0084],0,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.65,4042.64,32.0084],5,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.54,4042.6,32.0084],20,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.75,4042.81,32.0084],5,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.64,4042.81,32.0084],0,[0,0,1]] call InitItem; 
['MagazineFinisherLoaded',[3957.53,4042.79,32.0084],355,[0,0,1]] call InitItem; 
['MagazineFinisher',[3958.31,4042.63,32.0084],355,[0,0,1]] call InitItem; 
['RifleFinisher',[3958.15,4042.64,37.7896,true],[3.12605e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleFinisher',[3958.06,4042.64,37.7896,true],[3.12605e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleFinisher',[3957.96,4042.64,37.7896,true],[3.12605e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleFinisherSmall',[3957.54,4042.63,37.7889,true],[3.12621e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleFinisherSmall',[3957.45,4042.63,37.7889,true],[3.12621e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleFinisherSmall',[3957.36,4042.63,37.7889,true],[3.12621e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['MagazineBastard',[3957.06,4042.6,32.0084],265,[0,0,1]] call InitItem; 
['MagazineBastard',[3957.17,4042.6,32.007],265,[0,0,1]] call InitItem; 
['MagazineBastard',[3957.16,4042.81,32.0069],265,[0,0,1]] call InitItem; 
['MagazineBastard',[3957.05,4042.82,32.0084],255,[0,0,1]] call InitItem; 
['MagazineBastard',[3957.29,4042.82,32.0056],250,[0,0,1]] call InitItem; 
['MagazineBastard',[3957.29,4042.6,32.0045],85.0004,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[3958.75,4042.65,32.0084],0,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[3958.67,4042.65,32.0084],0,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[3958.58,4042.64,32.0084],0,[0,0,1]] call InitItem; 
['MagazineSVTLoaded',[3958.72,4042.84,32.0084],0,[0,0,1]] call InitItem; 
['RifleSVT',[3958.81,4042.61,37.7467,true],[0,1.19249e-08,1],[0,-1,1.19249e-08]] call InitItem; 
['RifleSVT',[3958.72,4042.61,37.7467,true],[0,1.19249e-08,1],[0,-1,1.19249e-08]] call InitItem; 
['RifleSVT',[3958.62,4042.61,37.7467,true],[0,1.19249e-08,1],[0,-1,1.19249e-08]] call InitItem; 
['RifleSVT',[3958.53,4042.61,37.7467,true],[0,1.19249e-08,1],[0,-1,1.19249e-08]] call InitItem; 
['RifleBastard',[3957.08,4042.63,37.7826,true],[3.12621e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['RifleBastard',[3956.99,4042.63,37.7826,true],[3.12621e-06,4.88759e-07,1],[-1.12504e-06,-1,4.88762e-07]] call InitItem; 
['OrangeCarpet1',[3954.37,4049.96,31.371],0,[0,0,1]] call InitStruct; 
_3957_625004054_0000031_28679 = ['IStruct',[3957.63,4054,31.2868],126,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\statues\maroula_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['RedCarpet',[3965.83,4045.54,30.795],0,[0,0,1]] call InitStruct; 
['SmallGrayStone',[3958.63,4048.5,37.375],0,[0,0,1]] call InitStruct; 
['SmallConcretePipe',[3958.63,4048.52,40.5386,true],[-4.37114e-08,-1.19646e-05,1],[-1,0,-4.37114e-08]] call InitStruct; 
['BigPilePipes',[3958.99,4043.31,34.4278],0,[0,0,1]] call InitStruct; 
['ConcreteSlabsStack',[3966.55,4043.24,34.4041],270,[0,0,1]] call InitStruct; 
_3959_906984065_8190931_25003 = ['IStruct',[3959.91,4065.82,31.25],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardhouse_03_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['OldBrickWallMedium',[3958.79,4066.92,32.2843],0,[0,0,1]] call InitStruct; 
['OldBrickWallMedium',[3961.01,4066.91,32.2822],180,[0,0,1]] call InitStruct; 
_3960_181884064_4689931_44694 = ['SteelDoorThinSmall',[3960.18,4064.47,31.4469],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RheadGuardDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ChairLibrary',[3958.1,4065.7,31.4469],265,[0,0,1]] call InitItem; 
['WoodenOfficeTable',[3958.23,4064.88,31.4505],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3962.85,4065.58,31.5537],0,[0,0,1]] call InitStruct; 
_3954_822274052_2812535_58392 = ['IStruct',[3954.82,4052.28,40.8171,true],[-0.683018,-0.683008,0.258818],[0.183013,0.183012,0.965926], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\dshk.p3d'];}] call InitStruct; // !!! realocated model !!!



if (!isNil'_4045_515144022_7897931_02055') then {
	_4045_515144022_7897931_02055 setvariable ['name',"Умывальник"];
	_4045_515144022_7897931_02055 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4043_248294022_4292031_02055') then {
	_4043_248294022_4292031_02055 setvariable ['name',"Умывальник"];
	_4043_248294022_4292031_02055 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4043_284424023_7231431_02055') then {
	_4043_284424023_7231431_02055 setvariable ['name',"Умывальник"];
	_4043_284424023_7231431_02055 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4044_447754020_6936032_09883') then {
	_4044_447754020_6936032_09883 setvariable ['name',"Мытьё"];
	_4044_447754020_6936032_09883 setvariable ['desc',"Так сделано, что сверху течёт струя прямо на голову"];
};
if (!isNil'_4017_911874028_2924832_41013') then {
	[_4017_911874028_2924832_41013,'Kastrula',1,100] call (_4017_911874028_2924832_41013 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_911874028_2924832_41013,'GlassBottle',1,100] call (_4017_911874028_2924832_41013 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4017_999274026_5935130_85009') then {
	[_4017_999274026_5935130_85009,'WoodenCup',2,100] call (_4017_999274026_5935130_85009 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_5935130_85009,'Cup',1,100] call (_4017_999274026_5935130_85009 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_5935130_85009,'MetalCup',1,100] call (_4017_999274026_5935130_85009 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_5935130_85009,'OlderWoodenCup',2,100] call (_4017_999274026_5935130_85009 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4018_009774025_5427230_83516') then {
	[_4018_009774025_5427230_83516,'Rag',1,100] call (_4018_009774025_5427230_83516 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_009774025_5427230_83516,'CuttingBoard',1,100] call (_4018_009774025_5427230_83516 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4018_027594027_5227130_86050') then {
	[_4018_027594027_5227130_86050,'MatchBox',1,100] call (_4018_027594027_5227130_86050 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_027594027_5227130_86050,'Polovnik',1,100] call (_4018_027594027_5227130_86050 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4026_811774028_2036131_82085') then {
	[_4026_811774028_2036131_82085,'Rag',3,100] call (_4026_811774028_2036131_82085 getvariable 'proto' getvariable 'createItemInContainer');
	[_4026_811774028_2036131_82085,'CetalinBox',1,100] call (_4026_811774028_2036131_82085 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4017_960214028_3176330_85656') then {
	[_4017_960214028_3176330_85656,'GlassLargeBowl',1,100] call (_4017_960214028_3176330_85656 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_3176330_85656,'Mug',1,100] call (_4017_960214028_3176330_85656 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_3176330_85656,'GlassGoblet',1,100] call (_4017_960214028_3176330_85656 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_3176330_85656,'SoupPlate',4,100] call (_4017_960214028_3176330_85656 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_3176330_85656,'FoodPlate',5,100] call (_4017_960214028_3176330_85656 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4018_002694021_1577130_87217') then {
	[_4018_002694021_1577130_87217,'Butter',1,100] call (_4018_002694021_1577130_87217 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_002694021_1577130_87217,'Butter',1,44] call (_4018_002694021_1577130_87217 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_002694021_1577130_87217,'ButterPiece',1,100] call (_4018_002694021_1577130_87217 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_002694021_1577130_87217,'ButterPiece',1,40] call (_4018_002694021_1577130_87217 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4037_618654032_2187530_70971') then {
	_4037_618654032_2187530_70971 setvariable ['name',"Камин"];
	_4037_618654032_2187530_70971 setvariable ['desc',"Тепло и уютно согревает комнату, на огонь приятно смотреть"];
};
if (!isNil'_4044_608404034_8510730_91115') then {
	_4044_608404034_8510730_91115 setvariable ['name',"Металлолом"];
	_4044_608404034_8510730_91115 setvariable ['desc',"Можно бы было сдать, да не утащить.."];
};
if (!isNil'_4029_571534030_3750031_36520') then {
	[_4029_571534030_3750031_36520,'Key',2,100,[["var","name","Ключ от кухни"],["var","preinit@__keytypesstr","KitchenDorm"]]] call (_4029_571534030_3750031_36520 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750031_36520,'Key',2,100,[["var","name","Ключ от туалетов"],["var","preinit@__keytypesstr","SortirDorm"]]] call (_4029_571534030_3750031_36520 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750031_36520,'Key',2,100,[["var","name","Ключ от подсобки"],["var","preinit@__keytypesstr","PodsobDorm"]]] call (_4029_571534030_3750031_36520 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750031_36520,'Key',2,100,[["var","name","Площадка"],["var","preinit@__keytypesstr","PloshadkaDorm"]]] call (_4029_571534030_3750031_36520 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750031_36520,'Key',2,100,[["var","name","Ключ от комнаты 201"],["var","preinit@__keytypesstr","key201"]]] call (_4029_571534030_3750031_36520 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4032_423834032_4235831_25031') then {
	[_4032_423834032_4235831_25031,'Bandage',1,100] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'Bandage',1,50] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'Rag',1,100] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'NeedleWithThreads',1,100] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'NeedleWithThreads',1,50] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'CetalinBox',1,100] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235831_25031,'KoradizinBox',1,100] call (_4032_423834032_4235831_25031 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4045_883304034_7033735_03304') then {
	_4045_883304034_7033735_03304 setvariable ['desc',"Звяковые документы текстильной фабрики"];
};
if (!isNil'_4048_582764030_6774933_91686') then {
	[_4048_582764030_6774933_91686,'Meat',1,100] call (_4048_582764030_6774933_91686 getvariable 'proto' getvariable 'createItemInContainer');
	[_4048_582764030_6774933_91686,'MeatChopped',1,100] call (_4048_582764030_6774933_91686 getvariable 'proto' getvariable 'createItemInContainer');
	[_4048_582764030_6774933_91686,'MeatMinced',1,50] call (_4048_582764030_6774933_91686 getvariable 'proto' getvariable 'createItemInContainer');
	[_4048_582764030_6774933_91686,'MilkBottle',1,100] call (_4048_582764030_6774933_91686 getvariable 'proto' getvariable 'createItemInContainer');
	[_4048_582764030_6774933_91686,'ButterPiece',1,100] call (_4048_582764030_6774933_91686 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4037_090334021_7871131_70051') then {
	[_4037_090334021_7871131_70051,'Key',1,100,[["var","name","Дубликат ключа от комнаты 202"],["var","preinit@__keytypesstr","RCherDormKey"]]] call (_4037_090334021_7871131_70051 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871131_70051,'Key',1,100,[["var","name","Дубликат ключа от комнаты 203"],["var","preinit@__keytypesstr","RCexDormKey"]]] call (_4037_090334021_7871131_70051 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871131_70051,'Key',1,100,[["var","name","Дубликат ключа от комнаты 204"],["var","preinit@__keytypesstr","RSlesarDormKey"]]] call (_4037_090334021_7871131_70051 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871131_70051,'Key',1,100,[["var","name","Ключ от комнаты 205"],["var","desc","Колдырь потерял его по пьяни"],["var","preinit@__keytypesstr","RKoldyrDormKey"]]] call (_4037_090334021_7871131_70051 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871131_70051,'Key',1,100,[["var","name","Дубликат ключа от комнаты 206"],["var","preinit@__keytypesstr","RMolDormKey"]]] call (_4037_090334021_7871131_70051 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4027_207034034_2902833_91122') then {
	_4027_207034034_2902833_91122 setvariable ['initialcategory',"milk"];
};
if (!isNil'_4027_194094032_9877933_91122') then {
	_4027_194094032_9877933_91122 setvariable ['initialcategory',"food"];
};
if (!isNil'_4039_493414029_6389234_72077') then {
	[_4039_493414029_6389234_72077,go_editor_globalRefs get "StationSpeaker G:Q54X59FAgzQ"] call (_4039_493414029_6389234_72077 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4034_250004029_3750033_86520') then {
	_4034_250004029_3750033_86520 setvariable ['desc',"Комната 205"];
};
if (!isNil'_4040_250004029_3750033_86520') then {
	_4040_250004029_3750033_86520 setvariable ['desc',"Комната 204"];
	_4040_250004029_3750033_86520 setvariable ['islocked',true];
};
if (!isNil'_4044_750004025_6250030_99020') then {
	_4044_750004025_6250030_99020 setvariable ['desc',"Умывальная"];
};
if (!isNil'_4047_125004025_6250030_99020') then {
	_4047_125004025_6250030_99020 setvariable ['desc',"Туалет"];
};
if (!isNil'_4049_000004021_5000030_99020') then {
	_4049_000004021_5000030_99020 setvariable ['desc',"Запасный выход"];
	_4049_000004021_5000030_99020 setvariable ['islocked',true];
};
if (!isNil'_4032_871834031_1250030_86520') then {
	_4032_871834031_1250030_86520 setvariable ['desc',"Кабинет 101"];
	_4032_871834031_1250030_86520 setvariable ['islocked',true];
};
if (!isNil'_4026_375004033_3750030_86520') then {
	_4026_375004033_3750030_86520 setvariable ['desc',"Запасный выход"];
	_4026_375004033_3750030_86520 setvariable ['islocked',true];
};
if (!isNil'_4038_500004025_6250033_86520') then {
	_4038_500004025_6250033_86520 setvariable ['desc',"Комната 201"];
	_4038_500004025_6250033_86520 setvariable ['islocked',true];
};
if (!isNil'_4044_750004025_6250033_86520') then {
	_4044_750004025_6250033_86520 setvariable ['desc',"Комната 202"];
	_4044_750004025_6250033_86520 setvariable ['islocked',true];
};
if (!isNil'_4026_625004027_3750030_86520') then {
	_4026_625004027_3750030_86520 setvariable ['desc',"Кухня"];
};
if (!isNil'_4025_625004023_3750030_86520') then {
	_4025_625004023_3750030_86520 setvariable ['islocked',true];
};
if (!isNil'_4026_625004021_7500030_99020') then {
	_4026_625004021_7500030_99020 setvariable ['islocked',true];
};
if (!isNil'_4047_125004029_3750033_86520') then {
	_4047_125004029_3750033_86520 setvariable ['desc',"Комната 203"];
	_4047_125004029_3750033_86520 setvariable ['islocked',true];
};
if (!isNil'_4038_500004025_6250030_86520') then {
	_4038_500004025_6250030_86520 setvariable ['desc',"Кабинет 102"];
	_4038_500004025_6250030_86520 setvariable ['islocked',true];
};
if (!isNil'_4041_039794028_9609430_83566') then {
	_4041_039794028_9609430_83566 setvariable ['desc',"Комната отдыха"];
};
if (!isNil'_4026_375004027_5000033_86520') then {
	_4026_375004027_5000033_86520 setvariable ['desc',"Выход на террасу"];
	_4026_375004027_5000033_86520 setvariable ['islocked',true];
};
if (!isNil'_4018_500004029_2500033_99020') then {
	_4018_500004029_2500033_99020 setvariable ['islocked',true];
};
if (!isNil'_4028_250004029_3750033_86520') then {
	_4028_250004029_3750033_86520 setvariable ['desc',"Комната 206"];
	_4028_250004029_3750033_86520 setvariable ['islocked',true];
};
if (!isNil'_4034_987794035_3024930_73840') then {
	_4034_987794035_3024930_73840 setvariable ['name',"Такая дверь"];
	_4034_987794035_3024930_73840 setvariable ['desc',"23 звяка, 3 цикла, 8-й смены, 28-го плана смена рождения. 8-й смены, 8-го плана в конце смены сгнила. Ебаный врот."];
	_4034_987794035_3024930_73840 setvariable ['islocked',true];
};
if (!isNil'_4007_750004056_3750034_86522') then {
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:fLGwpoBP83c"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:zx+c4iKzc5g"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:hGnHa7kTbEk"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:OpthpYcZ5Z4"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:umbpX/vnAss"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:HVC4/Ag7eck"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:kWu++T5dkiI"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:1V9pkcdGJ9Q"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750034_86522,go_editor_globalRefs get "Tumbler G:EWMj6vlYuZw"] call (_4007_750004056_3750034_86522 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4048_045654025_4414132_32677') then {
	[_4048_045654025_4414132_32677,go_editor_globalRefs get "LampCeiling G:eqHk+Uz0nZA"] call (_4048_045654025_4414132_32677 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4045_530524025_4428732_37648') then {
	[_4045_530524025_4428732_37648,go_editor_globalRefs get "LampCeiling G:eqHk+Uz0nZA (1)"] call (_4045_530524025_4428732_37648 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4037_568854025_4506832_22730') then {
	[_4037_568854025_4506832_22730,go_editor_globalRefs get "LampCeiling G:dBf4oFHbP2I"] call (_4037_568854025_4506832_22730 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4042_000004029_2993232_14939') then {
	[_4042_000004029_2993232_14939,go_editor_globalRefs get "LampCeiling G:3WTP9DQ1sKw"] call (_4042_000004029_2993232_14939 getvariable 'proto' getvariable 'addConnection');
	[_4042_000004029_2993232_14939,go_editor_globalRefs get "LampCeiling G:6MHQBqtjCTs"] call (_4042_000004029_2993232_14939 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4048_632324027_5000031_48298') then {
	_4048_632324027_5000031_48298 setvariable ['name',"Первый этаж. Левое крыло."];
	[_4048_632324027_5000031_48298,go_editor_globalRefs get "RedButton G:Y6ExyGIEWaY"] call (_4048_632324027_5000031_48298 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000031_48298,go_editor_globalRefs get "RedButton G:KDFGox8N8IQ"] call (_4048_632324027_5000031_48298 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000031_48298,go_editor_globalRefs get "RedButton G:Xh2Q/W2FGcg"] call (_4048_632324027_5000031_48298 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000031_48298,go_editor_globalRefs get "RedButton G:WGtGrZZEY8w"] call (_4048_632324027_5000031_48298 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000031_48298,go_editor_globalRefs get "RedButton G:TaTtSnTBX9c"] call (_4048_632324027_5000031_48298 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4016_060794021_3747630_85264') then {
	_4016_060794021_3747630_85264 setvariable ['name',"Уличное освещение."];
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:PtjQNHBBpAQ"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:4Ns/ZphJWgo"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:JobENx7FvpM"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:FjPul73CNac"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (1)"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:PtjQNHBBpAQ (1)"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (5)"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (2)"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (4)"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_3747630_85264,go_editor_globalRefs get "StreetLamp G:zVA/rLuMkaA"] call (_4016_060794021_3747630_85264 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4037_375004028_9318832_37982') then {
	[_4037_375004028_9318832_37982,go_editor_globalRefs get "LampCeiling G:zuAmqwZUMgw"] call (_4037_375004028_9318832_37982 getvariable 'proto' getvariable 'addConnection');
	[_4037_375004028_9318832_37982,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (1)"] call (_4037_375004028_9318832_37982 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4032_815924032_0000032_52993') then {
	[_4032_815924032_0000032_52993,go_editor_globalRefs get "LampCeiling G:qlQj1u5GQKs"] call (_4032_815924032_0000032_52993 getvariable 'proto' getvariable 'addConnection');
	[_4032_815924032_0000032_52993,go_editor_globalRefs get "LampCeiling G:DwTizfFKITc"] call (_4032_815924032_0000032_52993 getvariable 'proto' getvariable 'addConnection');
	[_4032_815924032_0000032_52993,go_editor_globalRefs get "LampCeiling G:NjkDlY9gWRQ"] call (_4032_815924032_0000032_52993 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4032_817144032_2802732_52950') then {
	[_4032_817144032_2802732_52950,go_editor_globalRefs get "LampCeiling G:jbNZsX9IGL8"] call (_4032_817144032_2802732_52950 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4046_375004029_5481035_41964') then {
	[_4046_375004029_5481035_41964,go_editor_globalRefs get "LampCeiling G:Kq7SLbsTC+k"] call (_4046_375004029_5481035_41964 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4041_150884029_5671435_23565') then {
	[_4041_150884029_5671435_23565,go_editor_globalRefs get "LampCeiling G:cBClC1cJFO0"] call (_4041_150884029_5671435_23565 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4035_125004029_5617735_39939') then {
	[_4035_125004029_5617735_39939,go_editor_globalRefs get "LampCeiling G:6DmKSV7k0vk"] call (_4035_125004029_5617735_39939 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4027_482424029_5642135_27439') then {
	[_4027_482424029_5642135_27439,go_editor_globalRefs get "LampCeiling G:YK+y03D0B3c"] call (_4027_482424029_5642135_27439 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4036_982184025_8139635_41375') then {
	[_4036_982184025_8139635_41375,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (2)"] call (_4036_982184025_8139635_41375 getvariable 'proto' getvariable 'addConnection');
	[_4036_982184025_8139635_41375,go_editor_globalRefs get "LampCeiling G:V/ojCDc8RhU"] call (_4036_982184025_8139635_41375 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4033_625004023_5000035_39939') then {
	[_4033_625004023_5000035_39939,go_editor_globalRefs get "LampCeiling G:RzZuM8b6yYs"] call (_4033_625004023_5000035_39939 getvariable 'proto' getvariable 'addConnection');
	[_4033_625004023_5000035_39939,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (4)"] call (_4033_625004023_5000035_39939 getvariable 'proto' getvariable 'addConnection');
	[_4033_625004023_5000035_39939,go_editor_globalRefs get "LampCeiling G:nIWIk6czRII"] call (_4033_625004023_5000035_39939 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4026_452394026_6794432_34003') then {
	[_4026_452394026_6794432_34003,go_editor_globalRefs get "LampCeiling G:S5mD+ipln0g"] call (_4026_452394026_6794432_34003 getvariable 'proto' getvariable 'addConnection');
	[_4026_452394026_6794432_34003,go_editor_globalRefs get "LampCeiling G:BQuGl8InN4c"] call (_4026_452394026_6794432_34003 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4026_437994022_4606932_08858') then {
	[_4026_437994022_4606932_08858,go_editor_globalRefs get "LampCeiling G:WmdD2F4ypQg"] call (_4026_437994022_4606932_08858 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4034_375004032_1250036_78271') then {
	_4034_375004032_1250036_78271 setvariable ['edisenabled',false];
};
if (!isNil'_4027_875004023_7500031_49020') then {
	_4027_875004023_7500031_49020 setvariable ['name',"Первый этаж. Входная группа."];
	[_4027_875004023_7500031_49020,go_editor_globalRefs get "RedButton G:/bk1HSzuyiI"] call (_4027_875004023_7500031_49020 getvariable 'proto' getvariable 'addConnection');
	[_4027_875004023_7500031_49020,go_editor_globalRefs get "RedButton G:ji1Yi/feNFc"] call (_4027_875004023_7500031_49020 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4047_835454025_9511734_68313') then {
	_4047_835454025_9511734_68313 setvariable ['name',"Второй этаж. Левое крыло."];
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "RedButton G:HfqsSe3iRaU"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "RedButton G:AjebpdJbUNU"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "RedButton G:bd1e0L0glps"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "RedButton G:QtralcJPWoA"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "RedButton G:8n4vmOZcVYg"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511734_68313,go_editor_globalRefs get "Intercom G:4/wwqSRELj8"] call (_4047_835454025_9511734_68313 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4024_226814021_5002431_56643') then {
	_4024_226814021_5002431_56643 setvariable ['name',"Первый этаж. Правое крыло. Кухня."];
	[_4024_226814021_5002431_56643,go_editor_globalRefs get "RedButton G:zbXUtKxPtFc"] call (_4024_226814021_5002431_56643 getvariable 'proto' getvariable 'addConnection');
	[_4024_226814021_5002431_56643,go_editor_globalRefs get "RedButton G:QhdIXJ0UnDY"] call (_4024_226814021_5002431_56643 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4028_875004020_2500034_61520') then {
	_4028_875004020_2500034_61520 setvariable ['name',"Второй этаж. Правое крыло."];
	[_4028_875004020_2500034_61520,go_editor_globalRefs get "RedButton G:IFPkvF5Dt4w"] call (_4028_875004020_2500034_61520 getvariable 'proto' getvariable 'addConnection');
	[_4028_875004020_2500034_61520,go_editor_globalRefs get "RedButton G:iw44gmmN2Mo"] call (_4028_875004020_2500034_61520 getvariable 'proto' getvariable 'addConnection');
	[_4028_875004020_2500034_61520,go_editor_globalRefs get "RedButton G:mIC0aid4Ae8"] call (_4028_875004020_2500034_61520 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_186044056_9160237_20776') then {
	_4004_186044056_9160237_20776 setvariable ['name',"Первый этаж. Входная группа."];
	[_4004_186044056_9160237_20776,go_editor_globalRefs get "ElectricalShieldSmall G:l2Y+w3c5mwI"] call (_4004_186044056_9160237_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_686044056_9160237_20776') then {
	_4004_686044056_9160237_20776 setvariable ['name',"Первый этаж. Правое крыло. Кухня."];
	[_4004_686044056_9160237_20776,go_editor_globalRefs get "ElectricalShieldSmall G:5tPSYWljSTo"] call (_4004_686044056_9160237_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160236_20776') then {
	_4003_686044056_9160236_20776 setvariable ['name',"Уличное освещение."];
	[_4003_686044056_9160236_20776,go_editor_globalRefs get "ElectricalShield G:BR05v5D45ZA"] call (_4003_686044056_9160236_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_186044056_9160236_70776') then {
	_4004_186044056_9160236_70776 setvariable ['name',"Второй этаж. Правое крыло."];
	[_4004_186044056_9160236_70776,go_editor_globalRefs get "ElectricalShieldSmall G:aNkEhGxpPYY"] call (_4004_186044056_9160236_70776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160236_70776') then {
	_4003_686044056_9160236_70776 setvariable ['name',"Второй этаж. Левое крыло."];
	[_4003_686044056_9160236_70776,go_editor_globalRefs get "ElectricalShieldSmall G:y2vQzELsluA"] call (_4003_686044056_9160236_70776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160237_20776') then {
	_4003_686044056_9160237_20776 setvariable ['name',"Первый этаж. Левое крыло."];
	[_4003_686044056_9160237_20776,go_editor_globalRefs get "ElectricalShieldSmall G:D4hhxFJEMKM"] call (_4003_686044056_9160237_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160235_70776') then {
	_4003_686044056_9160235_70776 setvariable ['name',"Верхотура"];
	[_4003_686044056_9160235_70776,go_editor_globalRefs get "ElectricalShield G:aL5OTxyNxco"] call (_4003_686044056_9160235_70776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4039_237064025_4521535_34606') then {
	[_4039_237064025_4521535_34606,go_editor_globalRefs get "LampCeiling G:GhyA0/mPKB8"] call (_4039_237064025_4521535_34606 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4011_000004055_7500034_97359') then {
	_4011_000004055_7500034_97359 setvariable ['name',"Генераторная"];
	[_4011_000004055_7500034_97359,go_editor_globalRefs get "RedButton G:2Y5XzDeSbnc"] call (_4011_000004055_7500034_97359 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4017_170414051_3002936_26777') then {
	[_4017_170414051_3002936_26777,go_editor_globalRefs get "LampCeiling G:ZtPLJzG0HNM"] call (_4017_170414051_3002936_26777 getvariable 'proto' getvariable 'addConnection');
	[_4017_170414051_3002936_26777,go_editor_globalRefs get "LampCeiling G:6Hk0pG2LyqI"] call (_4017_170414051_3002936_26777 getvariable 'proto' getvariable 'addConnection');
	[_4017_170414051_3002936_26777,go_editor_globalRefs get "LampCeiling G:g7G/XnsBC9A"] call (_4017_170414051_3002936_26777 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4005_186044056_9160236_20776') then {
	_4005_186044056_9160236_20776 setvariable ['name',"Ларёк"];
	[_4005_186044056_9160236_20776,go_editor_globalRefs get "ElectricalShieldSmall G:K+aD+A9Ny5s"] call (_4005_186044056_9160236_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4005_686044056_9160236_20776') then {
	_4005_686044056_9160236_20776 setvariable ['name',"Генераторная"];
	[_4005_686044056_9160236_20776,go_editor_globalRefs get "ElectricalShield G:+luUbpyNzq4"] call (_4005_686044056_9160236_20776 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4000_000004037_5000035_54056') then {
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E (5)"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E (9)"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:SLKfMovNocM"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:DERdhpwI1BE"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:MOBhI0NCvxc"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:Q/wMdw65U8Y"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:SaqNZ03gHeU"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000035_54056,go_editor_globalRefs get "LampCeiling G:aTykogdJ1gU"] call (_4000_000004037_5000035_54056 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4068_316894067_0622632_29673') then {
	[_4068_316894067_0622632_29673,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (3)"] call (_4068_316894067_0622632_29673 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4069_492924071_2988332_01056') then {
	[_4069_492924071_2988332_01056,go_editor_globalRefs get "RedButton G:iBr4jx3Wi0I"] call (_4069_492924071_2988332_01056 getvariable 'proto' getvariable 'addConnection');
	[_4069_492924071_2988332_01056,go_editor_globalRefs get "RedButton G:EXKORnjUGZM"] call (_4069_492924071_2988332_01056 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4067_558354068_1237832_35655') then {
	[_4067_558354068_1237832_35655,go_editor_globalRefs get "LampCeiling G:Tfyf2IaEkFM"] call (_4067_558354068_1237832_35655 getvariable 'proto' getvariable 'addConnection');
	[_4067_558354068_1237832_35655,go_editor_globalRefs get "LampCeiling G:RZhTnTC73d8"] call (_4067_558354068_1237832_35655 getvariable 'proto' getvariable 'addConnection');
	[_4067_558354068_1237832_35655,go_editor_globalRefs get "LampCeiling G:Tfyf2IaEkFM (1)"] call (_4067_558354068_1237832_35655 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4045_506104025_4533735_37244') then {
	[_4045_506104025_4533735_37244,go_editor_globalRefs get "LampCeiling G:KRZfyWUeOck"] call (_4045_506104025_4533735_37244 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3970_125004048_1250029_97929') then {
	_3970_125004048_1250029_97929 setvariable ['weight',"1"];
};
if (!isNil'_3958_195314040_1843329_97929') then {
	_3958_195314040_1843329_97929 setvariable ['weight',"1"];
};
if (!isNil'_3949_000004048_6250030_00000') then {
	_3949_000004048_6250030_00000 setvariable ['weight',"1"];
};
if (!isNil'_4035_132574042_8337430_94849') then {
	_4035_132574042_8337430_94849 setvariable ['name',"Статуя"];
	_4035_132574042_8337430_94849 setvariable ['desc',"Первой швее на фабрике"];
};
if (!isNil'_4016_250004051_1250034_99020') then {
	_4016_250004051_1250034_99020 setvariable ['islocked',true];
};
if (!isNil'_4009_750004052_5000034_99020') then {
	_4009_750004052_5000034_99020 setvariable ['islocked',true];
};
if (!isNil'_4015_114264051_7805234_98373') then {
	[_4015_114264051_7805234_98373,'Tumannik',1,58] call (_4015_114264051_7805234_98373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4015_114264051_7805234_98373,'Tumannik',1,100] call (_4015_114264051_7805234_98373 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4010_793464054_4775434_84227') then {
	[_4010_793464054_4775434_84227,'Tumannik',1,100] call (_4010_793464054_4775434_84227 getvariable 'proto' getvariable 'createItemInContainer');
	[_4010_793464054_4775434_84227,'Tumannik',1,29] call (_4010_793464054_4775434_84227 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4069_080574066_8750030_79514') then {
	_4069_080574066_8750030_79514 setvariable ['islocked',true];
};
if (!isNil'_4067_756104068_9772930_86520') then {
	_4067_756104068_9772930_86520 setvariable ['islocked',true];
};
if (!isNil'_4066_747314067_5549331_93539') then {
	[_4066_747314067_5549331_93539,'SigaretteDisabled',6,100] call (_4066_747314067_5549331_93539 getvariable 'proto' getvariable 'createItemInContainer');
	[_4066_747314067_5549331_93539,'SamokrutkaDisabled',8,100] call (_4066_747314067_5549331_93539 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4062_497074067_1679732_43538') then {
	_4062_497074067_1679732_43538 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4066_442634067_1804231_98770') then {
	_4066_442634067_1804231_98770 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4066_913824067_1801832_43532') then {
	_4066_913824067_1801832_43532 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4063_653324072_1203631_86020') then {
	_4063_653324072_1203631_86020 setvariable ['name',"Ручка без стержня"];
};
if (!isNil'_4061_627934070_0376031_81717') then {
	_4061_627934070_0376031_81717 setvariable ['name',"Запасный ключ от Фабричного"];
	_4061_627934070_0376031_81717 setvariable ['desc',"Для работы надо!"];
};
if (!isNil'_4061_824954070_8850130_95625') then {
	_4061_824954070_8850130_95625 setvariable ['name',"Сейф"];
	[_4061_824954070_8850130_95625,'Zvak',1,100,[["var","stackcount",10]]] call (_4061_824954070_8850130_95625 getvariable 'proto' getvariable 'createItemInContainer');
	[_4061_824954070_8850130_95625,'Zvak',1,75,[["var","stackcount",10]]] call (_4061_824954070_8850130_95625 getvariable 'proto' getvariable 'createItemInContainer');
	[_4061_824954070_8850130_95625,'Zvak',1,50,[["var","stackcount",5]]] call (_4061_824954070_8850130_95625 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4066_609384061_2426830_83279') then {
	_4066_609384061_2426830_83279 setvariable ['weight',"1000"];
};
if (!isNil'_4005_875004027_3750036_11520') then {
	_4005_875004027_3750036_11520 setvariable ['islocked',true];
};
if (!isNil'_4005_194584033_4079635_84485') then {
	_4005_194584033_4079635_84485 setvariable ['islocked',true];
};
if (!isNil'_4008_528814022_6792036_08043') then {
	_4008_528814022_6792036_08043 setvariable ['spawnpointname',"RPriyatelDorm"];
};
if (!isNil'_4007_289314036_3161635_85827') then {
	_4007_289314036_3161635_85827 setvariable ['spawnpointname',"RLekarDorm"];
};
if (!isNil'_4003_508544033_3056637_17892') then {
	[_4003_508544033_3056637_17892,'Bandage',2,100] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'Rag',1,100] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'Syringe',1,100] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'PainkillerBox',1,100] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'NeedleWithThreads',2,100] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'NeedleWithThreads',1,70] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056637_17892,'NeedleWithThreads',1,50] call (_4003_508544033_3056637_17892 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3974_669684030_6586937_18520') then {
	[_3974_669684030_6586937_18520,'HandcuffItem',1,100,[["var","keylockers","NaruchKey"]]] call (_3974_669684030_6586937_18520 getvariable 'proto' getvariable 'createItemInContainer');
	[_3974_669684030_6586937_18520,'RopeItem',1,100] call (_3974_669684030_6586937_18520 getvariable 'proto' getvariable 'createItemInContainer');
	[_3974_669684030_6586937_18520,'Key',1,100,[["var","name","Ключ от наручников"],["var","preinit@__keytypesstr","NaruchKey"]]] call (_3974_669684030_6586937_18520 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3977_916754034_9587438_64833') then {
	[_3977_916754034_9587438_64833,'Rag',2,100] call (_3977_916754034_9587438_64833 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587438_64833,'Bandage',2,100] call (_3977_916754034_9587438_64833 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587438_64833,'NeedleWithThreads',2,100] call (_3977_916754034_9587438_64833 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587438_64833,'PainkillerBox',1,100] call (_3977_916754034_9587438_64833 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3981_853764029_6223137_18520') then {
	_3981_853764029_6223137_18520 setvariable ['islocked',true];
};
if (!isNil'_3976_616704034_7785637_30444') then {
	_3976_616704034_7785637_30444 setvariable ['islocked',true];
};
if (!isNil'_3981_222414032_2087441_02331') then {
	_3981_222414032_2087441_02331 setvariable ['name',"Мешочек c зубами"];
	_3981_222414032_2087441_02331 setvariable ['desc',"Можно сыграть и отлично провести время"];
	_3981_222414032_2087441_02331 setvariable ['countslots',16];
	[_3981_222414032_2087441_02331,'Tooth',16,100] call (_3981_222414032_2087441_02331 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3976_000004034_2500040_17519') then {
	[_3976_000004034_2500040_17519,'RopeItem',1,100] call (_3976_000004034_2500040_17519 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3979_621344034_0034240_16192') then {
	_3979_621344034_0034240_16192 setvariable ['name',"Дубликат ключа от участка"];
	_3979_621344034_0034240_16192 setvariable ['desc',"Если ты каким-то чудом его нашёл - молчи о нём и не говори никому!"];
};
if (!isNil'_3974_891364021_7397535_64085') then {
	_3974_891364021_7397535_64085 setvariable ['name',"Сортир"];
	_3974_891364021_7397535_64085 setvariable ['desc',"Обыкновенный уличный сортир"];
};
if (!isNil'_3974_786134033_5002437_28997') then {
	_3974_786134033_5002437_28997 setvariable ['name',"Стальной сейф"];
	[_3974_786134033_5002437_28997,'Revolver',1,100] call (_3974_786134033_5002437_28997 getvariable 'proto' getvariable 'createItemInContainer');
	[_3974_786134033_5002437_28997,'AmmoRevolver',1,100,[["var","stackcount",16]]] call (_3974_786134033_5002437_28997 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3980_522714022_0053735_60637') then {
	_3980_522714022_0053735_60637 setvariable ['desc',"Замок стырен"];
};
if (!isNil'_3977_878424034_2717340_04393') then {
	_3977_878424034_2717340_04393 setvariable ['name',"Нужник"];
	_3977_878424034_2717340_04393 setvariable ['desc',"Все свои ""дела"" делать сюда, а потом вылить"];
};
if (!isNil'_3976_761474026_5017135_60740') then {
	_3976_761474026_5017135_60740 setvariable ['name',"Ящик"];
};
if (!isNil'_3991_640634031_6001035_92449') then {
	_3991_640634031_6001035_92449 setvariable ['islocked',true];
};
if (!isNil'_4040_877934021_7102130_99020') then {
	_4040_877934021_7102130_99020 setvariable ['spawnpointname',"RZavZhil"];
};
if (!isNil'_4027_799074031_1333030_99129') then {
	_4027_799074031_1333030_99129 setvariable ['spawnpointname',"RKomendantDorm"];
};
if (!isNil'_4038_526864031_0869133_92296') then {
	_4038_526864031_0869133_92296 setvariable ['spawnpointname',"RSlesarDorm"];
};
if (!isNil'_4035_017334031_2895533_92296') then {
	_4035_017334031_2895533_92296 setvariable ['spawnpointname',"RKoldyrDorm"];
};
if (!isNil'_4030_096924033_0385733_94363') then {
	_4030_096924033_0385733_94363 setvariable ['spawnpointname',"RMolDorm"];
};
if (!isNil'_4046_051514032_9072333_92296') then {
	_4046_051514032_9072333_92296 setvariable ['spawnpointname',"RCexDorm"];
};
if (!isNil'_4046_945564022_4687534_02227') then {
	_4046_945564022_4687534_02227 setvariable ['spawnpointname',"RCherDorm0"];
};
if (!isNil'_4044_670654022_3674334_02095') then {
	_4044_670654022_3674334_02095 setvariable ['spawnpointname',"RCherDorm1"];
};
if (!isNil'_4065_510254070_0705631_05020') then {
	_4065_510254070_0705631_05020 setvariable ['spawnpointname',"RTorgDorm"];
};
if (!isNil'_3976_206544030_7785637_31403') then {
	_3976_206544030_7785637_31403 setvariable ['spawnpointname',"RUchastDorm"];
};
if (!isNil'_3990_947754035_8142135_95543') then {
	_3990_947754035_8142135_95543 setvariable ['spawnpointname',"RRostDorm"];
};
if (!isNil'_3995_703614035_9272535_95543') then {
	_3995_703614035_9272535_95543 setvariable ['spawnpointname',"RDolgDorm"];
};
if (!isNil'_3994_949224063_2680730_96692') then {
	_3994_949224063_2680730_96692 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3985_375004067_7500030_87143') then {
	_3985_375004067_7500030_87143 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3997_438724046_3418030_99571') then {
	_3997_438724046_3418030_99571 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4012_829594047_0022031_03477') then {
	_4012_829594047_0022031_03477 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4056_398684055_7150931_90103') then {
	_4056_398684055_7150931_90103 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4077_467534076_2241230_99490') then {
	_4077_467534076_2241230_99490 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4082_726324071_6984930_96336') then {
	_4082_726324071_6984930_96336 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4075_615974070_1220731_05119') then {
	_4075_615974070_1220731_05119 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3976_000004033_0000040_17519') then {
	_3976_000004033_0000040_17519 setvariable ['spawnpointname',"RUchastHelperDorm"];
};
if (!isNil'_3965_754884047_4077131_38000') then {
	_3965_754884047_4077131_38000 setvariable ['spawnpointname',"RHeadGuardDorm"];
};
if (!isNil'_3952_661624043_9658231_38000') then {
	_3952_661624043_9658231_38000 setvariable ['spawnpointname',"RRookieGuardDorm1"];
};
if (!isNil'_3954_481454044_1167031_37500') then {
	_3954_481454044_1167031_37500 setvariable ['spawnpointname',"RRookieGuardDorm0"];
};
if (!isNil'_4087_000004011_0000017_86520') then {
	[_4087_000004011_0000017_86520,"govnelin"] call (_4087_000004011_0000017_86520 getvariable 'proto' getvariable 'setEffectType');
};
if (!isNil'_4069_708984053_2189930_60897') then {
	_4069_708984053_2189930_60897 setvariable ['islocked',true];
};
if (!isNil'_4038_990484093_6584524_81828') then {
	_4038_990484093_6584524_81828 setvariable ['islocked',true];
};
if (!isNil'_4001_246343916_1252417_87500') then {
	_4001_246343916_1252417_87500 setvariable ['islocked',true];
};
if (!isNil'_4055_224614066_2077633_85763') then {
	_4055_224614066_2077633_85763 setvariable ['name',"Брус"];
	_4055_224614066_2077633_85763 setvariable ['desc',"Деревяха"];
};
if (!isNil'_4055_082284066_2734435_20523') then {
	_4055_082284066_2734435_20523 setvariable ['name',"Брус"];
	_4055_082284066_2734435_20523 setvariable ['desc',"Деревяха"];
};
if (!isNil'_4029_292483719_6250048_75000') then {
	_4029_292483719_6250048_75000 setvariable ['name',"Странный шкаф"];
};
if (!isNil'_4034_250003723_8750048_12500') then {
	_4034_250003723_8750048_12500 setvariable ['islocked',true];
};
if (!isNil'_4031_031743723_4040548_70220') then {
	[_4031_031743723_4040548_70220,'Bryak',23,100] call (_4031_031743723_4040548_70220 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4026_000004020_8750016_62500') then {
	_4026_000004020_8750016_62500 setvariable ['destination',"EnterLuk"];
};
if (!isNil'_4026_033204020_4653330_99574') then {
	_4026_033204020_4653330_99574 setvariable ['destination',"ExitLuk"];
};
if (!isNil'_3952_900634065_1899431_14468') then {
	_3952_900634065_1899431_14468 setvariable ['name',"Бочка"];
	_3952_900634065_1899431_14468 setvariable ['desc',"Металлическая!"];
};
if (!isNil'_3935_251464057_9597233_17921') then {
	[_3935_251464057_9597233_17921,go_editor_globalRefs get "ElectricalShieldSmall G:AzVfeEX8vOI"] call (_3935_251464057_9597233_17921 getvariable 'proto' getvariable 'addConnection');
	[_3935_251464057_9597233_17921,go_editor_globalRefs get "ElectricalShieldSmall G:8DrWNsn9/UM"] call (_3935_251464057_9597233_17921 getvariable 'proto' getvariable 'addConnection');
	[_3935_251464057_9597233_17921,go_editor_globalRefs get "PowerSwitcherBox_Activator G:jf50a0d4mCA"] call (_3935_251464057_9597233_17921 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3963_443364045_6232932_32338') then {
	[_3963_443364045_6232932_32338,go_editor_globalRefs get "StationSpeaker G:PVIZKloCU1M"] call (_3963_443364045_6232932_32338 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3974_457034032_6416038_56679') then {
	_3974_457034032_6416038_56679 setvariable ['name',"Кнопка тревоги!"];
	_3974_457034032_6416038_56679 setvariable ['desc',"Нажать в случае потери контроля над обстановкой."];
	
['SCR_GuardButtonDorm',_3974_457034032_6416038_56679,nil] call createGameObjectScript;
};
if (!isNil'_3958_965824045_1452632_86649') then {
	[_3958_965824045_1452632_86649,go_editor_globalRefs get "LampCeiling G:qsyEIvDjAgI"] call (_3958_965824045_1452632_86649 getvariable 'proto' getvariable 'addConnection');
	[_3958_965824045_1452632_86649,go_editor_globalRefs get "LampCeiling G:Oyc9VIGwkE4"] call (_3958_965824045_1452632_86649 getvariable 'proto' getvariable 'addConnection');
	[_3958_965824045_1452632_86649,go_editor_globalRefs get "LampCeiling G:IdCWNfQPGdo"] call (_3958_965824045_1452632_86649 getvariable 'proto' getvariable 'addConnection');
	[_3958_965824045_1452632_86649,go_editor_globalRefs get "LampCeiling G:hK2gB7rgR0k"] call (_3958_965824045_1452632_86649 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3963_535404043_4843832_85275') then {
	[_3963_535404043_4843832_85275,go_editor_globalRefs get "LampCeiling G:qsyEIvDjAgI (1)"] call (_3963_535404043_4843832_85275 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3963_259284048_7844232_85275') then {
	[_3963_259284048_7844232_85275,go_editor_globalRefs get "LampCeiling G:qsyEIvDjAgI (4)"] call (_3963_259284048_7844232_85275 getvariable 'proto' getvariable 'addConnection');
	[_3963_259284048_7844232_85275,go_editor_globalRefs get "LampCeiling G:qsyEIvDjAgI (3)"] call (_3963_259284048_7844232_85275 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3964_319094051_8200732_85275') then {
	[_3964_319094051_8200732_85275,go_editor_globalRefs get "LampCeiling G:qsyEIvDjAgI (2)"] call (_3964_319094051_8200732_85275 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3962_152594064_5339432_39930') then {
	_3962_152594064_5339432_39930 setvariable ['name',"Ворота"];
	[_3962_152594064_5339432_39930,go_editor_globalRefs get "GateCity G:784RgeR4g/8"] call (_3962_152594064_5339432_39930 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3961_488284064_5471232_41827') then {
	_3961_488284064_5471232_41827 setvariable ['name',"Прожектор #1"];
	[_3961_488284064_5471232_41827,go_editor_globalRefs get "StreetLamp G:eZRD0jnQn3s (2)"] call (_3961_488284064_5471232_41827 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3961_178474064_5471232_41665') then {
	_3961_178474064_5471232_41665 setvariable ['name',"Прожектор #2"];
	[_3961_178474064_5471232_41665,go_editor_globalRefs get "StreetLamp G:eZRD0jnQn3s (4)"] call (_3961_178474064_5471232_41665 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3963_530764065_6084032_08355') then {
	[_3963_530764065_6084032_08355,go_editor_globalRefs get "PowerSwitcher G:vgfU2yV6Yzg"] call (_3963_530764065_6084032_08355 getvariable 'proto' getvariable 'addConnection');
	[_3963_530764065_6084032_08355,go_editor_globalRefs get "PowerSwitcher G:7M9Ex3e7DBU"] call (_3963_530764065_6084032_08355 getvariable 'proto' getvariable 'addConnection');
	[_3963_530764065_6084032_08355,go_editor_globalRefs get "PowerSwitcherBig G:wORuyt6fg7U"] call (_3963_530764065_6084032_08355 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3967_544434050_2976131_95592') then {
	[_3967_544434050_2976131_95592,go_editor_globalRefs get "IntercomOld G:4i8ntN3gdtY"] call (_3967_544434050_2976131_95592 getvariable 'proto' getvariable 'addConnection');
	[_3967_544434050_2976131_95592,go_editor_globalRefs get "RedButton G:bZsBuYUJDIg"] call (_3967_544434050_2976131_95592 getvariable 'proto' getvariable 'addConnection');
	[_3967_544434050_2976131_95592,go_editor_globalRefs get "RedButton G:O1FdMlcveHw"] call (_3967_544434050_2976131_95592 getvariable 'proto' getvariable 'addConnection');
	[_3967_544434050_2976131_95592,go_editor_globalRefs get "RedButton G:VK9gRE64Vp0"] call (_3967_544434050_2976131_95592 getvariable 'proto' getvariable 'addConnection');
	[_3967_544434050_2976131_95592,go_editor_globalRefs get "RedButton G:QaN0z5bZVNU"] call (_3967_544434050_2976131_95592 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3959_210694064_5664132_99703') then {
	_3959_210694064_5664132_99703 setvariable ['name',"Уличное освещение"];
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:eZRD0jnQn3s"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:rx403/5RY94"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:bUYa/2ZFq+E"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:+LbpR6UVeeY"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:bUYa/2ZFq+E (2)"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
	[_3959_210694064_5664132_99703,go_editor_globalRefs get "StreetLamp G:+LbpR6UVeeY (2)"] call (_3959_210694064_5664132_99703 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3960_333984051_9055231_18212') then {
	_3960_333984051_9055231_18212 setvariable ['islocked',true];
};
if (!isNil'_3965_325444051_9282230_87514') then {
	_3965_325444051_9282230_87514 setvariable ['islocked',true];
};
if (!isNil'_3963_475594044_3750031_39762') then {
	_3963_475594044_3750031_39762 setvariable ['islocked',true];
};
if (!isNil'_3959_020264044_2500031_39734') then {
	_3959_020264044_2500031_39734 setvariable ['islocked',true];
};
if (!isNil'_3956_583984043_6726131_36909') then {
	[_3956_583984043_6726131_36909,'AmmoBoxRifleBlank',6,100] call (_3956_583984043_6726131_36909 getvariable 'proto' getvariable 'createItemInContainer');
	[_3956_583984043_6726131_36909,'AmmoBoxRifle',4,100] call (_3956_583984043_6726131_36909 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3953_751464042_7878431_38000') then {
	[_3953_751464042_7878431_38000,'RopeItem',1,100] call (_3953_751464042_7878431_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_751464042_7878431_38000,'Baton1',1,100] call (_3953_751464042_7878431_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_751464042_7878431_38000,'FlashlightLoaded',1,100] call (_3953_751464042_7878431_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_751464042_7878431_38000,'MatchBox',1,100] call (_3953_751464042_7878431_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3958_739994051_5573731_37500') then {
	[_3958_739994051_5573731_37500,'Cutlet',5,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Omlet',1,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Pancakes',1,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Pie',1,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Shavirma',2,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Lepeshka',2,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
	[_3958_739994051_5573731_37500,'Bun',2,100] call (_3958_739994051_5573731_37500 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3962_701664042_7695331_38000') then {
	[_3962_701664042_7695331_38000,'CombatHat',1,100] call (_3962_701664042_7695331_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3962_701664042_7695331_38000,'ArmorLite',1,100] call (_3962_701664042_7695331_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3962_701664042_7695331_38000,'ArmyCloth1',1,100] call (_3962_701664042_7695331_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3953_302734042_7714831_38000') then {
	[_3953_302734042_7714831_38000,'RopeItem',1,100] call (_3953_302734042_7714831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_302734042_7714831_38000,'Baton1',1,100] call (_3953_302734042_7714831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_302734042_7714831_38000,'FlashlightLoaded',1,100] call (_3953_302734042_7714831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3953_302734042_7714831_38000,'MatchBox',1,100] call (_3953_302734042_7714831_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3951_548584045_9345731_37671') then {
	[_3951_548584045_9345731_37671,'RopeItem',1,100] call (_3951_548584045_9345731_37671 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_548584045_9345731_37671,'Baton1',1,100] call (_3951_548584045_9345731_37671 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_548584045_9345731_37671,'FlashlightLoaded',1,100] call (_3951_548584045_9345731_37671 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_548584045_9345731_37671,'MatchBox',1,100] call (_3951_548584045_9345731_37671 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3962_135014042_6677231_38000') then {
	[_3962_135014042_6677231_38000,'CombatHat',1,100] call (_3962_135014042_6677231_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3962_135014042_6677231_38000,'ArmorLite',1,100] call (_3962_135014042_6677231_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3962_135014042_6677231_38000,'ArmyCloth1',1,100] call (_3962_135014042_6677231_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3961_621344042_8173831_38000') then {
	[_3961_621344042_8173831_38000,'CombatHat',1,100] call (_3961_621344042_8173831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3961_621344042_8173831_38000,'ArmorLite',1,100] call (_3961_621344042_8173831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3961_621344042_8173831_38000,'ArmyCloth1',1,100] call (_3961_621344042_8173831_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3961_114504042_7404831_38000') then {
	[_3961_114504042_7404831_38000,'CombatHat',1,100] call (_3961_114504042_7404831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3961_114504042_7404831_38000,'ArmorLite',1,100] call (_3961_114504042_7404831_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3961_114504042_7404831_38000,'ArmyCloth1',1,100] call (_3961_114504042_7404831_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3960_525634042_7482931_38000') then {
	[_3960_525634042_7482931_38000,'CombatHat',1,100] call (_3960_525634042_7482931_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3960_525634042_7482931_38000,'ArmorLite',1,100] call (_3960_525634042_7482931_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3960_525634042_7482931_38000,'ArmyCloth1',1,100] call (_3960_525634042_7482931_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3959_992194042_8356931_38000') then {
	[_3959_992194042_8356931_38000,'CombatHat',1,100] call (_3959_992194042_8356931_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3959_992194042_8356931_38000,'ArmorLite',1,100] call (_3959_992194042_8356931_38000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3959_992194042_8356931_38000,'ArmyCloth1',1,100] call (_3959_992194042_8356931_38000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3951_633544045_2172931_37498') then {
	[_3951_633544045_2172931_37498,'RopeItem',1,100] call (_3951_633544045_2172931_37498 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_633544045_2172931_37498,'Baton1',1,100] call (_3951_633544045_2172931_37498 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_633544045_2172931_37498,'FlashlightLoaded',1,100] call (_3951_633544045_2172931_37498 getvariable 'proto' getvariable 'createItemInContainer');
	[_3951_633544045_2172931_37498,'MatchBox',1,100] call (_3951_633544045_2172931_37498 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3957_625004054_0000031_28679') then {
	_3957_625004054_0000031_28679 setvariable ['name',"Линда Структура"];
	_3957_625004054_0000031_28679 setvariable ['desc',"Красотка.rrrd.. у неё титьки!"];
};
if (!isNil'_3960_181884064_4689931_44694') then {
	_3960_181884064_4689931_44694 setvariable ['islocked',true];
};
if (!isNil'_3954_822274052_2812535_58392') then {
	_3954_822274052_2812535_58392 setvariable ['name',"Бандура!"];
	_3954_822274052_2812535_58392 setvariable ['desc',"Против буйных, за спокойных"];
};
