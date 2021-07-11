package fivecolor;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class Slider extends SliderSwf
{       
    private var max : Int = 5;
    private var pos : Int = 0;
    
    public function new()
    {
        super();
        this.sbSlider.addEventListener(MouseEvent.MOUSE_DOWN, this.onSliderDown);
        this.sbSlider.useHandCursor = true;
        this.sbSlider.buttonMode = true;
    }
    
    private function onSliderDown(param1 : MouseEvent) : Void
    {
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onSliderUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onSliderMove);
        this.sbSlider.startDrag(false, new Rectangle(18, 0, 430, 0));
    }
    
    public function setMax(param1 : Int) : Void
    {
        this.max = param1;
        if (this.pos < this.max)
        {
            this.sbSlider.x = 18 + 430 / this.max * this.pos;
        }
        else
        {
            this.sbSlider.x = 448;
        }
    }
    
    private function onSliderMove(param1 : MouseEvent) : Void
    {
        var _loc2_ : Int = as3hx.Compat.parseInt(this.sbSlider.x - 18);
        var _loc3_ : Int = Math.floor((_loc2_ + 430 / this.max / 2) / 430 * this.max);
        if (_loc3_ != this.pos)
        {
            this.pos = _loc3_;
            dispatchEvent(new SlideEvent("sliderMove", this.pos));
        }
    }
    
    public function setPos(param1 : Int) : Void
    {
        this.pos = param1;
        if (this.pos < this.max)
        {
            this.sbSlider.x = 18 + 430 / this.max * this.pos;
        }
        else
        {
            this.sbSlider.x = 448;
        }
    }
    
    private function onSliderUp(param1 : MouseEvent) : Void
    {
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onSliderUp);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onSliderMove);
        this.sbSlider.stopDrag();
        if (this.pos < this.max)
        {
            this.sbSlider.x = 18 + 430 / this.max * this.pos;
        }
        else
        {
            this.sbSlider.x = 448;
        }
    }
    
    public function getPos() : Int
    {
        return this.pos;
    }
}

