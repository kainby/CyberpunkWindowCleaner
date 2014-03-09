package particle 
{
	import org.flixel.FlxPoint;
	public class RocketParticle extends Particle {
		
		private var _ct:Number = 0;
		private var _ct_max:Number = 0;
		private var _angle:Number;
		private var _vel:Number;
		
		public function RocketParticle(pt:FlxPoint, duree:Number = 18) {
			_ct_max = duree;
			_ct = _ct_max;
			this.x = pt.x;
			this.y = pt.y;
			this._vel = 8;
			this.angle = Util.float_random(1.047, 2.094);
			
			this.loadGraphic(Resource.IMPORT_ROCKET_SPARK);
			this.color = 0xFFFFAA;
		}
		
		public override function particle_update(g:GameEngine):void {
			_ct--;
			var pct:Number = _ct / _ct_max;
			this.color = (0xFF0000 - 0xFFFFAA) * (1 - pct) + 0xFFFFAA;
			this.alpha = pct + 0.25;
			this.x += _vel * Math.cos(this.angle);
			this.y += _vel * Math.sin(this.angle);
		}
		
		public override function should_remove():Boolean {
			return _ct <= 0;
		}
		
	}

}