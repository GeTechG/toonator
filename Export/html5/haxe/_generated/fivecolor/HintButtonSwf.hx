package fivecolor;

@:access(swf.exporters.animate)

class HintButtonSwf extends fivecolor.HintButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(32);
		symbol.__initObject(library, this);
	}
}