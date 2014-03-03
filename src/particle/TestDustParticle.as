package particle 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ...
	 */
	public class TestDustParticle extends Particle {
		
		private var _ct:Number = 0;
		private var _vel:FlxPoint;
		
		public function TestDustParticle(pos:FlxPoint,vel:FlxPoint) {
			_ct = 100;
			this.loadGraphic(Resource.IMPORT_STAIN_1);
			this.x = pos.x;
			this.y = pos.y;
			this._vel = vel;
		}
		
		public override function particle_update(g:GameEngine):void {
			this.x += _vel.x;
			this.y += _vel.y;
			this.alpha -= 0.01;
		}
		
		public override function should_remove():Boolean {
			return _ct <= 0;
		}
		
	}

}