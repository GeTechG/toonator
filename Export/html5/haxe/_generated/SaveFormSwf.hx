package ;

@:access(swf.exporters.animate)

class SaveFormSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var lbl_name(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var lbl_keywords(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var lbl_description(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var lblStatus(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var edtName(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var edtKeys(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var edtDescription(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var btnSave(default, null):SaveButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var btnCancel(default, null):CancelButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var chkDraft(default, null):CheckboxSwf;
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("5PWWR61HV1pT7uVGH11N");
		var symbol = library.symbols.get(28);
		symbol.__initObject(library, this);
	}
}