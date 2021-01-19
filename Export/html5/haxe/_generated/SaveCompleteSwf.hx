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

		var library = swf.exporters.animate.AnimateLibrary.get("Jb3Q6P3BTijIGvBXiqUb");
		var symbol = library.symbols.get(14);
		symbol.__initObject(library, this);
	}
}