package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import flash.ui.*;
	public class PlayLogo extends FlxSprite{
		
		public function PlayLogo() 
		{
			super(0, 0, Resource.IMPORT_PLAY_LOGO_OPEN);
			this.x = Util.WID - this.width;
			this.y = Util.HEI - this.height;
			this.alpha = 0.75;
		}
		
		override public function update():void {
		  updateAnimationOnClick();
		  super.update();
		}

		public function hover(x:Number, y:Number, width:int, height:int):Boolean {
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			
			x -= (FlxG.stage.stageWidth-Util.WID)/2;
			y -= (FlxG.stage.stageHeight-Util.HEI)/2;
			
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}

		public function updateAnimationOnClick() {
		  if (hover(x, y, width, height)) {	
			Mouse.cursor = MouseCursor.BUTTON;
			if (FlxG.mouse.justPressed()) {
				Util.more_games();
			}
		  } else {
			  Mouse.cursor = MouseCursor.AUTO; 
		  }
	}
		
	}

}