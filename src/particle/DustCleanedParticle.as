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
		public const ADJ_COE:Number = 50;
		
		public function DustCleanedParticle(pos:FlxPoint,vel:FlxPoint, end:FlxPoint) {
			_ct = 200;
			this.loadGraphic(Resource.IMPORT_DUST_SPARK);
			//this.loadGraphic(Resource.IMPORT_STAIN_1);
			this.x = pos.x;
			this.y = pos.y;
			this._vel = vel;
			this._end = end;
			this._acc = new FlxPoint(0, 0);
		}
		
		public override function particle_update(g:GameEngine):void {
			this.x += _vel.x;
			this.y += _vel.y;
			this.alpha -= 0.005;
			_ct--;
			
			var r2:Number = (_end.x - this.x) * (_end.x - this.x) + (_end.y - this.y) * (_end.y - this.y);
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