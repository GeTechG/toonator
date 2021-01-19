package toonator;

import flash.display.SimpleButton;
import flash.text.TextField;

class CancelButton extends SimpleButton
{
    
    
    public var caption : TextField;
    
    public function new()
    {
        super();
    }
    
    public function setCaption(param1 : String) : Void
    {
        this.caption.text = param1;
    }
}

