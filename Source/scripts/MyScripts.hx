package scripts;

import com.stencyl.behavior.Script;
import scripts.Design_0_0_GenerateZones;
import scripts.SceneEvents_0;
import scripts.Design_2_2_BuildGraph;
import scripts.WorldMap;
import scripts.Array2D;
import scripts.Point;
import scripts.Room;
import scripts.MapDigger;
import scripts.Exit;


//Force all classes to compile since they aren't statically used.
class MyScripts
{
	var s:Script;
	var a:MyAssets;
	
	#if(mobile && !air)
	var stencylPreloader:scripts.StencylPreloader;
	#end
}