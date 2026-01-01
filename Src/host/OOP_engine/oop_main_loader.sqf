// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\engine.hpp"
#include "..\oop.hpp"

#define TRACE_OOP_MODULE_RELOAD

#ifdef TRACE_OOP_MODULE_RELOAD
    #define mlog(text) trace(text)
    #define mlogformat(text,fmt) traceformat(text,fmt)
#else
    #define mlog(text) 
    #define mlogformat(text,fmt)
#endif

oop_lastTypeLoadTime = 0;

#define NULLCLASS "<NAN_CLASS>"
#define EXIT_IF_ERROR(mes) if (_iserror || server_isLocked) exitWith {error(mes); [mes] call logCritical; false}
#define shell_init(__name__system,__value__system) format["_thisobj setvariable ['%1',%2]; ",__name__system,__value__system]
#define logoop(mes) ["[OOP]:    ",(mes),"#0111"] call stdoutPrint; ["(OOP_init)	%1",mes] call logInfo

#define allocName this setName "%2"

/*
    Данный файл предназначен для общей загрузки модулей в среде симуляции и редакторе
*/
oop_loadTypes = {
    params ["_typemap","_inh_struct","_options"];
    /*
        Порядок выполнения:
        Если _typemap не ссылка от p_table_allclassnames
        то в этот лист будут добавлены новые типы
        Данная опция позволяет сделать пакетную загрузку классов (doll)
    */
    //inheritance
    private _isEditor = is3DEN;
    private _isSim = !_isEditor;
    private _printError = ifcheck(_isSim,logCritical,printError);


    private _typeLoadedList = if isNullVar(_typemap) then {
        p_table_allclassnames
    } else {
        []
    };

    if (_isSim) then {
        logoop("Starting class compilation");
    };

    private _iserror = false;
    private _oop_initTime = diag_ticktime;
    
    _attr_ex_init_list = [];
    {
        _pObj = missionnamespace getvariable ['pt_' + _x,NULLCLASS];
        _className_str = _x;
        if (_pObj isequalto NULLCLASS) exitWith {
            ["Cant find class - %1",_x] call _printError;
            if (_isSim) then {
                errorformat("Cant find class - %1",_x);
            };
            _iserror = true;
        };
        _fieldsBaseValues = [];
        _exist_fields = [];
        _exists_methods = [];
        _ctor_objects = [];
        _dtor_objects = [];

        _motherType = _pObj getvariable ['__motherClass',"nulldata"];

        if (_pObj getVariable ['__isPrepToComp',false]) exitWith {
            _iserror = true;
            ["Duplicate classname - '%1'",_className_str] call _printError;
            if (_isSim) then {
                errorformat("Duplicate classname - '%1'",_className_str);
            };
        };
        _pObj setVariable ['__isPrepToComp',true];

        if (_motherType != TYPE_SUPER_BASE && {(missionnamespace getvariable ['pt_' + _motherType,nullPtr]) isEqualTo nullPtr}) exitWith {
            _iserror = true;
            ["Can't find mother type '%2' in class '%1'",_className_str arg _motherType] call _printError;
            if (_isSim) then {
                errorformat("Can't find mother type '%2' in class '%1'",_className_str arg _motherType);
            };
        };

        _shell_data = if (_motherType == "NetObject") then {
            format['private ctxParams = _this; private this = createNetObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
        } else {
            format['private ctxParams = _this; private this = createObj; private _pt = pt_%2; allocName; this setvariable ["%1",_pt]; ',PROTOTYPE_VAR_NAME,_x];
        };
        _shell_data = [_shell_data];

        //attributes and autoref init
        private _attrs = [];
        private _autoref = [];

        private _attr_fields = null;
		private _attr_methods = null;
		private _attr_class = null;
        if (_isEditor) then {
		    _attr_fields = createHashMap;
            _attr_methods = createHashMap;
            _attr_class = createHashMap;
            _pObj setVariable ["_redit_attribFields",_attr_fields];
            _pObj setVariable ["_redit_attribMethods",_attr_methods];
		    _pObj setVariable ["_redit_attribClass",_attr_class];
        };

        //inheritance process
        _mot = _pObj;
        _inheritance_list = [_x];
        _counter = 0;

        while {!((_mot) isequalto NULLCLASS)} do {

            if (_counter >= 9999) exitWith {
                ["Maximum inheritance amount on class '" + _x + "'"] call _printError;
                if (_isSim) then {
                    errorformat("Maximum inheritance amount on class '%1'",_x);
                };
                _iserror = true;
            };
            INC(_counter);

            //reg fields
            {
                _x params ["_name","_value"];
                _name = toLower _name;

                if (!(_name in _exist_fields)) then {
                    _exist_fields pushBack _name;
                    _fieldsBaseValues pushBack [_name,_value];

                    //reg new field
                    if (_isSim) then {
                        _shell_data pushBack shell_init(_name,_value);
                    };
                };
            } foreach (_mot getvariable '__fields');

            //reg methods
            {
                _x params ["_name","_value"];
                _name = toLower _name;

                if (_name isEqualTo "constructor") then {_ctor_objects pushBack (_mot)};
                if (_name isEqualTo "destructor") then {_dtor_objects pushBack (_mot)};

                if (!(_name in _exists_methods)) then {
                    _exists_methods pushBack _name;

                    //reg new method

                    _pObj setvariable [_name,_value];
                };
            } foreach (_mot getvariable '__methods');

            //handle members attributes
            if (_isEditor) then {
                ["__ed_attr_fields",_attr_fields,"field"] call oop_init_handleMemberAttributes;
			    ["__ed_attr_methods",_attr_methods,"method"] call oop_init_handleMemberAttributes;

			    ["__ed_attr_class",_attr_class,"class"] call oop_init_handleClassAttributes;
            };

            //collect attributes
            _attrs append (_mot getVariable '__attributes');
            //collect autoref variables
            _autoref append (_mot getVariable '__autoref');

            //getting this child
            _thisChild = _mot getVariable "classname";

            //go to next mother
            _mot = _mot getvariable ['__motherClass',"nulldata"];
            _motTypeName = _mot;

            if (_mot == TYPE_SUPER_BASE) exitWith {};
            _inheritance_list pushback (_mot);

            _mot = missionnamespace getvariable ['pt_' + _mot,NULLCLASS];
            if equals(_mot,NULLCLASS) exitWith {
                ["Compilation runtime error. Cant find mother class %1",_motTypeName] call _printError;
                if (_isSim) then {
                    errorformat("Compilation runtime error. Cant find mother class %1",_motTypeName);
                };
                _iserror = true;
            };
            (_mot getVariable '__childList') pushBackUnique (tolower _thisChild);
        };

        if (_iserror) exitWith {
            ["Abort init classes after inheritance process '" + _x + "'"] call _printError;
            if (_isSim) then {
                errorformat("Abort init classes after inheritance process '%1'",_x);
            };
        };

        //calling ctors
        if (_isSim) then {
            _shell_data pushBack '{this call (_x getvariable "constructor")} foreach (this getvariable "proto" getvariable "__ctors"); this';
        };

        if (_isSim) then {
            _pObj setvariable ['__instance',compile (_shell_data joinString "")];
        };

        _pObj setvariable ["__inhlistCase",_inheritance_list];
        _inheritance_list = _inheritance_list apply {tolower _x};
        _pObj setvariable ["__inhlist",_inheritance_list];

        //make hashset for isTypeOf faster algorithm
        _pObj setVariable ["__inhlist_map",hashSet_create(_inheritance_list)];

        //reversing ctors. base to childs...
        reverse _ctor_objects;

        _pObj setvariable ['__ctors',_ctor_objects];
        _pObj setvariable ['__dtors',_dtor_objects];

        //!not used anywhere
        //added mother object 
        // if !((_pObj getVariable ['__motherClass',TYPE_SUPER_BASE]) isEqualTo TYPE_SUPER_BASE) then {
        //     _pObj setvariable ['__motherObject',
        //         missionNamespace getVariable [
        //             'pt_' +
        //             (_pObj getVariable ['__motherClass',TYPE_SUPER_BASE])
        //         ,TYPE_SUPER_BASE]
        //     ];
        // };

        //adding reflect info: field and method names
        _pObj setVariable ["__allfields",_exist_fields];
        _pObj setVariable ["__allmethods",_exists_methods];
        
        //hashing faster than arrays
        _pObj setVariable ["__allfields_map",createHashMapFromArray _fieldsBaseValues];

        if (_isEditor) then {
            [_className_str,(_pObj getvariable "__allfields_map") get "model"] call golib_massoc_generate;
        };

        //init all attributes
        if not_equals(_attrs,[]) then {
            _attr_ex_init_list pushBack [_pObj,_attrs];

            //initialize all attributes after all classes done
        };

        //init autoref method
        if not_equals(_autoref,[]) then {
            _pObj setVariable ["__autoref_list",_autoref];
        };

        if (server_isLocked) exitWith {};
        //log("shell object <" + _x + "> is > " + _shell_data);
        //logoop("Class loaded - " + _x);

    } forEach _typeLoadedList;

    private _errorAttr = {
        ["Cant find attribute <%1> in class <%2>",_name arg _pObj getVariable ["classname" arg "UNKNOWN_CLASS"]] call _printError;
        if (_isSim) then {
            errorformat("Cant find attribute <%1> in class <%2>",_name arg _pObj getVariable ["classname" arg "UNKNOWN_CLASS"]);
        };
    };

    if (_isSim) then {
        {
            _x params ["_pObj","_attrs"];
            //?not need
            // if (_isEditor) then {
            //     _pObj setVariable ["__ed_attr_class",_attrs];
            // };

            {
                _x params ["_name","_params"];

                [_pObj,_params] call (missionNamespace getVariable ["oop_attr_"+_name,_errorAttr]);

            } foreach _attrs;
        } foreach _attr_ex_init_list;
    };

    EXIT_IF_ERROR("Class compilation was terminated");

    oop_lastTypeLoadTime = diag_ticktime - _oop_initTime;

    logoop("--------------------------------------------------");
    logoop("Classes loaded in " + str (oop_lastTypeLoadTime) + " sec");

    if (_isEditor) then {
        goasm_build_lastTime = oop_lastTypeLoadTime;
    };

    true
};

#undef EXIT_IF_ERROR
#undef shell_init

//Общий метод обработки атрибутов членов класса
oop_init_handleMemberAttributes = {
    params ["_memberNameStr","_refDict","_flag"];
    private _isInherAtr = not_equals(_mot,_pObj);
    {
        _x params ["_mem_name","_atrlist"];
        _mem_name = tolower _mem_name; //fix fields inspector attributes
        
        //Член не имеет атрибутов. проводим регистрацию
        if !(_mem_name in _refDict) then {
            private _list = [];

            {
                if ([_x select 0,_mot,_flag,_x select [1,(count _x) - 1],_isInherAtr] call goasm_attributes_canAddAttribute) then {
                    _list pushBack _x;
                };
            } foreach _atrlist;

            if (count _list > 0) then {
                _refDict set [_mem_name,_list];
            };
        } else {
            //Получаем список атрибутов
            _curAtList = _refDict get _mem_name;
            //Если атрибут есть в списке наследования - пропускаем
            {
                _atName = _x select 0;
                if ([_atName,_mot,_flag,_x select [1,(count _x) - 1],_isInherAtr] call goasm_attributes_canAddAttribute) then {
                    if ((_curAtList findif {(_x select 0) == _atName}) == -1) then {
                        _curAtList pushBack _x;
                    };
                };

            } foreach _atrlist;
        };
    } forEach (_mot getVariable [_memberNameStr,[]]);
};

oop_init_handleClassAttributes = {
    params ["_memberNameStr","_refDict","_flag"];
    private _isInherAtr = not_equals(_mot,_pObj);
    private _atdata = null;
    private _atName = null;

    {
        //если атрибут не в классе
        _atName = _x select 0;
        if !(_atName in _refDict) then {
            _atdata = _x select [1,(count _x) - 1];
            if ([_atName,_mot,_flag,_atdata,_isInherAtr] call goasm_attributes_canAddAttribute) then {
                _refDict set [_atName,_atdata];
            };
        } else {
            _atdata = _x select [1,(count _x) - 1];
            if ([_atName,_mot,_flag,_atdata,_isInherAtr] call goasm_attributes_canAddAttribute) then {
                //fix upper inheritance attributes. Editor 1.4
                //Так как наследование идёт сверху вниз нам не нужно переопределять дочерними свойствами значения атрибута при наличии
                if (_atName in _refDict) exitwith {};
                _refDict set [_atName,_atdata];
            };
        };
    } foreach (_mot getVariable [_memberNameStr,[]]);
};

oop_reloadModule = {
    params ["_filepath"];
    
    if !([_filepath,".sqf"] call stringEndWith) exitWith {
        warningformat("[oop_reloadModule]: Reloaded module is not a script file: %1",_filepath);
        false
    };
    if !([_filepath,true] call file_exists) exitWith {
        warningformat("[oop_reloadModule]: File not found %1",_filepath);
        false
    };

    mlogformat("Start reload module %1",_filepath)
    
    //safeguard reload gamemodule
    pc_oop_intList_loadObjectPool = [];
    pc_oop_flag_reloadModule = true;
    call compile preprocessFileLineNumbers _filepath;
    pc_oop_flag_reloadModule = false;

    private _classObjectList = pc_oop_intList_loadObjectPool;
    pc_oop_intList_loadObjectPool = []; //cleanup pool storage
    //firstpass: check ready classes
    private _allReady = _classObjectList findif {
        isNullVar(_x)
        || {isNullReference(_x)}
        || {not_equalTypes(_x,nullPtr)}
        || {_x getvariable ["classname",""] == ""}
    } == -1;
    
    mlogformat("Check classes ready %1",_allReady)
    mlogformat("Object list: %1",_classObjectList)

    if (_allReady) then {
        mlogformat("Start reloading %1 classes",count _classObjectList)

        //pathing process
        private _tempClass = nullPtr;
        private _baseToChilds = {
            params ["_clsext","_fMap","_mMap"];

            private _tObj = typeGetFromString(_clsext);
            private _curMethods = _tObj getvariable "__methods";
            private _curFields = _tObj getvariable "__fields";

            mlogformat("   Processing %1",_clsext)

            mlog("   Check methods")
            {
                _x params ["_metName","_oldCode"];
                if (_metName in _mMap && _classname != _clsext) then {
                    mlogformat("       Overriden method - %1",_metName)
                    //overriden. exclude method from childs
                    _mMap deleteAt _metName;
                } else {
                    mlogformat("       Update method - %1",_metName)
                    //not overriden. update value
                    _tObj setvariable [_metName,_mMap get _metName];
                };
            } foreach _curMethods;

            // mlog(" Check fields")
            // //Существующие поля перезаписываются если отличаются 
            // {
            //     _x params ["_fldName","_oldSerVal"];
            //     if (_fldName in _fmap && _classname != _clsext) then {
            //         mlogformat("       Override field - %1",_fldName)

            //         _fMap deleteAt _fldName;
            //     } else {
            //         mlogformat("       Update field - %1",_fldName)
            //     };
            // } foreach _curFields;

            //exclude inherited members process
            

            //collect childs
            mlogformat("   Child process %1: %2",_clsext arg _tObj getvariable "__childList")
            {
                [_x,_fMap,_mMap] call _baseToChilds;
            } foreach (_tObj getvariable "__childList");

            mlogformat("   =========== end process %1",_clsext)
        };

        {
            _tempClass = _x;
            _classname = _tempClass getvariable "classname";
            if isImplementClass(_classname) then {
                /*
                    Наследование снизу вверх (от базовых к дочерним) __childList
                    Если метод есть в дочернем - выход
                    иначе
                    патчим методы
                */
                private _fieldsMap = createHashMapFromArray (_tempClass getvariable "__fields");
                private _methodsMap = createHashMapFromArray (_tempClass getvariable "__methods");
                mlogformat("---- BEGIN RELOAD %1",_classname)
                [_classname,_fieldsMap,_methodsMap] call _baseToChilds;
                mlogformat("------ END RELOAD %1",_classname)

            } else {
                errorformat("Cant path class %1 - not exists",_classname);
            };
            
            deleteObj _tempClass;
        } foreach _classObjectList;
    } else {
        
        //cleanup temporary objects on error
        {deleteObj _x;} foreach _classObjectList;
    };

    _allReady
};