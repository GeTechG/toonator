package ;

@:access(swf.exporters.animate)

class EraseButtonSwf extends fivecolor.TriggerButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Kf5mLG1MtxnFZ8PDClhB");
		var symbol = library.symbols.get(59);
		symbol.__initObject(library, this);
	}
}