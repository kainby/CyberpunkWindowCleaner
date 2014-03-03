package particle {
	import org.flixel.FlxSprite;
	/**
	 * @author spotco
	 */
	public class Particle extends FlxSprite {
		public function Particle() {
				super(0, 0);
		}
		public function particle_update(game:GameEngine):void{}
		public function should_remove():Boolean{ return true; }
		public function do_remove():void {}
	}
}