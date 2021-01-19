package fivecolor;

@:access(swf.exporters.animate)

class HintButtonSwf extends fivecolor.HintButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Kf5mLG1MtxnFZ8PDClhB");
		var symbol = library.symbols.get(43);
		symbol.__initObject(library, this);
	}
}