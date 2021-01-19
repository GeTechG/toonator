package toonator;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;

class SaveForm extends SaveFormSwf
{
    public var checkDraft:Checkbox;
    public function new(lang:String)
    {
        super();

        checkDraft = new Checkbox(lang);
        chkDraft.addChild(checkDraft);

        
    }
}

