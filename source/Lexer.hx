package;
using StringTools;

/**
 * ...
 * @author 
 */
enum Token 
{
	Integ(val:Int);
	Decimal(val:Float);
	Boolean(val:Bool);
	Str(val:String);
	Identifier(val:String);
	OpenParen;
	ClosePar;
	OpenBracket;
	CloseBracket;
	
}
 
class Lexer 
{
	private var code:String;
	
	static private function to_token(chaine:String, acc:Array<Token>):Array<Token>
	{		
		if (chaine == "") 
		{
			return acc;
		}
		
		// Blank
		var regex = ~/^\s+/;
		if (regex.match(chaine))
		{
			return to_token(regex.matchedRight(), acc);
		}
		
		// Integer
		var regex = ~/^([0-9]+)/;
		if (regex.match(chaine))
		{
			var token = Integ(Std.parseInt(regex.matched(1)));
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		// Float
		var regex = ~/^([0-9]*.[0-9]+)/;
		if (regex.match(chaine))
		{
			var token = Decimal(Std.parseFloat(regex.matched(1)));
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		
		// Identifier
		var regex = ~/^([A-Za-z][A-Za-z0-9!]*)/;
		if (regex.match(chaine))
		{
			var token = Identifier(regex.matched(1));
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		// Open parenthesis
		var regex = ~/^\(/;
		if (regex.match(chaine))
		{
			var token = OpenParen;
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		// Close parenthesis
		var regex = ~/^\)/;
		if (regex.match(chaine))
		{
			var token = ClosePar;
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		// Open bracket
		var regex = ~/^\[/;
		if (regex.match(chaine))
		{
			var token = OpenBracket;
			acc.push(token);
			return to_token(regex.matchedLeft(), acc);
		}
		
		// Open parenthesis
		var regex = ~/^\]/;
		if (regex.match(chaine))
		{
			var token = CloseBracket;
			acc.push(token);
			return to_token(regex.matchedRight(), acc);
		}
		
		throw "uknown text";
	}

	public function new(code) 
	{
		this.code = code;
	}
	
	public function lex()
	{
		//trace(code);
		var result = to_token(code, []);
		//var result = code.split("\n").map(StringTools.trim).map(to_token).filter(function(x){return x != Undef; });
		for (i in result)
		{
			trace(i);
		}
		
		trace(result);
		return result;
	}
}