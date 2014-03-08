package gameobj 
{
	import org.flixel.FlxPoint;
	
	public class RoundBullet extends BasicBullet {
		public var _speed:Number;
		public var _angle:Number;
		public var _distance:Number;
		private var _range:Number;
		
		public function RoundBullet(x:Number = 0, y:Number = 0, ang:Number = 0) {
			// default: damage = 0
			super(x, y);
			
			this._speed = 5;
			this._angle = ang;
			this._distance = 0;
			this._range = 1200;
			this._damage = 15;
			
			this.loadGraphic(Resource.IMPORT_BULLET_ROUND);
		}
		
		override public function bullet_update(game:GameEngine):void {
			this.x += _speed * Math.cos(_angle * Util.RADIAN);
			this.y += _speed * Math.sin(_angle * Util.RADIAN);
			_distance += _speed;
		}
		
		override public function should_remove():Boolean {
			return _distance >= _range;
		}
	}
}