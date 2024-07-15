import re
import sys
import string
import os


def log(mes):
    print(mes,file=sys.stdout)

if len(sys.argv) <= 1:
    log(f"No cli param found; Count {len(sys.argv)}")
    for line in sys.argv:
        log(f"arg: {line}")
    sys.exit(-500)

path = sys.argv[1]
workspace = sys.argv[2]
doPrettyPrint = False
if len(sys.argv) > 3:
    prettyprint = sys.argv[3]
    if prettyprint == "prettyprint":
        doPrettyPrint = True

last_loaded_file = ""

summaryInfo = ""
loadedFilesInfo = []
loadedClassesInfo = []

if not os.path.exists(path):
    log(f"Wrong path:{path}")
    sys.exit(-600)

content = open(path,"r",encoding="utf8").read().splitlines()
hasErrors = 0

hasSuccessMessage = False

log(f"Start processing logfile {path}")

def parse_line(ln:str):
    global last_loaded_file 
    pattern_sysInfo = r"\[(\w+)\] \[L(\d+)\|.*\|([\w\/\\\.]+)\]\s+(.*$)"
    match = re.search(pattern_sysInfo,ln,re.DOTALL)
    
    # if finded vm log message
    if match and match.groups().__len__() == 4:
        cat = match.group(1)
        line = int(match.group(2))
        path = match.group(3)
        message = match.group(4)
        # check if loader by rules:
        # loader.hpp in path; [LOAD] in message
        # if path not loader.hpp then path is last_loaded_file
        if message.find("[LOAD]")!=-1 or path.find("loader.hpp")!=-1 or message.find("Load file:")!=-1:
            last_loaded_file = re.search(r"([\/\\.\w]+\.(sqf|cpp|hpp|c|h|Interface))",message,re.DOTALL).group(1)
            if not last_loaded_file in loadedFilesInfo:
                loadedFilesInfo.append(last_loaded_file)
            #log(f"{cat} on {path} {line} with message:{message}")
        
        if message.find("[CLASS]")!=-1:
            handle_classinfo(re.search(r"\[CLASS\](.*)",message,re.DOTALL).group(1))

        if message.find("VM compile done")!=-1:
            global hasSuccessMessage
            hasSuccessMessage = True

        if cat == "ERR":
            llf = last_loaded_file
            if llf == "":
                llf = path
            handle_error(llf,path,line,message)
        
        if message.find("&SYSTEMLOG")!=-1:
            message = re.search(r"\&SYSTEMLOG(.*)",message,re.DOTALL).group(1)
            llf = last_loaded_file
            if llf == "":
                llf = path
            handle_error(llf,path,line,message)
        

        if (message.find("[Error]")!=-1 or message.find("[Critical]")!=-1) and message.find("[OOP_init]")!=-1:
            log(f"::error file={path}::{message}")
    
    if ln.find("EXCEPTION OCCURRED:")!=-1:
        errGrp = re.search(r"EXCEPTION OCCURRED: '\"([\S\w\W]*)\|(CTX:([\w\/\\\.]+)\+(\d+))",ln,re.DOTALL)
        message = errGrp.group(1)
        file = errGrp.group(3)
        line = int(errGrp.group(4))
        llf = last_loaded_file
        if llf == "":
            llf = last_loaded_file
        handle_error(llf,file,line,message)


def handle_error(errored_file,catched_path,catched_line,error_message):
    global hasErrors
    hasErrors += 1
    optionals = ""
    errmes = error_message
    if errmes.find("Arg Count Missmatch") != -1:
        #optionals = optionals + f",title=Preprocessor error"
        patdef = r"\#define\s+(\w+\(\w+(\,\w+)*\))"
        macrosig = re.search(patdef,read_src_file(catched_path,catched_line),re.DOTALL)
        if macrosig:
            macrosig = macrosig.group(1)
        else:
            macrosig = f"UNKNOWN MACRO ({catched_path} at {catched_line})"
        errmes = f"Macro signature error. Incorrect number of parameters: {macrosig}; See module: {errored_file}"
    else:
        errmes = f"{error_message} [{catched_path} at {catched_line}]"
    
    if doPrettyPrint:
        log(f"Error:{errmes} \nfile:\t\t{errored_file}\n")
    else:
        log(f"::error file={errored_file},line=1{optionals}::{errmes}")
    

def read_src_file(file,line):
    #log(f"{workspace}\\{file} at {line-1}")
    f = open(f"{workspace}\\{file}",'r',encoding="utf8")
    lines=f.readlines()
    #log(f"READLINES: {lines[line-1 - 1]}")
    # index based
    curidx = line-1 - 1
    result = lines[curidx]
    if result.find("#define")==-1:
        curidx -= 1
        while result.find("#define")==-1 and curidx >= 0:
            result = lines[curidx] + " " + result
            curidx -= 1
    #log(f"RETURN{result}")
    return result

def handle_classinfo(mes : str):
    loadedClassesInfo.append(mes)

for line in content:
    parse_line(line)
    #log(f"data: {line}")

if hasErrors > 0:
    log(f"Errors detected: {hasErrors}")
    sys.exit(-5)

if len(content) == 0:
    log("Empty output file")
    sys.exit(-100)


if not hasSuccessMessage:
    log(f"Compilation failed...")
    sys.exit(-600)


log(f"No errors!")

if "GITHUB_STEP_SUMMARY" in os.environ :
        with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f :
            print("# Files:\n", file=f)
            __i = 0;
            for file in loadedFilesInfo:
                __i = __i + 1
                try:
                    log(f"Saving {file} ({__i})")
                    print(f"* {file}", file=f)
                except Exception as e:
                    log(f"::warning::Cannot output at line {__i};  {e};")

