package ;

@:access(swf.exporters.animate)

class CheckboxSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(27);
		symbol.__initObject(library, this);
	}
}