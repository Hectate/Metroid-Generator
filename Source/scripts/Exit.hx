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
import scripts.Room;

class Exit
{    
	public var roomA:Room;
	public var roomB:Room;
	public var locA:Int;
	public var locB:Int;
	public var posA:String;
	public var posB:String;

 	public function new()
	{
		
	}
	public function setRoom(r:Room, a:Bool):Void
	{
		if (a)
		{
			roomA = r;
		}
		else
		{
			roomB = r;
		}
	}
	public function setLoc(l:Int, a:Bool):Void
	{
		if (a)
		{
			locA = l;
		}
		else
		{
			locB = l;
		}
	}
	public function setPos(p:String, a:Bool):Void
	{
		if (a)
		{
			posA = p;
		}
		else
		{
			posB = p;
		}
	}
	public function addLoc(i:Int, a:Bool):Void
	{
		if (a)
		{
			locA += i;
			trace("locA incremented by " + i + " and is now " + locA);
		}
		else
		{
			locB += i;
			trace("locB incremented by " + i + " and is now " + locA);
		}
	}
}