package enemies {
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class SniperEnemy extends BaseEnemy {
		
		// cluster of battling judgements
		private var _hiding:Boolean;
		private var _tactical_step:Number;
		public var _hide_timer:int;
		public var _hide_timer_limit:int;
		public var _vulnerable_timer:int;
		public var _vulnerable_limit:int;
		
		private var _laser_sight:FlxSprite;
		
		public var _shoot_timer:int;
		
		public var _group:FlxGroup;
		public var _target:BaseEnemy;
		
		// relative position of gun's muzzle
		public var _gun_x:Number;
		public var _gun_y:Number;
		
		public function SniperEnemy(team_no:Number) {
			// auto: hp=100, shoot=false, angle=0
			super(team_no);
			
			this._angle = (_team_no == 1) ? 0:(-180);
			
			this._hiding = true;
			this._tactical_step = 1;
			this._hide_timer = 0;
			this._hide_timer_limit = Util.int_random(60, 600);
			this._shoot = false;
			this._shoot_timer = 0;
			this._vulnerable_timer = 0;
			this._vulnerable_limit = 120;
			this._group = null;
			this._target = null;
			
			// initialize laser sight
			this._laser_sight = new FlxSprite();
			_laser_sight.loadGraphic(Resource.IMPORT_LASER_SIGHT);
			_laser_sight.visible = false;
			_laser_sight.angle = _angle;
			
			if (this._team_no == 1) {
				this.loadGraphic(Resource.IMPORT_ENEMY_RED);
				this._gun_x = this.width - 5;
			} else {	// _team_no == 2
				this.loadGraphic(Resource.IMPORT_ENEMY_BLUE);
				this._gun_x = 5;
			}
			this._gun_y = 12;
			this.visible = false;
		}
		
		override public function enemy_update(game:GameEngine):void {
			var dx:Number = (_team_no == 1) ? 60 : 0;
			_laser_sight.set_position(this.x + dx - 320, this.y + 12);
			game.add(_laser_sight);
			if (!_hiding) {
				switch(_tactical_step) {
					case 1:
						// show up, be vulnerable, proceed
						_laser_sight.visible = true;
						this.visible = true;
						if (_vulnerable_timer >= _vulnerable_limit) {
							_vulnerable_timer = 0;
							_tactical_step = 2;
						} else {
							_vulnerable_timer++;
						}
						break;
					case 2:
						// finding target; if successfully, go on, otherwise retreat
						this.visible = true;
						var search_success:Boolean = search_new_target(game);
						if (!search_success) {
							retreat();
						} else {
							_tactical_step = 3;
						}
						break;
					case 3:
						// aim
						this.visible = true;
						_laser_sight.angle = _angle;
						var goal_angle:Number = Math.atan2(_target.y - this.y, _target.x - this.x) * Util.DEGREE;
						var err_tol:Number = Util.float_random(0.5, 1.5);
						if (Math.abs(_angle-goal_angle) <= err_tol) {
							// aim successful
							_tactical_step = 4;
						} else {
							var dtheta:Number = (goal_angle - _angle) / 10;
							_angle += dtheta;
						}
						break;
					case 4:
						this.visible = true;
						_laser_sight.visible = false;
						var choice:Number = Util.float_random(0, 4);
						if (choice > 3) {
							// optional tactical hide
							_hiding = true;
						} else {
							// shoot
							_shoot = true;
							_tactical_step = 5;
						}
						break;
					case 5:
						_shoot = false;
						if (_vulnerable_timer >= _vulnerable_limit) {
							retreat();
						} else {
							_vulnerable_timer++;
						}
						break;
					default:
						_tactical_step = 1;
						break;
				}
			} else {	// hide for some time
				this.visible = false;
				if (_hide_timer >= _hide_timer_limit) {
					_hiding = false;
					reset_hide_timer();
				} else {
					_hide_timer++;
				}
			}
		}
		
		public function retreat():void {
			_hiding = true;
			_shoot = false;
			_tactical_step = 1;
			_vulnerable_timer = 0;
			_vulnerable_limit = Util.int_random(180, 360);
			_laser_sight.visible = false;
		}
		
		// returns a boolean that indicates whether a target is found
		public function search_new_target(game:GameEngine):Boolean {
			_group = game._enemies;
			if (_group != null) {
				// randomly target someone from the group; if it's an enemy, then target succeed
				var trial:Number = 1;
				var max_trial:Number = Util.int_random(5, 10);
				while (trial <= max_trial) {
					var possible_target:BaseEnemy = _group.getRandom() as BaseEnemy;
					if (possible_target._team_no != this._team_no && possible_target.visible) {
						_target = possible_target;
						return true;
					}
					trial++;
				}
			}
			return false;
		}
		
		public function is_hiding():Boolean {
			return _hiding;
		}
		
		public function reset_hide_timer():void {
			_hide_timer = 0;
			_hide_timer_limit = Util.int_random(300, 600);
		}
	}
}