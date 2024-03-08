import re
import string
import sys

def split_elements(data):
    elements = []
    current_element = ''
    stack = []
    for char in data:
        if char == '[':
            stack.append('[')
        elif char == ']':
            stack.pop()
        if char == ',' and not stack:
            if current_element:
                elements.append(current_element.strip())
                current_element = ''
        else:
            current_element += char
    if current_element:
        elements.append(current_element.strip())
    return elements

def parse_arguments(arguments):
    arguments = arguments[1:-1]
    #print(f"argData: {arguments}")
    elements = split_elements(arguments)
    parsed_arguments = []
    for element in elements:
        if element.startswith('['):
            parsed_arguments.append(parse_arguments(element))
        else:
            parsed_arguments.append(element)
    return parsed_arguments

def parse_macroargumets(arguments):
    if not arguments:
        return None
    arguments = arguments[1:-1]
    return arguments.replace(" ","").split(',')

def parameters_to_string(argList,retAsMarkdown = False):
    if not argList:
        return ''
    
    paramlet = "Param:"
    if retAsMarkdown:
        paramlet = "- Param:"
    retval = []
    for arg in argList:
        if not isinstance(arg,list):
            if arg[0:1] == '"' or arg[0:1] == "'":
                retval.append( f"{paramlet} {arg[1:-1]}")
            else:
                retval.append( f"{paramlet} {arg}")
        else:
            lenargs = len(arg)
            if (lenargs == 1):
                raise Exception(f"ERROR LENARGS TOO SMALL {lenargs} -> {arg}")
            elif lenargs == 2:
                retval.append( f"{paramlet} {arg[0][1:-1]} (optional, default {arg[1]})")
            elif lenargs == 3:
                retval.append( f"{paramlet} {arg[0][1:-1]} (optional, default {arg[1]}, expected types: {str(arg[2])})")
            elif lenargs == 4:
                retval.append( f"{paramlet} {arg[0][1:-1]} (optional, default {arg[1]}, expected types: {str(arg[2])})")
            else:
                raise Exception(f"ERROR LENARGS TOO BIG {lenargs} -> {arg} ({argList})")
    
    return '\n'.join(retval)

