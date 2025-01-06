try:
	import os
	import re
	import glob

	cpyPath = "../../Editor/Bin/copyright.sqf"
	fhdr = open(cpyPath, 'r',encoding='utf-8')
	cpyHeader = fhdr.read()
	fhdr.close()

	nameList = []

	files = glob.glob('./ScriptedConfigs/*.sqf')
	if len(files) == 0:
		print('No files found')

	for file in files:
		print(file)
		with open(file, 'r',encoding='utf-8') as f:
			content = f.read()
			if len(content) < 10:
				print(f'{file} is empty or too small')
				continue
			
			dta = re.search(r'regScriptEmit\((\w+)\)',content,re.DOTALL | re.MULTILINE | re.UNICODE)
			if not dta:
				raise Exception(f'{file} is not a script')
			name = dta.group(1)
			if name in nameList:
				raise Exception(f'{name} is duplicate in {file}')
			nameList.append(name)

	with open(".\\ScriptedEffectConfigs.sqf", "w",encoding='utf-8') as fp:
		fp.write(cpyHeader)
		for f in nameList:
			fp.write("\n")
			fp.write(f"#include \"ScriptedConfigs\\{f}.sqf\"")
			print(f"	Added header path for {f}")

	with open('.\\ScriptedEffects.hpp', 'w', encoding='utf-8') as fp:
		fp.write(cpyHeader)
		base = 2100
		cur = base
		for f in nameList:
			fp.write("\n")
			fp.write(f'#define {f} {cur}')
			cur += 1
		cur = base
		fp.write('\n\n#ifdef SCRIPT_EMIT_EVAL_SERVER\n')

		for f in nameList:
			fp.write("\n")
			fp.write(f'\t{f}_var = {cur};')
			cur += 1
		
		fp.write('\n#endif')
		


except Exception as e:
	print(e)