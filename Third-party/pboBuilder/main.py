import shutil
import os
import sys
import glob
import subprocess

AB_PATH = "P:\\armatools\\steamapps\\common\\Arma 3 Tools\\AddonBuilder\\AddonBuilder.exe"

KEY_PATH = "P:\\armatools\\steamapps\\common\\Arma 3 Tools\\DSSignFile\\RelictaReborn.biprivatekey"

DEST_PATH = "P:\\armatools\\steamapps\\common\\Arma 3\\@RLCT\\Addons"

args = []
print("======== START =========")

def quote(s):
	return '"' + s + '"'

def processPack(srcFullPath):
	argsCopy = args.copy()
	pfxDir = os.path.join(srcFullPath, "$PREFIX$")
	if os.path.exists(pfxDir):
		with open(pfxDir, "r") as f:
			prefix = f.read().strip()
		argsCopy.append("-prefix="+quote(prefix))

	# start with args and wait exit
	line = quote(AB_PATH) + " " +quote(srcFullPath)+" "+quote(DEST_PATH)+" "+ " ".join(argsCopy)
	#print("RUNTIME: " + line + "\n\n")
	r = subprocess.call(line, shell=True)
	return r

if "bin" not in sys.argv:
	args.append("-packonly")
if "noclear" not in sys.argv:
	args.append("-clear")
if "pref" in sys.argv:
	args.append("-prefix="+quote(sys.argv[sys.argv.index("pref") + 1]))

args.append("-sign="+quote(KEY_PATH))

#args.append("-include="+quote("*.p3d;*.paa;*.ogg;*.wav;*.sqf;*.sqc;*.h;*.hpp"))

if not os.path.exists(DEST_PATH):
	print("Error: destination path not found: " + DEST_PATH)
	exit(-1)

if "root" in sys.argv:
	rootdir = sys.argv[sys.argv.index("root") + 1]
	
else:
	rootdir = input("Enter root directory: ")

# check root
if not os.path.exists(rootdir):
	print("Error: root path not found: " + rootdir)
	exit(-1)
if not os.path.isdir(rootdir):
	print("Error: root path is not directory: " + rootdir)
	exit(-1)

if "src" in sys.argv:
	addons = sys.argv[sys.argv.index("src") + 1]
else:
	addons = input("Enter source directory (one or more with separator ';'): ")

pathes = []
for addon in addons.split(";"):
	#if addon is glob pattern then parse and add folders

	if "*" in addon:
		for f in glob.glob(os.path.join(rootdir, addon), recursive=False):
			fullpath = os.path.join(rootdir, f)
			if not os.path.exists(fullpath):
				print("Error: full path not found: " + fullpath)
				exit(-1)
			if not os.path.isdir(fullpath):
				print("Error: full path is not directory: " + fullpath)
				exit(-1)
			print("APPEND ADDON (from glob): " + f)
			pathes.append(fullpath)
		continue

	fullpath = os.path.join(rootdir, addon)
	if not os.path.exists(fullpath):
		print("Error: full path not found: " + fullpath)
		exit(-1)
	if not os.path.isdir(fullpath):
		print("Error: full path is not directory: " + fullpath)
		exit(-1)
	print("APPEND ADDON: " + addon)
	pathes.append(fullpath)

input("Press any key to continue...")

r = 0
for path in pathes:
	print("PROCESSING: " + path)
	r = processPack(path)
	if (r != 0):
		print("\tERROR on process: " + path + "( exit code: " + str(r) + ")")
		break

print("Exit code: " + str(r))
print("DONE!!!")