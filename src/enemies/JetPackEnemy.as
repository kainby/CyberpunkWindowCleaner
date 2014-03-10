package enemies {
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import particle.RocketParticle;
	import org.flixel.FlxParticle;
	
	public class JetPackEnemy extends BaseEnemy {
		public var _shoot_timer:int;
		public var _shoot_delay:int;
		public var _rpm:int;
		public var _mag:int;
		public var _chance:int;
		
		public var RPM:int = 5;	// 720 RPM
		public var MAG:int = 5;
		
		public var _emitter:FlxEmitter;
		
		public var _g:GameEngine;
		
		public function JetPackEnemy(team_no:Number, init_x:Number, g:GameEngine) {
			// default: hp=100, shoot=false, angle=0, hiding=false
			super(team_no);
			
			_g = g;
			
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
			
			var emitter:FlxEmitter = new FlxEmitter();
			_emitter = emitter;
			var particles:int = 5;
			emitter.setXSpeed( -16, 16);
			emitter.setYSpeed(60, 80);
			emitter.width = 20;
			emitter.height = 20;
			for(var i:int = 0; i < 130; i++) {
				var p:FlxParticle = new RocketParticle();
				emitter.add(p);
			}
			emitter.start(false, 1, 0.01);
			g._behind.add(_emitter);
		}
		
		override public function do_remove():void {
			_g._behind.remove(_emitter);
			_emitter.destroy();
			_emitter = null;
		}
		
		override public function enemy_update(game:GameEngine):void {
			if (!this.alive) {
				return;
			}
			
			this.y--;
			
			_emitter.x = (this._team_no == 1) ? this.x+15 : this.x+25;
			_emitter.y = this.y + 50; 
			
			// rocket particle
			/*for (var i:int = 1; i <= 3; i++ ) {
				var dx = (_team_no == 1) ? 0 : 51;
				var x_loc = this.x + Util.float_random(3, 9) + dx;
				var y_loc = this.y + Util.float_random(47,51);
				var rocket_spark:RocketParticle = new RocketParticle(new FlxPoint(x_loc, y_loc));
				game._particles.add(rocket_spark);
			}*/
			
			_shoot_timer++;
			if (_shoot_timer >= _shoot_delay) {
				if (_mag > 0) {
					if (_rpm <= 0) {
						var dx1:Number = (_team_no == 1) ? 65:(-3);
						var dx2:Number = (_team_no == 1) ? 34:25;
						var bullet1:RoundBullet = new RoundBullet(this.x + dx1, this.y + 23, _angle + Util.float_random(-5,5), 3);
						var bullet2:RoundBullet = new RoundBullet(this.x + dx2, this.y + 26, _angle + Util.float_random(-5,5), 3);
						game._bullets.add(bullet1);
						game._bullets.add(bullet2);
						_mag--;
						_rpm = RPM;
						FlxG.play(Resource.IMPORT_SOUND_JETPACK_SHOOT);
					} else {
						_rpm--;
					}
				} else {
					_mag = MAG;
					_shoot_timer = 0;
					_chance--;
				}
			}
		}
		
		override public function should_remove():Boolean {
			return this.y <= -200;
		}
	}
}