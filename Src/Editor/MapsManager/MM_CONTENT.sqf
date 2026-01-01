// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

_module_name_='import from old map';
_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3741.24,3753.1,47.2746]];
	_o set3DENAttribute ['rotation',[0,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3741.15,3763.42,46.7592]];
	_o set3DENAttribute ['rotation',[0,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3738.63,3744.22,36.9338]];
	_o set3DENAttribute ['rotation',[359.802,359.767,332.167]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3736.55,3753.37,37.0342]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_tarkov_wood", [0,0,0]];
	_o set3DENAttribute ['position',[3742.89,3759.08,33.2918]];
	_o set3DENAttribute ['rotation',[0,0,179.716]];

	_hash = [_o,'OldWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3743.73,3763.63,35.4234]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_2"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3743.51,3758.29,29.9565]];
	_o set3DENAttribute ['rotation',[0,0,179.258]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_almara", [0,0,0]];
	_o set3DENAttribute ['position',[3742.16,3765.53,33.2923]];
	_o set3DENAttribute ['rotation',[0,0,268.888]];

	_hash = [_o,'LargeClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_almara", [0,0,0]];
	_o set3DENAttribute ['position',[3742.13,3760.68,33.3135]];
	_o set3DENAttribute ['rotation',[0,0,269.363]];

	_hash = [_o,'LargeClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "komodvirus", [0,0,0]];
	_o set3DENAttribute ['position',[3742.54,3765.13,29.9167]];
	_o set3DENAttribute ['rotation',[0,0,89.6845]];

	_hash = [_o,'LuxuryCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "biblio", [0,0,0]];
	_o set3DENAttribute ['position',[3743.51,3767.45,29.9081]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Bookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zhelstenabig", [0,0,0]];
	_o set3DENAttribute ['position',[3741.57,3763.18,30.1279]];
	_o set3DENAttribute ['rotation',[0,0,270.198]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\zhelstenabig.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zhelstenabig", [0,0,0]];
	_o set3DENAttribute ['position',[3740.33,3767.94,29.9822]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\zhelstenabig.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kovernew", [0,0,0]];
	_o set3DENAttribute ['position',[3743.82,3760.54,33.3446]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kovrik\kovernew.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_centr", [0,0,0]];
	_o set3DENAttribute ['position',[3743.93,3758.58,27.169]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_centr.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3758.62,3722.93,37.2849]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3768.54,3721.89,37.0191]];
	_o set3DENAttribute ['rotation',[0,0,3.69435]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3750.48,3733.82,28.8127]];
	_o set3DENAttribute ['rotation',[0,0,14.9003]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3768.01,3731.49,19.7731]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3757.77,3732.11,19.7837]];
	_o set3DENAttribute ['rotation',[0,0,186.046]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3768.04,3721.03,19.7121]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3767.41,3741.8,19.8982]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3757.97,3721.13,19.6979]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3758.21,3712.74,29.1994]];
	_o set3DENAttribute ['rotation',[0,0,19.8301]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3771.53,3713.43,29.0476]];
	_o set3DENAttribute ['rotation',[0,0,332.624]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3769.27,3742.95,39.1035]];
	_o set3DENAttribute ['rotation',[0,0,357.844]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3759.37,3733.78,37.6493]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3760.01,3742.7,28.939]];
	_o set3DENAttribute ['rotation',[0,0,352.102]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3769.65,3732.57,37.5494]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3750.8,3722.66,29.2302]];
	_o set3DENAttribute ['rotation',[0,0,347.326]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3762.32,3729.24,20.8222]];
	_o set3DENAttribute ['rotation',[0,0,4.08292]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3764.99,3726.27,21.4237]];
	_o set3DENAttribute ['rotation',[0,0,89.0528]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3765.27,3718.96,21.4167]];
	_o set3DENAttribute ['rotation',[0,0,265.458]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3757.92,3721.04,21.4137]];
	_o set3DENAttribute ['rotation',[0,0,269.934]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3762.23,3717.24,21.53]];
	_o set3DENAttribute ['rotation',[0,0,4.08292]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3746.76,3742.95,30.0968]];
	_o set3DENAttribute ['rotation',[57.8412,358.599,257.071]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_02_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3768.85,3722.7,20.7671]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3758.62,3722.16,20.3343]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3762.89,3723.45,20.6373]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3762.89,3724.95,20.6389]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.41,3731.98,20.959]];
	_o set3DENAttribute ['rotation',[0,23.3474,263.118]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3769.44,3741.48,20.3674]];
	_o set3DENAttribute ['rotation',[0,0,263.964]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3758.69,3718.68,17.11]];
	_o set3DENAttribute ['rotation',[0,0,92.3995]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sundugan", [0,0,0]];
	_o set3DENAttribute ['position',[3762.69,3719.7,19.8515]];
	_o set3DENAttribute ['rotation',[0,0,93.6778]];

	_hash = [_o,'ContainerGreen'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box", [0,0,0]];
	_o set3DENAttribute ['position',[3758.58,3722.16,19.7942]];
	_o set3DENAttribute ['rotation',[0,0,96.0876]];

	_hash = [_o,'ContainerGreen3'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3762.44,3728.77,19.8009]];
	_o set3DENAttribute ['rotation',[0,0,268.642]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Desk", [0,0,0]];
	_o set3DENAttribute ['position',[3762.66,3724.21,19.8162]];
	_o set3DENAttribute ['rotation',[0,0,90.6906]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\desk\desk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3768.09,3725.16,20.1742]];
	_o set3DENAttribute ['rotation',[0,0,180.96]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3768.25,3743.26,21.3241]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3766.3,3742.9,21.3307]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3768.93,3739.46,19.714]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3766.99,3739.11,19.7206]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3764.22,3721.16,19.559]];
	_o set3DENAttribute ['rotation',[0,0,359.056]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3758.34,3729.15,22.2726]];
	_o set3DENAttribute ['rotation',[0,0,248.924]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3769.26,3725.47,22.1322]];
	_o set3DENAttribute ['rotation',[0,0,248.924]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3764.73,3729.03,22.1809]];
	_o set3DENAttribute ['rotation',[0,0,287.068]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ArmChair_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3763.84,3724.13,19.7896]];
	_o set3DENAttribute ['rotation',[0,0,274.892]];

	_hash = [_o,'ArmChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3758,3725.04,19.7405]];
	_o set3DENAttribute ['rotation',[0,0,94.1234]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["abbat","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryslo", [0,0,0]];
	_o set3DENAttribute ['position',[3763.51,3722.32,20.572]];
	_o set3DENAttribute ['rotation',[0,0,346.701]];

	_hash = [_o,'RedLuxuryChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_stulcasual", [0,0,0]];
	_o set3DENAttribute ['position',[3766.22,3722.62,20.3357]];
	_o set3DENAttribute ['rotation',[0,0,178.926]];

	_hash = [_o,'ChairCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_stulcasual", [0,0,0]];
	_o set3DENAttribute ['position',[3761.55,3724.2,19.8094]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_9", [0,0,0]];
	_o set3DENAttribute ['position',[3767.47,3720.87,20.757]];
	_o set3DENAttribute ['rotation',[0,0,0.785188]];

	_hash = [_o,'SteelBrownContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sofa", [0,0,0]];
	_o set3DENAttribute ['position',[3761.54,3721.74,19.7968]];
	_o set3DENAttribute ['rotation',[0,0,185.498]];

	_hash = [_o,'RedSofa'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator", [0,0,0]];
	_o set3DENAttribute ['position',[3764.94,3718.3,20.6867]];
	_o set3DENAttribute ['rotation',[0,0,265.827]];

	_hash = [_o,'ElectricalShieldSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3763.68,3718.2,22.7797]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "biblio", [0,0,0]];
	_o set3DENAttribute ['position',[3759.64,3728.72,19.7492]];
	_o set3DENAttribute ['rotation',[0,0,358.721]];

	_hash = [_o,'Bookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3766.89,3732.75,20.9118]];
	_o set3DENAttribute ['rotation',[0,0,35.3892]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_pieces_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3762.61,3720.04,19.5017]];
	_o set3DENAttribute ['rotation',[0,0,187.23]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3765.86,3724.6,19.7546]];
	_o set3DENAttribute ['rotation',[0,0,179.348]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Chapel_Small_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3767.45,3724.46,20.2057]];
	_o set3DENAttribute ['rotation',[0,0,89.375]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\civ\chapels\chapel_small_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Shed_06_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.6,3724.34,19.2233]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\sheds\shed_06_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Church_chair", [0,0,0]];
	_o set3DENAttribute ['position',[3769.84,3728.55,19.8097]];
	_o set3DENAttribute ['rotation',[0,0,96.9382]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\church_chair\church_chair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Church_chair", [0,0,0]];
	_o set3DENAttribute ['position',[3770.47,3735.1,19.7376]];
	_o set3DENAttribute ['rotation',[0,0,96.9382]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\church_chair\church_chair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Church_chair", [0,0,0]];
	_o set3DENAttribute ['position',[3769.9,3730.41,19.7834]];
	_o set3DENAttribute ['rotation',[0,0,96.9382]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\church_chair\church_chair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Church_chair", [0,0,0]];
	_o set3DENAttribute ['position',[3770.36,3732.87,19.6329]];
	_o set3DENAttribute ['rotation',[0,0,96.9382]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\church_chair\church_chair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kovernew", [0,0,0]];
	_o set3DENAttribute ['position',[3761.24,3726.51,19.8478]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kovrik\kovernew.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_bed_big", [0,0,0]];
	_o set3DENAttribute ['position',[3763.73,3727.52,19.7779]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\bed_big_a.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TableSmall_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3768.8,3722.66,20.3323]];
	_o set3DENAttribute ['rotation',[0,0,357.556]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\props_f_orange\furniture\tablesmall_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TableSmall_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3767.47,3720.85,20.3357]];
	_o set3DENAttribute ['rotation',[0,0,86.9911]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\props_f_orange\furniture\tablesmall_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Sidewalk_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.37,3727.26,19.7503]];
	_o set3DENAttribute ['rotation',[0,0,178.596]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Sidewalk_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.24,3723.75,19.7466]];
	_o set3DENAttribute ['rotation',[0,0,186.456]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Sidewalk_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.41,3719.87,19.7415]];
	_o set3DENAttribute ['rotation',[0,0,3.85568]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\sidewalk_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3758.14,3727.73,21.5354]];
	_o set3DENAttribute ['rotation',[0.403153,0.0427687,92.3597]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3759.48,3729.21,20.8506]];
	_o set3DENAttribute ['rotation',[0.100321,359.608,174.102]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3762.12,3721.52,20.04]];
	_o set3DENAttribute ['rotation',[0.404599,0.025304,94.8623]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3763.81,3723.2,20.066]];
	_o set3DENAttribute ['rotation',[359.828,0.366937,343.25]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Unfinished_Building_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3749.94,3761.86,29.6545]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\wip\unfinished_building_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3769.25,3773.86,41.9583]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3760.78,3762.11,43.5445]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3767.97,3752.07,24.4446]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3760.89,3767.54,29.9153]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3769.99,3772.78,31.9935]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3759.34,3752.8,38.1022]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3771.35,3752.65,46.2085]];
	_o set3DENAttribute ['rotation',[359.586,343.381,0.116365]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3768.46,3762.48,24.2646]];
	_o set3DENAttribute ['rotation',[0,0,1.5558]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3760.88,3772.97,37.7617]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3751.37,3772.56,46.4905]];
	_o set3DENAttribute ['rotation',[0,0,7.05881]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3751.18,3753.07,47.2471]];
	_o set3DENAttribute ['rotation',[0,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3751.33,3762.86,55.3856]];
	_o set3DENAttribute ['rotation',[0,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3772.39,3764.35,45.6968]];
	_o set3DENAttribute ['rotation',[15.2765,348.601,4.98522]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3755.16,3745.68,38.8585]];
	_o set3DENAttribute ['rotation',[0,359.694,291.672]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3746.71,3744.87,43.0061]];
	_o set3DENAttribute ['rotation',[324.588,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3747.27,3748.14,28.9106]];
	_o set3DENAttribute ['rotation',[351.938,0,179.424]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_d_Stone_HouseBig_V1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3768.75,3758.3,26.4676]];
	_o set3DENAttribute ['rotation',[0,0,2.44]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3753.93,3770.49,29.5181]];
	_o set3DENAttribute ['rotation',[0,0,180.877]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["moneybank"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3770.04,3754.47,26.6082]];
	_o set3DENAttribute ['rotation',[0,0,2.34221]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["headpre","minihead","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3755.81,3764.49,29.4546]];
	_o set3DENAttribute ['rotation',[0,0,88.9357]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sobranie","minihead","super"]] call mm_importOld_regVar;
	[_o,'isLocked',false] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3754.36,3768.08,29.3021]];
	_o set3DENAttribute ['rotation',[0,0,1.30685]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["moneybank"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3754.02,3770.45,29.6666]];
	_o set3DENAttribute ['rotation',[0,0,90.7449]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3754.01,3770.87,32.0594]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_bank"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3748.83,3760.81,32.4962]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_1"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3753.81,3761.56,32.5298]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3744.24,3764,32.5741]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_1"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3760.92,3760.52,32.1421]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3749.07,3757.49,32.3911]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_1"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3761.42,3765.42,32.3789]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_meetingadm"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3757.79,3752.44,26.9604]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_btminiadmin"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3748.92,3757.59,35.9679]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_2"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3762.06,3751.64,27.0348]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_btminiadmin"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3768.29,3757.33,28.9977]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminhallhome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3749.12,3762.96,36.0932]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_2"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3768.31,3757.56,31.9921]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminhallhome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Stone_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3764.59,3766.45,30.4697]];
	_o set3DENAttribute ['rotation',[0,0,87.7142]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\stone_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Stone_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3760.4,3767.93,30.011]];
	_o set3DENAttribute ['rotation',[0,0,358.179]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\stone_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Stone_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3760.3,3762.48,30.3262]];
	_o set3DENAttribute ['rotation',[0,0,0.255097]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\stone_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3746.44,3747.8,28.9715]];
	_o set3DENAttribute ['rotation',[349.176,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.63,3754.32,25.4922]];
	_o set3DENAttribute ['rotation',[0,0,61.5245]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminevent"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3765.65,3748.9,23.7434]];
	_o set3DENAttribute ['rotation',[0,0,68.125]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3749.95,3755.6,29.665]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3748.27,3755.59,29.668]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3751.62,3757.25,29.6111]];
	_o set3DENAttribute ['rotation',[0,0,270.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3759.61,3758.56,20.5192]];
	_o set3DENAttribute ['rotation',[0,0,270.198]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3759.5,3758.57,29.5909]];
	_o set3DENAttribute ['rotation',[0,0,270.198]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3764.2,3751.82,24.563]];
	_o set3DENAttribute ['rotation',[0,0,276.915]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3760.76,3752.14,24.5034]];
	_o set3DENAttribute ['rotation',[0,0,99.3609]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3753.06,3768.08,29.8395]];
	_o set3DENAttribute ['rotation',[0,0,180.304]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3755.86,3765.76,29.8997]];
	_o set3DENAttribute ['rotation',[0,0,270.749]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3749.77,3757.72,30.6919]];
	_o set3DENAttribute ['rotation',[0,0,179.179]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3763.58,3753.05,25.2892]];
	_o set3DENAttribute ['rotation',[0,0,53.8189]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3751.14,3762.97,31.4326]];
	_o set3DENAttribute ['rotation',[257.971,85.5631,77.2111]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_adminbase_1'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3769.09,3754.59,28.1156]];
	_o set3DENAttribute ['rotation',[90.9238,0.570312,269.214]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_adminhallhome'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3746.7,3763.03,34.6592]];
	_o set3DENAttribute ['rotation',[142.192,271.169,217.02]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_adminbase_2'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3753.41,3767.86,31.1487]];
	_o set3DENAttribute ['rotation',[0,0,356.243]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_bank'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3755.7,3763.5,31.3909]];
	_o set3DENAttribute ['rotation',[0,0,91.2194]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_meetingadm'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3762.08,3749.01,25.7816]];
	_o set3DENAttribute ['rotation',[0,0,188.161]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_btminiadmin'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3770.82,3759.76,31.0086]];
	_o set3DENAttribute ['rotation',[0,0,266.283]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transAdmin"]] call mm_importOld_regFunc;

	[_o,'_sw_adminevent'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3745.17,3760.6,30.7297]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3758.98,3750.19,24.6229]];
	_o set3DENAttribute ['rotation',[0,0,279.137]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3760.27,3751.21,24.6229]];
	_o set3DENAttribute ['rotation',[0,0,6.74907]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Desk", [0,0,0]];
	_o set3DENAttribute ['position',[3763.25,3752.88,24.4646]];
	_o set3DENAttribute ['rotation',[0,0,7.61516]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\desk\desk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3763.94,3750.61,24.5397]];
	_o set3DENAttribute ['rotation',[0,0,277.325]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["minihead","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3767.73,3746.09,23.0741]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3765.79,3745.73,23.0807]];
	_o set3DENAttribute ['rotation',[0,0,349.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3761.18,3759.92,27.051]];
	_o set3DENAttribute ['rotation',[0,0,272.268]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3761.26,3761.85,27.0486]];
	_o set3DENAttribute ['rotation',[0,0,272.268]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3758.39,3761.97,28.7986]];
	_o set3DENAttribute ['rotation',[0,0,272.268]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_pod_2x4", [0,0,0]];
	_o set3DENAttribute ['position',[3758.31,3760.03,28.801]];
	_o set3DENAttribute ['rotation',[0,0,272.268]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_pod_2x4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3752.14,3766.24,29.346]];
	_o set3DENAttribute ['rotation',[0,0,91.562]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3752.08,3771.11,29.591]];
	_o set3DENAttribute ['rotation',[0,0,91.562]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3754.08,3773.06,29.587]];
	_o set3DENAttribute ['rotation',[0,0,182.45]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3755.86,3770.69,29.5832]];
	_o set3DENAttribute ['rotation',[0,0,269.843]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3754,3767.46,33.2732]];
	_o set3DENAttribute ['rotation',[0,0,359.514]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3751.91,3764.46,33.3132]];
	_o set3DENAttribute ['rotation',[0,0,269.934]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "barikada_3", [0,0,0]];
	_o set3DENAttribute ['position',[3761.12,3765.32,29.7381]];
	_o set3DENAttribute ['rotation',[0,0,180.083]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_24\barikada_3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3751.5,3761.81,29.416]];
	_o set3DENAttribute ['rotation',[0,0,90.5593]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["headup","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3763.59,3752.08,24.5815]];
	_o set3DENAttribute ['rotation',[0,0,93.6108]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3763.53,3753.77,24.6229]];
	_o set3DENAttribute ['rotation',[0,0,12.6555]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "throne", [0,0,0]];
	_o set3DENAttribute ['position',[3763.92,3765.26,29.805]];
	_o set3DENAttribute ['rotation',[0,0,90.588]];

	_hash = [_o,'HeadThrone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashi4ek", [0,0,0]];
	_o set3DENAttribute ['position',[3756.82,3750.35,24.6137]];
	_o set3DENAttribute ['rotation',[0,0,8.6705]];

	_hash = [_o,'ContainerGreen2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shkafsin", [0,0,0]];
	_o set3DENAttribute ['position',[3753.97,3772.06,29.788]];
	_o set3DENAttribute ['rotation',[0,0,90.1379]];

	_hash = [_o,'SteelGreenCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shkafsin", [0,0,0]];
	_o set3DENAttribute ['position',[3752.49,3767.16,33.3096]];
	_o set3DENAttribute ['rotation',[0,0,90.1379]];

	_hash = [_o,'SteelGreenCabinet'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Главоключ"],["var","keyOwner",["super","gatemain","sbsmain"]]]]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryslo", [0,0,0]];
	_o set3DENAttribute ['position',[3749.02,3756.71,29.6681]];
	_o set3DENAttribute ['rotation',[0,0,270.149]];

	_hash = [_o,'RedLuxuryChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBed_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3744.12,3766.76,33.2367]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LuxuryDoubleBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sofa", [0,0,0]];
	_o set3DENAttribute ['position',[3747.97,3763.36,29.776]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'RedSofa'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.09,3765.31,30.738]];
	_o set3DENAttribute ['rotation',[0,0,270.893]];

	_hash = [_o,'ConcretePanel'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator", [0,0,0]];
	_o set3DENAttribute ['position',[3769.89,3759.15,30.2315]];
	_o set3DENAttribute ['rotation',[0,0,181.984]];

	_hash = [_o,'ElectricalShieldSmall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swAdmin"]] call mm_importOld_regFunc;

	[_o,'_transAdmin'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[3746.1,3763.02,30.5368]];
	_o set3DENAttribute ['rotation',[0,0,0.857433]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_1"]] call mm_importOld_regFunc;
	[_o,'radioSettings',[1,"enc_sta",-10,5,nil,1000,0]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3772.84,3755.97,29.9059]];
	_o set3DENAttribute ['rotation',[0,0,272.383]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swAdmin"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_1'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_knihovna", [0,0,0]];
	_o set3DENAttribute ['position',[3745.96,3760.7,33.2962]];
	_o set3DENAttribute ['rotation',[0,0,86.0056]];

	_hash = [_o,'SmallBookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_knihovna", [0,0,0]];
	_o set3DENAttribute ['position',[3745.96,3763.34,33.3845]];
	_o set3DENAttribute ['rotation',[0,0,86.0056]];

	_hash = [_o,'SmallBookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3750.98,3763.61,34.0222]];
	_o set3DENAttribute ['rotation',[0,0,177.828]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_pieces_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3747.64,3760.67,29.1631]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x18.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_biblastul", [0,0,0]];
	_o set3DENAttribute ['position',[3744.51,3761.26,29.9163]];
	_o set3DENAttribute ['rotation',[0,0,221.68]];

	_hash = [_o,'ChairLibrary'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_biblastul", [0,0,0]];
	_o set3DENAttribute ['position',[3744.67,3759.78,29.9192]];
	_o set3DENAttribute ['rotation',[0,0,118.472]];

	_hash = [_o,'ChairLibrary'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_biblastul", [0,0,0]];
	_o set3DENAttribute ['position',[3746.04,3760.98,29.7245]];
	_o set3DENAttribute ['rotation',[0,0,329.728]];

	_hash = [_o,'ChairLibrary'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3760.12,3766.66,29.8974]];
	_o set3DENAttribute ['rotation',[0,0,180.604]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3760.01,3763.96,29.9199]];
	_o set3DENAttribute ['rotation',[0,0,359.406]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3761.78,3763.88,29.8795]];
	_o set3DENAttribute ['rotation',[0,0,358.306]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3757.44,3763.21,29.877]];
	_o set3DENAttribute ['rotation',[0,0,0.507642]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3761.77,3766.59,29.8213]];
	_o set3DENAttribute ['rotation',[0,0,180.604]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3758.13,3763.28,29.8846]];
	_o set3DENAttribute ['rotation',[0,0,357.088]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[3745.11,3760.5,30.7338]];
	_o set3DENAttribute ['rotation',[0,0,308.299]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[3745.29,3760.54,30.7313]];
	_o set3DENAttribute ['rotation',[0,0,329.531]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[3745.11,3760.72,30.7331]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[3748.19,3757.65,30.6849]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "propeller", [0,0,0]];
	_o set3DENAttribute ['position',[3750.72,3762.86,43.6908]];
	_o set3DENAttribute ['rotation',[0,0,325.658]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_14_10\propeller.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vent_door1", [0,0,0]];
	_o set3DENAttribute ['position',[3765.05,3751.13,30.6637]];
	_o set3DENAttribute ['rotation',[0,0,270.659]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3752,3772.92,32.3536]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3752.28,3772.68,29.6775]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3769.08,3744.52,20.7437]];
	_o set3DENAttribute ['rotation',[270,79.9458,90]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_3x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3763.64,3761.29,26.1036]];
	_o set3DENAttribute ['rotation',[0,0,182.303]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_3x3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_i_Garage_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3759.96,3752.1,24.4492]];
	_o set3DENAttribute ['rotation',[0,0,188.828]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\addons\i_garage_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcPipeline_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3746.48,3749.87,30.0256]];
	_o set3DENAttribute ['rotation',[0,0,359.917]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcPipeline_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3746.46,3747.16,29.5735]];
	_o set3DENAttribute ['rotation',[340.743,0,359.917]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcPipeline_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3746.49,3744.38,28.5878]];
	_o set3DENAttribute ['rotation',[340.743,0,359.917]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l01_props_jail_panel", [0,0,0]];
	_o set3DENAttribute ['position',[3745.61,3765.78,29.9705]];
	_o set3DENAttribute ['rotation',[0,0,268.85]];

	_hash = [_o,'HeadControlPanel'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_adminbase_1"]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_6]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_5]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_4]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_3]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_2]] call mm_importOld_regFunc;
	[_o,'addSpeaker',[_spkr_1]] call mm_importOld_regFunc;

	[_o,'_headcon'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zhelstenabig", [0,0,0]];
	_o set3DENAttribute ['position',[3752.63,3767.99,31.9729]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\zhelstenabig.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zhelstenabig", [0,0,0]];
	_o set3DENAttribute ['position',[3746.51,3767.99,30.0754]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\zhelstenabig.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair01", [0,0,0]];
	_o set3DENAttribute ['position',[3746.71,3752.02,29.3032]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vitoriansofa", [0,0,0]];
	_o set3DENAttribute ['position',[3749.06,3756.15,33.1727]];
	_o set3DENAttribute ['rotation',[0,0,178.537]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\furniture\vitoriansofa.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stolempire", [0,0,0]];
	_o set3DENAttribute ['position',[3745.16,3760.6,29.7978]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\stolempire.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "koverchik", [0,0,0]];
	_o set3DENAttribute ['position',[3745.16,3760.74,29.7939]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\koverchik.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kovernew", [0,0,0]];
	_o set3DENAttribute ['position',[3749.8,3764.73,33.341]];
	_o set3DENAttribute ['rotation',[0,0,91.3405]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kovrik\kovernew.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kovernew", [0,0,0]];
	_o set3DENAttribute ['position',[3748.94,3757.01,29.8111]];
	_o set3DENAttribute ['rotation',[0,0,0.0900788]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kovrik\kovernew.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "carpet", [0,0,0]];
	_o set3DENAttribute ['position',[3749.18,3759.8,32.7362]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\carpet\carpet.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "carpet", [0,0,0]];
	_o set3DENAttribute ['position',[3748.55,3761.31,29.2943]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\carpet\carpet.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "wood_box_1", [0,0,0]];
	_o set3DENAttribute ['position',[3752.04,3766.08,33.3218]];
	_o set3DENAttribute ['rotation',[0,0,87.1431]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\wood_box_1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_psacistul", [0,0,0]];
	_o set3DENAttribute ['position',[3748.99,3758.09,29.7331]];
	_o set3DENAttribute ['rotation',[0,0,269.613]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\dhangar_psacistul.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Carpet_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3744.07,3763.45,33.259]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_interier\carpet_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TableSmall_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3749.13,3757.4,33.3116]];
	_o set3DENAttribute ['rotation',[0,0,86.0657]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\props_f_orange\furniture\tablesmall_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_pravo", [0,0,0]];
	_o set3DENAttribute ['position',[3751.22,3756.83,27.0237]];
	_o set3DENAttribute ['rotation',[0,0,89.6924]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_pravo.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_pravo", [0,0,0]];
	_o set3DENAttribute ['position',[3746.79,3756.72,27.0737]];
	_o set3DENAttribute ['rotation',[0,0,89.6924]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_pravo.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_centr", [0,0,0]];
	_o set3DENAttribute ['position',[3748.92,3755.86,27.0401]];
	_o set3DENAttribute ['rotation',[0,0,180.268]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_centr.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "picture_09", [0,0,0]];
	_o set3DENAttribute ['position',[3751.36,3759.91,34.7455]];
	_o set3DENAttribute ['rotation',[0,0,271.178]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\ml_plakats2\picture_09.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "picture_115", [0,0,0]];
	_o set3DENAttribute ['position',[3746.23,3765.51,34.742]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ml_plakats3\picture_115.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sobranka", [0,0,0]];
	_o set3DENAttribute ['position',[3755.61,3764.59,31.0171]];
	_o set3DENAttribute ['rotation',[0,0,0.123478]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\ml_plakats2\sobranka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "ironfelix", [0,0,0]];
	_o set3DENAttribute ['position',[3746.53,3765.7,34.7742]];
	_o set3DENAttribute ['rotation',[0,0,90.2965]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ml_plakats3\ironfelix.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "picture_119", [0,0,0]];
	_o set3DENAttribute ['position',[3748.9,3756.01,31.1513]];
	_o set3DENAttribute ['rotation',[0,0,359.222]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ml_plakats3\picture_119.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3750,3757.74,30.6505]];
	_o set3DENAttribute ['rotation',[0,0,86.6784]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3762.72,3752.97,25.2976]];
	_o set3DENAttribute ['rotation',[0,0,277.176]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Stone_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3770.74,3758.96,26.6923]];
	_o set3DENAttribute ['rotation',[0,0,1.93785]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\stone_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3754.38,3751.46,26.3787]];
	_o set3DENAttribute ['rotation',[0.40541,360,98.4811]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "archive_tube", [0,0,0]];
	_o set3DENAttribute ['position',[3755.01,3751.44,24.6184]];
	_o set3DENAttribute ['rotation',[0,0,190.525]];

	_hash = [_o,'RegistrationPaperArchive'] call mm_importOld_initHashData;
	[_o,'setHeadConsole',[_headcon]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenRed_F", [0,0,0]];
	_o set3DENAttribute ['position',[3763.7,3753.04,25.2874]];
	_o set3DENAttribute ['rotation',[0.351201,359.581,358.915]];

	_hash = [_o,'PenRed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenRed_F", [0,0,0]];
	_o set3DENAttribute ['position',[3749.82,3757.71,30.6885]];
	_o set3DENAttribute ['rotation',[0.351201,359.581,358.915]];

	_hash = [_o,'PenRed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Unfinished_Building_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3768.84,3779.99,24.031]];
	_o set3DENAttribute ['rotation',[0,0,358.624]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\wip\unfinished_building_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3774.81,3791.04,37.7922]];
	_o set3DENAttribute ['rotation',[0,0,262.255]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3767.11,3784.6,41.5807]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3746.26,3792.5,23.8783]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3764.54,3790.7,40.271]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3760.29,3782.94,32.702]];
	_o set3DENAttribute ['rotation',[0,0,359.064]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3766.86,3782.84,24.0767]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3767.07,3793.27,24.0914]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3750.26,3782.79,32.7157]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3753.86,3791.08,40.1033]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3765.05,3804.37,24.5358]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3756.7,3792.72,23.9592]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3754.68,3803.88,34.4981]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3765.52,3803.01,47.9117]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3754.79,3802.96,44.3369]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3774.7,3791.54,26.4448]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3768.05,3781.32,30.2044]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradehall"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3771.97,3786.04,25.0237]];
	_o set3DENAttribute ['rotation',[0,0,358.049]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3761.62,3795.3,22.1443]];
	_o set3DENAttribute ['rotation',[0,0,180.67]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3768.95,3798.13,28.7456]];
	_o set3DENAttribute ['rotation',[0,0,177.705]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3748.71,3797.67,28.762]];
	_o set3DENAttribute ['rotation',[0,0,177.705]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3766.73,3785.93,24.2862]];
	_o set3DENAttribute ['rotation',[0,0,358.376]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3773.41,3781.17,24.237]];
	_o set3DENAttribute ['rotation',[0,0,358.376]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_germozatvor_menu2", [0,0,0]];
	_o set3DENAttribute ['position',[3749.03,3791.7,23.9649]];
	_o set3DENAttribute ['rotation',[0,0,270.843]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\germozatvor_menu2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3769.53,3781.85,28.4679]];
	_o set3DENAttribute ['rotation',[0,0,317.584]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3770.64,3781.22,25.7129]];
	_o set3DENAttribute ['rotation',[210.81,272.827,148.881]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;

	[_o,'_sw_tradework'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3773.64,3781,25.8505]];
	_o set3DENAttribute ['rotation',[267.559,354.04,89.9745]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;

	[_o,'_sw_tradehall'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3771.02,3783.71,27.761]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3772.09,3784.58,27.6418]];
	_o set3DENAttribute ['rotation',[0,0,271.125]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Desk", [0,0,0]];
	_o set3DENAttribute ['position',[3769.66,3782.54,27.6268]];
	_o set3DENAttribute ['rotation',[0,0,267.085]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\desk\desk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashik", [0,0,0]];
	_o set3DENAttribute ['position',[3769.68,3781.32,27.6409]];
	_o set3DENAttribute ['rotation',[0,0,268.18]];

	_hash = [_o,'CaseBedroomMedium'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.72,3783.97,27.7057]];
	_o set3DENAttribute ['rotation',[0,0,266.389]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.88,3779.98,27.6386]];
	_o set3DENAttribute ['rotation',[0,0,270.125]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.68,3778.33,27.7079]];
	_o set3DENAttribute ['rotation',[0,0,0.117409]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3772.31,3784.94,27.761]];
	_o set3DENAttribute ['rotation',[0,0,182.398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3775.65,3781.44,24.1094]];
	_o set3DENAttribute ['rotation',[0,0,178.85]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3774.92,3780.18,24.1569]];
	_o set3DENAttribute ['rotation',[0,0,88.0497]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["torg","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[3766.17,3781.06,24.1532]];
	_o set3DENAttribute ['rotation',[0,0,357.97]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shkafsin", [0,0,0]];
	_o set3DENAttribute ['position',[3766.45,3779.22,24.1456]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGreenCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3769.91,3784.42,27.761]];
	_o set3DENAttribute ['rotation',[0,0,358.543]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_almara", [0,0,0]];
	_o set3DENAttribute ['position',[3771.81,3778.81,27.6122]];
	_o set3DENAttribute ['rotation',[0,0,177.941]];

	_hash = [_o,'LargeClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_h", [0,0,0]];
	_o set3DENAttribute ['position',[3768.92,3782.47,27.6873]];
	_o set3DENAttribute ['rotation',[0,0,268.775]];

	_hash = [_o,'RedPappedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator", [0,0,0]];
	_o set3DENAttribute ['position',[3773.47,3781.52,25.1106]];
	_o set3DENAttribute ['rotation',[0,0,357.042]];

	_hash = [_o,'ElectricalShieldSmall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swTrader"]] call mm_importOld_regFunc;

	[_o,'_transTrader'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3772.35,3779.49,27.1968]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradehall"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3768.44,3780.59,27.1962]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradehall"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3772.6,3783.94,27.1841]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradework"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CraneRail_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3757.12,3791.57,23.9269]];
	_o set3DENAttribute ['rotation',[0,0,270.328]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chashka_rja", [0,0,0]];
	_o set3DENAttribute ['position',[3769.88,3783.25,28.4474]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MetalCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3775.21,3785.52,23.4571]];
	_o set3DENAttribute ['rotation',[0,0,91.8435]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3775.18,3784.37,22.2766]];
	_o set3DENAttribute ['rotation',[0,0,90.427]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3770.41,3782.15,24.1261]];
	_o set3DENAttribute ['rotation',[0,0,90.427]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_K_6_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3767.57,3805.61,26.26]];
	_o set3DENAttribute ['rotation',[0.331022,359.608,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housek\house_k_6_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_okn", [0,0,0]];
	_o set3DENAttribute ['position',[3767.5,3785.84,27.6579]];
	_o set3DENAttribute ['rotation',[0,0,179.024]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3769.78,3791.57,23.8233]];
	_o set3DENAttribute ['rotation',[0,0,269.863]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcOutlet_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3772.38,3781.72,30.3719]];
	_o set3DENAttribute ['rotation',[1.86384,21.8732,91.8011]];

	_hash = [_o,'DeliveryPipe'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradehall"]] call mm_importOld_regFunc;

	[_o,'_dp_trader'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3775.23,3782.43,24.2879]];
	_o set3DENAttribute ['rotation',[0,0,88.0372]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3775,3777.93,24.2061]];
	_o set3DENAttribute ['rotation',[0,0,88.0372]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3775.26,3784.25,25.9136]];
	_o set3DENAttribute ['rotation',[0,0,88.0372]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3770.37,3784.15,24.2959]];
	_o set3DENAttribute ['rotation',[0,0,88.0372]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "table_nastil_1", [0,0,0]];
	_o set3DENAttribute ['position',[3774.75,3784.34,24.2783]];
	_o set3DENAttribute ['rotation',[0,0,89.0953]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\table_nastil_1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "koverold", [0,0,0]];
	_o set3DENAttribute ['position',[3771.79,3780.95,27.7038]];
	_o set3DENAttribute ['rotation',[0,0,266.872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kovrik\koverold.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_portfeluga", [0,0,0]];
	_o set3DENAttribute ['position',[3769.68,3780.91,27.679]];
	_o set3DENAttribute ['rotation',[0,0,352.406]];

	_hash = [_o,'Briefcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "case_1", [0,0,0]];
	_o set3DENAttribute ['position',[3766.18,3780.99,24.9192]];
	_o set3DENAttribute ['rotation',[0,0,82.0517]];

	_hash = [_o,'ShuttleBag'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_shelf", [0,0,0]];
	_o set3DENAttribute ['position',[3771.56,3782.88,24.2561]];
	_o set3DENAttribute ['rotation',[0,0,87.3829]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\generalstore\shelf.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_shelf", [0,0,0]];
	_o set3DENAttribute ['position',[3771.55,3784.58,24.243]];
	_o set3DENAttribute ['rotation',[0,0,90.2]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\generalstore\shelf.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_wooden_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3774.87,3782.33,24.2981]];
	_o set3DENAttribute ['rotation',[0,0,269.99]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\furniture\metal_wooden_rack_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "panelka", [0,0,0]];
	_o set3DENAttribute ['position',[3769.92,3782.48,28.4499]];
	_o set3DENAttribute ['rotation',[0,0,267.468]];

	_hash = [_o,'MerchantConsole'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_tradehall"]] call mm_importOld_regFunc;
	[_o,'linkPipe',[_dp_trader]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3769.9,3781.85,28.4495]];
	_o set3DENAttribute ['rotation',[0,0,174.593]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3764.91,3822.19,44.4413]];
	_o set3DENAttribute ['rotation',[0,0,243.027]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3764.64,3822.41,34.1648]];
	_o set3DENAttribute ['rotation',[0,0,243.813]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3757.04,3814.39,44.2475]];
	_o set3DENAttribute ['rotation',[0,0,296.367]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3757.16,3814.79,34.4136]];
	_o set3DENAttribute ['rotation',[0,0,296.622]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3766.24,3813.62,48.3629]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3765.08,3814.89,24.2922]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3773.32,3813.41,25.1625]];
	_o set3DENAttribute ['rotation',[0,0,175.8]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_12_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3773.78,3812.15,24.9125]];
	_o set3DENAttribute ['rotation',[0.368754,0.124046,176.098]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_12_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3806.4,3614.87,8.63734]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3803.42,3610.52,18.2759]];
	_o set3DENAttribute ['rotation',[0,0,311.783]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3807.5,3625.64,8.69944]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3800.5,3622.4,18.4894]];
	_o set3DENAttribute ['rotation',[0,0,283.173]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "propeller", [0,0,0]];
	_o set3DENAttribute ['position',[3805.42,3617.87,13.2478]];
	_o set3DENAttribute ['rotation',[359.995,77.6875,325.651]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_14_10\propeller.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.18,3711.39,32.1958]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3804.75,3709.37,22.7189]];
	_o set3DENAttribute ['rotation',[0,0,274.286]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3806.4,3707.77,25.584]];
	_o set3DENAttribute ['rotation',[0,0,2.37504]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3804.41,3709.31,25.584]];
	_o set3DENAttribute ['rotation',[0,0,90.1882]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_vojenska_palanda", [0,0,0]];
	_o set3DENAttribute ['position',[3805.23,3710.74,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_02_m_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3806.56,3711.54,22.2218]];
	_o set3DENAttribute ['rotation',[0,0,182.222]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_02_m_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3806.56,3711.52,23.6951]];
	_o set3DENAttribute ['rotation',[180.004,0.000291586,178.184]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "oruzhie_crate", [0,0,0]];
	_o set3DENAttribute ['position',[3806.99,3708.32,25.4989]];
	_o set3DENAttribute ['rotation',[0,0,178.814]];

	_hash = [_o,'WoodenWeaponBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3806.73,3711.64,28.3443]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3806.97,3708.02,25.0726]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.04,3721.57,32.2192]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.32,3741.71,34.1527]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3798.99,3741.94,24.3598]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3777.92,3733.8,29.0003]];
	_o set3DENAttribute ['rotation',[0,0,7.3807]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3777.79,3741.97,30.0784]];
	_o set3DENAttribute ['rotation',[0,0,359.349]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.2,3731.77,32.2444]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3777.85,3724.62,28.8263]];
	_o set3DENAttribute ['rotation',[0,0,354.454]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3806.47,3727.53,29.7051]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3805.25,3719.4,22.7874]];
	_o set3DENAttribute ['rotation',[0,0,274.286]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3804.99,3714.35,22.7382]];
	_o set3DENAttribute ['rotation',[0,0,271.002]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3806.37,3722.38,22.9985]];
	_o set3DENAttribute ['rotation',[0,0,353.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3805.43,3730.38,23.1817]];
	_o set3DENAttribute ['rotation',[0,0,357.33]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3806.72,3725.71,22.8772]];
	_o set3DENAttribute ['rotation',[0,0,29.5245]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3804.92,3727.28,25.4528]];
	_o set3DENAttribute ['rotation',[0,0,91.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3804.74,3721.29,25.442]];
	_o set3DENAttribute ['rotation',[0,0,91.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3804.52,3715.27,25.4282]];
	_o set3DENAttribute ['rotation',[0,0,91.718]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_vojenska_palanda", [0,0,0]];
	_o set3DENAttribute ['position',[3805.29,3714.25,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,2.35401]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\chairs\vojenska_palanda\vojenska_palanda.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3806.52,3725.15,25.5597]];
	_o set3DENAttribute ['rotation',[0,0,180.207]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3806.29,3715.52,25.4969]];
	_o set3DENAttribute ['rotation',[0,0,182.462]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3806.72,3724.96,26.8582]];
	_o set3DENAttribute ['rotation',[275.151,359.975,89.9981]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_sw_SecHome'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3805.95,3720.3,26.4052]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3807.73,3725,25.4954]];
	_o set3DENAttribute ['rotation',[0,0,179.845]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbshome","sbsmain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x6", [0,0,0]];
	_o set3DENAttribute ['position',[3806.4,3716.5,29.913]];
	_o set3DENAttribute ['rotation',[0,0,0.609165]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_3okn", [0,0,0]];
	_o set3DENAttribute ['position',[3807.24,3730.38,25.2131]];
	_o set3DENAttribute ['rotation',[0,0,359.687]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_3o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3805.09,3723.2,25.5529]];
	_o set3DENAttribute ['rotation',[0,0,272.095]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_02_m_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3806.71,3717.06,22.2054]];
	_o set3DENAttribute ['rotation',[0,0,182.222]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_02_m_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3806.7,3717.04,23.6787]];
	_o set3DENAttribute ['rotation',[180.004,0.000291586,178.184]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\net\netfence_02_m_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3807.89,3731.17,22.2171]];
	_o set3DENAttribute ['rotation',[0,0,274.348]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3806.39,3719.55,25.5506]];
	_o set3DENAttribute ['rotation',[0,0,173.963]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3806.41,3721.13,25.5529]];
	_o set3DENAttribute ['rotation',[0,0,13.4073]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3805.4,3719.45,25.5506]];
	_o set3DENAttribute ['rotation',[0,0,192.532]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3805.45,3721.17,25.5529]];
	_o set3DENAttribute ['rotation',[0,0,336.718]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[3805.13,3716.8,25.4897]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["BalaclavaMask2",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3807.08,3728.12,28.0201]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHall"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3807.21,3721.21,28.3376]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3807.06,3718.03,28.3354]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3805.24,3720.3,26.4052]];
	_o set3DENAttribute ['rotation',[0,0,205.818]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3805.38,3720.42,26.4052]];
	_o set3DENAttribute ['rotation',[0,0,228.977]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3805.39,3720.28,26.4052]];
	_o set3DENAttribute ['rotation',[0,0,68.0782]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3805.25,3720.43,26.4052]];
	_o set3DENAttribute ['rotation',[0,0,271.591]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3806.98,3713.02,25.07]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3806.99,3722.87,25.0415]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3806.99,3717.99,25.0392]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3806.97,3727.84,24.9414]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TableBig_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3805.96,3720.3,25.515]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\props_f_orange\furniture\tablebig_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_Wall_D_left_F", [0,0,0]];
	_o set3DENAttribute ['position',[3807.46,3729.09,35.173]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wall_d_left_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3798.67,3772.77,43.8079]];
	_o set3DENAttribute ['rotation',[0,0,92.4415]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.13,3752.4,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3778.5,3752.02,24.3876]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3789.84,3752.31,41.9562]];
	_o set3DENAttribute ['rotation',[359.593,347.2,0.0879686]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3782.04,3763.35,43.5641]];
	_o set3DENAttribute ['rotation',[359.587,343.606,0.11453]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3788.71,3762.67,24.2991]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3799.13,3752,24.4006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3781.05,3752.48,43.8701]];
	_o set3DENAttribute ['rotation',[359.592,346.374,0.0940415]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3788.6,3752.05,24.3104]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3778.61,3762.63,24.5236]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3799.54,3762.43,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3799.08,3773.05,24.365]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3788.58,3772.98,24.3807]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3777.73,3773.53,24.3345]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3778.39,3774.16,37.7315]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3789.2,3772.35,43.9272]];
	_o set3DENAttribute ['rotation',[0,0,357.613]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3790.24,3762.35,42.2337]];
	_o set3DENAttribute ['rotation',[359.599,351.646,0.0560686]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3781.82,3751.55,23.9593]];
	_o set3DENAttribute ['rotation',[0,0,244.709]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3797.65,3749.38,23.9718]];
	_o set3DENAttribute ['rotation',[0,0,279.274]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3792.08,3749.85,23.9824]];
	_o set3DENAttribute ['rotation',[0,0,271.233]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3797.38,3775.49,23.8879]];
	_o set3DENAttribute ['rotation',[0,0,91.0917]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3797.44,3775.58,24.3241]];
	_o set3DENAttribute ['rotation',[0,0,0.959836]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3798.46,3747.73,24.4765]];
	_o set3DENAttribute ['rotation',[0,0,84.7797]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3779.87,3753.16,27.1101]];
	_o set3DENAttribute ['rotation',[0,0,63.3375]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3781.15,3750.51,27.0968]];
	_o set3DENAttribute ['rotation',[0,0,62.6431]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3798.8,3749.34,26.6289]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3778.42,3774.44,26.3779]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3807.23,3760.43,27.0281]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySec"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3800.43,3763.27,29.9495]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3797.27,3774.48,32.4401]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3793.37,3749.77,29.9418]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3782.32,3751.88,32.0807]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3791.64,3751.34,26.5432]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3799.14,3749.39,29.9282]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_medprivate"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3788.35,3751.13,30.8161]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CastleRuins_01_wall_10m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3802.85,3761.98,24.7022]];
	_o set3DENAttribute ['rotation',[0,0,272.303]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CastleRuins_01_wall_10m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.92,3765.84,24.4005]];
	_o set3DENAttribute ['rotation',[0,0,181.712]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CastleRuins_01_wall_10m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3793.74,3762.33,24.4785]];
	_o set3DENAttribute ['rotation',[0,0,88.2896]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3785.82,3755.48,26.174]];
	_o set3DENAttribute ['rotation',[0,0,0.19764]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3779.27,3750.64,24.6112]];
	_o set3DENAttribute ['rotation',[0,0,244.781]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3797.3,3759.51,25.4067]];
	_o set3DENAttribute ['rotation',[0,0,357.795]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3800.16,3759.68,28.638]];
	_o set3DENAttribute ['rotation',[0,0,359.209]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3803.53,3764.62,28.6466]];
	_o set3DENAttribute ['rotation',[178.546,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3799.46,3752.11,29.3044]];
	_o set3DENAttribute ['rotation',[182.353,0.91674,348.828]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3801.41,3749.28,29.2068]];
	_o set3DENAttribute ['rotation',[180.285,357.491,93.6964]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3801.68,3757.89,22.5772]];
	_o set3DENAttribute ['rotation',[0,0,209.028]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3785.85,3774.79,23.3319]];
	_o set3DENAttribute ['rotation',[0,0,136.479]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3789.97,3754.85,22.9274]];
	_o set3DENAttribute ['rotation',[0,0,0.0828579]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3782.34,3768.19,23.7563]];
	_o set3DENAttribute ['rotation',[0,0,205.364]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3779.57,3750.65,27.0438]];
	_o set3DENAttribute ['rotation',[0,0,245.025]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3784.28,3746.17,24.1863]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3806.67,3766.08,27.5467]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3792.18,3762.83,25.125]];
	_o set3DENAttribute ['rotation',[0,0,271.445]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_Uup_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.27,3764.15,23.1814]];
	_o set3DENAttribute ['rotation',[0,0,359.948]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_uup_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3797.97,3763.79,27.9472]];
	_o set3DENAttribute ['rotation',[0,0,87.184]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3796.61,3751.3,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,272.865]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["medhome","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3807.59,3762.03,27.5648]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_6","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3782.07,3755.08,24.3781]];
	_o set3DENAttribute ['rotation',[0,0,155.588]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["medpublic","medmain","super"]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3801.22,3759.56,24.398]];
	_o set3DENAttribute ['rotation',[0,0,0.774458]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["pump","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3807.5,3761.8,24.4904]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_3","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3803.91,3749.36,24.5659]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3806.35,3761.9,27.5986]];
	_o set3DENAttribute ['rotation',[0,0,179.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3806.31,3761.64,24.4685]];
	_o set3DENAttribute ['rotation',[0,0,179.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3785.34,3749.52,27.1318]];
	_o set3DENAttribute ['rotation',[0,0,93.2224]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3797.96,3762.59,27.9602]];
	_o set3DENAttribute ['rotation',[0,0,89.7225]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3788.83,3750.35,24.4736]];
	_o set3DENAttribute ['rotation',[0,0,271.139]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_90degR_F", [0,0,0]];
	_o set3DENAttribute ['position',[3801.76,3764.12,29.6653]];
	_o set3DENAttribute ['rotation',[0,0,267.077]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3799.77,3774.19,25.1542]];
	_o set3DENAttribute ['rotation',[0,0,53.8189]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3779.71,3753.15,25.3476]];
	_o set3DENAttribute ['rotation',[0,0,63.8388]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3795.47,3755.93,22.2004]];
	_o set3DENAttribute ['rotation',[0,0,2.52382]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3805.64,3756.04,21.8303]];
	_o set3DENAttribute ['rotation',[0,0,2.6146]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3792.65,3771.29,22.9919]];
	_o set3DENAttribute ['rotation',[0,0,88.0685]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3785.69,3751.83,25.8185]];
	_o set3DENAttribute ['rotation',[220.837,86.7899,40.6021]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;

	[_o,'_sw_medcommon'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3796.8,3749.99,28.566]];
	_o set3DENAttribute ['rotation',[186.85,272.446,172.867]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;

	[_o,'_sw_medprivate'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3799.41,3772.79,25.4719]];
	_o set3DENAttribute ['rotation',[92.4394,354.444,269.486]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;

	[_o,'_swGateLib'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3799.24,3748.05,25.3411]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LiqDemitolin'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3798.08,3750.41,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LiqPainkiller'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3799.05,3748.05,25.3411]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LiqPainkiller'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3799.08,3747.86,25.3411]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LiqTovimin'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3804.56,3765.58,27.6053]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3799.41,3747.7,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,279.137]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3800.64,3748.57,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,6.74907]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["DoctorCloth",2,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lekarnicka", [0,0,0]];
	_o set3DENAttribute ['position',[3778.24,3752.67,25.4582]];
	_o set3DENAttribute ['rotation',[0,0,245.781]];

	_hash = [_o,'WallmountedMedicalCabinet'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Bandage",1+(floor random 2),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["PainkillerBox",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lekarnicka", [0,0,0]];
	_o set3DENAttribute ['position',[3793.83,3752.8,25.596]];
	_o set3DENAttribute ['rotation',[0,0,358.33]];

	_hash = [_o,'WallmountedMedicalCabinet'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Bandage",10+(floor random 5),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["PainkillerBox",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lekarnicka", [0,0,0]];
	_o set3DENAttribute ['position',[3779.31,3750.9,28.3935]];
	_o set3DENAttribute ['rotation',[0,0,245.781]];

	_hash = [_o,'WallmountedMedicalCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_OfficeCabinet_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3779.47,3751.25,24.5143]];
	_o set3DENAttribute ['rotation',[0,0,245.866]];

	_hash = [_o,'OfficeCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Desk", [0,0,0]];
	_o set3DENAttribute ['position',[3798.72,3750.52,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,7.61516]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\desk\desk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashik", [0,0,0]];
	_o set3DENAttribute ['position',[3800.41,3773.02,25.1767]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CaseBedroomMedium'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashik", [0,0,0]];
	_o set3DENAttribute ['position',[3800.42,3773.02,24.5182]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CaseBedroomMedium'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3797.14,3772.21,28.4833]];
	_o set3DENAttribute ['rotation',[0,0,269.079]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3789.63,3749.23,27.233]];
	_o set3DENAttribute ['rotation',[0,0,269.855]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3792.31,3751.65,27.0545]];
	_o set3DENAttribute ['rotation',[0.556189,354.222,2.22658]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x6", [0,0,0]];
	_o set3DENAttribute ['position',[3786.09,3746.31,23.9758]];
	_o set3DENAttribute ['rotation',[0,0,359.957]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3801.52,3749.24,24.6999]];
	_o set3DENAttribute ['rotation',[359.598,359.951,271.377]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3798.79,3752.2,24.6971]];
	_o set3DENAttribute ['rotation',[0,0,190.088]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3791.05,3753.04,24.6764]];
	_o set3DENAttribute ['rotation',[0,0.398,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3791.06,3751.13,24.5716]];
	_o set3DENAttribute ['rotation',[0,0,359.565]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3787.34,3753.22,24.7671]];
	_o set3DENAttribute ['rotation',[0,0,87.844]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3800.14,3765.38,29.2268]];
	_o set3DENAttribute ['rotation',[0,0,1.33592]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3800.03,3772.53,28.8306]];
	_o set3DENAttribute ['rotation',[0,0,359.567]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3802.56,3761.99,29.1155]];
	_o set3DENAttribute ['rotation',[0,0,91.2628]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3794.16,3772.6,28.8306]];
	_o set3DENAttribute ['rotation',[0,0,359.567]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3792.11,3774.47,28.7543]];
	_o set3DENAttribute ['rotation',[0,0,89.9998]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3792.49,3753.77,24.2827]];
	_o set3DENAttribute ['rotation',[0,0,271.336]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3798.27,3772.67,24.2039]];
	_o set3DENAttribute ['rotation',[0,0,1.81387]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["gatepub","gatemain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3794.96,3752.96,24.2611]];
	_o set3DENAttribute ['rotation',[0,0,359.289]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["medprivate","medmain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3788.72,3749.15,24.0213]];
	_o set3DENAttribute ['rotation',[0,0,89.8896]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["medprivate","medmain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3800.27,3774.05,24.4577]];
	_o set3DENAttribute ['rotation',[0,0,85.2953]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3798.87,3774.15,24.4473]];
	_o set3DENAttribute ['rotation',[0,0,261.856]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3799.1,3751.33,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,0.513594]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3779.32,3752.64,24.6487]];
	_o set3DENAttribute ['rotation',[0,0,259.588]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3798.38,3751.29,24.4768]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed5", [0,0,0]];
	_o set3DENAttribute ['position',[3804.92,3765.05,24.4484]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashi4ek", [0,0,0]];
	_o set3DENAttribute ['position',[3797.41,3747.41,27.1597]];
	_o set3DENAttribute ['rotation',[0,0,4.70099]];

	_hash = [_o,'ContainerGreen2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3806.64,3766.09,24.4475]];
	_o set3DENAttribute ['rotation',[0,0,281.324]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.65,3774.7,24.3897]];
	_o set3DENAttribute ['rotation',[0,0,89.3994]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.64,3774.46,24.3597]];
	_o set3DENAttribute ['rotation',[0,0,269.318]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.64,3772.98,24.3349]];
	_o set3DENAttribute ['rotation',[0,0,89.079]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_9", [0,0,0]];
	_o set3DENAttribute ['position',[3806.62,3766.58,28.3899]];
	_o set3DENAttribute ['rotation',[0,0,182.564]];

	_hash = [_o,'SteelBrownContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator", [0,0,0]];
	_o set3DENAttribute ['position',[3800.07,3751.39,24.9427]];
	_o set3DENAttribute ['rotation',[0,0,189.248]];

	_hash = [_o,'ElectricalShieldSmall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swMedical"]] call mm_importOld_regFunc;

	[_o,'_transMed'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3791.72,3772.99,27.2255]];
	_o set3DENAttribute ['rotation',[0,0,86.5147]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySquare"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_2'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3802.07,3756.64,28.2704]];
	_o set3DENAttribute ['rotation',[0,0,33.5382]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_3'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3805.27,3760.78,27.4558]];
	_o set3DENAttribute ['rotation',[0,0,180.408]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3789.42,3751.07,27.4006]];
	_o set3DENAttribute ['rotation',[0,0,91.3542]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3787.14,3750.07,27.3018]];
	_o set3DENAttribute ['rotation',[0,4.69758,180.409]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_UrnaMetall", [0,0,0]];
	_o set3DENAttribute ['position',[3782.97,3755.88,24.3282]];
	_o set3DENAttribute ['rotation',[0,0,88.0526]];

	_hash = [_o,'TrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "turbosos", [0,0,0]];
	_o set3DENAttribute ['position',[3798.78,3761.31,23.2586]];
	_o set3DENAttribute ['rotation',[0,0,178.766]];

	_hash = [_o,'BigPipePump'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SignB_Pharmacy", [0,0,0]];
	_o set3DENAttribute ['position',[3784.3,3756.15,26.6706]];
	_o set3DENAttribute ['rotation',[0,0,83.5384]];

	_hash = [_o,'SignMedical'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transMed"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3780.83,3752.38,26.8276]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_medcommon"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3787.39,3749.82,27.234]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_medcommon"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3798.35,3775.44,26.7818]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swGateLib"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "med_crate", [0,0,0]];
	_o set3DENAttribute ['position',[3800.32,3747.99,24.4768]];
	_o set3DENAttribute ['rotation',[0,0,274.608]];

	_hash = [_o,'WoodenMedicalBox'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["PainkillerBox",12+(floor random 3),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["CetalinBox",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["KoradizinBox",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["LiqTovimin",1+(floor random 3),100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["NeedleWithThreads",1+(floor random 5),100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "med_crate", [0,0,0]];
	_o set3DENAttribute ['position',[3782.89,3748.62,27.0845]];
	_o set3DENAttribute ['rotation',[0,0,180.305]];

	_hash = [_o,'WoodenMedicalBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_knihovna", [0,0,0]];
	_o set3DENAttribute ['position',[3800.82,3750.63,27.1774]];
	_o set3DENAttribute ['rotation',[0,0,97.7063]];

	_hash = [_o,'SmallBookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_hospital_bench", [0,0,0]];
	_o set3DENAttribute ['position',[3783.6,3755.02,24.5402]];
	_o set3DENAttribute ['rotation',[0,0,359.123]];

	_hash = [_o,'HospitalBench'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_hospital_bench", [0,0,0]];
	_o set3DENAttribute ['position',[3785.13,3754.46,24.4695]];
	_o set3DENAttribute ['rotation',[0,0,91.0657]];

	_hash = [_o,'HospitalBench'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3779.42,3761.83,24.702]];
	_o set3DENAttribute ['rotation',[0,0,71.9343]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_pieces_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjKreslo", [0,0,0]];
	_o set3DENAttribute ['position',[3807.9,3766.21,27.5667]];
	_o set3DENAttribute ['rotation',[0,0,266.918]];

	_hash = [_o,'BumArmChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3780.82,3751.18,24.4643]];
	_o set3DENAttribute ['rotation',[0,0,328.834]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3781.77,3751.42,24.4643]];
	_o set3DENAttribute ['rotation',[0,0,2.75034]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3780,3750.67,24.4545]];
	_o set3DENAttribute ['rotation',[0,0,328.834]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3781.98,3753.24,24.4289]];
	_o set3DENAttribute ['rotation',[0,0,73.0715]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3781.55,3754.15,24.4221]];
	_o set3DENAttribute ['rotation',[0,0,56.2109]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3785.88,3752.56,24.3912]];
	_o set3DENAttribute ['rotation',[0,0,93.6995]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3783.91,3750.81,24.4328]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3785.89,3754.68,24.2858]];
	_o set3DENAttribute ['rotation',[0,0,86.7729]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_e", [0,0,0]];
	_o set3DENAttribute ['position',[3780.68,3753.24,24.4406]];
	_o set3DENAttribute ['rotation',[0,0,93.4033]];

	_hash = [_o,'SmallRedseatChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3791.1,3769.06,20.8233]];
	_o set3DENAttribute ['rotation',[0,0,74.2884]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3776.79,3764.65,20.8265]];
	_o set3DENAttribute ['rotation',[0,0,324.462]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3801.34,3754.29,20.1357]];
	_o set3DENAttribute ['rotation',[0,0,201.746]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3799.43,3750.51,27.9981]];
	_o set3DENAttribute ['rotation',[0,0,60.7979]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3799.87,3759.5,23.6775]];
	_o set3DENAttribute ['rotation',[0,0,180.52]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3807.2,3766.37,27.431]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3782.14,3749.29,26.891]];
	_o set3DENAttribute ['rotation',[0,0,333.19]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3796.16,3761.21,27.7215]];
	_o set3DENAttribute ['rotation',[0,0,358.551]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3780.67,3752.4,26.9162]];
	_o set3DENAttribute ['rotation',[0,0,333.19]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3783.31,3753.4,26.9013]];
	_o set3DENAttribute ['rotation',[0,0,254.399]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3796.08,3764.62,27.7289]];
	_o set3DENAttribute ['rotation',[0,0,358.551]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3784.23,3750.24,26.9201]];
	_o set3DENAttribute ['rotation',[0,0,273.597]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3796.07,3774.64,24.2297]];
	_o set3DENAttribute ['rotation',[0,0,2.9863]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3799.72,3774.55,24.2387]];
	_o set3DENAttribute ['rotation',[0,0,2.9863]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zabori", [0,0,0]];
	_o set3DENAttribute ['position',[3794.95,3753.11,27.6968]];
	_o set3DENAttribute ['rotation',[0,0,6.11192]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\zabori.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_Wall_D_right_F", [0,0,0]];
	_o set3DENAttribute ['position',[3800.97,3771.08,28.3354]];
	_o set3DENAttribute ['rotation',[0,0,275.787]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wall_d_right_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_kletka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.18,3750.28,23.8563]];
	_o set3DENAttribute ['rotation',[0,0,189.131]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_kletka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3799.24,3749.08,26.8696]];
	_o set3DENAttribute ['rotation',[0,0,2.75482]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_stolb_6m", [0,0,0]];
	_o set3DENAttribute ['position',[3785.92,3751.85,24.3268]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\stolb_6m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "burzhuika", [0,0,0]];
	_o set3DENAttribute ['position',[3801.74,3760.12,27.934]];
	_o set3DENAttribute ['rotation',[0,0,254.88]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\burzhuika\burzhuika.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "baloonexo", [0,0,0]];
	_o set3DENAttribute ['position',[3800.72,3749.53,24.3118]];
	_o set3DENAttribute ['rotation',[0,0,96.4481]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\baloonexo.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_Rugs1_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3807.39,3752.32,21.2677]];
	_o set3DENAttribute ['rotation',[0,0,226.192]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_rugs1_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3800.25,3761,27.7815]];
	_o set3DENAttribute ['rotation',[0,0,87.6001]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3800.17,3763.75,27.8008]];
	_o set3DENAttribute ['rotation',[0,0,87.6001]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kolonkawater", [0,0,0]];
	_o set3DENAttribute ['position',[3797.46,3762.31,23.3139]];
	_o set3DENAttribute ['rotation',[0,0,90.7384]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\kolonkawater.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3795.45,3772.72,24.8312]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3779.69,3754,28.0719]];
	_o set3DENAttribute ['rotation',[0,0,152.69]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3782.08,3755.04,27.032]];
	_o set3DENAttribute ['rotation',[0,0,161.591]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3784.94,3753.95,27.0905]];
	_o set3DENAttribute ['rotation',[0,0,253.5]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l19_cell_type_03", [0,0,0]];
	_o set3DENAttribute ['position',[3776.47,3747.93,30.0324]];
	_o set3DENAttribute ['rotation',[269.469,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\l19_cell_type_03.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l19_cell_type_03", [0,0,0]];
	_o set3DENAttribute ['position',[3791.79,3747.88,30.0963]];
	_o set3DENAttribute ['rotation',[273.204,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\l19_cell_type_03.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3798.31,3761.09,23.3206]];
	_o set3DENAttribute ['rotation',[0,0,178.912]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.75,3758.43,23.7642]];
	_o set3DENAttribute ['rotation',[0,0,88.5681]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medicbag", [0,0,0]];
	_o set3DENAttribute ['position',[3797.99,3747.89,25.316]];
	_o set3DENAttribute ['rotation',[1.53674,1.4017,345.328]];

	_hash = [_o,'MedicalBag'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medicbag", [0,0,0]];
	_o set3DENAttribute ['position',[3798.39,3747.75,25.3204]];
	_o set3DENAttribute ['rotation',[1.78539,1.06707,356.831]];

	_hash = [_o,'MedicalBag'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medicbag", [0,0,0]];
	_o set3DENAttribute ['position',[3797.59,3747.7,25.3019]];
	_o set3DENAttribute ['rotation',[1.84164,0.966718,0]];

	_hash = [_o,'MedicalBag'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_medbox", [0,0,0]];
	_o set3DENAttribute ['position',[3798.58,3750.6,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelMedicalBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_medbox", [0,0,0]];
	_o set3DENAttribute ['position',[3780.49,3753.64,27.9613]];
	_o set3DENAttribute ['rotation',[0,0,153.176]];

	_hash = [_o,'SteelMedicalBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed1", [0,0,0]];
	_o set3DENAttribute ['position',[3781.1,3749.86,24.4415]];
	_o set3DENAttribute ['rotation',[0,0,243.953]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed1", [0,0,0]];
	_o set3DENAttribute ['position',[3787.39,3752.05,24.3023]];
	_o set3DENAttribute ['rotation',[0,0,92.4297]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed1", [0,0,0]];
	_o set3DENAttribute ['position',[3787.21,3754.33,24.2635]];
	_o set3DENAttribute ['rotation',[0,0,84.8221]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed1", [0,0,0]];
	_o set3DENAttribute ['position',[3783.88,3749.55,24.4983]];
	_o set3DENAttribute ['rotation',[0,0,180.511]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "surgtable", [0,0,0]];
	_o set3DENAttribute ['position',[3791.75,3751.27,24.3286]];
	_o set3DENAttribute ['rotation',[0,0,273.11]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\surgtable.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "autopsy", [0,0,0]];
	_o set3DENAttribute ['position',[3789.63,3751.31,24.2056]];
	_o set3DENAttribute ['rotation',[0,0,90.8278]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\autopsy\autopsy.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SmallTable", [0,0,0]];
	_o set3DENAttribute ['position',[3798.36,3750.55,24.4416]];
	_o set3DENAttribute ['rotation',[0,0,0.179889]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\smalltable\smalltable.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "OfficeTable_01_old_F", [0,0,0]];
	_o set3DENAttribute ['position',[3780,3753,24.5033]];
	_o set3DENAttribute ['rotation',[0,0,65.8498]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_heli\furniture\officetable_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_conference_table_a", [0,0,0]];
	_o set3DENAttribute ['position',[3799.64,3774.06,24.4565]];
	_o set3DENAttribute ['rotation',[0,0,88.0797]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Bench_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3801.72,3762.64,28.003]];
	_o set3DENAttribute ['rotation',[0,0,179.905]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Bench_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3798.51,3761.25,27.9604]];
	_o set3DENAttribute ['rotation',[0,0,178.591]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Bench_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3800.1,3764.68,28.003]];
	_o set3DENAttribute ['rotation',[0,0,267.954]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_interier\bench_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_bucket", [0,0,0]];
	_o set3DENAttribute ['position',[3799.59,3764.62,28.5366]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Bucket'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_bucket", [0,0,0]];
	_o set3DENAttribute ['position',[3799.12,3760.27,27.9837]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Bucket'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3799.5,3774.59,25.1588]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3779.68,3753.37,25.3293]];
	_o set3DENAttribute ['rotation',[0,0,331.338]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "syringe", [0,0,0]];
	_o set3DENAttribute ['position',[3798.01,3750.68,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,182.649]];

	_hash = [_o,'Syringe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "syringe", [0,0,0]];
	_o set3DENAttribute ['position',[3797.96,3750.68,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,182.649]];

	_hash = [_o,'Syringe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "syringe", [0,0,0]];
	_o set3DENAttribute ['position',[3798.12,3750.68,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,182.649]];

	_hash = [_o,'Syringe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "syringe", [0,0,0]];
	_o set3DENAttribute ['position',[3798.07,3750.68,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,182.649]];

	_hash = [_o,'Syringe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "syringe", [0,0,0]];
	_o set3DENAttribute ['position',[3798.18,3750.68,25.2471]];
	_o set3DENAttribute ['rotation',[0,0,182.649]];

	_hash = [_o,'Syringe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3779.72,3753.99,26.2955]];
	_o set3DENAttribute ['rotation',[0,0,334.205]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3796.51,3748.65,29.1457]];
	_o set3DENAttribute ['rotation',[0,0,93.7536]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3788.91,3753.73,25.767]];
	_o set3DENAttribute ['rotation',[0.402196,0.0509912,91.1866]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3798.94,3783.33,44.0595]];
	_o set3DENAttribute ['rotation',[0,0,92.4415]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3789.17,3783.25,43.8289]];
	_o set3DENAttribute ['rotation',[0,0,89.7424]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3778.18,3784.77,37.5535]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3777.44,3784.07,24.1575]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3787.84,3794.11,24.2537]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3798.4,3794.4,24.3349]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3788.64,3783.53,24.2861]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3799.15,3783.6,24.2704]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3777.53,3793.83,24.0688]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3797.8,3804.69,24.3314]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3776.25,3804.54,24.5346]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3787.52,3803.97,48.5782]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3798.87,3804.45,48.4021]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3776.5,3803.3,48.6053]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3789.94,3794.12,47.9856]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3800.16,3795.8,48.3595]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3780.03,3794.58,48.727]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3794.05,3786.82,26.1651]];
	_o set3DENAttribute ['rotation',[33.2998,89.2308,33.3022]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3794.03,3779.74,26.2876]];
	_o set3DENAttribute ['rotation',[33.2998,89.2308,33.3022]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3794.11,3786.22,32.1014]];
	_o set3DENAttribute ['rotation',[33.2998,89.2308,33.3022]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3801.09,3783.15,28.7559]];
	_o set3DENAttribute ['rotation',[0,0,273.742]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swGate"]] call mm_importOld_regFunc;

	[_o,'_transGate'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3786.42,3781.4,28.7196]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGridDoorElectronic'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swact_gatejailtemp"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3799.04,3780.14,28.5559]];
	_o set3DENAttribute ['rotation',[0,0,1.6905]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["gatepriv","gatemain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3786.36,3781.45,28.9061]];
	_o set3DENAttribute ['rotation',[0,0,269.868]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3798.99,3780.19,28.7424]];
	_o set3DENAttribute ['rotation',[0,0,271.559]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3778.09,3781.97,26.3607]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transTrader"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3789.03,3779.83,32.2169]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3797.84,3783.05,32.5968]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall2_Corner_2", [0,0,0]];
	_o set3DENAttribute ['position',[3780.35,3791.02,23.7757]];
	_o set3DENAttribute ['rotation',[0.19334,0.337735,43.5784]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall2_corner_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall2_Corner_2", [0,0,0]];
	_o set3DENAttribute ['position',[3778.69,3795.17,23.3776]];
	_o set3DENAttribute ['rotation',[0.239945,0.305422,51.9362]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall2_corner_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3792.1,3786.87,22.6852]];
	_o set3DENAttribute ['rotation',[0,0,218.205]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3788.01,3776.85,32.5764]];
	_o set3DENAttribute ['rotation',[187.65,359.834,181.283]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3802.8,3779.26,28.7106]];
	_o set3DENAttribute ['rotation',[0,0,89.3699]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3805.6,3790.62,28.7262]];
	_o set3DENAttribute ['rotation',[0,0,180.028]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3788.79,3789.18,33.5182]];
	_o set3DENAttribute ['rotation',[187.65,359.834,181.283]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3783.13,3779.12,28.3614]];
	_o set3DENAttribute ['rotation',[0,0,89.3699]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_WallSmall_10m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3794.44,3777.13,27.7983]];
	_o set3DENAttribute ['rotation',[0,0,91.1823]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wallsmall_10m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Crowbar_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.21,3778.94,24.8002]];
	_o set3DENAttribute ['rotation',[0,0,263.571]];

	_hash = [_o,'Crowbar'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3785.32,3790.74,24.8223]];
	_o set3DENAttribute ['rotation',[0,0,32.9066]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PenBlack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.05,3782.42,25.1226]];
	_o set3DENAttribute ['rotation',[0,0,138.258]];

	_hash = [_o,'PenBlack'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3786.2,3785.1,23.0675]];
	_o set3DENAttribute ['rotation',[0,0,178.056]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3798.72,3778.72,25.7704]];
	_o set3DENAttribute ['rotation',[92.4351,4.32499,269.905]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;

	[_o,'_swGateWork'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3800.26,3788.24,24.4442]];
	_o set3DENAttribute ['rotation',[0,0,271.653]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.17,3780.23,24.3422]];
	_o set3DENAttribute ['rotation',[0,0,357.693]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.14,3780.56,24.3372]];
	_o set3DENAttribute ['rotation',[0,0,176.574]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.02,3780.52,24.319]];
	_o set3DENAttribute ['rotation',[0,0,176.574]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.19,3778.94,24.2619]];
	_o set3DENAttribute ['rotation',[0,0,176.574]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796,3780.11,24.2795]];
	_o set3DENAttribute ['rotation',[0,0,357.693]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3795.94,3778.82,24.2615]];
	_o set3DENAttribute ['rotation',[0,0,176.574]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3793.99,3776.03,28.9642]];
	_o set3DENAttribute ['rotation',[0,0,180.049]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.46,3776.1,29.0002]];
	_o set3DENAttribute ['rotation',[0,0,178.533]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3796.95,3784.39,28.4305]];
	_o set3DENAttribute ['rotation',[0,0,269.569]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3798.17,3785.45,28.4163]];
	_o set3DENAttribute ['rotation',[0,0,0.321407]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3794.74,3784.34,28.4687]];
	_o set3DENAttribute ['rotation',[0,0,269.569]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3795.03,3784.77,25.1413]];
	_o set3DENAttribute ['rotation',[0,0,88.8806]];

	_hash = [_o,'PowerSwitcher_Activator'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o,'name',"Внутренние врата"] call mm_importOld_regVar;

	[_o,'_gateact_internal'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3795.04,3785.1,25.1309]];
	_o set3DENAttribute ['rotation',[0,0,88.8806]];

	_hash = [_o,'PowerSwitcher_Activator'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o,'name',"Внешние врата"] call mm_importOld_regVar;

	[_o,'_gateact_external'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3796.3,3781.04,29.8097]];
	_o set3DENAttribute ['rotation',[0,0,88.8806]];

	_hash = [_o,'PowerSwitcher_Activator'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;

	[_o,'_swact_gatejailtemp'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3799.75,3778.32,24.1639]];
	_o set3DENAttribute ['rotation',[0,0,355.832]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["gatepriv","gatemain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3799.19,3777.29,28.7215]];
	_o set3DENAttribute ['rotation',[0,0,359.289]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["gatepub","gatemain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_doub_bronedwerks", [0,0,0]];
	_o set3DENAttribute ['position',[3793.47,3779.51,28.8385]];
	_o set3DENAttribute ['rotation',[0,0,270.32]];

	_hash = [_o,'SteelArmoredDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["gatepriv","gatemain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_doub_bronedwerks", [0,0,0]];
	_o set3DENAttribute ['position',[3794.22,3782.4,28.7683]];
	_o set3DENAttribute ['rotation',[0,0,270.32]];

	_hash = [_o,'SteelArmoredDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed2", [0,0,0]];
	_o set3DENAttribute ['position',[3799.2,3787.46,24.4088]];
	_o set3DENAttribute ['rotation',[0,0,1.84167]];

	_hash = [_o,'HospitalBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3796.9,3782.26,24.4691]];
	_o set3DENAttribute ['rotation',[0,0,106.769]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[3797.17,3786.96,24.2591]];
	_o set3DENAttribute ['rotation',[0,0,89.0391]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashi4ek", [0,0,0]];
	_o set3DENAttribute ['position',[3801.34,3784.91,28.7972]];
	_o set3DENAttribute ['rotation',[0,0,270.72]];

	_hash = [_o,'ContainerGreen2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.63,3776.21,24.3141]];
	_o set3DENAttribute ['rotation',[0,0,269.318]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.63,3776.51,24.3373]];
	_o set3DENAttribute ['rotation',[0,0,89.3994]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3795.68,3777.95,24.3554]];
	_o set3DENAttribute ['rotation',[0,0,269.318]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[3785.81,3790.46,24.8622]];
	_o set3DENAttribute ['rotation',[0,0,90.3609]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o,'radioSettings',[1,"enc_tg",10,5,nil,300,0]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[3795.12,3784.37,24.8773]];
	_o set3DENAttribute ['rotation',[0,0,178.061]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o,'radioSettings',[1,"enc_tg",10,5,nil,300,0]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3797.59,3781.09,26.7769]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swGateWork"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3799.85,3786.59,26.7556]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swGateWork"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3787.87,3804.86,25.3925]];
	_o set3DENAttribute ['rotation',[0,0,175.8]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3803.49,3805.27,26.3365]];
	_o set3DENAttribute ['rotation',[0,0,175.8]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x18_2", [0,0,0]];
	_o set3DENAttribute ['position',[3801.04,3781.42,28.3256]];
	_o set3DENAttribute ['rotation',[0,0,180.023]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x18_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3791.93,3782.2,20.0563]];
	_o set3DENAttribute ['rotation',[0,0,83.5415]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3789.47,3782.36,20.308]];
	_o set3DENAttribute ['rotation',[0,0,240.323]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3799.11,3776.62,24.219]];
	_o set3DENAttribute ['rotation',[0,0,357.165]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3796,3776.74,24.2296]];
	_o set3DENAttribute ['rotation',[0,0,357.181]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3786.24,3779.78,28.8328]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SportGround_fence_F", [0,0,0]];
	_o set3DENAttribute ['position',[3790.67,3781.38,29.8665]];
	_o set3DENAttribute ['rotation',[0,180,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\sportground_fence_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_2_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3788.71,3807.76,25.5731]];
	_o set3DENAttribute ['rotation',[359.864,0.364419,84.2769]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_2_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3803.71,3802.27,25.5885]];
	_o set3DENAttribute ['rotation',[359.603,0.885807,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_kletka", [0,0,0]];
	_o set3DENAttribute ['position',[3796.47,3786.7,25.3605]];
	_o set3DENAttribute ['rotation',[0,0,179.719]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_kletka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_lest_kletka", [0,0,0]];
	_o set3DENAttribute ['position',[3796.47,3786.38,22.171]];
	_o set3DENAttribute ['rotation',[0,0,179.719]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\lest_kletka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3786.99,3777.47,26.8074]];
	_o set3DENAttribute ['rotation',[0,0,179.254]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3793.35,3789.82,24.1131]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3787.97,3789.78,26.7774]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3790.01,3777.44,26.8042]];
	_o set3DENAttribute ['rotation',[0,0,179.348]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3784.85,3777.44,24.207]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3793.67,3782.63,31.5444]];
	_o set3DENAttribute ['rotation',[0,0,89.5048]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3794.73,3777.94,28.8059]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3785.04,3789.84,26.7846]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3793.05,3777.46,26.7997]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3794.42,3782.48,22.7422]];
	_o set3DENAttribute ['rotation',[0,0,88.7698]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3785.06,3789.82,24.1167]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3791,3789.74,26.7789]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3793.6,3779.58,31.5663]];
	_o set3DENAttribute ['rotation',[0,0,89.5048]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3801.45,3777.23,28.6955]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3794.71,3780.88,28.8503]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3794.42,3782.49,26.0412]];
	_o set3DENAttribute ['rotation',[0,0,89.1246]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3794.03,3789.66,26.7838]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3793.19,3777.4,24.3532]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3798.71,3784.58,24.232]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_PowerGenerator_F", [0,0,0]];
	_o set3DENAttribute ['position',[3797.82,3785.65,24.3691]];
	_o set3DENAttribute ['rotation',[0,0,180.396]];

	_hash = [_o,'RegistratorPanelReceiver'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;

	[_o,'_paperPress'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svetofor", [0,0,0]];
	_o set3DENAttribute ['position',[3793.03,3784.34,24.1984]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RegistrationPanel'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transGate"]] call mm_importOld_regFunc;
	[_o,'setReceiverObj',[_paperPress]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub2", [0,0,0]];
	_o set3DENAttribute ['position',[3796.42,3785.34,24.2521]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub2", [0,0,0]];
	_o set3DENAttribute ['position',[3796.42,3780.85,24.2669]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub2", [0,0,0]];
	_o set3DENAttribute ['position',[3800.03,3783.56,24.2658]];
	_o set3DENAttribute ['rotation',[0,0,274.174]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub2", [0,0,0]];
	_o set3DENAttribute ['position',[3799.86,3786.76,24.2619]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub2", [0,0,0]];
	_o set3DENAttribute ['position',[3799.19,3780.49,24.2652]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_prowod_shabut", [0,0,0]];
	_o set3DENAttribute ['position',[3790.11,3781.61,26.8008]];
	_o set3DENAttribute ['rotation',[0,271.983,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodusss\prowod_shabut.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_prowod_shabut", [0,0,0]];
	_o set3DENAttribute ['position',[3788.13,3781.46,28.6639]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodusss\prowod_shabut.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "germodweri", [0,0,0]];
	_o set3DENAttribute ['position',[3789.14,3789.93,24.1211]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GateCity'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gateact_external"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "germodweri", [0,0,0]];
	_o set3DENAttribute ['position',[3789.05,3777.47,24.2571]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GateCity'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gateact_internal"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Concrete_SmallWall_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3798.31,3786.59,25.7553]];
	_o set3DENAttribute ['rotation',[0,0,93.3091]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Concrete_SmallWall_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.99,3778.36,25.942]];
	_o set3DENAttribute ['rotation',[0,0,356.351]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Concrete_SmallWall_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3800.07,3777.23,32.8723]];
	_o set3DENAttribute ['rotation',[0,0,0.0458101]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\concrete_smallwall_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_portfeluga", [0,0,0]];
	_o set3DENAttribute ['position',[3796.02,3778.84,24.8028]];
	_o set3DENAttribute ['rotation',[0,0,174.182]];

	_hash = [_o,'Briefcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chooomadan", [0,0,0]];
	_o set3DENAttribute ['position',[3796.02,3780.12,25.262]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Suitcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SmallTable", [0,0,0]];
	_o set3DENAttribute ['position',[3800.14,3782.65,24.4518]];
	_o set3DENAttribute ['rotation',[0,0,86.1862]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\smalltable\smalltable.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "table", [0,0,0]];
	_o set3DENAttribute ['position',[3795.75,3782.26,24.2302]];
	_o set3DENAttribute ['rotation',[0,0,86.8285]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\table.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Battery_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.06,3782.12,25.1001]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallBattery'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Battery_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.26,3778.8,25.263]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallBattery'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Battery_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.06,3778.79,25.2636]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallBattery'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Battery_F", [0,0,0]];
	_o set3DENAttribute ['position',[3795.96,3778.81,25.2636]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallBattery'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ratziya", [0,0,0]];
	_o set3DENAttribute ['position',[3797.44,3780.24,24.9152]];
	_o set3DENAttribute ['rotation',[0,0,2.32906]];

	_hash = [_o,'RadioBaikal'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ratziya", [0,0,0]];
	_o set3DENAttribute ['position',[3797.04,3780.19,25.358]];
	_o set3DENAttribute ['rotation',[0,0,176.09]];

	_hash = [_o,'RadioBaikal'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ratziya", [0,0,0]];
	_o set3DENAttribute ['position',[3797.06,3780.3,24.902]];
	_o set3DENAttribute ['rotation',[0,0,90.1036]];

	_hash = [_o,'RadioBaikal'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ratziya", [0,0,0]];
	_o set3DENAttribute ['position',[3796.93,3780.3,24.902]];
	_o set3DENAttribute ['rotation',[0,0,81.2506]];

	_hash = [_o,'RadioBaikal'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "flashlight", [0,0,0]];
	_o set3DENAttribute ['position',[3795.84,3782.21,25.1001]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Flashlight'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "flashlight", [0,0,0]];
	_o set3DENAttribute ['position',[3796.03,3780.13,24.8227]];
	_o set3DENAttribute ['rotation',[0,0,79.6504]];

	_hash = [_o,'Flashlight'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "flashlight", [0,0,0]];
	_o set3DENAttribute ['position',[3797.23,3778.93,25.2589]];
	_o set3DENAttribute ['rotation',[0,0,271.445]];

	_hash = [_o,'Flashlight'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Leaflet_05_Stack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3795.96,3781.74,25.1023]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PaperHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "warknife3", [0,0,0]];
	_o set3DENAttribute ['position',[3800.16,3782.68,25.2577]];
	_o set3DENAttribute ['rotation',[0,0,41.4494]];

	_hash = [_o,'CombatKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3787.15,3815.07,24.4009]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3806.85,3815.77,24.4009]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3776.63,3825.04,34.275]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3787.02,3825.14,24.1573]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3797.1,3815.03,24.4009]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3776.86,3824.8,43.905]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3776.29,3815.06,24.291]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3786.98,3835.42,23.7859]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3797.68,3825.48,34.0901]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3787.12,3825.13,43.6158]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3798.06,3825.26,43.4609]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3807.78,3826.52,32.1526]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3807.93,3815.53,48.4715]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3798.17,3814.79,48.4715]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3788.22,3814.83,48.4715]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3777.41,3814.27,48.3617]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3806.7,3826.49,42.2299]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3798.95,3812.28,25.2333]];
	_o set3DENAttribute ['rotation',[0,0,175.8]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SharpRock_spike", [0,0,0]];
	_o set3DENAttribute ['position',[3787.94,3831.82,20.235]];
	_o set3DENAttribute ['rotation',[0,0,357.53]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f\sharp\sharprock_spike.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House02_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3801.47,3817.31,24.4447]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house02_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3796.61,3816.61,24.5184]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_K_1_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3788,3823.31,27.0496]];
	_o set3DENAttribute ['rotation',[359.512,0.156435,147.93]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housek\house_k_1_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "nakowal", [0,0,0]];
	_o set3DENAttribute ['position',[3806.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Anvil'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3793.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3790.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3791.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak2", [0,0,0]];
	_o set3DENAttribute ['position',[3801.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BedOld'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lekarnicka", [0,0,0]];
	_o set3DENAttribute ['position',[3803.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WallmountedMedicalCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Sign_Bar_RU", [0,0,0]];
	_o set3DENAttribute ['position',[3795.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SignBar'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3789.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SignB_Pub_RU1", [0,0,0]];
	_o set3DENAttribute ['position',[3796.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SignTableKabak'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SignB_Pharmacy", [0,0,0]];
	_o set3DENAttribute ['position',[3794.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SignMedical'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3792.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "golova_trup1", [0,0,0]];
	_o set3DENAttribute ['position',[3802.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Head'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\golova_trup1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_1", [0,0,0]];
	_o set3DENAttribute ['position',[3797.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedSteelBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "med_crate", [0,0,0]];
	_o set3DENAttribute ['position',[3805.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenMedicalBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "biblio", [0,0,0]];
	_o set3DENAttribute ['position',[3798.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Bookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_knihovna", [0,0,0]];
	_o set3DENAttribute ['position',[3799.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallBookcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjDivan", [0,0,0]];
	_o set3DENAttribute ['position',[3800.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SofaBrown'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_hospital_bench", [0,0,0]];
	_o set3DENAttribute ['position',[3804.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'HospitalBench'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "forge", [0,0,0]];
	_o set3DENAttribute ['position',[3807.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Forge'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3788.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.36,3580.29,8.72204]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3817.74,3577.2,17.3008]];
	_o set3DENAttribute ['rotation',[0,0,337.897]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3825.44,3580.53,8.71315]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3833.99,3573.08,13.1239]];
	_o set3DENAttribute ['rotation',[0,0,4.42781]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Barn_04_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.23,3574.09,16.9074]];
	_o set3DENAttribute ['rotation',[179.997,0.000444285,86.0874]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3839.84,3576.77,9.35491]];
	_o set3DENAttribute ['rotation',[359.704,0.415115,274.48]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3827.57,3579.85,8.86377]];
	_o set3DENAttribute ['rotation',[0,0,233.742]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Unfinished_Building_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3831.48,3589.8,8.02065]];
	_o set3DENAttribute ['rotation',[0,0,279.946]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\wip\unfinished_building_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3829.03,3607.07,28.3768]];
	_o set3DENAttribute ['rotation',[358.89,346.797,4.84712]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3817.27,3613.72,8.6575]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3828.19,3613.19,8.78424]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3838.18,3590.66,18.5701]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3837.94,3601.34,8.61236]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3827.69,3591.72,8.76611]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3818.02,3596.71,18.5316]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3817.05,3587.88,18.3023]];
	_o set3DENAttribute ['rotation',[0,0,13.2498]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3839.69,3599.32,26.361]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.93,3602.24,8.68597]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3837.81,3607.11,29.0885]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3838.69,3612.27,8.84369]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3818.67,3612.13,8.64499]];
	_o set3DENAttribute ['rotation',[0,0,124.119]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3811.37,3613.35,8.60948]];
	_o set3DENAttribute ['rotation',[0,0,171.045]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3838.31,3606.62,8.80273]];
	_o set3DENAttribute ['rotation',[0,0,121.012]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3819.26,3612.04,9.50957]];
	_o set3DENAttribute ['rotation',[0,0,202.848]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3811.77,3613.27,9.43379]];
	_o set3DENAttribute ['rotation',[0,0,249.773]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3815.76,3612.79,8.26388]];
	_o set3DENAttribute ['rotation',[0,0,350.899]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3823.78,3615.56,8.2437]];
	_o set3DENAttribute ['rotation',[0,0,81.1216]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3822.05,3610.46,9.30129]];
	_o set3DENAttribute ['rotation',[0,0,274.838]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3833.62,3598.48,9.43846]];
	_o set3DENAttribute ['rotation',[0,0,274.528]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3824.44,3607.9,9.2949]];
	_o set3DENAttribute ['rotation',[0,0,3.78507]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3828.54,3592.07,7.95998]];
	_o set3DENAttribute ['rotation',[0,0,187.827]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3810.68,3613.41,9.11939]];
	_o set3DENAttribute ['rotation',[359.704,0.415115,83.8161]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3819.94,3615.66,9.40557]];
	_o set3DENAttribute ['rotation',[359.704,0.415115,10.331]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_Wall_D_right_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.33,3610.35,12.8567]];
	_o set3DENAttribute ['rotation',[359.405,355.619,130.897]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wall_d_right_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_GRYAZOOOKASS", [0,0,0]];
	_o set3DENAttribute ['position',[3831.63,3598.35,6.37472]];
	_o set3DENAttribute ['rotation',[0,0,7.30596]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\surfaces\gryazoookass.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_krysha_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3826.39,3594.97,18.0984]];
	_o set3DENAttribute ['rotation',[358.427,345.787,6.38105]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\krysha.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3829.23,3608.8,8.87868]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3839.74,3584.14,8.84876]];
	_o set3DENAttribute ['rotation',[0,0,49.173]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SharpRock_spike", [0,0,0]];
	_o set3DENAttribute ['position',[3813.59,3600.72,8.26951]];
	_o set3DENAttribute ['rotation',[0,0,357.53]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f\sharp\sharprock_spike.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SharpRock_spike", [0,0,0]];
	_o set3DENAttribute ['position',[3808.86,3610.67,22.9837]];
	_o set3DENAttribute ['rotation',[0,0,357.53]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f\sharp\sharprock_spike.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.63,3615.81,8.8706]];
	_o set3DENAttribute ['rotation',[0,0,32.5695]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3831.86,3634.91,28.8291]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3829.29,3623.97,8.84633]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3832.26,3642.94,27.2283]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3821.14,3635.13,18.66]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3818.37,3624.5,8.71959]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3832.2,3645.75,9.04504]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3821.95,3645.27,18.5917]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3830.55,3634.92,8.9446]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3838.39,3618.64,7.90268]];
	_o set3DENAttribute ['rotation',[0,0,94.0283]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.97,3637.92,10.6448]];
	_o set3DENAttribute ['rotation',[0,0,96.5579]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3833.99,3617.76,9.5304]];
	_o set3DENAttribute ['rotation',[0.921771,0.304197,95.8887]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3833.64,3622.66,9.42873]];
	_o set3DENAttribute ['rotation',[0.763781,0.599041,76.0455]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.66,3643.41,9.31532]];
	_o set3DENAttribute ['rotation',[0,0,121.012]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.51,3627.76,9.02886]];
	_o set3DENAttribute ['rotation',[0,0,279.364]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3818.08,3625.83,8.17717]];
	_o set3DENAttribute ['rotation',[0,0,185.624]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3808.6,3620.93,8.2092]];
	_o set3DENAttribute ['rotation',[0,0,122.732]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3822.63,3618.81,6.63207]];
	_o set3DENAttribute ['rotation',[0,0,184.968]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3832.92,3638.2,7.90876]];
	_o set3DENAttribute ['rotation',[0,0,94.7599]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3822.03,3627.03,9.69258]];
	_o set3DENAttribute ['rotation',[0,0,75.2977]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3812.97,3616.05,9.31861]];
	_o set3DENAttribute ['rotation',[359.704,0.415115,169.895]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.6,3621.47,8.60085]];
	_o set3DENAttribute ['rotation',[0,0,14.8002]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_krysha_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3814.19,3618.72,15.1748]];
	_o set3DENAttribute ['rotation',[358.427,345.787,6.38105]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\krysha.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3822.44,3617.24,11.0809]];
	_o set3DENAttribute ['rotation',[0,0,274.573]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3822.74,3620.28,11.0824]];
	_o set3DENAttribute ['rotation',[0,0,274.573]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cliff_peak_F", [0,0,0]];
	_o set3DENAttribute ['position',[3811.35,3633.09,9.14472]];
	_o set3DENAttribute ['rotation',[79.5361,12.5369,213.678]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f_exp\cliff\cliff_peak_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SharpRock_spike", [0,0,0]];
	_o set3DENAttribute ['position',[3818.45,3628,16.2516]];
	_o set3DENAttribute ['rotation',[285.599,8.76229,324.846]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f\sharp\sharprock_spike.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3838.84,3630.91,8.68808]];
	_o set3DENAttribute ['rotation',[0,0,103.757]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.5,3627.24,8.58518]];
	_o set3DENAttribute ['rotation',[0,0,269.25]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3838.79,3638.41,13.5521]];
	_o set3DENAttribute ['rotation',[359.712,359.599,270.206]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3837.31,3634.68,13.5702]];
	_o set3DENAttribute ['rotation',[359.712,359.599,187.278]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "germodweri", [0,0,0]];
	_o set3DENAttribute ['position',[3822.91,3618.76,8.48052]];
	_o set3DENAttribute ['rotation',[0,0,275.774]];

	_hash = [_o,'GateCity'] call mm_importOld_initHashData;
	[_o,'connectTo',["_unlimgenTDM"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_pravo", [0,0,0]];
	_o set3DENAttribute ['position',[3816.76,3616.51,5.25334]];
	_o set3DENAttribute ['rotation',[0,0,10.0914]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_pravo.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3831.8,3665.08,18.0262]];
	_o set3DENAttribute ['rotation',[0,0,267.297]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3831.91,3655.73,9.01005]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3822.58,3655.53,18.6051]];
	_o set3DENAttribute ['rotation',[0,0,93.1277]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3833.21,3654.97,23.7008]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.89,3654.15,8.79795]];
	_o set3DENAttribute ['rotation',[0,0,271.52]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3831.39,3655.8,9.20964]];
	_o set3DENAttribute ['rotation',[0,0,324.08]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.81,3648.07,8.85619]];
	_o set3DENAttribute ['rotation',[0,0,7.46574]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3830.49,3648.69,8.93188]];
	_o set3DENAttribute ['rotation',[0,0,356.583]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_wall", [0,0,0]];
	_o set3DENAttribute ['position',[3833.59,3657.28,9.33435]];
	_o set3DENAttribute ['rotation',[4.93996,3.03183,100.973]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_wall.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3808.97,3711.12,21.9523]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.03,3705.36,31.9028]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3808.86,3702.14,31.904]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.64,3708.75,21.7438]];
	_o set3DENAttribute ['rotation',[0,0,269.102]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbskletka"]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.64,3708.7,21.7925]];
	_o set3DENAttribute ['rotation',[0,0,178.97]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3808.38,3709.02,25.5711]];
	_o set3DENAttribute ['rotation',[0,0,1.64129]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3811.02,3707.92,19.2806]];
	_o set3DENAttribute ['rotation',[0,0,349.455]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3809.27,3709.32,25.5526]];
	_o set3DENAttribute ['rotation',[0,0,90.1882]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3818.7,3711.92,24.9316]];
	_o set3DENAttribute ['rotation',[67.4785,283.552,291.955]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_sw_SecAdmHome'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3821.09,3710.9,23.6095]];
	_o set3DENAttribute ['rotation',[0,0,89.7373]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Desk", [0,0,0]];
	_o set3DENAttribute ['position',[3819.79,3711.06,23.6045]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\desk\desk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3818.8,3710.75,28.0234]];
	_o set3DENAttribute ['rotation',[0,0,267.529]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shkafsin", [0,0,0]];
	_o set3DENAttribute ['position',[3821.04,3711.63,28.0306]];
	_o set3DENAttribute ['rotation',[0,0,268.038]];

	_hash = [_o,'SteelGreenCabinet'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["AmmoBoxPBMNonLethal",4,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_h", [0,0,0]];
	_o set3DENAttribute ['position',[3819.79,3711.88,23.7368]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedPappedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_metalcase_01", [0,0,0]];
	_o set3DENAttribute ['position',[3808.86,3711.52,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,88.146]];

	_hash = [_o,'SteelBlueCase'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1,100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["StreakCloth",1,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_metalcase_01", [0,0,0]];
	_o set3DENAttribute ['position',[3808.88,3710.99,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,88.146]];

	_hash = [_o,'SteelBlueCase'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1,100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["StreakCloth",1,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_metalcase_01", [0,0,0]];
	_o set3DENAttribute ['position',[3808.89,3710.42,25.556]];
	_o set3DENAttribute ['rotation',[0,0,88.146]];

	_hash = [_o,'SteelBlueCase'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1,100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["StreakCloth",1,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "key", [0,0,0]];
	_o set3DENAttribute ['position',[3819.84,3711.21,24.435]];
	_o set3DENAttribute ['rotation',[0,0,314.381]];

	_hash = [_o,'Key'] call mm_importOld_initHashData;
	[_o,'keyOwner',["sbsweapons_private"]] call mm_importOld_regVar;
	[_o,'name',"Ключ от приватной оружейной"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3818.55,3710.29,25.6582]];
	_o set3DENAttribute ['rotation',[0,0,268.511]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.34,3742.71,38.0605]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.39,3742.23,34.315]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.54,3741.87,24.3979]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.18,3731.79,17.0575]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.18,3731.12,22.2245]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3829.89,3743.01,34.0056]];
	_o set3DENAttribute ['rotation',[0,0,86.4024]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.53,3725.62,22.2026]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.27,3741.94,22.4489]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.68,3725.49,32.3997]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3828.5,3733.98,31.1783]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3808.98,3721.61,22.0528]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.37,3715.02,22.0548]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3827.92,3714.88,32.2244]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3833.47,3728.93,17.0242]];
	_o set3DENAttribute ['rotation',[0,0,90.9637]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Генераторная"] call mm_importOld_regVar;

	[_o,'_genTrans'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3822.01,3718.87,23.6574]];
	_o set3DENAttribute ['rotation',[0,0,269.474]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swSec"]] call mm_importOld_regFunc;

	[_o,'_transSec'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.68,3723.61,21.88]];
	_o set3DENAttribute ['rotation',[0,0,270.898]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbskletka"]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.67,3714.32,21.8048]];
	_o set3DENAttribute ['rotation',[0,0,270.898]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbskletka"]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.73,3719.82,21.8096]];
	_o set3DENAttribute ['rotation',[0,0,270.898]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbskletka"]] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3810.37,3716.95,21.0282]];
	_o set3DENAttribute ['rotation',[0,0,179.843]];

	_hash = [_o,'SteelGridDoorElectronic'] call mm_importOld_initHashData;
	[_o,'connectTo',["_act_jaildoor"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3819.63,3717.03,27.6566]];
	_o set3DENAttribute ['rotation',[0,0,179.837]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbsweapons_private"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3818.39,3712.74,23.5052]];
	_o set3DENAttribute ['rotation',[0,0,88.8001]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbsprivate","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3824.91,3732.48,16.9131]];
	_o set3DENAttribute ['rotation',[0,0,88.8001]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["brig","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3819.06,3714.36,27.9198]];
	_o set3DENAttribute ['rotation',[0,0,88.0119]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbsweapons"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.63,3714.23,21.8156]];
	_o set3DENAttribute ['rotation',[0,0,180.768]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kaleetka", [0,0,0]];
	_o set3DENAttribute ['position',[3808.72,3719.73,21.8205]];
	_o set3DENAttribute ['rotation',[0,0,180.768]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\kaleetka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_F", [0,0,0]];
	_o set3DENAttribute ['position',[3820.16,3720,27.9682]];
	_o set3DENAttribute ['rotation',[0,0,1.8045]];

	_hash = [_o,'LongWeaponContainer'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["RifleFinisherSmall",1,100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["MagazineFinisherLoaded",2,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_F", [0,0,0]];
	_o set3DENAttribute ['position',[3822.13,3719.04,27.9792]];
	_o set3DENAttribute ['rotation',[0,0,269.047]];

	_hash = [_o,'LongWeaponContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3809.33,3727.34,24.5848]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3811.44,3720.49,24.8597]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3815.91,3713.41,26.5945]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3819.98,3712.98,26.7421]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecAdmHome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3818.81,3718.69,26.65]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3815.75,3713.22,29.9404]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3821.11,3716.83,24.8894]];
	_o set3DENAttribute ['rotation',[0,0,2.90434]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3812.94,3730.37,23.1461]];
	_o set3DENAttribute ['rotation',[0,0,2.9098]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3835.86,3733.11,17.0241]];
	_o set3DENAttribute ['rotation',[0,0,231.764]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.34,3735.51,17.0084]];
	_o set3DENAttribute ['rotation',[0,0,38.2772]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3816.99,3731.31,19.0803]];
	_o set3DENAttribute ['rotation',[0,0,345.292]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySec"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.69,3732.08,22.0996]];
	_o set3DENAttribute ['rotation',[0,0,317.833]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySec"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3809.34,3721.29,25.5496]];
	_o set3DENAttribute ['rotation',[0,0,90.1882]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "controlpanel", [0,0,0]];
	_o set3DENAttribute ['position',[3827.37,3728.61,17.0241]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerGenerator'] call mm_importOld_initHashData;

	[_o,'_gen'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "type94", [0,0,0]];
	_o set3DENAttribute ['position',[3821.19,3717.38,28.58]];
	_o set3DENAttribute ['rotation',[0,0,89.7486]];

	_hash = [_o,'PistolPBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "type94", [0,0,0]];
	_o set3DENAttribute ['position',[3821.61,3717.39,28.5802]];
	_o set3DENAttribute ['rotation',[0,0,89.7486]];

	_hash = [_o,'PistolPBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.64,3716.29,27.9543]];
	_o set3DENAttribute ['rotation',[0,0,90.7941]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Screwdriver_V1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.37,3729.77,18.0187]];
	_o set3DENAttribute ['rotation',[0,0,296.562]];

	_hash = [_o,'Screwdriver'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.61,3731.02,16.9795]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SquareWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.63,3728.74,17.0241]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SquareWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_Uup_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.69,3729.88,15.2425]];
	_o set3DENAttribute ['rotation',[0,0,178.112]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_uup_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Unfinished_Building_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3819.61,3715.73,23.5847]];
	_o set3DENAttribute ['rotation',[0,0,269.952]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\wip\unfinished_building_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3821.81,3717.04,27.7941]];
	_o set3DENAttribute ['rotation',[0,0,180.852]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3808.03,3730.4,22.2847]];
	_o set3DENAttribute ['rotation',[0,0,179.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3809.37,3727.3,25.4585]];
	_o set3DENAttribute ['rotation',[0,0,90.4079]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3811.7,3717.04,22.0475]];
	_o set3DENAttribute ['rotation',[0,0,357.542]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Barn_04_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.94,3725.6,31.9292]];
	_o set3DENAttribute ['rotation',[180,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_90degR_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.87,3723.63,17.0958]];
	_o set3DENAttribute ['rotation',[0,0,4.29397]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_90degR_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.23,3737.16,17.0691]];
	_o set3DENAttribute ['rotation',[0,0,267.363]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_90degR_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.74,3723.41,17.3186]];
	_o set3DENAttribute ['rotation',[0,0,93.9232]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_90degR_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.97,3723.78,17.7878]];
	_o set3DENAttribute ['rotation',[0,0,4.29397]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "patroni_indabox", [0,0,0]];
	_o set3DENAttribute ['position',[3821.23,3717.39,28.1305]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'AmmoBoxPBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "patroni_indabox", [0,0,0]];
	_o set3DENAttribute ['position',[3821.02,3717.39,28.1339]];
	_o set3DENAttribute ['rotation',[0,0,269.907]];

	_hash = [_o,'AmmoBoxPBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3813.21,3721.76,19.7213]];
	_o set3DENAttribute ['rotation',[0,0,2.6146]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3818.77,3733.83,16.5324]];
	_o set3DENAttribute ['rotation',[0,0,268.693]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3818.73,3735.44,16.5324]];
	_o set3DENAttribute ['rotation',[0,0,268.694]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3810.33,3724.19,24.8256]];
	_o set3DENAttribute ['rotation',[0,0,178.563]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3825.19,3733.53,18.643]];
	_o set3DENAttribute ['rotation',[360,275.149,0.000429901]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_genTrans"]] call mm_importOld_regFunc;
	[_o,'name',"Свет 'Генераторная'"] call mm_importOld_regVar;

	[_o,'_sw_GenLight'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3809.56,3727.72,26.8555]];
	_o set3DENAttribute ['rotation',[360,275.149,0.000429901]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_sw_SecHall'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.44,3728.18,19.0313]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Торговая зона"] call mm_importOld_regVar;

	[_o,'_swTrader'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.47,3728.26,18.5247]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Врата"] call mm_importOld_regVar;

	[_o,'_swGate'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.86,3728.25,18.1521]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Улицы 'Жилая зона'"] call mm_importOld_regVar;

	[_o,'_swCityLiving'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3830.77,3728.21,18.3905]];
	_o set3DENAttribute ['rotation',[0,0,181.659]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Охрана"] call mm_importOld_regVar;

	[_o,'_swSec'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3818.03,3713.54,29.4702]];
	_o set3DENAttribute ['rotation',[0,0,84.8985]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_sw_armory'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3830.33,3728.22,18.2027]];
	_o set3DENAttribute ['rotation',[0,0,181.659]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Улицы 'Охрана'"] call mm_importOld_regVar;

	[_o,'_swCitySec'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.48,3728.25,17.9004]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Бар"] call mm_importOld_regVar;

	[_o,'_swBar'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.92,3728.23,19.0466]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Администрация"] call mm_importOld_regVar;

	[_o,'_swAdmin'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.92,3728.2,18.6344]];
	_o set3DENAttribute ['rotation',[0,0,181.659]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Улицы 'Площадь'"] call mm_importOld_regVar;

	[_o,'_swCitySquare'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3830.35,3728.21,18.8139]];
	_o set3DENAttribute ['rotation',[0,0,181.659]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Лекарня"] call mm_importOld_regVar;

	[_o,'_swMedical'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3829.95,3728.25,17.7055]];
	_o set3DENAttribute ['rotation',[0,0,180.854]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gen"]] call mm_importOld_regFunc;
	[_o,'name',"Пром. зона"] call mm_importOld_regVar;

	[_o,'_swIndust'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lekarnicka", [0,0,0]];
	_o set3DENAttribute ['position',[3821.98,3716.95,24.7594]];
	_o set3DENAttribute ['rotation',[0,0,2.84635]];

	_hash = [_o,'WallmountedMedicalCabinet'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Bandage",1+(floor random 5),70]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["PainkillerBox",1,60]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3810.39,3719.03,30.25]];
	_o set3DENAttribute ['rotation',[0,0,270.13]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3817.26,3717.06,23.5552]];
	_o set3DENAttribute ['rotation',[0,0,175.007]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbshome","sbsmain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x6", [0,0,0]];
	_o set3DENAttribute ['position',[3821.51,3714.2,32.2602]];
	_o set3DENAttribute ['rotation',[0,0,178.33]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wall_L3_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3818.53,3718.1,28.0673]];
	_o set3DENAttribute ['rotation',[0,0,88.4465]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l3_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.36,3729.87,17.0241]];
	_o set3DENAttribute ['rotation',[0,0,269.288]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.4,3717.38,28.0277]];
	_o set3DENAttribute ['rotation',[0,0,178.517]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tank_rust_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.82,3735.59,16.9565]];
	_o set3DENAttribute ['rotation',[0,0,1.67518]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\tank\tank_rust_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3812.79,3720.48,23.4775]];
	_o set3DENAttribute ['rotation',[0,0,269.789]];

	_hash = [_o,'PowerSwitcher_Activator'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_act_jaildoor'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3810.27,3730.19,23.2612]];
	_o set3DENAttribute ['rotation',[0,0,181.142]];

	_hash = [_o,'PowerSwitcher'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transSec"]] call mm_importOld_regFunc;

	[_o,'_sw_SecHallLower'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3812.6,3717.71,22.064]];
	_o set3DENAttribute ['rotation',[0,0,183.434]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3809.21,3730.38,22.1566]];
	_o set3DENAttribute ['rotation',[0,0,0.186385]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["sbshall","sbsmain","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed2", [0,0,0]];
	_o set3DENAttribute ['position',[3819.85,3715.93,23.7273]];
	_o set3DENAttribute ['rotation',[0,0,90.7227]];

	_hash = [_o,'HospitalBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[3819.01,3714.35,23.6637]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Key",5,100,[["var","name","Ключ от клеток"],["var","keyOwner",["sbskletka"]]]]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3812.05,3730.81,25.9503]];
	_o set3DENAttribute ['rotation',[0,0,179.469]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHallLower"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_4'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3813.95,3734.55,22.1902]];
	_o set3DENAttribute ['rotation',[0,0,268.693]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3832.72,3727.17,19.0627]];
	_o set3DENAttribute ['rotation',[0,0,183.699]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3820.93,3715.82,30.7214]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_armory"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3838.1,3726.57,19.6851]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_GenLight"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3833.14,3733.4,19.6751]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_GenLight"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3828.42,3731.46,19.715]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_GenLight"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_stena", [0,0,0]];
	_o set3DENAttribute ['position',[3812.22,3729.16,27.8975]];
	_o set3DENAttribute ['rotation',[90,0,90]];

	_hash = [_o,'LampWall'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_SecHall"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3809.4,3736.25,22.6099]];
	_o set3DENAttribute ['rotation',[0,0,355.823]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_pieces_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.95,3731.13,17.5057]];
	_o set3DENAttribute ['rotation',[0,0,355.823]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3832.96,3729.5,21.2773]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x18.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3833.04,3728.56,16.5191]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x18.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Magazine_rifle_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.41,3717.37,28.1285]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MagazinePBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Magazine_rifle_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.76,3717.39,28.1327]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MagazinePBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Magazine_rifle_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.53,3717.37,28.1321]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MagazinePBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Magazine_rifle_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.64,3717.38,28.1324]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MagazinePBM'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjKreslo", [0,0,0]];
	_o set3DENAttribute ['position',[3808.64,3714.15,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,262.253]];

	_hash = [_o,'BumArmChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_okn", [0,0,0]];
	_o set3DENAttribute ['position',[3812.52,3730.35,25.2073]];
	_o set3DENAttribute ['rotation',[0,0,0.967819]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_okn", [0,0,0]];
	_o set3DENAttribute ['position',[3809.29,3715.3,25.5506]];
	_o set3DENAttribute ['rotation',[0,0,90.1646]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3821.89,3719.62,27.7199]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3822,3713.65,27.7229]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3812.32,3728.97,27.9729]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_3x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_plita_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3819.59,3714.32,27.7093]];
	_o set3DENAttribute ['rotation',[0,0,357.927]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\plita_3x3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_stolb_6m_l", [0,0,0]];
	_o set3DENAttribute ['position',[3811.77,3720.46,25.1154]];
	_o set3DENAttribute ['rotation',[0,0,89.1057]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\stolb_6m_l.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3826.41,3736.11,17.0033]];
	_o set3DENAttribute ['rotation',[348.403,0,253.891]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3833.63,3725.01,16.8177]];
	_o set3DENAttribute ['rotation',[0,340.442,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3839.59,3731.9,17.0241]];
	_o set3DENAttribute ['rotation',[2.40126,0,332.92]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3836.53,3729.73,16.8592]];
	_o set3DENAttribute ['rotation',[2.58785,353.831,290.128]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_domen3", [0,0,0]];
	_o set3DENAttribute ['position',[3832.14,3735.94,16.993]];
	_o set3DENAttribute ['rotation',[0,0,88.4786]];

	_hash = [_o,'ConvertorForGenerator'] call mm_importOld_initHashData;
	[_o,'connectToGenerator',[_gen]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_DPP_01_transformer_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.74,3725.16,16.5956]];
	_o set3DENAttribute ['rotation',[0,0,184.333]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\industrial\dieselpowerplant_01\dpp_01_transformer_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_vorota_pult", [0,0,0]];
	_o set3DENAttribute ['position',[3832.14,3729.37,16.977]];
	_o set3DENAttribute ['rotation',[0,0,183.23]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_germogate\l_02_alex_vorota_pult.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l08_market_09_pol_02", [0,0,0]];
	_o set3DENAttribute ['position',[3811.95,3727.83,24.9601]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l08_market\l08_market_09_pol_02.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.59,3737.01,17.4869]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.59,3737.02,17.4867]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.65,3727.94,17.5687]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.12,3722.67,17.5552]];
	_o set3DENAttribute ['rotation',[0,0,3.35149]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.41,3726.18,17.5988]];
	_o set3DENAttribute ['rotation',[0,0,274.547]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3838.68,3730.32,17.4683]];
	_o set3DENAttribute ['rotation',[0,0,182.491]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825,3735.21,17.5045]];
	_o set3DENAttribute ['rotation',[0,0,90.7716]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3824.94,3729.91,17.5408]];
	_o set3DENAttribute ['rotation',[0,0,90.7716]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair01", [0,0,0]];
	_o set3DENAttribute ['position',[3817.38,3714.52,27.2372]];
	_o set3DENAttribute ['rotation',[0,0,267.625]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_metalcase_01", [0,0,0]];
	_o set3DENAttribute ['position',[3808.84,3712.05,25.5814]];
	_o set3DENAttribute ['rotation',[0,0,88.146]];

	_hash = [_o,'SteelBlueCase'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["BalaclavaMask",1,100]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["StreakCloth",1,100]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Pliers_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.35,3729.49,17.1446]];
	_o set3DENAttribute ['rotation',[0,0,104.072]];

	_hash = [_o,'WireCutters'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "waraxe", [0,0,0]];
	_o set3DENAttribute ['position',[3822.11,3719.06,28.4103]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BattleAxe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "warknife3", [0,0,0]];
	_o set3DENAttribute ['position',[3822.17,3716.28,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CombatKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "warknife3", [0,0,0]];
	_o set3DENAttribute ['position',[3821.39,3716.32,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CombatKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "warknife3", [0,0,0]];
	_o set3DENAttribute ['position',[3821.76,3716.28,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CombatKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "warknife3", [0,0,0]];
	_o set3DENAttribute ['position',[3821.01,3716.3,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CombatKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_MultiMeter_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.35,3729.7,17.1289]];
	_o set3DENAttribute ['rotation',[0,0,264.158]];

	_hash = [_o,'Multimeter'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Wrench_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.36,3729.51,18.0229]];
	_o set3DENAttribute ['rotation',[0,0,273.865]];

	_hash = [_o,'Wrench'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "swordefault", [0,0,0]];
	_o set3DENAttribute ['position',[3821.96,3716.24,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,183.896]];

	_hash = [_o,'ShortSword'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "swordefault", [0,0,0]];
	_o set3DENAttribute ['position',[3821.58,3716.27,28.8189]];
	_o set3DENAttribute ['rotation',[0,0,183.896]];

	_hash = [_o,'ShortSword'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "swordefault", [0,0,0]];
	_o set3DENAttribute ['position',[3821.21,3716.28,28.7973]];
	_o set3DENAttribute ['rotation',[0,0,183.896]];

	_hash = [_o,'ShortSword'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sword", [0,0,0]];
	_o set3DENAttribute ['position',[3821.36,3717.37,29.0188]];
	_o set3DENAttribute ['rotation',[0,0,89.7409]];

	_hash = [_o,'HalfHandedSword'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Gloves_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.34,3730.3,17.1307]];
	_o set3DENAttribute ['rotation',[0,0,269.599]];

	_hash = [_o,'Gloves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Gloves_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.32,3729.98,17.1307]];
	_o set3DENAttribute ['rotation',[0,0,304.814]];

	_hash = [_o,'Gloves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Gloves_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.35,3730.13,17.1307]];
	_o set3DENAttribute ['rotation',[0,0,291.373]];

	_hash = [_o,'Gloves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Shovel_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.32,3729.87,17.5756]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Shovel'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Shovel_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.65,3730.8,17.94]];
	_o set3DENAttribute ['rotation',[0,0,331.19]];

	_hash = [_o,'Shovel'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tire", [0,0,0]];
	_o set3DENAttribute ['position',[3825.37,3730,18.0263]];
	_o set3DENAttribute ['rotation',[0,0,0.147172]];

	_hash = [_o,'ToolPipe'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3818.35,3715.36,25.4959]];
	_o set3DENAttribute ['rotation',[0,0,268.511]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3818.41,3752.55,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3809.31,3762.68,24.4758]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.11,3752.47,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3829.27,3752.68,24.6658]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.52,3762.51,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3829.94,3763.31,22.0431]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3809.62,3751.93,24.4605]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3818.81,3762.59,41.2745]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3819.9,3762.8,24.5111]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3839.8,3774.27,22.1058]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3828.82,3772.37,38.9462]];
	_o set3DENAttribute ['rotation',[0,13.3968,0.990371]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_brick", [0,0,0]];
	_o set3DENAttribute ['position',[3819.73,3752.01,24.4529]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockBrick'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3839.36,3753.33,31.1951]];
	_o set3DENAttribute ['rotation',[0,0,86.4024]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3838.51,3768.89,21.9938]];
	_o set3DENAttribute ['rotation',[0,0,1.39446]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swBar"]] call mm_importOld_regFunc;

	[_o,'_transBar'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chair2", [0,0,0]];
	_o set3DENAttribute ['position',[3827.98,3775.25,22.5232]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairBigCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.72,3770.45,22.5018]];
	_o set3DENAttribute ['rotation',[0,0,177.054]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.98,3772.66,22.0988]];
	_o set3DENAttribute ['rotation',[0,0,180.243]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.9,3770.41,22.5064]];
	_o set3DENAttribute ['rotation',[0,0,87.3974]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3830.96,3771.23,24.7221]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling_Red'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barlight"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3823.16,3761.71,29.1036]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3809.74,3747.86,26.9001]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySec"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3827.68,3752.93,27.2416]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3817.64,3760.45,27.0678]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCitySec"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3834.64,3774.25,24.6921]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barstoika"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3838.67,3775.94,25.2007]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barwork"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3808.84,3764.16,28.5823]];
	_o set3DENAttribute ['rotation',[178.546,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3819.32,3763.99,25.2246]];
	_o set3DENAttribute ['rotation',[0.8863,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3814.3,3764.32,28.5143]];
	_o set3DENAttribute ['rotation',[178.546,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3808.82,3764,25.2581]];
	_o set3DENAttribute ['rotation',[0.8863,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3819.25,3764.11,28.5198]];
	_o set3DENAttribute ['rotation',[178.546,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3814.61,3764.06,25.2604]];
	_o set3DENAttribute ['rotation',[0.8863,0.395819,90.0872]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3819.79,3748.32,22.5957]];
	_o set3DENAttribute ['rotation',[0,0,345.292]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swCityLiving"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3824.22,3748.37,24.5527]];
	_o set3DENAttribute ['rotation',[359.907,0.378,90]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3836.68,3771.14,21.9594]];
	_o set3DENAttribute ['rotation',[0,0,270.613]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3812.9,3768.66,29.1309]];
	_o set3DENAttribute ['rotation',[0,0,183.132]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.18,3750.27,27.6276]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3816.15,3757.48,27.5465]];
	_o set3DENAttribute ['rotation',[0,0,269.66]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.9,3765.53,27.6177]];
	_o set3DENAttribute ['rotation',[0,0,269.187]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.52,3752.68,27.5082]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3815.27,3762.85,27.5979]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.39,3773.22,22.522]];
	_o set3DENAttribute ['rotation',[0,0,90.7941]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.34,3759.37,22.1341]];
	_o set3DENAttribute ['rotation',[0,0,357.708]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3813.38,3758.4,24.3852]];
	_o set3DENAttribute ['rotation',[0,0,178.73]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3811.61,3752.1,24.2862]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3824.11,3756.28,24.6538]];
	_o set3DENAttribute ['rotation',[0,0,270.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3829.44,3749.38,24.5819]];
	_o set3DENAttribute ['rotation',[0,0,270.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3828.16,3756.29,24.7085]];
	_o set3DENAttribute ['rotation',[0,0,270.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3831.54,3753.68,24.6074]];
	_o set3DENAttribute ['rotation',[0,0,270.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak2", [0,0,0]];
	_o set3DENAttribute ['position',[3824.65,3749.25,24.7453]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BedOld'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak2", [0,0,0]];
	_o set3DENAttribute ['position',[3832.88,3754.55,24.7002]];
	_o set3DENAttribute ['rotation',[0,0,88.1509]];

	_hash = [_o,'BedOld'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak2", [0,0,0]];
	_o set3DENAttribute ['position',[3832.46,3756.39,24.6085]];
	_o set3DENAttribute ['rotation',[0,0,0.940592]];

	_hash = [_o,'BedOld'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3808.82,3752.4,24.5554]];
	_o set3DENAttribute ['rotation',[0,0,89.7904]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_1","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3809.6,3753.25,27.5226]];
	_o set3DENAttribute ['rotation',[0,0,357.739]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["badhome_5","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3812.41,3755.15,27.505]];
	_o set3DENAttribute ['rotation',[0,0,357.739]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["badhome_4","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3821.08,3751.2,24.547]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_9","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3813,3755.95,27.5324]];
	_o set3DENAttribute ['rotation',[0,0,264.298]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["badhome_3","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3833.59,3759.52,21.9361]];
	_o set3DENAttribute ['rotation',[0,0,260.778]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3812.57,3761.82,24.69]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_4","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3817.84,3762.02,27.6436]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_8","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3816.2,3758.21,24.2781]];
	_o set3DENAttribute ['rotation',[0,0,89.8605]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_2","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3812.62,3762.12,27.6101]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_7","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3817.72,3761.86,24.4602]];
	_o set3DENAttribute ['rotation',[0,0,0.520406]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["home_5","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3811.61,3758.73,27.5601]];
	_o set3DENAttribute ['rotation',[0,0,272.562]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["badhome_1","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3811.55,3757.32,27.5519]];
	_o set3DENAttribute ['rotation',[0,0,272.562]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["badhome_2","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3821.96,3748.8,24.9186]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3811.36,3761.66,24.4591]];
	_o set3DENAttribute ['rotation',[0,0,179.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3827.09,3751.12,24.5594]];
	_o set3DENAttribute ['rotation',[0,0,182.36]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3831.96,3750.92,24.6033]];
	_o set3DENAttribute ['rotation',[0,0,0.968515]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3826.94,3754.92,24.6793]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3816.65,3761.89,27.6136]];
	_o set3DENAttribute ['rotation',[0,0,182.189]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3816.53,3761.76,24.552]];
	_o set3DENAttribute ['rotation',[0,0,182.189]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3831.75,3754.91,24.7284]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3811.41,3761.95,27.5652]];
	_o set3DENAttribute ['rotation',[0,0,179.67]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knife2", [0,0,0]];
	_o set3DENAttribute ['position',[3839.69,3772.74,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,91.7937]];

	_hash = [_o,'KitchenKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knife2", [0,0,0]];
	_o set3DENAttribute ['position',[3839.71,3772.6,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,104.326]];

	_hash = [_o,'KitchenKnife'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Sponge_01_Wet_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.44,3772.65,23.0803]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Butter'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Sponge_01_Wet_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.24,3772.78,23.0608]];
	_o set3DENAttribute ['rotation',[359.639,0.363922,84.4708]];

	_hash = [_o,'Butter'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Sponge_01_Wet_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.35,3772.98,23.0641]];
	_o set3DENAttribute ['rotation',[0,0,145.297]];

	_hash = [_o,'Butter'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Sponge_01_Wet_F", [0,0,0]];
	_o set3DENAttribute ['position',[3837.45,3772.83,23.0688]];
	_o set3DENAttribute ['rotation',[0,0,222.737]];

	_hash = [_o,'Butter'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3822.69,3760.74,21.8209]];
	_o set3DENAttribute ['rotation',[0,0,266.909]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_doskarez", [0,0,0]];
	_o set3DENAttribute ['position',[3839.62,3773.01,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CuttingBoard'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3834.66,3775.61,23.6985]];
	_o set3DENAttribute ['rotation',[84.8362,355.729,270.386]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;
	[_o,'name',"Табличка"] call mm_importOld_regVar;

	[_o,'_sw_barsign'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3834.31,3775.61,23.6865]];
	_o set3DENAttribute ['rotation',[84.8362,355.729,270.386]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;
	[_o,'name',"Стойка"] call mm_importOld_regVar;

	[_o,'_sw_barstoika'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3833.93,3775.62,23.6821]];
	_o set3DENAttribute ['rotation',[84.8362,355.729,270.386]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;
	[_o,'name',"Свет"] call mm_importOld_regVar;

	[_o,'_sw_barlight'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3833.61,3775.65,23.6826]];
	_o set3DENAttribute ['rotation',[84.8362,355.729,270.386]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;
	[_o,'name',"Приватная зона"] call mm_importOld_regVar;

	[_o,'_sw_barvip'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.48,3775.46,23.0529]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SugarShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.38,3775.27,23.0521]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SaltShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.51,3775.13,23.0653]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PepperShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.38,3775.45,23.0568]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SugarShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.51,3775.28,23.0466]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SaltShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ibuprofenka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.4,3775.13,23.066]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PepperShaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.23,3775.16,23.5811]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.2,3774.51,23.2842]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.22,3774.06,23.2812]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.28,3774.46,23.5803]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.2,3775.15,23.2804]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.2,3774.82,23.5815]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.24,3774.2,23.2786]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.22,3775,23.2801]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.22,3774.99,23.5812]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.27,3774.11,23.5838]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3837.43,3772.43,23.0612]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MilkBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3837.23,3772.27,23.0536]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MilkBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.28,3774.25,23.5769]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3837.52,3772.22,23.0628]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MilkBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.21,3774.81,23.2795]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "buhlo1", [0,0,0]];
	_o set3DENAttribute ['position',[3836.2,3774.34,23.2764]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SpirtBottle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.41,3773.25,22.3547]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.25,3773.84,22.3077]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.39,3774.1,22.3091]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.29,3774.32,22.3101]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.48,3774.47,22.3146]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.23,3773.13,22.3039]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.44,3773.79,22.2905]];
	_o set3DENAttribute ['rotation',[0,0,327.261]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.42,3772.94,22.3351]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.36,3773.52,22.308]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "egg", [0,0,0]];
	_o set3DENAttribute ['position',[3837.37,3774.67,22.3121]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Egg'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "risochek", [0,0,0]];
	_o set3DENAttribute ['position',[3837.32,3772.15,22.3219]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Muka'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "risochek", [0,0,0]];
	_o set3DENAttribute ['position',[3837.33,3772.31,22.3421]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Muka'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "risochek", [0,0,0]];
	_o set3DENAttribute ['position',[3837.32,3772.5,22.3404]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Muka'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "risochek", [0,0,0]];
	_o set3DENAttribute ['position',[3837.33,3772.72,22.3373]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Muka'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "okorok", [0,0,0]];
	_o set3DENAttribute ['position',[3837.32,3773.37,23.1136]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Meat'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "okorok", [0,0,0]];
	_o set3DENAttribute ['position',[3837.33,3774.25,23.1223]];
	_o set3DENAttribute ['rotation',[0,0,113.285]];

	_hash = [_o,'Meat'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "okorok", [0,0,0]];
	_o set3DENAttribute ['position',[3837.2,3773.79,23.1184]];
	_o set3DENAttribute ['rotation',[0,0,225.102]];

	_hash = [_o,'Meat'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "okorok", [0,0,0]];
	_o set3DENAttribute ['position',[3837.32,3774.75,23.1182]];
	_o set3DENAttribute ['rotation',[0,0,185.169]];

	_hash = [_o,'Meat'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_skovoroda", [0,0,0]];
	_o set3DENAttribute ['position',[3839.68,3772,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,354.625]];

	_hash = [_o,'FryingPan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3809.83,3765.15,27.587]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3815.42,3764.81,27.6194]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3823.29,3749.7,24.4641]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sundugan", [0,0,0]];
	_o set3DENAttribute ['position',[3835.87,3773.53,22.5238]];
	_o set3DENAttribute ['rotation',[0,0,266.921]];

	_hash = [_o,'ContainerGreen'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Mug",5]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["WoodenCup",5]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["OlderWoodenCup",5]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bar_stoika", [0,0,0]];
	_o set3DENAttribute ['position',[3836.29,3774.64,22.5209]];
	_o set3DENAttribute ['rotation',[0,0,179.774]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\bar_stoika.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenCounter_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.87,3774.34,22.4154]];
	_o set3DENAttribute ['rotation',[0,0,88.7406]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\props_f_exp\commercial\market\woodencounter_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chairbar3", [0,0,0]];
	_o set3DENAttribute ['position',[3833.12,3773.45,22.4541]];
	_o set3DENAttribute ['rotation',[0,0,264.524]];

	_hash = [_o,'BarChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chairbar3", [0,0,0]];
	_o set3DENAttribute ['position',[3833.06,3774.22,22.4276]];
	_o set3DENAttribute ['rotation',[0,0,272.157]];

	_hash = [_o,'BarChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chairbar3", [0,0,0]];
	_o set3DENAttribute ['position',[3833.07,3775.09,22.404]];
	_o set3DENAttribute ['rotation',[0,0,276.533]];

	_hash = [_o,'BarChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stelazh_ot_seregi", [0,0,0]];
	_o set3DENAttribute ['position',[3837.3,3773.88,22.0744]];
	_o set3DENAttribute ['rotation',[0,0,91.0344]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\stelazh_ot_seregi\stelazh_ot_seregi.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3811.85,3760.53,27.2745]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3817.63,3760.52,27.2658]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[3808.52,3760.51,27.2855]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3825.71,3755.03,24.5675]];
	_o set3DENAttribute ['rotation',[0,0,0.409249]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["hotelroom_1","hotelmain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o,'desc',"На двери вдино старый номерок с цифрой 1"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3828.35,3750.88,24.4314]];
	_o set3DENAttribute ['rotation',[0,0,180.96]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["hotelroom_5","hotelmain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o,'desc',"На двери вдино старый номерок с цифрой 5"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3830.78,3750.76,24.5715]];
	_o set3DENAttribute ['rotation',[0,0,180.96]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["hotelroom_4","hotelmain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o,'desc',"На двери вдино старый номерок с цифрой 4"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3831.46,3751.68,24.5835]];
	_o set3DENAttribute ['rotation',[0,0,88.8413]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["hotelroom_3","hotelmain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o,'desc',"На двери вдино старый номерок с цифрой 3"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3830.5,3754.97,24.5544]];
	_o set3DENAttribute ['rotation',[0,0,357.061]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["hotelroom_2","hotelmain"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o,'desc',"На двери вдино старый номерок с цифрой 2"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "press", [0,0,0]];
	_o set3DENAttribute ['position',[3839.67,3773.45,22.9501]];
	_o set3DENAttribute ['rotation',[0,0,178.483]];

	_hash = [_o,'MeatGrinder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Sign_Bar_RU", [0,0,0]];
	_o set3DENAttribute ['position',[3833.4,3766.37,25.9562]];
	_o set3DENAttribute ['rotation',[359.698,0.414213,93.1436]];

	_hash = [_o,'SignBar'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barsign"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok2", [0,0,0]];
	_o set3DENAttribute ['position',[3837.17,3770.9,22.0666]];
	_o set3DENAttribute ['rotation',[0,0,264.413]];

	_hash = [_o,'FabricBagBig2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3835.62,3769.7,22.5322]];
	_o set3DENAttribute ['rotation',[0,0,115.93]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3835.6,3770.88,22.5279]];
	_o set3DENAttribute ['rotation',[0,0,87.4884]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.24,3772.27,22.5228]];
	_o set3DENAttribute ['rotation',[0,0,179.967]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.41,3769.52,22.5246]];
	_o set3DENAttribute ['rotation',[0,0,174.5]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.43,3774.24,22.5236]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.24,3771.22,22.5226]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.81,3768.93,22.5521]];
	_o set3DENAttribute ['rotation',[0,0,163.653]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.56,3769.53,22.5239]];
	_o set3DENAttribute ['rotation',[0,0,178.082]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3811,3759.49,27.7802]];
	_o set3DENAttribute ['rotation',[0,0,179.392]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3808.86,3752.82,27.6245]];
	_o set3DENAttribute ['rotation',[0,0,91.2628]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3816.61,3756.48,24.4154]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3808.51,3756.06,24.3527]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3833.49,3767.28,22.0742]];
	_o set3DENAttribute ['rotation',[0,0,94.9104]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed2", [0,0,0]];
	_o set3DENAttribute ['position',[3815.37,3753.69,27.5393]];
	_o set3DENAttribute ['rotation',[0,0,354.524]];

	_hash = [_o,'HospitalBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3816.3,3762.86,27.6307]];
	_o set3DENAttribute ['rotation',[0,0,78.5157]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3808.1,3764.34,27.6092]];
	_o set3DENAttribute ['rotation',[0,0,90.8594]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3812.89,3764.51,27.648]];
	_o set3DENAttribute ['rotation',[0,0,173.707]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3814.4,3751.37,27.5395]];
	_o set3DENAttribute ['rotation',[0,0,327.165]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed5", [0,0,0]];
	_o set3DENAttribute ['position',[3815.11,3753.81,24.4433]];
	_o set3DENAttribute ['rotation',[0,0,2.98866]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed5", [0,0,0]];
	_o set3DENAttribute ['position',[3813.53,3764.55,24.4715]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3809.72,3762.96,27.6067]];
	_o set3DENAttribute ['rotation',[0,0,179.184]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3818.38,3764.41,27.6486]];
	_o set3DENAttribute ['rotation',[0,0,359.25]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3815.52,3763.62,24.473]];
	_o set3DENAttribute ['rotation',[0,0,355.244]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_wooden_b", [0,0,0]];
	_o set3DENAttribute ['position',[3818.74,3765.88,28.8759]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'ClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_9", [0,0,0]];
	_o set3DENAttribute ['position',[3815.22,3751.71,24.5275]];
	_o set3DENAttribute ['rotation',[0,0,182.564]];

	_hash = [_o,'SteelBrownContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_9", [0,0,0]];
	_o set3DENAttribute ['position',[3811.3,3752.54,27.5554]];
	_o set3DENAttribute ['rotation',[0,0,265.878]];

	_hash = [_o,'SteelBrownContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok1", [0,0,0]];
	_o set3DENAttribute ['position',[3837.12,3769.91,22.0817]];
	_o set3DENAttribute ['rotation',[0,0,269.495]];

	_hash = [_o,'FabricBagBig1'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_a", [0,0,0]];
	_o set3DENAttribute ['position',[3810.83,3765.76,27.5463]];
	_o set3DENAttribute ['rotation',[0,0,269.008]];

	_hash = [_o,'CaseBedroomSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_a", [0,0,0]];
	_o set3DENAttribute ['position',[3822.02,3748.6,24.4889]];
	_o set3DENAttribute ['rotation',[0,0,86.04]];

	_hash = [_o,'CaseBedroomSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_a", [0,0,0]];
	_o set3DENAttribute ['position',[3815.66,3752.26,27.5136]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CaseBedroomSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3826.29,3766.26,26.4506]];
	_o set3DENAttribute ['rotation',[0,0,326.621]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swBar"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_5'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_matrassych", [0,0,0]];
	_o set3DENAttribute ['position',[3810.3,3758.61,27.5308]];
	_o set3DENAttribute ['rotation',[0,0,87.0441]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\eft\matrassych.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3814.57,3756.51,27.1923]];
	_o set3DENAttribute ['rotation',[0,0,359.258]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3814.75,3761.09,27.4489]];
	_o set3DENAttribute ['rotation',[0,0,270.034]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_UrnaMetall", [0,0,0]];
	_o set3DENAttribute ['position',[3823.69,3755.11,24.4344]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'TrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_1", [0,0,0]];
	_o set3DENAttribute ['position',[3815.35,3755.98,24.5302]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedSteelBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjKreslo", [0,0,0]];
	_o set3DENAttribute ['position',[3810.42,3756.12,24.5604]];
	_o set3DENAttribute ['rotation',[0,0,69.5128]];

	_hash = [_o,'BumArmChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3830.15,3763.82,20.1751]];
	_o set3DENAttribute ['rotation',[0,0,275.046]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3834.4,3769.82,23.3053]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3828.53,3770.29,23.371]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3827.29,3773.02,23.3866]];
	_o set3DENAttribute ['rotation',[0,0,205.818]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3827.43,3773.35,23.3866]];
	_o set3DENAttribute ['rotation',[0,0,187.095]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3827.46,3770.8,23.371]];
	_o set3DENAttribute ['rotation',[0,0,335.383]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3827.67,3770.07,23.371]];
	_o set3DENAttribute ['rotation',[0,0,186.512]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3834.6,3770.81,23.3491]];
	_o set3DENAttribute ['rotation',[0,0,72.8138]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3809.5,3750.51,27.429]];
	_o set3DENAttribute ['rotation',[0,0,202.743]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3813.15,3757.24,27.2371]];
	_o set3DENAttribute ['rotation',[0,0,98.4319]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3811.03,3753.18,27.457]];
	_o set3DENAttribute ['rotation',[0,0,187.23]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3815.27,3766.33,27.4596]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3812.72,3755.09,27.3659]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3830.61,3774.81,25.1423]];
	_o set3DENAttribute ['rotation',[0,0,89.8999]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3834.7,3774.86,25.1287]];
	_o set3DENAttribute ['rotation',[0,0,89.8999]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zabori", [0,0,0]];
	_o set3DENAttribute ['position',[3815.22,3750.42,27.8944]];
	_o set3DENAttribute ['rotation',[0,0,1.63177]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\zabori.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Barn_W_02", [0,0,0]];
	_o set3DENAttribute ['position',[3831.2,3775.2,21.7215]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenAmbarWithDoors'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe3_big_18_F", [0,0,0]];
	_o set3DENAttribute ['position',[3835.22,3770.58,19.3043]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\pipes\indpipe3_big_18_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_okn_1", [0,0,0]];
	_o set3DENAttribute ['position',[3826.97,3757.82,24.6667]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_okn_1", [0,0,0]];
	_o set3DENAttribute ['position',[3831.07,3757.84,24.6782]];
	_o set3DENAttribute ['rotation',[359.603,359.676,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1o.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pandus_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3827.43,3760.94,23.7373]];
	_o set3DENAttribute ['rotation',[0,357.493,178.092]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pand_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pandus_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3827.04,3764.77,23.8468]];
	_o set3DENAttribute ['rotation',[0,357.493,178.092]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pand_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pandus_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3810.56,3744.33,23.7882]];
	_o set3DENAttribute ['rotation',[0,0,271.556]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pand_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pandus_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3838.29,3775.36,22.2827]];
	_o set3DENAttribute ['rotation',[0,0,2.63438]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pand_3x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_krysha_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3827.1,3758.02,29.4071]];
	_o set3DENAttribute ['rotation',[0,345.701,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\krysha.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_Rugs1_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3817.6,3751.61,20.0238]];
	_o set3DENAttribute ['rotation',[0,0,98.7744]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_rugs1_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3826.45,3756.3,24.4852]];
	_o set3DENAttribute ['rotation',[0,0,270.81]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3830.21,3756.31,24.5345]];
	_o set3DENAttribute ['rotation',[0,0,270.81]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3831.46,3749.43,24.5162]];
	_o set3DENAttribute ['rotation',[0,0,273.291]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3832.93,3752.78,24.5457]];
	_o set3DENAttribute ['rotation',[0,0,359.325]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_concrete_slub3", [0,0,0]];
	_o set3DENAttribute ['position',[3826.63,3749.59,24.594]];
	_o set3DENAttribute ['rotation',[0,0,92.2283]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\redgates\concrete_slub3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3811.91,3751.53,27.5566]];
	_o set3DENAttribute ['rotation',[0,0,79.2594]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3810.23,3756.48,27.5531]];
	_o set3DENAttribute ['rotation',[0,0,175.398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3808.81,3755.35,27.5759]];
	_o set3DENAttribute ['rotation',[0,0,88.0372]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3810.25,3757.9,27.5519]];
	_o set3DENAttribute ['rotation',[0,0,175.398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3816.35,3751.45,27.4903]];
	_o set3DENAttribute ['rotation',[0,0,88.2682]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3808.85,3758.09,27.4621]];
	_o set3DENAttribute ['rotation',[0,0,273.186]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3827.94,3774.84,22.3687]];
	_o set3DENAttribute ['rotation',[0,0,177.539]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3816.19,3753.93,27.3923]];
	_o set3DENAttribute ['rotation',[0,0,81.4727]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3814.76,3757.93,27.3243]];
	_o set3DENAttribute ['rotation',[0,0,359.602]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3811.74,3753.57,27.412]];
	_o set3DENAttribute ['rotation',[0,0,89.5821]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3814.49,3755.22,27.4154]];
	_o set3DENAttribute ['rotation',[0,0,176.299]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3834.98,3773.11,22.2906]];
	_o set3DENAttribute ['rotation',[0,0,180.046]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3833.34,3775.56,22.3345]];
	_o set3DENAttribute ['rotation',[0,0,180.046]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_fanerka_vata", [0,0,0]];
	_o set3DENAttribute ['position',[3813.82,3759.25,24.2737]];
	_o set3DENAttribute ['rotation',[0,0,89.4323]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\fanerka_vata.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_fanerka_vata", [0,0,0]];
	_o set3DENAttribute ['position',[3811.31,3751.27,24.0975]];
	_o set3DENAttribute ['rotation',[0,0,91.5119]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\fanerka_vata.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoxyeta", [0,0,0]];
	_o set3DENAttribute ['position',[3825.46,3751.55,27.4179]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoxyeta.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoxyeta", [0,0,0]];
	_o set3DENAttribute ['position',[3828.47,3755.36,27.4513]];
	_o set3DENAttribute ['rotation',[0,0,91.223]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoxyeta.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3815.04,3757.45,24.4665]];
	_o set3DENAttribute ['rotation',[0,0,0.231799]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3814.99,3753.18,24.4352]];
	_o set3DENAttribute ['rotation',[0,0,0.231799]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3810.91,3752.52,24.4588]];
	_o set3DENAttribute ['rotation',[0,0,88.5681]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3812.88,3757.46,24.4841]];
	_o set3DENAttribute ['rotation',[0,0,172.544]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3810.61,3757.18,24.4681]];
	_o set3DENAttribute ['rotation',[0,0,0.231799]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak1", [0,0,0]];
	_o set3DENAttribute ['position',[3834.33,3749.68,24.6359]];
	_o set3DENAttribute ['rotation',[0,0,178.022]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\postel_panelak1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak1", [0,0,0]];
	_o set3DENAttribute ['position',[3816.3,3764.79,24.3916]];
	_o set3DENAttribute ['rotation',[0,0,270.654]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\postel_panelak1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak1", [0,0,0]];
	_o set3DENAttribute ['position',[3811.93,3757.98,24.5246]];
	_o set3DENAttribute ['rotation',[0,0,270.113]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\postel_panelak1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_postel_panelak1", [0,0,0]];
	_o set3DENAttribute ['position',[3825.53,3756.53,24.745]];
	_o set3DENAttribute ['rotation',[0,0,270.654]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\furniture\postel_panelak1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "matras_2", [0,0,0]];
	_o set3DENAttribute ['position',[3810.6,3751.15,27.5952]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\matras_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "matras_2", [0,0,0]];
	_o set3DENAttribute ['position',[3814.82,3757.17,27.5865]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\matras_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "matras_2", [0,0,0]];
	_o set3DENAttribute ['position',[3810.19,3757.19,27.6485]];
	_o set3DENAttribute ['rotation',[0,0,176.292]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\matras_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_2m5_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3838.14,3768.09,23.7713]];
	_o set3DENAttribute ['rotation',[359.941,0.401051,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_2m5_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3808.85,3794.51,24.1772]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3818.47,3795.04,43.8591]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3809.93,3794.27,48.2479]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3819.04,3794.86,34.0204]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3818.21,3804.95,43.733]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3818.69,3804.92,33.8943]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3809.26,3804.54,48.4278]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3808.18,3804.78,24.3571]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3834.32,3777.96,24.8532]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barlight"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3828.13,3776.77,25.0641]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling_Red'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barvip"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3834.41,3780.94,24.5195]];
	_o set3DENAttribute ['rotation',[0,0,359.209]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3829.25,3780.82,24.5277]];
	_o set3DENAttribute ['rotation',[0,0,359.209]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3839.55,3778.74,21.97]];
	_o set3DENAttribute ['rotation',[0,0,180.063]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3824.25,3777.6,23.1884]];
	_o set3DENAttribute ['rotation',[0,0,87.5376]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.9,3776.25,22.4487]];
	_o set3DENAttribute ['rotation',[0,0,95.8809]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3832.17,3777.59,22.4064]];
	_o set3DENAttribute ['rotation',[0,0,266.017]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["barpublic","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3835.44,3776.78,22.5206]];
	_o set3DENAttribute ['rotation',[0,0,352.75]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["barpublic","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3836.66,3776.84,21.9752]];
	_o set3DENAttribute ['rotation',[0,0,89.5133]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3837.39,3778.56,23.2755]];
	_o set3DENAttribute ['rotation',[275.15,359.278,89.9361]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;

	[_o,'_sw_barwork'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box", [0,0,0]];
	_o set3DENAttribute ['position',[3839.36,3778.05,22.0776]];
	_o set3DENAttribute ['rotation',[0,0,179.266]];

	_hash = [_o,'ContainerGreen3'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box", [0,0,0]];
	_o set3DENAttribute ['position',[3835.03,3780.22,22.5035]];
	_o set3DENAttribute ['rotation',[0.0203631,0.0518948,180.541]];

	_hash = [_o,'ContainerGreen3'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["FoodPlate",5]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["SoupPlate",5]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Ключ от комнаты #1"],["var","keyOwner",["hotelroom_1"]]]]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Ключ от комнаты #2"],["var","keyOwner",["hotelroom_2"]]]]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Ключ от комнаты #3"],["var","keyOwner",["hotelroom_3"]]]]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Ключ от комнаты #4"],["var","keyOwner",["hotelroom_4"]]]]] call mm_importOld_regFunc;
	[_o,'createItemInContainer',["Key",2,100,[["var","name","Ключ от комнаты #5"],["var","keyOwner",["hotelroom_5"]]]]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok2", [0,0,0]];
	_o set3DENAttribute ['position',[3836.07,3780.35,22.5189]];
	_o set3DENAttribute ['rotation',[0,0,52.3466]];

	_hash = [_o,'FabricBagBig2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.85,3779.44,22.5201]];
	_o set3DENAttribute ['rotation',[0,0,272.305]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.37,3779.99,22.5198]];
	_o set3DENAttribute ['rotation',[0,0,286.646]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3834.05,3780.42,22.5193]];
	_o set3DENAttribute ['rotation',[0,0,2.73732]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.7,3780.04,22.5205]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_stulcasual", [0,0,0]];
	_o set3DENAttribute ['position',[3828.79,3776.65,22.434]];
	_o set3DENAttribute ['rotation',[0,0,146.635]];

	_hash = [_o,'ChairCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjDivan", [0,0,0]];
	_o set3DENAttribute ['position',[3827.67,3780.05,22.4508]];
	_o set3DENAttribute ['rotation',[0,0,171.937]];

	_hash = [_o,'SofaBrown'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3827.12,3776.55,22.5243]];
	_o set3DENAttribute ['rotation',[0,0,110.329]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[3828.2,3776.09,23.3154]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3827.92,3776.19,23.3154]];
	_o set3DENAttribute ['rotation',[0,0,335.383]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3834.81,3776.11,22.52]];
	_o set3DENAttribute ['rotation',[0,0,84.0636]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3832.14,3776.29,22.2431]];
	_o set3DENAttribute ['rotation',[0,0,100.617]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3829.53,3779.95,22.2725]];
	_o set3DENAttribute ['rotation',[0,0,90.9357]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe3_big_18_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.24,3776.75,19.3342]];
	_o set3DENAttribute ['rotation',[0,0,91.742]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\pipes\indpipe3_big_18_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3829.47,3776.16,22.3646]];
	_o set3DENAttribute ['rotation',[0,0,89.8081]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3832.14,3779.64,22.3958]];
	_o set3DENAttribute ['rotation',[0,0,89.8081]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stolempire", [0,0,0]];
	_o set3DENAttribute ['position',[3828,3776.19,22.3874]];
	_o set3DENAttribute ['rotation',[0,0,203.43]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\stolempire.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shtora_pravo", [0,0,0]];
	_o set3DENAttribute ['position',[3829.63,3778.03,19.1746]];
	_o set3DENAttribute ['rotation',[0,0,89.6341]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\shabbat\shtora_pravo.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3827.27,3825.87,23.8999]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3816.78,3815.16,24.2323]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.97,3825.92,32.4096]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3827.47,3815.39,33.2849]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3816.61,3826.14,24.1821]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.9,3836.33,32.3001]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.73,3836.91,23.906]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3817.32,3836.88,32.1513]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3816.15,3825.66,38.4948]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.82,3825.38,39.0502]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.28,3836.42,40.5453]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3817.85,3814.92,48.303]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3827.15,3815.2,42.857]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3823.84,3829.15,26.0108]];
	_o set3DENAttribute ['rotation',[0,357.117,70.7607]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_GRYAZOOOKASS", [0,0,0]];
	_o set3DENAttribute ['position',[3828.43,3829.49,20.0007]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\surfaces\gryazoookass.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3821.86,3829.37,23.9584]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House02_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3814.96,3828.61,24.1522]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house02_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3829.98,3835.49,27.6056]];
	_o set3DENAttribute ['rotation',[0,0,1.44231]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3825.81,3837.22,27.522]];
	_o set3DENAttribute ['rotation',[0,0,88.977]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3827.21,3835.84,27.6472]];
	_o set3DENAttribute ['rotation',[0,0,10.0243]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_HouseBlock_A3_ruins", [0,0,0]];
	_o set3DENAttribute ['position',[3813.37,3816.36,24.5391]];
	_o set3DENAttribute ['rotation',[0,0,4.02877]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings2\houseblocks\houseblock_a\houseblock_a3_ruins.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_wall", [0,0,0]];
	_o set3DENAttribute ['position',[3825.33,3835.67,24.2556]];
	_o set3DENAttribute ['rotation',[359.6,359.934,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_wall.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3835.97,3868.5,39.7237]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.5,3847.54,23.9016]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3816.66,3847.02,32.3001]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3825.79,3869.27,24.0534]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.89,3857.95,23.9617]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3816.08,3857.22,32.1553]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3837.18,3847.05,23.6739]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.42,3868.99,24.0969]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3815.48,3867.56,32.1811]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.26,3857.9,40.3878]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.02,3858.41,23.9937]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3825.69,3868.34,39.7414]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3825.57,3857.92,40.0236]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.7,3847.27,40.4607]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3826.05,3847.05,40.6814]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3823.82,3863.02,25.5312]];
	_o set3DENAttribute ['rotation',[0,0,172.822]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3831.62,3852.17,24.202]];
	_o set3DENAttribute ['rotation',[0,0,359.037]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3839.9,3852.43,24.4934]];
	_o set3DENAttribute ['rotation',[0,0,177.031]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3835.07,3861.36,24.1909]];
	_o set3DENAttribute ['rotation',[0,0,91.1263]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3826.42,3868.17,23.3493]];
	_o set3DENAttribute ['rotation',[0,0,118.37]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3837.45,3854.08,24.4565]];
	_o set3DENAttribute ['rotation',[0,0,91.1263]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3830.23,3869.16,23.8877]];
	_o set3DENAttribute ['rotation',[0,0,28.9112]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.24,3847.73,24.2345]];
	_o set3DENAttribute ['rotation',[0,0,270.017]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.6,3859.72,24.2183]];
	_o set3DENAttribute ['rotation',[0,0,179.526]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_Shed_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.54,3845.83,23.6126]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\addons\metal_shed_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.74,3855.81,24.3606]];
	_o set3DENAttribute ['rotation',[0,0,357.531]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.31,3848.32,24.1177]];
	_o set3DENAttribute ['rotation',[5.44967,0,180.39]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3839.68,3851.13,24.0116]];
	_o set3DENAttribute ['rotation',[0,0,0.965287]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3828.5,3867.4,24.4315]];
	_o set3DENAttribute ['rotation',[0,0,27.8784]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.3,3848.23,24.1932]];
	_o set3DENAttribute ['rotation',[0,0,178.509]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.36,3850.87,24.1696]];
	_o set3DENAttribute ['rotation',[0,0,357.531]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3822.43,3856.09,25.7749]];
	_o set3DENAttribute ['rotation',[13.8468,0,359.345]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3832.14,3863.97,26.9904]];
	_o set3DENAttribute ['rotation',[0,0,172.833]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3826.87,3841.65,27.1652]];
	_o set3DENAttribute ['rotation',[0,0,167.219]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_GRYAZOOOKASS", [0,0,0]];
	_o set3DENAttribute ['position',[3820.43,3869.35,20.9253]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\surfaces\gryazoookass.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_2_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3825.3,3857.43,23.9235]];
	_o set3DENAttribute ['rotation',[0,0,1.00133]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_2_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3833.74,3858.48,24.0797]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3828.86,3846.53,24.0208]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Shed_06_F", [0,0,0]];
	_o set3DENAttribute ['position',[3827.9,3840.12,24.0463]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\sheds\shed_06_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ClothShelter_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3836.94,3865.93,23.6613]];
	_o set3DENAttribute ['rotation',[0,0,28.5206]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3839.73,3862.88,27.6657]];
	_o set3DENAttribute ['rotation',[0,0,177.473]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3839,3861.71,27.463]];
	_o set3DENAttribute ['rotation',[353.797,354.099,59.186]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3830.01,3840.26,27.261]];
	_o set3DENAttribute ['rotation',[0,0,8.69721]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3826,3840.07,27.3681]];
	_o set3DENAttribute ['rotation',[0,0,97.318]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3835.87,3858.99,26.9901]];
	_o set3DENAttribute ['rotation',[352.037,3.60801,66.3549]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3833.78,3853.84,26.5987]];
	_o set3DENAttribute ['rotation',[0.595699,359.902,355.701]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_walldoor", [0,0,0]];
	_o set3DENAttribute ['position',[3829.29,3841.37,23.8533]];
	_o set3DENAttribute ['rotation',[359.6,359.934,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_walldoor.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3836.76,3875.53,32.3686]];
	_o set3DENAttribute ['rotation',[0,0,297.963]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3825.64,3873.64,24.9885]];
	_o set3DENAttribute ['rotation',[9.04632,20.7873,293.508]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_01", [0,0,0]];
	_o set3DENAttribute ['position',[3824.17,3886.72,23.1373]];
	_o set3DENAttribute ['rotation',[0,0,267.428]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_10_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3824.61,3884.75,23.4172]];
	_o set3DENAttribute ['rotation',[359.636,0.360736,174.868]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_10_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_SharpRock_spike", [0,0,0]];
	_o set3DENAttribute ['position',[3823.8,3904.82,23.3248]];
	_o set3DENAttribute ['rotation',[0,0,0.527715]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f\sharp\sharprock_spike.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "controlpanel", [0,0,0]];
	_o set3DENAttribute ['position',[3812.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerGenerator'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_b", [0,0,0]];
	_o set3DENAttribute ['position',[3832.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CaseBedroom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pechechkas", [0,0,0]];
	_o set3DENAttribute ['position',[3811.05,3967.09,4.76837e-007]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlackSmallStove'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pechka", [0,0,0]];
	_o set3DENAttribute ['position',[3835.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallStoveGrill'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok2", [0,0,0]];
	_o set3DENAttribute ['position',[3838.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'FabricBagBig2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chai", [0,0,0]];
	_o set3DENAttribute ['position',[3837.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StationTea'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grill", [0,0,0]];
	_o set3DENAttribute ['position',[3836.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Grill'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBed_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3829.49,3966.3,-4.76837e-007]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LuxuryDoubleBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_metal_9", [0,0,0]];
	_o set3DENAttribute ['position',[3831.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelBrownContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok1", [0,0,0]];
	_o set3DENAttribute ['position',[3839.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'FabricBagBig1'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "oruzhie_crate", [0,0,0]];
	_o set3DENAttribute ['position',[3811.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenWeaponBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sofa", [0,0,0]];
	_o set3DENAttribute ['position',[3822.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedSofa'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "wesi", [0,0,0]];
	_o set3DENAttribute ['position',[3834.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Scales'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "umivalnik1", [0,0,0]];
	_o set3DENAttribute ['position',[3833.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Umivalnik'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_a", [0,0,0]];
	_o set3DENAttribute ['position',[3824.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CaseBedroomSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3823.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ConcretePanel'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_h", [0,0,0]];
	_o set3DENAttribute ['position',[3828.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedPappedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "komodvirus", [0,0,0]];
	_o set3DENAttribute ['position',[3821.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LuxuryCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_borwnskrin", [0,0,0]];
	_o set3DENAttribute ['position',[3825.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_5", [0,0,0]];
	_o set3DENAttribute ['position',[3815.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerSwitcherBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator", [0,0,0]];
	_o set3DENAttribute ['position',[3826.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ElectricalShieldSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[3827.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3820.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_UrnaMetall", [0,0,0]];
	_o set3DENAttribute ['position',[3830.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'TrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "turbonasos", [0,0,0]];
	_o set3DENAttribute ['position',[3814.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigElectricPumpFan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "turbosos", [0,0,0]];
	_o set3DENAttribute ['position',[3813.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigPipePump'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "engine_sm_01", [0,0,0]];
	_o set3DENAttribute ['position',[3819.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'OldEngine'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "engine_turbo_01", [0,0,0]];
	_o set3DENAttribute ['position',[3818.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ElectricPump'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "genagenagenerator", [0,0,0]];
	_o set3DENAttribute ['position',[3817.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallGreenGenerator'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "generator", [0,0,0]];
	_o set3DENAttribute ['position',[3816.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'DrumGenerator'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pepelishe", [0,0,0]];
	_o set3DENAttribute ['position',[3809.49,3966.3,-1.28746e-005]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CampfireBig'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_BarrelWater_grey_F", [0,0,0]];
	_o set3DENAttribute ['position',[3808.49,3966.3,-1.90735e-006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WaterBarrel'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3847.11,3579.29,8.87224]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3857.79,3578.41,8.97535]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3854.52,3576.4,8.90916]];
	_o set3DENAttribute ['rotation',[0,0,85.3912]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3848.65,3582.78,9.85734]];
	_o set3DENAttribute ['rotation',[359.102,359.633,271.895]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3864.14,3580.69,9.48886]];
	_o set3DENAttribute ['rotation',[0,0,274.514]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3855.15,3571.49,12.5993]];
	_o set3DENAttribute ['rotation',[0,0,4.42781]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv_okn_1", [0,0,0]];
	_o set3DENAttribute ['position',[3859.29,3583.94,8.8096]];
	_o set3DENAttribute ['rotation',[0,0,3.98848]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_do1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3846.98,3575.69,9.11322]];
	_o set3DENAttribute ['rotation',[0,0,95.474]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3860.08,3575.77,9.42322]];
	_o set3DENAttribute ['rotation',[0,0,269.721]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3858.72,3602.93,28.7844]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3847.56,3604.61,28.7692]];
	_o set3DENAttribute ['rotation',[0,0,13.4403]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3867.47,3612.17,29.6046]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3848.57,3600.38,8.758]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3849.83,3611.34,8.85627]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3871.21,3609.33,8.85254]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3859.58,3599.48,8.68439]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3848.05,3589.8,18.3117]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3871.96,3600.54,18.8673]];
	_o set3DENAttribute ['rotation',[0,0,352.789]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.33,3610.42,8.74714]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3858.49,3588.34,8.74569]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CastleRuins_01_wall_10m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3858.45,3607.41,6.2207]];
	_o set3DENAttribute ['rotation',[0,0,275.809]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\castleruins\castleruins_01_wall_10m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3854.04,3584.47,8.7138]];
	_o set3DENAttribute ['rotation',[0,0,185.267]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3867.53,3614.73,15.9567]];
	_o set3DENAttribute ['rotation',[181.534,0.243713,265.468]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3865.56,3600.1,9.64548]];
	_o set3DENAttribute ['rotation',[0,0,274.514]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3851.26,3596.77,9.26274]];
	_o set3DENAttribute ['rotation',[0,0,92.4831]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_Shed_F", [0,0,0]];
	_o set3DENAttribute ['position',[3848.74,3599.4,8.53063]];
	_o set3DENAttribute ['rotation',[0,0,184.611]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\addons\metal_shed_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x18", [0,0,0]];
	_o set3DENAttribute ['position',[3853.8,3593.43,17.663]];
	_o set3DENAttribute ['rotation',[0,0,5.15389]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x18.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3855.34,3613.15,8.3082]];
	_o set3DENAttribute ['rotation',[0,0,207.082]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3861.29,3604.75,8.91057]];
	_o set3DENAttribute ['rotation',[0,0,281.457]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3857.59,3598.77,8.77368]];
	_o set3DENAttribute ['rotation',[0,0,333.468]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House02_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3847.35,3610.44,8.7907]];
	_o set3DENAttribute ['rotation',[0,0,31.9462]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house02_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3855.06,3614.82,8.60455]];
	_o set3DENAttribute ['rotation',[0,6.95698,97.318]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "germodweri", [0,0,0]];
	_o set3DENAttribute ['position',[3865.85,3614.38,8.6822]];
	_o set3DENAttribute ['rotation',[0,0,275.234]];

	_hash = [_o,'GateCity'] call mm_importOld_initHashData;
	[_o,'connectTo',["_unlimgenTDM"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3855.63,3587.01,9.11828]];
	_o set3DENAttribute ['rotation',[0,0,271.834]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_walldoor", [0,0,0]];
	_o set3DENAttribute ['position',[3863.83,3591.13,8.88742]];
	_o set3DENAttribute ['rotation',[5.82028,356.059,11.033]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_walldoor.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3842.44,3644.08,27.068]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3852.59,3634.3,37.1129]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3842.15,3633.95,28.2563]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3853.58,3642.97,26.8315]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3840.3,3623.06,8.77272]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.93,3621.21,8.84476]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3850.92,3622.11,8.91836]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3862.07,3643.35,7.92855]];
	_o set3DENAttribute ['rotation',[7.23837,359.575,172.738]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3852.1,3632.99,9.01663]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3862.99,3643.55,23.482]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3852.86,3644.18,16.4203]];
	_o set3DENAttribute ['rotation',[0,0,183.348]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3862.61,3631.7,8.80699]];
	_o set3DENAttribute ['rotation',[4.94411,359.592,4.70112]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3863.12,3633.32,28.8895]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3841.05,3634,8.83547]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3863.23,3622.43,31.2118]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3842.47,3644.4,16.8745]];
	_o set3DENAttribute ['rotation',[0,0,183.348]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3871.05,3621.94,8.76591]];
	_o set3DENAttribute ['rotation',[0,0,189.996]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3853.08,3635.83,10.0604]];
	_o set3DENAttribute ['rotation',[4.02352,354.141,191.478]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_02_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3844.32,3632.43,9.09541]];
	_o set3DENAttribute ['rotation',[357.578,4.87966,70.8384]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_02_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3867.78,3628.53,9.1773]];
	_o set3DENAttribute ['rotation',[0,0,274.514]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3871.03,3621.83,9.63049]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3864.71,3617.95,8.34485]];
	_o set3DENAttribute ['rotation',[0,0,186.275]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3869.02,3617.43,8.92038]];
	_o set3DENAttribute ['rotation',[0,0,199.49]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Barn_04_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3840.6,3620.15,30.9086]];
	_o set3DENAttribute ['rotation',[179.999,6.89043e-005,265.769]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3849.93,3620.74,8.86395]];
	_o set3DENAttribute ['rotation',[0,0,91.1749]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3856.29,3619.26,8.33039]];
	_o set3DENAttribute ['rotation',[0,0,167.219]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3840.49,3638.96,13.4362]];
	_o set3DENAttribute ['rotation',[0,0,7.36095]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3848.21,3637.99,12.1823]];
	_o set3DENAttribute ['rotation',[355.696,341.979,9.06319]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_Wall_D_right_F", [0,0,0]];
	_o set3DENAttribute ['position',[3844.33,3632.15,13.9579]];
	_o set3DENAttribute ['rotation',[358.657,2.70313,274.791]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wall_d_right_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3847.26,3637.89,9.48593]];
	_o set3DENAttribute ['rotation',[353.906,14.504,358.295]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3845.21,3617.26,8.55464]];
	_o set3DENAttribute ['rotation',[0,0,324.08]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3849.25,3630.61,9.13604]];
	_o set3DENAttribute ['rotation',[356.586,0.558957,143.864]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3841.08,3625.97,8.83698]];
	_o set3DENAttribute ['rotation',[3.29343,0.653052,78.7966]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncBarrierMedium_F", [0,0,0]];
	_o set3DENAttribute ['position',[3845.5,3623.31,8.61811]];
	_o set3DENAttribute ['rotation',[0,3.60568,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncbarriermedium_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3855.42,3617.62,8.48737]];
	_o set3DENAttribute ['rotation',[0,0,97.318]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_wall", [0,0,0]];
	_o set3DENAttribute ['position',[3862.8,3618.47,9.33566]];
	_o set3DENAttribute ['rotation',[4.93996,3.03183,178.794]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_wall.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_House_C_12_ruins_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3861.06,3628.93,10.3087]];
	_o set3DENAttribute ['rotation',[0.368754,0.124046,273.068]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\housec\house_c_12_ruins_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3854.53,3653.71,23.7283]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3864.2,3663.36,16.1589]];
	_o set3DENAttribute ['rotation',[0,0,282.763]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3852.6,3664.09,17.2437]];
	_o set3DENAttribute ['rotation',[0,0,267.297]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3863.26,3654.49,6.69991]];
	_o set3DENAttribute ['rotation',[359.608,353.369,183.392]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3844.37,3654.3,24.1314]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3842.04,3655.17,8.28387]];
	_o set3DENAttribute ['rotation',[0,350.21,183.37]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3853.03,3655,7.3048]];
	_o set3DENAttribute ['rotation',[0,0,1.07793]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3843.23,3664.55,18.1446]];
	_o set3DENAttribute ['rotation',[0,0,279.695]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3863.55,3653.38,22.9318]];
	_o set3DENAttribute ['rotation',[0,0,183.369]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3856.99,3657.01,7.76561]];
	_o set3DENAttribute ['rotation',[341.762,2.04408,107.326]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\shellcrater_02_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3847.27,3651.6,7.46734]];
	_o set3DENAttribute ['rotation',[0,0,170.768]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3869.29,3650.03,9.31943]];
	_o set3DENAttribute ['rotation',[0,0,274.514]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Canal_Wall_D_right_F", [0,0,0]];
	_o set3DENAttribute ['position',[3851.03,3650.68,11.9375]];
	_o set3DENAttribute ['rotation',[357.797,344.153,98.0193]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\canal_wall_d_right_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka4", [0,0,0]];
	_o set3DENAttribute ['position',[3865.66,3655.91,6.68461]];
	_o set3DENAttribute ['rotation',[352.146,1.33516,58.8103]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_walldoor", [0,0,0]];
	_o set3DENAttribute ['position',[3863.34,3649.96,7.36506]];
	_o set3DENAttribute ['rotation',[5.82028,356.059,352.765]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_walldoor.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ruin_wall", [0,0,0]];
	_o set3DENAttribute ['position',[3843.56,3656.41,8.54847]];
	_o set3DENAttribute ['rotation',[355.788,4.1894,67.9733]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\ruins\ruin_wall.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3870.63,3742.62,35.2899]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3870.82,3731.93,35.2186]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3869.88,3731.64,19.6914]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.73,3731.84,28.5326]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.59,3741.66,28.7675]];
	_o set3DENAttribute ['rotation',[0,0,90.4093]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3870.68,3721.64,28.4218]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3869.93,3742.49,19.7003]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3869.05,3739.77,19.3752]];
	_o set3DENAttribute ['rotation',[0,0,266.528]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["grave","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3866.14,3740.78,19.479]];
	_o set3DENAttribute ['rotation',[0.35,359.625,85]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x3", [0,0,0]];
	_o set3DENAttribute ['position',[3867.73,3737.98,19.6716]];
	_o set3DENAttribute ['rotation',[0,0,176.795]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.26,3740.61,19.3621]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.33,3739.99,19.96]];
	_o set3DENAttribute ['rotation',[0,0,271.681]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.79,3743.82,19.7188]];
	_o set3DENAttribute ['rotation',[0,0,179.339]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3866.48,3743.83,20.9507]];
	_o set3DENAttribute ['rotation',[0,0,179.339]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tinfence", [0,0,0]];
	_o set3DENAttribute ['position',[3870.71,3743.93,19.7479]];
	_o set3DENAttribute ['rotation',[0,0,87.7672]];

	_hash = [_o,'Wicket'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3869.55,3735.92,19.6259]];
	_o set3DENAttribute ['rotation',[0,0,268.558]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3871.76,3735.99,19.6933]];
	_o set3DENAttribute ['rotation',[0,0,267.495]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3867.35,3735.85,19.5809]];
	_o set3DENAttribute ['rotation',[0,0,267.495]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3868.78,3741.58,20.4385]];
	_o set3DENAttribute ['rotation',[0,0,356.321]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3866.92,3738.97,19.8021]];
	_o set3DENAttribute ['rotation',[0,0,354.895]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv_okn_1", [0,0,0]];
	_o set3DENAttribute ['position',[3868.87,3740.88,19.6754]];
	_o set3DENAttribute ['rotation',[0,0,85.3414]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_do1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_08_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.29,3728.74,19.7888]];
	_o set3DENAttribute ['rotation',[0,0,181.635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_08_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_04_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.31,3729.96,19.8045]];
	_o set3DENAttribute ['rotation',[0,0,183.101]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.48,3733.62,19.8542]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.63,3733.56,19.9217]];
	_o set3DENAttribute ['rotation',[0,0,3.65445]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3871.23,3729.54,19.7895]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.42,3729.74,19.8109]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.33,3729.76,19.7925]];
	_o set3DENAttribute ['rotation',[0,0,8.27693]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3871.38,3733.62,19.7898]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3869.57,3734.25,19.9931]];
	_o set3DENAttribute ['rotation',[0,0,182.087]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3871.28,3729.03,19.9127]];
	_o set3DENAttribute ['rotation',[0,0,182.836]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3840.32,3734.19,17.4817]];
	_o set3DENAttribute ['rotation',[0,0,91.3234]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3840.29,3726.3,17.5431]];
	_o set3DENAttribute ['rotation',[0,0,274.547]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_dmg_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.66,3741.81,19.6844]];
	_o set3DENAttribute ['rotation',[0,0,353.895]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_dmg_F", [0,0,0]];
	_o set3DENAttribute ['position',[3865.78,3741.84,19.7078]];
	_o set3DENAttribute ['rotation',[0,0,353.895]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_dmg_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.07,3739.06,19.7098]];
	_o set3DENAttribute ['rotation',[0,0,85.5066]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "matras_2", [0,0,0]];
	_o set3DENAttribute ['position',[3866.97,3742.16,19.8248]];
	_o set3DENAttribute ['rotation',[0,0,265.062]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\matras_2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.75,3741.77,19.7324]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3851.01,3774.51,41.6593]];
	_o set3DENAttribute ['rotation',[0,0,7.17808]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.08,3773.22,49.6632]];
	_o set3DENAttribute ['rotation',[0,0,355.552]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3870.92,3763.56,36.4875]];
	_o set3DENAttribute ['rotation',[0,0,359.423]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.19,3763.67,36.8313]];
	_o set3DENAttribute ['rotation',[0,0,359.238]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3869.77,3773.65,39.5926]];
	_o set3DENAttribute ['rotation',[0,0,355.552]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3850.49,3774.17,22.0818]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.04,3763.56,21.6623]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.11,3774.02,15.5964]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3850.44,3763.71,21.863]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3871.08,3763.6,21.613]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3850.78,3774.29,31.6676]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3840.06,3763.39,21.9999]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3841.44,3774.21,36.8251]];
	_o set3DENAttribute ['rotation',[0,0,0.597449]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3840.97,3763.42,36.8275]];
	_o set3DENAttribute ['rotation',[0,352.103,358.952]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3850.52,3763.66,36.2466]];
	_o set3DENAttribute ['rotation',[0,0,1.93407]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3871.08,3773.75,21.6193]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3869.93,3753.61,20.6893]];
	_o set3DENAttribute ['rotation',[352.571,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.59,3752.09,30.0684]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3870.29,3752.47,35.9316]];
	_o set3DENAttribute ['rotation',[352.571,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_6x6", [0,0,0]];
	_o set3DENAttribute ['position',[3843.62,3775.69,27.0975]];
	_o set3DENAttribute ['rotation',[0,0,271.233]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_6x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3841.44,3761.84,21.9035]];
	_o set3DENAttribute ['rotation',[0,0,85.7808]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o,'connectTo',["_swIndust"]] call mm_importOld_regFunc;

	[_o,'_transIndust'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3848.19,3764.92,24.997]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3840.55,3765.45,25.3904]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3844.85,3768.61,23.8964]];
	_o set3DENAttribute ['rotation',[0,0,350.335]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3845.23,3771.47,23.8901]];
	_o set3DENAttribute ['rotation',[0,0,275.788]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ManurePile_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3858.16,3770.34,15.838]];
	_o set3DENAttribute ['rotation',[16.9327,0,294.012]];

	_hash = [_o,'BunchOfShit'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ManurePile_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3864.04,3770.33,15.6176]];
	_o set3DENAttribute ['rotation',[0,0,30.9585]];

	_hash = [_o,'BunchOfShit'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3848.58,3760.16,22.0297]];
	_o set3DENAttribute ['rotation',[0,0,249.696]];

	_hash = [_o,'FarmGarden'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3844,3760.67,22.1956]];
	_o set3DENAttribute ['rotation',[0,0,339.344]];

	_hash = [_o,'FarmGarden'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3851.75,3760.07,21.9583]];
	_o set3DENAttribute ['rotation',[0,0,339.344]];

	_hash = [_o,'FarmGarden'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3842.95,3762.77,17.9981]];
	_o set3DENAttribute ['rotation',[0,0,151.593]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3852.69,3762.63,18.1129]];
	_o set3DENAttribute ['rotation',[0,0,228.855]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3843.75,3772.69,22.7721]];
	_o set3DENAttribute ['rotation',[0,0,182.063]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3854.22,3756.99,21.3505]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3847.89,3763.11,21.8677]];
	_o set3DENAttribute ['rotation',[0,0,201.396]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3847.83,3763.15,23.3717]];
	_o set3DENAttribute ['rotation',[0,0,201.396]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3842.61,3763.12,23.3337]];
	_o set3DENAttribute ['rotation',[0,0,164.498]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3842.71,3763.18,21.8323]];
	_o set3DENAttribute ['rotation',[0,0,164.498]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3851.63,3762.77,23.388]];
	_o set3DENAttribute ['rotation',[0,0,170.488]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3855.68,3763.1,23.2599]];
	_o set3DENAttribute ['rotation',[0,0,180.056]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3855.66,3763.11,21.6855]];
	_o set3DENAttribute ['rotation',[0,0,180.056]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3851.69,3762.76,21.811]];
	_o set3DENAttribute ['rotation',[0,0,170.488]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3860.21,3760.44,22.4369]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3860.47,3762.08,21.7576]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SquareWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3866.9,3767.69,21.1306]];
	_o set3DENAttribute ['rotation',[356.759,0,173.245]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3845.32,3763.75,21.9345]];
	_o set3DENAttribute ['rotation',[0,0,357.528]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["griblanka","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3851.97,3766.43,21.8388]];
	_o set3DENAttribute ['rotation',[0,0,357.528]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3854.85,3766.75,21.812]];
	_o set3DENAttribute ['rotation',[0,0,352.922]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3842.75,3767.27,21.9636]];
	_o set3DENAttribute ['rotation',[0,0,263.139]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3860.05,3760.98,21.7459]];
	_o set3DENAttribute ['rotation',[0,0,268.953]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3866.74,3765.05,18.2944]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3870.21,3748.49,17.1516]];
	_o set3DENAttribute ['rotation',[0,0,87.1668]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_00", [0,0,0]];
	_o set3DENAttribute ['position',[3871.46,3768.76,18.2204]];
	_o set3DENAttribute ['rotation',[0,0,87.1668]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_00.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3840.91,3775.65,22.7789]];
	_o set3DENAttribute ['rotation',[0,0,272]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "patroni_indabox", [0,0,0]];
	_o set3DENAttribute ['position',[3844.77,3775.6,23.3666]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'AmmoBoxShotgunNonLethal'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3841.02,3773.61,23.9764]];
	_o set3DENAttribute ['rotation',[341.717,275.424,18.3603]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transBar"]] call mm_importOld_regFunc;

	[_o,'_sw_barhome'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3840.97,3774.52,22.4264]];
	_o set3DENAttribute ['rotation',[0,0,91.511]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o,'keyTypes',["barhome","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pechechkas", [0,0,0]];
	_o set3DENAttribute ['position',[3845.18,3770.91,22.0328]];
	_o set3DENAttribute ['rotation',[0,0,3.78554]];

	_hash = [_o,'BlackSmallStove'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pechka", [0,0,0]];
	_o set3DENAttribute ['position',[3842.96,3771.87,21.9377]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallStoveGrill'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_rack_F", [0,0,0]];
	_o set3DENAttribute ['position',[3844.85,3775.29,22.807]];
	_o set3DENAttribute ['rotation',[0,0,76.8359]];

	_hash = [_o,'Shelves'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3840.91,3768.03,21.933]];
	_o set3DENAttribute ['rotation',[0,0,0.186385]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o,'keyTypes',["kitchen","super"]] call mm_importOld_regVar;
	[_o,'isLocked',true] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "samogonapparat", [0,0,0]];
	_o set3DENAttribute ['position',[3841.76,3772.15,22.1674]];
	_o set3DENAttribute ['rotation',[0,0,185.204]];

	_hash = [_o,'HoochMachine'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "wesi", [0,0,0]];
	_o set3DENAttribute ['position',[3840.1,3772,22.9444]];
	_o set3DENAttribute ['rotation',[0,0,2.15022]];

	_hash = [_o,'Scales'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[3865.79,3764.96,24.9108]];
	_o set3DENAttribute ['rotation',[0,0,90.5615]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o,'edIsEnabled',true] call mm_importOld_regVar;
	[_o,'radioSettings',[1,"enc_sta",10,30,nil,1000,0]] call mm_importOld_regVar;

	[_o,'_spkr_6'] call mm_importOld_regMARK;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.12,3760.28,21.2288]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3844.38,3773.53,22.807]];
	_o set3DENAttribute ['rotation',[0,0,267.452]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "propeller", [0,0,0]];
	_o set3DENAttribute ['position',[3860.26,3773.48,35.2118]];
	_o set3DENAttribute ['rotation',[0,0,325.658]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_14_10\propeller.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "cup", [0,0,0]];
	_o set3DENAttribute ['position',[3843.09,3773.2,23.6518]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Cup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "cup", [0,0,0]];
	_o set3DENAttribute ['position',[3840.18,3772.61,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,282.461]];

	_hash = [_o,'Cup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[3840.11,3773.26,22.9634]];
	_o set3DENAttribute ['rotation',[0,0,60.7979]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3859.8,3765.32,21.7279]];
	_o set3DENAttribute ['rotation',[0,0,271.456]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3864.78,3765.32,21.6751]];
	_o set3DENAttribute ['rotation',[0,0,271.456]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.28,3769.02,21.6667]];
	_o set3DENAttribute ['rotation',[0,0,21.9505]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3864.51,3764.16,21.7372]];
	_o set3DENAttribute ['rotation',[0,0,87.7852]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3859.52,3764.1,21.7205]];
	_o set3DENAttribute ['rotation',[0,0,87.7852]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3853.43,3766.51,21.7004]];
	_o set3DENAttribute ['rotation',[0,0,172.355]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_four_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.8,3754.6,20.9744]];
	_o set3DENAttribute ['rotation',[352.175,359.191,359.674]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_four_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.44,3762.74,21.6065]];
	_o set3DENAttribute ['rotation',[0,0,354.326]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ClothShelter_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3855.19,3761.28,21.8184]];
	_o set3DENAttribute ['rotation',[0,0,180.496]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\commercial\market\clothshelter_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcPipeline_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3860.64,3770.48,18.9335]];
	_o set3DENAttribute ['rotation',[1.88425e-005,5.43726e-006,359.228]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcPipeline_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3860.6,3773.31,18.9353]];
	_o set3DENAttribute ['rotation',[1.88425e-005,5.43726e-006,359.228]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcOutlet_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3867.53,3774.16,18.5005]];
	_o set3DENAttribute ['rotation',[0,0,89.6339]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concoutlet_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcOutlet_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3858.28,3767.35,18.6476]];
	_o set3DENAttribute ['rotation',[0,0,181.141]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concoutlet_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_ConcOutlet_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3862.95,3767.22,18.4956]];
	_o set3DENAttribute ['rotation',[0,0,178.248]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_construction\misc_concoutlet_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cages_F", [0,0,0]];
	_o set3DENAttribute ['position',[3854.26,3762.21,21.8691]];
	_o set3DENAttribute ['rotation',[0,0,89.7607]];

	_hash = [_o,'RatCage'] call mm_importOld_initHashData;
	[_o,'setRatsCategory',["random"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cages_F", [0,0,0]];
	_o set3DENAttribute ['position',[3854.42,3759.98,21.8607]];
	_o set3DENAttribute ['rotation',[0,0,267.242]];

	_hash = [_o,'RatCage'] call mm_importOld_initHashData;
	[_o,'setRatsCategory',["random"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cages_F", [0,0,0]];
	_o set3DENAttribute ['position',[3856.59,3762.02,21.7442]];
	_o set3DENAttribute ['rotation',[0,0,177.486]];

	_hash = [_o,'RatCage'] call mm_importOld_initHashData;
	[_o,'setRatsCategory',["food"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cages_F", [0,0,0]];
	_o set3DENAttribute ['position',[3858.37,3762.12,21.6999]];
	_o set3DENAttribute ['rotation',[0,0,88.7138]];

	_hash = [_o,'RatCage'] call mm_importOld_initHashData;
	[_o,'setRatsCategory',["milk"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3871.96,3775.68,20.2412]];
	_o set3DENAttribute ['rotation',[0,0,356.34]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3853.17,3767.91,21.861]];
	_o set3DENAttribute ['rotation',[0,0,81.4727]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3847.05,3766.02,21.2987]];
	_o set3DENAttribute ['rotation',[0,0,355.354]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3848.23,3767.52,21.8636]];
	_o set3DENAttribute ['rotation',[0,0,81.4727]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3855.75,3768.15,21.2114]];
	_o set3DENAttribute ['rotation',[0,0,95.8075]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3849.91,3766.26,21.8601]];
	_o set3DENAttribute ['rotation',[0,0,353.814]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3844.31,3766.23,21.2926]];
	_o set3DENAttribute ['rotation',[0,0,11.753]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vag_wash4_p1", [0,0,0]];
	_o set3DENAttribute ['position',[3869.82,3772.9,20.6591]];
	_o set3DENAttribute ['rotation',[0,0,177.531]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\vag_wash4_p1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.91,3747.66,19.9054]];
	_o set3DENAttribute ['rotation',[349.689,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3868.82,3748.8,20.1246]];
	_o set3DENAttribute ['rotation',[349.689,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_v2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.03,3746.08,19.6736]];
	_o set3DENAttribute ['rotation',[0,0,351.771]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_portfeluga", [0,0,0]];
	_o set3DENAttribute ['position',[3843.3,3774.24,23.618]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Briefcase'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SmallTable", [0,0,0]];
	_o set3DENAttribute ['position',[3860.45,3760.02,21.631]];
	_o set3DENAttribute ['rotation',[0,0,272.275]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\misc2\smalltable\smalltable.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "OfficeTable_01_old_F", [0,0,0]];
	_o set3DENAttribute ['position',[3843.31,3773.76,22.807]];
	_o set3DENAttribute ['rotation',[0,0,267.851]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_heli\furniture\officetable_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "key", [0,0,0]];
	_o set3DENAttribute ['position',[3843.53,3773.26,23.6518]];
	_o set3DENAttribute ['rotation',[0,0,87.8934]];

	_hash = [_o,'Key'] call mm_importOld_initHashData;
	[_o,'keyOwner',["kitchen","barpublic"]] call mm_importOld_regVar;
	[_o,'name',"Ключ от бара"] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "izh43", [0,0,0]];
	_o set3DENAttribute ['position',[3844.87,3775.26,23.8286]];
	_o set3DENAttribute ['rotation',[0,0,347.525]];

	_hash = [_o,'DBShotgun'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3860.63,3783.47,38.4801]];
	_o set3DENAttribute ['rotation',[0,0,7.17808]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3851.5,3784.98,21.9469]];
	_o set3DENAttribute ['rotation',[0,0,10.3196]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3841.42,3784.69,31.3913]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.22,3784.35,15.7102]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3871.05,3784.3,21.698]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.85,3794.4,31.8274]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3851.57,3784.72,31.5694]];
	_o set3DENAttribute ['rotation',[0,0,7.17808]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3861.4,3794.76,21.8901]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3871.34,3783.67,38.2627]];
	_o set3DENAttribute ['rotation',[0,0,2.13575]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Lamp_tarelka", [0,0,0]];
	_o set3DENAttribute ['position',[3843.12,3776.26,25.4428]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LampCeiling'] call mm_importOld_initHashData;
	[_o,'connectTo',["_sw_barhome"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3845.18,3776.54,23.764]];
	_o set3DENAttribute ['rotation',[0,0,263.946]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ShellCrater_02_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3861.04,3776.13,16.2349]];
	_o set3DENAttribute ['rotation',[15.135,0,82.2582]];

	_hash = [_o,'MotherBunchOfShit'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.26,3785.63,21.6443]];
	_o set3DENAttribute ['rotation',[0,0,121.012]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.93,3778.25,21.3206]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ManurePile_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3858.23,3781.19,15.5099]];
	_o set3DENAttribute ['rotation',[0,0,15.2158]];

	_hash = [_o,'BunchOfShit'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ManurePile_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3861.05,3783.15,15.6378]];
	_o set3DENAttribute ['rotation',[0,0,331.202]];

	_hash = [_o,'BunchOfShit'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3863.29,3785.99,16.2173]];
	_o set3DENAttribute ['rotation',[0,0,202.423]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o,'connectTo',["_transIndust"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3843.98,3778.63,22.7791]];
	_o set3DENAttribute ['rotation',[0,0,180.063]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_Uup_F", [0,0,0]];
	_o set3DENAttribute ['position',[3870.94,3788.51,21.2051]];
	_o set3DENAttribute ['rotation',[0,0,178.856]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_uup_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3871.5,3784.66,22.607]];
	_o set3DENAttribute ['rotation',[356.871,0.8431,188.314]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed4", [0,0,0]];
	_o set3DENAttribute ['position',[3841.76,3777.23,22.807]];
	_o set3DENAttribute ['rotation',[0,0,181.344]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','relicta_models\models\interier\bed4.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pod_18x6", [0,0,0]];
	_o set3DENAttribute ['position',[3843.91,3781.42,22.302]];
	_o set3DENAttribute ['rotation',[0,0,182]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\pod_18x6.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3869.65,3782.08,22.5896]];
	_o set3DENAttribute ['rotation',[0,0,86.0081]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3869.65,3783.73,22.5715]];
	_o set3DENAttribute ['rotation',[0,0,86.0081]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3869.77,3780.66,22.5746]];
	_o set3DENAttribute ['rotation',[0,0,86.0081]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok2", [0,0,0]];
	_o set3DENAttribute ['position',[3840.48,3777.75,22.0495]];
	_o set3DENAttribute ['rotation',[0,0,87.0687]];

	_hash = [_o,'FabricBagBig2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_almara", [0,0,0]];
	_o set3DENAttribute ['position',[3844.4,3777.74,22.7064]];
	_o set3DENAttribute ['rotation',[0,0,89.8506]];

	_hash = [_o,'LargeClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_bedroom_a", [0,0,0]];
	_o set3DENAttribute ['position',[3842.68,3778.07,22.7848]];
	_o set3DENAttribute ['rotation',[0,0,272.215]];

	_hash = [_o,'CaseBedroomSmall'] call mm_importOld_initHashData;
	[_o,'createItemInContainer',["Key",1,100,[["var","name","Главный гостевой ключ"],["var","keyOwner",["hotelmain"]]]]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3861.16,3778.44,17.0207]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["govnelin"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3869.25,3780.16,22.6749]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3869.33,3782.16,22.6102]];
	_o set3DENAttribute ['rotation',[0,0,87.9997]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Scaffolding", [0,0,0]];
	_o set3DENAttribute ['position',[3864.25,3780.87,15.4192]];
	_o set3DENAttribute ['rotation',[0,0,359.141]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\misc\misc_scaffolding\misc_scaffolding.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_20m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3866.09,3777.45,21.085]];
	_o set3DENAttribute ['rotation',[0,0,265.71]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_20m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "most", [0,0,0]];
	_o set3DENAttribute ['position',[3866.94,3777.53,21.1561]];
	_o set3DENAttribute ['rotation',[0,0,358.34]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_24\most.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3868.02,3779.27,20.1734]];
	_o set3DENAttribute ['rotation',[0,0,88.2338]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcreteWall_01_l_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3867.76,3787.24,20.1654]];
	_o set3DENAttribute ['rotation',[0,0,88.2338]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\concrete\concretewall_01_l_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3846.88,3836.6,32.3487]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3847.33,3846.7,39.876]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3845.47,3867.27,32.1554]];
	_o set3DENAttribute ['rotation',[0,0,240.387]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3848.35,3846.99,23.6796]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3847.5,3856.88,32.4795]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3857,3847.09,32.3922]];
	_o set3DENAttribute ['rotation',[0,0,269.107]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L1_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3841.44,3845.95,24.6027]];
	_o set3DENAttribute ['rotation',[0,0,270.788]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l1_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3850.48,3845.95,23.8979]];
	_o set3DENAttribute ['rotation',[0,0,266.043]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Slum_House01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3850.12,3849.67,23.9512]];
	_o set3DENAttribute ['rotation',[0,0,266.043]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\slum_house01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Metal_Shed_F", [0,0,0]];
	_o set3DENAttribute ['position',[3842.27,3859.2,23.6864]];
	_o set3DENAttribute ['rotation',[0,0,178.263]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\addons\metal_shed_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_cargo_addon01_V2_F", [0,0,0]];
	_o set3DENAttribute ['position',[3843.74,3850.86,24.0115]];
	_o set3DENAttribute ['rotation',[0,0,0.965287]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\households\slum\cargo_addon01_v2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[3848.3,3847.29,26.5164]];
	_o set3DENAttribute ['rotation',[0,0,140.014]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_GRYAZOOOKASS", [0,0,0]];
	_o set3DENAttribute ['position',[3840.34,3856.22,19.8143]];
	_o set3DENAttribute ['rotation',[0,0,32.1379]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\surfaces\gryazoookass.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gryazyuka5", [0,0,0]];
	_o set3DENAttribute ['position',[3847.56,3850.61,23.9604]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\nvprops\gryazyuka5.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ClothShelter_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3844.98,3844.05,23.947]];
	_o set3DENAttribute ['rotation',[0,0,356.174]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3848.26,3845.5,26.5452]];
	_o set3DENAttribute ['rotation',[0,0,248.443]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3851.36,3847.43,26.6178]];
	_o set3DENAttribute ['rotation',[0,0,9.13594]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3850.14,3844.14,26.6028]];
	_o set3DENAttribute ['rotation',[0,0,177.272]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo2", [0,0,0]];
	_o set3DENAttribute ['position',[3841.81,3859,26.8733]];
	_o set3DENAttribute ['rotation',[0,0,210.099]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_4m_F", [0,0,0]];
	_o set3DENAttribute ['position',[3845.96,3849.86,26.2226]];
	_o set3DENAttribute ['rotation',[0.203058,10.2088,275.708]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_4m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3850.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[3847.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chair2", [0,0,0]];
	_o set3DENAttribute ['position',[3871.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairBigCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_F", [0,0,0]];
	_o set3DENAttribute ['position',[3866.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LongWeaponContainer'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenBox_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3859.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SquareWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3845.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "knopka", [0,0,0]];
	_o set3DENAttribute ['position',[3851.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedButton'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "tumbler", [0,0,0]];
	_o set3DENAttribute ['position',[3852.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Tumbler'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sundugan", [0,0,0]];
	_o set3DENAttribute ['position',[3860.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ContainerGreen'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box", [0,0,0]];
	_o set3DENAttribute ['position',[3863.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ContainerGreen3'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_OfficeCabinet_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3855.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'OfficeCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chairbar3", [0,0,0]];
	_o set3DENAttribute ['position',[3849.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BarChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "patefon", [0,0,0]];
	_o set3DENAttribute ['position',[3844.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Gramofon'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed2", [0,0,0]];
	_o set3DENAttribute ['position',[3868.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'HospitalBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed5", [0,0,0]];
	_o set3DENAttribute ['position',[3869.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[3865.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "yashi4ek", [0,0,0]];
	_o set3DENAttribute ['position',[3861.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ContainerGreen2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "boxuzk", [0,0,0]];
	_o set3DENAttribute ['position',[3862.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'OldWoodenBox'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exodus\boxuzk.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "shkafsin", [0,0,0]];
	_o set3DENAttribute ['position',[3867.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGreenCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Chest_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3864.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChestCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[3857.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sdaykey", [0,0,0]];
	_o set3DENAttribute ['position',[3858.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'KeyHolder'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_almara", [0,0,0]];
	_o set3DENAttribute ['position',[3856.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LargeClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_wooden_b", [0,0,0]];
	_o set3DENAttribute ['position',[3853.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_a", [0,0,0]];
	_o set3DENAttribute ['position',[3854.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigClothCabinetNew'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryslo", [0,0,0]];
	_o set3DENAttribute ['position',[3842.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RedLuxuryChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_stulcasual", [0,0,0]];
	_o set3DENAttribute ['position',[3870.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairCasual'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_lobby_chair", [0,0,0]];
	_o set3DENAttribute ['position',[3848.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'LobbyChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "infotablicka", [0,0,0]];
	_o set3DENAttribute ['position',[3846.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'InfoBoard'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dkamna_bila", [0,0,0]];
	_o set3DENAttribute ['position',[3843.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PipeStove'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "samogonapparat", [0,0,0]];
	_o set3DENAttribute ['position',[3841.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'HoochMachine'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "samovar", [0,0,0]];
	_o set3DENAttribute ['position',[3840.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Samovar'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3882.08,3608.19,8.8727]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3881.14,3600.26,18.3339]];
	_o set3DENAttribute ['rotation',[0,0,3.94044]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_A_Castle_Wall1_20", [0,0,0]];
	_o set3DENAttribute ['position',[3887.16,3612.36,8.98908]];
	_o set3DENAttribute ['rotation',[0,0,273.214]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures\castle\a_castle_wall1_20.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pepelishe", [0,0,0]];
	_o set3DENAttribute ['position',[3881.03,3609.1,8.73977]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CampfireBig'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3885.33,3611.93,8.89233]];
	_o set3DENAttribute ['rotation',[0,0,273.422]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3885.59,3614.96,11.5545]];
	_o set3DENAttribute ['rotation',[0,0,273.422]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3885.66,3614.98,8.88872]];
	_o set3DENAttribute ['rotation',[0,0,273.422]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "betonblocksbs", [0,0,0]];
	_o set3DENAttribute ['position',[3885.36,3611.92,11.553]];
	_o set3DENAttribute ['rotation',[0,0,273.422]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\betonblocksbs.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "germodweri", [0,0,0]];
	_o set3DENAttribute ['position',[3884.86,3613.5,8.89673]];
	_o set3DENAttribute ['rotation',[0,0,274.279]];

	_hash = [_o,'GateCity'] call mm_importOld_initHashData;
	[_o,'connectTo',["_gateact_external"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3872.3,3620.11,8.91464]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3883.41,3627.12,17.4289]];
	_o set3DENAttribute ['rotation',[0,0,9.24544]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_strongstone", [0,0,0]];
	_o set3DENAttribute ['position',[3873.47,3628.42,17.9623]];
	_o set3DENAttribute ['rotation',[0,0,10.1537]];

	_hash = [_o,'BlockStone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3883.17,3618.97,8.93479]];
	_o set3DENAttribute ['rotation',[0,0,4.7187]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_large_F", [0,0,0]];
	_o set3DENAttribute ['position',[3875.97,3621.41,8.82814]];
	_o set3DENAttribute ['rotation',[0,0,189.996]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_large_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6", [0,0,0]];
	_o set3DENAttribute ['position',[3876.62,3619.69,8.97804]];
	_o set3DENAttribute ['rotation',[0,0,96.0453]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3876.05,3621.79,9.69272]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Barn_04_ruins_F", [0,0,0]];
	_o set3DENAttribute ['position',[3876.89,3622.16,18.5891]];
	_o set3DENAttribute ['rotation',[180.001,1.00179e-005,175.901]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3873.32,3622.26,9.02656]];
	_o set3DENAttribute ['rotation',[0,0,92.9154]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Net_Fence_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3884.2,3617.17,9.09661]];
	_o set3DENAttribute ['rotation',[0,0,128.926]];

	_hash = [_o,'LampKeroseneHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv_okn_1", [0,0,0]];
	_o set3DENAttribute ['position',[3873.41,3616.87,8.93444]];
	_o set3DENAttribute ['rotation',[0,0,0.234957]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_do1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Cliff_peak_F", [0,0,0]];
	_o set3DENAttribute ['position',[3878.83,3704.73,16.2277]];
	_o set3DENAttribute ['rotation',[0,0,160.239]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\rocks_f_exp\cliff\cliff_peak_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3880.41,3731.96,34.4697]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3880.82,3742.45,35.1813]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3890.63,3732.13,35.0742]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3890.11,3742.67,35.0466]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3891.05,3742.4,19.6248]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3880.13,3731.59,19.734]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3900.6,3743.36,28.6574]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3880.18,3742.44,19.743]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3891.2,3731.59,19.8176]];
	_o set3DENAttribute ['rotation',[0,0,179.252]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3891.26,3722.06,28.8111]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3901.02,3732.69,28.7296]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.88,3723.26,18.8879]];
	_o set3DENAttribute ['rotation',[346.056,6.2075,177.599]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3879.96,3732.01,19.9197]];
	_o set3DENAttribute ['rotation',[0,0,298.016]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CraterLong_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3883.46,3731.28,19.1678]];
	_o set3DENAttribute ['rotation',[4.23805,6.2075,177.599]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\military\training\craterlong_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3891.23,3730.21,20.8708]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3894.17,3730.08,21.3273]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3893.75,3729.99,21.3273]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_kr_stena_3x6_dv", [0,0,0]];
	_o set3DENAttribute ['position',[3889.87,3732.43,19.8972]];
	_o set3DENAttribute ['rotation',[0,0,0.0131486]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\kr_stena_1d.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3886.97,3730.16,20.732]];
	_o set3DENAttribute ['rotation',[0.324847,359.607,90.4691]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3889.51,3727.46,20.6939]];
	_o set3DENAttribute ['rotation',[359.61,359.671,179.743]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Wall_L2_5m_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[3891.8,3730.15,20.6067]];
	_o set3DENAttribute ['rotation',[0.341406,359.621,88.0453]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\wall\wall_l\wall_l2_5m_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3880.69,3739.35,19.7616]];
	_o set3DENAttribute ['rotation',[0,0,271.46]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3876.27,3739.35,19.6078]];
	_o set3DENAttribute ['rotation',[0,0,271.46]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3875.25,3740.45,19.6723]];
	_o set3DENAttribute ['rotation',[0,0,1.12972]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3875.24,3743.86,19.5881]];
	_o set3DENAttribute ['rotation',[0,0,1.12972]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3878.49,3739.36,19.7389]];
	_o set3DENAttribute ['rotation',[0,0,267.761]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3877.7,3736.7,19.5749]];
	_o set3DENAttribute ['rotation',[10.9438,0,255.54]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "fence01", [0,0,0]];
	_o set3DENAttribute ['position',[3875.51,3736.31,19.6084]];
	_o set3DENAttribute ['rotation',[10.0647,0,267.495]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\fence01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3889.33,3739.45,19.686]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3877.06,3736.75,19.8156]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_clouds_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_GRYAZOOOKASS", [0,0,0]];
	_o set3DENAttribute ['position',[3879.84,3714.94,14.7861]];
	_o set3DENAttribute ['rotation',[6.03916,0,263.61]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','apalon\metro_a3\surfaces\gryazoookass.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CncShelter_F", [0,0,0]];
	_o set3DENAttribute ['position',[3890.26,3729.54,18.429]];
	_o set3DENAttribute ['rotation',[0,0,357.78]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\walls\cncshelter_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_16_F", [0,0,0]];
	_o set3DENAttribute ['position',[3892.52,3741.48,19.3613]];
	_o set3DENAttribute ['rotation',[0,0,89.4311]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_16_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_16_F", [0,0,0]];
	_o set3DENAttribute ['position',[3892.7,3739.5,19.6386]];
	_o set3DENAttribute ['rotation',[0,0,89.4311]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_16_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.2,3739.77,19.7832]];
	_o set3DENAttribute ['rotation',[0,0,359.541]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_08_F", [0,0,0]];
	_o set3DENAttribute ['position',[3892.5,3743.14,19.7566]];
	_o set3DENAttribute ['rotation',[0,0,87.815]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_08_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_04_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.12,3740.74,19.7699]];
	_o set3DENAttribute ['rotation',[0,0,178.557]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_04_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.62,3739.51,19.9387]];
	_o set3DENAttribute ['rotation',[0,0,87.934]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.69,3741.42,20.0761]];
	_o set3DENAttribute ['rotation',[0,0,88.7424]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.7,3743.82,20.1368]];
	_o set3DENAttribute ['rotation',[0,0,88.5635]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3873.05,3733.51,19.7724]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3872.99,3729.52,19.7946]];
	_o set3DENAttribute ['rotation',[0,0,176.857]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3878.22,3740.65,19.8622]];
	_o set3DENAttribute ['rotation',[0,0,355.795]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3876.24,3740.48,19.879]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.08,3740.7,19.851]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3872.96,3728.9,19.8968]];
	_o set3DENAttribute ['rotation',[0,0,192.504]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3873.12,3734.35,19.7746]];
	_o set3DENAttribute ['rotation',[0,0,4.04155]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3876.44,3739.73,19.9493]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3878.22,3739.97,19.8983]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Chapel_02_white_damaged_F", [0,0,0]];
	_o set3DENAttribute ['position',[3893.81,3732.37,20.4191]];
	_o set3DENAttribute ['rotation',[0,0,180.248]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_damaged_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "l04_catacombs_01", [0,0,0]];
	_o set3DENAttribute ['position',[3880.56,3713.22,18.0192]];
	_o set3DENAttribute ['rotation',[0,0,90.9611]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object\l04_catacombs\l04_catacombs_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_dmg_F", [0,0,0]];
	_o set3DENAttribute ['position',[3890.24,3730.12,19.8096]];
	_o set3DENAttribute ['rotation',[0,0,177.402]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_single_dmg_F", [0,0,0]];
	_o set3DENAttribute ['position',[3888.12,3730.18,19.8391]];
	_o set3DENAttribute ['rotation',[0,0,177.402]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3875.98,3738.26,19.7614]];
	_o set3DENAttribute ['rotation',[0,0,90.1877]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3889.72,3738.43,19.6507]];
	_o set3DENAttribute ['rotation',[0,0,333.166]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3889.17,3741.68,19.6146]];
	_o set3DENAttribute ['rotation',[0,0,176.329]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3872.26,3738.94,19.6818]];
	_o set3DENAttribute ['rotation',[0,0,287.691]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3879.67,3738.23,19.7912]];
	_o set3DENAttribute ['rotation',[0,0,88.4103]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.48,3736.17,19.8269]];
	_o set3DENAttribute ['rotation',[6.95829,0,136.534]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3883.28,3738.57,19.7576]];
	_o set3DENAttribute ['rotation',[0,0,77.9303]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3886.87,3739.01,19.7307]];
	_o set3DENAttribute ['rotation',[0,0,267.869]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3880,3763.32,28.0014]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3890.21,3752.7,28.1511]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3879.87,3752.45,28.1669]];
	_o set3DENAttribute ['rotation',[0,0,358.683]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3879.81,3773.45,31.533]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "svecha", [0,0,0]];
	_o set3DENAttribute ['position',[3891.04,3746.01,20.1492]];
	_o set3DENAttribute ['rotation',[0,0,268.724]];

	_hash = [_o,'Candle'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[3872.86,3748.51,19.8987]];
	_o set3DENAttribute ['rotation',[0.0836647,3.23984,264.72]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3873.49,3744.48,19.7901]];
	_o set3DENAttribute ['rotation',[0,0,167.767]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_TinWall_01_m_4m_v1_F", [0,0,0]];
	_o set3DENAttribute ['position',[3875.47,3746.88,19.9245]];
	_o set3DENAttribute ['rotation',[0,0,91.1749]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3872.49,3769.04,21.6856]];
	_o set3DENAttribute ['rotation',[0,0,182.353]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_07_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.76,3746.03,19.6758]];
	_o set3DENAttribute ['rotation',[0,0,88.2006]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\cultural\cemeteries\grave_07_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_16_F", [0,0,0]];
	_o set3DENAttribute ['position',[3892.54,3744.42,19.5963]];
	_o set3DENAttribute ['rotation',[0,0,89.4311]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_16_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Tombstone_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.2,3745.65,19.7773]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\tombstone_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_03_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.3,3744.45,19.6997]];
	_o set3DENAttribute ['rotation',[0,0,355.97]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GraveFence_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3891.59,3746.05,19.973]];
	_o set3DENAttribute ['rotation',[0,0,87.0207]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3876.44,3744.76,19.9866]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3878.57,3744.59,19.9096]];
	_o set3DENAttribute ['rotation',[0,0,4.69594]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3880.3,3744.69,19.8403]];
	_o set3DENAttribute ['rotation',[0,0,172.994]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3881.97,3744.57,19.8369]];
	_o set3DENAttribute ['rotation',[0,0,14.0099]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Grave_11_F", [0,0,0]];
	_o set3DENAttribute ['position',[3883.86,3744.54,19.834]];
	_o set3DENAttribute ['rotation',[0,0,2.62398]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\cultural\cemeteries\grave_11_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3878.64,3745.28,19.9815]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "GraveCross2", [0,0,0]];
	_o set3DENAttribute ['position',[3882.21,3745.2,19.9392]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ca\buildings\misc\hrobecek_krizek2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3889.2,3745.3,19.608]];
	_o set3DENAttribute ['rotation',[0,0,180.7]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3872.01,3792.85,31.7847]];
	_o set3DENAttribute ['rotation',[0,0,23.3838]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[3879.94,3783.86,31.67]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_IndPipe1_Uup_F", [0,0,0]];
	_o set3DENAttribute ['position',[3875.7,3780.07,20.4646]];
	_o set3DENAttribute ['rotation',[0,0,272.417]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f\ind\pipes\indpipe1_uup_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3872.89,3782.47,22.5741]];
	_o set3DENAttribute ['rotation',[0,0,264.091]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3872.75,3783.96,22.5421]];
	_o set3DENAttribute ['rotation',[0,0,264.091]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sartir_kabinka", [0,0,0]];
	_o set3DENAttribute ['position',[3873.04,3781.07,22.5561]];
	_o set3DENAttribute ['rotation',[0,0,264.091]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','metro_ob\model\sartir_kabinka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3872.75,3782.32,22.5906]];
	_o set3DENAttribute ['rotation',[0,0,87.9997]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3889.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3884.49,3964.72,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[3894.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "diwan", [0,0,0]];
	_o set3DENAttribute ['position',[3877.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3885.61,3963.96,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ChairWood_F", [0,0,0]];
	_o set3DENAttribute ['position',[3879.49,3966.3,0.00284195]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "distilation", [0,0,0]];
	_o set3DENAttribute ['position',[3893.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChemDistiller'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Bench_F", [0,0,0]];
	_o set3DENAttribute ['position',[3873.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenBench'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ArmChair_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3875.48,3966.3,-7.05719e-005]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ArmChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_doorvlk", [0,0,0]];
	_o set3DENAttribute ['position',[3887.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenDoubleDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "electron", [0,0,0]];
	_o set3DENAttribute ['position',[3892.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerSwitcherBig'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "rubilnik_4", [0,0,0]];
	_o set3DENAttribute ['position',[3891.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerSwitcher'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "pomoika", [0,0,0]];
	_o set3DENAttribute ['position',[3890.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallTrashCan'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_RattanChair_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[3882.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'RattanChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3884.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_doub_bronedwerks", [0,0,0]];
	_o set3DENAttribute ['position',[3888.69,3964.93,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelArmoredDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_d", [0,0,0]];
	_o set3DENAttribute ['position',[3874.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "throne", [0,0,0]];
	_o set3DENAttribute ['position',[3881.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'HeadThrone'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_armchair", [0,0,0]];
	_o set3DENAttribute ['position',[3872.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ArmChairBrown'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_biblastul", [0,0,0]];
	_o set3DENAttribute ['position',[3883.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairLibrary'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjKreslo", [0,0,0]];
	_o set3DENAttribute ['position',[3876.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BrownLeatherChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stulpin", [0,0,0]];
	_o set3DENAttribute ['position',[3880.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StripedChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[3895.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_stolb_3m", [0,0,0]];
	_o set3DENAttribute ['position',[3896.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','csa_constr\csa_obj\stolb_3m.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_e", [0,0,0]];
	_o set3DENAttribute ['position',[3878.49,3966.3,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallRedseatChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3930.17,3885.81,0]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3934.66,3879.01,5.33221]];
	_o set3DENAttribute ['rotation',[0,0,90.0001]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3934.66,3880.63,5.33221]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3935.34,3890.3,15.9887]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3930.16,3885.8,21.3196]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3928.55,3885.8,21.3196]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3935.34,3891.91,15.9887]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3934.66,3880.62,26.6518]];
	_o set3DENAttribute ['rotation',[0,0,90.0001]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3934.66,3879,26.6518]];
	_o set3DENAttribute ['rotation',[0,0,90.0001]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3928.56,3885.81,0]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3929.33,3878.6,26.982]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3929.34,3881.01,5.65776]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3928.14,3891.1,42.953]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3929.33,3881,26.9774]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3930.54,3891.11,42.9661]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3928.14,3891.11,21.6334]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3929.33,3878.61,5.66232]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3930.54,3891.13,21.6465]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3935.34,3890.28,37.3083]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3935.34,3891.9,37.3083]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_04_F", [0,0,0]];
	_o set3DENAttribute ['position',[3946.33,3757.91,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_VR_Block_02_F", [0,0,0]];
	_o set3DENAttribute ['position',[3943.88,3774.2,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'EffectAsStruct'] call mm_importOld_initHashData;
	[_o,'setEffectType',["dust_pieces_10m"]] call mm_importOld_regFunc;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_xlamdoor", [0,0,0]];
	_o set3DENAttribute ['position',[3952,3795.59,-0.0527401]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_traindoor2", [0,0,0]];
	_o set3DENAttribute ['position',[3960.17,3803.57,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelWindowDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_reshetow", [0,0,0]];
	_o set3DENAttribute ['position',[3943.61,3796.07,-0.0523186]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\kapeze\reshetow.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "reshetka", [0,0,0]];
	_o set3DENAttribute ['position',[3964.74,3813.93,0]];
	_o set3DENAttribute ['rotation',[0,0,0.000122943]];

	_hash = [_o,'SteelGridDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dwerrj", [0,0,0]];
	_o set3DENAttribute ['position',[3963.35,3818.29,0.00844955]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelBrownDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_door_solar", [0,0,0]];
	_o set3DENAttribute ['position',[3964.85,3816.76,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelDoorThinSmall'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "dooor", [0,0,0]];
	_o set3DENAttribute ['position',[3964.99,3820.03,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SteelGreenDoor'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3961.71,3893.46,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3939.83,3885.1,31.9761]];
	_o set3DENAttribute ['rotation',[0,0,4.26887e-005]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3939.84,3885.11,10.6565]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3941.44,3885.1,31.9761]];
	_o set3DENAttribute ['rotation',[0,0,7.59859e-005]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "stair", [0,0,0]];
	_o set3DENAttribute ['position',[3941.45,3885.11,10.6565]];
	_o set3DENAttribute ['rotation',[0,0,4.26887e-005]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\stair.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3941.86,3879.81,10.9769]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3939.46,3879.78,32.3096]];
	_o set3DENAttribute ['rotation',[0,0,90.0001]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3939.46,3879.79,10.99]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3940.67,3892.31,16.3188]];
	_o set3DENAttribute ['rotation',[0,0,1.8783e-005]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3940.66,3889.9,37.6339]];
	_o set3DENAttribute ['rotation',[0,0,4.26887e-005]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3941.86,3879.8,32.2965]];
	_o set3DENAttribute ['rotation',[0,0,90.0001]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3940.67,3892.3,37.6385]];
	_o set3DENAttribute ['rotation',[0,0,4.26887e-005]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3940.67,3889.91,16.3143]];
	_o set3DENAttribute ['rotation',[0,0,1.8783e-005]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed5", [0,0,0]];
	_o set3DENAttribute ['position',[3975.71,3676.46,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_matrassych", [0,0,0]];
	_o set3DENAttribute ['position',[3981.82,3683.1,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\eft\matrassych.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "bed_original1", [0,0,0]];
	_o set3DENAttribute ['position',[3977,3683.84,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\decor\bed_original1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjDivan", [0,0,0]];
	_o set3DENAttribute ['position',[3985.95,3735.42,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SofaBrown'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_biblastul", [0,0,0]];
	_o set3DENAttribute ['position',[3984.86,3736.38,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChairLibrary'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "SMG_BomjKreslo", [0,0,0]];
	_o set3DENAttribute ['position',[3982.58,3738.04,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BrownLeatherChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_ch_mod_e", [0,0,0]];
	_o set3DENAttribute ['position',[3986.11,3736.35,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'SmallRedseatChair'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Bench_05_F", [0,0,0]];
	_o set3DENAttribute ['position',[3992.64,3728.18,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\bench_05_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_WoodenTable_small_F", [0,0,0]];
	_o set3DENAttribute ['position',[3981.31,3756.17,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_epa\civ\camping\woodentable_small_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "zabori", [0,0,0]];
	_o set3DENAttribute ['position',[3987.74,3802.76,0.504925]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_05\zabori.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "metalplate", [0,0,0]];
	_o set3DENAttribute ['position',[3975.49,3866.81,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\metalplate.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_ConcretePanels_02_four_F", [0,0,0]];
	_o set3DENAttribute ['position',[3993.88,3850.52,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "poldrevko", [0,0,0]];
	_o set3DENAttribute ['position',[3998.95,3859.04,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\sbs\poldrevko.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "grating_01", [0,0,0]];
	_o set3DENAttribute ['position',[3998.6,3867.79,0.698952]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_zhelezoplatforma2", [0,0,0]];
	_o set3DENAttribute ['position',[3984.76,3876.65,0.035183]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\zhelezoplatforma2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "sundugan", [0,0,0]];
	_o set3DENAttribute ['position',[4013.18,3715.06,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ContainerGreen'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok2", [0,0,0]];
	_o set3DENAttribute ['position',[4003.09,3712.27,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'FabricBagBig2'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "box_wood_close", [0,0,0]];
	_o set3DENAttribute ['position',[4012.67,3716.71,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BoardWoodenBox'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kartoteka", [0,0,0]];
	_o set3DENAttribute ['position',[4003.81,3743.66,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigFileCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_case_wooden_b", [0,0,0]];
	_o set3DENAttribute ['position',[4004.87,3731.25,1.24387]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'ClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "meshok1", [0,0,0]];
	_o set3DENAttribute ['position',[4003.17,3713.24,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'FabricBagBig1'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "CUP_Dhangar_borwnskrin", [0,0,0]];
	_o set3DENAttribute ['position',[4005.77,3731.26,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BigClothCabinet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "medzanaves2", [0,0,0]];
	_o set3DENAttribute ['position',[4028.14,3774.33,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml_shabut\exoduss\medzanaves2.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_NetFence_03_m_pole_F", [0,0,0]];
	_o set3DENAttribute ['position',[4008.64,3782.21,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'TorchHolderCharged'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_BackAlley_02_l_1m_F", [0,0,0]];
	_o set3DENAttribute ['position',[4010.23,3792.37,0]];
	_o set3DENAttribute ['rotation',[0,0,90]];

	_hash = [_o,'GreenBed'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\walls\backalleys\backalley_02_l_1m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[4027.9,3823.6,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_ganzazhelezo3", [0,0,0]];
	_o set3DENAttribute ['position',[4023.55,3822.69,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\ganzazhelezo3.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[4003.04,3862.38,0]];
	_o set3DENAttribute ['rotation',[0,0,270]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "gate_bridge", [0,0,0]];
	_o set3DENAttribute ['position',[4004.83,3877.97,1.0562]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4011.98,3904.8,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4008.23,3904.93,0]];
	_o set3DENAttribute ['rotation',[0,0,180]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4003.73,3906.43,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4008.1,3909.55,0]];
	_o set3DENAttribute ['rotation',[0,0,1.36604e-005]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_GardenPavement_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4011.85,3909.43,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[4056.54,3755.37,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vinecup", [0,0,0]];
	_o set3DENAttribute ['position',[4056.5,3757.04,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'GlassGoblet'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "woodcup", [0,0,0]];
	_o set3DENAttribute ['position',[4056.33,3755.74,0.0683632]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'WoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "cup", [0,0,0]];
	_o set3DENAttribute ['position',[4056.28,3755.44,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Cup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "cup", [0,0,0]];
	_o set3DENAttribute ['position',[4056.3,3756.95,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Cup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chashka_rja", [0,0,0]];
	_o set3DENAttribute ['position',[4056.36,3755.34,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MetalCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "chashka_rja", [0,0,0]];
	_o set3DENAttribute ['position',[4052.55,3754.37,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'MetalCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_chashunka", [0,0,0]];
	_o set3DENAttribute ['position',[4052.17,3753.82,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Mug'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\chashunka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "land_chashunka", [0,0,0]];
	_o set3DENAttribute ['position',[4056.28,3755.61,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Mug'] call mm_importOld_initHashData;
	[_o,'model','ml_exodusnew\chashunka.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[4058.19,3755.08,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "kryjka", [0,0,0]];
	_o set3DENAttribute ['position',[4056.49,3755.58,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'OlderWoodenCup'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "block_dirt", [0,0,0]];
	_o set3DENAttribute ['position',[4050.63,3946.23,11]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'BlockDirt'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speaker", [0,0,0]];
	_o set3DENAttribute ['position',[4113.46,3622.55,5]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StationSpeaker'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Misc_Cable_EP1", [0,0,0]];
	_o set3DENAttribute ['position',[4126.47,3624.24,-4.76837e-007]];
	_o set3DENAttribute ['rotation',[0,0,97.7854]];

	_hash = [_o,'IStruct'] call mm_importOld_initHashData;
	[_o,'model','ca\structures_e\misc\misc_cables\misc_cable_ep1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_LampShabby_off_F", [0,0,0]];
	_o set3DENAttribute ['position',[4115.75,3670.71,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'StreetLamp'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "transformator_2", [0,0,0]];
	_o set3DENAttribute ['position',[4116.74,3707.95,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ElectricalShield'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "distilation", [0,0,0]];
	_o set3DENAttribute ['position',[4099.28,3701.36,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'ChemDistiller'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "electron", [0,0,0]];
	_o set3DENAttribute ['position',[4105.05,3697.39,0.743088]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'PowerSwitcherBig'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[4107.89,3698.13,3.66784]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "speeker", [0,0,0]];
	_o set3DENAttribute ['position',[4104.74,3695.29,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Intercom'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_pepelishe", [0,0,0]];
	_o set3DENAttribute ['position',[4106.2,3734.07,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'CampfireBig'] call mm_importOld_initHashData;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "vent_door1", [0,0,0]];
	_o set3DENAttribute ['position',[4130.69,3645.98,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\ml_object_2\l01_props\vent_door1.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "propeller", [0,0,0]];
	_o set3DENAttribute ['position',[4142.23,3656.08,0]];
	_o set3DENAttribute ['rotation',[359.999,83.0232,359.999]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','ml\ml_object_new\model_14_10\propeller.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_25_F", [0,0,0]];
	_o set3DENAttribute ['position',[4141.01,3804.11,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_25_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_L25_10_F", [0,0,0]];
	_o set3DENAttribute ['position',[4146.82,3804.75,1.90735e-006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_l25_10_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_R25_10_F", [0,0,0]];
	_o set3DENAttribute ['position',[4154.52,3804.98,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_r25_10_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Up_25_F", [0,0,0]];
	_o set3DENAttribute ['position',[4141.31,3831.16,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_up_25_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_2_F", [0,0,0]];
	_o set3DENAttribute ['position',[4147.07,3819.4,1.90735e-006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_2_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_L30_20_F", [0,0,0]];
	_o set3DENAttribute ['position',[4155.19,3829.42,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_l30_20_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_CraneRail_01_F", [0,0,0]];
	_o set3DENAttribute ['position',[4136.7,3812.52,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\industrial\port\cranerail_01_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Plank_01_8m_F", [0,0,0]];
	_o set3DENAttribute ['position',[4140.44,4479.38,0.875]];
	_o set3DENAttribute ['rotation',[16.1022,25.6589,303.69]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_25NOLC_F", [0,0,0]];
	_o set3DENAttribute ['position',[4190.12,3804.96,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25nolc_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Down_25_F", [0,0,0]];
	_o set3DENAttribute ['position',[4161.52,3805.34,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_down_25_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_25_F", [0,0,0]];
	_o set3DENAttribute ['position',[4168.71,3805.56,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_L25_10_F", [0,0,0]];
	_o set3DENAttribute ['position',[4175.44,3806.07,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_l25_10_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_R25_10_F", [0,0,0]];
	_o set3DENAttribute ['position',[4183.5,3805.34,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_r25_10_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_R30_20_F", [0,0,0]];
	_o set3DENAttribute ['position',[4162.15,3829,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_r30_20_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Down_40_F", [0,0,0]];
	_o set3DENAttribute ['position',[4169.44,3839.92,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_down_40_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Up_40_F", [0,0,0]];
	_o set3DENAttribute ['position',[4191.25,3839.88,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_up_40_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_40_F", [0,0,0]];
	_o set3DENAttribute ['position',[4176.03,3840.53,-1.90735e-006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_40_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_40NOLC_F", [0,0,0]];
	_o set3DENAttribute ['position',[4184.21,3840.71,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_40nolc_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_25NOLC_F", [0,0,0]];
	_o set3DENAttribute ['position',[4197.13,3804.88,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_25nolc_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_4_F", [0,0,0]];
	_o set3DENAttribute ['position',[4197.27,3822.41,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_4_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_8_F", [0,0,0]];
	_o set3DENAttribute ['position',[4197.38,3830.18,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_8_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_LB_RE_F", [0,0,0]];
	_o set3DENAttribute ['position',[4210.13,3831.67,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_lb_re_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_LB1_RE_F", [0,0,0]];
	_o set3DENAttribute ['position',[4216.59,3832.95,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_lb1_re_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_LE_RB_F", [0,0,0]];
	_o set3DENAttribute ['position',[4210.23,3814.25,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_le_rb_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_LE1_RB_F", [0,0,0]];
	_o set3DENAttribute ['position',[4217.67,3816.28,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_le1_rb_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_TrackE_8NOLC_F", [0,0,0]];
	_o set3DENAttribute ['position',[4197.96,3840.33,1.90735e-006]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_tracke_8nolc_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_SP_F", [0,0,0]];
	_o set3DENAttribute ['position',[4208.93,3846.09,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_sp_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Passing_10_F", [0,0,0]];
	_o set3DENAttribute ['position',[4215.2,3849.75,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_passing_10_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_Passing_25_F", [0,0,0]];
	_o set3DENAttribute ['position',[4223.12,3848.1,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_passing_25_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_TurnOutR_F", [0,0,0]];
	_o set3DENAttribute ['position',[4237.16,3839.86,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_turnoutr_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

_o = create3DENEntity ["Object", "Land_Rail_Track_TurnOutL_F", [0,0,0]];
	_o set3DENAttribute ['position',[4230.85,3841.25,0]];
	_o set3DENAttribute ['rotation',[0,0,0]];

	_hash = [_o,'Decor'] call mm_importOld_initHashData;
	[_o,'model','a3\structures_f_enoch\infrastructure\railways\rail_track_turnoutl_f.p3d'] call mm_importOld_regVar;
	[_o] call mm_importOld_postCreated;

