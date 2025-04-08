// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

//startpos: cpt2_pos_start

cpt2_json_allowedRecipes = '
[
    {
        "type": "system",
        "category": "Food",
        "options": {
        "craft_duration": "10"
        },
        "system_specific": "FryingPanSystem",
        "name": "Бибка",
        "required": {
        "components": [
            {
            "class": "Testo",
            "check_type_of": false
            },
            {
            "class": "Egg",
            "check_type_of": false
            }
        ]
        },
        "result": {
        "class": "Bun",
        "count": 1,
        "modifiers": [
            {
            "name": "set_name",
            "value": "Подгоревший пирожок"
            },
            "default"
        ]
        }
    },
    {
        "type": "system",
        "category": "Food",
        "options": {
        "craft_duration": "10"
        },
        "system_specific": "FryingPanSystem",
        "name": "Блинец",
        "required": {
        "components": [
            {
            "class": "Lepeshka",
            "check_type_of": false
            },
            {
            "class": "Egg"
            }
        ]
        },
        "result": {
        "class": "Pancakes",
        "modifiers": [
            {
            "name": "set_name",
            "value": "Подгоревший блинец"
            },
            "default"
        ]
        }
    }
]
';

//wait for gate open
["cpt2_begin",{
    ["cpt2_pos_start",0] call sp_setPlayerPos;

    //todo give inventory

    //load recipes
    [FromJSON cpt2_json_allowedRecipes] call csys_loadConfig;

    ["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	[false,3] call setBlackScreenGUI;
    {
        2.5 call sp_threadPause;
        _h = [
			"chap2\gg1",
			"chap2\gg2",
			"chap2\gg3"
		] call sp_audio_sayPlayerList;
		_h call sp_threadWaitForEnd;

        ["Все хвосты ведут домой","Откройте ворота"] call sp_setTaskMessageEff;

        1 call sp_threadPause;

        ["Для открытие автоматических дверей и ворот используются рычаги, кнопки и щитки. Перед вами один из таких примеров - старые ворота." +
        " Рядом с ними находится переключатель. Попробуйте активировать его, нажав ПКМ и выбрав пункт ""Открыть"", либо нажмите $input_act_mainAction нацелившись на него."] call sp_setNotification;

        {
            getVar("cpt2_obj_gate" call sp_getObject,isOpen)
        } call sp_threadWait;
        [false] call sp_setNotificationVisible;
        ["Все хвосты ведут домой","Идите через коллекторы"] call sp_setTaskMessageEff;
        0.7 call sp_threadPause;

        ["chap2\gg4"] call sp_audio_sayPlayer;
    } call sp_threadStart;
    
}] call sp_addScene;

["cpt2_trg_hungerevent",{
    hud_hunger = 15;
    private _mes = pick["Жрать охота..."];
    callFuncParams(call sp_getActor,localSay,_mes arg "mind");
    callFuncParams(call sp_getActor,playSound,"mob\hungry" + str randInt(1,4) arg getRandomPitch);
    {
        0.5 call sp_threadPause;
        ["chap2\gg5"] call sp_audio_sayPlayer;
        
        ["Все хвосты ведут домой","Утолите свой голод"] call sp_setTaskMessageEff;

        _h = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["hunger",_w];
            _w
        }] call sp_createWidgetHighlight;
        _notifHandle = ["Со временем вы начинаете испытывать голод. Большая нагрузка и интенсивные движения быстрее приведут к голоданию. "+
        "Если своевременно не употреблять пищу - вы упадете в голодный обморок."] call sp_setNotification;
        10 call sp_threadPause;
        refset(_h,true);
        [false,_notifHandle] call sp_setNotificationVisible;
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_foundkitchen",{
    {
        ["Вы нашли кухню. Здесь вы можете приготовить немного еды. Для начала подожгите огонь печи, нажав ЛКМ по ней с факелом в руке"] call sp_setNotification;
        {
            getVar("cpt2_obj_stove" call sp_getObject,lightIsEnabled)
        } call sp_threadWait;
        1 call sp_threadPause;

        ["Теперь нажмите ПКМ по сковороде на бетонном столе и выберите пункт ""Вспомнить рецепты"". В появившемся окне нажмите на желаемый рецепт, чтобы посмотреть необходимые ингредиенты."] call sp_setNotification;
        
        ["activate_verb",{
            params ["_t","_name"];
            if (_name == "craft_here" && equals("cpt2_obj_frypan" call sp_getObject,_t)) then {
                call sp_removeCurrentPlayerHandler;
                ["open_craft_on_frypan",true] call sp_storageSet;
            };
            false
        }] call sp_addPlayerHandler;

        {
            (["open_craft_on_frypan",false] call sp_storageGet)
            && {craft_isMenuOpen}
        } call sp_threadWait;
        
        [false] call sp_setNotificationVisible;
        {
            !craft_isMenuOpen;
        } call sp_threadWait;

        ["Возьмите сковороду и поставьте её на печь. Затем возьмите с полок необходимые ингредиенты и выложите их на сковороде. Если вы сделаете всё правильно, то блюдо начнёт готовиться."] call sp_setNotification;
        _h = ["click_target",{
            params ["_t"];
            if (
                isTypeOf(_t,Debris)
                || equals(_t,"cpt2_obj_frypan" call sp_getObject)
            ) exitWith {true};
            false
        }] call sp_addPlayerHandler;

        {
            _nitms = callFuncParams("cpt2_obj_stove" call sp_getObject,getNearObjects,"Debris" arg 3 arg true arg true);
            any_of(_nitms apply {"блюдо" in (tolower getVar(_x,name)) || isTypeOf(_x,OrganicDebris1)})
        } call sp_threadWait;

        ["Теперь подождите некоторое время пока блюдо будет готово"] call sp_setNotification;

        {
            _nitms = callFuncParams("cpt2_obj_stove" call sp_getObject,getNearObjects,"IFoodItem" arg 3 arg true arg true);
            any_of(_nitms apply {callFunc(_x,getClassName) == "Pancakes" || callFunc(_x,getClassName) == "Bun"})
        } call sp_threadWait;
        _h call sp_removePlayerHandler;

        ["Заберите приготовленное со сковороды. "+
        "Чтобы съесть какую-либо еду откройте инвентарь, выберите область взаимодействия ""Рот"" и затем нажмите по зоне ""Моя персона"" над слотами инвентаря. "+
        "Еда при этом должна находиться в активной руке."] call sp_setNotification;
        _hClick = ["click_self",{
            params ["_item"];
            if (callFunc(_item,isFood)) then {
                call sp_removeCurrentPlayerHandler;
                //consumed food
                hud_hunger = 100;
            };
            false
        }] call sp_addPlayerHandler;

        _h = [{
            _wid = widgetNull;
            {
                if equals(ctrltext _x,"Рот") exitWith {_wid = _x};
            } foreach interactMenu_selectionWidgets;
            _wid
        }] call sp_createWidgetHighlight;
        {
            equals(getVar(call sp_getActor,curTargZone),TARGET_ZONE_MOUTH)
        } call sp_threadWait;
        refset(_h,true);

        _h = [{
            inventory_selfWidgets select 0
        }] call sp_createWidgetHighlight;

        {
            !(_hClick call sp_isValidPlayerHandler)
        } call sp_threadWait;
        refset(_h,true);

        [false] call sp_setNotificationVisible;
        ["cpt2_roadtomedicine"] call sp_startScene;
    } call sp_threadStart
    
}] call sp_addScene;


