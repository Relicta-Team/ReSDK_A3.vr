// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define resetRuleCritAttack rp_log("<CRIT ATTACK> - Rule applied enum: %1",_rules_critAttack); _rules_critAttack = 0
#define isRuleCritAttack(var) (_rules_critAttack == var)
#define isRuleCritAttackInRange(vars) (_rules_critAttack in [vars])


//#define ca_emulate_rule
#define ca_emulated_rule_roll 12

#define cf_emulate_rule
#define cf_emulate_rule_roll 16

// Пустой прикол. без эффекта
#define RULE_CA_HEAD_NO 0

//Внимание: при добавлении рулов влияющих на урон выключи их если урон был нулевой (учитывай это)
//Нумераторы для критических атак в голову
#define RULE_CA_HEAD_MAXDMG_INGNORSP 1
#define RULE_CA_HEAD_SP2_MAJW 2
#define RULE_CA_HEAD_RELOCTOEYE 0 /*не используется. просчёт внутри*/
#define RULE_CA_HEAD_DEAF 4
#define RULE_CA_HEAD_DROPWEAP 5
#define RULE_CA_HEAD_MAXDMG 6
#define RULE_CA_HEAD_DDAM 7
#define RULE_CA_HEAD_SP2 8
#define RULE_CA_HEAD_TDAM 9


#define RULE_CA_MAJW 10
#define RULE_CA_DSHOCK 11
#define RULE_CA_DROPALL 12












