package ;

@:access(swf.exporters.animate)

class PickerButtonSwf extends fivecolor.TriggerButton
{
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("5PWWR61HV1pT7uVGH11N");
		var symbol = library.symbols.get(76);
		symbol.__initObject(library, this);
	}
}