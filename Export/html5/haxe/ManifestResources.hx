package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_tahoma_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		Assets.bundlePaths["draw31"] = rootPath + "lib/draw31.zip";
		data = '{"name":null,"assets":"aoy4:sizei697972y4:typey4:FONTy9:classNamey31:__ASSET__assets_font_tahoma_ttfy2:idy26:assets%2Ffont%2FTahoma.ttfy7:preloadtgoy4:pathy25:assets%2Fswf%2Fdraw31.swfR0i13127R1y6:BINARYR5R9R7tgoR8y142:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_backgroundSkinSwf.hxR0i100R1y8:TEMPLATER5R11goR8y138:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_swatchSkinSwf.hxR0i100R1R12R5R13goR8y140:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_disabledSkinSwf.hxR0i100R1R12R5R14goR8y134:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_upSkinSwf.hxR0i100R1R12R5R15goR8y141:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffl%2Fcore%2FComponentShimSwf.hxR0i100R1R12R5R16goR8y137:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffivecolor%2FToolPanelSwf.hxR0i100R1R12R5R17goR8y128:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPickerButtonSwf.hxR0i100R1R12R5R18goR8y127:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenColorRedSwf.hxR0i100R1R12R5R19goR8y129:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenColorBlackSwf.hxR0i100R1R12R5R20goR8y125:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenSize20Swf.hxR0i100R1R12R5R21goR8y125:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenSize10Swf.hxR0i100R1R12R5R22goR8y124:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenSize6Swf.hxR0i100R1R12R5R23goR8y124:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenSize4Swf.hxR0i100R1R12R5R24goR8y124:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPenSize2Swf.hxR0i100R1R12R5R25goR8y128:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FPencilButtonSwf.hxR0i100R1R12R5R26goR8y127:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FEraseButtonSwf.hxR0i100R1R12R5R27goR8y138:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffivecolor%2FHintButtonSwf.hxR0i100R1R12R5R28goR8y137:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffivecolor%2FFrameListSwf.hxR0i100R1R12R5R29goR8y134:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffivecolor%2FSliderSwf.hxR0i100R1R12R5R30goR8y124:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FSaveFormSwf.hxR0i100R1R12R5R31goR8y124:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FCheckboxSwf.hxR0i100R1R12R5R32goR8y128:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FCancelButtonSwf.hxR0i100R1R12R5R33goR8y126:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FSaveButtonSwf.hxR0i100R1R12R5R34goR8y128:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FSaveCompleteSwf.hxR0i100R1R12R5R35goR8y143:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffl%2Fcontrols%2FColorPickerSwf.hxR0i100R1R12R5R36goR8y146:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_swatchSelectedSkinSwf.hxR0i100R1R12R5R37goR8y137:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_colorWellSwf.hxR0i100R1R12R5R38goR8y136:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_overSkinSwf.hxR0i100R1R12R5R39goR8y141:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_textFieldSkinSwf.hxR0i100R1R12R5R40goR8y138:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2Ffl%2Fcontrols%2FButtonSwf.hxR0i100R1R12R5R41goR8y136:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FColorPicker_downSkinSwf.hxR0i100R1R12R5R42goR8y130:C%3A%5CDevelopment%5CToonator%20Reverse%20Engineering%5CToonatorEditor%5CExport%5Chtml5%2Fhaxe%2F_generated%2FMain_LeproLogoSwf.hxR0i100R1R12R5R43gh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("draw31");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("draw31");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_font_tahoma_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_draw31_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_backgroundskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_swatchskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_disabledskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_upskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fl_core_componentshimswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fivecolor_toolpanelswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pickerbuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pencolorredswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pencolorblackswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pensize20swf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pensize10swf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pensize6swf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pensize4swf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pensize2swf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_pencilbuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_erasebuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fivecolor_hintbuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fivecolor_framelistswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fivecolor_sliderswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_saveformswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_checkboxswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_cancelbuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_savebuttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_savecompleteswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fl_controls_colorpickerswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_swatchselectedskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_colorwellswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_overskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_textfieldskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_fl_controls_buttonswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_colorpicker_downskinswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__c__development_toonator_reverse_engineering_toonatoreditor_export_html5_haxe__generated_main_leprologoswf_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__lib_draw31_zip extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:font("Export/html5/obj/webfont/Tahoma.ttf") @:noCompletion #if display private #end class __ASSET__assets_font_tahoma_ttf extends lime.text.Font {}
@:keep @:file("Assets/swf/draw31.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_draw31_swf extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_font_tahoma_ttf') @:noCompletion #if display private #end class __ASSET__assets_font_tahoma_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/Tahoma"; #else ascender = 2049; descender = -423; height = 2472; numGlyphs = 3412; underlinePosition = -235; underlineThickness = 130; unitsPerEM = 2048; #end name = "Tahoma"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_font_tahoma_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_tahoma_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_tahoma_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_font_tahoma_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_tahoma_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_tahoma_ttf ()); super (); }}

#end

#end
#end

#end
