package fivecolor;

import flash.events.Event;

class ChangeFrameEvent extends Event
{
    
    
    public var preFrame : Int;
    
    public var force : Bool;
    
    public var curFrame : Int;
    
    public function new(param1 : String, param2 : Int, param3 : Int, param4 : Bool = false)
    {
        super(param1);
        this.preFrame = param2;
        this.curFrame = param3;
        this.force = param4;
    }
}

