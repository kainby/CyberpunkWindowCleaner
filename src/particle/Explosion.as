package particle {
	import org.flixel.FlxG;
	
	public class Explosion extends Particle {
		private var _delay:Number;
		private var _ct:Number;
		public var _explode:Boolean;
		
		public function Explosion(x:Number = 0, y:Number = 0, delay:Number = 0) {
			this.loadGraphic(Resource.IMPORT_EXPLOSION, true, false, 192, 96);
			this.addAnimation("boom", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 15, false);
			this.set_position(x, y);
			this.visible = false;
			this._delay = delay;
			this._ct = 0;
			this._explode = false;
		}
		
		public function explode():void {
			_explode = true;
		}
		
		override public function particle_update(game:GameEngine):void {
			if (_ct >= _delay) {
				this.visible = true;
				this.play("boom");
				FlxG.play(Resource.IMPORT_SOUND_EXPLOSION, 4);
				_ct = 0;
				_explode = false;
			} else if (_explode) {
				_ct++;
			}
		}
		
		override public function should_remove():Boolean {
			return this.finished;
		}
		
		public function set_location(x:Number, y:Number):Explosion {
			this.set_position(x, y);
			return this;
		}
	}

}