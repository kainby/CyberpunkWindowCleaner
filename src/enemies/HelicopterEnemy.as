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
		public var _crashed:Boolean;
		public var _currloc:FlxPoint;
		
		public var _reassign_countdown:Number;
		public var _debut:Boolean;
		public var _dx:Number;
		public var _dy:Number;
		public var _vy:Number;
		private var y0:Number;
		private var _dfloat:Number;
		private var _ct:Number;
		
		public var RPM:int = 6;		// 600 RPM
		public var MAG:int = 12;	// adjust this for the number of bullets
		public const SPD:Number = 2;
		public const GRAVITY:Number = 0.25;
		public var DELAY:Number = 90;
		
		public function HelicopterEnemy(team_no:Number, init_x:Number = 0, init_y:Number = 0) {
			// default: hp=100, angle=0, hiding=false
			super(team_no);
			
			this._shoot_timer = 150;	// so the debut shoot will happen faster
			this._shoot_delay = Util.int_random(150, 200);
			this._mag = MAG;
			this._rpm = RPM;
			this._destination = new FlxPoint(init_x, init_y);
			this.x = init_x;
			this.y = 550;
			this.y0 = 550;
			this._ct = 0;
			this._dfloat = 0;
			this._crash_mode = false;
			this._crashed = false;
			this._reassign_countdown = Util.int_random(1, 3);
			this._dx = 75;
			this._dy = 100;
			this._vy = 0;
			this._debut = true;
			this._currloc = new FlxPoint();
			
			if (_team_no == 1) {
				this._angle = 0;
				this.loadGraphic(Resource.IMPORT_HELI_RED, true, false, 102, 87);
				this.addAnimation("Propeller_red", [1, 2, 3, 4, 5, 6], 20);
				this.play("Propeller_red");
			} else {
				this._angle = -180;
				this.loadGraphic(Resource.IMPORT_HELI_BLUE, true, false, 102, 87);
				this.addAnimation("Propeller_blue", [1, 2, 3, 4, 5, 6], 20);
				this.play("Propeller_blue");
			}
		}
		
		private var _g:GameEngine;
		
		override public function enemy_update(game:GameEngine):void {
			_g = game;
			
			// floating effect
			_ct = (_ct + 1) % 314159;
			var team_dev:Number = (_team_no == 1) ? 0:(Math.PI / 2);
			_dfloat = 20 * Math.sin(0.02 * _ct - team_dev);
			this.y = this.y0 + _dfloat;
			
			// reach the assigned point
			if (!in_position() && !_crashed) {
				if (_debut) {
					// decelerate to the assigned position
					this.x += (_destination.x - this.x) / 60;
					this.y0 += (_destination.y - this.y0) / 60;
				} else if (!_crash_mode) {
					// move to reassigned location with constant speed
					var ang:Number = Math.atan2(_destination.y - this.y0, _destination.x - this.x);
					this.x += SPD * Math.cos(ang);
					this.y0 += SPD * Math.sin(ang);
				} else {
					var vx:Number = (_destination.x - _currloc.x) / DELAY;
					var vy:Number = (_destination.y - _currloc.y) / DELAY;
					this.x += vx;
					this.y0 += vy;
				}
				return;
			} else {
				_debut = false;
				if (_crash_mode) {
					// free-fall
					_crashed = true;
					var vx:Number = (_team_no == 1) ? -1:1;
					_vy += GRAVITY;
					this.x += vx * 4;
					this.y0 += _vy;
					this.angle += 2 * vx;
				}
			}
			if (_crashed) return;
			
			_shoot_timer++;
			if (_shoot_timer >= _shoot_delay) {
				if (_mag > 0) {
					if (_rpm <= 0) {
						var dx:Number = (_team_no == 1) ? 84:12;
						
						// search and aim
						for (var i:int = 0; i < game._enemies_front.length; i++) {
							if (game._enemies_front.members[i] instanceof HelicopterEnemy) {
								var target:HelicopterEnemy = game._enemies_front.members[i];
								if (target._team_no != this._team_no) {
									var ang:Number = Math.atan2(target.y0 - this.y0, target.x - this.x) * Util.DEGREE;
									if ((this._team_no == 1 && (ang > -60 && ang < 60))
									|| (this._team_no != 1 && (ang > 120 || ang < -120))) _angle = ang;
								}
							}
						}
						var bullet:RoundBullet = new RoundBullet(this.x + dx, this.y + 84, _angle + Util.float_random(-6,6));
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
					_reassign_countdown--;
				}
			}
			
			// re-assign location
			if (_reassign_countdown <= 0) {
				_reassign_countdown = Util.int_random(1, 3);
				var sign:Number = (Util.int_random(0, 1) == 1) ? ( -1):1;
				var new_x:Number = this.x + Util.float_random(-_dx, _dx);
				var new_y:Number = this.y0 + Util.float_random(-_dx, _dy);
				if ((new_x <= 0 || new_y <= 0 || new_x >= 900 || new_y >= 400)) {
					new_x = this.x;
					new_y = this.y0;
				}
				set_destination(new_x, new_y);
			}
		}
		
		public function crash(crash_point:FlxPoint):void {
			_crash_mode = true;
			_debut = false;
			_currloc = _currloc.make(this.x, this.y0);
			set_destination(crash_point.x, crash_point.y);
		}
		
		public function set_destination(x:Number, y:Number):void {
			_shoot_timer = 0;
			_destination = _destination.make(x, y);
		}
		
		// customize location auto reassign range, at least 10 for each number
		public function set_move_range(dx:Number, dy:Number):HelicopterEnemy {
			if (dx < 10) {
				dx = 10;
			}
			if (dy < 10) {
				dy = 10;
			}
			this._dx = dx;
			this._dy = dy;
			return this;
		}
		
		public function in_position():Boolean {
			return Math.abs(this.x - _destination.x) <= 3 && Math.abs(this.y0 - _destination.y) <= 3;
		}
		
		override public function should_remove():Boolean {
			return this.y >= 600 && _crash_mode;
		}
		
		override public function do_remove():void {
			_g.end_out();
		}
	}
}