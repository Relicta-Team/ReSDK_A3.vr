# Common deploy utility script
import os
import shutil
import sys
import zipfile
import re
import time
import enum
import datetime
from argparse import *
from glob import glob

from os.path import exists as fileExists
from os.path import abspath as getAbsPath
from os.path import dirname as getDirFromFile
from os.path import basename as getFilenameFromPath
from os.path import join as pathJoin
from shutil import copytree as dirCopy
from shutil import rmtree as dirRemove
from os import remove as fileRemove

def copyGlob(srcDir,pattern,destDir):
	"""Копирование директории/файлов по glob-паттерну"""
	for ff in glob(pathJoin(srcDir,pattern)):
		relpath = os.path.relpath(ff,srcDir)
		fileCopy(ff,pathJoin(destDir,relpath))

def fileCopy(src,dest):
	"""Копирование файла"""
	os.makedirs(getDirFromFile(dest),exist_ok=True)
	shutil.copyfile(src,dest)

def dirMove(source,destination):
	"""Перемещение директории"""
	files = os.listdir(source) 
	for file in files: 
		file_name = os.path.join(source, file) 
		shutil.move(file_name, destination)
	dirRemove(source)

def getPatternFromFile(path,pattern):
	"""Получить содержимое файла по regex-паттерну"""
	lst:list[str] = []
	with open(path,'r') as f:
		lst = re.findall(pattern,f.read())
	return lst

def exitIfError(condition,message):
	"""Выполняет оценку условия. При любом значении, отличном от истины выводит текст ошибки и принудительно завершает работу скрипта"""
	if not condition:
		printError(message)
		sys.exit(-1)

try:
	import requests
except:
	os.system("pip install requests")
	import requests


# special flag for local testing
DEBUG_MODE = False

CLI_PRELOAD : ArgumentParser = None
CLI:Namespace = None

#region Logging
def printDebug(data):
	"""Печать отладочного сообщения. Работает только с аргументами -d или --debug"""
	if CLI.debug:
		print("DEBUG: " + data)

def printError(data):
	"""Печать сообщения об ошибке."""
	if CLI.debug:
		print("ERROR: " + data)
	else:
		print(f"::error::{data}")

def printWarning(data):
	"""Печать предупреждения"""
	if CLI.debug:
		print("WARNING: " + data)
	else:
		print(f"::warning::{data}")

#endregion

def getCurrentWorkingDir():
	"""Получить текущую рабочую директорию"""
	return getAbsPath(getDirFromFile(sys.argv[0]))

#region CLI

def initParser()->ArgumentParser:
	"""Инициализация базовых аргументов командной строки"""
	
	global CLI_PRELOAD
	parser: ArgumentParser = ArgumentParser(prog="GH BUILD", description="Builds any dependency from github")
	parser.add_argument('-d',"--debug", action="store_true", help="Debug mode",dest="debug")
	#requiments path file
	parser.add_argument("-r", "--req", help="Requirements file path. By default relative to downloaded repo folder", dest="requirements",default='req_build.txt')
	parser.add_argument("-rpd", "--repo", help="Repository for dowloading", dest="repo")
	parser.add_argument("-t","--temp",help="Temporary folder",dest="tempFolder",default=pathJoin(getCurrentWorkingDir(),"TEMP"))
	parser.add_argument('-etv',"--env_token_var",help="Environment variable name for github API",dest="envTokenVar",default="DEPLOY_TOKEN",metavar="ENVIRONMENT_VARIABLE_NAME")
	parser.add_argument("--sdk",help="SDK specific root directory. By default: %(default)s",dest="sdk_path",default=getAbsPath(pathJoin(getCurrentWorkingDir(),"..","..")))	
	CLI_PRELOAD = parser
	return parser

