
import os
import shutil
import tools

TEMP_FOLDER = os.path.join(os.path.dirname(__file__), 'build')
SDK_ROOT = os.path.join(os.path.dirname(__file__),'..','..')
SDK_FOLDER = os.path.join(SDK_ROOT, 'Src')
EXCLUDED_PATHES=[
	"private.h",
	"CHANGELOGS.txt",

	#legacy maps and not-needed
	"Maps old_editor",
	"host\\MapManager\\*.sqf",

	"Editor",
	".vscode",
	"Scripts",
	"ReBridge",
	"*.py",
	"*.md"
]


#cleanup temp dir
if os.path.exists(TEMP_FOLDER):
	shutil.rmtree(TEMP_FOLDER)

sources = os.path.join(TEMP_FOLDER, "singleplayer.vr","Src")
tools.copy_directory_excluding(SDK_FOLDER, sources, exclude=EXCLUDED_PATHES)

# replacing config.cpp
destCfg = os.path.join(sources, "config.cpp")
srcCfg = os.path.join(os.path.dirname(__file__), "config.cpp")

if os.path.exists(srcCfg):
	shutil.copy(srcCfg, destCfg)
	print("Replaced config.cpp")
else:
	print("config.cpp not found in ", srcCfg)

# replacing base config
bc_from = os.path.join(os.path.dirname(__file__), "base_config.cpp")
bc_to = os.path.join(TEMP_FOLDER,"config.cpp")
if os.path.exists(bc_from):
	shutil.copy(bc_from, bc_to)
	print("Replaced base config")
else:
	print("base config not found in ", bc_from)

# add ui folder to build\singleplayer.vr
ui_folder_from = os.path.join(SDK_ROOT, "Resources","ui_schemas")
ui_folder_to = os.path.join(TEMP_FOLDER,"singleplayer.vr","ui")
if os.path.exists(ui_folder_from):
	shutil.copytree(ui_folder_from, ui_folder_to)
	print("Added ui folder")
else:
	print("ui folder not found in ", ui_folder_from)

stdFiles = [
	"initPlayerLocal.sqf",
	"initServer.sqf"
]
for file in stdFiles:
	baseFileFrom = os.path.join(SDK_ROOT,file)
	destFileTo = os.path.join(TEMP_FOLDER,"singleplayer.vr",file)
	if os.path.exists(baseFileFrom):
		shutil.copy(baseFileFrom, destFileTo)
		print("Added ", file)
	else:
		print("file not found in ", baseFileFrom)

# copy files from RBuilder\deploy\client
stdFiles = [
	"description.ext",
	"mission.sqm"
]
for file in stdFiles:
	baseFileFrom = os.path.join(SDK_ROOT, "RBuilder","deploy","client",file)
	destFileTo = os.path.join(TEMP_FOLDER,"singleplayer.vr",file)
	if os.path.exists(baseFileFrom):
		shutil.copy(baseFileFrom, destFileTo)
		print("Added ", file)
	else:
		print("file not found in ", baseFileFrom)


if "yes" in input("Copy to debug unpacked pbo? (yes/any...)"):
	dest = "P:\\armatools\\steamapps\\common\\Arma 3\\sp_mode"
	if os.path.exists(dest):
		print("Removing old src...",dest)
		shutil.rmtree(dest)
	print("copy from",TEMP_FOLDER,"to",dest)

	shutil.copytree(TEMP_FOLDER, dest)

print("DONE")
