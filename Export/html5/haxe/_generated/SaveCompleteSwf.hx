package ;

@:access(swf.exporters.animate)

class SaveCompleteSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var lblLink(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var lbl_saved(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var btnOK(default, null):openfl.display.SimpleButton;
	@:keep @:noCompletion @:dox(hide) public var lbl_page(default, null):openfl.text.TextField;
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(13);
		symbol.__initObject(library, this);
	}
}