["cpt2_roadtomedicine",{
    ["Все хвосты ведут домой","Идите через коллекторы"] call sp_setTaskMessageEff;
    //delete wall
    _wall = "cpt2_obj_kol_wallbeforecooking" call sp_getObject;
    if !isNullReference(_wall) then {
        [_wall] call deleteGameObject;
    };
    {
        _obj = "cpt2_obj_pressVTrgObj" call sp_getObject;
        {
            callFuncParams(_obj,getDistanceTo,call sp_getActor arg true) <= 1.5
        } call sp_threadWait;
        _notif = ["Чтобы перешагнуть через препятствие нажмите @GetOver"] call sp_setNotification;
        _h = ["getover",{
            call sp_removeCurrentPlayerHandler;
            false
        }] call sp_addPlayerHandler;

        {!(_h call sp_isValidPlayerHandler)} call sp_threadWait;

        [false,_notif] call sp_setNotificationVisible;
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_rememberX",{
    {
        _rememberTime = tickTime + 10;
        {
            callFunc(call sp_getActor,getStance) <= STANCE_MIDDLE
            || (tickTime >= _rememberTime)
        } call sp_threadWait;
        if (tickTime >= _rememberTime) then {
            ["Чтобы пригнуться нажмите @MoveUp"] call sp_setNotification;
            {
                callFunc(call sp_getActor,getStance) <= STANCE_MIDDLE
            } call sp_threadWait;
            [false] call sp_setNotificationVisible;
        };
        
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_foundmedicine",{
    _obj = "cpt2_obj_medcab" call sp_getObject;
    _st = [];
    _o = ["PainkillerBox",_obj] call createItemInContainer;
    _st pushBack _o;
    setVar(_o,pillCount,3);
    setVar(_o,name,"Помятая коробка таблеток");
    setVar(_o,desc,"Похоже на обезболивающее...");

    _o = ["Bandage",_obj] call createItemInContainer;
    _st pushBack _o;
    setVar(_o,name,"Старый бинт");
    setVar(_o,desc,"Для остановки слабых ран сойдёт.");

    ["medicine_for_guide",_st] call sp_storageSet;

    {
        _hinf = ["Вы можете хранить в караманах своей одежды несколько предметов. Попробуйте вытащить из медицинского шкафа всё что найдёте. "+
        "Чтобы посмотреть содержимое шкафа нажмите $input_act_mainAction (либо через ПКМ-меню по предмету) и перетащите предмет из него себе в свободную руку. "+
        "Затем, чтобы убрать предмет в карман - перетащите его на иконку одежды, либо нажав по одежде с предметом в руке."]
            call sp_setNotification;

        _tobjnext = "cpt2_trg_shifting" call sp_getTriggerByName;
        {
            _meds = (["medicine_for_guide",[]] call sp_storageGet) apply {equals(callFunc(_x,getSourceLoc),call sp_getActor)};
            all_of(_meds) 
            || callFuncParams(_tobjnext,getDistanceTo,call sp_getActor arg true) <= 6
        } call sp_threadWait;

        [false,_hinf] call sp_setNotificationVisible;
        
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_shifting",{
    {
        _hinf = ["Для быстрого бега вместе с кнопками передвижения удерживайте @turbo"+
        sbr+"Обратите внимание, что постоянный бег приводит к быстрому голоданию и расходу выносливости."] call sp_setNotification;
        _tNext = tickTime + 10;
        {
            callFunc(call sp_getActor,isSprinting)
            || tickTime >= _tNext
        } call sp_threadWait;

        [false,_hinf] call sp_setNotificationVisible;
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_prefalling",{
    {
        _boards = "cpt2_obj_rottenboards" call sp_getObject;
        if isNullReference(_boards) then {
            _boards = "cpt2_trg_breakboards" call sp_getTriggerByName;
        };
        if isNullReference(_boards) exitWith {
            setLastError("Not found debug object");
        };
        _bZFall = callFunc(_boards,getPos) select 2;
        modvar(_bZFall) - 1; //!zpos offset
        {
            (callFunc(call sp_getActor,getPos) select 2) <= _bZFall
        } call sp_threadWait;

        ["cpt2_trg_onfall"] call sp_startScene;
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_breakboards",{
    _boards = "cpt2_obj_rottenboards" call sp_getObject;
    _trg = "cpt2_trg_breakboards" call sp_getTriggerByName;
    _worldPos = callFunc(_trg,getPos) vectorAdd [0,0,0.3];
    _eff = true;
    _snd = true;
    _isblock = false;

    [0.5,3.5,.05,0.8] call cam_addCamShake;

    callFuncParams(_boards,sendDamageVisualOnPos,_worldPos arg _eff arg _snd arg _isblock);

    if !isNullReference(_boards) then {
        [_boards] call deleteStructure;
    };

    _snd = false;
    for "_i" from 1 to 3 do {
        private _wpos = _worldPos vectoradd [rand(-0.5,0.5),rand(-0.5,0.5),0];
        callFuncParams(_boards,sendDamageVisualOnPos,_wpos arg _eff arg _snd arg _isblock);
    };

    //pieces
    for "_i" from 1 to 6 do {
        private _wpos = _worldPos vectoradd [rand(-0.8,0.8),rand(-0.8,0.8),0];
        _w = ["WoodenDebris" + (str randInt(3,4)),_wpos vectoradd [0,0,-1],null,true] call createItemInWorld;
    };
    
}] call sp_addScene;

["cpt2_trg_onfall",{
    
    callFuncParams(call sp_getActor,playSound, "agony\falling_down_scream2" arg getRandomPitchInRange(0.85,1.2));

    callFuncParams(call sp_getActor,setUnconscious,5);
    ["cpt2_pos_falling",0] call sp_setPlayerPos;
    callFuncParams(call sp_getActor,playSound,"mob\fallsmash" arg getRandomPitchInRange(0.8,1.3) arg null arg 2.2);
    
    //best anim
    player switchMove "acts_staticdeath_10";

    hud_pain = 3;
    {
        {
            !callFunc(call sp_getActor,isUnconscious)
        } call sp_threadWait;

        1.5 call sp_threadPause;

        ["chap2\gg6"] call sp_audio_sayPlayer;

        ["Вы получили урон от падения и испытываете умеренную боль. Достаньте упаковку обезболивающего из вашего инвентаря. "+
        sbr+sbr+"Чтобы достать таблетку из коробки нажмите по ней пустой рукой $input_act_mainAction, либо через ПКМ-меню"] call sp_setNotification;

        _hpain = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["pain",_w];
            _w
        }] call sp_createWidgetHighlight;

        {
            _probPill = callFunc(call sp_getActor,getItemInActiveHandRedirect);
            if isNullReference(_probPill) exitWith {false};
            isTypeOf(_probPill,Pill)
        } call sp_threadWait;

        ["Проглотите таблетку. Не забудьте - для употребления нужно выбрать ""Рот"" и нажать с таблеткой в руке по ""Моя персона"" над слотами инвентаря."] call sp_setNotification;

        _hClick = ["click_self",{
            params ["_item"];
            if (isTypeOf(_item,Pill)) then {
                call sp_removeCurrentPlayerHandler;
                //consumed food
                hud_pain = 0;
            };
            false
        }] call sp_addPlayerHandler;


        {
            !(_hClick call sp_isValidPlayerHandler)
        } call sp_threadWait;
        refset(_hpain,true);
        [false] call sp_setNotificationVisible;

    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_torchnotif",{
    _items = [call sp_getActor,"Torch",true] call getAllItemsInInventory;
    if (count _item == 0) then {
        {
            _h = ["Не забудьте взять свой факел."] call sp_setNotification;
            5 call sp_threadPause;
            [false,_h] call sp_setNotificationVisible;
        } call sp_threadStart;
    };
}] call sp_addScene;

["cpt2_trg_kol_insidehole",{
    //temorary for tests
}] call sp_addScene;

["cpt2_trg_tragdamage",{
    {
        _trap = "cpt2_obj_trap1" call sp_getObject;
        [0.5,3.5,.05,0.5] call cam_addCamShake;
        ["chap2\gg7"] call sp_audio_sayPlayer;
        
        callFunc(call sp_getActor,doMoan);

        hud_bleeding = 5;
        _hbleeding = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["bleeding",_w];
            _w
        }] call sp_createWidgetHighlight;
        

        ["Вы попали в капкан и получили кровоточащую рану. Достаньте бинт и наложите его на правую ногу. Выберите правую ногу в области взаимодействия и нажмите с бинтом в руке по ""Моей персоне""."] call sp_setNotification;

        _hlegWid = [{
            _wid = widgetNull;
            {
                if equals(ctrltext _x,"Правая нога") exitWith {_wid = _x};
            } foreach interactMenu_selectionWidgets;
            _wid
        }] call sp_createWidgetHighlight;

        // _hClick = ["click_self",{
        //     params ["_item"];
        //     if (isTypeOf(_item,Bandage)) then {
        //         call sp_removeCurrentPlayerHandler;
        //         //consumed food
        //         hud_bleeding = 0;
        //     };
        //     false
        // }] call sp_addPlayerHandler;

        // {
        //     !(_hClick call sp_isValidPlayerHandler)
        // } call sp_threadWait;
        {
            callFunc(callFuncParams(call sp_getActor,getPart,BP_INDEX_LEG_R),isBandaged)
        } call sp_threadWait;


        refset(_hbleeding,true);
        refset(_hlegWid,true);
        [false] call sp_setNotificationVisible;
    } call sp_threadStart;

}] call sp_addScene;

//restore methods
cpt2_restoreTrapMethods = {
    private _methods = ["trap_default_methods",[]] call sp_storageGet;
    if (count _methods == 0) exitWith {
        setLastError("Methods count is zero. Cant restore");
    };
    _trap = "cpt2_obj_traplearn" call sp_getObject;
    [callFunc(_trap,getClassName),"onChangeTrapState",_methods select 0,"replace"] call oop_injectToMethod;
    [callFunc(_trap,getClassName),"damageProcess",_methods select 1,"replace"] call oop_injectToMethod;
};

["cpt2_trg_traplearn",{
    {
        _trap = "cpt2_obj_traplearn" call sp_getObject;
        callFuncAfterParams(_trap,setTrapEnable,0.1,true);
        ["chap2\gg8"] call sp_audio_sayPlayer;

        //save prev methods
        ["trap_default_methods",
            [getFunc(_trap,onChangeTrapState),getFunc(_trap,damageProcess)]
        ] call sp_storageSet;

        [callFunc(_trap,getClassName),"onChangeTrapState",{
            objParams_1(_usr);
            private _prevstate = callSelf(isTrapEnabled);

            if (!_prevstate) exitWith {
                callFuncParams(_usr,mindSay,"Не умею заряжать...");
            };

            callSelfParams(setTrapEnable,!_prevstate);

            if (_prevstate) then {
                ["unlocked_trap",true] call sp_storageSet;
                callFuncParams(_usr,meSay,"разряжает " + callSelfParams(getNameFor,_usr));
            };
        },"replace"] call oop_injectToMethod;
        [callFunc(_trap,getClassName),"damageProcess",{
            objParams_2(_usr,_part);
            
            [true,0.0001] call setBlackScreenGUI;
            ["cpt2_pos_onfailtrap",0] call sp_setPlayerPos;
            _post = { [false,0.5] call setBlackScreenGUI; };
            invokeAfterDelay(_post,0.5);

            callFuncAfterParams(this,setTrapEnable,0.5,true);
        },"replace"] call oop_injectToMethod;

        ["chap2\gg8"] call sp_audio_sayPlayer;
        
        ["unlocked_trap",false] call sp_storageSet;
        ["failed_trap",false] call sp_storageSet;

        ["Вы можете обезвреживать капканы при достаточных навыках. Для этого подойдите к ловушке и нажмите $input_act_mainAction (либо через ПКМ-меню)."+
        " Обратите внимание, что заряженную ловушку не стоит пытаться поднять, если вам дороги ваши руки."] call sp_setNotification;

        {
            ["unlocked_trap",false] call sp_storageGet;
        } call sp_threadWait;

        [false] call sp_setNotificationVisible;

    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_end",{
    [""] call sp_view_setPlayerHudVisible;
    [true] call sp_setHideTaskMessageCtg;
	[true,1.1] call setBlackScreenGUI;
    {
        3 call sp_threadPause;
        ["cpt3_begin"] call sp_startScene;
    } call sp_threadStart;
}] call sp_addScene;

//cpt2_obj_medcab - medical cab
//cpt2_obj_invval_ongetmed - invwall on get medicine
//cpt2_obj_cellbeforefall - решетка дверь перед падением вниз
//cpt2_obj_rottenboards -rotten boards ref

//cpt2_trg_kol_insidehole - trigger on enter inside hole

//cpt2_obj_doorfinal --final door

/*
anims:
Acts_JetsMarshallingStop_loop - new handsup anim
Acts_JetsMarshallingEmergencyStop_loop - лось
Acts_JetsMarshallingClear_loop - приветствие

ApanPercMstpSnonWnonDnon_G01
ApanPercMstpSnonWnonDnon_G02
ApanPercMstpSnonWnonDnon_G03
*/