package {
	import flash.geom.Rectangle;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flixel.*;
	
	public class GameEngine extends FlxState {
		
		protected var game_obj:FlxGroup = new FlxGroup();
		protected var player_obj:FlxGroup = new FlxGroup();
		
		protected var cam:FlxCamera;
		protected var cam_follow:FlxSprite;
		
		public override function create():void {
			super.create();
		}
		
		public override function update():void {
			super.update();
		}

		
	}
	
}