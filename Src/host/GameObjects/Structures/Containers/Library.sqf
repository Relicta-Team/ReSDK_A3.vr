// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


//================== library ==================

class(BigFileCabinet) extends(SContainer)
	var(name,"Картотека");
	var(model,"ml_shabut\exodus\kartoteka.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(Bookcase) extends(SContainer)
	var(name,"Книжный шкаф");
	var(model,"ml_shabut\biblio\biblio.p3d");
	var(material,"MatWood");
	getter_func(isMovable,true);
	var(dr,1);
endclass

class(SmallBookcase) extends(Bookcase)
	var(name,"Малый книжный шкаф");
	var(model,"ca\buildings\furniture\dhangar_knihovna.p3d");
endclass