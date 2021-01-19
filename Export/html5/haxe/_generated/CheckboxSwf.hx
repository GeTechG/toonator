package ;

@:access(swf.exporters.animate)

class CheckboxSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Kf5mLG1MtxnFZ8PDClhB");
		var symbol = library.symbols.get(28);
		symbol.__initObject(library, this);
	}
}