/*
    Stencyl exclusively uses the Haxe programming language. 
    Haxe is similar to ActionScript and JavaScript.
    
    Want to use native code or make something reusable? Use the Extensions Framework instead.
    http://www.stencyl.com/help/view/engine-extensions/
    
    Learn more about Haxe and our APIs
    http://www.stencyl.com/help/view/haxe/
*/

package scripts;

import com.stencyl.graphics.G;
import com.stencyl.Engine;
import scripts.Array2D;
import scripts.Point;
import scripts.Room;
import scripts.MapDigger;
import scripts.Exit;

class WorldMap {
	var width:Int;
	var height:Int;
	var emptyChar:String;
	public var map:Array2D;
	public var rooms:Array<Room>;

	//var down:String = "down";
	//var left:String = "left";
	//var right:String = "right";
	
	public static inline var down:String = "down";
	public static inline var left:String = "left";
	public static inline var right:String = "right";
	
	public function new(w,h,c)
	{
     	width = w;
     	height = h;
     	emptyChar = c;
     	map = new Array2D();
     	map.create(w,h,c);
     	rooms = [];
		
    	}
    	
	//gets the width of the map
	public function getWidth():Int
    	{
    		return width;
    	}

    	//gets the height of the map
    	public function getHeight():Int
    	{
    		return height;
    	}
    	
    	//returns the content at a given coordinate
	public function getPoint(x:Int,y:Int):String
	{
		return map.getPoint(x,y);
	}

