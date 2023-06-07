import Autodoc_current
import autodoc_utility
from Autodoc_current import *
from Autodoc_current import *
import os
import sys
import shutil
from glob import glob

# for testing
outputfile = ".\\output.md"
outputdirs = ".\\outputdirs.md"

arguments = sys.argv
if len(arguments) < 2:
    print("Need path for scan directory")
    sys.exit(-1)


scanpath = arguments[1]
extensions = ['.interface', '.sqf', '.cpp','.hpp','.h']

result = [os.path.join(x[0], y) for x in os.walk(scanpath) for y in x[2] if any(y.endswith(ext) for ext in extensions)]


#idx = 0
#for file in result:
#    print(f"{idx} file: {os.path.relpath(file,scanpath)}")
#    idx += 1

docsource = ".\\..\\..\\Documentation\\API"

if os.path.exists(docsource):
    shutil.rmtree(docsource)


ignored = ['Database\MySQL','Database\\fDB','client\client_debug.h','vm_compile.sqf',"ReBridge\\","Editor\\"]

hout = open(outputdirs,"w",encoding="utf-8")

mlistMain = {
    "client": [],
    "host": []
}

flielists = {}

for fpath in result:
    if not "\\" in fpath:
        continue
    
    if any(exc in fpath for exc in ignored):
        continue

    relativePath = os.path.relpath(fpath,scanpath)
    pathlist = relativePath.split("\\")
    side = pathlist[0]
    module = side
    if len(pathlist) > 2:
        module = pathlist[1]

    if "." in module:
        continue

    createdPath = f"{docsource}\\{side}\\{module}.md"
    os.makedirs(os.path.dirname(createdPath), exist_ok=True)

    print(f"file:{relativePath}; docpath:{createdPath}",file=hout)
    print(f"side: {side}; module: {module}\n\n",file=hout)

    finfokey = f"{side}-{module}"
    if not finfokey in flielists:
        flielists[finfokey] = []
    
    flielists[finfokey].append(relativePath)

    with open(createdPath,"a+",encoding="utf-8") as handle:
        # HERE WRITED MODULE DOCUMENTATION
        #handle.write(f"writed file: {relativePath}\n")
        fileinfo = readFile(fpath)
        relpath = os.path.relpath(fpath,scanpath)

        if len(fileinfo) > 0:
            handle.write(f"# {os.path.basename(fpath)}\n\n")

        for function_name, values in fileinfo.items():
            isConditional = False
            if "@" in function_name and "->" in function_name:
                isConditional = True
                function_name = function_name.split("@")[0]

            #print(f"Function: {function_name}")
            #print(f"Parameters:")
            #print(f"{parameters_to_string(values['Arguments'])}")
            memtype = values["Type"]
            let = "function"
            if memtype == "Macro":
                let = "constant"
                function_name = values['MacroFullname']
            handle.write(f"## {function_name}\n\n")
            handle.write(f"Type: {let}\n\n")
            if isConditional:
                cond = values['conditional']
                condText = "defined" if cond['required'] else "not defined"
                handle.write(f"> Exists if **{cond['name']}** {condText}\n\n")

            handle.write(f"Description: {values['Desc']}\n")
            
            handle.write(f"{parameters_to_string(values['Arguments'],True)}\n\n")

            if memtype == "Macro":
                handle.write(f"Replaced value:\n```sqf\n{values['Value']}\n```\n")

            
            refpath = relativePath.replace('\\','/')
            #print(f'relative: {refpath}')
            # ! Src folder case-senstivity
            handle.write(f"File: [{relpath} at line {values['DefLine']}](../../../Src/{refpath}#L{values['DefLine']})\n")
    if side in mlistMain:
        if not module in mlistMain[side]:
            mlistMain[side].append(module)

os.makedirs(os.path.dirname(docsource + "\\README.md"), exist_ok=True)
with open(docsource + "\\README.md","w+",encoding="utf-8") as handle:
    for side,mlist in mlistMain.items():
        #HERE WRITED SIDES AND MODULES (MENU)
        handle.write(f"# Side: {side}\n")
        handle.write(f"Count modules: {len(mlist)}\n")
        
        for mod in mlist:
            createdPath = f"{side}//{mod}.md"
            filesInModule = flielists[f'{side}-{mod}'] # list of files, defined in module
            handle.write(f" - [{mod}]({createdPath}) - {len(filesInModule)} files\n")
        #print(f"{side} : {mlist}")

"""
fl = result[612]
print(f"scan {fl}")
fileinfo = readFile(fl)
with open(outputfile,"w",encoding="utf-8") as handle:
    relpath = os.path.relpath(fl,scanpath)
    for function_name, values in fileinfo.items():
        #print(f"Function: {function_name}")
        #print(f"Parameters:")
        #print(f"{parameters_to_string(values['Arguments'])}")
        memtype = values["Type"]
        let = "function"
        if memtype == "Macro":
            let = "constant"
            function_name = values['MacroFullname']
        handle.write(f"# {function_name}\n\n")
        handle.write(f"Type: {let}\n")

        handle.write(f"Description: {values['Desc']}\n")
        
        handle.write(f"{parameters_to_string(values['Arguments'],True)}\n\n")

        if memtype == "Macro":
            handle.write(f"Replaced value:{values['Value']}\n")

        
        refpath = fl.replace('\\','/')
        handle.write(f"File: [{relpath} at line {values['DefLine']}]({refpath})\n")
"""