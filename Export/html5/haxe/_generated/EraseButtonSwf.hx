package ;

@:access(swf.exporters.animate)

class EraseButtonSwf extends fivecolor.TriggerButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(48);
		symbol.__initObject(library, this);
	}
}