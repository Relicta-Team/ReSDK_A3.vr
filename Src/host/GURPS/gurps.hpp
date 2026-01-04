// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define D6 (selectRandom[1,2,3,4,5,6])
#define _3D6 (D6 + D6 + D6)

#define throw3d6(vs) ((vs) call gurps_rollstd)
#define throw3d6nocrit(vs) ((vs) call gurps_rollnocrit)

#define getRollTypeText(dice_rez) (["Success","Fail","CritFail","CritSuccess"] select ([DICE_SUCCESS,DICE_FAIL,DICE_CRITFAIL,DICE_CRITSUCCESS] find dice_rez))
//Величина успеха, тип возврата, сколько выпало на кубиках
//прототип _amount,_diceRez,_3d6Amount
#define unpackRollResult(rez,amount,diceRez,d36Amount) (rez) params ['amount','diceRez','d36Amount']

#define customRollResult(amnt,type,dices) [amnt,type,dices]

//величина успеха
#define getRollAmount(throwExec) ((throwExec) select 0)
//тип возврата (DICE_SUCCESS, DICE_FAIL ...)
#define getRollType(throwExec) ((throwExec) select 1)
//результат 3d6
#define getRollDiceAmount(throwExec) ((throwExec) select 2)

#define DICE_SUCCESS 1
#define DICE_FAIL -1
#define DICE_CRITSUCCESS 2
#define DICE_CRITFAIL -2

#define DICE_RESULT_LIST_NODE_BINDING [ \
	'Успех:DICE_SUCCESS' \
	,'Провал:DICE_FAIL' \
	,'Крилический успех:DICE_CRITSUCCESS' \
	,'Критический провал:DICE_CRITFAIL' \
]

#define DICE_ISSUCCESS(v) ((v) > 0)
#define DICE_ISFAIL(v) ((v) < 0)

#define SKILL_BASE 0
#define SKILL_MOD 1
