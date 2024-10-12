# CombatRules.hpp

## resetRuleCritAttack

Type: constant

Description: 


Replaced value:
```sqf
rp_log("<CRIT ATTACK> - Rule applied enum: %1",_rules_critAttack); _rules_critAttack = 0
```
File: [host\CombatSystem\CombatRules.hpp at line 7](../../../Src/host/CombatSystem/CombatRules.hpp#L7)
## isRuleCritAttack(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(_rules_critAttack == var)
```
File: [host\CombatSystem\CombatRules.hpp at line 8](../../../Src/host/CombatSystem/CombatRules.hpp#L8)
## isRuleCritAttackInRange(vars)

Type: constant

Description: 
- Param: vars

Replaced value:
```sqf
(_rules_critAttack in [vars])
```
File: [host\CombatSystem\CombatRules.hpp at line 9](../../../Src/host/CombatSystem/CombatRules.hpp#L9)
## ca_emulated_rule_roll

Type: constant

Description: #define ca_emulate_rule


Replaced value:
```sqf
12
```
File: [host\CombatSystem\CombatRules.hpp at line 13](../../../Src/host/CombatSystem/CombatRules.hpp#L13)
## cf_emulate_rule

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CombatSystem\CombatRules.hpp at line 15](../../../Src/host/CombatSystem/CombatRules.hpp#L15)
## cf_emulate_rule_roll

Type: constant

Description: 


Replaced value:
```sqf
16
```
File: [host\CombatSystem\CombatRules.hpp at line 16](../../../Src/host/CombatSystem/CombatRules.hpp#L16)
## RULE_CA_HEAD_NO

Type: constant

Description: Пустой прикол. без эффекта


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatRules.hpp at line 19](../../../Src/host/CombatSystem/CombatRules.hpp#L19)
## RULE_CA_HEAD_MAXDMG_INGNORSP

Type: constant

Description: Нумераторы для критических атак в голову


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatRules.hpp at line 23](../../../Src/host/CombatSystem/CombatRules.hpp#L23)
## RULE_CA_HEAD_SP2_MAJW

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CombatSystem\CombatRules.hpp at line 24](../../../Src/host/CombatSystem/CombatRules.hpp#L24)
## RULE_CA_HEAD_RELOCTOEYE

Type: constant

Description: 


Replaced value:
```sqf
0 /*не используется. просчёт внутри*/
```
File: [host\CombatSystem\CombatRules.hpp at line 25](../../../Src/host/CombatSystem/CombatRules.hpp#L25)
## RULE_CA_HEAD_DEAF

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CombatSystem\CombatRules.hpp at line 26](../../../Src/host/CombatSystem/CombatRules.hpp#L26)
## RULE_CA_HEAD_DROPWEAP

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CombatSystem\CombatRules.hpp at line 27](../../../Src/host/CombatSystem/CombatRules.hpp#L27)
## RULE_CA_HEAD_MAXDMG

Type: constant

Description: Нумераторы для критических атак в голову


Replaced value:
```sqf
6
```
File: [host\CombatSystem\CombatRules.hpp at line 23](../../../Src/host/CombatSystem/CombatRules.hpp#L23)
## RULE_CA_HEAD_DDAM

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\CombatSystem\CombatRules.hpp at line 29](../../../Src/host/CombatSystem/CombatRules.hpp#L29)
## RULE_CA_HEAD_SP2

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CombatSystem\CombatRules.hpp at line 24](../../../Src/host/CombatSystem/CombatRules.hpp#L24)
## RULE_CA_HEAD_TDAM

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [host\CombatSystem\CombatRules.hpp at line 31](../../../Src/host/CombatSystem/CombatRules.hpp#L31)
## RULE_CA_MAJW

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\CombatSystem\CombatRules.hpp at line 34](../../../Src/host/CombatSystem/CombatRules.hpp#L34)
## RULE_CA_DSHOCK

Type: constant

Description: 


Replaced value:
```sqf
11
```
File: [host\CombatSystem\CombatRules.hpp at line 35](../../../Src/host/CombatSystem/CombatRules.hpp#L35)
## RULE_CA_DROPALL

Type: constant

Description: 


Replaced value:
```sqf
12
```
File: [host\CombatSystem\CombatRules.hpp at line 36](../../../Src/host/CombatSystem/CombatRules.hpp#L36)
# CombatSystem.hpp

## reqSkillAdd(name,minval)

Type: constant

Description: 
- Param: name
- Param: minval

Replaced value:
```sqf
[#name,minval]
```
File: [host\CombatSystem\CombatSystem.hpp at line 8](../../../Src/host/CombatSystem/CombatSystem.hpp#L8)
## wmLog(text,fmt)

Type: constant

Description: 
- Param: text
- Param: fmt

Replaced value:
```sqf
["<Roleplay::WeapModule>",format[text,fmt],"#0111"] call stdoutPrint;
```
File: [host\CombatSystem\CombatSystem.hpp at line 9](../../../Src/host/CombatSystem/CombatSystem.hpp#L9)
## DEF_TYPE_DODGE

Type: constant

Description: типы защиты уворот, парирование, блок


Replaced value:
```sqf
"def_dodge"
```
File: [host\CombatSystem\CombatSystem.hpp at line 12](../../../Src/host/CombatSystem/CombatSystem.hpp#L12)
## DEF_TYPE_PARRY

Type: constant

Description: 


Replaced value:
```sqf
"def_parry"
```
File: [host\CombatSystem\CombatSystem.hpp at line 13](../../../Src/host/CombatSystem/CombatSystem.hpp#L13)
## COMBAT_STYLE_NO

Type: constant

Description: Маневры для боёвки


Replaced value:
```sqf
"cs_no" /*без использования стиля*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 19](../../../Src/host/CombatSystem/CombatSystem.hpp#L19)
## COMBAT_STYLE_T_DEFENSE

Type: constant

Description: без использования стиля


Replaced value:
```sqf
"cs_totaldef" /*тотальная защита: дает +2 к броску защиту ИЛИ возможность защититься 2 разными защитами*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 20](../../../Src/host/CombatSystem/CombatSystem.hpp#L20)
## COMBAT_STYLE_RETEART

Type: constant

Description: 


Replaced value:
```sqf
"cs_reteart" /*отступление: возможность отойти на шаг назад и получить +3 к броску защиты против контактной атаки противника*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 21](../../../Src/host/CombatSystem/CombatSystem.hpp#L21)
## COMBAT_STYLE_FINT

Type: constant

Description: 


Replaced value:
```sqf
"cs_fint" /*финт*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 22](../../../Src/host/CombatSystem/CombatSystem.hpp#L22)
## COMBAT_STYLE_STRONG_ATTACK

Type: constant

Description: финт


Replaced value:
```sqf
"cs_strong" /*сильная атака: увеличивает урон противнику +1, для оружия зависящего от силы (удар со всей силы)*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 23](../../../Src/host/CombatSystem/CombatSystem.hpp#L23)
## COMBAT_STYLE_DOUBLE_ATTACK

Type: constant

Description: 


Replaced value:
```sqf
"cs_doubat" /*двойная атака: позволяет провести атаку основной и второй рукой. Если у вас 2 оружия, вы можете атаковать обеими руками сразу. Вторая рука получает штраф -4, но если вы Обоюдорукий, то получится 2 полноценные атаки*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 24](../../../Src/host/CombatSystem/CombatSystem.hpp#L24)
## COMBAT_STYLE_AIMED_ATTACK

Type: constant

Description: 


Replaced value:
```sqf
"cs_aimed" /*прицельная атака: увеличивает шанс попадания на +4 для холодного оружия (+1 для оружия дальнего боя),*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 25](../../../Src/host/CombatSystem/CombatSystem.hpp#L25)
## COMBAT_STYLE_FAST_ATTACK

Type: constant

Description: 


Replaced value:
```sqf
"cs_fast" /*Скоростной удар (с.370) — возможность провести два удара вместо одного, но пониженной точности с -6. Позволяет провести удары по разным противникам.*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 26](../../../Src/host/CombatSystem/CombatSystem.hpp#L26)
## COMBAT_STYLE_WEAK

Type: constant

Description: 


Replaced value:
```sqf
"cs_weak" /*щадящая атака. для дружеских тумаков*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 27](../../../Src/host/CombatSystem/CombatSystem.hpp#L27)
## COMBAT_STYLE_LIST_ALL

Type: constant

Description: этот лист только для ata_buf_process


Replaced value:
```sqf
[COMBAT_STYLE_NO,COMBAT_STYLE_T_DEFENSE,COMBAT_STYLE_FINT,COMBAT_STYLE_STRONG_ATTACK,COMBAT_STYLE_DOUBLE_ATTACK,COMBAT_STYLE_AIMED_ATTACK,COMBAT_STYLE_FAST_ATTACK,COMBAT_STYLE_WEAK]
```
File: [host\CombatSystem\CombatSystem.hpp at line 30](../../../Src/host/CombatSystem/CombatSystem.hpp#L30)
## _____COMBAT_STYLE_AIM

Type: constant

Description: 


Replaced value:
```sqf
8 /* СКОРЕЕ ВСЕГО ИДЁТ КАК ОТДЕЛЬНАЯ КНОПКА?! прицеливание (или оценка в ближнем бою)*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 32](../../../Src/host/CombatSystem/CombatSystem.hpp#L32)
## ATTACK_TYPE_SPECIAL

Type: constant

Description: do not change this values


Replaced value:
```sqf
"at_spec" /*только для специальных атак (укус например)*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 36](../../../Src/host/CombatSystem/CombatSystem.hpp#L36)
## ATTACK_TYPE_THRUST

Type: constant

Description: 


Replaced value:
```sqf
"at_thrust" /*Прямые точечные*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 37](../../../Src/host/CombatSystem/CombatSystem.hpp#L37)
## ATTACK_TYPE_SWING

Type: constant

Description: Прямые точечные


Replaced value:
```sqf
"at_swing" /*амплитудные размашистые*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 38](../../../Src/host/CombatSystem/CombatSystem.hpp#L38)
## ATTACK_TYPE_HANDLE

Type: constant

Description: амплитудные размашистые


Replaced value:
```sqf
"at_handle" /*рукоятка?*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 39](../../../Src/host/CombatSystem/CombatSystem.hpp#L39)
## ATTACK_TYPE_LIST_NODE_BINDING

Type: constant

Description: Тут можно добавить массу типов атаки


Replaced value:
```sqf
[ 'Прямая:'+ATTACK_TYPE_THRUST+':Прямые или точечные атаки' \
	,'Амплитудная:'+ATTACK_TYPE_SWING+':Амплитудные или размашистые атаки.' \
	,'Рукоятью:'+ATTACK_TYPE_HANDLE+':Атаки рукоятью.' \
	,'Специальная:'+ATTACK_TYPE_SPECIAL+':Специальная атака.' \
]
```
File: [host\CombatSystem\CombatSystem.hpp at line 42](../../../Src/host/CombatSystem/CombatSystem.hpp#L42)
## WEAPON_PARRY_UNABLE

Type: constant

Description: Парировательная способность


Replaced value:
```sqf
0 /*не парировательное */
```
File: [host\CombatSystem\CombatSystem.hpp at line 50](../../../Src/host/CombatSystem/CombatSystem.hpp#L50)
## WEAPON_PARRY_UNBALANCED

Type: constant

Description: не парировательное


Replaced value:
```sqf
1 /*несбалансированное*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 51](../../../Src/host/CombatSystem/CombatSystem.hpp#L51)
## WEAPON_PARRY_FENCING

Type: constant

Description: несбалансированное


Replaced value:
```sqf
2 /* фехтование */
```
File: [host\CombatSystem\CombatSystem.hpp at line 52](../../../Src/host/CombatSystem/CombatSystem.hpp#L52)
## WEAPON_PARRY_ENABLE

Type: constant

Description: фехтование


Replaced value:
```sqf
3 /* возможно */
```
File: [host\CombatSystem\CombatSystem.hpp at line 53](../../../Src/host/CombatSystem/CombatSystem.hpp#L53)
## DAMAGE_TYPE_CRUSHING

Type: constant

Description: дробящий (cr) причиняет Ущерб через тупой удар, как дубинкой или взрывчаткой.


Replaced value:
```sqf
"dt_crushing"
```
File: [host\CombatSystem\CombatSystem.hpp at line 63](../../../Src/host/CombatSystem/CombatSystem.hpp#L63)
## DAMAGE_TYPE_CUTTING

Type: constant

Description: режущий


Replaced value:
```sqf
"dt_cutting"
```
File: [host\CombatSystem\CombatSystem.hpp at line 65](../../../Src/host/CombatSystem/CombatSystem.hpp#L65)
## DAMAGE_TYPE_IMPALING

Type: constant

Description: (прон) bleeding наносит колотые раны, как копье или Стрела


Replaced value:
```sqf
"dt_impaling" /*колющий*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 67](../../../Src/host/CombatSystem/CombatSystem.hpp#L67)
## DAMAGE_TYPE_PIERCING_SM

Type: constant

Description: 


Replaced value:
```sqf
"dt_pi-"
```
File: [host\CombatSystem\CombatSystem.hpp at line 75](../../../Src/host/CombatSystem/CombatSystem.hpp#L75)
## DAMAGE_TYPE_PIERCING_NO

Type: constant

Description: 


Replaced value:
```sqf
"dt_pi"
```
File: [host\CombatSystem\CombatSystem.hpp at line 76](../../../Src/host/CombatSystem/CombatSystem.hpp#L76)
## DAMAGE_TYPE_PIERCING_LA

Type: constant

Description: 


Replaced value:
```sqf
"dt_pi+"
```
File: [host\CombatSystem\CombatSystem.hpp at line 77](../../../Src/host/CombatSystem/CombatSystem.hpp#L77)
## DAMAGE_TYPE_PIERCING_HU

Type: constant

Description: 


Replaced value:
```sqf
"dt_pi++"
```
File: [host\CombatSystem\CombatSystem.hpp at line 78](../../../Src/host/CombatSystem/CombatSystem.hpp#L78)
## DAMAGE_TYPE_BURN

Type: constant

Description: гореть


Replaced value:
```sqf
"dt_burn"
```
File: [host\CombatSystem\CombatSystem.hpp at line 81](../../../Src/host/CombatSystem/CombatSystem.hpp#L81)
## DAMAGE_TYPE_CORROSION

Type: constant

Description: разъедание (cor) это атака, повреждение которой включает кислоту, распад или что-то подобное.


Replaced value:
```sqf
"dt_cor"
```
File: [host\CombatSystem\CombatSystem.hpp at line 83](../../../Src/host/CombatSystem/CombatSystem.hpp#L83)
## DAMAGE_TYPE_TOXIC

Type: constant

Description: не записывающиеся в mob.wounds


Replaced value:
```sqf
"dt_tox"
```
File: [host\CombatSystem\CombatSystem.hpp at line 88](../../../Src/host/CombatSystem/CombatSystem.hpp#L88)
## DAMAGE_TYPE_FATIGUE

Type: constant

Description: усталость


Replaced value:
```sqf
"dt_fat"
```
File: [host\CombatSystem\CombatSystem.hpp at line 91](../../../Src/host/CombatSystem/CombatSystem.hpp#L91)
## DAMAGE_TYPE_AFFLICTION

Type: constant

Description: взд


Replaced value:
```sqf
"dt_aff"
```
File: [host\CombatSystem\CombatSystem.hpp at line 93](../../../Src/host/CombatSystem/CombatSystem.hpp#L93)
## DAMAGE_TYPE_SPEC

Type: constant

Description: по условиям оружия


Replaced value:
```sqf
"dt_spec"
```
File: [host\CombatSystem\CombatSystem.hpp at line 95](../../../Src/host/CombatSystem/CombatSystem.hpp#L95)
## DAMAGE_TYPE_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
[ "Дробящий:"+DAMAGE_TYPE_CRUSHING+":Ущерб через тупой удар, как дубинкой или взрывчаткой." \
	,"Режущий:"+DAMAGE_TYPE_CUTTING + ":Ущерб через острые предметы." \
	,"Проникающий:"+DAMAGE_TYPE_IMPALING + ":Колотые раны, полученные например копьем или стрелой." \
	,"Малый пробивной:"+DAMAGE_TYPE_PIERCING_SM +":Низкоэнергетический снаряд или атака, оставляющая небольшой раневой канал, например бронебойная пуля." \
	,"Обычный пробивной атака:"+DAMAGE_TYPE_PIERCING_NO +":Большинство обычных винтовочных и пистолетных пуль." \
	,"Большой пробивной:"+DAMAGE_TYPE_PIERCING_LA +":Крупнокалиберные твердые пули или атака, которая оставляет большой канал, такой как пуля с полой точкой или рикошетом." \
	,"Огромный пронзительный:"+DAMAGE_TYPE_PIERCING_HU +":" \
	,"Огненный:"+DAMAGE_TYPE_BURN \
	,"Разъедающий:"+DAMAGE_TYPE_CORROSION \
	,"Токсический:"+DAMAGE_TYPE_TOXIC \
	,"Изнуряющий:"+DAMAGE_TYPE_FATIGUE \
	,"Воздействующий:"+DAMAGE_TYPE_AFFLICTION \
	,"Специализированный:"+DAMAGE_TYPE_SPEC \
]
```
File: [host\CombatSystem\CombatSystem.hpp at line 97](../../../Src/host/CombatSystem/CombatSystem.hpp#L97)
## WOUND_TYPE_BRUISE

Type: constant

Description: ушибы, синяки


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 119](../../../Src/host/CombatSystem/CombatSystem.hpp#L119)
## WOUND_TYPE_BLEEDING

Type: constant

Description: все резанные


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatSystem.hpp at line 121](../../../Src/host/CombatSystem/CombatSystem.hpp#L121)
## WOUND_TYPE_BURN

Type: constant

Description: кожа и мясо


Replaced value:
```sqf
WOUND_TYPE_BRUISE
```
File: [host\CombatSystem\CombatSystem.hpp at line 123](../../../Src/host/CombatSystem/CombatSystem.hpp#L123)
## WOUND_SIZE_SCRATCH

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 133](../../../Src/host/CombatSystem/CombatSystem.hpp#L133)
## WOUND_SIZE_MINOR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatSystem.hpp at line 134](../../../Src/host/CombatSystem/CombatSystem.hpp#L134)
## WOUND_SIZE_MODERATE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CombatSystem\CombatSystem.hpp at line 135](../../../Src/host/CombatSystem/CombatSystem.hpp#L135)
## WOUND_SIZE_MAJOR

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CombatSystem\CombatSystem.hpp at line 136](../../../Src/host/CombatSystem/CombatSystem.hpp#L136)
## WOUND_SIZE_CRITICAL

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CombatSystem\CombatSystem.hpp at line 137](../../../Src/host/CombatSystem/CombatSystem.hpp#L137)
## WOUND_SIZE_MASSIVE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CombatSystem\CombatSystem.hpp at line 138](../../../Src/host/CombatSystem/CombatSystem.hpp#L138)
## WOUND_SIZE_GAWDAWFUL

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\CombatSystem\CombatSystem.hpp at line 139](../../../Src/host/CombatSystem/CombatSystem.hpp#L139)
## WOUND_SIZE_DESTRUCTION

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\CombatSystem\CombatSystem.hpp at line 140](../../../Src/host/CombatSystem/CombatSystem.hpp#L140)
## BP_INDEX_HEAD

Type: constant

Description: Зоны для ассоциации с частями тела моба (bodyParts)


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 149](../../../Src/host/CombatSystem/CombatSystem.hpp#L149)
## BP_INDEX_TORSO

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatSystem.hpp at line 150](../../../Src/host/CombatSystem/CombatSystem.hpp#L150)
## BP_INDEX_ARM_R

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CombatSystem\CombatSystem.hpp at line 151](../../../Src/host/CombatSystem/CombatSystem.hpp#L151)
## BP_INDEX_ARM_L

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CombatSystem\CombatSystem.hpp at line 152](../../../Src/host/CombatSystem/CombatSystem.hpp#L152)
## BP_INDEX_LEG_R

Type: constant

Description: #define LIMB_INDEX_HAND_L 4


Replaced value:
```sqf
4
```
File: [host\CombatSystem\CombatSystem.hpp at line 155](../../../Src/host/CombatSystem/CombatSystem.hpp#L155)
## BP_INDEX_LEG_L

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CombatSystem\CombatSystem.hpp at line 156](../../../Src/host/CombatSystem/CombatSystem.hpp#L156)
## BP_INDEX_ALL

Type: constant

Description: #define LIMB_INDEX_FOOT_L 8


Replaced value:
```sqf
[BP_INDEX_HEAD,BP_INDEX_TORSO,BP_INDEX_ARM_R,BP_INDEX_ARM_L,BP_INDEX_LEG_R,BP_INDEX_LEG_L]
```
File: [host\CombatSystem\CombatSystem.hpp at line 159](../../../Src/host/CombatSystem/CombatSystem.hpp#L159)
## BODY_PART_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
[ 'Голова:BP_INDEX_HEAD' \
	,'Туловище:BP_INDEX_TORSO' \
	,'Правая рука:BP_INDEX_ARM_R' \
	,'Левая рука:BP_INDEX_ARM_L' \
	,'Правая нога:BP_INDEX_LEG_R' \
	,'Левая нога:BP_INDEX_LEG_L' \
]
```
File: [host\CombatSystem\CombatSystem.hpp at line 161](../../../Src/host/CombatSystem/CombatSystem.hpp#L161)
## BO_INDEX_HEART

Type: constant

Description: Зоны для ассоциации органов в массиве


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 170](../../../Src/host/CombatSystem/CombatSystem.hpp#L170)
## BO_INDEX_LIVER

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatSystem.hpp at line 171](../../../Src/host/CombatSystem/CombatSystem.hpp#L171)
## BO_INDEX_KIDNEY_R

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CombatSystem\CombatSystem.hpp at line 172](../../../Src/host/CombatSystem/CombatSystem.hpp#L172)
## BO_INDEX_KIDNEY_L

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CombatSystem\CombatSystem.hpp at line 173](../../../Src/host/CombatSystem/CombatSystem.hpp#L173)
## BO_INDEX_GUTS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CombatSystem\CombatSystem.hpp at line 174](../../../Src/host/CombatSystem/CombatSystem.hpp#L174)
## BO_INDEX_STOMACH

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CombatSystem\CombatSystem.hpp at line 175](../../../Src/host/CombatSystem/CombatSystem.hpp#L175)
## BO_INDEX_LUNGS

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\CombatSystem\CombatSystem.hpp at line 176](../../../Src/host/CombatSystem/CombatSystem.hpp#L176)
## BO_INDEX_TO_NAME(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(["Сердце","Печень","Правая почка","Левая почка","Кишки","Желудок","Легкие"] select idx)
```
File: [host\CombatSystem\CombatSystem.hpp at line 178](../../../Src/host/CombatSystem/CombatSystem.hpp#L178)
## BO_INDEX_ALL

Type: constant

Description: 


Replaced value:
```sqf
[BO_INDEX_HEART,BO_INDEX_LIVER,BO_INDEX_KIDNEY_R,BO_INDEX_KIDNEY_L,BO_INDEX_GUTS,BO_INDEX_STOMACH,BO_INDEX_LUNGS]
```
File: [host\CombatSystem\CombatSystem.hpp at line 180](../../../Src/host/CombatSystem/CombatSystem.hpp#L180)
## TARGET_ZONE_TORSO

Type: constant

Description: 


Replaced value:
```sqf
0 /*торс*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 182](../../../Src/host/CombatSystem/CombatSystem.hpp#L182)
## TARGET_ZONE_ABDOMEN

Type: constant

Description: торс


Replaced value:
```sqf
1 /*живот*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 183](../../../Src/host/CombatSystem/CombatSystem.hpp#L183)
## TARGET_ZONE_HEAD

Type: constant

Description: живот


Replaced value:
```sqf
3 /*голова*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 184](../../../Src/host/CombatSystem/CombatSystem.hpp#L184)
## TARGET_ZONE_EYE_L

Type: constant

Description: голова


Replaced value:
```sqf
4
```
File: [host\CombatSystem\CombatSystem.hpp at line 185](../../../Src/host/CombatSystem/CombatSystem.hpp#L185)
## TARGET_ZONE_EYE_R

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CombatSystem\CombatSystem.hpp at line 186](../../../Src/host/CombatSystem/CombatSystem.hpp#L186)
## TARGET_ZONE_FACE

Type: constant

Description: 


Replaced value:
```sqf
6 /*лицо*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 187](../../../Src/host/CombatSystem/CombatSystem.hpp#L187)
## TARGET_ZONE_NECK

Type: constant

Description: лицо


Replaced value:
```sqf
7 /*шея*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 188](../../../Src/host/CombatSystem/CombatSystem.hpp#L188)
## TARGET_ZONE_GROIN

Type: constant

Description: шея


Replaced value:
```sqf
8 /*пах*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 189](../../../Src/host/CombatSystem/CombatSystem.hpp#L189)
## TARGET_ZONE_ARM_L

Type: constant

Description: пах


Replaced value:
```sqf
9
```
File: [host\CombatSystem\CombatSystem.hpp at line 190](../../../Src/host/CombatSystem/CombatSystem.hpp#L190)
## TARGET_ZONE_ARM_R

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\CombatSystem\CombatSystem.hpp at line 191](../../../Src/host/CombatSystem/CombatSystem.hpp#L191)
## TARGET_ZONE_LEG_L

Type: constant

Description: 


Replaced value:
```sqf
11
```
File: [host\CombatSystem\CombatSystem.hpp at line 192](../../../Src/host/CombatSystem/CombatSystem.hpp#L192)
## TARGET_ZONE_LEG_R

Type: constant

Description: 


Replaced value:
```sqf
12
```
File: [host\CombatSystem\CombatSystem.hpp at line 193](../../../Src/host/CombatSystem/CombatSystem.hpp#L193)
## TARGET_ZONE_FOOT_R

Type: constant

Description: 


Replaced value:
```sqf
16*/
```
File: [host\CombatSystem\CombatSystem.hpp at line 197](../../../Src/host/CombatSystem/CombatSystem.hpp#L197)
## TARGET_ZONE_MOUTH

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [host\CombatSystem\CombatSystem.hpp at line 198](../../../Src/host/CombatSystem/CombatSystem.hpp#L198)
## TARGET_ZONE_RANDOM

Type: constant

Description: #define TARGET_ZONE_LARGEAREA 18 /*не нужное*/


Replaced value:
```sqf
19
```
File: [host\CombatSystem\CombatSystem.hpp at line 201](../../../Src/host/CombatSystem/CombatSystem.hpp#L201)
## TARGET_ZONE_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
[ 'Торс:TARGET_ZONE_TORSO' \
	,'Живот:TARGET_ZONE_ABDOMEN' \
	,'Голова:TARGET_ZONE_HEAD' \
	,'Левый глаз:TARGET_ZONE_EYE_L' \
	,'Правый глаз:TARGET_ZONE_EYE_R' \
	,'Лицо:TARGET_ZONE_FACE' \
	,'Шея:TARGET_ZONE_NECK' \
	,'Пах:TARGET_ZONE_GROIN' \
	,'Левая рука:TARGET_ZONE_ARM_L' \
	,'Правая рука:TARGET_ZONE_ARM_R' \
	,'Левая нога:TARGET_ZONE_LEG_L' \
	,'Правая нога:TARGET_ZONE_LEG_R' \
	,'Рот:TARGET_ZONE_MOUTH' \
	,'Случайно:TARGET_ZONE_RANDOM' \
]
```
File: [host\CombatSystem\CombatSystem.hpp at line 203](../../../Src/host/CombatSystem/CombatSystem.hpp#L203)
## TARGET_ZONE_LIST_HEAD

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_NECK,TARGET_ZONE_MOUTH,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L]
```
File: [host\CombatSystem\CombatSystem.hpp at line 220](../../../Src/host/CombatSystem/CombatSystem.hpp#L220)
## TARGET_ZONE_LIST_LIMBS

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L,TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L]
```
File: [host\CombatSystem\CombatSystem.hpp at line 221](../../../Src/host/CombatSystem/CombatSystem.hpp#L221)
## TARGET_ZONE_LIST_TORSO

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO,TARGET_ZONE_GROIN]
```
File: [host\CombatSystem\CombatSystem.hpp at line 222](../../../Src/host/CombatSystem/CombatSystem.hpp#L222)
## TARGET_ZONE_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO,TARGET_ZONE_GROIN,TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L,TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L,TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_NECK,TARGET_ZONE_MOUTH,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L]
```
File: [host\CombatSystem\CombatSystem.hpp at line 223](../../../Src/host/CombatSystem/CombatSystem.hpp#L223)
## TARGET_ZONE_NAME_MAIN

Type: constant

Description: именительный - шея, левая рука


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 227](../../../Src/host/CombatSystem/CombatSystem.hpp#L227)
## TARGET_ZONE_NAME_TO

Type: constant

Description: к чему - шее, левой руке


Replaced value:
```sqf
1
```
File: [host\CombatSystem\CombatSystem.hpp at line 229](../../../Src/host/CombatSystem/CombatSystem.hpp#L229)
## TARGET_ZONE_NAME_WHAT

Type: constant

Description: используется в атаках - атакует что? - шею, левую руку


Replaced value:
```sqf
2
```
File: [host\CombatSystem\CombatSystem.hpp at line 231](../../../Src/host/CombatSystem/CombatSystem.hpp#L231)
## WEAPON_CATEGORY_MELEE

Type: constant

Description: кажется эти не нужны...


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 234](../../../Src/host/CombatSystem/CombatSystem.hpp#L234)
## WEAPON_CATEGORY_FIREARMS

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 235](../../../Src/host/CombatSystem/CombatSystem.hpp#L235)
## WEAPON_CATEGORY_THROWABLE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CombatSystem\CombatSystem.hpp at line 236](../../../Src/host/CombatSystem/CombatSystem.hpp#L236)
## runtimeGenerateWeapon(typename,baseclass)

Type: constant

Description: макрос для генератора скриптовых оружейных узлов
- Param: typename
- Param: baseclass

Replaced value:
```sqf
([typename,baseclass,__FILE__,__LINE__]call cs_runtime_internal_generate)pushBack
```
File: [host\CombatSystem\CombatSystem.hpp at line 240](../../../Src/host/CombatSystem/CombatSystem.hpp#L240)
## weaponModule(t)

Type: constant

Description: 
- Param: t

Replaced value:
```sqf
wm_##t
```
File: [host\CombatSystem\CombatSystem.hpp at line 242](../../../Src/host/CombatSystem/CombatSystem.hpp#L242)
## REACH_DEFAULT

Type: constant

Description: дистанты


Replaced value:
```sqf
0.9
```
File: [host\CombatSystem\CombatSystem.hpp at line 245](../../../Src/host/CombatSystem/CombatSystem.hpp#L245)
# Functions.sqf

## tzndef(name,a,b,c)

Type: constant

Description: 
- Param: name
- Param: a
- Param: b
- Param: c

Replaced value:
```sqf
[name,[a,b,c]]
```
File: [host\CombatSystem\Functions.sqf at line 7](../../../Src/host/CombatSystem/Functions.sqf#L7)
## hitRet(val,ret)

Type: constant

Description: 
- Param: val
- Param: ret

Replaced value:
```sqf
if (_hitZone == val) exitWith {ret}
```
File: [host\CombatSystem\Functions.sqf at line 176](../../../Src/host/CombatSystem/Functions.sqf#L176)
## hitMultiRet(vals,ret)

Type: constant

Description: 
- Param: vals
- Param: ret

Replaced value:
```sqf
if (_hitZone in [vals]) exitWith {ret}
```
File: [host\CombatSystem\Functions.sqf at line 177](../../../Src/host/CombatSystem/Functions.sqf#L177)
## gurps_internal_tzn

Type: Variable

Description: 


Initial value:
```sqf
hashMapNewArgs [ //reference type...
```
File: [host\CombatSystem\Functions.sqf at line 8](../../../Src/host/CombatSystem/Functions.sqf#L8)
## gurps_internal_tzToSel

Type: Variable

Description: 


Initial value:
```sqf
hashMapNewArgs [ //reference type...
```
File: [host\CombatSystem\Functions.sqf at line 64](../../../Src/host/CombatSystem/Functions.sqf#L64)
## gurps_pickThrowingZone

Type: function

Description: Внимание! Входящая зона как TARGET_ZONE_RANDOM конвертится в реально рандомную часть
- Param: _sel
- Param: _cat

File: [host\CombatSystem\Functions.sqf at line 27](../../../Src/host/CombatSystem/Functions.sqf#L27)
## gurps_convertTargetZoneToString

Type: function

Description: Конвертирует таргет зону в строковое название со склонением
- Param: _zoneIndex
- Param: _z_n (optional, default TARGET_ZONE_NAME_MAIN)

File: [host\CombatSystem\Functions.sqf at line 52](../../../Src/host/CombatSystem/Functions.sqf#L52)
## gurps_convertTargetZoneToStringSafe

Type: function

Description: Тоже что и gurps_convertTargetZoneToString но вовзращает только фактические имена частей тела
- Param: _zoneIndex
- Param: _z_n (optional, default TARGET_ZONE_NAME_MAIN)

File: [host\CombatSystem\Functions.sqf at line 58](../../../Src/host/CombatSystem/Functions.sqf#L58)
## gurps_convertTargetZoneToArmaSelection

Type: function

Description: таргетзону в селекшон на мобе
- Param: _zone

File: [host\CombatSystem\Functions.sqf at line 82](../../../Src/host/CombatSystem/Functions.sqf#L82)
## gurps_applyDamageType

Type: function

Description: применяет к дамагу модификатор после прохождения через DR
- Param: _dam
- Param: _type

File: [host\CombatSystem\Functions.sqf at line 88](../../../Src/host/CombatSystem/Functions.sqf#L88)
## gurps_convertDamageToWound

Type: function

Description: конвертирует тип повреждений в тип раны
- Param: _type

File: [host\CombatSystem\Functions.sqf at line 97](../../../Src/host/CombatSystem/Functions.sqf#L97)
## gurps_convertTargetZoneToBodyPart

Type: function

Description: Конвертирует таргет зону в боди парт нумератор
- Param: _zone

File: [host\CombatSystem\Functions.sqf at line 105](../../../Src/host/CombatSystem/Functions.sqf#L105)
## gurps_convertBodyPartToTargetZone

Type: function

Description: Обратная конвертация из бодипарта в таргет зону
- Param: _zone

File: [host\CombatSystem\Functions.sqf at line 123](../../../Src/host/CombatSystem/Functions.sqf#L123)
## gurps_convertTargetZoneToSlot

Type: function

Description: 
- Param: _zone
- Param: _dir (optional, default DIR_FRONT)

File: [host\CombatSystem\Functions.sqf at line 136](../../../Src/host/CombatSystem/Functions.sqf#L136)
## gurps_convertSlotToBodyPart

Type: function

Description: 
- Param: _slot

File: [host\CombatSystem\Functions.sqf at line 158](../../../Src/host/CombatSystem/Functions.sqf#L158)
## gurps_convertHitZoneToDefZone

Type: function

Description: 
- Param: _hitZone

File: [host\CombatSystem\Functions.sqf at line 168](../../../Src/host/CombatSystem/Functions.sqf#L168)
# MeeleWeapon.sqf

## isZoneIn(zones,modif,aimmodif)

Type: constant

Description: за зону попадания
- Param: zones
- Param: modif
- Param: aimmodif

Replaced value:
```sqf
if (_attTargetZone in [zones]) exitWith {ifcheck(_isAimed,MOD(_modif,aimmodif),MOD(_modif,modif))}
```
File: [host\CombatSystem\MeeleWeapon.sqf at line 191](../../../Src/host/CombatSystem/MeeleWeapon.sqf#L191)
# RuntimeWeaponModulesGenerator.sqf

## cs_runtime_map_modules

Type: Variable

Description: 


Initial value:
```sqf
hashMapNew
```
File: [host\CombatSystem\RuntimeWeaponModulesGenerator.sqf at line 25](../../../Src/host/CombatSystem/RuntimeWeaponModulesGenerator.sqf#L25)
## cs_runtime_internal_generate

Type: function

Description: внутренняя реализация генератора узлов
- Param: _typeName
- Param: _inherited
- Param: _decl_file (optional, default "<NULL_FILE>")
- Param: _decl_line (optional, default "<NaN>")

File: [host\CombatSystem\RuntimeWeaponModulesGenerator.sqf at line 29](../../../Src/host/CombatSystem/RuntimeWeaponModulesGenerator.sqf#L29)
## cs_runtime_internal_makeAll

Type: function

Description: 
- Param: _file__
- Param: _line__
- Param: _inherited___
- Param: _initcode___

File: [host\CombatSystem\RuntimeWeaponModulesGenerator.sqf at line 42](../../../Src/host/CombatSystem/RuntimeWeaponModulesGenerator.sqf#L42)
