package mx.utils;

import flash.errors.SecurityError;
import flash.display.DisplayObject;
import mx.core.IRepeaterClient;
import mx.core.MxInternal;

class NameUtil
{
    
    private static inline var VERSION : String = "4.6.0.23201";
    
    private static var counter : Int = 0;
    
    
    public function new()
    {
        super();
    }
    
    public static function createUniqueName(param1 : Dynamic) : String
    {
        if (param1 == null)
        {
            return null;
        }
        var _loc2_ : Dynamic = Type.getClassName(param1);
        var _loc3_ : Int = _loc2_.indexOf("::");
        if (_loc3_ != -1)
        {
            _loc2_ = _loc2_.substr(_loc3_ + 2);
        }
        var _loc4_ : Int = _loc2_.charCodeAt(_loc2_.length - 1);
        if (_loc4_ >= 48 && _loc4_ <= 57)
        {
            _loc2_ = _loc2_ + "_";
        }
        return _loc2_ + counter++;
    }
    
    public static function displayObjectToString(param1 : DisplayObject) : String
    {
        var _loc2_ : String = null;
        var _loc3_ : DisplayObject = null;
        var _loc4_ : String = null;
        var _loc5_ : Array<Dynamic> = null;
        try
        {
            _loc3_ = param1;
            while (_loc3_ != null)
            {
                if (_loc3_.parent && _loc3_.stage && _loc3_.parent == _loc3_.stage)
                {
                    break;
                }
                _loc4_ = (Lambda.has(_loc3_, "id") && Reflect.field(_loc3_, "id") != null) ? Reflect.field(_loc3_, "id") : _loc3_.name;
                if (Std.is(_loc3_, IRepeaterClient))
                {
                    _loc5_ = cast((_loc3_), IRepeaterClient).instanceIndices;
                    if (_loc5_ != null)
                    {
                        _loc4_ = _loc4_ + ("[" + _loc5_.join("][") + "]");
                    }
                }
                _loc2_ = (_loc2_ == null) ? _loc4_ : _loc4_ + "." + _loc2_;
                _loc3_ = _loc3_.parent;
            }
        }
        catch (e : SecurityError)
        {
        }
        return _loc2_;
    }
    
    public static function getUnqualifiedClassName(param1 : Dynamic) : String
    {
        var _loc2_ : String = null;
        if (Std.is(param1, String))
        {
            _loc2_ = Std.string(param1);
        }
        else
        {
            _loc2_ = Type.getClassName(param1);
        }
        var _loc3_ : Int = _loc2_.indexOf("::");
        if (_loc3_ != -1)
        {
            _loc2_ = _loc2_.substr(_loc3_ + 2);
        }
        return _loc2_;
    }
}