def postInitParser():
	"""Постинициализация аргументов командной строки"""
	global CLI_PRELOAD
	global CLI
	CLI = CLI_PRELOAD.parse_args()

	if CLI.repo:
		if "/" not in CLI.repo:
			printError(f"Invalid repository name ({CLI.repo})")
			sys.exit(-1)

	return CLI

#endregion

def checkPip(reqTxt):
	"""Проверка установленных модулей pip"""
	reqPipLibs = False

	try:
		# test common pip modules
		import iniparser2
		import requests
		import setuptools
	except:
		reqPipLibs = True
	
	if not reqPipLibs and isGithubActions():
		reqPipLibs = True

	print("Reuired pip loading: " + str(reqPipLibs))

	if reqPipLibs:
		print(f"Installing dependencies from {reqTxt}")
		content = []
		with open(reqTxt,'r') as fhandle:
			content = fhandle.readlines()
		for dat in content:
			print(f"\tLIB: {dat}")

		installRes = os.system("pip install -r {}".format(reqTxt)) 
		printDebug("PIP install result: " + str(installRes))
		if installRes != 0:
			printError("PIP install error")
			return False
	
	return True

#region time helper

def dt_start():
	"""Возвращает текущее время в секундах"""
	return time.time()

def dt_end(start_time)->float:
	"""Возвращает разницу между текущим временем и значением start_time в секундах"""
	return round((time.time() - start_time),3)

#endregion

#region github api
	
class CommitInfo:
	"""Информация о коммите"""
	def __init__(self,commit_data):
		self.sha_full = commit_data["sha"]
		self.sha_short = commit_data["sha"][:7]
		self.message = commit_data["commit"]["message"]
		# link for repo snapshot
		self.repo_url = commit_data["html_url"]
		self.author = commit_data["commit"]["author"]["name"]
		self.commit_full_response = commit_data

def gh_checkToken():
	"""Проверка токена github, переданного в переменную окружения"""
	try:
		api_token = os.environ[CLI.envTokenVar]
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
			printError("INVALID TOKEN...")
		else:
			printError(f"ERROR TOKEN, STATUS: {response.status_code}")
		return False

	except Exception as e:
		printError("Can't check github token: " + str(e))
		return False

