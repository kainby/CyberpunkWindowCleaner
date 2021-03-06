package{
    import org.flixel.system.*;
	import CPMStar.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	
	
	public class Preloader extends FlxPreloader
	{
		public function Preloader():void
		{
			className = "Main";
			super();
		}
		
		var adContainer:MovieClip = new MovieClip;
		var testAd:AdLoader = new AdLoader(
			//"6601Q3F4C5CDF" //goober
			"11550QA35E9A2E" //window cleaner
		);
		
		override protected function create():void {
			super.create();
			
				
			Util.WID = stage.stageWidth;
			Util.HEI = stage.stageHeight;
			
			if (Util.isUrl(["kongregate.com"],stage)) {
				//adContainer.addChild(testAd);
				//addChild(adContainer);
				cont();
				
			} else {
				
				adContainer.graphics.beginFill(0);
				adContainer.graphics.drawRect(0, 0, 300, 250);
				adContainer.graphics.endFill();

				adContainer.width = Util.WID-200;
				adContainer.height = Util.HEI-125;
				adContainer.x = 100;
				adContainer.y = 50;
				
				adContainer.addChild(testAd);
				addChild(adContainer);
			}
			
			var cover:Sprite = new Sprite();
			cover.graphics.beginFill(0x000000);
			cover.graphics.drawRect(0, 0, Util.WID, Util.HEI);
			cover.graphics.endFill();
			cover.visible = false;
			
			click = new Sprite();
			click.addChild(new IMPORT_CLICKTOPLAY as Bitmap);
			click.visible = false;
			add_mouse_over(click);
			click.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
				cover.visible = true;
				cont();
				//navigateToURL(new URLRequest("http://www.ppllaayy.com/?utm_source=sponsorship&utm_campaign=windcleaner"));
				
			});
			click.y = Util.HEI - click.height * (Util.WID / 1000);
			
			click.scaleX = click.scaleY = Util.WID / 1000;
			
			addChild(click);
			addChild(cover);
			
			Util.WID = 1000;
			Util.HEI = 500;
		}
		
		var click:Sprite;
		
		public override function done_loading():void {
			click.visible = true;
		}
		
		public static function add_mouse_over(o:DisplayObject) {
			o.addEventListener(MouseEvent.ROLL_OVER, function() {
			Mouse.cursor = MouseCursor.BUTTON;
			});
			o.addEventListener(MouseEvent.ROLL_OUT, function() {
			Mouse.cursor = MouseCursor.AUTO;
			});
		}
		
		override protected function destroy():void {
			super.destroy();
			if (adContainer.parent == this) removeChild(adContainer);
			if (click.parent == this) removeChild(click);
			
		}
		
	}
}