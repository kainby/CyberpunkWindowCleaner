package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import org.flixel.FlxGame;
	import org.flixel.FlxG
	import org.flixel.system.input.Mouse;
	
	[SWF(frameRate = "60", width = "1000", height = "500")]
	//[SWF(frameRate = "60", width = "800", height = "400")]
	[Frame(factoryClass="Preloader")]
	
	
	public class Main extends FlxGame {
		
		public function Main():void {
			//super(1000, 500, GameEngine);
			//super(1000, 500, GameEndMenu);
			super(1000, 500, MainMenu);
		}
	}
	
}