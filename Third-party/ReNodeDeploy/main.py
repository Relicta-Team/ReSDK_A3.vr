# ReNode deploy script
import os
import shutil
import sys
import zipfile

try:
	import requests
except:
	os.system("pip install requests")
	import requests

import re

DEBUG_MODE = False
REPOPATH = "Relicta-Team/ReNodes"
TEMP_FOLDER = ".\\TEMP\\"
RELEASEREPONAME = "RENODE_TEMP"

args = sys.argv
curAppDir = os.path.dirname(args[0])
if len(args) < 2:
	print("Need path for dest directory")
	sys.exit(-1)

renodeDir = os.path.realpath(args[1])

def printDebug(data):
	if DEBUG_MODE:
		print("DEBUG:" + data)

print("ReNode dir: " + renodeDir)
if not os.path.exists(renodeDir) or not os.path.isdir(renodeDir):
	print("ReNode dir not found")
	sys.exit(-1)

# downloading repo
def check_github_token(api_token):
	headers = {
		'Authorization': f'Bearer {api_token}' #Bearer
	}

	api_url = 'https://api.github.com/user'  # Здесь можно использовать любой другой endpoint API
	print("Check github token")
	response = requests.get(api_url, headers=headers,timeout=60)

	if response.status_code == 200:
		user_data = response.json()
		printDebug(f"TOKEN OK - : {user_data['login']}")
		return True
	elif response.status_code == 401:
		printDebug("INVALID TOKEN...")
	else:
		print(f"ERROR TOKEN, STATUS: {response.status_code}")
	return False


if not check_github_token(os.environ['RENODE_DEPLOY_TOKEN']):
	print("Github token invalid")
	sys.exit(-2)

def get_latest_commit_hash(repo_name, access_token,ref="main"):
	
	headers = {
		"Authorization": f"Bearer {access_token}"
	}
	printDebug("Get latest commit sha")
	api_url = f"https://api.github.com/repos/{repo_name}/commits"
	response = requests.get(api_url, headers=headers,timeout=60)
	
	if response.status_code == 200:
		commit_data_all = response.json()
		for commit_data in commit_data_all:
			isBot = True
			if commit_data['committer']!=None:
				isBot = commit_data['committer']['type'] == "Bot"
			else:
				print(f"Empty commiter in sha: {commit_data['sha']}")
			printDebug(f'Check commit: {commit_data["sha"]} (bot: {isBot}):: {commit_data["commit"]["message"]}')
			if isBot:
				continue
			return {
				"sha":commit_data["sha"],
				"mes":commit_data['commit']["message"],
				"url":commit_data['html_url'],
			}
		
		# default return (no commit found)
		return None
	else:
		print(f"Error fetching commit data. Status code: {response.status_code}")
		return None

dictInfo = get_latest_commit_hash(REPOPATH,os.environ['RENODE_DEPLOY_TOKEN'])
if dictInfo == None:
	print("No commit found")
	sys.exit(-3)

print(f"Latest commit: {dictInfo['sha']}")
print(f"Commit message: {dictInfo['mes']}")
print("Downloading repo from {}".format(dictInfo['url']))