def parse_sqf_functions(code):
    function_pattern = r"\s*\b([a-zA-Z]\w+|node_func\([a-zA-Z]\w+\))\s*=\s*\{"  #old pattern r"\s*\b([a-zA-Z]\w+)\s*=\s*\{"
    macros_pattern = r"[ \t]*#define[ \t]+((\w+)(\([^\)]*\))?)[ \t]*((?:.*\\\r?\n)*.*)" #g2 full,g3 params, g4 value
    param_pattern = r"params\s*(\[.+?\]);"
    contextParam_pattern =r"private\s+(\_\w+)\s*=\s*_this"
    ifdef_pattern = r"#(if(n)?def)\s*(\w+)"
    #comment_pattern = r"(?:(?:\/\/.*)|(?:\/\*(?:.|\n)*?\*\/))"

    compat_all = r"(\/\/(.*)\s*|\/\*([\wа-яА-Я\s]*)\*\/\s*)"

    lines = code.split('\n')
    linenum = 1

    for line in lines:
        #print(f"({linenum})" + line)
        linenum += 1

    functions = re.findall(function_pattern, code)
    macros = re.findall(macros_pattern,code)
    results = {}
    checkedMacro = []
    checkedVars = []
    checkedFuncs = []
   
    for macro in macros:
        macrofullname = macro[0]
        macroname = macro[1]
        macroparams = macro[2]
        macrovalue = macro[3]
        #print(f"name->>>>>>>>>>>>>>>>>>>{macroname}")
        start_line = -1
        condit = None
        multilineCom = False
        MemberDesc = ""
        
        for i, line in enumerate(lines):
            singleCom = False
            cond = re.search(ifdef_pattern,line,re.DOTALL)
            if cond:
                requireDef = cond.group(1) == "ifdef"
                defName = cond.group(3)
                condit = {
                    "required": requireDef,
                    "name": defName
                }
            if "#else" in line and condit:
                condit["required"] = not condit["required"]
            if "#endif" in line and condit:
                condit = None 

            if "/*" in line:
                multilineCom = True
            if "*/" in line:
                multilineCom = False
            if re.match(r"^[\s]*\/\/.*",line,re.DOTALL):
                singleCom = True

            pat = re.search(rf"[ \t]*#define[ \t]+{macroname}", line, re.DOTALL)
            checkedName = f"{macroname}@{i + 1}"

            if pat and not checkedName in checkedMacro:
                if multilineCom or singleCom:
                    macroname = ""
                    break
                start_line = i + 1
                checkedMacro.append(checkedName)

                com = re.search(rf"{compat_all}[ \t]*#define[ \t]+{macroname}", code, re.MULTILINE)
                if com:
                    if com.group(2):
                        MemberDesc = com.group(2)
                    if com.group(3):
                        MemberDesc = com.group(3).replace('\t',' ')
                    
                    MemberDesc = MemberDesc.lstrip("\n").lstrip(" ").rstrip(" ").rstrip("\n")
                break
        
        if macroname == "":
            continue

        if condit:
            macroname += f"@{condit['name']}->{condit['required']}"
        
        if MemberDesc == "======================================================":
            MemberDesc = ""

        results[macroname] = {
                    "Type": "Macro",
                    "DefLine": start_line,
                    "Desc": MemberDesc,
                    "Value": macrovalue,
                    "MacroFullname": macrofullname,
                    "Arguments" : parse_macroargumets(macroparams),

                    "conditional": condit
                }

    #fields search
    # check brackets { and }  
    bracketLevel = 0
    pat_var = r"^[\t ]*[a-zA-Z]\w+\s*\=\s*([^{]*);"
    pat_vardecl = r"^[\t ]*([a-zA-Z]\w+)\s*\=\s*([^{\n]*)"
    
    condit = None
    multilineCom = False
    MemberDesc = ""

    for i, line in enumerate(lines):
        singleCom = False
        bracketLevel += line.count("{")
        bracketLevel -= line.count("}")
        
        cond = re.search(ifdef_pattern,line,re.DOTALL)
        if cond:
            requireDef = cond.group(1) == "ifdef"
            defName = cond.group(3)
            condit = {
                "required": requireDef,
                "name": defName
            }
        if "#else" in line and condit:
            condit["required"] = not condit["required"]
        if "#endif" in line:
            condit = None 
        
        if "/*" in line:
            multilineCom = True
        if "*/" in line:
            multilineCom = False
        if re.match(r"^[\s]*\/\/.*",line,re.DOTALL):
            singleCom = True

        if bracketLevel > 0:
            continue

        vardecl = re.match(pat_vardecl,line,re.DOTALL)
        if vardecl and vardecl.group(2):
            varname = vardecl.group(1)
            if condit:
                varname += f"@{condit['name']}->{condit['required']}"
            checkedName = f"{varname}@{i + 1}"
            if multilineCom or singleCom or checkedName in checkedVars:
                break
            varvalue = vardecl.group(2)
            
            varvalue = (varvalue + "..." if not ";" in varvalue else varvalue.replace(";",""))
            checkedVars.append(checkedName)
            #print(f"newvar {varname} {varvalue}")
            #sys.exit()

            com = re.search(rf"{compat_all}{varname}\s*=\s*", code, re.MULTILINE)
            if com:
                if com.group(2):
                    MemberDesc = com.group(2)
                if com.group(3):
                    MemberDesc = com.group(3).replace('\t',' ')
                
                MemberDesc = MemberDesc.lstrip("\n").lstrip(" ").rstrip(" ").rstrip("\n")

            if MemberDesc == "======================================================":
                MemberDesc = ""

            results[varname] = {
                "Type": "Variable",
                "DefLine": i + 1,
                "Value": varvalue,
                "Desc": MemberDesc,
                "Arguments": None,
                'conditional' : condit
            }

            MemberDesc = ""
            condit = None

    for function_name in functions:
        function_signature = re.search(rf"{function_name}\)?\s*=\s*{{(.+?)}}", code, re.DOTALL)
        if function_signature:
            #find function start line in liest (search in string)
            start_line = -1
            condit = None
            MemberDesc = ""
            multilineCom = False
            for i, line in enumerate(lines):
                singleCom = False
                cond = re.search(ifdef_pattern,line,re.DOTALL)
                if cond:
                    requireDef = cond.group(1) == "ifdef"
                    defName = cond.group(3)
                    condit = {
                        "required": requireDef,
                        "name": defName
                    }
                if "#else" in line and condit:
                    condit["required"] = not condit["required"]
                if "#endif" in line:
                    condit = None 
                
                if "/*" in line:
                    multilineCom = True
                if "*/" in line:
                    multilineCom = False
                if re.match(r"^[\s]*\/\/.*",line,re.DOTALL):
                    singleCom = True

                checkedName = f"{function_name}@{i + 1}"

                if re.search(rf"{function_name}\s*=\s*{{", line) and not checkedName in checkedFuncs:
                    if multilineCom or singleCom:
                        function_name = ""
                        break
                    start_line = i + 1
                    checkedFuncs.append(checkedName)
                    
                    com = re.search(rf"{compat_all}{function_name}\s*=\s*{{", code, re.MULTILINE)
                    if com:
                        if com.group(2):
                            MemberDesc = com.group(2)
                        if com.group(3):
                            MemberDesc = com.group(3).replace('\t',' ')
                        
                        MemberDesc = MemberDesc.lstrip("\n").lstrip(" ").rstrip(" ").rstrip("\n")
                    break
            
            if function_name == "":
                continue
            
            #print(f"func {function_name} at {start_line}")

            #print(f'signature found: {function_signature.group()}')
            params_match = re.search(param_pattern, function_signature.group(), re.DOTALL)
            ctxparams_match = re.search(contextParam_pattern, function_signature.group(), re.DOTALL)
            
            if condit:
                function_name += f"@{condit['name']}->{condit['required']}"

            if params_match:
                params = params_match.group(1)
                results[function_name] = {
                    "Type": "Function",
                    "Arguments" : parse_arguments(params)
                }
            elif ctxparams_match:
                results[function_name] = {
                    "Type": "Function",
                    "Arguments" : [ctxparams_match.group(1)]
                }
            else:
                results[function_name] = {
                    "Type": "Function",
                    "Arguments" : None
                }
            

            results[function_name]['conditional'] = condit
            
            if MemberDesc == "======================================================":
                MemberDesc = ""
            if MemberDesc:
                results[function_name]['Desc'] = MemberDesc

            results[function_name]["DefLine"] = start_line
            if not 'Desc' in results[function_name]:
                results[function_name]['Desc'] = ""



    return results