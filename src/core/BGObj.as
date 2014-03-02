package core {
	import org.flixel.FlxSprite;
	import flash.display.Bitmap;
	
	public class BGObj extends FlxSprite{
		
		public function BGObj(img:Class) {
			super(0, 0);
			this.loadGraphic(img);
		}
		
	}

}