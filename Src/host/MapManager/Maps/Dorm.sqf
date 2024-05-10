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

['OldGreenToiletBowl',[4046.66,4020.63,10.125],265,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4046.68,4021.88,10.125],275,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4046.68,4023.13,10.125],265,[0,0,1]] call InitStruct; 
['OldGreenToiletBowl',[4048.45,4023.13,10.125],90.0003,[0,0,1]] call InitStruct; 
_4045_515144022_7897910_15535 = ['Umivalnik',[4045.52,4022.79,10.1553],270,[0,0,1]] call InitStruct; 
_4043_248294022_4292010_15535 = ['Umivalnik',[4043.25,4022.43,10.1553],90,[0,0,1]] call InitStruct; 
_4043_284424023_7231410_15535 = ['Umivalnik',[4043.28,4023.72,10.1553],90,[0,0,1]] call InitStruct; 
_4044_447754020_6936011_23363 = ['IStruct',[4044.45,4020.69,11.2336],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\dysh.p3d'];}] call InitStruct; // !!! realocated model !!!
['TrashCan',[4048.42,4025.21,10.1],285,[0,0,1], {go_editor_globalRefs set ["KoldyrTrash",_thisObj];
}] call InitStruct; 
['Paper',[4046.54,4024.47,11.0712],345,[0,0,1]] call InitItem; 
['Paper',[4046.65,4024.59,15.7347,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['Paper',[4046.49,4024.38,15.7337,true],15,[-0.00702907,0.000811577,0.999975]] call InitItem; 
['Paper',[4046.67,4023.41,10.1553],30,[0,0,1]] call InitItem; 
['Paper',[4047.12,4020.34,10.1553],305,[0,0,1]] call InitItem; 
['Paper',[4048.63,4023.3,10.6932],305,[0,0,1]] call InitItem; 
if ((random 1) < 0.3) then {
	['Crowbar',[4046.85,4021.85,15.7217,true],[0.0868239,0.0871559,0.992404],[-0.00759651,0.996195,-0.0868242]] call InitItem; 
};
['WoodenSmallShelf1',[4046.55,4024.52,15.6048,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['PaperHolder',[4046.55,4024.22,16.1466,true],0,[-0.0069996,-0.00688752,0.999952]] call InitItem; 
['SmallStoveGrill',[4018,4023.6,9.82862],5.00015,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',SLIGHT_LIGHT_STOVE_var];}] call InitStruct; 
['SmallStoveGrill',[4018,4024.73,9.84219],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',SLIGHT_LIGHT_STOVE_var];}] call InitStruct; 
['SmallStoveGrill',[4018,4022.48,9.84639],350,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',SLIGHT_LIGHT_STOVE_var];}] call InitStruct; 
['BlackSmallStove',[4020.7,4021.59,10.022],180,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',SLIGHT_LIGHT_BAKE_var];}] call InitStruct; 
['MediumWoodenTable',[4019.43,4020.7,9.94541],270,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4020.48,4027.89,9.95897],90.0061,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4023.14,4027.9,9.95228],85.0061,[0,0,1]] call InitStruct; 
['SofaBrown',[4026.04,4025.47,10.0277],270,[0,0,1]] call InitStruct; 
['StumpChair',[4023.96,4027.5,15.31,true],265.001,[0.00639512,0.00624495,0.99996]] call InitItem; 
['SmallWoodenTable',[4022.82,4020.65,9.96648],85,[0,0,1]] call InitStruct; 
['Shelves',[4025.48,4028.94,10.1],0,[0,0,1]] call InitStruct; 
['StripedChair',[4020.47,4026.38,9.97423],0,[0,0,1]] call InitItem; 
['WoodenChair',[4019.69,4027.44,9.95194],269.998,[0,0,1]] call InitItem; 
['WoodenChair',[4021.09,4027.41,9.96034],94.9982,[0,0,1]] call InitItem; 
['WoodenChair',[4021.11,4028.51,9.98153],74.9982,[0,0,1]] call InitItem; 
['WoodenChair',[4023.21,4026.57,9.99191],169.998,[0,0,1]] call InitItem; 
['WoodenChair',[4022.45,4028.51,9.93962],269.998,[0,0,1]] call InitItem; 
['ChairLibrary',[4023.97,4028.63,9.98945],350,[0,0,1]] call InitItem; 
_4017_911874028_2924811_54493 = ['RedSteelBox',[4017.91,4028.29,11.5449],85,[0,0,1]] call InitStruct; 
_4017_999274026_593519_98490 = ['BoardWoodenBox',[4018,4026.59,9.9849],355,[0,0,1]] call InitStruct; 
_4018_009774025_542729_96996 = ['CaseBedroomSmall',[4018.01,4025.54,9.96996],180,[0,0,1]] call InitStruct; 
_4018_027594027_522719_99531 = ['CaseBedroomSmall',[4018.03,4027.52,9.99531],180,[0,0,1]] call InitStruct; 
_4026_811774028_2036110_95566 = ['WallmountedMedicalCabinet',[4026.81,4028.2,10.9557],90,[0,0,1]] call InitStruct; 
['MeatGrinder',[4020.11,4020.51,10.784],265,[0,0,1]] call InitStruct; 
['MeatGrinder',[4023.26,4020.61,10.8025],255.001,[0,0,1]] call InitStruct; 
_4017_960214028_317639_99137 = ['SteelGreenCabinet',[4017.96,4028.32,9.99137],0,[0,0,1]] call InitStruct; 
['FryingPan',[4021.27,4021.01,10.7477],145,[0,0,1]] call InitItem; 
['ContainerGreen',[4019.71,4020.91,15.2652,true],[-0.996195,9.65599e-007,0.0871556],[0.0871556,0,0.996195]] call InitStruct; 
['CandleDisabled',[4023.15,4027.95,10.8307],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4020.53,4027.96,10.8393],0,[0,0,1]] call InitItem; 
['Umivalnik',[4023.42,4022.58,9.99595],275,[0,0,1]] call InitStruct; 
['Scales',[4018.8,4020.64,10.7798],100,[0,0,1]] call InitStruct; 
['SmallChair',[4019.74,4028.6,9.9947],279.998,[0,0,1]] call InitItem; 
['SmallRedseatChair',[4022.47,4027.29,10.0007],249.998,[0,0,1]] call InitItem; 
['MatchBox',[4019.49,4021.14,10.7991],330,[0,0,1]] call InitItem; 
['KitchenKnife',[4018.07,4025.56,15.5368,true],[-0.766707,0.641998,1.04215e-006],[-0.641982,-0.766688,-0.00699091]] call InitItem; 
['MetalCup',[4017.84,4027.49,10.5581],0,[0,0,1]] call InitItem; 
['GlassLargeBowl',[4025.53,4028.96,10.648],0,[0,0,1]] call InitItem; 
['Bucket',[4023.56,4022.09,15.0009,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['WoodenBucket',[4018.57,4028.88,15.2523,true],0,[-0.00659628,-0.00161913,0.999977]] call InitItem; 
['WoodenBucket',[4023.51,4021.56,15.2306,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
['GlassBottle',[4025.2,4028.99,10.2],0,[0,0,1]] call InitItem; 
['GlassBottle',[4025.89,4028.93,10.2],0,[0,0,1]] call InitItem; 
['GlassBottle',[4025.9,4028.94,10.65],0,[0,0,1]] call InitItem; 
['Mug',[4023.67,4022.95,10.9055],0,[0,0,1]] call InitItem; 
['GlassLargeBreaker',[4025.85,4028.98,11.55],0,[0,0,1]] call InitItem; 
['CuttingBoard',[4018.96,4021.05,10.81],280,[0,0,1]] call InitItem; 
['CuttingBoard',[4025.19,4028.95,11.1],95,[0,0,1]] call InitItem; 
['CuttingBoard',[4022.54,4020.7,10.8222],280,[0,0,1]] call InitItem; 
['Kastrula',[4025.18,4028.95,11.55],0,[0,0,1]] call InitItem; 
['Kastrula',[4023.43,4022.64,15.8675,true],0.43688,[-0.0868241,0.0871557,0.992404]] call InitItem; 
['OlderWoodenCup',[4018.12,4027.42,10.5581],0,[0,0,1]] call InitItem; 
['Polovnik',[4023.43,4022.54,15.9891,true],0,[-0.00659628,0.705945,0.708235]] call InitItem; 
['FoodPlate',[4022.87,4020.94,10.8311],0,[0,0,1]] call InitItem; 
['SoupPlate',[4020.55,4027.76,10.8459],0,[0,0,1]] call InitItem; 
['SoupPlate',[4019.35,4020.52,10.81],0,[0,0,1]] call InitItem; 
['SoupPlate',[4023.42,4022.9,15.8317,true],0,[0,-0.34202,0.939693]] call InitItem; 
['WoodenCup',[4018.09,4027.63,15.6322,true],0,[-0.00659628,-0.00161913,0.999977]] call InitItem; 
['SmallWoodenTable',[4046.2,4032.16,10.0848],0,[0,0,1]] call InitStruct; 
['OldGraveFence',[4038.03,4032.23,10.2757],0,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4037.68,4032.23,17.2522,true],180,[0,-1.91609e-005,-1]] call InitStruct; 
['GreenArmChair',[4045.99,4029.84,10.0885],185,[0,0,1]] call InitStruct; 
['BrownOldArmchair',[4046.07,4034.44,10.0827],175,[0,0,1]] call InitStruct; 
['ThickLightConcreteColumn',[4037.57,4031.08,10.6774],0,[0,0,1]] call InitStruct; 
['ThickLightConcreteColumn',[4037.54,4033.33,10.7302],270,[0,0,1]] call InitStruct; 
['BrownOldSofa',[4048,4032.12,10.0849],270,[0,0,1]] call InitStruct; 
['MediumBetonWall',[4038.23,4032.2,14.8165,true],[-1.19231e-008,-0.0174447,0.999848],[1,0,1.19249e-008]] call InitStruct; 
_4037_716064032_2500010_37500 = ['BarrelCampfireBig1',[4037.72,4032.25,10.375],155,[0,0,1], {_thisObj setvariable ['model','a3\props_f_enoch\military\garbage\garbagebarrel_02_buried_f.p3d']; _thisObj setvariable ['light',SLIGHT_WEAK_FIRE_var];}] call InitStruct; // !!! realocated model !!!
['SquareWoodenBox',[4048.13,4029.83,10.1199],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4047.67,4034.49,10.1287],0,[0,0,1]] call InitStruct; 
['PictureFoliesBergere',[4043.77,4029.3,11.4299],0,[0,0,1]] call InitStruct; 
['RedCarpet',[4043.01,4032.13,9.50924],270,[0,0,1]] call InitStruct; 
['LargeClothCabinet',[4042.92,4034.68,10.0871],0,[0,0,1]] call InitStruct; 
['SmallBookcase',[4037.3,4029.97,10.0593],270,[0,0,1]] call InitStruct; 
_4037_618654032_218759_84451 = ['Forge',[4037.62,4032.22,9.84451],270,[0,0,1]] call InitStruct; 
_4044_608404034_8510710_04595 = ['IStruct',[4044.61,4034.85,15.4541,true],0,[0.00161964,0.494275,0.869304], {_thisObj setvariable ['model','ml\ml_object_new\model_24\batareya.p3d'];}] call InitStruct; // !!! realocated model !!!
_4031_000004029_2500011_00000 = ['ConcreteWallWithNetfence',[4031,4029.25,11],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SingleWhiteBed',[4028.82,4030.61,10.0994],176.507,[0,0,1], {go_editor_globalRefs set ["RKomendantDormBed",_thisObj];
}] call InitStruct; 
['WoodenOfficeTable',[4032.42,4033.46,10.1102],270,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4029.52,4030.88,10.1],90,[0,0,1]] call InitStruct; 
_4029_571534030_3750010_50000 = ['KeyHolder',[4029.57,4030.38,10.5],180,[0,0,1]] call InitStruct; 
['SmallSteelTable',[4027.31,4029.71,10.1],0,[0,0,1]] call InitStruct; 
['SmallChair',[4031.73,4033.31,10.0962],255,[0,0,1]] call InitItem; 
['SmallChair',[4027.1,4030.2,10.0963],330,[0,0,1]] call InitItem; 
['WoodenSmallShelf1',[4026.81,4031.68,15.6018,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['MatchBox',[4027.55,4029.79,10.9051],315,[0,0,1]] call InitItem; 
['PaperHolder',[4032.57,4034.2,10.9313],355,[0,0,1]] call InitItem; 
['Paper',[4032.26,4034.14,10.9332],10,[0,0,1]] call InitItem; 
['Paper',[4032.3,4033.47,10.9329],0,[0,0,1]] call InitItem; 
['PenRed',[4032.25,4032.82,10.9329],325,[0,0,1]] call InitItem; 
['PenBlack',[4032.31,4032.85,10.9329],355,[0,0,1]] call InitItem; 
['MetalCup',[4032.48,4032.64,10.9191],35,[0,0,1]] call InitItem; 
['BigFileCabinet',[4027.8,4034.83,10.1299],270,[0,0,1]] call InitStruct; 
['Briefcase',[4026.74,4031.73,11.0808],95,[0,0,1]] call InitItem; 
['LuxuryRedCurtain',[4029.2,4034,6.86464],265,[0,0,1]] call InitStruct; 
['Notepad',[4032.46,4032.79,10.9329],0,[0,0,1]] call InitItem; 
['Baton',[4026.93,4031.66,11.0688],280,[0,0,1]] call InitItem; 
['WoodenChair',[4033.49,4033.84,10.067],20,[0,0,1]] call InitItem; 
['BreadChopped',[4026.95,4031.38,15.7333,true],25,[-0.00678136,0.00201983,0.999975]] call InitItem; 
['BreadChopped',[4026.85,4031.46,15.7321,true],335,[-0.00590623,-0.00389598,0.999975]] call InitItem; 
['ButterPiece',[4026.95,4031.81,15.7439,true],335,[-0.00590623,-0.00389598,0.999975]] call InitItem; 
['ButterPiece',[4026.95,4031.86,15.7449,true],45.0002,[-0.00567777,0.00421856,0.999975]] call InitItem; 
['FoodPlate',[4026.93,4031.83,15.7495,true],0,[-0.0069996,-0.00103549,0.999975]] call InitItem; 
_4032_423834032_4235810_38512 = ['SteelMedicalBox',[4032.42,4032.42,15.3813,true],[4.25984e-008,4.85035e-007,1],[-0.0871557,-0.996195,4.86902e-007]] call InitItem; 
['LuxuryDoubleBed',[4044.56,4033.86,13.0485],0.000122943,[0,0,1], {go_editor_globalRefs set ["RCexDormBed",_thisObj];
}] call InitStruct; 
['Shelves',[4048.72,4030.74,13.0454],90,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4048.34,4033.22,13.0528],270,[0,0,1]] call InitStruct; 
['WoodenSmallShelf1',[4048.31,4029.78,13.0528],270,[0,0,1]] call InitStruct; 
['OrangeCarpet1',[4046.52,4032.75,13.0488],255,[0,0,1]] call InitStruct; 
['Bookcase',[4047.6,4034.76,13.0528],0,[0,0,1]] call InitStruct; 
['RedCarpetWall',[4043.04,4033.42,14.6848],0,[0,0,1]] call InitStruct; 
['CaseBedroom',[4045.87,4034.86,13.0067],270,[0,0,1]] call InitStruct; 
['SmallBookcase',[4043.56,4031.94,13.0528],180,[0,0,1]] call InitStruct; 
['LampKerosene',[4048.43,4033.65,13.9276],300,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['SmallStoveGrill',[4048.47,4031.64,12.9028],180,[0,0,1], {_thisObj setvariable ['lightisenabled',false]; _thisObj setvariable ['light',SLIGHT_LIGHT_STOVE_var];}] call InitStruct; 
['SmallTrashCan',[4045.5,4031.07,13.0528],0.000122943,[0,0,1]] call InitStruct; 
['MeatGrinder',[4048.48,4032.38,13.9205],195,[0,0,1]] call InitStruct; 
['FryingPan',[4048.56,4032.83,13.9212],30,[0,0,1]] call InitItem; 
['ChairCasual',[4047.55,4033.66,13.0367],15,[0,0,1]] call InitItem; 
['OldGreenToiletBowl',[4043.47,4030.06,13.0564],225,[0,0,1]] call InitStruct; 
['Umivalnik',[4044.49,4031.33,13.0609],180,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[4043.31,4034.61,13.0503],180,[0,0,1]] call InitStruct; 
['MatchBox',[4048.22,4032.31,13.9368],315,[0,0,1]] call InitItem; 
['Paper',[4048.14,4033.06,13.9397],30,[0,0,1]] call InitItem; 
['PenBlack',[4048.19,4033.01,13.9397],60.0003,[0,0,1]] call InitItem; 
['PaperHolder',[4048.23,4033.46,13.9397],0,[0,0,1]] call InitItem; 
['Muka',[4048.75,4031.12,13.5804],290,[0,0,1]] call InitItem; 
if ((random 1) < 0.5) then {
	['Muka',[4048.73,4030.85,13.5841],345,[0,0,1]] call InitItem; 
};
['KitchenKnife',[4048.51,4033.24,18.9427,true],[0.984808,-0.173649,-2.14101e-006],[-0.173649,-0.984808,9.50929e-007]] call InitItem; 
['Meat',[4048.67,4031.05,14.1475],20,[0,0,1]] call InitItem; 
if ((random 1) < 0.5) then {
	['Meat',[4048.66,4030.48,14.1442],15,[0,0,1]] call InitItem; 
};
_4045_883304034_7033714_16785 = ['Documents',[4045.88,4034.7,14.1678],20,[0,0,1], {go_editor_globalRefs set ["TaskDocsCex",_thisObj];
}] call InitItem; 
['PaperHolder',[4042.3,4023.03,10.7972],0,[0,0,1]] call InitItem; 
['Paper',[4042.09,4022.41,10.7972],345,[0,0,1]] call InitItem; 
['PosterGirl1',[4041.36,4025.45,10.1],0,[0,0,1]] call InitStruct; 
['PenRed',[4042.27,4022.16,10.7972],90,[0,0,1]] call InitItem; 
['PenBlack',[4042.25,4022.25,10.7972],60,[0,0,1]] call InitItem; 
['SignNoEntry2',[4038.41,4025.78,17.1922,true],90,[3.01992e-007,1,-4.37114e-008]] call InitStruct; 
['SingleWhiteBed',[4041.42,4020.65,10.064],92.0003,[0,0,1], {go_editor_globalRefs set ["RZavZhilBed",_thisObj];
}] call InitStruct; 
['BrickThinWallSmall',[4039.38,4024.25,10],90,[0,0,1]] call InitStruct; 
['BigClothCabinetNew',[4042.09,4025.13,10.0936],0,[0,0,1]] call InitStruct; 
['WoodenOfficeTable3',[4042.22,4022.59,10.1],270,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4037.92,4020.32,10.2171],90,[0,0,1], {go_editor_globalRefs set ["ZavKartoteka",_thisObj];
}] call InitStruct; 
['SteelGreenCabinet',[4037.35,4023.5,10.0944],0,[0,0,1]] call InitStruct; 
['BrownLeatherChair',[4039.52,4020.48,10.1],15,[0,0,1]] call InitStruct; 
['Candle',[4040.42,4024.24,11.0566],0,[0,0,1]] call InitItem; 
['SmallChair',[4041.57,4022.28,10.0938],255,[0,0,1]] call InitItem; 
['SquareWoodenBox',[4040.05,4024.63,10.1034],0,[0,0,1]] call InitStruct; 
['MatchBox',[4042.08,4022.83,10.7972],0,[0,0,1]] call InitItem; 
['Briefcase',[4039.99,4024.29,11.0664],0,[0,0,1]] call InitItem; 
['Bread',[4042.41,4024.29,11.1],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.5) then {
	['Bread',[4042.44,4024.05,10.65],200,[0,0,1]] call InitItem; 
};
['Shelves',[4042.43,4023.99,10.1],90,[0,0,1]] call InitStruct; 
_4037_090334021_7871110_83532 = ['KeyHolder',[4037.09,4021.79,10.8353],180,[0,0,1]] call InitStruct; 
['BloodPoolSmall',[4034.53,4030.24,13.0431],0,[0,0,1]] call InitItem; 
['WoodenTableHandmade',[4035.17,4034.53,13.0528],182,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4032.51,4030.15,13.0528],345,[0,0,1], {go_editor_globalRefs set ["KoldyrAlkoBox",_thisObj];
}] call InitStruct; 
['BloodPoolMedium',[4033.99,4032.03,13.0429],0,[0,0,1]] call InitItem; 
['WoodenChair',[4033.02,4031.31,18.2415,true],[0.258819,-0.965926,-8.66658e-007],[-0.965926,-0.258819,3.08639e-009]] call InitItem; 
['SurgicalSaw',[4032.19,4034.53,13.0272],0,[0,0,1]] call InitItem; 
['GlassBottle',[4033.4,4029.6,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4034.87,4034.52,19.0075,true],[-1.84317e-006,3.3782e-006,1],[0.97437,0.224951,1.036e-006]] call InitItem; 
['GlassBottle',[4032.68,4033.23,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4036.54,4032.1,13.0511],0,[0,0,1]] call InitItem; 
['GlassBottle',[4033.46,4029.78,18.086,true],[-0.707108,0.707106,-9.12214e-007],[0.707106,0.707108,5.33851e-008]] call InitItem; 
['Kastrula',[4034.31,4033.86,13.0528],270,[0,0,1]] call InitItem; 
['Bone',[4034.43,4034.58,13.2284],257,[0,0,1]] call InitItem; 
['Polovnik',[4033.08,4031.52,13.0528],90,[0,0,1]] call InitItem; 
['SleepingMatras',[4036.08,4030.69,13.1825],85.0011,[0,0,1], {go_editor_globalRefs set ["RKoldyrDormBed",_thisObj];
}] call InitStruct; 
['FryingPan',[4032.74,4031.89,13.9793],10,[0,0,1]] call InitItem; 
['Candle',[4032.65,4032.83,14.0042],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['Candle',[4034.36,4034.38,13.987],257,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['Syringe',[4032.52,4032.66,14.0071],0,[0,0,1]] call InitItem; 
['Syringe',[4033.77,4034.33,13.0528],167,[0,0,1]] call InitItem; 
['Syringe',[4035.44,4029.72,13.0528],320,[0,0,1]] call InitItem; 
['SmallWoodenTableHandmade',[4032.42,4032.59,13.0492],265,[0,0,1]] call InitStruct; 
['SoupPlate',[4033.01,4032.58,13.0528],0,[0,0,1]] call InitItem; 
['SmallTrashCan',[4033.28,4028.91,13.0528],15,[0,0,1]] call InitStruct; 
['SaltShaker',[4035.37,4034.31,13.9838],0,[0,0,1]] call InitItem; 
['SaltShaker',[4035.46,4034.39,13.9849],0,[0,0,1]] call InitItem; 
['SaltShaker',[4035.36,4034.41,13.9823],0,[0,0,1]] call InitItem; 
['BigClothCabinet',[4036.43,4032.89,13.0578],90,[0,0,1], {go_editor_globalRefs set ["KoldyrShkaf",_thisObj];
}] call InitStruct; 
['BreadChopped',[4035.62,4034.34,13.9866],30,[0,0,1]] call InitItem; 
['SmallWoodenTable',[4029.57,4034.42,13.0497],93,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4031.02,4030.12,13.0518],11.2096,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4031.1,4031.25,13.0568],359.266,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4031.09,4030.61,14.0088],353.296,[0,0,1]] call InitStruct; 
_4027_207034034_2902813_04602 = ['RatCage',[4027.21,4034.29,13.046],357.01,[0,0,1]] call InitStruct; 
_4027_194094032_9877913_04602 = ['RatCage',[4027.19,4032.99,13.046],1.97399,[0,0,1]] call InitStruct; 
['WoodenChair',[4029.5,4033.6,13.0784],170.001,[0,0,1]] call InitItem; 
['RedSteelBox',[4027.06,4030.11,13.0518],240,[0,0,1]] call InitStruct; 
['Bucket',[4029.14,4034.14,13.0662],0,[0,0,1]] call InitItem; 
['Bucket',[4026.87,4031.04,13.0506],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4026.72,4030.71,13.0518],0,[0,0,1]] call InitItem; 
['GlassBottle',[4029,4034.71,13.8946],0,[0,0,1]] call InitItem; 
['GlassBottle',[4029.15,4034.75,13.8982],0,[0,0,1]] call InitItem; 
['MilkBottle',[4030.15,4034.5,13.9006],0,[0,0,1]] call InitItem; 
['SteelBlueCase',[4029.64,4029.8,13.0568],180,[0,0,1]] call InitStruct; 
['BedOld2',[4030.59,4033.94,13.0518],2.8042,[0,0,1], {go_editor_globalRefs set ["RMolDormBed",_thisObj];
}] call InitStruct; 
['Candle',[4029.7,4034.7,13.8954],0,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['ConcretePanelDamaged',[4029.74,4032.84,12.9862],4,[0,0,1]] call InitStruct; 
['MatchBox',[4030.14,4034.14,13.9024],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.51,4034.31,13.067],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.46,4033.38,13.0695],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.81,4033.33,13.7694],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.73,4034.21,13.7694],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4026.83,4033.35,13.0759],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.99,4034.15,13.0518],0,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.76,4032.71,13.0518],20,[0,0,1]] call InitItem; 
['RatShitMedium',[4027.28,4032.18,13.0518],260,[0,0,1]] call InitItem; 
['RatShitMedium',[4028.26,4033.47,13.0518],8.53774e-007,[0,0,1]] call InitItem; 
['SmallBattery',[4041.17,4034.84,14.0461],0,[0,0,1]] call InitItem; 
['SmallBattery',[4041.31,4034.78,14.0461],0,[0,0,1]] call InitItem; 
['Wrench',[4042.22,4033.47,14.0386],30,[0,0,1]] call InitItem; 
['Wrench',[4042.33,4033.28,14.0389],320,[0,0,1]] call InitItem; 
['MediumWoodenTable',[4039.22,4034.3,13.0402],87.5084,[0,0,1]] call InitStruct; 
['MatchBox',[4039.66,4033.89,13.9048],0,[0,0,1]] call InitItem; 
['PaperHolder',[4038.67,4034.19,13.8873],110,[0,0,1]] call InitItem; 
['Paper',[4039.16,4034.25,13.9048],110,[0,0,1]] call InitItem; 
['Crowbar',[4042.18,4034.62,13.3333],255,[0,0,1]] call InitItem; 
['Shovel',[4041.16,4029.66,18.53,true],[0,0.258819,-0.965926],[0,0.965926,0.258819]] call InitItem; 
['Shelves',[4041.14,4034.81,13.0461],0,[0,0,1]] call InitStruct; 
['Hammer',[4042.37,4033.06,18.3566,true],[-0.906308,-0.422618,1.69645e-008],[0.422618,-0.906308,1.08076e-008]] call InitItem; 
['Multimeter',[4042.29,4034.34,13.334],50,[0,0,1]] call InitItem; 
['Screwdriver',[4040.81,4034.8,14.0461],40,[0,0,1]] call InitItem; 
['Gloves',[4042.29,4032.89,14.0453],25,[0,0,1]] call InitItem; 
['Gloves',[4042.17,4033.03,14.0453],65,[0,0,1]] call InitItem; 
['WireCutters',[4041.43,4034.8,13.5961],20,[0,0,1]] call InitItem; 
_4042_386234031_3793913_33303 = ['IStruct',[4042.39,4031.38,13.333],350,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_bootcamp\training\target_popup_01_mechanism_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['LongShelf',[4042.34,4032.9,13.0528],90,[0,0,1]] call InitStruct; 
['PenBlack',[4039.5,4034.07,13.8878],325,[0,0,1]] call InitItem; 
['FabricBagBig2',[4040.56,4034.37,13.0528],270,[0,0,1]] call InitItem; 
['GreenBed',[4038.18,4030.1,13.0497],265.883,[0,0,1], {go_editor_globalRefs set ["RSlesarDormBed",_thisObj];
}] call InitStruct; 
['Canister',[4042.34,4031.51,14.8734],340,[0,0,1]] call InitItem; 
['SteelBrownContainer',[4038.16,4030.37,13.0528],10.0001,[0,0,1]] call InitItem; 
['ShuttleBag',[4039.94,4034.13,13.0528],0,[0,0,1]] call InitItem; 
['PowerSwitcherBig',[4042.58,4033.1,19.2983,true],90,[0,1,7.54979e-008]] call InitStruct; 
['Flashlight',[4042.21,4034.35,14.0387],105,[0,0,1]] call InitItem; 
['Flashlight',[4042.3,4034.1,14.0361],45,[0,0,1]] call InitItem; 
['FreezerStruct',[4042.31,4033.4,20.1674,true],[0.996195,0.0871556,1.1055e-007],[0.0871556,-0.996195,9.61925e-007]] call InitStruct; 
_4042_385014034_0026914_86833 = ['IStruct',[4042.39,4034,14.8683],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4041_598884030_9221213_04211 = ['IStruct',[4041.6,4030.92,13.0421],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
['DrumGenerator',[4041.99,4030.12,13.0495],80.0001,[0,0,1]] call InitStruct; 
['LampKerosene',[4042.29,4031.37,14.0304],340,[0,0,1], {_thisObj setvariable ['lightisenabled',false];}] call InitItem; 
['IntercomOld',[4039.83,4034.86,14.2559],270,[0,0,1]] call InitStruct; 
['Anvil',[4039.03,4029.98,13.0503],335,[0,0,1]] call InitStruct; 
['PowerSwitcherBox_Activator',[4042.4,4032.15,19.1218,true],[-3.77074e-006,3.69524e-006,1],[0.707106,0.707108,5.33851e-008]] call InitStruct; 
['StationSpeaker',[4038.57,4035.58,15.0472],180,[0,0,1], {go_editor_globalRefs set ["StationSpeaker G:Q54X59FAgzQ",_thisObj];
}] call InitStruct; 
_4039_493414029_6389213_85558 = ['Intercom',[4039.49,4029.64,13.8556],90,[0,0,1], {go_editor_globalRefs set ["Intercom G:4/wwqSRELj8",_thisObj];
}] call InitStruct; 
['RegistrationPanel',[4042.68,4030.56,13.0528],0,[0,0,1]] call InitStruct; 
['ToolPipe',[4040.07,4034.35,13.8924],30,[0,0,1]] call InitItem; 
['ToolStraigthPipe',[4042.29,4033.7,13.3574],105,[0,0,1]] call InitItem; 
['Tumbler',[4042.46,4032.62,18.4148,true],[1.33308e-007,1.3766e-007,-1],[-0.422618,0.906308,6.84243e-008]] call InitStruct; 
['Tumbler',[4042.4,4032.13,18.4218,true],[1.65039e-007,1.04599e-007,-1],[-0.173648,0.984808,7.43509e-008]] call InitStruct; 
['Wheelchair',[4041.42,4031.7,13.0578],103.822,[0,0,1]] call InitStruct; 
['SmallChair',[4038.98,4033.71,13.0475],190,[0,0,1]] call InitItem; 
['SmallBattery',[4041.07,4034.78,14.0461],0,[0,0,1]] call InitItem; 
_4037_408944034_6401413_01779 = ['IStruct',[4037.41,4034.64,13.0178],354.781,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\baloonexo.p3d'];}] call InitStruct; // !!! realocated model !!!
['Workbench',[4037.65,4032.42,13.0492],270,[0,0,1]] call InitStruct; 
['Hammer',[4037.6,4032.41,18.8894,true],[-0.906308,-0.422618,1.69645e-008],[0.422618,-0.906308,1.08076e-008]] call InitItem; 
['Canister',[4027.18,4025.69,10.098],340,[0,0,1]] call InitItem; 
['Butter',[4041.02,4034.78,13.1461],325,[0,0,1]] call InitItem; 
if ((random 1) < 0.5) then {
	['Butter',[4041.22,4034.81,13.1461],15,[0,0,1]] call InitItem; 
};
['Egg',[4040.78,4034.82,13.5961],0,[0,0,1]] call InitItem; 
['Egg',[4040.99,4034.79,13.5961],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.5) then {
	['Egg',[4041.19,4034.81,13.5961],0,[0,0,1]] call InitItem; 
};
if ((random 1) < 0.5) then {
	['Egg',[4040.81,4034.78,13.1461],0,[0,0,1]] call InitItem; 
};
['ButterPiece',[4041.11,4034.73,13.1461],335,[0,0,1]] call InitItem; 
['Bucket',[4037.69,4031.55,13.0457],0,[0,0,1]] call InitItem; 
['Wheelchair',[4042,4026.29,13.0528],103.822,[0,0,1]] call InitStruct; 
_4044_676274026_0610413_01668 = ['IStruct',[4044.68,4026.06,18.0167,true],[-1,4.20091e-012,8.59499e-006],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_006104026_0744613_05520 = ['IStruct',[4046.01,4026.07,18.1252,true],270,[-1.11674e-006,-0.00119335,0.999999], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\boots_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4043_334964026_3364313_04132 = ['IStruct',[4043.33,4026.34,18.1113,true],270,[-1.11674e-006,-0.00119335,0.999999], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\boots_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_668214025_0542013_93129 = ['IStruct',[4046.67,4025.05,18.9313,true],50,[-0.00673352,-0.00252653,0.999974], {_thisObj setvariable ['model','ml\ml_object_new\model_05\chainik.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_422614025_9975613_65177 = ['IStruct',[4046.42,4026,19.1656,true],[-0.996194,0.0868278,-0.00759807],[-0.000105655,0.0859711,0.996298], {_thisObj setvariable ['model','ml_shabut\exodus\misharazumcoat.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_837894025_0070813_75565 = ['IStruct',[4045.84,4025.01,13.7556],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\pillow_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_977054025_9995114_29542 = ['IStruct',[4045.98,4026,14.2954],0.000338948,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polotence.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenSmallShelf1',[4043.44,4026.04,18.5614,true],90,[0,0.00119604,0.999999]] call InitStruct; 
['SquareWoodenBox',[4035.76,4028.72,13.053],355,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4027.22,4020.82,13.0528],350,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4029.69,4028.72,13.0606],5.00001,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4030.82,4028.75,13.0532],1.02453e-005,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4030.15,4028.67,14.0309],1.02453e-005,[0,0,1]] call InitStruct; 
['WoodenLadder',[4027.25,4022.01,19.5133,true],[-0.996195,4.88762e-007,-0.0871557],[-0.0871557,0,0.996195]] call InitStruct; 
['WoodenOldBench',[4040.09,4026.19,13.0626],175,[0,0,1]] call InitStruct; 
['BigRedEdgesRack',[4048.43,4028.42,19.0985,true],90,[-1.74849e-007,0.00119604,0.999999]] call InitStruct; 
['OrangeCarpet1',[4047.19,4028.28,13.0611],0,[0,0,1]] call InitStruct; 
['RedSteelBox',[4036.39,4024.89,13.0444],260,[0,0,1]] call InitStruct; 
['Bucket',[4033.64,4023.71,13.05],0,[0,0,1]] call InitItem; 
['Bucket',[4032.36,4024.28,13.05],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4032.09,4023.93,13.0528],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4032.57,4023.82,13.05],0,[0,0,1]] call InitItem; 
['WoodenBucket',[4041.26,4025.98,18.2956,true],0,[-0.00119604,0,0.999999]] call InitItem; 
['ConcreteSlabsStack',[4032.52,4021.94,13.0222],0,[0,0,1]] call InitStruct; 
['DrumGenerator',[4030.78,4021.17,13.0528],10,[0,0,1]] call InitStruct; 
['HospitalBench',[4037.39,4028.9,18.0585,true],0,[-0.00119604,0,0.999999]] call InitStruct; 
['SteelBlueCase',[4032.82,4028.99,18.0614,true],0,[-0.00119604,0,0.999999]] call InitStruct; 
['SteelBlueCase',[4043.6,4029.03,18.0645,true],0,[-0.00119604,0,0.999999], {go_editor_globalRefs set ["PoisonBox3",_thisObj];
}] call InitStruct; 
['SteelGreenCabinet',[4031.96,4028.73,13.051],90,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[4042.74,4028.77,13.0541],90,[0,0,1]] call InitStruct; 
['SofaBrown',[4027.26,4023.76,13.0528],75,[0,0,1]] call InitStruct; 
['MetalFanSmall',[4028.93,4020.57,18.1703,true],[1.65609e-007,1.04699e-007,-1],[-0.173648,0.984808,7.43509e-008]] call InitStruct; 
['TorchHolderCharged',[4053.55,4033.6,10.1589],270,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[4053.49,4027.01,10.1116],270,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4030.59,4024.24,10.1195],185,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4029.46,4024.21,10.1122],180,[0,0,1], {go_editor_globalRefs set ["PoisonBox4",_thisObj];
}] call InitStruct; 
['SquareWoodenBox',[4030.13,4024.29,11.0899],180,[0,0,1]] call InitStruct; 
['SteelBlueCase',[4031.98,4023.74,15.1028,true],180,[0.00119383,1.61293e-006,0.999999]] call InitStruct; 
['SteelGreenCabinet',[4032.84,4024,10.0923],270,[0,0,1]] call InitStruct; 
['WoodenOldBench',[4038.6,4028.54,10.1141],355,[0,0,1]] call InitStruct; 
['HospitalBench',[4040.91,4026.04,15.11,true],180.001,[0.0011881,-1.25566e-006,0.999999]] call InitStruct; 
_4045_955574026_0163611_33869 = ['IStruct',[4045.96,4026.02,11.3387],0.000338948,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\polotence.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenSmallShelf1',[4042.91,4026.05,15.6109,true],90,[0,0.00119604,0.999999]] call InitStruct; 
['HospitalBench',[4036.47,4033.47,10.0884],90.0005,[0,0,1]] call InitStruct; 
_4046_122314028_3850110_09066 = ['IStruct',[4046.12,4028.39,10.0907],45,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_188964028_6723610_08355 = ['IStruct',[4045.19,4028.67,10.0835],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4027_104744028_8188510_09520 = ['IStruct',[4027.1,4028.82,10.0952],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4027_730224028_6967810_08649 = ['IStruct',[4027.73,4028.7,10.0865],45,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
['InfoBoard',[4036.68,4024.5,10.858],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4043.12,4028.68,10.1056],270,[0,0,1]] call InitStruct; 
_4048_373294028_5932610_09346 = ['IStruct',[4048.37,4028.59,10.0935],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_572274028_6684610_08518 = ['IStruct',[4047.57,4028.67,10.0852],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
_4048_468994026_3793910_42563 = ['IStruct',[4048.47,4026.38,15.4254,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_445074028_7695310_11163 = ['IStruct',[4028.45,4028.77,10.1116],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
['ContainerGreen',[4034.61,4021.46,10.0884],295,[0,0,1]] call InitStruct; 
['ConcreteSlabsStack',[4024.43,4021.29,13.0578],85,[0,0,1]] call InitStruct; 
['WoodenOldBench',[4025.8,4025.63,13.0578],85,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[4042.52,4036.81,10.4295],180,[0,0,1]] call InitStruct; 
['WoodenOldBench',[4043.41,4035.81,10.1013],180,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4044.58,4036.53,9.49799],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4043.77,4038.05,9.34299],0,[0,0,1]] call InitStruct; 
['TrashCan',[4041.66,4035.65,9.98514],270,[0,0,1], {go_editor_globalRefs set ["PoisonBox5",_thisObj];
}] call InitStruct; 
['WoodenNewBench',[4037.41,4036.08,10.1322],180.001,[0,0,1]] call InitStruct; 
['WoodenChair',[4041.24,4024.44,13.0528],285,[0,0,1]] call InitItem; 
['SingleWhiteBed',[4042,4021.17,13.0504],0,[0,0,1]] call InitStruct; 
['BrownOldSofa',[4037.79,4022.65,13.0528],90,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4039.52,4020.31,13.0499],180,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4042.02,4023.99,13.0527],0,[0,0,1]] call InitStruct; 
['LongWeaponContainer',[4047.31,4025.28,19.0304,true],[-0.999741,-0.0225574,0.00295896],[0.0225576,-0.965925,0.257837]] call InitStruct; 
['SquareWoodenBox',[4048.27,4024.79,13.0528],0,[0,0,1]] call InitStruct; 
['MatchBox',[4045.86,4021.23,13.9207],0,[0,0,1]] call InitItem; 
['DoubleCitizenBed1',[4048.17,4021.27,13.0528],1.06722e-005,[0,0,1], {go_editor_globalRefs set ["RCherDormBed0",_thisObj];
}] call InitStruct; 
['SewercoverBase',[4043.07,4024.42,18.4118,true],0,[0.939692,0,0.342021]] call InitStruct; 
['Paper',[4045.98,4020.99,13.9207],20,[0,0,1]] call InitItem; 
['Paper',[4046.27,4020.94,13.9207],335,[0,0,1]] call InitItem; 
['Paper',[4045.96,4022.26,13.0528],320,[0,0,1]] call InitItem; 
['Paper',[4046.74,4023.58,13.0528],305,[0,0,1]] call InitItem; 
['Paper',[4043.96,4025.16,13.0528],55,[0,0,1]] call InitItem; 
['IdentityDocs',[4043.57,4025.05,13.0528],25,[0,0,1]] call InitItem; 
['ShortRottenBoards',[4047.32,4022.16,13.0528],0,[0,0,1]] call InitStruct; 
['ShortRottenBoards',[4044.55,4022,13.0528],0,[0,0,1]] call InitStruct; 
['ShortRottenBoards',[4045.03,4024.32,13.0528],95,[0,0,1]] call InitStruct; 
['PenRed',[4046,4021.22,13.9207],35,[0,0,1]] call InitItem; 
['SmallClothShelter',[4046.02,4021.72,13.1525],0,[0,0,1]] call InitStruct; 
['MetalCup',[4045.74,4020.83,13.9207],0,[0,0,1]] call InitItem; 
['Bucket',[4045.46,4020.93,13.0528],0,[0,0,1]] call InitItem; 
['Bucket',[4047.21,4024.44,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.7,4025.3,18.1967,true],0,[-0.00119604,0,0.999999]] call InitItem; 
['GlassBottle',[4043.77,4025.05,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.83,4025.35,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4043.29,4024.97,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.12,4020.84,13.0528],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.87,4020.81,13.9207],0,[0,0,1]] call InitItem; 
['GlassBottle',[4045.82,4021.68,13.151],0,[0,0,1]] call InitItem; 
_4047_554934022_0539614_41714 = ['IStruct',[4047.55,4022.05,14.4171],180.001,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_938724023_2272913_02483 = ['IStruct',[4047.94,4023.23,18.0248,true],[0.258821,-0.965925,1.49012e-007],[0.96225,0.257837,-0.0871547], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\cloth_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['Cup',[4046.43,4021.58,13.9207],0,[0,0,1]] call InitItem; 
['GreenArmChair',[4043.48,4023.24,13.0528],265,[0,0,1]] call InitStruct; 
['CuttingBoard',[4046.28,4021.3,13.9207],55,[0,0,1]] call InitItem; 
['Kastrula',[4046.44,4022.1,13.055],0,[0,0,1]] call InitItem; 
['DoubleCitizenBed',[4043.58,4021.37,13.6417],85.0001,[0,0,1], {go_editor_globalRefs set ["RCherDormBed1",_thisObj];
}] call InitStruct; 
['OlderWoodenCup',[4045.9,4021.52,13.9207],0,[0,0,1]] call InitItem; 
['Crutch',[4046.52,4020.63,13.0723],300,[0,0,1]] call InitItem; 
['Crutch',[4048.06,4024.59,14.0435],55,[0,0,1]] call InitItem; 
['HoochMachine',[4045.26,4020.3,13.0528],0,[0,0,1]] call InitStruct; 
['FryingPan',[4046.35,4024.79,13.7917],0,[0,0,1]] call InitItem; 
['TrashCan',[4043.36,4025.15,13.0528],75,[0,0,1]] call InitStruct; 
['SmallSteelTable1',[4046.09,4020.93,13.0507],270,[0,0,1]] call InitStruct; 
['SoupPlate',[4045.95,4020.89,13.0528],0,[0,0,1]] call InitItem; 
['SoupPlate',[4046.09,4020.95,13.9207],0,[0,0,1]] call InitItem; 
['OldWoodenBox',[4045.94,4024.59,13.0399],5,[0,0,1]] call InitStruct; 
['Scales',[4046.32,4020.6,13.9207],85,[0,0,1]] call InitStruct; 
['WoodenCup',[4046.48,4020.99,13.9207],0,[0,0,1]] call InitItem; 
['BigClothCabinet',[4048.44,4023.45,13.0528],80,[0,0,1]] call InitStruct; 
['SmallBattery',[4046.16,4021.42,13.9207],0,[0,0,1]] call InitItem; 
['MatchBox',[4030.22,4020.7,11.0925],0,[0,0,1]] call InitItem; 
['MatchBox',[4030,4020.75,11.0925],335,[0,0,1]] call InitItem; 
['Shovel',[4030.09,4020.46,11.0925],85,[0,0,1]] call InitItem; 
['LongShelf',[4031.39,4020.54,10.1],0,[0,0,1]] call InitStruct; 
['BrushCleaner',[4032.91,4020.59,11.0925],15,[0,0,1]] call InitItem; 
['BrushCleaner',[4032.51,4020.58,11.0925],350,[0,0,1]] call InitItem; 
['BrushCleaner',[4032.13,4020.6,11.0925],350,[0,0,1]] call InitItem; 
['BoardWoodenBox',[4029.17,4022.87,10.075],90,[0,0,1]] call InitStruct; 
['Bucket',[4032.75,4020.57,10.3806],0,[0,0,1]] call InitItem; 
['Bucket',[4032.08,4020.5,10.3806],0,[0,0,1]] call InitItem; 
['Kastrula',[4032.38,4020.67,10.3806],0,[0,0,1]] call InitItem; 
['Rag',[4029.75,4020.59,10.3806],0,[0,0,1]] call InitItem; 
['Rag',[4030.13,4020.46,10.3806],335,[0,0,1]] call InitItem; 
['SteelGreenCabinet',[4031.13,4022.87,10.0936],95,[0,0,1]] call InitStruct; 
['FryingPan',[4031.69,4020.5,10.3806],345,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.98,4020.57,11.0925],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.69,4020.69,11.0925],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.99,4020.49,10.3806],0,[0,0,1]] call InitItem; 
['CandleDisabled',[4030.67,4020.57,10.3806],0,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.64,4020.54,11.0925],10,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.47,4020.57,11.0925],0,[0,0,1]] call InitItem; 
['TorchDisabled',[4031.31,4020.63,11.0925],0,[0,0,1]] call InitItem; 
['SquareWoodenBox',[4032.88,4022.45,10.1],0,[0,0,1]] call InitStruct; 
['WoodenDoor',[4032.75,4035.13,13],0,[0,0,1]] call InitStruct; 
_4034_250004029_3750013_00000 = ['WoodenDoor',[4034.25,4029.38,13],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKoldyrDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4040_250004029_3750013_00000 = ['WoodenDoor',[4040.25,4029.38,13],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4044_750004025_6250010_12500 = ['WoodenDoor',[4044.75,4025.63,10.125],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4047_125004025_6250010_12500 = ['WoodenDoor',[4047.13,4025.63,10.125],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4049_000004021_5000010_12500 = ['WoodenDoor',[4049,4021.5,10.125],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; SortirDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4032_871834031_1250010_00000 = ['WoodenDoor',[4032.87,4031.13,10],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_375004033_3750010_00000 = ['WoodenDoor',[4026.38,4033.38,10],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4038_500004025_6250013_00000 = ['WoodenDoor',[4038.5,4025.63,13],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"key201"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4044_750004025_6250013_00000 = ['WoodenDoor',[4044.75,4025.63,13],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RCherDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_625004027_3750010_00000 = ['WoodenDoor',[4026.63,4027.38,10],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; KitchenDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4025_625004023_3750010_00000 = ['WoodenDoor',[4025.63,4023.38,10],185,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; PodsobDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4026_625004021_7500010_12500 = ['WoodenDoor',[4026.63,4021.75,10.125],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; PodsobDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4047_125004029_3750013_00000 = ['SteelBrownDoor',[4047.13,4029.38,13],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RCexDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4038_500004025_6250010_00000 = ['SteelBrownDoor',[4038.5,4025.63,10],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4041_039794028_960949_97046 = ['SteelGreenDoor',[4041.04,4028.96,9.97046],0.000748759,[0,0,1]] call InitStruct; 
_4026_375004027_5000013_00000 = ['SteelDoorThinSmall',[4026.38,4027.5,13],90.0001,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey; PloshadkaDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4018_500004029_2500013_12500 = ['Wicket',[4018.5,4029.25,13.125],90.0003,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RZavZhilDormKey; PloshadkaDorm"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4028_250004029_3750013_00000 = ['WoodenDoor',[4028.25,4029.38,13],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RMolDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4034_987794035_302499_87321 = ['SteelGridDoor',[4034.99,4035.3,9.87321],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RKomendantDormKey; RZavZhilDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['StoneBigLadderDouble',[4035.25,4022.75,9.75],180,[0,0,1]] call InitStruct; 
_4026_750004031_750002_41766 = ['IStruct',[4026.75,4031.75,10.993,true],180,[0.00699831,0.00103626,0.999975], {_thisObj setvariable ['model','ca\structures\castle\a_castle_stairs_a.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_125004033_5000015_70017 = ['IStruct',[4047.13,4033.5,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4040_875004033_5000015_70017 = ['IStruct',[4040.88,4033.5,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_625004033_5000015_70017 = ['IStruct',[4034.63,4033.5,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_375004033_5000015_70017 = ['IStruct',[4028.38,4033.5,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_375004027_3750015_70017 = ['IStruct',[4028.38,4027.38,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_625004027_3750015_70017 = ['IStruct',[4034.63,4027.38,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4040_875004027_3750015_70017 = ['IStruct',[4040.88,4027.38,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_125004027_3750015_70017 = ['IStruct',[4047.13,4027.38,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_375004021_2500015_70017 = ['IStruct',[4028.38,4021.25,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_625004021_2500015_70017 = ['IStruct',[4034.63,4021.25,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4040_875004021_2500015_70017 = ['IStruct',[4040.88,4021.25,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4047_125004021_2500015_70017 = ['IStruct',[4047.13,4021.25,21.001,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWall',[4036.88,4022.75,10],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.75,4022.75,10],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4046,4022.75,10],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4020.5,4029.25,10],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4037,4032.25,10],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4029.13,10],180,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4019.88,10],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4031.75,4032.25,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.88,4032.25,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4036.88,4032.25,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4049,4022.75,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4036.88,4022.75,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4042.75,4022.75,13],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[4039.63,4019.88,13],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4045.88,4019.88,13],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4033.63,4019.88,13],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWall',[4029.25,4019.89,13],0.000122943,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4033,4032.25,10],90,[0,0,1]] call InitStruct; 
['BrickThinWallTwoDoorways',[4045.88,4025.63,10],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4017.5,4023,10],90,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4039.73,4019.88,10],180,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4045.75,4035.13,13],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4039.75,4035.13,13],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4029.25,4035.13,13],4.26887e-005,[0,0,1]] call InitStruct; 
_4049_000004031_875009_99885 = ['IStruct',[4049,4031.88,14.9994,true],[-1,-3.34978e-006,2.14577e-006],[-2.14577e-006,-8.02679e-007,-1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_8m_plain_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4049_000004031_8750014_12500 = ['IStruct',[4049,4031.88,14.125],90.0001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_8m_plain_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumLightWall',[4023.88,4021.8,11],90,[0,0,1]] call InitStruct; 
['MediumLightWall',[4017.5,4027.63,11],90.0001,[0,0,1]] call InitStruct; 
['MediumLightWall',[4048.99,4027.5,15,true],[1,4.37114e-008,-4.55078e-014],[0,-1.0411e-006,-1]] call InitStruct; 
['MediumLightWall',[4048.99,4027.5,14.125],270,[0,0,1]] call InitStruct; 
_4033_625004021_7500010_87500 = ['IStruct',[4033.63,4021.75,10.875],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_4m_plain_blue_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4031_625004023_3750010_87500 = ['IStruct',[4031.63,4023.38,10.875],1.36604e-005,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_4m_plain_blue_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4044_125004020_0000010_00000 = ['IStruct',[4044.13,4020,10],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWallSmall',[4025,4029.25,10],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.63,4025.63,10],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.63,4022.88,10],270,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.63,4026.25,10],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.88,4023.38,10],9.90377e-005,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.38,4032.25,10],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.88,4029.13,10],180,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4029.5,4029.38,13],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4035.5,4029.38,13],4.26887e-005,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4041.5,4029.38,13],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4046,4029.38,13],180,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4045.88,4025.63,13],4.26887e-005,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.63,4025.63,13],4.26887e-005,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4026.38,4026.25,13],90,[0,0,1]] call InitStruct; 
_4027_625004019_8750013_56901 = ['IStruct',[4027.63,4019.88,15.722,true],[-8.02679e-007,1,-1.27952e-006],[3.01992e-007,-1.27952e-006,-1], {_thisObj setvariable ['model','ml_shabut\stena\stena.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_750004035_2500011_87500 = ['IStruct',[4045.75,4035.25,11.875],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_8m_plain_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumLightWall',[4027.88,4035.25,16.5,true],0.000179292,[-9.77819e-007,-1.25567e-006,1]] call InitStruct; 
['BrickThinWallDoorway',[4049,4022.75,10],270,[0,0,1]] call InitStruct; 
_4047_548834020_0000010_12500 = ['IStruct',[4047.55,4020,10.125],180,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_210694021_3693810_15535 = ['IStruct',[4046.21,4021.37,10.1553],269.656,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_211184023_9663110_09516 = ['IStruct',[4046.21,4023.97,10.0952],268.768,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4042_857424021_3723110_15580 = ['IStruct',[4042.86,4021.37,10.1558],270.001,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4042_874024023_9699710_09561 = ['IStruct',[4042.87,4023.97,10.0956],269.113,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4017_500004020_7500013_25000 = ['IStruct',[4017.5,4020.75,13.25],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_2m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4018_375004019_8750013_25000 = ['IStruct',[4018.38,4019.88,13.25],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_2m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcreteWallWithNetfence',[4024.5,4029.25,13.25],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4017.5,4027.38,13.25],90.0002,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4025.13,4019.88,13.25],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4017.5,4023.5,13.25],270,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4038.75,4035.25,16.6192,true],[-3.25841e-007,1,-8.02679e-007],[3.01992e-007,-8.02679e-007,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4038.63,4035.13,18.9942,true],180,[-1.04008e-006,1.34309e-006,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4043.38,4035.13,18.9942,true],[-3.25841e-007,1,-8.02679e-007],[3.01992e-007,-8.02679e-007,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4036.13,4035.13,18.8692,true],180,[-1.13994e-006,-2.47161e-006,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4029.25,4035.13,18.9942,true],[-3.25841e-007,1,-8.02679e-007],[3.01992e-007,-8.02679e-007,-1]] call InitStruct; 
['RustyWindowFrameMeduim',[4039.63,4019.88,15.8692,true],[-3.25841e-007,1,-8.02679e-007],[3.01992e-007,-8.02679e-007,-1]] call InitStruct; 
['PlywoodThinWall',[4043,4035.13,10],270,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[4017.5,4024.25,10.75],0,[0,0,1]] call InitStruct; 
_4017_500004019_8750010_50009 = ['IStruct',[4017.5,4019.88,15.973,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4039_125004035_2500010_65364 = ['IStruct',[4039.13,4035.25,15.7617,true],0,[1,0,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4039_000004035_2500012_61973 = ['IStruct',[4039,4035.25,17.5117,true],[-8.08937e-014,1,1.85063e-006],[-1,0,-4.37114e-008], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4033_375004035_2500011_87500 = ['IStruct',[4033.38,4035.25,16.8867,true],0,[7.78829e-007,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4036_500004035_2500011_87500 = ['IStruct',[4036.5,4035.25,16.8867,true],180,[7.78829e-007,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4031_250004035_2500010_65364 = ['IStruct',[4031.25,4035.25,15.7617,true],3.62792e-013,[1,0,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4031_125004035_2500012_24473 = ['IStruct',[4031.13,4035.25,17.1367,true],[-8.33906e-014,1,1.90775e-006],[-1,0,-4.37114e-008], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4039_125004035_2500011_87500 = ['IStruct',[4039.13,4035.25,11.875],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_4m_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4031_250004035_2500011_87500 = ['IStruct',[4031.25,4035.25,11.875],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_4m_plain_dmg_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4026_125004029_3750010_87509 = ['IStruct',[4026.13,4029.38,16.348,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWallDoorwayWindow',[4033.88,4035.13,19.4935,true],180,[-0.00103702,0.0069951,0.999975]] call InitStruct; 
_4029_560794032_5537110_24855 = ['IStruct',[4029.56,4032.55,15.7214,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumLightWall',[4028.25,4029.25,16,true],180,[-6.78625e-007,-3.01992e-007,1]] call InitStruct; 
_4043_000004030_5341813_06565 = ['IStruct',[4043,4030.53,13.0656],268.768,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4044_026864029_4978013_04632 = ['IStruct',[4044.03,4029.5,13.0463],178.768,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4044_025394031_7478013_04701 = ['IStruct',[4044.03,4031.75,13.047],178.768,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\plitkastenka2.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcreteWallWithNetfence',[4021.23,4019.89,13.25],180,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[4021.38,4029.25,13.252],0.000313335,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4045.32,4031.09,13.011],270,[0,0,1]] call InitStruct; 
_4033_625004023_2500013_62500 = ['IStruct',[4033.63,4023.25,13.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\city\wallcity_01_pillar_grey_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWallWindow2',[4026.38,4021.38,13.0578],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4026.38,4032.25,13],270,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4031.48,4029.32,8.09556],0,[0,0,1]] call InitStruct; 
_4029_868414035_2363310_11038 = ['IStruct',[4029.87,4035.24,10.1104],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\misc\plot_rust_vrata.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_017584034_3103012_52373 = ['IStruct',[4034.02,4034.31,16.675,true],[1,1.2358e-006,-7.17937e-012],[0,-5.80947e-006,-1], {_thisObj setvariable ['model','ca\buildings\misc\plot_green_vrat_r.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_000004032_2500012_75000 = ['IStruct',[4046,4032.25,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4040_000004032_2500012_75000 = ['IStruct',[4040,4032.25,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_000004022_7500012_75000 = ['IStruct',[4046,4022.75,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4040_000004022_7500012_75000 = ['IStruct',[4040,4022.75,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4030_750004022_7500012_75000 = ['IStruct',[4030.75,4022.75,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4024_750004022_7500012_75000 = ['IStruct',[4024.75,4022.75,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4020_500004022_7500012_74990 = ['IStruct',[4020.5,4022.75,12.7499],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4020_500004026_2500012_74980 = ['IStruct',[4020.5,4026.25,12.7498],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4023_750004026_2500012_74970 = ['IStruct',[4023.75,4026.25,12.7497],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4029_375004032_2500012_74900 = ['IStruct',[4029.38,4032.25,12.749],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_000004032_2500012_75000 = ['IStruct',[4034,4032.25,12.75],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_6x6.p3d'];}] call InitStruct; // !!! realocated model !!!
_4045_875004027_3750012_87500 = ['IStruct',[4045.88,4027.38,12.875],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma.p3d'];}] call InitStruct; // !!! realocated model !!!
_4039_750004027_3750012_87500 = ['IStruct',[4039.75,4027.38,12.875],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma.p3d'];}] call InitStruct; // !!! realocated model !!!
_4033_625004027_3750012_87500 = ['IStruct',[4033.63,4027.38,12.875],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma.p3d'];}] call InitStruct; // !!! realocated model !!!
_4029_625004027_3750012_87490 = ['IStruct',[4029.63,4027.38,12.8749],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma.p3d'];}] call InitStruct; // !!! realocated model !!!
['BetonBlockFloor',[4044.75,4021.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4044.75,4025.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4036.75,4025.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4036.75,4021.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4025.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4021.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4029.88,10],0,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[4028.75,4033.88,10],0,[0,0,1]] call InitStruct; 
['WhiteConcreteFloorBig',[4040.25,4030.63,9.6985],0,[0,0,1]] call InitStruct; 
['WhiteConcreteFloorBig',[4045.38,4030.63,9.6987],0,[0,0,1]] call InitStruct; 
_4035_000004031_6181610_03150 = ['IStruct',[4035,4031.62,10.0315],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4034_999514036_2092310_05097 = ['IStruct',[4035,4036.21,10.051],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4035_022464037_696049_96723 = ['IStruct',[4035.02,4037.7,14.9006,true],[1,-1.62301e-007,1.41995e-008],[0,0.0871557,0.996195], {_thisObj setvariable ['model','a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4044_000004020_8750010_00000 = ['IStruct',[4044,4020.88,10],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4044_000004022_9550810_00000 = ['IStruct',[4044,4022.96,10],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_250004020_8750010_00000 = ['IStruct',[4046.25,4020.88,10],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4046_250004022_9550810_00000 = ['IStruct',[4046.25,4022.96,10],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4048_000004020_885019_99900 = ['IStruct',[4048,4020.89,9.999],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4048_000004022_965099_99800 = ['IStruct',[4048,4022.97,9.998],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallSteelPlate2',[4032.63,4035.5,12.75],180,[0,0,1]] call InitStruct; 
_4044_104984030_6250012_91338 = ['IStruct',[4044.1,4030.63,12.9134],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\polwhitesbs.p3d'];}] call InitStruct; // !!! realocated model !!!
_4033_500734031_5581110_03150 = ['IStruct',[4033.5,4031.56,10.0315],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4036_342044031_1015610_02000 = ['IStruct',[4036.34,4031.1,10.02],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcretePanelDamaged',[4019.92,4027.57,13.0576],275,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4022.21,4022.13,13.0578],1.02453e-005,[0,0,1]] call InitStruct; 
['LongShelf',[4018.12,4025.04,13.0577],90,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4021.13,4020.99,13.0577],5.00001,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4022.27,4021.02,13.0578],1.02453e-005,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4021.17,4022.12,13.0577],1.02453e-005,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4020.07,4021.01,13.0577],1.02453e-005,[0,0,1], {go_editor_globalRefs set ["PoisonBox1",_thisObj];
}] call InitStruct; 
['SquareWoodenBox',[4022.11,4021.26,14.0311],1.02453e-005,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4021.02,4021.07,14.031],1.02453e-005,[0,0,1]] call InitStruct; 
_4019_111334021_6765113_05766 = ['IStruct',[4019.11,4021.68,13.0577],45,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4017_899174022_4465313_05766 = ['IStruct',[4017.9,4022.45,13.0577],45,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4020_180664021_9965813_05766 = ['IStruct',[4020.18,4022,13.0577],325,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\galon.p3d'];}] call InitStruct; // !!! realocated model !!!
_4019_093514020_9001513_05766 = ['IStruct',[4019.09,4020.9,13.0577],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
_4018_184334020_7502413_05766 = ['IStruct',[4018.18,4020.75,13.0577],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
_4018_105964021_7627013_05766 = ['IStruct',[4018.11,4021.76,13.0577],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\oldbarrel.p3d'];}] call InitStruct; // !!! realocated model !!!
['TrashCan',[4025.69,4024.19,13.0578],15,[0,0,1], {go_editor_globalRefs set ["PoisonBox2",_thisObj];
}] call InitStruct; 
['ConcretePanelDamaged',[4024.07,4027.48,13.0575],270,[0,0,1]] call InitStruct; 
_4007_750004056_3750014_00003 = ['PowerGenerator',[4007.75,4056.38,19.6642,true],180,[0.00659539,0.00162002,0.999977], {go_editor_globalRefs set ["PowerGenerator G:gh057LhnsQs",_thisObj];
}] call InitStruct; 
_4048_045654025_4414111_46157 = ['RedButton',[4048.05,4025.44,16.4618,true],[0,9.65599e-007,1],[0,-1,9.65599e-007], {go_editor_globalRefs set ["RedButton G:Y6ExyGIEWaY",_thisObj];
}] call InitStruct; 
_4045_530524025_4428711_51128 = ['RedButton',[4045.53,4025.44,16.5115,true],[0,1.44244e-006,1],[0,-1,1.44244e-006], {go_editor_globalRefs set ["RedButton G:KDFGox8N8IQ",_thisObj];
}] call InitStruct; 
_4037_568854025_4506811_36210 = ['RedButton',[4037.57,4025.45,16.3623,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {go_editor_globalRefs set ["RedButton G:Xh2Q/W2FGcg",_thisObj];
}] call InitStruct; 
_4042_000004029_2993211_28420 = ['RedButton',[4042,4029.3,16.284,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:WGtGrZZEY8w",_thisObj];
}] call InitStruct; 
['LampCeiling',[4047.63,4022.38,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:eqHk+Uz0nZA",_thisObj];
}] call InitStruct; 
['LampCeiling',[4044.38,4022.38,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:eqHk+Uz0nZA (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4040.75,4022.38,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:dBf4oFHbP2I",_thisObj];
}] call InitStruct; 
['LampCeiling',[4046.25,4032.13,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:6MHQBqtjCTs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4041.13,4032.13,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:3WTP9DQ1sKw",_thisObj];
}] call InitStruct; 
_4048_632324027_5000010_61778 = ['ElectricalShieldSmall',[4048.63,4027.5,10.6178],270,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:D4hhxFJEMKM",_thisObj];
}] call InitStruct; 
_4016_060794021_374769_98744 = ['ElectricalShield',[4016.06,4021.37,9.98744],6.53137e-005,[0,0,1], {go_editor_globalRefs set ["ElectricalShield G:BR05v5D45ZA",_thisObj];
}] call InitStruct; 
['SignWelcome',[4036.82,4031.88,11.2777],268.53,[0,0,1]] call InitStruct; 
_4037_375004028_9318811_51462 = ['RedButton',[4037.38,4028.93,16.5148,true],[-1,6.70552e-007,1.19249e-008],[-6.70552e-007,-1,1.19249e-008], {go_editor_globalRefs set ["RedButton G:TaTtSnTBX9c",_thisObj];
}] call InitStruct; 
_4032_815924032_0000011_66473 = ['RedButton',[4032.82,4032,16.6649,true],0,[-1,0,-4.37114e-008], {go_editor_globalRefs set ["RedButton G:/bk1HSzuyiI",_thisObj];
}] call InitStruct; 
_4032_817144032_2802711_66430 = ['RedButton',[4032.82,4032.28,16.6644,true],0,[-1,0,-4.37114e-008], {go_editor_globalRefs set ["RedButton G:ji1Yi/feNFc",_thisObj];
}] call InitStruct; 
_4046_375004029_5481014_55445 = ['RedButton',[4046.38,4029.55,19.5542,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:HfqsSe3iRaU",_thisObj];
}] call InitStruct; 
_4041_150884029_5671414_37045 = ['RedButton',[4041.15,4029.57,19.3703,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:AjebpdJbUNU",_thisObj];
}] call InitStruct; 
_4035_125004029_5617714_53420 = ['RedButton',[4035.13,4029.56,19.534,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:mIC0aid4Ae8",_thisObj];
}] call InitStruct; 
_4027_482424029_5642114_40920 = ['RedButton',[4027.48,4029.56,19.409,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:IFPkvF5Dt4w",_thisObj];
}] call InitStruct; 
_4036_982184025_8139614_54855 = ['RedButton',[4036.98,4025.81,19.5484,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:bd1e0L0glps",_thisObj];
}] call InitStruct; 
_4033_625004023_5000014_53420 = ['RedButton',[4033.63,4023.5,19.534,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:iw44gmmN2Mo",_thisObj];
}] call InitStruct; 
_4026_452394026_6794411_47483 = ['RedButton',[4026.45,4026.68,16.475,true],0,[-1,0,-4.37114e-008], {go_editor_globalRefs set ["RedButton G:zbXUtKxPtFc",_thisObj];
}] call InitStruct; 
_4026_437994022_4606911_22338 = ['RedButton',[4026.44,4022.46,16.2235,true],0,[-1,0,-4.37114e-008], {go_editor_globalRefs set ["RedButton G:QhdIXJ0UnDY",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035,4025.4,12.3],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:DwTizfFKITc",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035,4032.25,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:qlQj1u5GQKs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.69,4027.5,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:NjkDlY9gWRQ",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.28,4033.88,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:jbNZsX9IGL8",_thisObj];
}] call InitStruct; 
['LampCeiling',[4046.25,4033,15.95],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:Kq7SLbsTC+k",_thisObj];
}] call InitStruct; 
['LampCeiling',[4039.47,4027.5,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:zuAmqwZUMgw",_thisObj];
}] call InitStruct; 
['LampCeiling',[4045.63,4027.38,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4040.13,4032.5,15.9399],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:cBClC1cJFO0",_thisObj];
}] call InitStruct; 
_4034_375004032_1250015_91751 = ['LampCeiling',[4034.38,4032.13,15.9175],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:6DmKSV7k0vk",_thisObj];
}] call InitStruct; 
['LampCeiling',[4028.88,4032.38,15.9322],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:YK+y03D0B3c",_thisObj];
}] call InitStruct; 
['LampCeiling',[4044.02,4027.31,15.82],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:V/ojCDc8RhU",_thisObj];
}] call InitStruct; 
['LampCeiling',[4037.76,4027.32,15.82],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (2)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4029.75,4022.13,15.82],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:OxG+WAr+YSE (4)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4029.5,4027.32,15.82],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:nIWIk6czRII",_thisObj];
}] call InitStruct; 
['LampCeiling',[4035.13,4024,15.82],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:RzZuM8b6yYs",_thisObj];
}] call InitStruct; 
['LampCeiling',[4021.8,4027.17,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:S5mD+ipln0g",_thisObj];
}] call InitStruct; 
['LampCeiling',[4019.89,4022.9,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:BQuGl8InN4c",_thisObj];
}] call InitStruct; 
['LampCeiling',[4030.55,4021.61,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:WmdD2F4ypQg",_thisObj];
}] call InitStruct; 
_4027_875004023_7500010_62500 = ['ElectricalShieldSmall',[4027.88,4023.75,10.625],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:l2Y+w3c5mwI",_thisObj];
}] call InitStruct; 
_4047_835454025_9511713_81793 = ['ElectricalShieldSmall',[4047.84,4025.95,13.8179],180,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:y2vQzELsluA",_thisObj];
}] call InitStruct; 
_4024_226814021_5002410_70123 = ['ElectricalShieldSmall',[4024.23,4021.5,10.7012],90,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:5tPSYWljSTo",_thisObj];
}] call InitStruct; 
_4028_875004020_2500013_75000 = ['ElectricalShieldSmall',[4028.88,4020.25,13.75],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:aNkEhGxpPYY",_thisObj];
}] call InitStruct; 
_4004_186044056_9160216_34257 = ['Tumbler',[4004.19,4056.92,16.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:zx+c4iKzc5g",_thisObj];
}] call InitStruct; 
_4004_686044056_9160216_34257 = ['Tumbler',[4004.69,4056.92,16.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:hGnHa7kTbEk",_thisObj];
}] call InitStruct; 
_4003_686044056_9160215_34257 = ['Tumbler',[4003.69,4056.92,15.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:HVC4/Ag7eck",_thisObj];
}] call InitStruct; 
_4004_186044056_9160215_84257 = ['Tumbler',[4004.19,4056.92,15.8426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:umbpX/vnAss",_thisObj];
}] call InitStruct; 
_4003_686044056_9160215_84257 = ['Tumbler',[4003.69,4056.92,15.8426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:OpthpYcZ5Z4",_thisObj];
}] call InitStruct; 
_4003_686044056_9160216_34257 = ['Tumbler',[4003.69,4056.92,16.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:fLGwpoBP83c",_thisObj];
}] call InitStruct; 
['StreetLamp',[4021.75,4043.38,9],180,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:4Ns/ZphJWgo",_thisObj];
}] call InitStruct; 
['StreetLamp',[4014.07,4028.89,14.2625],90.0001,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E",_thisObj];
}] call InitStruct; 
['StreetLamp',[4010.38,4043.88,9.93553],180,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:PtjQNHBBpAQ",_thisObj];
}] call InitStruct; 
['StreetLamp',[4032.17,4043.38,9],180,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:JobENx7FvpM",_thisObj];
}] call InitStruct; 
['StreetLamp',[4043.5,4043.63,9],180,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac",_thisObj];
}] call InitStruct; 
['StreetLamp',[3995.97,4041.13,10],0.000287722,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:PtjQNHBBpAQ (1)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4053,4046.14,9],270,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (1)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4063.8,4066.44,18.4044,true],0,[0,0.573576,0.819152], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:RZhTnTC73d8",_thisObj];
}] call InitStruct; 
_4003_686044056_9160214_84257 = ['Tumbler',[4003.69,4056.92,14.8426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:kWu++T5dkiI",_thisObj];
}] call InitStruct; 
['LampCeiling',[4064.54,4069.39,13.3018],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:Tfyf2IaEkFM",_thisObj];
}] call InitStruct; 
['StreetLamp',[3999.76,4028.14,14],0.000475552,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E (5)",_thisObj];
}] call InitStruct; 
['StreetLamp',[3985.5,4027.85,14],9.30613e-005,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:TqKXQjapt4E (9)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4006.17,4024.36,17.7589],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:SLKfMovNocM",_thisObj];
}] call InitStruct; 
['LampCeiling',[4005.97,4035.73,17.8879],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:DERdhpwI1BE",_thisObj];
}] call InitStruct; 
['LampCeiling',[3990.44,4035.08,17.5519],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:MOBhI0NCvxc",_thisObj];
}] call InitStruct; 
['LampCeiling',[3992.56,4024.05,17.9604],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:Q/wMdw65U8Y",_thisObj];
}] call InitStruct; 
['LampCeiling',[3977.82,4031.5,18.8708],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:SaqNZ03gHeU",_thisObj];
}] call InitStruct; 
['LampCeiling',[3977.29,4031.45,22.0541],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:aTykogdJ1gU",_thisObj];
}] call InitStruct; 
['LampCeiling',[4039.5,4022.13,15.875],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:GhyA0/mPKB8",_thisObj];
}] call InitStruct; 
_4039_237064025_4521514_48086 = ['RedButton',[4039.24,4025.45,19.4811,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {go_editor_globalRefs set ["RedButton G:QtralcJPWoA",_thisObj];
}] call InitStruct; 
_4011_000004055_7500014_10840 = ['ElectricalShield',[4011,4055.75,21.2186,true],90,[0,0.0348995,0.999391], {go_editor_globalRefs set ["ElectricalShield G:+luUbpyNzq4",_thisObj];
}] call InitStruct; 
['StreetLamp',[4052.63,4063,7.37282],135,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (2)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4072.81,4064.36,7.45862],190,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (3)",_thisObj];
}] call InitStruct; 
['StreetLamp',[4081.5,4074.55,7.0841],270,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (4)",_thisObj];
}] call InitStruct; 
_4017_170414051_3002915_40258 = ['RedButton',[4017.17,4051.3,20.4024,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:2Y5XzDeSbnc",_thisObj];
}] call InitStruct; 
['LampCeiling',[4006.39,4054.05,18.2939],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:g7G/XnsBC9A",_thisObj];
}] call InitStruct; 
['LampCeiling',[4014.18,4054.15,18.322],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:6Hk0pG2LyqI",_thisObj];
}] call InitStruct; 
['LampCeiling',[4016.33,4050.87,21.468,true],0,[0,0.48481,0.87462], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:ZtPLJzG0HNM",_thisObj];
}] call InitStruct; 
_4005_186044056_9160215_34257 = ['Tumbler',[4005.19,4056.92,15.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:EWMj6vlYuZw",_thisObj];
}] call InitStruct; 
_4005_686044056_9160215_34257 = ['Tumbler',[4005.69,4056.92,15.3426],0,[0,0,1], {go_editor_globalRefs set ["Tumbler G:1V9pkcdGJ9Q",_thisObj];
}] call InitStruct; 
['StreetLamp',[4070.62,4043.79,7.92625],0.000338948,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:FjPul73CNac (5)",_thisObj];
}] call InitStruct; 
['LampCeiling',[4024.88,4025.46,12.5],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:S5mD+ipln0g (1)",_thisObj];
}] call InitStruct; 
_4000_000004037_5000014_67537 = ['ElectricalShield',[4000,4037.5,14.6754],180,[0,0,1], {go_editor_globalRefs set ["ElectricalShield G:aL5OTxyNxco",_thisObj];
}] call InitStruct; 
_4068_316894067_0622611_43153 = ['RedButton',[4068.32,4067.06,16.4313,true],[0,7.54979e-008,-1],[0,1,7.54979e-008], {go_editor_globalRefs set ["RedButton G:EXKORnjUGZM",_thisObj];
}] call InitStruct; 
_4069_492924071_2988311_14536 = ['ElectricalShieldSmall',[4069.49,4071.3,11.1454],0,[0,0,1], {go_editor_globalRefs set ["ElectricalShieldSmall G:K+aD+A9Ny5s",_thisObj];
}] call InitStruct; 
_4067_558354068_1237811_49136 = ['RedButton',[4067.56,4068.12,16.4915,true],0,[-1,0,-4.37114e-008], {go_editor_globalRefs set ["RedButton G:iBr4jx3Wi0I",_thisObj];
}] call InitStruct; 
['LampCeiling',[4045.63,4022.38,15.875],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:KRZfyWUeOck",_thisObj];
}] call InitStruct; 
_4045_506104025_4533714_50724 = ['RedButton',[4045.51,4025.45,19.5074,true],[0,4.88762e-007,1],[0,-1,4.88762e-007], {go_editor_globalRefs set ["RedButton G:8n4vmOZcVYg",_thisObj];
}] call InitStruct; 
['StreetLamp',[4078.03,4014.96,2.31931],175,[0,0,1], {_thisObj setvariable ['light',SLIGHT_STREET_LAMP_DORM_var]; go_editor_globalRefs set ["StreetLamp G:zVA/rLuMkaA",_thisObj];
}] call InitStruct; 
['LampCeiling',[4062.33,4073.4,13.256],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LAMP_HOUSE_var]; go_editor_globalRefs set ["LampCeiling G:Tfyf2IaEkFM (1)",_thisObj];
}] call InitStruct; 
['BlockStone',[4013.75,4024.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4024.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.75,4024.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4034.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4024.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4003.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4034.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4023.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4033.75,4034.88,10],270,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4034.88,10],180,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4024.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4034.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4043.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4013.75,4053.88,14],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004.75,4049.88,14],180,[0,0,1]] call InitDecor; 
['BlockStone',[4053.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[3993.75,4044.38,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984.75,4063.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[3974.75,4064.13,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4064.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4054.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4083.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4093.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4063.75,4044.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4074.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4082.75,4074.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4082.75,4084.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4073.75,4084.88,10],0,[0,0,1]] call InitDecor; 
['BlockStone',[4008,4033,14.875],180,[0,0,1]] call InitDecor; 
['BlockStone',[4008,4023,14.875],180,[0,0,1]] call InitDecor; 
['BlockStone',[3998,4033,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[3998,4023,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[3988,4033,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[3988,4023,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[3978,4033,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[3978,4023,14.75],180,[0,0,1]] call InitDecor; 
['BlockStone',[4062.85,4037.03,7.89969,true],0,[0,-0.422618,0.906308]] call InitDecor; 
['BlockStone',[4063.88,4026.47,4.20567,true],0,[0,-0.258819,0.965926]] call InitDecor; 
['BlockDirt',[4073,4006.88,4],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4073,4018,4],90.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[4081.8,4018,2.45306,true],[-6.99328e-006,-1,1.92752e-006],[0.258819,5.18461e-008,0.965926]] call InitDecor; 
['BlockDirt',[4081.8,4006.88,2.45306,true],[-0.965926,9.95337e-007,0.258819],[0.258819,1.10984e-007,0.965926]] call InitDecor; 
['BlockDirt',[4063,4006.88,4],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4063,4018,4],0,[0,0,1]] call InitDecor; 
['StoneArch',[4059.25,4049.38,18.9877,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['StoneArch',[3974.73,4063.54,15.8266,true],270,[0.00692964,0.00566267,0.99996]] call InitDecor; 
['StoneArch',[4085.96,4049.88,7.77652],89.9979,[0,0,1]] call InitDecor; 
['BigStoneWall',[4042.25,4017.63,18.2369,true],2.86015e-005,[-0.00659113,-0.00162056,0.999977]] call InitDecor; 
['BigStoneWall',[4026.5,4017.75,18.3619,true],2.90283e-005,[-0.00659294,-0.00162104,0.999977]] call InitDecor; 
['BigStoneWall',[4012.25,4027.25,3.25],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[4000.25,4056.88,23.3619,true],90,[-0.00161952,0.00659617,0.999977]] call InitDecor; 
['BigStoneWall',[3989.63,4049,18.7369,true],90.0003,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4055.75,4029.88,18.2369,true],270,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4012.25,4059.88,14.875],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4032.13,4045.88,3.75],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4047.13,4057.88,9.875],105,[0,0,1]] call InitDecor; 
['BigStoneWall',[4048.44,4066.88,15],180,[0,0,1]] call InitDecor; 
['BigStoneWall',[4020.76,4057.32,14.875],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4000.75,4038.38,10.125],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3978.13,4057.38,17.3619,true],0.000939598,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[3988.75,4068.88,17.9869,true],180.001,[0.00161821,-0.00659538,0.999977]] call InitDecor; 
['BigStoneWall',[4069.88,4031.5,8.375],270.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4063.5,4057.75,3.625],0.000475552,[0,0,1]] call InitDecor; 
['BigStoneWall',[4087.63,4067.93,8.875],305.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4086,4076.13,9.875],270.001,[0,0,1]] call InitDecor; 
['BigStoneWall',[4054.26,4060.24,22.0465,true],[-2.94845e-006,-1.19249e-008,-1],[0,-1,1.19249e-008]] call InitDecor; 
['BigStoneWall',[4073.5,4065.5,21.9869,true],[-2.94845e-006,-1.19249e-008,-1],[0,-1,1.19249e-008]] call InitDecor; 
['BigStoneWall',[4079.05,4081.51,21.9605,true],[0,7.54979e-008,-1],[0,1,7.54979e-008]] call InitDecor; 
['BigStoneWall',[3993,4050.61,24.7369,true],[1.19249e-008,-4.37114e-008,-1],[1,0,1.19249e-008]] call InitDecor; 
['BigStoneWall',[3989.63,4062.75,24.6958,true],[-4.61738e-006,-4.88757e-007,-1],[-1.13994e-006,-1,4.88762e-007]] call InitDecor; 
['BigStoneWall',[4073.88,4049.09,22.9869,true],[-4.85579e-006,-4.88757e-007,-1],[-1.13994e-006,-1,4.88762e-007]] call InitDecor; 
_4014_750004019_3750010_39775 = ['IStruct',[4014.75,4019.38,18.7362,true],225,[0.0281457,0.0243337,0.999308], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4011_875004037_500009_87500 = ['IStruct',[4011.88,4037.5,9.875],60,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4020_957284046_192143_73324 = ['IStruct',[4020.96,4046.19,3.73324],230.001,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4043_125004046_375009_75000 = ['IStruct',[4043.13,4046.38,9.75],160,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4051_353764064_794199_52242 = ['IStruct',[4051.35,4064.79,9.52242],340,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3992_125004041_1250010_07605 = ['IStruct',[3992.13,4041.13,10.0761],240,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3988_977294056_730719_06092 = ['IStruct',[3988.98,4056.73,9.06092],50.0005,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3998_414554066_270519_95424 = ['IStruct',[3998.41,4066.27,9.95424],70.0005,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4053_083744019_668709_94673 = ['IStruct',[4053.08,4019.67,18.3193,true],159.984,[0.0208885,0.0307892,0.999308], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4069_875004071_667975_37500 = ['IStruct',[4069.88,4071.67,5.375],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumPileOfDirtAndStones',[4014.13,4050,16.1897,true],0,[-0.0069996,-0.174664,0.984603]] call InitStruct; 
['MediumPileOfDirtAndStones',[4055.63,4031.5,12],270,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3985.32,4067.61,14.8004,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['BigStoneWall',[4003,4018.83,14],360,[0,0,1]] call InitDecor; 
['BigStoneWall',[3983,4018.59,14],360,[0,0,1]] call InitDecor; 
['BigStoneWall',[3972,4029.75,14],90,[0,0,1]] call InitDecor; 
['BigStoneWall',[3981.5,4040.13,14.125],180,[0,0,1]] call InitDecor; 
['LargeConcreteWallWithReinforcement',[3969.22,4063.74,13.3088],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4090.09,4049.9,13.7363],90,[0,0,1]] call InitStruct; 
['BigStoneWall',[4061.25,4031,8.48244],90.0015,[0,0,1]] call InitDecor; 
['BigStoneWall',[4059.5,4009.38,8.5],90.0015,[0,0,1]] call InitDecor; 
['BigStoneWall',[4080,4019,5],190.002,[0,0,1]] call InitDecor; 
['BigStoneWall',[4071.13,4003.75,7.5],0.00152527,[0,0,1]] call InitDecor; 
['BigStoneWall',[4089.75,4009.25,4.5],270,[0,0,1]] call InitDecor; 
['BigStoneWall',[4070.88,4011,22.9869,true],[-1,-2.19464e-005,1.3273e-010],[0,-6.04789e-006,-1]] call InitDecor; 
['BigStoneWall',[4079.88,4009.88,23.1119,true],[4.37114e-008,2.29001e-005,-1],[-1,0,-4.37114e-008]] call InitDecor; 
['BigStoneWall',[4087.25,4003.5,13.8619,true],0,[0.34202,0,0.939693]] call InitDecor; 
['BigStoneWall',[4062.63,4036,19.7369,true],[1.12057e-008,0.34202,-0.939693],[1,0,1.19249e-008]] call InitDecor; 
['BigStoneWall',[4062.5,4016.25,16.2369,true],[1.19249e-008,-1.47422e-006,-1],[1,0,1.19249e-008]] call InitDecor; 
_4079_340094042_5869110_50000 = ['IStruct',[4079.34,4042.59,10.5],155,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_corner_2.p3d'];}] call InitStruct; // !!! realocated model !!!
['DestroyedMetalHangar',[4043.75,4104.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4021.75,4104.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4065.75,4104.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[3999.75,4104.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[3999.75,4054.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4021.75,4054.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4043.75,4054.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4065.75,4054.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088,4104.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088,4054.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4000,4004.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4022,4004.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4044,4004.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4066,4004.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[4088.25,4005.08,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[3977.75,4104.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[3977.75,4054.83,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['DestroyedMetalHangar',[3978,4004.96,42.3778,true],[-4.37896e-006,1,-2.4716e-006],[-1.13994e-006,-2.47161e-006,-1]] call InitDecor; 
['ThickConcreteFloorSmall',[4014.75,4054,13.6251],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4008.75,4054,13.6251],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4002.86,4054.01,13.6301],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4015,4051.13,16],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4009.75,4053.75,14.004],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4014.25,4057.5,17.875],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4005.25,4057.5,17.875],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4002.68,4055.05,17.9886],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4009.75,4058,17.875],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4007.63,4051.13,17.9885],0.000147703,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4018.27,4055.17,18.0063],90.0001,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4009.75,4053.02,16],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[4015.09,4051.12,14.0335],0,[0,0,1]] call InitStruct; 
_4016_250004051_1250014_12500 = ['SteelDoorThinSmall',[4016.25,4051.13,14.125],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormGenKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4009_750004052_5000014_12500 = ['SteelDoorThinSmall',[4009.75,4052.5,14.125],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RSlesarDormGenKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallSteelRustyFence',[4013.88,4051.09,14.7957],90,[0,0,1]] call InitStruct; 
['TinBigFence',[4012.83,4048.22,13.908],0,[0,0,1]] call InitStruct; 
['TinBigFence',[4007.51,4044.4,13.9842],0,[0,0,1]] call InitStruct; 
['TinBigFence',[4003.46,4044.73,14.0239],10,[0,0,1]] call InitStruct; 
['TinBigFence',[4016.86,4048.27,13.9],0,[0,0,1]] call InitStruct; 
_4018_833744048_284913_37035 = ['IStruct',[4018.83,4048.28,3.37035],180,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_stairs_a.p3d'];}] call InitStruct; // !!! realocated model !!!
_4005_301514052_0239320_40972 = ['IStruct',[4005.3,4052.02,26.0381,true],[-1.03273e-008,-0.499995,0.866028],[1,0,1.19249e-008], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4017_677004052_0405320_39853 = ['IStruct',[4017.68,4052.04,26.027,true],[-1.03273e-008,-0.499995,0.866028],[1,0,1.19249e-008], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
_4011_495854052_0407720_40201 = ['IStruct',[4011.5,4052.04,26.0304,true],[-1.03273e-008,-0.499995,0.866028],[1,0,1.19249e-008], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
['ThickConcreteFloorMedium',[4011.27,4054.03,19.9431],90,[0,0,1]] call InitStruct; 
_4018_969974053_7793013_78392 = ['Decor',[4018.97,4053.78,13.7839],269.294,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4018_812504053_8659714_47592 = ['Decor',[4018.81,4053.87,14.4759],269.294,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4017_035894054_6521014_12077 = ['Decor',[4017.04,4054.65,14.1208],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_germogate\l_02_alex_vorota_pult.p3d'];}] call InitDecor; // !!! realocated model !!!
_4015_906014057_3352114_15535 = ['Decor',[4015.91,4057.34,14.1553],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\dieselpowerplant_01\dpp_01_transformer_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['FarmGarden',[4018.76,4057.66,15.9117],231.764,[0,0,1]] call InitStruct; 
['BigElectricPumpFan',[4003.76,4053.48,14.0631],180,[0,0,1]] call InitStruct; 
['BigPipePump',[4005.58,4052.14,13.8048],270.001,[0,0,1]] call InitStruct; 
['ElectricPump',[4007.92,4052.11,14.0387],270,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[4013.41,4051.86,14.1236],270.794,[0,0,1]] call InitStruct; 
_4015_114264051_7805214_11853 = ['SquareWoodenBox',[4015.11,4051.78,14.1185],0,[0,0,1]] call InitStruct; 
_4010_793464054_4775413_97707 = ['SquareWoodenBox',[4010.79,4054.48,13.9771],0,[0,0,1]] call InitStruct; 
['MatchBox',[4013.77,4051.84,14.9881],321.649,[0,0,1]] call InitItem; 
['Paper',[4013.52,4051.97,14.9881],271.988,[0,0,1]] call InitItem; 
['Paper',[4013.28,4051.72,14.9881],60.118,[0,0,1]] call InitItem; 
['Paper',[4013.91,4052.08,14.9881],14.3355,[0,0,1]] call InitItem; 
['Shovel',[4009.13,4054.57,14.6721],180,[0,0,1]] call InitItem; 
['Shovel',[4013.05,4051.87,14.9745],215.852,[0,0,1]] call InitItem; 
['Shelves',[4009.09,4054.57,14.1206],89.288,[0,0,1]] call InitStruct; 
['Multimeter',[4009.1,4054.74,14.2254],84.158,[0,0,1]] call InitItem; 
['Screwdriver',[4009.08,4054.67,15.1152],116.562,[0,0,1]] call InitItem; 
['Gloves',[4009.11,4054.14,14.2272],89.5991,[0,0,1]] call InitItem; 
['Gloves',[4009.13,4054.46,14.2272],124.814,[0,0,1]] call InitItem; 
['Gloves',[4009.1,4054.31,14.2272],111.373,[0,0,1]] call InitItem; 
['WireCutters',[4009.1,4054.95,14.2411],284.072,[0,0,1]] call InitItem; 
_4013_466314057_5334514_53185 = ['Decor',[4013.47,4057.53,14.5319],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4005_032474046_1533213_97964 = ['Decor',[4005.03,4046.15,13.9796],10,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\tank\tank_rust_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['PenBlack',[4013.69,4052.16,14.9881],329.432,[0,0,1]] call InitItem; 
['WoodenChair',[4013.45,4052.7,14.1244],359.967,[0,0,1]] call InitItem; 
['FabricBagBig2',[4014.31,4051.87,14.1256],259.732,[0,0,1]] call InitItem; 
['SmallDirtGrey',[4005.01,4052.33,18.6367,true],265,[-1.86265e-007,0,1]] call InitStruct; 
['SmallDirtGrey',[4002.64,4055.65,18.8058,true],0.000147703,[-1.57946e-007,2.00795e-007,1]] call InitStruct; 
['LampWall',[4011.32,4055.18,23.603,true],90,[0,1,-4.37114e-008], {go_editor_globalRefs set ["Imported LampWall625366",_thisObj];
}] call InitStruct; 
['CandleDisabled',[4013.75,4051.58,14.9881],180,[0,0,1]] call InitItem; 
['CandleDisabled',[4013.61,4051.58,14.9881],180,[0,0,1]] call InitItem; 
['ToolPipe',[4009.08,4054.44,15.1228],180.147,[0,0,1]] call InitItem; 
['Wrench',[4009.09,4054.93,15.1194],93.865,[0,0,1]] call InitItem; 
['MediumRuinedPipe',[4004.83,4042.45,16.482],0,[0,0,1]] call InitStruct; 
['MediumRuinedPipe',[4004.35,4048.28,16.4468],180,[0,0,1]] call InitStruct; 
['SmallDestroyedCornerPipe',[4004.09,4051.96,21.4672,true],[0.0871557,-0.996195,3.65945e-006],[0.996195,0.0871557,-9.73177e-008]] call InitStruct; 
['Crowbar',[4009.1,4054.65,15.5706],0,[0,0,1]] call InitItem; 
['ConcreteFloorHangarLong',[4026.5,4065.75,21],90,[0,0,1]] call InitDecor; 
['FactoryBigBrick',[4031.13,4053.63,15.375],90,[0,0,1]] call InitDecor; 
['ConcreteArch',[4080.44,4049.87,6.58628],180,[0,0,1]] call InitDecor; 
['ConcreteArch',[3979.73,4063.48,6.27738],0,[0,0,1]] call InitDecor; 
['ConcreteArch',[4064.8,4049.3,9.26209],180,[0,0,1]] call InitDecor; 
['SmallDirtGrey',[4075.38,4073.88,10],160,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4076.38,4055.25,10],1.06722e-005,[0,0,1]] call InitStruct; 
['BigBlockedTunnel',[4079.13,4082.75,8.875],90,[0,0,1]] call InitDecor; 
['Rail',[4077.75,4066.75,9.875],187,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[4052.5,4057.13,16.9661],90,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[4050.13,4056,17.0911],0,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse1',[4050.13,4056,21.2161],1.06722e-005,[0,0,1]] call InitStruct; 
['BigRuinedBrickBuilding',[3990,4051.88,21.875],270,[0,0,1]] call InitDecor; 
['DirtCraterLong',[4050.88,4055,14.8759,true],10,[-0.00707306,0.000195864,0.999975]] call InitStruct; 
['DirtCraterLong',[3995.82,4051.6,14.5309,true],266.955,[0.00660731,0.00601942,0.99996]] call InitStruct; 
['DirtCraterLong',[3983.1,4058.33,14.9355,true],93.5819,[-0.00120364,0.00668457,0.999977]] call InitStruct; 
['BigPilePipes',[4052.49,4023.89,15.6334,true],270,[0.00161535,-0.00659347,0.999977]] call InitStruct; 
['MetalTruss',[4073.92,4056.24,16.4337,true],270,[-0.00103539,0.00699961,0.999975]] call InitStruct; 
['LongDestroyedPipeWithSupportingStructure',[4059,4048.88,22.1307,true],[-2.71003e-006,1,-4.85579e-006],[-6.70552e-007,-4.85579e-006,-1]] call InitStruct; 
['PipeCutOnSupportingStructure',[4016,4019.75,9.875],0,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4008.25,4028,10],10,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4036.96,4050.31,9.99754],98.8907,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4026.9,4050.47,10.016],102.876,[0,0,1]] call InitStruct; 
['BigPileBurntGarbage',[4003.5,4033.5,10.0233],87.5846,[0,0,1]] call InitStruct; 
['MetalTank',[3997.63,4051.75,16.2349,true],85,[-0.00825023,0.0147972,0.999856]] call InitStruct; 
['SmallRuinedWoodenBuilding',[4050.49,4041.57,10.9445],357.34,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4051.49,4019.78,10.031],240,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4002.58,4048.29,14.0237],27.6409,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4052.99,4038.85,10.1277],340.373,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[4074.88,4074.76,14.8729,true],[0.173648,0.984808,-7.48783e-007],[0.254886,-0.0449425,0.965926]] call InitStruct; 
['DestroyedPipeMedium',[4014.88,4039,16.4544,true],220,[-0.0238255,0.0139454,0.999619]] call InitStruct; 
['BigIndustrialPipesWithLadder',[3997.13,4063.13,18.7078,true],175,[0.00688101,0.00164269,0.999975]] call InitStruct; 
['RustyTank',[4028.13,4044.38,10.75],90,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4072.88,4068.35,10.1618],0,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4083.33,4076.19,10.0281],335,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4051.78,4064.33,10.1431],50,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[3993.07,4042.29,10.031],314.934,[0,0,1]] call InitStruct; 
['MetalAndConcreteRuins',[4009.77,4046.62,10.0265],24.7127,[0,0,1]] call InitStruct; 
['MediumPieceSuspendedPipe',[4049.75,4053.75,16.1597],0,[0,0,1]] call InitStruct; 
['MediumSteelUpperPipe',[4000.71,4043.98,11.6244],178.112,[0,0,1]] call InitStruct; 
['ConcretePanel',[4034.15,4042.2,15.0333,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['ConcretePanel',[4036.09,4042.2,15.0494,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
_4035_132574042_8337410_08330 = ['Statue3',[4035.13,4042.83,10.0833],0,[0,0,1]] call InitStruct; 
if ((random 1) < 0.5) then {
	['WoodenBucket',[4035.11,4042.84,17.6852,true],[-0.604024,0.766042,-0.219851],[0.34202,-5.45912e-006,-0.939693]] call InitItem; 
};
['MediumPileOfLightMud',[4034.1,4045.65,15.1741,true],[0.980421,0.165678,0.106423],[-0.0943911,-0.0788961,0.992404]] call InitStruct; 
['BetonTrapeciaSmall',[4035.09,4044.68,11.3668],0,[0,0,1]] call InitStruct; 
if ((random 1) < 0.4) then {
	['Paper',[4035.16,4042.79,17.016,true],[2.8994e-011,0.819152,-0.573576],[-0.996195,0.0499904,0.0713937]] call InitItem; 
};
['RedSteelBox',[3997.53,4061.41,9.99922],0,[0,0,1], {go_editor_globalRefs set ["task1redbox",_thisObj];
}] call InitStruct; 
['SteelThinWallSmall',[3997.44,4061.13,16.4121,true],0,[0,0.0871557,0.996195]] call InitStruct; 
['SmallSheetMetalHouse2',[3995.71,4062.97,10.288],270,[0,0,1]] call InitStruct; 
['Rail',[4075.63,4044.38,9.875],184,[0,0,1]] call InitStruct; 
['BigBlockedTunnel',[4074.88,4035,9.5],270,[0,0,1]] call InitDecor; 
['TunnelIntersection',[4079.25,4010,19.6961,true],180,[0,-8.02679e-007,-1]] call InitDecor; 
['ConcreteArch',[4077.1,4058.71,6.29935],90.0003,[0,0,1]] call InitDecor; 
['GateCity',[4079.95,4049.85,10.4647],90.0003,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4080.32,4049.85,14.5487,true],91.0414,[0.0324534,-0.036864,0.998793]] call InitStruct; 
['GateCity',[4064.82,4049.35,12.971],90.0003,[0,0,1]] call InitStruct; 
['GateCity',[3979.88,4063.5,10],270,[0,0,1]] call InitStruct; 
['GateCity',[4077.08,4058.74,10.332],0.000338948,[0,0,1]] call InitStruct; 
['GateCity',[4065.88,4048.14,16.2955,true],[0.944137,0.0973401,0.31485],[-0.317867,0.0168099,0.947986]] call InitStruct; 
['SmallSteelPlate',[4064.57,4049.33,15.5051,true],[-0.0968076,0.99474,-0.0334854],[-0.813497,-0.0596954,0.578498]] call InitStruct; 
['SmallPileOfConcreteFragments',[4070.18,4048.78,15.1017,true],320,[0.00879116,-0.00166821,0.99996]] call InitStruct; 
['DirtCraterLong',[4075.81,4042.21,14.8161,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['OrangeCarpet1',[4064.86,4070.26,10.1449],355,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4062.88,4067.37,10.0906],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4072.91,4070.25,14.0807],90.0003,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4073.72,4072.06,14.0746],105,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4062.72,4067.17,20.5158,true],179.999,[-1.13994e-006,-2.47161e-006,-1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4068.76,4067.18,20.5665,true],179.999,[-1.13994e-006,-2.47161e-006,-1]] call InitStruct; 
_4069_080574066_875009_92994 = ['SteelGridDoor',[4069.08,4066.88,9.92994],180,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RTorgDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_4067_756104068_9772910_00000 = ['SteelGridDoor',[4067.76,4068.98,10],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RTorgDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ConcreteWall',[4060.88,4071.25,10.875],270,[0,0,1]] call InitStruct; 
['BigConcreteUnfinishedBuilding',[4066.25,4070.13,10],0,[0,0,1]] call InitDecor; 
['RustyWindowFrameMeduim',[4061.19,4066.84,10.7929],0,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4063.97,4066.86,18.0669,true],1.75006e-007,[-5.36442e-007,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[4066.27,4066.84,10.7916],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4071,4069.75,10.185],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4070.38,4066.88,10.125],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4067.75,4070.08,10.185],270.001,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[4069.25,4071.63,10.185],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[4064,4075.13,11.036],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4064.25,4071.75,10.185],180,[0,0,1]] call InitStruct; 
['Wicket',[4065.22,4071.73,10.1855],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4064.26,4075.29,10.0896],180,[0,0,1]] call InitStruct; 
['BreadChopped',[4065.55,4067.23,11.5732],95,[0,0,1]] call InitItem; 
['BreadChopped',[4065.45,4067.18,11.5732],245,[0,0,1]] call InitItem; 
['BreadChopped',[4065.35,4067.24,11.5732],285,[0,0,1]] call InitItem; 
['BreadChopped',[4065.24,4067.18,11.5732],80,[0,0,1]] call InitItem; 
['BreadChopped',[4065.12,4067.22,11.5732],80,[0,0,1]] call InitItem; 
['BreadChopped',[4065.01,4067.17,11.5732],290,[0,0,1]] call InitItem; 
['Cutlet',[4065.08,4067.21,11.1342],295,[0,0,1]] call InitItem; 
['Cutlet',[4065.19,4067.24,11.1308],0,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.15,4067.18,11.5716],0,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.1,4067.18,11.5716],195,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4062.04,4067.16,11.5716],195,[0,0,1]] call InitItem; 
['SamokrutkaDisabled',[4061.99,4067.17,11.5716],170,[0,0,1]] call InitItem; 
['Lapsha',[4061.85,4067.15,11.5716],0,[0,0,1]] call InitItem; 
['Lapsha',[4061.67,4067.17,11.5716],0,[0,0,1]] call InitItem; 
['Lepeshka',[4062.43,4067.18,11.1216],0,[0,0,1]] call InitItem; 
['Lepeshka',[4062.24,4067.19,11.1216],300,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.88,4067.19,11.5732],190,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.83,4067.22,11.5732],180,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.78,4067.22,11.5732],175,[0,0,1]] call InitItem; 
['SigaretteDisabled',[4065.72,4067.21,11.5732],185,[0,0,1]] call InitItem; 
['Bread',[4062.87,4071.37,11.285],15,[0,0,1]] call InitItem; 
['Briefcase',[4066.81,4072.35,11.0635],100,[0,0,1]] call InitItem; 
['Briefcase',[4066.53,4067.19,12.038],185,[0,0,1]] call InitItem; 
['SteelBrownContainer',[4066.75,4067.55,11.0702],0,[0,0,1]] call InitItem; 
['SpirtBottle',[4062.04,4067.2,16.2563,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4062_497074067_1679711_57018 = ['SpirtBottle',[4062.5,4067.17,16.7071,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.67,4067.19,16.2557,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.89,4067.16,16.2573,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4061.78,4067.14,16.2565,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4062.37,4067.16,16.7022,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4062.24,4067.15,16.7075,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4066_442634067_1804211_12250 = ['SpirtBottle',[4066.44,4067.18,16.2595,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.31,4067.2,16.2545,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.2,4067.17,16.2599,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
_4066_913824067_1801811_57013 = ['SpirtBottle',[4066.91,4067.18,16.7071,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.8,4067.23,16.7022,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['SpirtBottle',[4066.72,4067.17,16.7075,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['Bun',[4066.54,4067.18,11.5733],200,[0,0,1]] call InitItem; 
['Bun',[4066.39,4067.21,11.5733],180,[0,0,1]] call InitItem; 
['Bun',[4066.26,4067.2,11.5733],195,[0,0,1]] call InitItem; 
['CoinBag',[4061.79,4067.16,12.0216],230,[0,0,1]] call InitItem; 
['CoinBag',[4061.97,4067.17,12.0216],0,[0,0,1]] call InitItem; 
['CoinBag',[4062.18,4067.15,12.0216],250,[0,0,1]] call InitItem; 
['ShuttleBag',[4061.64,4068.85,11.0415],0,[0,0,1]] call InitItem; 
['SmallBackpack',[4061.49,4069.27,10.9487],105,[0,0,1]] call InitItem; 
['Butter',[4063.25,4071.37,11.2827],315,[0,0,1]] call InitItem; 
['SmallBackpack',[4063.58,4071.36,11.2754],0,[0,0,1]] call InitItem; 
['SmallBackpack',[4063.89,4071.36,11.2706],340,[0,0,1]] call InitItem; 
['BrushCleaner',[4063.58,4071.35,10.9861],40,[0,0,1]] call InitItem; 
['Suitcase',[4064.58,4071.39,10.1348],350,[0,0,1], {go_editor_globalRefs set ["MoneyTorgCase",_thisObj];
}] call InitItem; 
['ToolStraigthPipe',[4067.4,4068.09,15.6197,true],6.51908e-009,[-0.939693,0,0.34202]] call InitItem; 
['Shavirma',[4065.83,4067.2,11.1232],210,[0,0,1]] call InitItem; 
['Shavirma',[4065.63,4067.19,11.1232],20,[0,0,1]] call InitItem; 
['Shavirma',[4065.47,4067.18,11.1232],205,[0,0,1]] call InitItem; 
['SmallChair',[4062.03,4069.69,10.0912],75,[0,0,1]] call InitItem; 
['MatchBox',[4062.93,4071.32,10.9861],0,[0,0,1]] call InitItem; 
['Muka',[4063.39,4072.09,11.3287],10,[0,0,1]] call InitItem; 
['Muka',[4063.09,4072.18,16.4616,true],[-8.14188e-015,1,1.86265e-007],[-1,0,-4.37114e-008]] call InitItem; 
_4063_653324072_1203610_99500 = ['PenBlack',[4063.65,4072.12,10.995],280,[0,0,1]] call InitItem; 
['MetalCup',[4063.27,4072.18,10.6268],0,[0,0,1]] call InitItem; 
['MilkBottle',[4062.82,4072.23,11.3501],0,[0,0,1]] call InitItem; 
['MilkBottle',[4062.67,4072.13,11.3501],0,[0,0,1]] call InitItem; 
['GlassBottle',[4064.25,4072.23,10.286],0,[0,0,1]] call InitItem; 
['GlassBottle',[4063.99,4072.18,10.286],0,[0,0,1]] call InitItem; 
['GlassBottle',[4063.79,4072.23,10.286],0,[0,0,1]] call InitItem; 
['Cup',[4063.73,4072.15,11.3501],0,[0,0,1]] call InitItem; 
['CuttingBoard',[4061.9,4073.33,11.0152],10,[0,0,1]] call InitItem; 
['Kastrula',[4063.32,4072.19,10.286],0,[0,0,1]] call InitItem; 
['Kastrula',[4063.01,4072.19,10.286],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4062.82,4071.32,11.6495],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4063.32,4071.37,11.649],0,[0,0,1]] call InitItem; 
['OlderWoodenCup',[4063.55,4071.44,11.6489],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.3) then {
	['Meat',[4064.08,4072.02,10.1745],230,[0,0,1]] call InitItem; 
};
['FoodPlate',[4063.65,4072.2,10.6447],0,[0,0,1]] call InitItem; 
['MeatChopped',[4064.24,4072.16,11.3501],335,[0,0,1]] call InitItem; 
['MeatMinced',[4064.09,4072.13,11.3501],0,[0,0,1]] call InitItem; 
['MeatMinced',[4063.97,4072.15,11.3501],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.97,4072.19,10.6447],0,[0,0,1]] call InitItem; 
['PepperShaker',[4063.1,4072.23,10.6447],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.85,4072.24,10.6447],0,[0,0,1]] call InitItem; 
['PepperShaker',[4063.05,4072.12,10.6447],0,[0,0,1]] call InitItem; 
['PepperShaker',[4062.86,4072.13,10.6447],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.97,4072.21,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.77,4072.25,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.77,4072.1,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.07,4072.17,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.9,4072.13,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.2,4072.25,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.86,4072.27,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4063.98,4072.09,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.19,4072.13,10.995],0,[0,0,1]] call InitItem; 
['SaltShaker',[4064.05,4072.26,10.995],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.68,4072.2,10.995],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.56,4072.15,10.995],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.49,4072.23,10.995],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.65,4072.11,10.995],0,[0,0,1]] call InitItem; 
['SugarShaker',[4062.8,4072.19,10.995],0,[0,0,1]] call InitItem; 
['FryingPan',[4061.78,4073.96,10.9958],245,[0,0,1]] call InitItem; 
['SoupPlate',[4062.62,4072.24,10.286],0,[0,0,1]] call InitItem; 
['SoupPlate',[4062.59,4072.2,10.6434],0,[0,0,1]] call InitItem; 
['WoodenCup',[4063.07,4071.33,11.6463],0,[0,0,1]] call InitItem; 
['MatchBox',[4062.83,4071.34,10.9861],15,[0,0,1]] call InitItem; 
['WoodenChair',[4070.68,4070.95,15.3601,true],[0.173648,0.984808,1.27118e-007],[-0.984808,0.173648,-9.0392e-008]] call InitItem; 
['WoodenChair',[4070.56,4070.9,10.0888],10,[0,0,1]] call InitItem; 
['MatchBox',[4065.59,4073.75,10.9427],15,[0,0,1]] call InitItem; 
['Egg',[4063.41,4072.2,10.995],0,[0,0,1]] call InitItem; 
['Egg',[4063.2,4072.25,10.995],0,[0,0,1]] call InitItem; 
['Egg',[4062.98,4072.17,10.995],0,[0,0,1]] call InitItem; 
['Egg',[4061.4,4072.58,11.007],0,[0,0,1]] call InitItem; 
['SmallSteelTable1',[4063.73,4067.24,10.2333],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4061.65,4068.63,10.0911],0,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[4061.82,4070.89,10.0911],30,[0,0,1]] call InitStruct; 
['WoodenSmallShelf',[4063.39,4071.38,10.221],90,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4066.86,4072.48,10.0902],0,[0,0,1]] call InitStruct; 
['BedOld2',[4066.26,4070.54,10.1574],2.56132e-006,[0,0,1], {go_editor_globalRefs set ["RTorgDormBed",_thisObj];
}] call InitStruct; 
['Shelves',[4065.44,4067.18,10.5732],0,[0,0,1]] call InitStruct; 
['Shelves',[4066.54,4067.18,10.5733],0,[0,0,1]] call InitStruct; 
['Shelves',[4062.08,4067.18,10.5716],0,[0,0,1]] call InitStruct; 
['SmallSteelTable',[4061.54,4069.63,10.1468],265,[0,0,1]] call InitStruct; 
['SmallWoodenTableHandmade',[4063.08,4060.95,9.98329],102.935,[0,0,1]] call InitStruct; 
['SmallSteelTable1',[4065.59,4060.8,15.4434,true],76.7988,[-0.00261052,0.0065761,0.999975]] call InitStruct; 
['SteelSmallShelf',[4063.38,4072,10.0908],270,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4061.63,4073.38,10.125],90,[0,0,1]] call InitStruct; 
['SmallStoveGrill',[4064.28,4074.33,10],105,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LIGHT_STOVE_var];}] call InitStruct; 
['BlackSmallStove',[4066.63,4073.38,10.185],0,[0,0,1], {_thisObj setvariable ['light',SLIGHT_LIGHT_BAKE_var];}] call InitStruct; 
['PosterWorkplaceClean',[4065.17,4074.94,11.7073],180,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4003.16,4037.17,14.9812],270,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4000.07,4033.85,19.8571,true],0,[-0.00566278,0.00693103,0.99996]] call InitStruct; 
['WoodenDoor',[3991.36,4027.21,15.5283],180,[0,0,1]] call InitStruct; 
_4005_875004027_3750015_25000 = ['WoodenDoor',[4005.88,4027.38,15.25],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RPriyatelDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['MediumWoodenTable',[3995.78,4023.06,15.4467],0,[0,0,1], {go_editor_globalRefs set ["AntagMoneyCasePoint",_thisObj];
}] call InitStruct; 
['StoneWall',[4013.15,4033.47,15.25],270,[0,0,1]] call InitStruct; 
['StoneWall',[4013.12,4035.96,15.3503],270,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall',[3990.88,4023.74,15.375],0,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall1',[4005.25,4023.83,15.125],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable1',[4010.03,4025.45,15.2001],270,[0,0,1]] call InitStruct; 
['BrickThinWall',[3992.68,4020.75,15.4343],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[4007.43,4020.78,15.1843],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4013.13,4025.05,16.6587],90.0001,[0,0,1]] call InitStruct; 
['WoodenChair',[3994.95,4022.72,15.4343],250,[0,0,1]] call InitItem; 
['WoodenSmallShelf',[4009.55,4023.39,15.2681],90,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[4009.43,4021.69,15.1983],85,[0,0,1], {go_editor_globalRefs set ["RPriyatelDormBed",_thisObj];
}] call InitStruct; 
['SingleWhiteBed',[4008.45,4036.67,14.9863],355,[0,0,1], {go_editor_globalRefs set ["RLekarDormBed",_thisObj];
}] call InitStruct; 
['CaseBedroom',[4007.26,4037.72,14.9818],265.034,[0,0,1]] call InitStruct; 
['GreenArmChair',[4006.25,4037.29,14.9857],0,[0,0,1]] call InitStruct; 
['SmallBrickHouse',[4006,4035,14.3922],270,[0,0,1]] call InitStruct; 
_4005_194584033_4079614_97966 = ['SteelGreenDoor',[4005.19,4033.41,14.9797],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RLekarDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelThinWallMedium',[3998.25,4027.25,14.625],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4011.88,4027.25,14.625],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3988.13,4020.71,15.4343],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4004.49,4038.01,14.9931],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3985.38,4022.45,15.4343],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3987.12,4027.22,15.4343],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3989.99,4025.22,15.4343],270,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3999.59,4022.67,15.1843],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4004.42,4025.35,15.1843],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4001.55,4027.27,15.1843],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4009.26,4034.98,14.6616],270,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[4011.13,4034.57,14.879],8.53774e-007,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3994.52,4027.71,14.6743],70,[0,0,1]] call InitStruct; 
['ClayWallSmall',[4009.2,4023.84,15.6191],0,[0,0,1]] call InitStruct; 
_4012_442634030_2500013_41836 = ['IStruct',[4012.44,4030.25,13.4184],180,[0,0,1], {_thisObj setvariable ['model','ca\structures\nav_boathouse\nav_boathouse_pierl.p3d'];}] call InitStruct; // !!! realocated model !!!
['BedOld2',[3991.37,4022.23,15.4665],175,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3993.68,4026.59,15.4423],90.0001,[0,0,1]] call InitStruct; 
['SmallSteelTable',[4007.32,4026.7,15.1977],0,[0,0,1]] call InitStruct; 
['SmallSteelTable1',[4003.45,4035.73,20.4144,true],270,[-0.00103742,0.00699736,0.999975]] call InitStruct; 
['Wicket',[4013.12,4030.46,15.1515],0,[0,0,1]] call InitStruct; 
['SmallChair',[4009.23,4025.41,15.1843],285,[0,0,1]] call InitItem; 
['SmallChair',[4004.25,4035.9,19.9852,true],75,[0.00281125,-0.00648951,0.999975]] call InitItem; 
['BigClothCabinet',[3993.56,4021.19,15.4508],180,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4005.15,4021.75,15.1961],250,[0,0,1]] call InitStruct; 
['SpirtBottle',[4010.62,4022.21,15.2152],0,[0,0,1]] call InitItem; 
_4008_528814022_6792015_21523 = ['SpawnPoint',[4008.53,4022.68,15.2152],120,[0,0,1]] call InitStruct; 
['SteelBrownContainer',[4010.05,4025.05,15.2152],35,[0,0,1], {go_editor_globalRefs set ["AlkoBox",_thisObj];
}] call InitItem; 
['PenBlack',[4003.65,4035.89,15.8488],295,[0,0,1]] call InitItem; 
_4007_289314036_3161614_99307 = ['SpawnPoint',[4007.29,4036.32,14.9931],45,[0,0,1]] call InitStruct; 
['LiqTovimin',[4003.22,4035.24,15.8526],0,[0,0,1]] call InitItem; 
['LiqPainkiller',[4003.14,4035.58,15.8502],0,[0,0,1]] call InitItem; 
['LiqDemitolin',[4003.44,4035.26,15.8527],0,[0,0,1]] call InitItem; 
_4003_508544033_3056616_31373 = ['WallmountedMedicalCabinet',[4003.51,4033.31,16.3137],180,[0,0,1]] call InitStruct; 
['MedicalBag',[4003.36,4036.2,15.8469],75,[0,0,1]] call InitItem; 
['Crutch',[4005.5,4037.42,20.5676,true],[-8.45339e-007,-1,-2.32255e-006],[-0.939693,0,0.34202]] call InitItem; 
['Syringe',[4003.31,4035.43,15.8506],75,[0,0,1]] call InitItem; 
['PaperHolder',[4003.71,4035.22,15.853],0,[0,0,1]] call InitItem; 
['SmallSteelRustyFence',[4007.91,4033.49,16.055],90,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3978.71,4033.32,21.7941,true],0,[0.0025838,0,0.999997]] call InitStruct; 
['DoubleCitizenBed1',[3980.29,4029.95,19.2],272.903,[0,0,1]] call InitStruct; 
['PaperHolder',[3978.47,4033.82,22.3029,true],0,[0.0025838,0,0.999997]] call InitItem; 
['Paper',[3978.4,4033.48,22.2299,true],0,[0.0025838,0,0.999997]] call InitItem; 
['SteelGridDoor',[3977.47,4032.06,19.0693],90,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKletKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['PenRed',[3978.64,4033.41,22.2345,true],123.955,[-0.00143704,-0.00212842,0.999997]] call InitItem; 
['PenBlack',[3978.54,4033.27,22.2351,true],323.788,[0.00207931,0.00152539,0.999997]] call InitItem; 
['WoodenAncientBench',[3979.6,4034.26,19.2742],0,[0,0,1]] call InitStruct; 
['WoodenChair',[3977.98,4033.78,21.3178,true],287.129,[0.000752751,0.00246804,0.999997]] call InitItem; 
['WoodenChair',[3979.66,4033.31,16.3828],94.1255,[0,0,1]] call InitItem; 
['MetalCup',[3978.91,4030.02,17.488],0,[0,0,1]] call InitItem; 
['HospitalBed',[3975.62,4029.78,21.9694,true],270.685,[2.46207e-005,0.00255372,0.999997], {go_editor_globalRefs set ["RUchastDormBed",_thisObj];
}] call InitStruct; 
_3974_669684030_6586916_32000 = ['CaseBedroom',[3974.67,4030.66,21.32,true],180.922,[-0.00257779,5.20634e-005,0.999997]] call InitStruct; 
['Cup',[3978.38,4033.05,22.2793,true],0,[0.0025838,0,0.999997]] call InitItem; 
['HospitalBench',[3981.3,4031.49,21.4256,true],90.8706,[-4.20036e-005,-0.00256759,0.999997]] call InitStruct; 
['RustyCell',[3977.5,4032.14,19.2547],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3974.7,4033.58,16.4524],179.513,[0,0,1]] call InitStruct; 
_3977_916754034_9587417_78314 = ['WallmountedMedicalCabinet',[3977.92,4034.96,22.7831,true],0,[0.0025838,0,0.999997]] call InitStruct; 
['BigClothCabinet',[3974.65,4031.7,21.4196,true],269.185,[-4.5079e-005,0.00257916,0.999997]] call InitStruct; 
['LargeTwoStoreyStoneHouse',[3979.5,4033,16.25],180,[0,0,1]] call InitStruct; 
_3981_826424029_5366216_32000 = ['SteelBrownDoor',[3981.83,4029.54,16.32],270,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelThinWallSmall',[3974.26,4031.5,19.24],90,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3974.19,4029.71,19.2],270,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3976.56,4034.79,19.2],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3983.47,4030,14.8975],0,[0,0,1]] call InitStruct; 
['Briefcase',[3978.46,4034.19,17.2271],0,[0,0,1]] call InitItem; 
['SmallDirtGrey',[3977.05,4037.02,14.6765],90,[0,0,1]] call InitStruct; 
_3976_581054034_8132316_43925 = ['SteelBrownDoor',[3976.58,4034.81,16.4392],0.000475552,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3976_703864026_4978014_74382 = ['RDetMailBox',[3976.7,4026.5,19.7438,true],0,[0.00659634,0.00161941,0.999977]] call InitStruct; 
['SquareWoodenBox',[3974.74,4026.31,14.7477],5,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3979.85,4023.65,14.723],5,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3978.33,4029.77,19.2385],355,[0,0,1]] call InitStruct; 
['MatchBox',[3981.04,4031.8,20.1573],0,[0,0,1]] call InitItem; 
if ((random 1) < 0.4) then {
	['Crowbar',[3981.32,4029.82,24.2795,true],55,[0.00148088,-0.00211316,0.999997]] call InitItem; 
};
['SteelCanopySmall',[3976.38,4025.62,15.2201],0,[0,0,1]] call InitStruct; 
['TinBigFence',[3980.55,4024.88,14.9597],270,[0,0,1]] call InitStruct; 
['TinBigFence',[3980.52,4024.89,16.625],270,[0,0,1]] call InitStruct; 
['WoodenChair',[3980.56,4031.87,19.2],225,[0,0,1]] call InitItem; 
['WoodenChair',[3981.18,4032.96,25.6755,true],[-0.0871615,0.996194,7.53972e-006],[-3.02838e-006,7.30355e-006,-1]] call InitItem; 
['WoodenWeaponBox',[3974.79,4024.93,14.7316],75,[0,0,1]] call InitStruct; 
_3981_222414032_2087420_15811 = ['CoinBag',[3981.22,4032.21,20.1581],0,[0,0,1]] call InitItem; 
['RedSteelBox',[3978.32,4029.84,20.191],310,[0,0,1]] call InitStruct; 
_3979_617684033_8132319_25614 = ['IStruct',[3979.62,4033.81,19.2561],175,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\carpet_2_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3976_000004034_2500019_31000 = ['CaseBedroomSmall',[3976,4034.25,19.31],265.001,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[3977.95,4019.35,21.328,true],0,[-0.00566278,0.505982,0.862525]] call InitStruct; 
['LampKeroseneDisabled',[3981.27,4031.94,20.1555],5,[0,0,1]] call InitItem; 
_3979_621344034_0034219_29673 = if ((random 1) < 0.5) then {
	['Key',[3979.62,4034,24.3009,true],120,[-0.00128955,-0.0022338,0.999997], {_thisObj setvariable ['preinit@__keytypesstr',"RUchastDormKletKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
};
_3974_891364021_7397514_77565 = ['WoodenToiletSmall',[3974.89,4021.74,14.7757],80,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3981.25,4034.06,16.3623],170,[0,0,1]] call InitStruct; 
['Lockpick',[3981.13,4032.97,20.1581],25,[0,0,1]] call InitItem; 
['Lockpick',[3981.11,4032.91,20.1581],315,[0,0,1]] call InitItem; 
['SmallWoodenTableHandmade',[3981.18,4032.27,19.2],85,[0,0,1]] call InitStruct; 
_3980_522714022_0053714_74117 = ['Wicket',[3980.52,4022.01,14.7412],0,[0,0,1]] call InitStruct; 
_3977_878424034_2717319_17873 = ['IStruct',[3977.88,4034.27,24.5264,true],335,[-0.0080614,0.00388847,0.99996], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\vase_loam_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['Baton',[3978.38,4032.87,17.2271],195,[0,0,1]] call InitItem; 
['BedOld',[3974.63,4033.5,19.25],0,[0,0,1], {go_editor_globalRefs set ["RUchastHelperDormBed",_thisObj];
}] call InitStruct; 
['RopeItem',[3976.01,4034.19,19.8713],50,[0,0,1]] call InitItem; 
['HouseWithGarageSmall1',[3992.13,4035.06,15],180,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3987.24,4035.65,15.0733],0,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3993.71,4036.88,15.0593],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[3989.5,4038.05,15.0593],0,[0,0,1]] call InitStruct; 
['BigRedEdgesRack',[3997.13,4034.61,15.0755],270,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3991.95,4036.68,15.0593],355,[0,0,1], {go_editor_globalRefs set ["RRostDorm",_thisObj];
}] call InitStruct; 
['SingleWhiteBed',[3996.77,4036.67,15.0726],355,[0,0,1], {go_editor_globalRefs set ["RDolgDormBed",_thisObj];
}] call InitStruct; 
['ChairLibrary',[3988.19,4035.66,15.0854],0,[0,0,1]] call InitItem; 
['ChairLibrary',[3994.47,4036.85,15.0854],0,[0,0,1]] call InitItem; 
['SteelThinWallSmall',[3994.8,4038.17,15.0593],0,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3989.86,4032.3,15.0723],270,[0,0,1]] call InitStruct; 
['ContainerGreen',[3997.08,4032.56,15.0746],185,[0,0,1]] call InitStruct; 
['BigClothCabinet',[3989.23,4037.62,15.0764],0,[0,0,1]] call InitStruct; 
_3991_640634031_6001015_05929 = ['WoodenDoor',[3991.64,4031.6,15.0593],0,[0,0,1], {_thisObj setvariable ['preinit@__keytypesstr',"RRostDormKey"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Notepad',[3987.47,4035.72,15.9379],165,[0,0,1]] call InitItem; 
['RedCarpet',[3990.83,4034.94,14.5003],0,[0,0,1]] call InitStruct; 
['PaperHolder',[3987.3,4034.9,15.9379],0,[0,0,1]] call InitItem; 
['Paper',[3987.34,4035.19,15.9379],0,[0,0,1]] call InitItem; 
['Paper',[3987.29,4035.43,15.9379],340,[0,0,1]] call InitItem; 
['OfficeCabinet',[3992.49,4034.88,15.0901],90,[0,0,1]] call InitStruct; 
['PenBlack',[3987.47,4035.72,15.9487],0,[0,0,1]] call InitItem; 
['OrangeCarpet1',[3995.35,4036.44,15.0745],0,[0,0,1]] call InitStruct; 
['RedCarpetWall',[3993.14,4036.13,16.8501],0,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3995.86,4031.68,15.8512],90,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3987.99,4032.16,15.0902],90,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[3997.75,4034.88,16.3268],270,[0,0,1]] call InitStruct; 
['RustyWindowFrameMeduim',[3986.38,4034.37,16.3364],90.0001,[0,0,1]] call InitStruct; 
['PosterGirl',[3986.69,4035.72,21.7829,true],[1.19249e-008,-7.58967e-007,-1],[1,0,1.19249e-008]] call InitStruct; 
_4040_877934021_7102110_12500 = ['SpawnPoint',[4040.88,4021.71,10.125],146,[0,0,1]] call InitStruct; 
_4027_799074031_1333010_12609 = ['SpawnPoint',[4027.8,4031.13,10.1261],150,[0,0,1]] call InitStruct; 
_4038_526864031_0869113_05776 = ['SpawnPoint',[4038.53,4031.09,13.0578],175,[0,0,1]] call InitStruct; 
_4035_017334031_2895513_05776 = ['SpawnPoint',[4035.02,4031.29,13.0578],85,[0,0,1]] call InitStruct; 
_4030_096924033_0385713_07844 = ['SpawnPoint',[4030.1,4033.04,13.0784],35,[0,0,1]] call InitStruct; 
_4046_051514032_9072313_05776 = ['SpawnPoint',[4046.05,4032.91,13.0578],320,[0,0,1]] call InitStruct; 
_4046_945564022_4687513_15707 = ['SpawnPoint',[4046.95,4022.47,13.1571],140,[0,0,1]] call InitStruct; 
_4044_670654022_3674313_15576 = ['SpawnPoint',[4044.67,4022.37,13.1558],220,[0,0,1]] call InitStruct; 
_4065_510254070_0705610_18500 = ['SpawnPoint',[4065.51,4070.07,10.185],20,[0,0,1]] call InitStruct; 
_3976_206544030_7785616_44883 = ['SpawnPoint',[3976.21,4030.78,16.4488],241.65,[0,0,1]] call InitStruct; 
_3990_947754035_8142115_09023 = ['SpawnPoint',[3990.95,4035.81,15.0902],30,[0,0,1]] call InitStruct; 
_3995_703614035_9272515_09023 = ['SpawnPoint',[3995.7,4035.93,15.0902],30,[0,0,1]] call InitStruct; 
_3994_949224063_2680710_10172 = ['CollectionSpawnPoint',[3994.95,4063.27,10.1017],45,[0,0,1]] call InitStruct; 
_3980_910644063_5080610_10054 = ['CollectionSpawnPoint',[3980.91,4063.51,10.1005],280,[0,0,1]] call InitStruct; 
_3997_438724046_3418010_13051 = ['CollectionSpawnPoint',[3997.44,4046.34,10.1305],30,[0,0,1]] call InitStruct; 
_4012_829594047_0022010_16958 = ['CollectionSpawnPoint',[4012.83,4047,10.1696],325,[0,0,1]] call InitStruct; 
_4056_398684055_7150911_03584 = ['CollectionSpawnPoint',[4056.4,4055.72,11.0358],320,[0,0,1]] call InitStruct; 
_4077_467534076_2241210_12971 = ['CollectionSpawnPoint',[4077.47,4076.22,10.1297],340,[0,0,1]] call InitStruct; 
_4082_726324071_6984910_09816 = ['CollectionSpawnPoint',[4082.73,4071.7,10.0982],90,[0,0,1]] call InitStruct; 
_4075_615974070_1220710_18600 = ['CollectionSpawnPoint',[4075.62,4070.12,10.186],310,[0,0,1]] call InitStruct; 
_3976_000004033_0000019_31000 = ['SpawnPoint',[3976,4033,19.31],320,[0,0,1]] call InitStruct; 
_4168_332524015_042970_00000 = ['IStruct',[4168.33,4015.04,5.13837,true],0,[0.00161916,-0.00659633,0.999977], {_thisObj setvariable ['model','a3\structures_f\items\vessels\bucket_painted_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['Documents',[4167.25,4015.06,0.108239],0,[0,0,1]] call InitItem; 
_4164_668464014_947510_01640 = ['IStruct',[4164.67,4014.95,5.54687,true],0,[0.00103599,-0.00699973,0.999975], {_thisObj setvariable ['model','metro_ob\model\big_box.p3d'];}] call InitStruct; // !!! realocated model !!!
_4167_696784015_086430_02165 = ['IStruct',[4167.7,4015.09,5.17823,true],0,[-0.0154596,-0.00693025,0.999856], {_thisObj setvariable ['model','relicta_models\models\interier\props\kitchen\buhlo2.p3d'];}] call InitStruct; // !!! realocated model !!!
_4167_834474015_07397_0_05223 = ['IStruct',[4167.83,4015.07,5.15591,true],0,[0.00161916,-0.00659633,0.999977], {_thisObj setvariable ['model','relicta_models\models\interier\props\kitchen\buhlo3.p3d'];}] call InitStruct; // !!! realocated model !!!
_4168_009284015_10010_0_03668 = ['IStruct',[4168.01,4015.1,5.17117,true],0,[-0.0384836,0.0261709,0.998916], {_thisObj setvariable ['model','relicta_models\models\interier\props\kitchen\buhlo4.p3d'];}] call InitStruct; // !!! realocated model !!!
_4166_846194015_244630_33909 = ['IStruct',[4166.85,4015.24,5.36501,true],0.400595,[0.999975,-0.00699163,-0.00103368], {_thisObj setvariable ['model','ml_shabut\exoduss\bukhuchet.p3d'];}] call InitStruct; // !!! realocated model !!!
['Suitcase1',[4166.08,4015.18,5.29204,true],0,[0.00103599,-0.00699973,0.999975]] call InitItem; 
_4169_483894014_99683_0_00016 = ['IStruct',[4169.48,4015,5.57172,true],185,[-0.00103538,0.00671021,0.999977], {_thisObj setvariable ['model','relicta_models\models\interier\chair3.p3d'];}] call InitStruct; // !!! realocated model !!!
_4168_689944015_072020_16981 = ['IStruct',[4168.69,4015.07,5.16981,true],0,[0.00161964,-0.00659681,0.999977], {_thisObj setvariable ['model','ml\ml_object_new\model_05\kostrulya.p3d'];}] call InitStruct; // !!! realocated model !!!
_4165_351074015_294430_01568 = ['IStruct',[4165.35,4015.29,5.17576,true],0,[0.00103599,-0.00699973,0.999975], {_thisObj setvariable ['model','ml_shabut\exodus\redlightbox.p3d'];}] call InitStruct; // !!! realocated model !!!
_4171_310064015_095460_01294 = ['IStruct',[4171.31,4015.1,5.63774,true],0,[0.00161916,-0.00659633,0.999977], {_thisObj setvariable ['model','relicta_models\models\nocategory\wheelchair1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4170_320804014_936280_02043 = ['IStruct',[4170.32,4014.94,5.75949,true],0,[0.00566271,-0.00693096,0.99996], {_thisObj setvariable ['model','relicta_models\models\nocategory\wheelchair2.p3d'];}] call InitStruct; // !!! realocated model !!!
['Notepad',[4166.86,4014.95,0.132112],0,[0,0,1]] call InitItem; 
_4161_394534018_616940_10824 = ['IStruct',[4161.39,4018.62,0.108239],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitStruct; // !!! realocated model !!!
_4156_764164020_498290_02760 = ['IStruct',[4156.76,4020.5,0.0275965],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\pozharishe.p3d'];}] call InitStruct; // !!! realocated model !!!
_4171_712404026_632089_97824 = ['IStruct',[4171.71,4026.63,14.9879,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','ml\ml_object\cube_close.p3d'];}] call InitStruct; // !!! realocated model !!!
_4161_662604015_307860_10824 = ['IStruct',[4161.66,4015.31,5.10824,true],185,[0.00705648,0.000419973,0.999975], {_thisObj setvariable ['model','ca\structures\furniture\cases\case_cans_b\case_cans_b.p3d'];}] call InitStruct; // !!! realocated model !!!
_4163_020024015_126220_10813 = ['IStruct',[4163.02,4015.13,5.10813,true],0,[-0.0069996,-0.00103549,0.999975], {_thisObj setvariable ['model','ca\structures\furniture\chairs\kitchen_chair_a\kitchen_chair_a.p3d'];}] call InitStruct; // !!! realocated model !!!
_4160_275884015_287840_10459 = ['IStruct',[4160.28,4015.29,6.3839,true],180,[0.00699259,0.00103492,0.999975], {_thisObj setvariable ['model','ml\ml_object_new\model_24\shkafik.p3d'];}] call InitStruct; // !!! realocated model !!!
_4158_689454015_095460_09938 = ['IStruct',[4158.69,4015.1,6.51914,true],265,[0.00218517,-0.00642801,0.999977], {_thisObj setvariable ['model','ml_shabut\exodusss\shkafique.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallPileOfBricks',[4172.63,4044.23,5.76225,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
_4178_856934070_530520_00000 = ['IStruct',[4178.86,4070.53,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_concrete_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4172_769534072_140380_00000 = ['IStruct',[4172.77,4072.14,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_metal_plates_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4177_920414076_313480_00000 = ['IStruct',[4177.92,4076.31,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_metal_plates_04.p3d'];}] call InitStruct; // !!! realocated model !!!
_4174_362794058_083980_00000 = ['IStruct',[4174.36,4058.08,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_rocks_01.p3d'];}] call InitStruct; // !!! realocated model !!!
_4171_842774080_503171_49376 = ['IStruct',[4171.84,4080.5,1.49376],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_wood_02.p3d'];}] call InitStruct; // !!! realocated model !!!
_4190_582524061_376460_00000 = ['IStruct',[4190.58,4061.38,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_wood_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4184_884284069_431640_00000 = ['IStruct',[4184.88,4069.43,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\ruin_rubble.p3d'];}] call InitStruct; // !!! realocated model !!!
_4182_050294061_630130_00000 = ['IStruct',[4182.05,4061.63,0],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_bricks_01.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallSteelTable1',[4081.3,4069.66,9.84325],269.998,[0,0,1], {go_editor_globalRefs set ["TaskMoneyCaseTable",_thisObj];
}] call InitStruct; 
['SmallSheetMetalHouse1',[4082.33,4069.82,11.5143],2.13443e-006,[0,0,1]] call InitStruct; 
['MotherBunchOfShit',[4085.55,4008.25,6.89263,true],0,[0.174679,-0.00713907,0.9846]] call InitStruct; 
['BunchOfShit',[4086.13,4015.25,2.125],305,[0,0,1]] call InitStruct; 
['BunchOfShit',[4083.34,4013.93,7.47758,true],[-0.739941,0.620887,0.258818],[0.357877,0.0375705,0.933013]] call InitStruct; 
['BunchOfShit',[4081.38,4007.13,8.00659,true],[0.34202,0.939693,-5.36442e-007],[0.24321,-0.0885207,0.965926]] call InitStruct; 
['DirtCraterLong',[4081.28,4011.25,8.18492,true],135.954,[0.260379,-0.00659992,0.965484]] call InitStruct; 
['DirtCraterLong',[4073.83,4014.43,8.57034,true],20.0837,[-0.0145697,0.0271876,0.999524]] call InitStruct; 
['SmallStoneRoad',[4066.38,4017.65,8.96612,true],347,[-0.00658753,-0.00258136,0.999975]] call InitStruct; 
['SmallStoneRoad',[4068.57,4014.23,8.97556,true],311.001,[-0.00381412,-0.00595258,0.999975]] call InitStruct; 
['SmallStoneRoad',[4065.87,4021.79,8.96122,true],352,[-0.00678747,-0.0019982,0.999975]] call InitStruct; 
['SmallStoneRoad',[4065.66,4026.89,9.8884,true],0,[0,-0.258819,0.965926]] call InitStruct; 
['SmallStoneRoad',[4065.53,4032.02,11.4901,true],0,[0,-0.422618,0.906308]] call InitStruct; 
['SmallStoneRoad',[4065.69,4036.26,13.4835,true],[0.173648,0.892539,0.416198],[0,-0.422618,0.906308]] call InitStruct; 
['SmallStoneRoad',[4066.73,4042.23,14.9767,true],6.99961,[-0.00658753,-0.00258136,0.999975]] call InitStruct; 
['BunchOfShit',[4065.8,4012.3,2.61972],85,[0,0,1]] call InitStruct; 
['BunchOfShit',[4071.08,4012.49,2.61421],85,[0,0,1]] call InitStruct; 
['BunchOfShit',[4075.93,4012.43,2.6831],265,[0,0,1]] call InitStruct; 
['Shovel',[4070.06,4009.2,9.35466,true],[0,0.258811,-0.965928],[0,0.965928,0.258811]] call InitItem; 
['Grave2',[4069.5,4007.75,4],85,[0,0,1]] call InitStruct; 
['OldTombstoneGrave',[4070.63,4016.75,4],15,[0,0,1]] call InitStruct; 
['Grave3',[4072.63,4008.2,4],90,[0,0,1]] call InitStruct; 
['Grave1',[4063.56,4008.1,3.875],95,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4072.63,4008.2,4],180,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4070.5,4016.63,4.125],15.0003,[0,0,1]] call InitStruct; 
['OldGraveFence3',[4076.13,4008.16,4.25],175,[0,0,1]] call InitStruct; 
['OldGraveFence2',[4069.5,4007.75,4],175,[0,0,1]] call InitStruct; 
['OldGraveFence2',[4074.13,4015.75,4],15.0003,[0,0,1]] call InitStruct; 
['OldGraveFence',[4063.57,4008.22,4],185,[0,0,1]] call InitStruct; 
['OldGraveFence',[4064.17,4016.6,4.125],265.001,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4065.98,4007.84,4],180,[0,0,1]] call InitStruct; 
['OldGraveFence4',[4064,4013.85,3.875],270.001,[0,0,1]] call InitStruct; 
['OldTombstone3',[4075.5,4007.28,4.125],175,[0,0,1]] call InitStruct; 
['OldTombstone',[4077,4007.28,4],0,[0,0,1]] call InitStruct; 
['OldTombstone2',[4072.63,4007.2,4],175,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[4067.13,4019.75,4],270,[0,0,1]] call InitStruct; 
['TinBigFence',[4063.38,4019.5,4.25],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4069.13,4019.75,4.25],175,[0,0,1]] call InitStruct; 
['MediumPileOfDirtAndStones',[4066.56,4004.52,10.3943,true],0.176103,[-0.00597826,0.42115,0.906971]] call InitStruct; 
['MediumPileOfDirtAndStones',[4073.76,4004.79,9.91045,true],0.176103,[-0.00597826,0.42115,0.906971]] call InitStruct; 
['MediumPileOfDirtAndStones',[4060.5,4010.12,10.4058,true],[0.906991,-0.00278756,-0.42114],[0.421149,0.00597987,0.906972]] call InitStruct; 
['MediumPileOfDirtAndStones',[4060.98,4018.94,9.90755,true],[0.903297,-0.0818265,-0.42114],[0.420067,-0.0307482,0.906972]] call InitStruct; 
['TreeRoots',[4079.55,4007.52,10.8117,true],0,[0.173648,0,0.984808]] call InitStruct; 
['TreeRootsNoGeom',[4085.36,4014.84,14.1026,true],[-0.540973,0.836518,0.0870975],[-0.25,-0.258818,0.933013]] call InitStruct; 
['SmallDirtBrown',[4075.31,4010.73,8.23572,true],[0.977892,0.190809,0.0855545],[-0.0871557,0,0.996195]] call InitStruct; 
['Grave4',[4065.98,4007.71,9.09687,true],180,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['Tumannik',[4086.71,4007.46,7.88833,true],[-0.286553,0.769942,-0.570154],[-0.751697,0.188287,0.63206]] call InitItem; 
['Tumannik',[4083.15,4014.07,8.85967,true],[0.0466238,0.844885,0.532912],[0.152036,-0.533279,0.832165]] call InitItem; 
['Meatflower',[4066.07,4007.81,9.83327,true],[0.341282,0.937665,-0.0656632],[0.104027,0.0317503,0.994068]] call InitItem; 
['TreeRoots1',[4062.1,4012,2.3371],255,[0,0,1]] call InitStruct; 
['Candle',[4072.59,4007.97,4.38545],0,[0,0,1]] call InitItem; 
['Candle',[4069.51,4007.76,9.42766,true],0,[-0.0154596,-0.00693025,0.999856]] call InitItem; 
['Candle',[4063.6,4007.91,9.29364,true],0,[0.00566271,-0.00693096,0.99996]] call InitItem; 
['Candle',[4070.49,4016.43,4.45],0,[0,0,1]] call InitItem; 
['Wicket',[4066.25,4019.53,4.25],90.0003,[0,0,1]] call InitStruct; 
['TreeRoots2',[4065.54,4020.42,2.13441],180,[0,0,1]] call InitStruct; 
['DirtCraterLong',[4069.26,4009.62,8.47271,true],180,[0.00658776,0.00161472,0.999977]] call InitStruct; 
_4067_068124035_003667_90813 = ['IStruct',[4067.07,4035,12.6549,true],[-0.258819,0.933013,0.249999],[0,-0.258818,0.965926], {_thisObj setvariable ['model','ca\structures\ruins\rubble_wood_02.p3d'];}] call InitStruct; // !!! realocated model !!!
_4063_955574027_854745_28749 = ['IStruct',[4063.96,4027.85,10.3144,true],[0.996195,0.084186,0.0225576],[0,-0.258819,0.965926], {_thisObj setvariable ['model','ca\structures\ruins\rubble_concrete_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4081_072514014_457524_32827 = ['IStruct',[4081.07,4014.46,4.32827],265,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_metal_plates_04.p3d'];}] call InitStruct; // !!! realocated model !!!
_4064_415774039_980719_63173 = ['IStruct',[4064.42,4039.98,9.63173],250,[0,0,1], {_thisObj setvariable ['model','ca\structures\ruins\rubble_metal_plates_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4087_000004011_00000_3_00000 = ['EffectAsStruct',[4087,4011,-3],0,[0,0,1]] call InitStruct; // Effect
['BrickThinWallDoorwayWindow',[4068.5,4053.38,9.9903],0,[0,0,1]] call InitStruct; 
_4069_708984053_218999_74378 = ['SteelGreenDoor',[4069.71,4053.22,9.74378],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4067.53,4057.32,10.0723],270,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4069.11,4057.32,10.0716],270,[0,0,1]] call InitStruct; 
_4067_299804053_3750011_48151 = ['IStruct',[4067.3,4053.38,16.488,true],[-0.996774,-0.0802532,-5.29794e-006],[-0.0802519,0.996759,-0.00565548], {_thisObj setvariable ['model','metro_ob\model\l19_cell_type_03.p3d'];}] call InitStruct; // !!! realocated model !!!
_4066_140634057_173349_99014 = ['IStruct',[4066.14,4057.17,16.2694,true],180,[0.00699259,0.00103492,0.999975], {_thisObj setvariable ['model','ml\ml_object_new\model_24\shkafik.p3d'];}] call InitStruct; // !!! realocated model !!!
_4067_344484054_055669_90783 = ['IStruct',[4067.34,4054.06,9.90783],90.0006,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\stolik.p3d'];}] call InitStruct; // !!! realocated model !!!
['DoubleArmyBed',[4070.91,4056.78,15.1048,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['SmallChair',[4067.14,4054.85,10.0274],0,[0,0,1]] call InitItem; 
_4068_585944055_1311012_67509 = ['IStruct',[4068.59,4055.13,17.976,true],[-4.37114e-008,6.71544e-007,1],[-1,0,-4.37114e-008], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWall',[4071.63,4056.23,10],270,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[4176.88,3985,0],0,[0,0,1], {go_editor_globalRefs set ["SquareWoodenBox",_thisObj];
}] call InitStruct; 
['OfficeCabinet',[4150,3984.63,0],0,[0,0,1]] call InitStruct; 
['WoodenMedicalBox',[4191.13,3984.88,0],180,[0,0,1]] call InitStruct; 
['WoodenWeaponBox',[4195,3984.75,0],180,[0,0,1]] call InitStruct; 
['LargeClothCabinet',[4163.5,3984.88,0],0,[0,0,1]] call InitStruct; 
['Bookcase',[4145.25,3984.63,0],0,[0,0,1]] call InitStruct; 
['ContainerGreen3',[4182.88,3984.75,0],180,[0,0,1]] call InitStruct; 
['RedSteelBox',[4186.88,3984.63,0],0,[0,0,1]] call InitStruct; 
['BoardWoodenBox',[4180,3984.75,0],270,[0,0,1]] call InitStruct; 
['ContainerGreen4',[4184.25,3984.75,0],90.0004,[0,0,1]] call InitStruct; 
['BigClothCabinetNew',[4167.75,3984.88,0],0,[0,0,1]] call InitStruct; 
['CaseBedroomSmall',[4160.13,3984.75,0],270,[0,0,1]] call InitStruct; 
['CaseBedroom',[4158.88,3984.88,0],270,[0,0,1]] call InitStruct; 
['ClothCabinet',[4167.25,3984.88,1.375],180,[0,0,1]] call InitStruct; 
['ChestCabinet',[4157.63,3984.75,0],270,[0,0,1]] call InitStruct; 
['SmallBookcase',[4148.88,3984.63,0],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4147.38,3984.63,0],270,[0,0,1]] call InitStruct; 
['LuxuryCabinet',[4154.75,3984.5,0],180,[0,0,1]] call InitStruct; 
['WallmountedMedicalCabinet',[4192.5,3985.13,0],0,[0,0,1]] call InitStruct; 
['SteelBlueCase',[4171.88,3984.75,0],0,[0,0,1]] call InitStruct; 
['SmallTrashCan',[4200.75,3984.75,0],90,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[4171,3984.75,0],90,[0,0,1]] call InitStruct; 
['TrashCan',[4201.38,3984.63,0],90,[0,0,1]] call InitStruct; 
['ContainerGreen',[4172.75,3984.75,0],90,[0,0,1]] call InitStruct; 
['OldWoodenBox',[4178.13,3984.5,0],0,[0,0,1]] call InitStruct; 
['BigClothCabinet',[4165,3984.88,0],0,[0,0,1]] call InitStruct; 
['ContainerGreen2',[4185.63,3984.75,0],2.56132e-006,[0,0,1]] call InitStruct; 
['CaseBedroomMedium',[4159.5,3984.75,0],180,[0,0,1]] call InitStruct; 
['LongWeaponContainer',[4196.89,3984.88,0],0,[0,0,1]] call InitStruct; 



if (!isNil'_4045_515144022_7897910_15535') then {
	_4045_515144022_7897910_15535 setvariable ['name',"Умывальник"];
	_4045_515144022_7897910_15535 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4043_248294022_4292010_15535') then {
	_4043_248294022_4292010_15535 setvariable ['name',"Умывальник"];
	_4043_248294022_4292010_15535 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4043_284424023_7231410_15535') then {
	_4043_284424023_7231410_15535 setvariable ['name',"Умывальник"];
	_4043_284424023_7231410_15535 setvariable ['desc',"Тут люди моют руки и много чего еще"];
};
if (!isNil'_4044_447754020_6936011_23363') then {
	_4044_447754020_6936011_23363 setvariable ['name',"Мытьё"];
	_4044_447754020_6936011_23363 setvariable ['desc',"Так сделано, что сверху течёт струя прямо на голову"];
};
if (!isNil'_4017_911874028_2924811_54493') then {
	[_4017_911874028_2924811_54493,'Kastrula',1,100] call (_4017_911874028_2924811_54493 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_911874028_2924811_54493,'GlassBottle',1,100] call (_4017_911874028_2924811_54493 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4017_999274026_593519_98490') then {
	[_4017_999274026_593519_98490,'WoodenCup',2,100] call (_4017_999274026_593519_98490 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_593519_98490,'Cup',1,100] call (_4017_999274026_593519_98490 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_593519_98490,'MetalCup',1,100] call (_4017_999274026_593519_98490 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_999274026_593519_98490,'OlderWoodenCup',2,100] call (_4017_999274026_593519_98490 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4018_009774025_542729_96996') then {
	[_4018_009774025_542729_96996,'Rag',1,100] call (_4018_009774025_542729_96996 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_009774025_542729_96996,'CuttingBoard',1,100] call (_4018_009774025_542729_96996 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4018_027594027_522719_99531') then {
	[_4018_027594027_522719_99531,'MatchBox',1,100] call (_4018_027594027_522719_99531 getvariable 'proto' getvariable 'createItemInContainer');
	[_4018_027594027_522719_99531,'Polovnik',1,100] call (_4018_027594027_522719_99531 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4026_811774028_2036110_95566') then {
	[_4026_811774028_2036110_95566,'Rag',3,100] call (_4026_811774028_2036110_95566 getvariable 'proto' getvariable 'createItemInContainer');
	[_4026_811774028_2036110_95566,'CetalinBox',1,100] call (_4026_811774028_2036110_95566 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4017_960214028_317639_99137') then {
	[_4017_960214028_317639_99137,'GlassLargeBowl',1,100] call (_4017_960214028_317639_99137 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_317639_99137,'Mug',1,100] call (_4017_960214028_317639_99137 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_317639_99137,'GlassGoblet',1,100] call (_4017_960214028_317639_99137 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_317639_99137,'SoupPlate',4,100] call (_4017_960214028_317639_99137 getvariable 'proto' getvariable 'createItemInContainer');
	[_4017_960214028_317639_99137,'FoodPlate',5,100] call (_4017_960214028_317639_99137 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4037_618654032_218759_84451') then {
	_4037_618654032_218759_84451 setvariable ['name',"Камин"];
	_4037_618654032_218759_84451 setvariable ['desc',"Тепло и уютно согревает комнату, на огонь приятно смотреть"];
};
if (!isNil'_4044_608404034_8510710_04595') then {
	_4044_608404034_8510710_04595 setvariable ['name',"Металлолом"];
	_4044_608404034_8510710_04595 setvariable ['desc',"Можно бы было сдать, да не утащить.."];
};
if (!isNil'_4029_571534030_3750010_50000') then {
	[_4029_571534030_3750010_50000,'Key',2,100,[["var","name","Ключ от кухни"],["var","preinit@__keytypesstr","KitchenDorm"]]] call (_4029_571534030_3750010_50000 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750010_50000,'Key',2,100,[["var","name","Ключ от туалетов"],["var","preinit@__keytypesstr","SortirDorm"]]] call (_4029_571534030_3750010_50000 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750010_50000,'Key',2,100,[["var","name","Ключ от подсобки"],["var","preinit@__keytypesstr","PodsobDorm"]]] call (_4029_571534030_3750010_50000 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750010_50000,'Key',2,100,[["var","name","Площадка"],["var","preinit@__keytypesstr","PloshadkaDorm"]]] call (_4029_571534030_3750010_50000 getvariable 'proto' getvariable 'createItemInContainer');
	[_4029_571534030_3750010_50000,'Key',2,100,[["var","name","Ключ от комнаты 201"],["var","preinit@__keytypesstr","key201"]]] call (_4029_571534030_3750010_50000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4032_423834032_4235810_38512') then {
	[_4032_423834032_4235810_38512,'Bandage',1,100] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'Bandage',1,50] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'Rag',1,100] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'NeedleWithThreads',1,100] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'NeedleWithThreads',1,50] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'CetalinBox',1,100] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
	[_4032_423834032_4235810_38512,'KoradizinBox',1,100] call (_4032_423834032_4235810_38512 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4045_883304034_7033714_16785') then {
	_4045_883304034_7033714_16785 setvariable ['desc',"Важные звяковые документы с фабрики"];
};
if (!isNil'_4037_090334021_7871110_83532') then {
	[_4037_090334021_7871110_83532,'Key',1,100,[["var","name","Дубликат ключа от комнаты 202"],["var","preinit@__keytypesstr","RCherDormKey"]]] call (_4037_090334021_7871110_83532 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871110_83532,'Key',1,100,[["var","name","Дубликат ключа от комнаты 203"],["var","preinit@__keytypesstr","RCexDormKey"]]] call (_4037_090334021_7871110_83532 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871110_83532,'Key',1,100,[["var","name","Дубликат ключа от комнаты 204"],["var","preinit@__keytypesstr","RSlesarDormKey"]]] call (_4037_090334021_7871110_83532 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871110_83532,'Key',1,100,[["var","name","Ключ от комнаты 205"],["var","desc","Колдырь потерял его по пьяни"],["var","preinit@__keytypesstr","RKoldyrDormKey"]]] call (_4037_090334021_7871110_83532 getvariable 'proto' getvariable 'createItemInContainer');
	[_4037_090334021_7871110_83532,'Key',1,100,[["var","name","Дубликат ключа от комнаты 206"],["var","preinit@__keytypesstr","RMolDormKey"]]] call (_4037_090334021_7871110_83532 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4027_207034034_2902813_04602') then {
	_4027_207034034_2902813_04602 setvariable ['initialcategory',"milk"];
};
if (!isNil'_4027_194094032_9877913_04602') then {
	_4027_194094032_9877913_04602 setvariable ['initialcategory',"food"];
};
if (!isNil'_4039_493414029_6389213_85558') then {
	[_4039_493414029_6389213_85558,go_editor_globalRefs get "StationSpeaker G:Q54X59FAgzQ"] call (_4039_493414029_6389213_85558 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4034_250004029_3750013_00000') then {
	_4034_250004029_3750013_00000 setvariable ['desc',"Комната 205"];
};
if (!isNil'_4040_250004029_3750013_00000') then {
	_4040_250004029_3750013_00000 setvariable ['desc',"Комната 204"];
	_4040_250004029_3750013_00000 setvariable ['islocked',true];
};
if (!isNil'_4044_750004025_6250010_12500') then {
	_4044_750004025_6250010_12500 setvariable ['desc',"Умывальная"];
};
if (!isNil'_4047_125004025_6250010_12500') then {
	_4047_125004025_6250010_12500 setvariable ['desc',"Туалет"];
};
if (!isNil'_4049_000004021_5000010_12500') then {
	_4049_000004021_5000010_12500 setvariable ['desc',"Запасный выход"];
	_4049_000004021_5000010_12500 setvariable ['islocked',true];
};
if (!isNil'_4032_871834031_1250010_00000') then {
	_4032_871834031_1250010_00000 setvariable ['desc',"Кабинет 101"];
	_4032_871834031_1250010_00000 setvariable ['islocked',true];
};
if (!isNil'_4026_375004033_3750010_00000') then {
	_4026_375004033_3750010_00000 setvariable ['desc',"Запасный выход"];
	_4026_375004033_3750010_00000 setvariable ['islocked',true];
};
if (!isNil'_4038_500004025_6250013_00000') then {
	_4038_500004025_6250013_00000 setvariable ['desc',"Комната 201"];
	_4038_500004025_6250013_00000 setvariable ['islocked',true];
};
if (!isNil'_4044_750004025_6250013_00000') then {
	_4044_750004025_6250013_00000 setvariable ['desc',"Комната 202"];
	_4044_750004025_6250013_00000 setvariable ['islocked',true];
};
if (!isNil'_4026_625004027_3750010_00000') then {
	_4026_625004027_3750010_00000 setvariable ['desc',"Кухня"];
};
if (!isNil'_4025_625004023_3750010_00000') then {
	_4025_625004023_3750010_00000 setvariable ['islocked',true];
};
if (!isNil'_4026_625004021_7500010_12500') then {
	_4026_625004021_7500010_12500 setvariable ['islocked',true];
};
if (!isNil'_4047_125004029_3750013_00000') then {
	_4047_125004029_3750013_00000 setvariable ['desc',"Комната 203"];
	_4047_125004029_3750013_00000 setvariable ['islocked',true];
};
if (!isNil'_4038_500004025_6250010_00000') then {
	_4038_500004025_6250010_00000 setvariable ['desc',"Кабинет 102"];
	_4038_500004025_6250010_00000 setvariable ['islocked',true];
};
if (!isNil'_4041_039794028_960949_97046') then {
	_4041_039794028_960949_97046 setvariable ['desc',"Комната отдыха"];
};
if (!isNil'_4026_375004027_5000013_00000') then {
	_4026_375004027_5000013_00000 setvariable ['desc',"Выход на террасу"];
	_4026_375004027_5000013_00000 setvariable ['islocked',true];
};
if (!isNil'_4018_500004029_2500013_12500') then {
	_4018_500004029_2500013_12500 setvariable ['islocked',true];
};
if (!isNil'_4028_250004029_3750013_00000') then {
	_4028_250004029_3750013_00000 setvariable ['desc',"Комната 206"];
	_4028_250004029_3750013_00000 setvariable ['islocked',true];
};
if (!isNil'_4034_987794035_302499_87321') then {
	_4034_987794035_302499_87321 setvariable ['name',"Такая дверь"];
	_4034_987794035_302499_87321 setvariable ['desc',"23 звяка, 3 цикла, 8-й смены, 28-го плана смена рождения. 8-й смены, 8-го плана в конце смены сгнила. Ебаный врот."];
	_4034_987794035_302499_87321 setvariable ['islocked',true];
};
if (!isNil'_4007_750004056_3750014_00003') then {
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:fLGwpoBP83c"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:zx+c4iKzc5g"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:hGnHa7kTbEk"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:OpthpYcZ5Z4"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:umbpX/vnAss"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:HVC4/Ag7eck"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:kWu++T5dkiI"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:1V9pkcdGJ9Q"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
	[_4007_750004056_3750014_00003,go_editor_globalRefs get "Tumbler G:EWMj6vlYuZw"] call (_4007_750004056_3750014_00003 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4048_045654025_4414111_46157') then {
	[_4048_045654025_4414111_46157,go_editor_globalRefs get "LampCeiling G:eqHk+Uz0nZA"] call (_4048_045654025_4414111_46157 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4045_530524025_4428711_51128') then {
	[_4045_530524025_4428711_51128,go_editor_globalRefs get "LampCeiling G:eqHk+Uz0nZA (1)"] call (_4045_530524025_4428711_51128 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4037_568854025_4506811_36210') then {
	[_4037_568854025_4506811_36210,go_editor_globalRefs get "LampCeiling G:dBf4oFHbP2I"] call (_4037_568854025_4506811_36210 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4042_000004029_2993211_28420') then {
	[_4042_000004029_2993211_28420,go_editor_globalRefs get "LampCeiling G:3WTP9DQ1sKw"] call (_4042_000004029_2993211_28420 getvariable 'proto' getvariable 'addConnection');
	[_4042_000004029_2993211_28420,go_editor_globalRefs get "LampCeiling G:6MHQBqtjCTs"] call (_4042_000004029_2993211_28420 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4048_632324027_5000010_61778') then {
	_4048_632324027_5000010_61778 setvariable ['name',"Первый этаж. Левое крыло."];
	[_4048_632324027_5000010_61778,go_editor_globalRefs get "RedButton G:Y6ExyGIEWaY"] call (_4048_632324027_5000010_61778 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000010_61778,go_editor_globalRefs get "RedButton G:KDFGox8N8IQ"] call (_4048_632324027_5000010_61778 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000010_61778,go_editor_globalRefs get "RedButton G:Xh2Q/W2FGcg"] call (_4048_632324027_5000010_61778 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000010_61778,go_editor_globalRefs get "RedButton G:WGtGrZZEY8w"] call (_4048_632324027_5000010_61778 getvariable 'proto' getvariable 'addConnection');
	[_4048_632324027_5000010_61778,go_editor_globalRefs get "RedButton G:TaTtSnTBX9c"] call (_4048_632324027_5000010_61778 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4016_060794021_374769_98744') then {
	_4016_060794021_374769_98744 setvariable ['name',"Уличное освещение."];
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:PtjQNHBBpAQ"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:4Ns/ZphJWgo"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:JobENx7FvpM"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:FjPul73CNac"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (1)"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:PtjQNHBBpAQ (1)"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (5)"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (2)"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (4)"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
	[_4016_060794021_374769_98744,go_editor_globalRefs get "StreetLamp G:zVA/rLuMkaA"] call (_4016_060794021_374769_98744 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4037_375004028_9318811_51462') then {
	[_4037_375004028_9318811_51462,go_editor_globalRefs get "LampCeiling G:zuAmqwZUMgw"] call (_4037_375004028_9318811_51462 getvariable 'proto' getvariable 'addConnection');
	[_4037_375004028_9318811_51462,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (1)"] call (_4037_375004028_9318811_51462 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4032_815924032_0000011_66473') then {
	[_4032_815924032_0000011_66473,go_editor_globalRefs get "LampCeiling G:qlQj1u5GQKs"] call (_4032_815924032_0000011_66473 getvariable 'proto' getvariable 'addConnection');
	[_4032_815924032_0000011_66473,go_editor_globalRefs get "LampCeiling G:DwTizfFKITc"] call (_4032_815924032_0000011_66473 getvariable 'proto' getvariable 'addConnection');
	[_4032_815924032_0000011_66473,go_editor_globalRefs get "LampCeiling G:NjkDlY9gWRQ"] call (_4032_815924032_0000011_66473 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4032_817144032_2802711_66430') then {
	[_4032_817144032_2802711_66430,go_editor_globalRefs get "LampCeiling G:jbNZsX9IGL8"] call (_4032_817144032_2802711_66430 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4046_375004029_5481014_55445') then {
	[_4046_375004029_5481014_55445,go_editor_globalRefs get "LampCeiling G:Kq7SLbsTC+k"] call (_4046_375004029_5481014_55445 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4041_150884029_5671414_37045') then {
	[_4041_150884029_5671414_37045,go_editor_globalRefs get "LampCeiling G:cBClC1cJFO0"] call (_4041_150884029_5671414_37045 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4035_125004029_5617714_53420') then {
	[_4035_125004029_5617714_53420,go_editor_globalRefs get "LampCeiling G:6DmKSV7k0vk"] call (_4035_125004029_5617714_53420 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4027_482424029_5642114_40920') then {
	[_4027_482424029_5642114_40920,go_editor_globalRefs get "LampCeiling G:YK+y03D0B3c"] call (_4027_482424029_5642114_40920 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4036_982184025_8139614_54855') then {
	[_4036_982184025_8139614_54855,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (2)"] call (_4036_982184025_8139614_54855 getvariable 'proto' getvariable 'addConnection');
	[_4036_982184025_8139614_54855,go_editor_globalRefs get "LampCeiling G:V/ojCDc8RhU"] call (_4036_982184025_8139614_54855 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4033_625004023_5000014_53420') then {
	[_4033_625004023_5000014_53420,go_editor_globalRefs get "LampCeiling G:RzZuM8b6yYs"] call (_4033_625004023_5000014_53420 getvariable 'proto' getvariable 'addConnection');
	[_4033_625004023_5000014_53420,go_editor_globalRefs get "LampCeiling G:OxG+WAr+YSE (4)"] call (_4033_625004023_5000014_53420 getvariable 'proto' getvariable 'addConnection');
	[_4033_625004023_5000014_53420,go_editor_globalRefs get "LampCeiling G:nIWIk6czRII"] call (_4033_625004023_5000014_53420 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4026_452394026_6794411_47483') then {
	[_4026_452394026_6794411_47483,go_editor_globalRefs get "LampCeiling G:S5mD+ipln0g"] call (_4026_452394026_6794411_47483 getvariable 'proto' getvariable 'addConnection');
	[_4026_452394026_6794411_47483,go_editor_globalRefs get "LampCeiling G:BQuGl8InN4c"] call (_4026_452394026_6794411_47483 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4026_437994022_4606911_22338') then {
	[_4026_437994022_4606911_22338,go_editor_globalRefs get "LampCeiling G:WmdD2F4ypQg"] call (_4026_437994022_4606911_22338 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4034_375004032_1250015_91751') then {
	_4034_375004032_1250015_91751 setvariable ['edisenabled',false];
};
if (!isNil'_4027_875004023_7500010_62500') then {
	_4027_875004023_7500010_62500 setvariable ['name',"Первый этаж. Входная группа."];
	[_4027_875004023_7500010_62500,go_editor_globalRefs get "RedButton G:/bk1HSzuyiI"] call (_4027_875004023_7500010_62500 getvariable 'proto' getvariable 'addConnection');
	[_4027_875004023_7500010_62500,go_editor_globalRefs get "RedButton G:ji1Yi/feNFc"] call (_4027_875004023_7500010_62500 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4047_835454025_9511713_81793') then {
	_4047_835454025_9511713_81793 setvariable ['name',"Второй этаж. Левое крыло."];
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "RedButton G:HfqsSe3iRaU"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "RedButton G:AjebpdJbUNU"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "RedButton G:bd1e0L0glps"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "RedButton G:QtralcJPWoA"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "RedButton G:8n4vmOZcVYg"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
	[_4047_835454025_9511713_81793,go_editor_globalRefs get "Intercom G:4/wwqSRELj8"] call (_4047_835454025_9511713_81793 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4024_226814021_5002410_70123') then {
	_4024_226814021_5002410_70123 setvariable ['name',"Первый этаж. Правое крыло. Кухня."];
	[_4024_226814021_5002410_70123,go_editor_globalRefs get "RedButton G:zbXUtKxPtFc"] call (_4024_226814021_5002410_70123 getvariable 'proto' getvariable 'addConnection');
	[_4024_226814021_5002410_70123,go_editor_globalRefs get "RedButton G:QhdIXJ0UnDY"] call (_4024_226814021_5002410_70123 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4028_875004020_2500013_75000') then {
	_4028_875004020_2500013_75000 setvariable ['name',"Второй этаж. Правое крыло."];
	[_4028_875004020_2500013_75000,go_editor_globalRefs get "RedButton G:IFPkvF5Dt4w"] call (_4028_875004020_2500013_75000 getvariable 'proto' getvariable 'addConnection');
	[_4028_875004020_2500013_75000,go_editor_globalRefs get "RedButton G:iw44gmmN2Mo"] call (_4028_875004020_2500013_75000 getvariable 'proto' getvariable 'addConnection');
	[_4028_875004020_2500013_75000,go_editor_globalRefs get "RedButton G:mIC0aid4Ae8"] call (_4028_875004020_2500013_75000 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_186044056_9160216_34257') then {
	_4004_186044056_9160216_34257 setvariable ['name',"Первый этаж. Входная группа."];
	[_4004_186044056_9160216_34257,go_editor_globalRefs get "ElectricalShieldSmall G:l2Y+w3c5mwI"] call (_4004_186044056_9160216_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_686044056_9160216_34257') then {
	_4004_686044056_9160216_34257 setvariable ['name',"Первый этаж. Правое крыло. Кухня."];
	[_4004_686044056_9160216_34257,go_editor_globalRefs get "ElectricalShieldSmall G:5tPSYWljSTo"] call (_4004_686044056_9160216_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160215_34257') then {
	_4003_686044056_9160215_34257 setvariable ['name',"Уличное освещение."];
	[_4003_686044056_9160215_34257,go_editor_globalRefs get "ElectricalShield G:BR05v5D45ZA"] call (_4003_686044056_9160215_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4004_186044056_9160215_84257') then {
	_4004_186044056_9160215_84257 setvariable ['name',"Второй этаж. Правое крыло."];
	[_4004_186044056_9160215_84257,go_editor_globalRefs get "ElectricalShieldSmall G:aNkEhGxpPYY"] call (_4004_186044056_9160215_84257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160215_84257') then {
	_4003_686044056_9160215_84257 setvariable ['name',"Второй этаж. Левое крыло."];
	[_4003_686044056_9160215_84257,go_editor_globalRefs get "ElectricalShieldSmall G:y2vQzELsluA"] call (_4003_686044056_9160215_84257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160216_34257') then {
	_4003_686044056_9160216_34257 setvariable ['name',"Первый этаж. Левое крыло."];
	[_4003_686044056_9160216_34257,go_editor_globalRefs get "ElectricalShieldSmall G:D4hhxFJEMKM"] call (_4003_686044056_9160216_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4003_686044056_9160214_84257') then {
	_4003_686044056_9160214_84257 setvariable ['name',"Верхотура"];
	[_4003_686044056_9160214_84257,go_editor_globalRefs get "ElectricalShield G:aL5OTxyNxco"] call (_4003_686044056_9160214_84257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4039_237064025_4521514_48086') then {
	[_4039_237064025_4521514_48086,go_editor_globalRefs get "LampCeiling G:GhyA0/mPKB8"] call (_4039_237064025_4521514_48086 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4011_000004055_7500014_10840') then {
	_4011_000004055_7500014_10840 setvariable ['name',"Генераторная"];
	[_4011_000004055_7500014_10840,go_editor_globalRefs get "RedButton G:2Y5XzDeSbnc"] call (_4011_000004055_7500014_10840 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4017_170414051_3002915_40258') then {
	[_4017_170414051_3002915_40258,go_editor_globalRefs get "LampCeiling G:ZtPLJzG0HNM"] call (_4017_170414051_3002915_40258 getvariable 'proto' getvariable 'addConnection');
	[_4017_170414051_3002915_40258,go_editor_globalRefs get "LampCeiling G:6Hk0pG2LyqI"] call (_4017_170414051_3002915_40258 getvariable 'proto' getvariable 'addConnection');
	[_4017_170414051_3002915_40258,go_editor_globalRefs get "LampCeiling G:g7G/XnsBC9A"] call (_4017_170414051_3002915_40258 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4005_186044056_9160215_34257') then {
	_4005_186044056_9160215_34257 setvariable ['name',"Ларёк"];
	[_4005_186044056_9160215_34257,go_editor_globalRefs get "ElectricalShieldSmall G:K+aD+A9Ny5s"] call (_4005_186044056_9160215_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4005_686044056_9160215_34257') then {
	_4005_686044056_9160215_34257 setvariable ['name',"Генераторная"];
	[_4005_686044056_9160215_34257,go_editor_globalRefs get "ElectricalShield G:+luUbpyNzq4"] call (_4005_686044056_9160215_34257 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4000_000004037_5000014_67537') then {
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E (5)"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "StreetLamp G:TqKXQjapt4E (9)"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:SLKfMovNocM"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:DERdhpwI1BE"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:MOBhI0NCvxc"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:Q/wMdw65U8Y"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:SaqNZ03gHeU"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
	[_4000_000004037_5000014_67537,go_editor_globalRefs get "LampCeiling G:aTykogdJ1gU"] call (_4000_000004037_5000014_67537 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4068_316894067_0622611_43153') then {
	[_4068_316894067_0622611_43153,go_editor_globalRefs get "StreetLamp G:FjPul73CNac (3)"] call (_4068_316894067_0622611_43153 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4069_492924071_2988311_14536') then {
	[_4069_492924071_2988311_14536,go_editor_globalRefs get "RedButton G:iBr4jx3Wi0I"] call (_4069_492924071_2988311_14536 getvariable 'proto' getvariable 'addConnection');
	[_4069_492924071_2988311_14536,go_editor_globalRefs get "RedButton G:EXKORnjUGZM"] call (_4069_492924071_2988311_14536 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4067_558354068_1237811_49136') then {
	[_4067_558354068_1237811_49136,go_editor_globalRefs get "LampCeiling G:Tfyf2IaEkFM"] call (_4067_558354068_1237811_49136 getvariable 'proto' getvariable 'addConnection');
	[_4067_558354068_1237811_49136,go_editor_globalRefs get "LampCeiling G:RZhTnTC73d8"] call (_4067_558354068_1237811_49136 getvariable 'proto' getvariable 'addConnection');
	[_4067_558354068_1237811_49136,go_editor_globalRefs get "LampCeiling G:Tfyf2IaEkFM (1)"] call (_4067_558354068_1237811_49136 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4045_506104025_4533714_50724') then {
	[_4045_506104025_4533714_50724,go_editor_globalRefs get "LampCeiling G:KRZfyWUeOck"] call (_4045_506104025_4533714_50724 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4016_250004051_1250014_12500') then {
	_4016_250004051_1250014_12500 setvariable ['islocked',true];
};
if (!isNil'_4009_750004052_5000014_12500') then {
	_4009_750004052_5000014_12500 setvariable ['islocked',true];
};
if (!isNil'_4015_114264051_7805214_11853') then {
	[_4015_114264051_7805214_11853,'Tumannik',1,58] call (_4015_114264051_7805214_11853 getvariable 'proto' getvariable 'createItemInContainer');
	[_4015_114264051_7805214_11853,'Tumannik',1,100] call (_4015_114264051_7805214_11853 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4010_793464054_4775413_97707') then {
	[_4010_793464054_4775413_97707,'Tumannik',1,100] call (_4010_793464054_4775413_97707 getvariable 'proto' getvariable 'createItemInContainer');
	[_4010_793464054_4775413_97707,'Tumannik',1,29] call (_4010_793464054_4775413_97707 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_4035_132574042_8337410_08330') then {
	_4035_132574042_8337410_08330 setvariable ['name',"Статуя"];
	_4035_132574042_8337410_08330 setvariable ['desc',"Первой швее на фабрике"];
};
if (!isNil'_4069_080574066_875009_92994') then {
	_4069_080574066_875009_92994 setvariable ['islocked',true];
};
if (!isNil'_4067_756104068_9772910_00000') then {
	_4067_756104068_9772910_00000 setvariable ['islocked',true];
};
if (!isNil'_4062_497074067_1679711_57018') then {
	_4062_497074067_1679711_57018 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4066_442634067_1804211_12250') then {
	_4066_442634067_1804211_12250 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4066_913824067_1801811_57013') then {
	_4066_913824067_1801811_57013 setvariable ['name',"Серое пиво"];
};
if (!isNil'_4063_653324072_1203610_99500') then {
	_4063_653324072_1203610_99500 setvariable ['name',"Ручка без стержня"];
};
if (!isNil'_4005_875004027_3750015_25000') then {
	_4005_875004027_3750015_25000 setvariable ['islocked',true];
};
if (!isNil'_4005_194584033_4079614_97966') then {
	_4005_194584033_4079614_97966 setvariable ['islocked',true];
};
if (!isNil'_4008_528814022_6792015_21523') then {
	_4008_528814022_6792015_21523 setvariable ['spawnpointname',"RPriyatelDorm"];
};
if (!isNil'_4007_289314036_3161614_99307') then {
	_4007_289314036_3161614_99307 setvariable ['spawnpointname',"RLekarDorm"];
};
if (!isNil'_4003_508544033_3056616_31373') then {
	[_4003_508544033_3056616_31373,'Bandage',2,100] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'Rag',1,100] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'Syringe',1,100] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'PainkillerBox',1,100] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'NeedleWithThreads',2,100] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'NeedleWithThreads',1,70] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
	[_4003_508544033_3056616_31373,'NeedleWithThreads',1,50] call (_4003_508544033_3056616_31373 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3974_669684030_6586916_32000') then {
	[_3974_669684030_6586916_32000,'HandcuffItem',1,100,[["var","keylockers","NaruchKey"]]] call (_3974_669684030_6586916_32000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3974_669684030_6586916_32000,'RopeItem',1,100] call (_3974_669684030_6586916_32000 getvariable 'proto' getvariable 'createItemInContainer');
	[_3974_669684030_6586916_32000,'Key',1,100,[["var","name","Ключ от наручников"],["var","preinit@__keytypesstr","NaruchKey"]]] call (_3974_669684030_6586916_32000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3977_916754034_9587417_78314') then {
	[_3977_916754034_9587417_78314,'Rag',2,100] call (_3977_916754034_9587417_78314 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587417_78314,'Bandage',2,100] call (_3977_916754034_9587417_78314 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587417_78314,'NeedleWithThreads',2,100] call (_3977_916754034_9587417_78314 getvariable 'proto' getvariable 'createItemInContainer');
	[_3977_916754034_9587417_78314,'PainkillerBox',1,100] call (_3977_916754034_9587417_78314 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3981_826424029_5366216_32000') then {
	_3981_826424029_5366216_32000 setvariable ['islocked',true];
};
if (!isNil'_3976_581054034_8132316_43925') then {
	_3976_581054034_8132316_43925 setvariable ['islocked',true];
};
if (!isNil'_3976_703864026_4978014_74382') then {
	_3976_703864026_4978014_74382 setvariable ['name',"Длинный ящик"];
	_3976_703864026_4978014_74382 setvariable ['desc',"Туда и человек влезет наверное"];
};
if (!isNil'_3981_222414032_2087420_15811') then {
	_3981_222414032_2087420_15811 setvariable ['name',"Мешочек c зубами"];
	_3981_222414032_2087420_15811 setvariable ['desc',"Можно сыграть и отлично провести время"];
	_3981_222414032_2087420_15811 setvariable ['countslots',16];
	[_3981_222414032_2087420_15811,'Tooth',16,100] call (_3981_222414032_2087420_15811 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3976_000004034_2500019_31000') then {
	[_3976_000004034_2500019_31000,'RopeItem',1,100] call (_3976_000004034_2500019_31000 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3979_621344034_0034219_29673') then {
	_3979_621344034_0034219_29673 setvariable ['name',"Дубликат ключа от участка"];
	_3979_621344034_0034219_29673 setvariable ['desc',"Если ты каким-то чудом его нашёл - молчи о нём и не говори никому!"];
};
if (!isNil'_3974_891364021_7397514_77565') then {
	_3974_891364021_7397514_77565 setvariable ['name',"Сортир"];
	_3974_891364021_7397514_77565 setvariable ['desc',"Обыкновенный уличный сортир"];
};
if (!isNil'_3980_522714022_0053714_74117') then {
	_3980_522714022_0053714_74117 setvariable ['desc',"Замок стырен"];
};
if (!isNil'_3977_878424034_2717319_17873') then {
	_3977_878424034_2717319_17873 setvariable ['name',"Нужник"];
	_3977_878424034_2717319_17873 setvariable ['desc',"Все свои ""дела"" делать сюда, а потом вылить"];
};
if (!isNil'_3991_640634031_6001015_05929') then {
	_3991_640634031_6001015_05929 setvariable ['islocked',true];
};
if (!isNil'_4040_877934021_7102110_12500') then {
	_4040_877934021_7102110_12500 setvariable ['spawnpointname',"RZavZhil"];
};
if (!isNil'_4027_799074031_1333010_12609') then {
	_4027_799074031_1333010_12609 setvariable ['spawnpointname',"RKomendantDorm"];
};
if (!isNil'_4038_526864031_0869113_05776') then {
	_4038_526864031_0869113_05776 setvariable ['spawnpointname',"RSlesarDorm"];
};
if (!isNil'_4035_017334031_2895513_05776') then {
	_4035_017334031_2895513_05776 setvariable ['spawnpointname',"RKoldyrDorm"];
};
if (!isNil'_4030_096924033_0385713_07844') then {
	_4030_096924033_0385713_07844 setvariable ['spawnpointname',"RMolDorm"];
};
if (!isNil'_4046_051514032_9072313_05776') then {
	_4046_051514032_9072313_05776 setvariable ['spawnpointname',"RCexDorm"];
};
if (!isNil'_4046_945564022_4687513_15707') then {
	_4046_945564022_4687513_15707 setvariable ['spawnpointname',"RCherDorm0"];
};
if (!isNil'_4044_670654022_3674313_15576') then {
	_4044_670654022_3674313_15576 setvariable ['spawnpointname',"RCherDorm1"];
};
if (!isNil'_4065_510254070_0705610_18500') then {
	_4065_510254070_0705610_18500 setvariable ['spawnpointname',"RTorgDorm"];
};
if (!isNil'_3976_206544030_7785616_44883') then {
	_3976_206544030_7785616_44883 setvariable ['spawnpointname',"RUchastDorm"];
};
if (!isNil'_3990_947754035_8142115_09023') then {
	_3990_947754035_8142115_09023 setvariable ['spawnpointname',"RRostDorm"];
};
if (!isNil'_3995_703614035_9272515_09023') then {
	_3995_703614035_9272515_09023 setvariable ['spawnpointname',"RDolgDorm"];
};
if (!isNil'_3994_949224063_2680710_10172') then {
	_3994_949224063_2680710_10172 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3980_910644063_5080610_10054') then {
	_3980_910644063_5080610_10054 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3997_438724046_3418010_13051') then {
	_3997_438724046_3418010_13051 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4012_829594047_0022010_16958') then {
	_4012_829594047_0022010_16958 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4056_398684055_7150911_03584') then {
	_4056_398684055_7150911_03584 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4077_467534076_2241210_12971') then {
	_4077_467534076_2241210_12971 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4082_726324071_6984910_09816') then {
	_4082_726324071_6984910_09816 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_4075_615974070_1220710_18600') then {
	_4075_615974070_1220710_18600 setvariable ['spawnpointname',"RBrodDorm"];
};
if (!isNil'_3976_000004033_0000019_31000') then {
	_3976_000004033_0000019_31000 setvariable ['spawnpointname',"RUchastHelperDorm"];
};
if (!isNil'_4087_000004011_00000_3_00000') then {
	[_4087_000004011_00000_3_00000,"govnelin"] call (_4087_000004011_00000_3_00000 getvariable 'proto' getvariable 'setEffectType');
};
if (!isNil'_4069_708984053_218999_74378') then {
	_4069_708984053_218999_74378 setvariable ['islocked',true];
};
