import sys
import re
import os

executeDir = os.path.relpath(os.path.dirname(sys.argv[0]),"..\\")
srcCopyrightTemplate = "template.txt"
serachDir = ".\\..\\..\\src"

content = []
includeExtensions = ["sqf","cpp","hpp","h",'interface','txt']

def find_files(root_dir, relToRootDir=False):
    files = []
    for dirpath, dirnames, filenames in os.walk(root_dir):
        if relToRootDir:
                dirpath = os.path.relpath(dirpath,root_dir)
        for filename in filenames:
            files.append(os.path.join(dirpath, filename))
    return files

#load template
with open(srcCopyrightTemplate,'r',encoding='utf-8') as f:
    content = f.readlines()

for file in find_files(serachDir,relToRootDir=True):
    print(f'File: {file}')
    pass

