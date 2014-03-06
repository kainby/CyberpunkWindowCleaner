package particle 
{
	import org.flixel.FlxPoint;
	public class FadeOutParticle extends Particle {
		
		private var _ct:Number = 0;
		private var _ct_max:Number = 0;
		private var _vr:Number = 0;
		
		public function FadeOutParticle(pt:FlxPoint, duree:Number = 40) {
			_ct_max = duree;
			_ct = _ct_max;
			this.x = pt.x;
			this.y = pt.y;
			
			this.loadGraphic(Resource.IMPORT_DUST_SPARK);
			
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
		}
		
		public function set_vr(vr:Number):FadeOutParticle {
			_vr = vr;
			return this;
		}
		
		public function set_scale(sc:Number):FadeOutParticle {
			this.scale.x = sc;
			this.scale.y = sc;
			return this;
		}
		
		public override function particle_update(g:GameEngine):void {
			_ct--;
			var pct:Number = _ct / _ct_max;
			this.alpha = pct;
			this.angle += _vr;
		}
		
		public override function should_remove():Boolean {
			return _ct <= 0;
		}
		
	}

}