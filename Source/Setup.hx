package;

import openfl.Assets;
import openfl.display.MovieClip;
import toonator.*;

class Setup extends MovieClip
{
	public var M:Main;

	public function new()
	{
		super();

		Assets.loadLibrary ('draw31').onComplete ( (_) -> {
			trace ('Editor loaded');
			
			M = new Main();
			addChild(M);
		});
		
	}
}
