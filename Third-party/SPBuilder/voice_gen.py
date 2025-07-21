import os
import glob
voiceDir = os.path.join(os.path.dirname(__file__), "..\\..\\Resources\\sounds\\singleplayer\\sp_guide")
realVoicePath = os.path.realpath(voiceDir)

from mutagen.oggvorbis import OggVorbis
from mutagen.mp3 import MP3
from mutagen.wave import WAVE

def get_audio_duration(filename):
    if filename.lower().endswith('.ogg'):
        audio = OggVorbis(filename)
    elif filename.lower().endswith('.mp3'):
        audio = MP3(filename)
    elif filename.lower().endswith('.wav'):
        audio = WAVE(filename)
    else:
        raise ValueError("Неподдерживаемый формат файла")
    return audio.info.length  # в секундах (float)

# recursive search ogg
print("START")
print("realVoicePath",realVoicePath)
buff = []
bufflen = []
for file in glob.glob(os.path.join(realVoicePath, "**/*.ogg"), recursive=True):
	fullFile = os.path.realpath(file)
	file = os.path.relpath(file, realVoicePath)
	fcfg = file.replace("\\","_").replace(".ogg","")
	print(fcfg + " " + file)
	file = "singleplayer\\sp_guide\\" + file
	buff.append(f'regSound({fcfg},{file});')

	#get song duration (use file attributes)
	duration = get_audio_duration(fullFile)
	bufflen.append(f"{fcfg}__dur = {duration};")
	
	
	
# copy to clipboard with winapi
outfile = os.path.join(os.path.dirname(__file__), "voice_gen.txt")
if os.path.exists(outfile):
	os.remove(outfile)
with open(outfile, "w") as f:
	for line in buff:
		f.write('\t' + line + "\n")
	for line in bufflen:
		f.write('\t' + line + "\n")


print("DONE")









