# Reputation_functions.sqf

## repvote_serializeFlags

Type: function

Description: 


File: [host\Reputation\Reputation_functions.sqf at line 31](../../../Src/host/Reputation/Reputation_functions.sqf#L31)
## repvote_deserializeFlags

Type: function

Description: 
- Param: _key
- Param: _val

File: [host\Reputation\Reputation_functions.sqf at line 47](../../../Src/host/Reputation/Reputation_functions.sqf#L47)
## repvote_collectPlayer

Type: function

Description: 
- Param: _mob
- Param: _client

File: [host\Reputation\Reputation_functions.sqf at line 60](../../../Src/host/Reputation/Reputation_functions.sqf#L60)
## repvote_onEndRound

Type: function

Description: 


File: [host\Reputation\Reputation_functions.sqf at line 91](../../../Src/host/Reputation/Reputation_functions.sqf#L91)
## repvote_startVotingClient

Type: function

Description: 
- Param: this
- Param: _bestBads

File: [host\Reputation\Reputation_functions.sqf at line 213](../../../Src/host/Reputation/Reputation_functions.sqf#L213)
## repvote_voteTo

Type: function

Description: Добавление структуры голосования
- Param: _name
- Param: _best (optional, default [])
- Param: _bad (optional, default [])

File: [host\Reputation\Reputation_functions.sqf at line 236](../../../Src/host/Reputation/Reputation_functions.sqf#L236)
## repvote_voteToEDITOR

Type: function

> <font size="5">Exists if **EDITOR** defined</font>

Description: 
- Param: _name
- Param: _best (optional, default [])
- Param: _bad (optional, default [])
- Param: _autoSync (optional, default true)

File: [host\Reputation\Reputation_functions.sqf at line 245](../../../Src/host/Reputation/Reputation_functions.sqf#L245)
## repvote_reputationToLevel

Type: function

Description: 
- Param: _rep

File: [host\Reputation\Reputation_functions.sqf at line 264](../../../Src/host/Reputation/Reputation_functions.sqf#L264)
## repvote_getReputationText

Type: function

Description: 
- Param: _points

File: [host\Reputation\Reputation_functions.sqf at line 294](../../../Src/host/Reputation/Reputation_functions.sqf#L294)
## repvote_isAllowedRoleByReputation

Type: function

Description: 
- Param: _rep
- Param: _role

File: [host\Reputation\Reputation_functions.sqf at line 302](../../../Src/host/Reputation/Reputation_functions.sqf#L302)
## rep_debug_showNeedPoints

Type: function

> <font size="5">Exists if **EDITOR** defined</font>

Description: 


File: [host\Reputation\Reputation_functions.sqf at line 319](../../../Src/host/Reputation/Reputation_functions.sqf#L319)
# Reputation_init.sqf

## QUESTIONS_COUNT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\Reputation\Reputation_init.sqf at line 21](../../../Src/host/Reputation/Reputation_init.sqf#L21)
## QUESTIONS_CUSTOM_COUNT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Reputation\Reputation_init.sqf at line 22](../../../Src/host/Reputation/Reputation_init.sqf#L22)
## QUESTION_CUSTOM_SPECIAL_CHAR

Type: constant

Description: 


Replaced value:
```sqf
"▬"
```
File: [host\Reputation\Reputation_init.sqf at line 24](../../../Src/host/Reputation/Reputation_init.sqf#L24)
## CATEGORIES_COUNT

Type: constant

Description: по 1 вопросу из каждой категории


Replaced value:
```sqf
QUESTIONS_COUNT
```
File: [host\Reputation\Reputation_init.sqf at line 27](../../../Src/host/Reputation/Reputation_init.sqf#L27)
## rep_regQuestion

Type: function

Description: 
- Param: _catIdx
- Param: _questionText
- Param: _answers
- Param: _correctAnswers

File: [host\Reputation\Reputation_init.sqf at line 36](../../../Src/host/Reputation/Reputation_init.sqf#L36)
## rep_regCustomQuestion

Type: function

Description: 
- Param: _questionText

File: [host\Reputation\Reputation_init.sqf at line 42](../../../Src/host/Reputation/Reputation_init.sqf#L42)
## rep_generateQuestions

Type: function

Description: 


File: [host\Reputation\Reputation_init.sqf at line 47](../../../Src/host/Reputation/Reputation_init.sqf#L47)
## rep_processTesting

Type: function

Description: 


File: [host\Reputation\Reputation_init.sqf at line 73](../../../Src/host/Reputation/Reputation_init.sqf#L73)
## rep_processQuestionText

Type: function

Description: 
- Param: _qt

File: [host\Reputation\Reputation_init.sqf at line 103](../../../Src/host/Reputation/Reputation_init.sqf#L103)
## rep_handleProcessTesting

Type: function

Description: 
- Param: this

File: [host\Reputation\Reputation_init.sqf at line 109](../../../Src/host/Reputation/Reputation_init.sqf#L109)
## rep_startTesting

Type: function

Description: 
- Param: this

File: [host\Reputation\Reputation_init.sqf at line 167](../../../Src/host/Reputation/Reputation_init.sqf#L167)
## rep_continueTesting

Type: function

Description: ! данная функция вызывает ошибку движка с падением базы в некоторых случаях
- Param: this
- Param: _testResult
- Param: _testQuestions
- Param: _testProgress

File: [host\Reputation\Reputation_init.sqf at line 179](../../../Src/host/Reputation/Reputation_init.sqf#L179)
## rep_endTest

Type: function

Description: 
- Param: this

File: [host\Reputation\Reputation_init.sqf at line 209](../../../Src/host/Reputation/Reputation_init.sqf#L209)
## rep_init

Type: function

Description: 


File: [host\Reputation\Reputation_init.sqf at line 220](../../../Src/host/Reputation/Reputation_init.sqf#L220)
