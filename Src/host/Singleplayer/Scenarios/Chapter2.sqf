// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

//startpos: cpt2_pos_start

cpt2_craftDuration = 15;
cpt2_json_allowedRecipes = '
[
    {
        "type": "system",
        "category": "Food",
        "options": {
        "craft_duration": "'+str cpt2_craftDuration+'"
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
            "craft_duration": "'+str cpt2_craftDuration+'"
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

cpt2_data_healingSkill = 5;

cpt2_defaultHud = "chat+right+stats+cursor+inv";
cpt2_defaultHudWithStamina = cpt2_defaultHud + "+stam";

cpt2_canClickByFood = false;

//хандлер поедания
cpt2_fnc_clickself_ItemCheck = {
    if isTypeOf(_this,Pill) exitWith {true};

    if (isTypeOf(_this,IFoodItem)) exitWith {
        if ((isTypeOf(_this,Bun) || isTypeOf(_this,Pancakes)) 
            && getVar(call sp_getActor,curTargZone) == TARGET_ZONE_MOUTH
            && callFuncParams(call sp_getActor,isEmptySlot,INV_FACE)
        ) exitWith {
            true
        };

        if (getVar(call sp_getActor,curTargZone) == TARGET_ZONE_MOUTH) then {
            [
                pick["Это не готово","Лучше сначала приготовить","Это надо готовить.","Не стоит есть сырым"]
                ,"mind"
            ] call chatPrint;
        };
        
        false;
    };
    true
};

cpt2_fnc_canPickupItem = {
    //check intermediate food
    if ("блюдо" in (tolower getVar(_this,name)) || isTypeOf(_this,OrganicDebris1)) exitWith {
        //this duplicate message (main from sp_initializeDefaultPlayerHandlers)
        //["Надо подождать пока приготовится...","mind"] call chatPrint;
        false
    };
    true
};

cpt2_data_listTorches = [];

cpt2_act_internal_printMessageOnTorch = {
    params [["_isDisAct",true]];
    private _list = if(_isDisAct) then {
        [
            "Глупо тушить свой факел сейчас...",
            "Без света я здесь долго не протяну.",
            "Я не буду тушить факел - это глупо.",
            "Нет необходимости тушить факел..."
        ]
    } else {
        [
            "Я не стану этого делать.",
            "Это может быть опасно.",
            "Так и до пожара довести получится.",
            "С этим лучше не играться."
        ]
    };

    [
        pick _list,"mind"
    ] call chatPrint;
};

cpt2_act_enableTorchHadnler = {
    cpt2_data_listTorches = [call sp_getActor,"Torch",true] call getAllItemsInInventory;
    //add torch handler
    ["main_action",{
        params ["_t"];
        if (array_exists(cpt2_data_listTorches,_t)) exitWith {
            [true] call cpt2_act_internal_printMessageOnTorch;
            true
        };
        false
    }] call sp_addPlayerHandler;
    ["activate_verb",{
		params ["_t","_name"];
		private _ret = false;
		if (_name == "mainact") then {
			if (array_exists(cpt2_data_listTorches,_t)) then {
				[true] call cpt2_act_internal_printMessageOnTorch;
				_ret = true;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

    ["interact_with",{
        params ["_item","_with"];
        if (array_exists(cpt2_data_listTorches,_with)) exitWith {
            [false] call cpt2_act_internal_printMessageOnTorch;
            true
        };
        false
    }] call sp_addPlayerHandler;

    ["click_target",{
        params ["_t"];
        if isNullReference(callFunc(call sp_getActor,getItemInActiveHandRedirect)) exitWith {false};
        
        if (
            callFunc(_t,isContainer)
            && {
                array_exists(cpt2_data_listTorches,callFunc(call sp_getActor,getItemInActiveHandRedirect))
            }
        ) exitWith {
            [false] call cpt2_act_internal_printMessageOnTorch;
            true
        };
        false
    }] call sp_addPlayerHandler;
};

cpt2_data_canUseSelections = false;

//wait for gate open
["cpt2_begin",{
    call sp_initializeDefaultPlayerHandlers;
    [call sp_getActor] call sp_loadCharacterData;
    [true,0] call setBlackScreenGUI;

    ["cpt2_pos_start",0] call sp_setPlayerPos;

    if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		[cpt1_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
	};

    if (!callFuncParams(call sp_getActor,hasItem,"Torch" arg true)) then {
		["Torch",call sp_getActor] call createItemInInventory;
	};

    //enable torch handler
    call cpt2_act_enableTorchHadnler;

    [sp_const_list_stdPlayerHandlers,false] call sp_setLockPlayerHandler;
    
    call cpt1_act_addMapViewHandler;

    //add feed locking handler
    ["click_self",{
        params ["_t"];
        _canuse = _t call cpt2_fnc_clickself_ItemCheck;
        !_canuse
    }] call sp_addPlayerHandler;


    ["click_self",{
        params ["_t"];
        if (isTypeOf(_t,Knife)) exitWith {
            _m = pick[
                "Я не буду себя резать.",
                "Что я творю?",
                "Это глупо.",
                "В этом нет необходимости.",
                "Зачем мне резать себя?",
                "Я не хочу это делать."
            ];
            callFuncParams(call sp_getActor,mindSay,_m);
            true
        };
        false
    }] call sp_addPlayerHandler;


    [{
        params ["_t","_wid"];
        false
    },null,{
		params ["_t","_wid"];
        if (!cpt2_data_canUseSelections) exitWith {false};
        array_exists(interactMenu_selectionWidgets,_wid)
	}] call sp_gui_setInventoryVisibleHandler;

    //add non-ready dish pickup handler
    sp_delegateCanClickItem = cpt2_fnc_canPickupItem;

    //save and increase healing
    cpt2_data_healingSkill = getVar(call sp_getActor,healing);
    setVar(call sp_getActor,healing,17);

    //load recipes
    [FromJSON cpt2_json_allowedRecipes] call csys_loadConfig;

    [cpt2_defaultHud] call sp_view_setPlayerHudVisible;
	[false,3] call setBlackScreenGUI;

    _hlist = [];
    _hlist pushBack (["main_action",{
        params ["_t"];
        if isTypeOf(_t,PowerSwitcherBig_Activator) exitWith {true};
        false
    }] call sp_addPlayerHandler);
    _hlist pushBack (["activate_verb",{
        params ["_t","_name"];
        if (_name == "mainact" && isTypeOf(_t,PowerSwitcherBig_Activator)) exitWith {true};
        false
    }] call sp_addPlayerHandler);
    ["cpt2_data_handlerLockPowerSwitcher",_hlist] call sp_storageSet;

    {
        2.5 call sp_threadPause;
        _h = [
			"chap2\gg1",
			"chap2\gg2",
			"chap2\gg3"
		] call sp_audio_sayPlayerList;
		_h call sp_threadWaitForEnd;

        {
            _hlist = ["cpt2_data_handlerLockPowerSwitcher",[]] call sp_storageGet;
            {
                _x call sp_removePlayerHandler;
            } foreach _hlist;
        } call sp_threadCriticalSection;

        ["Темные стоки","Откройте ворота"] call sp_setTaskMessageEff;

        1 call sp_threadPause;

        ["Автоматические двери и ворота открываются с помощью #(рычагов) и #(кнопок). Рядом с воротами - #(переключатель). Активируйте его, нажав ПКМ и выбрав ""Нажать"" или нажмите $input_act_mainAction."] call sp_setNotification;

        {
            getVar("cpt2_obj_gate" call sp_getObject,isOpen)
        } call sp_threadWait;

        [false] call sp_setNotificationVisible;
        ["Темные стоки","Идите через коллекторы"] call sp_setTaskMessageEff;
        0.7 call sp_threadPause;

        ["chap2\gg4"] call sp_audio_sayPlayer;
    } call sp_threadStart;
    
}] call sp_addScene;

["cpt2_trg_enterkollectors",{
    ["kollectors",true] call sp_audio_playMusic;
}] call sp_addScene;

["cpt2_trg_hungerevent",{
    hud_hunger = 15;
    private _mes = pick["Жрать охота..."];
    callFuncParams(call sp_getActor,localSay,_mes arg "mind");
    callFuncParams(call sp_getActor,playSound,"mob\hungry" + str randInt(1,4) arg getRandomPitch);
    {
        2 call sp_threadPause;
        ["chap2\gg5"] call sp_audio_sayPlayer;
        
        ["Темные стоки","Утолите свой голод"] call sp_setTaskMessageEff;

        _h = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["hunger",_w];
            _w
        }] call sp_createWidgetHighlight;
        _notifHandle = ["Со временем вы начинаете испытывать #(голод). Нагрузка и интенсивные движения ускоряют голодание. Если не будете питаться - упадёте #(в обморок)."] call sp_setNotification;
        10 call sp_threadPause;
        refset(_h,true);
        [false,_notifHandle] call sp_setNotificationVisible;
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_foundkitchen",{
    {
        sp_allowebVerbs append ["craft","craft_here"];

        ["Вы нашли кухню. Здесь вы можете приготовить немного еды. Зажгите огонь #(печи), нажав ЛКМ по ней с факелом в руке"] call sp_setNotification;
        {
            getVar("cpt2_obj_stove" call sp_getObject,lightIsEnabled)
        } call sp_threadWait;

        ["cpt2_data_canstart_cooking",false] call sp_storageSet;
        {
            while {!(["cpt2_data_canstart_cooking",false] call sp_storageGet)} do {
                _frypan = "cpt2_obj_frypan" call sp_getObject;
                if !isNullReference(_frypan) then {
                    getVar(_frypan,craftComponent) setv(procStage,0);
                };
                0.1 call sp_threadPause;
            };
        } call sp_threadStart;
        1 call sp_threadPause;

        ["Нажмите ПКМ по #(сковороде) и выберите #(""Вспомнить рецепты""). В окне выберите рецепт для просмотра #(ингредиентов)."] call sp_setNotification;
        
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
        
        ["cpt2_data_canstart_cooking",true] call sp_storageSet;

        ["Возьмите #(сковороду) и поставьте на #(печь). Добавьте #(ингредиенты) с полок на сковороду и #(блюдо) начнёт готовиться."] call sp_setNotification;
        _h = ["click_target",{
            params ["_t"];
            if (
                isTypeOf(_t,Debris)
                || equals(_t,"cpt2_obj_frypan" call sp_getObject)
            ) exitWith {
                false
            };
            false
        }] call sp_addPlayerHandler;


        {
            _nitms = callFuncParams("cpt2_obj_stove" call sp_getObject,getNearObjects,"Debris" arg 3 arg true arg true);
            any_of(_nitms apply {"блюдо" in (tolower getVar(_x,name)) || isTypeOf(_x,OrganicDebris1)})
        } call sp_threadWait;

        ["Подождите пока #(блюдо) приготовится."] call sp_setNotification;

        {
            //хандлеры защиты поднятия сковороды во время готовки
            _hlockfpan_list = [
                ["click_target",{
                    params ["_t"];
                    if (isTypeOf(_t,FryingPan)) exitWith {
                        ["Надо доготовить.","error"] call chatPrint;
                        true
                    };
                    false
                }] call sp_addPlayerHandler,
                ["activate_verb",{
                    params ["_t","_name"];
                    private _ret = false;
                    if (_name == "mainact" && isTypeOf(_t,SmallStoveGrill)) exitWith {
                        ["Надо доготовить.","error"] call chatPrint;
                        true
                    };
                    if (_name == "pickup") then {
                        if (isTypeOf(_t,FryingPan) || isTypeOf(_t,OrganicDebris1)) then {
                            ["Надо доготовить.","error"] call chatPrint;
                            _ret = true;
                        };
                    };
                    _ret
                }] call sp_addPlayerHandler
            ];

            _hlockfpan_list pushBack (["main_action",{
                params ["_t"];
                if (isTypeOf(_t,SmallStoveGrill)) exitWith {
                    ["Надо доготовить.","error"] call chatPrint;
                    true
                };
                false
            }] call sp_addPlayerHandler);

        } call sp_threadCriticalSection;

        {
            _nitms = callFuncParams("cpt2_obj_stove" call sp_getObject,getNearObjects,"IFoodItem" arg 3 arg true arg true);
            any_of(_nitms apply {callFunc(_x,getClassName) == "Pancakes" || callFunc(_x,getClassName) == "Bun"})
        } call sp_threadWait;
        _h call sp_removePlayerHandler;

        {    
            cpt2_data_canUseSelections = true;
            call sp_gui_syncInventoryVisible; //for activate selection group on opened inventory
        } call sp_threadCriticalSection;

        ["Заберите #(блюдо) со сковороды. Чтобы съесть #(еду): откройте инвентарь, выберите #(Рот) в области взаимодействия и нажмите по #(Моей персоне) с едой в #(активной руке)."] call sp_setNotification;

        _hClick = ["click_self",{
            params ["_item"];
            if ((isTypeOf(_item,Bun) || isTypeOf(_item,Pancakes)) && getVar(call sp_getActor,curTargZone) == TARGET_ZONE_MOUTH && callFuncParams(call sp_getActor,isEmptySlot,INV_FACE)) then {
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
        {
            ["cpt2_roadtomedicine"] call sp_startScene;
        } call sp_threadCriticalSection;

        {callFuncParams("cpt2_obj_stove" call sp_getObject,getDistanceTo,call sp_getActor arg true) >= 10} call sp_threadWait;
        {
            {
                _x call sp_removePlayerHandler;
            } foreach _hlockfpan_list;
        } call sp_threadCriticalSection;
    } call sp_threadStart
    
}] call sp_addScene;


["cpt2_roadtomedicine",{
    ["Темные стоки","Доберитесь до города"] call sp_setTaskMessageEff;
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
            false
        }] call sp_addPlayerHandler;
        ["cpt2_data_handlerGetOver_notif",[_h,_notif]] call sp_storageSet;
        
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_removeGetOverHandler",{
    (["cpt2_data_handlerGetOver_notif",[null,null]] call sp_storageGet) params ["_h","_notif"];
    _h call sp_removePlayerHandler;
    [false,_notif] call sp_setNotificationVisible;
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
    cpt2_data_bandageRefList pushBack _o;
    _st pushBack _o;
    setVar(_o,name,"Старый бинт");
    setVar(_o,desc,"Для остановки слабых ран сойдёт.");

    _hmain = ["main_action",{
        params ["_t"];
        if isTypeOf(_t,PainkillerBox) exitWith {
            callFuncParams(call sp_getActor,mindSay,"Не стоит сейчас это делать.");
            true
        };
        false
    }] call sp_addPlayerHandler;
    ["cpt2_data_handlerPainkillerLocker",_hmain] call sp_storageSet;


    ["medicine_for_guide",_st] call sp_storageSet;

    {
        _hinf = ["Вы можете носить предметы в карманах своей одежды. Попробуйте достать что-то из #(медицинского шкафа). "+
        "Для этого нажмите $input_act_mainAction (либо через ПКМ-меню). "+
        "Перетащите предмет в руку и уберите в карман, перетянув его на иконку #(одежды) в инвентаре, либо нажав по ЛКМ по ней. Для осмотра своих карманов используйте $input_act_mainAction или ПКМ-меню."]
            call sp_setNotification;

        _tobjnext = "cpt2_trg_shifting" call sp_getTriggerByName;
        if !isNullReference(_tobjnext) then {
            {
                _meds = (["medicine_for_guide",[]] call sp_storageGet) apply {equals(callFunc(_x,getSourceLoc),call sp_getActor)};
                all_of(_meds) 
                || callFuncParams(_tobjnext,getDistanceTo,call sp_getActor arg true) <= 6
            } call sp_threadWait;
        };        

        [false,_hinf] call sp_setNotificationVisible;
        
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_shifting",{
    [true] call sp_setPlayerSprintAllowed;
    [cpt2_defaultHudWithStamina] call sp_view_setPlayerHudVisible;

    {
        _hinf = ["Для #(быстрого бега) вместе с кнопками передвижения удерживайте @turbo ."+
        "Постоянный бег приводит к #(быстрому голоданию) и расходу #(выносливости)."] call sp_setNotification;
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

        {
            ["cpt2_trg_onfall"] call sp_startScene;
        } call sp_threadCriticalSection;
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

cpt2_data_pillMessage = "Достаньте упаковку #(обезболивающего) из вашего инвентаря.";
["cpt2_trg_onfall",{
    
    [] call sp_audio_stopMusic;

    callFuncParams(call sp_getActor,playSound, "agony\falling_down_scream2" arg getRandomPitchInRange(0.85,1.2));

    callFuncParams(call sp_getActor,setUnconscious,5);
    ["cpt2_pos_falling",0] call sp_setPlayerPos;
    callFuncParams(call sp_getActor,playSound,"mob\fallsmash" arg getRandomPitchInRange(0.8,1.3) arg null arg 2.2);
    
    //best anim
    player switchMove "acts_staticdeath_10";

    {
        if (
            (count ([call sp_getActor,"PainkillerBox"] call getAllItemsInInventory) == 0)
            && (count (["PainkillerBox",callFunc(call sp_getActor,getPos),2,true] call getAllItemsOnPosition) == 0)
        ) then {
            _pboxpos = callFunc("cpt2_pos_pillbox" call sp_getObject,getPos);
            _pbox = ["PainkillerBox",_pboxpos] call createItemInWorld;
            setVar(_pbox,pillCount,2);
            cpt2_data_pillMessage = "Подберите упаковку #(обезболивающего) на земле.";
        };
    } call sp_threadCriticalSection;

    //thread teleport
    {
        while {hud_pain > 0} do {
            if (callFuncParams("cpt2_pos_falling" call sp_getObject,getDistanceTo,call sp_getActor arg true) >= 5) then {
                sp_playerCanMove = false;
                [true,0.8] call sp_gui_setBlackScreenGUI;
                _d = getGUI;
                _t = widgetNull;
                {
                    _sizeX = 100;
                    _sizeY = 60;
                    _t = [_d,TEXT,[0,50-(_sizeY/2) + 20,_sizeX,_sizeY]] call createWidget;
                    [_t,format["<t align='center' valign='middle' color='#781f4d' size='1.7' font='Ringbear'>%1</t>",pick[
                        "С такой болью я далеко не уйду...",
                        "Мне слишком больно..."
                    ]]] call widgetSetText;
                    widgetSetFade(_t,1,0);
                    widgetSetFade(_t,0,1);
                } call sp_threadCriticalSection;
                
                ["cpt2_pos_falling",0] call sp_setPlayerPos;
                4 call sp_threadPause;
                widgetSetFade(_t,1,1);
                [false,1] call sp_gui_setBlackScreenGUI;
                [_t] call deleteWidget;
                sp_playerCanMove = true;
            };
            0.1 call sp_threadPause;
        };
    } call sp_threadStart;

    //разрешаем доставание таблеток
    (["cpt2_data_handlerPainkillerLocker",null] call sp_storageGet) call sp_removePlayerHandler;

    hud_pain = 3;
    {
        {
            !callFunc(call sp_getActor,isUnconscious)
        } call sp_threadWait;

        _thdDamaged = {
            while {true} do {
                [20,true] call sp_applyPlayerDamage;
                0.5 call sp_threadPause;
            };
        } call sp_threadStart;

        1.5 call sp_threadPause;

        //fix offset on broken boards
        private _offsetSound = ifcheck(!isNullReference("cpt2_obj_rottenboards" call sp_getObject),2.7,0);
        ["chap2\gg6",null,_offsetSound] call sp_audio_sayPlayer;
        private _mes = cpt2_data_pillMessage;
        ["Вы получили урон от падения и испытываете умеренную #(боль). "+_mes+" "+
        sbr+sbr+"Чтобы достать #(таблетку) из коробки нажмите по ней пустой рукой $input_act_mainAction, либо через ПКМ-меню."] call sp_setNotification;

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

        ["Проглотите #(таблетку). Не забудьте - для употребления нужно выбрать #(""Рот"") в области взаимодействия и нажать по #(""Моей персоне"") над слотами инвентаря."] call sp_setNotification;

        _hClick = ["click_self",{
            params ["_item"];
            if (isTypeOf(_item,Pill) && getVar(call sp_getActor,curTargZone) == TARGET_ZONE_MOUTH && callFuncParams(call sp_getActor,isEmptySlot,INV_FACE)) then {
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
        [_thdDamaged] call sp_threadStop;
        [false] call sp_setNotificationVisible;

    } call sp_threadStart;
}] call sp_addScene;

["cpt2_trg_torchnotif",{
    _items = [call sp_getActor,"Torch",true] call getAllItemsInInventory;
    if (count _items == 0) then {
        {
            _h = ["Не забудьте взять свой #(факел)."] call sp_setNotification;
            5 call sp_threadPause;
            [false,_h] call sp_setNotificationVisible;
        } call sp_threadStart;
    };
}] call sp_addScene;

["cpt2_trg_kol_insidehole",{
    //temorary for tests
    _trap = "cpt2_obj_trap1" call sp_getObject;
    _pos = callFunc(_trap,getPos);
    callFuncParams(_trap,changePosition,_pos vectoradd vec3(0,0,-10));
}] call sp_addScene;

["cpt2_trg_kol_underenter",{
    ["eff1"] call sp_audio_playMusic;
}] call sp_addScene;

cpt2_data_bandageRefList = [];

["cpt2_trg_tragdamage",{

    // защита от активации первого капкана
    ["main_action",{
        params ["_t"];
        if equals(_t,"cpt2_obj_trap1" call sp_getObject) exitWith {true};
        false
    }] call sp_addPlayerHandler;

    ["activate_verb",{
        params ["_t","_name"];
        if (_name == "mainact") exitWith {
            if equals(_t,"cpt2_obj_trap1" call sp_getObject) exitWith {true};
            false
        };
        false
    }] call sp_addPlayerHandler;

    {
        {
            _trap = "cpt2_obj_trap1" call sp_getObject;
            _pos = callFunc(_trap,getPos);
            callFuncParams(_trap,changePosition,_pos vectoradd vec3(0,0,10));
        } call sp_threadCriticalSection;

        //отключаем подбирание капкана
        ["click_target",{
            params ["_t"];
            if (
                equals(_t,"cpt2_obj_trap1" call sp_getObject)
                || {isTypeOf(_t,TrapEnabled) && {!callFunc(_t,isTrapEnabled)}}
            ) exitWith {
                callFuncParams(call sp_getActor,mindSay,"Больше я нему не притронусь...");
                true
            };
            false
        }] call sp_addPlayerHandler;
        ["main_action",{
            params ["_t"];
            if (
                equals(_t,"cpt2_obj_trap1" call sp_getObject)
                //|| {isTypeOf(_t,TrapEnabled) && {callFunc(_t,isTrapEnabled)}}
            ) exitWith {
                callFuncParams(call sp_getActor,mindSay,"Больше я нему не притронусь...");
                true
            };
            false
        }] call sp_addPlayerHandler;
        ["activate_verb",{
            params ["_t","_name"];
            if (
                ((equals(_t,"cpt2_obj_trap1" call sp_getObject))
                || {isTypeOf(_t,TrapEnabled) && {!callFunc(_t,isTrapEnabled)}}
                )
                && {_name in ["pickup","mainact"]}) exitWith {
                callFuncParams(call sp_getActor,mindSay,"Больше я нему не притронусь...");
                true
            };
            false
        }] call sp_addPlayerHandler;

        [0.5,3.5,.05,0.5] call cam_addCamShake;
        ["chap2\gg7"] call sp_audio_sayPlayer;
        
        callFunc(call sp_getActor,doMoan);
        
        sp_canRemoveCloth = true;

        hud_bleeding = 5;
        _hbleeding = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["bleeding",_w];
            _w
        }] call sp_createWidgetHighlight;
        
        private _mes = "Снимите свою одежду, перетащив её в слот свободной руки. Затем достаньте бинт из инвентаря.";
        {
            if (count ([call sp_getActor,"Bandage"] call getAllItemsInInventory) == 0
                && (count (["Bandage",callFunc(call sp_getActor,getPos),20,true] call getAllItemsOnPosition) == 0)
            ) then {
                _mes = "Снимите свою одежду, перетащив её в слот свободной руки. Затем подберите #(бинт) с земли рядом с вами.";
                _pos = callFunc("cpt2_pos_bandageobj" call sp_getObject,getPos);
                
                cpt2_data_bandageRefList pushBack (["Bandage",_pos] call createItemInWorld);
            };
        } call sp_threadCriticalSection;

        {
            while {hud_bleeding > 0} do {
                if (callFuncParams("cpt2_pos_revertbandagelocation" call sp_getObject,getDistanceTo,call sp_getActor arg true) >= 10) then {
                    sp_playerCanMove = false;
                    [true,0.8] call sp_gui_setBlackScreenGUI;
                    _d = getGUI;
                    _t = widgetNull;
                    {
                        _sizeX = 100;
                        _sizeY = 60;
                        _t = [_d,TEXT,[0,50-(_sizeY/2) + 20,_sizeX,_sizeY]] call createWidget;
                        [_t,format["<t align='center' valign='middle' color='#781f4d' size='1.7' font='Ringbear'>%1</t>",pick[
                            "Я не могу идти дальше в таком состоянии...",
                            "Я истеку кровью...",
                            "Кровотечение само не остановится..."
                        ]]] call widgetSetText;
                        widgetSetFade(_t,1,0);
                        widgetSetFade(_t,0,1);
                    } call sp_threadCriticalSection;
                    
                    ["cpt2_pos_revertbandagelocation",0] call sp_setPlayerPos;
                    4 call sp_threadPause;
                    widgetSetFade(_t,1,1);
                    [false,1] call sp_gui_setBlackScreenGUI;
                    sp_playerCanMove = true;

                    [_t] call deleteWidget;
                };
                0.1 call sp_threadPause;
            };
        } call sp_threadStart;

        ["Вы попали в капкан и получили #(кровоточащую рану). "+_mes+" Выберите #(правую ногу) в области взаимодействия и нажмите ЛКМ с бинтом в руке по ""Моей персоне""."] call sp_setNotification;

        _dmgHandle = {
            while {true} do {
                [20,true] call sp_applyPlayerDamage;
                1 call sp_threadPause;
            };
        } call sp_threadStart;

        _hlegWid = [{
            _wid = widgetNull;
            {
                if equals(ctrltext _x,"Правая нога") exitWith {_wid = _x};
            } foreach interactMenu_selectionWidgets;
            _wid
        }] call sp_createWidgetHighlight;

        _hClick = ["click_self",{
            params ["_item"];
            _r = false;
            if (isTypeOf(_item,Bandage)) then {
                if (getVar(call sp_getActor,curTargZone) != TARGET_ZONE_LEG_R) then {
                    _r = true;
                    ["Нужно бинтовать ПРАВУЮ НОГУ","error"] call chatPrint;
                };
            };
            _r
        }] call sp_addPlayerHandler;

        // {
        //     !(_hClick call sp_isValidPlayerHandler)
        // } call sp_threadWait;
        {
            hud_bleeding = 5;
            callFunc(callFuncParams(call sp_getActor,getPart,BP_INDEX_LEG_R),isBandaged)
        } call sp_threadWait;
        hud_bleeding = 0;
        _hClick call sp_removePlayerHandler;

        {
            private _legRef = callFuncParams(call sp_getActor,getPart,BP_INDEX_LEG_R);

        } call sp_threadCriticalSection;

        [_dmgHandle] call sp_threadStop;
        sp_canRemoveCloth = false;
        

        refset(_hbleeding,true);
        refset(_hlegWid,true);
        [false] call sp_setNotificationVisible;
    } call sp_threadStart;

}] call sp_addScene;

["cpt2_trg_nextmusicunderground",{
    ["eff2",false,true] call sp_audio_playMusic;
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

        ["Вы можете обезвреживать капканы при достаточном умении. Для этого подойдите к ловушке и нажмите $input_act_mainAction (либо через ПКМ-меню)."+
        " Не стоит пытаться поднимать заряженную ловушку, если вам дороги ваши руки."] call sp_setNotification;

        {
            ["unlocked_trap",false] call sp_storageGet;
        } call sp_threadWait;

        [false] call sp_setNotificationVisible;

    } call sp_threadStart;
}] call sp_addScene;

cpt2_trg_preend_act = false;
["cpt2_trg_preend",{
    if (cpt2_trg_preend_act) exitWith {};
    cpt2_trg_preend_act = true;
    [false] call sp_setNotificationVisible;
}] call sp_addTriggerEnter;

["cpt2_trg_end",{
    //restore healing skill
    setVar(call sp_getActor,healing,cpt2_data_healingSkill);

    //remove bandage if exists
    {
        delete(_x);
    } foreach cpt2_data_bandageRefList;

    [""] call sp_view_setPlayerHudVisible;
    [true] call sp_setHideTaskMessageCtg;
	[true,1.1] call setBlackScreenGUI;
    {
        3 call sp_threadPause;

        ["cpt2_topart3"] call sp_startScene;
       
    } call sp_threadStart;
}] call sp_addScene;

["cpt2_topart3",{
	{
        ["transition3"] call sp_audio_playMusic;
        
        1.5 call sp_threadPause;

		//cam shown
		[true] call sp_cam_setCinematicCam;
        [true] call sp_gui_setCinematicMode;
		{
			["cpt2_pos_cutscenetocpt3","player_cutscene",[],{
				[_this] call sp_copyPlayerInventoryTo;
			}] call sp_ai_createPersonEx;

		} call sp_threadCriticalSection;

		["vr",[4263.95,3958.19,8.57178],169.17,0.45,[6.2883,0],0,0,760.139,0,0,1,0,1] call sp_cam_prepCamera;
		"player_cutscene" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		["player_cutscene","cpt2_pos_cutscenetocpt3","cutscenes\cpt2_cutscenetocpt3",{},[
            ["state_1",{
                callFuncParams("cpt2_obj_doortocpt3" call sp_getObject,setDoorOpen,true);
            }]
        ]] call sp_ai_playAnim;
		1 call sp_threadPause;
		_del = 14.3;
		_pos2 = ["vr",[4264.5,3955.25,8.57178],169.17,0.32,[6.2883,0],0,0,760.139,0,0,1,0,1];
		["all",_pos2,_del + 8] call sp_cam_interpTo;
		[false,1] call setBlackScreenGUI;
		(_del) call sp_threadPause;
		[true,4] call sp_gui_setBlackScreenGUI;

		5 call sp_threadPause;

		[false] call sp_cam_setCinematicCam;
        [false] call sp_gui_setCinematicMode;
		call sp_cam_stopAllInterp;
		[2] call sp_onChapterDone;
		_post = {
            call sp_cleanupSceneData;
            ["cpt3_begin"] call sp_startScene;
        };
        invokeAfterDelay(_post,3);
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