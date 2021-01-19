package toonator;

import fivecolor.Slider;
import fivecolor.FrameList;
import flash.errors.Error;
import fivecolor.ChangeFrameEvent;
import fivecolor.SlideEvent;
import fivecolor.ToolPanel;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.external.ExternalInterface;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.net.URLRequestMethod;
import flash.ui.Mouse;
import flash.utils.ByteArray;
import flash.utils.Endian;

class Main extends MovieClip
{
    
    public static inline var DRAW_FRAME_UPDATE : String = "frameUpdate";
    
    public static inline var DRAW_COLOR_PICK : String = "drawColorPick";
    
    
    private var drawField : DrawField;
    
    private var frame : Frame;
    
    private var toolPanel : ToolPanel;
    
    private var curFrame : Int = -1;
    
    private var frames : Array<Dynamic>;
    
    private var playSprite : Sprite;
    
    private var playBitmap : Bitmap;
    
    private var saveForm : SaveForm;
    
    private var saveComplete : SaveComplete;
    
    private var fadeSprite : Sprite;
    
    private var incomeTags : String = "";
    
    private var cont : String = "";
    
    private var draft : String = "";
    
    private var lang : String = "ru";
    
    private var replaceColor : Int = 0;
        
    private var leproLogo : Bitmap;
    
    private var isDraft : Bool = false;
    
    private var session : String = "";
    
    private var disableCopy : Bool = false;
    
    private var frameLimit : Int = 0;
    
    private var lastUploader : URLLoader;
    
    private var canvasWidth : Int = 600;
    
    private var canvasHeight : Int = 300;
    
    private var canvasScale : Float = 1;
    
    private var sessionLoader : URLLoader;
    
    private var loader : URLLoader;
    
    private var copyFrame : Frame;
    
    private var lastThreeKeys : Array<Dynamic>;
    
    private var locked : Bool = false;
    
    private var playFrame : Int;
    
    private var playTimer : Int;
    
    private var playing : Bool = false;
    
    private var frameCounter : Int = 0;
    
    private var matrix : Matrix;
    
    private var lastFrameSprite : Sprite = null;
    
    private var uploader : URLLoader;
    
    private var totalUploadSize : Int;

    private var frameList:FrameList;
    private var framesSlider:Slider;
    
