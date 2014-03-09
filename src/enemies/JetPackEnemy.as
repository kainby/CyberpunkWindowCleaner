package enemies {
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	
	public class JetPackEnemy extends BaseEnemy {
		public var _position:FlxPoint;
		public var _destination:FlxPoint;
		
		public function JetPackEnemy(team_no:Number) {
			// default: hp=100, shoot=false, angle=0, hiding=false
			super(team_no);
			_position = new FlxPoint();
			_destination = new FlxPoint();
		}
		
		public function set_position(x:Number, y:Number):JetPackEnemy {
			_position = _position.make(x, y);
			return this;
		}
		
		public function set_destination(x:Number, y:Number):JetPackEnemy {
			_destination = _destination.make(x, y);
			return this;
		}
		
		public function in_position():Boolean {
			return _position.x == _destination.x && _position.y == _destination.y;
		}
		
		override public function enemy_update(game:GameEngine):void {
			
		}
	}
}