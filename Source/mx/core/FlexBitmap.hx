package mx.core;

import flash.errors.Error;
import flash.display.Bitmap;
import flash.display.BitmapData;
import mx.utils.NameUtil;

class FlexBitmap extends Bitmap
{
    
    private static inline var VERSION : String = "4.6.0.23201";
    
    
    public function new(param1 : BitmapData = null, param2 : String = "auto", param3 : Bool = false)
    {
        super(param1, param2, param3);
        try
        {
            name = NameUtil.createUniqueName(this);
            return;
        }
        catch (e : Error)
        {
            return;
        }
    }
    
    override public function toString() : String
    {
        return NameUtil.displayObjectToString(this);
    }
}

