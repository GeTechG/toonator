package fivecolor;

@:access(swf.exporters.animate)

class ToolPanelSwf extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var btnAddFrame(default, null):fivecolor.HintButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var btnDelFrame(default, null):openfl.display.SimpleButton;
	@:keep @:noCompletion @:dox(hide) public var btnPause(default, null):openfl.display.SimpleButton;
	@:keep @:noCompletion @:dox(hide) public var btnPlay(default, null):openfl.display.SimpleButton;
	@:keep @:noCompletion @:dox(hide) public var btnSave(default, null):openfl.display.SimpleButton;
	@:keep @:noCompletion @:dox(hide) public var btnErase(default, null):EraseButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var btnPencil(default, null):PenButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var ps2(default, null):PenSize2Swf;
	@:keep @:noCompletion @:dox(hide) public var ps4(default, null):PenSize4Swf;
	@:keep @:noCompletion @:dox(hide) public var ps6(default, null):PenSize6Swf;
	@:keep @:noCompletion @:dox(hide) public var ps10(default, null):PenSize10Swf;
	@:keep @:noCompletion @:dox(hide) public var ps20(default, null):PenSize20Swf;
	@:keep @:noCompletion @:dox(hide) public var btnPicker(default, null):PickerButtonSwf;
	@:keep @:noCompletion @:dox(hide) public var pc1(default, null):PenColorBlackSwf;
	@:keep @:noCompletion @:dox(hide) public var pc2(default, null):PenColorRedSwf;
	

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("U62f7xxBxj0LgeHMrCHk");
		var symbol = library.symbols.get(85);
		symbol.__initObject(library, this);
	}
}