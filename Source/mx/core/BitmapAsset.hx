package mx.core;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Point;
import flash.system.ApplicationDomain;

class BitmapAsset extends FlexBitmap implements IFlexAsset implements IFlexDisplayObject implements ILayoutDirectionElement
{
    public var layoutDirection(get, set) : String;
    public var measuredHeight(get, never) : Float;
    public var measuredWidth(get, never) : Float;

    
    private static inline var VERSION : String = "4.6.0.23201";
    
    private static var FlexVersionClass : Class<Dynamic>;
    
    private static var MatrixUtilClass : Class<Dynamic>;
    
    
    private var layoutFeaturesClass : Class<Dynamic>;
    
    private var layoutFeatures : IAssetLayoutFeatures;
    
    private var _height : Float;
    
    private var _layoutDirection : String = "ltr";
    
    public function new(param1 : BitmapData = null, param2 : String = "auto", param3 : Bool = false)
    {
        var _loc4_ : ApplicationDomain = null;
        super(param1, param2, param3);
        if (FlexVersionClass == null)
        {
            _loc4_ = ApplicationDomain.currentDomain;
            if (_loc4_.hasDefinition("mx.core::FlexVersion"))
            {
                FlexVersionClass = cast((_loc4_.getDefinition("mx.core::FlexVersion")), Class);
            }
        }
        if (FlexVersionClass != null && Reflect.field(FlexVersionClass, "compatibilityVersion") >= Reflect.field(FlexVersionClass, "VERSION_4_0"))
        {
            this.addEventListener(Event.ADDED, this.addedHandler);
        }
    }
    
