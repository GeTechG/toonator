package toonator;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;

class SaveComplete extends SaveCompleteSwf
{
        
    public function new()
    {
        super();
        this.setLink("http://multator.ru/");
    }
    
    public function setLink(param1 : String) : Void
    {
        this.lblLink.htmlText = "<u><a href=\"" + param1 + "\" target=\"_blank\">" + param1 + "</a></u>";
    }
}