    public function new()
    {
        this.frames = [];
        this.leproLogo = new Bitmap(new Main_LeproLogoSwf());
        this.lastThreeKeys = [0, 0, 0];
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
    
    private function init(param1 : Event = null) : Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, this.init);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        this.fadeSprite = new Sprite();
        this.fadeSprite.visible = false;
        this.drawField = new DrawField();
        this.drawField.addEventListener(DRAW_FRAME_UPDATE, this.onFrameUpdate);
        this.drawField.addEventListener(DRAW_COLOR_PICK, this.onDrawColorPick);
        addChild(this.drawField);
        var _loc2_ : Dynamic = cast((stage.loaderInfo), LoaderInfo).parameters;
        if (_loc2_.s != null)
        {
            this.session = _loc2_.s;
        }
        if(_loc2_.lang != null)
        {
            this.lang = _loc2_.lang;
        }
        this.isDraft = true;
        if (this.session == "anonymous")
        {
            this.isDraft = false;
        }
        else if (this.session != "")
        {
            this.loadSession(this.session);
        }
        if (_loc2_.dc != null)
        {
            this.disableCopy = true;
        }
        if (_loc2_.fl != null)
        {
            this.frameLimit = as3hx.Compat.parseInt(_loc2_.fl);
        }
        if (_loc2_.tags != null)
        {
            this.incomeTags = _loc2_.tags;
        }
        this.playSprite = new Sprite();
        this.playSprite.visible = false;
        addChild(this.playSprite);
        this.playBitmap = new Bitmap(new BitmapData(600, 300, true, 0));
        this.playSprite.addChild(this.playBitmap);
        this.toolPanel = new ToolPanel();
        this.toolPanel.y = 300;
        this.toolPanel.removeChild(this.toolPanel.framesSlider);
        this.toolPanel.removeChild(this.toolPanel.frameList);
        this.framesSlider = new Slider();
        this.framesSlider.x = 79.5;
        this.framesSlider.y = 29.95;
        this.frameList = new FrameList();
        this.frameList.x = 81;
        this.frameList.y = 3;
        addChild(this.toolPanel);
        this.toolPanel.addChild(this.frameList);
        this.toolPanel.addChild(this.framesSlider);
        this.toolPanel.addEventListener("addFrame", this.onAddFrame);
        this.toolPanel.addEventListener("addFramePrev", this.onAddFrame);
        this.toolPanel.addEventListener("delFrame", this.onDelFrame);
        this.toolPanel.addEventListener("setPencil", this.onSetPencil);
        this.toolPanel.addEventListener("setEraser", this.onSetEraser);
        this.toolPanel.addEventListener("setPicker", this.onSetPicker);
        this.toolPanel.addEventListener("setPenColor", this.onSetPenColor);
        this.toolPanel.addEventListener("setPenSize", this.onSetPenSize);
        this.toolPanel.addEventListener("playMovie", this.onPlayMovie);
        this.toolPanel.addEventListener("pauseMovie", this.onPauseMovie);
        this.toolPanel.addEventListener("saveMovie", this.onSaveMovie);
        this.toolPanel.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
        if (this.frameLimit > 0)
        {
            this.toolPanel.btnAddFrame.visible = false;
            this.toolPanel.btnDelFrame.visible = false;
        }
        if (_loc2_.palette != null)
        {
            this.toolPanel.enablePalette = true;
        }
        if (ExternalInterface.available)
        {
            ExternalInterface.addCallback("enablePalette", this.enablePalette);
        }
        this.framesSlider.addEventListener("sliderMove", this.onSliderMove);
        this.frameList.addEventListener("currentFrameChanged", this.onFrameChanged);
        stage.addEventListener(Event.RESIZE, this.onStageResize);
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this.onAddFrame();
        this.drawField.setPenSize(this.toolPanel.penSize);
        this.drawField.setColor(this.replaceColor);
        this.fadeSprite.graphics.beginFill(13421772, 0.9);
        this.fadeSprite.graphics.drawRect(0, 0, width, height);
        this.fadeSprite.graphics.endFill();
        addChild(this.fadeSprite);
        this.saveForm = new SaveForm(this.lang);
        addChild(this.saveForm);
        this.saveForm.x = width / 2 - this.saveForm.width / 2;
        this.saveForm.y = height / 2 - this.saveForm.height / 2;
        this.saveForm.visible = false;
        this.saveForm.btnSave.visible = true;
        this.saveForm.btnCancel.visible = true;
        this.saveForm.btnSave.addEventListener(MouseEvent.CLICK, this.onSaveClick);
        this.saveForm.btnCancel.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this.saveForm.edtDescription.text = "";
        this.saveForm.edtKeys.text = this.incomeTags;
        this.saveComplete = new SaveComplete();
        addChild(this.saveComplete);
        this.saveComplete.x = width / 2 - this.saveComplete.width / 2;
        this.saveComplete.y = height / 2 - this.saveComplete.height / 2;
        this.saveComplete.visible = false;
        this.saveComplete.btnOK.addEventListener(MouseEvent.CLICK, this.onSaveComplete2);

        if (this.lang == "en")
        {
            this.saveComplete.lbl_saved.text = "Animation saved";
            this.saveComplete.lbl_page.text = "URL:";
    
            this.saveForm.lbl_name.text = "Name:";
            this.saveForm.lbl_keywords.text = "Keywords:";
            this.saveForm.lbl_description.text = "Description:";
    
            this.saveForm.btnSave.lbl_save.text = "save";
            this.saveForm.btnCancel.lbl_cancel.text = "cancel";
        }
        else
        {
            this.saveComplete.lbl_saved.text = "Анимация сохранена";
            this.saveComplete.lbl_page.text = "Ссылка:";
    
            this.saveForm.lbl_name.text = "Название:";
            this.saveForm.lbl_keywords.text = "Ключевые слова:";
            this.saveForm.lbl_description.text = "Описание:";
                
            this.saveForm.btnSave.lbl_save.text = "сохранить";
            this.saveForm.btnCancel.lbl_cancel.text = "отмена";
        
            this.toolPanel.btnAddFrame.setHint("c Ctrl для добавления перед текушим кадром");
        }
            