    override private function get_x() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.x) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutX);
    }
    
    override private function set_x(param1 : Float) : Float
    {
        if (this.x == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.x = param1;
        }
        else
        {
            this.layoutFeatures.layoutX = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_y() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.y) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutY);
    }
    
    override private function set_y(param1 : Float) : Float
    {
        if (this.y == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.y = param1;
        }
        else
        {
            this.layoutFeatures.layoutY = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_z() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.z) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutZ);
    }
    
    override private function set_z(param1 : Float) : Float
    {
        if (this.z == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.z = param1;
        }
        else
        {
            this.layoutFeatures.layoutZ = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_width() : Float
    {
        var _loc1_ : Point = null;
        if (this.layoutFeatures == null)
        {
            return super.width;
        }
        if (MatrixUtilClass != null)
        {
            _loc1_ = Reflect.field(MatrixUtilClass, "transformSize")(this.layoutFeatures.layoutWidth, this._height, transform.matrix);
        }
        return !!(_loc1_ != null) ? as3hx.Compat.parseFloat(_loc1_.x) : as3hx.Compat.parseFloat(super.width);
    }
    
    override private function set_width(param1 : Float) : Float
    {
        if (this.width == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.width = param1;
        }
        else
        {
            this.layoutFeatures.layoutWidth = param1;
            this.layoutFeatures.layoutScaleX = (this.measuredWidth != 0) ? as3hx.Compat.parseFloat(param1 / this.measuredWidth) : 0;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_height() : Float
    {
        var _loc1_ : Point = null;
        if (this.layoutFeatures == null)
        {
            return super.height;
        }
        if (MatrixUtilClass != null)
        {
            _loc1_ = Reflect.field(MatrixUtilClass, "transformSize")(this.layoutFeatures.layoutWidth, this._height, transform.matrix);
        }
        return !!(_loc1_ != null) ? as3hx.Compat.parseFloat(_loc1_.y) : as3hx.Compat.parseFloat(super.height);
    }
    
    override private function set_height(param1 : Float) : Float
    {
        if (this.height == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.height = param1;
        }
        else
        {
            this._height = param1;
            this.layoutFeatures.layoutScaleY = (this.measuredHeight != 0) ? as3hx.Compat.parseFloat(param1 / this.measuredHeight) : 0;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_rotationX() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.rotationX) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutRotationX);
    }
    
    override private function set_rotationX(param1 : Float) : Float
    {
        if (this.rotationX == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.rotationX = param1;
        }
        else
        {
            this.layoutFeatures.layoutRotationX = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_rotationY() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.rotationY) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutRotationY);
    }
    
    override private function set_rotationY(param1 : Float) : Float
    {
        if (this.rotationY == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.rotationY = param1;
        }
        else
        {
            this.layoutFeatures.layoutRotationY = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_rotationZ() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.rotationZ) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutRotationZ);
    }
    
    override private function set_rotationZ(param1 : Float) : Float
    {
        if (this.rotationZ == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.rotationZ = param1;
        }
        else
        {
            this.layoutFeatures.layoutRotationZ = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_rotation() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.rotation) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutRotationZ);
    }
    
    override private function set_rotation(param1 : Float) : Float
    {
        if (this.rotation == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.rotation = param1;
        }
        else
        {
            this.layoutFeatures.layoutRotationZ = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_scaleX() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.scaleX) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutScaleX);
    }
    
    override private function set_scaleX(param1 : Float) : Float
    {
        if (this.scaleX == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.scaleX = param1;
        }
        else
        {
            this.layoutFeatures.layoutScaleX = param1;
            this.layoutFeatures.layoutWidth = Math.abs(param1) * this.measuredWidth;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_scaleY() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.scaleY) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutScaleY);
    }
    
    override private function set_scaleY(param1 : Float) : Float
    {
        if (this.scaleY == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.scaleY = param1;
        }
        else
        {
            this.layoutFeatures.layoutScaleY = param1;
            this._height = Math.abs(param1) * this.measuredHeight;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    override private function get_scaleZ() : Float
    {
        return (this.layoutFeatures == null) ? as3hx.Compat.parseFloat(super.scaleZ) : as3hx.Compat.parseFloat(this.layoutFeatures.layoutScaleZ);
    }
    
    override private function set_scaleZ(param1 : Float) : Float
    {
        if (this.scaleZ == param1)
        {
            return param1;
        }
        if (this.layoutFeatures == null)
        {
            super.scaleZ = param1;
        }
        else
        {
            this.layoutFeatures.layoutScaleZ = param1;
            this.validateTransformMatrix();
        }
        return param1;
    }
    
    private function get_layoutDirection() : String
    {
        return this._layoutDirection;
    }
    
    private function set_layoutDirection(param1 : String) : String
    {
        if (param1 == this._layoutDirection)
        {
            return param1;
        }
        this._layoutDirection = param1;
        this.invalidateLayoutDirection();
        return param1;
    }
    
    private function get_measuredHeight() : Float
    {
        if (bitmapData)
        {
            return bitmapData.height;
        }
        return 0;
    }
    
    private function get_measuredWidth() : Float
    {
        if (bitmapData)
        {
            return bitmapData.width;
        }
        return 0;
    }
    
    public function invalidateLayoutDirection() : Void
    {
        var _loc2_ : Bool = false;
        var _loc1_ : DisplayObjectContainer = parent;
        while (_loc1_)
        {
            if (Std.is(_loc1_, ILayoutDirectionElement))
            {
                _loc2_ = this._layoutDirection != null && cast((_loc1_), ILayoutDirectionElement).layoutDirection != null && this._layoutDirection != cast((_loc1_), ILayoutDirectionElement).layoutDirection;
                if (_loc2_ && this.layoutFeatures == null)
                {
                    this.initAdvancedLayoutFeatures();
                    if (this.layoutFeatures != null)
                    {
                        this.layoutFeatures.mirror = _loc2_;
                        this.validateTransformMatrix();
                    }
                }
                else if (!_loc2_ && this.layoutFeatures)
                {
                    this.layoutFeatures.mirror = _loc2_;
                    this.validateTransformMatrix();
                    this.layoutFeatures = null;
                }
                break;
            }
            _loc1_ = _loc1_.parent;
        }
    }
    
    public function move(param1 : Float, param2 : Float) : Void
    {
        this.x = param1;
        this.y = param2;
    }
    
    public function setActualSize(param1 : Float, param2 : Float) : Void
    {
        this.width = param1;
        this.height = param2;
    }
    
    private function addedHandler(param1 : Event) : Void
    {
        this.invalidateLayoutDirection();
    }
    
    private function initAdvancedLayoutFeatures() : Void
    {
        var _loc1_ : ApplicationDomain = null;
        var _loc2_ : IAssetLayoutFeatures = null;
        if (this.layoutFeaturesClass == null)
        {
            _loc1_ = ApplicationDomain.currentDomain;
            if (_loc1_.hasDefinition("mx.core::AdvancedLayoutFeatures"))
            {
                this.layoutFeaturesClass = cast((_loc1_.getDefinition("mx.core::AdvancedLayoutFeatures")), Class);
            }
            if (MatrixUtilClass == null)
            {
                if (_loc1_.hasDefinition("mx.utils::MatrixUtil"))
                {
                    MatrixUtilClass = cast((_loc1_.getDefinition("mx.utils::MatrixUtil")), Class);
                }
            }
        }
        if (this.layoutFeaturesClass != null)
        {
            _loc2_ = new this.LayoutFeaturesClass();
            _loc2_.layoutScaleX = this.scaleX;
            _loc2_.layoutScaleY = this.scaleY;
            _loc2_.layoutScaleZ = this.scaleZ;
            _loc2_.layoutRotationX = this.rotationX;
            _loc2_.layoutRotationY = this.rotationY;
            _loc2_.layoutRotationZ = this.rotation;
            _loc2_.layoutX = this.x;
            _loc2_.layoutY = this.y;
            _loc2_.layoutZ = this.z;
            _loc2_.layoutWidth = this.width;
            this._height = this.height;
            this.layoutFeatures = _loc2_;
        }
    }
    
    private function validateTransformMatrix() : Void
    {
        if (this.layoutFeatures != null)
        {
            if (this.layoutFeatures.is3D)
            {
                super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
            }
            else
            {
                super.transform.matrix = this.layoutFeatures.computedMatrix;
            }
        }
    }
}

