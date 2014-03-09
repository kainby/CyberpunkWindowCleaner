package particle 
{
	import org.flixel.FlxPoint;
	public class HpParticle extends Particle {
		
		private var _ct:Number = 0;
		private var _ct_max:Number = 0;
		private var _coeff:Number;
		private var _vy:Number;
		
		public function HpParticle(pt:FlxPoint, duree:Number = 40) {
			_ct_max = duree;
			_ct = _ct_max;
			this.x = pt.x;
			this.y = pt.y;
			this._vy = 2;
			this._coeff = 0.99;
			
			this.loadGraphic(Resource.IMPORT_HP_SPARK);
		}
		
		public function set_scale(sc:Number):HpParticle {
			this.scale.x = sc;
			this.scale.y = sc;
			return this;
		}
		
		public override function particle_update(g:GameEngine):void {
			_ct--;
			var pct:Number = _ct / _ct_max;
			this.alpha = pct;
			this.y -= _vy;
			_vy *= _coeff;
		}
		
		public override function should_remove():Boolean {
			return _ct <= 0;
		}
		
	}

}