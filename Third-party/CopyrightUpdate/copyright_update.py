import sys
import re
import os
import datetime
import time

timestamp = int(time.time()*1000.0)

try:
    prettyPrint = 'pretty' in sys.argv
    skipUpdate = 'nosave' in sys.argv
    errorCount = 0
    warnCount = 0
    def error(mes,file=None):
        global errorCount
        global prettyPrint
        errorCount += 1
        if prettyPrint:
            if file:
                print(f"::error file={file}::{mes}")
            else:
                print(f"::error ::{mes}")
        else:
            fempl = f' ({file})' if file else ""
            print(f"[ERROR] {mes}{fempl}")
    def warn(mes,file=None):
        global warnCount
        global prettyPrint
        warnCount += 1
        if prettyPrint:
            if file:
                print(f"::warning file={file}::{mes}")
            else:
                print(f"::warning ::{mes}")
        else:
            fempl = f' ({file})' if file else ""
            print(f"[LOG]: {mes}{fempl}")

    def log(mes,file=None):
        global prettyPrint
        if prettyPrint:
            if file:
                print(f"::notice file={file}::{mes}")
            else:
                print(f"::notice ::{mes}")
        else:
            fempl = f' ({file})' if file else ""
            print(f"[LOG]: {mes}{fempl}")

    currentYear = datetime.datetime.now().year
    srcCopyrightTemplate = "template.txt"
    serachDir = "./../../Src"
    relativeDir = "./../.."
    noErrorFiles = ["src/changelogs.txt"]
    ignoreDirs = [
        'src/host/GameModes/scripted_loader.hpp',
        'src/host/MapManager/Maps/',
        'src/Scripts/vs_studio_project/vs_studio_project',
        'src/host/ReNode/compiled/',
        'src/Editor/Bin/Maps/',
        'src/Editor/Bin/ProtoMap/',
        'src/version.hpp',
        'src/client/ProxyItems/RProx_cfg.h',
        "src/host/LootSystem/loader.sqf"
    ]
    

    curDir = os.getcwd()
    print(f'CWD: {curDir}')
    if curDir.split('/')[-1].lower() == 'src':
        curDir = os.chdir(os.path.join(curDir,'../third-party/opyrightupdate'))

    print(f'CWD final: {os.getcwd()}')

    content = []
    includeExtensions = ["sqf","cpp","hpp","h",'interface','cs']

    def find_files(root_dir, relToRootDir=False):
        files = []
        for dirpath, dirnames, filenames in os.walk(root_dir):
            if relToRootDir:
                    dirpath = os.path.relpath(dirpath,root_dir)
            for filename in filenames:
                files.append(os.path.join(dirpath, filename))
        return files

    #load template
    with open(srcCopyrightTemplate,'r+',encoding='utf-8') as f:
        content = f.readlines()

    print("Content count: {}".format(len(content)))
    print("Search directory: {}".format(serachDir))

    flistGlob = find_files(serachDir,relToRootDir=False)
    for file in flistGlob:
        fileName = os.path.relpath(file,relativeDir)
        print(f'Check file: {fileName} ({file})')
        if not [ext for ext in includeExtensions if file.lower().endswith(ext)]:
            #print(f"\t\t--- SKIPPED: {fileName}")
            continue
        if [fp for fp in ignoreDirs if fp.lower() in fileName.lower()]:
            continue
        #print(f'File: {fileName}')
        llist = []

        with open(file,mode='r+',encoding='utf-8') as fh:
            llist = fh.readlines()
            
        if len(llist) < 4:
            if fileName.lower() in noErrorFiles:
                continue
            else:
                warn("Unregistered file type",fileName)
        
        if llist[0]!=content[0]:
            warn("Copyright header not found. Creating header...",fileName)
            #emplacing copyright
            for i in range(3,-1,-1):
                elCont = content[i].format(CURRENT_YEAR=2000)
                llist.insert(0,elCont)
            if llist[4] != '\n': #add next line after copyright header
                llist.insert(4,'\n')
            pass
        
        l2 = llist[1] #this line need checks

        yearsParts = re.findall(r"\d+",l2)
        if len(yearsParts)!=3:
            error(f"Damaged copyright; Numbers get {len(yearsParts)}, need 3: {l2}",fileName)
            continue
        if yearsParts[0]!="2017" or yearsParts[2]!="3":
            error(f"Damaged copyright; Year start {yearsParts[0]} (need 2017), end {yearsParts[2]} (need 3): {l2}",fileName)
            continue
        oldYear = yearsParts[1]

        hasAnyUpdate = False
        for i in range(4):
            curContent = content[i]
            curLList = llist[i]
            if i==1:
                curContent = curContent.format(CURRENT_YEAR=oldYear)
            replCont = content[i].format(CURRENT_YEAR=currentYear)
            if curContent == curLList and replCont != curLList:
                llist[i] = replCont
                hasAnyUpdate = True
        
        if hasAnyUpdate:
            with open(file,mode='w+',encoding='utf-8') as fh:
                if not skipUpdate:
                    fh.writelines(llist)
                log(f"Updated {oldYear} -> {currentYear} in {fileName}",fileName)

        pass
    
    if not flistGlob:
        raise Exception("Empty filelist")

    timeDiff = int(time.time()*1000.0) - timestamp
    log(f'Done at {timeDiff} ms')
    log(f'Warnings: {warnCount}')
    log(f'Errors: {errorCount}')

    if errorCount > 0:
        exit(-2)

    exit(0)
except Exception as ex:
    print("---------- EXCEPTION ON PROCESS ----------")
    print(ex.with_traceback(sys.exc_info()[2]))
    print("")
    exit(-1)