package toonator;

import openfl.Vector;
import com.motiondraw.LineGeneralization;
import flash.display.*;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Mouse;

class DrawField extends Sprite
{
    
    public static inline var TOOL_PEN : String = "pen";
    
    public static inline var TOOL_ERASER : String = "eraser";
    
    public static inline var TOOL_PICKER : String = "picker";
    
    
    private var currentSprite : Sprite;
    
    private var containerSprite : Sprite;
    
    private var backContainerSprite : Sprite;
    
    private var backSprite : Sprite;
    
    private var backContainerSprite2 : Sprite;
    
    private var backSprite2 : Sprite;
    
    private var backBitmap : Bitmap;
    
    private var backBitmap2 : Bitmap;
    
    public var currentBitmap : Bitmap;
    
    private var drawSprite : Sprite;
    
    private var frame : Frame;
    
    private var cursorSprite : Sprite;
    
    private var activeTool : String;
    
    private var penSize : Int;
    
    private var penColor : Int;
    
    private var activeFrame : Frame;
    
    private var lastX : Float = 0;
    
    private var lastY : Float = 0;
    
    private var moves : Int;
    
    private var canvasWidth : Int = 600;
    
    private var canvasHeight : Int = 300;
    
    private var canvasScale : Float = 1;
    
    private var canvasMatrix : Matrix;
    
    private var mouseDown : Bool = false;
    
    private var lastPoints : Dynamic;
    
    private var lastAngle : Float = 0;
    
    private var readOnly : Bool = false;
    
    private var points : Array<Dynamic>;
    
    private var drawShape : Shape;
    
    private var beginTime : Int;
    
    private var oldschoolMode : Bool = false;
    
