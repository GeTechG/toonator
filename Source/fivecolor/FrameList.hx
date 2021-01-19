package fivecolor;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

class FrameList extends FrameListSwf
{
    
    
    private var bd : BitmapData;
    
    private var preFrame : Int = -1;
    
    private var curFrame : Int = -1;
    
    private var bmps : Array<BitmapData>;
    
    private var numbers : Array<Dynamic>;
    
    private var startPos : Int = 0;
    
    private var bitmapFramesThumb : Array<Dynamic>;
    
    private var frames : Bitmap;
    
    private var endPos : Int = 0;
    
    public function new()
    {
        var _loc2_ : Int = 0;
        var _loc3_ : Int = 0;
        this.numbers = [[0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0], [0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1], [1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1], [1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0], [1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1], [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0], [1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0], [0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0], [0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0]];
        super();
        this.bitmapFramesThumb = new Array<Dynamic>();
        this.frames = new Bitmap(new BitmapData(516, 24));
        addChild(this.frames);
        this.bmps = new Array<BitmapData>();
        var _loc1_ : Int = 0;
        while (_loc1_ < 10)
        {
            this.bmps[_loc1_] = new BitmapData(5, 5);
            this.bmps[_loc1_].lock();
            _loc2_ = 0;
            while (_loc2_ < 5)
            {
                _loc3_ = 0;
                while (_loc3_ < 4)
                {
                    this.bmps[_loc1_].setPixel32(_loc3_, _loc2_, !!(this.numbers[_loc1_][_loc3_ + _loc2_ * 4] != 0) ? 0xFFFF0000 : 0xFFFFFF);
                    _loc3_++;
                }
                _loc2_++;
            }
            this.bmps[_loc1_].unlock();
            _loc1_++;
        }
        this.drawFrames();
        addEventListener(MouseEvent.MOUSE_DOWN, this.onFrameChange);
    }
    
    public function addFrame(param1 : Int, param2 : BitmapData) : Void
    {
        if (param1 == this.bitmapFramesThumb.length)
        {
            this.bitmapFramesThumb.push(param2);
        }
        else
        {
            //todooo
            this.bitmapFramesThumb.insert(param1, param2);
            //this.bitmapFramesThumb.splice(param1, 0);
            //this.bitmapFramesThumb[param1] = param2;
        }
        this.preFrame = this.curFrame;
        this.curFrame = param1;
        this.endPos = this.bitmapFramesThumb.length - 1;
        this.startPos = (param1 > 9) ? as3hx.Compat.parseInt(param1 - 9) : 0;
        dispatchEvent(new ChangeFrameEvent("currentFrameChanged", this.preFrame, this.curFrame));
        this.drawFrames();
    }
    
    public function setCurFrame(param1 : Int, param2 : Int = -1) : Void
    {
        this.preFrame = param2 == -(1) ? as3hx.Compat.parseInt(this.curFrame) : param2;
        this.curFrame = param1;
        this.drawFrames();
    }
    
    public function setStartPos(param1 : Int) : Void
    {
        this.startPos = param1;
        this.endPos = param1 + 9;
        if (this.endPos >= this.bitmapFramesThumb.length)
        {
            this.endPos = this.bitmapFramesThumb.length - 1;
        }
        this.drawFrames();
    }
    
    public function drawFrames() : Void
    {
        var _loc2_ : Int = 0;
        var _loc3_ : Int = 0;
        var _loc4_ : Int = 0;
        var _loc5_ : Dynamic = null;
        if (this.endPos >= this.bitmapFramesThumb.length)
        {
            this.endPos = this.bitmapFramesThumb.length - 1;
        }
        this.frames.bitmapData.fillRect(this.frames.bitmapData.rect, 0xFFFFFF);
        var _loc1_ : Int = this.startPos;
        while (_loc1_ <= this.endPos)
        {
            if (!(_loc1_ < 0 || _loc1_ >= this.bitmapFramesThumb.length))
            {
                _loc2_ = as3hx.Compat.parseInt(_loc1_ - this.startPos);
                this.frames.bitmapData.copyPixels(this.bitmapFramesThumb[_loc1_], this.bitmapFramesThumb[_loc1_].rect, new Point(_loc2_ * 48 + 1, 1));
                _loc3_ = _loc1_;
                _loc4_ = 1;

                do
                {
                    _loc5_ = _loc3_ % 10;
                    this.frames.bitmapData.merge(this.bmps[_loc5_], this.bmps[_loc5_].rect, new Point(_loc2_ * 48 + 48 - _loc4_ * 5, 1), 255, 255, 255, 255);
                    _loc3_ = as3hx.Compat.parseInt(_loc3_ / 10);
                    _loc4_++;
                }
                while (_loc3_ > 0);
                
                this.frames.bitmapData.fillRect(new Rectangle((_loc2_ + 1) * 48, 0, 1, 24), 0xFF000000);
                if (_loc1_ == this.curFrame)
                {
                    this.frames.bitmapData.fillRect(new Rectangle((_loc2_ + 1) * 48, 0, 1, 24), 0xFFFF0000);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 0, 1, 24), 0xFFFF0000);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 0, 48, 1), 0xFFFF0000);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 23, 48, 1), 0xFFFF0000);
                }
                if (_loc1_ == this.preFrame)
                {
                    this.frames.bitmapData.fillRect(new Rectangle((_loc2_ + 1) * 48 - 1, 0, 1, 24), 0xFF555555);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 0, 1, 24), 0xFF555555);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 0, 47, 1), 0xFF555555);
                    this.frames.bitmapData.fillRect(new Rectangle(_loc2_ * 48, 23, 47, 1), 0xFF555555);
                }
            }
            _loc1_++;
        }
    }
    
    private function onFrameChange(param1 : MouseEvent) : Void
    {
        var _loc2_ : Int = as3hx.Compat.parseInt(param1.localX / 48);
        _loc2_ = as3hx.Compat.parseInt(_loc2_ + this.startPos);
        if (_loc2_ <= this.endPos)
        {
            this.preFrame = this.curFrame;
            this.curFrame = _loc2_;
            this.drawFrames();
            dispatchEvent(new ChangeFrameEvent("currentFrameChanged", this.preFrame, this.curFrame));
        }
    }
    
    public function delFrame(param1 : Int) : Void
    {
        this.bitmapFramesThumb.splice(param1, 1);
        this.preFrame = -1;
        if (this.curFrame > 0)
        {
            this.curFrame--;
        }
        this.endPos = this.bitmapFramesThumb.length - 1;
        this.startPos = (this.endPos > 9) ? as3hx.Compat.parseInt(this.endPos - 9) : 0;
        this.drawFrames();
    }
    
    public function updateFrame(param1 : Int, param2 : BitmapData) : Void
    {
        this.bitmapFramesThumb[param1] = param2;
        this.drawFrames();
    }
    
    public function setPrevFrame(param1 : Int) : Void
    {
        this.preFrame = param1;
    }
}

