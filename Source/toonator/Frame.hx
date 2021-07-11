package toonator;

import com.cartogrammar.drawing.CubicBezier;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;

class Frame
{
    
    
    public var splines : Array<Dynamic>;
    
    public var havePreview : Bool = true;
    
    public var sprite : Sprite;
    
    public var isNew : Bool = false;
    
    public var newSplines : Int = 0;
    
    public var newPoints : Int = 0;
    
    public var drawTime : Int;
    
    public function new()
    {
        this.splines = [];
        this.sprite = new Sprite();
        this.sprite.blendMode = BlendMode.LAYER;
        //this.sprite.cacheAsBitmap = true;
    }
    
    public function addSpline(param1 : Array<Dynamic>, param2 : Int, param3 : String, param4 : Int, param5 : Bool = false, param6 : Int = 0) : Shape
    {
        if (!param5)
        {
            this.splines.push({
                        spline : param1.copy(),
                        color : param2,
                        action : ((param4 > 0) ? 5 : 4),
                        size : param4,
                        drawTime : param6
                    });
            if (param6 > 0)
            {
                this.newSplines++;
                this.newPoints = this.newPoints + param1.length;
                this.drawTime = this.drawTime + param6;
            }
        }
        var _loc7_ : Array<Dynamic> = new Array<Dynamic>();
        var _loc8_ : Int = 0;
        while (_loc8_ < param1.length)
        {
            _loc7_.push(new Point(param1[_loc8_].x, param1[_loc8_].y));
            _loc8_++;
        }
        var _loc9_ : Shape = new Shape();
        _loc9_.blendMode = (param3 == "eraser") ? BlendMode.ERASE : BlendMode.NORMAL;
        var _loc10_ : Graphics = _loc9_.graphics;
        if (param4 == 0)
        {
            _loc10_.lineStyle(0, 0, 0);
            _loc10_.beginFill(param2);
            DrawField.multicurve(_loc10_, param1, true);
            _loc10_.endFill();
        }
        else if (_loc7_.length == 1 || _loc7_.length == 2 && _loc7_[0].x == _loc7_[1].x && _loc7_[0].y == _loc7_[1].y)
        {
            _loc10_.lineStyle(0, 0, 0);
            _loc10_.beginFill(param2);
            _loc10_.drawCircle(_loc7_[0].x, _loc7_[0].y, param4 / 2);
            _loc10_.endFill();
        }
        else
        {
            _loc10_.lineStyle(param4, param2);
            _loc10_.moveTo(_loc7_[0].x, _loc7_[0].y);
            DrawField.multicurve(_loc10_, param1, false);
        }
        this.sprite.addChild(_loc9_);
        return _loc9_;
    }
    
    public function redrawFrame() : Void
    {
        var _loc2_ : Dynamic = null;
        while (this.sprite.numChildren > 0)
        {
            this.sprite.removeChildAt(0);
        }
        var _loc1_ : Int = 0;
        while (_loc1_ < this.splines.length)
        {
            _loc2_ = this.splines[_loc1_];
            this.addSpline(_loc2_.spline, _loc2_.color, (_loc2_.color == 16777215) ? "eraser" : "pencil", _loc2_.size, true);
            _loc1_++;
        }
    }
    
    public function undo() : Void
    {
        var _loc1_ : Dynamic = null;
        if (this.splines.length > 0)
        {
            _loc1_ = this.splines.pop();
            this.sprite.removeChildAt(this.sprite.numChildren - 1);
            if (this.newSplines > 0)
            {
                this.newPoints -= cast(_loc1_.spline, Array<Dynamic>).length;
                this.newSplines--;
                this.drawTime -= cast(_loc1_.drawTime, Int);
            }
            if (this.splines.length == 0)
            {
                this.isNew = true;
                this.newPoints = 0;
                this.newSplines = 0;
                this.drawTime = 0;
            }
        }
        this.redrawFrame();
    }
    
    public function copy() : Frame
    {
        var _loc1_ : Frame = new Frame();
        var _loc2_ : Int = 0;
        while (_loc2_ < this.splines.length)
        {
            _loc1_.splines.push(this.splines[_loc2_]);
            _loc2_++;
        }
        _loc1_.redrawFrame();
        return _loc1_;
    }
    
    public function paste(param1 : Frame) : Void
    {
        this.newSplines = 0;
        this.newPoints = 0;
        this.drawTime = 0;
        this.isNew = false;
        this.splines = [];
        var _loc2_ : Int = 0;
        while (_loc2_ < param1.splines.length)
        {
            this.splines.push(param1.splines[_loc2_]);
            _loc2_++;
        }
        this.redrawFrame();
    }
    
    public function x_drawBitmap(param1 : BitmapData, param2 : Bool = false) : Void
    {
        var _loc5_ : Array<Dynamic> = null;
        var _loc6_ : Int = 0;
        var _loc3_ : Sprite = new Sprite();
        param1.fillRect(param1.rect, 16777215);
        var _loc4_ : Int = 0;
        while (_loc4_ < this.splines.length)
        {
            _loc5_ = new Array<Dynamic>();
            _loc6_ = 0;
            while (_loc6_ < this.splines[_loc4_].spline.length)
            {
                _loc5_.push(new Point(this.splines[_loc4_].spline[_loc6_].x, this.splines[_loc4_].spline[_loc6_].y));
                _loc6_++;
            }
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(this.splines[_loc4_].color);
            CubicBezier.curveThroughPoints(_loc3_.graphics, _loc5_, 0.5, 0.75, true);
            _loc3_.graphics.endFill();
            if (this.splines[_loc4_].color != 16777215)
            {
                param1.draw(_loc3_);
            }
            else
            {
                param1.draw(_loc3_, null, null, "erase");
            }
            _loc4_++;
        }
    }
    
    public function drawBitmapPreview(param1 : BitmapData, param2 : Bool = false) : Void
    {
        param1.fillRect(param1.rect, 16777215);
        var _loc3_ : Matrix = new Matrix();
        _loc3_.scale(0.08, 0.08);
        param1.draw(this.sprite, _loc3_);
    }
    
    public function drawGraphics(param1 : Graphics) : Void
    {
        var _loc3_ : Array<Dynamic> = null;
        var _loc4_ : Int = 0;
        param1.clear();
        var _loc2_ : Int = 0;
        while (_loc2_ < this.splines.length)
        {
            _loc3_ = new Array<Dynamic>();
            _loc4_ = 0;
            while (_loc4_ < this.splines[_loc2_].spline.length)
            {
                _loc3_.push(new Point(this.splines[_loc2_].spline[_loc4_].x, this.splines[_loc2_].spline[_loc4_].y));
                _loc4_++;
            }
            param1.beginFill(this.splines[_loc2_].color);
            CubicBezier.curveThroughPoints(param1, _loc3_, 0.5, 0.75, true);
            param1.endFill();
            _loc2_++;
        }
    }
}

