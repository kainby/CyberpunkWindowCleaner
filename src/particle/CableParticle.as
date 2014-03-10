package particle {
	import org.flixel.FlxSprite;
	public class CableParticle extends Particle {
		private var _follow:FlxSprite;
		public function CableParticle(follow:FlxSprite) {
			this.loadGraphic(Resource.IMPORT_CLEANER_GUY_CABLE);
			_follow = follow;
		}
		
		public override function particle_update(game:GameEngine):void {
			set_position(_follow.x+8, _follow.y-460);
		}
		
		public override function should_remove():Boolean {
			return false;
		}
		
	}

}