def gh_getLatestCommitInfo():
	"""Получает объект CommitInfo с информацией о последнем пользовательском коммите в репозитории"""
	# for example see: https://api.github.com/repos/Relicta-Team/ReSDK_A3.vr/commits
	try:
		api_token = os.environ[CLI.envTokenVar]
		repo_name = CLI.repo
		headers = {
			"Authorization": f"Bearer {	api_token }"
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
					printWarning(f"Empty commiter in sha: {commit_data['sha']}")
				
				printDebug(f'Check commit: {commit_data["sha"]} (bot: {isBot}):: {commit_data["commit"]["message"]}')
				
				if isBot: continue

				return CommitInfo(commit_data)
			
			# default return (no commit found)
			return None
		else:
			printError(f"Error fetching commit data from \"{api_url}\". Status code: {response.status_code}")
			return None

	except Exception as e:
		printError("Can't get latest commit info: " + str(e))
		return None
	

def gh_downloadRepository(commitInfo:CommitInfo):
	"""Загружает репозиторий во временную папку"""
	sha = commitInfo.sha_full
	url = commitInfo.repo_url
	repoUrl = CLI.repo
	tempFolder = CLI.tempFolder

	try:
		repoName = repoUrl.split('/')[1]

		url = f"https://github.com/{repoUrl}/archive/{sha}.zip"

		t = dt_start()
		print(f"Downloading {url}")
		response = requests.get(url,timeout=60*10)
		print(f"Repository downloaded in {dt_end(t)} sec.")
		repo_zip_path = os.path.join(tempFolder, '__archive__.zip')
		
		if fileExists(tempFolder):
			printDebug("Remove previous archive folder")
			dirRemove(tempFolder)

		if not fileExists(tempFolder):
			os.mkdir(tempFolder)

		with open(repo_zip_path, 'wb') as f:
			f.write(response.content)
		

		print(f"Unzipping to \"{tempFolder}\"")

		folder_name = "unknown"
		with zipfile.ZipFile(repo_zip_path, 'r') as zip_ref:
			# Получаем список файлов и каталогов в корне архива
			root_contents = zip_ref.namelist()
			folder_name = root_contents[0]
			#removing \ in last charachter folder_name
			folder_name = folder_name[:-1]
			zip_ref.extractall(tempFolder)
		
		print("Unzipped!")

		os.remove(repo_zip_path)
		if folder_name == "unknown":
			dirRemove(tempFolder)
			raise Exception("Corrupted archive")
		os.rename(pathJoin(tempFolder,folder_name), pathJoin(tempFolder,repoName))

	except Exception as e:
		printError("Exception:" + str(e))
		return False
	
	return True


def gh_getDownloadedRepoPath()->str:
	"""Получает путь к папке с загруженным репозиторием"""
	return pathJoin(CLI.tempFolder, CLI.repo.split('/')[1])

#endregion

#region building

class VersionInfo:
	"""Структура информации о версии компилируемой программы"""
	def __init__(self,ver_maj,ver_min,ver_path:str):
		company, projname = CLI.repo.split('/')

		self.vt_generated_path = pathJoin(CLI.tempFolder,projname,'__vinf_generated.txt')

		self.company_name = company
		self.file_description = f" "
		self.file_verion = f"{ver_maj}.{ver_min}.{ver_path}"
		self.internal_name = projname
		self.copyright = f'\\xa9 {company} 2017-{datetime.datetime.now().year}'
		self.original_filename = f'{projname}.exe'
		self.product_name = projname
		self.product_version = f"{ver_maj}.{ver_min}.{ver_path}"
		
		buildAsInt = 0
		if isinstance(ver_path,str) and len(ver_path) == 7 and re.match(r"^[0-9A-Fa-f]{7}$",ver_path):
			#buildAsInt = eval(f"0x{ver_path}")
			buildAsInt = 0
		else:
			if isinstance(ver_path,int):
				buildAsInt = ver_path
		_vinfList = [ver_maj,ver_min,buildAsInt,0]
		_vinfList = [int(x) for x in _vinfList]
		self.version_tuple = str(tuple(_vinfList))

	def applyToContent(self,content:str):
		dat = content.replace("VERSION_TUPLE",self.version_tuple)
		
		#in unix timestamp
		dt = datetime.datetime.now()
		tm = dt.timestamp()
		#dat = dat.replace("DATE_TIME_TUPLE",f"({dt},{tm})")
		dat = dat.replace("DATE_TIME_TUPLE",f"(0,0)")

		dat = dat.replace("COMPANY_NAME",self.company_name)
		dat = dat.replace("FILE_DESCRIPTION",self.file_description)
		dat = dat.replace("FILE_VERSION",self.file_verion)
		dat = dat.replace("INTERNAL_NAME",self.internal_name)
		dat = dat.replace("COPYRIGHT",self.copyright)
		dat = dat.replace("ORIGINAL_FILENAME",self.original_filename)
		dat = dat.replace("PRODUCT_NAME",self.product_name)
		dat = dat.replace("PRODUCT_VERSION",self.product_version)
		return dat

class ExecutableType(enum.Enum):
	"""Тип приложения для сборки - консольное или оконное"""
	Windowed = 1
	Console = 2

class CompilerCLI:
	"""Конфигурация компиляции программы"""
	def __init__(self,execT):
		self.addCommonArgs = True
		self.iconPath = None
		self.appName = CLI.repo.split('/')[1]
		self.hiddenImports = []
		self.additionalHooksDir = None
		self.paths = []
		self.mainScriptPath = None
		
		#self.uacAccess = False

		self.executableType = execT

	def build(self):
		cli = []
		if self.addCommonArgs:
			cli.append("--noconfirm")
			cli.append("--onefile")
		
		if self.executableType == ExecutableType.Console:
			cli.append("--console")
		elif self.executableType == ExecutableType.Windowed:
			cli.append("--windowed")
	
		#cli.append("--disable-windowed-traceback")

		# if self.uacAccess:
		# 	cli.append("--uac-uiaccess")
		#cli.append('--uac-admin')

		if self.iconPath:
			cli.append(f"--icon \"{self.iconPath}\"")
		if self.appName:
			cli.append(f"--name \"{self.appName}\"")
		if self.hiddenImports:
			for imp in self.hiddenImports:
				cli.append(f"--hidden-import \"{imp}\"")
		if self.additionalHooksDir:
			cli.append(f"--additional-hooks-dir \"{self.additionalHooksDir}\"")
		if self.paths:
			cli.append(f"--paths \"{';'.join(self.paths)}\"")
		if self.mainScriptPath:
			cli.append(f"\"{self.mainScriptPath}\"")
		return ' '.join(cli)
	
	def validate(self):
		if self.iconPath and not fileExists(self.iconPath):
			printError(f"Can't find icon file: {self.iconPath}")
			return False
		if self.mainScriptPath and not fileExists(self.mainScriptPath):
			printError(f"Can't find main script: {self.mainScriptPath}")
			return False
		for p in self.paths:
			if not fileExists(p):
				printError(f"Can't find path: {p}")
				return False
		if not fileExists(self.mainScriptPath):
			printError(f"Can't find main script: {self.mainScriptPath}")
			return False
		return True

def buildPythonScript(versionInfo:VersionInfo,cmpCLI:CompilerCLI,workdir:str=""):
	"""
		Запуск компиляции python приложения
	"""
	print("Start building...")
	reqFilePath = getAbsPath(pathJoin(workdir,CLI.requirements))
	if not checkPip(reqFilePath): return ""
	
	vtempfile = pathJoin(getCurrentWorkingDir(),"version_template.txt")
	if not fileExists(vtempfile):
		printError(f"Can't find verions template file: {vtempfile}")
		return ""
	
	content = ""
	with open(vtempfile) as f:
		content = f.read()
	
	if content == "":
		printError("Version template file is empty")
		return ""

	newContent = versionInfo.applyToContent(content)
	with open(versionInfo.vt_generated_path,'w') as f:
		f.write(newContent)

	print("Prepared version info file: " + versionInfo.vt_generated_path)

	vinfAbs = getAbsPath(versionInfo.vt_generated_path)
	if not fileExists(vinfAbs):
		printError(f"Can't find verions info file: {vinfAbs}")
		return ""
	
	if not cmpCLI.validate():
		printError("Validation failed")
		return ""

	compilerCommand = cmpCLI.build()
	
	compilerCommand += f" --version-file \"{vinfAbs}\""
	
	print("PYINSTALLER CLI: " + compilerCommand)
	print(f"CWD: {os.getcwd()}")
	print(f"Exec CWD: {workdir}")
	t = dt_start()
	curDir = os.getcwd()
	os.chdir(os.path.join(workdir))
	return_ = os.system("pyinstaller " + compilerCommand)
	os.chdir(curDir)
	printDebug("Compiler result " + str(return_))
	if return_ != 0:
		printError("Compiler error: Code " + str(return_))
		return ""
	
	appOut = pathJoin(workdir,'dist',cmpCLI.appName) 
	
	print(f"Compiled at {dt_end(t)}; Output: {appOut}")
	
	return appOut

#endregion

def isGithubActions():
	return os.getenv('GITHUB_OUTPUT') != None

def writeToGithubOutput(key:str,value:str):
	"""Записывает в переменную среды GITHUB_OUTPUT ключ и значение"""
	env_file = os.getenv('GITHUB_OUTPUT')
	if env_file is None: return
	with open(env_file, "a") as f:
		f.write(f"{key}={value}\n")