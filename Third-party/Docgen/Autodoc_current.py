import re
import sys
from autodoc_utility import *

def readFile(path):
    with open(path,"r",encoding='utf-8') as content:
        return parse_sqf_functions(content.read())

# Пример использования
sqf_code_testcode = """
cm_getAllClientsByAccessLevel = {
    params ["_lvl", ["_thisAndHight", false],"_tv"];
    // Код функции cm_getAllClientsByAccessLevel
};
/*
cm_accessTypeToNum = {params ["_accessString"];
    // Код функции cm_accessTypeToNum
};
*/

cm_noparamsFUnc = {a == 3};

cm_firstcheck = {
params [["_co",3,[true,"",[],1]],"_someval"];
    // Код функции cm_firstcheck
};

// Some docs


cm_idToName = {
params ["_id",["_co",3,[true,1]],"_someval"];
    // Код функции
};

fntest1 = {params["_x"]; }

#ifdef DEBUG
fninside = {
    params ["_internalval"];
    fninternal = {
        params ["_in_inval"];
    };
};
#endif

/* comment start
commentline
comment end 

#define macro
*/

passedparamFunc = {
    
    
    private _thisObj = _this; 
    
    };

_nonglobal = {params ["_x"]; }

/*
 Inline some data
 Use this in any cases
*/

#define preprocessed  {params["_DONOT"]};

#ifndef VALYE
   #define paramcall(a,b,c) 1,2,3
#else
    #define paramcall(a,b,c) 
#endif


// Другой код
"""

"""
functions = parse_sqf_functions(sqf_code_testcode)

for function_name, values in functions.items():
    if values["Type"] == "Macro":
        print(f"Macro:{function_name}")
        #print(f"Docs:{values['Desc']}")
        #print(f"Defined at line {values['DefLine']}")
        #print(f"{parameters_to_string(values['Arguments'])}")
        #print(f"Replaced value:{values['Value']}")
        #condit = values['conditional']
        #if condit:
        #    print(f"Exists if {condit['name']} is {condit['required']}")
    else:
        print(f"Function: {function_name}")
        print(f"Docs:{values['Desc']}")
        #print(f"Parameters:")
        #print(f"{parameters_to_string(values['Arguments'])}")
    print()

sys.exit()
"""