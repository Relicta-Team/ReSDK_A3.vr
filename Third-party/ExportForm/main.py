import os
import re
import sys
import shutil

toFolder = ""
fromFolder = ""
if "src" not in sys.argv:
	toFolder = input('Enter the root folder path: ')
else:
	toFolder = sys.argv[sys.argv.index("src") + 1]
toFolder = os.path.abspath(toFolder)

if "orig" not in sys.argv:
	fromFolder = input('Enter the root folder path: ')
else:
	fromFolder = sys.argv[sys.argv.index("orig") + 1]
fromFolder = os.path.abspath(fromFolder)

if not os.path.exists(toFolder):
	print(f'Folder {toFolder} doesn\'t exist!')
	input('Press any button to exit...')
	exit()

if not os.path.exists(fromFolder):
	print(f'Folder {fromFolder} doesn\'t exist!')
	input('Press any button to exit...')
	exit()

configFile = os.path.join(toFolder, "config.cpp")
if not os.path.exists(configFile):
	print(f'File {configFile} doesn\'t exist!')
	input('Press any button to exit...')
	exit()

def getPboPathes(p3dpath,prefix=''):
	"""
	Получает все дата-файлы в бинарном p3d файле
	"""
	if not os.path.exists(p3dpath):
		raise Exception(f'File {p3dpath} doesn\'t exist!')
	
	if not os.path.isfile(p3dpath):
		raise Exception(f'File {p3dpath} is not a file!')
	
	if not p3dpath.endswith(".p3d"):
		raise Exception(f'File {p3dpath} is not a p3d file!')

	with open(p3dpath,"r",errors="ignore") as f:
		data = str(f.read())
		lstitr = []
		lstitr += [f[0] for f in re.finditer(r"(\w+\\)*\w+\.paa",data)]
		lstitr += [f[0] for f in re.finditer(r"(\w+\\)*\w+\.rvmat",data)]

		# убираем все файлы не соответствующие префиксу
		if prefix:
			lstitr = [l for l in lstitr if prefix.lower() in l.lower()]

		return list(set(lstitr) )
	return []

print("src: " + toFolder)
print("orig: " + fromFolder)
print("=========== STARTING COLLECT MODELS ============")

requiredIcons = []
pboPrefix = ""
PBO_PREF_FILENAME = "$PREFIX$"

if os.path.exists(os.path.join(fromFolder, PBO_PREF_FILENAME)):
	with open(os.path.join(fromFolder, PBO_PREF_FILENAME), "r") as f:
		pboPrefix = f.read()
		pboPrefix = pboPrefix.replace("\n","")
		pboPrefix = pboPrefix.replace("\r","")

print("CURRENT PREFIX: " + pboPrefix or "not set")
print("\n"*3)

modelsOut = []

with open(configFile,"r") as f:
	data = f.read()
	models = []
	models += [m[0] for m in re.finditer(r"[\\/]?(\w+[\\/])*\w+\.p3d",data)]
	models += [m[1] for m in re.finditer(r"model\s*\=\s*['\"]([\\/]?(\w+[\\/])*\w+(\.p3d)?)",data,re.IGNORECASE)]
	
	#lower
	models = [m.lower() for m in models]
	# add p3d if not setted
	models = [m if m.endswith(".p3d") else m + ".p3d" for m in models]
	# remove duplicates
	models = list(set(models))
	
	# fix paths
	models = [m.replace("/","\\") for m in models]

	for m in models:
		print(m)
	
	modelsOut = models
print("\t\tCount: " + str(len(modelsOut)))

print ("\n"*3)
print("=========== CLONING MODELS ============")

for m_withpref in modelsOut:
	#print("CHECK:" + m_withpref)
	if pboPrefix:
		m = m_withpref.replace(pboPrefix.lower(),"")
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
	
	#print("POSTCHECK:" + m)

	absModelPath = os.path.join(fromFolder, m)
	#print(absModelPath)
	if not os.path.exists(absModelPath):
		print(f'File {absModelPath} doesn\'t exist!')
	else:
		print("copy: " + m)
		shutil.copyfile(os.path.join(fromFolder, m), os.path.join(toFolder, m))

print("\n"*3)
print("=========== STARTING COLLECT DATA ============")
dataPathes = []
for root, _, files in os.walk(toFolder):
	for file in files:
		if file.endswith(".p3d"):
			# получение относительного пути от директории toFolder
			fpath = os.path.join(os.path.relpath(root, toFolder),file)
			# получение абсолютного пути
			fpath = os.path.abspath(os.path.join(toFolder,fpath))
			
			print("Scan file:",fpath)
			
			#open file as text and search all pathes with ending .paa
			contents = getPboPathes(fpath,pboPrefix)
			for c in contents:
				print("\tfound:" + c)

			dataPathes += contents

#lowersize and unique
dataPathes = [d.lower() for d in dataPathes]
dataPathes = list(set(dataPathes))
print("\t\tCount: " + str(len(dataPathes)))

# copy data files
print("\n"*3)
print("=========== CLONING DATA ============")
bufferedPrefixes = []
for d in dataPathes:
	curDirFrom = fromFolder
	print("before check: " + d)
	# first step - removing prefix if setted
	if pboPrefix:
		pfx = pboPrefix.lower()
		if (pfx + "\\") not in d:
			
			#search in buffered prefixes
			override = False
			for (bp,bp_path) in bufferedPrefixes:
				if (bp + "\\") in d:
					pfx = bp
					curDirFrom = bp_path
					print("override prefix found: " + pfx)
					override = True
					break
			if not override:
				print("WARNING UNKNOWN PREFIX: " + d)
				res = input("Input prefix root directory if known or press enter to skip: ")
				if res == "": continue
				if not os.path.exists(res):
					print(f'File {res} doesn\'t exist!')
					continue
				with open(os.path.join(res,PBO_PREF_FILENAME), "r") as f:
					pfxnew = f.read()
					pfxnew = pfxnew.replace("\n","")
					pfxnew = pfxnew.replace("\r","")
				pfx = pfxnew.lower()
				curDirFrom = res
				print("Register new prefix: " + pfx + " ===> " + res)
				bufferedPrefixes.append((pfx,res))

		d = d.replace(pfx,"")
		d = d.lstrip("\\")

	print("check: " + d)

	if not os.path.exists(os.path.join(curDirFrom, d)):
		raise Exception(f'ORIG ERROR: File {os.path.join(curDirFrom, d)} doesn\'t exist!')
	if not os.path.isfile(os.path.join(curDirFrom, d)):
		raise Exception(f'ORIG ERROR: File {os.path.join(curDirFrom, d)} is not a file!')
	

	print("copy: " + d)
	#shutil.copyfile(os.path.join(fromFolder, d), os.path.join(toFolder, d))


print(f"Buffered prefixes ({len(bufferedPrefixes)}):")
for (bp,bp_path) in bufferedPrefixes:
	print("\t\t" + bp + " => " + bp_path)