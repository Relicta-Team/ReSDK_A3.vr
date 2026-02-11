// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(vcom_emit_internal_makeParticleWidgetProperties)
{
	params ["_ctg"];
	private _d = call vcom_getDisplay;
	private _yPos = 0; _dropYPos = {_yPos = 0;};
	private _xPos = 0; _dropXPos = {_xPos = 0;};

	private _listConfigs = [_d,LISTBOX,[0,0,10,50],_ctg] call createWidget;
	_ctg setvariable ["_listConfigs",_listConfigs];
	_listConfigs setvariable ["_isReflectorList",_addReflectorsButtons];
	_listConfigs setvariable ["__handleReloadList",{
		params ["_listConfigs"];
		private _it = null;
		private _addReflectorsButtons = _listConfigs getvariable "_isReflectorList";
		private _refList = vcom_emit_lowlevel_allParticles;
		lbclear _listConfigs;
		_listConfigs lbsetcursel -1;

		{
			_x params ["_confgiName","_configRef"];
			_it = _listConfigs lbAdd _confgiName;
			_listConfigs lbSetValue [_it,_foreachindex];
			_listConfigs lbSetTooltip [_it,_confgiName];
		} foreach _refList;

		_listConfigs lbSortBy ["TEXT", false];
	}];
	[_listConfigs] call (_listConfigs getvariable "__handleReloadList");
	_listConfigs ctrladdeventhandler ["LBDblClick",{
		//copypaste from evh _butLoad
		_c = {
			params ["_listConfigs"];
			private _idx = lbcursel _listConfigs;
			if (_idx == -1) exitwith {};
			_idx = _listConfigs lbValue _idx; 
			private _addReflectorsButtons = _listConfigs getvariable "_isReflectorList";
			private _refList = vcom_emit_lowlevel_allParticles;
			if (_idx < 0 || _idx > ((count _refList) - 1)) exitwith {};

			private _ltDat = _refList select _idx select 1;
			
			private _emit = call vcom_emit_relpos_getSelectedEmitter;
			if isNullReference(_emit) exitwith {};
			if ((_emit getvariable "emitType") != "particle") exitwith {setLastError("Undefined behaviour at load config to selected emitter")};
			
			private _data = _emit getvariable "data";
			_emit setvariable ["data",_ltDat];
			//update render value
			[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
			//sync visual values
			call vcom_emit_syncPropsToWidgets;
		};
		nextFrameParams(_c,[(_this select 0)])
	}];

	modvar(_yPos) + 50;

	private _butLoad = [_d,BUTTON,[_xPos,_yPos,10,20],_ctg] call createWidget;
	_butLoad ctrlsettext "Загрузить";
	_butLoad ctrlSetTooltip "Загружает настройки частиц из конфигурации";
	_butLoad ctrladdeventhandler ["MouseButtonUp",{
		_c = {
			params ["_listConfigs"];
			private _idx = lbcursel _listConfigs;
			if (_idx == -1) exitwith {};
			_idx = _listConfigs lbValue _idx; 
			private _addReflectorsButtons = _listConfigs getvariable "_isReflectorList";
			private _refList = vcom_emit_lowlevel_allParticles;
			if (_idx < 0 || _idx > ((count _refList) - 1)) exitwith {};

			private _ltDat = _refList select _idx select 1;
			
			private _emit = call vcom_emit_relpos_getSelectedEmitter;
			if isNullReference(_emit) exitwith {};
			if ((_emit getvariable "emitType") != "particle") exitwith {setLastError("Undefined behaviour at load config to selected emitter")};
			
			private _data = _emit getvariable "data";
			_emit setvariable ["data",
				//deep copy data
				call compile str _ltDat
			];
			//update render value
			[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
			//sync visual values
			call vcom_emit_syncPropsToWidgets;
		};
		nextFrameParams(_c,[(_this select 0)getvariable "_listConfigs"]);
	}];
	_butLoad setvariable ["_listConfigs",_listConfigs];

	modvar(_xPos) + 10; call _dropYPos;



	//private _combo = [_d,"RscCombo",[_xPos,_yPos,10,5],_ctg] call createWidget;
	//

	private _paramList = [
		["Базовые параметры","_sectBasic","Базовые параметры частиц"],
		["Параметры рендеринга","_sectRender","Параметры рендеринга частиц"],
		["Параметры случайности и круга","_sectRandom","Параметры случайности частиц и настроек окружности"]
		//["Параметры круга","_sectCircle","Параметры круга частиц"]
	];
	private _paramCount = count _paramList;
	private _refAll = [];
	private _b = 0;
	private _perItem = (100-_xPos)/_paramCount;
	private _ptrAllControls = null;
	{
		_x params ["_nameBut","_varSect","_desc"];
		
		_ptrAllControls = [];
		
		_b = [_d,BUTTON,[_xPos + _perItem*_foreachindex,0,_perItem,5],_ctg] call createWidget;

		_b ctrlsettext _nameBut;
		_b ctrlSetTooltip _desc;
		
		_refAll pushBack _b;
		
		[_ctg,_varSect,_ptrAllControls] call vcom_emit_internal_addParticleProperties;

		{
			_x setvariable ["___basicPos",(_x call widgetGetPosition) select [0,2]];
		} foreach _ptrAllControls;

		_ctg setvariable [_varSect,_b];
		_b setvariable ["_refAll",_refAll];
		_b setvariable ["_ptrAllControls",_ptrAllControls];

		_b ctrladdeventhandler ["MouseButtonUp",{
			_b = _this select 0;
			nextFrameParams(_b getvariable "_eventSyncVis",_b);
		}];

		_b setvariable ["_eventSyncVis",{
			private _b = _this;
			{
				_allControls = _x getvariable "_ptrAllControls";

				if equals(_b,_x) then {
					{
						[_x,_x getvariable "___basicPos"] call widgetSetPositionOnly;
					} foreach _allControls;
				} else {
					{
						[_x,[200,0]] call widgetSetPositionOnly;
					} foreach _allControls;
				};
			} foreach (_b getvariable "_refAll");
		}];
	} foreach _paramList;
	
	//manually change to
	(_refAll select 0) call ((_refAll select 0) getvariable "_eventSyncVis");

	// ["%1 - debug setup at next frame",__FUNC__] call printWarning;
	// // (_refAll select 2) call ((_refAll select 0) getvariable "_eventSyncVis");
	// _postCall = {
	//  	["directlight"] call vcom_emit_createEmitter;
	//  	[0,true] call vcom_emit_updateSelection;

	// 	["SMALL_FIRE"] call vcom_emit_io_loadConfig;
	// }; nextFrame(_postCall);
}

function(vcom_emit_internal_addParticleProperties)
{
	params ["_ctgParticle","_sectName","_ptrAllControls"]; //каждый объект нужно добавить в _ptrAllControls
	private _d = call vcom_getDisplay;
	private _defBackground = [0.3,0.3,0.3,1];
	private _constBasicYPos = 5;
	private _yPos = _constBasicYPos; _dropYPos = { _yPos = _constBasicYPos};
	private _xPos = 10; //because left widget is listbox of particles
	_dropXPos = { _xPos = 0};
	private _perButtonSizeH = 0; private _setPBSizeHByButtonCount = { private _c = _this; _perButtonSizeH = (100-_constBasicYPos)/_c;};
	private _perButtonSizeW = 0; private _setPBSizeWByButtonCount = { private _c = _this; _perButtonSizeW = (100-_xPos)/_c;};
	private _listData = [];
	call {
		private _genEvSetup = vcom_emit_internal_common_currentEmitterPropertySetup;
		private _evSetupCombo = vcom_emit_internal_common_currentEmitterPropertySetup_forComboBox;
		
		if (_sectName == "_sectBasic") exitwith {
			8 call _setPBSizeHByButtonCount;
			3 call _setPBSizeWByButtonCount;
			
			_itemList = array_copy(vcom_emit_lowlevel_allParticleShapes);
			
			//vcom_emit_internal_createZoneComboBox
			private _colBackPartModelType = "#5F077B" call color_HTMLtoRGBA;
			_listData pushBack ["ComboBox",
				["_zoneParticleShape",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleShape",["Спрайт","(particleShape) - Это модель частиц, которая используется\n"+
				"для данного класса частиц/эффекта. Это также определяет текстуру, используемую\n"+
				"для частицы. nTieth, FSIndex, FSLoop и FSFrameCount связаны со спрайтом.\n"+
				"Текстура частиц обычно состоит из небольших изображений, расположенных подряд\n"+
				"в несколько рядов, например, в случае пламени или взрыва, изображения в основном\n"+
				"представляют собой кадры одного пламени в разных фазах его 'жизни'.\n"+
				"Biki называет это 'анимацией', что означает анимацию эффекта частиц.\n"+
				"Поэтому думайте о пламени или взрыве как о старой школьной пошаговой анимации.\n\n"+
				"В случае огня среднего разрушения в эффекте используется спрайт,\n"+
				"называемый 'Universal'. И он использует текстуру под названием\n"+
				"'universal'. Обратите внимание, что иногда название текстуры далеко\n"+
				"не совпадает с названием спрайта, многие из них используют одну и ту же текстуру.\n"+
				"Текстура 'universal' выглядит следующим образом <нажмите ЛКМ для открытия>.\n\n"+
				"Для просмотра текстуры спрайта нажмите ПКМ"],_colBackPartModelType,1.5,_itemList,"contains"],
				_evSetupCombo,
				{
					private _t = _this getvariable "_text";
					_t setvariable ["_list",_this getvariable "_list"];
					_t ctrladdeventhandler ["MouseButtonUp",{
						
						if ((_this select 1)== 1) exitwith {
							_list = (_this select 0) getvariable "_list";
							_data = _list lbdata (lbcursel _list);
							if (_data == "") exitwith {};

							call wch_enable;
							_nfcall = {
								_data = _this;
								_ctg = null;//[call vcom_getDisplay,WIDGETGROUP,WIDGET_FULLSIZE,call vcom_getCtg] call createWidget;
								(call wch_getControlStorage) set [0,_ctg];
								_back = [call vcom_getDisplay,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
								(call wch_getControlStorage) set [1,_back];
								_back setBackgroundColor [1,1,1,1];
								_back ctrlSetActiveColor  [1,1,1,1];
								_h = 70;
								_w = getWidthByHeightToSquare(70);
								_pic = [call vcom_getDisplay,"RscActivePicture",
									[50-_w/2,50-_h/2,_w,_h]
								,_ctg] call createWidget;
								_pic ctrlsettext (_data call vcom_emit_lowlevel_getSpriteTexture);
								_pic ctrlsettextColor [1,1,1,1];
								(call wch_getControlStorage) set [2,_pic];

								_b = [call vcom_getDisplay,BUTTON,[50-_w/2 ,50+_h/2,_w/2,100-(_h+50-_h/2)],_ctg] call createWidget;
								_b ctrlsettext "Закрыть";
								(call wch_getControlStorage) set [3,_b];
								ctrlsetfocus _b;
								_b ctrladdeventhandler ["MouseButtonUp",{
									call wch_disable;
								}];

								_b = [call vcom_getDisplay,BUTTON,[50-_w/2 + (_w/2),50+_h/2,_w/2,100-(_h+50-_h/2)],_ctg] call createWidget;
								_b ctrlsettext "Сменить цвет фона";
								_b setvariable ["_back",_back];
								(call wch_getControlStorage) set [4,_b];
								_b ctrladdeventhandler ["MouseButtonUp",{
									_back = (_this select 0)getvariable "_back";
									_doblack = (_back getvariable ["_doblack",false]);
									if (_doblack) then {
										_back setBackgroundColor [1,1,1,1];
										_back ctrlSetActiveColor [1,1,1,1];
									} else {
										_back setBackgroundColor [0,0,0,1];
										_back ctrlSetActiveColor [0,0,0,1];
									};
									_back setvariable ["_doblack",!_doblack];
								}];
							}; nextFrameParams(_nfcall,_data);

						};

						_c = {

							[core_path_data+"/universal_ca_row_idx.png"] call file_open;
						};
						nextFrame(_c);
					}];
				}
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["ComboBox",
				["_zoneParticleType",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleType",["Тип частиц","(particleType) - Какую частицу использовать, либо текстуру (2D),\n"+
				"который используется для большинства эффектов частиц, либо модель,\n"+
				"представляющую собой 3D-частицу, используемую для создания таких вещей,\n"+
				"как мухи и тому подобное. Обратите внимание, что некоторые более поздние\n"+
				"параметры, а именно связанные с вращением, ведут себя немного по-разному для\n"+
				"каждого типа, очевидно, что 3D-частица может вращаться в 3D, а 2D - нет."],_colBackPartModelType,1.5,[vec2("Текстура","Billboard"),vec2("3d объект","SpaceObject")],"equalnocase"],
				_evSetupCombo
			];modvar(_yPos)+_perButtonSizeH;

			modvar(_yPos)+_perButtonSizeH;

			private _colBackPartRend = "#BA8D04" call color_HTMLtoRGBA;
			_listData pushBack ["Input",
				["_zoneParticleFSNtieth",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleFSNtieth",["n-tieth","(nTieth) - Согласно Biki, значение представляет собой коэффициент\n"+
				"размера текстуры (в пикселях): 2048/коэф.\n"+
				"Что все еще не говорит так много (я думаю, это сообщает игре, что высота строки равна 2048 / XX пикселям)\n\n"+
				"Проверки показали, что во встроенных конфигах платформы это значение обычно бывает: 1,4,8 и 16"],
				false, [1,64],0.001,_colBackPartRend,1.5,20,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleFSIndex",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleFSIndex",["Индекс","(FSIndex) - Этот параметр означает индекс (или номер) вертикального ряда кадров.\n"+
				"Номер индекса начинается с 0 (нуля), как и в массивах, поэтому 0 - это самая верхняя строка, 1 - следующая вниз и т.д.\n\n"+
				"Проверки показали, что во встроенных конфигах платформы это значение обычно бывает от 0 до 14"],
				false, [0,30],1,_colBackPartRend,1.5,50,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleFSFrameCount",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleFSFrameCount",["Количество кадров","(FSFrameCount) - Этот параметр означает количество воспроизводимых кадров,\n"+
				"начиная с заданной строки кадров, определенной с помощью параметра индекса (FSIndex).\n"+
				"В случае MediumDestructionFire количество равно 32, что составляет две полные строки, и,\n"+
				"как вы можете видеть на изображении <кликните по 'Спрайт' для просмотра>, начиная со строки 10,\n"+
				"все следующие 32 кадра имеют одинаковое пламя."],
				false, [1,100],1,_colBackPartRend,1.3,50,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Checkbox",
				["_zoneParticleFSLoop",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["particleFSLoop",["Зацикливание","(FSLoop) - Этот параметр означает, что анимация будет\n"+
				"зацикливаться, например, если частица все еще жива и достигнуты 32 кадра,\n"+
				"она начнется сначала и будет воспроизводиться через 32 кадра, пока частица не умрет.\n"+
				"Когда флаг установлен, анимация будет зацикливаться."],
				_defBackground,1.2,false],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			//ontimer delay skipped
			modvar(_yPos)+_perButtonSizeH;



			//next region ----------------------------------------------
			6 call _setPBSizeHByButtonCount;
			call _dropYPos;
			modvar(_xPos) + _perButtonSizeW;

			//Используется позиция аттачинга поэтому данный параметр неуместен
			// _listData pushBack ["Vec3",
			// 	["_zoneParticlePosition",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
			// 	["position",["X","Y","Z","(position) - Этот параметр означает трехмерное положение относительно объекта, к которому прикреплен излучатель."],
			// 		[-50,50],0.01,null,1.0],
			// 	_genEvSetup
			// ];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Скорость частицы</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Vec3",
				["_zoneParticleVelocity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["moveVelocity",["X","Y","Z","(moveVelocity) - Этот параметр означает вектор скорости частицы, [x, y, z].\nКак в направлении движения в трехмерном пространстве."],
					[-50,50],0.001,_defBackground,1.0],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			private _backColorMoving = "#0D72BA" call color_HTMLtoRGBA;
			_listData pushBack ["Input",
				["_zoneParticleRotationVelocity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["rotationVelocity",["Скорость вращения","(rotationVelocity) - Этот параметр означает число с плавающей точкой,\n"+
				"сколько оборотов совершает частица в секунду."],
				true, [0,100],0.001,_backColorMoving,0.9],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandomDirectionIntensity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["randomDirectionIntensity",["Случ.интенсивность направления","(randomDirectionIntensity) - Информация об этом немного расплывчата, но, похоже, это значение,\n"+
				"которое добавляется к каждому элементу вектора скорости перемещения.\n"+
				"Это значение, выбранное случайным образом между 0 и показанным значением."],
				true, [0,100],0.001,_backColorMoving,0.9],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandomDirectionPeriod",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["randomDirectionPeriod",["Случ.период направления","(randomDirectionPeriod) - Интервал (в секундах), в течение которого происходит случайное изменение\n"+
				"интенсивности направления вектора скорости перемещения."],
				true, [0,100],0.001,_backColorMoving,0.9],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			private _backColPhysx = "#184D10" call color_HTMLtoRGBA;
			_listData pushBack ["Input",
				["_zoneParticleWeight",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2]],
				["weight",["Вес","(weight) - Масса частицы, выраженная в килограммах. Влияет на то, как излучатель взаимодействует с окружающим воздухом."],
				false, [0,200],0.001,_backColPhysx,1.2,40,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Input",
				["_zoneParticleWeight",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2]],
				["volume",["Объём","(volume) - Объем частицы в кубических метрах (м^3). Влияет на то, как излучатель взаимодействует с окружающим воздухом."],
				false, [0,100],0.001,_backColPhysx,1.2,40,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Input",
				["_zoneParticleRubbing",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2]],
				["rubbing",["Трение","(Friction) - Этот параметр определяет, какое трение о воздух имеет частица, чем выше значение,\n"+
				"тем больше трение и, следовательно, тем труднее частице перемещаться по воздуху.\n"+
				"Влияет на скорость частицы.\n"+
				"Это также определяет, как ветер влияет на движение частиц (чем больше трение, тем больше ветер может “захватить” частицу).\n"+
				"0 трение означает, что частица движется по воздуху без какого-либо трения, как будто в вакууме."],
				false, [0,10],0.001,_backColPhysx,1.2,40,true],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH/2;

			//next region ----------------------------------------------
			4 call _setPBSizeHByButtonCount;
			call _dropYPos;

			modvar(_xPos) + _perButtonSizeW;
			private _backParticleCreation = "#A6465A" call color_HTMLtoRGBA;
			_listData pushBack ["Input",
				["_zoneParticleAngle",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["angle",["Угол","(angle) - Определяет начальный угол частицы\n"+
				"При использовании типа 3д-объект угол частиц изменяется на вектор направления."],
				true, [0,360],0.001,_backParticleCreation,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;
			
			modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Input",
				["_zoneParticleInterval",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["interval",["Интервал создания","(angle) - Интервал, в течение которого новая частица испускается из эмиттера.\n"+
				"Время указано в секундах."],
				true, [0,60],0.001,_backParticleCreation,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleLifeTime",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["lifeTime",["Время жизни","(lifeTime) - Этот параметр означает время в секундах, в течение которого частица будет 'живой'."],
				true, [0,60*2],1,_backParticleCreation,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;
			
		};
		if (_sectName == "_sectRender") exitwith {
			8 call _setPBSizeHByButtonCount;
			3 call _setPBSizeWByButtonCount;

			//значения анимации, размера могут быть нулевыми,
			//но установить значения можно только если предыдущий индекс имеет значение
			
			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center' size='1'>Управление кадрами частиц</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;
			_backRenderFrameColor = "#661CC7D6" call color_HTMLtoRGBA;

			_listData pushBack ["_runtimeInput",
				["_zoneParticleRuntimeInputCurFrame",[_xPos + _perButtonSizeW/4*1,_yPos,_perButtonSizeW/2,_perButtonSizeH]],
				["Текущий индекс кадра анимации.\n\nНа анимацию также влияет время жизни частицы, поэтому при работе с анимацией\n"+
				"все следующие параметры воспроизводятся вместе: Sprite, nTieth, Index, Count, Loop, Lifetime, Scale и AnimSpeed.\n"+
				"Если время жизни частицы больше, чем у анимации, и анимация не зациклена, последний кадр анимации показывается до тех пор,\n"+
				"пока частица не умрет.\n\nЭто поле только для чтения.",_backRenderFrameColor,true],
				{
					private _input = _this getvariable "_input";
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};
					private _emit = call vcom_emit_relpos_getSelectedEmitter;
					_input ctrlsettext str(_emit getvariable "animIndex");
				}
			];
			
			//next-prev jump

			_listData pushBack ["_buttonFrameMod",
				["_zoneParticleButtonChangeCurFrameRem",[_xPos,_yPos,_perButtonSizeW/4,_perButtonSizeH]],
				[["< пред.","Переход к предыдущему кадру"],null],
				{
					setScopeName("_buttonCurFrameMod-");
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};
					private _emit = call vcom_emit_relpos_getSelectedEmitter;
					private _data = _emit getvariable "data";
					private _maxIndex = call vcom_emit_lowlevel_RenderParams_getMaxStepnr;
					_emit setvariable ["animIndex",((_emit getvariable "animIndex") - 1) max 0];
					[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
					call vcom_emit_syncPropsToWidgets;

				}
			];
			_listData pushBack ["_buttonFrameMod",
				["_zoneParticleButtonChangeCurFrameAdd",[_xPos + _perButtonSizeW/4*3,_yPos,_perButtonSizeW/4,_perButtonSizeH]],
				[["след. >","Переход к следующему кадру"],null],
				{
					setScopeName("_buttonCurFrameMod+");
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};
					private _emit = call vcom_emit_relpos_getSelectedEmitter;
					private _data = _emit getvariable "data";
					private _maxIndex = call vcom_emit_lowlevel_RenderParams_getMaxStepnr;
					_emit setvariable ["animIndex",((_emit getvariable "animIndex") + 1) min _maxIndex];
					[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
					call vcom_emit_syncPropsToWidgets;
				}
			];

			modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["_buttonFrameMod",
				["_zoneParticlebuttonFrameModMinus",[_xPos,_yPos,_perButtonSizeW/4,_perButtonSizeH]],
				[["-","Удалить последний кадр\nЭтот параметр уменьшает дипазон кадров на -1. Допустим, если диапазон было от 0 до 4,\n"+
				"то при уменьшении он станет от 0 до 3."],null],
				{
					setScopeName("_buttonFrameMod-");
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};
					private _emit = call vcom_emit_relpos_getSelectedEmitter;
					private _data = _emit getvariable "data";

					private _allSizes = [_data,"size"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allAnimSpeeds = [_data,"animationSpeed"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allColors = [_data,"color"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allEmissiveColors = [_data,"emissiveColor"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					//TODO replace get _stepnr to vcom_emit_lowlevel_RenderParams_getMaxStepnr
					private _stepnr = (((count _allSizes) max (count _allColors)) max (count _allAnimSpeeds)) - 1;
					//Дополнительная отладка логики
					if not_equals(_stepnr,call vcom_emit_lowlevel_RenderParams_getMaxStepnr) exitwith {
						setLastError(__FUNC__ + " - mismatch stepnr; LV: "+str _stepnr + "; vcom_emit_lowlevel_RenderParams_getMaxStepnr:"+ str (call vcom_emit_lowlevel_RenderParams_getMaxStepnr));
					};
					if (_stepnr > 0) then {
						{
							_x deleteAt _stepnr;
						} foreach [_allSizes,_allAnimSpeeds,_allColors,_allEmissiveColors];
						
						DEC(_stepnr);

						_emit setvariable ["animIndex",(_emit getvariable "animIndex") min _stepnr];

						[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
						call vcom_emit_syncPropsToWidgets;
					};

				}
			];
			_listData pushBack ["_buttonFrameMod",
				["_zoneParticlebuttonFrameModPlus",[_xPos + _perButtonSizeW/4*3,_yPos,_perButtonSizeW/4,_perButtonSizeH]],
				[["+","Добавить новый кадр"],null],
				{
					setScopeName("_buttonFrameMod+");
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};
					private _emit = call vcom_emit_relpos_getSelectedEmitter;
					private _data = _emit getvariable "data";
					
					private _allSizes = [_data,"size"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allAnimSpeeds = [_data,"animationSpeed"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allColors = [_data,"color"] call vcom_emit_lowlevel_getRenderParamsValueFromData;
					private _allEmissiveColors = [_data,"emissiveColor"] call vcom_emit_lowlevel_getRenderParamsValueFromData;

					//вот это максимальный индекс
					//Можно смело юзать vcom_emit_lowlevel_RenderParams_getMaxStepnr
					//TODO replace to vcom_emit_lowlevel_RenderParams_getMaxStepnr
					private _stepnr = (((count _allSizes) max (count _allColors)) max (count _allAnimSpeeds)) - 1;
					//Дополнительная отладка логики
					if not_equals(_stepnr,call vcom_emit_lowlevel_RenderParams_getMaxStepnr) exitwith {
						setLastError(__FUNC__ + " - mismatch stepnr; LV: "+str _stepnr + "; vcom_emit_lowlevel_RenderParams_getMaxStepnr:"+ str (call vcom_emit_lowlevel_RenderParams_getMaxStepnr));
					};
					INC(_stepnr);
					
					//sizes применяется с фильтром
					_allSizes set [_stepnr,0];
					{
						if isNullVar(_x) then {
							_allSizes set [_foreachIndex,0];
							[(__FUNC__ + " null vaule catched. Logical error")] call printWarning;
						};
					} foreach _allSizes;

					// Добавление только через пользователя
					//_allAnimSpeeds set [count _allAnimSpeeds,0];
					//_allColors set [count _allColors,[0,0,0,0]];
					//_allEmissiveColors set [count _allEmissiveColors,[0,0,0,0]];

					//Поскольку мы изменяли ссылки из _data то нам нужно просто синхронизировать визуальные значения
					[_emit] call vcom_emit_prop_syncEmitterPropsFromData;
					//sync visual values
					call vcom_emit_syncPropsToWidgets;
				}
			];
			
			_listData pushBack ["_runtimeInput",
				["_zoneParticleRuntimeInputMaxFrame",[_xPos + _perButtonSizeW/4*1,_yPos,_perButtonSizeW/2,_perButtonSizeH]],
				["Количество кадров анимации. Первый кадр - это номер 0 (ноль), второй кадр - 1 и так далее.\n\nЭто поле только для чтения.",_backRenderFrameColor,true],
				{
					private _input = _this getvariable "_input";
					if !(call vcom_emit_relpos_hasSelectedEmitter) exitwith {};

					_input ctrlsettext str(call vcom_emit_lowlevel_RenderParams_getMaxStepnr);
				}
			];

			modvar(_yPos)+_perButtonSizeH + _perButtonSizeH;
			_backColorParticleSizeAndSpeed = "#C77324" call color_HTMLtoRGBA;
			
			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH],
				{
					[_this,"<t align='center'>Настройки размера и скорости анимации</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleSize",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["size",["Размер","(size) - Этот параметр означает размер частицы в заданном кадре. Размер указан в метрах."],
				false, [0,100],1,_backColorParticleSizeAndSpeed,1.1,70,true],
				_genEvSetup,
				{
					(_this getvariable "_inp_")ctrlSetDisabledColor ("#ff0000" call color_HTMLtoRGBA); 
				}
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleAnimationSpeed",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["animationSpeed",["Скорость анимации","(animationSpeed) - Как быстро “пропускается кадр“; согласно BIKI 'количество циклов анимации за 1 секунду'.\n"+
				"Таким образом, скорость - это своего рода FPS для анимации. Чем выше значение, тем, конечно, выше скорость."],
				false, [0,100],1,_backColorParticleSizeAndSpeed,1.1,70,true],
				_genEvSetup,
				{
					(_this getvariable "_inp_")ctrlSetDisabledColor ("#ff0000" call color_HTMLtoRGBA); 
				}
			];modvar(_yPos)+_perButtonSizeH;

			//----------------------------------- colors prefs -----------------------------
			4 call _setPBSizeHByButtonCount;
			call _dropYPos;
			modvar(_xPos) + _perButtonSizeW;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/3],
				{
					[_this,"<t align='center'>Цвет частиц</t>"] call widgetSetText;
					_this ctrlSetTooltip ("Цвет частиц на текущем кадре\n"+
					"Параметр A (альфа) цвета означает прозрачность, чем ниже значение, тем прозрачнее частица.\n"+
					"Для частиц отрицательное значение в виде альфа переводится в значение яркости частиц, чем меньше число, тем выше яркость.");
				}
			];modvar(_yPos)+_perButtonSizeH/3;

			_listData pushBack ["_Vec4_RenderParams",
				["_zoneColor",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["color",["R","G","B","A"],[[0,1],[-1,1]] 
				,0.001,null,1.2,true],
				_genEvSetup
				,
				{
					for "_i" from 0 to 3 do {
						{
							(_this getvariable (_x+str _i)) ctrlSetDisabledColor ("#ff0000" call color_HTMLtoRGBA); 
						} foreach ["_inp_","_slid_"];

					};
				}
			]; modvar(_yPos)+_perButtonSizeH;

			/*
				Свечение отключено

				Так как в платформе не было найдено ни единого места, где оно используется...
			*/
			// _listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/3],
			// 	{
			// 		[_this,"<t align='center'>Цвет свечения частиц</t>"] call widgetSetText;
			// 		_this ctrlSetTooltip ("Цвет свечения частиц на текущем кадре\n"+
			// 		"Этот параметр отвечает за цвет свечения частицы в темноте");
			// 	}
			// ];modvar(_yPos)+_perButtonSizeH/3;

			// _listData pushBack ["_Vec4_RenderParams",
			// 	["_zoneEmissiveColor",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
			// 	["emissiveColor",["R","G","B","A"],[[0,1],[-1,1]] 
			// 	,0.001,null,1.2],
			// 	_genEvSetup
			// 	,
			// 	{
			// 		for "_i" from 0 to 3 do {
			// 			{
			// 				(_this getvariable (_x+str _i)) ctrlSetDisabledColor ("#ff0000" call color_HTMLtoRGBA); 
			// 			} foreach ["_inp_","_slid_"];

			// 		};
			// 	}
			// ]; modvar(_yPos)+_perButtonSizeH;


		};
		if (_sectName == "_sectRandom") exitwith {
			3 call _setPBSizeWByButtonCount;
			6 call _setPBSizeHByButtonCount;

			private _backVec3PosVel = "#484848" call color_HTMLtoRGBA;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Случайная позиция</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Vec3",
				["_zoneParticleRandPosVar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["positionVar",["X","Y","Z","(randomPosition) - Этот параметр работает как и время жизни - рандомизированное положение\n"+
				"между позицией базовых параметров и этим. Каждый векторный элемент рандомизируется индивидуально."],
					[-10,10],0.001,_backVec3PosVel,1.0],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Случайная скорость</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Vec3",
				["_zoneParticleRandMoveVelocityvar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["moveVelocityVar",["X","Y","Z","(randomMoveVelocity) - Это рандомизированный вектор скорости перемещения между базовыми параметрами\n"+
				"moveVelocity и этим. Каждый векторный элемент рандомизируется индивидуально."],
					[-50,50],0.001,_backVec3PosVel,1.0],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			private _backColorLifeVelSc = "#4D962A93" call color_HTMLtoRGBA;

			_listData pushBack ["Input",
				["_zoneParticleLifetimevar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["lifeTimeVar",["Время жизни","(randomLifeTime) - Этот параметр означает интерполяцию между\n"+
				"значением времени жизни в базовых параметрах и этим."],
				false, [0,100],1,_backColorLifeVelSc,1.1,60],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandRotationVelocityVar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["rotationVelocityVar",["Скорость вращения","(randomRotationVelocity) - Это значение рандомизатора скорости вращения,\n"+
				"рандомизированное между базовыми параметрами rotationVelocity и этим."],
				false, [0,100],1,_backColorLifeVelSc,1.1,60],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandScaleVar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["sizeVar",["Размер","(randomSize) - Рандомизатор для размера частиц, определенного в параметрах рендеринга."],
				false, [0,100],1,_backColorLifeVelSc,1.1,60],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			//tab 2 --------------------------------------------------------
			modvar(_xPos)+_perButtonSizeW;
			call _dropYPos;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Рандомизатор цвета</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			private _colorsRandomBack = "#67876F" call color_HTMLtoRGBA;

			_listData pushBack ["Vec3",
				["_zoneParticleRandColor",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["colorVar",["R","G","B","(randomColor) - Это рандомизатор для цвета, установленного в параметрах рендеринга.\n"+
				"Рандомизирует настройки цвета каждого кадра индивидуально."],
					[0,1],0.001,_colorsRandomBack,1.0],
				_genEvSetup
				,null, true //for vcom_emit_internal_createZonevec3
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandColorAlpha",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["colorVarA",["Альфа-канал","(randomColorAlpha) - Этот параметр означает рандомизатор прозрачности, чем ниже значение, тем прозрачнее частица.\n"+
					"Для частиц отрицательное значение переводится в значение яркости частиц, чем меньше число, тем выше яркость.\n"+
				"Рандомизирует настройки альфы каждого кадра индивидуально."],
				true, [-1,1],0.001,_colorsRandomBack,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;
			
			//blue zone
			private _dirRandBack = "#2751BA" call color_HTMLtoRGBA;

			_listData pushBack ["Input",
				["_zoneParticleRandDirIntensity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["randomDirectionIntensityVar",["Случ.интенсивность направления","(randomized_DirectionIntensity) - Этот параметр интерполирует случайное значение между randomDirectionIntensity и этим."],
				false, [0,100],1,_dirRandBack,1.1,40],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandDirPeriodVar",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["randomDirectionPeriodVar",["Случ.период направления","(randomized_DirectionPeriod) - интервал (в секундах). Этот параметр интерполирует случайное значение между randomDirectionPeriod и этим."],
				false, [0,100],1,_dirRandBack,1.1,40],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["Input",
				["_zoneParticleRandAngle",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["angleVar",["Ранд. угол","(randomAngle) - Этот параметр интерполирует случайное значение между параметром angle и этим."],
				true, [0,360],0.001,_dirRandBack,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			//tab 3 --------------------------------------------------------
			modvar(_xPos)+_perButtonSizeW;
			call _dropYPos;

			private _colBackCircle = "#4D781CBA" call color_HTMLtoRGBA;
			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,100],
				{
					_this setBackgroundColor [0.1,0.1,0.1,0.2];
				}
			];

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Настройки окружности</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Input",
				["_zoneParticleCircleRadius",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["circleRadius",["Радиус","(circleRadius) - Этот параметр означает радиус окружности, созданной на месте расположения эмиттера, в метрах. Центр круга - это положение эмиттера."],
				true, [0,50],0.01,_colBackCircle,1.1],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

			_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
				{
					[_this,"<t align='center'>Вектор скорости окружности</t>"] call widgetSetText;
				}
			];modvar(_yPos)+_perButtonSizeH/2;

			_listData pushBack ["Vec3",
				["_zoneParticleCircleVelocity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
				["circleVelocity",["X","Y","Z","(circleVelocity) - Это вектор скорости вдоль окружности диска, определяемой радиусом."],
					[-20,20],0.001,_colBackCircle,1.0],
				_genEvSetup
			];modvar(_yPos)+_perButtonSizeH;

		};
		// if (_sectName == "_sectCircle") exitwith {
			
		// 	3 call _setPBSizeWByButtonCount;
		// 	6 call _setPBSizeHByButtonCount;

		// 	private _colBackCircle = "#4D781CBA" call color_HTMLtoRGBA;

		// 	_listData pushBack ["Input",
		// 		["_zoneParticleCircleRadius",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
		// 		["circleRadius",["Радиус","(circleRadius) - Этот параметр означает радиус окружности, созданной на месте расположения эмиттера, в метрах. Центр круга - это положение эмиттера."],
		// 		true, [0,50],0.01,_colBackCircle,1.1],
		// 		_genEvSetup
		// 	];modvar(_yPos)+_perButtonSizeH;

		// 	_listData pushBack ["simpleText",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH/2],
		// 		{
		// 			[_this,"<t align='center'>Вектор скорости окружности</t>"] call widgetSetText;
		// 		}
		// 	];modvar(_yPos)+_perButtonSizeH/2;

		// 	_listData pushBack ["Vec3",
		// 		["_zoneParticleCircleVelocity",[_xPos,_yPos,_perButtonSizeW,_perButtonSizeH]],
		// 		["circleVelocity",["X","Y","Z","(circleVelocity) - Это вектор скорости вдоль окружности диска, определяемой радиусом."],
		// 			[-20,20],0.001,_colBackCircle,1.0],
		// 		_genEvSetup
		// 	];modvar(_yPos)+_perButtonSizeH;
		// };

	};//endof scrited switch

	private _w = null;
	{
		_x params ["_callerVar","_genericParams","_customParams",["_evUpd",_genEvSetup],["_postCreateEvent",{}],["_opt",null]];
		
		if (_callerVar == "simpleText") then {
			private _code = _customParams;
			if not_equalTypes(_code,{}) exitwith {
				setLastError(__FUNC__ + " - Wrong type on create zone "+_callerVar+"; Type was "+typename _code);
			};
			private _t = [_d,TEXT,_genericParams,_ctgParticle] call createWidget;
			_t call _code;
			_ptrAllControls pushBack _t;

			continue;
		};
		
		_genericParams params ["_zoneStorageName","_sizes"];
		//params ["_varname","_size","_ctg","_props","_eventUpdate"]
		_w = [_zoneStorageName,_sizes,_ctgParticle,_customParams,_evUpd,_opt] call (missionNamespace getvariable ["vcom_emit_internal_createZone"+_callerVar,{
			setLastError(__FUNC__ + " - Error on call function (not exists): vcom_emit_internal_createZone"+_callerVar);
			widgetNull;
		}]);

		_w call _postCreateEvent;

		//create control
		//add new control zone to _ptrAllControls
		_ptrAllControls pushBack _w;
	} foreach _listData;
}

function(vcom_emit_debug_collectWidgetInfo)
{
	private _output = "//generated in "+__FUNC__ + endl + "[";
	private _isFirst = true;
	{
		if ("HNEG_ped" in (ctrlClassName _x)) then {
			modvar(_output) + endl + ifcheck(_isFirst,"",",")+ (format["[%1,%2]",str (ctrlClassName _x),_x call widgetGetPosition]);
			_isFirst =false;
		};
	} foreach (allControls getEdenDisplay);

	_output + endl + "]"
}


function(vcom_emit_prop_internal_getParticleAssoc)
{
	[
		["particleParams", [0]],
		["particleShape", [0, 0, 0]], 
		["particleFSNtieth", [0, 0, 1]], 
		["particleFSIndex", [0, 0, 2]], 
		["particleFSFrameCount", [0, 0, 3]], 
		["particleFSLoop", [0, 0, 4]], 
		["particleType", [0, 2]], 
		["timerPeriod", [0, 3]], 
		["lifeTime", [0, 4]], 
		//do not used
		["position", [0, 5]], 
			["positionx", [0, 5, 0]], 
			["positiony", [0, 5, 1]], 
			["positionz", [0, 5, 2]], 
		["moveVelocity", [0, 6]], 
			["moveVelocityx", [0, 6, 0]], 
			["moveVelocityy", [0, 6, 1]], 
			["moveVelocityz", [0, 6, 2]], 
		["rotationVelocity", [0, 7]], 
		["weight", [0, 8]], 
		["volume", [0, 9]], 
		["rubbing", [0, 10]], 
		["size", [0, 11]], 
		["color", [0, 12]], 
			["colorr", [0, 12, 0]], 
			["colorg", [0, 12, 1]], 
			["colorb", [0, 12, 2]], 
			["colorA", [0, 12, 3]], //alpha channel
		["animationSpeed", [0, 13]], 
		["randomDirectionPeriod", [0, 14]], 
		["randomDirectionIntensity", [0, 15]], 
		["onTimerScript", [0, 16]], 
		["beforeDestroyScript", [0, 17]], 
		["attachTo", [0, 18]], 
		["angle", [0, 19]], 
		["onSurface", [0, 20]], 
		["bounceOnSurface", [0, 21]], 
		["emissiveColor",  [0, 22]], //в конфигах emissiveColor везде равен [] 
			["emissiveColorr",  [0, 22, 0]],
			["emissiveColorg",  [0, 22, 1]],
			["emissiveColorb",  [0, 22, 2]],
			["emissiveColorA",  [0, 22, 3]], //alpha channel
		["particleRandom",[1]],
		["lifeTimeVar", [1, 0]], 
		["positionVar",  [1, 1]], 
			["positionVarX",  [1, 1, 0]], 
			["positionVarY",  [1, 1, 1]], 
			["positionVarZ",  [1, 1, 2]], 
		["moveVelocityVar", [1, 2]], 
			["moveVelocityVarX", [1, 2, 0]], 
			["moveVelocityVarY", [1, 2, 1]], 
			["moveVelocityVarZ", [1, 2, 2]], 
		["rotationVelocityVar", [1, 3]], 
		["sizeVar",  [1, 4]], 
		["colorVar", [1, 5]], 
			["colorVarR", [1, 5, 0]], 
			["colorVarG", [1, 5, 1]], 
			["colorVarB", [1, 5, 2]], 
			["colorVarA", [1, 5, 3]], 
		["randomDirectionPeriodVar", [1, 6]], 
		["randomDirectionIntensityVar",  [1, 7]], 
		["angleVar",  [1, 8]], 
		["bounceOnSurfaceVar",  [1, 9]], 
		["particleCircle",[2]],
		["circleRadius", [2, 0]], 
		["circleVelocity", [2, 1]], 
			["circleVelocityX", [2, 1, 0]], 
			["circleVelocityY", [2, 1, 1]], 
			["circleVelocityZ", [2, 1, 2]], 
		["particleFile",[3]],
		["coreIntensity", [3, 0]], 
		["coreDistance", [3, 1]], 
		["damageTime", [3, 2]], 
		["particleDropInterval",[4]],
		["interval",  [4]], 
		["damageType", [5]] 
	]
}

function(vcom_emit_lowlevel_createParticleData)
{
	array_copy(vcom_emit_lowlevel_allParticles select 1 select 1)

	/*
	//Actual config info
	[
		[
			["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,0],
			"","Billboard",1,5,
			[0,0,0],
			[0,0,0],
			0,1.278,1,0.5,[0.15,1.8,2.8],
			[[0.22,0.22,0.22,0.35],[0.25,0.25,0.25,0.22],[0.25,0.25,0.25,0.1],[0.25,0.25,0.25,0.04],[0.25,0.25,0.25,0.01]],
			[1],
			0.1,0.2,
			"","",
			"",
			0,false,
			-1,[]
		],
		[0.5,[0.05,0.05,0.05],[0.25,0.25,0.25],0,0.3,[0,0,0,0],0,0,360,0],
		[0,[0,0,0]],
		"",
		0.03
	]

	also we can use this:
		#define __BASEVALS [\
		[[],"", "", 0, 0, [], [], 0, 0, 0, 0, [], [], [], 0, 0, "", "", "", 0, true, 0],\
		[[0, [], [], 0, 0, [], 0, 0, 0], [0, [], [], 0, 0, [], 0, 0, 0, 0]],\
		[0, []],\
		[0, 0, 0],\
		0\
	]
	*/

	//!do not use this fucking config...
	// [
	// 	[ 
	// 		[ "\A3\data_f\ParticleEffects\Universal\Universal" , 16 , 12 , 0 , 8 ] ,
	// 		"" , "Billboard" , 1 , 3 ,						 // animationName, type, timerPeriod, lifeTime 
	// 		[ 0 , 1.5 , 0 ] ,									 // позиция относительно referenceObject 
	// 		[ 0 , 0 , 0 ] ,									 // скорость 
	// 		0 , 0.005, 0.003925 , 0.1 , [ 0.25 , 0.75 ] ,		 // вращение, вес, объем, трение, размер 
	// 		[ [ 1 , 0 , 0 , 0.5 ] , [ 0 , 1 , 0 , 1 ] , [ 0 ,0,01 , 0.25 ] ] ,	 // цвета 
	// 		[ 1 ] ,										 // фаза анимации 
	// 		0 , 0,										 // randomDirectionPeriod, randomDirectionIntensity 
	// 		"" , "" ,										 // onTimer, beforeDestroy 
	// 		objNull ,										 // referenceObject 
	// 		0 , false ,									 // angle, bounces 
	// 		-1 , [ ] ,										 // bounceOnSurface, emissiveColor 
	// 		[[0,1,0],[0,0,1]]
	// 		//[ 0 , 1 , 0 ] 										//vectorDir - НЕ МОЖЕТ быть [0,0,0] 
	// 	] select [0,19], //странное ограничение движка...
	// 	[ 0 , [ 0.1 , 0.1 , 0.1 ] , [ 0 , 0 , 0.5 ] , 0 , 0.1 , [ 0 , 0 , 0 , 0 ] , 0 , 0,
	// 	0,0,0,0 ] select [0,8],//engine block
	// 	[ 3 , [ 0 , 1 , 0 ] ],
	// 	"",//fire not used
	// 	0.0625
	// ]
}


//===========
// read/write anim data by frames in custom structure
//===========

#define _const_vecList_rpData ["size","color","animationSpeed","emissiveColor"]

function(vcom_emit_lowlevel_getRenderParamsFromData)
{
	params ["_data"];
	
	private _ptrDataRender = [];
	private _props = [];
	{
		_props = ([_data,_x,vcom_emit_prop_internal_getParticleAssoc] call vcom_emit_prop_getPropByName); 
		_ptrDataRender pushBack _props;
	} foreach _const_vecList_rpData;
	_ptrDataRender
}

function(vcom_emit_lowlevel_getRenderParamsValueFromData)
{
	params ["_data","_varname"];
	if !(_varname in _const_vecList_rpData) exitwith {
		setLastError(__FUNC__ + " - Unknown RenderParams struct var:"+_varname);
		[]
	};
	private _renderData = [_data] call vcom_emit_lowlevel_getRenderParamsFromData;
	private _indexParam = _const_vecList_rpData find _varname;
	_renderData select _indexParam
}

function(vcom_emit_lowlevel_setRenderParamsToData)
{
	params ["_data","_rpData"];
	if (count _rpData != (count _const_vecList_rpData)) exitwith {
		setLastError(__FUNC__ + " - corrupted data struct for animation frames");
	};
	{
		[_data,_x,_rpData select _foreachIndex,vcom_emit_prop_internal_getParticleAssoc] call vcom_emit_prop_setPropByName;
	} foreach _const_vecList_rpData;
}

function(vcom_emit_lowlevel_isRenderParamName) 
{
	params ["_paramName",["_isParticle",true]];
	(_paramName in _const_vecList_rpData) && _isParticle
}

function(vcom_emit_lowlevel_renderParamsGetMaxIndex)
{
	params ["_rpData"];
	private _struct = (_rpData select [0,3]) apply {count _x};
	([
		_struct,
		1
	] call BIS_fnc_findExtreme) - 1
}

function(vcom_emit_lowlevel_RenderParams_getMaxStepnr)
{
	private _emit = call vcom_emit_relpos_getSelectedEmitter;
	if isNullReference(_emit) exitwith {0};
	[
		[_emit getvariable "data"] call vcom_emit_lowlevel_getRenderParamsFromData
	] call vcom_emit_lowlevel_renderParamsGetMaxIndex
}


//! TEMPORARY FUNCTION - DO NOT USE THIS 
function(vcom_emit_internal_validateRenderParams)
{
	params ["_data"];
	private _rpData = [_data] call vcom_emit_lowlevel_getRenderParamsFromData;
	
	//check count
	if (count _rpData!=(count _const_vecList_rpData)) exitwith {
		setLastError(__FUNC__+" - RenderParams structure count mismatch: "+str count _rpData);
	};

	//check elements count
	private _compareCount = count (_rpData select 0);
	{
		//
		if (count _x != _compareCount) then {
			if ((_const_vecList_rpData select _foreachIndex)=="emissiveColor" && count _x == 0) exitwith {

			};
			_mes = format["%1 - Validate error; Param '%2' mismatch: %3; RenderParams: %4",__FUNC__,_const_vecList_rpData select _foreachIndex,count _x,_rpData];
			setLastError(_mes);
		};
	} foreach _rpData;
}