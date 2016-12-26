/*
    Stencyl exclusively uses the Haxe programming language. 
    Haxe is similar to ActionScript and JavaScript.
    
    Want to use native code or make something reusable? Use the Extensions Framework instead.
    http://www.stencyl.com/help/view/engine-extensions/
    
    Learn more about Haxe and our APIs
    http://www.stencyl.com/help/view/haxe/
*/

package scripts;


//==========================================================
// Imports
//==========================================================

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import scripts.WorldMap;
import scripts.Point;
import scripts.Room;

//THIS FILE WAS ALTERED IN FD FROM THE GAMES-GENERATED FOLDER!!

class Design_2_2_BuildGraph extends SceneScript
{          	
	//Expose your attributes like this
	//Need further help? See: http://www.stencyl.com/help/view/code-mode/
	//@:attribute("id='1' name='Display Name' desc='An Attribute'")
	//public var attributeName:String;
	
	var map:WorldMap;
	var room:Room;
	var roomID:Int;
	var roomParent:Int;
	var mX: Int;
	var mY: Int;
	var pX: Int;
	var pY: Int;
 	var exitsData:String;
	
	var debug:Bool=true;
	
	
	override public function init()
	{
		trace("creating a new map");
		map = new WorldMap(Std.int((getSceneWidth()/getTileWidth())/3),Std.int((getSceneHeight()/getTileHeight())/3),".");
		//map = new WorldMap(Std.int((getSceneWidth()/getTileWidth())),Std.int((getSceneHeight()/getTileHeight())),".");
		trace("map: " + map.getWidth() + "," + map.getHeight());
		trace("beginning generation");
		map.generate();
		trace("generation complete");
		redrawTiles();
	}
	
	public inline function update(elapsedTime:Float)
	{
		if (isKeyReleased("enter"))
		{
			//TODO: is this a memory leak? Do I need to dump the old map first?
			trace("beginning generation");
			map = new WorldMap(Std.int((getSceneWidth() / getTileWidth()) / 3), Std.int((getSceneHeight() / getTileHeight()) / 3), ".");
			//map = new WorldMap(Std.int((getSceneWidth()/getTileWidth())),Std.int((getSceneHeight()/getTileHeight())),".");
			trace("map: " + map.getWidth() + "," + map.getHeight());
			map.generate();
			trace("generation complete");
			redrawTiles();
		}
		if (isKeyReleased("space"))
		{
			debug = !debug;
			trace("debug switched");
		}
		if (Input.mouseReleased)
		{
			mX = Std.int(Input.mouseX);
			mY = Std.int(Input.mouseY);
			pX = Std.int(mX / (Std.int(getTileWidth() * 3)));
			pY = Std.int(mY / (Std.int(getTileHeight() * 3)));
			//pX = Std.int(mX / (Std.int(getTileWidth())));
			//pY = Std.int(mY / (Std.int(getTileHeight())));
			room = map.getRoomFromPoint(new Point(pX, pY));
			if (room == null)
			{
				roomID = -1;
				exitsData = "";
				roomParent = -1;
			}
			else
			{
				exitsData = "";
				roomID = room.ID;
				for (i in 0...room.exitList.length)
				{
					exitsData += room.exitList[i].roomB.ID + ",";
				}
				roomParent = room.parentID;
			}
		}
	}
	
	public inline function draw(g:G)
	{
		/*
		var string:String = "";
		g.setFont(getFont(6));
		for(i in 0...map.getHeight()-1)
		{
			string = map.map.rowToString(i);
			g.drawString(string, 0, 10*i);
		}
		*/
		if (debug)
		{
			g.setFont(getFont(6));
			//g.drawString("mouseX: " + Input.mouseX, 5, 5);
			//g.drawString("mouseY: " + Input.mouseY, 5, 15);
			g.drawString("Point: " + pX + "," +pY, 5, 5);
			g.drawString("RoomID: " + roomID, 5, 15);
			g.drawString("exits: " + exitsData, 5, 25);
			g.drawString("parent: " + roomParent, 5, 35);
		}
	}
	
	//Need to handle collisions and other event types? Visit TODO
	
	
	
	
	//==========================================================
	// Don't edit unless you know what you're doing
	//==========================================================
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();	
		
		addWhenUpdatedListener(null, onUpdate);
		addWhenDrawingListener(null, onDraw);
	}
	
	public function onUpdate(elapsedTime:Float, list:Array<Dynamic>)
	{
		if(wrapper.enabled)
		{
			update(elapsedTime);
		}
	}
	
	public function onDraw(g:G, x:Float, y:Float, list:Array<Dynamic>)
	{
		if(wrapper.enabled)
		{
			draw(g);
		}
	}
	
	public function emptyTiles()
	{
		for (i in 0...Std.int((getSceneWidth()/getTileWidth())))
        {
            for (ii in 0...Std.int((getSceneHeight()/getTileHeight())))
            {
                removeTileAt(Std.int(ii),Std.int(i),0,"0");
                removeTileAt(Std.int(ii),Std.int(i),0,"1");
            }
        }
	}
	
	private function redrawTiles()
	{
		emptyTiles();
		var colorNum:Int = 0;
		
		for (i in 0...map.rooms.length)
		{
			if (map.rooms[i].active == true)
			{
				map.rooms[i].drawRoom(colorNum);
				colorNum += 1;
				if(colorNum > 79) { colorNum = 0; }
			}
		}
	}
}