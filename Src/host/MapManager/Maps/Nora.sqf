__metaInfo__ = 'Builded on editor version: 1.0';__metaInfoVersion__ = 2;go_editor_globalRefs = createHashMap;

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

['BlockDirt',[3671.63,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3671.63,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3661.63,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3661.63,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3684,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3694,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3659.11,3704.16,68.906,true],0,[-0.238405,0,0.971166]] call InitDecor; 
['BlockDirt',[3670,3704,69.2937],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3704,69.1827],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3684,66.9398,true],0,[0,-0.641463,0.767154]] call InitDecor; 
['BlockDirt',[3670,3694,69.7652],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3659.27,3693.95,68.0898,true],0,[-0.205425,0,0.978673]] call InitDecor; 
['BlockDirt',[3660,3684,66.7958,true],0,[0,-0.597499,0.80187]] call InitDecor; 
['BlockDirt',[3654.5,3682.5,60],310,[0,0,1]] call InitDecor; 
['BlockDirt',[3650,3694,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3650,3704,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3650,3704,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3650,3694,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3654.5,3682.5,50],310,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3694,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3694,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3704,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3684,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3704,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3684,67.0245,true],0,[0,-0.39694,0.917845]] call InitDecor; 
['BlockDirt',[3660,3684,40],0.000313335,[0,0,1]] call InitDecor; 
['Candle',[3662.43,3694.52,46.0089,true],random 360,[0.00769685,0.00352093,0.999964]] call InitItem; 
['WoodenDoor',[3676.42,3701,40.0842],64.6287,[0,0,1]] call InitStruct; 
['WoodenDoor',[3678.09,3705.56,40.1195],335.889,[0,0,1]] call InitStruct; 
_3664_389893700_5800839_81658 = ['Decor',[3664.39,3700.58,45.586,true],332.523,[0.0648456,0.0337209,0.997325], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_280033709_9099139_81360 = ['Decor',[3671.28,3709.91,45.586,true],249.44,[-0.0134707,0.0359136,0.999264], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3679_629883691_0500539_81034 = ['Decor',[3679.63,3691.05,45.586,true],247.835,[0.0268749,-0.065989,0.997458], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3667_169923708_0300339_81024 = ['Decor',[3667.17,3708.03,45.586,true],248.309,[0.0211169,-0.0530912,0.998366], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3675_520023689_1699239_81048 = ['Decor',[3675.52,3689.17,45.586,true],247.135,[0.0309921,-0.0734813,0.996815], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3673_330083710_8501039_81036 = ['Decor',[3673.33,3710.85,45.586,true],241.869,[0.0172776,-0.0323127,0.999328], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3675_370123711_7800339_81408 = ['Decor',[3675.37,3711.78,45.586,true],249.796,[-0.0154615,0.0420141,0.998997], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3665_120123707_0900939_81036 = ['Decor',[3665.12,3707.09,45.586,true],239.399,[0.0369053,-0.0624171,0.997368], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_050053689_7900439_81533 = ['Decor',[3669.05,3689.79,45.586,true],339.6,[0.0561179,0.0208709,0.998206], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3668_120123691_8300839_81029 = ['Decor',[3668.12,3691.83,45.586,true],332.922,[-0.0383364,-0.0196017,0.999073], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3659_570073696_9899939_81025 = ['Decor',[3659.57,3696.99,45.586,true],59.5798,[-0.0308871,0.0526033,0.998138], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_429933687_3000539_81102 = ['Decor',[3671.43,3687.3,45.586,true],240.18,[0.0048521,-0.00846444,0.999952], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3663_459963702_6201239_81024 = ['Decor',[3663.46,3702.62,45.586,true],332.867,[-0.0456606,-0.023396,0.998683], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3664_520023691_2900439_81766 = ['Decor',[3664.52,3691.29,45.586,true],70.4413,[0.0279741,-0.078759,0.996501], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3666_560063692_2199739_81517 = ['Decor',[3666.56,3692.22,45.586,true],60.41,[0.0286367,-0.0504328,0.998317], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3658_899903695_4499539_81024 = ['Decor',[3658.9,3695.45,45.586,true],150.302,[0.0485185,0.0276788,0.998439], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_989993687_7399939_81056 = ['Decor',[3669.99,3687.74,45.586,true],330.737,[-0.0730434,-0.0409286,0.996489], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3661_729983697_9799839_81174 = ['Decor',[3661.73,3697.98,45.586,true],71.4123,[-0.0372362,0.110723,0.993154], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3662_469973690_3501039_81885 = ['Decor',[3662.47,3690.35,45.586,true],69.0306,[0.0337135,-0.0879923,0.995551], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3660_879883691_1298839_81030 = ['Decor',[3660.88,3691.13,45.586,true],151.514,[0.058958,0.031991,0.997748], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3659_889893693_2900439_81737 = ['Decor',[3659.89,3693.29,45.586,true],160.104,[-0.0760269,-0.0275101,0.996726], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_580083690_1101139_81863 = ['Decor',[3677.58,3690.11,45.586,true],241.322,[-0.0443242,0.0810322,0.995725], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3662_520023704_6699239_81206 = ['Decor',[3662.52,3704.67,45.586,true],330.05,[0.0119906,0.00690633,0.999904], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3673_469973688_2299839_81308 = ['Decor',[3673.47,3688.23,45.586,true],247.354,[-0.0118756,0.028465,0.999524], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3663_080083706_1599139_81434 = ['Decor',[3663.08,3706.16,45.586,true],249.856,[-0.0165796,0.0451967,0.998841], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3663_780033698_9199239_81100 = ['Decor',[3663.78,3698.92,45.586,true],57.7831,[-0.052836,0.0838474,0.995077], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_229983708_9699739_81041 = ['Decor',[3669.23,3708.97,45.586,true],242.056,[0.0356144,-0.0671544,0.997107], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3678_159913698_7600139_91300 = ['Decor',[3678.16,3698.76,39.913],290.421,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\cover_base_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3675_879883703_7700239_91340 = ['Decor',[3675.88,3703.77,39.9134],20.4206,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\cover_base_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3676_889893708_1699240_95060 = ['OldWoodenBox',[3676.89,3708.17,40.9506],245.31,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
_3673_750003699_7700240_92640 = ['OldWoodenBox',[3673.75,3699.77,40.9264],155.332,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['CampfireBig',[3679.57,3702.41,39.8883],0,[0,0,1]] call InitStruct; 
_3677_320073707_3000540_11240 = ['Decor',[3677.32,3707.3,40.1124],67.127,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3674_629883700_1499040_07550 = ['Decor',[3674.63,3700.15,40.0755],336.057,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3663_209963686_9599639_72820 = ['Decor',[3663.21,3686.96,39.7282],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3655_669923707_1298840_22510 = ['Decor',[3655.67,3707.13,40.2251],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3674_860113700_2800344_59900 = ['Decor',[3674.86,3700.28,44.599],245.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_439943706_9599644_59900 = ['Decor',[3677.44,3706.96,44.599],335.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3662_979983694_6999540_34900 = ['Decor',[3662.98,3694.7,40.349],245.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\cemeteries\grave_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_540043693_9699740_07550 = ['Decor',[3671.54,3693.97,40.0755],152.087,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_11_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3665_850103701_1899440_14760 = ['Decor',[3665.85,3701.19,40.1476],327.187,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_580083692_9199240_08170 = ['Decor',[3669.58,3692.92,40.0817],150.366,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_08_damaged_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3668_479983702_6001040_09700 = ['Decor',[3668.48,3702.6,40.097],338.323,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\tombstone_08_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3663_030033694_7600139_97400 = ['Decor',[3663.03,3694.76,39.974],245.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\cemeteries\mausoleum_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3670_850103690_0700739_97400 = ['Decor',[3670.85,3690.07,45.1413,true],329.542,[-2.23329e-007,1.06142e-007,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3668_639893701_9499540_30750 = ['Decor',[3668.64,3701.95,45.4748,true],340.421,[-2.23329e-007,1.06142e-007,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3666_300053700_7399940_30750 = ['Decor',[3666.3,3700.74,40.3075],330.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_379883694_5500540_09340 = ['Decor',[3671.38,3694.55,40.0934],155.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3667_100103704_8798839_97400 = ['Decor',[3667.1,3704.88,39.974],165.36,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_270023693_4499540_09340 = ['Decor',[3669.27,3693.45,40.0934],150.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3664_790043703_8501039_97400 = ['Decor',[3664.79,3703.85,39.974],150.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3672_909913691_0700739_97400 = ['Decor',[3672.91,3691.07,39.974],338.776,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3668_639893701_9199239_97400 = ['Decor',[3668.64,3701.92,39.974],344.177,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_350103694_4499539_97400 = ['Decor',[3671.35,3694.45,39.974],336.365,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3666_120123700_6499039_97400 = ['Decor',[3666.12,3700.65,39.974],328.194,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_239993693_3701239_97400 = ['Decor',[3669.24,3693.37,39.974],331.429,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_909913705_9299340_03540 = ['Decor',[3677.91,3705.93,40.0354],335.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_damaged_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3676_000003700_8000540_02010 = ['Decor',[3676,3700.8,40.0201],245.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_damaged_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3655_139893695_2099639_84510 = ['Decor',[3655.14,3695.21,46.6095,true],262,[0,2.22767e-006,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3655_159913691_1398939_95650 = ['Decor',[3655.16,3691.14,46.7326,true],270,[0.052336,1.74159e-007,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3680,3733.99,39.2907,true],6.88918e-005,[-7.07747e-008,0.104528,0.994522]] call InitDecor; 
['BlockDirt',[3670,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3744,65.3817,true],0,[0,0.640568,0.767901]] call InitDecor; 
['BlockDirt',[3658.5,3730.5,48.3191,true],61.2551,[0,0.312136,0.950037]] call InitDecor; 
['BlockDirt',[3670,3724,70.2596],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3714,69.426],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3724,69.4825],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3714,69.7193,true],0,[-0.166839,0,0.985984]] call InitDecor; 
['BlockDirt',[3670,3744,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3651,3720,60],7.00007,[0,0,1]] call InitDecor; 
['BlockDirt',[3650.13,3712.13,59.875],3,[0,0,1]] call InitDecor; 
['BlockDirt',[3662.5,3735.5,60],290,[0,0,1]] call InitDecor; 
['BlockDirt',[3658.5,3730.5,60],60.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3724,69.4388],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3714,69.3026],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3734,69.2396],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3651,3720,50],7.00007,[0,0,1]] call InitDecor; 
['BlockDirt',[3650.13,3712.13,49.875],3,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3744,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3734,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3744,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3744,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3734,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3744,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3662.5,3735.5,50],290,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3679_459963713_6499039_81036 = ['Decor',[3679.46,3713.65,45.586,true],246.681,[0.0287939,-0.0667858,0.997352], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_419923712_7199739_81036 = ['Decor',[3677.42,3712.72,45.586,true],241.93,[0.0341848,-0.0640944,0.997358], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
['ConcretePanel',[3678.57,3740.27,39.172],0,[0,0,1]] call InitStruct; 
_3675_929933738_2800310_09110 = ['Decor',[3675.93,3738.28,10.0911],209.513,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3675_679933735_4799839_25478 = ['Decor',[3675.68,3735.48,44.0504,true],359.838,[-0.000147803,-0.0127058,0.999919], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3676_399903720_9399439_46990 = ['Decor',[3676.4,3720.94,39.4699],18.0001,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3657_540043723_7800340_09040 = ['Decor',[3657.54,3723.78,40.0904],46.0912,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3669_100103715_0400439_60700 = ['Decor',[3669.1,3715.04,39.607],63.0131,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3660_290043715_3999039_84080 = ['Decor',[3660.29,3715.4,39.8408],103.903,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3666_840093723_0100139_94880 = ['Decor',[3666.84,3723.01,39.9488],138.764,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3670_270023731_3798839_91190 = ['Decor',[3670.27,3731.38,39.9119],20.8315,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3671_770023735_4899939_97530 = ['Decor',[3671.77,3735.49,39.9753],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3670,3774,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3756,28.5547,true],0,[0,-0.173648,0.984808]] call InitDecor; 
['BlockDirt',[3670,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3679.79,3766.18,30.4116,true],356.955,[0.0348996,-0.173543,0.984208]] call InitDecor; 
['BlockDirt',[3670,3774,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3764,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3764,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3754,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3755.38,25.625],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3774,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3774,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3764,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3754,65.1084,true],0,[0,-0.557383,0.830256]] call InitDecor; 
['BlockDirt',[3670,3754,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3774,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3764,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3674.42,3765.49,60],318.534,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3774,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3754,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670.59,3753.79,49.9311,true],6.78269e-005,[0.117728,0,0.993046]] call InitDecor; 
['BlockDirt',[3680,3754,10],6.83019e-005,[0,0,1]] call InitDecor; 
['ConcretePanel',[3679.77,3756.62,34.2221,true],345.793,[-1.71829e-007,-0.173648,0.984808]] call InitStruct; 
['ConcretePanel',[3677.12,3755.44,33.996,true],9.13652,[-2.09548e-009,-0.173648,0.984808]] call InitStruct; 
['ConcretePanel',[3677.83,3761.58,35.1567,true],346.766,[0.00392705,-0.190362,0.981706]] call InitStruct; 
['ConcretePanel',[3676.99,3750.66,33.0643,true],5.07673,[-1.16415e-009,-0.173648,0.984808]] call InitStruct; 
['ConcretePanel',[3675.64,3771.92,41.7922,true],7.05668,[0.383877,-0.215873,0.897796]] call InitStruct; 
['ConcretePanel',[3676.93,3744.07,10.0402],352,[0,0,1]] call InitStruct; 
_3665_949953770_3000540_08260 = ['Decor',[3665.95,3770.3,40.0826],120.427,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3672_860113771_6599139_94390 = ['Decor',[3672.86,3771.66,39.9439],359.838,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3676_899903771_9299332_16033 = ['Decor',[3676.9,3771.93,37.0459,true],359.834,[0,-0.213968,0.976841], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3675_919923768_1101110_06470 = ['Decor',[3675.92,3768.11,10.0647],334.739,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_379883766_9299331_13230 = ['Decor',[3677.38,3766.93,36.1323,true],348.835,[-1.72528e-007,-0.173648,0.984808], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3676_169923744_6201220_26080 = ['Decor',[3676.17,3744.62,25.2608,true],266.778,[-0.00949548,-0.0238379,0.999671], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3680,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3784,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3804,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3669.94,3794,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3784,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3784,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3660,3794,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3671.03,3783.46,20],27.2186,[0,0,1]] call InitDecor; 
['BlockDirt',[3679.77,3792.57,20],334.816,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3794,39.9676],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['ConcretePanel',[3678.6,3779.72,40.018],0,[0,0,1]] call InitStruct; 
['ConcretePanel',[3678.6,3791.73,40.018],0,[0,0,1]] call InitStruct; 
_3679_620123785_3898940_01800 = ['Decor',[3679.62,3785.39,40.018],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3679_620123805_3898940_01800 = ['Decor',[3679.62,3805.39,40.018],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3679_629883797_3798840_01800 = ['Decor',[3679.63,3797.38,40.018],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3679_129883788_550057_29797 = ['Decor',[3679.13,3788.55,7.29797],56.7775,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3668_500003784_3300836_60040 = ['Decor',[3668.5,3784.33,36.6004],182.545,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3667_530033780_3601146_80160 = ['Decor',[3667.53,3780.36,46.8016],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_monolith.p3d'];}] call InitDecor; // !!! realocated model !!!
_3667_510013792_1101147_98080 = ['Decor',[3667.51,3792.11,47.9808],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3679_899903790_9199240_11030 = ['Decor',[3679.9,3790.92,40.1103],61.5623,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3667_139893797_5600640_08280 = ['Decor',[3667.14,3797.56,40.0828],61.5623,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3677_649903793_8601146_53987 = ['Decor',[3677.65,3793.86,61.4374,true],0.000257329,[0.0107165,0,0.999943], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_wallh.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3670.42,3824.54,60],8.15598,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3824,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3670,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3671.3,3834,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3834,64.7139,true],0,[-0.482543,0,0.875872]] call InitDecor; 
['BlockDirt',[3680,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3671.3,3834,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3670.42,3824.54,50],8.15598,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['ConcretePanel',[3679.72,3828.55,40.018],0,[0,0,1]] call InitStruct; 
_3679_629883817_3798840_01800 = ['Decor',[3679.63,3817.38,40.018],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3678_570073811_7399940_01800 = ['Decor',[3678.57,3811.74,40.018],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3678_629883823_7500040_00000 = ['Decor',[3678.63,3823.75,40],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3672.63,3843.48,50],23.9243,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3844,64.9808,true],4.88548,[-0.258291,0.300952,0.917994]] call InitDecor; 
['BlockDirt',[3672.63,3843.48,60],23.9243,[0,0,1]] call InitDecor; 
['BlockDirt',[3680,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['ConcretePanel',[3679.92,3841.49,40.018],22,[0,0,1]] call InitStruct; 
['BlockDirt',[3711.38,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3691.63,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3701.38,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3681.63,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3701.38,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3711.38,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3681.63,3678.5,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3691.63,3678.5,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3704,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3694,69.5725],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3694,69.616],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3704,70.4246],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3704,69.7624],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3684,66.0996,true],0,[0,-0.436975,0.899474]] call InitDecor; 
['BlockDirt',[3710,3684,66.3774,true],0,[0,-0.469426,0.882972]] call InitDecor; 
['BlockDirt',[3710,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3694,70.1868],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3684,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3684,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3684,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3684,66.1915,true],0,[0,-0.523153,0.852239]] call InitDecor; 
['BlockDirt',[3710,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3700_399903703_8200739_97400 = ['Decor',[3700.4,3703.82,39.974],329.559,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\kosti.p3d'];}] call InitDecor; // !!! realocated model !!!
_3699_780033703_6001039_97400 = ['Decor',[3699.78,3703.6,39.974],215.625,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\kosti.p3d'];}] call InitDecor; // !!! realocated model !!!
['Candle',[3686.49,3705.42,41.2554],0,[0,0,1]] call InitItem; 
['WoodenDoor',[3680.92,3699.35,40.1003],335.889,[0,0,1]] call InitStruct; 
_3697_439943701_3999039_97400 = ['Decor',[3697.44,3701.4,39.974],195.423,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3700_709963706_8798839_97400 = ['Decor',[3700.71,3706.88,39.974],200.423,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_919923704_5000039_97400 = ['Decor',[3694.92,3704.5,39.974],300.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3701_419923703_2199739_97400 = ['Decor',[3701.42,3703.22,39.974],270.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3698_050053699_4699739_81046 = ['Decor',[3698.05,3699.47,45.586,true],247.849,[0.0296314,-0.0727884,0.996907], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3704_179933702_2800339_81071 = ['Decor',[3704.18,3702.28,45.586,true],247.881,[0.0337311,-0.0829872,0.99598], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3681_679933691_9799839_81571 = ['Decor',[3681.68,3691.98,45.586,true],242.582,[-0.0294818,0.0568305,0.997948], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3702_139893701_3400939_81614 = ['Decor',[3702.14,3701.34,45.586,true],243.233,[-0.0309099,0.0612762,0.997642], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_770023693_8601139_82136 = ['Decor',[3685.77,3693.86,45.586,true],240.001,[-0.0572603,0.0991779,0.993421], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_820073694_8000539_81946 = ['Decor',[3687.82,3694.8,45.586,true],248.258,[-0.03683,0.0923525,0.995045], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3693_030033702_5100139_81557 = ['Decor',[3693.03,3702.51,45.586,true],164.048,[-0.0601541,-0.0171945,0.998041], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_860113695_7299839_81028 = ['Decor',[3689.86,3695.73,45.586,true],249.46,[0.0227745,-0.0608062,0.99789], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3683_719973692_9199239_81059 = ['Decor',[3683.72,3692.92,45.586,true],246.517,[0.00980868,-0.0226165,0.999696], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_489993710_3601139_81428 = ['Decor',[3689.49,3710.36,45.586,true],162.526,[-0.0451677,-0.0142094,0.998878], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3700_090093700_4099139_81418 = ['Decor',[3700.09,3700.41,45.586,true],241.68,[-0.0218343,0.0405166,0.99894], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3691_909913696_6699239_82178 = ['Decor',[3691.91,3696.67,45.586,true],239.003,[-0.0606235,0.100899,0.993048], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3692_179933704_5500539_81065 = ['Decor',[3692.18,3704.55,45.586,true],149.031,[0.0748747,0.0449326,0.99618], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3693_949953697_6001039_81987 = ['Decor',[3693.95,3697.6,45.586,true],247.434,[-0.0394344,0.0948945,0.994706], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_510013699_0700739_81103 = ['Decor',[3694.51,3699.07,45.586,true],160.922,[0.094421,0.0326582,0.994996], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3696_000003698_5400439_81034 = ['Decor',[3696,3698.54,45.586,true],242.272,[0.0331206,-0.063017,0.997463], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3683_050053701_0000039_97400 = ['Decor',[3683.05,3701,39.974],200.424,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\cover_base_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_760013706_0000039_97370 = ['Decor',[3680.76,3706,39.9737],110.421,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\cover_base_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3682_139893696_6499040_93490 = ['OldWoodenBox',[3682.14,3696.65,40.9349],245.31,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
_3681_770023697_5400440_03640 = ['Decor',[3681.77,3697.54,40.0364],67.127,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_600103705_3601140_85161 = ['Head',[3694.6,3705.36,45.843,true],298.331,[0.476269,0.878257,0.0428141]] call InitItem; 
_3685_120123704_5000042_73820 = ['Decor',[3685.12,3704.5,42.7382],244.909,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_810063705_1699242_62950 = ['Decor',[3684.81,3705.17,42.6295],244.909,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_959963704_8300842_92700 = ['Decor',[3684.96,3704.83,42.927],244.909,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_620123700_7099640_86054 = ['Decor',[3686.62,3700.71,45.8927,true],185.422,[-0.0472393,-0.49775,0.866033], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_010013704_8701235_93220 = ['Decor',[3685.01,3704.87,35.9322],64.9091,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\belltowers\belltower_01_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3697_560063694_1101139_70200 = ['Decor',[3697.56,3694.11,39.702],309.139,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3711_979983710_1001039_70461 = ['Decor',[3711.98,3710.1,44.5033,true],80.888,[-0.131338,0.0830623,0.987852], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_260013688_2199739_34520 = ['Decor',[3685.26,3688.22,39.3452],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3708_669923684_5300340_00500 = ['Decor',[3708.67,3684.53,40.005],80.3002,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_510013698_2900439_98330 = ['Decor',[3709.51,3698.29,39.9833],25.7339,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_020023686_1398938_95290 = ['Decor',[3694.02,3686.14,38.9529],116.154,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_969973706_9099139_97400 = ['Decor',[3689.97,3706.91,39.974],155.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\chapels\chapel_small_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_250003704_9899940_98950 = ['Decor',[3686.25,3704.99,40.9895],244.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_840093705_2399945_25950 = ['Decor',[3684.84,3705.24,45.2595],64.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_149903704_4899945_36820 = ['Decor',[3685.15,3704.49,45.3682],64.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_989993704_8601145_55700 = ['Decor',[3684.99,3704.86,45.557],64.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_979983705_5800840_95310 = ['Decor',[3685.98,3705.58,40.9531],244.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_120123705_2800341_13620 = ['Decor',[3686.12,3705.28,41.1362],244.413,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\totems\palmtotem_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3681_600103697_8601144_59900 = ['Decor',[3681.6,3697.86,44.599],155.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3690_629883707_4099142_92980 = ['Decor',[3690.63,3707.41,42.9298],245.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\cultural\ancientrelics\ancientstatue_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3681_129883698_8798840_01620 = ['Decor',[3681.13,3698.88,40.0162],155.421,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_damaged_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_449953703_8798844_00491 = ['Decor',[3685.45,3703.88,49.0139,true],63.8261,[0.11114,-0.267989,0.95699], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_02_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_500003705_8300843_99907 = ['Decor',[3684.5,3705.83,49.0091,true],64.8405,[-0.103936,0.252436,0.962015], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_02_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_239993705_3300836_93560 = ['Decor',[3686.24,3705.33,36.9356],335.852,[0,0,1], {_thisObj setvariable ['model','ml_shabut\arka\arka2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3681_239993683_5700739_86490 = ['Decor',[3681.24,3683.57,46.6376,true],177.999,[0,0.0348995,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3695_939943709_8300839_96680 = ['Decor',[3695.94,3709.83,39.9668],243.601,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\skameika.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_459963709_1599139_96680 = ['Decor',[3694.46,3709.16,39.9668],250.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\skameika.p3d'];}] call InitDecor; // !!! realocated model !!!
_3697_590093710_4499539_96680 = ['Decor',[3697.59,3710.45,39.9668],251.402,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\skameika.p3d'];}] call InitDecor; // !!! realocated model !!!
_3699_070073711_3999039_96680 = ['Decor',[3699.07,3711.4,39.9668],239.81,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\skameika.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_739993706_9499539_93800 = ['Decor',[3687.74,3706.95,39.938],63.7533,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_969973708_0200239_93820 = ['Decor',[3689.97,3708.02,39.9382],65.5212,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3688_840093707_3999039_93800 = ['Decor',[3688.84,3707.4,39.938],67.3346,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3700_310063707_5000040_46690 = ['Head',[3700.31,3707.5,45.6112,true],196.052,[0.0670224,0.0230308,0.997486], {_thisObj setvariable ['model','ml_shabut\exoduss\golova_trup3.p3d'];}] call InitItem; // !!! realocated model !!!
_3696_889893701_9899940_54321 = ['Decor',[3696.89,3701.99,45.7456,true],286.118,[-0.696037,0.201099,0.689269], {_thisObj setvariable ['model','ml_shabut\exoduss\trup_ruka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3703_600103690_5500539_89010 = ['Decor',[3703.6,3690.55,39.8901],22.325,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3690,3744,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3744,67.198,true],0,[0,0.240077,0.970754]] call InitDecor; 
['BlockDirt',[3690,3724,69.4714],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3744,66.1717,true],0,[0,0.593932,0.804516]] call InitDecor; 
['BlockDirt',[3710,3744,68.0269],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3724,69.7447],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3734,69.1943],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3724,69.4984],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3714,69.5796],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3714,69.2616],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3714,69.8878],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3689.64,3744,30],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3733.99,39.2907,true],6.88918e-005,[-7.07747e-008,0.104528,0.994522]] call InitDecor; 
['BlockDirt',[3700,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3714,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3724,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3709.63,3734.18,39.3104,true],359.122,[-0.0348562,0.0526321,0.998005]] call InitDecor; 
['BlockDirt',[3690,3733.99,39.2907,true],0.000315274,[-7.07747e-008,0.104528,0.994522]] call InitDecor; 
['BlockDirt',[3710,3744,39.5547,true],0,[-0.104528,0,0.994522]] call InitDecor; 
['BlockDirt',[3690,3734,69.6893],0,[0,0,1]] call InitDecor; 
_3706_469973721_7700240_02030 = ['Decor',[3706.47,3721.77,40.0203],109.381,[0,0,1], {_thisObj setvariable ['model','a3\data_f\particleeffects\craterlong\craterlong_small.p3d'];}] call InitDecor; // !!! realocated model !!!
_3695_669923714_8798839_97400 = ['Decor',[3695.67,3714.88,39.974],100.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_540043715_6499039_97400 = ['Decor',[3689.54,3715.65,39.974],295.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3691_699953712_9299339_97400 = ['Decor',[3691.7,3712.93,39.974],30.4205,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_719973718_1599139_97400 = ['Decor',[3694.72,3718.16,39.974],165.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3693_790043720_1999539_81070 = ['Decor',[3693.79,3720.2,45.586,true],250.433,[0.0299279,-0.084179,0.996001], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3685_600103716_4599639_81721 = ['Decor',[3685.6,3716.46,45.586,true],240.023,[-0.0396463,0.0687321,0.996847], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_969973713_7299839_81034 = ['Decor',[3687.97,3713.73,45.586,true],151.096,[0.0625643,0.0345472,0.997443], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_649903717_3999039_81024 = ['Decor',[3687.65,3717.4,45.586,true],249.852,[0.0193549,-0.0527794,0.998419], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3695_830083721_1398939_81823 = ['Decor',[3695.83,3721.14,45.586,true],240.842,[-0.0432539,0.0775262,0.996052], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_689943718_3300839_81642 = ['Decor',[3689.69,3718.33,45.586,true],241.97,[-0.0336047,0.0631215,0.99744], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_030033715_7399939_81431 = ['Decor',[3687.03,3715.74,45.586,true],160.341,[-0.0449044,-0.0160404,0.998863], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3683_560063715_5300339_81042 = ['Decor',[3683.56,3715.53,45.586,true],249.597,[0.0267005,-0.0717855,0.997063], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3691_739993719_2700239_81823 = ['Decor',[3691.74,3719.27,45.586,true],239.382,[-0.0452273,0.0764187,0.99605], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3681_510013714_5900939_81942 = ['Decor',[3681.51,3714.59,45.586,true],242.834,[-0.0452369,0.0881512,0.995079], {_thisObj setvariable ['model','metro_ob\model\fence01.p3d'];}] call InitDecor; // !!! realocated model !!!
['CampfireBig',[3702.94,3713.08,39.8571],0,[0,0,1]] call InitStruct; 
['ConcretePanel',[3680.23,3739.73,28.2521,true],345.864,[-1.71829e-007,0.141429,0.989948]] call InitStruct; 
_3682_350103727_2800337_04490 = ['Decor',[3682.35,3727.28,37.0449],92,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3692_540043728_0300336_54040 = ['Decor',[3692.54,3728.03,36.5404],261.001,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3703_010013728_9399440_08950 = ['Decor',[3703.01,3728.94,40.0895],252.431,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_260013739_1201239_38666 = ['Decor',[3710.26,3739.12,44.2685,true],186.176,[-0.131338,0.0830621,0.987852], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3708_310063729_7900439_88380 = ['Decor',[3708.31,3729.79,39.8838],269.227,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3697_179933735_2399939_74030 = ['Decor',[3697.18,3735.24,39.7403],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3688_320073738_2800339_20050 = ['Decor',[3688.32,3738.28,39.2005],77.8349,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3691_330083736_1899439_34270 = ['Decor',[3691.33,3736.19,39.3427],272.849,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3683_629883736_0100139_43710 = ['Decor',[3683.63,3736.01,39.4371],263.551,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3690_300053716_4099139_84900 = ['Decor',[3690.3,3716.41,39.849],205.423,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3682_739993741_6999510_08050 = ['Decor',[3682.74,3741.7,10.0805],32,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_649903739_5600639_17200 = ['Decor',[3680.65,3739.56,39.172],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3692_530033713_2500040_86500 = ['Decor',[3692.53,3713.25,40.865],245.421,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\noga.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_030033718_3999040_52400 = ['Decor',[3694.03,3718.4,40.524],189.115,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\golova_trup2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3696_489993714_0800840_47173 = ['Decor',[3696.49,3714.08,45.6964,true],20.6924,[-0.277984,-0.735937,0.61735], {_thisObj setvariable ['model','smg_trup\model\smg_trup_head.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_149903741_9899939_85100 = ['Decor',[3709.15,3741.99,39.851],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_149903725_9899940_02400 = ['Decor',[3709.15,3725.99,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3711_409913723_0400440_02300 = ['Decor',[3711.41,3723.04,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_149903734_0000039_85080 = ['Decor',[3709.15,3734,39.8508],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3707_260013741_9899939_85100 = ['Decor',[3707.26,3741.99,39.851],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3707_260013725_9899940_02400 = ['Decor',[3707.26,3725.99,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3690,3764.15,31.8182,true],0.000317115,[-2.07005e-007,-0.173648,0.984808]] call InitDecor; 
['BlockDirt',[3710,3774,39.5547,true],0,[-0.104528,0,0.994522]] call InitDecor; 
['BlockDirt',[3680.45,3775.36,32.4728,true],6.83019e-005,[-2.88393e-007,-0.241922,0.970296]] call InitDecor; 
['BlockDirt',[3700,3774,33.5547,true],6.83019e-005,[-2.07005e-007,-0.173648,0.984808]] call InitDecor; 
['BlockDirt',[3690.97,3753.44,32.4762,true],0.652052,[-0.207632,0.287099,0.935127]] call InitDecor; 
['BlockDirt',[3690,3774,33.5547,true],0.000317115,[-2.07005e-007,-0.173648,0.984808]] call InitDecor; 
['BlockDirt',[3690,3764,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3691,3753,26],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3754,65.8945,true],3.01786,[-0.357503,0.144394,0.922682]] call InitDecor; 
['BlockDirt',[3710,3774,68.7718],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3774,67.6727],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3754,63.7722,true],0,[0,0.276578,0.960991]] call InitDecor; 
['BlockDirt',[3690,3754,65.7777,true],0,[0,-0.447962,0.894053]] call InitDecor; 
['BlockDirt',[3700,3764,65.6982],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3774,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3764,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3764,67.0728],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3691,3763,26],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3754,39.5547,true],0,[-0.104528,0,0.994522]] call InitDecor; 
['BlockDirt',[3710,3764,39.5547,true],0,[-0.104528,0,0.994522]] call InitDecor; 
['BlockDirt',[3690.97,3744.33,34.992,true],1.18234,[-0.274733,0.120589,0.953929]] call InitDecor; 
['BlockDirt',[3700.29,3744.02,37.2614,true],358.388,[-0.000866538,0.296305,0.955093]] call InitDecor; 
['BlockDirt',[3700,3754.3,32.9853,true],7.1096e-005,[-1.74845e-007,0.309024,0.951054]] call InitDecor; 
['BlockDirt',[3700,3774,20],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3764.15,31.8182,true],6.83019e-005,[-2.07005e-007,-0.173648,0.984808]] call InitDecor; 
['BlockDirt',[3710,3774,20],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3691,3773,26],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3774,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3754,20],0.000313335,[0,0,1]] call InitDecor; 
_3707_850103765_8701240_17324 = ['Decor',[3707.85,3765.87,45.2422,true],0,[-0.162694,0,0.986677], {_thisObj setvariable ['model','a3\data_f\particleeffects\craterlong\craterlong.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_280033772_739999_26534 = ['Decor',[3684.28,3772.74,9.26534],359.649,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntrock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
['ConcretePanel',[3680.49,3772.42,37.2852,true],350.729,[0,-0.241922,0.970296]] call InitStruct; 
_3681_409913747_610116_60038 = ['Decor',[3681.41,3747.61,6.60038],92,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3711_709963754_9899940_03760 = ['Decor',[3711.71,3754.99,40.0376],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_320073751_5000039_85000 = ['Decor',[3710.32,3751.5,39.85],61.562,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_719973757_1999540_03600 = ['Decor',[3710.72,3757.2,40.036],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3703_010013762_4599631_61435 = ['Decor',[3703.01,3762.46,38.9105,true],0,[0,-0.052336,0.99863], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3702_000003748_3601133_95565 = ['Decor',[3702,3748.36,41.5303,true],0,[0,0.258819,0.965926], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3692_110113748_4899933_51791 = ['Decor',[3692.11,3748.49,40.5652,true],91.699,[-0.209115,0.184337,0.96036], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3698_590093752_9199232_23673 = ['Decor',[3698.59,3752.92,39.8172,true],1.02476e-005,[-0.052336,0.258464,0.964602], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3693_129883764_3798832_81115 = ['Decor',[3693.13,3764.38,40.5145,true],91.549,[-0.0780589,-0.189578,0.978758], {_thisObj setvariable ['model','ca\buildings2\houseblocks\houseblock_d\houseblock_d2_ruins.p3d'];}] call InitDecor; // !!! realocated model !!!
_3683_719973746_1201226_10510 = ['Decor',[3683.72,3746.12,31.1051,true],49.8312,[-0.157441,-0.0732355,0.984809], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_149903750_8200728_15060 = ['Decor',[3680.15,3750.82,33.1506,true],344.779,[-1.71596e-007,-0.173648,0.984808], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_540043765_5400430_86640 = ['Decor',[3680.54,3765.54,35.8664,true],15.2207,[-3.49246e-009,-0.173648,0.984808], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_409913745_2099612_16994 = ['Decor',[3680.41,3745.21,17.5642,true],[0,0.258819,0.965926],[0,-0.965926,0.258819], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\powergenerator_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_050053774_4699740_03560 = ['Decor',[3710.05,3774.47,40.0356],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3707_270023771_4699740_03240 = ['Decor',[3707.27,3771.47,40.0324],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3707_260013749_9799839_85100 = ['Decor',[3707.26,3749.98,39.851],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_139893755_9699739_85100 = ['Decor',[3709.14,3755.97,39.851],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_139893763_9599639_85100 = ['Decor',[3709.14,3763.96,39.851],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3707_260013757_9699739_85100 = ['Decor',[3707.26,3757.97,39.851],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3710_050053772_5800840_03520 = ['Decor',[3710.05,3772.58,40.0352],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_159913771_4699740_03240 = ['Decor',[3709.16,3771.47,40.0324],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3690,3794,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3784,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3688.15,3782.85,51.0577,true],7.44707e-005,[0,-0.398509,0.917164]] call InitDecor; 
['BlockDirt',[3710,3784,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3705.5,3779.95,67.9095],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3698.15,3782.85,51.0577,true],7.44707e-005,[0,-0.398509,0.917164]] call InitDecor; 
['BlockDirt',[3708.15,3782.85,51.0577,true],7.44707e-005,[0,-0.398509,0.917164]] call InitDecor; 
['BlockDirt',[3710,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3794,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3699.07,3781.99,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3689.07,3781.99,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3784,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3784,10],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3804,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3709.35,3782.01,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3694_189943780_7099610_21140 = ['Decor',[3694.19,3780.71,10.2114],255.876,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_000003794_0000041_37500 = ['Decor',[3694,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_929933787_7099610_10910 = ['Decor',[3709.93,3787.71,10.1091],242.333,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3703_250003781_8501038_08410 = ['Decor',[3703.25,3781.85,38.0841],94.6866,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_wallh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3705_010013807_6999548_07600 = ['Decor',[3705.01,3807.7,48.076],95.0793,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_wallh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3696_219973786_899909_92614 = ['Decor',[3696.22,3786.9,9.92614],156.688,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3688_540043807_2900441_01990 = ['Decor',[3688.54,3807.29,41.0199],350.081,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_090093791_7299840_12170 = ['Decor',[3689.09,3791.73,40.1217],312.25,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3680_679933791_0200240_01800 = ['Decor',[3680.68,3791.02,40.018],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_870123794_0400439_87640 = ['Decor',[3709.87,3794.04,39.8764],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3690,3824,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3834,67.7104],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3834,68.6237],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3824,68.1561],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3834,68.7184],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3824,69.0351],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690.43,3812.14,55.857,true],7.69744e-005,[0,-0.461129,0.887333]] call InitDecor; 
['BlockDirt',[3690,3824,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3812.14,55.857,true],7.69744e-005,[0,-0.461129,0.887333]] call InitDecor; 
['BlockDirt',[3710,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3834,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3812.14,55.857,true],7.69744e-005,[0,-0.461129,0.887333]] call InitDecor; 
['BlockDirt',[3710,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['LampCeiling',[3697.41,3839.67,45.0486],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling477178',_thisObj];
}] call InitStruct; 
_3698_699953834_0800840_69220 = ['Decor',[3698.7,3834.08,40.6922],359.658,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3708_429933834_0800840_76960 = ['Decor',[3708.43,3834.08,40.7696],359.658,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_330083839_1298840_81920 = ['Decor',[3687.33,3839.13,40.8192],89.6832,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3693_199953834_0200240_69680 = ['Decor',[3693.2,3834.02,40.6968],0.404068,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TorchHolderCharged',[3688.19,3821.56,39.618],2.75026,[0,0,1]] call InitStruct; 
_3689_030033838_7199742_38256 = ['RedButton',[3689.03,3838.72,47.3835,true],86.6344,[0.0586795,-0.997763,0.0320185], {go_editor_globalRefs set ['_arenaHallSwitcher',_thisObj];
}] call InitStruct; 
_3692_310063838_4799843_64290 = ['Decor',[3692.31,3838.48,43.6429],269.474,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
['ConcretePanel',[3680.65,3811.03,40.018],180,[0,0,1]] call InitStruct; 
['ConcretePanel',[3683.95,3820.58,40.018],270,[0,0,1]] call InitStruct; 
['ConcretePanel',[3693.78,3822.6,40.018],270,[0,0,1]] call InitStruct; 
['ConcretePanel',[3711.28,3828.23,40.018],180,[0,0,1]] call InitStruct; 
['ConcretePanel',[3681.72,3822.73,40.018],270,[0,0,1]] call InitStruct; 
['LampWall',[3689.6,3836.14,48.76,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall550646',_thisObj];
}] call InitStruct; 
['StripedChair',[3689.35,3837.41,43.9276],98.1078,[0,0,1]] call InitItem; 
['StripedChair',[3689.3,3836.1,43.9248],74.6694,[0,0,1]] call InitItem; 
_3681_040043834_5600640_01800 = ['Decor',[3681.04,3834.56,40.018],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3700_129883823_6298840_01800 = ['Decor',[3700.13,3823.63,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3708_260013823_6298840_01800 = ['Decor',[3708.26,3823.63,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3688_060063823_8400940_01800 = ['Decor',[3688.06,3823.84,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3688_530033838_6101144_39080 = ['Decor',[3688.53,3838.61,44.3908],176.651,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\zabori.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_129883828_6001040_05590 = ['Decor',[3689.13,3828.6,40.0559],49.7041,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_290043834_1799339_64390 = ['Decor',[3684.29,3834.18,39.6439],49.7041,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3698_179933829_9399439_93250 = ['Decor',[3698.18,3829.94,39.9325],9.77472,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_350103837_6999539_93650 = ['Decor',[3686.35,3837.7,39.9365],346.466,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3684_530033828_0700739_86680 = ['Decor',[3684.53,3828.07,39.8668],346.466,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3686_419923830_8798839_98620 = ['Decor',[3686.42,3830.88,39.9862],346.466,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3695_040043815_8501050_50930 = ['Decor',[3695.04,3815.85,50.5093],144.22,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_689943815_8999051_50530 = ['Decor',[3709.69,3815.9,51.5053],262.099,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3696_439943836_1298840_87500 = ['Decor',[3696.44,3836.13,40.875],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\surfacemine_01\sm_01_shed_unfinished_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3695_250003838_9499540_54030 = ['Decor',[3695.25,3838.95,40.5403],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\sportsgrounds\tribune_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_489993824_6799340_01800 = ['Decor',[3694.49,3824.68,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3682_169923824_9699740_01800 = ['Decor',[3682.17,3824.97,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_060063828_2399940_01800 = ['Decor',[3709.06,3828.24,40.018],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3682_090093828_2099640_01800 = ['Decor',[3682.09,3828.21,40.018],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3694_810063819_2700239_95803 = ['Decor',[3694.81,3819.27,46.738,true],177.945,[0.00183279,0.23657,0.971613], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3689_570073819_3300839_93876 = ['Decor',[3689.57,3819.33,46.7171,true],180.001,[0,0.235315,0.971919], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3709_629883819_4399439_92941 = ['Decor',[3709.63,3819.44,46.6914,true],180.001,[0,0.307106,0.951675], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3700_389893819_2500039_89946 = ['Decor',[3700.39,3819.25,46.6822,true],180.001,[0,0.19965,0.979867], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3690_469973836_9399443_92120 = ['Decor',[3690.47,3836.94,43.9212],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\tablesmall_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3700,3854,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3844,67.185],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3854,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3854,60],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3844,68.7889],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3844,67.3715,true],0,[0,0.149319,0.988789]] call InitDecor; 
['BlockDirt',[3680.31,3852.45,60],331.82,[0,0,1]] call InitDecor; 
['BlockDirt',[3680.31,3852.45,50],331.82,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3854,50],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3854,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3854,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3710,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3700,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3690,3844,40],0.000313335,[0,0,1]] call InitDecor; 
['LampCeiling',[3689.6,3843,45.8897],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling897557',_thisObj];
}] call InitStruct; 
_3708_620123845_1599140_70860 = ['Decor',[3708.62,3845.16,40.7086],179.617,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3701_439943845_2099640_67110 = ['Decor',[3701.44,3845.21,40.6711],179.617,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3690_199953845_1799340_84090 = ['Decor',[3690.2,3845.18,40.8409],180.892,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3687_379883843_0800840_84390 = ['Decor',[3687.38,3843.08,40.8439],91.1386,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3690_949953842_3501038_13800 = ['Decor',[3690.95,3842.35,38.138],180.722,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3697_250003844_7800342_40860 = ['Tumbler',[3697.25,3844.78,42.4086],87.6792,[0,0,1], {go_editor_globalRefs set ['_arenaSwitcher',_thisObj];
}] call InitStruct; 
['ConcretePanel',[3681.95,3844.79,40.018],97.8526,[0,0,1]] call InitStruct; 
_3686_189943848_3701239_70410 = ['Decor',[3686.19,3848.37,39.7041],49.7041,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3682_459963840_6599140_01800 = ['Decor',[3682.46,3840.66,40.018],14,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3740,3704,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3704,60],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3684,67.0488,true],0,[0,-0.223675,0.974664]] call InitDecor; 
['BlockDirt',[3720,3694,68.4877,true],0,[0.217973,0,0.975955]] call InitDecor; 
['BlockDirt',[3732.09,3702.75,59.8299],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.86,3702.1,63.9185,true],180,[0,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3720,3704,68.609,true],0,[0.225818,0,0.974169]] call InitDecor; 
['BlockDirt',[3729.32,3692.88,60],9.23708,[0,0,1]] call InitDecor; 
['BlockDirt',[3723.01,3682.13,60],59.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3723.01,3682.13,50],59.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.5,3685.36,50],200,[0,0,1]] call InitDecor; 
['BlockDirt',[3732.47,3694,50],249,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.86,3702.1,53.9185,true],180,[0,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3730,3704,50],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3732.09,3702.75,49.8299],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.97,3692.5,53.5547,true],180,[0,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3729.32,3692.88,50],9.23708,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3684,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.47,3703,40],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.47,3693,40],180,[0,0,1]] call InitDecor; 
_3740_090093704_0000044_25000 = ['Decor',[3740.09,3704,44.25],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_100103703_9099139_62400 = ['Decor',[3740.1,3703.91,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['ElectricalShield',[3736.34,3709.11,40.065],90.0001,[0,0,1], {go_editor_globalRefs set ['_transFarGates',_thisObj];
}] call InitStruct; 
_3743_219973709_4399439_62500 = ['Decor',[3743.22,3709.44,39.625],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['PowerSwitcherBig',[3743.83,3704.51,41.9785],179.942,[0,0,1]] call InitStruct; 
['Intercom',[3742.31,3699.85,40.4473],3.61144,[0,0,1]] call InitStruct; 
['Intercom',[3742.9,3706.2,41.263],180,[0,0,1]] call InitStruct; 
_3742_610113699_8400938_87230 = ['Decor',[3742.61,3699.84,38.8723],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_129883711_7700239_44110 = ['Decor',[3720.13,3711.77,39.4411],44.5249,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_219973705_5000039_73970 = ['Decor',[3715.22,3705.5,39.7397],239.138,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_020023694_5500540_02110 = ['Decor',[3714.02,3694.55,40.0211],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_739993691_0100139_39340 = ['Decor',[3724.74,3691.01,39.3934],345.175,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3725_379883696_9399439_50000 = ['Decor',[3725.38,3696.94,39.5],80.3002,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_719973706_3798840_50000 = ['Decor',[3743.72,3706.38,40.5],0.000451646,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardbox_01_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_969973706_6298840_12500 = ['Decor',[3739.97,3706.63,40.125],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\germodweri.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_969973701_1001040_12500 = ['Decor',[3739.97,3701.1,40.125],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\germodweri.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_780033705_3100639_84800 = ['Decor',[3724.78,3705.31,46.5956,true],88.0001,[0.0523007,0.001827,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_760013708_3501039_85136 = ['Decor',[3724.76,3708.35,46.5994,true],94.0083,[0.0523007,0.00182725,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3718_080083689_7099639_98930 = ['Decor',[3718.08,3689.71,39.9893],319.951,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_189943704_6001040_00210 = ['Decor',[3719.19,3704.6,40.0021],14.9329,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3718_949953700_4199239_72040 = ['Decor',[3718.95,3700.42,39.7204],348.867,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3730,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3744,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3724,70.3771],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3744,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3744,69.3509],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3714,68.0864,true],0,[0.212706,0,0.977116]] call InitDecor; 
['BlockDirt',[3740,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3734,69.7081],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3724,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3714,68.7154],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3724,69.4576],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3714,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3714,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3724,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3743_219973715_4299339_62500 = ['Decor',[3743.22,3715.43,39.625],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampKeroseneHolderCharged',[3725.7,3720.72,39.9555],264.442,[0,0,1]] call InitStruct; 
_3730_100103735_3000539_20960 = ['Decor',[3730.1,3735.3,44.4918,true],346.781,[-0.0122926,0.0977322,0.995137], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_340093731_4299339_31210 = ['Decor',[3734.34,3731.43,39.3121],163.862,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_530033726_3000539_25780 = ['Decor',[3729.53,3726.3,39.2578],83.686,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_709963741_2600140_06140 = ['Decor',[3734.71,3741.26,40.0614],37.6687,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_090093730_8898940_02030 = ['Decor',[3715.09,3730.89,40.0203],23.8239,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_030033723_8000540_11440 = ['Decor',[3715.03,3723.8,40.1144],72.7135,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3722_340093732_2399939_93620 = ['Decor',[3722.34,3732.24,39.9362],64.5707,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_argo\limestone\limestone_01_erosion_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3738_320073726_5900939_99600 = ['Decor',[3738.32,3726.59,39.996],87.0546,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_949953723_0200239_98900 = ['Decor',[3720.95,3723.02,39.989],245.68,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3716_310063716_8798839_51820 = ['Decor',[3716.31,3716.88,39.5182],348.722,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_239993724_7099640_11780 = ['Decor',[3732.24,3724.71,40.1178],321.147,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3722_290043742_0800840_91840 = ['Decor',[3722.29,3742.08,40.9184],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\big_box.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_149903716_4499539_92844 = ['Decor',[3735.15,3716.45,46.688,true],273.003,[-0.0174206,-0.00183251,0.999847], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_979983713_2700240_00925 = ['Decor',[3724.98,3713.27,46.7781,true],91.0001,[-0.0174524,1.75272e-007,0.999848], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_229983712_4899940_05276 = ['Decor',[3735.23,3712.49,46.8255,true],270,[0.0348996,0,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_459963719_0500539_98277 = ['Decor',[3729.46,3719.05,46.7588,true],177.997,[-1.75205e-007,0.052336,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3716_909913723_0400440_02400 = ['Decor',[3716.91,3723.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_929933720_0200240_02300 = ['Decor',[3740.93,3720.02,40.023],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3733_659913742_8200740_02400 = ['Decor',[3733.66,3742.82,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_909913723_0400440_02400 = ['Decor',[3740.91,3723.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_909913724_9399440_02400 = ['Decor',[3724.91,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3716_909913724_9299340_02400 = ['Decor',[3716.91,3724.93,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3731_770023734_8300840_02400 = ['Decor',[3731.77,3734.83,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_919923724_9399440_02400 = ['Decor',[3732.92,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_909913723_0400440_02400 = ['Decor',[3732.91,3723.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3733_659913734_8300840_02400 = ['Decor',[3733.66,3734.83,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_919923724_9299340_02400 = ['Decor',[3740.92,3724.93,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3731_770023726_8300840_02300 = ['Decor',[3731.77,3726.83,40.023],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_040043720_0200240_02300 = ['Decor',[3739.04,3720.02,40.023],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3720,3774,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3774,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3764,68.3107],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3774,69.4618],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.61,3774.03,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3764,70.4153],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3754,69.1085],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3774,69.5774],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3742.85,3752.78,30],336,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3764,69.4074],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3774,20],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3754,69.3301],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3774,69.3739],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3754,69.2247],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740.59,3763.95,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3774,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3720_350103744_2199740_58183 = ['Decor',[3720.35,3744.22,50.4448,true],90,[-0.0174524,4.92385e-009,0.999848], {_thisObj setvariable ['model','a3\structures_f_enoch\ruins\houseruin_big_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3721_830083763_4799840_20961 = ['Decor',[3721.83,3763.48,47.419,true],180,[-0.0174526,5.68671e-009,0.999848], {_thisObj setvariable ['model','ca\buildings2\houseblocks\houseblock_c\houseblock_c1_ruins.p3d'];}] call InitDecor; // !!! realocated model !!!
_3718_120123775_469977_52103 = ['Decor',[3718.12,3775.47,7.52103],56.7775,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3731_070073755_4399440_11520 = ['Decor',[3731.07,3755.44,40.1152],263.884,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_360113769_3999040_09810 = ['Decor',[3734.36,3769.4,40.0981],350.37,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_070073773_2800340_20210 = ['Decor',[3714.07,3773.28,40.2021],197.86,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_840093754_9899940_04970 = ['Decor',[3714.84,3754.99,40.0497],332.838,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_239993751_1599140_08130 = ['Decor',[3715.24,3751.16,40.0813],359.838,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3737_419923772_9599640_07900 = ['Decor',[3737.42,3772.96,40.079],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_469973749_1799339_80750 = ['Decor',[3734.47,3749.18,39.8075],180,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\concreteplat.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_239993744_2600151_34220 = ['Decor',[3714.24,3744.26,51.3422],15,[0,0,1], {_thisObj setvariable ['model','ml_shabut\fryaz\fryaz.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_949953770_1499040_02400 = ['Decor',[3735.95,3770.15,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_379883754_0200240_02300 = ['Decor',[3727.38,3754.02,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_949953754_1699240_02400 = ['Decor',[3735.95,3754.17,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_389893754_0200240_02400 = ['Decor',[3719.39,3754.02,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_949953762_1599140_02300 = ['Decor',[3735.95,3762.16,40.023],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_060063770_1499040_02400 = ['Decor',[3734.06,3770.15,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_060063754_1699240_02400 = ['Decor',[3734.06,3754.17,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_379883752_1298840_02300 = ['Decor',[3727.38,3752.13,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3738_080083749_3300840_02300 = ['Decor',[3738.08,3749.33,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_530033772_5800840_02300 = ['Decor',[3729.53,3772.58,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3738_080083747_4499540_02300 = ['Decor',[3738.08,3747.45,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3721_540043772_5800840_02300 = ['Decor',[3721.54,3772.58,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_530033774_4699740_02300 = ['Decor',[3729.53,3774.47,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3738_800053774_9399440_02300 = ['Decor',[3738.8,3774.94,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3718_050053772_5800840_02250 = ['Decor',[3718.05,3772.58,40.0225],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_300053752_1298840_01690 = ['Decor',[3732.3,3752.13,40.0169],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_310063754_0300340_01690 = ['Decor',[3732.31,3754.03,40.0169],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3718_300053788_4899936_99500 = ['Decor',[3718.3,3788.49,36.995],217.34,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_wallv.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3720,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3794,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3728.15,3782.85,51.0577,true],7.44707e-005,[0,-0.398509,0.917164]] call InitDecor; 
['BlockDirt',[3728.78,3790.72,49.8732],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3712.25,3794.56,30],30.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3719.28,3801.34,30],336,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3794,69.5772],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3784,10],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3784,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3718.15,3782.85,51.0577,true],7.44707e-005,[0,-0.398509,0.917164]] call InitDecor; 
['BlockDirt',[3720,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3784,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720.04,3777.05,30],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3784,69.3536],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3804,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3718.4,3800.81,53.3636],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3804,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3804,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3718.4,3790.81,53.3636],6.83019e-005,[0,0,1]] call InitDecor; 
_3730_760013789_6201220_20450 = ['Decor',[3730.76,3789.62,20.2045],255.876,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_000003794_0000041_37500 = ['Decor',[3730,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3712_000003794_0000041_37500 = ['Decor',[3712,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3717_080083801_9199217_86020 = ['Decor',[3717.08,3801.92,17.8602],203.912,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_169923796_8300843_00000 = ['Decor',[3743.17,3796.83,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_d_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_159913791_1201243_00000 = ['Decor',[3743.16,3791.12,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_d_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3742_909913799_9799839_78440 = ['Decor',[3742.91,3799.98,39.7844],1.75046,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3736_179933798_5900920_13500 = ['Decor',[3736.18,3798.59,20.135],114.818,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_439943782_9099140_13400 = ['Decor',[3735.44,3782.91,40.134],94.5113,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3741_879883803_7399939_91970 = ['Decor',[3741.88,3803.74,39.9197],197.86,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_330083780_2500039_71510 = ['Decor',[3743.33,3780.25,39.7151],260.253,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_689943804_8898939_92633 = ['Decor',[3735.69,3804.89,45.4421,true],332.826,[0.0067022,-0.0931851,0.995626], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_820073802_6699239_73970 = ['Decor',[3743.82,3802.67,39.7397],346.466,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_250003798_5600639_82860 = ['Decor',[3740.25,3798.56,39.8286],235.357,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3723_060063805_3701238_92320 = ['Decor',[3723.06,3805.37,38.9232],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3721_489993788_370128_74415 = ['Decor',[3721.49,3788.37,8.74415],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\fireescape_01_tall_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_060063778_1499040_02400 = ['Decor',[3734.06,3778.15,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3735_949953778_1499040_02400 = ['Decor',[3735.95,3778.15,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3733_219973781_5200240_02300 = ['Decor',[3733.22,3781.52,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3733_209963779_6201240_02300 = ['Decor',[3733.21,3779.62,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3740,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3834,67.9318],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3824,69.0357],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3834,67.3679],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3824,67.7014],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3812.14,55.857,true],7.69744e-005,[0,-0.461129,0.887333]] call InitDecor; 
['BlockDirt',[3740,3814,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3729.36,3812.14,55.857,true],7.69744e-005,[0,-0.461129,0.887333]] call InitDecor; 
['BlockDirt',[3730,3824,68.428],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3834,68.6002],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3814,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['SteelGridDoor',[3719.43,3835.73,39.7842],180,[0,0,1]] call InitStruct; 
_3719_550053835_6499039_77780 = ['Decor',[3719.55,3835.65,39.7778],87.6052,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['OldWoodenBox',[3720.23,3830.37,40.1744],9.76188,[0,0,1]] call InitStruct; 
['LampCeiling',[3728.87,3835.62,43.1081],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling981629',_thisObj];
}] call InitStruct; 
['LampCeiling',[3728.88,3829.97,43.0586],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling233442',_thisObj];
}] call InitStruct; 
_3718_070073831_7099639_61000 = ['Decor',[3718.07,3831.71,39.61],179.043,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_959963829_6499039_58220 = ['Decor',[3715.96,3829.65,39.5822],93.165,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_489993827_5200239_25600 = ['Decor',[3719.49,3827.52,39.256],2,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3712_639893836_1298840_74140 = ['Decor',[3712.64,3836.13,40.7414],271.438,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3712.3,3834.47,39.1675],312.102,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp928373',_thisObj];
}] call InitStruct; 
_3714_639893839_7199739_99050 = ['Decor',[3714.64,3839.72,39.9905],1.35971,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['Candle',[3734.1,3830.36,45.8316,true],0,[-0.0069996,-0.00102977,0.999975]] call InitItem; 
['Candle',[3742.51,3835.95,45.8878,true],106.605,[0.00101263,0.00700368,0.999975]] call InitItem; 
_3739_929933834_2199740_12500 = ['Decor',[3739.93,3834.22,40.125],90.4371,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SquareWoodenBox',[3727.37,3834.02,40.0849],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3718.2,3828.46,41.0436],0,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3717.14,3821.44,39.6279],0.930202,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3736.03,3819,39.612],53.9311,[0,0,1]] call InitStruct; 
['WoodenDoor',[3721.49,3829.3,40.0641],90.2679,[0,0,1]] call InitStruct; 
['WoodenDoor',[3726.51,3832.63,40.118],271,[0,0,1]] call InitStruct; 
_3735_370123831_0400440_12500 = ['Decor',[3735.37,3831.04,40.125],350.736,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_129883832_7399939_86760 = ['Decor',[3727.13,3832.74,39.8676],271,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\addons\metal_shed_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_489993828_2900440_16510 = ['Decor',[3720.49,3828.29,40.1651],1.54322,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
['GreenArmChair',[3742.32,3830.59,40.0516],99.4073,[0,0,1]] call InitStruct; 
_3728_030033836_6201240_84830 = ['Decor',[3728.03,3836.62,40.8483],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\press.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenChair',[3734.86,3830.51,40.071],87.9897,[0,0,1]] call InitItem; 
_3737_310063829_6899439_94640 = ['Decor',[3737.31,3829.69,39.9464],358.451,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_830083828_5800839_99980 = ['Decor',[3732.83,3828.58,39.9998],328.84,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3726_669923831_1398940_88220 = ['PowerSwitcher',[3726.67,3831.14,40.8822],89.5897,[0,0,1], {go_editor_globalRefs set ['_craftHouseSwitcher',_thisObj];
}] call InitStruct; 
['SmallChair',[3727.41,3828.4,40.0419],178.127,[0,0,1]] call InitItem; 
['SmallChair',[3727.44,3830.16,40.0791],351.795,[0,0,1]] call InitItem; 
['GreenBed',[3742.39,3833.3,40.0742],178.472,[0,0,1]] call InitStruct; 
['BoardWoodenBox',[3729.56,3828.38,40.043],273.34,[0,0,1]] call InitStruct; 
['ContainerGreen2',[3739.73,3830.72,40.1011],85.5048,[0,0,1]] call InitStruct; 
_3734_060063831_4899940_06330 = ['OldWoodenBox',[3734.06,3831.49,40.0633],350.599,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['CampfireBig',[3736.52,3837.87,39.8387],0,[0,0,1]] call InitStruct; 
['WoodenWeaponBox',[3721.55,3839.75,40.3692],85.924,[0,0,1]] call InitStruct; 
['ConcretePanel',[3734.13,3822.63,40.018],270,[0,0,1]] call InitStruct; 
['ConcretePanel',[3741.1,3836.16,40.0335],89.9958,[0,0,1]] call InitStruct; 
['ConcretePanel',[3713.91,3822.6,40.018],270,[0,0,1]] call InitStruct; 
['ConcretePanel',[3736.37,3831.89,40.0182],170.252,[0,0,1]] call InitStruct; 
['ConcretePanel',[3741.03,3830.28,40.0339],89.9958,[0,0,1]] call InitStruct; 
['StationSpeaker',[3712.91,3834.45,44.3145],270,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker871679',_thisObj];
}] call InitStruct; 
['LampWall',[3719.89,3839.53,48.611,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall978420',_thisObj];
}] call InitStruct; 
['SmallRedseatChair',[3741.55,3835.82,40.0969],264.519,[0,0,1]] call InitItem; 
_3721_520023827_9899939_36820 = ['Decor',[3721.52,3827.99,39.3682],90.9386,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3721_600103830_6999542_29725 = ['Decor',[3721.6,3830.7,45.8348,true],89.0614,[0,0.000802906,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_500003823_6298840_01830 = ['Decor',[3740.5,3823.63,40.0183],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_479983823_6398940_01800 = ['Decor',[3728.48,3823.64,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_419923823_6101140_01800 = ['Decor',[3720.42,3823.61,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3737_429933812_9799839_30260 = ['Decor',[3737.43,3812.98,39.3026],163.862,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_479983837_8400939_92880 = ['Decor',[3714.48,3837.84,39.9288],51.1766,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\cliff\cliff_stonecluster_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3743_600103819_6799339_62550 = ['Decor',[3743.6,3819.68,39.6255],49.7041,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3741_600103820_1599139_74450 = ['Decor',[3741.6,3820.16,39.7445],346.466,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_580083835_0800843_45231 = ['Decor',[3719.58,3835.08,48.4573,true],[0.0174348,-0.0523453,-0.998477],[0,-0.998629,0.0523533], {_thisObj setvariable ['model','ml\ml_object_new\model_05\kyznya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_270023814_9599650_84290 = ['Decor',[3728.27,3814.96,50.8429],111.513,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_250003829_7399940_12500 = ['Decor',[3719.25,3829.74,40.125],182,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\sheds\shed_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_540043832_7299840_11600 = ['Decor',[3730.54,3832.73,40.116],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\rabochiystol\bencheees.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_129883836_5500540_03080 = ['Decor',[3728.13,3836.55,40.0308],3.91643,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\workbench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3716_810063830_0800840_19030 = ['Decor',[3716.81,3830.08,40.1903],271.745,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\workbench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_189943836_6298840_98580 = ['Decor',[3727.19,3836.63,40.9858],353.967,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\napilnik.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_040043829_9799839_90970 = ['Decor',[3727.04,3829.98,39.9097],6.83019e-005,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_820073834_8999039_91550 = ['Decor',[3729.82,3834.9,39.9155],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_040043834_9099139_91560 = ['Decor',[3727.04,3834.91,39.9156],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_810063835_4399439_91370 = ['Decor',[3729.81,3835.44,39.9137],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_810063829_9699739_90980 = ['Decor',[3729.81,3829.97,39.9098],6.83019e-005,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_040043830_5100139_91400 = ['Decor',[3727.04,3830.51,39.914],0,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_040043835_4499539_91380 = ['Decor',[3727.04,3835.45,39.9138],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_810063830_5100139_91400 = ['Decor',[3729.81,3830.51,39.914],0,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_080083827_5100141_50970 = ['Decor',[3730.08,3827.51,46.5097,true],2.44607,[-0.99909,0.0426225,-0.00137275], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_850103837_8000542_64560 = ['Decor',[3728.85,3837.8,47.6456,true],2.27163,[0.037237,0.042631,-0.998397], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3726_570073831_9299341_47450 = ['Decor',[3726.57,3831.93,46.4745,true],90,[0,-1,1.19249e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3726_560063833_3701241_58640 = ['Decor',[3726.56,3833.37,46.5864,true],90,[0,1,-4.37114e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_199953831_3999042_21860 = ['Decor',[3720.2,3831.4,47.2186,true],180,[0,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3741_030033832_2600140_03350 = ['Decor',[3741.03,3832.26,40.0335],89.9958,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_870123824_6799340_01800 = ['Decor',[3734.87,3824.68,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3714_620123824_6799340_01800 = ['Decor',[3714.62,3824.68,40.018],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3741_060063834_2199740_03350 = ['Decor',[3741.06,3834.22,40.0335],89.9958,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_429933831_5000040_01820 = ['Decor',[3734.43,3831.5,40.0182],170.252,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3715_290043819_2800339_84590 = ['Decor',[3715.29,3819.28,46.6251,true],177.942,[0.00183279,0.241446,0.970413], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_639893819_6201239_97735 = ['Decor',[3720.64,3819.62,46.7125,true],180,[0,0.37872,0.925511], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3729_090093819_1398939_45979 = ['Decor',[3729.09,3819.14,46.2427,true],180.001,[0,0.197793,0.980244], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3736_580083831_9699740_04780 = ['Decor',[3736.58,3831.97,40.0478],171.375,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stalker_props\zhmikhkrovatz.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_290043830_3999040_06860 = ['Decor',[3734.29,3830.4,40.0686],81.328,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\table_drawer\table_drawer.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_360113829_2800340_04190 = ['Decor',[3727.36,3829.28,40.0419],180.217,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3742_350103835_9899940_10570 = ['Decor',[3742.35,3835.99,40.1057],273.652,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_260013836_1699240_08420 = ['Decor',[3730.26,3836.17,40.0842],35.8677,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\furniture\metal_wooden_rack_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3730_510013829_2800340_09840 = ['Decor',[3730.51,3829.28,40.0984],284.918,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\furniture\metal_wooden_rack_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3720_179933838_3701240_11500 = ['Decor',[3720.18,3838.37,40.115],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l08_market\l08_market_02_trader_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_010013838_7299840_02390 = ['Decor',[3739.01,3838.73,40.0239],122.425,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3721_449953832_9699740_00590 = ['Decor',[3721.45,3832.97,40.0059],95,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3734_040043836_1899440_01000 = ['Decor',[3734.04,3836.19,40.01],7.82673,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_129883836_4699740_00950 = ['Decor',[3724.13,3836.47,40.0095],6,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_239993831_9399439_99180 = ['Decor',[3724.24,3831.94,39.9918],1.00007,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3717_520023833_2099640_04550 = ['Decor',[3717.52,3833.21,40.0455],84,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3723_709963827_8898939_98970 = ['Decor',[3723.71,3827.89,39.9897],5,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_500003808_7900440_03210 = ['Decor',[3739.5,3808.79,40.0321],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3740_919923813_0300340_02400 = ['Decor',[3740.92,3813.03,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_500003816_7800340_03580 = ['Decor',[3739.5,3816.78,40.0358],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3730,3844,67.6511],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3854,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3854,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3844,67.6265],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3844,68.0726],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3854,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3740,3854,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3720,3854,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3730,3854,50],6.83019e-005,[0,0,1]] call InitDecor; 
['Anvil',[3719.35,3844.13,40.9706],29.9438,[0,0,1]] call InitStruct; 
_3713_479983843_0800839_98530 = ['ElectricalShield',[3713.48,3843.08,39.9853],90.0004,[0,0,1], {go_editor_globalRefs set ['_transMasters',_thisObj];
}] call InitStruct; 
_3726_340093840_5800839_37860 = ['Decor',[3726.34,3840.58,39.3786],353.874,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_360113844_0500539_51594 = ['Decor',[3719.36,3844.05,44.5,true],[0.0104684,-0.00507359,-0.999932],[0.899824,-0.436097,0.011633], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3712_709963840_7700240_77520 = ['Decor',[3712.71,3840.77,40.7752],269.537,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3712_370123847_1001039_99570 = ['Decor',[3712.37,3847.1,39.9957],84.8606,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_080083843_2199740_03450 = ['Decor',[3724.08,3843.22,40.0345],178.943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['Candle',[3737.28,3845.65,40.9041],200.062,[0,0,1]] call InitItem; 
['SquareWoodenBox',[3718.99,3840.82,40.3692],312.842,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3722.71,3845.58,39.8149],25.2969,[0,0,1]] call InitStruct; 
_3722_010013842_8300841_84546 = ['RedButton',[3722.01,3842.83,46.8464,true],176.816,[-0.997944,-0.055524,0.032027], {go_editor_globalRefs set ['_blacksmithSwitcher',_thisObj];
}] call InitStruct; 
_3717_030033840_8100640_35950 = ['Decor',[3717.03,3840.81,40.3595],85.2554,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlackSmallStove',[3721.9,3843.63,40.406],359.123,[0,0,1]] call InitStruct; 
['FabricBagBig2',[3719.68,3841.27,40.3692],223.894,[0,0,1]] call InitItem; 
['HospitalBed',[3735.37,3844.79,40.1193],6.50455,[0,0,1]] call InitStruct; 
['BoardWoodenBox',[3741.53,3844.98,40.0558],285.569,[0,0,1]] call InitStruct; 
['BoardWoodenBox',[3721.43,3841.28,40.3692],359.078,[0,0,1]] call InitStruct; 
['WaterBarrel',[3719.51,3842.9,40.3587],0,[0,0,1]] call InitStruct; 
['FabricBagBig1',[3719.68,3840.37,40.3692],303.434,[0,0,1]] call InitItem; 
['ConcretePanel',[3735.63,3844.27,40.0271],185.327,[0,0,1]] call InitStruct; 
['ConcretePanel',[3741.42,3843.71,40.0271],185.327,[0,0,1]] call InitStruct; 
_3726_379883840_5800840_01180 = ['SteelGridDoor',[3726.38,3840.58,40.0118],262.102,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
['Forge',[3717.79,3844.45,40.3405],359.242,[0,0,1]] call InitStruct; 
['ChairLibrary',[3737.55,3844.82,40.0533],88.2424,[0,0,1]] call InitItem; 
['BrownLeatherChair',[3738.7,3843.03,40.1193],9.74671,[0,0,1]] call InitStruct; 
_3726_830083847_1699249_67851 = ['Decor',[3726.83,3847.17,54.6784,true],269.192,[0,0.998118,0.0613307], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_129883842_1599139_37670 = ['Decor',[3739.13,3842.16,39.3767],7.83561,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_780033856_3200738_14720 = ['Decor',[3739.78,3856.32,38.1472],83.5276,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3727_719973847_9699740_18170 = ['Decor',[3727.72,3847.97,40.1817],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstones_erosion.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_550053840_0100140_25000 = ['Decor',[3719.55,3840.01,40.25],268,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\addons\i_garage_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3738_530033844_3701239_28830 = ['Decor',[3738.53,3844.37,39.2883],4.86724,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodusss\budkapsinaebana.p3d'];}] call InitDecor; // !!! realocated model !!!
_3736_919923842_4099139_61900 = ['Decor',[3736.92,3842.41,39.619],95.5612,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3742_780033843_6999539_31770 = ['Decor',[3742.78,3843.7,39.3177],10.055,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_370123845_1298840_40600 = ['Decor',[3719.37,3845.13,40.406],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3719_060063845_5400440_21350 = ['Decor',[3719.06,3845.54,40.2135],88.9106,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3739_489993843_8898940_02710 = ['Decor',[3739.49,3843.89,40.0271],185.327,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3737_560063844_0500540_02710 = ['Decor',[3737.56,3844.05,40.0271],185.327,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3737_770023845_4299340_05930 = ['Decor',[3737.77,3845.43,40.0593],6.11832,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officetable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3722_780033847_1899440_04280 = ['Decor',[3722.78,3847.19,40.0428],90.2216,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3724_439943840_6201240_02190 = ['Decor',[3724.44,3840.62,40.0219],16.3789,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_860113844_5400440_03620 = ['Decor',[3728.86,3844.54,40.0362],131.864,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3728_800053840_9499539_99630 = ['Decor',[3728.8,3840.95,39.9963],95,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3732_659913840_0100140_00150 = ['Decor',[3732.66,3840.01,40.0015],118.631,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3736_439943840_6398940_03500 = ['Decor',[3736.44,3840.64,40.035],38.9078,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3751.88,3678.63,49.875],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3752,3687.75,56],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.47,3703,60],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3760.54,3703.28,58.5615],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3752.13,3694.63,56.125],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3704,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3704,68.285],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3704,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.11,3703,50],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.34,3683.93,50],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3747.97,3699.25,49.875],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3749.59,3692.88,53.5547,true],360,[-7.17964e-007,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3751.92,3702.2,50],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3768.36,3702.5,50],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3694,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3704,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3684,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.47,3703,40],180,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.47,3693,40],180,[0,0,1]] call InitDecor; 
_3754_189943709_4299339_62400 = ['Decor',[3754.19,3709.43,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003707_2099641_88000 = ['Decor',[3760,3707.21,41.88],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\germozatvor_menu2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_040043709_4199240_90100 = ['Decor',[3749.04,3709.42,40.901],90.0001,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003710_0000041_37500 = ['Decor',[3760,3710,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_750003709_3701245_75910 = ['Decor',[3751.75,3709.37,45.7591],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003692_0000041_37500 = ['Decor',[3760,3692,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_070073693_5300341_88000 = ['Decor',[3760.07,3693.53,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_820073708_4699750_54870 = ['Decor',[3750.82,3708.47,50.5487],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_889893711_2399942_96800 = ['Decor',[3762.89,3711.24,42.968],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883709_4399443_00000 = ['Decor',[3757.13,3709.44,43],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_439943709_3999041_96710 = ['Decor',[3751.44,3709.4,41.9671],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardbox_01_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_629883710_6101140_13000 = ['Decor',[3751.63,3710.61,40.13],1.36604e-005,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_489993708_7600140_12900 = ['Decor',[3753.49,3708.76,40.129],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3760,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3734,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3724,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3744,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3714,69.1537],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3714,69.1669],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3724,69.5718],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3744,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3734,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3734,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3724,69.6388],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3714,68.7389],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3724,69.6096],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3759.81,3727.58,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3744,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3744,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3734,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3744,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3724,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3714,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3744,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3724,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3769.09,3734.52,30],18.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3734,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3751.11,3735.48,30],338,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3744,40],0.000313335,[0,0,1]] call InitDecor; 
_3754_189943715_4299339_62400 = ['Decor',[3754.19,3715.43,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3770_669923712_6899439_49390 = ['Decor',[3770.67,3712.69,39.4939],75,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
_3765_199953717_0800839_76320 = ['Decor',[3765.2,3717.08,39.7632],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TorchHolderCharged',[3762.2,3721.4,41.808,true],357.673,[-0.0176508,0.184767,0.982624]] call InitStruct; 
['TorchHolderCharged',[3757.82,3726.88,41.7968,true],186.871,[-0.0121153,-0.185207,0.982625]] call InitStruct; 
_3757_760013724_1599132_68100 = ['Decor',[3757.76,3724.16,32.681],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_260013724_1599132_68100 = ['Decor',[3762.26,3724.16,32.681],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3770_239993724_9899937_27230 = ['Decor',[3770.24,3724.99,37.2723],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_489993725_0000037_23970 = ['Decor',[3749.49,3725,37.2397],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_610113725_0000038_98970 = ['Decor',[3746.61,3725,38.9897],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_120123724_9899939_02230 = ['Decor',[3773.12,3724.99,39.0223],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003728_0000041_37500 = ['Decor',[3760,3728,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['StationSpeaker',[3751.8,3718.69,45.1118],179.449,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker746771',_thisObj];
}] call InitStruct; 
_3760_070073720_0500541_88000 = ['Decor',[3760.07,3720.05,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3764_520023742_2299836_56780 = ['Decor',[3764.52,3742.23,36.5678],195,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_919923733_8100640_13400 = ['Decor',[3753.92,3733.81,40.134],95.0833,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3756_219973713_3200740_87110 = ['Decor',[3756.22,3713.32,40.8711],90.0001,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_3x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_500003723_4899936_33180 = ['Decor',[3748.5,3723.49,36.3318],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_800053723_5000037_71278 = ['Decor',[3748.8,3723.5,42.8459,true],90,[0.515038,5.81144e-007,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_500003724_5000036_33260 = ['Decor',[3748.5,3724.5,36.3326],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_229983724_5000036_27230 = ['Decor',[3771.23,3724.5,36.2723],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_219973723_5000036_27300 = ['Decor',[3771.22,3723.5,36.273],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3770_929933723_5000037_74528 = ['Decor',[3770.93,3723.5,42.8784,true],270,[-0.515038,0,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_000003723_5000038_98820 = ['Decor',[3773,3723.5,44.1212,true],270,[-0.515038,0,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_250003723_5000036_27430 = ['Decor',[3773.25,3723.5,36.2743],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_469973723_4899936_33280 = ['Decor',[3746.47,3723.49,36.3328],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_699953723_5000039_71770 = ['Decor',[3775.7,3723.5,39.7177],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3744_040043723_5000039_68520 = ['Decor',[3744.04,3723.5,39.6852],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_250003724_5000036_27330 = ['Decor',[3773.25,3724.5,36.2733],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_479983724_5000036_33380 = ['Decor',[3746.48,3724.5,36.3338],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_739993723_5000038_95730 = ['Decor',[3746.74,3723.5,44.0903,true],90,[0.515038,0,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_030033718_0100140_00120 = ['Decor',[3749.03,3718.01,40.0012],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_6m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_479983718_0700740_12900 = ['Decor',[3754.48,3718.07,40.129],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_6m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883719_2199742_96800 = ['Decor',[3762.88,3719.22,42.968],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883727_2299843_00730 = ['Decor',[3757.13,3727.23,43.0073],90.0005,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883735_1999542_97930 = ['Decor',[3762.88,3735.2,42.9793],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883743_1799342_97930 = ['Decor',[3762.88,3743.18,42.9793],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883735_2199743_01070 = ['Decor',[3757.13,3735.22,43.0107],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883743_2099643_01070 = ['Decor',[3757.13,3743.21,43.0107],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883727_2099642_97930 = ['Decor',[3762.88,3727.21,42.9793],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883719_2700243_01000 = ['Decor',[3757.13,3719.27,43.01],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_659913734_7500041_79428 = ['Decor',[3760.66,3734.75,46.6178,true],0,[0.0760401,0,0.997105], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3764_429933739_6101120_10380 = ['Decor',[3764.43,3739.61,20.1038],195.872,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3763_030033732_1101140_31100 = ['Decor',[3763.03,3732.11,40.311],133.036,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_090093736_9699720_12190 = ['Decor',[3757.09,3736.97,20.1219],195.872,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3767_689943718_6599136_55450 = ['Decor',[3767.69,3718.66,36.5545],105.543,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_899903728_9299336_61720 = ['Decor',[3750.9,3728.93,36.6172],105.543,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_790043716_9699740_13000 = ['Decor',[3751.79,3716.97,40.13],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\civilian\accessories\busstop_02_shelter_ruins_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_629883739_6398940_35740 = ['Decor',[3749.63,3739.64,40.3574],270.182,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\big_box.p3d'];}] call InitDecor; // !!! realocated model !!!
_3761_489993734_8701220_09730 = ['Decor',[3761.49,3734.87,20.0973],45,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\demon2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_800053728_9299339_67848 = ['Decor',[3769.8,3728.93,46.4379,true],0.00023034,[-2.27825e-007,0.0174524,0.999848], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3764_189943723_0500536_52400 = ['Decor',[3764.19,3723.05,36.524],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_169923724_9499536_52400 = ['Decor',[3762.17,3724.95,36.524],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3758_169923724_9499536_52400 = ['Decor',[3758.17,3724.95,36.524],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_169923741_8300840_02400 = ['Decor',[3753.17,3741.83,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_060063741_8300840_02400 = ['Decor',[3755.06,3741.83,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_070073735_8200740_02400 = ['Decor',[3755.07,3735.82,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3744_139893738_3999040_10200 = ['Decor',[3744.14,3738.4,40.102],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\ruins\houseruin_big_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3760,3774,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3774,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3754,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3764,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3774,70.1874],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3774,69.3109],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3774,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3754,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3754,69.3126],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3764,68.8727],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3764,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3754,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3749.89,3745.05,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3754,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3754,20],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3754,70.405],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3754,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3774,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3774,69.7698],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3774,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3764,69.386],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3764,60],0,[0,0,1]] call InitDecor; 
_3763_679933752_4199219_29550 = ['Decor',[3763.68,3752.42,19.2955],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_139893772_4799831_46990 = ['Decor',[3773.14,3772.48,31.4699],91.3285,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenDoor',[3773.51,3775.3,31.7375],181.797,[0,0,1]] call InitStruct; 
_3760_000003746_0000041_37500 = ['Decor',[3760,3746,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003764_0000041_37500 = ['Decor',[3760,3764,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3766_290043772_6398931_23300 = ['Decor',[3766.29,3772.64,31.233],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampKeroseneHolderCharged',[3772.46,3772.77,31.9667],355.664,[0,0,1]] call InitStruct; 
_3744_719973762_2700240_40280 = ['Decor',[3744.72,3762.27,40.4028],270,[0,0,1], {_thisObj setvariable ['model','ca\buildings2\houseblocks\houseblock_b\houseblock_b6_ruins.p3d'];}] call InitDecor; // !!! realocated model !!!
_3759_199953759_7700219_74740 = ['Decor',[3759.2,3759.77,19.7474],20.739,[0,0,1], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3759_379883773_2700219_79940 = ['Decor',[3759.38,3773.27,19.7994],0,[0,0,1], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_239993756_2900419_68414 = ['Decor',[3757.24,3756.29,25.4618,true],43.9761,[0.168988,0.175139,0.969933], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_649903752_4099121_67972 = ['Decor',[3753.65,3752.41,27.2205,true],50.2527,[0.411706,0.342389,0.844552], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3759_270023770_4899919_91940 = ['Decor',[3759.27,3770.49,19.9194],359.638,[0,0,1], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_449953753_8200720_88805 = ['Decor',[3755.45,3753.82,26.4688,true],38.8198,[0.381103,0.213309,0.899589], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_870123766_9899920_10940 = ['Decor',[3760.87,3766.99,20.1094],350.555,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_989993763_6799320_10130 = ['Decor',[3760.99,3763.68,20.1013],6.95471,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\kolya.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallChair',[3775.06,3773.81,31.6631],180.177,[0,0,1]] call InitItem; 
['BoardWoodenBox',[3773.02,3770.1,31.681],0,[0,0,1]] call InitStruct; 
['CampfireBig',[3750.64,3765.56,19.8793],0,[0,0,1]] call InitStruct; 
_3760_070073745_2800341_88000 = ['Decor',[3760.07,3745.28,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_080083769_1398941_88000 = ['Decor',[3760.08,3769.14,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3765_149903756_5500536_42470 = ['Decor',[3765.15,3756.55,36.4247],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_909913747_7700217_94740 = ['Decor',[3750.91,3747.77,17.9474],139.64,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_899903748_4099140_13870 = ['Decor',[3752.9,3748.41,40.1387],4.67885,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_370123775_3100641_77330 = ['Decor',[3760.37,3775.31,46.7704,true],11.5351,[0.0823383,0,0.996604], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_870123751_1699242_97930 = ['Decor',[3762.87,3751.17,42.9793],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883767_1398942_97600 = ['Decor',[3762.88,3767.14,42.976],270.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883759_1699243_01070 = ['Decor',[3757.13,3759.17,43.0107],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883767_1599143_01070 = ['Decor',[3757.13,3767.16,43.0107],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883751_1899443_01070 = ['Decor',[3757.13,3751.19,43.0107],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_129883775_1298843_00000 = ['Decor',[3757.13,3775.13,43],90.0003,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_879883775_1298843_00000 = ['Decor',[3762.88,3775.13,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_870123759_1599142_97930 = ['Decor',[3762.87,3759.16,42.9793],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_159913773_4199240_12750 = ['Decor',[3762.16,3773.42,40.1275],162.799,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_979983767_6298820_12630 = ['Decor',[3769.98,3767.63,20.1263],128.731,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_520023759_3501042_00034 = ['Decor',[3760.52,3759.35,46.7995,true],9.88865,[0.024258,-0.000645273,0.999706], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_879883761_7299819_73810 = ['Decor',[3751.88,3761.73,19.7381],192.43,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_929933759_8601119_72580 = ['Decor',[3757.93,3759.86,19.7258],205.423,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_770023771_8000519_74370 = ['Decor',[3757.77,3771.8,19.7437],66.5834,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_830083770_4099119_70160 = ['Decor',[3752.83,3770.41,19.7016],270.194,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_280033770_7800320_00370 = ['Decor',[3757.28,3770.78,20.0037],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\commercial\market\clothshelter_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_879883762_1101120_01830 = ['Decor',[3749.88,3762.11,20.0183],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\commercial\market\clothshelter_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3756_020023760_5500519_96810 = ['Decor',[3756.02,3760.55,19.9681],18.617,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_979983769_5200220_05990 = ['Decor',[3750.98,3769.52,20.0599],328.135,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3756_659913765_3200720_00310 = ['Decor',[3756.66,3765.32,20.0031],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stalker_props\kosterchik.p3d'];}] call InitDecor; // !!! realocated model !!!
_3767_090093772_6101131_69710 = ['Decor',[3767.09,3772.61,31.6971],85,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\cargo\cargo20_brick_red_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_969973772_6101131_71600 = ['Decor',[3769.97,3772.61,31.716],89,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\cargo\cargo20_brick_red_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_790043773_9799831_04350 = ['Decor',[3771.79,3773.98,31.0435],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\zaprivka\zhelproxod.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_979983770_6298831_56900 = ['Decor',[3775.98,3770.63,31.569],180,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\postel_panelak1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_909913758_9399420_03840 = ['Decor',[3754.91,3758.94,20.0384],139.23,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\camping\sleeping_bag_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_879883761_7099620_00130 = ['Decor',[3749.88,3761.71,20.0013],252.841,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\camping\sleeping_bag_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_870123771_0200220_08570 = ['Decor',[3755.87,3771.02,20.0857],126.13,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\matras_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_169923769_7900419_97610 = ['Decor',[3750.17,3769.79,19.9761],221.134,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stalker_props\zhmikhkrovatz.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_050053774_5600631_70360 = ['Decor',[3775.05,3774.56,31.7036],180.177,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\table_drawer\table_drawer.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_800053774_9399440_02300 = ['Decor',[3746.8,3774.94,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_060063749_8200740_02780 = ['Decor',[3755.06,3749.82,40.0278],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_070073747_4499540_02400 = ['Decor',[3746.07,3747.45,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_070073749_3400940_02400 = ['Decor',[3746.07,3749.34,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_169923749_8200740_02400 = ['Decor',[3753.17,3749.82,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_169923765_8100640_02400 = ['Decor',[3753.17,3765.81,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_169923773_8999040_02400 = ['Decor',[3753.17,3773.9,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_060063765_8100640_02400 = ['Decor',[3755.06,3765.81,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_060063757_8200740_02400 = ['Decor',[3755.06,3757.82,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_060063747_4399440_02300 = ['Decor',[3752.06,3747.44,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_070073749_3501040_02300 = ['Decor',[3752.07,3749.35,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3760,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3784,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3804,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3784,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3784,68.4531],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3794,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3784,69.1608],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3794,68.8975],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3804,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3784,69.3092],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3784,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3804,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3804,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3784,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3794,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770.69,3784.17,20.6797],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3804,69.0155],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3804,69.5979],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3804,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3794,69.4009],0,[0,0,1]] call InitDecor; 
_3760_000003794_0000041_37500 = ['Decor',[3760,3794,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_169923798_9799820_03770 = ['Decor',[3771.17,3798.98,20.0377],255.876,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_899903776_8300840_12922 = ['Decor',[3754.9,3776.83,45.1982,true],327.072,[-0.136549,-0.0884232,0.986679], {_thisObj setvariable ['model','a3\data_f\particleeffects\craterlong\craterlong.p3d'];}] call InitDecor; // !!! realocated model !!!
_3751_530033799_9899941_82573 = ['Decor',[3751.53,3799.99,46.958,true],240.386,[-0.0299023,-0.0206019,0.999341], {_thisObj setvariable ['model','a3\data_f\particleeffects\craterlong\craterlong.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3775.32,3777.33,30.4085],86.6117,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp543797',_thisObj];
}] call InitStruct; 
_3772_050053787_4699720_63560 = ['Decor',[3772.05,3787.47,20.6356],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_000003794_0000041_37500 = ['Decor',[3748,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003806_0000041_37500 = ['Decor',[3760,3806,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003782_0000041_37500 = ['Decor',[3760,3782,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3772_000003794_0000041_37500 = ['Decor',[3772,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3756_330083777_9399421_17226 = ['Decor',[3756.33,3777.94,26.8762,true],312.445,[0.242616,-0.221891,0.944406], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3758_040043776_4099120_26777 = ['Decor',[3758.04,3776.41,25.8984,true],312.445,[0.242616,-0.221891,0.944406], {_thisObj setvariable ['model','smg_metro_building\drugoe\smg_barrikada1.p3d'];}] call InitDecor; // !!! realocated model !!!
['PowerSwitcherBig',[3775.36,3780.73,32.9109],270,[0,0,1]] call InitStruct; 
['LampWall',[3771.65,3777.05,33.9512],359.004,[0,0,1], {go_editor_globalRefs set ['Imported LampWall220542',_thisObj];
}] call InitStruct; 
_3766_020023788_0000041_37300 = ['Decor',[3766.02,3788,41.373],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3765_959963799_9899941_37400 = ['Decor',[3765.96,3799.99,41.374],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_030033788_0200241_37300 = ['Decor',[3754.03,3788.02,41.373],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_020023800_0000041_37300 = ['Decor',[3754.02,3800,41.373],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_070073794_3501041_87800 = ['Decor',[3760.07,3794.35,41.878],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3772_709963794_1298841_88000 = ['Decor',[3772.71,3794.13,41.88],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3747_510013794_1298841_88000 = ['Decor',[3747.51,3794.13,41.88],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_520023783_3501017_77530 = ['Decor',[3749.52,3783.35,17.7753],139.64,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3758_250003790_8601137_92510 = ['Decor',[3758.25,3790.86,37.9251],231.788,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_750003795_2199741_46832 = ['Decor',[3769.75,3795.22,46.8141,true],155.183,[0.0241707,0.00369112,0.999701], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3765_459963781_4899919_78484 = ['Decor',[3765.46,3781.49,25.1012,true],187.542,[-0.154392,0.0217297,0.987771], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_689943782_4699741_91260 = ['Decor',[3750.69,3782.47,41.9126],105.493,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_929933780_9399442_06010 = ['Decor',[3760.93,3780.94,42.0601],22.4746,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3774_820073804_8300843_00000 = ['Decor',[3774.82,3804.83,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3745_159913787_1298843_00000 = ['Decor',[3745.16,3787.13,43],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3774_889893787_1001043_00000 = ['Decor',[3774.89,3787.1,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3745_159913800_8501043_00000 = ['Decor',[3745.16,3800.85,43],90.0003,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_129883779_1499043_00000 = ['Decor',[3753.13,3779.15,43],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3747_129883779_1298843_00000 = ['Decor',[3747.13,3779.13,43],0.000122943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3774_879883781_1201243_00000 = ['Decor',[3774.88,3781.12,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3774_810063798_8400943_00000 = ['Decor',[3774.81,3798.84,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3745_169923806_8300843_00000 = ['Decor',[3745.17,3806.83,43],90.0002,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3772_879883779_1201243_00000 = ['Decor',[3772.88,3779.12,43],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3745_149903781_1398943_00000 = ['Decor',[3745.15,3781.14,43],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_090093784_4799841_96610 = ['Decor',[3771.09,3784.48,41.9661],167.944,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharpstones_erosion.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_620123790_8701241_88000 = ['Decor',[3746.62,3790.87,41.88],109.395,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_949953804_2399941_87014 = ['Decor',[3769.95,3804.24,46.6693,true],319.042,[0.015812,0.0183978,0.999706], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3764_560063801_0500541_87014 = ['Decor',[3764.56,3801.05,46.6693,true],19.266,[0.0238213,-0.00458902,0.999706], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3755_780033804_6499020_13390 = ['Decor',[3755.78,3804.65,20.1339],316.383,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3765_899903787_3000520_32926 = ['Decor',[3765.9,3787.3,25.0852,true],351.564,[-0.0717238,0,0.997425], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3767_330083785_7700241_97960 = ['Decor',[3767.33,3785.77,41.9796],29.4984,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_320073803_6799341_78670 = ['Decor',[3753.32,3803.68,41.7867],22.9442,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3750_689943790_6201241_99780 = ['Decor',[3750.69,3790.62,41.9978],242.638,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3774_939943778_5800831_60870 = ['Decor',[3774.94,3778.58,31.6087],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_800053776_8300840_02300 = ['Decor',[3746.8,3776.83,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_800053776_8400940_02300 = ['Decor',[3752.8,3776.84,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_02_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3750,3824,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3834,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3814,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3814,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3814,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3824,69.2436],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3824,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3834,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3824,69.0186],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3834,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3834,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3814,69.217],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3824,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3824,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3751.76,3833.81,30],26.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3814,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760.2,3823.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3834,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3821.94,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3814,69.649],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3768.65,3831.89,30],344,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3834,69.6479],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3814,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3814,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3811.94,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3834,40],0.000313335,[0,0,1]] call InitDecor; 
_3755_729983815_6298820_14160 = ['Decor',[3755.73,3815.63,20.1416],210.936,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3744_979983829_8501040_01750 = ['Decor',[3744.98,3829.85,40.0175],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TorchHolderCharged',[3757.67,3811.12,41.65,true],6.11703,[0,0.170446,0.985367]] call InitStruct; 
['TorchHolderCharged',[3762.24,3816.71,41.698,true],187.94,[0,-0.246965,0.969024]] call InitStruct; 
_3757_739993813_8898932_68100 = ['Decor',[3757.74,3813.89,32.681],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_239993813_8898932_68100 = ['Decor',[3762.24,3813.89,32.681],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3770_489993814_9899937_30640 = ['Decor',[3770.49,3814.99,37.3064],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_750003815_0000038_96190 = ['Decor',[3746.75,3815,38.9619],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_620123815_0000037_21190 = ['Decor',[3749.62,3815,37.2119],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_370123814_9899939_05640 = ['Decor',[3773.37,3814.99,39.0564],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003824_0000041_37500 = ['Decor',[3760,3824,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_100103827_8300839_62500 = ['Decor',[3754.1,3827.83,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_070073819_5100141_88000 = ['Decor',[3760.07,3819.51,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3759_870123832_6001017_12620 = ['Decor',[3759.87,3832.6,17.1262],139.64,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3763_949953833_2399936_45960 = ['Decor',[3763.95,3833.24,36.4596],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_860113837_7600136_96830 = ['Decor',[3754.86,3837.76,36.9683],180,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3759_800053823_9699742_00040 = ['Decor',[3759.8,3823.97,42.0004],171.988,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_639893814_5000036_30290 = ['Decor',[3748.64,3814.5,36.3029],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_639893813_4899936_30220 = ['Decor',[3748.64,3813.49,36.3022],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_479983814_5000036_30640 = ['Decor',[3771.48,3814.5,36.3064],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_469973813_5000036_30720 = ['Decor',[3771.47,3813.5,36.3072],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_179933813_5000037_77938 = ['Decor',[3771.18,3813.5,42.9125,true],270,[-0.515038,0,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3748_939943813_5000037_68488 = ['Decor',[3748.94,3813.5,42.818,true],90,[0.515038,5.81144e-007,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_610113813_4899936_30320 = ['Decor',[3746.61,3813.49,36.3032],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_949953813_5000039_75180 = ['Decor',[3775.95,3813.5,39.7518],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_250003813_5000039_02230 = ['Decor',[3773.25,3813.5,44.1553,true],270,[-0.515038,0,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_610113814_5000036_30420 = ['Decor',[3746.61,3814.5,36.3042],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3746_870123813_5000038_93010 = ['Decor',[3746.87,3813.5,44.0631,true],90,[0.515038,5.81144e-007,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_500003813_5000036_30840 = ['Decor',[3773.5,3813.5,36.3084],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3773_500003814_5000036_30740 = ['Decor',[3773.5,3814.5,36.3074],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3744_169923813_5000039_65730 = ['Decor',[3744.17,3813.5,39.6573],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3766_860113808_8501043_00000 = ['Decor',[3766.86,3808.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_169923808_8000543_00000 = ['Decor',[3753.17,3808.8,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103836_7800343_00120 = ['Decor',[3762.85,3836.78,43.0012],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_169923836_7600142_99940 = ['Decor',[3757.17,3836.76,42.9994],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3753_120123818_9799841_31670 = ['Decor',[3753.12,3818.98,41.3167],0.000157948,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103820_8100643_00120 = ['Decor',[3762.85,3820.81,43.0012],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103812_8400943_00000 = ['Decor',[3762.85,3812.84,43],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103828_8000543_00120 = ['Decor',[3762.85,3828.8,43.0012],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_159913812_8100643_00000 = ['Decor',[3757.16,3812.81,43],90.0002,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3747_169923808_8100643_00000 = ['Decor',[3747.17,3808.81,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3772_840093808_8400943_00000 = ['Decor',[3772.84,3808.84,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_169923818_7800342_99600 = ['Decor',[3757.17,3818.78,42.996],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3747_149903818_9699741_31700 = ['Decor',[3747.15,3818.97,41.317],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_159913830_7800343_00000 = ['Decor',[3757.16,3830.78,43],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_350103816_2099641_88508 = ['Decor',[3760.35,3816.21,46.7086,true],0,[0.0760401,0,0.997105], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003831_8501042_04270 = ['Decor',[3760,3831.85,42.0427],5.21058,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3766_100103809_1298836_55150 = ['Decor',[3766.1,3809.13,36.5515],162.799,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3754_229983819_0200236_61730 = ['Decor',[3754.23,3819.02,36.6173],36.4043,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3764_510013819_1799320_12770 = ['Decor',[3764.51,3819.18,20.1277],187.333,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_409913825_6499019_88780 = ['Decor',[3757.41,3825.65,19.8878],205.423,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\dead\humanskeleton_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3775_750003823_1298840_62400 = ['Decor',[3775.75,3823.13,40.624],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_639893818_8400939_65266 = ['Decor',[3769.64,3818.84,46.4254,true],0.000230445,[-2.27825e-007,-0.0348996,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3752_870123822_4299340_02580 = ['Decor',[3752.87,3822.43,40.0258],44.4115,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\industrial\heavyequipment\bulldozer_01_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3749_000003826_1999540_11380 = ['Decor',[3749,3826.2,40.1138],181.381,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\wrecks\trailercistern_wreck_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3758_449953813_0400436_52400 = ['Decor',[3758.45,3813.04,36.524],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3758_449953814_9499536_52400 = ['Decor',[3758.45,3814.95,36.524],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_459963814_9499536_52400 = ['Decor',[3762.46,3814.95,36.524],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TorchHolderCharged',[3745.53,3839.92,45.7294,true],265.086,[-0.705692,0,0.708518]] call InitStruct; 
['BlockDirt',[3760,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3854,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3864,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3844,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3864,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3854,69.0346],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3844,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3844,69.1562],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3759.76,3863.11,58.5745],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3854,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3844,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3768,3872,56],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3770.38,3864,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3854,69.2578],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3854,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3864,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3844,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3750.11,3859.81,50],121.921,[0,0,1]] call InitDecor; 
['BlockDirt',[3768.34,3863.26,50.0134],184.61,[0,0,1]] call InitDecor; 
['BlockDirt',[3761.7,3840.71,30],11,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3864,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3772.5,3867.75,49.875],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3750,3844,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3864,40],6.83019e-005,[0,0,1]] call InitDecor; 
['StreetLamp',[3775.95,3840.95,37.1035],62.4232,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp402738',_thisObj];
}] call InitStruct; 
['StreetLamp',[3774.33,3849.88,38.849],15.6687,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp874730',_thisObj];
}] call InitStruct; 
_3760_000003860_0100141_90900 = ['Decor',[3760,3860.01,41.909],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\germozatvor_menu2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3770_949953857_0300340_90000 = ['Decor',[3770.95,3857.03,40.9],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003860_0000041_37500 = ['Decor',[3760,3860,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3768_500003854_6201245_75810 = ['Decor',[3768.5,3854.62,45.7581],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_000003842_0000041_37500 = ['Decor',[3760,3842,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3771_189943854_2299839_62300 = ['Decor',[3771.19,3854.23,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_070073847_1899441_88000 = ['Decor',[3760.07,3847.19,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3763_629883854_1298840_87370 = ['Decor',[3763.63,3854.13,40.8737],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_3x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103859_5800843_01750 = ['Decor',[3762.85,3859.58,43.0175],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_pole_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_159913852_7299842_99940 = ['Decor',[3757.16,3852.73,42.9994],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103844_7700243_00120 = ['Decor',[3762.85,3844.77,43.0012],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_169923844_7500042_99940 = ['Decor',[3757.17,3844.75,42.9994],90.0004,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3757_159913857_3701243_00000 = ['Decor',[3757.16,3857.37,43],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3762_850103857_5900942_99800 = ['Decor',[3762.85,3857.59,42.998],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_409913853_7700241_97160 = ['Decor',[3760.41,3853.77,41.9716],359.606,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3768_810063857_1398941_96610 = ['Decor',[3768.81,3857.14,41.9661],90.0003,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardbox_01_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3769_870123851_1298840_12800 = ['Decor',[3769.87,3851.13,40.128],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\civilian\accessories\busstop_02_shelter_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3766_760013857_7800340_12800 = ['Decor',[3766.76,3857.78,40.128],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3768_620123855_9299340_12900 = ['Decor',[3768.62,3855.93,40.129],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3767.91,3888.88,50.0105],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3874,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770.88,3874.13,53.5547,true],180,[-2.10401e-013,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3768,3882,56],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3760,3884,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770,3874,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3770.13,3883.08,50],6.83019e-005,[0,0,1]] call InitDecor; 
_3760_000003878_0000041_37500 = ['Decor',[3760,3878,41.375],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3760_070073873_0100141_88000 = ['Decor',[3760.07,3873.01,41.88],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3797.46,3704.68,60],349.123,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.2,3703.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.2,3703.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3806.93,3708.2,50],336.853,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3704,60],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3704,50],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3806.93,3708.2,60],336.853,[0,0,1]] call InitDecor; 
['BlockDirt',[3797.46,3704.68,50],349.123,[0,0,1]] call InitDecor; 
_3799_830083709_7600137_80150 = ['Decor',[3799.83,3709.76,37.8015],240,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_939943706_8400937_73300 = ['Decor',[3784.94,3706.84,37.733],92,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3780,3734,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3744,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3744,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3734,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3724,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3724,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3744,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3734,69.3803],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3734,69.1877],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3744,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3724,68.718],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3714,68.9993],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3744,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3724,68.671],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3734,30],277.56,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3744,69.4016],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3789.36,3715.97,30],29.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3744,69.5483],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3724,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3734,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3724,68.2863],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3781.19,3724.8,30],342,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3714,68.3358],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3734,68.9354],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3714,68.8487],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3724,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800.2,3713.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3734,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3714,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3714,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3744,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800.2,3723.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3734,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3744,30],6.83019e-005,[0,0,1]] call InitDecor; 
_3798_860113735_3400940_11370 = ['Decor',[3798.86,3735.34,40.1137],181.477,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_139893733_4899940_11840 = ['Decor',[3797.14,3733.49,40.1184],89.8245,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_949953742_3200740_08050 = ['Decor',[3788.95,3742.32,40.0805],89.8245,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampCeiling',[3789.83,3743.05,43.4972],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling204278',_thisObj];
}] call InitStruct; 
['LampCeiling',[3789.86,3736.53,43.4016],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling645971',_thisObj];
}] call InitStruct; 
['LampCeiling',[3795.18,3740.39,43.8293],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling870028',_thisObj];
}] call InitStruct; 
['LampCeiling',[3795.89,3734.74,43.8125],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling769699',_thisObj];
}] call InitStruct; 
_3793_469973741_6899440_03350 = ['Decor',[3793.47,3741.69,40.0335],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_540043741_5900940_07000 = ['Decor',[3791.54,3741.59,40.07],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_580083741_6999540_90590 = ['Decor',[3792.58,3741.7,40.9059],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_669923741_5500540_06920 = ['Decor',[3790.67,3741.55,40.0692],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_010013741_6298840_93880 = ['Decor',[3793.01,3741.63,40.9388],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_870123741_6001041_76140 = ['Decor',[3792.87,3741.6,41.7614],1.62889,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_620123741_7299839_93090 = ['Decor',[3792.62,3741.73,39.9309],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\covers_concreteblock_010.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_560063736_5300339_65840 = ['Decor',[3803.56,3736.53,39.6584],270.273,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_600103729_1499039_81910 = ['Decor',[3802.6,3729.15,39.8191],125.847,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_179933728_1398939_72670 = ['Decor',[3796.18,3728.14,39.7267],17.613,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_439943734_9699739_69510 = ['Decor',[3806.44,3734.97,39.6951],203.715,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_560063738_0400439_93200 = ['Decor',[3806.56,3738.04,39.932],13.445,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3787.87,3726.7,39.5705],172.655,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp872382',_thisObj];
}] call InitStruct; 
['Candle',[3802.99,3733.08,45.8722,true],random 360,[0.00218183,-0.00671982,0.999975]] call InitItem; 
['SquareWoodenBox',[3791.31,3736.24,40.0814],4.74284,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3791.32,3743.8,40.0805],4.74284,[0,0,1]] call InitStruct; 
['WoodenDoor',[3792.17,3733.39,40.13],87.2291,[0,0,1]] call InitStruct; 
['WoodenDoor',[3789.8,3732.53,40.13],0.371646,[0,0,1]] call InitStruct; 
['WoodenDoor',[3800.41,3740.44,40.1037],0,[0,0,1]] call InitStruct; 
['ContainerGreen3',[3800.39,3733.33,40.0753],44.9595,[0,0,1]] call InitStruct; 
['WallmountedMedicalCabinet',[3800,3734.57,41.0561],91.4716,[0,0,1]] call InitStruct; 
['WallmountedMedicalCabinet',[3797.54,3732.21,41.144],181.824,[0,0,1]] call InitStruct; 
_3792_750003737_4799840_13000 = ['Decor',[3792.75,3737.48,40.13],269.461,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_919923739_2299840_13000 = ['Decor',[3792.92,3739.23,40.13],279.687,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
['HospitalBed',[3798.03,3740.15,40.1128],90.1782,[0,0,1]] call InitStruct; 
['HospitalBed',[3798.11,3742.16,40.13],91.8035,[0,0,1]] call InitStruct; 
['SmallChair',[3802.27,3733.88,40.0771],0,[0,0,1]] call InitItem; 
['GreenBed',[3802.75,3738.87,40.0841],357.887,[0,0,1]] call InitStruct; 
_3788_179933739_0500540_08050 = ['OldWoodenBox',[3788.18,3739.05,40.0805],185.661,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGreenCabinet',[3788.33,3734.17,40.1067],0,[0,0,1]] call InitStruct; 
['WoodenMedicalBox',[3788.36,3736.72,40.0468],100.126,[0,0,1]] call InitStruct; 
['WoodenMedicalBox',[3791.17,3738.97,40.0564],47.3771,[0,0,1]] call InitStruct; 
_3795_260013740_3999039_62500 = ['Decor',[3795.26,3740.4,39.625],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['BrownLeatherChair',[3800.5,3736.36,40.13],99.8631,[0,0,1]] call InitStruct; 
_3796_489993743_1398940_13000 = ['IStruct',[3796.49,3743.14,40.13],273.756,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3796_500003740_1298840_13000 = ['IStruct',[3796.5,3740.13,40.13],266.782,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3797_530033738_7700240_13150 = ['IStruct',[3797.53,3738.77,40.1315],3.93029,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3797_449953743_1699240_13000 = ['IStruct',[3797.45,3743.17,40.13],182.158,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3798_590093738_8300840_13000 = ['IStruct',[3798.59,3738.83,40.13],345.161,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3798_610113743_1799340_13000 = ['IStruct',[3798.61,3743.18,40.13],183.901,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3796_429933742_0400440_13000 = ['IStruct',[3796.43,3742.04,40.13],277.891,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3802_699953740_4599639_76640 = ['Decor',[3802.7,3740.46,39.7664],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_810063740_4099142_89840 = ['Decor',[3801.81,3740.41,46.4359,true],360,[-2.14576e-006,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_399903732_5000042_69260 = ['Decor',[3788.4,3732.5,46.2301,true],360,[0,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_419923732_4899942_97118 = ['Decor',[3790.42,3732.49,48.0403,true],0,[-1,0,-4.37114e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_389893741_6201237_97788 = ['Decor',[3776.39,3741.62,45.8953,true],179,[0.514948,0.00898335,0.857174], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_699953722_7199717_72190 = ['Decor',[3783.7,3722.72,17.7219],133.443,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_679933733_7099619_53230 = ['Decor',[3793.68,3733.71,19.5323],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_659913731_0600639_93090 = ['Decor',[3780.66,3731.06,39.9309],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_790043727_2900440_11060 = ['Decor',[3790.79,3727.29,40.1106],182.516,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_810063727_2299840_01930 = ['Decor',[3797.81,3727.23,40.0193],76.6894,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_bandage_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_100103729_7099639_96466 = ['Decor',[3797.1,3729.71,44.9952,true],229.305,[0.0364869,-0.0118077,0.999264], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_1x1_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_060063729_0900939_99100 = ['Decor',[3786.06,3729.09,39.991],346.647,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_5x5_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_050053728_7199740_00500 = ['Decor',[3801.05,3728.72,40.005],229.095,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_5x5_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_129883717_6499039_85890 = ['Decor',[3779.13,3717.65,39.8589],210.584,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharpstones_erosion.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_060063732_0100139_67710 = ['Decor',[3785.06,3732.01,39.6771],287.441,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_199953727_3200739_71510 = ['Decor',[3783.2,3727.32,39.7151],317.071,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_139893719_9199220_11300 = ['Decor',[3800.14,3719.92,20.113],225.8,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_510013729_3300820_11300 = ['Decor',[3799.51,3729.33,20.113],26.1358,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_040043740_0200239_94320 = ['Decor',[3785.04,3740.02,39.9432],71.374,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_560063731_8000539_75280 = ['Decor',[3806.56,3731.8,39.7528],132.346,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3787_669923721_5300339_82250 = ['Decor',[3787.67,3721.53,39.8225],301.605,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_770023721_0000039_71770 = ['Decor',[3796.77,3721,39.7177],304.605,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_379883720_2800339_69220 = ['Decor',[3792.38,3720.28,39.6922],173.392,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_939943723_9599640_11700 = ['Decor',[3777.94,3723.96,40.117],317.113,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_679933742_4599619_73140 = ['Decor',[3780.68,3742.46,19.7314],139.795,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntrock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3787_139893727_4699739_89440 = ['Decor',[3787.14,3727.47,39.8944],68.4747,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\cliff\cliff_stone_medium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_850103717_6201239_57780 = ['Decor',[3786.85,3717.62,39.5778],274.989,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\sharp\sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_570073736_1101140_16340 = ['Decor',[3783.57,3736.11,40.1634],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_780033741_4399440_09380 = ['Decor',[3796.78,3741.44,40.0938],0.000245887,[0,0,1], {_thisObj setvariable ['model','ca\buildings\hut_old02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_600103735_9199240_04110 = ['Decor',[3792.6,3735.92,40.0411],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\pereliv.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_590093743_7399940_11270 = ['Decor',[3792.59,3743.74,40.1127],40.1049,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\medical\kapelnica.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_310063743_6999540_13000 = ['Decor',[3793.31,3743.7,40.13],183.624,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\medical\kapelnica.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_060063736_8601141_48990 = ['Decor',[3792.06,3736.86,46.4899,true],90,[0,-1,1.19249e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_510013732_4599641_42210 = ['Decor',[3790.51,3732.46,46.4221,true],4.08264e-012,[1,0,1.19249e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_530033733_2500040_10580 = ['Decor',[3802.53,3733.25,40.1058],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3787_189943724_9399440_02400 = ['Decor',[3787.19,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_659913732_5100140_01900 = ['Decor',[3778.66,3732.51,40.019],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_550053740_5200240_01900 = ['Decor',[3780.55,3740.52,40.019],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_189943724_9399440_02370 = ['Decor',[3779.19,3724.94,40.0237],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_189943724_9399440_02400 = ['Decor',[3795.19,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_189943723_0500540_02370 = ['Decor',[3779.19,3723.05,40.0237],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_659913740_5200240_01900 = ['Decor',[3778.66,3740.52,40.019],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_189943723_0500540_02400 = ['Decor',[3803.19,3723.05,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_189943724_9399440_02400 = ['Decor',[3803.19,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_389893729_1899440_01150 = ['Decor',[3791.39,3729.19,40.0115],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_500003729_1899440_01150 = ['Decor',[3789.5,3729.19,40.0115],90.0001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_560063726_5000040_01910 = ['Decor',[3780.56,3726.5,40.0191],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_649903726_5000040_01910 = ['Decor',[3778.65,3726.5,40.0191],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_040043743_2199740_02300 = ['Decor',[3806.04,3743.22,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_040043741_3200740_02300 = ['Decor',[3806.04,3741.32,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_459963741_6799340_01150 = ['Decor',[3783.46,3741.68,40.0115],347.893,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_3x3_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_169923727_3999040_01810 = ['Decor',[3794.17,3727.4,40.0181],251.532,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_3x3_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3790,3774,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3764,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3774,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3764,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3754,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3754,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3774,69.3073],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3764,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3764,69.5716],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3764,69.4618],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3754,69.1118],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3754,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3774,69.7218],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3754,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3774,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3764,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3774,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3764,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3774,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3754,69.1644],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3754,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3774,69.2061],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3754,69.2754],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3805.07,3771.25,30],20.0003,[0,0,1]] call InitDecor; 
_3777_149903773_7900431_55460 = ['ElectricalShield',[3777.15,3773.79,31.5546],90,[0,0,1], {go_editor_globalRefs set ['_transGeneratorRoom',_thisObj];
}] call InitStruct; 
['SteelGridDoor',[3783.71,3772.68,31.5908],180.424,[0,0,1]] call InitStruct; 
_3783_810063772_6599131_61500 = ['Decor',[3783.81,3772.66,31.615],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['OldWoodenBox',[3800.67,3746.9,40.094],274.911,[0,0,1]] call InitStruct; 
_3796_260013758_4199240_13000 = ['Decor',[3796.26,3758.42,40.13],181.477,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampCeiling',[3794.35,3761.85,42.5435],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling896019',_thisObj];
}] call InitStruct; 
['LampCeiling',[3799.04,3773.24,43.2899],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling85210',_thisObj];
}] call InitStruct; 
['LampCeiling',[3794.8,3747.88,43.7882],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling871440',_thisObj];
}] call InitStruct; 
['LampCeiling',[3794.31,3772.94,43.3374],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling166736',_thisObj];
}] call InitStruct; 
['LampCeiling',[3790.07,3747.9,43.3856],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling420604',_thisObj];
}] call InitStruct; 
['LampCeiling',[3798.31,3774.75,46.6748],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling119892',_thisObj];
}] call InitStruct; 
['LampCeiling',[3792.82,3757.47,43.2148],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling686750',_thisObj];
}] call InitStruct; 
['LampCeiling',[3798.65,3757.6,43.0294],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling657799',_thisObj];
}] call InitStruct; 
_3800_300053766_7500039_97570 = ['Decor',[3800.3,3766.75,39.9757],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\perila.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_100103766_7500039_97790 = ['Decor',[3798.1,3766.75,39.9779],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\perila.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_580083749_2399939_69400 = ['Decor',[3803.58,3749.24,39.694],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_540043746_1201239_70800 = ['Decor',[3803.54,3746.12,39.708],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_02_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_370123770_9599640_60290 = ['Decor',[3786.37,3770.96,40.6029],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_530033755_2600140_13000 = ['Decor',[3788.53,3755.26,40.13],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_330083766_8898940_59060 = ['Decor',[3788.33,3766.89,40.5906],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_520023761_2600140_13000 = ['Decor',[3788.52,3761.26,40.13],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_040043766_8898940_59100 = ['Decor',[3791.04,3766.89,40.591],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_530033763_2099640_13000 = ['Decor',[3789.53,3763.21,40.13],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3805.19,3749.9,39.1599],88.4188,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp673634',_thisObj];
}] call InitStruct; 
['Candle',[3802.86,3745.54,46.0108,true],random 360,[0.00218183,-0.00671982,0.999975]] call InitItem; 
_3790_689943750_0800840_08050 = ['Decor',[3790.69,3750.08,40.0805],271.291,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_280033760_8601140_06350 = ['Decor',[3793.28,3760.86,40.0635],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_010013771_4099140_26950 = ['Decor',[3795.01,3771.41,40.2695],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\wip\unfinished_building_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_050053769_9799840_02140 = ['Decor',[3798.05,3769.98,40.0214],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_969973770_1799343_94950 = ['Decor',[3799.97,3770.18,43.9495],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_330083770_1699243_94950 = ['Decor',[3798.33,3770.17,43.9495],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
['BedOld',[3796.33,3763.8,39.9502],89.6588,[0,0,1]] call InitStruct; 
['WoodenDoor',[3790.46,3761.16,40.13],90.9619,[0,0,1]] call InitStruct; 
['WoodenDoor',[3800.38,3744.14,40.0622],0,[0,0,1]] call InitStruct; 
['WoodenDoor',[3792.22,3744.93,40.13],274.457,[0,0,1]] call InitStruct; 
_3795_590093755_6599139_91330 = ['Decor',[3795.59,3755.66,39.9133],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\addons\metal_shed_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_620123761_8501041_51816 = ['RedButton',[3790.62,3761.85,46.5191,true],2.17111,[0.99877,-0.0378623,0.0320131], {go_editor_globalRefs set ['_doctorHomeSwitcher',_thisObj];
}] call InitStruct; 
_3791_659913751_4699741_65016 = ['RedButton',[3791.66,3751.47,46.6511,true],270.26,[0.00453787,0.999477,0.0320175], {go_editor_globalRefs set ['_doctorHallSwitcher',_thisObj];
}] call InitStruct; 
_3787_899903744_9599641_61126 = ['RedButton',[3787.9,3744.96,46.6122,true],359.516,[0.999451,0.00844429,0.0320258], {go_editor_globalRefs set ['_doctorChemSwitcher',_thisObj];
}] call InitStruct; 
_3796_280033770_8200745_18786 = ['RedButton',[3796.28,3770.82,50.1888,true],187.36,[-0.991252,0.12804,0.0320143], {go_editor_globalRefs set ['_merchantHomeSwitcher',_thisObj];
}] call InitStruct; 
_3790_409913756_0100141_71550 = ['Tumbler',[3790.41,3756.01,41.7155],90.3464,[0,0,1], {go_editor_globalRefs set ['_doctorSignSwitcher',_thisObj];
}] call InitStruct; 
_3793_959963755_1999541_78180 = ['Tumbler',[3793.96,3755.2,46.7826,true],180.356,[0.999919,-0.00614945,-0.0111182], {go_editor_globalRefs set ['_doctorMeatSwitcher',_thisObj];
}] call InitStruct; 
['Tumbler',[3789.26,3749.62,41.2629],305.738,[0,0,1]] call InitStruct; 
_3791_360113769_2900443_94950 = ['Decor',[3791.36,3769.29,43.9495],90.9308,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bed4.p3d'];}] call InitDecor; // !!! realocated model !!!
['ContainerGreen',[3794.1,3760.7,40.1103],291.035,[0,0,1]] call InitStruct; 
['ContainerGreen',[3793.28,3766.95,43.8882],273.709,[0,0,1]] call InitStruct; 
['CaseBedroom',[3796.13,3769.46,43.8597],0,[0,0,1]] call InitStruct; 
['WallmountedMedicalCabinet',[3798.14,3760.05,41.7113],0,[0,0,1]] call InitStruct; 
_3791_510013758_6398940_12190 = ['Decor',[3791.51,3758.64,40.1219],298.159,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_790043773_8000540_44450 = ['Decor',[3800.79,3773.8,40.4445],90,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_840093775_1799340_44450 = ['Decor',[3800.84,3775.18,40.4445],92.0631,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_719973771_1699240_42660 = ['Decor',[3796.72,3771.17,40.4266],90.0001,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\commercial\market\woodencounter_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_719973773_5400440_42510 = ['Decor',[3796.72,3773.54,40.4251],90.0001,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\commercial\market\woodencounter_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_229983767_1899443_94950 = ['Decor',[3795.23,3767.19,43.9495],344.648,[0,0,1], {_thisObj setvariable ['model','ca\misc2\desk\desk.p3d'];}] call InitDecor; // !!! realocated model !!!
['SteelDoorThinSmall',[3793.99,3770.14,40.4348],0,[0,0,1]] call InitStruct; 
['SteelDoorThinSmall',[3795.75,3772.38,43.9123],182.959,[0,0,1]] call InitStruct; 
_3787_760013744_9499540_36690 = ['Decor',[3787.76,3744.95,40.3669],177.068,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_pole_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_659913751_3400940_43720 = ['Decor',[3791.66,3751.34,40.4372],269.249,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_pole_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['ChemDistiller',[3790.55,3750.26,40.9303],350.314,[0,0,1]] call InitItem; 
_3779_620123772_9599632_69160 = ['PowerSwitcher',[3779.62,3772.96,32.6916],0,[0,0,1], {go_editor_globalRefs set ['_street2Switcher',_thisObj];
}] call InitStruct; 
_3779_189943772_9799832_68850 = ['PowerSwitcher',[3779.19,3772.98,32.6885],0,[0,0,1], {go_editor_globalRefs set ['_street1Switcher',_thisObj];
}] call InitStruct; 
['SmallTrashCan',[3799.16,3753.37,40.1194],0,[0,0,1]] call InitStruct; 
['RattanChair',[3794.97,3767.99,43.9495],353.273,[0,0,1]] call InitItem; 
['SteelGreenDoor',[3796.45,3775.5,40.3307],270.367,[0,0,1]] call InitStruct; 
['HospitalBed',[3798.11,3744.23,40.1012],269.467,[0,0,1]] call InitStruct; 
['HospitalBed',[3798.12,3746.22,40.0765],91.8115,[0,0,1]] call InitStruct; 
['HospitalBed',[3802.8,3749.92,40.0979],359.509,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3788.35,3746.01,40.0805],0,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3792.95,3746.89,40.1061],0,[0,0,1]] call InitStruct; 
['LargeClothCabinet',[3790.77,3767.5,43.8712],216.574,[0,0,1]] call InitStruct; 
['ClothCabinet',[3794.68,3763.51,41.3615],180,[0,0,1]] call InitStruct; 
['InfoBoard',[3791.86,3773.48,41.6723],180,[0,0,1]] call InitStruct; 
_3790_429933757_5000040_98580 = ['ElectricalShieldSmall',[3790.43,3757.5,40.9858],90,[0,0,1], {go_editor_globalRefs set ['_transDoctor',_thisObj];
}] call InitStruct; 
_3791_870123769_1899440_23070 = ['SteelGridDoor',[3791.87,3769.19,40.2307],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3798_830083751_9199240_00050 = ['SteelGridDoor',[3798.83,3751.92,40.0005],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
['TrashCan',[3792.87,3770.47,40.4086],100.953,[0,0,1]] call InitStruct; 
['SignMedical',[3798.68,3751.72,48.9435,true],272.972,[0.0204194,-0.0789994,-0.996666], {go_editor_globalRefs set ['Imported SignMedical156392',_thisObj];
}] call InitStruct; 
['SignMedical',[3800.38,3754.52,47.2459,true],269.231,[0,0.0830291,0.996547], {go_editor_globalRefs set ['Imported SignMedical449993',_thisObj];
}] call InitStruct; 
['LampWall',[3794.52,3771.07,51.4401,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall177316',_thisObj];
}] call InitStruct; 
['LampWall',[3776.68,3771.14,36.7771],181.633,[0,0,1], {go_editor_globalRefs set ['Imported LampWall905367',_thisObj];
}] call InitStruct; 
['LampWall',[3793.01,3768.45,51.4488,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall667306',_thisObj];
}] call InitStruct; 
['LampWall',[3776.7,3771.17,34.6374],178.116,[0,0,1], {go_editor_globalRefs set ['Imported LampWall258221',_thisObj];
}] call InitStruct; 
['LampWall',[3776.67,3771.13,38.8914],178.116,[0,0,1], {go_editor_globalRefs set ['Imported LampWall860184',_thisObj];
}] call InitStruct; 
['WoodenMedicalBox',[3793.55,3759.13,40.0703],355.823,[0,0,1]] call InitStruct; 
['SofaBrown',[3796.15,3760.7,40.1108],358.735,[0,0,1]] call InitStruct; 
['HospitalBench',[3792.97,3750.68,40.1019],0,[0,0,1]] call InitStruct; 
['HospitalBench',[3792.92,3748.23,40.0873],181.166,[0,0,1]] call InitStruct; 
['HospitalBench',[3794.18,3750.66,40.1029],0,[0,0,1]] call InitStruct; 
['HospitalBench',[3793.19,3755.41,40.1132],182.492,[0,0,1]] call InitStruct; 
['HospitalBench',[3791.8,3755.42,40.1167],180.602,[0,0,1]] call InitStruct; 
['HospitalBench',[3794.12,3748.19,40.0818],181.456,[0,0,1]] call InitStruct; 
_3776_199953775_7500031_23250 = ['Decor',[3776.2,3775.75,31.2325],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_260013758_3999039_62500 = ['Decor',[3795.26,3758.4,39.625],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['ArmChairBrown',[3800.32,3750.55,40.1023],295.683,[0,0,1]] call InitStruct; 
['ChairLibrary',[3791.97,3762.48,40.1],354.276,[0,0,1]] call InitItem; 
_3798_719973747_3601140_13000 = ['IStruct',[3798.72,3747.36,40.13],358.091,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3796_540043744_2199740_13000 = ['IStruct',[3796.54,3744.22,40.13],268.648,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3796_669923746_5300340_13000 = ['IStruct',[3796.67,3746.53,40.13],280.021,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
_3797_590093747_3300840_13000 = ['IStruct',[3797.59,3747.33,40.13],359.045,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\medzanaves2.p3d'];}] call InitStruct; // !!! realocated model !!!
['SmallRedseatChair',[3802.34,3744.63,40.0689],172.408,[0,0,1]] call InitItem; 
_3798_800053754_3000542_85430 = ['Decor',[3798.8,3754.3,46.3918,true],90,[0,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_830083753_3300839_86400 = ['Decor',[3798.83,3753.33,39.864],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_639893766_7800343_56610 = ['Decor',[3795.64,3766.78,43.5661],340.779,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_780033744_1101142_93030 = ['Decor',[3801.78,3744.11,46.4678,true],360,[-2.14576e-006,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_739993770_0900940_24060 = ['Decor',[3792.74,3770.09,40.2406],2.96391,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_669923744_1699239_79740 = ['Decor',[3802.67,3744.17,39.7974],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_840093767_7600140_19490 = ['Decor',[3791.84,3767.76,40.1949],92.9639,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_639893770_0400443_75410 = ['Decor',[3793.64,3770.04,43.7541],0.00023308,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_659913766_6298843_69910 = ['Decor',[3791.66,3766.63,43.6991],2.96391,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_530033772_4299343_67160 = ['Decor',[3792.53,3772.43,43.6716],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_590093766_9699743_72400 = ['Decor',[3790.59,3766.97,43.724],27.2823,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_209963762_8300839_67980 = ['Decor',[3806.21,3762.83,39.6798],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\bsg_eft\gryazuchkas1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_659913753_2099617_02010 = ['Decor',[3794.66,3753.21,17.0201],167.202,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_379883756_6101139_08376 = ['Decor',[3778.38,3756.61,45.3366,true],258.59,[0.774106,0.0551909,0.630646], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_969973769_6899419_40260 = ['Decor',[3794.97,3769.69,19.4026],19.5792,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_360113757_5700740_10770 = ['Decor',[3806.36,3757.57,40.1077],8.62036,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_120123771_8798848_60170 = ['Decor',[3800.12,3771.88,48.6017],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_up_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_760013749_7299840_00950 = ['Decor',[3782.76,3749.73,40.0095],151.191,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_1x1_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_889893756_9499540_01180 = ['Decor',[3783.89,3756.95,40.0118],128.932,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_5x5_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_189943746_4299340_01150 = ['Decor',[3784.19,3746.43,40.0115],223.532,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_3x3_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_479983769_5400443_89440 = ['Decor',[3796.48,3769.54,43.8944],270.285,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_o.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_389893770_9699739_98650 = ['Decor',[3796.39,3770.97,39.9865],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\backalleys\backalley_01_l_1m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_389893773_0800839_99940 = ['Decor',[3796.39,3773.08,39.9994],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\backalleys\backalley_01_l_gap_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_070073767_8501039_60310 = ['Decor',[3776.07,3767.85,39.6031],74.7041,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_520023749_4099139_71690 = ['Decor',[3806.52,3749.41,39.7169],165.786,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_989993767_3501039_90850 = ['Decor',[3782.99,3767.35,39.9085],231.704,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_070073744_3501039_67700 = ['Decor',[3783.07,3744.35,39.677],216.164,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_379883773_1499039_93980 = ['Decor',[3806.38,3773.15,39.9398],212.595,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stalker_props\metallolom.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_750003769_5300339_98760 = ['Decor',[3805.75,3769.53,39.9876],297.851,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\military\fortifications\barricade_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_790043766_3000519_97680 = ['Decor',[3778.79,3766.3,19.9768],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_129883746_8798839_81040 = ['Decor',[3805.13,3746.88,39.8104],322.964,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_219973760_6001039_92670 = ['Decor',[3783.22,3760.6,39.9267],112.524,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_550053767_6499040_02430 = ['Decor',[3785.55,3767.65,40.0243],354.73,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\cliff\cliff_stone_medium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_239993748_6201240_13840 = ['Decor',[3784.24,3748.62,40.1384],68.4747,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\cliff\cliff_stone_medium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_850103761_8999040_17620 = ['Decor',[3784.85,3761.9,40.1762],93.3284,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_850103745_5900939_80960 = ['Decor',[3806.85,3745.59,39.8096],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_669923750_1899440_08050 = ['Decor',[3788.67,3750.19,40.0805],1.18866,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\baloonexo.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_540043772_7399946_59517 = ['Decor',[3799.54,3772.74,51.7071,true],90.923,[0.129903,0,0.991527], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_979983768_7700246_57180 = ['Decor',[3794.98,3768.77,46.5718],0,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_270023771_1101146_56880 = ['Decor',[3794.27,3771.11,46.5688],90.9152,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_300053768_7700246_57000 = ['Decor',[3793.3,3768.77,46.57],0,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_229983768_6799346_56720 = ['Decor',[3792.23,3768.68,46.5672],90.9152,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_590093769_7099631_73750 = ['Decor',[3776.59,3769.71,31.7375],270.698,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_639893769_6799333_52410 = ['Decor',[3776.64,3769.68,33.5241],270.698,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_800053772_8601133_52410 = ['Decor',[3779.8,3772.86,33.5241],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_800053772_7800331_73750 = ['Decor',[3779.8,3772.78,31.7375],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\zhelstenabig.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_669923757_5100142_98940 = ['Decor',[3800.67,3757.51,47.9894,true],90,[0,-0.000541059,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_959963768_5800843_89450 = ['Decor',[3789.96,3768.58,43.8945],90.0003,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_280033748_3501041_51380 = ['Decor',[3792.28,3748.35,46.5138,true],90,[0,1,-1.71264e-006], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_300053747_1201242_86580 = ['Decor',[3792.3,3747.12,47.8658,true],89.9996,[0,-8.74228e-008,-1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_639893756_2700241_58010 = ['Decor',[3790.64,3756.27,46.5801,true],90,[0,1,-4.37114e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_040043770_0300340_39780 = ['Decor',[3796.04,3770.03,40.3978],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_570073772_4899943_74100 = ['Decor',[3793.57,3772.49,43.741],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_570073770_9499543_77000 = ['Decor',[3796.57,3770.95,43.77],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_489993770_0800843_89450 = ['Decor',[3791.49,3770.08,43.8945],0.843598,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_679933766_5800843_84040 = ['Decor',[3793.68,3766.58,43.8404],0.00023308,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_620123775_5800846_90290 = ['Decor',[3796.62,3775.58,46.9029],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_02_1m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_810063775_5800847_00130 = ['Decor',[3796.81,3775.58,47.0013],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_02_1m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_729983775_5900945_49520 = ['Decor',[3794.73,3775.59,45.4952],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_110113774_3300843_96018 = ['Decor',[3795.11,3774.33,49.725,true],90,[0.0697564,0,0.997564], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_810063769_9499531_10100 = ['Decor',[3780.81,3769.95,31.101],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\fireescape_01_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_820073774_7299845_49260 = ['Decor',[3792.82,3774.73,45.4926],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_679933774_8400945_87480 = ['Decor',[3791.68,3774.84,45.8748],269.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_540043774_8100642_81750 = ['Decor',[3791.54,3774.81,42.8175],269.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_550053772_1298842_81810 = ['Decor',[3791.55,3772.13,42.8181],269.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_689943772_1499045_83740 = ['Decor',[3791.69,3772.15,45.8374],269.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_919923766_7700241_74490 = ['Decor',[3793.92,3766.77,41.7449],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_429933766_7700241_78230 = ['Decor',[3794.43,3766.77,41.7823],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_570073771_2399943_97470 = ['Decor',[3792.57,3771.24,43.9747],89.0095,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\sofa_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_459963773_4099140_51480 = ['ChairLibrary',[3792.46,3773.41,40.5148],87.9411,[0,0,1], {_thisObj setvariable ['model','ca\buildings\misc\lavicka_3.p3d'];}] call InitItem; // !!! realocated model !!!
_3794_719973768_4699743_90930 = ['Decor',[3794.72,3768.47,43.9093],11.1678,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\rug_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_439943768_4899943_90560 = ['Decor',[3792.44,3768.49,43.9056],342.075,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\rug_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_179933759_1201239_86590 = ['Decor',[3799.18,3759.12,39.8659],1.37544,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\surgtable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_709963749_3898940_13000 = ['Decor',[3798.71,3749.39,40.13],349.767,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\nosilki.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_350103749_2600140_07820 = ['Decor',[3797.35,3749.26,40.0782],0.65181,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\nosilki.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_260013755_7299839_69370 = ['Decor',[3799.26,3755.73,39.6937],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\autopsy\autopsy.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_060063749_5000039_86310 = ['Decor',[3794.06,3749.5,39.8631],0,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_929933749_5000039_86450 = ['Decor',[3792.93,3749.5,39.8645],0,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_560063745_3200740_08190 = ['Decor',[3802.56,3745.32,40.0819],357.399,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officetable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_659913771_3100643_84460 = ['Decor',[3794.66,3771.31,43.8446],92.0351,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\carpet_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_179933762_7800340_11030 = ['Decor',[3791.18,3762.78,40.1103],269.408,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_820073771_2700243_95260 = ['Decor',[3793.82,3771.27,43.9526],180.063,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\tablesmall_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_110113774_9699747_24680 = ['Decor',[3800.11,3774.97,47.2468],260.374,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\teh_shkaf.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_149903753_8898940_01140 = ['Decor',[3784.15,3753.89,40.0114],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_750003765_0300340_00030 = ['Decor',[3784.75,3765.03,40.0003],0.000122943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_550053748_5200240_01900 = ['Decor',[3780.55,3748.52,40.019],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_659913756_5200240_01900 = ['Decor',[3778.66,3756.52,40.019],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_659913764_5300340_01900 = ['Decor',[3778.66,3764.53,40.019],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_149903752_0000040_01140 = ['Decor',[3784.15,3752,40.0114],0.000122943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_550053756_5200240_01900 = ['Decor',[3780.55,3756.52,40.019],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_550053764_5300340_01900 = ['Decor',[3780.55,3764.53,40.019],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_959963751_7700240_02300 = ['Decor',[3805.96,3751.77,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_250003766_0100140_02300 = ['Decor',[3806.25,3766.01,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_959963753_6799340_02300 = ['Decor',[3805.96,3753.68,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3790,3784,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3794,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3804,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3794,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3804,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3784,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3794,68.5883],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3781.03,3783.1,26.0126],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3794,68.3986],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3804,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3784,68.8481],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780.97,3804,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780.81,3804,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3794,68.6496],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3804,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3784,68.9303],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3804,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3784,68.3851],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3804,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3804,20.035],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3794,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3784,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3794,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3794,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3784,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3807.28,3783.49,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3804,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3805.25,3795.32,30],339,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3804,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780.13,3779.2,29.9327],0,[0,0,1]] call InitDecor; 
_3797_520023777_6799340_07450 = ['ElectricalShield',[3797.52,3777.68,40.0745],0,[0,0,1], {go_editor_globalRefs set ['_transMerchant',_thisObj];
}] call InitStruct; 
_3801_669923776_9199240_58630 = ['Decor',[3801.67,3776.92,40.5863],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_pole_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_370123786_9599640_62370 = ['Decor',[3786.37,3786.96,40.6237],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_639893786_9399440_62400 = ['Decor',[3803.64,3786.94,40.624],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_370123778_9699740_61110 = ['Decor',[3786.37,3778.97,40.6111],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_639893780_9299340_62400 = ['Decor',[3803.64,3780.93,40.624],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_639893777_9199240_62400 = ['Decor',[3803.64,3777.92,40.624],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_699953776_9099140_62400 = ['Decor',[3802.7,3776.91,40.624],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_959963807_8501019_87300 = ['Decor',[3777.96,3807.85,19.873],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_520023780_9399431_46820 = ['PowerGenerator',[3777.52,3780.94,31.4682],270,[0,0,1], {go_editor_globalRefs set ['_generatorMain',_thisObj];
}] call InitStruct; 
['SquareWoodenBox',[3778.81,3780.14,31.5991],4.74284,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3807.22,3791.78,41.7234,true],93.1287,[0.185615,0,0.982623]] call InitStruct; 
['WoodenDoor',[3795.18,3788.38,40.13],346.743,[0,0,1]] call InitStruct; 
['WoodenDoor',[3792.29,3783.15,40.13],334.393,[0,0,1]] call InitStruct; 
_3779_479983787_4099125_94910 = ['Decor',[3779.48,3787.41,25.9491],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
['Tumbler',[3777.83,3779.58,32.2915],0,[0,0,1]] call InitStruct; 
_3798_010013776_5500541_67580 = ['Tumbler',[3798.01,3776.55,41.6758],359.799,[0,0,1], {go_editor_globalRefs set ['_merchantMainSwitcher',_thisObj];
}] call InitStruct; 
_3808_000003794_0000041_37500 = ['Decor',[3808,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_260013788_3999039_62500 = ['Decor',[3795.26,3788.4,39.625],270,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_000003794_0000041_37500 = ['Decor',[3790,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_969973785_9599640_18400 = ['Decor',[3790.97,3785.96,40.184],154.039,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\barikada_1.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallChair',[3790.82,3783.74,40.1436],343.219,[0,0,1]] call InitItem; 
_3790_469973787_1699240_18400 = ['OldWoodenBox',[3790.47,3787.17,40.184],346.78,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
_3796_739993785_8898940_23070 = ['OldWoodenBox',[3796.74,3785.89,40.2307],3.63802,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelBrownContainer',[3789.89,3788.21,40.1486],236.506,[0,0,1]] call InitItem; 
['SteelBrownContainer',[3796.06,3782.75,40.1914],1.65672,[0,0,1]] call InitItem; 
['ConcretePanel',[3783.96,3786.67,31.6191],0,[0,0,1]] call InitStruct; 
['PowerSwitcherBox',[3780.92,3782.08,31.6687],180,[0,0,1]] call InitStruct; 
['BigElectricPumpFan',[3781.57,3782.61,31.4646],180,[0,0,1]] call InitStruct; 
['BigPipePump',[3781.6,3779.47,30.9612],6.83019e-005,[0,0,1]] call InitStruct; 
['OldEngine',[3776.75,3783.29,31.696],0,[0,0,1]] call InitStruct; 
['ElectricPump',[3778.2,3782.85,31.4139],270,[0,0,1]] call InitStruct; 
['SmallGreenGenerator',[3780.89,3782.64,31.6705],90,[0,0,1]] call InitStruct; 
['DrumGenerator',[3778.79,3783.75,31.6708],90,[0,0,1]] call InitStruct; 
_3795_260013776_3999039_62500 = ['Decor',[3795.26,3776.4,39.625],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_840093794_1298841_88000 = ['Decor',[3797.84,3794.13,41.88],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_510013777_1899431_47000 = ['Decor',[3781.51,3777.19,31.47],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_370123777_1101131_47020 = ['Decor',[3778.37,3777.11,31.4702],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_159913777_9499531_47210 = ['Decor',[3782.16,3777.95,31.4721],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_760013784_4399433_74859 = ['Decor',[3780.76,3784.44,38.6991,true],1.4482,[0.999595,-0.0248013,0.0139293], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3787_280033793_0200241_84750 = ['Decor',[3787.28,3793.02,41.8475],89.3121,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\railways\track_01_switch_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_540043787_7700217_53670 = ['Decor',[3784.54,3787.77,17.5367],139.64,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_129883800_8601137_35860 = ['Decor',[3788.13,3800.86,37.3586],270,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_489993779_1398917_10400 = ['Decor',[3784.49,3779.14,17.104],237.403,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_830083792_9499539_58950 = ['Decor',[3782.83,3792.95,39.5895],320.875,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_870123786_8999035_95240 = ['Decor',[3804.87,3786.9,35.9524],178.003,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_219973798_7199719_33600 = ['Decor',[3797.22,3798.72,19.336],269.196,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_250003789_1298840_86750 = ['Decor',[3801.25,3789.13,40.8675],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_3x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_790043796_8501043_00000 = ['Decor',[3794.79,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_780033796_8501043_00000 = ['Decor',[3802.78,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_870123791_1201243_00000 = ['Decor',[3778.87,3791.12,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3778_820073796_8501043_00000 = ['Decor',[3778.82,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_800053796_8501043_00000 = ['Decor',[3786.8,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_840093791_1201243_00000 = ['Decor',[3804.84,3791.12,43],0.00012892,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_860113791_1298843_00000 = ['Decor',[3784.86,3791.13,43],0.000397005,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_550053776_0300339_72840 = ['Decor',[3805.55,3776.03,39.7284],165.786,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_600103791_7500040_08590 = ['Decor',[3776.6,3791.75,40.0859],268.639,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_689943794_1398941_90654 = ['Decor',[3800.69,3794.14,46.7057,true],72.9407,[0.010419,-0.0219185,0.999705], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_439943785_830086_77953 = ['Decor',[3803.44,3785.83,6.77953],218.865,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_540043778_0200240_13500 = ['Decor',[3806.54,3778.02,40.135],75,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_689943787_0200240_06490 = ['Decor',[3795.69,3787.02,40.0649],259.68,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\cargo_house_slum_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_469973784_3000540_01830 = ['Decor',[3791.47,3784.3,40.0183],64.68,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\cargo_house_slum_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_100103776_5100142_63900 = ['Decor',[3794.1,3776.51,42.639],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\ventel.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_300053777_1599131_60560 = ['Decor',[3776.3,3777.16,31.6056],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_250003782_8701231_61520 = ['Decor',[3782.25,3782.87,31.6152],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_699953784_5100131_61520 = ['Decor',[3776.7,3784.51,31.6152],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_510013784_4399431_61520 = ['Decor',[3779.51,3784.44,31.6152],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_189943780_0300331_61520 = ['Decor',[3782.19,3780.03,31.6152],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_489993776_8400942_81600 = ['Decor',[3793.49,3776.84,42.816],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_070073776_6599145_90620 = ['Decor',[3796.07,3776.66,45.9062],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_649903776_8601142_75650 = ['Decor',[3794.65,3776.86,42.7565],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_449953776_6499045_86880 = ['Decor',[3793.45,3776.65,45.8688],359.581,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_320073803_9499539_50342 = ['Decor',[3805.32,3803.95,46.2883,true],270,[0.156434,0,0.987688], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_479983787_2199740_18070 = ['Decor',[3796.48,3787.22,40.1807],163.816,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\chairs\kitchen_chair_a\kitchen_chair_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3794_010013776_0500540_38440 = ['ChairLibrary',[3794.01,3776.05,40.3844],6.36345,[0,0,1], {_thisObj setvariable ['model','ca\buildings\misc\lavicka_3.p3d'];}] call InitItem; // !!! realocated model !!!
_3797_010013783_8501040_28510 = ['Decor',[3797.01,3783.85,40.2851],80.2341,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\matras_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_320073787_5700740_73550 = ['Decor',[3790.32,3787.57,40.7355],241.812,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\matras.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_340093787_8701240_17090 = ['Decor',[3796.34,3787.87,40.1709],166.9,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\table_drawer\table_drawer.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_080083783_2900440_15210 = ['Decor',[3791.08,3783.29,40.1521],331.701,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3800,3824,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3834,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3814,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3824,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3834,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3782.4,3833.34,30],26.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3824,69.4369],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3824,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3811.94,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3834,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3814,69.2912],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3814,66.6224,true],0,[0.228844,0,0.973463]] call InitDecor; 
['BlockDirt',[3790,3824,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3834,69.0711],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3824,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3834,68.7173],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3814,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3814,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3824,69.1123],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3814,69.2088],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3821.94,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['LampCeiling',[3796.62,3837.01,47.4674],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling788751',_thisObj];
}] call InitStruct; 
['LampCeiling',[3800.07,3836.91,47.3946],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling499367',_thisObj];
}] call InitStruct; 
['LampCeiling',[3783.21,3834.84,43.2029],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling774675',_thisObj];
}] call InitStruct; 
_3794_540043810_8601119_97820 = ['Decor',[3794.54,3810.86,19.9782],337.168,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_169923829_7600120_03940 = ['Decor',[3799.17,3829.76,20.0394],252.425,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_959963830_0100140_62400 = ['Decor',[3776.96,3830.01,40.624],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_489993819_1001020_00920 = ['Decor',[3786.49,3819.1,20.0092],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntrock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3795.2,3833.14,39.6684],181.35,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp137502',_thisObj];
}] call InitStruct; 
['StreetLamp',[3804.11,3810.61,40.128],0,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp723502',_thisObj];
}] call InitStruct; 
['StreetLamp',[3787.52,3810.58,40.134],16.1165,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp830354',_thisObj];
}] call InitStruct; 
_3776_429933818_6499040_07400 = ['Decor',[3776.43,3818.65,40.074],20.7419,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_840093817_9599640_02200 = ['Decor',[3785.84,3817.96,40.022],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SquareWoodenBox',[3776.35,3820.91,40.0333],0,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3777.98,3817.53,39.2429],187.696,[0,0,1]] call InitStruct; 
['WoodenDoor',[3783.08,3818.01,40.022],0,[0,0,1]] call InitStruct; 
_3780_510013839_0800841_53576 = ['RedButton',[3780.51,3839.08,46.5367,true],0.000491113,[0.999488,-7.25853e-006,0.0320041], {go_editor_globalRefs set ['_librabooksbutt',_thisObj];
}] call InitStruct; 
_3801_379883838_8400945_82676 = ['RedButton',[3801.38,3838.84,50.8277,true],177.871,[-0.998798,-0.0371313,0.0320124], {go_editor_globalRefs set ['_headprivaterelax',_thisObj];
}] call InitStruct; 
['ContainerGreen',[3796.07,3839.84,40.9066],81.5386,[0,0,1]] call InitStruct; 
['OfficeCabinet',[3800.08,3835.41,40.9161],167.035,[0,0,1]] call InitStruct; 
_3780_350103817_9599640_11730 = ['Decor',[3780.35,3817.96,40.1173],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenBench',[3804.44,3837.42,44.7032],90.186,[0,0,1]] call InitStruct; 
['WoodenBench',[3802.18,3838.92,44.7151],179.117,[0,0,1]] call InitStruct; 
_3780_790043821_6799340_83050 = ['PowerSwitcher',[3780.79,3821.68,40.8305],180.131,[0,0,1], {go_editor_globalRefs set ['_streetLightSwitcher',_thisObj];
}] call InitStruct; 
['SmallChair',[3797.9,3837.78,40.9197],64.1802,[0,0,1]] call InitItem; 
['SmallChair',[3797.93,3836.87,40.8987],106.205,[0,0,1]] call InitItem; 
['BoardWoodenBox',[3797.66,3838.71,44.6946],89.9805,[0,0,1]] call InitStruct; 
_3776_399903819_3501040_05500 = ['OldWoodenBox',[3776.4,3819.35,40.055],288.765,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGreenCabinet',[3778.23,3821.15,40.0333],90.9485,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3785.58,3837.5,40.281],0,[0,0,1]] call InitStruct; 
['CaseBedroomSmall',[3795.81,3835.4,44.705],181.469,[0,0,1]] call InitStruct; 
['ConcretePanel',[3782.9,3819.73,40.0031],179.818,[0,0,1]] call InitStruct; 
['ConcretePanel',[3779.06,3819.72,40.0031],179.818,[0,0,1]] call InitStruct; 
['TrashCan',[3805.38,3810.63,40.125],179.028,[0,0,1]] call InitStruct; 
['TrashCan',[3788.91,3817.69,40.125],270,[0,0,1]] call InitStruct; 
['LampWall',[3804.08,3839.31,52.1568,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall94383',_thisObj];
}] call InitStruct; 
['LampWall',[3797.33,3837.38,48.9271,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall399520',_thisObj];
}] call InitStruct; 
['Bookcase',[3784.51,3830.32,40.3397],180,[0,0,1]] call InitStruct; 
['SmallBookcase',[3781.7,3830.3,40.2479],180,[0,0,1]] call InitStruct; 
_3796_879883830_6298839_62400 = ['Decor',[3796.88,3830.63,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_750003818_7500039_62300 = ['Decor',[3796.75,3818.75,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_750003830_5000039_62500 = ['Decor',[3783.75,3830.5,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['ChairLibrary',[3785.29,3833.05,40.1812],10.0912,[0,0,1]] call InitItem; 
['ChairLibrary',[3782.99,3833.25,40.1812],176.67,[0,0,1]] call InitItem; 
['ChairLibrary',[3782.99,3834.32,40.1812],191.09,[0,0,1]] call InitItem; 
['ChairLibrary',[3785.24,3834.38,40.1812],355.231,[0,0,1]] call InitItem; 
['SmallRedseatChair',[3796.18,3837.6,40.9269],276.978,[0,0,1]] call InitItem; 
_3800_850103836_6799344_49500 = ['Decor',[3800.85,3836.68,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_060063836_6899444_49500 = ['Decor',[3797.06,3836.69,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_649903836_6699244_49500 = ['Decor',[3804.65,3836.67,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_060063838_2399917_41070 = ['Decor',[3789.06,3838.24,17.4107],206.011,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_959963834_2500040_14190 = ['Decor',[3777.96,3834.25,40.1419],8.62036,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_199953829_3898940_11380 = ['Decor',[3788.2,3829.39,40.1138],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_030033838_5800839_97860 = ['Decor',[3792.03,3838.58,39.9786],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\musor1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_379883813_7199720_13400 = ['Decor',[3785.38,3813.72,20.134],147.512,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_320073834_5700719_24970 = ['Decor',[3804.32,3834.57,19.2497],45.0002,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_250003822_0000040_00000 = ['Decor',[3803.25,3822,40],180,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\nocategory\savin\savin.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_750003836_2500040_00910 = ['Decor',[3791.75,3836.25,40.0091],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\military\mil_wallbig_debris_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_780033822_0100140_12900 = ['Decor',[3795.78,3822.01,40.129],359.778,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_520023813_2900440_13000 = ['Decor',[3806.52,3813.29,40.13],176.592,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_000003815_4099140_12800 = ['Decor',[3793,3815.41,40.128],334.715,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_070073829_3798840_12890 = ['Decor',[3799.07,3829.38,40.1289],164.39,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_510013829_3601140_13040 = ['Decor',[3792.51,3829.36,40.1304],281.261,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_070073835_3300840_12500 = ['Decor',[3783.07,3835.33,40.125],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\addons\i_garage_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_659913829_2299840_25000 = ['Decor',[3784.66,3829.23,40.25],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\accessories\water_source_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_250003820_2500040_12500 = ['Decor',[3804.25,3820.25,40.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_250003820_2500040_12500 = ['Decor',[3802.25,3820.25,40.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_250003823_7500040_12500 = ['Decor',[3804.25,3823.75,40.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_250003823_7500040_12500 = ['Decor',[3802.25,3823.75,40.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_379883833_6298840_24739 = ['Decor',[3806.38,3833.63,45.1231,true],9.97976e-006,[0.173648,0.10294,0.979413], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_500003833_6298840_37500 = ['Decor',[3803.5,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_750003833_6298840_37500 = ['Decor',[3797.75,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_629883833_6298840_37500 = ['Decor',[3800.63,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_129883810_0000040_26200 = ['Decor',[3800.13,3810,40.262],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_129883810_0000040_26190 = ['Decor',[3792.13,3810,40.2619],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_000003821_8798840_26190 = ['Decor',[3779,3821.88,40.2619],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_000003821_8798840_26190 = ['Decor',[3785,3821.88,40.2619],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_250003821_8701240_26100 = ['Decor',[3786.25,3821.87,40.261],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_070073819_8798840_25090 = ['Decor',[3788.07,3819.88,40.2509],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_209963808_1799340_21050 = ['Decor',[3804.21,3808.18,40.2105],90.7035,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_000003836_7399944_67800 = ['Decor',[3803,3836.74,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\woodstenka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_479983836_6899444_67800 = ['Decor',[3805.48,3836.69,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\woodstenka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_629883836_7299844_67800 = ['Decor',[3806.63,3836.73,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_590093839_2099644_68200 = ['Decor',[3798.59,3839.21,44.682],358.543,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_699953839_1999544_68200 = ['Decor',[3796.7,3839.2,44.682],359.194,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_699953837_9599644_67800 = ['Decor',[3801.7,3837.96,44.678],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_500003824_2500040_62500 = ['Decor',[3786.5,3824.25,40.625],0.000234788,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3779_620123824_2399940_62400 = ['Decor',[3779.62,3824.24,40.624],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_129883832_5000040_62500 = ['Decor',[3806.13,3832.5,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_379883812_2500040_62500 = ['Decor',[3792.38,3812.25,40.625],0.000234788,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_250003817_3798840_62500 = ['Decor',[3804.25,3817.38,40.625],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_139893832_5100140_62500 = ['Decor',[3800.14,3832.51,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_379883812_2500040_62500 = ['Decor',[3800.38,3812.25,40.625],0.000234788,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_250003826_6298840_62500 = ['Decor',[3804.25,3826.63,40.625],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_250003823_1298840_62500 = ['Decor',[3803.25,3823.13,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_250003820_8798840_62500 = ['Decor',[3803.25,3820.88,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_379883820_1298840_62500 = ['Decor',[3790.38,3820.13,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_250003826_6298840_62500 = ['Decor',[3799.25,3826.63,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_250003811_1298840_62500 = ['Decor',[3804.25,3811.13,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_129883822_0000040_62500 = ['Decor',[3805.13,3822,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_379883822_0000040_62500 = ['Decor',[3801.38,3822,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_250003817_3798840_62500 = ['Decor',[3799.25,3817.38,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_379883825_5000040_62500 = ['Decor',[3798.38,3825.5,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3789_250003818_2500040_62500 = ['Decor',[3789.25,3818.25,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_250003833_6298840_62500 = ['Decor',[3796.25,3833.63,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_379883818_5000040_62500 = ['Decor',[3798.38,3818.5,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_379883823_1298840_62500 = ['Decor',[3790.38,3823.13,40.625],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_500003811_1298840_62500 = ['Decor',[3788.5,3811.13,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_860113819_9399440_00200 = ['Decor',[3777.86,3819.94,40.002],200.578,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_840093819_7399940_00310 = ['Decor',[3784.84,3819.74,40.0031],179.818,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_969973819_7299840_00310 = ['Decor',[3780.97,3819.73,40.0031],179.818,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_780033819_7399940_00310 = ['Decor',[3786.78,3819.74,40.0031],179.818,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_060063820_6101139_99540 = ['Decor',[3776.06,3820.61,39.9954],200.549,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_689943809_3000539_84792 = ['Decor',[3781.69,3809.3,46.5892,true],180,[0,-0.0697564,0.997564], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_189943837_0300344_78950 = ['Decor',[3798.19,3837.03,44.7895],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_149903827_2099640_12500 = ['Decor',[3800.15,3827.21,40.125],184.112,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_239993816_7700240_12500 = ['Decor',[3800.24,3816.77,40.125],355.947,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_379883827_1899440_12500 = ['Decor',[3806.38,3827.19,40.125],182.387,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_350103816_7199740_12500 = ['Decor',[3806.35,3816.72,40.125],354.273,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_310063827_1799340_12500 = ['Decor',[3803.31,3827.18,40.125],178.728,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_209963816_7399940_12500 = ['Decor',[3803.21,3816.74,40.125],6.68109,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_070073838_4699744_69920 = ['Decor',[3796.07,3838.47,44.6992],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\blankets_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_419923820_6499040_09370 = ['Decor',[3786.42,3820.65,40.0937],78.6514,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\camping\sleeping_bag_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_340093837_4799844_68800 = ['Decor',[3802.34,3837.48,44.688],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\rattantable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_020023837_5600644_72110 = ['Decor',[3806.02,3837.56,44.7211],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\rattantable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_870123836_1699244_47520 = ['Decor',[3797.87,3836.17,44.4752],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\stul_hospoda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_030033837_3701240_93260 = ['Decor',[3797.03,3837.37,40.9326],88.3147,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officetable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_239993837_0800844_68500 = ['Decor',[3798.24,3837.08,44.685],97.0385,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\carpet_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_100103833_7600140_16140 = ['Decor',[3784.1,3833.76,40.1614],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\stol.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_360113837_1398945_85600 = ['Decor',[3801.36,3837.14,45.856],271.174,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ml_plakats3\picture_121.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_739993832_4199240_21080 = ['Decor',[3780.74,3832.42,40.2108],90,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bookshelfbig.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_639893834_5500540_24310 = ['Decor',[3780.64,3834.55,40.2431],0,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bookshelf.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_879883814_9499540_02400 = ['Decor',[3785.88,3814.95,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_879883814_9499540_02400 = ['Decor',[3781.88,3814.95,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_949953814_9499540_02300 = ['Decor',[3776.95,3814.95,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_949953813_0400440_02300 = ['Decor',[3776.95,3813.04,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_879883814_9499540_02400 = ['Decor',[3777.88,3814.95,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_879883813_0400440_02400 = ['Decor',[3785.88,3813.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3777_879883813_0400440_02400 = ['Decor',[3777.88,3813.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_879883813_0400440_02400 = ['Decor',[3781.88,3813.04,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3790,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3844,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3844,69.0538],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3799.75,3864,60],350.001,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3854,69.6344],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3844,69.5912],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3779.6,3864.91,63.9185,true],360,[-1.13994e-006,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3790,3854,68.8261],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.47,3862.69,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3788.38,3864.25,59.8299],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3854,69.7075],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3790,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3864,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3789.25,3840.92,30],330,[0,0,1]] call InitDecor; 
['BlockDirt',[3800,3854,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3844,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3800.2,3843.84,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3790.47,3863,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3788.38,3864.25,49.8299],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3779.6,3864.91,53.9185,true],360,[-1.13994e-006,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3780,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3799.75,3864,50],350.001,[0,0,1]] call InitDecor; 
_3780_379883863_0000044_25000 = ['Decor',[3780.38,3863,44.25],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_6x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_270023844_5600640_07250 = ['ElectricalShield',[3783.27,3844.56,40.0725],180,[0,0,1], {go_editor_globalRefs set ['_transLibra',_thisObj];
}] call InitStruct; 
['SteelGridDoor',[3776.64,3848.78,39.8985],180,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3807.66,3850.04,40.6619],90.9133,[0,0,1]] call InitStruct; 
_3776_760013848_7700239_88730 = ['Decor',[3776.76,3848.77,39.8873],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampCeiling',[3783.67,3849.07,42.8972],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling161668',_thisObj];
}] call InitStruct; 
['LampCeiling',[3803.76,3849.43,47.4188],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling467800',_thisObj];
}] call InitStruct; 
['LampCeiling',[3805.46,3843.33,44.1436],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling865611',_thisObj];
}] call InitStruct; 
['LampCeiling',[3801.12,3844.82,47.4188],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling547290',_thisObj];
}] call InitStruct; 
['LampCeiling',[3797.68,3848.84,44.0532],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling798420',_thisObj];
}] call InitStruct; 
['LampCeiling',[3797.08,3850.26,47.4078],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling458244',_thisObj];
}] call InitStruct; 
['LampCeiling',[3804.74,3844.35,47.4157],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling260950',_thisObj];
}] call InitStruct; 
['LampCeiling',[3800.49,3850.18,47.4502],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling151716',_thisObj];
}] call InitStruct; 
['LampCeiling',[3802.33,3848.52,47.3756],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling971839',_thisObj];
}] call InitStruct; 
_3793_000003843_5000041_13690 = ['Decor',[3793,3843.5,41.1369],180,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_construction\misc_rubble_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3785_969973841_5500540_62400 = ['Decor',[3785.97,3841.55,40.624],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\pipe\pipefence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3793.67,3852.28,39.4415],271.33,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp475780',_thisObj];
}] call InitStruct; 
_3797_449953844_5200242_26026 = ['RedButton',[3797.45,3844.52,47.2612,true],270.597,[0.010419,0.999433,0.0320109], {go_editor_globalRefs set ['_headknuthouseswitcher',_thisObj];
}] call InitStruct; 
_3798_959963840_3200742_27666 = ['RedButton',[3798.96,3840.32,47.2776,true],89.2857,[0.0124612,-0.99941,0.0320188], {go_editor_globalRefs set ['_headknutworkswitcher',_thisObj];
}] call InitStruct; 
_3781_379883849_1799341_54596 = ['RedButton',[3781.38,3849.18,46.5469,true],0.000491113,[0.999488,-7.25853e-006,0.0320041], {go_editor_globalRefs set ['_librahousebutt',_thisObj];
}] call InitStruct; 
_3799_719973848_1298845_90676 = ['RedButton',[3799.72,3848.13,50.9077,true],272.454,[0.0428,0.998571,0.0320129], {go_editor_globalRefs set ['_headprivatesleep',_thisObj];
}] call InitStruct; 
_3804_060063841_7700245_90766 = ['RedButton',[3804.06,3841.77,50.9086,true],272.454,[0.0428,0.998571,0.0320129], {go_editor_globalRefs set ['_headprivatework',_thisObj];
}] call InitStruct; 
_3801_090093842_4499542_33906 = ['RedButton',[3801.09,3842.45,47.34,true],179.372,[-0.999427,-0.0109527,0.0320266], {go_editor_globalRefs set ['_headknutlobbyswitcher',_thisObj];
}] call InitStruct; 
_3800_209963850_6398940_96650 = ['Decor',[3800.21,3850.64,40.9665],0,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bed4.p3d'];}] call InitDecor; // !!! realocated model !!!
['ContainerGreen',[3799.37,3851.87,44.7063],84.9004,[0,0,1]] call InitStruct; 
['ContainerGreen',[3785.55,3850.02,40.2721],181.458,[0,0,1]] call InitStruct; 
['CaseBedroom',[3800.58,3852.04,44.6903],271.335,[0,0,1]] call InitStruct; 
['SteelDoorThinSmall',[3801.23,3843.43,40.9795],267.225,[0,0,1]] call InitStruct; 
['WoodenBench',[3798.72,3843.77,40.9334],89.9935,[0,0,1]] call InitStruct; 
['ArmChair',[3796.15,3841.27,40.9392],30.9877,[0,0,1]] call InitStruct; 
['WoodenDoubleDoor',[3802.84,3841.58,44.6738],0,[0,0,1]] call InitStruct; 
['PowerSwitcherBig',[3776.64,3862.52,41.893],0,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[3806.75,3846.15,44.6276],270,[0,0,1]] call InitStruct; 
['GreenBed',[3785.32,3846.93,40.306],180,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3795.66,3846.22,40.9463],0,[0,0,1]] call InitStruct; 
['ChestCabinet',[3806.19,3851.01,45.0007],0,[0,0,1]] call InitStruct; 
['LargeClothCabinet',[3799.21,3845.21,40.8571],182.559,[0,0,1]] call InitStruct; 
['ClothCabinet',[3781.84,3847.6,41.5336],88.8463,[0,0,1]] call InitStruct; 
['RedLuxuryChair',[3805.94,3842.37,44.7169],231.954,[0,0,1]] call InitStruct; 
['LuxuryDoubleBed',[3796.61,3851.14,44.7073],270.532,[0,0,1]] call InitStruct; 
['RedSofa',[3800.43,3844.69,44.7037],0.00023308,[0,0,1]] call InitStruct; 
['RedPappedChair',[3804.35,3851.32,44.7265],0,[0,0,1]] call InitItem; 
['LuxuryCabinet',[3797.57,3848.61,44.7187],0.000122943,[0,0,1]] call InitStruct; 
['BigClothCabinet',[3802.05,3850.84,44.7292],268.729,[0,0,1]] call InitStruct; 
['Intercom',[3778.2,3867.36,40.7612],183.611,[0,0,1]] call InitStruct; 
['Intercom',[3801.82,3848.78,45.5173],181.204,[0,0,1]] call InitStruct; 
['Intercom',[3777.56,3860.74,41.2089],0.074805,[0,0,1]] call InitStruct; 
['StationSpeaker',[3780.43,3852.47,42.7291],180.558,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker891726',_thisObj];
}] call InitStruct; 
['LampWall',[3799.04,3842.75,49.4015,true],180.002,[0.999999,-4.54635e-006,-0.00158835], {go_editor_globalRefs set ['Imported LampWall438783',_thisObj];
}] call InitStruct; 
_3780_379883857_1298839_62400 = ['Decor',[3780.38,3857.13,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_879883851_6298839_62300 = ['Decor',[3796.88,3851.63,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_750003848_5000039_62500 = ['Decor',[3783.75,3848.5,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['ArmChairBrown',[3781.86,3849.98,40.2793],311.73,[0,0,1]] call InitStruct; 
['StripedChair',[3803.75,3849.49,44.6446],14.6751,[0,0,1]] call InitItem; 
['StripedChair',[3804.78,3849.56,44.6499],332.525,[0,0,1]] call InitItem; 
['StripedChair',[3798.5,3847.7,40.9513],300.049,[0,0,1]] call InitItem; 
_3777_889893867_3701239_18620 = ['Decor',[3777.89,3867.37,39.1862],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallRedseatChair',[3783.43,3851.07,40.2386],190.772,[0,0,1]] call InitItem; 
_3790_540043857_6298850_93860 = ['Decor',[3790.54,3857.63,50.9386],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_790043852_1699240_13000 = ['Decor',[3782.79,3852.17,40.13],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3781_229983850_7299840_33460 = ['Decor',[3781.23,3850.73,40.3346],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3784_409913852_1999540_13000 = ['Decor',[3784.41,3852.2,40.13],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_469973849_3400939_92420 = ['Decor',[3780.47,3849.34,39.9242],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_570073849_0700739_86440 = ['Decor',[3780.57,3849.07,39.8644],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3786_219973846_2600139_79890 = ['GreenBed',[3786.22,3846.26,39.7989],269.359,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\backalleys\backalley_02_l_1m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3786_229983847_2399939_88930 = ['GreenBed',[3786.23,3847.24,39.8893],269.359,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\backalleys\backalley_02_l_1m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_3797_040043847_2199744_49500 = ['Decor',[3797.04,3847.22,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_040043850_7299844_49500 = ['Decor',[3797.04,3850.73,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_620123850_7099644_49500 = ['Decor',[3804.62,3850.71,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_649903840_1899444_49500 = ['Decor',[3804.65,3840.19,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_639893843_6999544_49500 = ['Decor',[3804.64,3843.7,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_850103840_1899444_49500 = ['Decor',[3800.85,3840.19,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_830083847_2099644_49500 = ['Decor',[3800.83,3847.21,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_050053840_1999544_49500 = ['Decor',[3797.05,3840.2,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3797_040043843_7099644_49450 = ['Decor',[3797.04,3843.71,44.4945],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_830083850_7199744_49500 = ['Decor',[3800.83,3850.72,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_840093843_6999544_49500 = ['Decor',[3800.84,3843.7,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_629883847_1899444_49500 = ['Decor',[3804.63,3847.19,44.495],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\poldrevko.p3d'];}] call InitDecor; // !!! realocated model !!!
_3790_750003843_6298840_27890 = ['Decor',[3790.75,3843.63,40.2789],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3793_879883843_1298840_52320 = ['Decor',[3793.88,3843.13,40.5232],90,[0,0,1], {_thisObj setvariable ['model','ca\misc\fort_barricade.p3d'];}] call InitDecor; // !!! realocated model !!!
_3792_129883842_7500040_26190 = ['Decor',[3792.13,3842.75,40.2619],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\military\fortifications\barricade_01_10m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_729983850_1599140_04330 = ['Decor',[3791.73,3850.16,40.0433],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_argo\walls\military\mil_wallbig_debris_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3788_649903853_7700240_13010 = ['Decor',[3788.65,3853.77,40.1301],27.4835,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3782_729983848_8701240_12500 = ['Decor',[3782.73,3848.87,40.125],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardhouse_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3776_750003860_6298840_50000 = ['Decor',[3776.75,3860.63,40.5],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\military\barracks\guardbox_01_brown_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_310063849_7399940_25620 = ['Decor',[3780.31,3849.74,40.2562],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_enoch\civilian\garbage\garbagebin_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_320073843_3999044_73320 = ['Decor',[3795.32,3843.4,44.7332],181.279,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_699953852_5200243_95470 = ['Decor',[3800.7,3852.52,43.9547],271.369,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_439943852_0400444_67800 = ['Decor',[3805.44,3852.04,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\woodstenka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_639893851_3300844_67800 = ['Decor',[3801.64,3851.33,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\woodstenka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3802_850103852_1001044_67800 = ['Decor',[3802.85,3852.1,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\woodstenka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_679933844_0600644_73370 = ['Decor',[3806.68,3844.06,44.7337],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_649903842_8501044_67800 = ['Decor',[3806.65,3842.85,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_719973848_1999544_68200 = ['Decor',[3806.72,3848.2,44.682],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_770023850_8000544_68200 = ['Decor',[3806.77,3850.8,44.682],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3807_370123841_6001044_67800 = ['Decor',[3807.37,3841.6,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_649903849_4799844_67800 = ['Decor',[3801.65,3849.48,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3805_169923841_6499044_67800 = ['Decor',[3805.17,3841.65,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_419923851_0900944_67800 = ['Decor',[3795.42,3851.09,44.678],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3800_050053852_3501044_67800 = ['Decor',[3800.05,3852.35,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_860113846_0900944_67800 = ['Decor',[3799.86,3846.09,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_629883848_0500544_67800 = ['Decor',[3798.63,3848.05,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_739993840_5500544_67800 = ['Decor',[3801.74,3840.55,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_449953848_0800844_67800 = ['Decor',[3796.45,3848.08,44.678],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_330083851_0900944_67800 = ['Decor',[3801.33,3851.09,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_310063849_2900444_67800 = ['Decor',[3801.31,3849.29,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3795_399903848_5000044_67800 = ['Decor',[3795.4,3848.5,44.678],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_770023840_9099144_67800 = ['Decor',[3799.77,3840.91,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_820073843_5000044_67800 = ['Decor',[3799.82,3843.5,44.678],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sbs\stukaturkastenka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_500003865_8999040_12500 = ['Decor',[3780.5,3865.9,40.125],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\germodweri.p3d'];}] call InitDecor; // !!! realocated model !!!
_3780_500003860_3798840_12500 = ['Decor',[3780.5,3860.38,40.125],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\germodweri.p3d'];}] call InitDecor; // !!! realocated model !!!
_3799_459963858_6699240_11562 = ['Decor',[3799.46,3858.67,46.8924,true],350.997,[-0.0330542,-0.0534919,0.998021], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3791_050053857_5900939_97427 = ['Decor',[3791.05,3857.59,46.7365,true],0.0777967,[-0.0348995,9.56568e-009,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_270023851_0000040_83050 = ['Decor',[3796.27,3851,40.8305],122.875,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\sofa_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3796_879883848_5100145_72640 = ['Decor',[3796.88,3848.51,45.7264],0,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\pillow_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_679933850_6799344_72370 = ['Decor',[3804.68,3850.68,44.7237],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kovrik\kovernew.p3d'];}] call InitDecor; // !!! realocated model !!!
_3803_709963845_3400944_16100 = ['Decor',[3803.71,3845.34,44.161],13.6285,[0,0,1], {_thisObj setvariable ['model','ml_shabut\carpet\carpet.p3d'];}] call InitDecor; // !!! realocated model !!!
_3798_169923848_4299340_94200 = ['Decor',[3798.17,3848.43,40.942],103.329,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\stul_hospoda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3783_639893851_5900940_24310 = ['Decor',[3783.64,3851.59,40.2431],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officetable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3804_330083850_6101144_70780 = ['Decor',[3804.33,3850.61,44.7078],89.8659,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\tables\office_table_a\office_table_a.p3d'];}] call InitDecor; // !!! realocated model !!!
_3801_229983850_0500545_99860 = ['Decor',[3801.23,3850.05,45.9986],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ml_plakats3\picture_117.p3d'];}] call InitDecor; // !!! realocated model !!!
_3806_290043844_0900944_69670 = ['Decor',[3806.29,3844.09,44.6967],269.894,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bookshelfbig.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3788,3873,50],69.0002,[0,0,1]] call InitDecor; 
['BlockDirt',[3780,3874,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3779.5,3874.5,53.5547,true],360,[-1.13994e-006,-8.74228e-008,-1]] call InitDecor; 
['BlockDirt',[3779.96,3881.65,50],20.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3835.68,3711.75,50],333.417,[0,0,1]] call InitDecor; 
['BlockDirt',[3835.68,3711.75,60],333.417,[0,0,1]] call InitDecor; 
_3833_300053704_5900940_11080 = ['Decor',[3833.3,3704.59,40.1108],211.536,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3830.2,3723.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3733.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3713.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3723.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3733.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3744,68.7909],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3714,69.2726],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3744,69.1444],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3734,68.7219],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3724,69.0738],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3832.04,3714.72,60],11.0847,[0,0,1]] call InitDecor; 
['BlockDirt',[3816.45,3712.8,60],327.678,[0,0,1]] call InitDecor; 
['BlockDirt',[3823.55,3715.23,60],262.866,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3734,69.3684],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3832.04,3714.72,50],11.0847,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3724,69.1749],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3724,69.24],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3734,68.8726],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3713.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3733.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3733.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3734,30],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3724,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3723.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3723.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3823.55,3715.23,50],262.866,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3744,69.1354],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3816.45,3712.8,50],327.678,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3733.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3743.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3743.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3743.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3713.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3723.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3713.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
_3810_500003724_8100620_11640 = ['Decor',[3810.5,3724.81,20.1164],255.876,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_000003732_5600639_15880 = ['Decor',[3836,3732.56,39.1588],231.001,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_169923728_0600619_25450 = ['Decor',[3810.17,3728.06,19.2545],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_800053723_5500539_90160 = ['Decor',[3823.8,3723.55,39.9016],245.847,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_550053729_1201239_89830 = ['Decor',[3825.55,3729.12,39.8983],125.847,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_340093722_9699740_13570 = ['Decor',[3818.34,3722.97,40.1357],255.053,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_580083728_4099139_97370 = ['Decor',[3818.58,3728.41,39.9737],79.685,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\rm_boulder2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_399903730_1101139_32790 = ['Decor',[3814.4,3730.11,39.3279],149.706,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_05_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3810.12,3721.7,38.8332],5.22144,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp115425',_thisObj];
}] call InitStruct; 
['Candle',[3832.2,3738.7,45.4726,true],random 360,[0.00218183,-0.00671982,0.999975]] call InitItem; 
_3828_379883738_6298840_09970 = ['Decor',[3828.38,3738.63,40.0997],30,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SquareWoodenBox',[3826.03,3733.4,39.9533],36.3186,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3825.45,3732.75,40.9191],317.85,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3824,3732.77,39.9663],29.7731,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3825.08,3732.23,39.9838],357.085,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3831.26,3724.38,39.7062],4.09322,[0,0,1]] call InitStruct; 
['WoodenDoor',[3826.1,3740.33,40.0693],300.028,[0,0,1]] call InitStruct; 
['WoodenDoor',[3825.43,3734.65,39.6541],34.8457,[0,0,1]] call InitStruct; 
['WoodenDoor',[3820.84,3738.02,40.1273],33.4239,[0,0,1]] call InitStruct; 
['GreenArmChair',[3828.11,3741.07,40.0253],0,[0,0,1]] call InitStruct; 
['FabricBagBig2',[3818.94,3735.69,40.0782],0,[0,0,1]] call InitItem; 
['SmallTrashCan',[3826.47,3741.6,40.0749],27.5949,[0,0,1]] call InitStruct; 
['ContainerGreen2',[3820.17,3735.14,40.0689],222.384,[0,0,1]] call InitStruct; 
['StationTea',[3823.26,3735.05,40.4972],60.1265,[0,0,1]] call InitStruct; 
['Grill',[3822.47,3733.84,40.234],354.099,[0,0,1]] call InitStruct; 
['SteelBrownContainer',[3832.35,3738.55,40.0595],258.197,[0,0,1]] call InitItem; 
['ConcretePanel',[3831.9,3737.87,39.9774],30,[0,0,1]] call InitStruct; 
['ConcretePanel',[3819.82,3736.61,40.035],214,[0,0,1]] call InitStruct; 
['ConcretePanel',[3823.02,3734.44,40.035],214,[0,0,1]] call InitStruct; 
['ConcretePanel',[3826.78,3740.7,39.977],30,[0,0,1]] call InitStruct; 
_3826_070073736_6699240_01100 = ['Decor',[3826.07,3736.67,40.011],124.182,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_840093725_9099140_10000 = ['Decor',[3819.84,3725.91,40.1],288,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_929933740_1599140_08970 = ['Decor',[3819.93,3740.16,40.0897],302.209,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_649903726_1899440_02670 = ['Decor',[3825.65,3726.19,40.0267],253,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_820073740_8200740_06030 = ['Decor',[3824.82,3740.82,40.0603],32.8354,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_560063726_5400440_10810 = ['Decor',[3833.56,3726.54,40.1081],278,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_399903716_9599617_09310 = ['Decor',[3825.4,3716.96,17.0931],268.898,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_679933715_7299837_42890 = ['Decor',[3833.68,3715.73,37.4289],59,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_639893742_2299839_88200 = ['Decor',[3813.64,3742.23,39.882],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\cliff\cliff_stonecluster_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_250003727_1999520_29825 = ['Decor',[3827.25,3727.2,24.9088,true],[-0.141592,0.318972,0.937128],[0.380215,-0.856531,0.348986], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_689943727_3501020_12460 = ['Decor',[3836.69,3727.35,20.1246],47.3838,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_669923723_7500039_84530 = ['Decor',[3814.67,3723.75,39.8453],188.543,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3816_040043733_3999039_93010 = ['Decor',[3816.04,3733.4,39.9301],44.6064,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\gryazooka_bochki.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_030033732_5400440_06450 = ['Decor',[3829.03,3732.54,40.0645],353.668,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_159913741_8798839_70470 = ['Decor',[3834.16,3741.88,39.7047],353.668,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_080083743_7099639_90430 = ['Decor',[3839.08,3743.71,39.9043],25.5553,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_879883739_5800839_33870 = ['Decor',[3836.88,3739.58,39.3387],318,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_870123730_9599640_07210 = ['Decor',[3821.87,3730.96,40.0721],211.184,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagepallet_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_909913724_8601139_98510 = ['Decor',[3829.91,3724.86,39.9851],151.049,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_669923742_6599140_10850 = ['Decor',[3809.67,3742.66,40.1085],68.1717,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3811_260013723_9599640_12230 = ['Decor',[3811.26,3723.96,40.1223],317.113,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3811_129883718_5600640_03910 = ['Decor',[3811.13,3718.56,40.0391],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_000003736_1298840_00290 = ['Decor',[3821,3736.13,40.0029],304,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\xataexodus.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_419923735_5300340_03500 = ['Decor',[3821.42,3735.53,40.035],214,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_530033739_8000539_97700 = ['Decor',[3828.53,3739.8,39.977],30,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_209963737_6999540_03500 = ['Decor',[3818.21,3737.7,40.035],214,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3816_580083738_8200740_03500 = ['Decor',[3816.58,3738.82,40.035],214,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_239993738_8400939_97700 = ['Decor',[3830.24,3738.84,39.977],30,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_780033717_0600639_89521 = ['Decor',[3838.78,3717.06,46.6428,true],238,[-0.0443834,-0.0277375,0.998629], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_479983720_3701239_96486 = ['Decor',[3822.48,3720.37,46.7376,true],173,[-0.00425314,0.0346393,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_659913716_3999039_86420 = ['Decor',[3812.66,3716.4,46.6369,true],147.999,[-0.0174497,0.0302239,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_050053719_7800339_91126 = ['Decor',[3832.05,3719.78,46.6801,true],191.001,[0.00333386,0.0171317,0.999848], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3831_040043737_3200740_12140 = ['Decor',[3831.04,3737.32,40.1214],19.903,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\matras_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3816_810063738_6599140_13400 = ['Decor',[3816.81,3738.66,40.134],308.508,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sovokbed\sovokbed.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_060063728_2299840_02300 = ['Decor',[3809.06,3728.23,40.023],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3811_199953724_9399440_02400 = ['Decor',[3811.2,3724.94,40.024],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_949953728_2299840_02300 = ['Decor',[3810.95,3728.23,40.023],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3811_199953723_0500540_02400 = ['Decor',[3811.2,3723.05,40.024],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_949953742_8701240_02400 = ['Decor',[3810.95,3742.87,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_060063742_8701240_02400 = ['Decor',[3809.06,3742.87,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_949953734_8701240_02400 = ['Decor',[3810.95,3734.87,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3810,3774,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3764,68.3963],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3754,67.4567],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3774,69.432],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3754,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3774,66.6096],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3774,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3764,69.2225],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3754,69.1302],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3764,66.1997],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3774,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3773.84,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3753.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3753.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3754,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3763.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3763.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3764,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3819_189943761_0000040_10870 = ['ElectricalShield',[3819.19,3761,40.1087],180.444,[0,0,1], {go_editor_globalRefs set ['_street1Gen',_thisObj];
}] call InitStruct; 
_3832_290043775_9199240_54850 = ['Decor',[3832.29,3775.92,40.5485],156.712,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3831_090093770_2199740_55410 = ['Decor',[3831.09,3770.22,40.5541],232.003,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3835_580083771_5900940_55140 = ['Decor',[3835.58,3771.59,40.5514],235.267,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_229983766_5600640_55040 = ['Decor',[3833.23,3766.56,40.5504],10.8836,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampCeiling',[3825.77,3775.03,43.125],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling958655',_thisObj];
}] call InitStruct; 
['LampCeiling',[3834.97,3774.69,43.0945],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling259554',_thisObj];
}] call InitStruct; 
['LampCeiling',[3837.06,3764.16,43.0312],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling819711',_thisObj];
}] call InitStruct; 
['LampCeiling',[3821.47,3775,43.1427],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling607096',_thisObj];
}] call InitStruct; 
['LampCeiling',[3839.11,3769.98,43.1302],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling462665',_thisObj];
}] call InitStruct; 
['LampCeiling',[3832.29,3764.12,42.925],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling838719',_thisObj];
}] call InitStruct; 
['LampCeiling',[3833.13,3769.1,43.1942],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling184779',_thisObj];
}] call InitStruct; 
_3839_949953755_0300339_00000 = ['Decor',[3839.95,3755.03,39],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3836.93,3753.36,37.946],91.0183,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp858425',_thisObj];
}] call InitStruct; 
['StreetLamp',[3816.2,3769.11,39.5032],266.489,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp200086',_thisObj];
}] call InitStruct; 
['Candle',[3818.57,3752.35,45.621,true],random 360,[0.00218183,-0.00671982,0.999975]] call InitItem; 
_3836_020023763_1599140_56720 = ['Decor',[3836.02,3763.16,40.5672],42.8553,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_840093764_0900940_53410 = ['Decor',[3830.84,3764.09,40.5341],297.828,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_100103767_0600640_55720 = ['Decor',[3836.1,3767.06,40.5572],267.159,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_419923764_0300340_13000 = ['Decor',[3818.42,3764.03,40.13],269.427,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_129883761_7199740_31790 = ['Decor',[3823.13,3761.72,40.3179],0.0757596,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenDoor',[3826.17,3748.14,40.0748],239.291,[0,0,1]] call InitStruct; 
['WoodenDoor',[3820.15,3750.72,40.0793],314.068,[0,0,1]] call InitStruct; 
_3817_750003751_8798839_83260 = ['Decor',[3817.75,3751.88,39.8326],135,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_139893767_2500042_00116 = ['RedButton',[3823.14,3767.25,47.0021,true],272.553,[0.044526,0.998495,0.032014], {go_editor_globalRefs set ['_kabakHomeSwitcher',_thisObj];
}] call InitStruct; 
_3822_739993767_2399941_99766 = ['RedButton',[3822.74,3767.24,46.9986,true],272.553,[0.044526,0.998495,0.032014], {go_editor_globalRefs set ['_kabakSignSwitcher',_thisObj];
}] call InitStruct; 
_3826_830083771_3898940_53860 = ['Decor',[3826.83,3771.39,40.5386],0,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bed4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_260013771_6398940_56720 = ['Decor',[3823.26,3771.64,40.5672],89.9324,[0,0,1], {_thisObj setvariable ['model','ca\misc2\desk\desk.p3d'];}] call InitDecor; // !!! realocated model !!!
['BarChair',[3838.51,3767.55,40.5362],317.465,[0,0,1]] call InitItem; 
['BarChair',[3838.45,3769.16,40.552],67.3573,[0,0,1]] call InitItem; 
['BarChair',[3838.39,3769.89,40.5377],28.647,[0,0,1]] call InitItem; 
['BarChair',[3838.42,3768.34,40.549],317.465,[0,0,1]] call InitItem; 
['SmallStoveGrill',[3829.02,3748.66,39.9076],0,[0,0,1]] call InitStruct; 
['FabricBagBig2',[3825.68,3750.33,40.0317],0,[0,0,1]] call InitItem; 
['WoodenChair',[3835.38,3763.7,40.5674],297.827,[0,0,1]] call InitItem; 
['WoodenChair',[3834.81,3771.95,40.5672],286.37,[0,0,1]] call InitItem; 
['WoodenChair',[3832.56,3767.01,40.5676],269.747,[0,0,1]] call InitItem; 
['WoodenChair',[3836.83,3763.91,40.5676],48.0584,[0,0,1]] call InitItem; 
['WoodenChair',[3830.51,3770.85,40.5672],297.344,[0,0,1]] call InitItem; 
['WoodenChair',[3836.11,3766.34,40.5674],151.594,[0,0,1]] call InitItem; 
['WoodenChair',[3831.51,3769.64,40.5672],101.402,[0,0,1]] call InitItem; 
['WoodenChair',[3836.38,3771.29,40.5674],106.209,[0,0,1]] call InitItem; 
['WoodenChair',[3832.15,3770.99,40.5672],97.3959,[0,0,1]] call InitItem; 
['WoodenChair',[3836.61,3775.78,40.5676],95.7257,[0,0,1]] call InitItem; 
['WoodenChair',[3836.04,3767.8,40.5671],37.4859,[0,0,1]] call InitItem; 
['WoodenChair',[3835.61,3770.69,40.5665],124.621,[0,0,1]] call InitItem; 
['WoodenChair',[3833.2,3775.73,40.5672],91.2855,[0,0,1]] call InitItem; 
['WoodenChair',[3831.62,3775.27,40.5656],224.336,[0,0,1]] call InitItem; 
['WoodenChair',[3833.95,3766.4,40.5673],79.9109,[0,0,1]] call InitItem; 
['WoodenChair',[3831.74,3763.74,40.5672],73.6861,[0,0,1]] call InitItem; 
['WoodenChair',[3832.33,3766.14,40.5656],241.976,[0,0,1]] call InitItem; 
['WoodenChair',[3835.14,3775.3,40.5673],273.963,[0,0,1]] call InitItem; 
_3836_290043755_5500540_25140 = ['Decor',[3836.29,3755.55,40.2514],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_pole.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_580083751_4399440_49390 = ['Decor',[3836.58,3751.44,40.4939],84.909,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_250003758_5300340_46360 = ['Decor',[3838.25,3758.53,40.4636],125.327,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallTrashCan',[3833.7,3762.25,40.5672],41.2916,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[3821.49,3772.84,40.357],0,[0,0,1]] call InitStruct; 
['Gramofon',[3828.79,3767.15,41.4484],100.209,[0,0,1]] call InitStruct; 
['SmallChair',[3827.88,3748.64,40.0587],0,[0,0,1]] call InitItem; 
_3825_350103751_3200740_06490 = ['OldWoodenBox',[3825.35,3751.32,40.0649],339.536,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGreenCabinet',[3826.71,3768.36,40.5554],238.213,[0,0,1]] call InitStruct; 
['ClothCabinet',[3820.68,3772.32,41.7971],179.061,[0,0,1]] call InitStruct; 
['InfoBoard',[3824.68,3773.11,41.358],89.3194,[0,0,1]] call InitStruct; 
['CampfireBig',[3821.67,3744.84,39.881],0,[0,0,1]] call InitStruct; 
['ConcretePanel',[3818.71,3752.02,39.987],135,[0,0,1]] call InitStruct; 
['ConcretePanel',[3827.15,3750.1,40.001],60,[0,0,1]] call InitStruct; 
['StationSpeaker',[3817.91,3769.98,46.3402],90.254,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker383203',_thisObj];
}] call InitStruct; 
_3817_070073751_7199740_03460 = ['Decor',[3817.07,3751.72,40.0346],230.897,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
['SignTableKabak',[3818.23,3775.19,43.2843],90,[0,0,1]] call InitStruct; 
['LampWall',[3824.96,3769.69,48.166,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall679564',_thisObj];
}] call InitStruct; 
['LampWall',[3820.1,3769.54,48.1646,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall987857',_thisObj];
}] call InitStruct; 
['RedSteelBox',[3818.48,3752.78,40.0636],55.7872,[0,0,1]] call InitStruct; 
_3825_699953769_9699739_62500 = ['Decor',[3825.7,3769.97,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_159913769_9699739_62400 = ['Decor',[3838.16,3769.97,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['ArmChairBrown',[3819.46,3768.31,40.5473],271.605,[0,0,1]] call InitStruct; 
['SmallRedseatChair',[3823.8,3771.67,40.5672],93.1912,[0,0,1]] call InitItem; 
_3833_389893751_4899940_02840 = ['Decor',[3833.39,3751.49,40.0284],156.373,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_350103748_5400440_01570 = ['Decor',[3819.35,3748.54,40.0157],44.6192,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_500003758_8000540_07150 = ['Decor',[3822.5,3758.8,40.0715],252.593,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_899903745_3501040_06770 = ['Decor',[3825.9,3745.35,40.0677],352.002,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_129883745_9799840_09310 = ['Decor',[3814.13,3745.98,40.0931],323.178,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_379883754_7900440_04250 = ['Decor',[3821.38,3754.79,40.0425],186.778,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_580083759_0700740_05690 = ['Decor',[3814.58,3759.07,40.0569],287.651,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_699953749_6999540_02530 = ['Decor',[3823.7,3749.7,40.0253],137.027,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_370123744_7800340_02440 = ['Decor',[3836.37,3744.78,40.0244],146.822,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3817_070073744_0500540_04630 = ['Decor',[3817.07,3744.05,40.0463],354.643,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_120123758_0000040_02100 = ['Decor',[3830.12,3758,40.021],283.711,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_520023749_3701239_52920 = ['Decor',[3825.52,3749.37,39.5292],62.9684,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_300053767_0600640_18550 = ['Decor',[3826.3,3767.06,40.1855],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_669923773_0000040_56720 = ['Decor',[3839.67,3773,40.5672],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_879883764_5100140_16690 = ['Decor',[3827.88,3764.51,40.1669],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_360113771_1599139_86710 = ['Decor',[3814.36,3771.16,39.8671],30,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\bsg_eft\gryazuchkas1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_330083765_4899939_50960 = ['Decor',[3814.33,3765.49,39.5096],176,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_550053751_4799840_01190 = ['Decor',[3833.55,3751.48,40.0119],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_889893745_6899439_96920 = ['Decor',[3819.89,3745.69,39.9692],40.1232,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3816_840093757_2700240_05080 = ['Decor',[3816.84,3757.27,40.0508],186.024,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstones_erosion.p3d'];}] call InitDecor; // !!! realocated model !!!
_3833_719973759_1001039_60750 = ['Decor',[3833.72,3759.1,39.6075],108.777,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_409913744_8300839_59030 = ['Decor',[3832.41,3744.83,39.5903],165.977,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_280033755_0900939_64610 = ['Decor',[3834.28,3755.09,39.6461],227.534,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_659913759_5000039_91630 = ['Decor',[3836.66,3759.5,39.9163],353.668,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_780033754_1398939_90860 = ['Decor',[3829.78,3754.14,39.9086],196.037,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_949953747_6398939_83900 = ['Decor',[3830.95,3747.64,39.839],84.8674,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_370123775_4099140_11980 = ['Decor',[3810.37,3775.41,40.1198],198.076,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_360113764_8200740_12240 = ['Decor',[3810.36,3764.82,40.1224],101.405,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_729983749_1799339_68170 = ['Decor',[3814.73,3749.18,39.6817],75,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_000003751_1298839_44080 = ['Decor',[3827,3751.13,39.4408],60,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodusss\budkapsinaebana.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_719973770_1899440_33530 = ['Decor',[3829.72,3770.19,40.3353],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\stalker_tun\radarkitchen.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_750003772_7099641_65560 = ['Decor',[3818.75,3772.71,46.6556,true],90,[0,-1,1.19249e-008], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_370123769_9799843_33800 = ['Decor',[3826.37,3769.98,48.338,true],[0.125529,-0.206746,0.970309],[-0.0154873,-0.978334,-0.206452], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_800053771_0900940_86890 = ['Decor',[3827.8,3771.09,40.8689],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_709963768_5900940_56720 = ['Decor',[3818.71,3768.59,40.5672],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_350103772_6101143_38350 = ['Decor',[3826.35,3772.61,48.3835,true],[-0.107147,0.0434603,-0.993293],[0.0056198,-0.999002,-0.0443163], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_469973751_3300839_77150 = ['Decor',[3824.47,3751.33,39.7715],150.694,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_820073747_3300839_39420 = ['Decor',[3828.82,3747.33,39.3942],62.1318,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_649903770_0400442_53670 = ['Decor',[3822.65,3770.04,42.5367],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoxyeta.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_239993753_4599640_00100 = ['Decor',[3825.24,3753.46,40.001],60,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_139893748_4299340_00100 = ['Decor',[3828.14,3748.43,40.001],60,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_199953751_7800340_00110 = ['Decor',[3826.2,3751.78,40.0011],60,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3817_350103750_5900939_98700 = ['Decor',[3817.35,3750.59,39.987],135,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_689943767_1699240_53300 = ['Decor',[3828.69,3767.17,40.533],100.209,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\stolempire.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_179933753_7700240_01680 = ['Decor',[3825.18,3753.77,40.0168],241.84,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stalker_props\zhmikhkrovatz.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_959963747_8400940_03570 = ['Decor',[3827.96,3747.84,40.0357],329.341,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_389893769_8898940_07940 = ['Decor',[3839.39,3769.89,40.0794],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l08_market\l08_market_02_trader_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_060063774_8898940_02400 = ['Decor',[3809.06,3774.89,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_959963766_8798840_02400 = ['Decor',[3810.96,3766.88,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_959963750_8701240_02400 = ['Decor',[3810.96,3750.87,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_060063758_8701240_02400 = ['Decor',[3809.06,3758.87,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_060063750_8798840_02400 = ['Decor',[3809.06,3750.88,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_070073766_8798840_02400 = ['Decor',[3809.07,3766.88,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_020023774_5400440_02300 = ['Decor',[3814.02,3774.54,40.023],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_949953774_8898940_02400 = ['Decor',[3810.95,3774.89,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3830,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3794,68.5811],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3804,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3794,68.4921],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3804,63.0343,true],0,[-0.0782239,0,0.996936]] call InitDecor; 
['BlockDirt',[3830,3804,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3794,68.7916],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3783.84,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3783.84,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3804,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3804,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3783.84,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3783.84,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3793.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3794,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3784,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3804,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3794,36.5],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3784,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3784,69.4913],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3804,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3835_649903776_0300340_53440 = ['Decor',[3835.65,3776.03,40.5344],157.619,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_360113778_1101139_74230 = ['Decor',[3814.36,3778.11,39.7423],191.315,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_enoch\bare_boulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['TorchHolderCharged',[3812.68,3796.28,41.7557,true],267.601,[-0.118491,0,0.992955]] call InitStruct; 
_3809_989993796_3000532_68100 = ['Decor',[3809.99,3796.3,32.681],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_989993791_8000532_68100 = ['Decor',[3809.99,3791.8,32.681],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_000003804_2500037_30680 = ['Decor',[3809,3804.25,37.3068],0.000234788,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_000003807_1298839_05680 = ['Decor',[3809,3807.13,39.0568],0.000234788,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_000003783_6499037_30040 = ['Decor',[3809,3783.65,37.3004],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_000003780_7800339_05040 = ['Decor',[3809,3780.78,39.0504],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_2x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_000003794_0000041_37500 = ['Decor',[3826,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['SignBar',[3817.82,3777.14,42.9191],223.533,[0,0,1], {go_editor_globalRefs set ['Imported SignBar232924',_thisObj];
}] call InitStruct; 
['WoodenChair',[3831.33,3776.12,40.5676],265.466,[0,0,1]] call InitItem; 
['WoodenChair',[3836.21,3776.73,40.5674],66.035,[0,0,1]] call InitItem; 
['WoodenChair',[3832.76,3776.66,40.5819],37.2497,[0,0,1]] call InitItem; 
['WoodenChair',[3834.84,3776.26,40.5673],250.213,[0,0,1]] call InitItem; 
['SmallTrashCan',[3827.1,3776.59,40.5672],349.569,[0,0,1]] call InitStruct; 
_3822_949953794_1298841_88000 = ['Decor',[3822.95,3794.13,41.88],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_020023794_1298841_87160 = ['Decor',[3836.02,3794.13,41.8716],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_969973804_8701251_78680 = ['Decor',[3809.97,3804.87,51.7868],257.046,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_429933785_6499037_61450 = ['Decor',[3830.43,3785.65,37.6145],90.2619,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_709963797_3898936_56560 = ['Decor',[3827.71,3797.39,36.5656],270,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_590093802_6398935_88600 = ['Decor',[3814.59,3802.64,35.886],164.019,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_510013782_6699236_30040 = ['Decor',[3810.51,3782.67,36.3004],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_500003782_6699236_30110 = ['Decor',[3809.5,3782.67,36.3011],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_500003805_2299836_30800 = ['Decor',[3810.5,3805.23,36.308],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_489993804_9399437_77978 = ['Decor',[3810.49,3804.94,42.9129,true],180,[0,-0.515038,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_500003782_9699737_77338 = ['Decor',[3810.5,3782.97,42.9065,true],0.000225105,[0,0.515037,0.857168], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_489993805_2399936_30700 = ['Decor',[3809.49,3805.24,36.307],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_510013780_6398936_30140 = ['Decor',[3810.51,3780.64,36.3014],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_500003780_6499036_30240 = ['Decor',[3809.5,3780.65,36.3024],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_500003780_8999039_01630 = ['Decor',[3810.5,3780.9,44.1493,true],0.000225105,[0,0.515037,0.857168], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_500003807_2600136_30880 = ['Decor',[3810.5,3807.26,36.3088],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_489993807_2600136_30780 = ['Decor',[3809.49,3807.26,36.3078],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_500003778_2099639_74580 = ['Decor',[3810.5,3778.21,39.7458],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_489993807_0100139_02270 = ['Decor',[3810.49,3807.01,44.1557,true],180,[0,-0.515038,0.857167], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_719973796_8601143_00000 = ['Decor',[3826.72,3796.86,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_709963796_8501043_00000 = ['Decor',[3834.71,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_800053791_1201243_00000 = ['Decor',[3818.8,3791.12,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_739993796_8601143_00000 = ['Decor',[3818.74,3796.86,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_780033791_1298843_00000 = ['Decor',[3826.78,3791.13,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_770023791_1298843_00000 = ['Decor',[3834.77,3791.13,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_820073791_1201243_00000 = ['Decor',[3810.82,3791.12,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_760013796_8501043_00000 = ['Decor',[3810.76,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3818_810063789_8000539_99120 = ['Decor',[3818.81,3789.8,39.9912],110.626,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3817_820073776_7700239_96060 = ['Decor',[3817.82,3776.77,39.9606],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_enoch\civilian\garbage\garbagebin_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_909913803_5300339_64127 = ['Decor',[3814.91,3803.53,46.4242,true],90,[-0.104528,0,0.994522], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3815_020023783_8200739_77660 = ['Decor',[3815.02,3783.82,46.5527,true],90,[-0.052336,0,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_360113777_6201240_56720 = ['Decor',[3824.36,3777.62,40.5672],93.152,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_969973777_5300340_56720 = ['Decor',[3820.97,3777.53,40.5672],91.9229,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_020023776_4299340_02300 = ['Decor',[3814.02,3776.43,40.023],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_949953793_6799336_52400 = ['Decor',[3810.95,3793.68,36.524],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_050053787_6599136_52400 = ['Decor',[3809.05,3787.66,36.524],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_050053791_6699236_52400 = ['Decor',[3809.05,3791.67,36.524],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_000003826_2500042_12500 = ['Decor',[3839,3826.25,42.125],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\wip\unfinished_building_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3820,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3834,69.3476],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3814,69.3561],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3834,69.0507],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3824,69.4033],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3824,68.9182],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3814,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3814.28,64.7799],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.09,3813.87,59.9834],359.442,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3824,68.9964],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3824,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3824,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3814,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3826,3814,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3824,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3834,69.2932],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3814,69.4017],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3814,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['SteelGridDoor',[3837.97,3837.08,39.9412],90.0001,[0,0,1]] call InitStruct; 
['SteelGridDoor',[3835.26,3827.15,42.1133],90.0001,[0,0,1]] call InitStruct; 
_3835_290043827_2600142_06660 = ['Decor',[3835.29,3827.26,42.0666],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_010013837_1999539_99000 = ['Decor',[3838.01,3837.2,39.99],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['LongWeaponContainer',[3839.47,3834.12,51.7643,true],90,[0,-1,1.19249e-008]] call InitStruct; 
['LampCeiling',[3837.82,3832.17,48.6202],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling552030',_thisObj];
}] call InitStruct; 
['LampCeiling',[3822.26,3838.08,46.9238],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling182367',_thisObj];
}] call InitStruct; 
['LampCeiling',[3809.86,3836.3,47.283],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling921659',_thisObj];
}] call InitStruct; 
['LampCeiling',[3828.04,3839.31,46.9933],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling289190',_thisObj];
}] call InitStruct; 
['LampCeiling',[3819.46,3838.12,44.2423],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling446759',_thisObj];
}] call InitStruct; 
_3813_189943833_3100642_90500 = ['Decor',[3813.19,3833.31,42.905],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ograda\ograda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3815_590093833_3200742_90500 = ['Decor',[3815.59,3833.32,42.905],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ograda\ograda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3815_580083830_9299342_90500 = ['Decor',[3815.58,3830.93,42.905],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ograda\ograda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_379883829_7500042_90490 = ['Decor',[3814.38,3829.75,42.9049],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ograda\ograda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_199953830_9299342_90500 = ['Decor',[3813.2,3830.93,42.905],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\ograda\ograda.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3829.52,3833.88,40.129],189.556,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp201546',_thisObj];
}] call InitStruct; 
['StreetLamp',[3813.17,3829.46,39.1525],169.421,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp266358',_thisObj];
}] call InitStruct; 
_3835_340093831_3701242_26500 = ['Decor',[3835.34,3831.37,42.265],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_540043819_9199242_28200 = ['Decor',[3838.54,3819.92,42.282],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3837_010013819_9299342_27700 = ['Decor',[3837.01,3819.93,42.277],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3835_370123832_7299842_26000 = ['Decor',[3835.37,3832.73,42.26],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3835_389893821_6999545_65220 = ['Decor',[3835.39,3821.7,45.6522],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3835_419923823_0500545_64720 = ['Decor',[3835.42,3823.05,45.6472],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3837_219973820_8999045_83200 = ['Decor',[3837.22,3820.9,45.832],90,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenDoor',[3839.13,3829.79,45.7197],0,[0,0,1]] call InitStruct; 
['WoodenDoor',[3838.94,3824.76,45.6919],0,[0,0,1]] call InitStruct; 
_3838_189943829_8701247_18596 = ['RedButton',[3838.19,3829.87,52.1869,true],272.553,[0.044526,0.998495,0.032014], {go_editor_globalRefs set ['_armyHosHomeSwitcher',_thisObj];
}] call InitStruct; 
_3809_500003838_0600646_11746 = ['RedButton',[3809.5,3838.06,51.1184,true],272.553,[0.044526,0.998495,0.032014], {go_editor_globalRefs set ['_head2floorswitcher',_thisObj];
}] call InitStruct; 
_3822_229983835_1699241_78386 = ['RedButton',[3822.23,3835.17,46.7848,true],270.597,[0.010419,0.999433,0.0320109], {go_editor_globalRefs set ['_head1floorswitcher',_thisObj];
}] call InitStruct; 
_3822_280033835_1699246_12186 = ['RedButton',[3822.28,3835.17,51.1228,true],268.95,[-0.0183187,0.999319,0.0320142], {go_editor_globalRefs set ['_zvakworkswitcher',_thisObj];
}] call InitStruct; 
_3830_959963836_2199744_55550 = ['Decor',[3830.96,3836.22,44.5555],0,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bed4.p3d'];}] call InitDecor; // !!! realocated model !!!
['SteelDoorThinSmall',[3808.23,3837.93,44.6951],359.429,[0,0,1]] call InitStruct; 
['SteelDoorThinSmall',[3819.31,3838.32,44.7182],90.7538,[0,0,1]] call InitStruct; 
_3813_510013835_4899945_59650 = ['PowerSwitcher',[3813.51,3835.49,45.5965],0,[0,0,1], {go_editor_globalRefs set ['_streetPodiumSwitcher',_thisObj];
}] call InitStruct; 
['SmallChair',[3821.74,3837.56,44.5713],234.101,[0,0,1]] call InitItem; 
['SmallChair',[3821.78,3838.63,44.5713],289.847,[0,0,1]] call InitItem; 
['BoardWoodenBox',[3838.61,3821,45.7091],180,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3835.97,3831.04,42.2677],0,[0,0,1]] call InitStruct; 
['BigClothCabinetNew',[3824.84,3839.31,44.6233],269.555,[0,0,1]] call InitStruct; 
['WoodenWeaponBox',[3839.21,3833.83,42.2467],0,[0,0,1]] call InitStruct; 
['StationSpeaker',[3832.17,3827.19,45.5855],90,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker670983',_thisObj];
}] call InitStruct; 
['StationSpeaker',[3818.93,3834.22,43.4331],0,[0,0,1], {go_editor_globalRefs set ['Imported StationSpeaker154809',_thisObj];
}] call InitStruct; 
_3839_189943829_7800342_28210 = ['SteelGridDoor',[3839.19,3829.78,42.2821],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
['TrashCan',[3817.58,3831.85,40.121],90,[0,0,1]] call InitStruct; 
['LampWall',[3839.83,3826.8,50.3389,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall411526',_thisObj];
}] call InitStruct; 
['LampWall',[3837.73,3822.43,50.3122,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall796411',_thisObj];
}] call InitStruct; 
['LampWall',[3816.4,3837.39,52.1509,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall223124',_thisObj];
}] call InitStruct; 
['LampWall',[3833.62,3827.41,53.8115,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall892404',_thisObj];
}] call InitStruct; 
['LampWall',[3828.47,3839.54,48.8596,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall546236',_thisObj];
}] call InitStruct; 
['LampWall',[3810.9,3839.32,52.1537,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall900861',_thisObj];
}] call InitStruct; 
_3832_750003831_0100139_62400 = ['Decor',[3832.75,3831.01,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_879883830_6298839_62300 = ['Decor',[3814.88,3830.63,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_750003818_7500039_62500 = ['Decor',[3814.75,3818.75,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_750003818_7500039_62300 = ['Decor',[3832.75,3818.75,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['ArmChairBrown',[3825.14,3837.09,44.5579],265.764,[0,0,1]] call InitStruct; 
['ChairLibrary',[3836.87,3832.61,45.7124],0,[0,0,1]] call InitItem; 
['StripedChair',[3827.53,3836.22,44.5487],14.5404,[0,0,1]] call InitItem; 
_3837_959963834_7800340_12410 = ['Decor',[3837.96,3834.78,40.1241],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_520023834_9199244_52650 = ['Decor',[3813.52,3834.92,44.5265],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_520023835_2800344_52700 = ['Decor',[3813.52,3835.28,44.527],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3815_209963835_2800344_52700 = ['Decor',[3815.21,3835.28,44.527],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3815_209963834_8898944_52700 = ['Decor',[3815.21,3834.89,44.527],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\stolb_3m.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallRedseatChair',[3823.12,3837.84,44.5713],105,[0,0,1]] call InitItem; 
_3832_030033835_9199248_83414 = ['Decor',[3832.03,3835.92,53.8739,true],292.869,[-0.218503,0.0549236,0.974289], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_389893838_5300319_49040 = ['Decor',[3809.39,3838.53,19.4904],45.5881,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_729983816_5700748_10540 = ['Decor',[3839.73,3816.57,48.1054],88.2292,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_489993809_7099639_75220 = ['Decor',[3810.49,3809.71,39.7522],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\plita_3x3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_750003834_0800820_09660 = ['Decor',[3839.75,3834.08,20.0966],70.5706,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\fortification\razorwire_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_379883829_9199220_12210 = ['Decor',[3812.38,3829.92,20.1221],56.2567,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_439943824_9899940_11490 = ['Decor',[3813.44,3824.99,40.1149],148.981,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_949953822_0600640_12250 = ['Decor',[3823.95,3822.06,40.1225],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square5_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3808_939943829_8400940_10540 = ['Decor',[3808.94,3829.84,40.1054],180.387,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_510013817_2399940_13000 = ['Decor',[3814.51,3817.24,40.13],24.9839,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_square3_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_189943836_7600148_25000 = ['Decor',[3820.19,3836.76,48.25],332.571,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\military\emplacements\emplacementgun_01_rusty_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3817_459963836_6001048_25000 = ['Decor',[3817.46,3836.6,48.25],334.352,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\military\emplacements\emplacementgun_01_rusty_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_379883836_3999048_25000 = ['Decor',[3814.38,3836.4,48.25],331.373,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\military\emplacements\emplacementgun_01_rusty_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_709963825_7399942_12470 = ['Decor',[3834.71,3825.74,42.1247],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_enoch\civilian\garbage\garbagebin_03_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_379883832_4099142_94400 = ['Decor',[3814.38,3832.41,42.944],0,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_370123831_8000542_94640 = ['Decor',[3814.37,3831.8,42.9464],0.000122943,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\redgates\concrete_slub3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3825_000003833_6298840_37500 = ['Decor',[3825,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_879883833_6298840_37500 = ['Decor',[3827.88,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_129883833_6298840_37500 = ['Decor',[3822.13,3833.63,40.375],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\pot_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3817_530033810_0000040_26200 = ['Decor',[3817.53,3810,40.262],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3837_090093829_8100642_28210 = ['Decor',[3837.09,3829.81,47.2821,true],0.000342362,[-0.001796,0,0.999998], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_000003832_5000040_62500 = ['Decor',[3824,3832.5,40.625],0.000234788,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_560063829_4499540_62500 = ['Decor',[3828.56,3829.45,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_570073824_8400940_62500 = ['Decor',[3828.57,3824.84,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_129883832_5000040_62500 = ['Decor',[3814.13,3832.5,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_580083824_8300840_62500 = ['Decor',[3824.58,3824.83,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3816_620123812_2500040_62500 = ['Decor',[3816.62,3812.25,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_689943826_7199740_61090 = ['Decor',[3820.69,3826.72,40.6109],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_590093829_4599640_62500 = ['Decor',[3824.59,3829.46,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_600103812_2399940_62500 = ['Decor',[3820.6,3812.24,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_739993811_1699240_62500 = ['Decor',[3814.74,3811.17,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3808_129883825_5000040_62500 = ['Decor',[3808.13,3825.5,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3808_129883818_5000040_62500 = ['Decor',[3808.13,3818.5,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_699953828_6001040_62500 = ['Decor',[3820.7,3828.6,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_770023811_1298840_62500 = ['Decor',[3820.77,3811.13,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_879883833_6298840_62500 = ['Decor',[3829.88,3833.63,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_000003832_5000040_62500 = ['Decor',[3829,3832.5,40.625],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_350103833_4299343_16160 = ['Decor',[3814.35,3833.43,43.1616],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\droshke.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_919923839_9099140_12900 = ['Decor',[3834.92,3839.91,40.129],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\walls\concrete\camoconcretewall_01_l_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3823_459963819_2099640_10920 = ['Decor',[3823.46,3819.21,46.8842,true],178.101,[-0.053487,0.0778137,0.995532], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_580083819_1298840_19130 = ['Decor',[3830.58,3819.13,46.9672,true],182.004,[0,0.0509412,0.998702], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3820_850103815_9599639_96840 = ['Decor',[3820.85,3815.96,46.7444,true],90.078,[-0.0646981,0.0348995,0.997294], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3837_120123823_9099142_46120 = ['Decor',[3837.12,3823.91,42.4612],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_090093821_5500542_32660 = ['Decor',[3836.09,3821.55,42.3266],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_429933838_3999040_19720 = ['Decor',[3828.43,3838.4,40.1972],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kovrik\kovernew.p3d'];}] call InitDecor; // !!! realocated model !!!
_3835_790043832_6599145_64270 = ['Decor',[3835.79,3832.66,45.6427],180,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_090093837_6298844_55230 = ['Decor',[3827.09,3837.63,44.5523],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\stul_hospoda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_570073838_0600644_54350 = ['Decor',[3822.57,3838.06,44.5435],272.432,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officetable_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_810063836_3501044_64670 = ['Decor',[3819.81,3836.35,44.6467],1.22674,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_370123830_3701242_90928 = ['Decor',[3814.37,3830.37,45.2601,true],240.801,[-1.26054e-006,-8.74228e-008,-1], {_thisObj setvariable ['model','a3\structures_f\civ\ancient\ancientpillar_damaged_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_939943810_9399440_02400 = ['Decor',[3810.94,3810.94,40.024],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_030033810_9499540_02400 = ['Decor',[3809.03,3810.95,40.024],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_narrow_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3830,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3854,69.0752],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3864,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3854,68.9242],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3844,69.353],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3844,69.4432],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3831.38,3863.13,60],23.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.63,3865.38,50],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3864,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3854,69.0235],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3830.2,3843.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.2,3843.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3844,69.4894],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.2,3843.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3831.38,3863.13,50],23.0003,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3864,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.75,3865.38,60],3.00031,[0,0,1]] call InitDecor; 
['BlockDirt',[3810.63,3865.38,60],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3830,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3820.75,3865.38,50],3.00031,[0,0,1]] call InitDecor; 
['SteelGridDoor',[3831.71,3855.23,40.0179],90.0001,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3814.21,3846.45,40.6607],357.427,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3818.03,3847.99,44.3402],0,[0,0,1]] call InitStruct; 
_3831_729983855_3701240_03440 = ['Decor',[3831.73,3855.37,40.0344],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['OldWoodenBox',[3830.58,3840.12,44.6596],85.3081,[0,0,1]] call InitStruct; 
['LampCeiling',[3815.35,3842.88,44.2718],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling831070',_thisObj];
}] call InitStruct; 
['LampCeiling',[3825.16,3849.86,43.6854],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling840883',_thisObj];
}] call InitStruct; 
['LampCeiling',[3812.84,3849.79,43.7339],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling868711',_thisObj];
}] call InitStruct; 
['StreetLamp',[3832.73,3851.61,39.5417],109.835,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp832727',_thisObj];
}] call InitStruct; 
_3808_139893847_0400444_68210 = ['Decor',[3808.14,3847.04,44.6821],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3809_370123845_0700744_68210 = ['Decor',[3809.37,3845.07,44.6821],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3808_239993845_0800844_68210 = ['Decor',[3808.24,3845.08,44.6821],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_750003845_7500044_68210 = ['Decor',[3810.75,3845.75,44.6821],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3810_379883844_4799840_01300 = ['Decor',[3810.38,3844.48,40.013],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\stalker_tun\radar1_enoch.p3d'];}] call InitDecor; // !!! realocated model !!!
_3813_120123846_5500542_44916 = ['RedButton',[3813.12,3846.55,47.4501,true],270.597,[0.010419,0.999433,0.0320109], {go_editor_globalRefs set ['_headsecretroomswitcher',_thisObj];
}] call InitStruct; 
_3821_320073846_5600641_65196 = ['RedButton',[3821.32,3846.56,46.6529,true],270.597,[0.010419,0.999433,0.0320109], {go_editor_globalRefs set ['_bankLobbySwitcher',_thisObj];
}] call InitStruct; 
_3824_600103841_5000046_10446 = ['RedButton',[3824.6,3841.5,51.1054,true],1.09393,[0.999305,-0.0190795,0.0320177], {go_editor_globalRefs set ['_zvakhomeswitcher',_thisObj];
}] call InitStruct; 
_3825_600103844_3200741_78546 = ['Tumbler',[3825.6,3844.32,46.7854,true],270.001,[0,-0.999991,0.0042758], {go_editor_globalRefs set ['_bankSwitcher',_thisObj];
}] call InitStruct; 
['ContainerGreen3',[3827.53,3851.66,40.1866],240,[0,0,1]] call InitStruct; 
['OfficeCabinet',[3823.57,3842.82,44.6428],0.225995,[0,0,1]] call InitStruct; 
_3824_540043851_1398939_95880 = ['Decor',[3824.54,3851.14,39.9588],90.0001,[0,0,1], {_thisObj setvariable ['model','a3\props_f_exp\commercial\market\woodencounter_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3824_600103849_0400440_09130 = ['Decor',[3824.6,3849.04,40.0913],90,[0,0,1], {_thisObj setvariable ['model','ca\misc2\desk\desk.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_090093843_7800339_62500 = ['Decor',[3829.09,3843.78,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['RattanChair',[3812.61,3848.53,40.9613],180,[0,0,1]] call InitItem; 
['RattanChair',[3810.07,3850.12,40.9613],270,[0,0,1]] call InitItem; 
['RattanChair',[3812.61,3851.68,40.9613],1.36604e-005,[0,0,1]] call InitItem; 
['SteelGreenDoor',[3819.21,3848.14,40.8795],270.367,[0,0,1]] call InitStruct; 
['SteelArmoredDoor',[3827.37,3846.34,40.1611],179.217,[0,0,1]] call InitStruct; 
['HeadThrone',[3815.57,3850.12,40.927],90.0001,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3812.19,3851.95,44.658],85.5568,[0,0,1]] call InitStruct; 
['ChestCabinet',[3828.45,3840.39,40.4751],90.0001,[0,0,1]] call InitStruct; 
['BigFileCabinet',[3827.88,3849.92,40.1442],358.543,[0,0,1]] call InitStruct; 
['KeyHolder',[3826.91,3852.28,41.0291],270,[0,0,1]] call InitStruct; 
_3821_949953850_6699245_07360 = ['ElectricalShieldSmall',[3821.95,3850.67,45.0736],90,[0,0,1], {go_editor_globalRefs set ['_transGolova',_thisObj];
}] call InitStruct; 
_3809_159913843_6398948_34210 = ['Decor',[3809.16,3843.64,48.3421],179.68,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\metalplate.p3d'];}] call InitDecor; // !!! realocated model !!!
['LampWall',[3824.03,3849.83,52.2161,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall416895',_thisObj];
}] call InitStruct; 
['LampWall',[3827.62,3849.83,52.2445,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall270106',_thisObj];
}] call InitStruct; 
['LampWall',[3829.26,3845.14,52.1745,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall935616',_thisObj];
}] call InitStruct; 
['LampWall',[3817.92,3845.13,52.231,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall104879',_thisObj];
}] call InitStruct; 
['LampWall',[3812.21,3849.85,52.2948,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall902053',_thisObj];
}] call InitStruct; 
['LampWall',[3818.93,3850.38,52.4832,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall42730',_thisObj];
}] call InitStruct; 
_3823_080083855_2500039_62300 = ['Decor',[3823.08,3855.25,39.623],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_879883851_6298839_62500 = ['Decor',[3814.88,3851.63,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
['StripedChair',[3825.61,3851.27,40.1944],260.595,[0,0,1]] call InitItem; 
_3826_050053841_9199217_86610 = ['Decor',[3826.05,3841.92,17.8661],82.5002,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_139893851_2399944_68200 = ['Decor',[3826.14,3851.24,44.682],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\pisuar_destr_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_129883850_2199744_68200 = ['Decor',[3826.13,3850.22,44.682],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\pisuar_destr_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_610113852_1799344_68210 = ['Decor',[3827.61,3852.18,44.6821],0,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\pisuar_destr_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3826_129883849_0500544_68200 = ['Decor',[3826.13,3849.05,44.682],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\pisuar_destr_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_360113851_3200739_53270 = ['Decor',[3838.36,3851.32,39.5327],33.5978,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3839_860113850_1699239_50850 = ['Decor',[3839.86,3850.17,39.5085],40.3868,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_780033852_1699239_52510 = ['Decor',[3834.78,3852.17,39.5251],1.58983,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3832_919923852_1899439_52500 = ['Decor',[3832.92,3852.19,39.525],359.945,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3836_649903852_0000039_53940 = ['Decor',[3836.65,3852,39.5394],9.41862,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_570073844_0600640_11190 = ['Decor',[3834.57,3844.06,40.1119],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\training\obstacle_runaround_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3834_840093849_8601140_18510 = ['Decor',[3834.84,3849.86,40.1851],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\training\obstacle_pass_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3838_770023841_8701240_12440 = ['Decor',[3838.77,3841.87,40.1244],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\training\obstacle_crawl_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3830_189943851_9699744_66770 = ['Decor',[3830.19,3851.97,44.6677],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\tolchek.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_250003848_6298840_12390 = ['Decor',[3828.25,3848.63,40.1239],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_189943850_2900440_14520 = ['Decor',[3828.19,3850.29,40.1452],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_419923840_8200745_83590 = ['IStruct',[3812.42,3840.82,45.8359],271.001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\dwerca.p3d'];}] call InitStruct; // !!! realocated model !!!
_3835_530033856_0100139_96400 = ['Decor',[3835.53,3856.01,46.7383,true],18.0266,[0.00183279,-0.0523006,0.99863], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_060063858_5000040_12961 = ['Decor',[3829.06,3858.5,46.8924,true],25.0689,[-0.0035072,0.00972031,0.999947], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3822_510013860_1001040_11907 = ['Decor',[3822.51,3860.1,46.89,true],2.92845,[-0.0367037,-0.0348585,0.998718], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3808_399903860_1999540_13284 = ['Decor',[3808.4,3860.2,46.8944,true],356.002,[-0.0348995,9.69442e-009,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_850103842_5500544_57450 = ['Decor',[3827.85,3842.55,44.5745],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\furniture\vitoriansofa.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_979983850_0300340_18850 = ['Decor',[3819.98,3850.03,40.1885],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_419923851_4799840_17860 = ['Decor',[3821.42,3851.48,40.1786],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epc\civ\accessories\bench_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3821_320073848_6499044_81588 = ['Decor',[3821.32,3848.65,49.9806,true],[0.236435,-0.274546,-0.932053],[0.969689,0.00579695,0.244274], {_thisObj setvariable ['model','a3\structures_f_heli\furniture\officechair_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3827_620123840_4099140_19720 = ['Decor',[3827.62,3840.41,40.1972],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\rug_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3829_239993840_3999040_19720 = ['Decor',[3829.24,3840.4,40.1972],0,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\rug_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3828_429933842_4099140_19720 = ['Decor',[3828.43,3842.41,40.1972],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kovrik\kovernew.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_620123850_6398940_96130 = ['Decor',[3812.62,3850.64,40.9613],90.0001,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
_3811_110113850_1001040_96130 = ['Decor',[3811.11,3850.1,40.9613],0.000179292,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
_3814_129883850_1101140_96130 = ['Decor',[3814.13,3850.11,40.9613],180,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
_3812_620123849_5700740_96130 = ['Decor',[3812.62,3849.57,40.9613],270,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
_3819_899903840_1699244_64910 = ['Decor',[3819.9,3840.17,44.6491],1.22674,[0,0,1], {_thisObj setvariable ['model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3850.2,3703.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.11,3705.39,50],336.445,[0,0,1]] call InitDecor; 
['BlockDirt',[3841.57,3705.66,60],22.7719,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3703.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3703.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3703.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3841.57,3705.66,50],22.7719,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.11,3705.39,60],336.445,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3703.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
_3850_699953710_3400928_37500 = ['Decor',[3850.7,3710.34,28.375],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_040043710_8999039_77590 = ['Decor',[3851.04,3710.9,39.7759],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_270023711_5500539_46950 = ['Decor',[3859.27,3711.55,39.4695],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3840.2,3713.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3723.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3723.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3723.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3733.84,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3733.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3713.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3714,68.8608],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3733.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3744,68.1667],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3724,69.7954],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3744,68.9426],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3724,69.034],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3868.24,3713.68,60],30.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3724,69.6961],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3734,69.1758],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3744,67.3555],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3734,68.7669],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3714,69.1309],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3714,69.1922],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3723.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3733.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3733.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3713.84,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3723.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3723.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3713.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3743.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3743.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3734,69.3619],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3743.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3733.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3733.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3723.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3868.24,3713.68,50],30.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3743.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3743.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3713.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3723.84,30],0.000313335,[0,0,1]] call InitDecor; 
_3850_479983714_1398920_20440 = ['Decor',[3850.48,3714.14,20.2044],56.2509,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_389893715_5100119_19210 = ['Decor',[3848.39,3715.51,19.1921],339.523,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_060063712_1298820_45230 = ['Decor',[3850.06,3712.13,20.4523],80.2895,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_129883715_4299339_19380 = ['Decor',[3861.13,3715.43,39.1938],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_apart.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3855.24,3743.86,37.7178],317.85,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp875451',_thisObj];
}] call InitStruct; 
['TorchHolderCharged',[3848.66,3719.51,39.7904],92.8604,[0,0,1]] call InitStruct; 
_3846_320073713_3400933_75000 = ['Decor',[3846.32,3713.34,33.75],0.000259547,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_320073717_7199717_62500 = ['Decor',[3849.32,3717.72,17.625],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_699953714_7199723_00000 = ['Decor',[3853.7,3714.72,23],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_949953717_2399939_77590 = ['Decor',[3848.95,3717.24,39.7759],90,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_989993712_7700239_77590 = ['Decor',[3848.99,3712.77,39.7759],90,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_030033715_1398939_77590 = ['Decor',[3851.03,3715.14,39.7759],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_620123718_0700740_01170 = ['Decor',[3845.62,3718.07,40.0117],225.852,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_pole.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_540043743_0500540_55800 = ['Decor',[3863.54,3743.05,40.558],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_639893742_9499540_53680 = ['Decor',[3847.64,3742.95,40.5368],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_500003713_8999040_04680 = ['Decor',[3845.5,3713.9,40.0468],90.8471,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_590093743_0100140_55850 = ['Decor',[3855.59,3743.01,40.5585],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_340093731_4299340_06780 = ['Decor',[3854.34,3731.43,40.0678],241.634,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_360113726_7800340_03060 = ['Decor',[3840.36,3726.78,40.0306],255,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_639893737_3701240_09240 = ['Decor',[3855.64,3737.37,40.0924],297.782,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_070073741_0900940_08360 = ['Decor',[3843.07,3741.09,40.0836],274.392,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_889893728_7900440_10000 = ['Decor',[3847.89,3728.79,40.1],287,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_580083734_1799340_10450 = ['Decor',[3859.58,3734.18,40.1045],297,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_750003739_6499040_06920 = ['Decor',[3849.75,3739.65,40.0692],303.712,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_389893722_2500040_09190 = ['Decor',[3849.39,3722.25,40.0919],348.001,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_989993713_4599639_84490 = ['Decor',[3849.99,3713.46,39.8449],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_100103727_0800816_63110 = ['Decor',[3850.1,3727.08,16.6311],101.882,[0,0,1], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_199953731_3400939_98840 = ['Decor',[3857.2,3731.34,39.9884],40.1232,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbage_line_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_290043725_3798839_70160 = ['Decor',[3844.29,3725.38,39.7016],81.5305,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_big_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_399903733_8701250_00760 = ['Decor',[3865.4,3733.87,50.0076],251.001,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3868_159913739_5000042_96455 = ['Decor',[3868.16,3739.5,48.5307,true],322.001,[-0.106907,0.136838,0.984808], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3867_919923739_7600147_17878 = ['Decor',[3867.92,3739.76,52.6709,true],289.001,[-0.0621227,-0.18041,0.981628], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_04_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3869_969973738_1101140_16280 = ['Decor',[3869.97,3738.11,40.1628],266.001,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_879883740_1001039_94740 = ['Decor',[3856.88,3740.1,39.9474],0,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_280033727_8200739_74720 = ['Decor',[3852.28,3727.82,39.7472],207.565,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_300053721_7299839_85290 = ['Decor',[3847.3,3721.73,39.8529],173.776,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f_exp\lavastones\lavastone_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_479983738_3898939_49230 = ['Decor',[3840.48,3738.39,39.4923],340,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_270023736_4099139_54560 = ['Decor',[3842.27,3736.41,39.5456],343,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\blunt\bluntstone_02.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_429933735_8898940_13240 = ['Decor',[3847.43,3735.89,40.1324],27.291,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_679933735_6799340_09100 = ['Decor',[3845.68,3735.68,40.091],208.672,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_989993734_3701241_13830 = ['Decor',[3847.99,3734.37,41.1383],92.448,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_120123731_8898940_11750 = ['Decor',[3846.12,3731.89,40.1175],80.1535,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_209963734_1101140_20460 = ['Decor',[3848.21,3734.11,40.2046],315.028,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_810063732_6001040_13010 = ['Decor',[3847.81,3732.6,40.1301],322.079,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_129883733_9099140_12060 = ['Decor',[3846.13,3733.91,40.1206],6.80965,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_709963735_3200740_11680 = ['Decor',[3849.71,3735.32,40.1168],73.3661,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_159913734_6201240_10930 = ['Decor',[3851.16,3734.62,40.1093],265.29,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_679933735_0100140_85420 = ['Decor',[3847.68,3735.01,40.8542],235.332,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_850103736_6799340_14500 = ['Decor',[3848.85,3736.68,40.145],247.832,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_889893733_2700240_10540 = ['Decor',[3849.89,3733.27,40.1054],66.6246,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_290043734_8200740_79150 = ['Decor',[3849.29,3734.82,40.7915],323.275,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_360113733_2700240_53750 = ['Decor',[3847.36,3733.27,40.5375],28.0618,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\garbage\garbagebags_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_610113721_0300333_57210 = ['Decor',[3862.61,3721.03,33.5721],110.149,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3868_110113721_1899440_08110 = ['Decor',[3868.11,3721.19,40.0811],28,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharprock_spike.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_550053726_8100639_90690 = ['Decor',[3847.55,3726.81,39.9069],319.758,[0,0,1], {_thisObj setvariable ['model','a3\rocks_f\water\w_sharpstone_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_239993717_8300839_62970 = ['Decor',[3845.24,3717.83,44.6297,true],270,[-3.85936e-007,-0.224985,0.974362], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_729983712_9099139_80557 = ['Decor',[3840.73,3712.91,46.5235,true],244.004,[-0.111578,-0.045669,0.992706], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3850.2,3753.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3764,68.0004],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3764,67.0693],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3774,67.7709],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3774,66.0109],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3753.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3764,66.4876,true],0,[0.0647938,0,0.997899]] call InitDecor; 
['BlockDirt',[3870.2,3773.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3763.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3754,66.8479],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3774,68.4664],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3754,67.557],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3753.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3763.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3773.84,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3773.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3763.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3763.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3773.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3753.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3763.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3753.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3773.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3754,67.9214],0,[0,0,1]] call InitDecor; 
_3846_060063770_0700740_09840 = ['ElectricalShield',[3846.06,3770.07,40.0984],90.0002,[0,0,1], {go_editor_globalRefs set ['_transKitchen',_thisObj];
}] call InitStruct; 
['LampCeiling',[3843.62,3769.61,43.3683],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling876140',_thisObj];
}] call InitStruct; 
['LampCeiling',[3841.75,3775.24,43.0799],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling105697',_thisObj];
}] call InitStruct; 
_3852_020023754_7600139_00000 = ['Decor',[3852.02,3754.76,39],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_939943754_9399439_00000 = ['Decor',[3845.94,3754.94,39],271.275,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_439943745_0500539_00000 = ['Decor',[3851.44,3745.05,39],269.133,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_239993747_6899439_00000 = ['Decor',[3840.24,3747.69,39],125.633,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_129883751_8898939_00000 = ['Decor',[3846.13,3751.89,39],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_219973757_7900439_04850 = ['Decor',[3853.22,3757.79,39.0485],88.4247,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_770023758_1699239_00000 = ['Decor',[3841.77,3758.17,39],252.679,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_379883748_6398939_00000 = ['Decor',[3845.38,3748.64,39],270.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_909913748_5300339_00000 = ['Decor',[3851.91,3748.53,39],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_219973757_9599639_00000 = ['Decor',[3847.22,3757.96,39],272.701,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_129883751_8601139_00000 = ['Decor',[3840.13,3751.86,39],273.238,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_370123745_0500539_00000 = ['Decor',[3845.37,3745.05,39],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_070073751_7399939_00000 = ['Decor',[3852.07,3751.74,39],272.571,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['Candle',[3861.53,3748.4,45.8801,true],random 360,[-0.0069996,-0.00102977,0.999975]] call InitItem; 
['SquareWoodenBox',[3844.27,3772.08,41.5428],353.29,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3860.23,3746.07,39.9802],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3860.75,3746.03,40.9369],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3844.28,3772.08,40.5672],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3861.25,3746.04,39.9835],0,[0,0,1]] call InitStruct; 
_3845_280033775_4799840_85930 = ['Decor',[3845.28,3775.48,40.8593],90.1128,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_290043746_2700239_91700 = ['Decor',[3861.29,3746.27,39.917],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\slum_house01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_270023770_3100641_85676 = ['RedButton',[3842.27,3770.31,46.8577,true],0.613112,[0.99943,-0.0106927,0.0320092], {go_editor_globalRefs set ['_kabakBarSwitcher',_thisObj];
}] call InitStruct; 
_3842_959963773_0800841_85926 = ['RedButton',[3842.96,3773.08,46.8602,true],271.717,[0.0299455,0.999038,0.0320279], {go_editor_globalRefs set ['_kabakVIPSwitcher',_thisObj];
}] call InitStruct; 
_3848_979983767_2299841_63849 = ['RedButton',[3848.98,3767.23,46.6385,true],91.2097,[-0.0211087,-0.999766,0.00472869], {go_editor_globalRefs set ['_kabakKitchenSwitcher',_thisObj];
}] call InitStruct; 
_3842_270023769_9499541_86026 = ['RedButton',[3842.27,3769.95,46.8612,true],0.613112,[0.99943,-0.0106927,0.0320092], {go_editor_globalRefs set ['_kabakHallSwitcher',_thisObj];
}] call InitStruct; 
_3843_600103762_0200241_57460 = ['Tumbler',[3843.6,3762.02,41.5746],181.108,[0,0,1], {go_editor_globalRefs set ['_fermSwitcher',_thisObj];
}] call InitStruct; 
['ContainerGreen3',[3852.94,3764.57,41.3104],0,[0,0,1]] call InitStruct; 
_3844_520023768_7600140_56720 = ['Decor',[3844.52,3768.76,40.5672],90.3583,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_439943770_5000040_56720 = ['Decor',[3844.44,3770.5,40.5672],85.0048,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\stelazh.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_850103764_6001040_33330 = ['Decor',[3853.85,3764.6,40.3333],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\stelazh_ot_seregi\stelazh_ot_seregi.p3d'];}] call InitDecor; // !!! realocated model !!!
['SmallStoveGrill',[3852.5,3766.71,40.2014],0,[0,0,1]] call InitStruct; 
['LampKeroseneHolderCharged',[3862.52,3755.46,39.8713],172.04,[0,0,1]] call InitStruct; 
['FabricBagBig2',[3853.77,3762.32,40.2544],273.125,[0,0,1]] call InitItem; 
['FabricBagBig2',[3852.34,3762.32,40.3255],46.3586,[0,0,1]] call InitItem; 
_3840_449953761_5400440_39240 = ['Decor',[3840.45,3761.54,40.3924],105,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_pole.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_350103745_1699240_53060 = ['Decor',[3840.35,3745.17,40.5306],36.1706,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\slums01_8m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_000003751_1298839_86630 = ['Decor',[3864,3751.13,39.8663],0.722314,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_290043752_2600139_86990 = ['Decor',[3860.29,3752.26,39.8699],33.6378,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_830083758_9499539_92250 = ['Decor',[3860.83,3758.95,39.9225],154.538,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_679933759_6398939_93800 = ['Decor',[3864.68,3759.64,39.938],186.209,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_320073761_6699240_39000 = ['Decor',[3847.32,3761.67,40.39],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_459963761_6899440_39000 = ['Decor',[3842.46,3761.69,40.39],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_02_m_2m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_560063754_2800339_93700 = ['Decor',[3858.56,3754.28,39.937],176.167,[0,0,1], {_thisObj setvariable ['model','ml_shabut\tinfence\tinfence.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_770023757_1799339_86750 = ['Decor',[3858.77,3757.18,39.8675],201.044,[0,0,1], {_thisObj setvariable ['model','ml_shabut\tinfence\tinfence.p3d'];}] call InitDecor; // !!! realocated model !!!
['Samovar',[3856.93,3766.73,40.3802],0,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[3843.75,3766.87,40.2677],0,[0,0,1]] call InitStruct; 
['SmallChair',[3861.65,3747.68,39.9645],177.375,[0,0,1]] call InitItem; 
['BoardWoodenBox',[3862.57,3746.33,39.9598],27.6538,[0,0,1]] call InitStruct; 
_3840_800053767_3400940_55840 = ['OldWoodenBox',[3840.8,3767.34,40.5584],270.663,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
_3854_800053764_5800841_31140 = ['OldWoodenBox',[3854.8,3764.58,41.3114],94.1389,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
_3862_719973747_9099140_01560 = ['OldWoodenBox',[3862.72,3747.91,40.0156],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['LobbyChair',[3844.16,3773.75,40.5558],186.048,[0,0,1]] call InitStruct; 
['PipeStove',[3851.05,3766.31,40.3769],0,[0,0,1]] call InitStruct; 
['HoochMachine',[3856.47,3762.3,40.3473],0,[0,0,1]] call InitStruct; 
['StationTea',[3849.42,3764.03,40.7216],0,[0,0,1]] call InitStruct; 
['Grill',[3849.42,3764.62,40.5166],0,[0,0,1]] call InitStruct; 
['FabricBagBig1',[3853.04,3762.34,40.3418],208.915,[0,0,1]] call InitItem; 
['Scales',[3851.2,3764.59,41.1848],91.5429,[0,0,1]] call InitStruct; 
['Umivalnik',[3856.12,3766.75,40.3785],180,[0,0,1]] call InitStruct; 
['LampWall',[3855.42,3764.36,48.538,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall93090',_thisObj];
}] call InitStruct; 
_3856_159913769_9699739_62400 = ['Decor',[3856.16,3769.97,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_899903754_9399452_98933 = ['Decor',[3862.9,3754.94,57.9896,true],[-0.100989,-0.224169,0.969304],[0.994616,0,0.103626], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_350103773_7900440_48140 = ['Decor',[3840.35,3773.79,40.4814],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_449953764_4499540_25000 = ['Decor',[3852.45,3764.45,40.25],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\addons\i_garage_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_729983765_9799840_37500 = ['Decor',[3858.73,3765.98,40.375],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\accessories\water_source_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_659913766_4599640_40600 = ['Decor',[3850.66,3766.46,40.406],13.3599,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\stalker_tun\plita.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_820073767_1001042_75120 = ['Decor',[3851.82,3767.1,42.7512],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\ventel.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_750003770_2299842_68010 = ['Decor',[3841.75,3770.23,42.6801],270.044,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\ventel.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_770023774_5500540_13010 = ['Decor',[3858.77,3774.55,40.1301],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\cargo\cargo20_brick_red_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_879883752_5500540_02650 = ['Decor',[3863.88,3752.55,40.0265],106.584,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\market\cages_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_929933757_4299340_03100 = ['Decor',[3860.93,3757.43,40.031],5.38868,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\market\cages_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_610113755_5600640_00480 = ['Decor',[3863.61,3755.56,40.0048],351.592,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\market\cages_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_989993753_6599140_02830 = ['Decor',[3860.99,3753.66,40.0283],334.933,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\market\cages_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_750003758_4399440_02340 = ['Decor',[3863.75,3758.44,40.0234],149.839,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\civ\market\cages_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_439943766_8200740_51500 = ['Decor',[3840.44,3766.82,40.515],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_560063764_7399940_40600 = ['Decor',[3857.56,3764.74,40.406],0.838935,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\fanerka_vata.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_459963755_7700239_66160 = ['Decor',[3858.46,3755.77,39.6616],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezodozz.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_139893761_8400939_41430 = ['Decor',[3845.14,3761.84,39.4143],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\arka\arka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_189943763_7600139_99130 = ['Decor',[3865.19,3763.76,39.9913],88,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_149903770_9499540_00660 = ['Decor',[3865.15,3770.95,40.0066],92,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_129883775_0500540_52670 = ['Decor',[3842.13,3775.05,40.5267],350.098,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\koverchik.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_250003764_6201240_38460 = ['Decor',[3851.25,3764.62,40.3846],0,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_550053748_2500039_99600 = ['Decor',[3861.55,3748.25,39.996],0,[0,0,1], {_thisObj setvariable ['model','ca\misc2\smalltable\smalltable.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_120123775_3999040_47840 = ['Decor',[3844.12,3775.4,40.4784],270,[0,0,1], {_thisObj setvariable ['model','a3\props_f_orange\furniture\tablebig_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_760013773_4499537_38090 = ['Decor',[3841.76,3773.45,37.3809],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\shtora_pravo.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_080083775_7500037_64460 = ['Decor',[3840.08,3775.75,37.6446],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\shtora_pravo.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_639893773_0600641_64690 = ['Decor',[3843.64,3773.06,41.6469],0,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\decoration\wallboards\picture_a_03\picture_a_03.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_399903764_6201240_19110 = ['Decor',[3849.4,3764.62,40.1911],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\drova\drovasever.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_419923764_0100140_32160 = ['Decor',[3849.42,3764.01,40.3216],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\drova\drova.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_879883764_5400440_78120 = ['Decor',[3854.88,3764.54,40.7812],106.677,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\yashikgrib.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_639893764_5800840_60310 = ['Decor',[3853.64,3764.58,40.6031],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\riba.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_969973766_6699240_38170 = ['Decor',[3854.97,3766.67,40.3817],65.8845,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_24\posyda.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3860,3794,67.5728],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3784,68.7445],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3794,68.3208],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3794,69.4632],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3784,68.9671],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3793.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3804,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3804,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3804,60.2698],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3783.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3783.84,60],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3804,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3793.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3849.36,3806.06,44.6958,true],0,[0,-0.302137,0.953264]] call InitDecor; 
['BlockDirt',[3840,3804,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3783.84,50],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3783.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3793.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3793.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3793.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3803.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3803.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3783.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3783.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['StreetLamp',[3845.96,3783.37,38.2384],88.6766,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp899163',_thisObj];
}] call InitStruct; 
['WoodenDoor',[3854.78,3785.14,40.1305],134.192,[0,0,1]] call InitStruct; 
['WoodenDoor',[3853.75,3780.93,40.1037],223.077,[0,0,1]] call InitStruct; 
_3844_000003794_0000041_37500 = ['Decor',[3844,3794,41.375],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_250003794_0000041_37400 = ['Decor',[3856.25,3794,41.374],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
['ContainerGreen2',[3852.72,3778.33,40.0884],316.019,[0,0,1]] call InitStruct; 
_3852_860113787_1799340_11950 = ['OldWoodenBox',[3852.86,3787.18,40.1195],315.386,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['RedLuxuryChair',[3844.14,3777.19,40.5672],98.2704,[0,0,1]] call InitStruct; 
['LobbyChair',[3842.27,3777.12,40.5672],79.8136,[0,0,1]] call InitStruct; 
_3856_159913781_9699739_62500 = ['Decor',[3856.16,3781.97,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_159913794_1201241_88000 = ['Decor',[3861.16,3794.12,41.88],90.0097,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_280033777_2199740_49880 = ['Decor',[3840.28,3777.22,40.4988],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_540043793_0200241_85520 = ['Decor',[3851.54,3793.02,41.8552],89.3121,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\railways\track_01_switch_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_800053799_7900438_70420 = ['Decor',[3849.8,3799.79,47.0442,true],270,[0,-0.128224,0.991745], {_thisObj setvariable ['model','apalon\metro_a3\surfaces\gryazoookass.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_260013787_7399939_65840 = ['Decor',[3846.26,3787.74,39.6584],349.23,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_550053802_9499543_63800 = ['Decor',[3851.55,3802.95,49.1227,true],353.78,[-0.0437322,-0.226893,0.972937], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_830083789_4099140_87030 = ['Decor',[3858.83,3789.41,40.8703],0.00023308,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\lest_pod_3x4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_370123791_1201243_00000 = ['Decor',[3864.37,3791.12,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_760013791_1298843_00000 = ['Decor',[3842.76,3791.13,43],0.000259547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_750003791_1298843_00000 = ['Decor',[3848.75,3791.13,43],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_d_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_639893796_8501043_00600 = ['Decor',[3860.64,3796.85,43.006],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_639893796_8501043_00000 = ['Decor',[3864.64,3796.85,43],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_709963796_8400943_00950 = ['Decor',[3840.71,3796.84,43.0095],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\net\netfence_01_m_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_780033790_2099640_17150 = ['Decor',[3841.78,3790.21,40.1715],114.818,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka5.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_520023802_6599144_84916 = ['Decor',[3847.52,3802.66,49.9317,true],83.2343,[0.0586443,-0.576351,0.815095], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_030033781_8000540_11080 = ['Decor',[3847.03,3781.8,40.1108],7.53404,[0,0,1], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_340093790_9499540_29096 = ['Decor',[3854.34,3790.95,45.3358,true],88.2274,[-0.0839107,-0.439964,0.894086], {_thisObj setvariable ['model','ml_shabut\nvprops\gryazyuka4.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_979983779_8000539_99770 = ['Decor',[3852.98,3779.8,39.9977],315,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\cargo_house_slum_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_629883785_9699739_99680 = ['Decor',[3853.63,3785.97,39.9968],45,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\households\slum\cargo_house_slum_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_620123782_9699740_13000 = ['Decor',[3860.62,3782.97,40.13],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\ind\cargo\cargo20_brick_red_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_090093778_0600639_87373 = ['Decor',[3865.09,3778.06,46.6407,true],88.1051,[-0.0330542,-0.0534919,0.998021], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_090093785_3798840_00403 = ['Decor',[3865.09,3785.38,46.7768,true],92.0012,[-0.0348995,9.84319e-009,0.999391], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_310063776_8200740_17490 = ['Decor',[3850.31,3776.82,40.1749],43.9833,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\matras_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_270023788_4899940_04580 = ['Decor',[3851.27,3788.49,40.0458],46.6419,[0,0,1], {_thisObj setvariable ['model','ml_shabut\sovokbed\sovokbed.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_739993777_4699740_56720 = ['Decor',[3840.74,3777.47,40.5672],0,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\stul_hospoda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_149903777_8798841_43470 = ['Decor',[3841.15,3777.88,41.4347],180,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\decoration\wallboards\picture_f\picture_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3860.2,3813.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3824,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3817.34,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3834,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3834,69.2722],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3834,69.5796],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3834,69.5079],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3824,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3814,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3867.26,3814.06,60],12.3491,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.43,3810.62,60.1046],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3848.69,3812.58,64.6818],11.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3833.84,50],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3824,69.626],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3817.34,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3834,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3869.32,3824.34,50],14.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3869.32,3824.34,60],14.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3833.84,60],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3813.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3824,69.4379],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3871.67,3838.22,30],337,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3824,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.35,3810.67,50.1046],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3834,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.68,3821.73,30],31,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3824,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3867.67,3817.41,50],184.019,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3824,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3833.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3834,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3814,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3823.84,20],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3813.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.68,3821.73,40],31.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3848.68,3809.56,46.4356],11.369,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.1,3814.23,48.7564],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3871.67,3838.22,40],337,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3823.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850.2,3833.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3846_139893821_7199740_13000 = ['ElectricalShield',[3846.14,3821.72,40.13],90,[0,0,1], {go_editor_globalRefs set ['_transArmy',_thisObj];
}] call InitStruct; 
['SteelGridDoor',[3855.7,3819.91,43.371],92,[0,0,1]] call InitStruct; 
_3855_709963820_0200243_55330 = ['Decor',[3855.71,3820.02,43.5533],2,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\kaleetka.p3d'];}] call InitDecor; // !!! realocated model !!!
['ChairBigCasual',[3844.09,3822.31,42.3273],270,[0,0,1]] call InitItem; 
['ChairBigCasual',[3855.18,3820.75,40.248],157.453,[0,0,1]] call InitItem; 
['LongWeaponContainer',[3842.5,3834.41,48.345,true],270,[0,-1,1.19249e-008]] call InitStruct; 
['LongWeaponContainer',[3840.82,3834.42,48.345,true],270,[0,-1,1.19249e-008]] call InitStruct; 
['LongWeaponContainer',[3841.69,3834.41,48.345,true],270,[0,-1,1.19249e-008]] call InitStruct; 
['LampCeiling',[3840.94,3832.1,45.1016],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling671391',_thisObj];
}] call InitStruct; 
['LampCeiling',[3842.75,3831.67,48.7516],0,[0,0,1], {go_editor_globalRefs set ['Imported LampCeiling47289',_thisObj];
}] call InitStruct; 
_3864_870123833_1001019_80800 = ['Decor',[3864.87,3833.1,19.808],159.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_189943835_6899419_78140 = ['Decor',[3861.19,3835.69,19.7814],270.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_020023828_6799319_44840 = ['Decor',[3858.02,3828.68,19.4484],147.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_189943827_3300819_79540 = ['Decor',[3863.19,3827.33,19.7954],258.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_629883832_6298819_61440 = ['Decor',[3857.63,3832.63,19.6144],200.898,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['StreetLamp',[3845.49,3835.26,39.6036],8.03827,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp974440',_thisObj];
}] call InitStruct; 
['StreetLamp',[3845.7,3824.65,40.13],136.767,[0,0,1], {go_editor_globalRefs set ['Imported StreetLamp261945',_thisObj];
}] call InitStruct; 
_3857_340093831_3999039_94930 = ['Decor',[3857.34,3831.4,39.9493],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_350103829_3200740_02490 = ['Decor',[3857.35,3829.32,40.0249],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_449953829_3501039_91660 = ['Decor',[3861.45,3829.35,39.9166],0.00023308,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_389893831_4499539_98100 = ['Decor',[3861.39,3831.45,39.981],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_969973819_8898943_58690 = ['Decor',[3859.97,3819.89,43.5869],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['SquareWoodenBox',[3844.27,3831.85,42.3372],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3843.19,3830.6,42.345],0,[0,0,1]] call InitStruct; 
['SquareWoodenBox',[3842.02,3830.59,42.3431],0,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3855.3,3836.5,39.6355],119.983,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[3855.54,3828.46,34.4524,true],90.8662,[0.156918,-0.0134963,0.987519]] call InitStruct; 
['TorchHolderCharged',[3855.45,3822.89,45.7269,true],50.0563,[0.278371,0.364948,0.888438]] call InitStruct; 
['TorchHolderCharged',[3863.6,3830.49,39.3767,true],90.8662,[0.156918,-0.0134963,0.987519]] call InitStruct; 
_3844_939943826_4699743_92940 = ['Decor',[3844.94,3826.47,43.9294],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_860113822_9299342_33130 = ['Decor',[3844.86,3822.93,42.3313],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_590093820_0400442_36100 = ['Decor',[3841.59,3820.04,42.361],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_830083821_5700742_32980 = ['Decor',[3844.83,3821.57,42.3298],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_949953826_4699742_75870 = ['Decor',[3844.95,3826.47,42.7587],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_120123820_0300342_36600 = ['Decor',[3843.12,3820.03,42.366],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_840093822_9299345_73400 = ['Decor',[3844.84,3822.93,45.734],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_850103821_3999045_72900 = ['Decor',[3844.85,3821.4,45.729],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_729983834_5700742_22920 = ['Decor',[3842.73,3834.57,42.2292],180,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_199953819_9099145_76250 = ['Decor',[3843.2,3819.91,45.7625],359.959,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_939943832_7800345_77040 = ['Decor',[3844.94,3832.78,45.7704],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_929933827_9899943_93440 = ['Decor',[3844.93,3827.99,43.9344],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_679933819_9199245_75750 = ['Decor',[3841.68,3819.92,45.7575],359.959,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_949953831_2500045_76540 = ['Decor',[3844.95,3831.25,45.7654],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_139893824_6699242_29380 = ['Decor',[3843.14,3824.67,42.2938],359.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_939943827_9899942_76370 = ['Decor',[3844.94,3827.99,42.7637],269.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_610113824_6599142_28880 = ['Decor',[3841.61,3824.66,42.2888],359.393,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\kr_stena_m.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_530033820_8000545_79600 = ['Decor',[3843.53,3820.8,45.796],90,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_689943823_8100645_70600 = ['Decor',[3843.69,3823.81,45.706],90,[0,0,1], {_thisObj setvariable ['model','ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_590093823_6899428_54310 = ['Decor',[3859.59,3823.69,28.5431],90.0003,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_629883837_7299823_23860 = ['Decor',[3862.63,3837.73,23.2386],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_469973823_9099117_89080 = ['Decor',[3859.47,3823.91,17.8908],90.0003,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_830083837_5700733_89090 = ['Decor',[3862.83,3837.57,33.8909],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_209963820_7299837_72420 = ['Decor',[3850.21,3820.73,37.7242],93.1967,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3840_209963834_1599144_08586 = ['RedButton',[3840.21,3834.16,49.0868,true],91.9034,[-0.0331948,-0.998936,0.0320208], {go_editor_globalRefs set ['_armyWeaponsDepotSwitcher',_thisObj];
}] call InitStruct; 
_3840_169923829_4599647_31526 = ['RedButton',[3840.17,3829.46,52.3162,true],89.706,[0.00513152,-0.999473,0.032038], {go_editor_globalRefs set ['_army2stfloor',_thisObj];
}] call InitStruct; 
_3840_129883824_9899943_91056 = ['RedButton',[3840.13,3824.99,48.9115,true],269.54,[-0.00803532,0.999455,0.0320274], {go_editor_globalRefs set ['_army1stfloor',_thisObj];
}] call InitStruct; 
_3855_489993816_5700745_20300 = ['Tumbler',[3855.49,3816.57,45.203],87.6792,[0,0,1], {go_editor_globalRefs set ['_armynicecageswitcher',_thisObj];
}] call InitStruct; 
_3853_649903817_8601141_72070 = ['Tumbler',[3853.65,3817.86,41.7207],90,[0,0,1], {go_editor_globalRefs set ['_armyInterrogationSwitcher',_thisObj];
}] call InitStruct; 
_3844_149903833_0000045_85500 = ['Decor',[3844.15,3833,45.855],0,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\interier\bed4.p3d'];}] call InitDecor; // !!! realocated model !!!
['ContainerGreen3',[3840.73,3830.6,42.2575],0,[0,0,1]] call InitStruct; 
['OfficeCabinet',[3843.87,3820.41,42.3825],180,[0,0,1]] call InitStruct; 
['BarChair',[3854.34,3820.13,40.2722],28.647,[0,0,1]] call InitItem; 
_3846_169923837_0000039_62300 = ['Decor',[3846.17,3837,39.623],90,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x6.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_679933828_6001039_98000 = ['Decor',[3862.68,3828.6,39.98],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_679933832_1001040_00200 = ['Decor',[3862.68,3832.1,40.002],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_679933834_1999540_00800 = ['Decor',[3862.68,3834.2,40.008],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_290043826_5400440_03070 = ['Decor',[3862.29,3826.54,40.0307],270,[0,0,1], {_thisObj setvariable ['model','metro_ob\model\sartir_kabinka.p3d'];}] call InitDecor; // !!! realocated model !!!
['WoodenChair',[3859.03,3819.91,43.583],267.794,[0,0,1]] call InitItem; 
['WoodenChair',[3859.95,3820.89,43.5959],0,[0,0,1]] call InitItem; 
['WoodenChair',[3860.76,3819.86,43.5903],107.455,[0,0,1]] call InitItem; 
['WoodenChair',[3859.79,3818.89,43.6067],198.816,[0,0,1]] call InitItem; 
_3861_820073830_3798840_01520 = ['Decor',[3861.82,3830.38,40.0152],179.319,[0,0,1], {_thisObj setvariable ['model','ml_shabut\tinfence\tinfence.p3d'];}] call InitDecor; // !!! realocated model !!!
['BoardWoodenBox',[3841.87,3830.43,45.7677],90,[0,0,1]] call InitStruct; 
['ContainerGreen2',[3841.63,3820.92,45.7563],270,[0,0,1]] call InitStruct; 
_3841_729983823_8701245_80380 = ['OldWoodenBox',[3841.73,3823.87,45.8038],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exodus\boxuzk.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGreenCabinet',[3857.38,3820.84,40.2938],95.1651,[0,0,1]] call InitStruct; 
['SteelGreenCabinet',[3841.03,3833.86,45.766],90,[0,0,1]] call InitStruct; 
['ChairCasual',[3841.04,3821.57,42.3849],0,[0,0,1]] call InitItem; 
['ChairCasual',[3841.19,3822.99,42.3849],30,[0,0,1]] call InitItem; 
_3857_899903816_6101143_65460 = ['Decor',[3857.9,3816.61,43.6546],270.935,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_310063821_6599143_65990 = ['Decor',[3857.31,3821.66,43.6599],270.935,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_929933816_9399443_61600 = ['Decor',[3860.93,3816.94,43.616],89.5807,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\decor\bed_original1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_199953827_5400423_61150 = ['SteelGridDoor',[3863.2,3827.54,23.6115],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3859_159913827_5900928_90940 = ['SteelGridDoor',[3859.16,3827.59,28.9094],90.0001,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3845_080083833_3000542_28240 = ['SteelGridDoor',[3845.08,3833.3,42.2824],269.874,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3863_260013827_5400434_27730 = ['SteelGridDoor',[3863.26,3827.54,34.2773],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3863_270023833_4299334_27920 = ['SteelGridDoor',[3863.27,3833.43,34.2792],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3863_209963833_4399423_61340 = ['SteelGridDoor',[3863.21,3833.44,23.6134],270,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
_3859_169923833_4799828_90750 = ['SteelGridDoor',[3859.17,3833.48,28.9075],90.0001,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
['LampWall',[3842.83,3822.31,50.3973,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall279384',_thisObj];
}] call InitStruct; 
['LampWall',[3857.76,3819.53,48.0983,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall622259',_thisObj];
}] call InitStruct; 
['LampWall',[3858.71,3818.92,51.614,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall68308',_thisObj];
}] call InitStruct; 
['LampWall',[3840.17,3822.44,53.7365,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall394942',_thisObj];
}] call InitStruct; 
['LampWall',[3840.12,3827.14,53.8245,true],180,[1,0,1.19249e-008], {go_editor_globalRefs set ['Imported LampWall172065',_thisObj];
}] call InitStruct; 
_3846_169923825_0600639_62500 = ['Decor',[3846.17,3825.06,39.625],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_699953813_4799839_62400 = ['Decor',[3854.7,3813.48,39.624],0,[0,0,1], {_thisObj setvariable ['model','csa_constr\csa_obj\pod_18x18.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_080083835_5700734_21220 = ['Decor',[3860.08,3835.57,34.2122],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_219973826_1298823_54590 = ['Decor',[3863.22,3826.13,23.5459],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_310063828_1298823_56780 = ['Decor',[3859.31,3828.13,23.5678],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_370123828_1201234_23360 = ['Decor',[3859.37,3828.12,34.2336],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_310063832_0200234_21360 = ['Decor',[3863.31,3832.02,34.2136],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_280033826_1298834_21170 = ['Decor',[3863.28,3826.13,34.2117],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_310063834_8601123_55850 = ['Decor',[3859.31,3834.86,23.5585],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_149903834_8898928_84190 = ['Decor',[3859.15,3834.89,28.8419],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_260013834_8601134_22070 = ['Decor',[3863.26,3834.86,34.2207],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_060063832_8999028_86380 = ['Decor',[3863.06,3832.9,28.8638],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_169923826_1599128_85090 = ['Decor',[3859.17,3826.16,28.8509],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_370123835_6001028_85180 = ['Decor',[3862.37,3835.6,28.8518],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_010013832_1599123_55770 = ['Decor',[3860.01,3832.16,23.5577],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_149903832_0600628_84900 = ['Decor',[3859.15,3832.06,28.849],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_370123834_8501034_22420 = ['Decor',[3859.37,3834.85,34.2242],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_060063825_4199234_22160 = ['Decor',[3860.06,3825.42,34.2216],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_360113832_1899428_86070 = ['Decor',[3862.36,3832.19,28.8607],1.8783e-005,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_070073832_1599134_22350 = ['Decor',[3860.07,3832.16,34.2235],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_219973828_9699723_55300 = ['Decor',[3863.22,3828.97,23.553],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_010013828_8400923_56470 = ['Decor',[3860.01,3828.84,23.5647],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_350103825_4499528_84240 = ['Decor',[3862.35,3825.45,28.8424],1.8783e-005,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_120123829_0000028_84390 = ['Decor',[3859.12,3829,28.8439],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_070073828_8300834_23050 = ['Decor',[3860.07,3828.83,34.2305],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_000003825_4299323_55580 = ['Decor',[3860,3825.43,23.5558],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_020023835_5700723_54640 = ['Decor',[3860.02,3835.57,23.5464],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_060063826_1699228_85450 = ['Decor',[3863.06,3826.17,28.8545],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_360113828_8601128_85370 = ['Decor',[3862.36,3828.86,28.8537],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_250003832_0300323_54790 = ['Decor',[3863.25,3832.03,23.5479],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_280033828_9599634_21880 = ['Decor',[3863.28,3828.96,34.2188],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_199953834_8601123_55490 = ['Decor',[3863.2,3834.86,23.5549],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_399903818_7800343_43400 = ['Decor',[3858.4,3818.78,43.434],92,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_270023818_8400946_85620 = ['Decor',[3858.27,3818.84,46.8562],92,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_419923831_4599628_94270 = ['Decor',[3857.42,3831.46,28.9427],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_330083833_8798834_25740 = ['Decor',[3856.33,3833.88,34.2574],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3866_110113833_8798828_88570 = ['Decor',[3866.11,3833.88,28.8857],9.90377e-005,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3866_100103827_1398928_88760 = ['Decor',[3866.1,3827.14,28.8876],9.90377e-005,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_820073822_4299345_20640 = ['Decor',[3862.82,3822.43,50.2064,true],[0.0147901,-0.000566675,-0.99989],[0.0382834,0.999267,-4.36793e-008], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_320073827_1398934_25550 = ['Decor',[3856.32,3827.14,34.2555],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_820073827_6699240_04700 = ['Decor',[3860.82,3827.67,40.047],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_409913833_0700740_04700 = ['Decor',[3860.41,3833.07,40.047],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_959963830_0000023_61020 = ['Decor',[3864.96,3830,23.6102],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3865_010013829_7800334_26250 = ['Decor',[3865.01,3829.78,34.2625],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_129883820_7900443_71190 = ['Decor',[3862.13,3820.79,43.7119],276.368,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_05_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_770023809_4299345_92632 = ['Decor',[3851.77,3809.43,51.2721,true],195.887,[0.0207327,-0.0129647,0.999701], {_thisObj setvariable ['model','ml_shabut\nvprops\nv_gryaz3.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_679933815_5300340_12900 = ['Decor',[3846.68,3815.53,40.129],191.618,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_840093816_5200240_13000 = ['Decor',[3845.84,3816.52,40.13],272.333,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_969973814_7099640_12900 = ['Decor',[3849.97,3814.71,40.129],12.7813,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_429933817_2299840_13000 = ['Decor',[3849.43,3817.23,40.13],280.528,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_129883815_6201240_13000 = ['Decor',[3849.13,3815.62,40.13],280.528,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_179933815_2399940_12900 = ['Decor',[3848.18,3815.24,40.129],191.618,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_330083839_9399439_74520 = ['Decor',[3848.33,3839.94,39.7452],0.000122943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_850103816_6001040_13000 = ['Decor',[3852.85,3816.6,40.13],276.72,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_679933815_3400940_13000 = ['Decor',[3852.68,3815.34,40.13],276.72,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_629883814_5600640_12900 = ['Decor',[3851.63,3814.56,40.129],2.05042,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_610113818_0700740_13000 = ['Decor',[3845.61,3818.07,40.13],248.073,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_870123839_9699739_75030 = ['Decor',[3852.87,3839.97,39.7503],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_610113839_0400439_79800 = ['Decor',[3856.61,3839.04,39.798],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_459963839_0900939_76410 = ['Decor',[3862.46,3839.09,39.7641],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_570073839_0400439_72860 = ['Decor',[3859.57,3839.04,39.7286],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_620123839_9199239_86430 = ['Decor',[3849.62,3839.92,39.8643],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_end_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3864_260013839_1298839_75970 = ['Decor',[3864.26,3839.13,39.7597],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_end_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3854_870123839_7099639_78940 = ['Decor',[3854.87,3839.71,39.7894],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_corner_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_719973834_6398920_09190 = ['Decor',[3844.72,3834.64,20.0919],130.475,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\fortification\razorwire_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_800053833_6298820_02020 = ['Decor',[3850.8,3833.63,20.0202],60.1431,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\fortification\razorwire_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3845_290043809_7500046_76828 = ['Decor',[3845.29,3809.75,52.644,true],89.9654,[0.158348,-0.0365258,0.986708], {_thisObj setvariable ['model','a3\structures_f\walls\rampart_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_810063839_7700239_53200 = ['Decor',[3841.81,3839.77,39.532],1.003,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_439943839_8200739_53180 = ['Decor',[3846.44,3839.82,39.5318],178.474,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_810063819_4499540_13000 = ['Decor',[3856.81,3819.45,40.13],92.3857,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelxata_2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_979983833_4699723_47990 = ['Decor',[3860.98,3833.47,23.4799],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\concrete_slub.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_959963827_5600623_49690 = ['Decor',[3860.96,3827.56,23.4969],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\concrete_slub.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_959963826_3300823_49580 = ['Decor',[3860.96,3826.33,23.4958],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\concrete_slub.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_979983834_6999523_48100 = ['Decor',[3860.98,3834.7,23.481],90,[0,0,1], {_thisObj setvariable ['model','ml_shabut\exoduss\concrete_slub.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_639893834_6101140_13000 = ['Decor',[3851.64,3834.61,40.13],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\flags\mast_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_340093816_1999540_08980 = ['Decor',[3847.34,3816.2,40.0898],193.418,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\decor\chr_body_corpse_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_909913815_3000540_07730 = ['Decor',[3850.91,3815.3,40.0773],189.971,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\decor\chr_body_corpse_1.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_810063828_8798823_69540 = ['Decor',[3861.81,3828.88,23.6954],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_320073826_7600123_69130 = ['Decor',[3859.32,3826.76,23.6913],90.0001,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_330083833_5000023_49500 = ['Decor',[3859.33,3833.5,23.495],90,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_840093832_1699223_69100 = ['Decor',[3861.84,3832.17,23.691],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_889893825_4299334_35490 = ['Decor',[3861.89,3825.43,34.3549],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_389893833_4899934_35900 = ['Decor',[3859.39,3833.49,34.359],90.0001,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_379883826_7600134_35710 = ['Decor',[3859.38,3826.76,34.3571],90.0001,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_820073825_4399423_68910 = ['Decor',[3861.82,3825.44,23.6891],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_540043835_5900928_98510 = ['Decor',[3860.54,3835.59,28.9851],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_899903832_1699234_35680 = ['Decor',[3861.9,3832.17,34.3568],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_050053834_2600128_98730 = ['Decor',[3863.05,3834.26,28.9873],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_879883835_6101134_36310 = ['Decor',[3861.88,3835.61,34.3631],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_560063832_1398928_99140 = ['Decor',[3860.56,3832.14,28.9914],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_870123828_8701234_36120 = ['Decor',[3861.87,3828.87,34.3612],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3861_820073835_6201223_69730 = ['Decor',[3861.82,3835.62,23.6973],0.000122943,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_550053825_4099128_99330 = ['Decor',[3860.55,3825.41,28.9933],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_530033828_8501028_98700 = ['Decor',[3860.53,3828.85,28.987],180,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_040043827_5300328_98920 = ['Decor',[3863.04,3827.53,28.9892],270,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_000003830_7600140_62500 = ['Decor',[3852,3830.76,40.625],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3847_899903834_6599140_62500 = ['Decor',[3847.9,3834.66,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3848_120123824_6599140_62500 = ['Decor',[3848.12,3824.66,40.625],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\infrastructure\pavements\concretekerb_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_270023837_5700739_81030 = ['Decor',[3857.27,3837.57,44.8103,true],90,[0.121869,1.46045e-007,0.992546], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_429933837_5700740_03010 = ['Decor',[3853.43,3837.57,40.0301],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_250003830_3798840_02460 = ['Decor',[3857.25,3830.38,40.0246],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_649903830_3798839_96720 = ['Decor',[3863.65,3830.38,39.9672],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_500003830_3798840_00700 = ['Decor',[3858.5,3830.38,40.007],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_379883830_5000033_91902 = ['Decor',[3863.38,3830.5,38.9121,true],90.0001,[-2.14576e-006,-1,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_379883830_5000037_91902 = ['Decor',[3863.38,3830.5,42.9121,true],90.0001,[-2.14576e-006,-1,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_439943816_5300347_08377 = ['Decor',[3855.44,3816.53,50.3183,true],267.063,[0,0.0156898,-0.999877], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_379883830_5000027_90603 = ['Decor',[3863.38,3830.5,32.9,true],90.0001,[-2.14576e-006,-1,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_379883830_5000019_90604 = ['Decor',[3863.38,3830.5,24.9,true],90.0001,[-2.14576e-006,-1,1.19249e-008], {_thisObj setvariable ['model','a3\structures_f\walls\concrete_smallwall_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_449953819_8100640_28410 = ['Decor',[3859.45,3819.81,40.2841],110.152,[0,0,1], {_thisObj setvariable ['model','relicta_models\models\nocategory\wheelchair2.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_659913822_3400942_38490 = ['Decor',[3842.66,3822.34,42.3849],180,[0,0,1], {_thisObj setvariable ['model','ca\buildings\furniture\dhangar_psacistul.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3840,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3844,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3849.2,3856.34,60],16.001,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3854,69.644],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3844,69.6456],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.32,3853.34,60],26.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3844,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.38,3859.5,60],24,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.38,3859.5,50],24,[0,0,1]] call InitDecor; 
['BlockDirt',[3840,3854,70],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3867.57,3844.47,60],330,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3844,69.3291],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3867.57,3844.47,50],330,[0,0,1]] call InitDecor; 
['BlockDirt',[3860,3844,30],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3844,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3843.84,30],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3840.2,3853.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3870.2,3843.84,40],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3843.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3849.2,3856.34,50],16.001,[0,0,1]] call InitDecor; 
['BlockDirt',[3858.32,3853.34,50],26.0001,[0,0,1]] call InitDecor; 
['BlockDirt',[3860.2,3853.84,40],0.000313335,[0,0,1]] call InitDecor; 
['BlockDirt',[3850,3854,40],6.83019e-005,[0,0,1]] call InitDecor; 
_3855_209963848_4099139_78460 = ['Decor',[3855.21,3848.41,39.7846],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_389893847_3701239_87710 = ['Decor',[3852.39,3847.37,39.8771],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3862_250003841_9299339_87620 = ['Decor',[3862.25,3841.93,39.8762],0.000122943,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3844_649903852_3100639_90310 = ['Decor',[3844.65,3852.31,39.9031],313.397,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3842_250003849_3501039_88830 = ['Decor',[3842.25,3849.35,39.8883],307.234,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_short_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_199953846_0500539_77300 = ['Decor',[3855.2,3846.05,39.773],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3855_199953843_1699239_80820 = ['Decor',[3855.2,3843.17,39.8082],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3850_770023841_8400939_91230 = ['Decor',[3850.77,3841.84,39.9123],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_489993843_3601139_88310 = ['Decor',[3849.49,3843.36,39.8831],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_649903841_8601139_91200 = ['Decor',[3853.65,3841.86,39.912],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_959963841_8898939_92370 = ['Decor',[3856.96,3841.89,39.9237],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_469973846_2299839_89430 = ['Decor',[3849.47,3846.23,39.8943],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3859_919923841_9199239_88540 = ['Decor',[3859.92,3841.92,39.8854],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_long_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_469973847_8601139_86390 = ['Decor',[3849.47,3847.86,39.8639],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_end_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3851_270023847_3701239_92450 = ['Decor',[3851.27,3847.37,39.9245],180,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_end_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3853_350103847_3701239_91770 = ['Decor',[3853.35,3847.37,39.9177],0.000287722,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\mil\bagfence\bagfence_end_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3856_229983847_1899439_97200 = ['Decor',[3856.23,3847.19,39.972],6.121,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\sex_toy.p3d'];}] call InitDecor; // !!! realocated model !!!
_3858_800053845_9699739_98610 = ['Decor',[3858.8,3845.97,39.9861],359.492,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\sex_toy.p3d'];}] call InitDecor; // !!! realocated model !!!
_3860_020023845_6899439_99590 = ['Decor',[3860.02,3845.69,39.9959],356.62,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\sex_toy.p3d'];}] call InitDecor; // !!! realocated model !!!
_3857_500003846_6101139_98320 = ['Decor',[3857.5,3846.61,39.9832],6.12068,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\shabbat\sex_toy.p3d'];}] call InitDecor; // !!! realocated model !!!
_3843_469973847_2199739_51040 = ['Decor',[3843.47,3847.22,39.5104],39.3317,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3846_770023844_0600639_50270 = ['Decor',[3846.77,3844.06,39.5027],63.3547,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\walls\cncbarriermedium_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3841_649903846_4199239_95900 = ['Decor',[3841.65,3846.42,39.959],129.264,[0,0,1], {_thisObj setvariable ['model','a3\structures_f\training\obstacle_bridge_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3852_419923850_0200239_92878 = ['Decor',[3852.42,3850.02,46.7102,true],3.01553,[-0.00182643,-0.0869298,0.996213], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3849_270023850_9599639_94759 = ['Decor',[3849.27,3850.96,46.719,true],13.0072,[0.00633552,-0.0354574,0.999351], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3863_899903840_7099639_85358 = ['Decor',[3863.9,3840.71,46.6272,true],55.1242,[-0.0267649,-0.0722547,0.997027], {_thisObj setvariable ['model','a3\structures_f\walls\cncwall1_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[3873.19,3734.24,49.6952],6.83019e-005,[0,0,1]] call InitDecor; 
['BlockDirt',[3872.22,3830.84,40],0,[0,0,1]] call InitDecor; 
['BlockDirt',[3872.39,3830.29,30],0,[0,0,1]] call InitDecor; 
_3930_169923885_810060_00000 = ['Decor',[3930.17,3885.81,0],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3934_659913879_010015_33221 = ['Decor',[3934.66,3879.01,5.33221],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3934_659913880_629885_33221 = ['Decor',[3934.66,3880.63,5.33221],90,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3935_340093890_3000515_98870 = ['Decor',[3935.34,3890.3,15.9887],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3930_159913885_8000521_31960 = ['Decor',[3930.16,3885.8,21.3196],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3928_550053885_8000521_31960 = ['Decor',[3928.55,3885.8,21.3196],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3935_340093891_9099115_98870 = ['Decor',[3935.34,3891.91,15.9887],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3934_659913880_6201226_65180 = ['Decor',[3934.66,3880.62,26.6518],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3934_659913879_0000026_65180 = ['Decor',[3934.66,3879,26.6518],90.0001,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3928_560063885_810060_00000 = ['Decor',[3928.56,3885.81,0],180,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3935_340093890_2800337_30830 = ['Decor',[3935.34,3890.28,37.3083],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3935_340093891_8999037_30830 = ['Decor',[3935.34,3891.9,37.3083],270,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
['Decor',[3946.33,3757.91,0],0,[0,0,1]] call InitDecor; // Effect
['WoodenDoor',[3952,3795.59,-0.0527406],0,[0,0,1]] call InitStruct; 
['SteelWindowDoor',[3960.17,3803.57,0],0,[0,0,1]] call InitStruct; 
_3943_610113796_07007_0_05232 = ['SteelGridDoor',[3943.61,3796.07,-0.052319],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\kapeze\reshetow.p3d'];}] call InitStruct; // !!! realocated model !!!
['SteelGridDoor',[3964.74,3813.93,0],0.000122943,[0,0,1]] call InitStruct; 
['SteelBrownDoor',[3963.35,3818.29,0.00845051],0,[0,0,1]] call InitStruct; 
['SteelDoorThinSmall',[3964.85,3816.76,0],0,[0,0,1]] call InitStruct; 
['SteelGreenDoor',[3964.99,3820.03,0],0,[0,0,1]] call InitStruct; 
_3961_709963893_459960_00000 = ['Decor',[3961.71,3893.46,0],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3939_830083885_1001031_97610 = ['Decor',[3939.83,3885.1,31.9761],4.26887e-005,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3939_840093885_1101110_65650 = ['Decor',[3939.84,3885.11,10.6565],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3941_439943885_1001031_97610 = ['Decor',[3941.44,3885.1,31.9761],7.59859e-005,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
_3941_449953885_1101110_65650 = ['Decor',[3941.45,3885.11,10.6565],4.26887e-005,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'];}] call InitDecor; // !!! realocated model !!!
['GreenBed',[3975.71,3676.46,0],0,[0,0,1]] call InitStruct; 
_3981_820073683_100100_00000 = ['Decor',[3981.82,3683.1,0],0,[0,0,1], {_thisObj setvariable ['model','ml_shabut\eft\matrassych.p3d'];}] call InitDecor; // !!! realocated model !!!
_3977_000003683_840090_00000 = ['Decor',[3977,3683.84,0],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\decor\bed_original1.p3d'];}] call InitDecor; // !!! realocated model !!!
['SofaBrown',[3985.95,3735.42,0],0,[0,0,1]] call InitStruct; 
['ChairLibrary',[3984.86,3736.38,0],0,[0,0,1]] call InitItem; 
['BrownLeatherChair',[3982.58,3738.04,0],0,[0,0,1]] call InitStruct; 
['SmallRedseatChair',[3986.11,3736.35,0],0,[0,0,1]] call InitItem; 
_3992_639893728_179930_00000 = ['Decor',[3992.64,3728.18,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\bench_05_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3981_310063756_169920_00000 = ['Decor',[3981.31,3756.17,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_3987_739993802_760010_50492 = ['Decor',[3987.74,3802.76,0.504925],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\model_05\zabori.p3d'];}] call InitDecor; // !!! realocated model !!!
_3998_600103867_790040_69895 = ['Decor',[3998.6,3867.79,0.698952],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'];}] call InitDecor; // !!! realocated model !!!
_3984_760013876_649900_03518 = ['Decor',[3984.76,3876.65,0.035183],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\zhelezoplatforma2.p3d'];}] call InitDecor; // !!! realocated model !!!
['ContainerGreen',[4013.18,3715.06,0],0,[0,0,1]] call InitStruct; 
['FabricBagBig2',[4003.09,3712.27,0],0,[0,0,1]] call InitItem; 
['BoardWoodenBox',[4012.67,3716.71,0],0,[0,0,1]] call InitStruct; 
['BigFileCabinet',[4003.81,3743.66,0],0,[0,0,1]] call InitStruct; 
['ClothCabinet',[4004.87,3731.25,1.24387],180,[0,0,1]] call InitStruct; 
['FabricBagBig1',[4003.17,3713.24,0],0,[0,0,1]] call InitItem; 
['BigClothCabinet',[4005.77,3731.26,0],0,[0,0,1]] call InitStruct; 
['TorchHolderCharged',[4008.64,3782.21,0],0,[0,0,1]] call InitStruct; 
_4010_229983792_370120_00000 = ['GreenBed',[4010.23,3792.37,0],90,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\walls\backalleys\backalley_02_l_1m_f.p3d'];}] call InitStruct; // !!! realocated model !!!
_4027_899903823_600100_00000 = ['Decor',[4027.9,3823.6,0],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_4023_550053822_689940_00000 = ['Decor',[4023.55,3822.69,0],0,[0,0,1], {_thisObj setvariable ['model','ml_exodusnew\ganzazhelezo3.p3d'];}] call InitDecor; // !!! realocated model !!!
_4003_040043862_379880_00000 = ['Decor',[4003.04,3862.38,0],270,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['BlockDirt',[4050.63,3946.23,11],0,[0,0,1]] call InitDecor; 
['StationSpeaker',[4113.46,3622.55,5],0,[0,0,1]] call InitStruct; 
['StreetLamp',[4115.75,3670.71,0],0,[0,0,1]] call InitStruct; 
['ElectricalShield',[4116.74,3707.95,0],0,[0,0,1]] call InitStruct; 
['ChemDistiller',[4099.28,3701.36,0],0,[0,0,1]] call InitItem; 
['PowerSwitcherBig',[4105.05,3697.39,0.743088],0,[0,0,1]] call InitStruct; 
['Intercom',[4107.89,3698.13,3.66784],0,[0,0,1]] call InitStruct; 
['Intercom',[4104.74,3695.29,0],0,[0,0,1]] call InitStruct; 
['CampfireBig',[4106.2,3734.07,0],0,[0,0,1]] call InitStruct; 
_4130_689943645_979980_00000 = ['Decor',[4130.69,3645.98,0],0,[0,0,1], {_thisObj setvariable ['model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'];}] call InitDecor; // !!! realocated model !!!
_4142_229983656_08008_0_00033 = ['Decor',[4142.23,3656.08,4.99985,true],360,[-0.992595,-2.12181e-006,0.121467], {_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}] call InitDecor; // !!! realocated model !!!
_4141_009773804_110110_00000 = ['Decor',[4141.01,3804.11,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_25_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4146_819823804_750000_00000 = ['Decor',[4146.82,3804.75,1.90735e-006],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_l25_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4154_520023804_979980_00000 = ['Decor',[4154.52,3804.98,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_r25_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4141_310063831_159910_00000 = ['Decor',[4141.31,3831.16,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_up_25_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4147_069823819_399900_00000 = ['Decor',[4147.07,3819.4,1.90735e-006],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_2_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4155_189943829_419920_00000 = ['Decor',[4155.19,3829.42,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_l30_20_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4136_700203812_520020_00000 = ['Decor',[4136.7,3812.52,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4140_439944479_379880_88654 = ['Decor',[4140.44,4479.38,5.91872,true],300,[-0.433013,0.250001,0.866025], {_thisObj setvariable ['model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4190_120123804_959960_00000 = ['Decor',[4190.12,3804.96,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25nolc_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4161_520023805_340090_00000 = ['Decor',[4161.52,3805.34,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_down_25_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4168_709963805_560060_00000 = ['Decor',[4168.71,3805.56,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4175_439943806_070070_00000 = ['Decor',[4175.44,3806.07,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_l25_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4183_500003805_340090_00000 = ['Decor',[4183.5,3805.34,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_r25_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4162_149903829_000000_00000 = ['Decor',[4162.15,3829,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_r30_20_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4169_439943839_919920_00000 = ['Decor',[4169.44,3839.92,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_down_40_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4191_250003839_879880_00000 = ['Decor',[4191.25,3839.88,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_up_40_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4176_029793840_53003_0_00000 = ['Decor',[4176.03,3840.53,-1.90735e-006],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_40_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4184_209963840_709960_00000 = ['Decor',[4184.21,3840.71,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_40nolc_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4197_129883804_879880_00000 = ['Decor',[4197.13,3804.88,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25nolc_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4197_270023822_409910_00000 = ['Decor',[4197.27,3822.41,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_4_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4197_379883830_179930_00000 = ['Decor',[4197.38,3830.18,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_8_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4210_129883831_669920_00000 = ['Decor',[4210.13,3831.67,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_lb_re_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4216_589843832_949950_00000 = ['Decor',[4216.59,3832.95,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_lb1_re_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4210_229983814_250000_00000 = ['Decor',[4210.23,3814.25,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_le_rb_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4217_669923816_280030_00000 = ['Decor',[4217.67,3816.28,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_le1_rb_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4197_959963840_330080_00000 = ['Decor',[4197.96,3840.33,1.90735e-006],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_8nolc_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4208_930183846_090090_00000 = ['Decor',[4208.93,3846.09,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_sp_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4215_200203849_750000_00000 = ['Decor',[4215.2,3849.75,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_passing_10_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4223_120123848_100100_00000 = ['Decor',[4223.12,3848.1,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_passing_25_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4237_160163839_860110_00000 = ['Decor',[4237.16,3839.86,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_turnoutr_f.p3d'];}] call InitDecor; // !!! realocated model !!!
_4230_850103841_250000_00000 = ['Decor',[4230.85,3841.25,0],0,[0,0,1], {_thisObj setvariable ['model','a3\structures_f_enoch\infrastructure\railways\rail_track_turnoutl_f.p3d'];}] call InitDecor; // !!! realocated model !!!
['EffectAsStruct',[3692.35,3758.02,33.2785],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3730.07,3728.47,40.3428],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3712.49,3726.69,40.0831],320.893,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3734.24,3754.12,40.2233],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3756.37,3772.61,20.1033],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3793.83,3722.53,39.8366],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3804.32,3821.89,39.4945],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3806.28,3828.23,40.128],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3807.62,3813.78,40.13],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3790.69,3830.64,40.13],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3793.21,3816.98,40.129],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3811.07,3731.5,40.1234],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3809.43,3772.02,40.134],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3810.83,3754.97,40.134],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3821.55,3825.99,40.13],0,[0,0,1]] call InitStruct; // Effect
['EffectAsStruct',[3943.88,3774.2,0],0,[0,0,1]] call InitStruct; // Effect



if (!isNil'_3694_600103705_3601140_85161') then {
	_3694_600103705_3601140_85161 setvariable ['name',"Мингул Тумирович"];
	_3694_600103705_3601140_85161 setvariable ['desc',"Казнён за вандализм."];
};
if (!isNil'_3700_310063707_5000040_46690') then {
	_3700_310063707_5000040_46690 setvariable ['name',"Ромозис Расланович"];
	_3700_310063707_5000040_46690 setvariable ['desc',"Подгнившая головешка смотрит на тебя жадными, безжизненными глазками. Был казнён за заработки на продаже некачественной посуды."];
};
if (!isNil'_3689_030033838_7199742_38256') then {
	[_3689_030033838_7199742_38256,go_editor_globalRefs get 'Imported LampWall550646'] call (_3689_030033838_7199742_38256 getvariable 'proto' getvariable 'addConnection');
	[_3689_030033838_7199742_38256,go_editor_globalRefs get 'Imported LampCeiling897557'] call (_3689_030033838_7199742_38256 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3697_250003844_7800342_40860') then {
	[_3697_250003844_7800342_40860,go_editor_globalRefs get 'Imported StreetLamp928373'] call (_3697_250003844_7800342_40860 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3726_669923831_1398940_88220') then {
	[_3726_669923831_1398940_88220,go_editor_globalRefs get 'Imported LampCeiling981629'] call (_3726_669923831_1398940_88220 getvariable 'proto' getvariable 'addConnection');
	[_3726_669923831_1398940_88220,go_editor_globalRefs get 'Imported LampCeiling233442'] call (_3726_669923831_1398940_88220 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3713_479983843_0800839_98530') then {
	_3713_479983843_0800839_98530 setvariable ['name',"Кузня"];
	[_3713_479983843_0800839_98530,go_editor_globalRefs get '_arenaHallSwitcher'] call (_3713_479983843_0800839_98530 getvariable 'proto' getvariable 'addConnection');
	[_3713_479983843_0800839_98530,go_editor_globalRefs get '_arenaSwitcher'] call (_3713_479983843_0800839_98530 getvariable 'proto' getvariable 'addConnection');
	[_3713_479983843_0800839_98530,go_editor_globalRefs get '_craftHouseSwitcher'] call (_3713_479983843_0800839_98530 getvariable 'proto' getvariable 'addConnection');
	[_3713_479983843_0800839_98530,go_editor_globalRefs get 'Imported StationSpeaker871679'] call (_3713_479983843_0800839_98530 getvariable 'proto' getvariable 'addConnection');
	[_3713_479983843_0800839_98530,go_editor_globalRefs get '_blacksmithSwitcher'] call (_3713_479983843_0800839_98530 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3722_010013842_8300841_84546') then {
	[_3722_010013842_8300841_84546,go_editor_globalRefs get 'Imported LampWall978420'] call (_3722_010013842_8300841_84546 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3777_149903773_7900431_55460') then {
	_3777_149903773_7900431_55460 setvariable ['name',"Генераторная"];
	[_3777_149903773_7900431_55460,go_editor_globalRefs get 'Imported StreetLamp543797'] call (_3777_149903773_7900431_55460 getvariable 'proto' getvariable 'addConnection');
	[_3777_149903773_7900431_55460,go_editor_globalRefs get 'Imported LampWall220542'] call (_3777_149903773_7900431_55460 getvariable 'proto' getvariable 'addConnection');
	[_3777_149903773_7900431_55460,go_editor_globalRefs get 'Imported LampWall905367'] call (_3777_149903773_7900431_55460 getvariable 'proto' getvariable 'addConnection');
	[_3777_149903773_7900431_55460,go_editor_globalRefs get 'Imported LampWall258221'] call (_3777_149903773_7900431_55460 getvariable 'proto' getvariable 'addConnection');
	[_3777_149903773_7900431_55460,go_editor_globalRefs get 'Imported LampWall860184'] call (_3777_149903773_7900431_55460 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3790_620123761_8501041_51816') then {
	[_3790_620123761_8501041_51816,go_editor_globalRefs get 'Imported LampCeiling896019'] call (_3790_620123761_8501041_51816 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3791_659913751_4699741_65016') then {
	[_3791_659913751_4699741_65016,go_editor_globalRefs get 'Imported LampCeiling204278'] call (_3791_659913751_4699741_65016 getvariable 'proto' getvariable 'addConnection');
	[_3791_659913751_4699741_65016,go_editor_globalRefs get 'Imported LampCeiling645971'] call (_3791_659913751_4699741_65016 getvariable 'proto' getvariable 'addConnection');
	[_3791_659913751_4699741_65016,go_editor_globalRefs get 'Imported LampCeiling870028'] call (_3791_659913751_4699741_65016 getvariable 'proto' getvariable 'addConnection');
	[_3791_659913751_4699741_65016,go_editor_globalRefs get 'Imported LampCeiling769699'] call (_3791_659913751_4699741_65016 getvariable 'proto' getvariable 'addConnection');
	[_3791_659913751_4699741_65016,go_editor_globalRefs get 'Imported LampCeiling871440'] call (_3791_659913751_4699741_65016 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3787_899903744_9599641_61126') then {
	[_3787_899903744_9599641_61126,go_editor_globalRefs get 'Imported LampCeiling420604'] call (_3787_899903744_9599641_61126 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3796_280033770_8200745_18786') then {
	[_3796_280033770_8200745_18786,go_editor_globalRefs get 'Imported LampWall177316'] call (_3796_280033770_8200745_18786 getvariable 'proto' getvariable 'addConnection');
	[_3796_280033770_8200745_18786,go_editor_globalRefs get 'Imported LampWall667306'] call (_3796_280033770_8200745_18786 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3790_409913756_0100141_71550') then {
	[_3790_409913756_0100141_71550,go_editor_globalRefs get 'Imported SignMedical156392'] call (_3790_409913756_0100141_71550 getvariable 'proto' getvariable 'addConnection');
	[_3790_409913756_0100141_71550,go_editor_globalRefs get 'Imported SignMedical449993'] call (_3790_409913756_0100141_71550 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3793_959963755_1999541_78180') then {
	[_3793_959963755_1999541_78180,go_editor_globalRefs get 'Imported LampCeiling686750'] call (_3793_959963755_1999541_78180 getvariable 'proto' getvariable 'addConnection');
	[_3793_959963755_1999541_78180,go_editor_globalRefs get 'Imported LampCeiling657799'] call (_3793_959963755_1999541_78180 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3779_620123772_9599632_69160') then {
	_3779_620123772_9599632_69160 setvariable ['name',"Свет второй улицы"];
};
if (!isNil'_3779_189943772_9799832_68850') then {
	_3779_189943772_9799832_68850 setvariable ['name',"Свет главной улицы"];
	[_3779_189943772_9799832_68850,go_editor_globalRefs get '_street1Gen'] call (_3779_189943772_9799832_68850 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3790_429933757_5000040_98580') then {
	_3790_429933757_5000040_98580 setvariable ['name',"Лекарня"];
	[_3790_429933757_5000040_98580,go_editor_globalRefs get '_doctorHomeSwitcher'] call (_3790_429933757_5000040_98580 getvariable 'proto' getvariable 'addConnection');
	[_3790_429933757_5000040_98580,go_editor_globalRefs get '_doctorHallSwitcher'] call (_3790_429933757_5000040_98580 getvariable 'proto' getvariable 'addConnection');
	[_3790_429933757_5000040_98580,go_editor_globalRefs get '_doctorChemSwitcher'] call (_3790_429933757_5000040_98580 getvariable 'proto' getvariable 'addConnection');
	[_3790_429933757_5000040_98580,go_editor_globalRefs get '_doctorSignSwitcher'] call (_3790_429933757_5000040_98580 getvariable 'proto' getvariable 'addConnection');
	[_3790_429933757_5000040_98580,go_editor_globalRefs get '_doctorMeatSwitcher'] call (_3790_429933757_5000040_98580 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3797_520023777_6799340_07450') then {
	_3797_520023777_6799340_07450 setvariable ['name',"Торговец"];
	[_3797_520023777_6799340_07450,go_editor_globalRefs get '_merchantHomeSwitcher'] call (_3797_520023777_6799340_07450 getvariable 'proto' getvariable 'addConnection');
	[_3797_520023777_6799340_07450,go_editor_globalRefs get '_merchantMainSwitcher'] call (_3797_520023777_6799340_07450 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3777_520023780_9399431_46820') then {
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transMasters'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transGeneratorRoom'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_street2Switcher'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_street1Switcher'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transDoctor'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transMerchant'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transLibra'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transGolova'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transKitchen'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
	[_3777_520023780_9399431_46820,go_editor_globalRefs get '_transArmy'] call (_3777_520023780_9399431_46820 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3798_010013776_5500541_67580') then {
	[_3798_010013776_5500541_67580,go_editor_globalRefs get 'Imported LampCeiling85210'] call (_3798_010013776_5500541_67580 getvariable 'proto' getvariable 'addConnection');
	[_3798_010013776_5500541_67580,go_editor_globalRefs get 'Imported LampCeiling166736'] call (_3798_010013776_5500541_67580 getvariable 'proto' getvariable 'addConnection');
	[_3798_010013776_5500541_67580,go_editor_globalRefs get 'Imported LampCeiling119892'] call (_3798_010013776_5500541_67580 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3780_510013839_0800841_53576') then {
	[_3780_510013839_0800841_53576,go_editor_globalRefs get 'Imported LampCeiling774675'] call (_3780_510013839_0800841_53576 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3801_379883838_8400945_82676') then {
	[_3801_379883838_8400945_82676,go_editor_globalRefs get 'Imported LampCeiling788751'] call (_3801_379883838_8400945_82676 getvariable 'proto' getvariable 'addConnection');
	[_3801_379883838_8400945_82676,go_editor_globalRefs get 'Imported LampCeiling499367'] call (_3801_379883838_8400945_82676 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3780_790043821_6799340_83050') then {
	[_3780_790043821_6799340_83050,go_editor_globalRefs get 'Imported StreetLamp137502'] call (_3780_790043821_6799340_83050 getvariable 'proto' getvariable 'addConnection');
	[_3780_790043821_6799340_83050,go_editor_globalRefs get 'Imported StreetLamp723502'] call (_3780_790043821_6799340_83050 getvariable 'proto' getvariable 'addConnection');
	[_3780_790043821_6799340_83050,go_editor_globalRefs get 'Imported StreetLamp830354'] call (_3780_790043821_6799340_83050 getvariable 'proto' getvariable 'addConnection');
	[_3780_790043821_6799340_83050,go_editor_globalRefs get 'Imported StreetLamp475780'] call (_3780_790043821_6799340_83050 getvariable 'proto' getvariable 'addConnection');
	[_3780_790043821_6799340_83050,go_editor_globalRefs get 'Imported StreetLamp201546'] call (_3780_790043821_6799340_83050 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3783_270023844_5600640_07250') then {
	_3783_270023844_5600640_07250 setvariable ['name',"Библиотека"];
	[_3783_270023844_5600640_07250,go_editor_globalRefs get 'Imported StreetLamp402738'] call (_3783_270023844_5600640_07250 getvariable 'proto' getvariable 'addConnection');
	[_3783_270023844_5600640_07250,go_editor_globalRefs get 'Imported StreetLamp874730'] call (_3783_270023844_5600640_07250 getvariable 'proto' getvariable 'addConnection');
	[_3783_270023844_5600640_07250,go_editor_globalRefs get '_librabooksbutt'] call (_3783_270023844_5600640_07250 getvariable 'proto' getvariable 'addConnection');
	[_3783_270023844_5600640_07250,go_editor_globalRefs get '_librahousebutt'] call (_3783_270023844_5600640_07250 getvariable 'proto' getvariable 'addConnection');
	[_3783_270023844_5600640_07250,go_editor_globalRefs get 'Imported StationSpeaker891726'] call (_3783_270023844_5600640_07250 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3797_449953844_5200242_26026') then {
	[_3797_449953844_5200242_26026,go_editor_globalRefs get 'Imported LampCeiling798420'] call (_3797_449953844_5200242_26026 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3798_959963840_3200742_27666') then {
	[_3798_959963840_3200742_27666,go_editor_globalRefs get 'Imported LampWall399520'] call (_3798_959963840_3200742_27666 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3781_379883849_1799341_54596') then {
	[_3781_379883849_1799341_54596,go_editor_globalRefs get 'Imported LampCeiling161668'] call (_3781_379883849_1799341_54596 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3799_719973848_1298845_90676') then {
	[_3799_719973848_1298845_90676,go_editor_globalRefs get 'Imported LampCeiling458244'] call (_3799_719973848_1298845_90676 getvariable 'proto' getvariable 'addConnection');
	[_3799_719973848_1298845_90676,go_editor_globalRefs get 'Imported LampCeiling151716'] call (_3799_719973848_1298845_90676 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3804_060063841_7700245_90766') then {
	[_3804_060063841_7700245_90766,go_editor_globalRefs get 'Imported LampCeiling467800'] call (_3804_060063841_7700245_90766 getvariable 'proto' getvariable 'addConnection');
	[_3804_060063841_7700245_90766,go_editor_globalRefs get 'Imported LampCeiling547290'] call (_3804_060063841_7700245_90766 getvariable 'proto' getvariable 'addConnection');
	[_3804_060063841_7700245_90766,go_editor_globalRefs get 'Imported LampCeiling260950'] call (_3804_060063841_7700245_90766 getvariable 'proto' getvariable 'addConnection');
	[_3804_060063841_7700245_90766,go_editor_globalRefs get 'Imported LampCeiling971839'] call (_3804_060063841_7700245_90766 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3801_090093842_4499542_33906') then {
	[_3801_090093842_4499542_33906,go_editor_globalRefs get 'Imported LampWall438783'] call (_3801_090093842_4499542_33906 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3819_189943761_0000040_10870') then {
	_3819_189943761_0000040_10870 setvariable ['name',"Улица"];
	[_3819_189943761_0000040_10870,go_editor_globalRefs get 'Imported StationSpeaker746771'] call (_3819_189943761_0000040_10870 getvariable 'proto' getvariable 'addConnection');
	[_3819_189943761_0000040_10870,go_editor_globalRefs get 'Imported StreetLamp872382'] call (_3819_189943761_0000040_10870 getvariable 'proto' getvariable 'addConnection');
	[_3819_189943761_0000040_10870,go_editor_globalRefs get 'Imported StreetLamp673634'] call (_3819_189943761_0000040_10870 getvariable 'proto' getvariable 'addConnection');
	[_3819_189943761_0000040_10870,go_editor_globalRefs get 'Imported StreetLamp115425'] call (_3819_189943761_0000040_10870 getvariable 'proto' getvariable 'addConnection');
	[_3819_189943761_0000040_10870,go_editor_globalRefs get 'Imported StreetLamp200086'] call (_3819_189943761_0000040_10870 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3823_139893767_2500042_00116') then {
	_3823_139893767_2500042_00116 setvariable ['name',"Комната Трактирщика"];
	[_3823_139893767_2500042_00116,go_editor_globalRefs get 'Imported LampWall679564'] call (_3823_139893767_2500042_00116 getvariable 'proto' getvariable 'addConnection');
	[_3823_139893767_2500042_00116,go_editor_globalRefs get 'Imported LampWall987857'] call (_3823_139893767_2500042_00116 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3822_739993767_2399941_99766') then {
	_3822_739993767_2399941_99766 setvariable ['name',"Вывеска бара"];
	[_3822_739993767_2399941_99766,go_editor_globalRefs get 'Imported SignBar232924'] call (_3822_739993767_2399941_99766 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3838_189943829_8701247_18596') then {
	[_3838_189943829_8701247_18596,go_editor_globalRefs get 'Imported LampCeiling552030'] call (_3838_189943829_8701247_18596 getvariable 'proto' getvariable 'addConnection');
	[_3838_189943829_8701247_18596,go_editor_globalRefs get 'Imported LampCeiling47289'] call (_3838_189943829_8701247_18596 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3809_500003838_0600646_11746') then {
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall94383'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampCeiling921659'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall223124'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall900861'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall416895'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall270106'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall935616'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
	[_3809_500003838_0600646_11746,go_editor_globalRefs get 'Imported LampWall104879'] call (_3809_500003838_0600646_11746 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3822_229983835_1699241_78386') then {
	[_3822_229983835_1699241_78386,go_editor_globalRefs get 'Imported LampCeiling865611'] call (_3822_229983835_1699241_78386 getvariable 'proto' getvariable 'addConnection');
	[_3822_229983835_1699241_78386,go_editor_globalRefs get 'Imported LampCeiling446759'] call (_3822_229983835_1699241_78386 getvariable 'proto' getvariable 'addConnection');
	[_3822_229983835_1699241_78386,go_editor_globalRefs get 'Imported LampCeiling831070'] call (_3822_229983835_1699241_78386 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3822_280033835_1699246_12186') then {
	[_3822_280033835_1699246_12186,go_editor_globalRefs get 'Imported LampCeiling182367'] call (_3822_280033835_1699246_12186 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3813_510013835_4899945_59650') then {
	[_3813_510013835_4899945_59650,go_editor_globalRefs get 'Imported StreetLamp266358'] call (_3813_510013835_4899945_59650 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3813_120123846_5500542_44916') then {
	[_3813_120123846_5500542_44916,go_editor_globalRefs get 'Imported LampCeiling868711'] call (_3813_120123846_5500542_44916 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3821_320073846_5600641_65196') then {
	[_3821_320073846_5600641_65196,go_editor_globalRefs get 'Imported LampCeiling840883'] call (_3821_320073846_5600641_65196 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3824_600103841_5000046_10446') then {
	[_3824_600103841_5000046_10446,go_editor_globalRefs get 'Imported LampCeiling289190'] call (_3824_600103841_5000046_10446 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3825_600103844_3200741_78546') then {
	[_3825_600103844_3200741_78546,go_editor_globalRefs get 'Imported LampWall546236'] call (_3825_600103844_3200741_78546 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3821_949953850_6699245_07360') then {
	_3821_949953850_6699245_07360 setvariable ['name',"Администрация"];
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headprivaterelax'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_streetLightSwitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headknuthouseswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headknutworkswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headprivatesleep'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headprivatework'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headknutlobbyswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_head2floorswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_head1floorswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_zvakworkswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_streetPodiumSwitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get 'Imported StationSpeaker154809'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_headsecretroomswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_bankLobbySwitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_zvakhomeswitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get '_bankSwitcher'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get 'Imported LampWall902053'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
	[_3821_949953850_6699245_07360,go_editor_globalRefs get 'Imported LampWall42730'] call (_3821_949953850_6699245_07360 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3812_419923840_8200745_83590') then {
	_3812_419923840_8200745_83590 setvariable ['name',"Заблокированная дверь"];
	_3812_419923840_8200745_83590 setvariable ['desc',"Лучше даже не думать о том, что может быть скрыто за этой дверью."];
};
if (!isNil'_3846_060063770_0700740_09840') then {
	_3846_060063770_0700740_09840 setvariable ['name',"Бар"];
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakHomeSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakSignSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get 'Imported StationSpeaker383203'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakBarSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakVIPSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakKitchenSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_kabakHallSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get '_fermSwitcher'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
	[_3846_060063770_0700740_09840,go_editor_globalRefs get 'Imported StreetLamp899163'] call (_3846_060063770_0700740_09840 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3842_270023770_3100641_85676') then {
	_3842_270023770_3100641_85676 setvariable ['name',"Свет у барной стойки"];
	[_3842_270023770_3100641_85676,go_editor_globalRefs get 'Imported LampCeiling462665'] call (_3842_270023770_3100641_85676 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023770_3100641_85676,go_editor_globalRefs get 'Imported LampCeiling876140'] call (_3842_270023770_3100641_85676 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3842_959963773_0800841_85926') then {
	_3842_959963773_0800841_85926 setvariable ['name',"Свет приватной комнаты"];
	[_3842_959963773_0800841_85926,go_editor_globalRefs get 'Imported LampCeiling105697'] call (_3842_959963773_0800841_85926 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3848_979983767_2299841_63849') then {
	[_3848_979983767_2299841_63849,go_editor_globalRefs get 'Imported LampWall93090'] call (_3848_979983767_2299841_63849 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3842_270023769_9499541_86026') then {
	_3842_270023769_9499541_86026 setvariable ['name',"Свет бара"];
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling958655'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling259554'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling819711'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling607096'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling838719'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
	[_3842_270023769_9499541_86026,go_editor_globalRefs get 'Imported LampCeiling184779'] call (_3842_270023769_9499541_86026 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3843_600103762_0200241_57460') then {
	[_3843_600103762_0200241_57460,go_editor_globalRefs get 'Imported StreetLamp858425'] call (_3843_600103762_0200241_57460 getvariable 'proto' getvariable 'addConnection');
	[_3843_600103762_0200241_57460,go_editor_globalRefs get 'Imported StreetLamp875451'] call (_3843_600103762_0200241_57460 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3846_139893821_7199740_13000') then {
	_3846_139893821_7199740_13000 setvariable ['name',"Служба безопасности"];
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_armyHosHomeSwitcher'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get 'Imported StationSpeaker670983'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get 'Imported StreetLamp832727'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get 'Imported StreetLamp974440'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get 'Imported StreetLamp261945'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_armyWeaponsDepotSwitcher'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_army2stfloor'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_army1stfloor'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_armynicecageswitcher'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
	[_3846_139893821_7199740_13000,go_editor_globalRefs get '_armyInterrogationSwitcher'] call (_3846_139893821_7199740_13000 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3840_209963834_1599144_08586') then {
	[_3840_209963834_1599144_08586,go_editor_globalRefs get 'Imported LampCeiling671391'] call (_3840_209963834_1599144_08586 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3840_169923829_4599647_31526') then {
	[_3840_169923829_4599647_31526,go_editor_globalRefs get 'Imported LampWall892404'] call (_3840_169923829_4599647_31526 getvariable 'proto' getvariable 'addConnection');
	[_3840_169923829_4599647_31526,go_editor_globalRefs get 'Imported LampWall394942'] call (_3840_169923829_4599647_31526 getvariable 'proto' getvariable 'addConnection');
	[_3840_169923829_4599647_31526,go_editor_globalRefs get 'Imported LampWall172065'] call (_3840_169923829_4599647_31526 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3840_129883824_9899943_91056') then {
	[_3840_129883824_9899943_91056,go_editor_globalRefs get 'Imported LampWall411526'] call (_3840_129883824_9899943_91056 getvariable 'proto' getvariable 'addConnection');
	[_3840_129883824_9899943_91056,go_editor_globalRefs get 'Imported LampWall796411'] call (_3840_129883824_9899943_91056 getvariable 'proto' getvariable 'addConnection');
	[_3840_129883824_9899943_91056,go_editor_globalRefs get 'Imported LampWall279384'] call (_3840_129883824_9899943_91056 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3855_489993816_5700745_20300') then {
	[_3855_489993816_5700745_20300,go_editor_globalRefs get 'Imported LampWall68308'] call (_3855_489993816_5700745_20300 getvariable 'proto' getvariable 'addConnection');
};
if (!isNil'_3853_649903817_8601141_72070') then {
	[_3853_649903817_8601141_72070,go_editor_globalRefs get 'Imported LampWall622259'] call (_3853_649903817_8601141_72070 getvariable 'proto' getvariable 'addConnection');
};
