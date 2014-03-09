package particle 
{
	import org.flixel.FlxPoint;
	public class BloodParticle extends Particle {
		
		public function BloodParticle(x:Number,y:Number) {
			super();
			this.set_position(x, y);
			loadGraphic(Resource.IMPORT_BLOOD, true, false, 18, 18);
			addAnimation("blood_splash", [1, 2, 3], 12, false);
			play("blood_splash");
			set_scale(2);
		}
		
		public override function should_remove():Boolean {
			return this.finished;
		}
		
		
		
	}

}