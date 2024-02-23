import sys
import re
import os
import datetime

try:

    def error(mes,file=None):
        if file:
            print(f"::error file={file}::{mes}")
        else:
            print(f"::error ::{mes}")
    def warn(mes,file=None):
        if file:
            print(f"::warning file={file}::{mes}")
        else:
            print(f"::warning ::{mes}")

    def log(mes,file=None):
        if file:
            print(f"::notice file={file}::{mes}")
        else:
            print(f"::notice ::{mes}")

    currentYear = datetime.datetime.now().year
    srcCopyrightTemplate = "template.txt"
    serachDir = ".\\..\\..\\src"
    relativeDir = ".\\..\\.."
    noErrorFiles = ["src\\changelogs.txt"]

    curDir = os.getcwd()
    if curDir.split('\\')[-1].lower() == 'src':
        curDir = os.chdir(os.path.join(curDir,'..\\third-party\\copyrightupdate'))

    content = []
    includeExtensions = ["sqf","cpp","hpp","h",'interface','txt','cs']

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

    for file in find_files(serachDir,relToRootDir=False):
        fileName = os.path.relpath(file,relativeDir)
        if not [ext for ext in includeExtensions if file.lower().endswith(ext)]:
            print(f"\t\t--- SKIPPED: {fileName}")
            continue
        #print(f'File: {fileName}')
        llist = []

        with open(file,mode='r+',encoding='utf-8') as fh:
            llist = fh.readlines()
            
        if len(llist) < 4:
            if fileName.lower() not in noErrorFiles:
                warn("Copyright header not found",fileName)
            continue
        l2 = llist[1] #this line need checks

        yearsParts = re.findall("\d+",l2)
        if len(yearsParts)!=3:
            error(f"Damaged copyright; Numbers get {len(yearsParts)}, need 3: {l2}",fileName)
            continue
        if yearsParts[0]!="2017" or yearsParts[2]!="3":
            error(f"Damaged copyright; Year start {yearsParts[0]} (need 2017), end {yearsParts[2]} (need 3): {l2}",fileName)
            continue
        oldYear = yearsParts[1]

        for i in range(4):
            curContent = content[i]
            curLList = llist[i]
            if i==1:
                curContent = curContent.format(CURRENT_YEAR=oldYear)
            if curContent != curLList:
                replCont = content[i].format(CURRENT_YEAR=currentYear)
                llist[i] = replCont
            
        with open(file,mode='w',encoding='utf-8') as fh:
            fh.writelines(llist)
            log(f"Updated from {oldYear} to {currentYear} for {fileName}",fileName)

        pass
        

    exit(0)
except Exception as ex:
    print("---------- EXCEPTION ON PROCESS ----------")
    print(ex.with_traceback(sys.exc_info()[2]))
    print("")
    exit(-1)