import os
import re
import sys
import shutil
from os.path import exists as fileExists
from os.path import exists as dirExists
from os.path import join as pathJoin
from os.path import abspath as pathAbs
from os.path import isfile as pathIsFile
from os.path import isdir as pathIsDir
from os.path import abspath as pathAbs
from os.path import dirname as pathGetDirName
from os.path import basename as pathGetBaseName

#todo в rvmat-ах возможно тоже могут быть пути, которые надо портировать

DEBUG_SHOW_MODELS = False
DEBUG_SHOW_IMAGES = False

FEATURE_PREFIX_CHECK_ON_COPY_DATA = True

# включает пропуск ненайденных ресурсов (используется для модов сделанных рукожопами)
FORCE_SKIP_NON_EXISTENDATA = False

toFolder = ""
fromFolder = ""
addonName = ""
if "src" not in sys.argv:
	toFolder = input('Enter the source place folder path: ')
else:
	toFolder = sys.argv[sys.argv.index("src") + 1]
toFolder = pathAbs(toFolder)

if "orig" not in sys.argv:
	fromFolder = input('Enter the original folder path: ')
else:
	fromFolder = sys.argv[sys.argv.index("orig") + 1]
fromFolder = pathAbs(fromFolder)

if "addon" not in sys.argv:
	addonName = input('Enter the addon name: ')
else:
	addonName = sys.argv[sys.argv.index("addon") + 1]

ignorePrefixLoading = "nopref" in sys.argv

toFolder_addon = pathJoin(toFolder,addonName)
if not dirExists(toFolder_addon):
	print(f'Folder {toFolder_addon} doesn\'t exist!')
	input('Press any button to exit...')
	exit()

fromFolder_addon = pathJoin(fromFolder,addonName)
if not dirExists(fromFolder_addon):
	print(f'Folder {fromFolder_addon} doesn\'t exist!')
	input('Press any button to exit...')
	exit()

configFile = pathJoin(toFolder_addon, "config.cpp")
if not fileExists(configFile):
	print(f'File {configFile} doesn\'t exist!')
	input('Press any button to exit...')
	exit()



def getP3dPathes(p3dpath,prefix=''):
	"""
	Получает все дата-файлы в бинарном p3d файле
	"""
	if not fileExists(p3dpath):
		raise Exception(f'File {p3dpath} doesn\'t exist!')
	
	if not pathIsFile(p3dpath):
		raise Exception(f'File {p3dpath} is not a file!')
	
	if not p3dpath.endswith(".p3d"):
		raise Exception(f'File {p3dpath} is not a p3d file!')

	with open(p3dpath,"r",errors="ignore") as f:
		data = str(f.read())
		lstitr = []
		lstitr += [f[0] for f in re.finditer(r"(\w+\\)*\w+\.paa",data)]
		lstitr += [f[0] for f in re.finditer(r"(\w+\\)*\w+\.rvmat",data)]

		# убираем все файлы не соответствующие префиксу
		#! больше не убираем потому что некоторые г-ны распихивают текстуры по разным пбошкам
		#if prefix:
		#	lstitr = [l for l in lstitr if prefix.lower() in l.lower()]

		return list(set(lstitr) )
	return []

print("src: " + toFolder_addon)
print("orig: " + fromFolder_addon)
print("=========== STARTING COLLECT MODELS ============")

requiredIcons = []
pboPrefix = ""
PBO_PREF_FILENAME = "$PREFIX$"

if fileExists(pathJoin(fromFolder_addon, PBO_PREF_FILENAME)):
	if not ignorePrefixLoading:
		with open(pathJoin(fromFolder_addon, PBO_PREF_FILENAME), "r") as f:
			pboPrefix = f.read()
			pboPrefix = pboPrefix.replace("\n","")
			pboPrefix = pboPrefix.replace("\r","")

print("CURRENT PREFIX: " + ("not set" if pboPrefix=='' else pboPrefix))
print("\n"*3)

modelsOut = []
imagesOut = []