def downloadRepo(url,sha):
	try:
		url = f"https://github.com/{REPOPATH}/archive/{sha}.zip"
		tempfolder = os.path.abspath(TEMP_FOLDER)
		release_folder = os.path.join(tempfolder, RELEASEREPONAME)

		if not os.path.exists(tempfolder):
			os.mkdir(tempfolder)

		#region Download
		print("Downloading repository...")
		response = requests.get(url,timeout=60*10)
		print("Repository downloaded. Unzipping...")
		repo_zip_path = os.path.join(tempfolder, 'release.zip')
		
		if os.path.exists(repo_zip_path):
			print("Remove previous archive")
			os.remove(repo_zip_path)
		if os.path.exists(release_folder):
			print("Remove previous RELEASE folder")
			shutil.rmtree(release_folder)

		with open(repo_zip_path, 'wb') as f:
			f.write(response.content)
		
		folder_name = "unknown"
		with zipfile.ZipFile(repo_zip_path, 'r') as zip_ref:
			# Получаем список файлов и каталогов в корне архива
			root_contents = zip_ref.namelist()
			folder_name = root_contents[0]
			#removing \ in last charachter folder_name
			folder_name = folder_name[:-1]
			zip_ref.extractall(tempfolder)
		print("Unzipped.")
		os.remove(repo_zip_path)
		if folder_name == "unknown":
			shutil.rmtree(tempfolder)
			raise Exception("Corrupted release archive")
		os.rename(os.path.join(tempfolder,folder_name), release_folder)
		#endregion

		#--------------------------------------------------------------------

		#region Deploy
		
		# print("Updating version...")
		# full_commit_hash = sha
		# repo_name_fold = RELEASEREPONAME
		# srcFolder = os.path.join(tempfolder,repo_name_fold,"Src")
		# path_private = config.get("private_header_path")
		# if not os.path.exists(path_private):
		#     print("Cannot load version. Private file not found.")
		#     discordWebhook(f"{config.get('notif_group')} DEPLOY VERSION ERROR: Cannot load version. Private file not found.")
		#     return False
		# if not os.path.exists(srcFolder):
		#     print("Cannot load version. Source folder not found.")
		#     discordWebhook(f"{config.get('notif_group')} DEPLOY VERSION ERROR: Cannot load version. Source folder not found.")
		#     return False

		# print("Emplace private header")
		# shutil.copyfile(path_private,srcFolder+"\\private.h")

		# print("Copy remaker config")
		# remakerFolder = os.path.join(tempfolder,repo_name_fold,"ReMaker")
		# shutil.copyfile(config.get("remaker_config_path"),remakerFolder + "\\config.ini")

		# print("Sync version/revision")
		# with open(srcFolder + "\\VERSION","w",encoding='utf-8') as f:
		#     f.write(f"{vername}")
		#     f.close()

		# with open(srcFolder + "\\REVISION","w",encoding='utf-8') as f:
		#     f.write(full_commit_hash)

		# import re
		# with open(srcFolder + "\\CHANGELOGS.txt","w",encoding='utf-8') as f:
		#     textchanges = re.sub(r'\r\n', '<br/>', textchanges)
		#     f.write(textchanges)

		# #run remaker process
		# print("Run remaker")
		# argsList = [remakerFolder + "\\remaker.exe", "build=client", "build=server"]
		# print("ReMaker CLI args: " + str(argsList))
		# code = subprocess.run(argsList).returncode
		# print("Remaker returned code: " + str(code))

		# if code != 0:
		#     shutil.rmtree(os.path.join(tempfolder, repo_name_fold))
		#     raise Exception("Remaker returned code: " + str(code))

		# print("removing unpacked repo")
		# shutil.rmtree(os.path.join(tempfolder, repo_name_fold))
		# #endregion

		# if not doUpdateChangelog_workflow(config.get('reponame'),config.get('api_key'),textchanges):
		#     discordWebhook(f"Cant update changelogs on {config.get('reponame')}")
		#     return False

	except Exception as e:
		print("Exception:" + str(e))
		return False
	
	return True

if not downloadRepo(dictInfo['url'],dictInfo['sha']):
	print("repo process error")
	sys.exit(-3)

tempfolder = os.path.abspath(TEMP_FOLDER)
tempRenodeDir = os.path.join(tempfolder, RELEASEREPONAME)
deployProjectPath = renodeDir
#reqTxt = os.path.join(tempRenodeDir, "requirements.txt")
reqTxt = os.path.join(curAppDir,"req_build.txt")
print("Installing pip libs")

if 'DISABLE_INSTALL_REQUIREMENTS' in os.environ:
	print("Skipping requirements installation because DISABLE_INSTALL_REQUIREMENTS is set")
