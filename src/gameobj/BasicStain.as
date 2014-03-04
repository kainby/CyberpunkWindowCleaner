package gameobj {
	import core.BGObj;
	import org.flixel.FlxG;
	
	public class BasicStain extends BGObj {
		
		private static var STAINS:Vector.<Class> = Vector.<Class>([Resource.IMPORT_STAIN_1, Resource.IMPORT_STAIN_2, Resource.IMPORT_STAIN_3]);
		private var _g:GameEngine;
		public var _cleaned:Boolean;
		
		public function BasicStain(g:GameEngine) {
			super(STAINS[Util.int_random(0, STAINS.length)]);
			_g = g;
			_cleaned = false;
		}
		
		public function clean_step():void {
			this.alpha -= 1/(width*5);
			if (this.alpha <= 0) {
				this.visible = false;
				this.alpha = 0;
				this._cleaned = true;
			}
		}
		
	}

}