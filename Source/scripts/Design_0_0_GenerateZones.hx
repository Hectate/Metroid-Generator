package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

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
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_0_0_GenerateZones extends SceneScript
{
	
public var _Rooms:Array<Dynamic>;

public var _Generating:Bool;

public var _RoomIndex:Float;

public var _Paused:Bool;
    
/* ========================= Custom Block ========================= */


/* Params are:__Parent __RoomsList __Index */
public function _customBlock_RoomGenerate(__Parent:Float, __RoomsList:Array<Dynamic>, __Index:Float):Void
{
        __RoomsList.push(new Map<String, Dynamic>());
        __RoomsList[Std.int(__Index)].set("Room", __Index);
        __RoomsList[Std.int(__Index)].set("Parent", __Parent);
        __RoomsList[Std.int(__Index)].set("Key", 0);
        __RoomsList[Std.int(__Index)].set("Intensity", 0);
        if((__Index == 0))
{
            __RoomsList[Std.int(__Index)].set("Type", "H");
            __RoomsList[Std.int(__Index)].set("TL", "80,4");
            __RoomsList[Std.int(__Index)].set("BR", "89,7");
}

        else
{
            __RoomsList[Std.int(__Index)].set("Type", "V");
            __RoomsList[Std.int(__Index)].set("TL", "80,8");
            __RoomsList[Std.int(__Index)].set("BR", "83,17");
}

        sayToScene("Generate Zones", "_customBlock_SetTilesForRoom", [__RoomsList[Std.int(__Index)].get("TL"),__RoomsList[Std.int(__Index)].get("BR"),randomInt(Math.floor(1), Math.floor(6))]);
}
    
/* ========================= Custom Block ========================= */


/* Params are:__TL __BR __TileID */
public function _customBlock_SetTilesForRoom(__TL:String, __BR:String, __TileID:Float):Void
{
        for(index0 in 0...Std.int((asNumber(("" + __BR).split(",")[Std.int(0)]) - asNumber(("" + __TL).split(",")[Std.int(0)]))))
{
            for(index1 in 0...Std.int((asNumber(("" + __BR).split(",")[Std.int(1)]) - asNumber(("" + __TL).split(",")[Std.int(1)]))))
{
                setTileAt(Std.int((index1 + asNumber(("" + __TL).split(",")[Std.int(1)]))),Std.int((index0 + asNumber(("" + __TL).split(",")[Std.int(0)]))),0,"" + "0",0,__TileID);
}

}

}

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Rooms", "_Rooms");
_Rooms = [];
nameMap.set("Generating", "_Generating");
_Generating = false;
nameMap.set("RoomIndex", "_RoomIndex");
_RoomIndex = 0.0;
nameMap.set("Paused", "_Paused");
_Paused = false;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _Rooms = new Array<Dynamic>();
propertyChanged("_Rooms", _Rooms);
        _Generating = true;
propertyChanged("_Generating", _Generating);
        _RoomIndex = asNumber(0);
propertyChanged("_RoomIndex", _RoomIndex);
        _Paused = false;
propertyChanged("_Paused", _Paused);
        setTileAt(Std.int(1),Std.int(2),0,"" + "3",5,4);
        removeTileAt(Std.int(1),Std.int(2),0,"" + "1");
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        g.setFont(getFont(6));
        g.drawString("" + _Rooms, 2, 3);
        
}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(isKeyReleased("enter"))
{

}

        if((_Generating && !(_Paused)))
{
            sayToScene("Generate Zones", "_customBlock_RoomGenerate", [(_RoomIndex - 1),_Rooms,_RoomIndex]);
            _RoomIndex += randomInt(Math.floor(1), Math.floor(2));
propertyChanged("_RoomIndex", _RoomIndex);
            if((_RoomIndex > 1))
{
                _Generating = false;
propertyChanged("_Generating", _Generating);
}

            _Paused = true;
propertyChanged("_Paused", _Paused);
            runLater(1000 * .25, function(timeTask:TimedTask):Void {
                        _Paused = false;
propertyChanged("_Paused", _Paused);
}, null);
}

        removeRegion(getLastCreatedRegion().getID());
}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}