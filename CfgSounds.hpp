
#define PATHSOUNDCFG(var) \resources\sounds\##var
#define PATHMUSICCFG(var) resources\music\##var

#define regSound(cls,path)  class cls { \
	name = #cls; \
	sound[] = {PATHSOUNDCFG(path), 1, 1}; \
	titles[] = {1,""}; \
}

#define regMusic(pref,cls,path,dur) class pref##_##cls { \
	name = 'pref cls'; \
	sound[] = {PATHMUSICCFG(path), db+0, 1.0}; \
	titles[] = {0,""}; \
	duration = dur; \
}


#include <soundsdef.cpp>
#include <musicdef.cpp>

/*class CfgMusic {
	regMusic(ambient,test,ambient\test.ogg,500);
};*/