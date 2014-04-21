package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxGame;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author test
	 */
	public class MainMenu extends FlxState{
		
		private var _flash:FlxSprite = new FlxSprite(Util.WID / 2 - 583 / 2, Util.HEI * 0.83, Resource.IMPORT_TITLE_FLASH);
		private var _ct:Number = 0;
		private var _fadeout:FlxSprite = new FlxSprite();
		private var _playlogo:FlxSprite = new PlayLogo();
		
		private var _begin_game:Boolean = false;
		
		public function MainMenu() {
			
			add(new FlxSprite(0, 0, Resource.IMPORT_TITLE));
			add(new FlxSprite(Util.WID * 0.82, Util.HEI * 0.02, Resource.IMPORT_MAIN_MUTE_BUTTON));
			//add(new FlxSprite(Util.WID * 0.82, Util.HEI * 0.145, Resource.IMPORT_MAIN_MENU_MORE_GAMES));
			
			
			add(_playlogo);
			add(_flash);
			add(_fadeout);
			
			_fadeout.makeGraphic(Util.WID, Util.HEI, 0xFF000000);
			_fadeout.alpha = 0;
			Util.play_bgm(Resource.BGM_MAIN);
		}
		
		public override function create():void {
			Util.zoom_camera();
		}
		
		public override function update():void {
			super.update();
			
			if (_begin_game) {
				_fadeout.alpha += 0.01;
				if (_fadeout.alpha >= 1) {
					FlxG.switchState(new GameEngine());
				}
				return;
			}
			
			if (Util.is_key(Util.MOVE_DOWN) || 
				Util.is_key(Util.MOVE_UP) || 
				Util.is_key(Util.MOVE_LEFT) || 
				Util.is_key(Util.MOVE_RIGHT) ||
				Util.is_key(Util.MOVE_JUMP)) {
					
				_begin_game = true;
			}
			
			if (FlxG.keys.justPressed("M")) {
				Util.mute_toggle();
			} /*else if (FlxG.keys.justPressed("P")) {
				Util.more_games();
			}*/
			
			_ct++;
			if (_ct % 40 == 0) {
				_flash.visible = !_flash.visible;
			}
		}
		
	}

}