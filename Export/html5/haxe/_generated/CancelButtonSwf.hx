package ;

@:access(swf.exporters.animate)

class CancelButtonSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var lbl_cancel(default, null):openfl.text.TextField;
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(26);
		symbol.__initObject(library, this);
	}
}