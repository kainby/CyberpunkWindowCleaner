package enemies {
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	
	public class JetPackEnemy extends BaseEnemy {
		public var _destination:FlxPoint;
		public var _tactical_step:Number;
		
		public function JetPackEnemy(team_no:Number) {
			// default: hp=100, shoot=false, angle=0, hiding=false
			super(team_no);
			_destination = new FlxPoint();
			_tactical_step = 1;
		}
		
		public function set_position(x:Number, y:Number):JetPackEnemy {
			this.x = x;
			this.y = y;
			return this;
		}
		
		public function set_destination(x:Number, y:Number):JetPackEnemy {
			_destination = _destination.make(x, y);
			return this;
		}
		
		public function in_position():Boolean {
			return this.x == _destination.x && this.y == _destination.y;
		}
		
		override public function enemy_update(game:GameEngine):void {
			if (!in_position()) {
				this.x += (_destination.x - this.x) / 10;
				this.y += (_destination.y - this.y) / 10;
			} else {
				// shoot logic
				
			}
		}
	}
}