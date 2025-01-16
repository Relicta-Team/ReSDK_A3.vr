import re
import sys
import string
import os
import glob


def log(mes):
    print(mes,file=sys.stdout)

def writeSummary(content):
    if "GITHUB_STEP_SUMMARY" in os.environ :
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f :
            print(content+"\n", file=f)

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
    sys.exit(-120)

taskname = sys.argv[1]
workspace = os.path.abspath(sys.argv[2])
log(f"Task {taskname}")
log(f"Workspace path: {workspace}")

mapStorageFolder = os.path.abspath(workspace + '/Src/Editor/Bin/Maps')
log(f'Check map storage: {mapStorageFolder}')
if not os.path.exists(mapStorageFolder): 
    error("Binary maps directory not found " + mapStorageFolder)
    sys.exit(-20)

mapCompiledFolder = os.path.abspath(workspace + '/Src/host/MapManager/Maps')
log(f'Check baked maps: {mapCompiledFolder}')
if not os.path.exists(mapCompiledFolder): 
    error("Baked maps directory not found")
    sys.exit(-21)

lightEngineFolder ='/Src/client/LightEngine'
scrCfgDirectory = os.path.abspath(workspace + lightEngineFolder + "/ScriptedConfigs")

log('Check light configs')
if not os.path.exists(scrCfgDirectory): 
    error("Light configs directory not found")
    sys.exit(22)

hasError = False

#region Functions
def validateConfigs():
    global hasError
    global mapStorageFolder
    global mapCompiledFolder
    global scrCfgDirectory
    allConfigs = {}
    
    writeSummary(f"Light configs:")
    log(f"Searching configs in directory: {scrCfgDirectory}")
    for fcfgPath in glob.glob(f"{scrCfgDirectory}/*.sqf"):
        log(f'Found {fcfgPath}')
        log("    Scanning...")
        cfgFileContent = ""
        with open(fcfgPath,"r",encoding="utf8") as f:
            cfgFileContent = f.read()
        if len(cfgFileContent) == 0:
            error(f'Empty file',fcfgPath)
            hasError = True
            continue
        grp = re.search(r'regScriptEmit\((SLIGHT_[\w_]+)\)',cfgFileContent)
        if not grp:
            error('Wrong config structure',os.path.relpath(fcfgPath,workspace))
            hasError = True
            continue
        cfgName = grp.group(1)
        if cfgName in allConfigs:
            error(f"Duplicate config {cfgName}; Previous path: {allConfigs[cfgName]}",fcfgPath)
            hasError = True
            continue
        allConfigs[cfgName] = fcfgPath
        writeSummary(f" {cfgName} ({fcfgPath})")

    if hasError: return
    
    log("\n\nValidate storage")
    writeSummary("# Maps in storage:")
    for map in os.listdir(mapStorageFolder):
        if not map.endswith(".cpp"): continue

        mapPath = os.path.join(mapStorageFolder,map)
        log(f"Scanning map file {map}")
        
        with open(mapPath,"r",encoding="utf8") as f:
            buf = f.read()
            
            mapDataBin = re.search("\"\"missionName\"\",\"\"([\w_]*)\"\"\]\,\[\"\"version\"\"\,(\d+)\]",buf)
            if not mapDataBin:
                error(f"Map {map} has no internal name or unknown version")
                hasError = True
                continue
            
            mapnamebin = mapDataBin.group(1)
            mapnameVersion = mapDataBin.group(2)

            mathces = re.findall("\"\"light\"\",\"\"(\w+)\"\"",buf)
            foundedCfgs = 0
            for match in mathces:
                cfg = match
                if not cfg in allConfigs:
                    error(f"Config {cfg} not found in binary map {mapnamebin}")
                    hasError = True
                else:
                    foundedCfgs += 1
            
            log(f"Map {map} has {foundedCfgs} config uses")
            writeSummary(f"- {map} (v{mapnameVersion}) - {foundedCfgs} cfgs")
    
    if hasError: return
        
    log("\n\nValidate compiled maps")
    writeSummary("# Compiled maps:")
    for map in os.listdir(mapCompiledFolder):
        if not map.endswith(".sqf"): continue

        mapPath = os.path.join(mapCompiledFolder,map)
        log(f"Scanning map builded file {map}")
        
        with open(mapPath,"r",encoding="utf8") as f:
            buf = f.read()

            mapver = re.search(r"__metaInfoVersion__\s*\=\s*(\d+)",buf)
            if not mapver:
                error(f"Map {map} has no internal version marker or unknown version")
                hasError = True
                continue
            buildVersion = float(mapver.group(1))

            if (buildVersion < 5):
                writeSummary(f"- [SKIP CHECK] {map} v{buildVersion} ")
                log(f"Skip map checking because version {buildVersion} < 5")
                continue


            foundedCfgs = 0
            mathces = re.findall("\[\'light\'\,\"(\w+)\" call lightSys_getConfigIdByName\]",buf)
            for match in mathces:
                cfg = match
                if not cfg in allConfigs:
                    error(f"Config {cfg} not found in builded map {map}")
                    hasError = True
                else:
                    foundedCfgs += 1
            
            log(f"Map {map} has {foundedCfgs} config uses")
            writeSummary(f'- [OK] {map} v{buildVersion} - {foundedCfgs} configs')

#endregion

if taskname=="map_cfg_light_check":
    validateConfigs()
elif taskname=="todo_check":
    pass
else:
    log(f"Unknown task {taskname}")
    sys.exit(-130)

log(f"Work done!!! Error: {hasError}")
if hasError:
    sys.exit(1)
else:
    sys.exit(0)