with open(configFile,"r",encoding="utf-8") as f:
	data = f.read()
	models = []
	images = []
	materials = []
	models += [m[0] for m in re.finditer(r"[\\/]?(\w+[\\/])*\w+\.p3d",data)]
	models += [m[1] for m in re.finditer(r"model\s*\=\s*['\"]([\\/]?(\w+[\\/])*\w+(\.p3d)?)",data,re.IGNORECASE)]
	
	images += [m[0] for m in re.finditer(r"[\\/]?(\w+[\\/])*\w+\.paa",data,re.IGNORECASE)]

	materials += [m[0] for m in re.finditer(r"[\\/]?(\w+[\\/])*\w+\.rvmat",data,re.IGNORECASE)]

	#lower
	models = [m.lower() for m in models]
	# add extension if not setted
	models = [m if m.endswith(".p3d") else m + ".p3d" for m in models]
	# remove duplicates
	models = list(set(models))
	# fix paths
	models = [m.replace("/","\\") for m in models]

	#================= also for images
	images = [m.lower() for m in images]
	# add extension if not setted
	images = [m if m.endswith(".paa") else m + ".paa" for m in images]
	# remove duplicates
	images = list(set(images))
	# fix paths
	images = [m.replace("/","\\") for m in images]
	# remove images starts with \a3\
	images = [m for m in images if not m.startswith("\\a3\\") and not m.startswith("a3\\data")]

	#================= and then rvmat works
	materials = [m.lower() for m in materials]
	# remove duplicates
	materials = list(set(materials))
	# fix paths
	materials = [m.replace("/","\\") for m in materials]
	# remove images starts with \a3\
	materials = [m for m in materials if not m.startswith("\\a3\\") and not m.startswith("a3\\data")]

	images += materials

	if DEBUG_SHOW_MODELS:
		print(">>>> MODELS: ")
		for m in models:
			print(m)
	if DEBUG_SHOW_IMAGES:
		print(">>>> IMAGES (included materials): ")
		for m in images:
			print(m)
	
	modelsOut = models
	imagesOut = images

print("\t\tCount: " + str(len(modelsOut)) + " models, " + str(len(imagesOut)) + " images")

print ("\n"*3)
print("=========== CLONING MODELS ============")
realModelPathes = []

for m_withpref in modelsOut:
	#print("CHECK:" + m_withpref)
	if pboPrefix:
		# префикс не убирается потму что аддон не использует префикса
		if pboPrefix.lower()==addonName.lower():
			m = m_withpref
		else:
			m = m_withpref.replace(pboPrefix.lower(),addonName)
		#print("---m:" + m)
		# if m.startswith("\\"):
		# 	m = m[1:]
		# #removing double leading slash
		# if m.startswith("\\"):
		# 	m = m[1:]
		# ! best way is lstrip
		m = m.lstrip("\\")
	else:
		m = m_withpref
	
	print("POSTCHECK:" + m)

	absModelPath = pathJoin(fromFolder, m)
	#print(absModelPath)
	
	if not fileExists(absModelPath):
		print(f'File {absModelPath} doesn\'t exist!')
		raise Exception(f'File {absModelPath} doesn\'t exist!')
	else:
		toFolderDir = pathGetDirName(pathJoin(toFolder, m))
		if not dirExists(toFolderDir):
			print("\t create dir: " + toFolderDir)
			os.makedirs(toFolderDir)
		destModel_ = pathJoin(toFolder, m)
		print(f"copy dest: {destModel_} [{m}]")

		realModelPathes.append(destModel_)
		shutil.copyfile(pathJoin(fromFolder, m), pathJoin(toFolder, m))
		

realModelPathes = [pathAbs(m).lower() for m in realModelPathes] #lower and abs

print("\n"*3)
print("=========== STARTING COLLECT DATA ============")
dataPathes = imagesOut

#region obsolete models info collect
#! алгоритм учитывает только текущий аддон. не проверяет зависимости
# for root, _, files in os.walk(toFolder):
# 	for file in files:
# 		if file.endswith(".p3d"):
# 			# получение относительного пути от директории toFolder
# 			fpath = pathJoin(os.path.relpath(root, toFolder),file)
# 			# получение абсолютного пути
# 			fpath = pathAbs(pathJoin(toFolder,fpath))
			
# 			print("Scan file:",fpath)
			
# 			#open file as text and search all pathes with ending .paa,rvmat
# 			contents = getP3dPathes(fpath,pboPrefix)
			
# 			#for c in contents:
# 				#print("\tfound:" + c)
# 			print("\tfound " + str(len(contents)) + " pathes: " + (' ; '.join(contents)))

# 			dataPathes += contents
#endregion

# сначала подколектим модели в текущем аддоне
print("\t1. Stage check not listed p3d in "+toFolder_addon)
for root, _, files in os.walk(toFolder_addon):
	for file in files:
		if file.endswith(".p3d"):
			# получение относительного пути от директории toFolder_addon
			fpathRel = pathJoin(os.path.relpath(root, toFolder_addon),file)
			# получение абсолютного пути
			fpath = pathAbs(pathJoin(toFolder_addon,fpathRel))
			#print("\t\tScan file:",fpathRel)
			
			if not fileExists(fpath):
				raise Exception("cant collect src model:" + fpath)
			if realModelPathes.count(fpath.lower())==0:
				print("Append not listed p3d: " + fpathRel)
				realModelPathes.append(fpath)
