package;

import flixel.FlxState;
import sys.io.File;

class PlayState extends FlxState
{
	override public function create():Void
	{
		//var chaine = 'FUNCTION HELLO(NAME) DO\n PRINT("HELLO WORLD")\nEND';
		var chaine = File.getContent("assets/code/Test.txt");
		var regex = ~/FUNCTION\s*([A-Z]+)\(([A-Z, ]*)\)\s*DO/;
		//if (regex.match(chaine))
		//{
			//trace(regex.matched(1));
			//trace(regex.matched(2));
		//}
		
		var lexer = new Lexer(chaine);
		lexer.lex();
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