        this.saveForm.btnSave.buttonMode = true;
        this.saveForm.btnCancel.buttonMode = true;

        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUp);
    }
    
    public function enablePalette() : Void
    {
        this.toolPanel.enablePalette = true;
    }
    
    private function onDrawColorPick(param1 : Event) : Void
    {
        var _loc2_ : Int = this.drawField.getColor();
        this.toolPanel.setPickerColor(_loc2_);
        if (_loc2_ == 0xFFFFFF)
        {
            this.toolPanel.setErase(null);
        }
        else
        {
            this.toolPanel.setPencil(null);
        }
    }
    
    private function endpoint(param1 : String) : String
    {
        if (this.lang == "en")
        {
            return "https://toonator.com/" + param1;
        }
        if (this.lang == "xx")
        {
            return "https://multator.xx/" + param1;
        }
        return "https://multator.ru/" + param1;
    }
    
    private function loadSession(param1 : String) : Void
    {
        this.fade(true);
        this.sessionLoader = new URLLoader();
        this.sessionLoader.dataFormat = URLLoaderDataFormat.TEXT;
        this.sessionLoader.addEventListener(Event.COMPLETE, this.onSessionLoadComplete);
        this.sessionLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
        this.sessionLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
        this.sessionLoader.load(new URLRequest(this.endpoint("api/v1/drawing/session/" + param1)));
    }
    
    private function onSessionLoadComplete(param1 : Event) : Void
    {
        var _loc2_ : Dynamic = haxe.Json.parse(cast(param1.target, URLLoader).data);
        if (_loc2_.result != "ok")
        {
            if (this.lang == "en")
            {
                this.saveComplete.lblLink.htmlText = "error while loading";
            }
            else
            {
                this.saveComplete.lblLink.htmlText = "ошибка при загрзке";
            }
            this.saveComplete.visible = true;
            return;
        }
        if (_loc2_.draft != null)
        {
            this.draft = _loc2_.draft;
            this.loadClip(this.draft);
        }
        else if (_loc2_.original != null)
        {
            this.cont = _loc2_.original;
            this.loadClip(this.cont);
        }
        else
        {
            this.fade(false);
        }
    }
    
    private function loadClip(param1 : String) : Void
    {
        this.fade(true);
        this.loader = new URLLoader();
        this.loader.dataFormat = URLLoaderDataFormat.BINARY;
        this.loader.addEventListener(Event.COMPLETE, this.onLoadComplete);
        this.loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
        this.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
        this.loader.load(new URLRequest(this.endpoint("dra/" + param1)));
    }
    
    private function onLoadComplete(param1 : Event) : Void
    {
        var _loc3_ : Array<Dynamic> = null;
        var _loc5_ : ByteArray = null;
        var _loc6_ : Int = 0;
        var _loc7_ : Int = 0;
        var _loc8_ : Array<Dynamic> = null;
        var _loc9_ : Int = 0;
        var _loc10_ : Int = 0;
        var _loc11_ : Dynamic = null;
        var _loc12_ : Int = 0;
        var _loc13_ : Int = 0;
        var _loc14_ : Int = 0;
        var _loc15_ : Int = 0;
        var _loc16_ : Int = 0;
        this.loader.data.endian = Endian.LITTLE_ENDIAN;
        var _loc2_ : Int = this.loader.data.readInt();
        if (_loc2_ == 2)
        {
            _loc3_ = [];
            _loc5_ = this.loader.data;
            _loc5_.endian = Endian.LITTLE_ENDIAN;
            _loc6_ = _loc5_.readUnsignedInt();
            if (_loc6_ == 0)
            {
                _loc5_ = this.StrToInt(_loc5_);
                _loc6_ = _loc5_.readUnsignedInt();
            }
            _loc7_ = 0;
            while (_loc7_ < _loc6_)
            {
                _loc8_ = [];
                _loc9_ = _loc5_.readUnsignedInt();
                _loc10_ = 0;
                while (_loc10_ < _loc9_)
                {
                    _loc11_ = {
                                spline : [],
                                action : 4,
                                color : 0,
                                size : 0
                            };
                    _loc11_.color = _loc5_.readUnsignedInt();
                    _loc12_ = _loc5_.readUnsignedInt();
                    if (_loc12_ == 0)
                    {
                        _loc11_.action = 5;
                        _loc11_.size = _loc5_.readUnsignedInt();
                        _loc12_ = _loc5_.readUnsignedInt();
                    }
                    _loc13_ = 0;
                    while (_loc13_ < _loc12_)
                    {
                        _loc14_ = _loc5_.readShort();
                        _loc15_ = _loc5_.readShort();
                        _loc11_.spline.push({
                                    x : _loc14_,
                                    y : _loc15_
                                });
                        _loc13_++;
                    }
                    _loc8_.push(_loc11_);
                    _loc10_++;
                }
                _loc3_.push(_loc8_);
                _loc7_++;
            }
            var _loc4_ : Int = 0;
            while (_loc4_ < _loc3_.length)
            {
                if (_loc4_ > 0)
                {
                    this.onAddFrameBool(true);
                }
                this.frames[this.curFrame].splines = _loc3_[_loc4_];
                this.frames[this.curFrame].havePreview = false;
                this.frames[this.curFrame].redrawFrame();
                _loc4_++;
            }
            _loc3_ = null;
            this.updatePreviews((this.frames.length >= 10) ? as3hx.Compat.parseInt(this.frames.length - 10) : 0);
            if (this.frames.length > 1)
            {
                this.drawField.setFrame(this.frames[this.frames.length - 2]);
            }
            if (this.frames.length > 0)
            {
                this.drawField.setFrame(this.frames[this.frames.length - 1]);
            }
            if (this.frameLimit > 0 && this.draft == "")
            {
                _loc16_ = this.curFrame;
                _loc4_ = 0;
                while (_loc4_ < this.frameLimit)
                {
                    this.onAddFrameBool(true);
                    _loc4_++;
                }
                this.curFrame = _loc16_;
                this.drawField.setFrame(this.frames[this.curFrame]);
                this.curFrame++;
                this.drawField.setFrame(this.frames[this.curFrame]);
                _loc7_ = this.frames[this.curFrame];
                this.frameList.setCurFrame(this.curFrame, this.curFrame - 1);
                this.onFrameChanged();
            }
            this.fade(false);
            return;
        }
    }
    
    private function onLoadError(param1 : Event) : Void
    {
        if (this.lang == "en")
        {
            this.saveComplete.lblLink.htmlText = "error while loading";
        }
        else
        {
            this.saveComplete.lblLink.htmlText = "ошибка при загрзке";
        }
        this.saveComplete.visible = true;
    }
    
    private function StrToInt(param1 : ByteArray) : ByteArray
    {
        var _loc8_ : Dynamic = 0;
        var _loc2_ : Array<Dynamic> = [];
        var _loc3_ : Int = 0;
        while (_loc3_ < 13)
        {
            _loc2_.push(param1.readUnsignedByte());
            _loc3_++;
        }
        _loc3_ = 0;
        while (_loc3_ < 1000)
        {
            _loc2_.push(_loc2_[_loc3_] ^ _loc2_[_loc3_ + 7]);
            _loc3_++;
        }
        var _loc4_ : ByteArray = new ByteArray();
        _loc4_.endian = Endian.LITTLE_ENDIAN;
        var _loc5_ : Int = param1.length;
        var _loc6_ : Int = 13;
        var _loc7_ : Int = param1.position;
        while (_loc7_ < _loc5_)
        {
            _loc8_ = param1.readUnsignedByte() ^ _loc2_[_loc6_];
            _loc4_.writeByte(_loc8_);
            _loc6_++;
            if (_loc6_ == _loc2_.length)
            {
                _loc6_ = 0;
            }
            _loc7_++;
        }
        _loc4_.position = 0;
        return _loc4_;
    }
    
    private function keyDown(param1 : KeyboardEvent) : Void
    {
        var _loc2_ : Int = 0;
        while (_loc2_ <= 1)
        {
            this.lastThreeKeys[_loc2_] = this.lastThreeKeys[_loc2_ + 1];
            _loc2_++;
        }
        this.lastThreeKeys[2] = param1.charCode;
        if (this.lastThreeKeys[0] == 111 && this.lastThreeKeys[1] == 108 && this.lastThreeKeys[2] == 100)
        {
            this.drawField.switchOldschool();
        }
        if (this.saveForm.visible)
        {
            return;
        }
        if (param1.keyCode == 90)
        {
            if (this.frame.splines.length > 0)
            {
                this.frame.undo();
                this.drawField.updateFrame();
                this.drawField.redrawCurrent();
                
                if(this.frame.splines.length == 0)
                {
                    trace('dead');
                    trace(this.frames[this.curFrame].splines);
                    this.frames[this.curFrame].splines = [];
                }
            }
        }
        else if (param1.keyCode == 67 && !this.disableCopy)
        {
            this.copyFrame = this.frames[this.curFrame].copy();
            this.flashCopy();
        }
        else if (param1.keyCode == 86 && !this.disableCopy)
        {
            if (this.copyFrame != null)
            {
                this.frames[this.curFrame].paste(this.copyFrame);
                this.onFrameChanged();
                this.onFrameUpdate();
                this.flashCopy();
            }
        }
        else if (param1.charCode == 43 || param1.charCode == 61)
        {
            this.drawField.setPenSize(0, 1);
            this.toolPanel.setPenActualSize(this.drawField.getPenSize());
        }
        else if (param1.charCode == 45)
        {
            this.drawField.setPenSize(0, -1);
            this.toolPanel.setPenActualSize(this.drawField.getPenSize());
        }
        else if (param1.keyCode == 66)
        {
            this.toolPanel.setPencil(null);
        }
        else if (param1.keyCode == 69)
        {
            this.toolPanel.setErase(null);
        }
        else if (param1.keyCode == 80 && this.toolPanel.enablePalette)
        {
            this.toolPanel.setPicker(null);
        }
        else if (param1.keyCode == 77)
        {
            this.toolPanel.enablePalette = !this.toolPanel.enablePalette;
        }
        else if (param1.keyCode == 70)
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("toggleFullscreen()");
            }
        }
    }
    
    private function keyUp(param1 : KeyboardEvent) : Void
    {
    }
    
    private function flashCopy() : Void
    {
        this.fadeSprite.visible = true;
        as3hx.Compat.setTimeout(function() : Void
                {
                    fadeSprite.visible = false;
                }, 50);
    }
    
    private function onFrameChanged(param1 : ChangeFrameEvent = null) : Void
    {
        var _loc2_ : Bool = false;
        if (param1 == null || this.curFrame != param1.curFrame)
        {
            if (param1 != null)
            {
                this.curFrame = param1.curFrame;
            }
            _loc2_ = this.frameLimit > 0 && this.frames.length - this.curFrame - 1 >= this.frameLimit;
            this.drawField.setFrame(this.frames[this.curFrame], _loc2_);
            this.frame = this.frames[this.curFrame];
        }
    }
    
    private function onFrameUpdate(param1 : Event = null) : Void
    {
        var _loc2_ : BitmapData = new BitmapData(48, 24);
        var _loc3_ : Matrix = new Matrix();
        _loc3_.scale(0.08, 0.08);
        _loc2_.draw(this.frame.sprite, _loc3_, null, null, null, false);
        this.frameList.updateFrame(this.curFrame, _loc2_);
        if (ExternalInterface.available && !this.locked)
        {
            this.locked = true;
            ExternalInterface.call("m.lockExit(\'draw\')");
        }
    }
    
    private function onOver(param1 : Event) : Void
    {
        Mouse.show();
    }
    
    private function onPlayMovie(param1 : Event) : Void
    {
        this.matrix = new Matrix();
        this.matrix.scale(this.canvasScale, this.canvasScale);
        if (this.frames.length == 0)
        {
            return;
        }
        this.drawField.disableEditor();
        this.toolPanel.setPlaying(true);
        this.drawField.visible = false;
        this.playSprite.visible = true;
        this.playFrame = 0;
        this.frameCounter = 0;
        this.playing = true;
    }
    
    private function onPauseMovie(param1 : Event) : Void
    {
        this.playing = false;
        if (this.lastFrameSprite != null)
        {
            this.lastFrameSprite = null;
        }
        this.playSprite.visible = false;
        this.toolPanel.setPlaying(false);
        this.drawField.visible = true;
        this.drawField.enableEditor();
    }
    
    private function onEnterFrame(param1 : Event) : Void
    {
        if (!this.playing)
        {
            return;
        }
        this.frameCounter++;
        if (this.frameCounter % 6 == 0)
        {
            this.doPlay();
        }
    }
    
    private function doPlay() : Void
    {
        var _loc1_ : Frame = this.frames[this.playFrame];
        if (this.lastFrameSprite != null)
        {
        }
        this.playBitmap.bitmapData.fillRect(new Rectangle(0, 0, this.canvasWidth, this.canvasHeight), 0xFFFFFF);
        this.playBitmap.bitmapData.draw(_loc1_.sprite, this.matrix);
        this.lastFrameSprite = _loc1_.sprite;
        this.playFrame++;
        if (this.playFrame == this.frames.length)
        {
            this.playFrame = 0;
        }
    }
    
    private function onSetPencil(param1 : Event) : Void
    {
        if (this.drawField.getColor() == 0xFFFFFF)
        {
            this.drawField.setTool(DrawField.TOOL_ERASER);
        }
        else
        {
            this.drawField.setTool(DrawField.TOOL_PEN);
        }
    }
    
    private function onSetEraser(param1 : Event) : Void
    {
        this.drawField.setTool("eraser");
    }
    
    private function onSetPicker(param1 : Event) : Void
    {
        this.drawField.setTool("picker");
    }
    
    private function onAddFrameBool(param2:Bool = false):Void
    {
        AddFrame(null, param2);
    }
    private function onAddFrame(param1 : Event = null) : Void
    {
        AddFrame(param1, false);
    }
    private function AddFrame(param1:Event, param2:Bool = false):Void
    {
        var _loc3_ : Frame = new Frame();
        if (param1 != null)
        {
            _loc3_.isNew = true;
        }
        this.curFrame = this.curFrame + 1;
        if (param1 != null)
        {
            if (param1.type == "addFramePrev")
            {
                this.curFrame--;
            }
        }
        if (this.curFrame == this.frames.length)
        {
            this.frames.push(_loc3_);
        }
        else
        {
            this.frames.insert(this.curFrame, _loc3_);
        }
        if (!param2)
        {
            this.drawField.setFrame(_loc3_);
        }
        var _loc4_ : BitmapData = new BitmapData(48, 24);
        this.frameList.addFrame(this.curFrame, _loc4_);
        this.framesSlider.setMax(this.frames.length - 10);
        this.framesSlider.setPos(this.frames.length - 10);
        this.frame = _loc3_;
    }
    
    private function onDelFrame(param1 : Event) : Void
    {
        if (this.frames.length == 1)
        {
            return;
        }
        this.frames.splice(this.curFrame, 1);
        this.frameList.delFrame(this.curFrame);
        if (this.curFrame > 0)
        {
            this.curFrame--;
        }
        this.onFrameChanged();
    }
    
    private function onSetPenColor(param1 : Event) : Void
    {
        if (this.toolPanel.penColor == 0 && this.replaceColor != 0)
        {
            this.drawField.setColor(this.replaceColor);
        }
        else
        {
            this.drawField.setColor(this.toolPanel.penColor);
        }
        if (this.drawField.getColor() == 0xFFFFFF)
        {
            this.toolPanel.setErase(null);
        }
        else
        {
            this.toolPanel.setPencil(null);
        }
    }
    
    private function onMouseWheel(param1 : MouseEvent) : Void
    {
        this.drawField.setPenSize(0, (param1.delta > 0) ? 1 : -1);
    }
    
    private function onSetPenSize(param1 : Event) : Void
    {
        this.drawField.setPenSize(this.toolPanel.penSize);
    }
    
    private function fade(param1 : Bool) : Void
    {
        this.fadeSprite.visible = param1;
    }
    
    private function onSaveMovie(param1 : Event) : Void
    {
        this.fade(true);
        this.saveForm.chkDraft.visible = this.isDraft;
        this.saveForm.visible = true;
        this.saveForm.btnSave.visible = true;
        this.saveForm.lblStatus.text = "";
    }
    
    private function saveFrame(param1 : Int) : Void
    {
        var _loc2_ : BitmapData = null;
        var _loc3_ : BitmapData = null;
        if (this.lang == "en")
        {
            this.saveForm.lblStatus.text = "Prepare " + Math.round(param1 / this.frames.length * 100) + "%";
        }
        else
        {
            this.saveForm.lblStatus.text = "Подготовка " + Math.round(param1 / this.frames.length * 100) + "%";
        }
        if (param1 < this.frames.length)
        {
            _loc2_ = new BitmapData(600, 300, false);
            this.frames[param1].drawBitmap(_loc2_, true);
            _loc3_ = new BitmapData(200, 100, false);
            this.frames[param1].drawBitmapPreview(_loc3_, true);
            _loc2_.copyPixels(this.leproLogo.bitmapData, this.leproLogo.bitmapData.rect, new Point(570, 270), null, null, true);
            as3hx.Compat.setTimeout(this.saveFrame, 100, [param1 + 1]);
        }
        else
        {
            this.saveForm.btnSave.visible = true;
        }
    }
    
    private function onCancelClick(param1 : Event) : Void
    {
        if (this.uploader != null)
        {
            this.uploader.close();
            this.uploader = null;
        }
        this.saveForm.visible = false;
        this.fade(false);
    }
    
    private function onSaveClick(param1 : Event) : Void
    {
        var _loc14_ : URLRequest = null;
        var _loc16_ : Frame = null;
        var _loc17_ : Int = 0;
        var _loc18_ : Int = 0;
        var _loc19_ : Dynamic = 0;
        this.saveForm.btnSave.visible = false;
        if (this.lang == "en")
        {
            this.saveForm.lblStatus.text = "Save...";
        }
        else
        {
            this.saveForm.lblStatus.text = "Сохранение...";
        }
        var _loc2_ : Array<Dynamic> = new Array<Dynamic>();
        var _loc3_ : ByteArray = new ByteArray();
        _loc3_.endian = Endian.LITTLE_ENDIAN;
        _loc3_.writeInt(this.frames.length);
        var _loc4_ : ByteArray = new ByteArray();
        _loc4_.endian = Endian.LITTLE_ENDIAN;
        _loc4_.writeInt(0);
        var _loc5_ : Int = 0;
        var _loc6_ : Int = 0;
        var _loc7_ : Int = 0;
        var _loc8_ : Int = 0;
        var _loc9_ : Int = 0;
        while (_loc9_ < this.frames.length)
        {
            _loc16_ = this.frames[_loc9_];
            if (_loc16_.isNew)
            {
                _loc5_++;
            }
            _loc6_ = as3hx.Compat.parseInt(_loc6_ + _loc16_.newSplines);
            _loc7_ = as3hx.Compat.parseInt(_loc7_ + _loc16_.newPoints);
            _loc8_ = as3hx.Compat.parseInt(_loc8_ + _loc16_.drawTime);
            _loc3_.writeUnsignedInt(this.frames[_loc9_].splines.length);
            _loc17_ = 0;
            while (_loc17_ < this.frames[_loc9_].splines.length)
            {
                _loc3_.writeUnsignedInt(this.frames[_loc9_].splines[_loc17_].color);
                if (this.frames[_loc9_].splines[_loc17_].size == 0)
                {
                    _loc3_.writeUnsignedInt(this.frames[_loc9_].splines[_loc17_].spline.length);
                }
                else
                {
                    _loc3_.writeUnsignedInt(0);
                    _loc3_.writeUnsignedInt(this.frames[_loc9_].splines[_loc17_].size);
                    _loc3_.writeUnsignedInt(this.frames[_loc9_].splines[_loc17_].spline.length);
                }
                _loc18_ = 0;
                while (_loc18_ < this.frames[_loc9_].splines[_loc17_].spline.length)
                {
                    _loc3_.writeShort(this.frames[_loc9_].splines[_loc17_].spline[_loc18_].x);
                    _loc3_.writeShort(this.frames[_loc9_].splines[_loc17_].spline[_loc18_].y);
                    _loc18_++;
                }
                _loc17_++;
            }
            _loc9_++;
        }
        var _loc10_ : Array<Dynamic> = [];
        var _loc11_ : Int = 0;
        while (_loc11_ < 13)
        {
            _loc19_ = as3hx.Compat.parseInt(Math.floor(15 + Math.random() * 200));
            _loc10_.push(_loc19_);
            _loc4_.writeByte(_loc19_);
            _loc11_++;
        }
        _loc11_ = 0;
        while (_loc11_ < 1000)
        {
            _loc10_.push(_loc10_[_loc11_] ^ _loc10_[_loc11_ + 7]);
            _loc11_++;
        }
        var _loc12_ : Int = _loc3_.length;
        _loc3_.position = 0;
        _loc11_ = 13;
        var _loc13_ : Int = _loc3_.position;
        while (_loc13_ < _loc12_)
        {
            _loc19_ = _loc3_.readUnsignedByte() ^ _loc10_[_loc11_];
            _loc4_.writeByte(_loc19_);
            _loc11_++;
            if (_loc11_ == _loc10_.length)
            {
                _loc11_ = 0;
            }
            _loc13_++;
        }
        this.totalUploadSize = _loc4_.length;
        _loc4_.position = 0;
        _loc14_ = new URLRequest(this.endpoint("up/"));
        _loc14_.contentType = "multipart/form-data; boundary=" + UploadPostHelper.getBoundary();
        _loc14_.method = URLRequestMethod.POST;
        var _loc15_ : Dynamic = { };
        Reflect.setField(_loc15_, "name", this.saveForm.edtName.text);
        Reflect.setField(_loc15_, "tags", this.saveForm.edtKeys.text);
        Reflect.setField(_loc15_, "desc", this.saveForm.edtDescription.text);
        Reflect.setField(_loc15_, "format", "json");
        Reflect.setField(_loc15_, "isdraft", (this.isDraft && this.saveForm.checkDraft.isChecked) ? '1' : '0');
        Reflect.setField(_loc15_, "session", this.session);
        Reflect.setField(_loc15_, "stats", _loc5_ + ":" + _loc6_ + ":" + _loc7_ + ":" + _loc8_);
        _loc14_.data = UploadPostHelper.getPostData("file", _loc4_, _loc15_);
        _loc14_.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache"));
        this.uploader = new URLLoader();
        this.lastUploader = this.uploader;
        this.uploader.dataFormat = URLLoaderDataFormat.TEXT;
        this.uploader.addEventListener(Event.COMPLETE, this.onUploadComplete);
        this.uploader.addEventListener(ProgressEvent.PROGRESS, this.onUploadProgress);
        this.uploader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        this.uploader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onIOError);
        this.uploader.load(_loc14_);
    }
    
    private function onIOError(param1 : Dynamic) : Void
    {
        this.saveForm.btnSave.visible = true;
        this.saveForm.btnCancel.visible = true;
        if (this.lang == "ru")
        {
            this.saveForm.lblStatus.text = "Ошибка";
        }
        else
        {
            this.saveForm.lblStatus.text = "Error";
        }
    }
    
    private function updatePreviews(param1 : Int = -1) : Void
    {
        var _loc4_ : Int = 0;
        var _loc5_ : BitmapData = null;
        var _loc6_ : Matrix = null;
        var _loc2_ : Int = param1;
        if (_loc2_ == -1)
        {
            _loc2_ = this.framesSlider.getPos();
        }
        var _loc3_ : Int = 0;
        while (_loc3_ < 10)
        {
            _loc4_ = as3hx.Compat.parseInt(_loc2_ + _loc3_);
            if (_loc4_ < 0 || _loc4_ >= this.frames.length)
            {
                break;
            }
            if (!this.frames[_loc4_].havePreview)
            {
                this.frames[_loc4_].havePreview = true;
                _loc5_ = new BitmapData(48, 24);
                _loc6_ = new Matrix();
                this.frames[_loc4_].drawBitmapPreview(_loc5_);
                this.frameList.updateFrame(_loc4_, _loc5_);
            }
            _loc3_++;
        }
    }
    
    private function onSliderMove(param1 : SlideEvent) : Void
    {
        this.frameList.setStartPos(param1.pos);
        this.updatePreviews();
    }
    
    private function onUploadProgress(param1 : ProgressEvent) : Void
    {
    }
    
    private function onUploadComplete(param1 : Event) : Void
    {
        var json : Dynamic = null;
        var toon : String = null;
        var goUrl : String = null;
        var ev : Event = param1;
        this.saveForm.visible = false;
        this.uploader = null;
        try
        {
            json = haxe.Json.parse(cast(ev.target, URLLoader).data);
        }
        catch (e : Error)
        {
            json = {
                        result : "NOT JSON"
                    };
        }
        if (json.result == "ok" && json.state == "saved")
        {
            toon = json.toon;
            this.isDraft = false;
            this.draft = "";
            this.cont = toon;
            goUrl = this.endpoint("toon/" + toon);
            if (ExternalInterface.available)
            {
                this.locked = false;
                ExternalInterface.call("m.lockExit(\'draw\',false)");
                js.Syntax.code('location.href = {0}', goUrl);
            }
            else
            {
                this.saveComplete.setLink(goUrl);
            }
        }
        else
        {
            if (json.result == "ok" && json.state == "draft")
            {
                if (ExternalInterface.available)
                {
                    this.locked = false;
                    ExternalInterface.call("m.lockExit(\'draw\',false)");
                }
                this.isDraft = true;
                this.draft = json.draft;
                this.fade(false);
                return;
            }
            if (json.result == "error")
            {
                this.saveComplete.lblLink.htmlText = json.message;
            }
            else if (this.lang == "en")
            {
                this.saveComplete.lblLink.htmlText = "error while saving";
            }
            else
            {
                this.saveComplete.lblLink.htmlText = "ошибка при сохранении";
            }
        }
        this.saveComplete.visible = true;
    }
    
    private function onSaveComplete2(param1 : Event) : Void
    {
        this.saveComplete.visible = false;
        this.fade(false);
    }
    
    private function onStageResize(param1 : Event) : Void
    {
        this.toolPanel.y = stage.stageHeight - 90;
        this.toolPanel.x = (stage.stageWidth - 600) / 2;
        graphics.clear();
        graphics.beginFill(13421772);
        graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
        graphics.endFill();
        var _loc2_ : Int = stage.stageWidth;
        var _loc3_ : Int = as3hx.Compat.parseInt(stage.stageHeight - 90);
        var _loc4_ : Int = as3hx.Compat.parseInt(_loc2_ / 2);
        if (_loc3_ < _loc4_)
        {
            _loc2_ = as3hx.Compat.parseInt(_loc3_ * 2);
        }
        else
        {
            _loc3_ = _loc4_;
        }
        this.drawField.x = (stage.stageWidth - _loc2_) / 2;
        this.drawField.y = (stage.stageHeight - 90 - _loc3_) / 2;
        this.playSprite.x = this.drawField.x;
        this.playSprite.y = this.drawField.y;
        this.canvasHeight = _loc3_;
        this.canvasWidth = _loc2_;
        this.canvasScale = _loc2_ / 600;
        this.drawField.setSize(this.canvasScale, _loc2_, _loc3_);
        if (this.playBitmap != null)
        {
            this.playSprite.removeChild(this.playBitmap);
            this.playSprite.graphics.clear();
            this.playSprite.graphics.beginFill(0xFFFFFF);
            this.playSprite.graphics.drawRect(0, 0, this.canvasWidth, this.canvasHeight);
            this.playSprite.graphics.endFill();
            this.playBitmap = new Bitmap(new BitmapData(this.canvasWidth, this.canvasHeight, true, 0xFFFFFF));
            this.playSprite.addChild(this.playBitmap);
        }
        this.saveForm.x = stage.stageWidth / 2 - this.saveForm.width / 2;
        this.saveForm.y = stage.stageHeight / 2 - this.saveForm.height / 2;
        this.fadeSprite.graphics.clear();
        this.fadeSprite.graphics.beginFill(13421772, 0.9);
        this.fadeSprite.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
        this.fadeSprite.graphics.endFill();
        this.saveComplete.x = stage.stageWidth / 2 - this.saveComplete.width / 2;
        this.saveComplete.y = stage.stageHeight / 2 - this.saveComplete.height / 2;
    }
}

