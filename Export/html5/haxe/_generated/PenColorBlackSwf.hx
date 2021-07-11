package ;

@:access(swf.exporters.animate)

class PenColorBlackSwf extends fivecolor.TriggerButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("5PWWR61HV1pT7uVGH11N");
		var symbol = library.symbols.get(80);
		symbol.__initObject(library, this);
	}
}