from build_util import *

cli = initParser()

args = postInitParser()

exitIfError(gh_checkToken(),"Token validation failed")

v = gh_getLatestCommitInfo()
exitIfError(v,"No commits found")

exitIfError(gh_downloadRepository(v),"Failed to download repository")

src = gh_getDownloadedRepoPath()

pathVersionFile = pathJoin(src,"ReNode\\app\\VERSION.py")
pathRevisionFile = pathJoin(src,"ReNode\\app\\REVISION.py")
iconPath = pathJoin(src,"data","icon.ico")

exitIfError(fileExists(pathVersionFile),"VERSION.py not found")
exitIfError(fileExists(pathRevisionFile),"REVISION.py not found")
exitIfError(fileExists(iconPath),"icon.ico not found")


with open(pathRevisionFile,'w') as f:
	f.write("global_revision = \"" + str(v.sha_short) + "\"")

verInf = getPatternFromFile(pathVersionFile,r"\d+")
if not verInf:
	raise Exception("Corrupted VERSION.py")
maj_v = verInf[0]
min_v = verInf[1]

vobj = VersionInfo(maj_v,min_v,v.sha_short)
vobj.file_description = "Visual scripting editor"
vobj.product_name = "Relicta Node Editor"
_dt = datetime.datetime.now()
vobj.file_verion = f'{vobj.file_verion} ({_dt.strftime("%H:%M:%S %d.%m.%Y")})'

cmpCli = CompilerCLI(ExecutableType.Windowed)
cmpCli.iconPath = iconPath
cmpCli.appName = "ReNode.exe"
cmpCli.hiddenImports.append("NodeGraphQt")
cmpCli.additionalHooksDir = pathJoin(src,"NodeGraphQt-0.6.11")
cmpCli.paths.append(src)
cmpCli.mainScriptPath = pathJoin(src,"main.py")

compiledPath = buildPythonScript(vobj,cmpCli,src)
exitIfError(compiledPath!="","Build error")

# copy to sdk destination
dest = pathJoin(args.sdk_path,"ReNode")
dest_data = pathJoin(dest,"data")
dest_exe = pathJoin(dest,getFilenameFromPath(compiledPath))

# cleanup
if fileExists(dest_data): dirRemove(dest_data)
if fileExists(dest_exe): fileRemove(dest_exe)

print("Copy from {} to {}".format(pathJoin(src,"data"),dest))
dirCopy(pathJoin(src,"data"),dest_data)
print("Copy from {} to {}".format(compiledPath,dest_exe))
fileCopy(compiledPath,dest_exe)

writeToGithubOutput("RENODE_FULL_VERSION",vobj.product_version)

print("Build ReNode done!")

exit(0)