else:
	installRes = os.system("pip install -r {}".format(reqTxt)) 
	print("PIP install result: " + str(installRes))
	if installRes != 0:
		print("PIP install error")
		sys.exit(-10)

print("syncing version info")
shaShort = dictInfo['sha'][:7]
pathRevisionFile = os.path.join(tempRenodeDir,"ReNode\\app\\REVISION.py")
pathVersionFile = os.path.join(tempRenodeDir,"ReNode\\app\\VERSION.py")
shaShort = str(shaShort).replace('\\n', '').replace('\r','').replace('\n','')
with open(pathRevisionFile, 'w') as f:
	f.write("global_revision = \"" + str(shaShort) + "\"")
print("ReNode revision: " + str(shaShort))

versioncontent = ""
with open(pathVersionFile) as f:
	versioncontent = f.read()
# regex get version values from array
version = re.findall(r'\d+', versioncontent)
version = [int(x) for x in version]
vinfList__ = [version[0],version[1],0,0]
fullVerTUPLE = str(tuple(vinfList__))
fullVerFULL = f'{version[0]}.{version[1]}.{shaShort}'

iconPath = os.path.join(tempRenodeDir,"data","icon.ico")
if not os.path.exists(iconPath):
	raise Exception("Icon \"{}\" not found".format(iconPath))

mainScriptPath = os.path.join(tempRenodeDir,"main.py")
if not os.path.exists(mainScriptPath): raise Exception("Script \"{}\" not found".format(mainScriptPath))
nodeGraphLibPath = os.path.join(tempRenodeDir,"NodeGraphQt-0.6.11")

#prep version manifest

vfile_ = os.path.join(curAppDir,"RENODE_VER.txt")
vfile_gen = os.path.join(curAppDir,"RENODE_VER_GEN.txt")
if os.path.exists(vfile_gen): os.remove(vfile_gen)

#modify version file
vfileInfo = ""
with open(vfile_, 'r') as f: vfileInfo = f.read()
vfileInfo = vfileInfo.replace("VER_TUPLE",fullVerTUPLE).replace("VER_FULL",fullVerFULL)
with open(vfile_gen, 'w') as f: f.write(vfileInfo)

vfile_gen = os.path.realpath(vfile_gen) #full path

data = f"pyinstaller --noconfirm --onefile --windowed --icon \"{iconPath}\" --name \"ReNode\" --hidden-import \"NodeGraphQt\" --additional-hooks-dir \"{nodeGraphLibPath}\" --paths \"{tempRenodeDir}\"  \"{mainScriptPath}\" --version-file \"{vfile_gen}\""
print("PYINSTALLER CLI: " + data)
curDir = os.getcwd()
os.chdir(os.path.join(tempRenodeDir))
return_ = os.system(data)
os.chdir(curDir)
print("Compiler result " + str(return_))
if return_ != 0:
	raise Exception("Compiler error: Code " + str(return_))

#cleanup deploy folder
print(f'Exists data: {os.path.exists(deployProjectPath + "/data")}')
if os.path.exists(deployProjectPath + "/data"): shutil.rmtree(deployProjectPath + "/data")
print(f'Exists executable: {os.path.exists(deployProjectPath + "/ReNode.exe")}')
if os.path.exists(deployProjectPath + "/ReNode.exe"): os.remove(deployProjectPath + "/ReNode.exe")

print("Copy files...")

dest = deployProjectPath

shutil.copytree(os.path.join(tempRenodeDir,'data'),dest+"/data")
shutil.copyfile(os.path.join(tempRenodeDir,'dist/ReNode.exe'),dest+"/ReNode.exe")

os.environ['RENODE_DEPLOY_BUILD_VER'] = fullVerFULL

env_file = os.getenv('GITHUB_ENV')

with open(env_file, "a") as f:
    f.write("RENODE_FULL_VERSION={}".format(fullVerFULL))

print("WORK DONE!")