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

_3894_000003996_0000018_89106 = ['CollectionSpawnPoint',[3894,3996,18.8911],0.534458,[0,0,1]] call InitStruct; 
_3914_903563940_5090319_99245 = ['CollectionSpawnPoint',[3914.9,3940.51,19.9925],356.708,[0,0,1]] call InitStruct; 
_3826_682373999_2905328_80826 = ['CollectionSpawnPoint',[3826.68,3999.29,28.8083],92.3068,[0,0,1]] call InitStruct; 
_3784_078614017_7922423_95523 = ['CollectionSpawnPoint',[3784.08,4017.79,23.9552],92.908,[0,0,1]] call InitStruct; 
_3800_359623943_1918919_69399 = ['CollectionSpawnPoint',[3800.36,3943.19,19.694],70.497,[0,0,1]] call InitStruct; 
_3803_996833969_5153820_00448 = ['CollectionSpawnPoint',[3804,3969.52,20.0045],165.692,[0,0,1]] call InitStruct; 
_3801_070313990_0515124_34992 = ['CollectionSpawnPoint',[3801.07,3990.05,24.3499],179.366,[0,0,1]] call InitStruct; 
_3849_103763959_1550317_15636 = ['CollectionSpawnPoint',[3849.1,3959.16,17.1564],356.708,[0,0,1]] call InitStruct; 
_3840_284183935_1530828_65343 = ['CollectionSpawnPoint',[3840.28,3935.15,28.6534],3.981,[0,0,1]] call InitStruct; 
_3797_882084039_5727524_36955 = ['CollectionSpawnPoint',[3797.88,4039.57,24.3696],126.309,[0,0,1]] call InitStruct; 
_3816_171394054_4160224_17438 = ['CollectionSpawnPoint',[3816.17,4054.42,24.1744],96.368,[0,0,1]] call InitStruct; 
_3853_685064078_1875024_51472 = ['CollectionSpawnPoint',[3853.69,4078.19,24.5147],33.4555,[0,0,1]] call InitStruct; 
_3861_489264107_1484424_05810 = ['CollectionSpawnPoint',[3861.49,4107.15,24.0581],266.022,[0,0,1]] call InitStruct; 
_3712_729743967_593515_71991 = ['SpawnPoint',[3712.73,3967.59,5.71991],169.582,[0,0,1], {go_editor_globalRefs set ["escaper_location",_thisObj];
}] call InitStruct; 
_3860_298834101_3476624_08509 = ['SpawnPoint',[3860.3,4101.35,24.0851],196.653,[0,0,1]] call InitStruct; 
_3745_816893972_464114_87182 = ['TeleportBase',[3745.82,3972.46,4.87182],257.756,[0,0,1]] call InitStruct; 
_3779_868653968_8442428_45285 = ['TeleportBase',[3779.87,3968.84,28.4528],1.23411,[0,0,1], {go_editor_globalRefs set ["tp_enter_city",_thisObj];
}] call InitStruct; 
['TeleportExit',[3779.81,3972.13,29.5005],2.26905,[0,0,1], {go_editor_globalRefs set ["tp_city",_thisObj];
}] call InitStruct; 
['TeleportExit',[3742.87,3971.77,4.88845],260.049,[0,0,1], {go_editor_globalRefs set ["tp_escape",_thisObj];
}] call InitStruct; 
['TeleportExit',[3573.69,3835.51,18.4583],0.471129,[0,0,1]] call InitStruct; 
['TeleportExit',[3575.52,3768.18,13.6502],358.267,[0,0,1]] call InitStruct; 
['TeleportExit',[3611.05,3806.42,18.6102],83.9008,[0,0,1]] call InitStruct; 
['TeleportExit',[3607.54,3816.78,18.7423],4.72548,[0,0,1]] call InitStruct; 
['TeleportExit',[3682.65,3809.3,18.1501],0.471129,[0,0,1]] call InitStruct; 
['TeleportExit',[3687.14,3781.24,17.9177],278.081,[0,0,1]] call InitStruct; 
['TeleportExit',[3680.3,3762.53,17.4342],2.95976,[0,0,1]] call InitStruct; 
['BlockBrick',[3577.18,3832.96,18.4313],0,[0,0,1]] call InitDecor; 
_3572_072753828_4719213_89088 = ['BlockBrick',[3572.07,3828.47,13.8909],274.823,[0,0,1], {_thisObj setvariable ['model','CUP_A2_castle_wall1_20_turn'];}] call InitDecor; // !!! realocated model !!!
_3576_656743827_7731917_74557 = ['BlockBrick',[3576.66,3827.77,17.7456],0,[0,0,1], {_thisObj setvariable ['model','Land_Canal_Wall_Stairs_F'];}] call InitDecor; // !!! realocated model !!!
['BlockBrick',[3576.63,3832.96,32.6307,true],180,[0,-0.00144443,-0.999999]] call InitDecor; 
['BlockBrick',[3577.54,3822.61,13.3426,true],[-0.0268968,0.999638,-2.62866e-07],[0.0497844,0.00133979,0.998759]] call InitDecor; 
['BlockBrick',[3587.5,3812.43,23.3205],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3587.24,3801.67,22.2863],4.72274,[0,0,1]] call InitDecor; 
['BlockBrick',[3576.24,3788.06,21.0113],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3589.2,3790.57,19.3729],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3589.18,3779.59,19.3554],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3600.02,3792.09,28.3299],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3611.02,3802.22,18.5966],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3611.08,3813.41,18.6596],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3610.39,3790.9,31.304],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3610.25,3779.88,31.4758],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3620.49,3779.71,31.5614],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3620.53,3790.95,31.4271],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3621.48,3813.25,18.7475],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3611.01,3823.93,24.2094],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3621.02,3823.79,24.0418],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3630.78,3823.55,23.0297],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3641.19,3824.53,22.8132],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3631.3,3814.73,18.6566],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3606.06,3820.77,18.7205],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3606.06,3827.95,18.7505],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3616.44,3827.96,18.8252],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3636.95,3827.57,18.5928],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3626.6,3827.76,18.7243],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3648.28,3835.38,18.4665],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3647.96,3838.93,32.2839,true],[-6.23147e-05,1,3.89671e-07],[-4.12343e-06,3.89414e-07,-1]] call InitDecor; 
['BlockBrick',[3648.44,3846.74,18.2925],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3648.3,3857.19,18.2863],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3647.27,3848.03,31.5872,true],[-6.23147e-05,1,3.89671e-07],[-4.12343e-06,3.89414e-07,-1]] call InitDecor; 
['BlockBrick',[3647.73,3857.96,31.3683,true],[-6.23147e-05,1,3.89671e-07],[-4.12343e-06,3.89414e-07,-1]] call InitDecor; 
['BlockBrick',[3659.26,3830.57,18.3407],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3650.56,3824.64,25.5828],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3686.19,3782.63,32.5607],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3676.12,3789.29,32.3441],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3667.37,3797.81,32.5168],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3665.52,3786.93,32.1708],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3675.37,3778.38,31.9831],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3678.09,3771.19,31.898],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3656.47,3790.81,32.1816],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3680.66,3762.13,32.258],0,[0,0,1]] call InitDecor; 
if ((random 1) < 0.51) then {
	['Meatflower',[3841.67,4073.17,30.1176,true],random 360,[-0.101648,0.120631,0.98748]] call InitItem; 
};
if ((random 1) < 0.51) then {
	['Meatflower',[3819.87,4068.22,29.6897,true],random 360,[-0.101648,0.120631,0.98748]] call InitItem; 
};
if ((random 1) < 0.51) then {
	['Meatflower',[3801.51,4029.61,31.1035,true],random 360,[-0.101648,-0.206434,0.973166]] call InitItem; 
};
if ((random 1) < 0.51) then {
	['Meatflower',[3837.53,4028.6,32.6292,true],[-0.503944,0.849594,-0.155661],[-0.101648,0.120631,0.98748]] call InitItem; 
};
_3600_796883821_0078119_06969 = ['IStruct',[3600.8,3821.01,25.0257,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3600_885013813_1897019_36172 = ['IStruct',[3600.89,3813.19,25.3177,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3593_012213813_6213419_10055 = ['IStruct',[3593.01,3813.62,25.0565,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3600_990233805_5117219_46782 = ['IStruct',[3600.99,3805.51,25.4238,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3592_963623805_7922419_06245 = ['IStruct',[3592.96,3805.79,25.0184,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3592_921143798_7258319_21406 = ['IStruct',[3592.92,3798.73,25.17,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3607_607183801_0891120_26440 = ['IStruct',[3607.61,3801.09,26.2204,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3607_656493807_2023918_64095 = ['IStruct',[3607.66,3807.2,24.5969,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3620_391113808_2954118_82949 = ['IStruct',[3620.39,3808.3,24.7855,true],4.86975,[-0.00669787,-0.00112418,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3618_203373802_4089418_79774 = ['IStruct',[3618.2,3802.41,24.7537,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3600_787353829_0314918_87222 = ['IStruct',[3600.79,3829.03,24.8282,true],90.3377,[-0.00165248,0.00658808,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3618_425783799_1938512_47250 = ['IStruct',[3618.43,3799.19,18.4285,true],178.874,[0.00653912,0.00182117,0.999977], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\basaltruins\basaltwall_01_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallBattery',[3829.21,4005.91,25.0778],0,[0,0,1]] call InitItem; 
['SmallBattery',[3829.65,4003.7,25.2407],0,[0,0,1]] call InitItem; 
['SmallBattery',[3829.45,4003.69,25.2413],0,[0,0,1]] call InitItem; 
['SmallBattery',[3829.35,4003.71,25.2413],0,[0,0,1]] call InitItem; 
['MediumConcreteWall',[3831.7,4011.49,25.733],93.3091,[0,0,1]] call InitStruct; 
['MediumConcreteWall',[3830.38,4003.26,25.9197],356.351,[0,0,1]] call InitStruct; 
['MediumConcreteWall',[3833.46,4002.13,32.85],0.0458101,[0,0,1]] call InitStruct; 
['BigConcretePipe',[3779.87,3974.77,30.0033],359.917,[0,0,1]] call InitStruct; 
['BigConcretePipe',[3779.85,3972.06,35.5585,true],[-0.00144893,0.944048,0.329806],[0,-0.329806,0.944049]] call InitStruct; 
['BigConcretePipe',[3779.88,3969.28,34.5728,true],[-0.00144893,0.944048,0.329806],[0,-0.329806,0.944049]] call InitStruct; 
['BigConcretePipe',[3894.03,3995.38,24.9185,true],359.228,[-9.48981e-08,3.28864e-07,1]] call InitStruct; 
['BigConcretePipe',[3893.99,3998.21,24.9203,true],359.228,[-9.48981e-08,3.28864e-07,1]] call InitStruct; 
['BigConcretePipe',[3745.85,3972.39,4.87025],258.77,[0,0,1]] call InitStruct; 
['BigConcretePipe',[3743.06,3971.85,4.90398],258.77,[0,0,1]] call InitStruct; 
['BigConcretePipe',[3740.27,3971.28,4.90243],258.77,[0,0,1]] call InitStruct; 
['BigConcretePipe',[3573.68,3835.53,27.6493,true],[0,-4.37114e-08,-1],[0,1,-4.37114e-08]] call InitStruct; 
['BigConcretePipe',[3575.51,3768.19,22.8207,true],[0,-4.37114e-08,-1],[0,1,-4.37114e-08]] call InitStruct; 
['BigConcretePipe',[3610.8,3806.31,27.9528,true],[2.53178e-08,-4.992e-07,-1],[0.998459,0.0554982,-2.4259e-09]] call InitStruct; 
['BigConcretePipe',[3607.53,3816.8,27.6096,true],[0,-4.37114e-08,-1],[0,1,-4.37114e-08]] call InitStruct; 
['BigConcretePipe',[3682.86,3809.27,26.6924,true],[0,-4.37114e-08,-1],[0,1,-4.37114e-08]] call InitStruct; 
['BigConcretePipe',[3687.3,3781.2,26.6826,true],[2.91917e-06,2.22873e-05,-1],[-0.991196,0.132399,5.73455e-08]] call InitStruct; 
['BigConcretePipe',[3680.4,3762.34,25.9186,true],[3.32864e-05,-4.60017e-07,-1],[0.0375496,0.999295,7.90196e-07]] call InitStruct; 
['SmallConcreteArch',[3923.65,3954.44,18.4067],357.78,[0,0,1]] call InitStruct; 
['ConcretePanel',[3794.48,3990.21,30.7157],270.893,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3831.7,3985.99,23.2983],178.912,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3831.14,3983.33,23.7419],88.5681,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3848.43,3982.35,24.4442],0.231799,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3848.38,3978.08,24.4129],0.231799,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3844.3,3977.42,24.4365],88.5681,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3846.27,3982.36,24.4618],172.544,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3844,3982.08,24.4458],0.231799,[0,0,1]] call InitStruct; 
['ConcretePanel2',[3904.3,3972.56,24.8831,true],0,[0,-0.178991,0.983851]] call InitStruct; 
['ConcretePanel2',[3902.21,3973.7,25.1023,true],0,[0,-0.178991,0.983851]] call InitStruct; 
['ConcretePanel2',[3902.42,3970.98,19.6513],351.771,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[3901.05,3966.71,19.6621],353.895,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[3899.17,3966.74,19.6855],353.895,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[3900.46,3963.96,19.6875],85.5066,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[3923.63,3955.02,19.7873],177.402,[0,0,1]] call InitStruct; 
['ConcretePanelDamaged',[3921.51,3955.08,19.8168],177.402,[0,0,1]] call InitStruct; 
['BigConcretePanel',[3903.19,3979.5,25.9521,true],[-0.00568885,0.990662,0.136225],[0.014119,-0.136134,0.99059]] call InitStruct; 
['BigConcretePanel',[3902.83,3987.64,21.5842],354.326,[0,0,1]] call InitStruct; 
_3803_173344016_4711923_80097 = ['Decor',[3803.17,4016.47,23.801],269.863,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_103274009_4812024_20967 = ['Decor',[3832.1,4009.48,24.2097],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3872_233403855_811048_66574 = ['Decor',[3872.23,3855.81,8.66574],103.757,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3870_893313852_141118_56285 = ['Decor',[3870.89,3852.14,8.56285],269.25,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3868_203373872_971198_83386 = ['Decor',[3868.2,3872.97,8.83386],7.46574,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_883303873_591068_90955 = ['Decor',[3863.88,3873.59,8.90955],356.583,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3878_893313848_211188_59745 = ['Decor',[3878.89,3848.21,14.442,true],0,[-0.0628895,0,0.99802], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_509773969_813964_45731 = ['Decor',[3730.51,3969.81,4.45731],84.0999,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['MediumBetonWall',[3799.25,3949.5,19.7323],179.348,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3820.38,4002.37,26.7851],179.254,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3826.74,4014.72,24.0908],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3821.36,4014.68,26.7551],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3823.4,4002.34,26.7819],179.348,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3818.24,4002.34,24.1847],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3827.06,4007.53,31.5221],89.5048,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3828.12,4002.84,28.7836],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3818.43,4014.74,26.7623],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3826.44,4002.36,26.7774],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3827.04,4007.24,22.8115],88.7698,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3818.45,4014.72,24.0944],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3824.39,4014.64,26.7566],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3826.99,4004.48,31.544],89.5048,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3834.84,4002.13,28.6732],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3828.1,4005.78,28.828],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3827.42,4014.56,26.7615],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3826.58,4002.3,24.3309],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3855.83,3842.14,11.0586],274.573,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3856.13,3845.18,11.0601],274.573,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3918.72,3836.83,8.87],273.422,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3918.98,3839.86,11.5322],273.422,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3919.05,3839.88,8.86639],273.422,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3918.75,3836.82,11.5307],273.422,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3726.98,3965.13,4.7631],82.9166,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3726.27,3970.46,7.45715],82.9166,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3725.95,3973.36,4.54842],82.9166,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3726.61,3967.45,7.46505],82.9166,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3725.94,3973.35,6.32795],82.9166,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3573.39,3796.89,13.3903],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3580.85,3796.9,13.3544],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3574.08,3796.89,16.1094],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3577.11,3796.87,16.09],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3580.15,3796.82,16.0893],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3583.69,3795.94,13.4039],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3766.09,4002.16,23.824],0,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3760.31,4010.09,30.1288,true],303.88,[-0.0016111,-0.0108391,0.99994]] call InitStruct; 
['MediumBetonWall',[3760.33,4010.04,32.1256,true],303.88,[-0.0016111,-0.0108391,0.99994]] call InitStruct; 
['MediumBetonWall',[3760.4,4010.06,34.8693,true],305.986,[-0.00200723,-0.0107618,0.99994]] call InitStruct; 
['MediumBetonWall',[3759.43,4007.56,28.4478],55.6195,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3761.13,4005.02,28.4624],55.6195,[0,0,1]] call InitStruct; 
['MediumBetonWall',[3766.22,4002.24,26.5811],0,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3839.95,3936.44,22.1995],182.222,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3839.95,3936.42,29.279,true],1.81599,[-5.08914e-06,-6.97056e-05,-1]] call InitStruct; 
['ConcreteWallWithNetfence',[3840.1,3941.96,22.1831],182.222,[0,0,1]] call InitStruct; 
['ConcreteWallWithNetfence',[3840.09,3941.94,29.2626,true],1.81599,[-5.08914e-06,-6.97056e-05,-1]] call InitStruct; 
['ConcreteWallWithNetfence',[3826.99,4008.56,31.5792,true],[0.998193,0.0181568,-0.057278],[-0.057315,0.00152066,-0.998355]] call InitStruct; 
['ConcreteWallWithNetfence',[3826.98,4006.75,24.2098],88.7542,[0,0,1]] call InitStruct; 
_3578_143803807_4040512_49531 = ['IStruct',[3578.14,3807.4,12.4953],269.447,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\naval\piers\quayconcrete_01_20m_wall_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3589_120853822_3369118_17755 = ['IStruct',[3589.12,3822.34,18.1776],269.439,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\naval\piers\quayconcrete_01_5m_ladder_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['DeliveryPipe',[3805.77,4006.62,35.3477,true],[0.927552,-0.0193023,0.373195],[-0.372554,0.030183,0.92752], {go_editor_globalRefs set ["_dp_trader",_thisObj];
}] call InitStruct; 
['SmallConcretePipe',[3900.92,3999.06,18.4777],89.634,[0,0,1]] call InitStruct; 
['SmallConcretePipe',[3891.67,3992.25,18.6257],181.141,[0,0,1]] call InitStruct; 
['SmallConcretePipe',[3896.34,3992.12,18.4737],178.248,[0,0,1]] call InitStruct; 
_3798_443363976_0310130_64137 = ['Decor',[3798.44,3976.03,30.6414],270.659,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'];}] call InitDecor; // !!! realocated model !!!
['DirtCraterLong',[3871.7,3831.52,8.7804],121.012,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3867.05,3868.31,9.29299],121.012,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3880.66,3876.5,7.44501],170.768,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3903.65,4010.53,21.622],121.012,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3904.32,4003.15,21.2983],0,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3914.27,3948.16,23.9298,true],[0.0416474,-0.970771,-0.236366],[-0.108129,-0.239561,0.964841]] call InitStruct; 
['DirtCraterLong',[3913.35,3956.91,19.8974],298.016,[0,0,1]] call InitStruct; 
['DirtCraterLong',[3916.85,3956.18,24.2097,true],[0.0416474,-0.996055,0.0783531],[-0.108129,0.0734672,0.991418]] call InitStruct; 
_3779_833253972_7011729_19707 = ['Decor',[3779.83,3972.7,33.9941,true],0,[0,-0.187793,0.982209], {_thisObj setvariable ['model','a3\structures_f_enoch\military\training\craterlong_02_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3742_879643968_755135_34880 = ['Decor',[3742.88,3968.76,9.84311,true],[0.870366,-0.270703,0.411318],[-0.445727,-0.0781389,0.891752], {_thisObj setvariable ['model','a3\structures_f_enoch\military\training\craterlong_02_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3742_266603974_292485_30884 = ['Decor',[3742.27,3974.29,9.90697,true],[0.603861,0.721707,0.338366],[-0.254191,-0.22798,0.9399], {_thisObj setvariable ['model','a3\structures_f_enoch\military\training\craterlong_02_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['FarmGarden',[3869.25,3958.01,17.0018],231.764,[0,0,1]] call InitStruct; 
['FarmGarden',[3867.73,3960.41,16.9861],38.2772,[0,0,1]] call InitStruct; 
['FarmGarden',[3881.97,3985.06,22.0074],249.696,[0,0,1]] call InitStruct; 
['FarmGarden',[3877.39,3985.57,22.1733],339.344,[0,0,1]] call InitStruct; 
['FarmGarden',[3885.14,3984.97,21.936],339.344,[0,0,1]] call InitStruct; 
['MotherBunchOfShit',[3780.15,3967.85,34.3596,true],[-0.974357,-0.0989177,0.2021],[0.0244496,0.846323,0.532108]] call InitStruct; 
['MotherBunchOfShit',[3886.47,3860.73,14.3232,true],191.463,[0.102081,0.0697994,0.992324]] call InitStruct; 
['MotherBunchOfShit',[3877.71,3857.33,13.3582,true],[0.941173,0.324545,0.0941496],[-0.0850632,-0.0421062,0.995485]] call InitStruct; 
['MotherBunchOfShit',[3890.38,3881.91,12.0284,true],[0.954018,-0.293504,-0.0608641],[-0.0356684,-0.312766,0.94916]] call InitStruct; 
['MotherBunchOfShit',[3894.43,4001.03,20.4977,true],[0.990885,0.130036,-0.0351718],[0,0.261094,0.965313]] call InitStruct; 
['MotherBunchOfShit',[3746.74,3972.48,10.5194,true],[-0.030034,-0.978905,0.202095],[-0.835761,0.135497,0.532113]] call InitStruct; 
_3828_843263997_6210924_80887 = ['IStruct',[3828.84,3997.62,24.8089],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3872_073243955_2211917_44597 = ['Decor',[3872.07,3955.22,17.446],182.491,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_393313960_1110817_48217 = ['Decor',[3858.39,3960.11,17.4822],90.7716,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_333253954_8110417_51847 = ['Decor',[3858.33,3954.81,17.5185],90.7716,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['ConcreteWall',[3869.98,3961.91,17.4646],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[3861.98,3961.92,17.4644],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[3862.04,3952.84,17.5464],0,[0,0,1]] call InitStruct; 
['ConcreteWall',[3869.51,3948,17.5329],14.0759,[0,0,1]] call InitStruct; 
['ConcreteWall',[3865.8,3952.7,17.5765],274.547,[0,0,1]] call InitStruct; 
['ConcreteWall',[3873.71,3959.09,17.4594],91.3234,[0,0,1]] call InitStruct; 
['ConcreteWall',[3873.68,3951.2,17.5208],274.547,[0,0,1]] call InitStruct; 
['ConcreteWall',[3905.35,4000.58,20.2189],356.34,[0,0,1]] call InitStruct; 
['ConcreteWall',[3901.41,4004.17,20.1511],88.2338,[0,0,1]] call InitStruct; 
['ConcreteWall',[3901.15,4012.14,20.1431],88.2338,[0,0,1]] call InitStruct; 
['Wrench',[3858.75,3954.41,18.0006],273.865,[0,0,1]] call InitItem; 
['BetonGarageMedium',[3793.35,3977,24.4269],188.828,[0,0,1]] call InitStruct; 
['Butter',[3870.83,3997.55,28.0775,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Butter',[3870.63,3997.68,28.058,true],84.4731,[-0.00635159,-0.00630058,0.99996]] call InitItem; 
['Butter',[3870.74,3997.88,23.0418],145.297,[0,0,1]] call InitItem; 
['Butter',[3870.84,3997.73,23.0465],222.737,[0,0,1]] call InitItem; 
['WoodenDoor',[3831.36,3988.69,27.9249],87.184,[0,0,1]] call InitStruct; 
_3830_003423976_2011727_15507 = ['WoodenDoor',[3830,3976.2,27.1551],272.865,[0,0,1]] call InitStruct; 
_3840_983403986_9311527_54247 = ['WoodenDoor',[3840.98,3986.93,27.5425],0.520406,[0,0,1]] call InitStruct; 
_3815_463383979_9812024_35577 = ['WoodenDoor',[3815.46,3979.98,24.3558],155.588,[0,0,1]] call InitStruct; 
_3834_613283984_4611824_37567 = ['WoodenDoor',[3834.61,3984.46,24.3757],0.774458,[0,0,1]] call InitStruct; 
_3840_893313986_7011724_46807 = ['WoodenDoor',[3840.89,3986.7,24.4681],0.520406,[0,0,1]] call InitStruct; 
_3842_213383977_3010324_53307 = ['WoodenDoor',[3842.21,3977.3,24.5331],89.7904,[0,0,1]] call InitStruct; 
_3842_993413978_1511227_50027 = ['WoodenDoor',[3842.99,3978.15,27.5003],357.739,[0,0,1]] call InitStruct; 
_3845_803223980_0510327_48267 = ['WoodenDoor',[3845.8,3980.05,27.4827],357.739,[0,0,1]] call InitStruct; 
_3854_473393976_1010724_52467 = ['WoodenDoor',[3854.47,3976.1,24.5247],0.520406,[0,0,1]] call InitStruct; 
_3846_393313980_8510727_51007 = ['WoodenDoor',[3846.39,3980.85,27.5101],264.298,[0,0,1]] call InitStruct; 
['WoodenDoor',[3866.98,3984.42,21.9138],260.778,[0,0,1]] call InitStruct; 
_3845_963383986_7211924_66767 = ['WoodenDoor',[3845.96,3986.72,24.6677],0.520406,[0,0,1]] call InitStruct; 
_3851_233403986_9211427_62127 = ['WoodenDoor',[3851.23,3986.92,27.6213],0.520406,[0,0,1]] call InitStruct; 
_3849_593263983_1110824_25577 = ['WoodenDoor',[3849.59,3983.11,24.2558],89.8605,[0,0,1]] call InitStruct; 
_3846_013433987_0212427_58777 = ['WoodenDoor',[3846.01,3987.02,27.5878],0.520406,[0,0,1]] call InitStruct; 
_3851_113283986_7612324_43787 = ['WoodenDoor',[3851.11,3986.76,24.4379],0.520406,[0,0,1]] call InitStruct; 
_3845_003423983_6311027_53777 = ['WoodenDoor',[3845,3983.63,27.5378],272.562,[0,0,1]] call InitStruct; 
_3844_943363982_2211927_52957 = ['WoodenDoor',[3844.94,3982.22,27.5296],272.562,[0,0,1]] call InitStruct; 
_3866_582284002_5793522_38407 = ['WoodenDoor',[3866.58,4002.58,22.3841],87.3869,[0,0,1]] call InitStruct; 
_3868_833254001_6811522_49827 = ['WoodenDoor',[3868.83,4001.68,22.4983],352.75,[0,0,1]] call InitStruct; 
_3878_713383988_6511221_91217 = ['WoodenDoor',[3878.71,3988.65,21.9122],357.528,[0,0,1]] call InitStruct; 
['WoodenDoor',[3885.36,3991.33,21.8165],357.528,[0,0,1]] call InitStruct; 
['WoodenDoor',[3888.24,3991.65,21.7897],352.922,[0,0,1]] call InitStruct; 
['WoodenDoor',[3876.14,3992.17,21.9413],263.139,[0,0,1]] call InitStruct; 
_3783_806643985_9480033_20531 = ['WoodenDoor',[3783.81,3985.95,33.2053],0.588527,[0,0,1]] call InitStruct; 
['Bench1',[3835.11,3987.54,27.9807],179.905,[0,0,1]] call InitStruct; 
['Bench1',[3831.9,3986.15,27.9381],358.57,[0,0,1]] call InitStruct; 
['Bench1',[3833.49,3989.58,27.9807],89.9138,[0,0,1]] call InitStruct; 
['WoodenTableHandmade',[3867.26,3999.24,22.3931],88.7406,[0,0,1]] call InitStruct; 
['WoodenTableHandmade',[3868.62,3998.38,22.3849],2.68861,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3831.85,3972.63,24.4542],84.7797,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3813.26,3978.06,27.0878],63.3375,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3814.54,3975.41,27.0745],62.6431,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3852.06,3837.03,8.62266],124.119,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3844.76,3838.25,8.58715],171.045,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3841.77,3933.92,25.5488],1.64129,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3867.43,3995.57,22.4795],186.062,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3873.37,3997.56,22.0765],180.243,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3861.9,3995.32,22.4841],82.1965,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3904.44,3846.84,8.74358],189.996,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3909.36,3846.31,8.80581],189.996,[0,0,1]] call InitStruct; 
['MediumWoodenTable',[3861.73,3998.25,27.9149,true],275.059,[-0.000486379,4.30543e-05,1]] call InitStruct; 
['SmallWoodenTable',[3840.06,3990.98,27.5244],0,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3855.03,3941.19,27.932],90.7941,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3846.29,3990.43,27.5954],269.187,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3845.91,3977.58,27.4859],0,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3848.66,3987.75,27.5756],0,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3867.29,4001.23,22.4264],95.8809,[0,0,1]] call InitStruct; 
['SmallWoodenTable',[3864,3955.85,16.9947],90.7941,[0,0,1]] call InitStruct; 
_3853_564703944_9028327_94587 = ['LongWeaponContainer',[3853.56,3944.9,27.9459],1.8045,[0,0,1]] call InitStruct; 
_3855_534673943_9428727_95687 = ['LongWeaponContainer',[3855.53,3943.94,27.9569],269.047,[0,0,1]] call InitStruct; 
_3859_003423955_9211416_95717 = ['SquareWoodenBox',[3859,3955.92,16.9572],0,[0,0,1]] call InitStruct; 
_3859_023193953_6411117_00177 = ['SquareWoodenBox',[3859.02,3953.64,17.0018],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3893.86,3986.98,21.7353],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SquareWoodenBox',[3662.69,3826.87,18.3729],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3620_528563778_6303712_28339 = ['IStruct',[3620.53,3778.63,17.9287,true],179.792,[0.00698591,0.00105879,0.999975], {_thisObj setvariable ['model','a3\structures_f\mil\cargo\cargo_house_v2_ruins_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['Statue6',[3579.24,3775.65,20.1919,true],80.7478,[-0.00219864,0.00671061,0.999975]] call InitStruct; 
['Statue6',[3574.49,3775.68,20.088,true],272.301,[0.000807587,-0.00701213,0.999975]] call InitStruct; 
_3824_063234006_2810132_26201 = ['Decor',[3824.06,4006.28,36.0531,true],0,[8.74228e-08,0,-1], {_thisObj setvariable ['model','a3\structures_f\walls\sportground_fence_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3583_380373823_3042019_11469 = ['IStruct',[3583.38,3823.3,19.1147],267.875,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ferrum\xlamfence1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3658_105473829_5537118_20808 = ['BlockDirt',[3658.11,3829.55,24.1904,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','xlamfence1'];}] call InitDecor; // !!! realocated model !!!
['SmallCornerFenceMadeOfJunk',[3584.32,3820.78,19.144],88.5016,[0,0,1]] call InitStruct; 
_3659_382083828_6301318_04794 = ['BlockDirt',[3659.38,3828.63,24.0737,true],0,[0.00566367,-0.00693192,0.99996], {_thisObj setvariable ['model','xlamfence2'];}] call InitDecor; // !!! realocated model !!!
_3789_003423989_4912130_99476 = ['Decor',[3789,3989.49,30.9948],0.123478,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ml_plakats2\sobranka.p3d'];}] call InitDecor; // !!! realocated model !!!
['StoneWall',[3804.13,3983.86,26.67],1.93785,[0,0,1]] call InitStruct; 
_3797_983403991_3510730_44737 = ['Decor',[3797.98,3991.35,30.4474],87.7142,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\stone_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_793213992_8310529_98867 = ['Decor',[3793.79,3992.83,29.9887],358.179,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\stone_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_693363987_3811030_30387 = ['Decor',[3793.69,3987.38,30.3039],0.255097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\stone_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallConcretePanel',[3893.19,3990.22,21.7056],271.456,[0,0,1]] call InitStruct; 
['SmallConcretePanel',[3898.17,3990.22,21.6528],271.456,[0,0,1]] call InitStruct; 
['SmallConcretePanel',[3903.67,3993.92,21.6444],21.9505,[0,0,1]] call InitStruct; 
['SmallConcretePanel',[3897.9,3989.06,21.7149],87.7852,[0,0,1]] call InitStruct; 
['SmallConcretePanel',[3892.91,3989,21.6982],87.7852,[0,0,1]] call InitStruct; 
['SmallConcretePanel',[3905.88,3993.94,21.6633],182.353,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3904.14,3966.67,19.7101],0,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3909.37,3963.16,19.7391],90.1877,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3923.11,3963.33,19.6284],333.166,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3922.56,3966.58,19.5923],176.329,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3905.65,3963.84,19.6595],287.691,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3913.06,3963.13,19.7689],88.4103,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3924.87,3961.07,24.7409,true],136.322,[0,0.121147,0.992635]] call InitStruct; 
['SmallStoneRoad',[3916.67,3963.47,19.7353],77.9303,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3920.26,3963.91,19.7084],267.869,[0,0,1]] call InitStruct; 
['SmallStoneRoad',[3922.59,3970.2,19.5857],180.7,[0,0,1]] call InitStruct; 
['Golovinskaya',[3802.14,3983.2,26.4453],2.44,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[3794.76,3952.16,19.728],178.596,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[3794.63,3948.65,19.7243],186.456,[0,0,1]] call InitStruct; 
['BetonBlockFloor',[3794.8,3944.77,19.7192],3.85568,[0,0,1]] call InitStruct; 
_3846_983403825_621098_24718 = ['Decor',[3846.98,3825.62,8.24718],357.53,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_253423835_5710422_96136 = ['Decor',[3842.25,3835.57,22.9614],357.53,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_843263852_9011222_41250 = ['Decor',[3851.84,3852.9,28.3257,true],[-0.569056,0.304338,0.763907],[-0.152335,-0.951926,0.265765], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_623293990_4111334_71967 = ['Decor',[3779.62,3990.41,34.7197],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ml_plakats3\picture_115.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_348633984_4182134_90466 = ['Decor',[3782.35,3984.42,34.9047],271.178,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ml_plakats2\picture_09.p3d'];}] call InitDecor; // !!! realocated model !!!
['PictureFranklin',[3782.29,3980.91,31.129],359.222,[0,0,1]] call InitStruct; 
_3568_626223782_8222713_72391 = ['IStruct',[3568.63,3782.82,19.3967,true],0,[0.041942,-0.0247924,0.998812], {_thisObj setvariable ['model','a3\structures_f_enoch\walls\brick\brickwall_04_l_5m_old_d_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3567_645753775_8889216_95718 = ['IStruct',[3567.65,3775.89,22.581,true],268.011,[0.0233837,-0.0340878,0.999145], {_thisObj setvariable ['model','a3\structures_f_enoch\walls\brick\brickwall_04_l_5m_old_d_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['RedCarpet',[3781.94,3986.21,29.272],0,[0,0,1]] call InitStruct; 
['RatCage',[3887.65,3987.11,21.8468],89.7607,[0,0,1]] call InitStruct; 
['RatCage',[3887.81,3984.88,21.8384],267.242,[0,0,1]] call InitStruct; 
['RatCage',[3889.98,3986.92,21.7219],177.486,[0,0,1]] call InitStruct; 
['RatCage',[3891.76,3987.02,21.6776],88.7138,[0,0,1]] call InitStruct; 
['MatchBox',[3863.64,3955.87,17.8593],141.649,[0,0,1]] call InitItem; 
['Campfire',[3849.04,4079.24,29.3881,true],0,[0.00684429,0.00577726,0.99996]] call InitStruct; 
['CampfireDisabled',[3568.19,3779.53,18.31,true],0,[0.0419416,-0.024792,0.998812]] call InitStruct; 
['CampfireDisabled',[3656.88,3827.17,23.3589,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['TinyWoodenTable',[3802.19,3947.56,20.31],357.556,[0,0,1]] call InitStruct; 
['TinyWoodenTable',[3800.86,3945.75,20.3134],86.9911,[0,0,1]] call InitStruct; 
['TinyWoodenTable',[3782.87,3990.33,33.2893],0.239025,[0,0,1]] call InitStruct; 
['TinyWoodenTable',[3782.94,3981.91,33.1826],0.239025,[0,0,1]] call InitStruct; 
['Rail',[3790.51,4016.47,23.9046],270.328,[0,0,1]] call InitStruct; 
['Rail',[3717.75,3968.21,4.73795],262.275,[0,0,1]] call InitStruct; 
['Rail',[3766.18,4008.7,28.54,true],51.2582,[-0.00877123,-0.0070071,0.999937]] call InitStruct; 
['ArmChair',[3797.23,3949.03,19.7673],274.892,[0,0,1]] call InitStruct; 
['ArmChair',[3710.49,3966.36,5.63494],352.334,[0,0,1]] call InitStruct; 
['ArmChair',[3710.21,3968.06,5.63428],171.983,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3902.96,3959.15,19.9708],182.087,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3904.67,3953.93,19.8904],182.836,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3906.35,3953.8,19.8745],192.504,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3906.51,3959.25,19.7523],4.04155,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3909.83,3964.63,19.927],0,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3911.61,3964.87,19.876],0,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3912.03,3970.18,19.9592],0,[0,0,1]] call InitStruct; 
['WoodenGraveCross',[3915.6,3970.1,19.9169],0,[0,0,1]] call InitStruct; 
['RedLuxuryChair',[3796.9,3947.22,20.5497],346.701,[0,0,1]] call InitStruct; 
['RedLuxuryChair',[3782.41,3981.61,29.6458],270.149,[0,0,1]] call InitStruct; 
['LuxuryDoubleBed',[3777.51,3991.66,33.2144],0,[0,0,1]] call InitStruct; 
['SewercoverBase',[3800.77,3988.44,24.29],358.721,[0,0,1]] call InitStruct; 
['SewercoverBase',[3811.22,3974.61,24.3728],299.984,[0,0,1]] call InitStruct; 
['SewercoverBase',[3804.62,3948.46,19.7178],353.892,[0,0,1]] call InitStruct; 
['SewercoverBase',[3838.97,3970.03,22.5718],177.21,[0,0,1]] call InitStruct; 
['SewercoverBase',[3849.05,3957.42,17.0834],90.7945,[0,0,1]] call InitStruct; 
['SewercoverBase',[3893.29,4012.9,15.6415],178.816,[0,0,1]] call InitStruct; 
['SewercoverBase',[3906.52,3988.67,21.6249],269.817,[0,0,1]] call InitStruct; 
['BunchOfShit',[3891.55,3995.24,21.1973,true],[-0.91346,0.389287,-0.118517],[0,0.291248,0.956648]] call InitStruct; 
['BunchOfShit',[3897.43,3995.23,15.5953],30.9585,[0,0,1]] call InitStruct; 
['BunchOfShit',[3891.62,4006.09,15.4876],15.2158,[0,0,1]] call InitStruct; 
['BunchOfShit',[3894.44,4008.05,15.6155],331.202,[0,0,1]] call InitStruct; 
['ScaffoldingLadder',[3897.64,4005.77,15.3969],359.141,[0,0,1]] call InitStruct; 
['ScaffoldingLadder',[3615.61,3794.62,12.3764],275.716,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3792.08,3943.58,17.0877],92.3995,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3828.86,3980.83,22.1781],2.52382,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3839.03,3980.94,21.808],2.6146,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3826.04,3996.19,22.9696],88.0685,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3819.59,4010,23.0452],178.056,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3866.31,3863.1,7.88643],94.7599,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3846.6,3946.66,19.699],2.6146,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3852.16,3958.73,16.5101],268.693,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3852.12,3960.34,16.5101],268.694,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3843.72,3949.09,24.8033],178.563,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[3856.08,3985.64,21.7986],266.909,[0,0,1]] call InitStruct; 
['SmallSteelRustyStairs',[3780.1,3976.92,29.2809],0,[0,0,1]] call InitStruct; 
['SmallSteelRustyStairs',[3850.77,3939.42,27.2149],267.625,[0,0,1]] call InitStruct; 
['SmallSteelRustyStairs',[3713.08,3965.22,4.87531],170.982,[0,0,1]] call InitStruct; 
['SmallSteelRustyStairs',[3712.71,3969.83,4.74428],350.487,[0,0,1]] call InitStruct; 
['SmallSteelRustyStairs',[3845.75,3950.69,21.572],180.488,[0,0,1]] call InitStruct; 
['PaperHolder',[3783.39,3982.64,30.6282],86.6784,[0,0,1]] call InitItem; 
['PaperHolder',[3796.11,3977.87,25.2753],277.176,[0,0,1]] call InitItem; 
['PaperHolder',[3803.29,4006.75,28.4272],174.593,[0,0,1]] call InitItem; 
['PaperHolder',[3832.89,3999.49,25.1365],0,[0,0,1]] call InitItem; 
['PaperHolder',[3813.07,3978.27,25.307],331.338,[0,0,1]] call InitItem; 
['PaperHolder',[3828.7,4005.95,25.08],87.7113,[0,0,1]] call InitItem; 
['Paper',[3781.14,3980.98,38.9346,true],94.2409,[-0.0206521,0.00153141,0.999786]] call InitItem; 
['Paper',[3781.65,3980.84,38.9316,true],179.219,[-0.000282374,0.0207069,0.999786]] call InitItem; 
['Paper',[3780.78,3980.89,38.9327,true],40.2984,[-0.0133938,-0.0157939,0.999786]] call InitItem; 
['Paper',[3781.47,3981.1,38.9371,true],258.33,[0.0202807,0.00418875,0.999786]] call InitItem; 
['Paper',[3863.89,3955.74,17.8593],91.9883,[0,0,1]] call InitItem; 
['Paper',[3864.13,3955.99,17.8593],240.118,[0,0,1]] call InitItem; 
['Paper',[3863.5,3955.64,17.8593],194.335,[0,0,1]] call InitItem; 
['Crowbar',[3830.6,4003.84,24.7779],263.571,[0,0,1]] call InitItem; 
['Shovel',[3858.71,3954.77,17.5533],0,[0,0,1]] call InitItem; 
['Shovel',[3864.36,3955.84,17.8457],35.8516,[0,0,1]] call InitItem; 
_3855_153323942_2910228_11036 = ['MagazinePBM',[3855.15,3942.29,28.1104],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epb\items\military\magazine_rifle_f.p3d'];}] call InitItem; // !!! realocated model !!!
_3854_867923942_2854028_10977 = ['MagazinePBM',[3854.87,3942.29,28.1098],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epb\items\military\magazine_rifle_f.p3d'];}] call InitItem; // !!! realocated model !!!
_3855_004153942_2832028_11007 = ['MagazinePBM',[3855,3942.28,28.1101],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epb\items\military\magazine_rifle_f.p3d'];}] call InitItem; // !!! realocated model !!!
['SmallSteelTable',[3831.75,3975.45,24.4193],0.179889,[0,0,1]] call InitStruct; 
['SmallSteelTable',[3833.53,4007.55,24.4295],86.1862,[0,0,1]] call InitStruct; 
['SmallSteelTable',[3893.84,3984.92,21.6087],272.275,[0,0,1]] call InitStruct; 
['SmallSteelTable',[3833.84,4012.96,28.8083],1.3897,[0,0,1]] call InitStruct; 
['Shelves',[3787.39,3992.36,33.2509],359.514,[0,0,1]] call InitStruct; 
['Shelves',[3785.3,3989.36,33.2909],269.934,[0,0,1]] call InitStruct; 
['Shelves',[3838.48,3948.1,25.5306],272.095,[0,0,1]] call InitStruct; 
['Shelves',[3830.56,4005.13,24.3199],357.693,[0,0,1]] call InitStruct; 
['Shelves',[3830.53,4005.46,24.3149],176.574,[0,0,1]] call InitStruct; 
['Shelves',[3829.41,4005.42,24.2967],176.574,[0,0,1]] call InitStruct; 
['Shelves',[3830.58,4003.84,24.2396],176.574,[0,0,1]] call InitStruct; 
['Shelves',[3829.39,4005.01,24.2572],357.693,[0,0,1]] call InitStruct; 
['Shelves',[3829.33,4003.72,24.2392],176.574,[0,0,1]] call InitStruct; 
['Shelves',[3858.75,3954.77,17.0018],269.288,[0,0,1]] call InitStruct; 
['Shelves',[3854.79,3942.28,28.0054],178.517,[0,0,1]] call InitStruct; 
['Shelves',[3878.24,4000.19,22.7847],76.8359,[0,0,1]] call InitStruct; 
['Shelves',[3803.94,4009.15,29.9339,true],270.994,[-0.00104888,0.00250717,0.999996]] call InitStruct; 
['Grave',[3902.87,3958.52,19.8319],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3901.02,3958.46,19.8994],3.65445,[0,0,1]] call InitStruct; 
['Grave',[3904.62,3954.44,19.7672],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3900.81,3954.64,19.7886],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3902.72,3954.66,19.7702],8.27693,[0,0,1]] call InitStruct; 
['Grave',[3904.77,3958.52,19.7675],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3906.44,3958.41,19.7501],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3906.38,3954.42,19.7723],176.857,[0,0,1]] call InitStruct; 
['Grave',[3911.61,3965.55,19.8399],355.795,[0,0,1]] call InitStruct; 
['Grave',[3909.63,3965.38,19.8567],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3913.47,3965.6,19.8287],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3909.83,3969.66,19.9643],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3911.96,3969.49,19.8873],4.69594,[0,0,1]] call InitStruct; 
['Grave',[3913.69,3969.59,19.818],172.994,[0,0,1]] call InitStruct; 
['Grave',[3915.36,3969.47,19.8146],14.0099,[0,0,1]] call InitStruct; 
['Grave',[3917.25,3969.44,19.8117],2.62398,[0,0,1]] call InitStruct; 
['Grave',[3772.05,4005.33,23.8207],0,[0,0,1]] call InitStruct; 
['Grave',[3772.44,4005.3,23.8358],0,[0,0,1]] call InitStruct; 
['OldTombstoneGrave',[3925.15,3970.93,19.6535],88.2006,[0,0,1]] call InitStruct; 
['OldGraveFence3',[3925.09,3968.72,20.1145],88.5635,[0,0,1]] call InitStruct; 
['OldGraveFence2',[3924.98,3970.95,19.9507],87.0207,[0,0,1]] call InitStruct; 
['OldGraveFence',[3925.08,3966.32,20.0538],88.7424,[0,0,1]] call InitStruct; 
['OldGraveFence',[3913.69,3969.35,19.6774],355.97,[0,0,1]] call InitStruct; 
['OldGraveFence4',[3902.7,3954.86,19.7822],183.101,[0,0,1]] call InitStruct; 
['OldGraveFence4',[3913.51,3965.64,19.7476],178.557,[0,0,1]] call InitStruct; 
['OldGraveFence4',[3925.01,3964.41,19.9164],87.934,[0,0,1]] call InitStruct; 
['OldGraveFence4',[3772.42,4005.58,23.8505],182.068,[0,0,1]] call InitStruct; 
['Multimeter',[3858.74,3954.6,17.1066],264.158,[0,0,1]] call InitItem; 
['SteelCanopySmall',[3824.45,3976.03,24.5493],359.565,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3820.73,3978.12,24.7448],87.844,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3867.13,4080.71,24.3383],357.531,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3872.7,4073.22,29.5396,true],[-0.00680665,-0.995457,0.0949691],[0,0.0949713,0.99548]] call InitStruct; 
['SteelCanopySmall',[3873.07,4076.03,23.9893],0.965287,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3861.89,4092.3,24.4092],27.8784,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3866.69,4073.13,24.1709],178.509,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3865.75,4075.77,24.1473],357.531,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3903.72,3964.89,19.9377],271.681,[0,0,1]] call InitStruct; 
['SteelCanopySmall',[3877.13,4075.76,23.9892],0.965287,[0,0,1]] call InitStruct; 
_3576_557863782_7727113_22314 = ['IStruct',[3576.56,3782.77,20.4353,true],0,[0.041942,-0.0247924,0.998812], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_12_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3579_760993797_7910214_15552 = ['IStruct',[3579.76,3797.79,14.1555],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_12_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3574_674073797_6757814_14659 = ['IStruct',[3574.67,3797.68,14.1466],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_12_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['Statue9',[3566.27,3779.45,19.6623,true],271.15,[0.00154907,-0.0066011,0.999977]] call InitStruct; 
['OldTombstone3',[3902.68,3953.64,19.7665],181.635,[0,0,1]] call InitStruct; 
['OldTombstone3',[3925.89,3968.04,19.7343],87.815,[0,0,1]] call InitStruct; 
['OldTombstone',[3913.59,3964.67,19.7609],359.541,[0,0,1]] call InitStruct; 
['OldTombstone',[3913.59,3970.55,19.755],0,[0,0,1]] call InitStruct; 
['OldTombstone2',[3925.91,3966.38,19.339],89.4311,[0,0,1]] call InitStruct; 
['OldTombstone2',[3926.09,3964.4,19.6163],89.4311,[0,0,1]] call InitStruct; 
['OldTombstone2',[3925.93,3969.32,19.574],89.4311,[0,0,1]] call InitStruct; 
['BigConcreteUnfinishedBuilding',[3853,3940.63,23.5624],269.952,[0,0,1]] call InitDecor; 
['BigBrickUnfinishedTwoStoreyHouse',[3802.23,4004.89,24.0087],358.624,[0,0,1]] call InitDecor; 
['BigBrickUnfinishedTwoStoreyHouse',[3864.87,3814.7,7.99832],279.946,[0,0,1]] call InitDecor; 
['BigBrickUnfinishedTwoStoreyHouse',[3783.33,3986.76,29.6322],0,[0,0,1]] call InitDecor; 
['MediumWoodenTable1',[3839.35,3945.2,25.4927],0,[0,0,1]] call InitStruct; 
['Screwdriver',[3858.76,3954.67,17.9964],296.562,[0,0,1]] call InitItem; 
['WoodenOfficeTable2',[3813.39,3977.9,24.481],65.8498,[0,0,1]] call InitStruct; 
['WoodenOfficeTable2',[3876.7,3998.66,22.7847],267.851,[0,0,1]] call InitStruct; 
_3812_863283976_1511224_49197 = ['OfficeCabinet',[3812.86,3976.15,24.492],245.866,[0,0,1]] call InitStruct; 
['MediumGreenRock',[3844.74,3857.99,18.1723,true],[-0.541303,-0.269503,0.796467],[-0.217068,0.959922,0.177286]] call InitDecor; 
['MediumGreenRock',[3912.22,3929.63,16.2054],160.239,[0,0,1]] call InitDecor; 
['Muka',[3870.71,3997.05,22.2996],0,[0,0,1]] call InitItem; 
['Muka',[3870.72,3997.21,22.3198],0,[0,0,1]] call InitItem; 
['Muka',[3870.71,3997.4,22.3181],0,[0,0,1]] call InitItem; 
['Muka',[3870.72,3997.62,22.315],0,[0,0,1]] call InitItem; 
['Gloves',[3858.73,3955.2,17.1084],269.599,[0,0,1]] call InitItem; 
['Gloves',[3858.71,3954.88,17.1084],304.814,[0,0,1]] call InitItem; 
['Gloves',[3858.74,3955.03,17.1084],291.373,[0,0,1]] call InitItem; 
['ShortRottenBoards',[3869.26,4083.89,32.0115,true],66.939,[-0.06293,-0.138259,0.988395]] call InitStruct; 
['ShortRottenBoards',[3867.17,4078.74,31.6201,true],355.701,[0.00171024,0.0103967,0.999944]] call InitStruct; 
['ShortRottenBoards',[3879.35,4074.76,31.244,true],[-0.979289,0.0988333,-0.176708],[-0.177236,0.00348792,0.984162]] call InitStruct; 
['LongRottenBoards',[3855.82,4080.99,30.7963,true],[-0.0114317,0.970876,-0.239311],[0,0.239327,0.970939]] call InitStruct; 
['LongRottenBoards',[3865.53,4088.87,26.9681],172.833,[0,0,1]] call InitStruct; 
['LongRottenBoards',[3859.03,4098.54,30.0099,true],[-0.857311,0.342745,-0.384113],[-0.3549,0.146998,0.923276]] call InitStruct; 
['WireCutters',[3858.74,3954.39,17.1223],104.072,[0,0,1]] call InitItem; 
['TwoStoreyHouseBalcony1',[3569.72,3778.68,19.8611,true],178.735,[0.0393202,-0.0248513,0.998918]] call InitStruct; 
_3864_479983955_6213417_85927 = ['BrigadirCloth',[3864.48,3955.62,17.8593],190.504,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\camping\pillow_grey_f.p3d'];}] call InitItem; // !!! realocated model !!!
['LongShelf',[3870.69,3998.78,22.0521],91.0344,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3815.53,3974.19,26.8687],333.19,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3829.55,3986.11,27.6992],358.551,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3814.06,3977.3,26.8939],333.19,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3816.7,3978.3,26.879],254.399,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3829.47,3989.52,27.7066],358.551,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3817.62,3975.14,26.8978],273.597,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3829.46,3999.54,24.2074],2.9863,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3833.11,3999.45,24.2164],2.9863,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3832.5,4001.52,24.1967],357.165,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3829.39,4001.64,24.2073],357.181,[0,0,1]] call InitStruct; 
['WoodenSmallFloor',[3846.11,3953.11,22.0962],269.083,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[3835.15,3989.02,29.643],267.077,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[3868.26,3948.53,17.0735],4.29397,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[3861.62,3962.06,17.0468],267.363,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[3873.13,3948.31,17.2963],93.9232,[0,0,1]] call InitStruct; 
['NewIndPipe90DegR',[3868.36,3948.68,17.7655],4.29397,[0,0,1]] call InitStruct; 
['NewIndPipeGround',[3670.43,3793.77,24.463,true],[0.0242958,-0.0434587,-0.99876],[0.985769,-0.165193,0.0311678]] call InitStruct; 
['LongSteelPipe',[3899.48,4002.35,21.0627],265.71,[0,0,1]] call InitStruct; 
['LongSteelPipe',[3828.39,4072.9,31.4103,true],305.734,[0.00679566,0.00104769,0.999976]] call InitStruct; 
['LongSteelPipe',[3595.73,3806.62,24.3192,true],0,[-0.00657818,-0.00169113,0.999977]] call InitStruct; 
['LongSteelPipe',[3613.47,3831.89,24.1155,true],269.59,[0.0068729,0.00570967,0.99996]] call InitStruct; 
['LongSteelPipe',[3633.19,3832.09,23.9932,true],269.382,[0.00684858,0.0057345,0.99996]] call InitStruct; 
['MediumSteelUpperPipe',[3830.66,3989.05,23.1591],359.948,[0,0,1]] call InitStruct; 
['MediumSteelUpperPipe',[3873.08,3954.78,15.2202],178.112,[0,0,1]] call InitStruct; 
['MediumSteelUpperPipe',[3904.33,4013.41,21.1828],178.856,[0,0,1]] call InitStruct; 
['MediumSteelUpperPipe',[3909.09,4004.97,20.4423],272.417,[0,0,1]] call InitStruct; 
['IndustrialPipes',[3868.61,3995.48,19.282],270,[0,0,1]] call InitStruct; 
['IndustrialPipes',[3865.63,4001.65,19.3119],91.742,[0,0,1]] call InitStruct; 
['IndustrialPipes',[3617.78,3776.53,21.6127,true],89.9879,[-0.00691178,-0.00565018,0.99996]] call InitStruct; 
['MetalTruss',[3615.64,3784.35,20.3034,true],269.5,[0.00686575,0.00572153,0.99996]] call InitStruct; 
['TorchHolderCharged',[3805.8,3956.88,26.6288,true],[-0.911504,-0.119825,-0.39345],[-0.396305,0,0.918119]] call InitStruct; 
['TorchHolderCharged',[3802.83,3966.38,20.3451],263.964,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3818.71,4015.64,24.8],32.9066,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3849.15,3837.69,8.24155],350.899,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3857.17,3840.46,8.22137],81.1216,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3851.47,3850.73,8.15483],185.624,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3841.99,3845.83,8.18687],122.732,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3898.1,3842.85,8.32252],186.275,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3900.29,3992.59,26.8004,true],[0.117624,-0.99147,-0.0561434],[0,-0.0565359,0.998401]] call InitStruct; 
['TorchHolderCharged',[3904.89,4009.56,28.2768,true],[-0.144582,-0.987899,-0.0561352],[-0.0147143,-0.0545785,0.998401]] call InitStruct; 
['TorchHolderCharged',[3906.25,3973.41,25.5685,true],[-0.994165,-0.0921052,-0.0561415],[-0.0565157,0.00145789,0.998401]] call InitStruct; 
['TorchHolderCharged',[3829.31,4072.69,23.9209],103.849,[0,0,1]] call InitStruct; 
['TorchHolder',[3730.53,3971.06,4.02542],357.065,[0,0,1]] call InitStruct; 
['ElectricalEngineDevice',[3864.94,3957.33,16.9547],270,[0,0,1]] call InitStruct; 
_3781_033203985_5710429_14077 = ['Decor',[3781.03,3985.57,29.1408],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3866_353273954_4011221_25497 = ['Decor',[3866.35,3954.4,21.255],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3866_433353953_4611816_49677 = ['Decor',[3866.43,3953.46,16.4968],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3887_193363818_3310517_64067 = ['Decor',[3887.19,3818.33,17.6407],5.15389,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_433354006_3210428_30326 = ['Decor',[3834.43,4006.32,28.3033],180.023,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18_2.p3d'];}] call InitDecor; // !!! realocated model !!!
['ThickConcreteFloorMedium',[3825.85,3937.31,29.8907],0.609165,[0,0,1]] call InitStruct; 
['ThickConcreteFloorMedium',[3819.48,3971.21,23.9535],359.957,[0,0,1]] call InitStruct; 
['ThickConcreteFloorMedium',[3854.9,3939.1,32.2379],178.33,[0,0,1]] call InitStruct; 
['ThickConcreteFloorMedium',[3877.3,4006.32,22.2797],182,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3839.86,3952.43,29.6828],0,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3815.21,3976.45,23.937],244.709,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3831.04,3974.28,23.9495],279.274,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3825.47,3974.75,23.9601],271.233,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3827.44,4011.72,30.6453,true],0.422328,[-0.99991,0.00737047,0.0112206]] call InitStruct; 
['ThickConcreteFloorSmall',[3827.3,4003.58,30.7678,true],0.422328,[-0.99991,0.00737047,0.0112206]] call InitStruct; 
['ThickConcreteFloorSmall',[3827.5,4011.12,36.5816,true],0.422328,[-0.99991,0.00737047,0.0112206]] call InitStruct; 
['ThickConcreteFloorSmall',[3877.01,4000.59,27.0752],271.233,[0,0,1]] call InitStruct; 
['ThickConcreteFloorSmall',[3839.85,3946.45,29.8231],0,[0,0,1]] call InitStruct; 
['BrickThinWall',[3776.9,3983.19,29.9342],179.258,[0,0,1]] call InitStruct; 
['BrickThinWall',[3839.79,3932.67,25.5617],2.37504,[0,0,1]] call InitStruct; 
['BrickThinWall',[3837.8,3934.21,25.5617],90.1882,[0,0,1]] call InitStruct; 
['BrickThinWall',[3838.31,3952.18,25.4305],91.718,[0,0,1]] call InitStruct; 
['BrickThinWall',[3838.13,3946.19,25.4197],91.718,[0,0,1]] call InitStruct; 
['BrickThinWall',[3837.91,3940.17,25.4059],91.718,[0,0,1]] call InitStruct; 
['BrickThinWall',[3812.96,3975.55,27.0215],245.025,[0,0,1]] call InitStruct; 
['BrickThinWall',[3842.66,3934.22,25.5303],90.1882,[0,0,1]] call InitStruct; 
['BrickThinWall',[3842.73,3946.19,25.5273],90.1882,[0,0,1]] call InitStruct; 
['BrickThinWall',[3857.61,3973.27,31.0239,true],90.0006,[-0.0065973,-0.00162294,0.999977]] call InitStruct; 
['BrickThinWall',[3870.07,3996.04,21.9371],270.613,[0,0,1]] call InitStruct; 
['BrickThinWall',[3872.94,4003.64,21.9477],180.063,[0,0,1]] call InitStruct; 
['BrickThinWall',[3887.43,3809.37,8.69147],185.267,[0,0,1]] call InitStruct; 
['BrickThinWall',[3899.53,3965.68,25.9502,true],85.0023,[0.00654485,0.00610848,0.99996]] call InitStruct; 
['BrickThinWall',[3877.14,3997.59,22.7498],182.063,[0,0,1]] call InitStruct; 
['BrickThinWall',[3877.37,4003.53,22.7568],180.063,[0,0,1]] call InitStruct; 
['BrickThinWall',[3910.01,3844.59,8.95571],96.0453,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3797.59,3976.72,24.5407],276.915,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3794.15,3977.04,24.4811],99.3609,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3786.45,3992.98,29.8172],180.304,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3789.25,3990.66,29.8774],270.749,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3839.91,3950.05,25.5374],180.207,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3839.68,3940.42,25.4746],182.462,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3839.74,3986.8,27.5763],179.67,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3839.7,3986.54,24.4462],179.67,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3818.73,3974.42,27.1095],93.2224,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3831.35,3987.49,27.9379],89.7225,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3822.22,3975.25,24.4513],271.139,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3841.42,3955.3,22.2624],179.67,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3842.76,3952.2,25.4362],90.4079,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3845.09,3941.94,22.0252],357.542,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3844.75,3986.56,24.4368],179.67,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3860.48,3976.02,24.5371],182.36,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3865.35,3975.82,24.581],0.968515,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3860.33,3979.82,24.657],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3850.04,3986.79,27.5913],182.189,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3849.92,3986.66,24.5297],182.189,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3865.14,3979.81,24.7061],0,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3844.8,3986.85,27.5429],179.67,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3870.05,4001.74,21.9529],89.5133,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3874.3,4000.55,22.7566],272,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3923.26,3957.33,19.8749],0.0131486,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3782.84,3983.07,33.2905],0.515281,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3832.96,4010.66,28.8083],89.4953,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3847.13,3951.23,22.3054],358.507,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[3861.22,3956.59,17.0018],179.67,[0,0,1]] call InitStruct; 
_3787_323243995_3911129_49577 = ['SteelGridDoor',[3787.32,3995.39,29.4958],180.877,[0,0,1]] call InitStruct; 
_3830_773194000_3911123_86557 = ['SteelGridDoor',[3830.77,4000.39,23.8656],91.0917,[0,0,1]] call InitStruct; 
['SteelGridDoorElectronic',[3819.81,4006.3,28.6973],0,[0,0,1], {go_editor_globalRefs set ["Imported SteelGridDoorElectronic517134",_thisObj];
}] call InitStruct; 
_3832_433354005_0410228_53357 = ['SteelGridDoor',[3832.43,4005.04,28.5336],1.6905,[0,0,1]] call InitStruct; 
_3842_033203933_6511221_72147 = ['SteelGridDoor',[3842.03,3933.65,21.7215],269.102,[0,0,1]] call InitStruct; 
_3842_073243948_5112321_85767 = ['SteelGridDoor',[3842.07,3948.51,21.8577],270.898,[0,0,1]] call InitStruct; 
_3842_063233939_2211921_78247 = ['SteelGridDoor',[3842.06,3939.22,21.7825],270.898,[0,0,1]] call InitStruct; 
_3842_123293944_7211921_78727 = ['SteelGridDoor',[3842.12,3944.72,21.7873],270.898,[0,0,1]] call InitStruct; 
['SteelGridDoorElectronic',[3843.76,3941.85,21.0059],179.843,[0,0,1], {go_editor_globalRefs set ["Imported SteelGridDoorElectronic329481",_thisObj];
}] call InitStruct; 
_3853_023193941_9311527_63427 = ['SteelGridDoor',[3853.02,3941.93,27.6343],179.837,[0,0,1]] call InitStruct; 
_3833_045654011_9438528_49050 = ['SteelGridDoor',[3833.05,4011.94,28.4905],272.338,[0,0,1]] call InitStruct; 
_3871_213383960_4912116_93417 = ['Decor',[3871.21,3960.49,16.9342],1.67518,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\tank\tank_rust_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_243413986_8811024_67987 = ['Decor',[3836.24,3986.88,24.6799],272.303,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3831_313233990_7412124_37817 = ['Decor',[3831.31,3990.74,24.3782],181.712,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_133303987_2312024_45617 = ['Decor',[3827.13,3987.23,24.4562],88.2896,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3891_843263832_311046_19837 = ['Decor',[3891.84,3832.31,6.19837],275.809,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['PenRed',[3797.09,3977.94,30.273,true],358.915,[0.00731301,0.00612941,0.999954]] call InitItem; 
['PenRed',[3783.21,3982.61,35.674,true],358.915,[0.00731301,0.00612941,0.999954]] call InitItem; 
['PenBlack',[3783.16,3982.62,30.6696],179.179,[0,0,1]] call InitItem; 
['PenBlack',[3796.97,3977.95,25.2669],53.8189,[0,0,1]] call InitItem; 
['PenBlack',[3802.92,4006.75,28.4456],317.584,[0,0,1]] call InitItem; 
['PenBlack',[3833.16,3999.09,25.1319],53.8189,[0,0,1]] call InitItem; 
['PenBlack',[3813.1,3978.05,25.3253],63.8388,[0,0,1]] call InitItem; 
['PenBlack',[3828.82,4006.47,25.1003],138.258,[0,0,1]] call InitItem; 
['PenBlack',[3781.44,3980.91,33.9298],66.3409,[0,0,1]] call InitItem; 
['PenBlack',[3863.72,3955.55,17.8593],149.432,[0,0,1]] call InitItem; 
['BigSteelRoof',[3859.78,3819.87,23.5769,true],[0.107738,0.994179,2.97837e-06],[0.245528,-0.0266105,0.969024]] call InitDecor; 
['BigSteelRoof',[3847.58,3843.62,20.6533,true],[0.107738,0.994179,2.97837e-06],[0.245528,-0.0266105,0.969024]] call InitDecor; 
_3845_163333945_3610825_09307 = ['IStruct',[3845.16,3945.36,25.0931],89.1057,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_6m_l.p3d'];}] call InitStruct; // !!! realocated model !!!
['ConcreteLongPole',[3819.31,3976.75,24.3045],0,[0,0,1]] call InitStruct; 
['ConcreteLongPole',[3866.19,3956.92,17.0018],0,[0,0,1]] call InitStruct; 
['StoneSmallPandus',[3871.68,4000.26,22.2604],2.63438,[0,0,1]] call InitStruct; 
['StoneBigPandus',[3860.82,3985.84,28.2175,true],[0.033263,-0.999446,-0.00145636],[0.0437414,0,0.999043]] call InitStruct; 
['StoneBigPandus',[3860.43,3989.67,28.327,true],[0.033263,-0.999446,-0.00145636],[0.0437414,0,0.999043]] call InitStruct; 
['StoneBigPandus',[3843.95,3969.23,23.7659],271.556,[0,0,1]] call InitStruct; 
['StoneBigPandus',[3839.81,3940.5,29.8232],270,[0,0,1]] call InitStruct; 
['Struct_DebugMaterial__',[3797.03,3986.19,26.0813],182.303,[0,0,1]] call InitStruct; 
['Struct_DebugMaterial__',[3852.98,3939.22,27.687],357.927,[0,0,1]] call InitStruct; 
['MediumConcreteFloor',[3802.47,3969.42,25.8766,true],[0.17458,-0.984643,-3.19696e-08],[-0.984643,-0.17458,2.08184e-09]] call InitStruct; 
['MediumConcreteFloor',[3845.71,3953.87,27.9506],90,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3832.63,3973.98,26.8473],2.75482,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3855.28,3944.52,27.6976],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3855.39,3938.55,27.7006],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[3839.79,3935.36,28.3457],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3801.64,3968.16,21.3018],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3799.69,3967.8,21.3084],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3802.32,3964.36,19.6917],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3800.38,3964.01,19.6983],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3797.61,3946.06,19.5367],359.056,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3801.12,3970.99,23.0518],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3799.18,3970.63,23.0584],349.718,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3794.57,3984.82,27.0287],272.268,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3794.65,3986.75,27.0263],272.268,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3791.78,3986.87,28.7763],272.268,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3791.7,3984.93,28.7787],272.268,[0,0,1]] call InitStruct; 
['StoneBigLadderDouble',[3828.57,3975.18,23.834],189.131,[0,0,1]] call InitStruct; 
['StoneBigLadderDouble',[3829.86,4011.6,25.3382],179.719,[0,0,1]] call InitStruct; 
['StoneBigLadderDouble',[3829.86,4011.28,22.1487],179.719,[0,0,1]] call InitStruct; 
['DestroyedMetalHangar',[3872.62,3798.99,21.8851,true],[0.997669,-0.0682346,-1.13255e-05],[-7.75424e-06,5.26031e-05,-1]] call InitDecor; 
['DestroyedMetalHangar',[3846.33,3950.5,36.9069,true],[-8.74228e-08,1,-8.74228e-08],[0,-8.74228e-08,-1]] call InitDecor; 
['DestroyedMetalHangar',[3873.99,3845.05,35.8863,true],[-0.997275,0.0737778,2.49454e-06],[-1.20261e-06,1.75556e-05,-1]] call InitDecor; 
['DestroyedMetalHangar',[3910.28,3847.06,23.5668,true],[0.07148,0.997442,-1.74597e-05],[-1.74845e-07,-1.7492e-05,-1]] call InitDecor; 
['DestroyedMetalHangar',[3617.17,3809.25,27.2373,true],[-0.999879,0.0155357,2.51805e-06],[-2.24929e-06,1.73171e-05,-1]] call InitDecor; 
_3669_475103823_1435518_57704 = ['IStruct',[3669.48,3823.14,23.3727,true],0.226958,[0.00562981,-0.00694718,0.99996], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_8m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelCanopy',[3794.99,3949.24,19.201],0,[0,0,1]] call InitStruct; 
['SteelCanopy',[3861.29,4065.02,24.024],0,[0,0,1]] call InitStruct; 
['MediumJunkShed',[3869.93,4070.73,23.5903],0,[0,0,1]] call InitStruct; 
['MediumJunkShed',[3882.13,3824.3,8.5083],184.611,[0,0,1]] call InitStruct; 
['MediumJunkShed',[3875.66,4084.1,23.6641],178.263,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3791.73,3954.05,22.2503],248.924,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3802.65,3950.37,22.1099],248.924,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3798.12,3953.93,22.1586],287.068,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3902.65,3965.51,19.3398],0,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3906.71,3847.16,9.00423],92.9154,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3917.59,3842.07,9.07428],128.926,[0,0,1]] call InitStruct; 
['WoodenOldBench',[3813.19,3979.62,24.3882],159.064,[0,0,1]] call InitStruct; 
['WoodenOldBench',[3832.77,3977.89,24.4091],191.162,[0,0,1]] call InitStruct; 
['WoodenOldBench',[3813.87,4007.1,24.156],90.7604,[0,0,1]] call InitStruct; 
['WoodenSmallBench',[3868.3,3992.27,22.1834],0,[0,0,1]] call InitStruct; 
['TinBigFence',[3845.57,3975.17,27.6053],0,[0,0,1]] call InitStruct; 
['TinBigFence',[3849.54,3982.38,27.5242],269.66,[0,0,1]] call InitStruct; 
['TinBigFence',[3881.28,3988.01,21.8454],201.396,[0,0,1]] call InitStruct; 
['TinBigFence',[3881.22,3988.05,23.3494],201.396,[0,0,1]] call InitStruct; 
['TinBigFence',[3876,3988.02,23.3114],164.498,[0,0,1]] call InitStruct; 
['TinBigFence',[3876.1,3988.08,21.81],164.498,[0,0,1]] call InitStruct; 
['TinBigFence',[3885.02,3987.67,23.3657],170.488,[0,0,1]] call InitStruct; 
['TinBigFence',[3889.07,3988,23.2376],180.056,[0,0,1]] call InitStruct; 
['TinBigFence',[3889.05,3988.01,21.6632],180.056,[0,0,1]] call InitStruct; 
['TinBigFence',[3885.08,3987.66,21.7887],170.488,[0,0,1]] call InitStruct; 
['TinFence',[3806.11,4008.87,27.6834],266.389,[0,0,1]] call InitStruct; 
['TinFence',[3806.27,4004.88,27.8257],270.125,[0,0,1]] call InitStruct; 
['TinFence',[3806.07,4003.23,27.6856],0.117409,[0,0,1]] call InitStruct; 
['TinFence',[3805.7,4009.84,27.7387],182.398,[0,0,1]] call InitStruct; 
['TinFence',[3833.53,3990.28,29.2045],1.33592,[0,0,1]] call InitStruct; 
['TinFence',[3833.42,3997.43,28.8083],359.567,[0,0,1]] call InitStruct; 
['TinFence',[3835.95,3986.89,29.0932],91.2628,[0,0,1]] call InitStruct; 
['TinFence',[3827.55,3997.5,28.8083],359.567,[0,0,1]] call InitStruct; 
['TinFence',[3825.5,3999.37,28.732],89.9998,[0,0,1]] call InitStruct; 
['TinFence',[3827.38,4000.93,28.9419],180.049,[0,0,1]] call InitStruct; 
['TinFence',[3829.85,4001,28.9779],178.533,[0,0,1]] call InitStruct; 
['TinFence',[3870.99,3846.37,8.57852],14.8002,[0,0,1]] call InitStruct; 
['TinFence',[3870.28,3879.05,8.77562],271.52,[0,0,1]] call InitStruct; 
['TinFence',[3844.39,3984.39,27.7579],179.392,[0,0,1]] call InitStruct; 
['TinFence',[3842.25,3977.72,27.6022],91.2628,[0,0,1]] call InitStruct; 
['TinFence',[3883.32,3845.64,8.84162],91.1749,[0,0,1]] call InitStruct; 
['TinFence',[3901.18,3968.72,19.6965],179.339,[0,0,1]] call InitStruct; 
['TinFence',[3899.87,3968.73,20.9284],179.339,[0,0,1]] call InitStruct; 
['TinFence',[3906.88,3969.38,19.7678],167.767,[0,0,1]] call InitStruct; 
['TinFence',[3908.86,3971.78,19.9022],91.1749,[0,0,1]] call InitStruct; 
_3650_626953855_9423819_60556 = ['IStruct',[3650.63,3855.94,24.6542,true],359.938,[0.00286275,0.0261709,0.999653], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3674_594973794_0837419_26060 = ['IStruct',[3674.59,3794.08,24.3092,true],270.301,[-0.00574146,0.00687474,0.99996], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigRedEdgesRack',[3808.26,4007.23,24.2758],269.99,[0,0,1]] call InitStruct; 
['SmallPileOfConcreteFragments',[3776.12,4006.07,29.135,true],0,[0.00700784,0.000976538,0.999975]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3827.83,4002.03,27.776],91.1823,[0,0,1]] call InitStruct; 
_3579_489013838_3486321_21549 = ['BlockBrick',[3579.49,3838.35,21.2155],0,[0,0,1], {_thisObj setvariable ['model','Land_Canal_WallSmall_10m_F'];}] call InitDecor; // !!! realocated model !!!
_3582_597663833_3474121_34586 = ['BlockBrick',[3582.6,3833.35,21.3459],267.879,[0,0,1], {_thisObj setvariable ['model','Land_Canal_WallSmall_10m_F'];}] call InitDecor; // !!! realocated model !!!
_3574_094973827_9663122_36365 = ['BlockBrick',[3574.09,3827.97,22.3636],1.98631,[0,0,1], {_thisObj setvariable ['model','Land_Canal_WallSmall_10m_F'];}] call InitDecor; // !!! realocated model !!!
['LargeConcreteWallWithReinforcement',[3580.2,3771.14,20.2789,true],90.7293,[-0.0107683,0.0168278,0.9998]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3571.23,3770.33,20.1891,true],90.7293,[-0.0107683,0.0168278,0.9998]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3575.19,3766.55,20.2707,true],0,[-0.0172351,0.0319391,0.999341]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3587.35,3825.3,26.4293,true],359.965,[-0.0149605,0.0257327,0.999557]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3596.31,3825.25,25.5218,true],181.072,[0.0144508,-0.0260095,0.999557]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3607.37,3815.13,25.8707,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3620.12,3815.24,26.1853,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3626.2,3815.28,26.199,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3629.12,3809.22,24.7403,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3633.76,3814.19,24.8296,true],268.098,[-0.0254102,-0.0103651,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3605.28,3833.06,26.0423,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3614.24,3832.99,26.093,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3623.2,3833,26.175,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3632.11,3833,26.2076,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3641.1,3832.98,25.933,true],359.957,[-0.0095401,0.0257327,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3652.21,3833.18,25.8219,true],359.621,[-0.00969111,0.0256763,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3647.94,3859.92,25.1686,true],0.047515,[-0.00949962,0.0257477,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3647.7,3837.16,25.8305,true],269.964,[-0.025734,-0.00953184,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3643.26,3837.38,25.8257,true],269.964,[-0.025734,-0.00953184,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3643.23,3846.44,24.9405,true],269.964,[-0.025734,-0.00953184,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3647.93,3845.66,25.6211,true],269.964,[-0.025734,-0.00953184,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3643.12,3855.36,25.0293,true],268.727,[-0.0255216,-0.0100853,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3652.64,3854.97,25.8212,true],272.038,[-0.0260611,-0.0085875,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3652.02,3850.03,25.7202,true],359.621,[-0.00969111,0.0256763,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3664.12,3826.06,25.8011,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3664.07,3818.2,25.717,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3674.87,3818.55,25.6644,true],270.596,[-0.0258372,-0.00924772,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3659.4,3825.52,25.8479,true],180.579,[0.00925367,-0.0258309,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3670.06,3833.53,25.9279,true],180.547,[0.00925892,-0.0051561,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3661.18,3833.43,25.7989,true],175.895,[0.00963274,-0.00437793,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3670.31,3816.09,25.5278,true],180.547,[0.00925892,-0.0051561,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3674.92,3809.58,25.6352,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3674.5,3828.88,25.7733,true],268.536,[-0.0254882,-0.0101716,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3679.72,3825.59,24.7819,true],178.214,[0.00945823,-0.00477321,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3681.43,3816.5,25.1072,true],180.547,[0.00925892,-0.0051561,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3684.85,3821.44,25.1207,true],268.536,[-0.0254882,-0.0101716,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3684.78,3811.56,24.9681,true],271.541,[-0.0259863,-0.00882013,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3679.93,3807.26,24.3868,true],180.547,[0.00925892,-0.0051561,0.999944]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3664.96,3810.29,25.7332,true],252.209,[-0.0216009,-0.0169252,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3672.95,3806.82,25.5794,true],0.517239,[-0.00928451,0.0258249,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3669.21,3802.13,25.5681,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3665.59,3801.8,25.5026,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3669.08,3793.26,25.3075,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3665.47,3792.83,25.371,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3673.11,3789.43,25.2474,true],0.517239,[-0.00928451,0.0258249,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3673.77,3796.43,25.0641,true],0.517239,[-0.00928451,0.0258249,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3679.76,3792.26,24.9782,true],237.477,[-0.0165863,-0.02186,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3673.24,3782.93,24.2948,true],358.061,[-0.0103827,0.0254033,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3685.47,3785.5,25.1952,true],37.5637,[0.00814602,0.0262059,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3687.05,3779.31,24.8657,true],0.451844,[-0.00931403,0.0258143,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3664.38,3783.47,24.2824,true],358.061,[-0.0103827,0.0254033,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3678.09,3779,25.1428,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3677.91,3770.4,24.7863,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3682.49,3770.12,24.771,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3682.53,3775.45,24.8146,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3661.2,3795.63,25.5955,true],358.061,[-0.0103827,0.0254033,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3656.34,3791.34,25.5323,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3677.22,3761.45,24.2695,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3683.32,3761.57,24.599,true],271.109,[-0.0259191,-0.00901843,0.999623]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[3680.22,3757.1,24.5583,true],180.153,[0.00944678,-0.0257627,0.999623]] call InitStruct; 
_3584_588623826_7485417_15080 = ['BlockBrick',[3584.59,3826.75,17.1508],1.98631,[0,0,1], {_thisObj setvariable ['model','Land_Canal_WallSmall_10m_F'];}] call InitDecor; // !!! realocated model !!!
['LargeConcreteWallWithReinforcement',[3688.97,3781.28,24.4259,true],97.6445,[0.0267715,0.00601348,0.999623]] call InitStruct; 
['BigConcreteWallDestroyed',[3840.85,3953.99,35.1507],90,[0,0,1]] call InitStruct; 
_3834_363283995_9812028_31307 = ['Decor',[3834.36,3995.98,28.3131],275.787,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\canal_wall_d_right_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3867_723393835_2512212_68082 = ['Decor',[3867.72,3835.25,15.6094,true],[0.753679,-0.654066,-0.0645369],[0.0763886,-0.0103543,0.997024], {_thisObj setvariable ['model','a3\structures_f\walls\canal_wall_d_right_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3877_723393857_0510313_83736 = ['Decor',[3877.72,3857.05,16.7106,true],[-0.995397,0.0845998,-0.0450258],[-0.047161,-0.0234115,0.998613], {_thisObj setvariable ['model','a3\structures_f\walls\canal_wall_d_right_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3884_423343875_5810511_82901 = ['Decor',[3884.42,3875.58,14.6902,true],[0.952587,-0.129009,-0.275562],[0.273069,-0.0369792,0.961283], {_thisObj setvariable ['model','a3\structures_f\walls\canal_wall_d_right_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BigLightWall',[3574.49,3838.43,20.3473],357.25,[0,0,1]] call InitStruct; 
['BigLightWall',[3571.26,3834.34,25.1331,true],182.927,[-0.00529171,0.00720262,0.99996]] call InitStruct; 
['BigLightWall',[3575.2,3828.74,25.1118,true],272.873,[0.0071919,0.0053008,0.99996]] call InitStruct; 
['WoodenOfficeTable',[3796.05,3949.11,19.7939],90.6906,[0,0,1]] call InitStruct; 
['WoodenOfficeTable',[3796.64,3977.78,24.4423],7.61516,[0,0,1]] call InitStruct; 
['WoodenOfficeTable',[3803.05,4007.44,27.6045],267.085,[0,0,1]] call InitStruct; 
['WoodenOfficeTable',[3832.11,3975.42,27.1551],7.61516,[0,0,1]] call InitStruct; 
['WoodenOfficeTable',[3853.18,3935.96,23.5822],0,[0,0,1]] call InitStruct; 
['MetalTank',[3611.6,3778.76,18.8085,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['MetalTank',[3611.63,3782.25,18.6803,true],178.919,[-0.00579217,0.00681934,0.99996]] call InitStruct; 
['MetalTank',[3611.77,3789.45,18.907,true],178.919,[-0.00579217,0.00681934,0.99996]] call InitStruct; 
['MetalTank',[3611.52,3786.2,18.6544,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['StripedChair',[3793.51,3991.56,29.8751],180.604,[0,0,1]] call InitItem; 
['StripedChair',[3793.4,3988.86,29.8976],359.406,[0,0,1]] call InitItem; 
['StripedChair',[3795.17,3988.78,29.8572],358.306,[0,0,1]] call InitItem; 
['StripedChair',[3790.83,3988.11,29.8547],0.507642,[0,0,1]] call InitItem; 
['StripedChair',[3795.16,3991.49,29.799],180.604,[0,0,1]] call InitItem; 
['StripedChair',[3791.52,3988.18,29.8623],357.088,[0,0,1]] call InitItem; 
['StripedChair',[3877.77,3998.43,22.7847],267.452,[0,0,1]] call InitItem; 
['StripedChair',[3861.05,4002.81,22.5021],91.5794,[0,0,1]] call InitItem; 
['StripedChair',[3863.11,4002.71,22.5001],270.616,[0,0,1]] call InitItem; 
['WoodenChair',[3868.26,3994.83,22.5099],115.93,[0,0,1]] call InitItem; 
['WoodenChair',[3868.24,3996.01,22.5056],87.4884,[0,0,1]] call InitItem; 
['WoodenChair',[3861.81,3994.37,22.5023],174.5,[0,0,1]] call InitItem; 
['WoodenChair',[3861.17,3996.29,22.5003],0,[0,0,1]] call InitItem; 
['WoodenChair',[3867.45,3994.06,22.5298],163.653,[0,0,1]] call InitItem; 
['WoodenChair',[3862.56,3994.75,22.5016],178.082,[0,0,1]] call InitItem; 
['WoodenChair',[3866.91,4004.61,22.4978],272.305,[0,0,1]] call InitItem; 
['WoodenChair',[3866.87,4005.12,22.4975],356.646,[0,0,1]] call InitItem; 
['WoodenChair',[3867.94,4005.25,23.0045],2.73732,[0,0,1]] call InitItem; 
['WoodenChair',[3867.43,4005.2,23.0013],0,[0,0,1]] call InitItem; 
['WoodenChair',[3805.97,4006.91,24.2639],358.654,[0,0,1]] call InitItem; 
['WoodenChair',[3844.96,3954.56,22.3178],359.348,[0,0,1]] call InitItem; 
['WoodenChair',[3863.98,3954.91,16.9955],179.967,[0,0,1]] call InitItem; 
['WoodenChair',[3862.54,3999.21,22.5217],58.3905,[0,0,1]] call InitItem; 
['WoodenChair',[3862.18,3997.43,22.4599],178.082,[0,0,1]] call InitItem; 
['WoodenChair',[3806.13,4005.37,24.1575],180.645,[0,0,1]] call InitItem; 
_3777_463383988_3510733_23666 = ['Decor',[3777.46,3988.35,33.2367],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\carpet_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_725833981_9626533_13938 = ['Decor',[3781.73,3981.96,33.1394],90.1632,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\carpet_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_300783967_114264_92780 = ['Decor',[3710.3,3967.11,10.3012,true],262.28,[-0.0175579,-0.00978,0.999798], {_thisObj setvariable ['model','a3\structures_f\civ\constructions\wheelcart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3713_160893967_542724_93402 = ['Decor',[3713.16,3967.54,10.3074,true],262.28,[-0.0175579,-0.00978,0.999798], {_thisObj setvariable ['model','a3\structures_f\civ\constructions\wheelcart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_381843967_948244_92065 = ['Decor',[3715.38,3967.95,10.294,true],82.5259,[0.0175904,0.00971492,0.999798], {_thisObj setvariable ['model','a3\structures_f\civ\constructions\wheelcart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['MediumClothCanopy',[3870.33,4090.83,23.639],28.5206,[0,0,1]] call InitStruct; 
['MediumClothCanopy',[3878.37,4068.95,23.9247],356.174,[0,0,1]] call InitStruct; 
['SmallClothShelter',[3888.58,3986.18,21.7961],180.496,[0,0,1]] call InitStruct; 
['ElectricalTransformer',[3870.13,3950.06,16.5733],184.333,[0,0,1]] call InitStruct; 
['StreetLamp',[3806.02,3979.22,25.4699],61.5245,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp527501",_thisObj];
}] call InitStruct; 
['StreetLamp',[3799.04,3973.8,23.7211],68.125,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp960143",_thisObj];
}] call InitStruct; 
['StreetLamp',[3795.01,4020.2,22.122],180.67,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp862849",_thisObj];
}] call InitStruct; 
['StreetLamp',[3835.07,3982.79,22.5549],209.028,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp677578",_thisObj];
}] call InitStruct; 
['StreetLamp',[3819.24,3999.69,23.3096],136.479,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp127348",_thisObj];
}] call InitStruct; 
['StreetLamp',[3823.36,3979.75,22.9051],0.0828579,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp523280",_thisObj];
}] call InitStruct; 
['StreetLamp',[3815.73,3993.09,23.734],205.364,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp309553",_thisObj];
}] call InitStruct; 
['StreetLamp',[3825.49,4011.77,22.6629],218.205,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp5111",_thisObj];
}] call InitStruct; 
['StreetLamp',[3844.41,3932.82,19.2583],349.455,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp848884",_thisObj];
}] call InitStruct; 
['StreetLamp',[3850.38,3956.21,19.058],345.292,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp958271",_thisObj];
}] call InitStruct; 
['StreetLamp',[3846.08,3956.98,22.0773],317.833,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp24839",_thisObj];
}] call InitStruct; 
['StreetLamp',[3853.18,3973.22,22.5734],345.292,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp656328",_thisObj];
}] call InitStruct; 
['StreetLamp',[3876.34,3987.67,17.9758],151.593,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp134473",_thisObj];
}] call InitStruct; 
['StreetLamp',[3886.08,3987.53,18.0906],228.855,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp901674",_thisObj];
}] call InitStruct; 
['StreetLamp',[3896.68,4010.89,16.195],202.423,[0,0,1], {go_editor_globalRefs set ["Imported StreetLamp854465",_thisObj];
}] call InitStruct; 
['SmallSheetMetalHouse',[3825.57,3987.73,25.1027],271.445,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3865.9,3852.66,9.00653],279.364,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3869.73,3984.27,22.1118],357.708,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3846.77,3983.3,24.3629],178.73,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3845,3977,24.2639],0,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3863.62,4094.06,23.8654],28.9112,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3858.63,4072.63,24.2122],270.017,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse',[3848.45,4078.06,24.1208],357.927,[0,0,1]] call InitStruct; 
_3830_003424041_5112324_49607 = ['Decor',[3830,4041.51,24.4961],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_023193840_711188_84827 = ['Decor',[3862.02,3840.71,8.84827],32.5695,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3893_473393800_671149_40089 = ['Decor',[3893.47,3800.67,9.40089],269.721,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3889_023193811_911139_09595 = ['Decor',[3889.02,3811.91,9.09595],271.834,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_139404071_2041025_17518 = ['Decor',[3842.14,4071.2,30.597,true],[0.845455,-0.511858,0.152341],[-2.67755e-08,0.285257,0.958451], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallSheetMetalHouse2',[3837.3,3974.26,24.5436],0,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3855.35,3973.7,24.8963],0,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3866.99,4084.62,24.196],179.526,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3884.65,3821.67,9.24041],92.4831,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3893.44,3985.88,21.7236],268.953,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3883.87,4070.85,23.8756],266.043,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[3883.51,4074.57,23.9289],266.043,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[3834.86,4042.21,24.4224],0,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[3848.35,4053.51,24.1299],0,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[3880.74,3835.34,8.76837],31.9462,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[3819.65,4068.75,24.1731],0,[0,0,1]] call InitStruct; 
['SmallRuinedWoodenBuilding',[3829.2,4079.45,29.5478,true],[-0.998762,-0.049743,-6.62636e-07],[0.00669409,-0.13442,0.990902]] call InitStruct; 
['ChurchPrayHouse',[3927.2,3957.27,20.3968],180.248,[0,0,1]] call InitStruct; 
['ChurchPrayHouse',[3573.87,3794.86,20.8265,true],267.338,[-0.0217135,0.0221734,0.999518]] call InitStruct; 
['ChurchSmallHouse',[3800.84,3949.36,20.1834],89.375,[0,0,1]] call InitStruct; 
['MetalCup',[3803.27,4008.15,28.4251],0,[0,0,1]] call InitItem; 
['RegistratorPanelReceiver',[3831.21,4010.55,24.3468],180.396,[0,0,1], {go_editor_globalRefs set ["_paperPress",_thisObj];
}] call InitStruct; 
_3833_713383972_8911124_45447 = ['WoodenMedicalBox',[3833.71,3972.89,24.4545],274.608,[0,0,1]] call InitStruct; 
['WoodenMedicalBox',[3816.28,3973.52,27.0622],180.305,[0,0,1]] call InitStruct; 
_3840_383303933_2211925_47657 = ['WoodenWeaponBox',[3840.38,3933.22,25.4766],178.814,[0,0,1]] call InitStruct; 
['OrangeCarpet1',[3805.18,4005.85,27.6815],266.872,[0,0,1]] call InitStruct; 
['OrangeCapet',[3777.21,3985.44,33.3223],0,[0,0,1]] call InitStruct; 
['OrangeCapet',[3794.63,3951.41,19.8255],0,[0,0,1]] call InitStruct; 
['OrangeCapet',[3783.08,3990.41,33.3187],91.3405,[0,0,1]] call InitStruct; 
['OrangeCapet',[3782.33,3981.91,29.7888],0.0900788,[0,0,1]] call InitStruct; 
['OrangeCapet',[3861.83,4005.45,28.7335,true],[-0.0239592,-0.00352831,0.999707],[0.0122466,-0.99992,-0.00323556]] call InitStruct; 
['OrangeCapet',[3805.98,4008.59,24.2465],0,[0,0,1]] call InitStruct; 
['FabricBagBig1',[3870.51,3994.81,22.0594],269.495,[0,0,1]] call InitItem; 
['FabricBagBig1',[3851.77,4080.97,24.4466],36.7297,[0,0,1]] call InitItem; 
['FabricBagBig2',[3870.56,3995.8,22.0443],264.413,[0,0,1]] call InitItem; 
['FabricBagBig2',[3869.46,4005.25,22.4966],52.3466,[0,0,1]] call InitItem; 
['FabricBagBig2',[3873.87,4002.65,22.0272],87.0687,[0,0,1]] call InitItem; 
['FabricBagBig2',[3863.1,3955.85,16.9968],79.7324,[0,0,1]] call InitItem; 
_3835_133303985_0212427_91166 = ['IStruct',[3835.13,3985.02,27.9117],254.88,[0,0,1], {_thisObj setvariable ['model','ml_shabut\burzhuika\burzhuika.p3d'];}] call InitStruct; // !!! realocated model !!!
_3775_553223990_4311533_26997 = ['LargeClothCabinet',[3775.55,3990.43,33.27],268.888,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3775_523193985_5810533_29116 = ['LargeClothCabinet',[3775.52,3985.58,33.2912],269.363,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['LargeClothCabinet',[3805.2,4003.71,27.5899],177.941,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3877_793214002_6411122_68407 = ['LargeClothCabinet',[3877.79,4002.64,22.6841],89.8506,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3788_403323976_3410624_56436 = ['RegistrationPaperArchive',[3788.4,3976.34,24.5644],190.525,[0,0,1]] call InitStruct; 
_3833_260014009_8059128_80827 = ['RegistrationPaperArchive',[3833.26,4009.81,28.8083],179.981,[0,0,1]] call InitStruct; 
['SurgeryBlueTable',[3823.02,3976.21,24.1833],90.8278,[0,0,1]] call InitStruct; 
['SurgeryBlueTable',[3651.68,3857.91,17.9482],90.8278,[0,0,1]] call InitStruct; 
['CoinBag',[3787.48,3996.98,36.419,true],231.51,[-0.000540493,-0.000429455,1]] call InitItem; 
['CoinBag',[3802.96,4007.99,28.4176],323.717,[0,0,1]] call InitItem; 
['SteamBarrel',[3834.11,3974.43,24.2895],96.4481,[0,0,1]] call InitStruct; 
['WoodenSmallShelf',[3869.68,3999.54,22.4986],179.774,[0,0,1]] call InitStruct; 
_3794_513433990_2211929_71576 = ['Decor',[3794.51,3990.22,29.7158],180.083,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\barikada_3.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3772.02,3969.12,36.4662,true],332.167,[0.00406676,-0.00345591,0.999986]] call InitDecor; 
['BlockStone',[3769.94,3978.27,37.0119],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3783.87,3958.72,28.7904],14.9003,[0,0,1]] call InitDecor; 
['BlockStone',[3801.4,3956.39,19.7508],0,[0,0,1]] call InitDecor; 
['BlockStone',[3791.16,3957.01,19.7614],186.046,[0,0,1]] call InitDecor; 
['BlockStone',[3801.43,3945.93,19.6898],0,[0,0,1]] call InitDecor; 
['BlockStone',[3800.8,3966.7,19.8759],0,[0,0,1]] call InitDecor; 
['BlockStone',[3791.36,3946.03,19.6756],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3791.6,3937.64,29.1771],19.8301,[0,0,1]] call InitDecor; 
['BlockDirt',[3804.92,3938.33,29.0253],332.624,[0,0,1]] call InitDecor; 
['BlockStone',[3793.4,3967.6,28.9167],352.102,[0,0,1]] call InitDecor; 
['BlockDirt',[3784.19,3947.56,29.2079],347.326,[0,0,1]] call InitDecor; 
['BlockStone',[3794.17,3987.01,43.0769,true],0,[0.00565508,-0.00692906,0.99996]] call InitDecor; 
['BlockBrick',[3801.36,3976.97,24.4223],0,[0,0,1]] call InitDecor; 
['BlockStone',[3794.28,3992.44,29.893],0,[0,0,1]] call InitDecor; 
['BlockStone',[3792.73,3977.7,38.0799],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3801.85,3987.38,24.2423],1.5558,[0,0,1]] call InitDecor; 
['BlockStone',[3794.27,3997.87,37.7394],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3788.55,3970.58,38.3909,true],291.672,[0.00534085,0,0.999986]] call InitDecor; 
['BlockDirt',[3780.66,3973.04,28.443,true],[0.0100531,-0.990067,-0.140238],[0,-0.140245,0.990117]] call InitDecor; 
['BlockStone',[3793.68,4007.84,32.6797],359.064,[0,0,1]] call InitDecor; 
['BlockStone',[3800.25,4007.74,24.0544],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800.46,4018.17,24.0691],269.107,[0,0,1]] call InitDecor; 
['BlockStone',[3783.97,4007.57,32.6934],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3798.44,4029.27,24.5135],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.09,4017.62,23.9369],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3788.07,4028.78,34.4758],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3788.18,4027.86,44.3146],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3798.3,4047.09,44.419],243.027,[0,0,1]] call InitDecor; 
['BlockDirt',[3798.03,4047.31,34.1425],243.813,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.43,4039.29,44.2252],296.367,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.55,4039.69,34.3913],296.622,[0,0,1]] call InitDecor; 
['BlockDirt',[3798.47,4039.79,24.2699],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3839.79,3839.77,8.61501],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3836.81,3835.42,18.2536],311.783,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.89,3850.54,8.6771],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3833.89,3847.3,18.4671],283.173,[0,0,1]] call InitDecor; 
['BlockStone',[3832.57,3936.29,32.1735],0,[0,0,1]] call InitDecor; 
['BlockStone',[3832.43,3946.47,32.1969],0,[0,0,1]] call InitDecor; 
['BlockStone',[3832.71,3966.61,34.1304],0,[0,0,1]] call InitDecor; 
['BlockStone',[3832.38,3966.84,24.3375],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3811.31,3958.7,28.978],7.3807,[0,0,1]] call InitDecor; 
['BlockStone',[3811.18,3966.87,30.0561],359.349,[0,0,1]] call InitDecor; 
['BlockStone',[3832.59,3956.67,32.2221],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3811.24,3949.52,28.804],354.454,[0,0,1]] call InitDecor; 
['BlockBrick',[3811.89,3976.92,24.3653],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3822.1,3987.57,24.2768],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3832.52,3976.9,24.3783],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3821.99,3976.95,24.2881],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3812,3987.53,24.5013],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3832.47,3997.95,24.3427],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3821.97,3997.88,24.3584],0,[0,0,1]] call InitDecor; 
['BlockStone',[3811.12,3998.43,24.3122],0,[0,0,1]] call InitDecor; 
['BlockStone',[3810.83,4008.97,24.1352],0,[0,0,1]] call InitDecor; 
['BlockStone',[3821.23,4019.01,24.2314],0,[0,0,1]] call InitDecor; 
['BlockStone',[3831.79,4019.3,24.3126],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3822.03,4008.43,24.2638],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3832.54,4008.5,24.2481],0,[0,0,1]] call InitDecor; 
['BlockStone',[3810.92,4018.73,24.0465],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3831.19,4029.59,24.3091],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3809.64,4029.44,24.5123],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.54,4039.97,24.3786],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.24,4040.67,24.3786],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.02,4049.94,34.2527],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.41,4050.04,24.135],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.49,4039.93,24.3786],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.25,4049.7,43.8827],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3809.68,4039.96,24.2687],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.37,4060.32,24.0154],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3841.17,4053.46,32.1303],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.09,4051.39,42.2076],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3869.75,3805.19,8.69971],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3851.13,3802.1,17.2785],337.897,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.83,3805.43,8.69081],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3862.42,3831.97,27.9092,true],[0.0822638,0.996611,6.52671e-06],[0.228402,-0.0188595,0.973384]] call InitDecor; 
['BlockDirt',[3850.66,3838.62,8.63517],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3861.58,3838.09,8.76191],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3871.57,3815.56,18.5478],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3871.33,3826.24,8.59003],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3861.08,3816.62,8.74378],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3851.41,3821.61,18.5093],0,[0,0,1]] call InitDecor; 
['BlockStone',[3850.44,3812.78,18.28],13.2498,[0,0,1]] call InitDecor; 
['BlockDirt',[3873.08,3824.22,26.3387],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.32,3827.14,8.66364],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3871.2,3832.01,29.0662],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3872.08,3837.17,8.82136],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3865.25,3859.81,28.8068],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3862.68,3848.87,8.824],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3865.65,3867.84,27.206],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3854.53,3860.03,18.6377],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3851.76,3849.4,8.69726],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3865.59,3870.65,9.02271],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3855.34,3870.17,18.5694],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3863.94,3859.82,8.92227],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3865.19,3889.98,18.0039],267.297,[0,0,1]] call InitDecor; 
['BlockDirt',[3865.3,3880.63,8.98772],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3855.97,3880.43,18.5828],93.1277,[0,0,1]] call InitDecor; 
['BlockDirt',[3866.6,3879.87,23.6785],183.369,[0,0,1]] call InitDecor; 
['BlockStone',[3842.36,3936.02,21.93],0,[0,0,1]] call InitDecor; 
['BlockStone',[3852.42,3930.26,31.8805],0,[0,0,1]] call InitDecor; 
['BlockStone',[3842.25,3927.04,31.8817],0,[0,0,1]] call InitDecor; 
['BlockStone',[3852.78,3967.13,34.2927],0,[0,0,1]] call InitDecor; 
['BlockStone',[3852.93,3966.77,24.3756],0,[0,0,1]] call InitDecor; 
['BlockStone',[3852.57,3956.69,17.0352],0,[0,0,1]] call InitDecor; 
['BlockStone',[3842.57,3956.02,22.2022],0,[0,0,1]] call InitDecor; 
['BlockStone',[3863.28,3967.91,33.9833],86.4024,[0,0,1]] call InitDecor; 
['BlockStone',[3852.92,3950.52,22.1803],0,[0,0,1]] call InitDecor; 
['BlockStone',[3842.66,3966.84,22.4266],0,[0,0,1]] call InitDecor; 
['BlockStone',[3861.89,3958.88,31.156],0,[0,0,1]] call InitDecor; 
['BlockStone',[3842.37,3946.51,22.0305],0,[0,0,1]] call InitDecor; 
['BlockStone',[3852.76,3939.92,22.0325],0,[0,0,1]] call InitDecor; 
['BlockStone',[3861.31,3939.78,32.2021],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3842.7,3987.58,24.4535],0,[0,0,1]] call InitDecor; 
['BlockStone',[3862.66,3977.58,24.6435],0,[0,0,1]] call InitDecor; 
['BlockStone',[3864.46,3988.21,22.1981],0,[0,0,1]] call InitDecor; 
['BlockStone',[3843.01,3976.83,24.4382],0,[0,0,1]] call InitDecor; 
['BlockStone',[3853.29,3987.7,24.4888],0,[0,0,1]] call InitDecor; 
['BlockStone',[3873.19,3999.17,22.0835],0,[0,0,1]] call InitDecor; 
['BlockBrick',[3853.12,3976.91,24.4306],0,[0,0,1]] call InitDecor; 
['BlockStone',[3872.75,3978.23,31.1728],86.4024,[0,0,1]] call InitDecor; 
['BlockDirt',[3842.24,4019.41,24.1549],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3851.86,4019.94,43.8368],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3852.43,4019.76,33.9981],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3851.6,4029.85,43.7107],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3852.08,4029.82,33.872],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3841.57,4029.68,24.3348],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.66,4050.77,23.8776],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.17,4040.06,24.21],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.36,4050.82,32.3873],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.86,4040.29,33.2626],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,4051.04,24.1598],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.29,4061.23,32.2778],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.12,4061.81,23.8837],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.71,4061.78,32.129],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.54,4040.1,42.8347],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3859.89,4072.44,23.8793],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.05,4071.92,32.2778],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3859.18,4094.17,24.0311],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.28,4082.85,23.9394],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3849.81,4082.55,24.3665],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.57,4071.95,23.6516],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3869.81,4093.89,24.0746],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3848.87,4092.46,32.1588],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3859.41,4083.31,23.9714],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.15,4100.43,32.3463],297.963,[0,0,1]] call InitDecor; 
['BlockDirt',[3880.5,3804.19,8.84991],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3891.18,3803.31,8.95302],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3892.11,3827.83,28.7621],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3880.95,3829.51,28.7469],13.4403,[0,0,1]] call InitDecor; 
['BlockDirt',[3900.86,3837.07,29.5823],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3881.96,3825.28,8.73567],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3883.22,3836.24,8.83393],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3904.6,3834.23,8.83021],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3892.97,3824.38,8.66206],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3881.44,3814.7,18.2894],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3905.35,3825.44,18.845],352.789,[0,0,1]] call InitDecor; 
['BlockDirt',[3893.72,3835.32,8.72481],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3891.88,3813.24,8.72336],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3875.83,3868.98,27.0457],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3885.98,3859.2,37.0906],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3875.54,3858.85,28.234],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3886.97,3867.87,26.8092],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3873.69,3847.96,8.75039],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3895.32,3846.11,8.82243],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3884.31,3847.01,8.89603],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3895.46,3868.25,7.46096,true],[0.126403,-0.984191,0.124057],[0.00741744,0.125994,0.992003]] call InitDecor; 
['BlockDirt',[3885.49,3857.89,8.9943],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3896.38,3868.45,23.4597],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3886.25,3869.08,16.398],183.348,[0,0,1]] call InitDecor; 
['BlockDirt',[3896,3856.6,8.3394,true],4.71872,[0.00712085,0.0861818,0.996254]] call InitDecor; 
['BlockDirt',[3896.51,3858.22,28.8672],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3874.44,3858.9,8.81314],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3896.62,3847.33,31.1895],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3875.86,3869.3,16.8522],183.348,[0,0,1]] call InitDecor; 
['BlockDirt',[3887.92,3878.61,23.706],183.369,[0,0,1]] call InitDecor; 
['BlockStone',[3897.59,3888.26,16.1366],282.763,[0,0,1]] call InitDecor; 
['BlockStone',[3885.99,3888.99,17.2214],267.297,[0,0,1]] call InitDecor; 
['BlockDirt',[3896.65,3879.39,6.23232,true],[-0.0587712,-0.998271,2.69013e-06],[0.115475,-0.00679566,0.993287]] call InitDecor; 
['BlockDirt',[3877.76,3879.2,24.1091],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3875.43,3880.07,7.81628,true],[-0.0579275,-0.998271,0.00999541],[0.170038,0,0.985438]] call InitDecor; 
['BlockDirt',[3886.42,3879.9,7.28247],1.07793,[0,0,1]] call InitDecor; 
['BlockStone',[3876.62,3889.45,18.1223],279.695,[0,0,1]] call InitDecor; 
['BlockDirt',[3896.94,3878.28,22.9095],183.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3903.27,3956.54,19.6691],179.252,[0,0,1]] call InitDecor; 
['BlockDirt',[3894.12,3956.74,28.5103],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3893.98,3966.56,28.7452],90.4093,[0,0,1]] call InitDecor; 
['BlockDirt',[3904.07,3946.54,28.3995],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3903.32,3967.39,19.678],179.252,[0,0,1]] call InitDecor; 
['BlockStone',[3883.88,3999.07,22.0595],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3894.43,3988.46,21.64],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3894.5,3998.92,15.5741],0,[0,0,1]] call InitDecor; 
['BlockStone',[3883.83,3988.61,21.8407],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3904.47,3988.5,21.5907],0,[0,0,1]] call InitDecor; 
['BlockStone',[3884.17,3999.19,31.6453],0,[0,0,1]] call InitDecor; 
['BlockStone',[3873.45,3988.29,22.0104],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3904.47,3998.65,21.597],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3903.32,3978.51,20.2217,true],0,[0,-0.129297,0.991606]] call InitDecor; 
['BlockDirt',[3893.98,3976.99,30.0461],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3884.89,4009.88,21.9246],10.3196,[0,0,1]] call InitDecor; 
['BlockStone',[3874.81,4009.59,31.369],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3894.61,4009.25,15.6879],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3904.44,4009.2,21.6757],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3895.24,4019.3,31.8051],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3884.96,4009.62,31.5471],7.17808,[0,0,1]] call InitDecor; 
['BlockDirt',[3894.79,4019.66,21.8678],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3880.27,4061.5,32.3264],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3878.86,4092.17,32.1331],240.387,[0,0,1]] call InitDecor; 
['BlockDirt',[3881.74,4071.89,23.6573],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3880.89,4081.78,32.4572],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3890.39,4071.99,32.3699],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3915.47,3833.09,8.85037],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3914.53,3825.16,18.3116],3.94044,[0,0,1]] call InitDecor; 
['BlockDirt',[3905.69,3845.01,8.89231],4.7187,[0,0,1]] call InitDecor; 
['BlockStone',[3916.8,3852.02,17.4066],9.24544,[0,0,1]] call InitDecor; 
['BlockStone',[3906.86,3853.32,17.94],10.1537,[0,0,1]] call InitDecor; 
['BlockDirt',[3916.56,3843.87,8.91246],4.7187,[0,0,1]] call InitDecor; 
['BlockDirt',[3924.44,3967.3,19.6025],179.252,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.52,3956.49,19.7117],179.252,[0,0,1]] call InitDecor; 
['BlockDirt',[3933.99,3968.26,28.6351],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.57,3967.34,19.7207],179.252,[0,0,1]] call InitDecor; 
['BlockDirt',[3924.59,3956.49,19.7953],179.252,[0,0,1]] call InitDecor; 
['BlockDirt',[3924.65,3946.96,28.7888],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3934.41,3957.59,28.7073],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.39,3988.22,27.9791],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3923.6,3977.6,28.1288],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.26,3977.35,28.1446],358.683,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.2,3998.35,31.5107],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3905.4,4017.75,31.7624],23.3838,[0,0,1]] call InitDecor; 
['BlockDirt',[3913.33,4008.76,31.6477],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.9,4060.44,24.1759],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3809.64,4060.29,33.4319],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.61,4071.18,24.0268],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3848.14,4102.65,32.1868],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3867.82,4104.35,32.4443],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.55,4103.21,24.0395],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3838.74,4082.03,24.3064],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3828.81,4081.57,24.041],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3831.19,4071.02,24.2419],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.94,4071.21,24.7929,true],[-0.999879,-0.0152893,0.00302284],[0,0.193955,0.98101]] call InitDecor; 
['BlockDirt',[3840.97,4063.09,34.2886],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3837.98,4090.68,31.9395],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3812.11,4071.88,33.3643],290.953,[0,0,1]] call InitDecor; 
['BlockDirt',[3819.17,4079.92,31.2441],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3827.42,4089.57,31.9373],258.823,[0,0,1]] call InitDecor; 
['BlockDirt',[3742.34,3971.67,4.693],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3731.67,3969.99,4.719],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3720.95,3968.4,4.62144],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3752.12,3973.07,13.9475],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.46,3981.34,13.5232],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3710.26,3967.19,4.81427],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3730.04,3979.51,13.4385],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3719.31,3978.14,13.5551],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3709.11,3976.01,13.553],244.394,[0,0,1]] call InitDecor; 
['BlockDirt',[3712.56,3958.63,10.6178],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3743.65,3962.46,13.5227],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3733.49,3961.08,13.8886],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3722.66,3960.15,13.8232],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3711.61,3966.98,20.2168],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3721.44,3968.44,21.0481],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3732.1,3969.8,18.4562],261.347,[0,0,1]] call InitDecor; 
['BlockDirt',[3742.49,3971.67,22.7427],261.347,[0,0,1]] call InitDecor; 
['BlockStone',[3853.07,3950.39,32.3774],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.63,3812.19,32.3561],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.48,3822.24,32.9256],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.59,3802.06,32.4843],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.43,3791.88,28.3762],269.107,[0,0,1]] call InitDecor; 
['BlockStone',[3579.21,3792.16,13.5541],359.349,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.67,3780.43,29.0859],269.107,[0,0,1]] call InitDecor; 
['BlockStone',[3575.47,3770.58,13.4629],359.349,[0,0,1]] call InitDecor; 
['BlockDirt',[3576.45,3770.31,28.1935],269.107,[0,0,1]] call InitDecor; 
['BlockStone',[3585.94,3768.88,18.3483],359.349,[0,0,1]] call InitDecor; 
['BlockStone',[3579.19,3781.17,13.1947],359.349,[0,0,1]] call InitDecor; 
['BlockStone',[3597.2,3819.94,18.5887],359.349,[0,0,1]] call InitDecor; 
['BlockDirt',[3587.69,3819.5,33.8169],269.107,[0,0,1]] call InitDecor; 
['BlockStone',[3600.53,3809.87,18.4864],359.349,[0,0,1]] call InitDecor; 
['BlockStone',[3600.47,3802.28,18.4724],359.349,[0,0,1]] call InitDecor; 
['BlockDirt',[3610.75,3791.77,12.2927],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3611.74,3781.32,12.1795],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3621.36,3782.2,12.3184],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3598.12,3822.21,33.8637],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3620.92,3791.86,12.3613],0,[0,0,1]] call InitDecor; 
['BlockStone',[3622.38,3803.38,21.5333],359.349,[0,0,1]] call InitDecor; 
['BlockDirt',[3607.4,3827.89,33.0702],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3617.61,3828.11,32.942],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3628.17,3828.36,32.7373],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3638.49,3828.44,32.8126],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3670.05,3830.68,18.5973],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.91,3819.84,18.5284],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3680.79,3810.43,18.1616],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3649.28,3827.36,33.5642],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3659.09,3828.45,33.382],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.67,3828.32,33.4132],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.49,3810.49,18.2744],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.24,3802.69,18.221],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3666.64,3791.78,18.1248],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3677.8,3792.11,17.884],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3687.61,3781.45,17.8453],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3666.71,3781.26,17.9434],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3677.29,3781.76,17.8853],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3655.95,3780.81,18.1192],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3680.75,3820.7,18.4439],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3679.8,3821.98,31.7618],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3679.92,3811.34,32.1171],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.4,3817.8,32.2317,true],[-0.999879,-0.0149368,-0.00444897],[0,-0.28546,0.958391]] call InitDecor; 
['BlockDirt',[3680.34,3771.34,17.7194],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.43,3808.18,31.8935],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3655.58,3791.49,18.0958],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3680.74,3761.52,17.4056],269.107,[0,0,1]] call InitDecor; 
['BlockDirt',[3767.1,4007.75,23.775],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3762.75,4007.43,23.7891],358.202,[0,0,1]] call InitDecor; 
['BlockStone',[3773.8,3998.57,32.6296,true],355.52,[-0.0224719,-0.0407426,0.998917]] call InitDecor; 
['BlockStone',[3765.24,3997.28,33.3053],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3776.57,4007.22,23.8241],180.563,[0,0,1]] call InitDecor; 
['BlockDirt',[3768.81,4017.22,23.8164],0,[0,0,1]] call InitDecor; 
['BlockStone',[3803.38,3997.68,31.9712],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3779.65,4017.4,23.856],269.107,[0,0,1]] call InitDecor; 
['SimpleDoubleBed',[3797.12,3952.42,19.7556],0,[0,0,1]] call InitStruct; 
['HospitalBedWheels',[3814.49,3974.76,24.4192],243.953,[0,0,1]] call InitStruct; 
['HospitalBedWheels',[3820.78,3976.95,24.28],92.4297,[0,0,1]] call InitStruct; 
['HospitalBedWheels',[3820.6,3979.23,24.2412],84.8221,[0,0,1]] call InitStruct; 
['HospitalBedWheels',[3817.27,3974.45,24.476],180.511,[0,0,1]] call InitStruct; 
['HospitalBed',[3832.59,4012.36,24.3865],1.84167,[0,0,1]] call InitStruct; 
['HospitalBed',[3853.24,3940.83,23.705],90.7227,[0,0,1]] call InitStruct; 
['HospitalBed',[3848.76,3978.59,27.517],354.524,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3792.37,3975.09,24.6006],279.137,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3804.41,4008.61,27.7387],0,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3837.95,3990.48,27.583],0,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3832.8,3972.6,27.1551],279.137,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3843.22,3990.05,27.5647],0,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3848.81,3989.71,27.5971],0,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3856.68,3974.6,24.4418],0,[0,0,1]] call InitStruct; 
['SingleWhiteBed',[3875.15,4002.13,22.7847],181.344,[0,0,1]] call InitStruct; 
['GreenBed',[3838.31,3989.95,24.4261],0,[0,0,1]] call InitStruct; 
['GreenBed',[3848.5,3978.71,24.421],2.98866,[0,0,1]] call InitStruct; 
['GreenBed',[3846.92,3989.45,24.4492],0,[0,0,1]] call InitStruct; 
['CaseBedroom',[3795.83,3953.67,19.7786],268.642,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3793_663333976_1110824_60057 = ['CaseBedroom',[3793.66,3976.11,24.6006],6.74907,[0,0,1]] call InitStruct; 
['CaseBedroom',[3805.48,4009.48,27.6195],271.125,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3834_033203973_4711927_15506 = ['CaseBedroom',[3834.03,3973.47,27.1551],6.74907,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3833_653324013_1411124_42187 = ['CaseBedroom',[3833.65,4013.14,24.4219],271.653,[0,0,1]] call InitStruct; 
_3854_483403935_8010323_58717 = ['CaseBedroom',[3854.48,3935.8,23.5872],89.7373,[0,0,1]] call InitStruct; 
['CaseBedroom',[3794.8,3979.09,24.5556],196.402,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ChairLibrary',[3777.9,3986.16,29.894],221.68,[0,0,1]] call InitItem; 
['ChairLibrary',[3778.06,3984.68,29.8969],118.472,[0,0,1]] call InitItem; 
['ChairLibrary',[3779.43,3985.88,29.7022],329.728,[0,0,1]] call InitItem; 
['ChairLibrary',[3781.06,3981.96,33.2259],263.059,[0,0,1]] call InitItem; 
['Bookcase',[3776.9,3992.35,29.8858],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bookcase',[3793.03,3953.62,19.7269],358.721,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bookcase',[3863.07,4000.8,22.4805],179.145,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3791_973393947_0610419_77187 = ['ContainerGreen3',[3791.97,3947.06,19.7719],96.0876,[0,0,1]] call InitStruct; 
['ContainerGreen3',[3872.75,4002.95,22.0553],179.266,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3867_695314005_2231422_48117 = ['ContainerGreen3',[3867.7,4005.22,27.7502,true],180.541,[-0.000905735,0.000355403,1]] call InitStruct; 
['RedSteelBox',[3848.74,3980.88,24.5079],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBrownContainer',[3800.86,3945.77,20.7347],0.785188,[0,0,1]] call InitItem; 
['SteelBrownContainer',[3840.01,3991.48,28.3676],182.564,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['SteelBrownContainer',[3848.61,3976.61,24.5052],182.564,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
['SteelBrownContainer',[3844.69,3977.44,27.5331],265.878,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitItem; 
_3799_563234005_9611824_13087 = ['BoardWoodenBox',[3799.56,4005.96,24.1309],357.97,[0,0,1]] call InitStruct; 
['BoardWoodenBox',[3830.51,4011.98,24.2368],89.0391,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3852_403323939_2512223_64137 = ['BoardWoodenBox',[3852.4,3939.25,23.6414],0,[0,0,1]] call InitStruct; 
_3838_523193941_7011725_46737 = ['BoardWoodenBox',[3838.52,3941.7,25.4674],0,[0,0,1]] call InitStruct; 
['ContainerGreen4',[3840.03,3990.99,24.4252],281.324,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen4',[3843.11,3987.86,27.5844],179.184,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen4',[3851.77,3989.31,27.6263],359.25,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen4',[3848.91,3988.52,24.4507],355.244,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen4',[3900.31,3963.87,19.7798],354.895,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Bucket',[3832.98,3989.52,28.5143],0,[0,0,1]] call InitItem; 
['Bucket',[3832.51,3985.17,27.9614],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3778.56,3985.5,30.7074],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3839.34,3945.2,26.3829],0,[0,0,1]] call InitItem; 
['LiqDemitolin',[3832.63,3972.95,25.3188],0,[0,0,1]] call InitItem; 
['LiqPainkiller',[3831.47,3975.31,25.2248],0,[0,0,1]] call InitItem; 
['LiqPainkiller',[3832.44,3972.95,25.3188],0,[0,0,1]] call InitItem; 
['LiqTovimin',[3832.47,3972.76,25.3188],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.62,4000.06,23.5588],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.59,3999.41,23.2619],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.61,3998.96,23.2589],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.67,3999.36,23.558],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.59,4000.05,23.2581],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.59,3999.72,23.5592],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.63,3999.1,23.2563],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.61,3999.9,23.2578],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.61,3999.89,23.5589],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.66,3999.01,23.5615],0,[0,0,1]] call InitItem; 
['MilkBottle',[3870.82,3997.33,23.0389],0,[0,0,1]] call InitItem; 
['MilkBottle',[3870.62,3997.17,23.0313],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.67,3999.15,23.5546],0,[0,0,1]] call InitItem; 
['MilkBottle',[3870.91,3997.12,23.0405],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.6,3999.71,23.2572],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3869.59,3999.24,23.2541],0,[0,0,1]] call InitItem; 
['SpirtBottle',[3849.44,4079.74,29.5167,true],0,[0.00684429,0.00577726,0.99996]] call InitItem; 
['DoubleArmyBed',[3838.62,3935.64,25.5591],0,[0,0,1]] call InitStruct; 
['DoubleArmyBed',[3838.68,3939.15,25.5591],2.35401,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3783.34,3980.5,29.6427],180,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3781.66,3980.49,29.6457],180,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3785.01,3982.15,29.5888],270.635,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3800.12,4010.83,24.2639],358.376,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3855.2,3941.94,27.7718],180.852,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3857.5,3981.18,24.6315],270.635,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3862.49,3974.34,24.5596],270.635,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3861.55,3981.19,24.6862],270.635,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3864.93,3978.58,24.5851],270.635,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3902.41,3842.33,8.89804],199.49,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3901.12,3962.88,19.6493],176.795,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3834.34,4007.76,28.8083],182.945,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3864.84,3956.59,17.0018],179,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3789.32,3985.72,33.1601],0,[0,0,1]] call InitStruct; 
['BrickThinWallSmall',[3782.55,3984.4,33.1493],90,[0,0,1]] call InitStruct; 
['BrickThinWallWindow3',[3840.63,3955.28,25.1908],359.687,[0,0,1]] call InitStruct; 
['BrickThinWallWindow',[3860.36,3982.72,31.1379,true],0,[0.00565508,-0.00692906,0.99996]] call InitStruct; 
['BrickThinWallWindow',[3864.46,3982.74,31.1494,true],0,[0.00565508,-0.00692906,0.99996]] call InitStruct; 
['BrickThinWallDoorwayWindow',[3892.68,3808.84,8.78727],3.98848,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[3902.26,3965.78,19.6531],85.3414,[0,0,1]] call InitStruct; 
['BrickThinWallDoorwayWindow',[3906.8,3841.77,8.91211],0.234957,[0,0,1]] call InitStruct; 
['BrickThinWallTwoDoorways',[3785.08,3985.73,33.1765],0,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[3800.89,4010.74,27.6356],179.024,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[3845.91,3955.25,25.185],0.967819,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[3842.68,3940.2,25.5283],90.1646,[0,0,1]] call InitStruct; 
_3840_783203977_2211921_24537 = ['IStruct',[3840.78,3977.22,21.2454],226.192,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_rugs1_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3850_993413976_5112320_00147 = ['IStruct',[3850.99,3976.51,20.0015],98.7744,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_rugs1_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['ShuttleBag',[3799.57,4005.89,24.8969],82.0517,[0,0,1]] call InitItem; 
['BigStoneWall',[3802.34,4023.03,28.7233],177.705,[0,0,1]] call InitDecor; 
['BigStoneWall',[3782.1,4022.57,28.7397],177.705,[0,0,1]] call InitDecor; 
['BigStoneWall',[3817.67,3971.07,24.164],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3821.4,4001.75,41.041,true],[-0.0223906,0.990843,-0.133152],[0.00289708,-0.133121,-0.991096]] call InitDecor; 
['BigStoneWall',[3836.19,4004.16,28.6883],89.3699,[0,0,1]] call InitDecor; 
['BigStoneWall',[3838.99,4015.52,28.7039],180.028,[0,0,1]] call InitDecor; 
['BigStoneWall',[3822.18,4014.08,41.9828,true],[-0.0223906,0.990843,-0.133152],[0.00289708,-0.133121,-0.991096]] call InitDecor; 
['BigStoneWall',[3816.52,4004.02,28.3391],89.3699,[0,0,1]] call InitDecor; 
['BigStoneWall',[3867.38,3797.98,13.1016],4.42781,[0,0,1]] call InitDecor; 
['BigStoneWall',[3846.29,3993.56,29.1086],183.132,[0,0,1]] call InitDecor; 
['BigStoneWall',[3857.64,4002.5,23.1661],87.5376,[0,0,1]] call InitDecor; 
['BigStoneWall',[3897.53,3805.59,9.46653],274.514,[0,0,1]] call InitDecor; 
['BigStoneWall',[3888.54,3796.39,12.577],4.42781,[0,0,1]] call InitDecor; 
['BigStoneWall',[3900.92,3839.63,24.4213,true],[-0.996864,0.0791014,0.00212349],[-0.00425358,-0.0267699,-0.999633]] call InitDecor; 
['BigStoneWall',[3898.95,3825,9.62315],274.514,[0,0,1]] call InitDecor; 
['BigStoneWall',[3901.17,3853.43,9.15496],274.514,[0,0,1]] call InitDecor; 
['BigStoneWall',[3902.68,3874.93,9.2971],274.514,[0,0,1]] call InitDecor; 
['BigStoneWall',[3887.61,3981.89,21.3282],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3920.55,3837.26,8.96675],273.214,[0,0,1]] call InitDecor; 
_3813_743414015_9211423_75960 = ['Decor',[3813.74,4015.92,34.7418,true],43.5775,[-0.00589455,0.00337435,0.999977], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_083254020_0710423_36148 = ['Decor',[3812.08,4020.07,34.3437,true],51.9353,[-0.00533059,0.00418776,0.999977], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner_2.p3d'];}] call InitDecor; // !!! realocated model !!!
['BigStoneWall',[3766.01,4018.81,36.6503,true],308.517,[0.0940365,0.0033153,0.995563]] call InitDecor; 
_3572_431403807_5302713_96402 = ['IStruct',[3572.43,3807.53,13.964],277.376,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_20_turn.p3d'];}] call InitStruct; // !!! realocated model !!!
_3604_415283786_9169910_10080 = ['IStruct',[3604.42,3786.92,10.1008],97.9678,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_20_turn.p3d'];}] call InitStruct; // !!! realocated model !!!
_3616_434573774_893319_63354 = ['IStruct',[3616.43,3774.89,9.63354],7.13995,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_20_turn.p3d'];}] call InitStruct; // !!! realocated model !!!
_3627_234133786_770759_55404 = ['IStruct',[3627.23,3786.77,9.55404],278.225,[0,0,1], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall1_20_turn.p3d'];}] call InitStruct; // !!! realocated model !!!
_3585_390143825_4704614_44177 = ['IStruct',[3585.39,3825.47,25.6025,true],275.676,[0.00424033,0.0425932,0.999083], {_thisObj setvariable ['model','ca\structures\castle\a_castle_wall2_corner.p3d'];}] call InitStruct; // !!! realocated model !!!
['StationTea',[3773.55,4009.61,24.2773],0,[0,0,1]] call InitStruct; 
['ChairBigCasual',[3862,4001.79,22.3626],0,[0,0,1]] call InitItem; 
['BarChair',[3866.51,3998.35,22.4318],264.524,[0,0,1]] call InitItem; 
['BarChair',[3866.45,3999.12,22.4053],272.157,[0,0,1]] call InitItem; 
['BarChair',[3866.46,3999.99,22.3817],276.533,[0,0,1]] call InitItem; 
['BarChair',[3869.42,4004.6,22.4465],272.157,[0,0,1]] call InitItem; 
['BarChair',[3869.42,4004.13,22.4543],272.157,[0,0,1]] call InitItem; 
['ChestCabinet',[3860.83,4001.03,22.3942],89.4882,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ChestCabinet',[3808.12,4009.13,29.5926,true],0,[0.00248939,0.00109183,0.999996], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Suitcase',[3829.41,4005.02,25.2397],0,[0,0,1]] call InitItem; 
['ChurchBench',[3803.23,3953.45,19.7874],96.9382,[0,0,1]] call InitStruct; 
['ChurchBench',[3803.86,3960,19.7153],96.9382,[0,0,1]] call InitStruct; 
['ChurchBench',[3803.29,3955.31,19.7611],96.9382,[0,0,1]] call InitStruct; 
['ChurchBench',[3803.75,3957.77,19.6106],96.9382,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3829.81,4010.24,24.2298],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3829.81,4005.75,24.2446],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3833.42,4008.46,24.2435],274.174,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3833.25,4011.66,24.2396],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3832.58,4005.39,24.2429],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor1',[3828.08,4008,24.2202],0,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3833.64,3985.9,27.7592],87.6001,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3833.56,3988.65,27.7785],87.6001,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3859.84,3981.2,24.4629],270.81,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3863.6,3981.21,24.5122],270.81,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3864.85,3974.33,24.4939],273.291,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3866.32,3977.68,24.5234],359.325,[0,0,1]] call InitStruct; 
['ConcreteSmallFloor',[3860.02,3974.49,24.5717],92.2283,[0,0,1]] call InitStruct; 
['WoodenOfficeTable3',[3833.03,3998.96,24.4342],88.0797,[0,0,1]] call InitStruct; 
['WoodenOfficeTable3',[3845.18,3953.63,22.3405],358.284,[0,0,1]] call InitStruct; 
_3860_763433953_5112317_00177 = ['PowerGenerator',[3860.76,3953.51,17.0018],0,[0,0,1], {go_editor_globalRefs set ["_gen",_thisObj];
}] call InitStruct; 
['Cup',[3876.48,3998.1,23.6295],0,[0,0,1]] call InitItem; 
['Cup',[3873.57,3997.51,22.9411],282.461,[0,0,1]] call InitItem; 
['RedPappedChair',[3802.31,4007.37,27.665],268.775,[0,0,1]] call InitItem; 
['RedPappedChair',[3853.18,3936.78,23.7145],0,[0,0,1]] call InitItem; 
_3865_533203960_8410616_97067 = ['ConvertorForGenerator',[3865.53,3960.84,16.9707],88.4786,[0,0,1]] call InitStruct; 
_3791_393313949_9411619_71817 = ['SteelGreenDoor',[3791.39,3949.94,19.7182],94.1234,[0,0,1]] call InitStruct; 
_3784_893313986_7111829_39367 = ['SteelGreenDoor',[3784.89,3986.71,29.3937],90.5593,[0,0,1]] call InitStruct; 
_3808_313234005_0810524_13457 = ['SteelGreenDoor',[3808.31,4005.08,24.1346],88.0497,[0,0,1]] call InitStruct; 
_3831_663333997_5710424_18157 = ['SteelGreenDoor',[3831.66,3997.57,24.1816],1.81387,[0,0,1]] call InitStruct; 
_3828_353273977_8610824_23877 = ['SteelGreenDoor',[3828.35,3977.86,24.2388],359.289,[0,0,1]] call InitStruct; 
_3822_113283974_0510323_99897 = ['SteelGreenDoor',[3822.11,3974.05,23.999],89.8896,[0,0,1]] call InitStruct; 
_3833_143314003_2211924_14157 = ['SteelGreenDoor',[3833.14,4003.22,24.1416],355.832,[0,0,1]] call InitStruct; 
_3832_583254002_1911628_69917 = ['SteelGreenDoor',[3832.58,4002.19,28.6992],359.289,[0,0,1]] call InitStruct; 
_3842_603273955_2810122_13427 = ['SteelGreenDoor',[3842.6,3955.28,22.1343],0.186385,[0,0,1]] call InitStruct; 
_3874_303223992_9311521_91067 = ['SteelGreenDoor',[3874.3,3992.93,21.9107],0.186385,[0,0,1]] call InitStruct; 
_3784_857673986_7465833_15168 = ['SteelGreenDoor',[3784.86,3986.75,33.1517],90.5593,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[3676.14,3816.24,18.3327],182.71,[0,0,1]] call InitStruct; 
_3803_795174004_8940424_03793 = ['SteelGreenDoor',[3803.8,4004.89,24.0379],88.0497,[0,0,1]] call InitStruct; 
_3803_823004007_1550324_19521 = ['SteelGreenDoor',[3803.82,4007.16,24.1952],88.0497,[0,0,1]] call InitStruct; 
['SteelDoorThinSmall',[3801.48,3950.06,20.1519],180.96,[0,0,1]] call InitStruct; 
_3797_333253975_5112324_51737 = ['SteelDoorThinSmall',[3797.33,3975.51,24.5174],277.325,[0,0,1]] call InitStruct; 
_3841_123293949_9011225_47307 = ['SteelDoorThinSmall',[3841.12,3949.9,25.4731],179.845,[0,0,1]] call InitStruct; 
_3850_653323941_9611823_53287 = ['SteelDoorThinSmall',[3850.65,3941.96,23.5329],175.007,[0,0,1]] call InitStruct; 
_3859_103273979_9311524_54517 = ['SteelDoorThinSmall',[3859.1,3979.93,24.5452],0.409249,[0,0,1]] call InitStruct; 
_3861_743413975_7810124_40907 = ['SteelDoorThinSmall',[3861.74,3975.78,24.4091],180.96,[0,0,1]] call InitStruct; 
_3864_173343975_6611324_54917 = ['SteelDoorThinSmall',[3864.17,3975.66,24.5492],180.96,[0,0,1]] call InitStruct; 
_3864_853273976_5810524_56117 = ['SteelDoorThinSmall',[3864.85,3976.58,24.5612],88.8413,[0,0,1]] call InitStruct; 
_3863_893313979_8710924_53207 = ['SteelDoorThinSmall',[3863.89,3979.87,24.5321],357.061,[0,0,1]] call InitStruct; 
_3874_363283999_4211422_40407 = ['SteelDoorThinSmall',[3874.36,3999.42,22.4041],91.511,[0,0,1]] call InitStruct; 
_3845_889163951_3642622_23729 = ['SteelDoorThinSmall',[3845.89,3951.36,22.2373],358.637,[0,0,1]] call InitStruct; 
['CuttingBoard',[3873.01,3997.91,22.9411],0,[0,0,1]] call InitItem; 
_3826_863284004_4111328_81617 = ['SteelArmoredDoor',[3826.86,4004.41,28.8162],270.32,[0,0,1]] call InitStruct; 
['SteelArmoredDoor',[3827.61,4007.3,28.746],270.32,[0,0,1]] call InitStruct; 
['SteelArmoredDoor',[3646.35,3833.04,18.6117],180.136,[0,0,1]] call InitStruct; 
_3803_433353979_3710926_58587 = ['SteelBrownDoor',[3803.43,3979.37,26.5859],2.34221,[0,0,1]] call InitStruct; 
_3789_203373989_3911129_43227 = ['SteelBrownDoor',[3789.2,3989.39,29.4323],88.9357,[0,0,1]] call InitStruct; 
_3787_753423992_9812029_27977 = ['SteelBrownDoor',[3787.75,3992.98,29.2798],1.30685,[0,0,1]] call InitStruct; 
_3851_783203937_6411123_48287 = ['SteelBrownDoor',[3851.78,3937.64,23.4829],88.8001,[0,0,1]] call InitStruct; 
_3858_303223957_3811016_89077 = ['SteelBrownDoor',[3858.3,3957.38,16.8908],88.8001,[0,0,1]] call InitStruct; 
_3852_453373939_2612327_89747 = ['SteelBrownDoor',[3852.45,3939.26,27.8975],88.0119,[0,0,1]] call InitStruct; 
_3902_443363964_6711419_35287 = ['SteelBrownDoor',[3902.44,3964.67,19.3529],266.528,[0,0,1]] call InitStruct; 
_3862_327883956_6872616_84690 = ['SteelBrownDoor',[3862.33,3956.69,16.8469],181.425,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3674.9,3823.64,18.4344],93.5243,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3665.12,3815.7,18.436],180.104,[0,0,1]] call InitStruct; 
['Egg',[3870.8,3998.15,27.4524,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.64,3998.74,27.4054,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.78,3999,27.4068,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.68,3999.22,27.4078,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.87,3999.37,27.4123,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.62,3998.03,27.4016,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.83,3998.69,22.2682],327.261,[0,0,1]] call InitItem; 
['Egg',[3870.81,3997.84,27.4328,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.75,3998.42,27.4057,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
['Egg',[3870.76,3999.57,27.4098,true],0,[0.00565508,-0.00692906,0.99996]] call InitItem; 
_3715_427003967_935065_42207 = ['ElectricPump',[3715.43,3967.94,5.42207],263.492,[0,0,1]] call InitStruct; 
['PlywoodThinWall',[3847.21,3984.15,24.2514],89.4323,[0,0,1]] call InitStruct; 
['PlywoodThinWall',[3844.7,3976.17,24.0752],91.5119,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3830.34,4009.29,28.4082],269.569,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3831.56,4010.35,28.394],0.321407,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3828.13,4009.24,28.4464],269.569,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3902.94,3960.82,19.6036],268.558,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3905.15,3960.89,19.671],267.495,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3900.74,3960.75,19.5586],267.495,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3902.17,3966.48,20.4162],356.321,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3914.08,3964.25,19.7393],271.46,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3909.66,3964.25,19.5855],271.46,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3908.64,3965.35,19.65],1.12972,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3908.63,3968.76,19.5658],1.12972,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3911.88,3964.26,19.7166],267.761,[0,0,1]] call InitStruct; 
['SmallSteelRustyFence',[3911.09,3961.6,25.3271,true],[-0.968322,-0.245163,0.0474053],[0,0.189846,0.981814]] call InitStruct; 
['SmallSteelRustyFence',[3908.9,3961.21,25.3606,true],[-0.999044,-0.0430342,0.0076382],[0,0.17476,0.984611]] call InitStruct; 
['Flashlight',[3829.75,4006,25.0778],316.58,[0,0,1]] call InitItem; 
['Flashlight',[3829.42,4005.03,24.8004],79.6504,[0,0,1]] call InitItem; 
['Flashlight',[3830.62,4003.83,25.2366],271.445,[0,0,1]] call InitItem; 
_3582_152103775_5314915_30857 = ['IStruct',[3582.15,3775.53,20.2497,true],[0.997452,0.0664818,0.0258828],[-0.0670453,0.997517,0.0215447], {_thisObj setvariable ['model','ca\structures\misc\misc_g_pipes\misc_g_pipes.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelThinWallMedium',[3808.62,4007.33,24.2656],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3808.39,4002.83,24.1838],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3808.58,4009.15,25.1496],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3803.76,4009.44,24.2705],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3813.08,3978.9,28.0496],152.69,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3815.47,3979.94,27.0097],161.591,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3818.33,3978.85,27.0682],253.5,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3872.18,3863.31,18.5298,true],270.204,[0.00699878,-0.0050265,0.999963]] call InitStruct; 
['SteelThinWallMedium',[3870.7,3859.58,18.5479,true],187.278,[0.00699878,-0.0050265,0.999963]] call InitStruct; 
['SteelThinWallMedium',[3845.3,3976.43,27.5343],79.2594,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3843.62,3981.38,27.5308],175.398,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3842.2,3980.25,27.5536],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3843.64,3982.8,27.5296],175.398,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3849.74,3976.35,27.468],88.2682,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3842.24,3982.99,27.4398],273.186,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3849.58,3978.83,27.37],81.4727,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3848.15,3982.83,27.302],359.602,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3845.13,3978.47,27.3897],89.5821,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3847.88,3980.12,27.3931],176.299,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3866.96,4000.47,22.3122],180.046,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3866.53,4004.62,22.3735],89.8081,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3863.37,4060.39,27.5833],1.44231,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3859.2,4062.12,27.4997],88.977,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3860.6,4060.74,27.6249],10.0243,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3873.12,4087.78,27.6434],177.473,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3872.39,4086.61,32.4407,true],[0.854284,0.518794,-0.0324301],[0.10281,-0.107479,0.988877]] call InitStruct; 
['SteelThinWallMedium',[3863.4,4065.16,27.2387],8.69721,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3859.39,4064.97,27.3458],97.318,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3888.45,3839.72,13.5822,true],[0.984552,-0.127376,0.120137],[-0.121124,0,0.992637]] call InitStruct; 
['SteelThinWallMedium',[3888.81,3842.52,8.46504],97.318,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3886.56,3992.81,21.8387],81.4727,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3880.44,3990.92,21.2764],355.354,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3881.62,3992.42,21.8413],81.4727,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3889.14,3993.05,21.1891],95.8075,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3883.3,3991.16,21.8378],353.814,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3877.7,3991.13,21.2703],11.753,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3881.65,4070.4,26.5229],248.443,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3884.75,4072.33,26.5955],9.13594,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3883.53,4069.04,26.5805],177.272,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3875.2,4083.9,26.851],210.099,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3716.37,3967.93,5.60625],81.9493,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3715.23,3966.39,5.56599],351.871,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3711.2,3965.91,5.71267],351.871,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3714.81,3969.26,5.71159],351.871,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3710.76,3968.73,5.71267],351.871,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3709.61,3967.07,5.71267],81.9493,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3861.36,4000.54,22.4137],180.046,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3808.62,4009,22.4413],88.0372,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[3806.06,4005.91,22.4306],356.141,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3796,3944.94,19.4794],187.23,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3808.6,4010.42,23.4348],91.8435,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3833.26,3984.4,23.6552],180.52,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3842.89,3975.41,27.4067],202.743,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3846.54,3982.14,27.2148],98.4319,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3844.42,3978.08,27.4347],187.23,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3868.2,4001.01,22.4977],84.0636,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3866.53,4001.27,22.2208],100.617,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3860.26,4066.55,27.1429],167.219,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3888.73,3838.05,8.28587],207.082,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3889.68,3844.16,8.30806],167.219,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3886.82,3991.41,21.6781],172.355,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3881.69,4072.19,26.4941],140.014,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3863.55,4000.57,22.0665],359.237,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3864.24,4001.27,22.0693],273.303,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3864.27,4002.69,22.2072],273.303,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3807.58,4006.08,24.1237],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3804.66,4005.83,24.1098],0,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[3806.18,4006,31.715,true],[-0.0594173,0.998233,8.34465e-07],[-0.998221,-0.0594165,-0.00494317]] call InitStruct; 
['GateCity',[3822.53,4014.83,24.0988],0,[0,0,1], {go_editor_globalRefs set ["Imported GateCity963902",_thisObj];
}] call InitStruct; 
['GateCity',[3822.44,4002.37,24.2348],0,[0,0,1], {go_editor_globalRefs set ["Imported GateCity677114",_thisObj];
}] call InitStruct; 
['GateCity',[3856.3,3843.66,8.45819],275.774,[0,0,1], {go_editor_globalRefs set ["Imported GateCity716496",_thisObj];
}] call InitStruct; 
['GateCity',[3899.24,3839.28,8.65987],275.234,[0,0,1], {go_editor_globalRefs set ["Imported GateCity857140",_thisObj];
}] call InitStruct; 
['GateCity',[3918.25,3838.4,8.8744],274.279,[0,0,1], {go_editor_globalRefs set ["Imported GateCity179936",_thisObj];
}] call InitStruct; 
['GateCity',[3726.57,3969.28,4.75005],83.5738,[0,0,1], {go_editor_globalRefs set ["gate_escape",_thisObj];
}] call InitStruct; 
['BigGermoGate2',[3762.27,4005.59,31.6728,true],231.105,[-0.00104378,-0.00728249,0.999973]] call InitDecor; 
['BigGermoGate2',[3706.59,3966.35,4.72207],263.851,[0,0,1]] call InitDecor; 
['MediumDirt',[3865.02,3823.25,6.35239],7.30596,[0,0,1]] call InitStruct; 
['MediumDirt',[3861.82,4054.39,19.9784],0,[0,0,1]] call InitStruct; 
['MediumDirt',[3853.82,4094.25,20.903],0,[0,0,1]] call InitStruct; 
['MediumDirt',[3873.73,4081.12,19.792],32.1379,[0,0,1]] call InitStruct; 
['MediumDirt',[3913.23,3939.84,23.1218,true],[-0.993787,-0.110678,0.0117092],[0,0.105208,0.99445]] call InitStruct; 
['MediumDirt',[3840.18,4083.27,20.7482],32.1379,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3873.13,3809.04,8.82643],49.173,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3872.98,3956.8,21.792,true],332.9,[0,0.0418976,0.999122]] call InitStruct; 
['SmallDirtBrown',[3869.92,3954.63,21.6271,true],290.463,[0.107462,0.0448897,0.993195]] call InitStruct; 
['SmallDirtBrown',[3855.25,4054.27,23.9361],0,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3862.25,4071.43,23.9985],0,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3880.37,3800.59,9.09089],95.474,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3890.98,3823.67,8.75135],333.468,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3882.64,3855.51,13.904,true],143.828,[-0.00975548,-0.0595473,0.998178]] call InitStruct; 
['SmallDirtBrown',[3874.47,3850.87,13.6049,true],[0.98088,0.194614,-2.42144e-08],[-0.0113977,0.0574458,0.998284]] call InitStruct; 
['SmallDirtBrown',[3899.05,3880.81,11.4525,true],[0.855225,0.510292,0.0905129],[-0.0233008,-0.136612,0.990351]] call InitStruct; 
['SmallDirtBrown',[3832.45,4069.16,24.3362],296.92,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3661.99,3787.4,17.8294],0,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3673.13,3787.44,17.6043],48.0982,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3672.14,3792.46,17.6889],0,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3665.88,3823.46,18.4787],0,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3625.64,3829.26,18.6121],75.823,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3615.1,3807.64,18.4197],75.823,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3591.23,3823.88,23.8064,true],[0.0778762,-0.99695,-0.00500521],[0.064139,0,0.997941]] call InitStruct; 
['SmallDirtBrown',[3581.67,3821.48,13.6534],38.1712,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3579.97,3809.94,13.4118],95.2454,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3573.45,3823.61,14.0938],167.892,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3606.27,3804.64,18.66],176.354,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3617.85,3813.84,18.7012],139.851,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3678.19,3770.49,17.8167],351.181,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3682.32,3787.24,22.8371,true],[0.879223,-0.466517,0.0965874],[-0.196539,-0.1705,0.965558]] call InitStruct; 
['SmallDirtBrown',[3666.4,3797.87,18.0716],35.6628,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3673.88,3813.22,23.1314,true],35.7007,[0,-0.0528269,0.998604]] call InitStruct; 
['SmallDirtBrown',[3666.22,3811.83,18.165],120.085,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3673.55,3808.13,18.3865],310.132,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3683.76,3824.3,18.69],35.6628,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3682.96,3817.67,18.4363],286.757,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3642.52,3830.97,18.5124],35.6628,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3766.31,4005.2,23.6752],229.229,[0,0,1]] call InitStruct; 
['SmallDirtBrown',[3779.24,4004.18,23.3927],289.24,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3860.96,3804.75,8.84143],233.742,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3862.62,3833.7,8.85635],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3864.78,3880.7,9.18731],324.08,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3859.8,3961.01,21.7712,true],[-0.960736,-0.271801,-0.055778],[0,-0.201027,0.979586]] call InitStruct; 
['SmallDirtGrey',[3867.02,3949.91,21.5856,true],0,[0.334761,0,0.942303]] call InitStruct; 
['SmallDirtGrey',[3867.13,4083.38,24.0574],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3894.68,3829.65,8.88824],281.457,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3880.65,3862.79,14.2539,true],[-0.0288052,0.9947,0.0987033],[-0.250448,-0.102777,0.962659]] call InitStruct; 
['SmallDirtGrey',[3878.6,3842.16,8.53231],324.08,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3880.95,4075.51,23.9381],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3834.05,4075.61,28.8381,true],[0.904456,0.426567,-2.6077e-08],[-0.0525679,0.111461,0.992378]] call InitStruct; 
['SmallDirtGrey',[3823.92,4069.69,28.5519,true],[0.960926,0.27609,0.0198923],[-0.0525679,0.111461,0.992378]] call InitStruct; 
['SmallDirtGrey',[3644.77,3842.53,18.3303],331.15,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3619.39,3819.24,18.8659],272.34,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3624.61,3810.59,18.6828],275.413,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3573.41,3782.39,13.0975],0,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3583.22,3774.91,13.3346],282.639,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3582.78,3786.5,17.7855,true],[0.455961,0.887084,0.071982],[0.0499073,-0.106236,0.993088]] call InitStruct; 
['SmallDirtGrey',[3581.19,3814.88,13.5618],192.427,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3573.25,3815.93,13.5352],202.935,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3573.5,3802.95,13.4953],345.775,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3579.23,3803.46,13.4953],291.706,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3579.94,3798.29,13.4997],20.0879,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3580.82,3835.21,18.5314],192.427,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3571.75,3836.39,18.3781],192.427,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3571.93,3831.39,18.4433],348.447,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3609.48,3802.03,18.6971],353.789,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3615.7,3802.82,18.6124],205.182,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3623.97,3797.68,12.5063],205.182,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3620.17,3795.6,12.2819],126.243,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3615.49,3797.26,12.3036],252.095,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3593.6,3818.37,18.6858],167.486,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3586.13,3823.75,19.2029],5.01239,[0,0,1]] call InitStruct; 
['SmallDirtGrey',[3777.27,4016.28,23.7934],71.2225,[0,0,1]] call InitStruct; 
['Bread',[3833.5,4007.76,25.2354],55.0957,[0,0,1]] call InitItem; 
['HospitalBench',[3816.99,3979.92,24.5179],359.123,[0,0,1]] call InitStruct; 
['HospitalBench',[3818.52,3979.36,24.4472],91.0657,[0,0,1]] call InitStruct; 
_3846_763434041_2612324_51677 = ['Decor',[3846.76,4041.26,24.5168],4.02877,[0,0,1], {_thisObj setvariable ['model','ca\buildings2\houseblocks\houseblock_a\houseblock_a3_ruins.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenGraveCross',[3772.36,4004.55,29.2564,true],0,[0.0970676,-0.00185023,0.995276]] call InitStruct; 
['DestroyedPipeMedium',[3766.94,4015.16,30.1993,true],318.84,[0.0039609,0.00551491,0.999977]] call InitStruct; 
['SmallDestroyedCornerPipe',[3778.61,4008.46,29.1943,true],[0.120065,0.992766,-0.000105172],[-0.990017,0.119741,0.0743492]] call InitStruct; 
['IndPipeBroken',[3612.55,3815.13,27.3849,true],91.0464,[0.0173449,-0.00476937,0.999838]] call InitStruct; 
_3669_426033817_7221718_68207 = ['BlockDirt',[3669.43,3817.72,23.9861,true],0,[0.00566367,-0.00693192,0.99996], {_thisObj setvariable ['model','CUP_A2_indpipe1_ground2'];}] call InitDecor; // !!! realocated model !!!
['IndPipeUUP',[3659.89,3829.28,25.3376,true],88.7336,[-0.00176849,0.00655322,0.999977]] call InitStruct; 
['IndPipeUR',[3679.73,3812.04,23.5384,true],0.0034877,[-0.00325254,-0.218771,0.975771]] call InitStruct; 
['MediumRuinedPipe',[3606.54,3778,18.3537,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['MediumRuinedPipe',[3683.95,3813.64,24.2444,true],89.7691,[-0.00697674,-0.00116757,0.999975]] call InitStruct; 
_3583_051033788_3544911_48075 = ['IStruct',[3583.05,3788.35,20.3103,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','ca\buildings2\ind_pipeline\indpipe2\indpipe2_big_18ladder.p3d'];}] call InitStruct; // !!! realocated model !!!
_3582_952153788_4704613_64563 = ['IStruct',[3582.95,3788.47,22.4752,true],0,[0.00566319,-0.00693144,0.99996], {_thisObj setvariable ['model','ca\buildings2\ind_pipeline\indpipe2\indpipe2_big_18ladder.p3d'];}] call InitStruct; // !!! realocated model !!!
_3610_915283831_1057115_27426 = ['IStruct',[3610.92,3831.11,24.0621,true],269.286,[0.00747179,-0.027674,0.999589], {_thisObj setvariable ['model','ca\buildings2\ind_pipeline\indpipe2\indpipe2_big_18ladder.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigIndustrialPipesWithLadder',[3621.95,3790.28,21.4341,true],88.1593,[-0.00126008,0.00696267,0.999975]] call InitStruct; 
['BigIndustrialPipesWithLadder',[3601.81,3827.26,25.8233,true],88.1593,[-0.00126008,0.00696267,0.999975]] call InitStruct; 
_3669_668703830_2075218_81001 = ['IStruct',[3669.67,3830.21,24.3784,true],0.246087,[0.00686289,0.005748,0.99996], {_thisObj setvariable ['model','ca\structures\ind_pipeline\indpipe1\indpipe1_stair.p3d'];}] call InitStruct; // !!! realocated model !!!
_3784_706303989_3676834_75187 = ['Decor',[3784.71,3989.37,34.7519],269.758,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ml_plakats3\ironfelix.p3d'];}] call InitDecor; // !!! realocated model !!!
_3661_690193794_8830617_98355 = ['Decor',[3661.69,3794.88,23.6784,true],178.331,[-0.0025424,-0.00292092,0.999992], {_thisObj setvariable ['model','ca\structures_e\misc\misc_construction\misc_ironpipes_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['DBShotgun',[3878.26,4000.16,23.8063],347.525,[0,0,1]] call InitItem; 
['RustyCell',[3787.41,3995.35,29.6443],90.7449,[0,0,1]] call InitStruct; 
['RustyCell',[3830.83,4000.48,24.3018],0.959836,[0,0,1]] call InitStruct; 
['RustyCell',[3819.75,4006.35,28.8838],269.868,[0,0,1]] call InitStruct; 
['RustyCell',[3832.38,4005.09,28.7201],271.559,[0,0,1]] call InitStruct; 
['RustyCell',[3842.03,3933.6,21.7702],178.97,[0,0,1]] call InitStruct; 
['RustyCell',[3842.02,3939.13,21.7933],180.768,[0,0,1]] call InitStruct; 
['RustyCell',[3842.11,3944.63,21.7982],180.768,[0,0,1]] call InitStruct; 
['RustyCell',[3648.69,3853.26,24.974,true],181.789,[0,0.0258296,0.999666]] call InitStruct; 
['RustyCell',[3671.18,3786.21,24.6753,true],181.76,[-0.00271277,-0.00276594,0.999992]] call InitStruct; 
['RustyCell',[3665.49,3786.09,24.7041,true],178.331,[-0.0025424,-0.00292044,0.999992]] call InitStruct; 
['BigFileCabinet',[3803.3,4009.32,27.7387],358.543,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[3829.04,3999.6,24.3674],89.3994,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[3829.03,3999.36,24.3374],269.318,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3829.03,3997.88,24.3126],89.079,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[3829.02,4001.11,24.2918],269.318,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[3829.02,4001.41,24.315],89.3994,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['BigFileCabinet',[3829.07,4002.85,24.3331],269.318,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3853_233403936_1110824_41267 = ['Key',[3853.23,3936.11,24.4127],314.381,[0,0,1]] call InitItem; 
_3876_923343998_1611323_62947 = ['Key',[3876.92,3998.16,23.6295],87.8934,[0,0,1]] call InitItem; 
['KitchenKnife',[3873.08,3997.64,22.9411],91.7937,[0,0,1]] call InitItem; 
['KitchenKnife',[3873.1,3997.5,22.9411],104.326,[0,0,1]] call InitItem; 
_3784_533203987_8710931_44496 = ['RedButton',[3784.53,3987.87,36.4443,true],[0.0754419,-0.997054,0.0138715],[-0.997003,-0.0756624,-0.0161226], {go_editor_globalRefs set ["_sw_adminbase_1",_thisObj];
}] call InitStruct; 
['RedButton',[3802.48,3979.49,33.1273,true],[-0.999856,-0.00973026,0.0138768],[-0.00995366,0.99982,-0.0161218], {go_editor_globalRefs set ["_sw_adminhallhome",_thisObj];
}] call InitStruct; 
_3780_093263987_9311534_67156 = ['RedButton',[3780.09,3987.93,39.6709,true],[-0.0122836,0.999829,0.0138518],[0.999792,0.0125065,-0.0161186], {go_editor_globalRefs set ["_sw_adminbase_2",_thisObj];
}] call InitStruct; 
_3804_033204006_1210925_72616 = ['RedButton',[3804.03,4006.12,30.7246,true],1.46062,[0.998783,-0.0252615,-0.0423597], {go_editor_globalRefs set ["_sw_tradework",_thisObj];
}] call InitStruct; 
_3808_328864003_5336925_16447 = ['RedButton',[3808.33,4003.53,30.1648,true],[0.0351473,-0.999184,0.019924],[-0.99931,-0.0348974,0.0127519], {go_editor_globalRefs set ["_sw_tradehall",_thisObj];
}] call InitStruct; 
_3840_113283949_8610826_86696 = ['RedButton',[3840.11,3949.86,31.8699,true],[1,0.000437352,-6.0747e-06],[0.000436131,-0.995961,0.0897809], {go_editor_globalRefs set ["_sw_SecHome",_thisObj];
}] call InitStruct; 
_3819_083253976_7312025_83176 = ['RedButton',[3819.08,3976.73,30.8302,true],[0.0364433,-0.999324,0.00487247],[-0.998431,-0.0366173,-0.0423662], {go_editor_globalRefs set ["_sw_medcommon",_thisObj];
}] call InitStruct; 
_3830_193363974_8911128_57926 = ['RedButton',[3830.19,3974.89,33.5777,true],0.30364,[0.999089,-0.0050902,-0.0423732], {go_editor_globalRefs set ["_sw_medprivate",_thisObj];
}] call InitStruct; 
_3832_803223997_6911625_48516 = ['RedButton',[3832.8,3997.69,30.4836,true],[-0.995262,0.0971087,0.00484227],[0.0968185,0.9944,-0.0423627], {go_editor_globalRefs set ["_swGateLib",_thisObj];
}] call InitStruct; 
_3832_113284003_6210925_78366 = ['RedButton',[3832.11,4003.62,30.7821,true],[-0.997151,-0.075275,0.0048606],[-0.0754136,0.996252,-0.0423666], {go_editor_globalRefs set ["_swGateWork",_thisObj];
}] call InitStruct; 
_3852_093263936_8210424_94036 = ['RedButton',[3852.09,3936.82,29.9433,true],[-0.217334,0.976097,-3.66569e-06],[0.972158,0.216457,0.0897546], {go_editor_globalRefs set ["_sw_SecAdmHome",_thisObj];
}] call InitStruct; 
_3858_583253958_4311518_65177 = ['RedButton',[3858.58,3958.43,23.6547,true],3.85818e-05,[0.995965,0,0.0897457], {go_editor_globalRefs set ["_sw_GenLight",_thisObj];
}] call InitStruct; 
_3842_953373952_6210926_86427 = ['RedButton',[3842.95,3952.62,31.8672,true],3.85818e-05,[0.995965,0,0.0897457], {go_editor_globalRefs set ["_sw_SecHall",_thisObj];
}] call InitStruct; 
_3868_053224000_5112323_70726 = ['RedButton',[3868.05,4000.51,28.7102,true],[-0.9972,0.0747762,-6.62869e-06],[0.0744738,0.993176,0.0897535], {go_editor_globalRefs set ["_sw_barsign",_thisObj];
}] call InitStruct; 
_3867_703374000_5112323_69526 = ['RedButton',[3867.7,4000.51,28.6982,true],[-0.9972,0.0747762,-6.62869e-06],[0.0744738,0.993176,0.0897535], {go_editor_globalRefs set ["_sw_barstoika",_thisObj];
}] call InitStruct; 
_3867_323244000_5212423_69086 = ['RedButton',[3867.32,4000.52,28.6938,true],[-0.9972,0.0747762,-6.62869e-06],[0.0744738,0.993176,0.0897535], {go_editor_globalRefs set ["_sw_barlight",_thisObj];
}] call InitStruct; 
_3867_003424000_5510323_69136 = ['RedButton',[3867,4000.55,28.6943,true],[-0.9972,0.0747762,-6.62869e-06],[0.0744738,0.993176,0.0897535], {go_editor_globalRefs set ["_sw_barvip",_thisObj];
}] call InitStruct; 
_3870_783204003_4611823_28426 = ['RedButton',[3870.78,4003.46,28.2872,true],[0.99992,0.0126501,-2.02002e-05],[0.0126009,-0.995884,0.0897562], {go_editor_globalRefs set ["_sw_barwork",_thisObj];
}] call InitStruct; 
_3874_413333998_5112323_98516 = ['RedButton',[3874.41,3998.51,28.9881,true],1.70622,[0.995522,-0.0296537,0.0897539], {go_editor_globalRefs set ["_sw_barhome",_thisObj];
}] call InitStruct; 
_3830_853273987_2111823_29157 = ['Decor',[3830.85,3987.21,23.2916],90.7384,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\kolonkawater.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_933353990_0310129_84590 = ['LuxuryCabinet',[3775.93,3990.03,29.8459],89.6845,[0,0,1]] call InitStruct; 
_3778_553223985_6411129_77156 = ['Decor',[3778.55,3985.64,29.7716],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\koverchik.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_185793987_0415033_24361 = ['Decor',[3783.19,3987.04,33.2436],93.9652,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\koverchik.p3d'];}] call InitDecor; // !!! realocated model !!!
['OlderWoodenCup',[3832.82,3975.41,27.9758],60.7979,[0,0,1]] call InitItem; 
['OlderWoodenCup',[3861.34,3995.47,23.3487],335.383,[0,0,1]] call InitItem; 
['OlderWoodenCup',[3861.55,3994.97,23.3487],186.512,[0,0,1]] call InitItem; 
['OlderWoodenCup',[3867.51,3995.74,23.317],72.8138,[0,0,1]] call InitItem; 
['OlderWoodenCup',[3873.5,3998.16,22.9411],60.7979,[0,0,1]] call InitItem; 
['LadderBase',[3573.47,3835.05,21.3055],179.826,[0,0,1]] call InitStruct; 
['LadderBase',[3575.3,3767.71,16.4974],179.826,[0,0,1]] call InitStruct; 
['LadderBase',[3610.31,3806.49,21.609],266.646,[0,0,1]] call InitStruct; 
['LadderBase',[3607.33,3816.32,21.8226],179.826,[0,0,1]] call InitStruct; 
['LadderBase',[3682.66,3808.79,20.9643],179.826,[0,0,1]] call InitStruct; 
['LadderBase',[3687.75,3780.93,20.7919],97.4345,[0,0,1]] call InitStruct; 
['LadderBase',[3680.17,3761.87,20.3808],181.981,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3830.53,3997.11,28.461],269.079,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3823.02,3974.13,27.2107],269.855,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3825.7,3976.55,32.9107,true],2.21547,[0.100675,0.00965786,0.994873]] call InitStruct; 
['SmallSteelPlate2',[3843.78,3943.93,30.2277],270.13,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3845.24,3985.43,27.2522],0,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3851.02,3985.42,27.2435],0,[0,0,1]] call InitStruct; 
['SmallSteelPlate2',[3841.91,3985.41,27.2632],0,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3819.63,4004.68,28.8105],0,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3864,3999.71,25.12],89.8999,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3868.09,3999.76,25.1064],89.8999,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3902.72,4007.06,22.5879],87.9997,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3906.14,4007.22,22.5683],87.9997,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3855.49,4004.02,25.148],0,[0,0,1]] call InitStruct; 
_3779_003423990_6811529_94817 = ['HeadControlPanel',[3779,3990.68,29.9482],268.85,[0,0,1], {go_editor_globalRefs set ["_headcon",_thisObj];
}] call InitStruct; 
['ConcreteArch',[3793,3983.46,20.4969],270.198,[0,0,1]] call InitDecor; 
['ConcreteArch',[3792.89,3983.47,29.5686],270.198,[0,0,1]] call InitDecor; 
['ConcreteArch',[3856.02,3843.71,6.60974],184.968,[0,0,1]] call InitDecor; 
['ConcreteArch',[3900.13,3989.95,18.2721],0,[0,0,1]] call InitDecor; 
['ConcreteArch',[3903.6,3973.39,17.1293],87.1668,[0,0,1]] call InitDecor; 
['ConcreteArch',[3904.85,3993.66,18.1981],87.1668,[0,0,1]] call InitDecor; 
['OldLongTunnel',[3913.95,3938.12,17.9969],90.9611,[0,0,1]] call InitDecor; 
['ConcreteGreenSmallFloor',[3840.36,3932.92,25.0503],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[3840.37,3937.92,25.0477],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[3840.38,3947.77,25.0192],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[3840.38,3942.89,25.0169],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[3840.36,3952.74,24.9191],0,[0,0,1]] call InitStruct; 
['ConcreteGreenSmallFloor',[3845.34,3952.73,24.9378],0,[0,0,1]] call InitStruct; 
_3809_863283972_8310529_44327 = ['Decor',[3809.86,3972.83,35.0301,true],[0,-0.00926766,0.999957],[0,-0.999957,-0.00926766], {_thisObj setvariable ['model','metro_ob\model\l19_cell_type_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_183353972_7810129_50675 = ['Decor',[3825.18,3972.78,35.094,true],[0,0.0558915,0.998437],[0,-0.998437,0.0558915], {_thisObj setvariable ['model','metro_ob\model\l19_cell_type_03.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampWall',[3805.74,4004.39,32.1749,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall912514",_thisObj];
}] call InitStruct; 
['LampWall',[3801.83,4005.49,32.1743,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall530585",_thisObj];
}] call InitStruct; 
['LampWall',[3805.99,4008.84,32.1622,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall97324",_thisObj];
}] call InitStruct; 
['LampWall',[3840.12,3936.54,33.2524,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall338809",_thisObj];
}] call InitStruct; 
['LampWall',[3840.47,3953.02,32.9982,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall242546",_thisObj];
}] call InitStruct; 
['LampWall',[3840.6,3946.11,33.3157,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall981747",_thisObj];
}] call InitStruct; 
['LampWall',[3840.45,3942.93,33.2396,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall162515",_thisObj];
}] call InitStruct; 
['LampWall',[3814.22,3977.28,31.8057,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall953697",_thisObj];
}] call InitStruct; 
['LampWall',[3820.78,3974.72,32.2121,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall493836",_thisObj];
}] call InitStruct; 
['LampWall',[3831.74,4000.34,31.7599,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall189793",_thisObj];
}] call InitStruct; 
['LampWall',[3830.98,4005.99,31.755,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall244287",_thisObj];
}] call InitStruct; 
['LampWall',[3833.24,4011.49,31.7337,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall580698",_thisObj];
}] call InitStruct; 
['LampWall',[3866.11,3952.07,19.0404],183.699,[0,0,1]] call InitStruct; 
['LampWall',[3854.32,3940.72,35.6995,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall122905",_thisObj];
}] call InitStruct; 
['LampWall',[3871.49,3951.47,24.6632,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall324354",_thisObj];
}] call InitStruct; 
['LampWall',[3866.53,3958.3,24.6532,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall435541",_thisObj];
}] call InitStruct; 
['LampWall',[3861.81,3955.53,24.6931,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall625366",_thisObj];
}] call InitStruct; 
['LampWall',[3845.61,3954.06,32.8756,true],90,[0,1,-4.37114e-08], {go_editor_globalRefs set ["Imported LampWall449694",_thisObj];
}] call InitStruct; 
['LampCeiling',[3777.12,3988.53,35.4011],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling315928",_thisObj];
}] call InitStruct; 
['LampCeiling',[3787.4,3995.77,32.0371],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling491427",_thisObj];
}] call InitStruct; 
['LampCeiling',[3782.22,3985.71,32.4739],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling33082",_thisObj];
}] call InitStruct; 
['LampCeiling',[3787.2,3986.46,32.5075],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling980749",_thisObj];
}] call InitStruct; 
['LampCeiling',[3777.63,3988.9,32.5518],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling856506",_thisObj];
}] call InitStruct; 
['LampCeiling',[3794.31,3985.42,32.1198],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling686773",_thisObj];
}] call InitStruct; 
['LampCeiling',[3782.46,3982.39,32.3688],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling125000",_thisObj];
}] call InitStruct; 
['LampCeiling',[3794.81,3990.32,32.3566],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling286957",_thisObj];
}] call InitStruct; 
['LampCeiling',[3791.18,3977.34,26.9381],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling732907",_thisObj];
}] call InitStruct; 
['LampCeiling',[3782.31,3981.99,35.9456],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling666555",_thisObj];
}] call InitStruct; 
['LampCeiling',[3795.45,3976.54,27.0125],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling838025",_thisObj];
}] call InitStruct; 
['LampCeiling',[3801.68,3982.23,28.9754],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling176782",_thisObj];
}] call InitStruct; 
['LampCeiling',[3782.51,3987.86,36.0709],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling432651",_thisObj];
}] call InitStruct; 
['LampCeiling',[3801.7,3982.46,31.9698],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling927113",_thisObj];
}] call InitStruct; 
['LampCeiling',[3808.09,4016.44,26.4225],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling264769",_thisObj];
}] call InitStruct; 
['LampCeiling',[3801.44,4006.22,30.1821],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling250516",_thisObj];
}] call InitStruct; 
['LampCeiling',[3832.19,3974.24,26.6066],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling547543",_thisObj];
}] call InitStruct; 
['LampCeiling',[3811.81,3999.34,26.3556],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling273917",_thisObj];
}] call InitStruct; 
['LampCeiling',[3840.62,3985.33,27.0058],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling734320",_thisObj];
}] call InitStruct; 
['LampCeiling',[3833.82,3988.17,29.9272],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling142153",_thisObj];
}] call InitStruct; 
['LampCeiling',[3830.66,3999.38,32.4178],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling385116",_thisObj];
}] call InitStruct; 
['LampCeiling',[3826.76,3974.67,29.9195],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling336516",_thisObj];
}] call InitStruct; 
['LampCeiling',[3815.71,3976.78,32.0584],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling841910",_thisObj];
}] call InitStruct; 
['LampCeiling',[3825.03,3976.24,26.5209],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling802733",_thisObj];
}] call InitStruct; 
['LampCeiling',[3832.53,3974.29,29.9059],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling921580",_thisObj];
}] call InitStruct; 
['LampCeiling',[3821.74,3976.03,30.7938],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling477663",_thisObj];
}] call InitStruct; 
['LampCeiling',[3811.48,4006.87,26.3384],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling618496",_thisObj];
}] call InitStruct; 
['LampCeiling',[3822.42,4004.73,32.1946],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling877246",_thisObj];
}] call InitStruct; 
['LampCeiling',[3831.23,4007.95,32.5745],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling71870",_thisObj];
}] call InitStruct; 
['LampCeiling',[3842.72,3952.24,24.5625],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling194730",_thisObj];
}] call InitStruct; 
['LampCeiling',[3844.83,3945.39,24.8374],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling695369",_thisObj];
}] call InitStruct; 
['LampCeiling',[3849.3,3938.31,26.5722],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling34896",_thisObj];
}] call InitStruct; 
['LampCeiling',[3853.37,3937.88,26.7198],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling673548",_thisObj];
}] call InitStruct; 
['LampCeiling',[3852.2,3943.59,26.6277],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling193459",_thisObj];
}] call InitStruct; 
['LampCeiling',[3849.14,3938.12,29.9181],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling896946",_thisObj];
}] call InitStruct; 
['LampCeiling_Red',[3864.35,3996.13,24.6998],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling_Red714931",_thisObj];
}] call InitStruct; 
['LampCeiling',[3856.55,3986.61,29.0813],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling113425",_thisObj];
}] call InitStruct; 
['LampCeiling',[3843.13,3972.76,26.8778],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling493290",_thisObj];
}] call InitStruct; 
['LampCeiling',[3861.07,3977.83,27.2193],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling322389",_thisObj];
}] call InitStruct; 
['LampCeiling',[3851.03,3985.35,27.0455],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling78688",_thisObj];
}] call InitStruct; 
['LampCeiling',[3868.03,3999.15,24.6698],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling972617",_thisObj];
}] call InitStruct; 
['LampCeiling',[3872.06,4000.84,25.1784],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling897890",_thisObj];
}] call InitStruct; 
['LampCeiling',[3867.71,4002.86,24.8309],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling923377",_thisObj];
}] call InitStruct; 
['LampCeiling_Red',[3861.99,4002.44,25.0141],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling_Red840405",_thisObj];
}] call InitStruct; 
['LampCeiling',[3881.58,3989.82,24.9747],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling603949",_thisObj];
}] call InitStruct; 
['LampCeiling',[3873.94,3990.35,25.3681],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling461642",_thisObj];
}] call InitStruct; 
['LampCeiling',[3876.51,4001.16,25.4205],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling358156",_thisObj];
}] call InitStruct; 
_3845_869143952_8059124_62250 = ['LampCeiling',[3845.87,3952.81,24.6225],0,[0,0,1], {go_editor_globalRefs set ["Imported LampCeiling194730 (1)",_thisObj];
}] call InitStruct; 
['Bench2',[3774.9,4009.81,29.1346,true],266.038,[-0.00146182,0.00692074,0.999975]] call InitStruct; 
['Bench2',[3773.76,4008.12,29.0487,true],357.569,[0.00695253,0.00127783,0.999975]] call InitStruct; 
['Bench2',[3773.31,4010.98,29.0018,true],357.569,[0.00695253,0.00127783,0.999975]] call InitStruct; 
['SleepingMatras',[3843.99,3976.05,27.5729],0,[0,0,1]] call InitStruct; 
['SleepingMatras',[3848.21,3982.07,27.5642],0,[0,0,1]] call InitStruct; 
['SleepingMatras',[3843.58,3982.09,27.6262],176.292,[0,0,1]] call InitStruct; 
['SleepingMatras',[3900.36,3967.06,19.8025],265.062,[0,0,1]] call InitStruct; 
_3843_693363983_5112327_50847 = ['Decor',[3843.69,3983.51,27.5085],87.0441,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
['SteelMedicalBox',[3831.97,3975.5,25.2248],0,[0,0,1]] call InitItem; 
['SteelMedicalBox',[3813.88,3978.54,27.939],153.176,[0,0,1]] call InitItem; 
['MedicalBag',[3831.38,3972.79,30.4932,true],345.325,[-0.0244618,0.0268099,0.999341]] call InitItem; 
['MedicalBag',[3831.78,3972.65,30.4976,true],356.83,[-0.0186228,0.0311505,0.999341]] call InitItem; 
['MedicalBag',[3830.98,3972.6,30.4791,true],0,[-0.0168716,0.0321326,0.999341]] call InitItem; 
_3811_633303977_5710425_43587 = ['WallmountedMedicalCabinet',[3811.63,3977.57,25.4359],245.781,[0,0,1]] call InitStruct; 
_3827_223393977_7011725_57367 = ['WallmountedMedicalCabinet',[3827.22,3977.7,25.5737],358.33,[0,0,1]] call InitStruct; 
['WallmountedMedicalCabinet',[3812.7,3975.8,28.3712],245.781,[0,0,1]] call InitStruct; 
_3855_373293941_8510724_73707 = ['WallmountedMedicalCabinet',[3855.37,3941.85,24.7371],2.84635,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3814.21,3976.08,24.442],328.834,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3815.16,3976.32,24.442],2.75034,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3813.39,3975.57,24.4322],328.834,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3815.37,3978.14,24.4066],73.0715,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3814.94,3979.05,24.3998],56.2109,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3819.27,3977.46,24.3689],93.6995,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3817.3,3975.71,24.4105],0,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3819.28,3979.58,24.2635],86.7729,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3644.44,3856.09,18.2581],67.9209,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3646.91,3856.11,18.2381],292.104,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3644.29,3857.22,18.2787],91.5727,[0,0,1]] call InitStruct; 
['MedicalCurtainSmall',[3647.18,3857.39,18.2433],79.485,[0,0,1]] call InitStruct; 
_3842_253423936_4211425_55867 = ['SteelBlueCase',[3842.25,3936.42,25.5587],88.146,[0,0,1]] call InitStruct; 
_3842_273193935_8911125_55867 = ['SteelBlueCase',[3842.27,3935.89,25.5587],88.146,[0,0,1]] call InitStruct; 
_3842_283203935_3210425_53367 = ['SteelBlueCase',[3842.28,3935.32,25.5337],88.146,[0,0,1]] call InitStruct; 
_3842_233403936_9511725_55867 = ['SteelBlueCase',[3842.23,3936.95,25.5587],88.146,[0,0,1]] call InitStruct; 
['SteelBlueCase',[3651.66,3850.84,23.2746,true],178.395,[0.00350743,0.000106762,0.999994], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier1_2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[3670.04,3795.55,22.9839,true],0,[0.00114471,-0.00698257,0.999975], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SteelBlueCase',[3670.39,3795.56,23.2982,true],[-0.00459589,0.999989,-0.000268579],[0.999972,0.00459738,0.0058666], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallSteelPlate',[3797.07,3943.1,22.7574],0,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3838.66,3985.68,27.4335],180.408,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3822.81,3975.97,27.3783],91.3542,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3820.53,3974.97,32.3251,true],[-0.0071143,-0.999975,-0.0005846],[-0.0818964,0,0.996641]] call InitStruct; 
['SmallSteelPlate',[3847.34,3959.45,22.1679],268.693,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3847.96,3981.41,27.17],359.258,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3848.14,3985.99,27.4266],270.034,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3710.49,3967.19,5.60897],262.276,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3712.85,3967.5,5.6162],262.276,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3715.22,3967.84,5.60789],262.276,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3710.43,3967.17,8.47091],262.276,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3712.79,3967.48,8.47815],262.276,[0,0,1]] call InitStruct; 
['SmallSteelPlate',[3715.15,3967.82,8.46983],262.276,[0,0,1]] call InitStruct; 
['NormalClayWall',[3838.14,3934.27,22.6966],274.286,[0,0,1]] call InitStruct; 
['NormalClayWall',[3838.64,3944.3,22.7651],274.286,[0,0,1]] call InitStruct; 
['NormalClayWall',[3838.38,3939.25,22.7159],271.002,[0,0,1]] call InitStruct; 
['NormalClayWall',[3839.76,3947.28,22.9762],353.67,[0,0,1]] call InitStruct; 
['NormalClayWall',[3838.82,3955.28,23.1594],357.33,[0,0,1]] call InitStruct; 
['NormalClayWall',[3840.11,3950.61,22.8549],29.5245,[0,0,1]] call InitStruct; 
['NormalClayWall',[3836.92,3989.52,34.0902,true],[0.999975,0.00169667,-0.00686744],[-0.00690829,0.0253736,-0.999654]] call InitStruct; 
['NormalClayWall',[3832.85,3977.01,34.748,true],[-0.19373,-0.980096,0.0433752],[-0.0159994,-0.0410507,-0.999029]] call InitStruct; 
['NormalClayWall',[3834.8,3974.18,34.6504,true],[0.996963,0.0646862,0.0433644],[0.0437766,-0.00496943,-0.999029]] call InitStruct; 
['NormalClayWall',[3867.38,3842.66,14.974,true],95.8832,[-0.00530921,0.016087,0.999857]] call InitStruct; 
['NormalClayWall',[3867.03,3847.56,14.8724,true],76.0384,[-0.010455,0.0133294,0.999856]] call InitStruct; 
['NormalClayWall',[3846.33,3955.27,23.1238],2.9098,[0,0,1]] call InitStruct; 
['NormalClayWall',[3842.23,3989.06,34.0259,true],[0.999975,0.00169667,-0.00686744],[-0.00690829,0.0253736,-0.999654]] call InitStruct; 
['NormalClayWall',[3852.71,3988.89,30.6682,true],90.0811,[-0.00690829,0.0154679,0.999857]] call InitStruct; 
['NormalClayWall',[3847.69,3989.22,33.9579,true],[0.999975,0.00169667,-0.00686744],[-0.00690829,0.0253736,-0.999654]] call InitStruct; 
['NormalClayWall',[3842.21,3988.9,30.7017,true],90.0811,[-0.00690829,0.0154679,0.999857]] call InitStruct; 
['NormalClayWall',[3852.64,3989.01,33.9634,true],[0.999975,0.00169667,-0.00686744],[-0.00690829,0.0253736,-0.999654]] call InitStruct; 
['NormalClayWall',[3848,3988.96,30.704,true],90.0811,[-0.00690829,0.0154679,0.999857]] call InitStruct; 
['NormalClayWall',[3873.29,4077.33,24.4711],177.031,[0,0,1]] call InitStruct; 
['NormalClayWall',[3868.46,4086.26,24.1686],91.1263,[0,0,1]] call InitStruct; 
['NormalClayWall',[3859.81,4093.07,23.327],118.37,[0,0,1]] call InitStruct; 
['NormalClayWall',[3870.84,4078.98,24.4342],91.1263,[0,0,1]] call InitStruct; 
['NormalClayWall',[3882.04,3807.68,15.301,true],271.889,[0.00640561,-0.0156725,0.999857]] call InitStruct; 
['NormalClayWall',[3874.83,4070.85,24.5804],270.788,[0,0,1]] call InitStruct; 
['NormalClayWall',[3826.84,4074.41,29.8304,true],33.2238,[0.0102273,-0.0438082,0.998988]] call InitStruct; 
['NormalClayWall',[3826.48,4073.97,29.8665,true],33.2238,[0.0102273,-0.0438082,0.998988]] call InitStruct; 
['LuxuryClayWall',[3873.23,3801.67,14.7716,true],274.482,[-0.00724506,-0.00516572,0.99996]] call InitStruct; 
['LuxuryClayWall',[3844.07,3838.31,14.5361,true],83.8181,[-0.00724506,-0.00516572,0.99996]] call InitStruct; 
['LuxuryClayWall',[3853.33,3840.56,14.8223,true],10.3309,[-0.00724506,-0.00516572,0.99996]] call InitStruct; 
['LuxuryClayWall',[3846.36,3840.95,14.7353,true],169.895,[-0.00724506,-0.00516572,0.99996]] call InitStruct; 
['LuxuryClayWall',[3920.36,3955.06,26.1487,true],90.4713,[0.00685907,0.00566949,0.99996]] call InitStruct; 
['LuxuryClayWall',[3922.9,3952.36,26.1106,true],179.743,[0.00574234,-0.00680699,0.99996]] call InitStruct; 
['LuxuryClayWall',[3925.19,3955.05,26.0234,true],88.0475,[0.00661494,0.00595849,0.99996]] call InitStruct; 
_3785_533203991_1411129_32367 = ['Decor',[3785.53,3991.14,29.3237],91.562,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_473393996_0112329_56867 = ['Decor',[3785.47,3996.01,29.5687],91.562,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3787_473393997_9611829_56466 = ['Decor',[3787.47,3997.96,29.5647],182.45,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_253423995_5910629_56086 = ['Decor',[3789.25,3995.59,29.5609],269.843,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_913333974_1411124_68106 = ['Decor',[3834.91,3974.14,31.0936,true],271.377,[0.000855271,-0.00701642,0.999975], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_183353977_1010724_67477 = ['Decor',[3832.18,3977.1,24.6748],190.088,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_443363977_9411624_65753 = ['Decor',[3824.44,3977.94,31.0701,true],0,[-0.00694635,0,0.999976], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_443363835_361089_27896 = ['Decor',[3855.44,3835.36,9.27896],274.838,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3867_013433823_381109_41613 = ['Decor',[3867.01,3823.38,9.41613],274.528,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_833253832_801039_27257 = ['Decor',[3857.83,3832.8,9.27257],3.78507,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_933353816_971197_93765 = ['Decor',[3861.93,3816.97,7.93765],187.827,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_423343851_931159_67025 = ['Decor',[3855.42,3851.93,9.67025],75.2977,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_193363935_6511228_00106 = ['Decor',[3852.19,3935.65,28.0011],267.529,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_923343943_0012228_04496 = ['Decor',[3851.92,3943,28.045],88.4465,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['SteelSmallDoubleLadder',[3900.33,4002.43,21.1338],358.34,[0,0,1]] call InitStruct; 
['ClayWallBig',[3795.71,3954.14,20.7999],4.08292,[0,0,1]] call InitStruct; 
['ClayWallBig',[3798.38,3951.17,21.4014],89.0528,[0,0,1]] call InitStruct; 
['ClayWallBig',[3798.66,3943.86,21.3944],265.458,[0,0,1]] call InitStruct; 
['ClayWallBig',[3791.31,3945.94,21.3914],269.934,[0,0,1]] call InitStruct; 
['ClayWallBig',[3795.62,3942.14,21.5077],4.08292,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3791.53,3952.63,26.6479,true],92.3593,[-0.000746455,0.00703629,0.999975]] call InitStruct; 
['ClayWallSmall',[3792.87,3954.11,25.9631,true],174.102,[0.00684143,0.00175089,0.999975]] call InitStruct; 
['ClayWallSmall',[3795.51,3946.42,25.1525,true],94.862,[-0.000441638,0.00706153,0.999975]] call InitStruct; 
['ClayWallSmall',[3797.2,3948.1,25.1785,true],343.25,[-0.00640422,-0.00300193,0.999975]] call InitStruct; 
['ClayWallSmall',[3787.77,3976.36,31.4912,true],98.4809,[0,0.00707568,0.999975]] call InitStruct; 
['ClayWallBig',[3805.36,4010.94,25.0014],358.049,[0,0,1]] call InitStruct; 
['ClayWallBig',[3819.21,3980.38,26.1517],0.19764,[0,0,1]] call InitStruct; 
['ClayWallBig',[3812.66,3975.54,24.5889],244.781,[0,0,1]] call InitStruct; 
['ClayWallBig',[3830.69,3984.41,25.3844],357.795,[0,0,1]] call InitStruct; 
['ClayWallBig',[3833.55,3984.58,28.6157],359.209,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3813.11,3978.89,26.2732],334.205,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3829.9,3973.55,29.1234],93.7536,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3822.3,3978.63,30.8795,true],91.1862,[-0.000889964,0.00701958,0.999975]] call InitStruct; 
['ClayWallBig',[3871.78,3843.54,7.88034],94.0283,[0,0,1]] call InitStruct; 
['ClayWallBig',[3870.36,3862.82,10.6225],96.5579,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3851.94,3935.19,25.6359],268.511,[0,0,1]] call InitStruct; 
['ClayWallBig',[3854.5,3941.73,24.8671],2.90434,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3851.74,3940.26,25.4736],268.511,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3871.53,3992.99,28.8838,true],0,[-0.0069996,-0.00102977,0.999975]] call InitStruct; 
['ClayWallBig',[3867.8,4005.84,24.4972],359.209,[0,0,1]] call InitStruct; 
['ClayWallBig',[3862.64,4005.72,24.5054],359.209,[0,0,1]] call InitStruct; 
['ClayWallBig',[3857.23,4054.05,31.1233,true],[0.942956,0.329514,-0.0474873],[0.0502964,0,0.998734]] call InitStruct; 
['ClayWallBig',[3857.21,4087.92,25.5089],172.822,[0,0,1]] call InitStruct; 
['ClayWallBig',[3865.01,4077.07,24.1797],359.037,[0,0,1]] call InitStruct; 
['ClayWallBig',[3887.91,3801.3,8.88683],85.3912,[0,0,1]] call InitStruct; 
['ClayWallBig',[3878.24,3993.51,23.8741],350.335,[0,0,1]] call InitStruct; 
['ClayWallBig',[3878.62,3996.37,23.8678],275.788,[0,0,1]] call InitStruct; 
['ClayWallBig',[3878.57,4001.44,23.7417],263.946,[0,0,1]] call InitStruct; 
['ClayWallSmall',[3844.27,3953.18,28.1018,true],[-0.999224,0.00023577,-0.0393821],[0.000752274,0.999914,-0.0131009]] call InitStruct; 
['ClayWallBig',[3847.79,3953.21,29.891,true],[-0.999201,-0.0107966,0.0384693],[-0.0108046,0.999942,-4.37088e-08]] call InitStruct; 
_3613_754153815_1965320_29643 = ['IStruct',[3613.75,3815.2,25.3451,true],359.952,[-0.00650829,0.026171,0.999636], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_nolc_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['MetalAndConcreteRuins',[3781.29,4018,23.8495],0,[0,0,1]] call InitStruct; 
['Meat',[3870.71,3998.27,23.0913],0,[0,0,1]] call InitItem; 
['Meat',[3870.72,3999.15,23.1],113.285,[0,0,1]] call InitItem; 
['Meat',[3870.59,3998.69,23.0961],225.102,[0,0,1]] call InitItem; 
['Meat',[3870.71,3999.65,23.0959],185.169,[0,0,1]] call InitItem; 
['BedOld2',[3867.72,3974.58,24.6136],178.022,[0,0,1]] call InitStruct; 
['BedOld2',[3849.69,3989.69,24.3693],270.654,[0,0,1]] call InitStruct; 
['BedOld2',[3845.32,3982.88,24.5023],270.113,[0,0,1]] call InitStruct; 
['BedOld2',[3858.92,3981.43,24.7227],270.654,[0,0,1]] call InitStruct; 
['BedOld2',[3783.67,3981.8,33.08],2.26351,[0,0,1]] call InitStruct; 
['BedOld2',[3865.85,3955.28,17.0018],183.322,[0,0,1]] call InitStruct; 
['BedOld',[3858.04,3974.15,24.723],0,[0,0,1]] call InitStruct; 
['BedOld',[3866.27,3979.45,24.6779],88.1509,[0,0,1]] call InitStruct; 
['BedOld',[3865.85,3981.29,24.5862],0.940592,[0,0,1]] call InitStruct; 
_3803_313234007_3811028_42756 = ['MerchantConsole',[3803.31,4007.38,28.4276],267.468,[0,0,1], {go_editor_globalRefs set ["Imported MerchantConsole963969",_thisObj];
}] call InitStruct; 
_3854_565193942_2876028_11157 = ['AmmoBoxPBM',[3854.57,3942.29,28.1116],269.907,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\patroni.p3d'];}] call InitItem; // !!! realocated model !!!
_3878_163334000_5012223_34427 = ['AmmoBoxShotgunNonLethal',[3878.16,4000.5,23.3443],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\patroni.p3d'];}] call InitItem; // !!! realocated model !!!
['BlackSmallStove',[3878.57,3995.81,22.0105],3.78554,[0,0,1]] call InitStruct; 
['SmallStoveGrill',[3876.35,3996.77,21.9154],0,[0,0,1]] call InitStruct; 
['CampfireBig',[3914.42,3834,8.71744],0,[0,0,1]] call InitStruct; 
['CampfireBigDisabled',[3773.64,4009.64,23.8024],0,[0,0,1]] call InitStruct; 
['SignMedical',[3817.69,3981.05,26.6483],83.5384,[0,0,1], {go_editor_globalRefs set ["Imported SignMedical564417",_thisObj];
}] call InitStruct; 
_3587_541753818_7939515_52967 = ['IStruct',[3587.54,3818.79,20.5318,true],89.0474,[0.000711743,9.42447e-05,1], {_thisObj setvariable ['model','cup\terrains\cup_terrains_buildings\platform\platform_stairs_30.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallTrashCan',[3809.04,4006.34,24.1093],178.85,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3841.28,3956.07,22.2054],274.348,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3825.88,3978.67,24.2913],271.336,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3845.99,3942.61,22.0245],183.434,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3850,3981.38,24.4199],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3841.9,3980.96,24.3746],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallTrashCan',[3866.88,3992.18,22.2358],94.9104,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['Briefcase',[3803.07,4005.81,27.6567],352.406,[0,0,1]] call InitItem; 
['Briefcase',[3829.41,4003.74,24.7805],174.182,[0,0,1]] call InitItem; 
['Briefcase',[3876.69,3999.14,23.5957],0,[0,0,1]] call InitItem; 
_3824_493413993_9611820_80097 = ['IStruct',[3824.49,3993.96,20.801],74.2884,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3810_183353989_5510320_80417 = ['IStruct',[3810.18,3989.55,20.8042],324.462,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3834_733403979_1911620_11337 = ['IStruct',[3834.73,3979.19,20.1134],201.746,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3825_323244007_1010720_03397 = ['IStruct',[3825.32,4007.1,20.034],83.5415,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3822_863284007_2612320_28567 = ['IStruct',[3822.86,4007.26,20.2857],240.323,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_3863_543213988_7211920_15277 = ['IStruct',[3863.54,3988.72,20.1528],275.046,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['MeatGrinder',[3873.06,3998.35,22.9278],178.483,[0,0,1]] call InitStruct; 
['BigVentilationTurbine',[3784.11,3987.76,43.6685],325.658,[0,0,1]] call InitStruct; 
['BigVentilationTurbine',[3838.81,3842.77,18.2253,true],[-0.120319,0.825664,-0.551182],[-0.976999,-1.86723e-05,0.213244]] call InitStruct; 
['BigVentilationTurbine',[3893.65,3998.38,35.1895],325.658,[0,0,1]] call InitStruct; 
_3823_503424006_5112328_66142 = ['Decor',[3823.5,4006.51,33.7782,true],0,[0.999401,0,0.0346029], {_thisObj setvariable ['model','ml_shabut\exodusss\prowod_shabut.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_523194006_3610828_64157 = ['Decor',[3821.52,4006.36,28.6416],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodusss\prowod_shabut.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallGrayStone',[3776.57,4004.43,28.8206,true],0,[-0.00659628,-0.00161913,0.999977]] call InitStruct; 
['RadioBaikal',[3830.83,4005.14,24.8929],2.32906,[0,0,1]] call InitItem; 
['RadioBaikal',[3830.43,4005.09,25.3357],176.09,[0,0,1]] call InitItem; 
['RadioBaikal',[3830.45,4005.2,24.8797],90.1036,[0,0,1]] call InitItem; 
['RadioBaikal',[3830.32,4005.2,24.8797],81.2506,[0,0,1]] call InitItem; 
_3807_173344037_0510324_88520 = ['Decor',[3807.17,4037.05,29.8345,true],176.098,[-0.00216501,0.00643591,0.999977], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_12_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3894_453373853_8310510_28569 = ['Decor',[3894.45,3853.83,15.2307,true],273.067,[-0.00216501,0.00643591,0.999977], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_12_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_461674059_0429724_22821 = ['Decor',[3821.46,4059.04,29.1719,true],92.2832,[-0.00216501,0.00643591,0.999977], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_12_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallPileOfBricks',[3773.28,4018.84,29.388,true],[0,0.99439,-0.105779],[-0.175494,0.104137,0.978957]] call InitStruct; 
_3828_423344009_6711425_11897 = ['PowerSwitcher_Activator',[3828.42,4009.67,25.119],88.8806,[0,0,1], {go_editor_globalRefs set ["_gateact_internal",_thisObj];
}] call InitStruct; 
_3828_433354010_0012225_10857 = ['PowerSwitcher_Activator',[3828.43,4010,25.1086],88.8806,[0,0,1], {go_editor_globalRefs set ["_gateact_external",_thisObj];
}] call InitStruct; 
_3829_693364005_9411629_78737 = ['PowerSwitcher_Activator',[3829.69,4005.94,29.7874],88.8806,[0,0,1], {go_editor_globalRefs set ["_swact_gatejailtemp",_thisObj];
}] call InitStruct; 
_3846_183353945_3811023_45517 = ['PowerSwitcher_Activator',[3846.18,3945.38,23.4552],269.789,[0,0,1], {go_editor_globalRefs set ["_act_jaildoor",_thisObj];
}] call InitStruct; 
_3843_536623955_1259823_23887 = ['PowerSwitcher',[3843.54,3955.13,23.2389],181.142,[0,0,1], {go_editor_globalRefs set ["_sw_SecHallLower",_thisObj];
}] call InitStruct; 
['SignBar',[3866.79,3991.27,30.8216,true],93.1458,[-0.00722932,-0.00527062,0.99996], {go_editor_globalRefs set ["Imported SignBar8232",_thisObj];
}] call InitStruct; 
['Crutch',[3830.83,3972.3,27.5405],0,[0,0,1]] call InitItem; 
['Crutch',[3830.86,3972.5,27.5405],180.951,[0,0,1]] call InitItem; 
['Crutch',[3830.32,3976.8,30.0368,true],[0.980895,-0.194537,-0.000396743],[-0.189083,-0.953872,0.233184]] call InitItem; 
['Crutch',[3830.61,3976.64,30.0165,true],[0.983585,-0.169357,0.062279],[-0.179892,-0.893304,0.411883]] call InitItem; 
['SugarShaker',[3870.87,4000.36,23.0427],0,[0,0,1]] call InitItem; 
['SaltShaker',[3870.77,4000.17,23.0403],0,[0,0,1]] call InitItem; 
_3870_903324000_0310123_04120 = ['PepperShaker',[3870.9,4000.03,23.0412],0,[0,0,1], {_thisObj setvariable ['model','relicta_models2\food\s_salt\s_salt.p3d'];}] call InitItem; // !!! realocated model !!!
['SugarShaker',[3870.77,4000.35,23.0428],0,[0,0,1]] call InitItem; 
['SaltShaker',[3870.9,4000.18,23.0404],0,[0,0,1]] call InitItem; 
_3870_793214000_0310123_04101 = ['PepperShaker',[3870.79,4000.03,23.041],0,[0,0,1], {_thisObj setvariable ['model','relicta_models2\food\s_salt\s_salt.p3d'];}] call InitItem; // !!! realocated model !!!
['HoochMachine',[3875.15,3997.05,22.1451],185.204,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3903.04,4006.98,22.5673],86.0081,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3903.04,4008.63,22.5492],86.0081,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3903.16,4005.56,22.5523],86.0081,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3906.28,4007.37,22.5518],264.091,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3906.14,4008.86,22.5198],264.091,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3906.43,4005.97,22.5338],264.091,[0,0,1]] call InitStruct; 
['WoodenToiletSmall',[3777.92,4005.04,23.8526],303.68,[0,0,1]] call InitStruct; 
['SteelSmallShelf',[3806.98,4010.68,24.2104],87.3829,[0,0,1]] call InitStruct; 
['SteelSmallShelf',[3804.98,4010.63,24.2207],90.2,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3787.36,3996.96,29.7657],90.1379,[0,0,1]] call InitStruct; 
_3785_883303992_0610433_28727 = ['SteelGreenCabinet',[3785.88,3992.06,33.2873],90.1379,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3799.84,4004.12,24.1233],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier2_3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3854_433353936_5310127_99822 = ['SteelGreenCabinet',[3854.43,3936.53,27.9982],268.038,[0,0,1]] call InitStruct; 
_3648_864013858_6816418_30062 = ['SteelGreenCabinet',[3648.86,3858.68,18.3006],77.7658,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3664.58,3791.21,18.12],177.869,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3822_103274032_6611325_54935 = ['Decor',[3822.1,4032.66,31.5174,true],84.2776,[-0.00636027,-0.00237347,0.999977], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3837_103274027_1711425_56627 = ['Decor',[3837.1,4027.17,31.5328,true],0,[-0.0154596,-0.00692834,0.999856], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_693364082_3310523_90117 = ['Decor',[3858.69,4082.33,23.9012],1.00133,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_577644059_5712924_74564 = ['Decor',[3833.58,4059.57,30.7122,true],0,[-0.0154596,-0.00692834,0.999856], {_thisObj setvariable ['model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['CurtainElectronic',[3777.32,3983.48,27.1467],0,[0,0,1]] call InitStruct; 
['CurtainElectronic',[3782.31,3980.76,27.0178],180.268,[0,0,1]] call InitStruct; 
['LuxuryRedCurtain',[3784.61,3981.73,27.0014],89.6924,[0,0,1]] call InitStruct; 
['LuxuryRedCurtain',[3780.18,3981.62,27.0514],89.6924,[0,0,1]] call InitStruct; 
['LuxuryRedCurtain',[3850.15,3841.41,5.23101],10.0914,[0,0,1]] call InitStruct; 
['LuxuryRedCurtain',[3864.47,4004.63,21.9022],278.628,[0,0,1]] call InitStruct; 
['Sink',[3784.65,3984.47,39.2282,true],90.0004,[-0.00102983,0.00699553,0.999975]] call InitStruct; 
['Sink',[3838.43,3943.59,31.6853,true],270.001,[0.00103027,-0.0069902,0.999975]] call InitStruct; 
['FryingPan',[3873.07,3996.9,22.9411],354.625,[0,0,1]] call InitItem; 
['BrownLeatherChair',[3841.22,3990.9,27.612],263.261,[0,0,1]] call InitStruct; 
['BrownLeatherChair',[3841.96,3939.38,25.575],272.391,[0,0,1]] call InitStruct; 
['BrownLeatherChair',[3843.87,3980.99,24.527],61.1524,[0,0,1]] call InitStruct; 
['TrashCan',[3816.36,3980.78,24.3802],88.0526,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['TrashCan',[3857.08,3980.01,24.4422],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier2_3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['RedSofa',[3794.93,3946.64,19.7745],185.498,[0,0,1]] call InitStruct; 
['RedSofa',[3781.36,3988.26,29.7537],90,[0,0,1]] call InitStruct; 
['RedSofa',[3861.74,4005,22.4799],86.052,[0,0,1]] call InitStruct; 
_3806_233403980_8710929_88357 = ['StationSpeaker',[3806.23,3980.87,29.8836],272.383,[0,0,1], {go_editor_globalRefs set ["_spkr_1",_thisObj];
}] call InitStruct; 
_3825_113283997_8911127_20317 = ['StationSpeaker',[3825.11,3997.89,27.2032],86.5147,[0,0,1], {go_editor_globalRefs set ["_spkr_2",_thisObj];
}] call InitStruct; 
_3835_463383981_5410228_24807 = ['StationSpeaker',[3835.46,3981.54,28.2481],33.5382,[0,0,1], {go_editor_globalRefs set ["_spkr_3",_thisObj];
}] call InitStruct; 
_3845_443363955_7111825_92797 = ['StationSpeaker',[3845.44,3955.71,25.928],179.469,[0,0,1], {go_editor_globalRefs set ["_spkr_4",_thisObj];
}] call InitStruct; 
_3859_683353991_1611326_42827 = ['StationSpeaker',[3859.68,3991.16,26.4283],326.621,[0,0,1], {go_editor_globalRefs set ["_spkr_5",_thisObj];
}] call InitStruct; 
_3899_183353989_8610824_88847 = ['StationSpeaker',[3899.18,3989.86,24.8885],90.5615,[0,0,1], {go_editor_globalRefs set ["_spkr_6",_thisObj];
}] call InitStruct; 
_3779_493413987_9211430_51447 = ['Intercom',[3779.49,3987.92,30.5145],0.857433,[0,0,1], {go_editor_globalRefs set ["Imported Intercom47894",_thisObj];
}] call InitStruct; 
_3819_203374015_3610824_83987 = ['Intercom',[3819.2,4015.36,24.8399],90.3609,[0,0,1], {go_editor_globalRefs set ["Imported Intercom943681",_thisObj];
}] call InitStruct; 
_3828_513434009_2712424_85497 = ['Intercom',[3828.51,4009.27,24.855],178.061,[0,0,1], {go_editor_globalRefs set ["Imported Intercom516853",_thisObj];
}] call InitStruct; 
['SmallRoundWoodenTable',[3778.55,3985.5,29.7755],0,[0,0,1]] call InitStruct; 
['SmallRoundWoodenTable',[3862.1,4002.76,22.3816],273.235,[0,0,1]] call InitStruct; 
['ChairCasual',[3799.61,3947.52,20.3134],178.926,[0,0,1]] call InitItem; 
['ChairCasual',[3794.94,3949.1,19.7871],0,[0,0,1]] call InitItem; 
['ContainerGreen',[3796.08,3944.6,19.8129],93.6778,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3868_769043998_4140622_53541 = ['ContainerGreen',[3868.77,3998.41,22.5354],270.785,[0,0,1]] call InitStruct; 
['SurgicalBed',[3825.14,3976.17,24.3063],273.11,[0,0,1]] call InitStruct; 
['SurgicalBed',[3852.81,4003.73,18.1487],178.547,[0,0,1]] call InitStruct; 
['Baton',[3854.53,3941.14,28.8324],91.0275,[0,0,1]] call InitItem; 
['Baton',[3854.84,3941.14,28.7966],91.0275,[0,0,1]] call InitItem; 
['Baton',[3855.15,3941.14,28.7966],91.0275,[0,0,1]] call InitItem; 
['Baton',[3855.45,3941.15,28.7966],91.0275,[0,0,1]] call InitItem; 
['Candle',[3802.24,3947.6,20.7448],0,[0,0,1]] call InitItem; 
['Candle',[3792.01,3947.06,20.312],268.724,[0,0,1]] call InitItem; 
['Candle',[3796.28,3948.35,20.615],0,[0,0,1]] call InitItem; 
['Candle',[3796.28,3949.85,20.6166],0,[0,0,1]] call InitItem; 
['Candle',[3852.65,3836.94,9.48724],202.848,[0,0,1]] call InitItem; 
['Candle',[3845.16,3838.17,9.41146],249.773,[0,0,1]] call InitItem; 
['Candle',[3904.42,3846.73,9.60816],268.724,[0,0,1]] call InitItem; 
['Candle',[3893.6,3985.34,22.4146],268.724,[0,0,1]] call InitItem; 
['Candle',[3909.44,3846.69,9.67039],268.724,[0,0,1]] call InitItem; 
['Candle',[3924.62,3955.11,20.8485],268.724,[0,0,1]] call InitItem; 
['Candle',[3927.56,3954.98,21.305],268.724,[0,0,1]] call InitItem; 
['Candle',[3927.14,3954.89,21.305],268.724,[0,0,1]] call InitItem; 
['Candle',[3924.43,3970.91,20.1269],268.724,[0,0,1]] call InitItem; 
['Candle',[3848.68,3987.67,28.4402],0,[0,0,1]] call InitItem; 
['Candle',[3846.33,3990.43,28.46],0,[0,0,1]] call InitItem; 
['Candle',[3840.07,3990.7,28.389],0,[0,0,1]] call InitItem; 
['Candle',[3846.15,3977.55,28.3505],0,[0,0,1]] call InitItem; 
['Candle',[3839.98,3991.07,24.743],0,[0,0,1]] call InitItem; 
['Candle',[3844.47,3990.13,24.5456],0,[0,0,1]] call InitItem; 
['Candle',[3848.97,3988.47,24.7553],0,[0,0,1]] call InitItem; 
['CandleDisabled',[3863.66,3956.13,17.8593],0,[0,0,1]] call InitItem; 
['CandleDisabled',[3863.81,3956.13,17.8593],0,[0,0,1]] call InitItem; 
_3826_373294009_2412124_17607 = ['RegistrationPanel',[3826.37,4009.24,24.1761],0,[0,0,1]] call InitStruct; 
['HalfHandedSword',[3854.75,3942.27,28.9965],89.7409,[0,0,1]] call InitItem; 
['Syringe',[3831.4,3975.58,25.2248],182.649,[0,0,1]] call InitItem; 
['Syringe',[3831.35,3975.58,25.2248],182.649,[0,0,1]] call InitItem; 
['Syringe',[3831.51,3975.58,25.2248],182.649,[0,0,1]] call InitItem; 
['Syringe',[3831.46,3975.58,25.2248],182.649,[0,0,1]] call InitItem; 
['Syringe',[3831.57,3975.58,25.2248],182.649,[0,0,1]] call InitItem; 
['SmallSteelTable1',[3829.22,4006.17,24.2079],358.363,[0,0,1]] call InitStruct; 
['SmallWoodenTableHandmade',[3806.03,4006.36,24.256],177.179,[0,0,1]] call InitStruct; 
['OldWoodenBox',[3776.28,3983.98,33.2695],179.716,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_tier3_4"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3781_415043981_2993233_13918 = ['OldWoodenBox',[3781.42,3981.3,33.1392],179.716,[0,0,1]] call InitStruct; 
['OldWoodenBox',[3777.58,4011.83,28.7841,true],[1,0.00052689,3.12325e-05],[0,-0.0591732,0.998248], {_thisObj setvariable ['preinit@__loottemplate',"Kintchen_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3655_860603783_8615718_44699 = ['IStruct',[3655.86,3783.86,25.2965,true],[-0.557471,0.805287,-0.201838],[-0.321044,0.0150954,0.946944], {_thisObj setvariable ['model','a3\rocks_f\stonesharp_medium.p3d'];}] call InitStruct; // !!! realocated model !!!
_3584_703133775_9907219_73595 = ['IStruct',[3584.7,3775.99,26.1982,true],[-0.912856,0.113667,-0.392139],[-0.391861,-0.513569,0.763342], {_thisObj setvariable ['model','a3\rocks_f\stonesharp_medium.p3d'];}] call InitStruct; // !!! realocated model !!!
['HeadThrone',[3797.31,3990.16,29.7827],90.588,[0,0,1]] call InitStruct; 
['Wicket',[3904.1,3968.83,19.7256],87.7672,[0,0,1]] call InitStruct; 
['ToolPipe',[3858.76,3954.9,18.004],0.147172,[0,0,1]] call InitItem; 
['OldGreenToiletBowl',[3784.35,3983.7,33.3159],90,[0,0,1]] call InitStruct; 
['TorchDisabled',[3849.37,4080.04,24.3916],206.548,[0,0,1]] call InitItem; 
['TorchDisabled',[3731.25,3971.12,4.74705],37.9883,[0,0,1]] call InitItem; 
['ElectricalShieldSmall',[3798.33,3943.2,20.6644],265.827,[0,0,1]] call InitStruct; 
_3803_283203984_0510330_20917 = ['ElectricalShieldSmall',[3803.28,3984.05,30.2092],181.984,[0,0,1], {go_editor_globalRefs set ["_transAdmin",_thisObj];
}] call InitStruct; 
_3802_582524010_5485825_08827 = ['ElectricalShieldSmall',[3802.58,4010.55,25.0883],357.042,[0,0,1], {go_editor_globalRefs set ["_transTrader",_thisObj];
}] call InitStruct; 
_3833_463383976_2910224_92037 = ['ElectricalShieldSmall',[3833.46,3976.29,24.9204],189.248,[0,0,1], {go_editor_globalRefs set ["_transMed",_thisObj];
}] call InitStruct; 
_3834_798584006_4126028_69736 = ['ElectricalShield',[3834.8,4006.41,28.6974],273.742,[0,0,1], {go_editor_globalRefs set ["_transGate",_thisObj];
}] call InitStruct; 
_3866_863283953_8310517_00187 = ['ElectricalShield',[3866.86,3953.83,17.0019],90.9637,[0,0,1], {go_editor_globalRefs set ["_genTrans",_thisObj];
}] call InitStruct; 
_3855_403323943_7712423_63507 = ['ElectricalShield',[3855.4,3943.77,23.6351],269.474,[0,0,1], {go_editor_globalRefs set ["_transSec",_thisObj];
}] call InitStruct; 
_3871_903323993_7910221_97147 = ['ElectricalShield',[3871.9,3993.79,21.9715],1.39446,[0,0,1], {go_editor_globalRefs set ["_transBar",_thisObj];
}] call InitStruct; 
_3874_833253986_7412121_88116 = ['ElectricalShield',[3874.83,3986.74,21.8812],85.7808,[0,0,1], {go_editor_globalRefs set ["_transIndust",_thisObj];
}] call InitStruct; 
_3786_803223992_7612331_12637 = ['Tumbler',[3786.8,3992.76,31.1264],356.243,[0,0,1], {go_editor_globalRefs set ["_sw_bank",_thisObj];
}] call InitStruct; 
_3789_093263988_4011231_36857 = ['Tumbler',[3789.09,3988.4,31.3686],91.2194,[0,0,1], {go_editor_globalRefs set ["_sw_meetingadm",_thisObj];
}] call InitStruct; 
_3795_473393973_9111325_75927 = ['Tumbler',[3795.47,3973.91,25.7593],188.161,[0,0,1], {go_editor_globalRefs set ["_btminiadmin",_thisObj];
}] call InitStruct; 
_3804_213383984_6611330_98627 = ['Tumbler',[3804.21,3984.66,30.9863],266.283,[0,0,1], {go_editor_globalRefs set ["_sw_adminevent",_thisObj];
}] call InitStruct; 
_3862_833253953_0810519_00897 = ['Tumbler',[3862.83,3953.08,19.009],180.854,[0,0,1], {go_editor_globalRefs set ["_swTrader",_thisObj];
}] call InitStruct; 
_3862_863283953_1611318_50237 = ['Tumbler',[3862.86,3953.16,18.5024],180.854,[0,0,1], {go_editor_globalRefs set ["_swGate",_thisObj];
}] call InitStruct; 
_3863_253423953_1511218_12977 = ['Tumbler',[3863.25,3953.15,18.1298],180.854,[0,0,1], {go_editor_globalRefs set ["_swCityLiving",_thisObj];
}] call InitStruct; 
_3864_163333953_1110818_36817 = ['Tumbler',[3864.16,3953.11,18.3682],181.659,[0,0,1], {go_editor_globalRefs set ["_swSec",_thisObj];
}] call InitStruct; 
_3851_423343938_4411629_44787 = ['Tumbler',[3851.42,3938.44,29.4479],84.8985,[0,0,1], {go_editor_globalRefs set ["_sw_armory",_thisObj];
}] call InitStruct; 
_3863_723393953_1210918_18037 = ['Tumbler',[3863.72,3953.12,18.1804],181.659,[0,0,1], {go_editor_globalRefs set ["_swCitySec",_thisObj];
}] call InitStruct; 
_3862_873293953_1511217_87807 = ['Tumbler',[3862.87,3953.15,17.8781],180.854,[0,0,1], {go_editor_globalRefs set ["_swBar",_thisObj];
}] call InitStruct; 
_3863_313233953_1311019_02427 = ['Tumbler',[3863.31,3953.13,19.0243],180.854,[0,0,1], {go_editor_globalRefs set ["_swAdmin",_thisObj];
}] call InitStruct; 
_3863_313233953_1010718_61207 = ['Tumbler',[3863.31,3953.1,18.6121],181.659,[0,0,1], {go_editor_globalRefs set ["_swCitySquare",_thisObj];
}] call InitStruct; 
_3863_743413953_1110818_79157 = ['Tumbler',[3863.74,3953.11,18.7916],181.659,[0,0,1], {go_editor_globalRefs set ["_swMedical",_thisObj];
}] call InitStruct; 
_3863_343263953_1511217_68317 = ['Tumbler',[3863.34,3953.15,17.6832],180.854,[0,0,1], {go_editor_globalRefs set ["_swIndust",_thisObj];
}] call InitStruct; 
_3846_856203951_4355523_61390 = ['Tumbler',[3846.86,3951.44,23.6139],180.706,[0,0,1], {go_editor_globalRefs set ["Tumbler G:ClpPHGWDpXc",_thisObj];
}] call InitStruct; 
['BigPipePump',[3832.17,3986.21,23.2363],178.766,[0,0,1]] call InitStruct; 
['BigPipePump',[3670.9,3790.81,17.6576],271.738,[0,0,1]] call InitStruct; 
['PistolPBM',[3854.58,3942.28,28.5577],89.7486,[0,0,1]] call InitItem; 
['PistolPBM',[3855,3942.29,28.5579],89.7486,[0,0,1]] call InitItem; 
['Umivalnik',[3868.8,4005.31,22.4968],185,[0,0,1]] call InitStruct; 
['Umivalnik',[3830.1,3972.38,24.4545],5.00007,[0,0,1]] call InitStruct; 
['Umivalnik',[3833.93,3988.57,29.6308,true],[0.00131726,-0.984923,-0.172986],[-0.0151346,-0.172986,0.984808]] call InitStruct; 
['SteelSmallLadder',[3903.21,3997.8,20.6368],177.531,[0,0,1]] call InitStruct; 
_3821_393314048_2111827_01249 = ['Decor',[3821.39,4048.21,29.3024,true],147.93,[-0.0027303,-0.00851743,0.99996], {_thisObj setvariable ['model','ca\structures_e\housek\house_k_1_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_963384030_5112323_81576 = ['Decor',[3800.96,4030.51,27.8507,true],[0.988965,0.0681308,0.131557],[-0.130774,-0.0158516,0.991286], {_thisObj setvariable ['model','ca\structures_e\housek\house_k_6_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_937264049_5258823_74238 = ['Decor',[3832.94,4049.53,27.6374,true],0,[0.00684143,0.00577726,0.99996], {_thisObj setvariable ['model','ca\structures_e\housek\house_k_6_ruins_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['GlassGoblet',[3778.5,3985.4,30.7115],308.299,[0,0,1]] call InitItem; 
['GlassGoblet',[3778.68,3985.44,30.709],329.531,[0,0,1]] call InitItem; 
['GlassGoblet',[3778.5,3985.62,30.7108],0,[0,0,1]] call InitItem; 
['GlassGoblet',[3781.58,3982.55,30.6626],0,[0,0,1]] call InitItem; 
['CoolSofa',[3784.16,3990.38,33.1504],90.933,[0,0,1]] call InitStruct; 
_3866_983403882_181159_31345 = ['Decor',[3866.98,3882.18,14.5931,true],100.696,[-0.0528907,0.0859913,0.994891], {_thisObj setvariable ['model','ca\structures\ruins\ruin_wall.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_723394060_5712924_23327 = ['Decor',[3858.72,4060.57,29.5144,true],0,[0.00115234,-0.00698114,0.999975], {_thisObj setvariable ['model','ca\structures\ruins\ruin_wall.p3d'];}] call InitDecor; // !!! realocated model !!!
_3896_193363843_371099_31476 = ['Decor',[3896.19,3843.37,14.5945,true],[0.0210177,-0.995969,0.0872018],[-0.0528907,0.0859913,0.994891], {_thisObj setvariable ['model','ca\structures\ruins\ruin_wall.p3d'];}] call InitDecor; // !!! realocated model !!!
_3876_953373881_311048_52764 = ['Decor',[3876.95,3881.31,13.8073,true],[0.924532,0.369052,0.0950841],[-0.0730537,-0.0732509,0.994634], {_thisObj setvariable ['model','ca\structures\ruins\ruin_wall.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_683354066_2714823_83088 = ['Decor',[3862.68,4066.27,29.8872,true],0,[0.00115234,-0.00698114,0.999975], {_thisObj setvariable ['model','ca\structures\ruins\ruin_walldoor.p3d'];}] call InitDecor; // !!! realocated model !!!
_3897_223393816_031018_87123 = ['Decor',[3897.22,3816.03,14.9213,true],[0.190922,0.975123,-0.112619],[0.0687294,0.101169,0.992492], {_thisObj setvariable ['model','ca\structures\ruins\ruin_walldoor.p3d'];}] call InitDecor; // !!! realocated model !!!
_3896_733403874_861087_34693 = ['Decor',[3896.73,3874.86,13.3989,true],352.751,[0.0687294,0.101169,0.992492], {_thisObj setvariable ['model','ca\structures\ruins\ruin_walldoor.p3d'];}] call InitDecor; // !!! realocated model !!!
['CombatKnife',[3833.57,4007.42,25.2354],67.0969,[0,0,1]] call InitItem; 
['Scales',[3873.49,3996.9,22.9221],2.15022,[0,0,1]] call InitStruct; 
_3785_433353990_9812033_29947 = ['Decor',[3785.43,3990.98,33.2995],87.1431,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\wood_box_1.p3d'];}] call InitDecor; // !!! realocated model !!!
['MediumFenceOfSheetsAndBoards',[3778.45,4010.12,23.8569],0,[0,0,1]] call InitStruct; 
['MediumFenceOfSheetsAndBoards',[3780.95,4012.91,23.6536],272.745,[0,0,1]] call InitStruct; 
['WoodenCup',[3838.63,3945.2,26.3829],205.818,[0,0,1]] call InitItem; 
['WoodenCup',[3838.77,3945.32,26.3829],228.977,[0,0,1]] call InitItem; 
['WoodenCup',[3838.78,3945.18,26.3829],68.0782,[0,0,1]] call InitItem; 
['WoodenCup',[3838.64,3945.33,26.3829],271.591,[0,0,1]] call InitItem; 
['WoodenCup',[3867.79,3994.72,23.283],0,[0,0,1]] call InitItem; 
['WoodenCup',[3862.75,3995.14,23.3487],0,[0,0,1]] call InitItem; 
['GreenAmbarWithDoors',[3864.59,4000.1,21.6992],0,[0,0,1]] call InitStruct; 
['SmallBookcase',[3779.47,3985.47,33.2739],86.0056,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBookcase',[3779.35,3988.24,33.2866],86.0056,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallBookcase',[3834.21,3975.53,27.1551],97.7063,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ClothCabinet',[3852.13,3990.78,28.8536],180,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"CityCloth_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['SmallChair',[3796.98,3976.98,24.5592],93.6108,[0,0,1]] call InitItem; 
['SmallChair',[3796.92,3978.67,24.6006],12.6555,[0,0,1]] call InitItem; 
['SmallChair',[3839.78,3944.45,25.5283],173.963,[0,0,1]] call InitItem; 
['SmallChair',[3839.8,3946.03,25.5306],13.4073,[0,0,1]] call InitItem; 
['SmallChair',[3838.79,3944.35,25.5283],192.532,[0,0,1]] call InitItem; 
['SmallChair',[3838.84,3946.07,25.5306],336.718,[0,0,1]] call InitItem; 
['SmallChair',[3833.66,3998.95,24.4354],85.2953,[0,0,1]] call InitItem; 
['SmallChair',[3832.26,3999.05,24.425],261.856,[0,0,1]] call InitItem; 
['SmallChair',[3832.49,3976.23,27.1551],0.513594,[0,0,1]] call InitItem; 
['SmallChair',[3812.71,3977.54,24.6264],259.588,[0,0,1]] call InitItem; 
['SmallChair',[3831.77,3976.19,24.4545],0,[0,0,1]] call InitItem; 
['SmallChair',[3829.44,4007.13,24.4468],16.3324,[0,0,1]] call InitItem; 
['SmallChair',[3849.69,3987.76,27.6084],78.5157,[0,0,1]] call InitItem; 
['SmallChair',[3841.49,3989.24,27.5869],90.8594,[0,0,1]] call InitItem; 
['SmallChair',[3846.28,3989.41,27.6257],173.707,[0,0,1]] call InitItem; 
['SmallChair',[3847.79,3976.27,27.5172],327.165,[0,0,1]] call InitItem; 
['SmallChair',[3847.24,3952.01,22.3253],86.033,[0,0,1]] call InitItem; 
['SmallChair',[3847.23,3952.71,22.3241],89.9426,[0,0,1]] call InitItem; 
['SmallChair',[3844.9,3952.96,22.3202],188.229,[0,0,1]] call InitItem; 
['SmallRedseatChair',[3814.07,3978.14,24.4183],93.4033,[0,0,1]] call InitItem; 
['LuxuryWoodenTable1',[3782.38,3982.99,29.7108],269.613,[0,0,1]] call InitStruct; 
['CaseBedroomSmall',[3844.22,3990.66,27.524],269.008,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CaseBedroomSmall',[3855.41,3973.5,24.4666],86.04,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"TrashCan_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CaseBedroomSmall',[3849.05,3977.16,27.4913],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3876_073244002_9711922_76247 = ['CaseBedroomSmall',[3876.07,4002.97,22.7625],272.215,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['ContainerGreen2',[3790.21,3975.25,24.5914],8.6705,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Things_all"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3830_803223972_3110427_13736 = ['ContainerGreen2',[3830.8,3972.31,27.1374],4.70099,[0,0,1]] call InitStruct; 
['ContainerGreen2',[3833.29,4007.18,28.8113],185.159,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Tools_tier3"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CaseBedroomMedium',[3803.07,4006.22,27.6186],268.18,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CaseBedroomMedium',[3833.8,3997.92,25.1544],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['CaseBedroomMedium',[3833.81,3997.92,24.4959],0,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier1_2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
_3847_112063954_6157222_32498 = ['CaseBedroomMedium',[3847.11,3954.62,22.325],269.116,[0,0,1], {_thisObj setvariable ['preinit@__loottemplate',"Office_tier2"]; _thisObj call (_thisObj getvariable 'proto' getvariable '__handlePreInitVars__');}] call InitStruct; 
['WoodenSmallFence2',[3868.16,3998.06,21.9428],273.507,[0,0,1]] call InitStruct; 
['WoodenSmallFence',[3828.34,3978.01,27.6745],6.11192,[0,0,1]] call InitStruct; 
['WoodenSmallFence',[3848.61,3975.32,27.8721],1.63177,[0,0,1]] call InitStruct; 
_3785_393313997_8210432_33127 = ['Decor',[3785.39,3997.82,32.3313],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_673343997_5810529_65517 = ['Decor',[3785.67,3997.58,29.6552],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_593263991_2712427_40867 = ['Decor',[3840.59,3991.27,27.4087],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_663333991_2312027_43727 = ['Decor',[3848.66,3991.23,27.4373],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_113283979_9912127_34357 = ['Decor',[3846.11,3979.99,27.3436],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3873_883303863_8610813_41386 = ['Decor',[3873.88,3863.86,13.4139],7.36095,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3881_603273862_8911112_11329 = ['Decor',[3881.6,3862.89,17.1835,true],[0.149796,0.988388,0.0255163],[0.309366,-0.0713666,0.948261], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_853273976_4511727_39557 = ['Decor',[3858.85,3976.45,27.3956],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoxyeta.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_863283980_2612327_42897 = ['Decor',[3861.86,3980.26,27.429],91.223,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoxyeta.p3d'];}] call InitDecor; // !!! realocated model !!!
['SteelThinWallBig',[3774.96,3988.08,30.1056],270.198,[0,0,1]] call InitStruct; 
['SteelThinWallBig',[3773.72,3992.84,29.9599],0,[0,0,1]] call InitStruct; 
['SteelThinWallBig',[3786.02,3992.89,31.9506],0,[0,0,1]] call InitStruct; 
['SteelThinWallBig',[3779.9,3992.89,30.0531],0,[0,0,1]] call InitStruct; 
['BlockBrick',[3994,3989,26],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,3979,26],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4004,3989,26],90,[0,0,1]] call InitDecor; 
['BlockBrick',[3994,3979,26],270,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3989,26],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3979,26],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3989,25],90,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3979,26],270,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3999,26],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3999,26],270,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3979,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3989,26],180,[0,0,1]] call InitDecor; 
['BlockStone',[4054,3989,23.9726],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,3989,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4074,3989,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4054,3979,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4054,3999,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,3999,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3999,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3999,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,4009,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,4019,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3994,4019,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3969,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3959,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3959,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3969,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3959,22],0,[0,0,1]] call InitDecor; 
['BlockStone',[3994,3949,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3949,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3949,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3974,3959,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4004,3939,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3994,3929,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3984,3929,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3974,3949,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3974,3969,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4014,3959,22],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3959,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3959,24],90.0001,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3969,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3969,24],270,[0,0,1]] call InitDecor; 
['BlockStone',[4042.88,3959,18.875],270,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3949,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3939,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3929,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3929,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3939,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3949,24],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4009,26],0.000121236,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,4009,26],90.0001,[0,0,1]] call InitDecor; 
['BlockStone',[4054,3969,21],90,[0,0,1]] call InitDecor; 
_4056_874273954_7497618_36674 = ['IStruct',[4056.87,3954.75,22.8693,true],0,[-0.00659628,-0.00161913,0.999977], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitStruct; // !!! realocated model !!!
['BlockStone',[3984,3969,41],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3999,36],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4007.5,4004.25,34.8619,true],90.0001,[0.00659396,0.00161853,0.999977]] call InitDecor; 
['BigStoneWall',[4031,4015,37.4869,true],270,[-0.00659316,-0.00161913,0.999977]] call InitDecor; 
['BigStoneWall',[3969,4030,34.4869,true],165,[0.00161869,-0.00659157,0.999977]] call InitDecor; 
['BlockStone',[3994,4009,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3984,4019,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3974,4019,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,4009,36],0,[0,0,1]] call InitDecor; 
['BlockStone',[3974,4009,36],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3964,4019,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3964,4009,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3954,4009,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3954,4019,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[3954,3999,36],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3999,36],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[3952,4020,34.4869,true],135,[0.00469665,-0.0048983,0.999977]] call InitDecor; 
['BigStoneWall',[3970,4065,34.4869,true],240,[-0.00351621,-0.0058043,0.999977]] call InitDecor; 
['BlockStone',[4014,3949,22],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3949,31],270,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3939,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3929,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4014,3939,22],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4014,3929,22],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4004,3929,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,3989,24],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,3989,24],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3989,34],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3979,34],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,4009,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,3999,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,3979,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4074,3999,24],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,3970,22.5547,true],0,[0,-0.258818,0.965926]] call InitDecor; 
['BlockDirt',[4094,3958,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,3948,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3948,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3958,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3948,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3958,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3968,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3968,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4124,3958,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4124,3948,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3938,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3938,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,3938,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,3948,31],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,3958,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,3969,21],270,[0,0,1]] call InitDecor; 
['BlockStone',[4074,3969,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[4074,3959,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,3968,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,3980.36,22.2831,true],0,[0,-0.275636,0.961262]] call InitDecor; 
['BlockDirt',[4084,3979,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4054,4009,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,4009,24],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4037.75,3994,34.4869,true],180,[0.00161869,-0.00659252,0.999977]] call InitDecor; 
['BetonGarageMedium',[3957.13,3978,26],180,[0,0,1]] call InitStruct; 
['Golovinskaya',[3955.25,3985,28],0,[0,0,1]] call InitStruct; 
['LargeTwoStoreyStoneHouse',[3994.5,3999.75,26],180,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall',[3994.5,4007.75,26.108],270,[0,0,1]] call InitStruct; 
['LargeTwoStoreyStoneHouse',[3979,4027.38,25.75],0.000121236,[0,0,1]] call InitStruct; 
['SmallBrickHouse',[3968,4024,26],255,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3992.38,3972.75,24.75],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3990.5,3972.75,24.75],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3992.38,3969.88,23],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3990.5,3969.88,23],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3992.38,3966,21.25],0,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3990.5,3966,21.25],0,[0,0,1]] call InitStruct; 
['BlockStone',[4034,3919,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3919,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[4054,4019,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4064,4019,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3999,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3999,24],0,[0,0,1]] call InitDecor; 
['HouseWithGarageSmall',[3985,3938,21.108],180,[0,0,1]] call InitStruct; 
['BlockStone',[3964,3959,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3954,3959,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3949,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3969,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3954,3949,31],0,[0,0,1]] call InitDecor; 
['BlockStone',[3964,3939,31],0,[0,0,1]] call InitDecor; 
['HouseWithGarageSmall',[3964,3948,21.1014],180,[0,0,1]] call InitStruct; 
['BlockDirt',[4094,3999,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,4009,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3989,24],0,[0,0,1]] call InitDecor; 
['StoneBigPandus',[4051.75,3984.5,25.4176],180,[0,0,1]] call InitStruct; 
['StoneBigPandus',[4051.75,3990.5,25.4176],180,[0,0,1]] call InitStruct; 
['GreenAmbarWithDoors',[4056.38,4000.8,23.5],0,[0,0,1]] call InitStruct; 
['BlockStone',[3994,3939,21],0,[0,0,1]] call InitDecor; 
['BlockStone',[3984,3939,21],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3974,3939,31],0,[0,0,1]] call InitDecor; 
['HouseWithGarageSmall',[3987,3945,21.1185],90.0007,[0,0,1]] call InitStruct; 
['BlockStone',[4044,4019,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,4009,24],0,[0,0,1]] call InitDecor; 
['StoneBigPandus',[4031.63,4003.63,25.25],180,[0,0,1]] call InitStruct; 
['StoneBigPandus',[4031.63,3997.63,25.25],180,[0,0,1]] call InitStruct; 
['StoneBigPandus',[4035.13,3971.38,29.8775,true],270,[0.00161583,-0.00659347,0.999977]] call InitStruct; 
['StoneBigPandus',[4016.25,3957.25,27.8775,true],0.000297967,[-0.00659134,-0.00161341,0.999977]] call InitStruct; 
['StoneSmallLadder',[3997.75,3962.38,20.75],85,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3997.75,3964.25,20.75],95,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3997.75,3958.62,20.75],95,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3997.88,3960.5,20.75],90,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3997.88,3954.75,20.75],85,[0,0,1]] call InitStruct; 
['StoneSmallLadder',[3997.75,3956.63,20.75],90,[0,0,1]] call InitStruct; 
['ClayWallSmall',[4063.63,3993.75,25.75],0,[0,0,1]] call InitStruct; 
['ClayWallBig',[4070.25,3994.25,25.75],350,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[4066.38,3993.75,24.0991],0,[0,0,1]] call InitStruct; 
['BlockStone',[4074,4009,24],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3979,24],0,[0,0,1]] call InitDecor; 
['LargeSmoothRock',[4077.75,4003.88,9.875],0.000589424,[0,0,1]] call InitDecor; 
['LargeSmoothRock',[4089.25,3991.25,19.6696,true],99.0011,[-0.0174099,0.00121742,0.999848]] call InitDecor; 
['LargeSmoothRock',[4089.01,4043.5,9],42.1351,[0,0,1]] call InitDecor; 
['LargeSmoothRock',[4100,4048,20.9196,true],[0.999391,0.0347668,-0.00304053],[-0.0119375,0.422411,0.906326]] call InitDecor; 
['LargeSmoothRock',[4102.13,3989.5,19.6697,true],[0.994992,0.0530495,0.0847123],[-0.0854644,0.0120704,0.996268]] call InitDecor; 
['LargeSmoothRock',[4126.27,4030.62,20.0339,true],[0.529901,-0.84806,2.13087e-06],[0.424027,0.264951,0.866026]] call InitDecor; 
['LargeSmoothRock',[4114,4042,20.9196,true],[0.828101,-0.560579,1.92225e-06],[0.191727,0.283227,0.939693]] call InitDecor; 
['BlockDirt',[4084,4019,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,4019,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4094,4029,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4084,4029,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,4019,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,4019,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,4029,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,4029,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,3999,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,3999,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4114,4009,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,4009,14],0,[0,0,1]] call InitDecor; 
['LargeSmoothRock',[4124,3996,20.9196,true],[-0.615682,-0.787994,7.59959e-07],[0.33302,-0.260197,0.906309]] call InitDecor; 
['LargeSmoothRock',[4131,4014,19.9196,true],[-0.0505786,-0.998628,0.0135573],[0.499654,-0.0135481,0.866119]] call InitDecor; 
['BlockDirt',[4094,4039,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4104,4039,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4124,4009,14],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4124,4019,14],0,[0,0,1]] call InitDecor; 
['LargeSmoothRock',[4076,4019,9],0.000589424,[0,0,1]] call InitDecor; 
['BigWoodenLadder',[4101.38,4000.29,22.0748,true],185,[-0.00503721,0.00739673,0.99996]] call InitStruct; 
['ShortRottenBoards',[4092.44,3998.02,29.1561,true],0,[0,0.0738884,0.997267]] call InitStruct; 
['ShortRottenBoards',[4093.21,3997.25,29.1618,true],3.02823,[0.00122482,0.051289,0.998683]] call InitStruct; 
['BigSteelGrating',[4085.13,3999.41,24.0433],2.86681,[0,0,1]] call InitStruct; 
['BigConcretePipe',[4082.21,4030.34,19.9212,true],317.953,[-0.00450262,-0.0054395,0.999975]] call InitStruct; 
['BigConcretePipe',[4080.29,4032.47,19.9143,true],317.953,[-0.00450262,-0.0054395,0.999975]] call InitStruct; 
['LargeSmoothRock',[4080.85,4032.8,28.8099,true],[0.670882,0.741564,-2.5928e-06],[0.716296,-0.648024,-0.258814]] call InitDecor; 
['BlockDirt',[4114,3989,24],0,[0,0,1]] call InitDecor; 
['BigSteelGrating',[4107,3988,25],270,[0,0,1]] call InitStruct; 
['BigSteelGrating',[4103.5,3988,25],270,[0,0,1]] call InitStruct; 
['ConcreteWall',[4101.88,3991,22.5],270,[0,0,1]] call InitStruct; 
['ConcreteWall',[4101.88,3985,22.5],270,[0,0,1]] call InitStruct; 
['ConcreteWall',[4105.75,3981.13,22.5],180,[0,0,1]] call InitStruct; 
_4100_125004033_0000014_12552 = ['IStruct',[4100.13,4033,19.0638,true],55,[-0.00242912,-0.00861233,0.99996], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstones_erosion.p3d'];}] call InitStruct; // !!! realocated model !!!
_4086_375004002_8750013_37716 = ['IStruct',[4086.38,4002.88,20.8884,true],315.002,[-0.00419537,-0.00565694,0.999975], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntrock_apart.p3d'];}] call InitStruct; // !!! realocated model !!!
['BigSmoothStone',[4102.5,4040.75,11.8099,true],[0.996171,-0.0842676,-0.0232961],[-0.00555539,-0.326931,0.945032]] call InitDecor; 
['BigSmoothStone',[4117.75,4029,12.4349,true],[0.644813,-0.763985,-0.0232947],[-0.297595,-0.279013,0.913011]] call InitDecor; 
['BigSmoothStone',[4127.25,4011.88,11.8099,true],[0.00083444,-0.999725,-0.0234554],[-0.242563,-0.0229573,0.969864]] call InitDecor; 
['BigSmoothStone',[4115.25,3994,13.3099,true],[-0.801687,-0.577135,-0.155607],[-0.47579,0.45854,0.750576]] call InitDecor; 
['BigSmoothStone',[4099.13,3990.5,14.1849,true],[0.985003,-0.171134,0.02196],[0.0109731,0.189155,0.981886]] call InitDecor; 
['BigSmoothStone',[4076.5,4015.13,14.6849,true],[0.155137,-0.987792,-0.014116],[0.649362,0.0911962,0.754991]] call InitDecor; 
_4088_750004001_0000014_00052 = ['IStruct',[4088.75,4001,18.9388,true],290.001,[0.00843736,0.00295045,0.99996], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstones_erosion.p3d'];}] call InitStruct; // !!! realocated model !!!
_4087_500004006_1250014_00052 = ['IStruct',[4087.5,4006.13,18.9388,true],305.001,[0.00890464,0.000665333,0.99996], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstones_erosion.p3d'];}] call InitStruct; // !!! realocated model !!!
['BlockDirt',[4074,3979,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,3979,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,3989,26],0,[0,0,1]] call InitDecor; 
['BigStoneWall',[4079,3972,29.4869,true],7.0011e-05,[-0.00161921,0.00659316,0.999977]] call InitDecor; 
['BigStoneWall',[4049,3972,29.4869,true],7.0011e-05,[-0.00161921,0.00659316,0.999977]] call InitDecor; 
['LargeConcreteWallWithReinforcement',[4059.38,3977.75,24.875],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4054.25,3984.38,24.875],180,[0,0,1]] call InitStruct; 
['BigConcreteWallDestroyed',[4058.38,3983.63,28.2373,true],180,[-2.14049e-06,-5.07036e-06,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4068.63,3977.88,22.875],270,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[4043.13,3961.75,18.25],270,[0,0,1]] call InitStruct; 
['SteelRustyStairs',[4043.13,3960.13,18.25],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4065.62,3959.87,22.7418],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4061.5,3963.75,20.1168],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4065.62,3951,22.7418],270,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4060.75,3947,22.7418],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4051.87,3947,22.7418],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4052.62,3963.75,20.1168],180,[0,0,1]] call InitStruct; 
['BigConcreteWallDestroyed',[4047.5,3962.87,23.9791,true],105.002,[-4.20278e-06,9.4512e-07,1]] call InitStruct; 
_4056_999273955_1247625_11674 = ['IStruct',[4057,3955.12,29.6193,true],0,[-0.00659628,-0.00161913,0.999977], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitStruct; // !!! realocated model !!!
['LargeConcreteWallWithReinforcement',[4049.38,3963,22.75],90.0005,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4049.38,3971.88,22.75],90.0005,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4049.38,3951.88,22.625],90.0005,[0,0,1]] call InitStruct; 
['SteelSmallLadder',[4062.63,3961,18.875],180,[0,0,1]] call InitStruct; 
['SteelSmallLadder',[4050.25,3970,21.625],90,[0,0,1]] call InitStruct; 
['SteelSmallLadder',[4053.63,3968.5,19.75],180,[0,0,1]] call InitStruct; 
['SteelThinWallMedium',[4087.88,3979,24],90,[0,0,1]] call InitStruct; 
['MediumFenceOfSheetsAndBoards',[4069,3980.88,24],0,[0,0,1]] call InitStruct; 
['SmallCornerFenceMadeOfJunk',[4086.88,3982.88,23.875],270,[0,0,1]] call InitStruct; 
['TinFence',[4070.88,3983.63,24.125],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4083.88,3983.75,24.125],0,[0,0,1]] call InitStruct; 
['WoodenSmallFence4',[4071.01,3983.61,29.586,true],0,[-0.0069996,-0.00103549,0.999975]] call InitStruct; 
['WoodenSmallFence3',[4080.13,3983.38,24],270,[0,0,1]] call InitStruct; 
['WoodenSmallFence2',[4075,3983.88,24],90,[0,0,1]] call InitStruct; 
['WoodenSmallFence1',[4087.75,3983,31.337,true],90,[-5.40918e-08,1,-4.37114e-08]] call InitStruct; 
['SmallSheetMetalHouse',[4073.25,3977.25,24],180,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse1',[4086.88,3982,25.5],90,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[4086.63,3975.75,24.125],270,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse3',[4104,3975.38,24.125],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4075,3983.75,24.25],180,[0,0,1]] call InitStruct; 
['TinFence',[4080.38,3983.63,24.125],180,[0,0,1]] call InitStruct; 
['TinFence',[4085.75,3983.88,25.875],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4081.75,3983.72,25.8938],0.000151118,[0,0,1]] call InitStruct; 
['SteelThinWallSmall',[4082.88,3983.88,23.625],180,[0,0,1]] call InitStruct; 
['TinBigFence',[4070.88,3983.63,25.75],0.000124651,[0,0,1]] call InitStruct; 
['WoodenSmallFence2',[4069,3982.25,26],1.19528e-05,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3822.63,4018.13,30.75],180,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3836.63,4018.13,30.75],180,[0,0,1]] call InitStruct; 
['BigSteelGrating',[3813.75,4021.75,31.25],180,[0,0,1]] call InitStruct; 
['HouseWithGarageSmall',[3978.75,4012.63,26.5],180.001,[0,0,1]] call InitStruct; 
['BlockStone',[4054,4029,26],0,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,4019,26],90.0001,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4019,26],0.000121236,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,4029,26],0.000121236,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,4029,26],90.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[4024,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4014,4039,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4044,4029,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,4029,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4044,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4034,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4054,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4004,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3994,4039,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4024,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4014,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4044,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4034,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4054,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[4004,4049,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3994,4049,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4004,4029,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3994,4029,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3984,4029,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3974,4029,26],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3964,4029,26],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,4009,24],0,[0,0,1]] call InitDecor; 
['BlockStone',[4034,4019,24],0,[0,0,1]] call InitDecor; 
_4023_750003993_3750026_50000 = ['IStruct',[4023.75,3993.38,26.5],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4018_500003989_0000026_50000 = ['IStruct',[4018.5,3989,26.5],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4033_875003988_2500026_50000 = ['IStruct',[4033.88,3988.25,26.5],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
['ClayWallBig',[4071.13,3997.38,25.875],270,[0,0,1]] call InitStruct; 
['ClayWallBig',[4071.13,4002.5,25.875],270,[0,0,1]] call InitStruct; 
['ClayWallBig',[4004.5,3985.25,28],0,[0,0,1]] call InitStruct; 
_4025_000003973_1250027_00000 = ['IStruct',[4025,3973.13,27],270,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4022_500003975_6250027_00000 = ['IStruct',[4022.5,3975.63,27],180,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGreenDoor',[4018.63,3975.63,26],0,[0,0,1]] call InitStruct; 
_4014_750003975_6250027_00000 = ['IStruct',[4014.75,3975.63,27],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['WoodenDoor',[4007.38,3977.38,26.125],180,[0,0,1]] call InitStruct; 
['ClayWallSmall',[4004.75,3977.38,28],0,[0,0,1]] call InitStruct; 
['ClayWallBig',[4002.88,3974.25,28],270,[0,0,1]] call InitStruct; 
['BlockBrick',[4004,3974,26],90.0001,[0,0,1]] call InitDecor; 
['BlockBrick',[4014,3974,26],180,[0,0,1]] call InitDecor; 
['BlockBrick',[4024,3974,26],90.0001,[0,0,1]] call InitDecor; 
['BlockStone',[4004,3969,22],0,[0,0,1]] call InitDecor; 
['BlockStone',[4014,3969,22],0,[0,0,1]] call InitDecor; 
['BlockStone',[4024,3969,24],270,[0,0,1]] call InitDecor; 
['LargeConcreteWallWithReinforcement',[3998.25,3969.63,24.875],90.0005,[0,0,1]] call InitStruct; 
_4025_000003969_5000027_00000 = ['IStruct',[4025,3969.5,27],90,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallSheetMetalHouse2',[4027.25,3970.25,26.125],0.000198075,[0,0,1]] call InitStruct; 
_4012_125003977_5000027_00000 = ['IStruct',[4012.13,3977.5,27],270,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['BrickThinWallDoorway',[4012,3972.25,26],270.001,[0,0,1]] call InitStruct; 
['BigBrickUnfinishedTwoStoreyHouse',[3985.5,3985.13,28.125],270,[0,0,1]] call InitDecor; 
['BigBrickUnfinishedTwoStoreyHouse',[3972.88,3985.38,31.625],0.000203198,[0,0,1]] call InitDecor; 
['BigBrickUnfinishedTwoStoreyHouse',[3990.88,4025.5,26],90.0002,[0,0,1]] call InitDecor; 
['BigStoneWall',[4042,4033,32.4869,true],0.000200641,[-0.00161913,0.00659316,0.999977]] call InitDecor; 
['BigStoneWall',[4061,4033,32.4869,true],0.000198934,[-0.0016192,0.00659314,0.999977]] call InitDecor; 
['CampFireBig1',[4014,4011.62,31.2196,true],0,[-0.0010358,0.0069996,0.999975]] call InitStruct; 
['BigStoneWall',[4001.63,4022.88,34.4869,true],55.0001,[0.00447159,0.00510753,0.999977]] call InitDecor; 
['NormalClayWall',[4004.25,3983.25,27],0,[0,0,1]] call InitStruct; 
['ClayWallSmall',[4010,3977.38,28],0,[0,0,1]] call InitStruct; 
_4002_875003969_5000027_00000 = ['IStruct',[4002.88,3969.5,27],90,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumConcreteFloor1',[4001.63,3966,25.75],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4007.63,3966,25.75],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4019.63,3966,25.75],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4013.63,3966,25.75],0,[0,0,1]] call InitStruct; 
['MediumConcreteFloor1',[4022.63,3966,25.75],0,[0,0,1]] call InitStruct; 
_4005_625003967_0000027_00000 = ['IStruct',[4005.63,3967,27],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4010_875003967_0000027_00000 = ['IStruct',[4010.88,3967,27],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4016_125003967_0000027_00000 = ['IStruct',[4016.13,3967,27],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
_4021_375003967_0000027_00000 = ['IStruct',[4021.38,3967,27],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallSheetMetalHouse',[4001.63,3964.13,22.75],0.000228384,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[4008.13,3965.63,22.625],180,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse1',[4011.38,3964.25,23.5],2.56132e-05,[0,0,1]] call InitStruct; 
['SmallSheetMetalHouse2',[4015,3965.63,22.625],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4040.25,3954,27.75],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4029.63,3954,27.75],180,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4043.5,3953.88,27.75],180,[0,0,1]] call InitStruct; 
['MediumConcreteWall',[4019.88,3982.88,27.5],0,[0,0,1]] call InitStruct; 
['LuxuryClayWall',[4013.75,3986.5,27],90,[0,0,1]] call InitStruct; 
['BigLightWall',[4019.5,3980.38,27.875],0,[0,0,1]] call InitStruct; 
['OldBrickWallMedium',[4018,3981.75,26.875],0,[0,0,1]] call InitStruct; 
['LuxuryClayWall',[4013.75,3986.5,35.564,true],[-1,-1.91926e-06,3.49151e-06],[-3.4915e-06,-3.90212e-06,-1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4021.25,3963.38,25],0.000506715,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4025.25,3967.38,25],270.001,[0,0,1]] call InitStruct; 
['BrickThinWallDoorway',[4039.88,3977,26],0,[0,0,1]] call InitStruct; 
['BigLightWall',[4037,3980.5,27.125],90,[0,0,1]] call InitStruct; 
['MediumLightWall',[4044.25,3977,27.125],180,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4045.75,3980.13,32.4935,true],90,[-0.00692886,-0.00565972,0.99996]] call InitStruct; 
['MediumLightWall',[4045.75,3984.88,27.125],90.0004,[0,0,1]] call InitStruct; 
['BrickThinWallWindow2',[4042.5,3986.38,32.4935,true],6.83035e-06,[0.00565604,-0.00692667,0.99996]] call InitStruct; 
['MediumLightWall',[4037,3984.88,27.125],90.0004,[0,0,1]] call InitStruct; 
['MediumLightWall',[4038.5,3986.38,27.125],0.00044695,[0,0,1]] call InitStruct; 
['OldBrickWallMedium',[4049.75,3982,26.75],270,[0,0,1]] call InitStruct; 
['OldBrickWallMedium',[4053.13,3975.5,26.75],90.0004,[0,0,1]] call InitStruct; 
['MediumLightWall',[4051.63,3979.75,26.875],180,[0,0,1]] call InitStruct; 
['BrickThinWallWindow',[4052.75,3984.38,32.2435,true],0,[0.00566271,-0.00693096,0.99996]] call InitStruct; 
['MediumLightWall',[4057.5,3984.38,26.875],180,[0,0,1]] call InitStruct; 
['BrickThinWallWindow3',[4059,3981.25,32.2435,true],90,[-0.00161859,0.00659636,0.999977]] call InitStruct; 
['OldBrickWallMedium',[4059,3976,26.75],90.0004,[0,0,1]] call InitStruct; 
_4016_750004004_2500026_00008 = ['IStruct',[4016.75,4004.25,33.0004,true],270,[0.00659205,0.0016191,0.999977], {_thisObj setvariable ['model','ml\ml_germogate\l19_police_germozatbor.p3d'];}] call InitStruct; // !!! realocated model !!!
['MediumConcreteWall',[4019.51,4008.76,26.0344],0,[0,0,1]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4010,4004.25,35.5007,true],0,[1,0,1.19249e-08]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4023.63,4004.25,35.5007,true],[3.50862e-14,-1,-8.02679e-07],[-1,0,-4.37114e-08]] call InitStruct; 
['LargeConcreteWallWithReinforcement',[4016.75,4004.25,37.5007,true],180,[-9.16421e-07,-2.47161e-06,-1]] call InitStruct; 
_4018_125004012_6250034_62499 = ['IStruct',[4018.13,4012.63,39.1275,true],0,[-0.00659628,-0.00161913,0.999977], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitStruct; // !!! realocated model !!!
['IStruct',[4012.25,4036.39,31.1616,true],0,[-0.0384836,0.0261709,0.998916]] call InitStruct; 



if (!isNil'_3894_000003996_0000018_89106') then {
	_3894_000003996_0000018_89106 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3914_903563940_5090319_99245') then {
	_3914_903563940_5090319_99245 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3826_682373999_2905328_80826') then {
	_3826_682373999_2905328_80826 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3784_078614017_7922423_95523') then {
	_3784_078614017_7922423_95523 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3800_359623943_1918919_69399') then {
	_3800_359623943_1918919_69399 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3803_996833969_5153820_00448') then {
	_3803_996833969_5153820_00448 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3801_070313990_0515124_34992') then {
	_3801_070313990_0515124_34992 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3849_103763959_1550317_15636') then {
	_3849_103763959_1550317_15636 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3840_284183935_1530828_65343') then {
	_3840_284183935_1530828_65343 setvariable ['spawnpointname',"rndloc"];
};
if (!isNil'_3797_882084039_5727524_36955') then {
	_3797_882084039_5727524_36955 setvariable ['spawnpointname',"rndcave"];
};
if (!isNil'_3816_171394054_4160224_17438') then {
	_3816_171394054_4160224_17438 setvariable ['spawnpointname',"rndcave"];
};
if (!isNil'_3853_685064078_1875024_51472') then {
	_3853_685064078_1875024_51472 setvariable ['spawnpointname',"rndcave"];
};
if (!isNil'_3861_489264107_1484424_05810') then {
	_3861_489264107_1484424_05810 setvariable ['spawnpointname',"rndcave"];
};
if (!isNil'_3712_729743967_593515_71991') then {
	_3712_729743967_593515_71991 setvariable ['spawnpointname',"escaper_location"];
};
if (!isNil'_3860_298834101_3476624_08509') then {
	_3860_298834101_3476624_08509 setvariable ['spawnpointname',"kochevniki"];
};
if (!isNil'_3745_816893972_464114_87182') then {
	_3745_816893972_464114_87182 setvariable ['destination',"tp_city"];
	_3745_816893972_464114_87182 setvariable ['tdistance',1.4];
};
if (!isNil'_3779_868653968_8442428_45285') then {
	_3779_868653968_8442428_45285 setvariable ['destination',"tp_escape"];
	_3779_868653968_8442428_45285 setvariable ['tdistance',1.4];
};
if (!isNil'_3830_003423976_2011727_15507') then {
	_3830_003423976_2011727_15507 setvariable ['keytypes',["medhome","super"]];
	_3830_003423976_2011727_15507 setvariable ['islocked',true];
};
if (!isNil'_3840_983403986_9311527_54247') then {
	_3840_983403986_9311527_54247 setvariable ['keytypes',["home_6","super"]];
};
if (!isNil'_3815_463383979_9812024_35577') then {
	_3815_463383979_9812024_35577 setvariable ['keytypes',["medpublic","medmain","super"]];
};
if (!isNil'_3834_613283984_4611824_37567') then {
	_3834_613283984_4611824_37567 setvariable ['keytypes',["pump","super"]];
	_3834_613283984_4611824_37567 setvariable ['islocked',true];
};
if (!isNil'_3840_893313986_7011724_46807') then {
	_3840_893313986_7011724_46807 setvariable ['keytypes',["home_3","super"]];
};
if (!isNil'_3842_213383977_3010324_53307') then {
	_3842_213383977_3010324_53307 setvariable ['keytypes',["home_1","super"]];
};
if (!isNil'_3842_993413978_1511227_50027') then {
	_3842_993413978_1511227_50027 setvariable ['keytypes',["badhome_5","super"]];
};
if (!isNil'_3845_803223980_0510327_48267') then {
	_3845_803223980_0510327_48267 setvariable ['keytypes',["badhome_4","super"]];
};
if (!isNil'_3854_473393976_1010724_52467') then {
	_3854_473393976_1010724_52467 setvariable ['keytypes',["home_9","super"]];
	_3854_473393976_1010724_52467 setvariable ['islocked',true];
};
if (!isNil'_3846_393313980_8510727_51007') then {
	_3846_393313980_8510727_51007 setvariable ['keytypes',["badhome_3","super"]];
};
if (!isNil'_3845_963383986_7211924_66767') then {
	_3845_963383986_7211924_66767 setvariable ['keytypes',["home_4","super"]];
};
if (!isNil'_3851_233403986_9211427_62127') then {
	_3851_233403986_9211427_62127 setvariable ['keytypes',["home_8","super"]];
	_3851_233403986_9211427_62127 setvariable ['islocked',true];
};
if (!isNil'_3849_593263983_1110824_25577') then {
	_3849_593263983_1110824_25577 setvariable ['keytypes',["home_2","super"]];
};
if (!isNil'_3846_013433987_0212427_58777') then {
	_3846_013433987_0212427_58777 setvariable ['keytypes',["home_7","super"]];
};
if (!isNil'_3851_113283986_7612324_43787') then {
	_3851_113283986_7612324_43787 setvariable ['keytypes',["home_5","super"]];
	_3851_113283986_7612324_43787 setvariable ['islocked',true];
};
if (!isNil'_3845_003423983_6311027_53777') then {
	_3845_003423983_6311027_53777 setvariable ['keytypes',["badhome_1","super"]];
};
if (!isNil'_3844_943363982_2211927_52957') then {
	_3844_943363982_2211927_52957 setvariable ['keytypes',["badhome_2","super"]];
};
if (!isNil'_3866_582284002_5793522_38407') then {
	_3866_582284002_5793522_38407 setvariable ['keytypes',["barpublic","super"]];
	_3866_582284002_5793522_38407 setvariable ['islocked',true];
};
if (!isNil'_3868_833254001_6811522_49827') then {
	_3868_833254001_6811522_49827 setvariable ['keytypes',["barpublic","super"]];
	_3868_833254001_6811522_49827 setvariable ['islocked',true];
};
if (!isNil'_3878_713383988_6511221_91217') then {
	_3878_713383988_6511221_91217 setvariable ['keytypes',["griblanka","super"]];
	_3878_713383988_6511221_91217 setvariable ['islocked',true];
};
if (!isNil'_3783_806643985_9480033_20531') then {
	_3783_806643985_9480033_20531 setvariable ['keytypes',["medpublic","medmain","super"]];
};
if (!isNil'_3853_564703944_9028327_94587') then {
	[_3853_564703944_9028327_94587,'RifleFinisherSmall',1,100] call (_3853_564703944_9028327_94587 getvariable 'proto' getvariable 'createItemInContainer');
	[_3853_564703944_9028327_94587,'MagazineFinisherLoaded',1,100] call (_3853_564703944_9028327_94587 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3855_534673943_9428727_95687') then {
	[_3855_534673943_9428727_95687,'CombatKnife',3,100] call (_3855_534673943_9428727_95687 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3859_003423955_9211416_95717') then {
	[_3859_003423955_9211416_95717,'Tumannik',1,58] call (_3859_003423955_9211416_95717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3859_003423955_9211416_95717,'Tumannik',1,100] call (_3859_003423955_9211416_95717 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3859_023193953_6411117_00177') then {
	[_3859_023193953_6411117_00177,'Tumannik',1,100] call (_3859_023193953_6411117_00177 getvariable 'proto' getvariable 'createItemInContainer');
	[_3859_023193953_6411117_00177,'Tumannik',1,29] call (_3859_023193953_6411117_00177 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3812_863283976_1511224_49197') then {
	_3812_863283976_1511224_49197 setvariable ['countslots',5];
	[_3812_863283976_1511224_49197,'PaperHolder',3,100] call (_3812_863283976_1511224_49197 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3787_323243995_3911129_49577') then {
	_3787_323243995_3911129_49577 setvariable ['keytypes',["moneybank"]];
	_3787_323243995_3911129_49577 setvariable ['islocked',true];
};
if (!isNil'_3830_773194000_3911123_86557') then {
	_3830_773194000_3911123_86557 setvariable ['islocked',true];
};
if (!isNil'_3832_433354005_0410228_53357') then {
	_3832_433354005_0410228_53357 setvariable ['keytypes',["gatepriv","gatemain","super"]];
	_3832_433354005_0410228_53357 setvariable ['islocked',true];
};
if (!isNil'_3842_033203933_6511221_72147') then {
	_3842_033203933_6511221_72147 setvariable ['keytypes',["sbskletka"]];
};
if (!isNil'_3842_073243948_5112321_85767') then {
	_3842_073243948_5112321_85767 setvariable ['keytypes',["sbskletka"]];
};
if (!isNil'_3842_063233939_2211921_78247') then {
	_3842_063233939_2211921_78247 setvariable ['keytypes',["sbskletka"]];
};
if (!isNil'_3842_123293944_7211921_78727') then {
	_3842_123293944_7211921_78727 setvariable ['keytypes',["sbskletka"]];
};
if (!isNil'_3853_023193941_9311527_63427') then {
	_3853_023193941_9311527_63427 setvariable ['keytypes',["sbsweapons_private"]];
	_3853_023193941_9311527_63427 setvariable ['islocked',true];
};
if (!isNil'_3833_045654011_9438528_49050') then {
	_3833_045654011_9438528_49050 setvariable ['keytypes',["gatepriv","gatemain","super"]];
	_3833_045654011_9438528_49050 setvariable ['islocked',true];
};
if (!isNil'_3710_300783967_114264_92780') then {
	_3710_300783967_114264_92780 setvariable ['name',"Движик"];
};
if (!isNil'_3713_160893967_542724_93402') then {
	_3713_160893967_542724_93402 setvariable ['name',"Движик"];
};
if (!isNil'_3715_381843967_948244_92065') then {
	_3715_381843967_948244_92065 setvariable ['name',"Движик"];
};
if (!isNil'_3833_713383972_8911124_45447') then {
	[_3833_713383972_8911124_45447,'PainkillerBox',3,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'CetalinBox',3,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'KoradizinBox',2,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'NeedleWithThreads',5,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'LiqDemitolin',1,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'LiqPainkiller',1,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_713383972_8911124_45447,'LiqTovimin',1,100] call (_3833_713383972_8911124_45447 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3840_383303933_2211925_47657') then {
	[_3840_383303933_2211925_47657,'Baton',4,100] call (_3840_383303933_2211925_47657 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3775_553223990_4311533_26997') then {
	[_3775_553223990_4311533_26997,'HeadCloth',1,100] call (_3775_553223990_4311533_26997 getvariable 'proto' getvariable 'createItemInContainer');
	[_3775_553223990_4311533_26997,'HeadCloth',1,48] call (_3775_553223990_4311533_26997 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3775_523193985_5810533_29116') then {
	[_3775_523193985_5810533_29116,'WomanBasicCloth',1,100] call (_3775_523193985_5810533_29116 getvariable 'proto' getvariable 'createItemInContainer');
	[_3775_523193985_5810533_29116,'WomanBasicCloth',1,47] call (_3775_523193985_5810533_29116 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3877_793214002_6411122_68407') then {
	[_3877_793214002_6411122_68407,'CookerCloth',2,100] call (_3877_793214002_6411122_68407 getvariable 'proto' getvariable 'createItemInContainer');
	[_3877_793214002_6411122_68407,'CookerCap',2,100] call (_3877_793214002_6411122_68407 getvariable 'proto' getvariable 'createItemInContainer');
	[_3877_793214002_6411122_68407,'BarmenCloth',1,100] call (_3877_793214002_6411122_68407 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3788_403323976_3410624_56436') then {
	
_o=_3788_403323976_3410624_56436;
([_o, "setHeadConsole" , ([_o, "_headcon" ] call reditor_binding_gref) ] call reditor_binding_fc)
};
if (!isNil'_3833_260014009_8059128_80827') then {
	
_o=_3833_260014009_8059128_80827;
([_o, "setHeadConsole" , ([_o, "_headcon" ] call reditor_binding_gref) ] call reditor_binding_fc)
};
if (!isNil'_3793_663333976_1110824_60057') then {
	[_3793_663333976_1110824_60057,'KnutCloth',1,100] call (_3793_663333976_1110824_60057 getvariable 'proto' getvariable 'createItemInContainer');
	[_3793_663333976_1110824_60057,'KnutCloth',1,42] call (_3793_663333976_1110824_60057 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3834_033203973_4711927_15506') then {
	[_3834_033203973_4711927_15506,'DoctorCloth',2,100] call (_3834_033203973_4711927_15506 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3833_653324013_1411124_42187') then {
	[_3833_653324013_1411124_42187,'WatchmanCloth',1,100] call (_3833_653324013_1411124_42187 getvariable 'proto' getvariable 'createItemInContainer');
	[_3833_653324013_1411124_42187,'WatchmanCloth',1,57] call (_3833_653324013_1411124_42187 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3854_483403935_8010323_58717') then {
	[_3854_483403935_8010323_58717,'BalaclavaMask',1,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3854_483403935_8010323_58717,'PenBlack',2,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3854_483403935_8010323_58717,'PenRed',1,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3854_483403935_8010323_58717,'PaperHolder',1,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3854_483403935_8010323_58717,'CaretakerCloth',1,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
	[_3854_483403935_8010323_58717,'VeteranCloth',3,100] call (_3854_483403935_8010323_58717 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3791_973393947_0610419_77187') then {
	[_3791_973393947_0610419_77187,'CliricCloth',2,100] call (_3791_973393947_0610419_77187 getvariable 'proto' getvariable 'createItemInContainer');
	[_3791_973393947_0610419_77187,'CliricCloth',1,57] call (_3791_973393947_0610419_77187 getvariable 'proto' getvariable 'createItemInContainer');
	[_3791_973393947_0610419_77187,'CliricCloth',1,56] call (_3791_973393947_0610419_77187 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3867_695314005_2231422_48117') then {
	[_3867_695314005_2231422_48117,'FoodPlate',5,100] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'SoupPlate',5,100] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'Key',2,100,[["var","name","Ключ от комнаты #1"],["var","keyowner",["hotelroom_1"]]]] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'Key',2,100,[["var","name","Ключ от комнаты #2"],["var","keyowner",["hotelroom_2"]]]] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'Key',2,100,[["var","name","Ключ от комнаты #3"],["var","keyowner",["hotelroom_3"]]]] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'Key',2,100,[["var","name","Ключ от комнаты #4"],["var","keyowner",["hotelroom_4"]]]] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
	[_3867_695314005_2231422_48117,'Key',2,100,[["var","name","Ключ от комнаты #5"],["var","keyowner",["hotelroom_5"]]]] call (_3867_695314005_2231422_48117 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3799_563234005_9611824_13087') then {
	[_3799_563234005_9611824_13087,'GromilaCloth',1,100] call (_3799_563234005_9611824_13087 getvariable 'proto' getvariable 'createItemInContainer');
	[_3799_563234005_9611824_13087,'GromilaCloth',1,50] call (_3799_563234005_9611824_13087 getvariable 'proto' getvariable 'createItemInContainer');
	[_3799_563234005_9611824_13087,'MerchantCloth',1,100] call (_3799_563234005_9611824_13087 getvariable 'proto' getvariable 'createItemInContainer');
	[_3799_563234005_9611824_13087,'MerchantCloth',1,45] call (_3799_563234005_9611824_13087 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3852_403323939_2512223_64137') then {
	[_3852_403323939_2512223_64137,'Key',5,100,[["var","name","Ключ от клеток"],["var","keyowner",["sbskletka"]]]] call (_3852_403323939_2512223_64137 getvariable 'proto' getvariable 'createItemInContainer');
	[_3852_403323939_2512223_64137,'HandcuffKey',5,100,[["var","handcuffs","dirtcity_handcuff"]]] call (_3852_403323939_2512223_64137 getvariable 'proto' getvariable 'createItemInContainer');
	[_3852_403323939_2512223_64137,'HandcuffItem',20,100,[["var","keylockers","dirtcity_handcuff"]]] call (_3852_403323939_2512223_64137 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3838_523193941_7011725_46737') then {
	[_3838_523193941_7011725_46737,'BalaclavaMask',2,100] call (_3838_523193941_7011725_46737 getvariable 'proto' getvariable 'createItemInContainer');
	[_3838_523193941_7011725_46737,'BalaclavaMask2',2,100] call (_3838_523193941_7011725_46737 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3860_763433953_5112317_00177') then {
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_genTrans"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swTrader"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swGate"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swCityLiving"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swSec"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swCitySec"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swBar"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swAdmin"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swCitySquare"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swMedical"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
	[_3860_763433953_5112317_00177,go_editor_globalRefs get "_swIndust"] call (_3860_763433953_5112317_00177 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3865_533203960_8410616_97067') then {
	
_o=_3865_533203960_8410616_97067;
_mark = "_gen"; 
([_o, "connectToGenerator", 
  ([_o, _mark ] call reditor_binding_gref) 
] call reditor_binding_fc)
};
if (!isNil'_3791_393313949_9411619_71817') then {
	_3791_393313949_9411619_71817 setvariable ['keytypes',["abbat","super"]];
	_3791_393313949_9411619_71817 setvariable ['islocked',true];
};
if (!isNil'_3784_893313986_7111829_39367') then {
	_3784_893313986_7111829_39367 setvariable ['keytypes',["headup","super"]];
	_3784_893313986_7111829_39367 setvariable ['islocked',true];
};
if (!isNil'_3808_313234005_0810524_13457') then {
	_3808_313234005_0810524_13457 setvariable ['keytypes',["torg","super"]];
	_3808_313234005_0810524_13457 setvariable ['islocked',true];
};
if (!isNil'_3831_663333997_5710424_18157') then {
	_3831_663333997_5710424_18157 setvariable ['keytypes',["gatepub","gatemain","super"]];
	_3831_663333997_5710424_18157 setvariable ['islocked',true];
};
if (!isNil'_3828_353273977_8610824_23877') then {
	_3828_353273977_8610824_23877 setvariable ['keytypes',["medprivate","medmain","super"]];
	_3828_353273977_8610824_23877 setvariable ['islocked',true];
};
if (!isNil'_3822_113283974_0510323_99897') then {
	_3822_113283974_0510323_99897 setvariable ['keytypes',["medprivate","medmain","super"]];
	_3822_113283974_0510323_99897 setvariable ['islocked',true];
};
if (!isNil'_3833_143314003_2211924_14157') then {
	_3833_143314003_2211924_14157 setvariable ['keytypes',["gatepriv","gatemain","super"]];
	_3833_143314003_2211924_14157 setvariable ['islocked',true];
};
if (!isNil'_3832_583254002_1911628_69917') then {
	_3832_583254002_1911628_69917 setvariable ['keytypes',["gatepub","gatemain","super"]];
	_3832_583254002_1911628_69917 setvariable ['islocked',true];
};
if (!isNil'_3842_603273955_2810122_13427') then {
	_3842_603273955_2810122_13427 setvariable ['keytypes',["sbshall","sbsmain","super"]];
	_3842_603273955_2810122_13427 setvariable ['islocked',true];
};
if (!isNil'_3874_303223992_9311521_91067') then {
	_3874_303223992_9311521_91067 setvariable ['keytypes',["kitchen","super"]];
	_3874_303223992_9311521_91067 setvariable ['islocked',true];
};
if (!isNil'_3784_857673986_7465833_15168') then {
	_3784_857673986_7465833_15168 setvariable ['keytypes',["headup","super"]];
	_3784_857673986_7465833_15168 setvariable ['islocked',true];
};
if (!isNil'_3803_795174004_8940424_03793') then {
	_3803_795174004_8940424_03793 setvariable ['keytypes',["torg","super"]];
	_3803_795174004_8940424_03793 setvariable ['islocked',true];
};
if (!isNil'_3803_823004007_1550324_19521') then {
	_3803_823004007_1550324_19521 setvariable ['keytypes',["torg","super"]];
	_3803_823004007_1550324_19521 setvariable ['islocked',true];
};
if (!isNil'_3797_333253975_5112324_51737') then {
	_3797_333253975_5112324_51737 setvariable ['keytypes',["minihead","super"]];
	_3797_333253975_5112324_51737 setvariable ['islocked',true];
};
if (!isNil'_3841_123293949_9011225_47307') then {
	_3841_123293949_9011225_47307 setvariable ['keytypes',["sbshome","sbsmain","super"]];
	_3841_123293949_9011225_47307 setvariable ['islocked',true];
};
if (!isNil'_3850_653323941_9611823_53287') then {
	_3850_653323941_9611823_53287 setvariable ['keytypes',["sbshome","sbsmain","super"]];
	_3850_653323941_9611823_53287 setvariable ['islocked',true];
};
if (!isNil'_3859_103273979_9311524_54517') then {
	_3859_103273979_9311524_54517 setvariable ['keytypes',["hotelroom_1","hotelmain"]];
	_3859_103273979_9311524_54517 setvariable ['desc',"На двери вдино старый номерок с цифрой 1"];
	_3859_103273979_9311524_54517 setvariable ['islocked',true];
};
if (!isNil'_3861_743413975_7810124_40907') then {
	_3861_743413975_7810124_40907 setvariable ['keytypes',["hotelroom_5","hotelmain"]];
	_3861_743413975_7810124_40907 setvariable ['desc',"На двери вдино старый номерок с цифрой 5"];
	_3861_743413975_7810124_40907 setvariable ['islocked',true];
};
if (!isNil'_3864_173343975_6611324_54917') then {
	_3864_173343975_6611324_54917 setvariable ['keytypes',["hotelroom_4","hotelmain"]];
	_3864_173343975_6611324_54917 setvariable ['desc',"На двери вдино старый номерок с цифрой 4"];
	_3864_173343975_6611324_54917 setvariable ['islocked',true];
};
if (!isNil'_3864_853273976_5810524_56117') then {
	_3864_853273976_5810524_56117 setvariable ['keytypes',["hotelroom_3","hotelmain"]];
	_3864_853273976_5810524_56117 setvariable ['desc',"На двери вдино старый номерок с цифрой 3"];
	_3864_853273976_5810524_56117 setvariable ['islocked',true];
};
if (!isNil'_3863_893313979_8710924_53207') then {
	_3863_893313979_8710924_53207 setvariable ['keytypes',["hotelroom_2","hotelmain"]];
	_3863_893313979_8710924_53207 setvariable ['desc',"На двери вдино старый номерок с цифрой 2"];
	_3863_893313979_8710924_53207 setvariable ['islocked',true];
};
if (!isNil'_3874_363283999_4211422_40407') then {
	_3874_363283999_4211422_40407 setvariable ['keytypes',["barhome","super"]];
	_3874_363283999_4211422_40407 setvariable ['islocked',true];
};
if (!isNil'_3845_889163951_3642622_23729') then {
	_3845_889163951_3642622_23729 setvariable ['keytypes',["sbshome","sbsmain","super"]];
};
if (!isNil'_3826_863284004_4111328_81617') then {
	_3826_863284004_4111328_81617 setvariable ['keytypes',["gatepriv","gatemain"]];
	_3826_863284004_4111328_81617 setvariable ['islocked',true];
};
if (!isNil'_3803_433353979_3710926_58587') then {
	_3803_433353979_3710926_58587 setvariable ['keytypes',["headpre","minihead","super"]];
	_3803_433353979_3710926_58587 setvariable ['islocked',true];
};
if (!isNil'_3789_203373989_3911129_43227') then {
	_3789_203373989_3911129_43227 setvariable ['keytypes',["sobranie","minihead","super"]];
	_3789_203373989_3911129_43227 setvariable ['islocked',false];
};
if (!isNil'_3787_753423992_9812029_27977') then {
	_3787_753423992_9812029_27977 setvariable ['keytypes',["moneybank"]];
	_3787_753423992_9812029_27977 setvariable ['islocked',true];
};
if (!isNil'_3851_783203937_6411123_48287') then {
	_3851_783203937_6411123_48287 setvariable ['keytypes',["sbsprivate","super"]];
	_3851_783203937_6411123_48287 setvariable ['islocked',true];
};
if (!isNil'_3858_303223957_3811016_89077') then {
	_3858_303223957_3811016_89077 setvariable ['keytypes',["brig","super"]];
	_3858_303223957_3811016_89077 setvariable ['islocked',true];
};
if (!isNil'_3852_453373939_2612327_89747') then {
	_3852_453373939_2612327_89747 setvariable ['keytypes',["sbsweapons"]];
	_3852_453373939_2612327_89747 setvariable ['islocked',true];
};
if (!isNil'_3902_443363964_6711419_35287') then {
	_3902_443363964_6711419_35287 setvariable ['keytypes',["grave","super"]];
	_3902_443363964_6711419_35287 setvariable ['islocked',true];
};
if (!isNil'_3862_327883956_6872616_84690') then {
	_3862_327883956_6872616_84690 setvariable ['keytypes',["brig","super"]];
	_3862_327883956_6872616_84690 setvariable ['islocked',true];
};
if (!isNil'_3715_427003967_935065_42207') then {
	_3715_427003967_935065_42207 setvariable ['name',"Двигатель"];
};
if (!isNil'_3853_233403936_1110824_41267') then {
	_3853_233403936_1110824_41267 setvariable ['name',"Ключ от приватной оружейной"];
	_3853_233403936_1110824_41267 setvariable ['keyowner',["sbsweapons_private"]];
};
if (!isNil'_3876_923343998_1611323_62947') then {
	_3876_923343998_1611323_62947 setvariable ['name',"Ключ от бара"];
	_3876_923343998_1611323_62947 setvariable ['keyowner',["kitchen","barpublic"]];
};
if (!isNil'_3784_533203987_8710931_44496') then {
	[_3784_533203987_8710931_44496,go_editor_globalRefs get "Imported Intercom47894"] call (_3784_533203987_8710931_44496 getvariable 'proto' getvariable 'addConnection');
	[_3784_533203987_8710931_44496,go_editor_globalRefs get "_headcon"] call (_3784_533203987_8710931_44496 getvariable 'proto' getvariable 'addConnection');
	[_3784_533203987_8710931_44496,go_editor_globalRefs get "Imported LampCeiling33082"] call (_3784_533203987_8710931_44496 getvariable 'proto' getvariable 'addConnection');
	[_3784_533203987_8710931_44496,go_editor_globalRefs get "Imported LampCeiling125000"] call (_3784_533203987_8710931_44496 getvariable 'proto' getvariable 'addConnection');
	[_3784_533203987_8710931_44496,go_editor_globalRefs get "Imported LampCeiling856506"] call (_3784_533203987_8710931_44496 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3780_093263987_9311534_67156') then {
	[_3780_093263987_9311534_67156,go_editor_globalRefs get "Imported LampCeiling315928"] call (_3780_093263987_9311534_67156 getvariable 'proto' getvariable 'addConnection');
	[_3780_093263987_9311534_67156,go_editor_globalRefs get "Imported LampCeiling432651"] call (_3780_093263987_9311534_67156 getvariable 'proto' getvariable 'addConnection');
	[_3780_093263987_9311534_67156,go_editor_globalRefs get "Imported LampCeiling666555"] call (_3780_093263987_9311534_67156 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3804_033204006_1210925_72616') then {
	[_3804_033204006_1210925_72616,go_editor_globalRefs get "Imported LampWall97324"] call (_3804_033204006_1210925_72616 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3808_328864003_5336925_16447') then {
	[_3808_328864003_5336925_16447,go_editor_globalRefs get "Imported LampCeiling250516"] call (_3808_328864003_5336925_16447 getvariable 'proto' getvariable 'addConnection');
	[_3808_328864003_5336925_16447,go_editor_globalRefs get "Imported LampWall912514"] call (_3808_328864003_5336925_16447 getvariable 'proto' getvariable 'addConnection');
	[_3808_328864003_5336925_16447,go_editor_globalRefs get "Imported LampWall530585"] call (_3808_328864003_5336925_16447 getvariable 'proto' getvariable 'addConnection');
	[_3808_328864003_5336925_16447,go_editor_globalRefs get "_dp_trader"] call (_3808_328864003_5336925_16447 getvariable 'proto' getvariable 'addConnection');
	[_3808_328864003_5336925_16447,go_editor_globalRefs get "Imported MerchantConsole963969"] call (_3808_328864003_5336925_16447 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3840_113283949_8610826_86696') then {
	[_3840_113283949_8610826_86696,go_editor_globalRefs get "Imported LampWall338809"] call (_3840_113283949_8610826_86696 getvariable 'proto' getvariable 'addConnection');
	[_3840_113283949_8610826_86696,go_editor_globalRefs get "Imported LampWall981747"] call (_3840_113283949_8610826_86696 getvariable 'proto' getvariable 'addConnection');
	[_3840_113283949_8610826_86696,go_editor_globalRefs get "Imported LampWall162515"] call (_3840_113283949_8610826_86696 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3819_083253976_7312025_83176') then {
	[_3819_083253976_7312025_83176,go_editor_globalRefs get "Imported LampWall953697"] call (_3819_083253976_7312025_83176 getvariable 'proto' getvariable 'addConnection');
	[_3819_083253976_7312025_83176,go_editor_globalRefs get "Imported LampWall493836"] call (_3819_083253976_7312025_83176 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3830_193363974_8911128_57926') then {
	[_3830_193363974_8911128_57926,go_editor_globalRefs get "Imported LampCeiling921580"] call (_3830_193363974_8911128_57926 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3832_803223997_6911625_48516') then {
	[_3832_803223997_6911625_48516,go_editor_globalRefs get "Imported LampWall189793"] call (_3832_803223997_6911625_48516 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3832_113284003_6210925_78366') then {
	[_3832_113284003_6210925_78366,go_editor_globalRefs get "Imported LampWall244287"] call (_3832_113284003_6210925_78366 getvariable 'proto' getvariable 'addConnection');
	[_3832_113284003_6210925_78366,go_editor_globalRefs get "Imported LampWall580698"] call (_3832_113284003_6210925_78366 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3852_093263936_8210424_94036') then {
	[_3852_093263936_8210424_94036,go_editor_globalRefs get "Imported LampCeiling673548"] call (_3852_093263936_8210424_94036 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3858_583253958_4311518_65177') then {
	_3858_583253958_4311518_65177 setvariable ['name',"Свет 'Генераторная'"];
	[_3858_583253958_4311518_65177,go_editor_globalRefs get "Imported LampWall324354"] call (_3858_583253958_4311518_65177 getvariable 'proto' getvariable 'addConnection');
	[_3858_583253958_4311518_65177,go_editor_globalRefs get "Imported LampWall435541"] call (_3858_583253958_4311518_65177 getvariable 'proto' getvariable 'addConnection');
	[_3858_583253958_4311518_65177,go_editor_globalRefs get "Imported LampWall625366"] call (_3858_583253958_4311518_65177 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3842_953373952_6210926_86427') then {
	[_3842_953373952_6210926_86427,go_editor_globalRefs get "Imported LampWall242546"] call (_3842_953373952_6210926_86427 getvariable 'proto' getvariable 'addConnection');
	[_3842_953373952_6210926_86427,go_editor_globalRefs get "Imported LampWall449694"] call (_3842_953373952_6210926_86427 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3868_053224000_5112323_70726') then {
	_3868_053224000_5112323_70726 setvariable ['name',"Табличка"];
	[_3868_053224000_5112323_70726,go_editor_globalRefs get "Imported SignBar8232"] call (_3868_053224000_5112323_70726 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3867_703374000_5112323_69526') then {
	_3867_703374000_5112323_69526 setvariable ['name',"Стойка"];
	[_3867_703374000_5112323_69526,go_editor_globalRefs get "Imported LampCeiling972617"] call (_3867_703374000_5112323_69526 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3867_323244000_5212423_69086') then {
	_3867_323244000_5212423_69086 setvariable ['name',"Свет"];
	[_3867_323244000_5212423_69086,go_editor_globalRefs get "Imported LampCeiling_Red714931"] call (_3867_323244000_5212423_69086 getvariable 'proto' getvariable 'addConnection');
	[_3867_323244000_5212423_69086,go_editor_globalRefs get "Imported LampCeiling923377"] call (_3867_323244000_5212423_69086 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3867_003424000_5510323_69136') then {
	_3867_003424000_5510323_69136 setvariable ['name',"Приватная зона"];
	[_3867_003424000_5510323_69136,go_editor_globalRefs get "Imported LampCeiling_Red840405"] call (_3867_003424000_5510323_69136 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3870_783204003_4611823_28426') then {
	[_3870_783204003_4611823_28426,go_editor_globalRefs get "Imported LampCeiling897890"] call (_3870_783204003_4611823_28426 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3874_413333998_5112323_98516') then {
	[_3874_413333998_5112323_98516,go_editor_globalRefs get "Imported LampCeiling358156"] call (_3874_413333998_5112323_98516 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3775_933353990_0310129_84590') then {
	[_3775_933353990_0310129_84590,'TorchDisabled',3,100] call (_3775_933353990_0310129_84590 getvariable 'proto' getvariable 'createItemInContainer');
	[_3775_933353990_0310129_84590,'MatchBox',2,100] call (_3775_933353990_0310129_84590 getvariable 'proto' getvariable 'createItemInContainer');
	[_3775_933353990_0310129_84590,'SigaretteDisabled',8,100] call (_3775_933353990_0310129_84590 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3779_003423990_6811529_94817') then {
	
_o=_3779_003423990_6811529_94817;
([_o, "addSpeaker", (([_o, "_spkr_1" ] call reditor_binding_gref)) ] call reditor_binding_fc);
([_o, "addSpeaker", (([_o, "_spkr_2" ] call reditor_binding_gref)) ] call reditor_binding_fc);
([_o, "addSpeaker", (([_o, "_spkr_3" ] call reditor_binding_gref)) ] call reditor_binding_fc);
([_o, "addSpeaker", (([_o, "_spkr_4" ] call reditor_binding_gref)) ] call reditor_binding_fc);
([_o, "addSpeaker", (([_o, "_spkr_5" ] call reditor_binding_gref)) ] call reditor_binding_fc);
([_o, "addSpeaker", (([_o, "_spkr_6" ] call reditor_binding_gref)) ] call reditor_binding_fc);





};
if (!isNil'_3845_869143952_8059124_62250') then {
	_3845_869143952_8059124_62250 setvariable ['name',"Слабая лампа"];
	_3845_869143952_8059124_62250 setvariable ['edreqpower',10];
};
if (!isNil'_3811_633303977_5710425_43587') then {
	[_3811_633303977_5710425_43587,'Bandage',1,37] call (_3811_633303977_5710425_43587 getvariable 'proto' getvariable 'createItemInContainer');
	[_3811_633303977_5710425_43587,'PainkillerBox',1,30] call (_3811_633303977_5710425_43587 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3827_223393977_7011725_57367') then {
	[_3827_223393977_7011725_57367,'Bandage',11,100] call (_3827_223393977_7011725_57367 getvariable 'proto' getvariable 'createItemInContainer');
	[_3827_223393977_7011725_57367,'PainkillerBox',2,100] call (_3827_223393977_7011725_57367 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3855_373293941_8510724_73707') then {
	[_3855_373293941_8510724_73707,'Bandage',4,70] call (_3855_373293941_8510724_73707 getvariable 'proto' getvariable 'createItemInContainer');
	[_3855_373293941_8510724_73707,'PainkillerBox',1,60] call (_3855_373293941_8510724_73707 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3842_253423936_4211425_55867') then {
	[_3842_253423936_4211425_55867,'Key',1,100,[["var","name","Ключ от клеток"],["var","keyowner",["sbskletka"]]]] call (_3842_253423936_4211425_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_253423936_4211425_55867,'BalaclavaMask',1,100] call (_3842_253423936_4211425_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_253423936_4211425_55867,'StreakCloth',1,100] call (_3842_253423936_4211425_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_253423936_4211425_55867,'HandcuffItem',2,100,[["var","keylockers","dirtcity_handcuff"]]] call (_3842_253423936_4211425_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_253423936_4211425_55867,'HandcuffKey',1,100,[["var","handcuffs","dirtcity_handcuff"]]] call (_3842_253423936_4211425_55867 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3842_273193935_8911125_55867') then {
	[_3842_273193935_8911125_55867,'Key',1,100,[["var","name","Ключ от клеток"],["var","keyowner",["sbskletka"]]]] call (_3842_273193935_8911125_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_273193935_8911125_55867,'BalaclavaMask',1,100] call (_3842_273193935_8911125_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_273193935_8911125_55867,'StreakCloth',1,100] call (_3842_273193935_8911125_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_273193935_8911125_55867,'HandcuffItem',2,100,[["var","keylockers","dirtcity_handcuff"]]] call (_3842_273193935_8911125_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_273193935_8911125_55867,'HandcuffKey',1,100,[["var","handcuffs","dirtcity_handcuff"]]] call (_3842_273193935_8911125_55867 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3842_283203935_3210425_53367') then {
	[_3842_283203935_3210425_53367,'Key',1,100,[["var","name","Ключ от клеток"],["var","keyowner",["sbskletka"]]]] call (_3842_283203935_3210425_53367 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_283203935_3210425_53367,'BalaclavaMask',1,100] call (_3842_283203935_3210425_53367 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_283203935_3210425_53367,'StreakCloth',1,100] call (_3842_283203935_3210425_53367 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_283203935_3210425_53367,'HandcuffItem',2,100,[["var","keylockers","dirtcity_handcuff"]]] call (_3842_283203935_3210425_53367 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_283203935_3210425_53367,'HandcuffKey',1,100,[["var","handcuffs","dirtcity_handcuff"]]] call (_3842_283203935_3210425_53367 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3842_233403936_9511725_55867') then {
	[_3842_233403936_9511725_55867,'Key',1,100,[["var","name","Ключ от клеток"],["var","keyowner",["sbskletka"]]]] call (_3842_233403936_9511725_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_233403936_9511725_55867,'BalaclavaMask',1,100] call (_3842_233403936_9511725_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_233403936_9511725_55867,'StreakCloth',1,100] call (_3842_233403936_9511725_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_233403936_9511725_55867,'HandcuffItem',2,100,[["var","keylockers","dirtcity_handcuff"]]] call (_3842_233403936_9511725_55867 getvariable 'proto' getvariable 'createItemInContainer');
	[_3842_233403936_9511725_55867,'HandcuffKey',1,100,[["var","handcuffs","dirtcity_handcuff"]]] call (_3842_233403936_9511725_55867 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3803_313234007_3811028_42756') then {
	
_o=_3803_313234007_3811028_42756;
_mark = "_dp_trader"; 
([_o, "linkpipe", 
  ([_o, _mark ] call reditor_binding_gref) 
] call reditor_binding_fc)
};
if (!isNil'_3828_423344009_6711425_11897') then {
	_3828_423344009_6711425_11897 setvariable ['name',"Внутренние врата"];
	[_3828_423344009_6711425_11897,go_editor_globalRefs get "Imported GateCity677114"] call (_3828_423344009_6711425_11897 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3828_433354010_0012225_10857') then {
	_3828_433354010_0012225_10857 setvariable ['name',"Внешние врата"];
	[_3828_433354010_0012225_10857,go_editor_globalRefs get "Imported GateCity963902"] call (_3828_433354010_0012225_10857 getvariable 'proto' getvariable 'addConnection');
	[_3828_433354010_0012225_10857,go_editor_globalRefs get "Imported GateCity179936"] call (_3828_433354010_0012225_10857 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3829_693364005_9411629_78737') then {
	[_3829_693364005_9411629_78737,go_editor_globalRefs get "Imported SteelGridDoorElectronic517134"] call (_3829_693364005_9411629_78737 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3846_183353945_3811023_45517') then {
	[_3846_183353945_3811023_45517,go_editor_globalRefs get "Imported SteelGridDoorElectronic329481"] call (_3846_183353945_3811023_45517 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3843_536623955_1259823_23887') then {
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported StreetLamp848884"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported LampCeiling194730"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported LampCeiling695369"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported LampCeiling34896"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported LampCeiling193459"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "Imported LampCeiling896946"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
	[_3843_536623955_1259823_23887,go_editor_globalRefs get "_spkr_4"] call (_3843_536623955_1259823_23887 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3785_883303992_0610433_28727') then {
	[_3785_883303992_0610433_28727,'Key',2,100,[["var","name","Главоключ"],["var","keyowner",["super","gatemain","sbsmain"]]]] call (_3785_883303992_0610433_28727 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3854_433353936_5310127_99822') then {
	[_3854_433353936_5310127_99822,'AmmoBoxPBMNonLethal',2,100] call (_3854_433353936_5310127_99822 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3648_864013858_6816418_30062') then {
	[_3648_864013858_6816418_30062,'SurgeryScalpel',1,100] call (_3648_864013858_6816418_30062 getvariable 'proto' getvariable 'createItemInContainer');
	[_3648_864013858_6816418_30062,'SurgicalExpander',1,100] call (_3648_864013858_6816418_30062 getvariable 'proto' getvariable 'createItemInContainer');
	[_3648_864013858_6816418_30062,'NeedleWithThreads',1,100] call (_3648_864013858_6816418_30062 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3806_233403980_8710929_88357') then {
	_3806_233403980_8710929_88357 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3806_233403980_8710929_88357 setvariable ['edisenabled',true];
};
if (!isNil'_3825_113283997_8911127_20317') then {
	_3825_113283997_8911127_20317 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3825_113283997_8911127_20317 setvariable ['edisenabled',true];
};
if (!isNil'_3835_463383981_5410228_24807') then {
	_3835_463383981_5410228_24807 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3835_463383981_5410228_24807 setvariable ['edisenabled',true];
};
if (!isNil'_3845_443363955_7111825_92797') then {
	_3845_443363955_7111825_92797 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3845_443363955_7111825_92797 setvariable ['edisenabled',true];
};
if (!isNil'_3859_683353991_1611326_42827') then {
	_3859_683353991_1611326_42827 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3859_683353991_1611326_42827 setvariable ['edisenabled',true];
};
if (!isNil'_3899_183353989_8610824_88847') then {
	_3899_183353989_8610824_88847 setvariable ['radiosettings',[1,"enc_sta",10,30,any,1000,0]];
	_3899_183353989_8610824_88847 setvariable ['edisenabled',true];
};
if (!isNil'_3779_493413987_9211430_51447') then {
	_3779_493413987_9211430_51447 setvariable ['radiosettings',[1,"enc_sta",-10,5,any,1000,0]];
};
if (!isNil'_3819_203374015_3610824_83987') then {
	_3819_203374015_3610824_83987 setvariable ['radiosettings',[1,"enc_tg",10,5,any,300,0]];
};
if (!isNil'_3828_513434009_2712424_85497') then {
	_3828_513434009_2712424_85497 setvariable ['radiosettings',[1,"enc_tg",10,5,any,300,0]];
};
if (!isNil'_3868_769043998_4140622_53541') then {
	[_3868_769043998_4140622_53541,'Mug',5,100] call (_3868_769043998_4140622_53541 getvariable 'proto' getvariable 'createItemInContainer');
	[_3868_769043998_4140622_53541,'WoodenCup',5,100] call (_3868_769043998_4140622_53541 getvariable 'proto' getvariable 'createItemInContainer');
	[_3868_769043998_4140622_53541,'OlderWoodenCup',5,100] call (_3868_769043998_4140622_53541 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3826_373294009_2412124_17607') then {
	
_o=_3826_373294009_2412124_17607;
([_o, "setReceiverObj", ([_o, "_paperPress" ] call reditor_binding_gref) ] call reditor_binding_fc)
};
if (!isNil'_3781_415043981_2993233_13918') then {
	_3781_415043981_2993233_13918 setvariable ['name',"Тайник Фенрира"];
	[_3781_415043981_2993233_13918,'SpirtBottle',1,52] call (_3781_415043981_2993233_13918 getvariable 'proto' getvariable 'createItemInContainer');
	[_3781_415043981_2993233_13918,'Zvak',2,46] call (_3781_415043981_2993233_13918 getvariable 'proto' getvariable 'createItemInContainer');
	[_3781_415043981_2993233_13918,'KitchenKnife',1,8] call (_3781_415043981_2993233_13918 getvariable 'proto' getvariable 'createItemInContainer');
	[_3781_415043981_2993233_13918,'BrightRedCloth',1,77] call (_3781_415043981_2993233_13918 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3803_283203984_0510330_20917') then {
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_adminbase_1"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_adminhallhome"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_adminbase_2"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_bank"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_meetingadm"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_btminiadmin"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "_sw_adminevent"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "Imported LampCeiling176782"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "Imported LampCeiling927113"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "Imported LampCeiling686773"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
	[_3803_283203984_0510330_20917,go_editor_globalRefs get "Imported LampCeiling980749"] call (_3803_283203984_0510330_20917 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3802_582524010_5485825_08827') then {
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "Imported LampCeiling264769"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "Imported StreetLamp862849"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "_sw_tradework"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "_sw_tradehall"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "Imported LampCeiling273917"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
	[_3802_582524010_5485825_08827,go_editor_globalRefs get "Imported LampCeiling618496"] call (_3802_582524010_5485825_08827 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3833_463383976_2910224_92037') then {
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported LampCeiling547543"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported LampCeiling336516"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported LampCeiling841910"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported LampCeiling802733"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported LampCeiling477663"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "_sw_medcommon"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "_sw_medprivate"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
	[_3833_463383976_2910224_92037,go_editor_globalRefs get "Imported SignMedical564417"] call (_3833_463383976_2910224_92037 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3834_798584006_4126028_69736') then {
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_swGateLib"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "Imported LampCeiling877246"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "Imported LampCeiling71870"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "Imported StreetLamp5111"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_swGateWork"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_gateact_internal"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_gateact_external"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_swact_gatejailtemp"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "Imported Intercom943681"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "Imported Intercom516853"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
	[_3834_798584006_4126028_69736,go_editor_globalRefs get "_paperPress"] call (_3834_798584006_4126028_69736 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3866_863283953_8310517_00187') then {
	_3866_863283953_8310517_00187 setvariable ['name',"Генераторная"];
	[_3866_863283953_8310517_00187,go_editor_globalRefs get "_sw_GenLight"] call (_3866_863283953_8310517_00187 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3855_403323943_7712423_63507') then {
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_sw_SecHome"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_sw_SecAdmHome"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_sw_SecHall"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_sw_armory"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_act_jaildoor"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "_sw_SecHallLower"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
	[_3855_403323943_7712423_63507,go_editor_globalRefs get "Tumbler G:ClpPHGWDpXc"] call (_3855_403323943_7712423_63507 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3871_903323993_7910221_97147') then {
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barsign"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barstoika"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barlight"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barvip"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barwork"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
	[_3871_903323993_7910221_97147,go_editor_globalRefs get "_sw_barhome"] call (_3871_903323993_7910221_97147 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3874_833253986_7412121_88116') then {
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "Imported LampCeiling603949"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "Imported LampCeiling461642"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "Imported StreetLamp134473"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "Imported StreetLamp901674"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "_spkr_6"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
	[_3874_833253986_7412121_88116,go_editor_globalRefs get "Imported StreetLamp854465"] call (_3874_833253986_7412121_88116 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3786_803223992_7612331_12637') then {
	_3786_803223992_7612331_12637 setvariable ['edisenabled',false];
	[_3786_803223992_7612331_12637,go_editor_globalRefs get "Imported LampCeiling491427"] call (_3786_803223992_7612331_12637 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3789_093263988_4011231_36857') then {
	[_3789_093263988_4011231_36857,go_editor_globalRefs get "Imported LampCeiling286957"] call (_3789_093263988_4011231_36857 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3795_473393973_9111325_75927') then {
	[_3795_473393973_9111325_75927,go_editor_globalRefs get "Imported LampCeiling838025"] call (_3795_473393973_9111325_75927 getvariable 'proto' getvariable 'addConnection');
	[_3795_473393973_9111325_75927,go_editor_globalRefs get "Imported LampCeiling732907"] call (_3795_473393973_9111325_75927 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3804_213383984_6611330_98627') then {
	[_3804_213383984_6611330_98627,go_editor_globalRefs get "Imported StreetLamp527501"] call (_3804_213383984_6611330_98627 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3862_833253953_0810519_00897') then {
	_3862_833253953_0810519_00897 setvariable ['name',"Торговая зона"];
	[_3862_833253953_0810519_00897,go_editor_globalRefs get "_transTrader"] call (_3862_833253953_0810519_00897 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3862_863283953_1611318_50237') then {
	_3862_863283953_1611318_50237 setvariable ['name',"Врата"];
	[_3862_863283953_1611318_50237,go_editor_globalRefs get "_transGate"] call (_3862_863283953_1611318_50237 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_253423953_1511218_12977') then {
	_3863_253423953_1511218_12977 setvariable ['name',"Улицы 'Жилая зона'"];
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "Imported LampCeiling142153"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "Imported StreetLamp677578"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "_spkr_3"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "Imported LampCeiling113425"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "Imported LampCeiling322389"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
	[_3863_253423953_1511218_12977,go_editor_globalRefs get "Imported StreetLamp656328"] call (_3863_253423953_1511218_12977 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3864_163333953_1110818_36817') then {
	_3864_163333953_1110818_36817 setvariable ['name',"Охрана"];
	[_3864_163333953_1110818_36817,go_editor_globalRefs get "_transSec"] call (_3864_163333953_1110818_36817 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3851_423343938_4411629_44787') then {
	[_3851_423343938_4411629_44787,go_editor_globalRefs get "Imported LampWall122905"] call (_3851_423343938_4411629_44787 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_723393953_1210918_18037') then {
	_3863_723393953_1210918_18037 setvariable ['name',"Улицы 'Охрана'"];
	[_3863_723393953_1210918_18037,go_editor_globalRefs get "Imported LampCeiling734320"] call (_3863_723393953_1210918_18037 getvariable 'proto' getvariable 'addConnection');
	[_3863_723393953_1210918_18037,go_editor_globalRefs get "Imported StreetLamp958271"] call (_3863_723393953_1210918_18037 getvariable 'proto' getvariable 'addConnection');
	[_3863_723393953_1210918_18037,go_editor_globalRefs get "Imported StreetLamp24839"] call (_3863_723393953_1210918_18037 getvariable 'proto' getvariable 'addConnection');
	[_3863_723393953_1210918_18037,go_editor_globalRefs get "Imported LampCeiling493290"] call (_3863_723393953_1210918_18037 getvariable 'proto' getvariable 'addConnection');
	[_3863_723393953_1210918_18037,go_editor_globalRefs get "Imported LampCeiling78688"] call (_3863_723393953_1210918_18037 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3862_873293953_1511217_87807') then {
	_3862_873293953_1511217_87807 setvariable ['name',"Бар"];
	[_3862_873293953_1511217_87807,go_editor_globalRefs get "_transBar"] call (_3862_873293953_1511217_87807 getvariable 'proto' getvariable 'addConnection');
	[_3862_873293953_1511217_87807,go_editor_globalRefs get "_spkr_5"] call (_3862_873293953_1511217_87807 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_313233953_1311019_02427') then {
	_3863_313233953_1311019_02427 setvariable ['name',"Администрация"];
	[_3863_313233953_1311019_02427,go_editor_globalRefs get "_transAdmin"] call (_3863_313233953_1311019_02427 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1311019_02427,go_editor_globalRefs get "_spkr_1"] call (_3863_313233953_1311019_02427 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_313233953_1010718_61207') then {
	_3863_313233953_1010718_61207 setvariable ['name',"Улицы 'Площадь'"];
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "Imported LampCeiling385116"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "Imported StreetLamp127348"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "Imported StreetLamp523280"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "Imported StreetLamp309553"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "_spkr_2"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
	[_3863_313233953_1010718_61207,go_editor_globalRefs get "Imported StreetLamp960143"] call (_3863_313233953_1010718_61207 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_743413953_1110818_79157') then {
	_3863_743413953_1110818_79157 setvariable ['name',"Лекарня"];
	[_3863_743413953_1110818_79157,go_editor_globalRefs get "_transMed"] call (_3863_743413953_1110818_79157 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3863_343263953_1511217_68317') then {
	_3863_343263953_1511217_68317 setvariable ['name',"Пром. зона"];
	[_3863_343263953_1511217_68317,go_editor_globalRefs get "_transIndust"] call (_3863_343263953_1511217_68317 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3846_856203951_4355523_61390') then {
	[_3846_856203951_4355523_61390,go_editor_globalRefs get "Imported LampCeiling194730 (1)"] call (_3846_856203951_4355523_61390 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3876_073244002_9711922_76247') then {
	[_3876_073244002_9711922_76247,'Key',1,100,[["var","name","Главный гостевой ключ"],["var","keyowner",["hotelmain"]]]] call (_3876_073244002_9711922_76247 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3830_803223972_3110427_13736') then {
	[_3830_803223972_3110427_13736,'SteelMedicalBox',2,100] call (_3830_803223972_3110427_13736 getvariable 'proto' getvariable 'createItemInContainer');
};
if (!isNil'_3847_112063954_6157222_32498') then {
	[_3847_112063954_6157222_32498,'PaperHolder',2,100] call (_3847_112063954_6157222_32498 getvariable 'proto' getvariable 'createItemInContainer');
	[_3847_112063954_6157222_32498,'PenBlack',1,100] call (_3847_112063954_6157222_32498 getvariable 'proto' getvariable 'createItemInContainer');
};
