import datetime
import os
import re
import sys

def generate_config(root_folder, authors, extensions, m_name,pboprefix,reqlist=[]):
	out_file = os.path.join(root_folder, 'config.cpp')
	with open(out_file, 'w') as f:
		f.write('/*\n')
		f.write(' * Generated in Model Config Creator v3.0\n')
		f.write(' * by Yodes\n')
		f.write(f' * Created: {datetime.datetime.now()}\n')
		f.write(' */\n')
		f.write('class CfgPatches {\n')
		f.write(f'    class {m_name} {{\n')
		f.write('        units[] = {};\n')
		f.write('        weapons[] = {};\n')
		if len(reqlist) > 0:
			f.write(f'        requiredAddons[] = {{\n')
			for i, addon in enumerate(reqlist):
				if i == 0:
					f.write(f'            \"{addon}\"\n')
				else:
					f.write(f'            , \"{addon}\"\n')
			f.write('        };\n')
		else:
			f.write('        requiredAddons[] = { \"CBA_xeh\", \"A3_UI_F\", \"A3_Data_F\" };\n')
		f.write('        requiredVersion = 1.0;\n')
		f.write(f'        author = \"{authors}\";\n')
		f.write('    };\n')
		f.write('};\n')
		f.write('class CfgVehicles {\n')
		f.write('    class All;\n')
		f.write('    class AllVehicles : All {};\n')
		f.write('    class Land : AllVehicles {};\n')
		f.write('    class Static : All {};\n')
		f.write('    class Building : Static {};\n')
		f.write('    class NonStrategic : Building {};\n')
		f.write('    class Thing : All {};\n')
		f.write('    class ThingX : Thing {};\n')
		f.write(f'    class {m_name}Object : Static {{\n')
		f.write('        scope = 2;\n')
		f.write(f'        author = \"{authors}\";\n')
		f.write('        destrType = \"DestructNo\";\n')
		f.write('        mass = 1;\n')
		f.write('        weight = 1;\n')
		f.write('    };\n')
		f.write('\n    /*    Class list    */\n')
		mdlNameMap = set()
		realPrefix = pboprefix
		if pboprefix != "":
			realPrefix = "\\" + pboprefix

		if realPrefix.lower().endswith(m_name):
			realPrefix = realPrefix[:-len(m_name)]
			if realPrefix.endswith('\\'):
				realPrefix = realPrefix[:-1]

		for extension in extensions:
			for root, _, files in os.walk(root_folder):
				for file in files:
					if file.endswith('.' + extension):
						model_name:str = os.path.splitext(file)[0]
						relative_path = os.path.relpath(root, root_folder).replace('\\', '/')

						if model_name.lower() in mdlNameMap:
							oldmdlname__ = model_name
							model_name = relative_path.split('/')[-2] + "_" + model_name
							print(f'WARNING! {oldmdlname__} already exists; Renamed to {model_name}')

						# postcheck
						if model_name.lower() in mdlNameMap:
							raise Exception(f'WARNING! {model_name} already exists!')

						mdlNameMap.add(model_name.lower())
						
						f.write(f'    class {model_name} : {m_name}Object {{\n')
						f.write(f'        displayname = \"{model_name}\";\n')
						rpathunix = relative_path.replace("/", "\\")
						
						if rpathunix != '.':
							rpathunix = rpathunix + '\\'
						else:
							rpathunix = ""
						f.write(f'        model = \"{realPrefix}\\{m_name}\\{rpathunix}{model_name}.{extension}\";\n')
						f.write('    };\n')
		f.write('};\n')
	print('Config generated successfully!')
if __name__ == '__main__':
	print("MCC new")
	print("args:")
	print("		src [SOURCE] - source folder")
	print("		noauthor - don't ask for authors")
	print("		wait - wait for input after generating")
	print("		clean - clean generated files")
	print("		required [FILE] - required addon data")

	root_folder = ""
	if "src" not in sys.argv:
		root_folder = input('Enter the root folder path: ')
	else:
		root_folder = sys.argv[sys.argv.index("src") + 1]
	root_folder = os.path.abspath(root_folder)
	authors = "Yodes"
	if "noauthor" not in sys.argv:
		authors = input('Enter authors: ')
	prefix = ""

	if os.path.exists(os.path.join(root_folder, "$PREFIX$")):
		with open(os.path.join(root_folder, "$PREFIX$"), 'r') as f:
			prefix = f.readlines()[0]

	if not os.path.exists(root_folder):
		print(f'Folder {root_folder} doesn\'t exist!')
		input('Press any button to exit...')
		exit()

	extensions = ['p3d']
	m_name = os.path.split(root_folder)[(-1)]
	if not os.path.exists(root_folder):
		print(f'Folder {root_folder} doesn\'t exist!')
		input('Press any button to exit...')
		exit()
	if ' ' in m_name or '.' in m_name or ',' in m_name:
		print(f'Root folder name \'{m_name}\' can\'t contain spaces, dots or commas!')
		input('Press any button to exit...')
		exit()
	print(f'folder {root_folder}\nauthors {authors}\nExtensions {extensions}\nProject name {m_name}')

	out_file = os.path.join(root_folder, 'config.cpp')
	if os.path.exists(out_file):
		if "clean" in sys.argv:
			os.remove(out_file)
		else:
			print(f'File already exists: {out_file}; Remove it and try again')
			exit()

	reqdata = [] # plain string (use regex)
	if "required" in sys.argv:
		required_addons = sys.argv[sys.argv.index("required") + 1]
		with open(required_addons, 'r') as f:
			data = f.read()
			reqdata = re.findall('\w+',data)

	generate_config(root_folder, authors, extensions, m_name,prefix,reqdata)

	if "wait" in sys.argv:
		input('Press any button to exit...')