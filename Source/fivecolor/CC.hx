package fivecolor;

import js.Browser.document;
import js.html.*;

import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.text.*;

class CC extends fivecolor.CCSwf
{
    public var HTMLPicker:InputElement;
    public var colorData:BitmapData;

    public function new():Void
    {
        super(); 

        this.colorPicker.visible = false;

        this.colorData = new BitmapData(Std.int(this.colorPicker.colorSelector.width), Std.int(this.colorPicker.colorSelector.height));
        this.colorData.draw(this.colorPicker.colorSelector);

        //костыль непонятный, но без него кнопки почему-то не тыкаются(
        this.colorPicker.addChild(this.colorPicker.colorChooser);
        this.colorPicker.addChild(this.colorPicker.colorSelector);
        this.colorPicker.addChild(this.colorPicker.preview);
        this.colorPicker.addChild(this.colorPicker.txtColor);
        this.colorPicker.addChild(this.colorPicker.outline);

        this.colorPick.addEventListener(MouseEvent.CLICK, OpenPicker);
        
        this.colorPicker.colorChooser.addEventListener(MouseEvent.MOUSE_DOWN,  ColorChooser);
        this.colorPicker.colorSelector.addEventListener(MouseEvent.MOUSE_MOVE, CheckColor);  
        this.colorPicker.colorSelector.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);   

        #if html5
        PrepareHTMLPicker();
        #end
    }

    private function PrepareHTMLPicker():Void
    {
        //trace('sdfsdf');
        HTMLPicker = cast(document.createElement('input'), InputElement);
        HTMLPicker.type     = 'color';
        HTMLPicker.id       = 'pick';
        HTMLPicker.setAttribute('disabled', 'true');
        HTMLPicker.setAttribute('style', 'opacity: 0; position: relative; bottom: 0; right: 0;');

        if(document.getElementById('draw_container') != null)
            document.getElementById('draw_container').appendChild(HTMLPicker);
        else
            document.body.appendChild(HTMLPicker);

        HTMLPicker.addEventListener('input', HTMLColorUpdate);
        HTMLPicker.addEventListener('change', HTMLColorChange);
    }
    private function ColorChooser(e:MouseEvent):Void
    {
        HTMLPicker.removeAttribute('disabled');
        HTMLPicker.click();
    }
    private function HTMLColorUpdate(e):Void
    {
        SetPreColor(Std.parseInt(StringTools.replace(e.target.value, '#', '0x')));
    }
    private function HTMLColorChange(e):Void
    {
        HTMLPicker.setAttribute('disabled', 'true');
        var color:Int = Std.parseInt(StringTools.replace(e.target.value, '#', '0x'));
        this.colorPicker.visible = false;
        dispatchEvent(new ChangeColorEvent("changeColor", color));
    }

    private function OpenPicker(e:MouseEvent):Void
    {
        this.colorPicker.visible = !this.colorPicker.visible;
    }

    public function SetColor(color:Int):Void
    {
        var c:ColorTransform = new ColorTransform();
        c.color     = color;
        this.colorPick.transform.colorTransform = c;

        #if html5
        HTMLPicker.value = '#' + StringTools.hex(color, 6);
        #end

        this.colorPicker.txtColor.text = StringTools.hex(color, 6);
    }
    public function SetPreColor(color:Int):Void
    {
        var c:ColorTransform = new ColorTransform();
        c.color     = color;
        this.colorPicker.preview.transform.colorTransform = c;

        #if html5
        HTMLPicker.value = '#' + StringTools.hex(color, 6);
        #end

        this.colorPicker.txtColor.text = StringTools.hex(color, 6);
    }

    private function GetColorUnderCursor(e:MouseEvent):Int
    {
        return this.colorData.getPixel(Std.int(e.localX), Std.int(e.localY));
    }

    private function CheckColor(e:MouseEvent):Void
    {        
        var color:Int = GetColorUnderCursor(e);
        SetPreColor(color);
    }

    private function MouseDown(e:MouseEvent):Void
    {
        var color:Int = GetColorUnderCursor(e);

        this.colorPicker.visible = false;

        dispatchEvent(new ChangeColorEvent("changeColor", color));
    }
}