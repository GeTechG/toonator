package mx.core;

import flash.accessibility.AccessibilityProperties;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.IBitmapDrawable;
import flash.display.LoaderInfo;
import flash.display.Stage;
import flash.events.IEventDispatcher;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Transform;

interface IFlexDisplayObject extends IBitmapDrawable extends IEventDispatcher
{
    
    
    
    var root(get, never) : DisplayObject;    
    
    var stage(get, never) : Stage;    
    
    
    
    var name(get, set) : String;    
    
    var parent(get, never) : DisplayObjectContainer;    
    
    
    
    var mask(get, set) : DisplayObject;    
    
    
    
    var visible(get, set) : Bool;    
    
    
    
    var x(get, set) : Float;    
    
    
    
    var y(get, set) : Float;    
    
    
    
    var scaleX(get, set) : Float;    
    
    
    
    var scaleY(get, set) : Float;    
    
    var mouseX(get, never) : Float;    
    
    var mouseY(get, never) : Float;    
    
    
    
    var rotation(get, set) : Float;    
    
    
    
    var alpha(get, set) : Float;    
    
    
    
    var width(get, set) : Float;    
    
    
    
    var height(get, set) : Float;    
    
    
    
    var cacheAsBitmap(get, set) : Bool;    
    
    
    
    var opaqueBackground(get, set) : Dynamic;    
    
    
    
    var scrollRect(get, set) : Rectangle;    
    
    
    
    var filters(get, set) : Array<Dynamic>;    
    
    
    
    var blendMode(get, set) : String;    
    
    
    
    var transform(get, set) : Transform;    
    
    
    
    var scale9Grid(get, set) : Rectangle;    
    
    var loaderInfo(get, never) : LoaderInfo;    
    
    
    
    var accessibilityProperties(get, set) : AccessibilityProperties;    
    
    var measuredHeight(get, never) : Float;    
    
    var measuredWidth(get, never) : Float;

    
    function globalToLocal(param1 : Point) : Point
    ;
    
    function localToGlobal(param1 : Point) : Point
    ;
    
    function getBounds(param1 : DisplayObject) : Rectangle
    ;
    
    function getRect(param1 : DisplayObject) : Rectangle
    ;
    
    function hitTestObject(param1 : DisplayObject) : Bool
    ;
    
    function hitTestPoint(param1 : Float, param2 : Float, param3 : Bool = false) : Bool
    ;
    
    function move(param1 : Float, param2 : Float) : Void
    ;
    
    function setActualSize(param1 : Float, param2 : Float) : Void
    ;
}

