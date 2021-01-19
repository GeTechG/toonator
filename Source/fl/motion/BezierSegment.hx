package fl.motion;

import flash.geom.Point;

class BezierSegment
{
    
    
    public var a : Point;
    
    public var c : Point;
    
    public var b : Point;
    
    public var d : Point;
    
    public function new(param1 : Point, param2 : Point, param3 : Point, param4 : Point)
    {
        this.a = param1;
        this.b = param2;
        this.c = param3;
        this.d = param4;
    }
    
    public static function getCubicCoefficients(param1 : Float, param2 : Float, param3 : Float, param4 : Float) : Array<Dynamic>
    {
        return [-param1 + 3 * param2 - 3 * param3 + param4, 3 * param1 - 6 * param2 + 3 * param3, -3 * param1 + 3 * param2, param1];
    }
    
    public static function getSingleValue(param1 : Float, param2 : Float = 0, param3 : Float = 0, param4 : Float = 0, param5 : Float = 0) : Float
    {
        return (param1 * param1 * (param5 - param2) + 3 * (1 - param1) * (param1 * (param4 - param2) + (1 - param1) * (param3 - param2))) * param1 + param2;
    }
    
    public static function getCubicRoots(param1 : Float = 0, param2 : Float = 0, param3 : Float = 0, param4 : Float = 0) : Array<Dynamic>
    {
        var _loc9_ : Float = Math.NaN;
        var _loc10_ : Float = Math.NaN;
        var _loc11_ : Float = Math.NaN;
        var _loc12_ : Float = Math.NaN;
        var _loc13_ : Float = Math.NaN;
        var _loc14_ : Float = Math.NaN;
        var _loc15_ : Int = 0;
        var _loc16_ : Float = Math.NaN;
        if (param1 == 0)
        {
            return BezierSegment.getQuadraticRoots(param2, param3, param4);
        }
        if (param1 != 1)
        {
            param2 = param2 / param1;
            param3 = param3 / param1;
            param4 = param4 / param1;
        }
        var _loc5_ : Float = (param2 * param2 - 3 * param3) / 9;
        var _loc6_ : Float = _loc5_ * _loc5_ * _loc5_;
        var _loc7_ : Float = (2 * param2 * param2 * param2 - 9 * param2 * param3 + 27 * param4) / 54;
        var _loc8_ : Float = _loc6_ - _loc7_ * _loc7_;
        if (_loc8_ >= 0)
        {
            if (_loc5_ == 0)
            {
                return [0];
            }
            _loc9_ = Math.acos(_loc7_ / Math.sqrt(_loc6_));
            _loc10_ = Math.sqrt(_loc5_);
            _loc11_ = -2 * _loc10_ * Math.cos(_loc9_ / 3) - param2 / 3;
            _loc12_ = -2 * _loc10_ * Math.cos((_loc9_ + 2 * Math.PI) / 3) - param2 / 3;
            _loc13_ = -2 * _loc10_ * Math.cos((_loc9_ + 4 * Math.PI) / 3) - param2 / 3;
            return [_loc11_, _loc12_, _loc13_];
        }
        _loc14_ = Math.pow(Math.sqrt(-_loc8_) + Math.abs(_loc7_), 1 / 3);
        _loc15_ = (_loc7_ > 0) ? 1 : (_loc7_ < 0) ? -1 : 0;
        _loc16_ = -_loc15_ * (_loc14_ + _loc5_ / _loc14_) - param2 / 3;
        return [_loc16_];
    }
    
    public static function getQuadraticRoots(param1 : Float, param2 : Float, param3 : Float) : Array<Dynamic>
    {
        var _loc7_ : Float = Math.NaN;
        var _loc4_ : Array<Dynamic> = [];
        if (param1 == 0)
        {
            if (param2 == 0)
            {
                return [];
            }
            _loc4_[0] = -param3 / param2;
            return _loc4_;
        }
        var _loc5_ : Float = param2 * param2 - 4 * param1 * param3;
        var _loc6_ : Int = (_loc5_ > 0) ? 1 : (_loc5_ < 0) ? -1 : 0;
        if (_loc6_ < 0)
        {
            return [];
        }
        if (_loc6_ == 0)
        {
            _loc4_[0] = -param2 / (2 * param1);
        }
        else
        {
            _loc4_[0] = _loc4_[1] = -param2 / (2 * param1);
            _loc7_ = Math.sqrt(_loc5_) / (2 * param1);
            _loc4_[0] = _loc4_[0] - _loc7_;
            _loc4_[1] = _loc4_[1] + _loc7_;
        }
        return _loc4_;
    }
    
    public function getValue(param1 : Float) : Point
    {
        var _loc2_ : Float = this.a.x;
        var _loc3_ : Float = (param1 * param1 * (this.d.x - _loc2_) + 3 * (1 - param1) * (param1 * (this.c.x - _loc2_) + (1 - param1) * (this.b.x - _loc2_))) * param1 + _loc2_;
        var _loc4_ : Float = this.a.y;
        var _loc5_ : Float = (param1 * param1 * (this.d.y - _loc4_) + 3 * (1 - param1) * (param1 * (this.c.y - _loc4_) + (1 - param1) * (this.b.y - _loc4_))) * param1 + _loc4_;
        return new Point(_loc3_, _loc5_);
    }
    
    public function getYForX(param1 : Float, param2 : Array<Dynamic> = null) : Float
    {
        var _loc6_ : Float = Math.NaN;
        if (this.a.x < this.d.x)
        {
            if (param1 <= this.a.x + 1.0e-16)
            {
                return this.a.y;
            }
            if (param1 >= this.d.x - 1.0e-16)
            {
                return this.d.y;
            }
        }
        else
        {
            if (param1 >= this.a.x + 1.0e-16)
            {
                return this.a.y;
            }
            if (param1 <= this.d.x - 1.0e-16)
            {
                return this.d.y;
            }
        }
        if (param2 == null)
        {
            param2 = getCubicCoefficients(this.a.x, this.b.x, this.c.x, this.d.x);
        }
        var _loc3_ : Array<Dynamic> = getCubicRoots(param2[0], param2[1], param2[2], param2[3] - param1);
        var _loc4_ : Float = Math.NaN;
        if (_loc3_.length == 0)
        {
            _loc4_ = 0;
        }
        else if (_loc3_.length == 1)
        {
            _loc4_ = _loc3_[0];
        }
        else
        {
            for (_loc6_ in _loc3_)
            {
                if (0 <= _loc6_ && _loc6_ <= 1)
                {
                    _loc4_ = _loc6_;
                    break;
                }
            }
        }
        if (Math.isNaN(_loc4_))
        {
            return Math.NaN;
        }
        var _loc5_ : Float = getSingleValue(_loc4_, this.a.y, this.b.y, this.c.y, this.d.y);
        return _loc5_;
    }
}

