package misc {
	import core.*;
	import flash.geom.Rectangle;
	import gameobj.BasicStain;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBitmapFont;
	import org.flixel.plugin.photonstorm.FlxScrollingText;
	import particle.*;
	
	
	public class ScrollingTextBubble extends FlxGroupSprite {
		
		private var _s:FlxSprite, _bubble:FlxSprite;
		public var _text:String;
		
		public function ScrollingTextBubble(text:String = "Romeo, O Romeo. Wherefore art thou Romeo?") {
			_bubble = new FlxSprite(0, 0);
			_bubble.loadGraphic(Resource.IMPORT_SPEECH_BUBBLE);
			this.add(_bubble);
			_text = text;
			
			_s = FlxScrollingText.add(Resource.get_bitmap_font(), new Rectangle(0, 0, 75, 30),2,0,text,true,false);
			
			this.add(_s);
			
			_bubble.alpha = 0.8;
		}
		
		public function start():void {
			FlxScrollingText.startScrolling(_s);
		}
		
		public function end():void {
			FlxScrollingText.remove(_s);
		}
		
		public override function update_position():void {
			_bubble.set_position(x() - 35, y()-23);
			_s.set_position(x() + 5 - 35, y() + 6 - 23);
		}
		
		private var _do_scroll_tick:Boolean = false;
		public override function draw():void {
			super.draw();
			if (_do_scroll_tick) FlxScrollingText.update_sprite(_s);
			_do_scroll_tick = false;
		}
		
		public function scroll_tick():void {
			_do_scroll_tick = true;
		}
		
		private var _saw_end:Boolean = false;
		private var _end_ct:Number = 115;
		public override function update():void {
			if (_s._data.complete && !_saw_end) {
				_saw_end = true;
			}
			if (_saw_end && _end_ct > 0) {
				_end_ct--;
			}
		}
		
		public function is_complete():Boolean {
			return _end_ct <= 0;
		}
		
	}

}