#define MACRO_ANIMATION \
    head = "headDefault"; \
    aimingBody = "aimingNo"; \
    forceAim = 1; \
    static = 1;

#define GVAR(var) var

class CfgMovesBasic {
    class StandBase;
};

class CfgMovesMaleSdr: CfgMovesBasic {
    class States {

		//noidle

		// rifle
        class AmovPercMstpSlowWrflDnon: StandBase {
            variantsPlayer[] = {/*"AidlPercMstpSlowWrflDnon_G01", 0.5, "AidlPercMstpSlowWrflDnon_G02", 0.125, "AidlPercMstpSlowWrflDnon_G03", 0.125, "AidlPercMstpSlowWrflDnon_G04", 0.125, "AidlPercMstpSlowWrflDnon_G05", 0.125*/};
        };
        class AmovPknlMstpSlowWrflDnon: AmovPercMstpSlowWrflDnon {
            variantsPlayer[] = {/*"AidlPknlMstpSlowWrflDnon_G01", 0.25, "AidlPknlMstpSlowWrflDnon_G02", 0.25, "AidlPknlMstpSlowWrflDnon_G03", 0.25*/};
        };

        // pistol
        class AmovPercMstpSrasWpstDnon;
        class AmovPercMstpSlowWpstDnon: AmovPercMstpSrasWpstDnon {
            variantsPlayer[] = {/*"AidlPercMstpSlowWpstDnon_G01", 0.333, "AidlPercMstpSlowWpstDnon_G02", 0.333, "AidlPercMstpSlowWpstDnon_G03", 0.334*/};
        };

        class AmovPknlMstpSrasWpstDnon;
        class AmovPknlMstpSlowWpstDnon: AmovPknlMstpSrasWpstDnon {
            variantsPlayer[] = {/*"AidlPknlMstpSlowWpstDnon_G03", 0.333, "AidlPknlMstpSlowWpstDnon_G02", 0.333, "AidlPknlMstpSlowWpstDnon_G01", 0.334*/};
        };

        // none
        class AmovPercMstpSnonWnonDnon: StandBase {
            variantsPlayer[] = {/*"AidlPercMstpSnonWnonDnon_G01", 0.16, "AidlPercMstpSnonWnonDnon_G02", 0.16, "AidlPercMstpSnonWnonDnon_G03", 0.16, "AidlPercMstpSnonWnonDnon_G04", 0.16, "AidlPercMstpSnonWnonDnon_G05", 0.16, "AidlPercMstpSnonWnonDnon_G06", 0.16*/};
        };
        class AmovPknlMstpSnonWnonDnon: AmovPercMstpSnonWnonDnon {
            variantsPlayer[] = {/*"AidlPknlMstpSnonWnonDnon_G01", 0.33, "AidlPknlMstpSnonWnonDnon_G02", 0.33, "AidlPknlMstpSnonWnonDnon_G03", 0.33*/};
        };

		//fix sitting

        class HubSittingChairA_idle1;
        class GVAR(HubSittingChairA_idle1): HubSittingChairA_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairA_idle2;
        class GVAR(HubSittingChairA_idle2): HubSittingChairA_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairA_idle3;
        class GVAR(HubSittingChairA_idle3): HubSittingChairA_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairA_move1;
        class GVAR(HubSittingChairA_move1): HubSittingChairA_move1 {
            MACRO_ANIMATION
        };
        class HubSittingChairB_idle1;
        class GVAR(HubSittingChairB_idle1): HubSittingChairB_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairB_idle2;
        class GVAR(HubSittingChairB_idle2): HubSittingChairB_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairB_idle3;
        class GVAR(HubSittingChairB_idle3): HubSittingChairB_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairB_move1;
        class GVAR(HubSittingChairB_move1): HubSittingChairB_move1 {
            MACRO_ANIMATION
        };
        class HubSittingChairC_idle1;
        class GVAR(HubSittingChairC_idle1): HubSittingChairC_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairC_idle2;
        class GVAR(HubSittingChairC_idle2): HubSittingChairC_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairC_idle3;
        class GVAR(HubSittingChairC_idle3): HubSittingChairC_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairC_move1;
        class GVAR(HubSittingChairC_move1): HubSittingChairC_move1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUA_idle1;
        class GVAR(HubSittingChairUA_idle1): HubSittingChairUA_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUA_idle2;
        class GVAR(HubSittingChairUA_idle2): HubSittingChairUA_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairUA_idle3;
        class GVAR(HubSittingChairUA_idle3): HubSittingChairUA_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairUA_move1;
        class GVAR(HubSittingChairUA_move1): HubSittingChairUA_move1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUB_idle1;
        class GVAR(HubSittingChairUB_idle1): HubSittingChairUB_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUB_idle2;
        class GVAR(HubSittingChairUB_idle2): HubSittingChairUB_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairUB_idle3;
        class GVAR(HubSittingChairUB_idle3): HubSittingChairUB_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairUB_move1;
        class GVAR(HubSittingChairUB_move1): HubSittingChairUB_move1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUC_idle1;
        class GVAR(HubSittingChairUC_idle1): HubSittingChairUC_idle1 {
            MACRO_ANIMATION
        };
        class HubSittingChairUC_idle2;
        class GVAR(HubSittingChairUC_idle2): HubSittingChairUC_idle2 {
            MACRO_ANIMATION
        };
        class HubSittingChairUC_idle3;
        class GVAR(HubSittingChairUC_idle3): HubSittingChairUC_idle3 {
            MACRO_ANIMATION
        };
        class HubSittingChairUC_move1;
        class GVAR(HubSittingChairUC_move1): HubSittingChairUC_move1 {
            MACRO_ANIMATION
        };
    };
};
