from build_util import *

cli = initParser()

args = postInitParser()

exitIfError(gh_checkToken(),"Token validation failed")

v = gh_getLatestCommitInfo()
exitIfError(v,"No commits found")

exitIfError(gh_downloadRepository(v),"Failed to download repository")

src = gh_getDownloadedRepoPath()

pathVersionFile = pathJoin(src,"APP_VERSION.py")
verInf = getPatternFromFile(pathVersionFile,r"\d+")
exitIfError(verInf,"Corrupted VERSION.py")
exitIfError(len(verInf)==3,"Сorrupted data in VERSION.py")
verInf = [int(x) for x in verInf]

# file helers
iconPath = pathJoin(src,"icon.ico")
exitIfError(fileExists(iconPath),"icon.ico not found")

vinf = VersionInfo(verInf[0],verInf[1],verInf[2])
vinf.file_description = "RVEngine VM executor, compiler, parser, static analyzer in one application."
vinf.product_name = "Relicta Build Tool"
_dt = datetime.datetime.now()
vinf.file_verion = f'{vinf.file_verion} ({_dt.strftime("%H:%M:%S %d.%m.%Y")})'
vinf.original_filename = "rbuilder.exe"

cli = CompilerCLI(ExecutableType.Console)
#cli.uacAccess = True
cli.iconPath = iconPath
cli.appName = "rb.exe"

cli.hiddenImports.append("Builder")
cli.hiddenImports.append("packlib")
cli.hiddenImports.append("yaml")

cli.paths.append(pathJoin(src,"Builder"))
cli.paths.append(pathJoin(src,"packlib"))
cli.paths.append(pathJoin(src,"yaml"))

cli.mainScriptPath = pathJoin(src,"app.py")

compiledPath = buildPythonScript(vinf,cli,src)
exitIfError(compiledPath!="","Build error")

#copy to root
fileCopy(compiledPath,pathJoin(src,cli.appName))

# copy to sdk destination
dest = pathJoin(args.sdk_path,"RBuilder")

files = [
	cli.appName,
	"config.yml",
	"DEPLOY.bat",
	"DB\\GameMain.db",
	"loader\\description.ext",
	"loader\\init.sqf",
	"loader\\mission.sqm",
	"mdl_loader\\config.cpp",
	"preload\\*.*",
	"deploy\\*.*",
	"deploy\\client\\*.*",
	"deploy\\editor\\*.*",
	"deploy\\editor\\Addons\\*.*",
	"deploy\\editor\\db\\*.*",
	"VM\\@server\\ru",
	"VM\\@server\\*.dll",
	"VM\\dll",
	"VM\\dta",
	"VM\\mpmissions\\__cur_mp.VR",
	"VM\\*.cfg",
	"VM\\*.dll",
	"VM\\*.txt",
]
# dest_exe = pathJoin(dest,)
# yml_cfg = pathJoin(dest,"config.yml")

print("Cleanup RBuilder directory")
if fileExists(dest): dirRemove(dest)

try:
	for pathInfo in files:

		print("Copy source: " + pathInfo)

		srcPath = pathJoin(src,pathInfo)
		destPath = pathJoin(dest,pathInfo)
		if os.path.isfile(srcPath):
			fileCopy(srcPath,destPath)
		elif os.path.isdir(srcPath):
			dirCopy(srcPath,destPath)
		elif "*" in srcPath:
			copyGlob(src,pathInfo,dest)
		else:
			printError(f"Unknown source type: {srcPath}")
except Exception as e:
	printError(str(e))
	exit(-1)
	




# fileCopy(compiledPath,dest_exe)

writeToGithubOutput("RBUILDER_FULL_VERSION",vinf.product_version)
