package;
using StringTools;

/**
 * ...
 * @author 
 */
enum Token 
{
	Fun_def(name:String, args:Array<String>);
	Fun_call(name:String, args:Array<Token>);
	Var_def(name:String, value:Token);
	Var_mod(name:String, modifier:String, value:Token);
	Cond(value:Token);
	Comp(value:Token, op:String, valueb:Token);
	Number(value:Int);
	Ident(value:String);
	Returning(value:Token);
	End_block;
	Undef;
}
 
class Lexer 
{
	private var code:String;
	
	static private function to_token(chaine:String):Token
	{
		chaine = chaine.trim();
		
		// Function definition
		var regex = ~/FUNCTION\s*([A-Z_]+)\(([A-Z_, ]*)\)\s*DO/;
		if (regex.match(chaine))
		{
			return Fun_def(regex.matched(1), regex.matched(2).split(",").map(StringTools.trim));
		}
		
		//Condition
		regex = ~/IF\s*(.+)\s*DO/;
		if (regex.match(chaine))
		{
			return Cond(to_token(regex.matched(1)));
		}
		
		//Comparaison
		regex = ~/(.+)\s*(==|!=|>=|>|<=|<)\s*(.+)/;
		if (regex.match(chaine))
		{
			return Comp(to_token(regex.matched(1)), regex.matched(2), to_token(regex.matched(3)));
		}
		
		//Variable definition
		regex = ~/([A-Z_]+)\s*=\s*(.+)/;
		if (regex.match(chaine))
		{
			return Var_def(regex.matched(1), to_token(regex.matched(2)));
		}
		
		//Variable modification
		regex = ~/([A-Z_]+)\s*(\+|\-|\*|\/|%)=\s*(.+)/;
		if (regex.match(chaine))
		{
			return Var_mod(regex.matched(1), regex.matched(2), to_token(regex.matched(3)));
		}
		
		//Return a value
		regex = ~/RETURN(.+)/;
		if (regex.match(chaine))
		{
			return Returning(to_token(regex.matched(1)));
		}
		
		//Define a number
		regex = ~/([0-9]+)/;
		if (regex.match(chaine))
		{
			return Number(Std.parseInt(regex.matched(1)));
		}
		
		//End keyword
		regex = ~/END/;
		if (regex.match(chaine))
		{
			return End_block;
		}
		
		//Function call
		regex = ~/([A-Z_]+)\((.*)\)/i;
		if (regex.match(chaine))
		{
			var temp = regex.matched(2).trim();
			if (temp == "")
			{
				return Fun_call(regex.matched(1), []);
			}
			else
			{
				return Fun_call(regex.matched(1), regex.matched(2).split(",").map(to_token));
			}
			
		}
		
		//Define a identifier
		regex = ~/([A-Z_]+)/;
		if (regex.match(chaine))
		{
			return Ident(regex.matched(1));
		}
		return Undef;
	}

	public function new(code) 
	{
		this.code = code;
	}
	
	public function lex()
	{
		var result = code.split("\n").map(StringTools.trim).map(to_token);
		for (i in result)
		{
			trace(i);
		}
		
		return result;
	}
}