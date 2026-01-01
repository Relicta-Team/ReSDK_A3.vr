// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(WidgetSystem.Actions,widget_)

inline_macro
#define ACT(name) actionKeys #name

//Пользовательские меню?!
macro_func(widget_getGroups,int[]())
#define GROUP_ACTIONS ACT(CommandingMenu1) + ACT(CommandingMenu2) + ACT(CommandingMenu3) + ACT(CommandingMenu4) + ACT(CommandingMenu5) \
 + ACT(CommandingMenu6) + ACT(CommandingMenu7) + ACT(CommandingMenu8) + ACT(CommandingMenu9) + ACT(CommandingMenu0) + \
 ACT(CommandingMenuSelect1) + ACT(CommandingMenuSelect2) + ACT(CommandingMenuSelect3) + ACT(CommandingMenuSelect4) + \
 ACT(CommandingMenuSelect5) + ACT(CommandingMenuSelect6) + ACT(CommandingMenuSelect7) + ACT(CommandingMenuSelect8) + \
 ACT(CommandingMenuSelect9) + ACT(CommandingMenuSelect0) + \
 ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)
 
//команды на F1-F12
macro_func(widget_getCommandingMenu,int[]())
#define GROUP_COMMA_MENU ACT(SelectGroupUnit1) + ACT(SelectGroupUnit2) + ACT(SelectGroupUnit3) + \
ACT(SelectGroupUnit4) + ACT(SelectGroupUnit5) + ACT(SelectGroupUnit6) + ACT(SelectGroupUnit7) + \
ACT(SelectGroupUnit8) + ACT(SelectGroupUnit9) + ACT(SelectGroupUnit0) + ACT(selectAll)

#ifdef SP_MODE
	#define SP_MODE_LOCKED_BUTTONS + ACT(timeInc) + ACT(timeDec)
#else
	#define SP_MODE_LOCKED_BUTTONS 
#endif

//инвентарь и другое пользовательское взаимодействие
macro_func(widget_getSimplePlayerInteractions,int[]())
#define SIMPLE_PLAYER_INTERACTION ACT(showMap) + ACT(gear) + ACT(navigateMenu) + ACT(EvasiveLeft) + ACT(EvasiveRight) + \
 ACT(Salute) + ACT(SitDown) + ACT(networkStats) + ACT(networkPlayers) + ACT(diary) SP_MODE_LOCKED_BUTTONS

// + ACT(TactShort) -> TactShort - тактический шаг на 3 секунды

// GetOver - перешагивание

//эскейп
macro_func(widget_getEscapeButtons,int[]())
#define ESCAPE_BUTTONS ACT(ingamePause)

macro_func(widget_getForbiddenButtons,int[]())
#define FORBIDDEN_BUTTONS (GROUP_ACTIONS + GROUP_COMMA_MENU + SIMPLE_PLAYER_INTERACTION)
macro_func(widget_getForbiddenScrollButton,int[]())
#define FORBIDDEN_BUTTONS_SCROLL ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)

macro_func(widget_isForbiddenButton,bool(int))
#define ADDRULE_FORBIDDEN_BUTTONS(forkey) (forkey in FORBIDDEN_BUTTONS)
macro_func(widget_isForbiddenScrollButton,bool(int))
#define ADDRULE_FORBIDDEN_SCROLL(forkey) (forkey in FORBIDDEN_BUTTONS_SCROLL)

//TurnLeft, TurnRight, MoveForward, MoveBack
//strafelock check
macro_func(widget_getLeftMoveButtons,int[]())
#define LEFT_MOVE_BUTTONS ( ACT(TurnLeft) )
macro_func(widget_getRightMoveButtons,int[]())
#define RIGHT_MOVE_BUTTONS ( ACT(TurnRight) )

macro_func(widget_getMoveForwardButtons,int[]())
#define MOVE_FORWARD_BUTTONS ( ACT(MoveForward) + ACT(MoveFastForward) + ACT(MoveSlowForward) )

//movement actions 
macro_func(widget_getAllMoveButtons,int[]())
#define CAN_MOVE_BUTTONS (ACT(MoveForward) + ACT(MoveBack) + ACT(TurnLeft) + ACT(TurnRight) + \
 ACT(MoveFastForward) + ACT(MoveSlowForward) + ACT(turbo) + ACT(TurboToggle) + ACT(MoveLeft) + ACT(MoveRight) + ACT(GetOver))

macro_func(widget_getChangeStanceButtons,int[]())
#define CHANGE_STANCE_BUTTONS (ACT(AdjustUp) + ACT(AdjustDown) + ACT(Crouch) + ACT(Stand) + ACT(MoveUp) + ACT(MoveDown))
//прыжок на землю в беге
macro_func(widget_getFastDropButtons,int[]())
#define FAST_DROP_BUTTONS (ACT(Crouch) + ACT(MoveDown))
//защита от стрейфа тупых школьников
macro_func(widget_getSidewaysMovementButtons,int[]())
#define SIDEWAYS_MOVEMENT_BUTTONS (ACT(TurnLeft) + ACT(TurnRight))

