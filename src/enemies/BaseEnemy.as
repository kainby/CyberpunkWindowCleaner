package enemies {
	import org.flixel.FlxSprite;
	/**
	 * @author spotco
	 */
	public class BaseEnemy extends FlxSprite {
		public function BaseEnemy() {
				super(0, 0);
		}
		public function enemy_update(game:GameEngine):void{}
	}
}