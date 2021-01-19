package fivecolor;

@:access(swf.exporters.animate)

class FrameListSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Jb3Q6P3BTijIGvBXiqUb");
		var symbol = library.symbols.get(40);
		symbol.__initObject(library, this);
	}
}