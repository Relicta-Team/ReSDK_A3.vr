
import os
import shutil
import tools

TEMP_FOLDER = os.path.join(os.path.dirname(__file__), 'build')
SDK_FOLDER = os.path.join(os.path.dirname(__file__),'..','..', 'Src')
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


tools.copy_directory_excluding(SDK_FOLDER, TEMP_FOLDER, exclude=EXCLUDED_PATHES)

