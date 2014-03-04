package scene {
	import core.*;
	import gameobj.BasicStain;
	import misc.FlxGroupSprite;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import particle.*;
	public class TestScene extends Scene {
		
		private static var SCRIPT:Array = [
			{
				PERCENT:0,
				CHARACTER:CHARACTER_ROMEO,
				POSITION:[267, 300]
			},
			{
				PERCENT:0,
				CHARACTER:CHARACTER_JULIET,
				POSITION:[350, 300]
			},
			{
				PERCENT:0.015,
				CHARACTER:CHARACTER_ROMEO,
				POSITION:[320, 300]
			},
			{
				PERCENT:0.02,
				CHARACTER:CHARACTER_JULIET,
				POSITION:[450, 300]
			},
			{
				PERCENT:0.0151,
				CHARACTER:CHARACTER_ROMEO,
				POSITION:[100, 100],
				SPEED:5
			}
		];
		
		public function TestScene(g:GameEngine) {
			super(g);
		}
		
		public override function init():Scene {
			super.init();
			load_script(SCRIPT);
			
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_BACK));
			_bg_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_INTERNAL));
			_window_group.add(new BGObj(Resource.IMPORT_FLOOR1_MAINBLDG_WINDOW));
			
			return this;
		}
		
	}

}