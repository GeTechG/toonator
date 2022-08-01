package ;

@:access(swf.exporters.animate)

class PenColorBlackSwf extends fivecolor.TriggerButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(80);
		symbol.__initObject(library, this);
	}
}