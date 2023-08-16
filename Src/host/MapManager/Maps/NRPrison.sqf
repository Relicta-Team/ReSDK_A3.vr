__metaInfo__ = 'Builded on editor version: 1.8';__metaInfoVersion__ = 3;go_editor_globalRefs = createHashMap;

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

['BlockBrick',[4004.75,4009.06,14.8506],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3995.29,4008.88,14.811],0,[0,0,1]] call InitDecor; 
['BlockStone',[3995.48,4019.89,14.7376],0,[0,0,1]] call InitDecor; 
['BlockStone',[4009.46,4019.86,14.6763],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4012.35,4008.99,14.7894],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4023.12,4008.91,14.55],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4022.87,3998.35,14.5004],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4023.05,4019.67,14.6886],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3931.22,4041.44,14.2671],0,[0,0,1]] call InitDecor; 
['BlockStone',[4009.41,4031.03,14.7974],0,[0,0,1]] call InitDecor; 
['BlockStone',[3995.51,4030.51,14.63],0,[0,0,1]] call InitDecor; 
['IndustrialPipes',[4002.22,4015.86,0],0,[0,0,1]] call InitDecor; 
['IndustrialPipes',[4002.35,4028.21,0],0,[0,0,1]] call InitDecor; 
_4039_980713985_7009318_83356 = ['BigStoneWall',[4039.98,3985.7,36.9776,true],0,[-0.00659628,-0.0016196,0.999977], {_thisObj setvariable ['model','ca\structures\castle\a_castle_bergfrit_dam.p3d'];}] call InitDecor; // !!! realocated model !!!
['BigStoneWall',[4024.22,3993.38,27.4797,true],33.5351,[-0.00640633,0.00300423,0.999975]] call InitDecor; 
_4014_811284000_2524414_89744 = ['BigStoneWall',[4014.81,4000.25,25.9339,true],0.966382,[-0.00701606,-0.000911038,0.999975], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner.p3d'];}] call InitDecor; // !!! realocated model !!!
_4028_230713996_5144016_46206 = ['BetonWallMedium',[4028.23,3996.51,21.568,true],89.9997,[-0.000856065,0.00702388,0.999975], {_thisObj setvariable ['model','a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_216554002_5083016_44889 = ['BetonWallMedium',[4028.22,4002.51,21.5548,true],89.9997,[-0.000856065,0.00702388,0.999975], {_thisObj setvariable ['model','a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_219484008_4995116_51906 = ['BetonWallMedium',[4028.22,4008.5,21.625,true],89.9997,[-0.000856065,0.00702388,0.999975], {_thisObj setvariable ['model','a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_181404014_3852516_49940 = ['BetonWallMedium',[4028.18,4014.39,21.6053,true],89.9997,[-0.000856065,0.00702388,0.999975], {_thisObj setvariable ['model','a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4028_147464020_3664616_49079 = ['BetonWallMedium',[4028.15,4020.37,21.5967,true],89.9997,[-0.000856065,0.00702388,0.999975], {_thisObj setvariable ['model','a3\structures_f_exp\military\pillboxes\pillboxwall_01_6m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigStoneWall',[4016.01,4025.84,26.2872,true],90.6583,[-0.000954507,0.00701109,0.999975]] call InitDecor; 
_4031_506104026_3913616_33133 = ['BigStoneWall',[4031.51,4026.39,27.3678,true],180.946,[0.00700212,0.000917471,0.999975], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner.p3d'];}] call InitDecor; // !!! realocated model !!!
_4037_417974030_0327118_55561 = ['BigStoneWall',[4037.42,4030.03,36.6997,true],0,[-0.00659628,-0.0016196,0.999977], {_thisObj setvariable ['model','ca\structures\castle\a_castle_bergfrit_dam.p3d'];}] call InitDecor; // !!! realocated model !!!
_4027_587164027_7409724_72826 = ['BigStoneWall',[4027.59,4027.74,33.1967,true],183.359,[-0.00540806,0.00712654,0.99996], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_20_turn.p3d'];}] call InitDecor; // !!! realocated model !!!
['ConcreteArch',[4016.25,4008.82,14.6378],0,[0,0,1]] call InitDecor; 
['ConcreteArch',[3991.01,4008.96,14.7132],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4014.82,4006.4,36.7249,true],90.6583,[-0.000954507,0.00701109,0.999975]] call InitDecor; 
_4026_966314002_4555714_52096 = ['PowerGenerator',[4026.97,4002.46,20.1846,true],267.703,[-0.0246084,-0.0394964,0.998917], {go_editor_globalRefs set ['PowerGenerator G:6zjrUq/qWew',_thisObj];
}] call InitStruct; 
['LampWall',[4034.44,3992.99,21.9201],86.0245,[0,0,1], {go_editor_globalRefs set ['LampWall G:+WLVHg1VIhE',_thisObj];
}] call InitStruct; 
['LampWall',[4034.1,3992.77,21.9668],0,[0,0,1], {go_editor_globalRefs set ['LampWall G:4wwgg1i6mtk',_thisObj];
}] call InitStruct; 
['StreetLampEnabled',[4027.75,3994.24,14.5478],323.989,[0,0,1], {go_editor_globalRefs set ['StreetLampEnabled G:BDN+S1yZ/S0',_thisObj];
}] call InitStruct; 
['BrickThinWall',[4028.1,4028.11,14.7528],90,[0,0,1]] call InitStruct; 
['LampWall',[4029,4023.19,20.2708],270,[0,0,1], {go_editor_globalRefs set ['LampWall G:+WLVHg1VIhE (1)',_thisObj];
}] call InitStruct; 
['LampWall',[4031.05,4023.25,20.2811],270,[0,0,1], {go_editor_globalRefs set ['LampWall G:+WLVHg1VIhE (2)',_thisObj];
}] call InitStruct; 
['LampCeiling',[4020.22,4025.18,17.4296],0,[0,0,1], {go_editor_globalRefs set ['LampCeiling G:mFDepJIrQWg',_thisObj];
}] call InitStruct; 
['LampCeiling',[4019.87,4034.44,17.4147],0,[0,0,1], {go_editor_globalRefs set ['LampCeiling G:o1w1FH4lGDs',_thisObj];
}] call InitStruct; 
['LampCeiling',[4027.64,4024.8,17.3606],0,[0,0,1], {go_editor_globalRefs set ['LampCeiling G:N06+vnpJ0sw',_thisObj];
}] call InitStruct; 
['StreetLampEnabled',[4017.41,4013.74,14.5026],91.4082,[0,0,1], {go_editor_globalRefs set ['StreetLampEnabled G:BDN+S1yZ/S0 (1)',_thisObj];
}] call InitStruct; 
['StreetLampEnabled',[4017.5,4003.98,14.7664],78.1615,[0,0,1], {go_editor_globalRefs set ['StreetLampEnabled G:BDN+S1yZ/S0 (2)',_thisObj];
}] call InitStruct; 
['BrickThinWallWindow3',[4025.14,4025.25,14.673],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow',[4022.3,4028.42,14.7099],90,[0,0,1]] call InitStruct; 
['BrickThinWall',[4025.65,4036.28,14.7286],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4022.3,4034.09,14.7083],90,[0,0,1]] call InitStruct; 
['BrickThinWall',[4028.1,4034.02,14.7475],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4024.62,4036.93,18.6857],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4023.79,4053.61,18.5229],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4018.62,4049.81,18.7039],95.8784,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4028.74,4049.71,18.5775],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4028.75,4040.78,18.667],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4018.17,4040.92,18.6913],90,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4020.7,4036.27,14.7547],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[4024.28,4042.84,15.325],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4008.68,4015.07,18.2465],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4013.01,4019.7,18.2031],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4008.91,4021.47,18.241],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3996.08,4015.07,18.7046],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3996.27,4021.53,18.2345],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3991.46,4019.75,18.6514],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4008.95,4033.87,18.2365],8.72965,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4013.08,4028.54,18.2027],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3995.49,4034.12,18.5321],351.538,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3991.45,4028.66,18.6431],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4008.73,4027.92,18.184],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3996.22,4028.18,18.2483],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4020.91,4027.27,19.144],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4026.87,4027.41,19.1483],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4020.75,4033.27,19.1515],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4026.75,4033.4,19.1478],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4021.24,4028.05,14.2423],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4027.19,4028.19,14.2465],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4021.08,4034.05,14.2497],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4027.07,4034.17,14.2461],358.703,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4020.96,4039.94,14.2498],180,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4020.97,4045.89,14.2471],180,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4026.97,4040.08,14.2513],180,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4026.97,4045.91,14.2521],180,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4020.96,4051.89,14.2612],180,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[4026.97,4051.92,14.2606],180,[0,0,1]] call InitStruct; 
['LongShelf',[4025.96,4035.68,14.7511],0,[0,0,1]] call InitStruct; 
['LampKeroseneHolder',[4027.91,4028.64,14.7465],180,[0,0,1]] call InitStruct; 
['SurgeryBlueTable',[4027.39,4030.68,14.5893],88.4934,[0,0,1]] call InitStruct; 
['BlackSmallStove',[4026.38,4026.53,14.7515],90.4215,[0,0,1]] call InitStruct; 
['SmallStoveGrill',[4027.5,4026.47,14.5664],176.549,[0,0,1]] call InitStruct; 
['WoodenDoor',[4022.22,4035.29,14.5892],90.4444,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[4019.48,4036.37,14.4214],0,[0,0,1]] call InitStruct; 
['LampKerosene',[4027.06,4029.52,15.7496],0,[0,0,1]] call InitItem; 
['SquareWoodenBox',[4027.32,4032.78,14.733],0,[0,0,1]] call InitStruct; 
['InfoBoard',[4028.18,4024.18,15.8199],1.72197,[0,0,1]] call InitStruct; 
_4027_392584034_4382314_79724 = ['SewercoverBase',[4027.39,4034.44,14.7972],0,[0,0,1]] call InitStruct; 
['BigSteelGrating',[4002.47,4021.42,14.6133],90,[0,0,1]] call InitStruct; 
['BigSteelGrating',[4002.33,4035.39,14.6142],90,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4001.91,4034.65,18.5177],0,[0,0,1]] call InitStruct; 
['RustyCell',[4004.42,4018.38,14.7736],0,[0,0,1]] call InitStruct; 
['RustyCell',[4004.55,4024.73,14.6996],0,[0,0,1]] call InitStruct; 
['RustyCell',[4004.43,4031.23,14.87],0,[0,0,1]] call InitStruct; 
['RustyCell',[4000.39,4031.43,14.7668],0,[0,0,1]] call InitStruct; 
['RustyCell',[4000.31,4024.83,14.8743],0,[0,0,1]] call InitStruct; 
['RustyCell',[4000.52,4018.33,14.8467],0,[0,0,1]] call InitStruct; 
['LampKerosene',[4004.85,4012.17,14.8729],0,[0,0,1]] call InitItem; 
['LongSteelPipe',[4013.78,4015.47,20.0586,true],[0,0.0149249,0.999889],[0.00566271,-0.999873,0.0149247]] call InitStruct; 
['DoubleArmyBed',[3993.53,4020.2,14.7652],90,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3993.55,4016.16,14.7449],90,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3997.33,4020.28,14.7617],90,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3997.31,4016.14,14.7643],90,[0,0,1]] call InitStruct; 
['SteelBlueCase',[4000.06,4015.86,14.7368],180,[0,0,1]] call InitStruct; 
['SteelBlueCase',[3999.62,4015.84,14.7321],180,[0,0,1]] call InitStruct; 
['SteelBlueCase',[3999.17,4015.83,14.7292],180,[0,0,1]] call InitStruct; 
['SteelBlueCase',[3998.72,4015.81,14.7292],180,[0,0,1]] call InitStruct; 
['SteelBlueCase',[3998.53,4020.73,19.7624,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['SteelBlueCase',[3998.95,4020.75,19.7783,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['SteelBlueCase',[3999.78,4020.76,19.7555,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['SteelBlueCase',[3999.37,4020.75,19.7795,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['MediumWoodenTable',[4025.86,4020.85,14.7141],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4025.84,4018.66,14.7148],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4022.25,4018.66,14.6827],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4022.27,4020.85,14.6821],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4025.8,4014.27,14.7114],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4025.81,4016.47,14.7108],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4022.22,4014.3,14.6774],0,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[4022.24,4016.5,14.6768],0,[0,0,1]] call InitStruct; 
['Bench3',[4021,4015.39,14.6242],90,[0,0,1]] call InitStruct; 
['Bench3',[4021.01,4019.73,14.6814],90,[0,0,1]] call InitStruct; 
['Bench3',[4023.17,4019.79,14.6986],270,[0,0,1]] call InitStruct; 
['Bench3',[4023.19,4015.55,14.6932],270,[0,0,1]] call InitStruct; 
['Bench3',[4026.87,4015.39,14.7997],270,[0,0,1]] call InitStruct; 
['Bench3',[4024.68,4015.23,14.7307],90,[0,0,1]] call InitStruct; 
['Bench3',[4024.7,4019.56,14.7879],90,[0,0,1]] call InitStruct; 
['Bench3',[4026.85,4019.62,14.8051],270,[0,0,1]] call InitStruct; 
['BigSteelRoof',[4002.07,4024.96,23.7123,true],0,[-0.0069996,-0.00103549,0.999975]] call InitDecor; 
_3984_050544025_8828114_08588 = ['BlockBrick',[3984.05,4025.88,14.0859],90,[0,0,1], {_thisObj setvariable ['model','Land_Canal_Dutch_01_plate_F'];}] call InitDecor; // !!! realocated model !!!
_3984_051764013_0925314_08285 = ['BlockBrick',[3984.05,4013.09,14.0829],90,[0,0,1], {_thisObj setvariable ['model','Land_Canal_Dutch_01_plate_F'];}] call InitDecor; // !!! realocated model !!!
_3984_103524000_1511214_08134 = ['BlockBrick',[3984.1,4000.15,14.0813],90,[0,0,1], {_thisObj setvariable ['model','Land_Canal_Dutch_01_plate_F'];}] call InitDecor; // !!! realocated model !!!



if (!isNil'_4028_230713996_5144016_46206') then {
	_4028_230713996_5144016_46206 setvariable ['desc',"Толстая стена из кирпича. Всего несколько метров от свободы."];
};
if (!isNil'_4028_216554002_5083016_44889') then {
	_4028_216554002_5083016_44889 setvariable ['desc',"Толстая стена из кирпича. Всего несколько метров от свободы."];
};
if (!isNil'_4028_219484008_4995116_51906') then {
	_4028_219484008_4995116_51906 setvariable ['desc',"Толстая стена из кирпича. Всего несколько метров от свободы."];
};
if (!isNil'_4028_181404014_3852516_49940') then {
	_4028_181404014_3852516_49940 setvariable ['desc',"Толстая стена из кирпича. Всего несколько метров от свободы."];
};
if (!isNil'_4028_147464020_3664616_49079') then {
	_4028_147464020_3664616_49079 setvariable ['desc',"Толстая стена из кирпича. Всего несколько метров от свободы."];
};
if (!isNil'_4026_966314002_4555714_52096') then {
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'StreetLampEnabled G:BDN+S1yZ/S0'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampWall G:4wwgg1i6mtk'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampWall G:+WLVHg1VIhE'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampCeiling G:o1w1FH4lGDs'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampCeiling G:mFDepJIrQWg'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampCeiling G:N06+vnpJ0sw'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampWall G:+WLVHg1VIhE (2)'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'LampWall G:+WLVHg1VIhE (1)'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'StreetLampEnabled G:BDN+S1yZ/S0 (2)'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
	[_4026_966314002_4555714_52096,go_editor_globalRefs get 'StreetLampEnabled G:BDN+S1yZ/S0 (1)'] call (_4026_966314002_4555714_52096 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_4027_392584034_4382314_79724') then {
	_4027_392584034_4382314_79724 setvariable ['desc',"Этот люк ведёт в погреб, к продуктами и ингредиентам."];
};
