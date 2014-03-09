package enemies {
	import org.flixel.FlxSprite;
	/**
	 * @author spotco
	 */
	public class BaseEnemy extends FlxSprite {
		public var _team_no:Number;
		public var _hp:Number;
		public var _shoot:Boolean;
		public var _angle:Number;
		public var _hiding:Boolean;
		
		public function BaseEnemy(team_no:Number) {
				super(0, 0);
				this._team_no = team_no;
				this._hp = 100;
				this._shoot = false;
				this._angle = 0;
				this._hiding = false;
		}
		public function enemy_update(game:GameEngine):void { }
		
		public function should_remove():Boolean {
			return _hp <= 0;
			trace("enemy died!");
		}
		
		public function do_remove():void { }
	}
}