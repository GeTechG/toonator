package com.motiondraw;


class LineGeneralization
{
    
    
    public function new()
    {
    }
    
    public function smoothMcMaster(param1 : Array<Dynamic>) : Array<Dynamic>
    {
        var _loc4_ : Float = Math.NaN;
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Float = Math.NaN;
        var _loc2_ : Array<Dynamic> = [];
        var _loc3_ : Float = param1.length;
        if (_loc3_ < 5)
        {
            return param1;
        }
        var _loc7_ : Float = _loc3_;
        while (_loc7_ >= 0)
        {
            if (_loc7_ == _loc3_ - 1 || _loc7_ == _loc3_ - 2 || _loc7_ == 1 || _loc7_ == 0)
            {
                Reflect.setField(_loc2_, Std.string(_loc7_), {
                    x : Reflect.field(param1, Std.string(_loc7_)).x,
                    y : Reflect.field(param1, Std.string(_loc7_)).y
                });
            }
            else
            {
                _loc4_ = 5;
                _loc5_ = 0;
                _loc6_ = 0;
                while (_loc4_ >= 0)
                {
                    _loc5_ = _loc5_ + param1[Std.int(_loc7_ + 2 - _loc4_)].x;
                    _loc6_ = _loc6_ + param1[Std.int(_loc7_ + 2 - _loc4_)].y;
                    _loc4_--;
                }
                _loc5_ = _loc5_ / 5;
                _loc6_ = _loc6_ / 5;

                Reflect.setField(_loc2_, Std.string(_loc7_), {
                    x : (Reflect.field(param1, Std.string(_loc7_)).x + _loc5_) / 2,
                    y : (Reflect.field(param1, Std.string(_loc7_)).y + _loc6_) / 2
                });
                Reflect.setField(_loc2_, Std.string(_loc7_), {
                    x : (Reflect.field(param1, Std.string(_loc7_)).x + _loc5_) / 2,
                    y : (Reflect.field(param1, Std.string(_loc7_)).y + _loc6_) / 2
                });
            }

            _loc7_--;
        }
        return _loc2_;
    }
    
    public function simplifyLang(param1 : Float, param2 : Float, param3 : Array<Dynamic>) : Array<Dynamic>
    {
        var _loc5_ : Float = Math.NaN;
        var _loc6_ : Float = Math.NaN;
        var _loc7_ : Float = Math.NaN;
        if (param1 <= 1 || param3.length < 3)
        {
            return param3;
        }
        var _loc4_ : Array<Dynamic> = new Array<Dynamic>();
        _loc6_ = param3.length;
        if (param1 > _loc6_ - 1)
        {
            param1 = _loc6_ - 1;
        }
        _loc4_[0] = {
                    x : param3[0].x,
                    y : param3[0].y
                };
        _loc7_ = 1;
        var _loc8_ : Float = 0;
        while (_loc8_ < _loc6_)
        {
            if (_loc8_ + param1 > _loc6_)
            {
                param1 = _loc6_ - _loc8_ - 1;
            }
            _loc5_ = this.recursiveToleranceBar(param3, _loc8_, param1, param2);
            if (_loc5_ > 0 && param3[Std.int(_loc8_ + _loc5_)] != null)
            {
                Reflect.setField(_loc4_, Std.string(_loc7_), {
                    x : param3[Std.int(_loc8_ + _loc5_)].x,
                    y : param3[Std.int(_loc8_ + _loc5_)].y
                });
                _loc8_ = _loc8_ + (_loc5_ - 1);
                _loc7_++;
            }
            _loc8_++;
        }
        _loc4_[Std.int(_loc7_ - 1)] = {
                    x : param3[Std.int(_loc6_ - 1)].x,
                    y : param3[Std.int(_loc6_ - 1)].y
                };
        return _loc4_;
    }
    
