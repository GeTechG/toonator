package mx.core;


interface IRepeaterClient
{
    
    
    
    
    
    var instanceIndices(get, set) : Array<Dynamic>;    
    
    var isDocument(get, never) : Bool;    
    
    
    
    var repeaterIndices(get, set) : Array<Dynamic>;    
    
    
    
    var repeaters(get, set) : Array<Dynamic>;

    
    function initializeRepeaterArrays(param1 : IRepeaterClient) : Void
    ;
}

