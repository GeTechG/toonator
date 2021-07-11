package fivecolor;

@:access(swf.exporters.animate)

class HintButtonSwf extends fivecolor.HintButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("5PWWR61HV1pT7uVGH11N");
		var symbol = library.symbols.get(32);
		symbol.__initObject(library, this);
	}
}