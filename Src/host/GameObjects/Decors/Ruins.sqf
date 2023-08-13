// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>


//руины
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigRuins) extends(BigConstructions) var(name,"Крупные руины"); var(desc,"Остатки разрушенного здания для декорации. Не разрушаемы"); endclass

editor_attribute("EditorGenerated")
class(BigIndustrialPipesWithLadder) extends(BigRuins)
	var(model,"ca\structures_e\ind\ind_pipes\indpipe2_bigbuild2_l_ep1.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigSteelRoof) extends(BigRuins)
	var(model,"csa_constr\csa_obj\krysha.p3d");
endclass

editor_attribute("EditorGenerated")
class(IndustrialPipes) extends(BigRuins)
	var(model,"a3\structures_f_enoch\industrial\pipes\indpipe3_big_18_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldLongTunnel) extends(BigRuins)
	var(model,"ml\ml_object\l04_catacombs\l04_catacombs_01.p3d");
endclass