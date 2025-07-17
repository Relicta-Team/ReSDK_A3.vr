// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\..\host\struct.hpp>

struct(PostProcessEffectBase)

	def(_RVStringRepr) []
	def(_priority) 0;
	def(_internalName) "";

	def(_getRVProps) {self getv(_RVStringRepr) apply {self getv(_x)}}

	def(_handle) -1;

	def(init) {
		private _h = ppEffectCreate [self getv(_internalName),self getv(_priority)];
		if equals(_h,-1) then {
			warningformat("Failed to create post-processing effect %1 with priority %2",self getv(_internalName) arg self getv(_priority));
		};
		self setv(_handle,_h);
		ppmgr_effects pushBackUnique self;
	}

	def(del) {
		array_remove(ppmgr_effects,self);
		ppEffectDestroy (self getv(_handle));
	}

	// ------------------------------------------------------------
	// Generic control
	// ------------------------------------------------------------
	def(apply) {
		params [["_t",0]];
		(self getv(_handle)) ppEffectAdjust (self callv(_getRVProps));
		self callp(commit,_t);
	};

	def(commit) {
		params [["_t",0]];
		(self getv(_handle)) ppEffectCommit _t;
	};

	def(isCommited) {
		ppEffectCommitted (self getv(_handle))
	};

	def(setEnable) {
		params [["_enable",true]];
		(self getv(_handle)) ppEffectEnable _enable;
	};

	def(isEnabled) {
		ppEffectEnabled (self getv(_handle))
	}

	// ------------------------------------------------------------
	// Animations
	// ------------------------------------------------------------
	

endstruct


struct(PPRadialBlur) base(PostProcessEffectBase)
    def(_priority) 100;
    def(_internalName) "RadialBlur";
    def(_RVStringRepr) ["powerX","powerY","offsetX","offsetY"];
    
    // relative blur degree on axis X
    def(powerX) 0.01;
    // relative blur degree on axis Y
    def(powerY) 0.01;
    // relative size X of un-blurred centre
    def(offsetX) 0.06;
    // relative size Y of un-blurred centre
    def(offsetY) 0.06;
endstruct

struct(PPChromAberration) base(PostProcessEffectBase)
    def(_priority) 200;
    def(_internalName) "ChromaticAberration";
    def(_RVStringRepr) ["aberrationPowerX","aberrationPowerY","aspectCorrection"];
    
    // relative effect strength (sample spacing from each other) axis X
    def(aberrationPowerX) 0.005;
    // relative effect strength (sample spacing from each other) axis Y
    def(aberrationPowerY) 0.005;
    // enable/disable correction according to screen aspect ratio
    def(aspectCorrection) false;
endstruct

struct(PPWetDistortion) base(PostProcessEffectBase)
    def(_priority) 300;
    def(_internalName) "WetDistortion";
    def(_RVStringRepr) ["value","top","bottom","horizontal1","horizontal2","vertical1","vertical2","horizontal1Amplitude","horizontal2Amplitude","vertical1Amplitude","vertical2Amplitude","randX","randY","posX","posY"];
    
    // blurriness of distorted image (0 to 1, values above 1 cause unusual)
    def(value) 1;
    // effect power (top of screen)
    def(top) 1;
    // effect power (bottom of screen)
    def(bottom) 1;
    // wave speed (horizontal1)
    def(horizontal1) 4.10;
    // wave speed (horizontal2)
    def(horizontal2) 3.70;
    // wave speed (vertical1)
    def(vertical1) 2.50;
    // wave speed (vertical2)
    def(vertical2) 1.85;
    // wave amplitude (horizontal1)
    def(horizontal1Amplitude) 0.0054;
    // wave amplitude (horizontal2)
    def(horizontal2Amplitude) 0.0041;
    // wave amplitude (vertical1)
    def(vertical1Amplitude) 0.0090;
    // wave amplitude (vertical2)
    def(vertical2Amplitude) 0.0070;
    // coefficient for phase computing; weight of random vertex data on horizontal wave phases
    def(randX) 0.5;
    // coefficient for phase computing; weight of random vertex data on vertical wave phases
    def(randY) 0.3;
    // coefficient for phase computing; weight of vertex X-position on horizontal wave phases
    def(posX) 10.0;
    // coefficient for phase computing; weight of vertex Y-position on vertical wave phases
    def(posY) 6.0;
