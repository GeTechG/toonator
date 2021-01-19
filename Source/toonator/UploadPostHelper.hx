package toonator;

import flash.utils.ByteArray;
import flash.utils.Endian;

class UploadPostHelper
{
    
    private static var _boundary : String = "";
    
    
    public function new()
    {
        
    }
    
    public static function getBoundary() : String
    {
        var _loc1_ : Int = 0;
        if (_boundary.length == 0)
        {
            _loc1_ = 0;
            while (_loc1_ < 32)
            {
                _boundary = _boundary + String.fromCharCode(as3hx.Compat.parseInt(97 + Math.random() * 25));
                _loc1_++;
            }
        }
        return _boundary;
    }
    
    public static function getPostData(param1 : String, param2 : ByteArray, param3 : Dynamic = null) : ByteArray
    {
        var _loc4_ : Int = 0;
        var _loc5_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc6_ : ByteArray = new ByteArray();
        _loc6_.endian = Endian.BIG_ENDIAN;
        if (param3 == null)
        {
            param3 = {};
        }
        param3.Filename = param1;
        for (_loc7_ in Reflect.fields(param3))
        {
            _loc6_ = BOUNDARY(_loc6_);
            _loc6_ = LINEBREAK(_loc6_);
            _loc5_ = "Content-Disposition: form-data; name=\"" + _loc7_ + "\"";
            _loc4_ = 0;
            while (_loc4_ < _loc5_.length)
            {
                _loc6_.writeByte(_loc5_.charCodeAt(_loc4_));
                _loc4_++;
            }
            _loc6_ = LINEBREAK(_loc6_);
            _loc6_ = LINEBREAK(_loc6_);
            _loc6_.writeUTFBytes(Reflect.field(param3, Std.string(_loc7_)));
            _loc6_ = LINEBREAK(_loc6_);
        }
        _loc6_ = BOUNDARY(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc5_ = "Content-Disposition: form-data; name=\"file\"; filename=\"f_";
        _loc4_ = 0;
        while (_loc4_ < _loc5_.length)
        {
            _loc6_.writeByte(_loc5_.charCodeAt(_loc4_));
            _loc4_++;
        }
        _loc6_.writeUTFBytes(param1);
        _loc6_ = QUOTATIONMARK(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc5_ = "Content-Type: application/octet-stream";
        _loc4_ = 0;
        while (_loc4_ < _loc5_.length)
        {
            _loc6_.writeByte(_loc5_.charCodeAt(_loc4_));
            _loc4_++;
        }
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_.writeBytes(param2, 0, param2.length);
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_ = BOUNDARY(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc5_ = "Content-Disposition: form-data; name=\"Upload\"";
        _loc4_ = 0;
        while (_loc4_ < _loc5_.length)
        {
            _loc6_.writeByte(_loc5_.charCodeAt(_loc4_));
            _loc4_++;
        }
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_ = LINEBREAK(_loc6_);
        _loc5_ = "Submit Query";
        _loc4_ = 0;
        while (_loc4_ < _loc5_.length)
        {
            _loc6_.writeByte(_loc5_.charCodeAt(_loc4_));
            _loc4_++;
        }
        _loc6_ = LINEBREAK(_loc6_);
        _loc6_ = BOUNDARY(_loc6_);
        _loc6_ = DOUBLEDASH(_loc6_);
        return _loc6_;
    }
    
    private static function BOUNDARY(param1 : ByteArray) : ByteArray
    {
        var _loc2_ : Int = UploadPostHelper.getBoundary().length;
        param1 = DOUBLEDASH(param1);
        var _loc3_ : Int = 0;
        while (_loc3_ < _loc2_)
        {
            param1.writeByte(_boundary.charCodeAt(_loc3_));
            _loc3_++;
        }
        return param1;
    }
    
    private static function LINEBREAK(param1 : ByteArray) : ByteArray
    {
        param1.writeShort(3338);
        return param1;
    }
    
    private static function QUOTATIONMARK(param1 : ByteArray) : ByteArray
    {
        param1.writeByte(34);
        return param1;
    }
    
    private static function DOUBLEDASH(param1 : ByteArray) : ByteArray
    {
        param1.writeShort(11565);
        return param1;
    }
}

