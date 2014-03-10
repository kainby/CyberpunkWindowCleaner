package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite
	public class GameEndMenu extends FlxState {
		
		public function GameEndMenu() {
			Util.play_bgm(Resource.BGM_MAIN);
			this.add(new FlxSprite(0, 0, Resource.IMPORT_LASTPICTURE));
		}
		
	}

}