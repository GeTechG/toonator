package fivecolor;

import flash.events.Event;

class SlideEvent extends Event
{
    
    
    public var pos : Int;
    
    public function new(param1 : String, param2 : Int)
    {
        super(param1);
        this.pos = param2;
    }
}

