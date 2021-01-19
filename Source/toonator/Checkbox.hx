package toonator;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class Checkbox extends Sprite
{
    public var isChecked(get, set) : Bool;

    
    
    private var tf : TextField;
    
    private var _isChecked : Bool = false;
    
    public function new(lang:String)
    {
        super();
        this.repaint();
        this.tf = new TextField();
        this.tf.defaultTextFormat = new TextFormat("Tahoma", 12, 16777215);
        this.tf.autoSize = TextFieldAutoSize.LEFT;
        this.tf.text = (lang == "en" ? "Draft" : "Черновик");
        this.tf.x = 20;
        addChild(this.tf);
        this.tf.mouseEnabled = false;
        buttonMode = true;
        addEventListener(MouseEvent.CLICK, this.onMouseClick);
    }
    
    private function onMouseClick(param1 : Event) : Void
    {
        this._isChecked = !this._isChecked;
        this.repaint();
    }
    
    private function set_isChecked(param1 : Bool) : Bool
    {
        this._isChecked = param1;
        this.repaint();
        return param1;
    }
    
    private function repaint() : Void
    {
        var _loc1_ : Graphics = graphics;
        _loc1_.clear();
        _loc1_.beginFill(16777215);
        _loc1_.drawRoundRect(0, 0, 16, 16, 6, 6);
        _loc1_.endFill();
        if (this._isChecked)
        {
            _loc1_.beginFill(0);
            _loc1_.moveTo(1, 6);
            _loc1_.lineTo(7, 12);
            _loc1_.lineTo(17, 4);
            _loc1_.lineTo(13, 4);
            _loc1_.lineTo(7, 10);
            _loc1_.lineTo(3, 6);
            _loc1_.endFill();
        }
    }
    
    private function get_isChecked() : Bool
    {
        return this._isChecked;
    }
}

