package;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create():Void
	{
		var chaine = '(println "hello world")';
		var tokens = Lexer.lex(chaine);
		for (i in tokens) 
		{
			trace(i);
		}
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
