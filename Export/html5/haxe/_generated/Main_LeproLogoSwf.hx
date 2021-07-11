package ;

@:access(swf.exporters.animate.AnimateLibrary)

class Main_LeproLogoSwf extends openfl.display.BitmapData
{
	public function new(width:Int = 0, height:Int = 0, transparent:Bool = false, background:Int = 0)
	{
		super(0, 0, true, 0);

		var library = swf.exporters.animate.AnimateLibrary.get("5PWWR61HV1pT7uVGH11N");
		var symbol:swf.exporters.animate.AnimateBitmapSymbol = cast library.symbols.get(1);
		var image = library.getImage(symbol.path);
		__fromImage(image);
	}
}