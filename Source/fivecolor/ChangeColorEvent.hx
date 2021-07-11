package fivecolor;

import flash.events.Event;

class ChangeColorEvent extends Event
{
    public var selectedColor : Int;
    
    public function new(param1 : String, param2 : Int)
    {
        super(param1);
        this.selectedColor = param2;
    }
}

