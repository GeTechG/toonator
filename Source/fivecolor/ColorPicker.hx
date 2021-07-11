package fivecolor;

import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.text.*;

class ColorPicker extends fivecolor.ColorPickerSwf
{

    public function new():Void
    {
        super();

        this.alpha = 0;

        var Preview = new Shape();
        Preview.graphics.beginFill(0x00FF00, 1);
        Preview.graphics.drawRect(0, 0.5, 22, 22);
        this.addChild(Preview);
    }
}