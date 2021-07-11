package fivecolor;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;

class ToolPanel extends ToolPanelSwf
{
    public var enablePalette(get, set) : Bool;

    private var _enablePalette : Bool = false;
    
    public var penSize : Int = 4;
    public var penColor : Int = 0;

    public var cc:CC;
    
    public function new()
    {
        super();
        this.btnPause.visible = false;
        this.btnPencil.setState(true);
        this.ps4.setState(true);
        this.btnAddFrame.setHint("Add frame after (with ctrl for add before)");
        this.btnAddFrame.addEventListener(MouseEvent.MOUSE_DOWN, this.addFrame);
        this.btnDelFrame.addEventListener(MouseEvent.MOUSE_DOWN, this.delFrame);
        this.btnPlay.addEventListener(MouseEvent.MOUSE_DOWN, this.playMovie);
        this.btnPause.addEventListener(MouseEvent.MOUSE_DOWN, this.pauseMovie);
        this.btnSave.addEventListener(MouseEvent.MOUSE_DOWN, this.saveMovie);
        this.btnPencil.addEventListener(MouseEvent.MOUSE_DOWN, this.setPencil);
        this.btnErase.addEventListener(MouseEvent.MOUSE_DOWN, this.setErase);
        this.btnPicker.addEventListener(MouseEvent.MOUSE_DOWN, this.setPicker);
        this.ps2.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenSize);
        this.ps4.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenSize);
        this.ps6.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenSize);
        this.ps10.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenSize);
        this.ps20.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenSize);
        this.pc1.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
        this.pc2.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
        this.pc1.visible = true;
        this.pc2.visible = true;

        this.cc = new CC();
        this.cc.x = 211;
        this.cc.y = -187;
        setPickerColor(0);

        //this.cc.addEventListener("changeColor", this.setPenColorPicker);
        this.cc.visible = false;
        this.btnPicker.visible = false;
        this._enablePalette = false;
    }
    
    public function setPenColorPicker(param1 : ChangeColorEvent) : Void
    {
        //trace(param1.selectedColor);
        this.penColor = param1.selectedColor;
        setPickerColor(param1.selectedColor);
        dispatchEvent(new Event("setPenColor"));
    }

    public function setPencil(param1 : Event) : Void
    {
        dispatchEvent(new Event("setPencil"));
        this.btnPencil.setState(true);
        this.btnErase.setState(false);
        this.btnPicker.setState(false);
    }
    
    public function setPicker(param1 : Event) : Void
    {
        dispatchEvent(new Event("setPicker"));
        this.btnPicker.setState(true);
        this.btnErase.setState(false);
        this.btnPencil.setState(false);
    }
    
    public function setPickerColor(param1 : Int) : Void
    {
        this.cc.SetColor(param1);
    }

    public function currentFrameChanged(param1 : ChangeFrameEvent) : Void
    {
        dispatchEvent(new ChangeFrameEvent("currentFrameChanged", param1.preFrame, param1.curFrame, param1.force));
    }
    
    private function delFrame(param1 : Event) : Void
    {
        dispatchEvent(new Event("delFrame"));
    }
    
    private function saveMovie(param1 : Event) : Void
    {
        dispatchEvent(new Event("saveMovie"));
    }
        
    private function addFrame(param1 : MouseEvent) : Void
    {
        if (param1.ctrlKey)
        {
            dispatchEvent(new Event("addFramePrev"));
        }
        else
        {
            dispatchEvent(new Event("addFrame"));
        }
    }
    
    public function setPenColor(param1 : Event) : Void
    {
        var _loc2_ : Array<Dynamic> = [this.pc1, this.pc2];
        var _loc3_ : Array<Dynamic> = [0, 16711680];
        var _loc4_ : Int = 0;
        while (_loc4_ < _loc2_.length)
        {
            if (param1.target == _loc2_[_loc4_])
            {
                this.penColor = _loc3_[_loc4_];
            }
            else
            {
                _loc2_[_loc4_].setState(false);
            }
            _loc4_++;
        }
        setPickerColor(this.penColor);
        dispatchEvent(new Event("setPenColor"));
    }
    
    private function pauseMovie(param1 : Event) : Void
    {
        dispatchEvent(new Event("pauseMovie"));
    }
    
    private function playMovie(param1 : Event) : Void
    {
        dispatchEvent(new Event("playMovie"));
    }
    
    public function setErase(param1 : Event) : Void
    {
        dispatchEvent(new Event("setEraser"));
        this.btnErase.setState(true);
        this.btnPencil.setState(false);
        this.btnPicker.setState(false);
    }
    
    public function setPenActualSize(param1 : Int) : Void
    {
        var _loc2_ : Array<Dynamic> = [this.ps2, this.ps4, this.ps6, this.ps10, this.ps20];
        var _loc3_ : Array<Dynamic> = [2, 4, 6, 10, 20];
        var _loc4_ : Int = 0;
        while (_loc4_ < _loc2_.length)
        {
            if (param1 == _loc3_[_loc4_])
            {
                _loc2_[_loc4_].setState(true);
            }
            else
            {
                _loc2_[_loc4_].setState(false);
            }
            _loc4_++;
        }
    }
    
    public function setPlaying(param1 : Bool) : Void
    {
        this.btnPause.visible = param1;
        this.btnPlay.visible = !param1;
    }
    
    private function set_enablePalette(param1 : Bool) : Bool
    {
        if (this._enablePalette == param1)
        {
            return param1;
        }
        this._enablePalette = param1;

        if (param1)
        {
            this.pc1.removeEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
            this.pc2.removeEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
            this.cc.addEventListener("changeColor", this.setPenColorPicker);
            this.pc1.visible = false;
            this.pc2.visible = false;
            this.cc.visible = true;
            this.btnPicker.visible = true;
        }
        else
        {
            this.pc1.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
            this.pc2.addEventListener(MouseEvent.MOUSE_DOWN, this.setPenColor);
            this.cc.removeEventListener("changeColor", this.setPenColorPicker);
            this.pc1.visible = true;
            this.pc2.visible = true;
            this.cc.visible = false;
            this.btnPicker.visible = false;
        }
        return param1;
    }
    
    private function get_enablePalette() : Bool
    {
        return this._enablePalette;
    }
    
    public function setPenSize(param1 : Event) : Void
    {
        var _loc2_ : Array<Dynamic> = [this.ps2, this.ps4, this.ps6, this.ps10, this.ps20];
        var _loc3_ : Array<Dynamic> = [2, 4, 6, 10, 20];
        var _loc4_ : Int = 0;
        while (_loc4_ < _loc2_.length)
        {
            if (param1.target == _loc2_[_loc4_])
            {
                this.penSize = _loc3_[_loc4_];
            }
            else
            {
                _loc2_[_loc4_].setState(false);
            }
            _loc4_++;
        }
        dispatchEvent(new Event("setPenSize"));
    }
}

