package;

import flash.system.System;
import flixel.*;
import flixel.FlxState;
import haxe.macro.Context;

class SystemStuff extends FlxState {
	public static function error(message:String, pos:Pos):Dynamic {
		#if macro
		return haxe.macro.Context.error(message, pos);
		#else
		return throw message;
		#end
	}
}