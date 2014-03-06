package particle 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ...
	 */
	public class DustCleanedParticle extends Particle {
		
		private var _ct:Number = 0;
		private var _vel:FlxPoint;
		private var _acc:FlxPoint;
		private var _end:FlxPoint;
		private var _r:Number;
		public const ADJ_COE:Number = 50;
		
		public function DustCleanedParticle(pos:FlxPoint,vel:FlxPoint, end:FlxPoint) {
			_ct = 200;
			this.loadGraphic(Resource.IMPORT_DUST_SPARK);
			this.x = pos.x;
			this.y = pos.y;
			this._vel = vel;
			this._end = end;
			this._acc = new FlxPoint(0, 0);
			
			this._r = Math.sqrt((_end.x - this.x) * (_end.x - this.x) + (_end.y - this.y) * (_end.y - this.y));
			
			// setting a random color
			var choice:int = Util.int_random(1, 7);
			switch(choice) {
				case 1: this.color = 0x80D5D5; break;
				case 2: this.color = 0xBFEAEA; break;
				case 3: this.color = 0xFFFFFF; break;
				case 4: this.color = 0x71DD55; break;
				case 5: this.color = 0xA6EA95; break;
				case 6: this.color = 0x9FDFDF; break;
				case 7: this.color = 0xF1F163; break;
			}
			
			this.angle = Util.float_random( -3.14, 3.14);
			var sc:Number = Util.float_random(0.8, 2);
			this.scale = new FlxPoint(sc, sc);
			
			
			this._initial_dist = Math.sqrt(Math.pow(_end.x-this.x,2)+Math.pow(_end.y-this.y,2));
			this._vr = Util.float_random( -45, 45);
			
		}
		
		private var _vr:Number = 0;
		private var _initial_dist:Number = 1;
		
		public override function particle_update(g:GameEngine):void {
			
			
			var r2:Number = (_end.x - this.x) * (_end.x - this.x) + (_end.y - this.y) * (_end.y - this.y);
			
			this.angle += _vr;
			this.x += _vel.x;
			this.y += _vel.y;
			this.alpha = Math.sqrt(r2) / _r + 0.25;
			_ct--;
			
			if (_ct >= 180) {
				// smooth curve
				_acc.x = (_end.x - this.x) / r2 * ADJ_COE;
				_acc.y = (_end.y - this.y) / r2 * ADJ_COE;
			} else {
				// sharp turn to the end point
				_acc.x = 0;
				_acc.y = 0;
				_vel.x = (_end.x - this.x) / Math.sqrt(r2) * 6;
				_vel.y = (_end.y - this.y) / Math.sqrt(r2) * 6;
			}
			if (Math.abs(this.x - _end.x) >= 1) {
				_vel.x += _acc.x;
			} else {
				_vel.x = 0;
			}
			if (Math.abs(this.y - _end.y) >= 1) {
				_vel.y += _acc.y;
			}
			
			if (this.y <= 0) {
				this.y = 0;
				this.alpha = 0;
				_ct = 0;
			}
		}
		
		public override function should_remove():Boolean {
			return _ct <= 0;
		}
		
	}

}