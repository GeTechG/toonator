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
		data = '{"name":null,"assets":"aoy4:sizei697972y4:typey4:FONTy9:classNamey31:__ASSET__assets_font_tahoma_ttfy2:idy26:assets%2Ffont%2FTahoma.ttfy7:preloadtgoy4:pathy25:assets%2Fswf%2Fdraw31.swfR0i276076R1y6:BINARYR5R9R7tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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
