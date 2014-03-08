package gameobj 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class BasicBullet extends FlxSprite	{
		public var _damage:Number;
		
		public function BasicBullet(x:Number = 0, y:Number = 0) {
			super(x, y);
			_damage = 0;
		}
		
		public function bullet_update(game:GameEngine):void { }
		public function should_remove():Boolean { return true; }
		public function do_remove():void { }
	}

}