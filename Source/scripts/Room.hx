/*
    Stencyl exclusively uses the Haxe programming language. 
    Haxe is similar to ActionScript and JavaScript.
    
    Want to use native code or make something reusable? Use the Extensions Framework instead.
    http://www.stencyl.com/help/view/engine-extensions/
    
    Learn more about Haxe and our APIs
    http://www.stencyl.com/help/view/haxe/
*/


// via twitch: <metsjeesus> so... shoudl be there  method called room.draw?
// YES THERE SHOULD BE ONE WHY DIDN"T I DO THAT FIRST

package scripts;

import com.stencyl.Engine;
import com.stencyl.behavior.Script;
import scripts.Point;
import scripts.Exit;

class Room
{    
	public var ID:Int;
	public var parentID:Int;
	public var keyVal:Int;
	public var char:String;
	public var intensity:Float;
	public var startPoint:Point;
	public var dir:String;
	public var length:Int;
	public var active:Bool;
	public var exits:Array<Int>; //TODO: remove this once we are fully over to using exitList instead of 'exits' as our array.
	public var exitList:Array<Exit>;
	
	public static inline var down:String = "down";
	public static inline var left:String = "left";
	public static inline var right:String = "right";

 	public function new(ID,parentID,keyVal,char,intensity,startPoint,dir,length)
	{
		this.ID = ID;
		this.parentID = parentID;
		this.keyVal = keyVal;
		this.char = char;
		this.intensity = intensity;
		this.startPoint = new Point(startPoint.x,startPoint.y);
		this.dir = dir;
		this.length = length;
		active = true;
		exits = [for (i in 0...this.length) 0];
		exitList = [];
	}

	public function extendRoom(newStartPoint,newLength)
	{
		startPoint.setFromPoint(newStartPoint);
		length = newLength;
	}
	
	public function disableRoom()
	{
		active = false;
	}
	
	public function getActiveStatus():Bool
	{
		return active;
	}
	//TODO: remove once we use exitList
	public function getExits():Array<Int>
	{
		return exits;
	}
	//TODO: This will be extraneous once we use exitList instead, because we can directly examine and modify the Exit class objects in the array, instead of using
	//bitmasks to track the directions, etc. Will greatly simply things.
	public function addExit(x:Exit):Void
	{
		//exits[pos] = exits[pos] | val;
		//return;
		exitList.push(x);
		return;
	}
	public function traceExitList():Void
	{
		for (i in 0...exitList.length)
		{
			trace("Exit " + i + " joins roomA:" + exitList[i].roomA.ID + " to roomB:" + exitList[i].roomB.ID);
		}
	}
	public function drawRoom(color:Int):Void
	{
		var p:Point = new Point(0, 0);
		p.setFromPoint(startPoint);
		for (i in 0...length)
		{
			for (x in 0...3)
			{
				for (y in 0...3)
				{
					Script.setTileAt(p.y * 3 + y, p.x * 3 + x, 0, "0", 7, color);
				}
			}
			
			if (dir == down)
			{
				if (i == 0)
				{
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 0);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 2);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1", 8, 5);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 5);
				}
				else if (i == length - 1)
				{
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 5);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1", 8, 5);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 6);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 8);
				}
				else
				{
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 5);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1", 8, 5);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 3);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 5);
				}
			}
			else //dir is left or right
			{
				
				if (i == 0)
				{
					switch(dir)
					{
						case right:
							{
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 0);
								Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1", 8, 3);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 6);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 7);
							}
						case left:
							{
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 2);
								Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1", 8, 5);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 8);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 7);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
							}
					}
				}
				else if (i == length - 1)
				{
					switch(dir)
					{
						case left:
							{
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 0);
								Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1", 8, 3);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 6);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 7);
							}
						case right:
							{
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 2);
								Script.setTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1", 8, 5);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 8);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 7);
								Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
							}
					}
				}
				else
				{
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 0, 0, "1", 8, 1);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 0, 0, "1", 8, 7);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 1, 0, "1", 8, 1);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 1, 0, "1", 8, 7);
					Script.setTileAt((p.y * 3) + 0, (p.x * 3) + 2, 0, "1", 8, 1);
					Script.setTileAt((p.y * 3) + 2, (p.x * 3) + 2, 0, "1", 8, 7);
				}
			}
			
			switch(dir)
			{
				case down: p.y++;
				case left: p.x--;
				case right: p.x++;
			}
		}
		//TODO: start "cutting" exits here...
		
		for (i in 0...exitList.length)
		{
			p.setFromPoint(startPoint);
			var e:Exit = exitList[i];
			var loc:Int;
			var pos:String;
			if (e.roomA != this)
			{
				loc = e.locB;
				pos = e.posB;
			}
			else
			{
				loc = e.locA;
				pos = e.posA;
			}
			//trace("Room " + ID + " cutting exit at loc " + loc + ", pos " + pos);
			switch(dir)
			{
				case down:
					{
						p.y += loc;
					}
				case left:
					{
						p.x -= loc;
					}
				case right:
					{
						p.x += loc;
					}
			}
			if (pos == "east")
			{
				Script.removeTileAt((p.y * 3) + 1, (p.x * 3) + 2, 0, "1");
				//trace("removedTileAt(" + p.y + "," + p.x + ")");
			}
			else if (pos == "west")
			{
				Script.removeTileAt((p.y * 3) + 1, (p.x * 3) + 0, 0, "1");
				//trace("removedTileAt(" + p.y + "," + p.x + ")");
			}
		}
	}
	
	public function getArrayOfExitsAtLoc(i:Int):Array<Exit>
	{
		var a:Array<Exit>;
		a = [];
		for (e in 0...exitList.length)
		{
			if (this == exitList[e].roomA)
			{
				if (i == exitList[e].locA)
				{
					a.push(exitList[e]);
				}
			}
			else if (this == exitList[e].roomB)
			{
				if (i == exitList[e].locB)
				{
					a.push(exitList[e]);
				}
			}
		}
		return a;
	}
	
	public function hasExitAtPos(i:Int):Bool
	{
		for (e in 0...exitList.length)
		{
			if (this == exitList[e].roomA)
			{
				if (i == exitList[e].locA)
				{
					return true;
				}
			}
			else if (this == exitList[e].roomB)
			{
				if (i == exitList[e].locB)
				{
					return true;
				}
			}
		}
		return false;
	}
	
}