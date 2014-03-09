package enemies {
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import particle.RocketParticle;
	
	public class JetPackEnemy extends BaseEnemy {
		public var _shoot_timer:int;
		public var _shoot_delay:int;
		public var _rpm:int;
		public var _mag:int;
		public var _chance:int;
		
		public var RPM:int = 5;
		public var MAG:int = 5;
		
		public function JetPackEnemy(team_no:Number, init_x:Number) {
			// default: hp=100, shoot=false, angle=0, hiding=false
			super(team_no);
			
			this.x = init_x;
			this.y = 500;
			
			_chance = 3;
			_shoot_timer = 0;
			_shoot_delay = Util.int_random(100, 125);
			_mag = MAG;
			_rpm = RPM;
			
			if (_team_no == 1) {
				this._angle = 0;
				this.loadGraphic(Resource.IMPORT_JETPACK_THUG_RED);
				this.scale.x = -1;
			} else {
				this._angle = -180;
				this.loadGraphic(Resource.IMPORT_JETPACK_THUG_BLUE);
			}
		}
		
		override public function enemy_update(game:GameEngine):void {
			this.y -= 1;
			
			// rocket particle
			for (var i:int = 1; i <= 3; i++ ) {
				var dx = (_team_no == 1) ? 0 : 51;
				var x_loc = this.x + Util.float_random(3, 9) + dx;
				var y_loc = this.y + Util.float_random(47,51);
				var rocket_spark:RocketParticle = new RocketParticle(new FlxPoint(x_loc, y_loc));
				game._particles.add(rocket_spark);
			}
			
			_shoot_timer++;
			if (_shoot_timer >= _shoot_delay) {
				if (_mag > 0) {
					if (_rpm <= 0) {
						var dx1:Number = (_team_no == 1) ? 65:(-3);
						var dx2:Number = (_team_no == 1) ? 34:25;
						var bullet1:RoundBullet = new RoundBullet(this.x + dx1, this.y + 23, _angle + Util.float_random(-5,5));
						var bullet2:RoundBullet = new RoundBullet(this.x + dx2, this.y + 26, _angle + Util.float_random(-5,5));
						game._bullets.add(bullet1);
						game._bullets.add(bullet2);
						_mag--;
						_rpm = RPM;
					} else {
						_rpm--;
					}
				} else {	// mag used up
					_mag = MAG;
					_shoot_timer = 0;
					_chance--;
				}
			}
		}
		
		override public function should_remove():Boolean {
			return this.y <= -100;
		}
	}
}