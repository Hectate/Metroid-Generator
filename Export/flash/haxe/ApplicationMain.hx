import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new scripts.StencylPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/graphics/1.5x/font-5.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/1.5x/font-5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1.5x/font-6.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/1.5x/font-6.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1.5x/tileset-0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1.5x/tileset-7.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1.5x/tileset-8.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1x/font-5.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/1x/font-5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1x/font-6.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/1x/font-6.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1x/tileset-0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1x/tileset-7.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/1x/tileset-8.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/2x/font-5.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/2x/font-5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/2x/font-6.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/2x/font-6.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/2x/tileset-0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/2x/tileset-7.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/2x/tileset-8.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/4x/font-5.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/4x/font-5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/4x/font-6.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/4x/font-6.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/4x/tileset-0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/4x/tileset-7.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/4x/tileset-8.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/default-font.fnt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/graphics/default-font.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/preloader-badge.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/preloader-bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/preloader-bg@1.5x.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/preloader-bg@2x.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/graphics/preloader-bg@4x.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/data/behaviors.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/game.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/resources.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/scene-0.scn");
		types.push (AssetType.BINARY);
		
		
		urls.push ("assets/data/scene-0.xml");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/data/scenes.xml");
		types.push (AssetType.TEXT);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (65),
			fullscreen: false,
			height: Std.int (480),
			orientation: "portrait",
			resizable: false,
			stencilBuffer: false,
			title: "Metroid Generator",
			vsync: true,
			width: Std.int (640),
			
		}
		
		#if js
		#if (munit || utest)
		flash.Lib.embed (null, 640, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Universal)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Universal, Reflect.field (Universal, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Universal {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
