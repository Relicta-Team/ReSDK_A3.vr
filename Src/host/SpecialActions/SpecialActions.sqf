// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <SpecialActions.hpp>
#include <SpecialActions.h>

//событие при пинке
SA_ADD(SPECIAL_ACTION_KICK)

SA_END(SA_EF_NO)

//переключение граба
SA_ADD(SPECIAL_ACTION_GRAB)

SA_END(SA_EF_NO);

//событие при сжимании
SA_ADD(SPECIAL_ACTION_BREATH)
	callSelfParams(setHoldBreath,!getSelf(isHoldedBreath));
SA_END(SA_EF_NO)

//событие при кусании
SA_ADD(SPECIAL_ACTION_BITE)

SA_END(SA_EF_NO)

//прыжок
SA_ADD(SPECIAL_ACTION_JUMP)

SA_END(SA_EF_NO)

//воровство
SA_ADD(SPECIAL_ACTION_STEAL)

SA_END(SA_EF_NO)

//прятаться
SA_ADD(SPECIAL_ACTION_STEALTH)
	callFuncParams(this,setPreStealth,!getSelf(isStealthEnabled));
SA_END(SA_EF_NO)

//глаза
SA_ADD(SPECIAL_ACTION_EYES)
	callFuncParams(this,setCloseEyes,!getSelf(isCloseEyes));
SA_END(SA_EF_NO)

//сон
SA_ADD(SPECIAL_ACTION_SLEEP)
	callSelfParams(setSleep,!callSelf(isSleep));
SA_END(SA_EF_NO)

//бросание
SA_ADD(SPECIAL_ACTION_THROW)

SA_END(SA_EF_CANCEL_AFTER_USE)
