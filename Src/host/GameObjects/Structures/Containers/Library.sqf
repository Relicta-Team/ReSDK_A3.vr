// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


//================== library ==================

class(BigFileCabinet) extends(SContainer)
	var(name,"Картотека");
	var(model,"ml_shabut\exodus\kartoteka.p3d");
endclass

class(SmallBookcase) extends(SContainer)
	var(name,"Малый книжный шкаф");
	var(model,"ca\buildings\furniture\dhangar_knihovna.p3d");
endclass

class(Bookcase) extends(SContainer)
	var(name,"Книжный шкаф");
	var(model,"ml_shabut\biblio\biblio.p3d");
endclass