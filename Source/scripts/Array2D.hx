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

class Array2D
{
	var a:Array<Array<String>>;
	var w:Int;
	var h:Int;
	
	public function new()
	{
		
	}
    	public function create(w:Int,h:Int,c:String)
    	{
    		this.w = w;
    		this.h = h;
		a = [];
		for (x in 0...w)
		{
          	a[x] = [];
          	for (y in 0...h)
          	{
               	a[x][y] = c;
            	}
        }
        return a;
    	}

    	//returns the height of the Array2D
    	public function getHeight():Int
    	{
    		return h;
    	}
    	//returns the width of the Array2D
    	public function getWidth():Int
    	{
    		return w;
    	}
    	//returns the content at a given coordinate
	public function getPoint(x:Int,y:Int)
	{
		if (x < 0 || y < 0)
		{
			trace("Warning: Tried to getPoint with negative value");
			return a[0][0];
		}
		else if (x > w-1 || y > h-1)
		{
			trace("Warning: Tried to getPoint greater than width or height");
			return a[w-1][h-1];
		}
		return a[x][y];
	}

	//sets the content at a given coordinate
	public function setPoint(x:Int,y:Int,c:String)
	{
		//prevent setting points at negative positions on the array(s)
		if((x>=0)&&(y>=0))
		{
			//prevent setting points outside the positive bounds of the array(s)
			if((x<w)&&(y<h))
			{
				a[x][y] = c;
			}
			else
			{
				trace("setPoint attempted outside positive bounds at: " + x + "," + y);
			}
		}
		else
		{
			trace("setPoint attempted at negative bounds at: " + x + "," + y);
		}
	}
	//returns the contents of a specific row as a string for printing
	public function rowToString(y:Int):String
	{
		var string:String = "";
		for(i in 0...w)
		{
			string += a[i][y];
		}
		return string;
	}
	//returns the contents of a specific column as a string for printing
	public function columnToString(x:Int):String
	{
		var string:String = "";
		for(i in 0...h)
		{
			string += a[x][i];
		}
		return string;
	}
}