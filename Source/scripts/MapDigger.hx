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
import scripts.WorldMap;
import scripts.Room;
import scripts.Point;

class MapDigger
{    
	public var life:Int;
	var dir:String = "down";
	var position:Point;
	var map:WorldMap;
	var xDist:Int;
	var yDist:Int;
	
	public static inline var down:String = "down";
	public static inline var left:String = "left";
	public static inline var right:String = "right";
	
	var root:Room;
	var branch:Room;
	var graftee:Room;
	var graftPoint:Int;

 	public function new(map:WorldMap,startRoom:Room,pos:Point,dir:String,life:Int)
	{
		this.map = map;
		position = new Point(0,0);
		position.setFromPoint(pos);
		this.dir = dir;
		this.life = life;
		root = startRoom;
	}
	
	public function getPosition():Point
	{
		return position;
	}
	
	/* Plan: return an Int
	 * -1 means we didn't make a room at all (encountered an adjacent room, "graftee") so we need to just join the root and the graftee
	 * 0 means our digger died early but a room was made too, we join the root, branch, and graftee together and are done.
	 * 1+ means our digger died of old age, a room was made but we can continue the branch without a graftee at this point.
	 * plus, we'll assign rooms to variables to use depending on the status
	 * root: our source room, will have an exit added where we started if successful
	 * branch: our new room if created
	 * graftee: the room we find if we run into one, allows us to know where we're going to connect to...
	 * graftPoint: the location (int) on the graftee that will have an exit added connecting to the root/branch
	 */
	public function startDig():Int
	{	
		var North = 8;
		var South = 4;
		var East = 2;
		var West = 1;
		var branchExit1 = 0;
		var branchExit2 = 0;
		var grafteeExit = 0;
		
		var newRoomStartPoint:Point = new Point(0, 0);
		newRoomStartPoint.setFromPoint(position);
		
		var result:Int;
		xDist = yDist = 0;
		//trace("Digger triggered at " + position.x + "," + position.y + " for room " + root.ID);
		switch ( dir ) 
		{
			case left :
			{ 
				newRoomStartPoint.x--;
				branchExit1 = East;
				branchExit2 = West;
				grafteeExit = East;
			}
			case right :
			{
				newRoomStartPoint.x++;
				branchExit1 = West;
				branchExit2 = East;
				grafteeExit = West;
			}
			case down :
			{
				if (root.dir == left)
				{
					newRoomStartPoint.x--;
				}
				else
				{
					newRoomStartPoint.x++;
				}
				branchExit1 = North;
				branchExit2 = South;
				grafteeExit = North;
			}
		}
		while(life > 0)
		{
			//start moving in the direction we want to go in, because the starting point is on the room we're branching from.
			switch ( dir ) 
			{
				case left : xDist--;
			
				case right : xDist++;
			
				case down : yDist++;
			}
			//check point for a room
			if(map.getRoomFromPoint(new Point(position.x+xDist,position.y+yDist)) != null)
			{
				//trace("found room, killing digger");
				graftee = map.getRoomFromPoint(new Point(position.x + xDist, position.y + yDist));
				break;
			}
			life--;
		}
		
		var x:Int = xDist < 0 ? -xDist : xDist; //get absolute value of xDist
		if(life > 0)
		{
			trace("digger had life leftover, room must have been found");
			if ((x == 1) && (yDist == 1))
			{
				trace("digger died immediately, we need to just join root and graftee because there's no space for a room");
				//graftee.addExit(0, grafteeExit); //TODO: place the exit correctly along the length of exits
				result = -1;
			}
			else
			{
				trace("digger died because room was found, we need to join root, branch, and graftee all together");
				branch = new Room(map.rooms.length, root.ID, root.keyVal, "0", root.intensity, newRoomStartPoint, dir, x-1);
				map.rooms.push(branch);
				//branch.addExit(0, branchExit1);
				//branch.addExit(branch.exits.length-1, branchExit2);
				trace(branch.dir);
				//graftee.addExit(0, grafteeExit); //TODO: place this exit correctly
				result = 0;
			}
		}
		else
		{
			trace("digger died of old age, full space available to make a room and we'll try to make another afteward.");
			if (dir == down)
			{
				branch = new Room(map.rooms.length, root.ID, root.keyVal, "0", root.intensity, newRoomStartPoint, dir, yDist-1);
			}
			else
			{
				branch = new Room(map.rooms.length, root.ID, root.keyVal, "0", root.intensity, newRoomStartPoint, dir, x - 1);
			}
			//branch.addExit(0, branchExit1);
			//branch.addExit(branch.exits.length - 1, branchExit2);
			map.rooms.push(branch);
			trace(branch.dir);
			result = 1;
		}
		
		return result;
	}
}