print("\t2. Collect info...")
for m in realModelPathes:
 			#open file as text and search all pathes with ending .paa,rvmat
			print("Scan file:",m)
			contents = getP3dPathes(m,pboPrefix)
			#for c in contents:
				#print("\tfound:" + c)
			print("\tfound " + str(len(contents)) + " pathes")
			dataPathes += contents

#lowersize and unique
dataPathes = [d.lower() for d in dataPathes]
dataPathes = list(set(dataPathes))

#removing all starts with \\a3\\ or a3\\data
dataPathes = [d for d in dataPathes if not d.startswith("\\a3\\") and not d.startswith("a3\\data") and not d.startswith("a3\\characters") and not d.startswith("a3\\weapons")]

print(">>> DATA: ")
for d in dataPathes:
	print(d)

print("\t\tCount: " + str(len(dataPathes)))

# copy data files
print("\n"*3)
print("=========== CLONING DATA ============")
bufferedPrefixes:list[(str,str,str)] = [] #buffprefix,buffpathfrom,buffpathto
for d in dataPathes:
	curDirFrom = fromFolder
	curDirTo = toFolder
	curAddon = addonName
	#print("before check: " + d)

	# first step - removing prefix if setted
	if pboPrefix and FEATURE_PREFIX_CHECK_ON_COPY_DATA:
		pfx = pboPrefix.lower()
		# префикс не найден в текущем пути
		if (pfx + "\\") not in d:
			raise NotImplementedError("PREFIX SEARCH NOT IMPLEMENTED YET")
			#search in buffered prefixes
			override = False
			for (bp,bp_path,bp_pathdest) in bufferedPrefixes:
				if (bp + "\\") in d:
					pfx = bp
					curDirFrom = bp_path
					curDirTo = bp_pathdest
					print("override prefix found: " + pfx)
					override = True
					break
			if not override:
				print("WARNING UNKNOWN PREFIX: " + d)
				res = input("Input prefix root directory if known or press enter to skip: ")
				if res == "": continue
				if not fileExists(res):
					print(f'File {res} doesn\'t exist!')
					continue
				with open(pathJoin(res,PBO_PREF_FILENAME), "r") as f:
					pfxnew = f.read()
					pfxnew = pfxnew.replace("\n","")
					pfxnew = pfxnew.replace("\r","")

				r2 = input("Input dest dir for addon: ")
				if r2 == "":
					continue
				if not fileExists(r2):
					reqcreate = input("Dir not found: " + r2 + "\nCreate? (y/yes): ")
					if reqcreate.lower().startswith("y"):
						os.makedirs(r2)
				
				pfx = pfxnew.lower()
				curDirFrom = res
				curDirTo = r2
				print("Register new prefix: " + pfx + " ===> " + res + "(orig: " + r2 + ")")
				bufferedPrefixes.append((pfx,res,r2))

		d = d.replace(pfx,curAddon)
		d = d.lstrip("\\")

	d = d.lstrip("\\")

	print("check: " + d)
	
	if not fileExists(pathJoin(curDirFrom, d)):
		if FORCE_SKIP_NON_EXISTENDATA:
			print("WARNING: File " + pathJoin(curDirFrom, d) + " doesn\'t exist!")
			continue
		raise Exception(f'ORIG ERROR: File {pathJoin(curDirFrom, d)} doesn\'t exist!')
	if not pathIsFile(pathJoin(curDirFrom, d)):
		raise Exception(f'ORIG ERROR: File {pathJoin(curDirFrom, d)} is not a file!')
	
	toFolderDir = pathGetDirName(pathJoin(curDirTo, d))
	if not dirExists(toFolderDir):
		print("\t create dir: " + toFolderDir)
		os.makedirs(toFolderDir)
	print("copy: " + d)
	shutil.copyfile(pathJoin(curDirFrom, d), pathJoin(curDirTo, d))


print(f"Buffered prefixes ({len(bufferedPrefixes)}):")
for (bp,bp_path,bp_pathdest) in bufferedPrefixes:
	print("\t\t" + bp + " => " + bp_path + " => " + bp_pathdest)

print("\n"*3)
print("=========== FINISHED ============")