endstruct

struct(PPColorCorrections) base(PostProcessEffectBase)
    def(_priority) 1500;
    def(_internalName) "ColorCorrections";
    def(_RVStringRepr) ["brightness","contrast","offset","blend","colorize","desaturate",["radialMajorAxisRadius","radialMinorAxisRadius","radialRotationDeg","radialCenterX","radialCenterY","radialInnerRadiusCoef","radialInterpCoef"]];
    
	def(_getRVProps) {
		
		self getv(_RVStringRepr) apply {
			if equalTypes(_x,[]) then {
				_x apply {
					self getv(_x)
				}
			} else {
				self getv(_x)
			}
		}
	};


    // image brightness (0 - black, 1 - unchanged, 2 - white)
    def(brightness) 1;
    // image contrast (1 - normal contrast)
    def(contrast) 1;
    // image contrast offset (0 - unchanged)
    def(offset) 0;
    // color for blending [r, g, b, a] (a - blend factor)
    def(blend) [0,0,0,0];
    // color for colorization [r, g, b, a] (a - saturation)
    def(colorize) [1,1,1,1];
    // color rgb weights for desaturation [r, g, b, 0]
    def(desaturate) [0.299,0.587,0.114,0];
    // major axis radius of ellipse (radial effect)
    def(radialMajorAxisRadius) -1;
    // minor axis radius of ellipse (radial effect)
    def(radialMinorAxisRadius) -1;
    // rotation of ellipse axis (in degrees)
    def(radialRotationDeg) 0;
    // centerX of ellipse on the screen (relative, -0.5..0.5)
    def(radialCenterX) 0;
    // centerY of ellipse on the screen (relative, -0.5..0.5)
    def(radialCenterY) 0;
    // coefficient for inner radius (where effect is not applied)
    def(radialInnerRadiusCoef) 0;
    // coefficient for color interpolation between inner and outer radius
    def(radialInterpCoef) 0;
endstruct

struct(PPDynamicBlur) base(PostProcessEffectBase)
    def(_priority) 400;
    def(_internalName) "DynamicBlur";
    def(_RVStringRepr) ["value"];
    
    // blurriness
    def(value) 0;
endstruct

struct(PPFilmGrain) base(PostProcessEffectBase)
    def(_priority) 2000;
    def(_internalName) "FilmGrain";
    def(_RVStringRepr) ["intensity","sharpness","grainSize","intensityX0","intensityX1","monochromatic"];
    
    // intensity (0..1)
    def(intensity) 0.005;
    // sharpness (1..20)
    def(sharpness) 1.25;
    // grain size (1..8)
    def(grainSize) 2.01;
    // intensityX0 (-x..+x)
    def(intensityX0) 0.75;
    // intensityX1 (-x..+x)
    def(intensityX1) 1.0;
    // monochromatic (0 - off, 1 - on)
    def(monochromatic) 0;
endstruct

struct(PPColorInversion) base(PostProcessEffectBase)
    def(_priority) 2500;
    def(_internalName) "ColorInversion";
    def(_RVStringRepr) ["red","green","blue"];
    
    // Inversion of R channel (0..no blur, 1..very blurred)
    def(red) 0;
    // Inversion of G channel (0..no blur, 1..very blurred)
    def(green) 0;
    // Inversion of B channel (0..no blur, 1..very blurred)
    def(blue) 0;
endstruct

