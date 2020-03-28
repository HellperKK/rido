package;
using StringTools;

/**
 * ...
 * @author 
 */
enum Token 
{
	Integ(val:Int);
	//Decimal(val:Float);
	Boolean(val:Bool);
	Str(val:String);
	Identifier(val:String);
	Group(val: Array<Token>);
}
 
class Lexer 
{
	static public function to_token(chaine:String): Token
	{
		
		if (chaine == "") 
		{
			return Integ(42);
		}
		
		if (chaine.charAt(0) == '(') 
		{
			return Group(lex(chaine.substring(1, chaine.length - 1)));
		}
		
		if (chaine.charAt(0) == '"') 
		{
			return Str(chaine.substring(1, chaine.length - 1));
		}
		
		if ((chaine == 'true') || (chaine == 'false')) 
		{
			return Boolean(chaine == 'true');
		}
		
		var regex = ~/^[A-Za-z][A-Za-z0-9]*$/;
		if (regex.match(chaine))
		{
			return Identifier(chaine);
		}
		
		var regex = ~/^[+\-*\/!<>=|&]*$/;
		if (regex.match(chaine))
		{
			return Identifier(chaine);
		}
		
		throw 'Uknown token ${chaine}';
	}
	
	static private function manage_paren(code:String, pointer:Int): Int
	{
		var initial = pointer;
		pointer++;
		var count = 1;
		while ((count > 0) && (pointer < code.length)) 
		{
			if (code.charAt(pointer) == '(')
			{
				count++;
			}
			else if (code.charAt(pointer) == ')')
			{
				count--;
			}
			pointer++;
		}
		
		if ((pointer == code.length) && (count > 0)) 
		{
			throw "Missing )";
		}
		
		return pointer - initial;
	}
	
	static private function manage_space(code:String, pointer:Int): Int
	{
		var initial = pointer;
		pointer ++;
		while ((code.charAt(pointer) != ' ') && (pointer < code.length)) 
		{
			pointer++;
		}
		
		return pointer - initial;
	}
	
	static private function manage_string(code:String, pointer:Int):Int
	{
		var regex = ~/^"[^"]*"/;
		//var regex = ~/^"(([^"]|\\")*)"/;
		if (regex.matchSub(code, pointer))
		{
			return regex.matched(0).length;
		}
		
		throw 'Missing "';
	}
	
	static public function lex(code: String): Array<Token>
	{		
		var acc:Array<String> = [];
		var pointer = 0;
		trace(code);
		
		while (pointer < code.length) 
		{
			var regex = ~/^\s+/;
			if (regex.matchSub(code, pointer))
			{
				pointer++;
				continue;
			}
			
			if (code.charAt(pointer) == '(') 
			{
				var size = manage_paren(code, pointer);
				acc.push(code.substr(pointer, size));
				pointer += size;
			}
			else if (code.charAt(pointer) == '"') 
			{
				var size = manage_string(code, pointer);
				acc.push(code.substr(pointer, size));
				pointer += size;
			}
			else
			{
				var size = manage_space(code, pointer);
				acc.push(code.substr(pointer, size));
				pointer += size;
			}
		}
		trace(acc);
		return acc.map(to_token);
	}

	public function new() 
	{
		
	}
}