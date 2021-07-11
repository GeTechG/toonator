package fivecolor;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class HintButton extends MovieClip
{
    private var hint : String = "";
    
    private var isDown : Bool = false;
    
    private var hintSprite : Sprite;
    
    private var isOver : Bool = false;
    
    public function new()
    {
        super();
        useHandCursor = true;
        buttonMode = true;
        addEventListener(MouseEvent.MOUSE_OVER, this.overButton);
        addEventListener(MouseEvent.MOUSE_OUT, this.outButton);
        addEventListener(MouseEvent.MOUSE_DOWN, this.downButton);
        addEventListener(MouseEvent.MOUSE_UP, this.upButton);
        addEventListener(Event.ADDED_TO_STAGE, this.added);
    }

    private function added(e:Event):Void
    {
        stop();
    }
    
    private function outButton(param1 : Event) : Void
    {
        if (this.hintSprite != null)
        {
            this.hintSprite.parent.removeChild(this.hintSprite);
            this.hintSprite = null;
        }
        this.isOver = false;
        if (this.isDown)
        {
            return;
        }
        gotoAndStop(1);
    }
    
    private function showHint() : Void
    {
        var _loc1_ : TextField = null;
        var _loc2_ : Point = null;
        if (this.hintSprite == null)
        {
            this.hintSprite = new Sprite();
            stage.addChild(this.hintSprite);
            _loc1_ = new TextField();
            _loc1_.defaultTextFormat = new TextFormat("Tahoma", 12, 0);
            _loc1_.autoSize = TextFieldAutoSize.LEFT;
            _loc1_.text = this.hint;
            this.hintSprite.addChild(_loc1_);
            _loc2_ = localToGlobal(new Point(0, 0));
            this.hintSprite.x = _loc2_.x + width / 2 - this.hintSprite.width / 2;
            if (this.hintSprite.x < 5)
            {
                this.hintSprite.x = 5;
            }
            this.hintSprite.y = _loc2_.y + height + 5;
            this.hintSprite.graphics.clear();
            this.hintSprite.graphics.lineStyle(1, 8947814);
            this.hintSprite.graphics.beginFill(16777164);
            this.hintSprite.graphics.drawRect(0, 0, this.hintSprite.width, this.hintSprite.height);
            this.hintSprite.graphics.endFill();
        }
    }
    
    private function overButton(param1 : Event) : Void
    {
        this.isOver = true;
        if (this.hint != "")
        {
            as3hx.Compat.setTimeout(this.checkHint, 500);
        }
        if (this.isDown)
        {
            return;
        }
        gotoAndStop(2);
    }
    
    public function setHint(param1 : String) : Void
    {
        this.hint = param1;
    }
    
    private function upButton(param1 : Event) : Void
    {
        if (this.isDown)
        {
            this.isDown = false;
            gotoAndStop(2);
        }
    }
    
    private function checkHint() : Void
    {
        if (this.isOver)
        {
            this.showHint();
        }
    }
    
    private function downButton(param1 : Event) : Void
    {
        if (!this.isDown)
        {
            this.isDown = true;
            gotoAndStop(3);
        }
    }
}

