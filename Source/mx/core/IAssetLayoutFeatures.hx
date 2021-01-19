package mx.core;

import flash.geom.Matrix;
import flash.geom.Matrix3D;

interface IAssetLayoutFeatures
{
    
    
    
    
    
    var layoutX(get, set) : Float;    
    
    
    
    var layoutY(get, set) : Float;    
    
    
    
    var layoutZ(get, set) : Float;    
    
    
    
    var layoutWidth(get, set) : Float;    
    
    
    
    var transformX(get, set) : Float;    
    
    
    
    var transformY(get, set) : Float;    
    
    
    
    var transformZ(get, set) : Float;    
    
    
    
    var layoutRotationX(get, set) : Float;    
    
    
    
    var layoutRotationY(get, set) : Float;    
    
    
    
    var layoutRotationZ(get, set) : Float;    
    
    
    
    var layoutScaleX(get, set) : Float;    
    
    
    
    var layoutScaleY(get, set) : Float;    
    
    
    
    var layoutScaleZ(get, set) : Float;    
    
    
    
    var layoutMatrix(get, set) : Matrix;    
    
    
    
    var layoutMatrix3D(get, set) : Matrix3D;    
    
    var is3D(get, never) : Bool;    
    
    var layoutIs3D(get, never) : Bool;    
    
    
    
    var mirror(get, set) : Bool;    
    
    
    
    var stretchX(get, set) : Float;    
    
    
    
    var stretchY(get, set) : Float;    
    
    var computedMatrix(get, never) : Matrix;    
    
    var computedMatrix3D(get, never) : Matrix3D;

}