    public function new()
    {
        this.points = [];
        super();
        if (stage != null)
        {
            this.init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, this.init);
        }
    }
    
    public static function multicurve(param1 : Graphics, param2 : Array<Dynamic>, param3 : Bool) : Void
    {
        var _loc7_ : Int = 0;
        var _loc4_ : Vector<Int> = new Vector<Int>();
        var _loc5_ : Vector<Float> = new Vector<Float>();
        var _loc6_ : Array<Dynamic> = param2.copy();
        var _loc8_ : Dynamic = {
            x : 0,
            y : 0
        };
        var _loc9_ : Dynamic = {
            x : 0,
            y : 0
        };
        var _loc10_ : Int = _loc6_.length;
        if (_loc10_ == 2)
        {
            _loc4_.push(1);
            _loc5_.push(_loc6_[0].x);
            _loc5_.push(_loc6_[0].y);
            
            _loc4_.push(2);
            _loc5_.push(_loc6_[1].x);
            _loc5_.push(_loc6_[1].y);
            
            param1.drawPath(_loc4_, _loc5_, "nonZero");
            return;
        }
        var _loc11_ : Array<Dynamic> = new Array<Dynamic>();
        var _loc12_ : Array<Dynamic> = new Array<Dynamic>();
        _loc7_ = 1;
        while (_loc7_ < _loc10_ - 2)
        {
            _loc8_ = _loc6_[_loc7_];
            _loc9_ = _loc6_[_loc7_ + 1];
            _loc11_[_loc7_] = 0.5 * (_loc9_.x + _loc8_.x);
            _loc12_[_loc7_] = 0.5 * (_loc9_.y + _loc8_.y);
            _loc7_++;
        }
        if (param3)
        {
            _loc11_[0] = 0.5 * (_loc6_[1].x + _loc6_[0].x);
            _loc12_[0] = 0.5 * (_loc6_[1].y + _loc6_[0].y);
            _loc11_[_loc7_] = 0.5 * (_loc6_[_loc7_ + 1].x + _loc6_[_loc7_].x);
            _loc12_[_loc7_] = 0.5 * (_loc6_[_loc7_ + 1].y + _loc6_[_loc7_].y);
            _loc11_[_loc7_ + 1] = 0.5 * (_loc6_[_loc7_ + 1].x + _loc6_[0].x);
            _loc12_[_loc7_ + 1] = 0.5 * (_loc6_[_loc7_ + 1].y + _loc6_[0].y);
            _loc6_.push([_loc6_[0].x, _loc6_[0].y]);
            _loc11_[_loc7_ + 2] = _loc11_[0];
            _loc12_[_loc7_ + 2] = _loc12_[0];
        }
        else
        {
            _loc11_[0] = _loc6_[0].x;
            _loc12_[0] = _loc6_[0].y;
            _loc11_[_loc7_] = _loc6_[_loc7_ + 1].x;
            _loc12_[_loc7_] = _loc6_[_loc7_ + 1].y;
            _loc6_.pop();
            _loc10_--;
        }
        _loc4_.push(1);
        _loc5_.push(_loc11_[0]);
        _loc5_.push(_loc12_[0]);
        
        _loc7_ = 1;
        while (_loc7_ < _loc10_)
        {
            _loc8_ = _loc6_[_loc7_];
            _loc4_.push(3);
            _loc5_.push(_loc8_.x);
            _loc5_.push(_loc8_.y);
            _loc5_.push(_loc11_[_loc7_]);
            _loc5_.push(_loc12_[_loc7_]);
            
            _loc7_++;
        }
        if (param3)
        {
            _loc4_.push(3);
            _loc5_.push(_loc6_[0].x);
            _loc5_.push(_loc6_[0].y);
            _loc5_.push(_loc11_[_loc7_]);
            _loc5_.push(_loc12_[_loc7_]);
            
        }
        param1.drawPath(_loc4_, _loc5_, "nonZero");
    }
    
    public static function multicurveX(param1 : Graphics, param2 : Array<Dynamic>, param3 : Bool) : Void
    {
        var _loc7_ : Int = 0;
        var _loc4_ : Vector<Int> = new Vector<Int>();
        var _loc5_ : Vector<Float> = new Vector<Float>();
        var _loc6_ : Array<Dynamic> = param2.copy();
        var _loc8_ : Array<Dynamic> = [0, 0];
        var _loc9_ : Array<Dynamic> = [0, 0];
        var _loc10_ : Int = _loc6_.length;
        if (_loc10_ == 2)
        {
            _loc4_.push(1);
            _loc5_.push(_loc6_[0][0]);
            _loc5_.push(_loc6_[0][1]);
            
            _loc4_.push(2);
            _loc5_.push(_loc6_[1][0]);
            _loc5_.push(_loc6_[1][1]);
            
            param1.drawPath(_loc4_, _loc5_, "nonZero");
            return;
        }
        var _loc11_ : Array<Dynamic> = new Array<Dynamic>();
        var _loc12_ : Array<Dynamic> = new Array<Dynamic>();
        _loc7_ = 1;
        while (_loc7_ < _loc10_ - 2)
        {
            _loc8_ = _loc6_[_loc7_];
            _loc9_ = _loc6_[_loc7_ + 1];
            _loc11_[_loc7_] = 0.5 * (_loc9_[0] + _loc8_[0]);
            _loc12_[_loc7_] = 0.5 * (_loc9_[1] + _loc8_[1]);
            _loc7_++;
        }
        if (param3)
        {
            _loc11_[0] = 0.5 * (_loc6_[1][0] + _loc6_[0][0]);
            _loc12_[0] = 0.5 * (_loc6_[1][1] + _loc6_[0][1]);
            _loc11_[_loc7_] = 0.5 * (_loc6_[_loc7_ + 1][0] + _loc6_[_loc7_][0]);
            _loc12_[_loc7_] = 0.5 * (_loc6_[_loc7_ + 1][1] + _loc6_[_loc7_][1]);
            _loc11_[_loc7_ + 1] = 0.5 * (_loc6_[_loc7_ + 1][0] + _loc6_[0][0]);
            _loc12_[_loc7_ + 1] = 0.5 * (_loc6_[_loc7_ + 1][1] + _loc6_[0][1]);
            _loc6_.push([_loc6_[0][0], _loc6_[0][1]]);
            _loc11_[_loc7_ + 2] = _loc11_[0];
            _loc12_[_loc7_ + 2] = _loc12_[0];
        }
        else
        {
            _loc11_[0] = _loc6_[0][0];
            _loc12_[0] = _loc6_[0][1];
            _loc11_[_loc7_] = _loc6_[_loc7_ + 1][0];
            _loc12_[_loc7_] = _loc6_[_loc7_ + 1][1];
            _loc6_.pop();
            _loc10_--;
        }
        _loc4_.push(1);
        _loc5_.push(_loc11_[0]);
        _loc5_.push(_loc12_[0]);
        
        _loc7_ = 1;
        while (_loc7_ < _loc10_)
        {
            _loc8_ = _loc6_[_loc7_];
            _loc4_.push(3);
            _loc5_.push(_loc8_[0]);
            _loc5_.push(_loc8_[1]);
            _loc5_.push(_loc11_[_loc7_]);
            _loc5_.push(_loc12_[_loc7_]);
            
            _loc7_++;
        }
        if (param3)
        {
            _loc4_.push(3);
            _loc5_.push(_loc6_[0][0]);
            _loc5_.push(_loc6_[0][1]);
            _loc5_.push(_loc11_[_loc7_]);
            _loc5_.push(_loc12_[_loc7_]);
            
        }
        param1.drawPath(_loc4_, _loc5_, "nonZero");
    }
    
    private function init(param1 : Event = null) : Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, this.init);
        this.activeTool = TOOL_PEN;
        this.penSize = 4;
        this.penColor = 0;
        this.backContainerSprite2 = new Sprite();
        addChild(this.backContainerSprite2);
        this.backContainerSprite2.alpha = 0.1;
        this.backContainerSprite = new Sprite();
        addChild(this.backContainerSprite);
        this.backContainerSprite.alpha = 0.3;
        this.containerSprite = new Sprite();
        this.containerSprite.alpha = 0.8;
        addChild(this.containerSprite);
        this.createBitmaps();
        this.backContainerSprite2.addChild(this.backBitmap2);
        this.backContainerSprite.addChild(this.backBitmap);
        this.containerSprite.addChild(this.currentBitmap);
        this.containerSprite.blendMode = BlendMode.LAYER;
        this.setSize(1, this.canvasWidth, this.canvasHeight);
        this.drawSprite = this.containerSprite;
        this.cursorSprite = new Sprite();
        this.cursorSprite.blendMode = BlendMode.INVERT;
        addChild(this.cursorSprite);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onStartDraw);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onDraw);
        addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
    }
    
    private function createBitmaps() : Void
    {
        this.backBitmap = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
        this.backBitmap2 = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
        this.currentBitmap = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
    }
    
    public function setSize(param1 : Float, param2 : Int, param3 : Int) : Void
    {
        this.canvasScale = param1;
        this.canvasWidth = param2;
        this.canvasHeight = param3;
        this.canvasMatrix = new Matrix();
        this.canvasMatrix.scale(this.canvasScale, this.canvasScale);
        graphics.clear();
        graphics.beginFill(0xFFFFFF);
        graphics.drawRect(0, 0, param2, param3);
        graphics.endFill();
        this.backContainerSprite2.removeChild(this.backBitmap2);
        this.backContainerSprite.removeChild(this.backBitmap);
        this.containerSprite.removeChild(this.currentBitmap);
        this.backBitmap = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
        this.backBitmap2 = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
        this.currentBitmap = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0));
        this.backContainerSprite2.addChild(this.backBitmap2);
        this.backContainerSprite.addChild(this.backBitmap);
        this.containerSprite.addChild(this.currentBitmap);
        this.redrawCurrent();
        this.redrawBack();
        if (this.cursorSprite != null)
        {
            this.setPenSize(this.penSize, 0);
        }
    }
    
    private function onOver(param1 : Event) : Void
    {
        if (this.readOnly || this.activeTool == TOOL_PICKER)
        {
            return;
        }
        Mouse.hide();
    }
    
    public function setFrame(param1 : Frame, param2 : Bool = false) : Void
    {
        this.readOnly = param2;
        if (this.activeFrame != null)
        {
        }
        this.activeFrame = param1;
        if (this.currentSprite != null)
        {
            if (this.backSprite2 != null && this.backSprite2.parent != null)
            {
                this.backSprite2 = null;
            }
            this.backSprite2 = this.backSprite;
            if (this.backSprite != null && this.backSprite.parent != null)
            {
                this.backSprite = null;
            }
            if (this.currentSprite != this.activeFrame.sprite)
            {
                this.backSprite = this.currentSprite;
                this.redrawBack();
            }
        }
        this.currentSprite = this.activeFrame.sprite;
        this.redrawCurrent();
    }
    
    public function redrawBack() : Void
    {
        this.backBitmap.bitmapData.fillRect(new Rectangle(0, 0, this.canvasWidth, this.canvasHeight), 0);
        if (this.backSprite != null)
        {
            this.backBitmap.bitmapData.draw(this.backSprite, this.canvasMatrix);
        }
        this.backBitmap2.bitmapData.fillRect(new Rectangle(0, 0, this.canvasWidth, this.canvasHeight), 0);
        if (this.backSprite2 != null)
        {
            this.backBitmap2.bitmapData.draw(this.backSprite2, this.canvasMatrix);
        }
    }
    
    public function redrawCurrent() : Void
    {
        this.currentBitmap.bitmapData.fillRect(new Rectangle(0, 0, this.canvasWidth, this.canvasHeight), 0);
        if (this.currentSprite != null)
        {
            this.currentBitmap.bitmapData.draw(this.currentSprite, this.canvasMatrix);
        }
    }
    
    public function disableEditor() : Void
    {
        if (this.currentSprite != null)
        {
        }
        if (this.backSprite != null)
        {
        }
    }
    
    public function enableEditor() : Void
    {
        if (this.currentSprite != null)
        {
        }
        if (this.backSprite != null)
        {
        }
    }
    
    public function updateFrame() : Void
    {
        dispatchEvent(new Event(Main.DRAW_FRAME_UPDATE));
    }
    
    public function setPenSize(param1 : Int, param2 : Int = 0) : Void
    {
        if (param2 != 0)
        {
            if (this.penSize < 10)
            {
                this.penSize = this.penSize + param2;
            }
            else if (this.penSize < 50)
            {
                this.penSize = this.penSize + param2 * 5;
            }
            else
            {
                this.penSize = this.penSize + param2 * 10;
            }
            if (this.penSize < 1)
            {
                this.penSize = 1;
            }
            if (this.penSize > 300)
            {
                this.penSize = 300;
            }
        }
        else
        {
            this.penSize = param1;
        }
        var _loc3_ : Float = this.penSize * this.canvasScale;
        this.cursorSprite.graphics.clear();
        if (_loc3_ <= 4)
        {
            this.cursorSprite.graphics.beginFill(0xFFFFFF, 1);
            this.cursorSprite.graphics.lineStyle(1.2, this.penColor, 1);
            this.cursorSprite.graphics.drawEllipse(0, 0, _loc3_, _loc3_);
            this.cursorSprite.graphics.endFill();
        }
        else
        {
            this.cursorSprite.graphics.lineStyle(1.2, 0xFFFFFF, 1);
            this.cursorSprite.graphics.drawEllipse(-0.2, -0.2, _loc3_ + 0.4, _loc3_ + 0.4);
            this.cursorSprite.graphics.lineStyle(1.2, this.penColor, 1);
            this.cursorSprite.graphics.drawEllipse(0, 0, _loc3_, _loc3_);
        }
    }
    
    public function getPenSize() : Int
    {
        return this.penSize;
    }
    
    public function setTool(param1 : String) : Void
    {
        if (param1 == TOOL_PEN && this.penColor == 0xFFFFFF)
        {
            param1 = TOOL_ERASER;
        }
        this.activeTool = param1;
        var _loc2_ : Float = this.penSize * this.canvasScale;
        if (param1 == TOOL_PICKER || this.readOnly)
        {
            Mouse.show();
            this.cursorSprite.visible = false;
        }
        else
        {
            Mouse.hide();
            this.cursorSprite.visible = true;
            this.cursorSprite.x = mouseX - _loc2_ / 2;
            this.cursorSprite.y = mouseY - _loc2_ / 2;
        }
    }
    
    public function setColor(param1 : Int) : Void
    {
        this.penColor = param1;
        this.setPenSize(this.penSize);
    }
    
    public function getColor() : Int
    {
        return this.penColor;
    }
    
    private function onStartDraw(param1 : MouseEvent) : Void
    {
        var _loc2_ : Int = 0;
        if (this.activeTool == TOOL_PICKER)
        {
            _loc2_ = this.currentBitmap.bitmapData.getPixel32(Std.int(mouseX), Std.int(mouseY));
            if (_loc2_ >> 24 == 0)
            {
                _loc2_ = 0xFFFFFF;
            }
            _loc2_ = _loc2_ & 0xFFFFFF;
            this.setColor(_loc2_);
            dispatchEvent(new Event(Main.DRAW_COLOR_PICK));
            return;
        }
        if (this.readOnly)
        {
            return;
        }
        this.beginTime = Math.round(haxe.Timer.stamp() * 1000);
        this.lastX = mouseX;
        this.lastY = mouseY;
        this.moves = 0;
        this.mouseDown = true;
        this.lastPoints = {
                    points : [{
                        x : mouseX / this.canvasScale,
                        y : mouseY / this.canvasScale
                    }],
                    midPoint : 1
                };
        this.lastAngle = -1;
        this.points = [{
                    x : this.lastX / this.canvasScale,
                    y : this.lastY / this.canvasScale
                }];
        this.drawShape = new Shape();
        this.drawShape.blendMode = BlendMode.NORMAL;
        this.drawShape.graphics.lineStyle(this.penSize, (this.activeTool == TOOL_ERASER) ? 0xFFFFFF : this.penColor);
        this.drawShape.graphics.moveTo(mouseX, mouseY);
        this.drawSprite.addChild(this.drawShape);
        if (this.oldschoolMode)
        {
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onOldEndDraw);
        }
        else
        {
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onEndDraw);
        }
    }
    
    private function lineLength(param1 : Dynamic, param2 : Dynamic) : Float
    {
        return Math.sqrt((param1.x - param2.x) * (param1.x - param2.x) + (param1.y - param2.y) * (param1.y - param2.y));
    }
    
    private function onDraw(param1 : MouseEvent) : Void
    {
        if (this.readOnly || this.activeTool == TOOL_PICKER)
        {
            return;
        }
        var _loc2_ : Float = this.penSize * this.canvasScale;
        this.cursorSprite.x = mouseX - _loc2_ / 2;
        this.cursorSprite.y = mouseY - _loc2_ / 2;
        if (!this.mouseDown)
        {
            return;
        }
        this.drawShape.graphics.lineStyle(_loc2_, this.penColor);
        this.drawShape.graphics.moveTo(this.points[this.points.length - 1].x * this.canvasScale, this.points[this.points.length - 1].y * this.canvasScale);
        this.drawShape.graphics.lineTo(mouseX, mouseY);
        this.points.push({
                    x : mouseX / this.canvasScale,
                    y : mouseY / this.canvasScale
                });
    }
    
    private function onEndDraw(param1 : MouseEvent) : Void
    {
        var _loc4_ : Float = Math.NaN;
        var _loc5_ : LineGeneralization = null;
        var _loc6_ : Matrix = null;
        this.beginTime = Math.round(haxe.Timer.stamp() * 1000) - this.beginTime;
        this.mouseDown = false;
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onEndDraw);
        var _loc2_ : Bool = false;
        if (this.points.length == 1 && this.lastX == mouseX && this.lastY == mouseY)
        {
            _loc2_ = true;
        }
        else
        {
            _loc4_ = (this.lastX - mouseX) * (this.lastX - mouseX) / this.canvasScale / this.canvasScale + (this.lastY - mouseY) * (this.lastY - mouseY) / this.canvasScale / this.canvasScale;
            this.points.push({
                        x : mouseX / this.canvasScale,
                        y : mouseY / this.canvasScale
                    });
            _loc5_ = new LineGeneralization();
            this.points = _loc5_.simplifyLang(5, 10, this.points);
        }
        this.drawSprite.removeChild(this.drawShape);
        var _loc3_ : Shape = this.activeFrame.addSpline(this.points, (this.activeTool == TOOL_ERASER) ? 0xFFFFFF : as3hx.Compat.parseInt(this.penColor), this.activeTool, this.penSize, false, this.beginTime);
        dispatchEvent(new Event(Main.DRAW_FRAME_UPDATE));
        if (this.activeTool == TOOL_ERASER)
        {
            this.redrawCurrent();
        }
        else
        {
            _loc6_ = new Matrix();
            _loc6_.scale(this.canvasScale, this.canvasScale);
            this.currentBitmap.bitmapData.draw(_loc3_, _loc6_);
        }
    }
    
    public function switchOldschool() : Void
    {
        this.oldschoolMode = !this.oldschoolMode;
    }
    
    private function onOldEndDraw(param1 : MouseEvent) : Void
    {
        var _loc2_ : Bool = false;
        var _loc8_ : Float = Math.NaN;
        var _loc9_ : Float = Math.NaN;
        var _loc10_ : Float = Math.NaN;
        var _loc11_ : Float = Math.NaN;
        var _loc13_ : Bool = false;
        var _loc14_ : Float = Math.NaN;
        var _loc15_ : Float = Math.NaN;
        var _loc20_ : LineGeneralization = null;
        var _loc21_ : Int = 0;
        this.mouseDown = false;
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onOldEndDraw);
        var _loc3_ : Int = 4;
        var _loc4_ : Int = as3hx.Compat.parseInt(this.penSize / 2);
        var _loc5_ : Int = as3hx.Compat.parseInt(mouseX / this.canvasScale);
        var _loc6_ : Int = as3hx.Compat.parseInt(mouseY / this.canvasScale);
        var _loc7_ : Float = _loc4_;
        var _loc12_ : Array<Dynamic> = [];
        var _loc16_ : Float = 0;
        if (_loc4_ >= 2)
        {
            _loc16_ = _loc4_ / 2;
            if (_loc16_ < 2)
            {
                _loc16_ = 2;
            }
            if (_loc16_ > 6)
            {
                _loc16_ = 6;
            }
        }
        if (_loc2_)
        {
            _loc11_ = 0;
            while (_loc11_ < Math.PI * 2)
            {
                _loc8_ = this.points[0].x + _loc7_ * Math.cos(_loc11_);
                _loc9_ = this.points[0].y + _loc7_ * Math.sin(_loc11_);
                _loc12_.push({
                            x : _loc8_,
                            y : _loc9_
                        });
                _loc11_ = _loc11_ + Math.PI / _loc3_;
            }
        }
        else
        {
            _loc20_ = new LineGeneralization();
            this.points = _loc20_.simplifyLang(5, 5, this.points);
            _loc10_ = this.getAngle(this.points[0], this.points[1]);
            _loc11_ = _loc10_ + Math.PI / 2;
            while (_loc11_ < _loc10_ + Math.PI / 2 + Math.PI + Math.PI / _loc3_ / 2)
            {
                _loc8_ = this.points[0].x + _loc7_ * Math.cos(_loc11_);
                _loc9_ = this.points[0].y + _loc7_ * Math.sin(_loc11_);
                _loc12_.push({
                            x : _loc8_,
                            y : _loc9_
                        });
                _loc11_ = _loc11_ + Math.PI / _loc3_;
            }
            _loc21_ = 1;
            while (_loc21_ < this.points.length - 1)
            {
                _loc15_ = this.getAngle(this.points[_loc21_], this.points[_loc21_ + 1]);
                _loc14_ = _loc10_ - _loc15_;
                if (_loc14_ > Math.PI)
                {
                    _loc14_ = Math.PI * 2 - _loc14_;
                    _loc13_ = false;
                }
                else if (_loc14_ < -Math.PI)
                {
                    _loc14_ = Math.PI * 2 + _loc14_;
                    _loc13_ = true;
                }
                else if (_loc14_ >= 0)
                {
                    _loc13_ = true;
                }
                else
                {
                    _loc14_ = -_loc14_;
                    _loc13_ = false;
                }
                _loc11_ = this.midAngle(_loc10_ - Math.PI / 2, _loc15_ - Math.PI / 2);
                if (_loc13_)
                {
                    _loc11_ = _loc11_ + Math.PI;
                }
                if (_loc14_ > Math.PI / 4)
                {
                    if (!_loc13_)
                    {
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc10_ - Math.PI / 2);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc10_ - Math.PI / 2);
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                        _loc12_.push({
                                    x : _loc8_,
                                    y : _loc9_
                                });
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc15_ - Math.PI / 2);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc15_ - Math.PI / 2);
                    }
                    else
                    {
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                        _loc12_.push({
                                    x : _loc8_,
                                    y : _loc9_
                                });
                    }
                }
                else
                {
                    _loc7_ = _loc4_ + Math.random() * _loc16_ - _loc16_ / 2;
                    _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                    _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                    _loc12_.push({
                                x : _loc8_,
                                y : _loc9_
                            });
                }
                _loc10_ = _loc15_;
                _loc21_++;
            }
            _loc10_ = this.getAngle(this.points[this.points.length - 2], this.points[this.points.length - 1]);
            _loc7_ = _loc4_ + Math.random() * _loc16_ - _loc16_ / 2;
            _loc11_ = _loc10_ + Math.PI / 2 + Math.PI;
            while (_loc11_ < _loc10_ + Math.PI / 2 + Math.PI * 2 + Math.PI / _loc3_ / 2)
            {
                _loc8_ = this.points[this.points.length - 1].x + _loc7_ * Math.cos(_loc11_);
                _loc9_ = this.points[this.points.length - 1].y + _loc7_ * Math.sin(_loc11_);
                _loc12_.push({
                            x : _loc8_,
                            y : _loc9_
                        });
                _loc11_ = _loc11_ + Math.PI / _loc3_;
            }
            _loc10_ = this.getAngle(this.points[this.points.length - 1], this.points[this.points.length - 2]);
            _loc21_ = as3hx.Compat.parseInt(this.points.length - 2);
            while (_loc21_ > 0)
            {
                _loc15_ = this.getAngle(this.points[_loc21_], this.points[_loc21_ - 1]);
                _loc14_ = _loc10_ - _loc15_;
                if (_loc14_ > Math.PI)
                {
                    _loc14_ = Math.PI * 2 - _loc14_;
                    _loc13_ = false;
                }
                else if (_loc14_ < -Math.PI)
                {
                    _loc14_ = Math.PI * 2 + _loc14_;
                    _loc13_ = true;
                }
                else if (_loc14_ >= 0)
                {
                    _loc13_ = true;
                }
                else
                {
                    _loc14_ = -_loc14_;
                    _loc13_ = false;
                }
                _loc11_ = this.midAngle(_loc10_ - Math.PI / 2, _loc15_ - Math.PI / 2);
                if (_loc13_)
                {
                    _loc11_ = _loc11_ + Math.PI;
                }
                if (_loc14_ > Math.PI / 4)
                {
                    if (!_loc13_)
                    {
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc10_ - Math.PI / 2);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc10_ - Math.PI / 2);
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                        _loc12_.push({
                                    x : _loc8_,
                                    y : _loc9_
                                });
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc15_ - Math.PI / 2);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc15_ - Math.PI / 2);
                    }
                    else
                    {
                        _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                        _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                        _loc12_.push({
                                    x : _loc8_,
                                    y : _loc9_
                                });
                    }
                }
                else
                {
                    _loc7_ = _loc4_ + Math.random() * _loc16_ - _loc16_ / 2;
                    _loc8_ = this.points[_loc21_].x + _loc7_ * Math.cos(_loc11_);
                    _loc9_ = this.points[_loc21_].y + _loc7_ * Math.sin(_loc11_);
                    _loc12_.push({
                                x : _loc8_,
                                y : _loc9_
                            });
                }
                _loc10_ = _loc15_;
                _loc21_--;
            }
        }
        this.drawSprite.removeChild(this.drawShape);
        var _loc17_ : Array<Dynamic> = new Array<Dynamic>();
        var _loc18_ : Int = 0;
        while (_loc18_ < _loc12_.length)
        {
            _loc17_.push(new Point(_loc12_[_loc18_].x, _loc12_[_loc18_].y));
            _loc18_++;
        }
        var _loc19_ : Shape = this.activeFrame.addSpline(_loc12_, (this.activeTool == TOOL_ERASER) ? 0xFFFFFF : as3hx.Compat.parseInt(this.penColor), this.activeTool, 0);
        dispatchEvent(new Event(Main.DRAW_FRAME_UPDATE));
        if (this.activeTool == TOOL_ERASER)
        {
            this.redrawCurrent();
        }
        else
        {
            this.currentBitmap.bitmapData.draw(_loc19_, this.canvasMatrix);
        }
    }
    
    private function getAngle(param1 : Dynamic, param2 : Dynamic) : Float
    {
        var _loc3_ : Float = Math.NaN;
        if (param1.y == param2.y)
        {
            _loc3_ = 0;
        }
        else
        {
            _loc3_ = Math.atan((param2.y - param1.y) / (param2.x - param1.x));
        }
        if (param2.x - param1.x < 0)
        {
            _loc3_ = Math.PI + _loc3_;
        }
        while (_loc3_ < 0)
        {
            _loc3_ = _loc3_ + Math.PI * 2;
        }
        while (_loc3_ > Math.PI * 2)
        {
            _loc3_ = _loc3_ - Math.PI * 2;
        }
        return _loc3_;
    }
    
    private function midAngle(param1 : Float, param2 : Float) : Float
    {
        while (param1 < 0)
        {
            param1 = param1 + Math.PI * 2;
        }
        while (param1 > Math.PI * 2)
        {
            param1 = param1 - Math.PI * 2;
        }
        while (param2 < 0)
        {
            param2 = param2 + Math.PI * 2;
        }
        while (param2 > Math.PI * 2)
        {
            param2 = param2 - Math.PI * 2;
        }
        var _loc3_ : Float = Math.PI * 2 - param1 + param2;
        while (_loc3_ < 0)
        {
            _loc3_ = _loc3_ + Math.PI * 2;
        }
        while (_loc3_ > Math.PI * 2)
        {
            _loc3_ = _loc3_ - Math.PI * 2;
        }
        _loc3_ = param1 + _loc3_ / 2;
        while (_loc3_ < Math.PI * 2)
        {
            _loc3_ = _loc3_ + Math.PI * 2;
        }
        while (_loc3_ > Math.PI * 2)
        {
            _loc3_ = _loc3_ - Math.PI * 2;
        }
        return _loc3_;
    }
}

