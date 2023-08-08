#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>

//большие камни
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigStoneDecor) extends(BigConstructions) var(name,"Камень"); var(desc,"Груда камней. Не разрушаема"); endclass

editor_attribute("EditorGenerated")
class(BigSmoothStone) extends(BigStoneDecor)
	var(model,"a3\rocks_f\sharp\sharprock_monolith.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumGreenRock) extends(BigStoneDecor)
	var(model,"a3\rocks_f_exp\cliff\cliff_peak_f.p3d");
endclass