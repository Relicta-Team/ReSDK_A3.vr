import re

try:
	def export_segments(text, output_dir):
		pattern = r'(regScriptEmit\((\w+)\)\s*\[\s*([.\W\s\S]*?)\]\s*endScriptEmit)'
		matches = re.findall(pattern, text, re.DOTALL)
		
		cpyPath = "../../Editor/Bin/copyright.sqf"
		cpyHeader = open(cpyPath, 'r',encoding='utf-8').read()
		nameList = []
		for match in matches:
			name = match[1]
			content = match[0]
			
			nameList.append(name)

			filename = f"{output_dir}/{name}.sqf"
			with open(filename, 'w',encoding='utf-8') as f:
				f.write(cpyHeader+"\n"+content)
			
			print(f"Segment '{name}' exported to '{filename}'")
			
		with open(".\\ScriptedEffectConfigs.sqf", "w",encoding='utf-8') as fp:
			fp.write(cpyHeader)
			for f in nameList:
				fp.write("\n")
				fp.write(f"#include \"ScriptedConfigs\\{f}.sqf\"")
				print(f"	Added header path for {f}")

		print("All segments exported to 'ScriptedEffectConfigs.sqf'")

	output_dir = ".\\ScriptedConfigs"
	text = ""

	with open("ScriptedEffectConfigs.sqf", "r",encoding='utf-8') as f:
		text = f.read()
		
	export_segments(text, output_dir)

	input("Press Enter to continue...")

except Exception as e:
	print(f"Error: {e}")
	input("Error occurred. Press Enter to continue...")