	//sets the content at a given coordinate
	public function setPoint(x:Int,y:Int,c:String)
	{
		map.setPoint(x,y,c);
	}
	//gets the "string" originally designated as the "empty" one for comparison
	public function getEmptyChar():String
	{
		return emptyChar;
	}
	//gets the index of a room directly from the map using it's "char", or -1 if there's no match
	public function getRoomIndexFromMap(x:Int,y:Int):Int
	{
		var s:String = map.getPoint(x,y);
		for(i in 0...rooms.length)
		{
			if(rooms[i].char == s)
			{
				return i;
			}
			else return -1;
		}
		return -1;
	}
	//gets the index of a room directly from it's "char", or -1 if there's no match
	public function getRoomIndexFromChar(s:String):Int
	{
		for(i in 0...rooms.length)
		{
			if(rooms[i].char == s) { return i; }
			else return -1;
		}
		return -1;
		
	}
	//returns a room from it's ID
	public function getRoomFromID(ID:Int):Room
	{
		for (i in 0...rooms.length)
		{
			if (rooms[i].ID == ID)
			{
				return rooms[i];
			}
		}
		return null; //didn't find one with that ID...
	}
	//returns a room if one is found at a point, or null
	public function getRoomFromPoint(p:Point):Room
	{
		var testPoint:Point = new Point(0,0);
		for (i in 0...rooms.length)
		{
			if (rooms[i].active == true)
			{
				testPoint.setFromPoint(rooms[i].startPoint);
				for (ii in 0...rooms[i].length)
				{
					if (testPoint.equals(p))
					{
						return rooms[i];
					}
					switch ( rooms[i].dir ) 
					{
						case left : testPoint.x--;
						case right : testPoint.x++;
						case down : testPoint.y++;
					}
				}
			}
		}
		return null; //didn't find a room at that point...
	}
	private function redrawRoom(room:Room):Void
	{
		for(i in 0...room.length)
		{
			if(room.dir == "down")
			{
				setPoint(room.startPoint.x,room.startPoint.y+i,room.char);
			}
			else if(room.dir == "left")
			{
				setPoint(room.startPoint.x-i,room.startPoint.y,room.char);
			}
			else if(room.dir == "right")
			{
				setPoint(room.startPoint.x+i,room.startPoint.y,room.char);
			}
		}
		return;
	}
	//adds a room, also returns with a new point at the "end" of the room so another can be put there.
	private function addRoom(p:Point,index:Int,parent:Int,dir:String,len:Int,keyVal:Int,val:String,intensity:Int):Point
	{
		var x = p.x;
		var y = p.y;
		var tp:Point = new Point(p.x,p.y);
		
		for(i in 0...len)
		{	
			if(dir == "down")
			{
				setPoint(x,y+i,val);
				if(i >= len-1)
				{
					tp.setY(y+i);
					rooms.push(new Room(index,parent,keyVal,val,intensity,p,dir,len));
					//trace("finished down");
					return tp;
				}
			}
			else if(dir == "left")
			{
				setPoint(x-i,y,val);
				if(i >= len-1)
				{
					tp.setX(x-i);
					rooms.push(new Room(index,parent,keyVal,val,intensity,p,dir,len));
					//trace("finished left");
					return tp;
				}
			}
			else if(dir == "right")
			{
				setPoint(x+i,y,val);
				if(i >= len-1)
				{
					tp.setX(x+i);
					rooms.push(new Room(index,parent,keyVal,val,intensity,p,dir,len));
					//trace("finished right");
					return tp;
				}
			}
			else
			{
				trace("Invalid direction given to addRoom: " + dir);
				return p;
			}
		}
		return tp;
	}
	public function getRandInt(m:Int,n:Int):Int
	{
		var i:Int = Math.floor(Math.random() * (n-m+1)) + m;
		//trace("getRandInt result " + m + " to " + n + " = " + i);
		return i;
	}
	//here we check if any of our new vertical rooms are aligned and connect them into one room
	private function joinVerticals()
	{
		//collect all vertical rooms only in an array
		var verts:Array<Room> = [];
		for(i in 0...rooms.length)
		{
			//trace("Room num " + rooms[i].ID);
			if(rooms[i].dir == down)
			{
				//trace("Found down room #" + rooms[i].ID);
				verts.push(rooms[i]);
			}
		}
		//compare X values of all EXCEPT the current one
		for(i in 0...verts.length) //do this to every room
		{
			//skip this round if the room is no longer active.
			if(!verts[i].active)
			{
				//trace("room " + verts[i].char + " inactive already, skipping loop i");
				continue;
			}
			for(ii in i+1...verts.length)
			{
				//skip this room if it's not active also.
				if(!verts[ii].active)
				{
					//trace("room " + verts[ii].char + " inactive already, skipping loop ii");
					continue;
				}
				//trace("i:" + i + " ii:" + ii + " of length:" + (-1 + verts.length));
				//trace("Comparing " + verts[i].char + " to " + verts[ii].char);
				if(verts[i].startPoint.x == verts[ii].startPoint.x) //we found a vertical match!
				{
					//is there a room between us?
					//trace("startPoints:" + verts[i].startPoint.x + ", " + verts[i].startPoint.y + ", " + verts[ii].startPoint.x + ", " + verts[ii].startPoint.y + ")");
					if(hasRoom(
						verts[i].startPoint.x,
						verts[i].startPoint.y + verts[i].length,
						verts[i].startPoint.x,
						verts[ii].startPoint.y -1)
						== false)
						{
							//no room in the way? delete the found one and extend the old one!
							//trace("We found no blocking room between " + verts[i].char + " and " + verts[ii].char);
							var newLength:Int = (verts[ii].startPoint.y + verts[ii].length) - verts[i].startPoint.y;
							//QUESTION: should there be a max length to a vertical room?
							//var gap:Int = newLength - verts[ii].length - verts[i].length;
							var offset:Int = newLength - verts[ii].length; //subtracting one only looks right sometimes because of other exits!
							//trace("offset sent:" + offset);
							//get the exits from the room we are about to join. loop through each.
							//verts[i].traceExitList();
							for (ei in 0...verts[ii].exitList.length)
							{
								//e is now whichever exit we are looking at that also belongs to the room we are about to destroy.
								var e:Exit = verts[ii].exitList[ei];
								//trace("testing exit " + ei + " of room " + verts[ii].ID);
								if (e.roomA == verts[ii]) //roomA is the same as the room we're going to disable
								{
									//if we want to disable A, then we need to change it to point to the room that's going to be extended...
									//trace("roomA is now " + e.roomA.ID + " and is being set to " + verts[i].ID);
									e.roomA = verts[i];
									e.addLoc(offset, true);
									verts[i].addExit(e);
								}
								else //roomB is the room we are going to disable...
								{
									//trace("roomB is now " + e.roomB.ID + " and is being set to " + verts[i].ID);
									e.roomB = verts[i];
									e.addLoc(offset, false);
									verts[i].addExit(e);
								}
								
							}
							//verts[i].traceExitList();
							verts[i].extendRoom(verts[i].startPoint, newLength);
							verts[ii].disableRoom();
							redrawRoom(verts[i]);
							
						}
					else
					{
						//trace("Blocking room found between room " + verts[i].char + " and " + verts[ii].char + " at X:" + verts[ii].startPoint.x);	
					}
				}
			}
		}
		return;
	}
	//checks if there's any non-emptyChar value on the map within the region defined by two X,Y points
	public function hasRoom(xA:Int,yA:Int,xB:Int,yB:Int):Bool
	{
		var width:Int;
		var height:Int;

		width = xB - xA +1;
		height = yB - yA +1;
		
		//trace("hasRoom() debugging, width:" + width + ", height:" + height + ", xA:" + xA + ", yA:" + yA + ", xB:" + xB + ", yB:" + yB);
		if((width < 0) || (height < 0)) { return false; }
		
		for(i in 0...width)
		{
			//trace("hasRoom() debugging, loop i count:" + i);
			for(ii in 0...height)
			{
				//trace("hasRoom() debugging, loop ii count:" + ii);
				//trace("hasRoom() testing point (" + (xA + i) + "," + (yA + ii) + ")");
				if(map.getPoint((xA+i),(yA+ii)) != emptyChar)
				{
					//if it's not same as the emptyChar there's a room so we might as well end now...
					//trace("hasRoom() found room " + map.getPoint((xA+i),(yA+ii)) );
					return true;
				}
				//map.setPoint(xA+i,yA+ii,"x");
			}
		}
		//full loops ran without finding one? No problem, looks like there wasn't a room!
		return false;
	}
	//the meat of map generation algorithm
	public function generate()
	{
		//wipe the old map out, hide this line if you want to leave the old data and just add more
		map.create(width,height,".");
		var dir:String = right;
		var lastHorzDir:String = right;
		//we want each room to have a unique character to represent it so we create a string of all characters we wish to use
		//the assumption is that a period "." will be used for blank spaces so we use alphanumeric characters for rooms
		var aleph:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		var alephIndex:Int = 0;
		var parentIndex:Int = -1;
		var keyValue:Int = 0;
		var intensityVal:Int = 0;
		var point:Point;
		
		var North = 8;
		var South = 4;
		var East = 2;
		var West = 1;
		
		var roomIndex:Int = 0; //we want to track how many rooms we've made
		point = new Point(Math.floor(width/2),0); //place the starting point in the top middle of the map, going right with a 3 length.
		
		//add rooms a set number of times, picking randomly between left,down,right directions
		//of course, the point moves each time, resulting in a chain of rooms.
		var r:Room = null;
		var e:Exit;
		for(i in 0...40) //this is how many rooms we will make (unless we make it to the bottom of the map...)
		{
			if (roomIndex == 0)
			{
				point = addRoom(point,roomIndex,parentIndex,dir,3,keyValue,aleph.charAt(alephIndex),intensityVal);
				r = rooms[roomIndex];
				e = new Exit();
				r.addExit(e);
				e.setRoom(r, true);
				e.setLoc(r.length - 1, true);
				e.setPos("east", true);
				
				roomIndex++;
				parentIndex++;
				alephIndex++;
			}
			else 
			{
				//Setting some exit values for roomA...
				e = new Exit();
				r.addExit(e);
				e.setRoom(r, true);
				e.setLoc(r.length - 1, true);
				/*** How to get the correct direction? **/
				if (r.dir == right)
				{
					e.setPos("east", true);
				}
				else if (r.dir == left)
				{
					e.setPos("west", true);
				}
			}
			var randDir:Int = getRandInt(0,3);
			var lastDir:String = dir;
			var prevRoom:Room = rooms[roomIndex - 1];
			e = prevRoom.exitList[prevRoom.exitList.length-1]; //last exit made
			//to get a good shape we want to zigzag more than stairstep, so we encourage a horizontal reversal
			//by increasing the odds of switching left/right each time instead of right/right, for example (between downs)
			if(dir == down)
			{
				if(randDir == 0) //0 is 25% chance so we go in the "same" direction
				{
					if(lastHorzDir == left)
					{
						dir = left;
					}
					else
					{
						dir = right;
					}
				}
				else //otherwise 75% chance to reverse horizontal direction
				{
					if(lastHorzDir == left)
					{
						dir = right;
					}
					else
					{
						dir = left;
					}
				}
			}
			else //direction is not down so we want to switch to down and save which way we just went for next time...
			{
				lastHorzDir = dir;
				dir = down;
			}
			var randLen:Int;
			if(dir == left)
			{
				randLen = getRandInt(3,7);
				point.x--;
				e.setPos("west", true);
			}
			else if (dir == right)
			{
				randLen = getRandInt(3,7);
				point.x++;
				e.setPos("east", true);
			}
			else //dir = down;
			{
				randLen = getRandInt(0,4); //want more frequent short shafts, so anything less than two (0,1) will become 2 
				//when direction is downward, we want to place the starting point to the left or right based on the previous direction
				if(randLen < 2) { randLen = 2; } //length must be at least 2 for vertical shafts
				if(lastDir == left)
				{
					point.x--;
				}
				else
				{
					point.x++;
				}
			}
			point = addRoom(point, roomIndex, parentIndex, dir, randLen, keyValue, aleph.charAt(alephIndex), intensityVal);
			//set roomB details for the exit from the parent room...
			r = rooms[roomIndex]; //r is now room just made...
			e.setRoom(r,false);
			e.setLoc(0, false);
			//now we set the exit correctly here...
			if (e.roomA.dir == right)
			{
				e.setPos("west", false);
			}
			else if (e.roomA.dir == left)
			{
				e.setPos("east", false);
			}
			else //dir for roomA is "down" - we should never have two adjacent "down" rooms so this if/elseif is fine...
			{
				if (r.dir == right)
				{
					e.setPos("west", false);
				}
				else //if (r.dir == left)
				{
					e.setPos("east", false);
				}
			}
			r.addExit(e);
			
			roomIndex++;
			parentIndex++;
			alephIndex++;
			
			//if we create so many rooms that we surpass our string's length we need to start over with the first char
			if(alephIndex > aleph.length)
			{
				alephIndex = 0;
			}
			//if we pass the bottom of the predefined map we might as well quit now.
			if(point.y > map.getHeight())
			{
				trace("Reached bottom edge of map limits, quitting.");
				break;
			}
		}
		joinVerticals();
		//now we need to start adding branches!
		//TODO: select rooms to add branches.
		//good candidates should be long (?), vertical rooms preferred highly.
		//?? extract the main generation code and refactor as a general method for adding branches from an existing room to reuse it?
		
		//start of Diggers test code using addBranch()
		//reattempt to joinVerticals() after digging?
		for (b in 0...15)
		{
			addBranch();
		}
		return;
	}
	
