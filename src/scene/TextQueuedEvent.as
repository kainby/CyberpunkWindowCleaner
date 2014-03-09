package scene 
{
	import misc.ScrollingTextBubble;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	public class TextQueuedEvent extends QueuedEvent {
		
		private var _text_bubble:ScrollingTextBubble;
		private var _add_to:FlxGroup;
		private var _text:String;
		
		public function TextQueuedEvent(name:String, character:SceneCharacter, pct:Number, text:String, add_to:FlxGroup) {
			super(name, character, pct);
			_add_to = add_to;
			_text = text;
		}
		
		private var _initial_update:Boolean = true;
		public override function update():void {
			if (_initial_update) {
				_initial_update = false;
				_text_bubble = new ScrollingTextBubble(_text);
				_add_to.add(_text_bubble);
			}
			_text_bubble.set_pos(_character.x - _character.frameWidth * 0.1, _character.y - _character.frameHeight * 0.8);
			_text_bubble.scroll_tick();
		}
		
		
		public override function done():Boolean {
			if (_text_bubble == null) return false;
			return _text_bubble.is_complete();
		}
		
		public override function do_remove():void {
			if (_text_bubble == null) return;
			_add_to.remove(_text_bubble);
			_text_bubble.end();
		}
		
	}

}