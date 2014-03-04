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
		
		public function ScrollingTextBubble() {
			_bubble = new FlxSprite(0, 0);
			_bubble.loadGraphic(Resource.IMPORT_SPEECH_BUBBLE);
			this.add(_bubble);
			
			_s = FlxScrollingText.add(Resource.get_bitmap_font(), new Rectangle(0, 0, 75, 30),2,0,"Romeo, O Romeo. Wherefore art thou Romeo? ",true,true);
			this.add(_s);
			
			FlxScrollingText.startScrolling(_s);
			
			_bubble.alpha = 0.8;
		}
		
		public override function update_position():void {
			_bubble.set_position(x() - 35, y()-23);
			_s.set_position(x() + 5 - 35, y() + 6 - 23);
		}
		
	}

}