	//TODO: modify this to use the MapDigger to create branches!!!!!!!!!!!!!!!
	function addBranch():Void
	{
		//we need to go back to the vertical rooms and add a new horizontal one somewhere off to the side.
		//prefer points near the middle, since they'll be empty
		//however, in all cases make sure that you never put a room in the same spot as an existing one
		//for example, on the ends where the "next" room was already put
		//bitmask key NSEW, combinations add up...
			//North == 1000 (8)
			//South == 0100 (4)
			//East == 0010 (2)
			//West == 0001 (1)
		var North = 8;
		var South = 4;
		var East = 2;
		var West = 1;	
		
		var needActive:Bool = true;
		var root:Room = rooms[0];
		var downs:Array<Room> = [];
		
		for (i in 0...rooms.length - 1)
		{
			if ((rooms[i].dir == down) && (rooms[i].active == true))
			{
				downs.push(rooms[i]);
			}
		}
		root = downs[getRandInt(0,downs.length-1)];
		
		trace("Room selected for digging:" + root.ID);
		var r:Int = getRandInt(0, root.length - 1);
		var point:Point = new Point(root.startPoint.x,root.startPoint.y+r);
		var dir:String;
		
		var westSafe:Bool = true;
		var eastSafe:Bool = true;
		
		//check for existing exits at that position
		if (root.hasExitAtPos(r))
		{
			//there's at least one exit...
			var exitArray:Array<Exit> = root.getArrayOfExitsAtLoc(r);
			for (i in 0...exitArray.length)
			{
				//we're in roomA here....
				if (exitArray[i].roomA == root)
				{
					if (exitArray[i].posA == "west")
					{
						westSafe = false;
					}
					if (exitArray[i].posA == "east")
					{
						eastSafe = false;
					}
				}
				//roomB instead...
				else
				{
					if (exitArray[i].posB == "west")
					{
						westSafe = false;
					}
					if (exitArray[i].posB == "east")
					{
						eastSafe = false;
					}
				}
			}
			//we can go one direction
			if (westSafe && !eastSafe)
			{
				dir = left;
			}
			//or the other direction
			else if (!westSafe && eastSafe)
			{
				dir = right;
			}
			//must have an up or down exit, unusual but happens...
			else if (westSafe && eastSafe)
			{
				if(getRandInt(0,1) != 0)
				{
					dir = left;
				}
				else
				{
					dir = right;
				}
			}
			else //or neither because there's no space!
			{
				trace("addBranch picked a bad spot...");
				return;
			}
		}
		else
		{
			//one doesn't exist in this case, so just pick either way
			if(getRandInt(0,1) != 0)
			{
				dir = left;
			}
			else
			{
				dir = right;
			}
		}
		//repeatedly create diggers until either we run into something or we do more steps than desired...
		//The problem is that the position is incremented off of the pre-room position; not the new root end point. Need to go to the new room's positioning...
		var result:Int = 1;
		var steps:Int = 20;
		while ((result == 1) && (steps >= 0))
		{
			steps--;
			var randLen:Int = getRandInt(3, 6);
			var dig:MapDigger = new MapDigger(this, root, point, dir, randLen);
			result = dig.startDig();
			if (result > 0)
			{
				
				root = rooms[rooms.length - 1];
				point.setFromPoint(root.startPoint);
				if (root.dir == left)
				{
					point.x -= (root.length -1);
				}
				else if(root.dir == right)
				{
					point.x += (root.length -1);
				}
				else
				{
					point.y += (root.length -1);
				}
				
				trace("good to repeat! New root: " + root.ID);
				switch(dir)
				{
					case left : 
					{ 
						dir = down;
					}
					case right :
					{ 
						dir = down;
					}
					case down : 
					{
						if(getRandInt(0,1) != 0)
						{
							dir = left;
						}
						else
						{
							dir = right;
						}
					}
				}
				
			}
			else if (result < 0)
			{
				trace("connect root and graftee");
			}
			else
			{
				trace("join root, branch, and graftee");
			}
		}
	}
}
    	