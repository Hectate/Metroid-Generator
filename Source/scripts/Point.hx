/*
    Stencyl exclusively uses the Haxe programming language. 
    Haxe is similar to ActionScript and JavaScript.
    
    Want to use native code or make something reusable? Use the Extensions Framework instead.
    http://www.stencyl.com/help/view/engine-extensions/
    
    Learn more about Haxe and our APIs
    http://www.stencyl.com/help/view/haxe/
*/

package scripts;

import com.stencyl.Engine;

class Point
{    
	public var x:Int;
	public var y:Int;

 	public function new(x:Int,y:Int)
	{
		this.x = x;
		this.y = y;
	}

	public function toString()
	{
		return "Point("+x+","+y+")";
	}
	public function setX(x:Int)
	{
		this.x = x;
	}
	public function setY(y:Int)
	{
		this.y = y;
	}
	public function setFromPoint(p:Point)
	{
		this.x = p.x;
		this.y = p.y;
	}
	public function equals(p:Point):Bool
	{
		if ((x == p.x) && (y == p.y))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}