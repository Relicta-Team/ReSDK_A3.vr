import re
import sys
import string
import os


def log(mes):
    print(mes,file=sys.stdout)

def writeSummary(content):
    if "GITHUB_STEP_SUMMARY" in os.environ :
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f :
            print(content="\n", file=f)

def error(message,optfile = '',optline='',opttitle=''):
    build = '::error '
    listargs = []
    if optfile!="":
        listargs.append(f'file="{optfile}"')
    if optline!="":
        listargs.append(f'line="{optline}"')
    if opttitle!="":
        listargs.append(f'title="{opttitle}"')
    
    print(build + ','.join(listargs) + "::" + message)

if len(sys.argv) < 3:
    error(f"No cli param found; Count {len(sys.argv)}")
    for line in sys.argv:
        log(f"arg: {line}")
    sys.exit(-500)

taskname = sys.argv[1]
workspace = os.path.abspath(sys.argv[2])
log(f"Task {taskname}")
log(f"Workspace path: {workspace}")

mapStorageFolder = os.path.abspath(workspace + '\\Src\\Editor\\Bin\\Maps')
log(f'Check map storage: {mapStorageFolder}')
if not os.path.exists(mapStorageFolder): sys.exit(20)

mapCompiledFolder = os.path.abspath(workspace + '\\Src\\host\\MapManager\\Maps')
log(f'Check baked maps: {mapCompiledFolder}')
if not os.path.exists(mapCompiledFolder): sys.exit(21)

lightEngineFolder ='\\Src\\client\\LightEngine\\'
legacyLightsFile = os.path.abspath(workspace + lightEngineFolder + 'LightEngine.hpp')
scriptedLightsFile = os.path.abspath(workspace + lightEngineFolder + 'ScriptedEffects.hpp')

log('Check light configs')
if not os.path.exists(legacyLightsFile) or not os.path.exists(scriptedLightsFile): sys.exit(22)

hasError = False

#region Functions
def validateConfigs():
    global mapStorageFolder
    global mapCompiledFolder
    global legacyLightsFile
    global scriptedLightsFile
    allConfigsLE = {}
    
    global hasError


    log("Scanning configs")
    allContents = ""
    with open(scriptedLightsFile,"r",encoding="utf8") as f:
        allContents += f.read()
    with open(legacyLightsFile,"r",encoding="utf8") as f:
        allContents += f.read()
    
    mathces = re.findall("\#\s*define\s+(S?LIGHT_\w+)\s+(\d+)",allContents)
    
    writeSummary(f"Light configs:")
    for match in mathces:
        cfg = match[0]
        id = match[1]
        if cfg in allConfigsLE:
            error(f"Duplicate config {cfg}")
            hasError = True
        if id in allConfigsLE.values():
            configwithid = next((k for k, v in allConfigsLE.items() if v == id), None)
            error(f"Duplicate config id {id}; This id already used for {configwithid}")
            hasError = True
        log(f'Found config {cfg} with id {id}')
        writeSummary(f" - {cfg}={id}")
        allConfigsLE[cfg] = id

    if hasError: return
    
    log("\n\nValidate storage")
    writeSummary("# Maps in storage:")
    for map in os.listdir(mapStorageFolder):
        if not map.endswith(".cpp"): continue

        mapPath = os.path.join(mapStorageFolder,map)
        log(f"Scanning map file {map}")
        writeSummary(f"- {map}")
        with open(mapPath,"r",encoding="utf8") as f:
            buf = f.read()
            
            mapnamebin = re.findall("\"\"missionName\"\",\"\"([\w_]*)\"\"",buf)
            if mapnamebin.__len__() != 1:
                error(f"Map {map} has no internal name")
                hasError = True
            
            mapnamebin = mapnamebin[0]

            mathces = re.findall("\"\"light\"\",\"\"(\w+)\"\"",buf)
            foundedCfgs = 0
            for match in mathces:
                cfg = match
                if not cfg in allConfigsLE:
                    error(f"Config {cfg} not found in binary map {mapnamebin}")
                    hasError = True
                else:
                    foundedCfgs += 1
            
            log(f"Map {map} has {foundedCfgs} config uses")
    
    if hasError: return
        
    log("\n\nValidate compiled maps")
    writeSummary("# Compiled maps:")
    for map in os.listdir(mapCompiledFolder):
        if not map.endswith(".sqf"): continue

        mapPath = os.path.join(mapCompiledFolder,map)
        log(f"Scanning map builded file {map}")
        writeSummary(f"- {map}")
        with open(mapPath,"r",encoding="utf8") as f:
            buf = f.read()
            foundedCfgs = 0
            mathces = re.findall("\[\'light\'\,(\w+)\]",buf)
            for match in mathces:
                if match.endswith('_var'):
                    match = match[:-4]
                cfg = match
                if not cfg in allConfigsLE:
                    error(f"Config {cfg} not found in builded map {map}")
                    hasError = True
                else:
                    foundedCfgs += 1
            
            log(f"Map {map} has {foundedCfgs} config uses")

#endregion

if taskname=="map_cfg_light_check":
    validateConfigs()
elif taskname=="todo_check":
    pass
else:
    log(f"Unknown task {taskname}")
    sys.exit(-501)

log("Work done!!!")
sys.exit(0 if not hasError else -1)