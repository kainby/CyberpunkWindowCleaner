package enemies {
	import gameobj.RoundBullet;
	import misc.FlxGroupSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import particle.RocketParticle;
	
	public class HelicopterEnemy extends BaseEnemy {
		public var _shoot_timer:int;
		public var _shoot_delay:int;
		public var _rpm:int;
		public var _mag:int;
		public var _destination:FlxPoint;
		public var _crash_mode:Boolean;
		public var _angle:Number;
		public var _reset_dest_timer:Number;
		public var _reset_dest_delay:Number;
		
		public var RPM:int = 4;	// 900 RPM
		public var MAG:int = 20;
		public var SPD:Number = 3;
		
		public function HelicopterEnemy(team_no:Number, init_x:Number = 0, init_y:Number = 0) {
			// default: hp=100, shoot=false, angle=0, hiding=false
			super(team_no);
			
			_shoot_timer = 0;
			_shoot_delay = Util.int_random(60, 90);
			_mag = MAG;
			_rpm = RPM;
			_destination = new FlxPoint(init_x, init_y);
			this.x = (_team_no == 1) ? -102:1000;
			this.y = -87;
			_crash_mode = false;
			
			_reset_dest_timer = 0;
			_reset_dest_delay = Util.int_random(600, 720);
			
			if (_team_no == 1) {
				this._angle = 0;
				this.loadGraphic(Resource.IMPORT_HELI_RED, true);
				this.addAnimation("Propeller_red", [1, 2, 3, 4, 5, 6], 20);
				this.play("Propeller_red");
			} else {
				this._angle = -180;
				this.loadGraphic(Resource.IMPORT_HELI_BLUE, true);
				this.addAnimation("Propeller_blue", [1, 2, 3, 4, 5, 6], 20);
				this.play("Propeller_blue");
			}
		}
		
		override public function enemy_update(game:GameEngine):void {
			// reach the assigned point
			if (!in_position()) {
				var ang:Number = Math.atan2(_destination.x - this.x, _destination.y - this.y);
				this.x += SPD * Math.cos(ang);
				this.y += SPD * Math.sin(ang);
				return;
			}
			
			// auto reassign location?
			
			_shoot_timer++;
			if (_shoot_timer >= _shoot_delay) {
				if (_mag > 0) {
					if (_rpm <= 0) {
						var dx:Number = (_team_no == 1) ? 84:12;
						var bullet:RoundBullet = new RoundBullet(this.x + dx, this.y + 84, _angle + Util.float_random(-7,7));
						game._bullets.add(bullet);
						_mag--;
						_rpm = RPM;
						FlxG.play(Resource.IMPORT_SOUND_HELI_SHOOT);
					} else {
						_rpm--;
					}
				} else {
					_mag = MAG;
					_shoot_timer = 0;
				}
			}
		}
		
		public function crash(crash_point:FlxPoint):void {
			_crash_mode = true;
			set_destination(crash_point.x, crash_point.y);
		}
		
		public function set_destination(x:Number, y:Number):void {
			_destination = _destination.make(x, y);
		}
		
		public function in_position():Boolean {
			return Math.abs(this.x - _destination.x) <= 0.5 && Math.abs(this.y - _destination.y) <= 0.5;
		}
		
		override public function should_remove():Boolean {
			return in_position() && _crash_mode;
		}
	}
}