package{
    import org.flixel.system.*;
	import CPMStar.*;
	import flash.display.*;
	
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

			adContainer.graphics.beginFill(0);
			adContainer.graphics.drawRect(0, 0, 300, 250);
			adContainer.graphics.endFill();

			adContainer.width = Util.WID-200;
			adContainer.height = Util.HEI-125;
			adContainer.x = 100;
			adContainer.y = 50;
			
			
			if (Util.isUrl(["kongregate.com"],stage)) {
				trace("kongregate.com no ads");
			} else {
				adContainer.addChild(testAd);
				addChild(adContainer);
			}
		}
		
		override protected function destroy():void {
			super.destroy();
			removeChild(adContainer);
			
		}
		
	}
}