    private function recursiveToleranceBar(param1 : Array<Dynamic>, param2 : Float, param3 : Float, param4 : Float) : Float
    {
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Float = Math.NaN;
        var _loc11_ : Float = Math.NaN;
        var _loc12_ : Float = Math.NaN;
        var _loc14_ : Float = Math.NaN;
        var _loc5_ : Float = param3;
        _loc6_ = Reflect.field(param1, Std.string(param2));
        if (param1[Std.int(param2 + _loc5_)] == null)
        {
            return 0;
        }
        _loc8_ = {
                    x : param1[Std.int(param2 + _loc5_)].x - _loc6_.x,
                    y : param1[Std.int(param2 + _loc5_)].y - _loc6_.y
                };
        var _loc13_ : Float = 1;
        while (_loc13_ <= _loc5_)
        {
            _loc7_ = param1[Std.int(param2 + _loc13_)];
            _loc9_ = {
                        x : _loc7_.x - _loc6_.x,
                        y : _loc7_.y - _loc6_.y
                    };
            _loc10_ = Math.acos((_loc8_.x * _loc9_.x + _loc8_.y * _loc9_.y) / (Math.sqrt(_loc8_.y * _loc8_.y + _loc8_.x * _loc8_.x) * Math.sqrt(_loc9_.y * _loc9_.y + _loc9_.x * _loc9_.x)));
            if (Math.isNaN(_loc10_))
            {
                _loc10_ = 0;
            }
            _loc11_ = _loc6_.x - _loc7_.x;
            _loc12_ = _loc6_.y - _loc7_.y;
            _loc14_ = Math.sqrt(_loc11_ * _loc11_ + _loc12_ * _loc12_);
            if (Math.sin(_loc10_) * _loc14_ >= param4)
            {
                _loc5_--;
                if (_loc5_ > 0)
                {
                    return this.recursiveToleranceBar(param1, param2, _loc5_, param4);
                }
                return 0;
            }
            _loc13_++;
        }
        return _loc5_;
    }
    
    private function recursiveToleranceBar_old(param1 : Array<Dynamic>, param2 : Float, param3 : Float, param4 : Float) : Float
    {
        var _loc6_ : Dynamic = null;
        var _loc7_ : Dynamic = null;
        var _loc8_ : Dynamic = null;
        var _loc9_ : Dynamic = null;
        var _loc10_ : Float = Math.NaN;
        var _loc11_ : Float = Math.NaN;
        var _loc12_ : Float = Math.NaN;
        var _loc13_ : Float = Math.NaN;
        var _loc15_ : Float = Math.NaN;
        var _loc5_ : Float = param3;
        _loc6_ = Reflect.field(param1, Std.string(param2));
        _loc8_ = {
                    x : param1[Std.int(param2 + _loc5_)].x - _loc6_.x,
                    y : param1[Std.int(param2 + _loc5_)].y - _loc6_.y
                };
        var _loc14_ : Float = 1;
        while (_loc14_ <= _loc5_)
        {
            _loc7_ = param1[Std.int(param2 + _loc14_)];
            _loc9_ = {
                        x : _loc7_.x - _loc6_.x,
                        y : _loc7_.y - _loc6_.y
                    };
            _loc10_ = Math.acos((_loc8_.x * _loc9_.x + _loc8_.y * _loc9_.y) / (Math.sqrt(_loc8_.y * _loc8_.y + _loc8_.x * _loc8_.x) * Math.sqrt(_loc9_.y * _loc9_.y + _loc9_.x * _loc9_.x)));
            if (Math.isNaN(_loc10_))
            {
                _loc10_ = 0;
            }
            _loc11_ = _loc6_.x - _loc7_.x;
            _loc12_ = _loc6_.y - _loc7_.y;
            _loc15_ = Math.sqrt(_loc11_ * _loc11_ + _loc12_ * _loc12_);
            if (Math.sin(_loc10_) * _loc15_ >= param4)
            {
                _loc5_--;
                if (_loc5_ > 0)
                {
                    _loc13_ = this.recursiveToleranceBar(param1, param2, _loc5_, param4);
                    break;
                }
                _loc13_ = 0;
                break;
            }
            _loc14_++;
        }
        return _loc13_;
    }
}

