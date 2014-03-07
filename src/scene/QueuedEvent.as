package scene 
{
	import org.flixel.FlxSprite;
	public class QueuedEvent {
		public var _character:FlxSprite;
		public var _pct:Number = 0;
		public var _name:String = "NONE";
		
		public function QueuedEvent(name:String, character:FlxSprite, pct:Number) {
			_character = character;
			_pct = pct;
			_name = name;
		}
		public function update():void { }
		public function done():Boolean {
			return true;
		}
		public function do_remove():void {}
	}

}