import os
import sys
import glob
flist = glob.glob("client\LightEngine\ScriptedConfigs\**")

fret = []
for i in flist:
	if i.endswith(".sqf"):
		fret.append("src\\"+i)

dat = '\n'.join(fret)
with open("SP_lightPathes.i",'w+',encoding='utf-8') as h:
	h.write(dat)