struct(PPSSAO) base(PostProcessEffectBase)
    def(_priority) 0;
    def(_internalName) "SSAO";
    def(_RVStringRepr) ["intensity","threshold0","nearRadius","farRadius","nearDist","farDist","depthBlurDist","blurPasses","halfRes","blurHalfRes"];
    
    // intensity (0..1)
    def(intensity) 0;
    // threshold0 (0..1)
    def(threshold0) 0;
    // near radius (0..1)
    def(nearRadius) 0;
    // far radius (0..1)
    def(farRadius) 0;
    // near distance (0..1)
    def(nearDist) 0;
    // far distance (0..1)
    def(farDist) 0;
    // depth blur distance (0..1)
    def(depthBlurDist) 0;
    // number of blur passes (integer)
    def(blurPasses) 0;
    // use half resolution (boolean)
    def(halfRes) false;
    // blur in half resolution (boolean)
    def(blurHalfRes) false;
endstruct

struct(PPResolution) base(PostProcessEffectBase)
    def(_priority) 0;
    def(_internalName) "Resolution";
    def(_RVStringRepr) ["verticalResolution"];
    
    // define the render's vertical resolution (integer, -1..x; <0 - normal, >max - clamped)
    def(verticalResolution) -1;
endstruct

struct(PPSharpness) base(PostProcessEffectBase)
    def(_internalName) "Sharpness";
	def(_RVStringRepr) ["scale"];

    // Scale (minimum 0.01)
    def(scale) 0;
endstruct

struct(PPDOF) base(PostProcessEffectBase)
    def(_internalName) "DOF";
    def(_RVStringRepr) ["scale","focusDistance","blurCoef"];

    // DOF scale (эффект глубины резкости)
    def(scale) 0;
    // DOF focus distance (дистанция фокуса)
    def(focusDistance) 0;
    // DOF blur coefficient (коэффициент размытия)
    def(blurCoef) 0;
endstruct

struct(PPFisheye) base(PostProcessEffectBase)
    def(_internalName) "Fisheye";
	def(_RVStringRepr) ["aperture","scale1","scale2"];

    // Fisheye aperture (апертура, 0-180)
    def(aperture) 0;
    // Fisheye scale1 (масштаб 1)
    def(scale1) 0;
    // Fisheye scale2 (масштаб 2)
    def(scale2) 0;
endstruct

//--------------------------------
// Advanced (engine internal effects)
// --------------------------------

struct(PostProcessEffectInternal) base(PostProcessEffectBase)

endstruct

struct(PPLightShafts) base(PostProcessEffectInternal)
    def(_internalName) "LightShafts";
	def(_RVStringRepr) ["sunInnerRadius","sunOuterRadius","exposure","decay"];

    // inner radius of the sun. 0 = no radius, 1 = full screen
    def(sunInnerRadius) 0.01;
    // outer radius of the sun. Must be > sunInnerRadius. 0 = no radius, 1 = full screen
    def(sunOuterRadius) 0.6;
    // strength of effect
    def(exposure) 0.45;
    // how fast intensity of rays decays with distance
    def(decay) 0.89;
endstruct

struct(PPHBAOPlus) base(PostProcessEffectInternal)
    def(_internalName) "HBAOPlus";
	def(_RVStringRepr) ["radius","bias","detailAO","coarseAO","powerExponent","blurRadius","blurSharpness","fadeSharpness","foregroundViewDepth","backgroundViewDepth"];

    // AO radius in meters
    def(radius) 1;
    // hide low-tessellation artifacts
    def(bias) 0.3;
    // scale factor for the small-scale AO, the greater the darker
    def(detailAO) 0.1;
    // scale factor for the large-scale AO, the greater the darker
    def(coarseAO) 0.5;
    // final AO output is pow(AO, powerExponent)
    def(powerExponent) 3;
    // 0 = disabled blur, 1 = enabled with a radius of 2, 2 = enabled with a radius of 4
    def(blurRadius) 1;
    // the greater the sharpness parameter, the more the blur preserves edges
    def(blurSharpness) 4;
    // fading of the AO with distance (greater value = sharper transition)
    def(fadeSharpness) 5;
    // distance (in meters) of foreground objects
    def(foregroundViewDepth) 2;
    // distance (in meters) of background objects
    def(backgroundViewDepth) 0;
endstruct







