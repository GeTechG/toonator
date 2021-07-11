package fivecolor;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

class TriggerButton extends MovieClip
{
    
    
    private var hint : String = "";
    
    private var isDown : Bool = false;
    
    private var isOver : Bool = false;
    
    public function new()
    {
        super();
        useHandCursor = true;
        buttonMode = true;
        addEventListener(MouseEvent.MOUSE_OVER, this.overButton);
        addEventListener(MouseEvent.MOUSE_OUT, this.outButton);
        addEventListener(MouseEvent.MOUSE_DOWN, this.clickButton);
        addEventListener(Event.ADDED_TO_STAGE, this.added);
    }

    private function added(e:Event):Void
    {
        stop();
    }
    
    private function outButton(param1 : Event) : Void
    {
        this.isOver = false;
        if (this.isDown)
        {
            return;
        }
        gotoAndStop(1);
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
    
    private function checkHint() : Void
    {
    }
    
    public function setState(param1 : Bool) : Void
    {
        this.isDown = param1;
        if (this.isDown)
        {
            gotoAndStop(3);
        }
        else
        {
            gotoAndStop(1);
        }
    }
    
    private function clickButton(param1 : Event) : Void
    {
        if (!this.isDown)
        {
            this.isDown = true;
            gotoAndStop(3);
        }
    }
    
    public function getState() : Bool
    {
        return this.isDown;
    }
}

