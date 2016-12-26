package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/graphics/1.5x/font-5.fnt", __ASSET__assets_graphics_1_5x_font_5_fnt);
		type.set ("assets/graphics/1.5x/font-5.fnt", AssetType.TEXT);
		className.set ("assets/graphics/1.5x/font-5.png", __ASSET__assets_graphics_1_5x_font_5_png);
		type.set ("assets/graphics/1.5x/font-5.png", AssetType.IMAGE);
		className.set ("assets/graphics/1.5x/font-6.fnt", __ASSET__assets_graphics_1_5x_font_6_fnt);
		type.set ("assets/graphics/1.5x/font-6.fnt", AssetType.TEXT);
		className.set ("assets/graphics/1.5x/font-6.png", __ASSET__assets_graphics_1_5x_font_6_png);
		type.set ("assets/graphics/1.5x/font-6.png", AssetType.IMAGE);
		className.set ("assets/graphics/1.5x/tileset-0.png", __ASSET__assets_graphics_1_5x_tileset_0_png);
		type.set ("assets/graphics/1.5x/tileset-0.png", AssetType.IMAGE);
		className.set ("assets/graphics/1.5x/tileset-7.png", __ASSET__assets_graphics_1_5x_tileset_7_png);
		type.set ("assets/graphics/1.5x/tileset-7.png", AssetType.IMAGE);
		className.set ("assets/graphics/1.5x/tileset-8.png", __ASSET__assets_graphics_1_5x_tileset_8_png);
		type.set ("assets/graphics/1.5x/tileset-8.png", AssetType.IMAGE);
		className.set ("assets/graphics/1x/font-5.fnt", __ASSET__assets_graphics_1x_font_5_fnt);
		type.set ("assets/graphics/1x/font-5.fnt", AssetType.TEXT);
		className.set ("assets/graphics/1x/font-5.png", __ASSET__assets_graphics_1x_font_5_png);
		type.set ("assets/graphics/1x/font-5.png", AssetType.IMAGE);
		className.set ("assets/graphics/1x/font-6.fnt", __ASSET__assets_graphics_1x_font_6_fnt);
		type.set ("assets/graphics/1x/font-6.fnt", AssetType.TEXT);
		className.set ("assets/graphics/1x/font-6.png", __ASSET__assets_graphics_1x_font_6_png);
		type.set ("assets/graphics/1x/font-6.png", AssetType.IMAGE);
		className.set ("assets/graphics/1x/tileset-0.png", __ASSET__assets_graphics_1x_tileset_0_png);
		type.set ("assets/graphics/1x/tileset-0.png", AssetType.IMAGE);
		className.set ("assets/graphics/1x/tileset-7.png", __ASSET__assets_graphics_1x_tileset_7_png);
		type.set ("assets/graphics/1x/tileset-7.png", AssetType.IMAGE);
		className.set ("assets/graphics/1x/tileset-8.png", __ASSET__assets_graphics_1x_tileset_8_png);
		type.set ("assets/graphics/1x/tileset-8.png", AssetType.IMAGE);
		className.set ("assets/graphics/2x/font-5.fnt", __ASSET__assets_graphics_2x_font_5_fnt);
		type.set ("assets/graphics/2x/font-5.fnt", AssetType.TEXT);
		className.set ("assets/graphics/2x/font-5.png", __ASSET__assets_graphics_2x_font_5_png);
		type.set ("assets/graphics/2x/font-5.png", AssetType.IMAGE);
		className.set ("assets/graphics/2x/font-6.fnt", __ASSET__assets_graphics_2x_font_6_fnt);
		type.set ("assets/graphics/2x/font-6.fnt", AssetType.TEXT);
		className.set ("assets/graphics/2x/font-6.png", __ASSET__assets_graphics_2x_font_6_png);
		type.set ("assets/graphics/2x/font-6.png", AssetType.IMAGE);
		className.set ("assets/graphics/2x/tileset-0.png", __ASSET__assets_graphics_2x_tileset_0_png);
		type.set ("assets/graphics/2x/tileset-0.png", AssetType.IMAGE);
		className.set ("assets/graphics/2x/tileset-7.png", __ASSET__assets_graphics_2x_tileset_7_png);
		type.set ("assets/graphics/2x/tileset-7.png", AssetType.IMAGE);
		className.set ("assets/graphics/2x/tileset-8.png", __ASSET__assets_graphics_2x_tileset_8_png);
		type.set ("assets/graphics/2x/tileset-8.png", AssetType.IMAGE);
		className.set ("assets/graphics/4x/font-5.fnt", __ASSET__assets_graphics_4x_font_5_fnt);
		type.set ("assets/graphics/4x/font-5.fnt", AssetType.TEXT);
		className.set ("assets/graphics/4x/font-5.png", __ASSET__assets_graphics_4x_font_5_png);
		type.set ("assets/graphics/4x/font-5.png", AssetType.IMAGE);
		className.set ("assets/graphics/4x/font-6.fnt", __ASSET__assets_graphics_4x_font_6_fnt);
		type.set ("assets/graphics/4x/font-6.fnt", AssetType.TEXT);
		className.set ("assets/graphics/4x/font-6.png", __ASSET__assets_graphics_4x_font_6_png);
		type.set ("assets/graphics/4x/font-6.png", AssetType.IMAGE);
		className.set ("assets/graphics/4x/tileset-0.png", __ASSET__assets_graphics_4x_tileset_0_png);
		type.set ("assets/graphics/4x/tileset-0.png", AssetType.IMAGE);
		className.set ("assets/graphics/4x/tileset-7.png", __ASSET__assets_graphics_4x_tileset_7_png);
		type.set ("assets/graphics/4x/tileset-7.png", AssetType.IMAGE);
		className.set ("assets/graphics/4x/tileset-8.png", __ASSET__assets_graphics_4x_tileset_8_png);
		type.set ("assets/graphics/4x/tileset-8.png", AssetType.IMAGE);
		className.set ("assets/graphics/default-font.fnt", __ASSET__assets_graphics_default_font_fnt);
		type.set ("assets/graphics/default-font.fnt", AssetType.TEXT);
		className.set ("assets/graphics/default-font.png", __ASSET__assets_graphics_default_font_png);
		type.set ("assets/graphics/default-font.png", AssetType.IMAGE);
		className.set ("assets/graphics/preloader-badge.png", __ASSET__assets_graphics_preloader_badge_png);
		type.set ("assets/graphics/preloader-badge.png", AssetType.IMAGE);
		className.set ("assets/graphics/preloader-bg.png", __ASSET__assets_graphics_preloader_bg_png);
		type.set ("assets/graphics/preloader-bg.png", AssetType.IMAGE);
		className.set ("assets/graphics/preloader-bg@1.5x.png", __ASSET__assets_graphics_preloader_bg_1_5x_png);
		type.set ("assets/graphics/preloader-bg@1.5x.png", AssetType.IMAGE);
		className.set ("assets/graphics/preloader-bg@2x.png", __ASSET__assets_graphics_preloader_bg_2x_png);
		type.set ("assets/graphics/preloader-bg@2x.png", AssetType.IMAGE);
		className.set ("assets/graphics/preloader-bg@4x.png", __ASSET__assets_graphics_preloader_bg_4x_png);
		type.set ("assets/graphics/preloader-bg@4x.png", AssetType.IMAGE);
		className.set ("assets/data/behaviors.xml", __ASSET__assets_data_behaviors_xml);
		type.set ("assets/data/behaviors.xml", AssetType.TEXT);
		className.set ("assets/data/game.xml", __ASSET__assets_data_game_xml);
		type.set ("assets/data/game.xml", AssetType.TEXT);
		className.set ("assets/data/resources.xml", __ASSET__assets_data_resources_xml);
		type.set ("assets/data/resources.xml", AssetType.TEXT);
		className.set ("assets/data/scene-0.scn", __ASSET__assets_data_scene_0_scn);
		type.set ("assets/data/scene-0.scn", AssetType.BINARY);
		className.set ("assets/data/scene-0.xml", __ASSET__assets_data_scene_0_xml);
		type.set ("assets/data/scene-0.xml", AssetType.TEXT);
		className.set ("assets/data/scenes.xml", __ASSET__assets_data_scenes_xml);
		type.set ("assets/data/scenes.xml", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "assets/graphics/1.5x/font-5.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/1.5x/font-5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1.5x/font-6.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/1.5x/font-6.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1.5x/tileset-0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1.5x/tileset-7.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1.5x/tileset-8.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1x/font-5.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/1x/font-5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1x/font-6.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/1x/font-6.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1x/tileset-0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1x/tileset-7.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/1x/tileset-8.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/2x/font-5.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/2x/font-5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/2x/font-6.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/2x/font-6.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/2x/tileset-0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/2x/tileset-7.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/2x/tileset-8.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/4x/font-5.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/4x/font-5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/4x/font-6.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/4x/font-6.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/4x/tileset-0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/4x/tileset-7.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/4x/tileset-8.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/default-font.fnt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/graphics/default-font.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/preloader-badge.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/preloader-bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/preloader-bg@1.5x.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/preloader-bg@2x.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/graphics/preloader-bg@4x.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/data/behaviors.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/game.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/resources.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/scene-0.scn";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/data/scene-0.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/scenes.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/graphics/1.5x/font-5.fnt", __ASSET__assets_graphics_1_5x_font_5_fnt);
		type.set ("assets/graphics/1.5x/font-5.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/1.5x/font-5.png", __ASSET__assets_graphics_1_5x_font_5_png);
		type.set ("assets/graphics/1.5x/font-5.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1.5x/font-6.fnt", __ASSET__assets_graphics_1_5x_font_6_fnt);
		type.set ("assets/graphics/1.5x/font-6.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/1.5x/font-6.png", __ASSET__assets_graphics_1_5x_font_6_png);
		type.set ("assets/graphics/1.5x/font-6.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1.5x/tileset-0.png", __ASSET__assets_graphics_1_5x_tileset_0_png);
		type.set ("assets/graphics/1.5x/tileset-0.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1.5x/tileset-7.png", __ASSET__assets_graphics_1_5x_tileset_7_png);
		type.set ("assets/graphics/1.5x/tileset-7.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1.5x/tileset-8.png", __ASSET__assets_graphics_1_5x_tileset_8_png);
		type.set ("assets/graphics/1.5x/tileset-8.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1x/font-5.fnt", __ASSET__assets_graphics_1x_font_5_fnt);
		type.set ("assets/graphics/1x/font-5.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/1x/font-5.png", __ASSET__assets_graphics_1x_font_5_png);
		type.set ("assets/graphics/1x/font-5.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1x/font-6.fnt", __ASSET__assets_graphics_1x_font_6_fnt);
		type.set ("assets/graphics/1x/font-6.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/1x/font-6.png", __ASSET__assets_graphics_1x_font_6_png);
		type.set ("assets/graphics/1x/font-6.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1x/tileset-0.png", __ASSET__assets_graphics_1x_tileset_0_png);
		type.set ("assets/graphics/1x/tileset-0.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1x/tileset-7.png", __ASSET__assets_graphics_1x_tileset_7_png);
		type.set ("assets/graphics/1x/tileset-7.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/1x/tileset-8.png", __ASSET__assets_graphics_1x_tileset_8_png);
		type.set ("assets/graphics/1x/tileset-8.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/2x/font-5.fnt", __ASSET__assets_graphics_2x_font_5_fnt);
		type.set ("assets/graphics/2x/font-5.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/2x/font-5.png", __ASSET__assets_graphics_2x_font_5_png);
		type.set ("assets/graphics/2x/font-5.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/2x/font-6.fnt", __ASSET__assets_graphics_2x_font_6_fnt);
		type.set ("assets/graphics/2x/font-6.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/2x/font-6.png", __ASSET__assets_graphics_2x_font_6_png);
		type.set ("assets/graphics/2x/font-6.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/2x/tileset-0.png", __ASSET__assets_graphics_2x_tileset_0_png);
		type.set ("assets/graphics/2x/tileset-0.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/2x/tileset-7.png", __ASSET__assets_graphics_2x_tileset_7_png);
		type.set ("assets/graphics/2x/tileset-7.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/2x/tileset-8.png", __ASSET__assets_graphics_2x_tileset_8_png);
		type.set ("assets/graphics/2x/tileset-8.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/4x/font-5.fnt", __ASSET__assets_graphics_4x_font_5_fnt);
		type.set ("assets/graphics/4x/font-5.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/4x/font-5.png", __ASSET__assets_graphics_4x_font_5_png);
		type.set ("assets/graphics/4x/font-5.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/4x/font-6.fnt", __ASSET__assets_graphics_4x_font_6_fnt);
		type.set ("assets/graphics/4x/font-6.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/4x/font-6.png", __ASSET__assets_graphics_4x_font_6_png);
		type.set ("assets/graphics/4x/font-6.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/4x/tileset-0.png", __ASSET__assets_graphics_4x_tileset_0_png);
		type.set ("assets/graphics/4x/tileset-0.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/4x/tileset-7.png", __ASSET__assets_graphics_4x_tileset_7_png);
		type.set ("assets/graphics/4x/tileset-7.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/4x/tileset-8.png", __ASSET__assets_graphics_4x_tileset_8_png);
		type.set ("assets/graphics/4x/tileset-8.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/default-font.fnt", __ASSET__assets_graphics_default_font_fnt);
		type.set ("assets/graphics/default-font.fnt", AssetType.TEXT);
		
		className.set ("assets/graphics/default-font.png", __ASSET__assets_graphics_default_font_png);
		type.set ("assets/graphics/default-font.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/preloader-badge.png", __ASSET__assets_graphics_preloader_badge_png);
		type.set ("assets/graphics/preloader-badge.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/preloader-bg.png", __ASSET__assets_graphics_preloader_bg_png);
		type.set ("assets/graphics/preloader-bg.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/preloader-bg@1.5x.png", __ASSET__assets_graphics_preloader_bg_1_5x_png);
		type.set ("assets/graphics/preloader-bg@1.5x.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/preloader-bg@2x.png", __ASSET__assets_graphics_preloader_bg_2x_png);
		type.set ("assets/graphics/preloader-bg@2x.png", AssetType.IMAGE);
		
		className.set ("assets/graphics/preloader-bg@4x.png", __ASSET__assets_graphics_preloader_bg_4x_png);
		type.set ("assets/graphics/preloader-bg@4x.png", AssetType.IMAGE);
		
		className.set ("assets/data/behaviors.xml", __ASSET__assets_data_behaviors_xml);
		type.set ("assets/data/behaviors.xml", AssetType.TEXT);
		
		className.set ("assets/data/game.xml", __ASSET__assets_data_game_xml);
		type.set ("assets/data/game.xml", AssetType.TEXT);
		
		className.set ("assets/data/resources.xml", __ASSET__assets_data_resources_xml);
		type.set ("assets/data/resources.xml", AssetType.TEXT);
		
		className.set ("assets/data/scene-0.scn", __ASSET__assets_data_scene_0_scn);
		type.set ("assets/data/scene-0.scn", AssetType.BINARY);
		
		className.set ("assets/data/scene-0.xml", __ASSET__assets_data_scene_0_xml);
		type.set ("assets/data/scene-0.xml", AssetType.TEXT);
		
		className.set ("assets/data/scenes.xml", __ASSET__assets_data_scenes_xml);
		type.set ("assets/data/scenes.xml", AssetType.TEXT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getAudioBuffer (id));
			
		//}
		
		#else
		
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_font_5_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_font_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_font_6_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_font_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_tileset_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_tileset_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1_5x_tileset_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_font_5_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_font_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_font_6_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_font_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_tileset_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_tileset_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_1x_tileset_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_font_5_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_font_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_font_6_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_font_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_tileset_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_tileset_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_2x_tileset_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_font_5_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_font_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_font_6_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_font_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_tileset_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_tileset_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_4x_tileset_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_default_font_fnt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_default_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_preloader_badge_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_preloader_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_preloader_bg_1_5x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_preloader_bg_2x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_graphics_preloader_bg_4x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_data_behaviors_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_game_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_resources_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_scene_0_scn extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_scene_0_xml extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_scenes_xml extends flash.utils.ByteArray { }


#elseif html5

#if openfl










































#end

#else

#if openfl

#end

#if (windows || mac || linux)


@:file("Assets/graphics/1.5x/font-5.fnt") class __ASSET__assets_graphics_1_5x_font_5_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/1.5x/font-5.png") class __ASSET__assets_graphics_1_5x_font_5_png extends lime.graphics.Image {}
@:file("Assets/graphics/1.5x/font-6.fnt") class __ASSET__assets_graphics_1_5x_font_6_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/1.5x/font-6.png") class __ASSET__assets_graphics_1_5x_font_6_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1.5x/tileset-0.png") class __ASSET__assets_graphics_1_5x_tileset_0_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1.5x/tileset-7.png") class __ASSET__assets_graphics_1_5x_tileset_7_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1.5x/tileset-8.png") class __ASSET__assets_graphics_1_5x_tileset_8_png extends lime.graphics.Image {}
@:file("Assets/graphics/1x/font-5.fnt") class __ASSET__assets_graphics_1x_font_5_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/1x/font-5.png") class __ASSET__assets_graphics_1x_font_5_png extends lime.graphics.Image {}
@:file("Assets/graphics/1x/font-6.fnt") class __ASSET__assets_graphics_1x_font_6_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/1x/font-6.png") class __ASSET__assets_graphics_1x_font_6_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1x/tileset-0.png") class __ASSET__assets_graphics_1x_tileset_0_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1x/tileset-7.png") class __ASSET__assets_graphics_1x_tileset_7_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/1x/tileset-8.png") class __ASSET__assets_graphics_1x_tileset_8_png extends lime.graphics.Image {}
@:file("Assets/graphics/2x/font-5.fnt") class __ASSET__assets_graphics_2x_font_5_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/2x/font-5.png") class __ASSET__assets_graphics_2x_font_5_png extends lime.graphics.Image {}
@:file("Assets/graphics/2x/font-6.fnt") class __ASSET__assets_graphics_2x_font_6_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/2x/font-6.png") class __ASSET__assets_graphics_2x_font_6_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/2x/tileset-0.png") class __ASSET__assets_graphics_2x_tileset_0_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/2x/tileset-7.png") class __ASSET__assets_graphics_2x_tileset_7_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/2x/tileset-8.png") class __ASSET__assets_graphics_2x_tileset_8_png extends lime.graphics.Image {}
@:file("Assets/graphics/4x/font-5.fnt") class __ASSET__assets_graphics_4x_font_5_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/4x/font-5.png") class __ASSET__assets_graphics_4x_font_5_png extends lime.graphics.Image {}
@:file("Assets/graphics/4x/font-6.fnt") class __ASSET__assets_graphics_4x_font_6_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/4x/font-6.png") class __ASSET__assets_graphics_4x_font_6_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/4x/tileset-0.png") class __ASSET__assets_graphics_4x_tileset_0_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/4x/tileset-7.png") class __ASSET__assets_graphics_4x_tileset_7_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/4x/tileset-8.png") class __ASSET__assets_graphics_4x_tileset_8_png extends lime.graphics.Image {}
@:file("Assets/graphics/default-font.fnt") class __ASSET__assets_graphics_default_font_fnt extends lime.utils.ByteArray {}
@:bitmap("Assets/graphics/default-font.png") class __ASSET__assets_graphics_default_font_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/preloader-badge.png") class __ASSET__assets_graphics_preloader_badge_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/preloader-bg.png") class __ASSET__assets_graphics_preloader_bg_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/preloader-bg@1.5x.png") class __ASSET__assets_graphics_preloader_bg_1_5x_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/preloader-bg@2x.png") class __ASSET__assets_graphics_preloader_bg_2x_png extends lime.graphics.Image {}
@:bitmap("Assets/graphics/preloader-bg@4x.png") class __ASSET__assets_graphics_preloader_bg_4x_png extends lime.graphics.Image {}
@:file("Assets/data/behaviors.xml") class __ASSET__assets_data_behaviors_xml extends lime.utils.ByteArray {}
@:file("Assets/data/game.xml") class __ASSET__assets_data_game_xml extends lime.utils.ByteArray {}
@:file("Assets/data/resources.xml") class __ASSET__assets_data_resources_xml extends lime.utils.ByteArray {}
@:file("Assets/data/scene-0.scn") class __ASSET__assets_data_scene_0_scn extends lime.utils.ByteArray {}
@:file("Assets/data/scene-0.xml") class __ASSET__assets_data_scene_0_xml extends lime.utils.ByteArray {}
@:file("Assets/data/scenes.xml") class __ASSET__assets_data_scenes_xml extends lime.utils.ByteArray {}



#end

#end
#end

