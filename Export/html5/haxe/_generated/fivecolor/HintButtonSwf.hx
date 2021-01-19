package fivecolor;

@:access(swf.exporters.animate)

class HintButtonSwf extends fivecolor.HintButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Jb3Q6P3BTijIGvBXiqUb");
		var symbol = library.symbols.get(43);
		symbol.__initObject(library, this);
	}
}